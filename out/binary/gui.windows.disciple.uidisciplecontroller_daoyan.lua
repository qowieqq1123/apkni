







function UIDiscipleController:onAppStart_daoyan()
socketManager:register_receiver(2,194,UIDiscipleController.do_protocol_2_194)

socketManager:register_receiver(2,195,UIDiscipleController.do_protocol_2_195)
socketManager:register_receiver(2,196,UIDiscipleController.do_protocol_2_196)
socketManager:register_receiver(2,202,UIDiscipleController.do_protocol_2_202)
end

function UIDiscipleController:onEnterState_daoyan()
end

function UIDiscipleController:onLeaveState_daoyan()
end


function UIDiscipleController.testDaoYanUp(dis_guid,dylv,olddylv)
local args={}
args.dis_guid=dis_guid
args.dylv=dylv
args.olddylv=olddylv
UIManager:showWindow('UIDiscipleDaoYanUpWin',args)
end



function UIDiscipleController:reqDaoYanUnlock(discipleguid)
local dyUnlock=UIDiscipleModel:getDaoYanUnlock(discipleguid)
if dyUnlock==0 then
UIDiscipleController:reqDaoYanLevelup(discipleguid)
end
end


function UIDiscipleController:reqDaoYanLevelup(discipleguid)

socketManager:send_2_194(discipleguid)
end

function UIDiscipleController:reqDaoYanReset(discipleguid)
socketManager:send_2_195(discipleguid)
end





function UIDiscipleController.do_protocol_2_194(discipleguid,result,daoyan_unlock)




local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end
if result==0 then

local olddylv=netData.daoyan_lv
local dylv=netData.daoyan_lv+1

netData.daoyan_lv=dylv

UIDiscipleModel:setDiscipleAttrListDirty(netData,DISCIPLE_ATTRIBUTE_TYPE.eDaoYan,true)

notifySystem:postNotify(notifyConfig.onDiscipleDaoYanLvChange,discipleguid,olddylv,dylv)
local func=function()
local args={}
args.dis_guid=discipleguid
args.dylv=dylv
args.olddylv=olddylv
UIManager:showWindow('UIDiscipleDaoYanUpWin',args)
end
timeEventController.delayDo(1.5,func)
elseif result==1 then
netData.daoyan_unlock=daoyan_unlock
else
UIManager.error('觉醒失败')
end
reddotControl.on_change_catch_type(CATCH_TYPE.eDiscipleDaoYan,discipleguid)
end


function UIDiscipleController.do_protocol_2_195(discipleguid,result,daoyanlv,moth_reset_count)
if result~=0 then
logErr(FMT.fmt("弟子道衍重置失败，错误标记为：{0}",result))
return
end

local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then
logErr(FMT.fmt("弟子数据丢失，guid：{0}",discipleguid))
return
end

local olddylv=netData.daoyan_lv

netData.daoyan_lv=0

UIDiscipleModel:setDiscipleAttrListDirty(netData,DISCIPLE_ATTRIBUTE_TYPE.eDaoYan,true)

notifySystem:postNotify(notifyConfig.onDiscipleDaoYanLvReset,discipleguid)

UIDiscipleController:setDiscipleDaoYanResetCount(moth_reset_count)

reddotControl.on_change_catch_type(CATCH_TYPE.eDiscipleDaoYan,discipleguid)
end


function UIDiscipleController.do_protocol_2_196(count)
UIDiscipleController:setDiscipleDaoYanResetCount(count)
end

function UIDiscipleController.do_protocol_2_202(disiciple_guid,daoyan_unlock,daoyan_lv)
local netData=UIDiscipleModel:getDiscipleData(disiciple_guid)
if netData==nil then
logErr(FMT.fmt("弟子数据丢失，guid：{0}",disiciple_guid))
return
end

netData.daoyan_unlock=daoyan_unlock
netData.daoyan_lv=daoyan_lv

UIDiscipleModel:setDiscipleAttrListDirty(netData,DISCIPLE_ATTRIBUTE_TYPE.eDaoYan,true)
reddotControl.on_change_catch_type(CATCH_TYPE.eDiscipleDaoYan,disiciple_guid)
end



function UIDiscipleController.resetDaoYanResetCount_NewMonth5AM(islogin)
if not islogin then
UIDiscipleController:setDiscipleDaoYanResetCount(0)
end
end


function UIDiscipleController.refreshCommonItemDaoYan(item,netData,index)
if item==nil or netData==nil then return end
local dylv=UIDiscipleModel:getDaoYanLevelEx(netData)
local isshow=dylv>0
index=index or 19
item:SetChildActive(index,isshow)
if isshow then
local widget=item:GetChildWidgetBase(index)
local chong,floor=UIDiscipleModel.getDaoYanLevelFloor(dylv)
local abName,iconName=UIDiscipleModel.getDaoYanFloorIcon(chong)
widget:SetChildLayoutGroupCreateItems(0,floor)
local grids=widget:GetChildLayoutGroupGridList(0)
for i=1,floor do
local fireItem=grids[i-1]
fireItem:SetChildCSImageSprite(0,abName,iconName)
end
end
end


function UIDiscipleController:setDiscipleDaoYanResetCount(count)
self.disciple_DaoYan_Reset_Month_Count=count
end

function UIDiscipleController:getDiscipleDaoYanResetCount()
return self.disciple_DaoYan_Reset_Month_Count or 0
end

function UIDiscipleController:getMonthMaxResetDaoYanMaxCount()
return cfgHelper.getdef(cfg_discipledaoyanconfig,'reset_month_count')
end

function UIDiscipleController:getMonthMaxResetDaoYanCost()
return cfgHelper.getdef(cfg_discipledaoyanconfig,'reset_cost')
end

function UIDiscipleController:checkCanResetDiscipleDaoYan()
local max=UIDiscipleController:getMonthMaxResetDaoYanMaxCount()
local useTimes=UIDiscipleController:getDiscipleDaoYanResetCount()

local result=max>useTimes

return result
end



function UIDiscipleController:calculateResetRewardList(discipleguid)
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
local dylv=UIDiscipleModel:getDaoYanLevelEx(netData)
if dylv<=0 then return defaultT end

local dzID=UIDiscipleModel:getDiscipleIDEx(netData)

local list={}

for lv=dylv,1,-1 do
local costList=UIDiscipleModel:getUpDaoYanCostEx(dzID,lv)
for index,cost in pairs(costList)do
list[cost[1]]=(list[cost[1]]or 0)+cost[2]
end
end

local temp={}
for itemid,itemnum in pairs(list)do
temp[#temp+1]={itemid=itemid,itemcount=itemnum}
end

if#temp>1 then
table.sort(temp,function(a,b)
return a.itemid>b.itemid
end)
end

return temp
end


function UIDiscipleController:onShowPrize_daoyan(prizeType,rewards,effectData)
if prizeType==ePrizeType.eDzDaoYanReset then
UIDiscipleController:setShowPrize_daoyan(rewards)
end
end

function UIDiscipleController:setShowPrize_daoyan(rewards)
self.showPrizeRewards_daoyan=rewards
end

function UIDiscipleController:showPrize_daoyan(callback,tips)
if self.showPrizeRewards_daoyan~=nil then
showPrizeControl.showWindowNow(self.showPrizeRewards_daoyan,callback,tips)
self.showPrizeRewards_daoyan=nil
end
end