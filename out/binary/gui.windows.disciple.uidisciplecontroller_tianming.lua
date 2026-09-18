







function UIDiscipleController:onAppStart_tianming()
socketManager:register_receiver(2,81,UIDiscipleController.do_protocol_2_81)
socketManager:register_receiver(2,82,UIDiscipleController.do_protocol_2_82)
socketManager:register_receiver(2,83,UIDiscipleController.do_protocol_2_83)

socketManager:register_receiver(2,76,UIDiscipleController.do_protocol_2_76)
socketManager:register_receiver(2,77,UIDiscipleController.do_protocol_2_77)
end

function UIDiscipleController:onEnterState_tianming()

end

function UIDiscipleController:onLeaveState_tianming()

end


function UIDiscipleController.testTiamMingUp(dis_guid,tmlv,oldtmlv)
local attrLookup=UIDiscipleModel:getDiscipleMultipleAttrLookup(dis_guid,false)
local oldattrLookup=UIDiscipleModel:getDiscipleMultipleAttrLookup(dis_guid,false)
local args={}
args.dis_guid=dis_guid
args.tmlv=tmlv
args.oldtmlv=oldtmlv
args.attrLookup=attrLookup
args.oldattrLookup=oldattrLookup
UIManager:showWindow('UIDiscipleTianMingUpWin',args)
end


function UIDiscipleController.refreshCommonItemTianMing(item,netData,index)
local tmlv=UIDiscipleModel:getTianMingLevelEx(netData)
local dylv=UIDiscipleModel:getDaoYanLevelEx(netData)
local dyunlock=UIDiscipleModel:getDaoYanUnlockEx(netData)
local isShowTianMing=tmlv>0
local isShowDaoYan=dylv>0 and dyunlock>0
index=index or 19
item:SetChildActive(index,isShowTianMing or isShowDaoYan)


if isShowDaoYan then

UIDiscipleController.refreshCommonItemDaoYan(item,netData,index)
return
end

if isShowTianMing then
local widget=item:GetChildWidgetBase(index)
local chong=UIDiscipleModel.getTianMingLevelChong(tmlv)
local floor=UIDiscipleModel.getTianMingLevelFloor(tmlv)
local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)
widget:SetChildLayoutGroupCreateItems(0,chong)
local grids=widget:GetChildLayoutGroupGridList(0)
for i=1,chong do
local fireItem=grids[i-1]
local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)
fireItem:SetChildCSImageSprite(0,abName,iconName)
end
end

end




function UIDiscipleController:reqTianMingReset(discipleguid,resetIndex)


socketManager:send_2_76(discipleguid,resetIndex)
end


function UIDiscipleController:reqTianMingResetconfirm(discipleguid)

socketManager:send_2_77(discipleguid)
end


function UIDiscipleController:reqTianMingLevelup(discipleguid,spenum)


socketManager:send_2_81(discipleguid,spenum)
end


function UIDiscipleController:reqSaveTianMingCiFu(discipleguid,select_lookup)


local tmlv=UIDiscipleModel:getTianMingLevel(discipleguid)
local tmcfList={}
local cifupos=cfgHelper.getdef1(cfg_discipletmcfconfig,'pos')
for i,cifu_limit_tmlv in ipairs(cifupos)do
if select_lookup[i]~=nil then
tmcfList[i]=select_lookup[i]
else
local isActive_=UIDiscipleModel.checkTiamMingCiFuPosOpenX(tmlv,i,false)
if isActive_ then
tmcfList[i]=UIDiscipleModel:getTianMingCiFuID(discipleguid,i)or 0
end
end
end
socketManager:send_2_83(discipleguid,#tmcfList,tmcfList)
end






function UIDiscipleController.do_protocol_2_81(discipleguid,tmlv,tmnum)




local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end
netData.tmnum=tmnum

local oldtmlv=netData.tmlv
local oldfloor=UIDiscipleModel.getTianMingLevelFloor(oldtmlv)
local floor=UIDiscipleModel.getTianMingLevelFloor(tmlv)
if oldtmlv~=tmlv then
local oldattrLookup=UIDiscipleModel:getDiscipleMultipleAttrLookup(discipleguid,false)
netData.tmlv=tmlv

UIDiscipleModel:setDiscipleAttrListDirty(netData,DISCIPLE_ATTRIBUTE_TYPE.eTianMing,true)
if oldfloor~=floor then
UIDiscipleModel:setSkillReplaceLookupDirty(netData)
end
local attrLookup=UIDiscipleModel:getDiscipleMultipleAttrLookup(discipleguid,false)

notifySystem:postNotify(notifyConfig.onDiscipleTianMingLvChange,discipleguid,oldtmlv,tmlv)
local func=function()
local args={}
args.dis_guid=discipleguid
args.tmlv=tmlv
args.oldtmlv=oldtmlv
args.attrLookup=attrLookup
args.oldattrLookup=oldattrLookup
UIManager:showWindow('UIDiscipleTianMingUpWin',args)
end
if oldfloor~=floor then
timeEventController.delayDo(0.45,func)
else
func()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eDiscipleTianMing,discipleguid)

if UIDiscipleModel:checkOpenDaoYan(netData)then
UIDiscipleController:reqDaoYanUnlock(discipleguid)
end




























end
end


function UIDiscipleController.do_protocol_2_82(discipleguid,tmlv,tmlistlen,tmList)





local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end

local oldtmlv=netData.tmlv
local oldfloor=UIDiscipleModel.getTianMingLevelFloor(oldtmlv)
local floor=UIDiscipleModel.getTianMingLevelFloor(tmlv)
netData.tmlv=tmlv
netData.tmlistlen=tmlistlen
netData.tmList=tmList

if oldtmlv~=tmlv then

UIDiscipleModel:setDiscipleAttrListDirty(netData,DISCIPLE_ATTRIBUTE_TYPE.eTianMing,true)
if oldfloor~=floor then
UIDiscipleModel:setSkillReplaceLookupDirty(netData)
end

notifySystem:postNotify(notifyConfig.onDiscipleTianMingLvChange,discipleguid,oldtmlv,tmlv)

reddotControl.on_change_catch_type(CATCH_TYPE.eDiscipleTianMing,discipleguid)
end
end


function UIDiscipleController.do_protocol_2_83(discipleguid,tmcflistlen,tmcfList)




local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end

netData.tmcflistlen=tmcflistlen
netData.tmcfList=tmcfList


UIDiscipleModel:setDiscipleAttrListDirty(netData,DISCIPLE_ATTRIBUTE_TYPE.eTianMingCiFu,true)
notifySystem:postNotify(notifyConfig.onDiscipleTianMingCiFuChange,discipleguid)

reddotControl.on_change_catch_type(CATCH_TYPE.eDiscipleTianMing,discipleguid)
end

function UIDiscipleController.do_protocol_2_76(discipleguid,len,array)

UIDiscipleModel:setDiscipleTMResetList(discipleguid,len,array,true)
UIManager:invokeUIMethod("UITianMingResetWin","refreshRecv")
end

function UIDiscipleController.do_protocol_2_77(discipleguid)
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end
if netData.randlistlen>0 then UIDiscipleModel:setIsUseRandtmList(true)end

local resetData=UIDiscipleModel:getDiscipleTMResetList(discipleguid)
if not resetData and netData.randlistlen>0 then
resetData=netData.randtmList
end

if resetData then
for k,v in ipairs(resetData)do
netData.tmList[k]=v
end
end

UIDiscipleModel:setDiscipleAttrListDirty(netData,DISCIPLE_ATTRIBUTE_TYPE.eTianMing,true)
UIDiscipleModel:setSkillReplaceLookupDirty(netData)
reddotControl.on_change_catch_type(CATCH_TYPE.eDiscipleTianMing,discipleguid)

UIDiscipleModel:setDiscipleTMResetList(discipleguid,0,nil)
UIManager:invokeUIMethod("UITianMingResetWin","confirmRecv")
end