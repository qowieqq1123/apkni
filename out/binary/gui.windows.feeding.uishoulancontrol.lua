

UIShouLanControl=gameState.addListener(fullScreenUI.create())

function UIShouLanControl:onAppStart()
socketManager:register_receiver(3,211,self.recv_3_211)
socketManager:register_receiver(3,212,self.recv_3_212)
socketManager:register_receiver(3,213,self.recv_3_213)
socketManager:register_receiver(3,214,self.recv_3_214)
socketManager:register_receiver(3,215,self.recv_3_215)
socketManager:register_receiver(3,216,self.recv_3_216)
socketManager:register_receiver(3,217,self.recv_3_217)
socketManager:register_receiver(3,218,self.recv_3_218)
socketManager:register_receiver(3,219,self.recv_3_219)
socketManager:register_receiver(3,220,self.recv_3_220)
socketManager:register_receiver(3,221,self.recv_3_221)

local menulist=
{
{tabType=FULL_TAB_TYPE.eShouLanInfo,callback=function(...)self:showInfoWindow(...)end,
sendCallback=function()end},
{tabType=FULL_TAB_TYPE.eShouLanFeeding,callback=function(...)self:showFeedingWindow(...)end,
sendCallback=function()end},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eShouLan,
skinType=fullScreenSkinType.eSkin29,
attachName={'entityId'}
}
self:initUI(args)
end

function UIShouLanControl:onEnterState(...)
UIShouLanModel:onEnterState(...)
end

function UIShouLanControl:onLeaveState(...)
UIShouLanModel:onLeaveState(...)

self.winArgs=nil
end

function UIShouLanControl:addAllMenberToShouLan()
local datas=UIShouLanModel:getDatas()
for k,v in pairs(datas)do
local bdData=zongmenModel:getBuildingData(k)
if bdData then
for kk,vv in pairs(v.petBaseInfoLookup)do


lingShouAIManager:addToBuilding(bdData,kk)
feedingSystem:addCountDownData(bdData.un_build_id,kk)
end
hudControl:refreshBuildingStatusHUD(k)
end
end
end

function UIShouLanControl:addMenberById(slId,lsId)
local bdData=zongmenModel:getBuildingData(slId)


lingShouAIManager:addToBuilding(bdData,lsId)
feedingSystem:addCountDownData(slId,lsId)
end

function UIShouLanControl:removeMenberById(slId,lsId)
local bdData=zongmenModel:getBuildingData(slId)
lingShouAIManager:removeFormBuilding(bdData.entityId,lsId)
feedingSystem:removeCountDownData(lsId)
end

function UIShouLanControl:showInfoWindow(argstable)
argstable.entityId=argstable.data and argstable.data.entityId or argstable.entityId
if argstable then
self.winArgs=argstable
end
local args=
{
tabType=FULL_TAB_TYPE.eShouLanInfo,
showBg=true,
showTopMask=true,
viewNames={'UIShouLanInfoWin'},
viewArgs={['UIShouLanInfoWin']=self.winArgs},
}
self:showUI(args)
end

function UIShouLanControl:showFeedingWindow(argstable)
argstable.entityId=argstable.data and argstable.data.entityId or argstable.entityId
if argstable then
self.winArgs=argstable
end
local args=
{
tabType=FULL_TAB_TYPE.eShouLanFeeding,
showBg=true,
showTopMask=true,
viewNames={'UIShouLanFeedingWin'},
viewArgs={['UIShouLanFeedingWin']=self.winArgs},
}
self:showUI(args)
end

function UIShouLanControl:showMonsterSelect(args)
local winParams={
titleName='灵兽安排',
extraWin='UIMonsterSelect',
extraParams=args,
}
UIManager:showWindow('UICommonDragonBoneWin',winParams)
end


function UIShouLanControl:showMainWindow(argstable)
local tabType=FULL_TAB_TYPE.eShouLanInfo
if argstable.args~=nil and argstable.args.tabType~=nil then
tabType=argstable.args.tabType
end
if argstable and argstable.data then
argstable.entityId=argstable.data.entityId
end
if tabType==FULL_TAB_TYPE.eShouLanInfo then
self:showInfoWindow(argstable)
elseif tabType==FULL_TAB_TYPE.eShouLanFeeding then
self:showFeedingWindow(argstable)
end
end



function UIShouLanControl:reqShouLanData()
socketManager:send_3_211()
end

function UIShouLanControl:reqShouLanInfo(slId)
socketManager:send_3_212(slId)
end

function UIShouLanControl:reqAddToShouLan(slId,len,datas)
socketManager:send_3_213(slId,len,datas)
end

function UIShouLanControl:reqChangeShouLanStyle(sId,dId)
socketManager:send_3_214(sId,dId)
end

function UIShouLanControl:reqChangeShouLanDecorate(sId,dId)
socketManager:send_3_215(sId,dId)
end

function UIShouLanControl:reqShouLanRewardList(slId,sId)
socketManager:send_3_216(slId,sId)
end

function UIShouLanControl:reqRemoveFormShouLan(ubdId,len,arr)
socketManager:send_3_217(ubdId,len,arr)
end

function UIShouLanControl:reqReveiveReward(ubdId,len,arr)
socketManager:send_3_218(ubdId,len,arr)
end

function UIShouLanControl:reqUnloclShouLan(slId)
socketManager:send_3_220(slId)
end



function UIShouLanControl.recv_3_211(len,datas,llen,ldatas)
UIShouLanModel:setDatas(datas or{})
UIShouLanModel:setUnlockDatas(ldatas or{})
end

function UIShouLanControl.recv_3_212(datas)
local data={}
data.un_build_id=datas[1]
data.build_id=datas[2]
data.decorate_id=datas[3]
data.stop_reason=datas[4]
data.pet_len=datas[5]
data.petBaseInfo=datas[6]
UIShouLanModel:resetData(data)
end

function UIShouLanControl.recv_3_213(slId,len,datas,infoLen,infoList)
if len>0 then
UIShouLanModel:addMonster(slId,datas,infoLen,infoList)
for i,v in ipairs(datas)do
UIShouLanControl:addMenberById(slId,v)
UIManager:invokeUIMethod('UIShouLanFeedingWin','addNewMonster',v)
end

notifySystem:postNotify(notifyConfig.onShouLanLingShouChange,ShouLanChangeType.eAdd,slId)
end
end

function UIShouLanControl.recv_3_214(sId,dId)
UIShouLanModel:changeShouLanStyle(sId,dId)
local sfId=mapIdType.lingshoudao
local bdData=zongmenModel:getBuildingData(sId)
isometricMapSystem:changeModelById(sfId,sId)
if bdData and bdData.entityId and isometricMapSystem:hasSpecialModel(bdData.entityId)then
isometricMapSystem:change3DModelById(sfId,sId)
end

UIManager.info("兽栏转型成功")

UIManager:invokeUIMethod('UIShouLanInfoWin','onFinishShouLanTypeChange',sId)
end

function UIShouLanControl.recv_3_215(sId,dId)
UIShouLanModel:changeShouLanDecorate(sId,dId)
UIShouLanControl:refreshShouLanDecorate(sId)
UIManager:invokeUIMethod('UISLDecorateWin','refresh')

UIManager:invokeUIMethod('UIShouLanInfoWin','refresh')
end

function UIShouLanControl.recv_3_216(args)
local slId=args[1]
local sId=args[2]
local time=args[3]
local xinqingVal=args[4]
local sec=args[5]
local len=args[6]
local datas=args[7]
UIShouLanModel:setCurrReward(slId,sId,time,xinqingVal,sec,len,datas)
feedingSystem:addCountDownData(slId,sId)
hudControl:refreshBuildingStatusHUD(slId)

UIManager:invokeUIMethod('UIShouLanFeedingWin','refreshMonsterInfoByLsGuid',sId)



end

function UIShouLanControl.recv_3_217(slId,len,datas)
if len>0 then
UIShouLanControl:removeShouLanLs(slId,datas)
end
end

function UIShouLanControl.recv_3_218(slId,len,datas,rwlen,rwlist)
if len>0 then
UIShouLanModel:clearReward(slId,datas)
end
hudControl:refreshBuildingStatusHUD(slId)
if rwlen>0 then
local tempRewardlist={}
for k,v in pairs(rwlist)do
showPrizeControl.insertTemp(tempRewardlist,nil,v.param_1,v.param_2)
end
showPrizeControl.showWindow(tempRewardlist)
end
UIManager:invokeUIMethod('UIShouLanFeedingWin','refreshCurrSelect')
UIManager:invokeUIMethod('UIShouLanInfoWin','refresh')
end

function UIShouLanControl.recv_3_219(ubdId,reason)
UIShouLanModel:setStopReason(ubdId,reason)
UIManager:invokeUIMethod('UIShouLanFeedingWin','refreshCurrSelect')
end

function UIShouLanControl.recv_3_220(slBdId)
UIShouLanModel:unlockShouLan(slBdId)
local bdName=cfgHelper.get2(cfg_monijybuildconfig_get,slBdId,'name')
UIManager.info(FMT.fmt("{0} 解锁成功",bdName))

UIManager:invokeUIMethod('UIShouLanSelectWin','unlockShouLan',slBdId)
end


function UIShouLanControl.recv_3_221(yearCount,itemListLen,itemList)
local timeStamp=timeHelper.getServerLongTime()
local year=gameUtilityModel.getGameYearPassByLongStamp(timeStamp)
local yearStr=FMT.fmt('第{0}年',year)

local title='系统'

local strList={}
if itemListLen>0 then
for _,v in ipairs(itemList)do
local itemId=v.param_1
local itemCount=v.param_2
local name=itemsModel.getName(itemId)
strList[#strList+1]=FMT.fmt("{0}{1}",itemCount,name)
end
end

local itemStr=next(strList)~=nil and table.concat(strList,"、")or""
local str=FMT.fmt('{0}，兽栏维护费用扣除{1}',yearStr,itemStr)
chatControl.reqSystemMesg(CHAT_MSG_TYPE.eNoFitler,{CHAT_CHANNNEL.eSystem},str,title)
end



function UIShouLanControl:refreshShouLanDecorate(bdId)
local bdData=zongmenModel:getBuildingData(bdId)
if not bdData then
return
end
local slData=UIShouLanModel:getShouLanData(bdId)
local dId=slData.decorate_id
local eId=bdData.entityId
if dId>0 then
local cfg=cfgHelper.get1(cfg_buildinglayoutconfig_get,bdData.build_id)
local pos=_MapManager.ToVector3Int(cfg.fd_pos[1],cfg.fd_pos[2],0)
local id=cfgHelper.get2(cfg_petdecorateconfig_get,dId,'ldId')
local guid=_MapManager.AddDecorationToLayoutBuilding(eId,id,pos)
slData.decorate_guid=guid
else
if slData.decorate_guid then
_MapManager.RemoveDecorationFormLayoutBuilding(eId,slData.decorate_guid)
end
slData.decorate_guid=nil
end
end

function UIShouLanControl:refreshAllShouLanDecorate()
local datas=UIShouLanModel:getDatas()
for k,v in pairs(datas)do
local slcfg=cfgHelper.get1(cfg_petbuildconfig_get,v.build_id)
if slcfg.decorate then
self:refreshShouLanDecorate(v.un_build_id)
end
end
end

function UIShouLanControl:showElementInfoWin(pos,offset,id,isElement,attrsDescList)
local cfg
local name
local color
if isElement then
cfg=cfgHelper.get1(cfg_elementtypeconfig_get,id)
name=FMT.fmt("{0}属性",cfg.name)
color=cfg.id
else
cfg=cfgHelper.get1(cfg_environmenttypeconfig_get,id)
name=cfg.name
color=cfg.framecolor or cfg.color
end

local args={
name=name,
color=color,
desc=cfg.sl_des,
attrsDescList=attrsDescList,
pos=pos,
offset=offset,
isElement=isElement,
}
UIManager:showWindow('UIElementInfoWin',args)
end

function UIShouLanControl:receiveSLReward(slId)
local data=UIShouLanModel:getShouLanData(slId)
local idlist={}
for k,v in pairs(data.petBaseInfoLookup)do
if v.len>0 then
table.insert(idlist,v.guid)
end
end
local len=#idlist
if len>0 then
UIShouLanControl:reqReveiveReward(slId,len,idlist)
end
end

function UIShouLanControl:removeSLAllLingShou(slId)
local data=UIShouLanModel:getShouLanData(slId)
local idlist={}
for k,v in pairs(data.petBaseInfoLookup)do
table.insert(idlist,v.guid)
end
local len=#idlist
if len>0 then
UIShouLanControl:reqRemoveFormShouLan(slId,len,idlist)
end
end

function UIShouLanControl:getSLRewardList(slId)
local data=UIShouLanModel:getShouLanData(slId)
local rewardList={}
local rewardLookup={}
for k,v in pairs(data.petBaseInfoLookup)do
local hasRewardList=v.commItem
for i,item in ipairs(hasRewardList)do
local itemId=item.param_1
local itemCount=item.param_2
if rewardLookup[itemId]then
rewardLookup[itemId]=rewardLookup[itemId]+itemCount
else
rewardLookup[itemId]=itemCount
end
end
end

for itemId,itemCount in pairs(rewardLookup)do
rewardList[#rewardList+1]={itemId,itemCount}
end

return rewardList,rewardLookup
end

function UIShouLanControl:checkShouLanDzFire(sfId,ubdId,okCallBack)
local slId=ubdId

local bdData=zongmenModel:getBuildingData(ubdId)
local dzId=bdData.dizi_id
local hasDZ=tostring(dzId)~='0'
if not hasDZ then

return true
end


local rewardList=UIShouLanControl:getSLRewardList(slId)
local hasReward=rewardList and#rewardList>0 or false
local show_data
if hasReward then
local contentStr="卸任该弟子会将兽栏内灵兽迁出，并收获以下材料\n是否确定卸任？"
local itemList={}
for i,v in ipairs(rewardList)do
local itemId=v[1]
local itemCount=v[2]
itemList[#itemList+1]={itemid=itemId,itemcount=itemCount}
end
show_data=
{
type='UIDialougeBuyWithReward2',
title='提示',
tip=contentStr,
oktext='确定',
canceltext='取消',
okcallback=function()

UIShouLanControl:receiveSLReward(slId)

UIShouLanControl:removeSLAllLingShou(slId)

zongmenControl:reqChangeBuildingManager(sfId,bdData.un_build_id,Int64_0)
if okCallBack then
return okCallBack()
end
end,
showclosebtn=true,
itemlist=itemList,
}
else
local contentStr="卸任该弟子会将兽栏内灵兽迁出\n是否确定卸任？"
show_data={
type='UIDialouge',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
okcallback=function()

UIShouLanControl:removeSLAllLingShou(slId)

zongmenControl:reqChangeBuildingManager(sfId,bdData.un_build_id,Int64_0)

if okCallBack then
return okCallBack()
end
end,
}
end

local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

return false
end


function UIShouLanControl:removeShouLanLs(slId,lsGuidList)
UIShouLanModel:removeMonster(slId,lsGuidList)
for i,v in ipairs(lsGuidList)do
UIShouLanControl:removeMenberById(slId,v)
UIManager:invokeUIMethod('UIShouLanFeedingWin','removeAMonster',slId,v)
end
UIManager:invokeUIMethod('UIShouLanFeedingWin','onBackBtn')

notifySystem:postNotify(notifyConfig.onShouLanLingShouChange,ShouLanChangeType.eRemove,slId)
end


function UIShouLanControl:removeShouLanLsByLsGuidList(lsGuidList)
local removeList={}
for _,lsGuid in ipairs(lsGuidList)do
local slId=UIShouLanModel:getShouLanUbdIdByLsGuid(lsGuid)
if slId then
if not removeList[slId]then
removeList[slId]={}
end
local list=removeList[slId]
list[#list+1]=lsGuid
end
end

if next(removeList)then
for slId,list in pairs(removeList)do
self:removeShouLanLs(slId,list)
end
end
end