








buildSkinController=gameState.addListener({})




function buildSkinController:onAppStart()

buildSkinModel:onAppStart()



socketManager:register_receiver(3,70,buildSkinController.recv_3_70)
socketManager:register_receiver(3,71,buildSkinController.recv_3_71)
socketManager:register_receiver(3,72,buildSkinController.recv_3_72)






end


function buildSkinController:onEnterState(isReconnect)
buildSkinModel:onEnterState()
notifySystem:listenNotify(notifyConfig.on_item_list_changed,self.on_item_list_changed)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function buildSkinController:onProtocolReq()
buildSkinModel:onProtocolReq()
end


function buildSkinController:onLeaveState(isReconnect)
notifySystem:removelistener(notifyConfig.on_item_list_changed,self.on_item_list_changed)
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
buildSkinModel:onLeaveState(isReconnect)

self.data={}
end


function buildSkinController:onLostConnection()

end


function buildSkinController:onReConnection(isInitPro)

end



function buildSkinController:reqChangeBuildSkin(bdId,ubdId,skinId,isAll)
local data={}
local sfId=mapIdType.zhufeng
if not isAll then
data={{ubdId,skinId}}
else

local config=cfgHelper.get1(cfg_monijybuildconfig_get,bdId)
local bdType=config.build_type
local bdDataList=zongmenModel:getBuildingDataByBdType(sfId,bdType)
for i,bdData in ipairs(bdDataList)do
local un_build_id=bdData.un_build_id
local dataItem={un_build_id,skinId}
table.insert(data,dataItem)
end
end

local len=#data
socketManager:send_3_71(sfId,len,data)
end


function buildSkinController:reqUnLockBuildSkin(skinId)
socketManager:send_3_72(skinId)
end


function buildSkinController.recv_3_70(len,appearanceList)
buildSkinModel:setBuildUnLockSkinData(len,appearanceList)
buildSkinModel:initNeedListenUnLockItemList()


local win=UIManager:findActiveWindow('UISelectBuildSkinWin')
if win then
win:refresh()
end
end


function buildSkinController.recv_3_71(sf_id,len,changeList)
if len and len>0 then
for i,v in ipairs(changeList)do
local ubdId=v.param_1
local skinId=v.param_2
local bdData=zongmenModel:getBuildingData(ubdId)
bdData.build_appearance_id=skinId
isometricMapSystem:changeModelById(sf_id,ubdId)
if bdData.planStatus==planStatus.eStart or bdData.planStatus==planStatus.eComplete then
buildingEffectControl:playEffectByEID(bdData.entityId,bdData.build_id,buildEffectType.eProduce)
end
end
UIManager.info("更换成功")
end


local win=UIManager:findActiveWindow('UISelectBuildSkinWin')
if win then
win:refresh()
end
UIManager:invokeUIMethod("UISectPalaceInfoWin","refreshView")
UIManager:invokeUIMethod("UIDzRoomWin","refreshLeft")
end


function buildSkinController.recv_3_72(skinId)
buildSkinModel:setBuildUnLockSkinDataBySkinId(skinId)
buildSkinModel:removeNeedListenUnLockItemList(skinId)
UIManager.info("解锁成功")

AudioManager.playAudio(525)


local win=UIManager:findActiveWindow('UISelectBuildSkinWin')
if win then
win:refresh()
end
local bdId=buildSkinModel:getBuildSkinBindBuildIdBySkinId(skinId)
if bdId then
buildSkinModel:checkBuildSkinUnLockReddotByBuildId(bdId,true)

buildSkinController:refreshBuildHud(bdId)


UIManager:invokeUIMethod("UIBottomMaskWin","refreshBdSkinBtn")
UIManager:invokeUIMethod("UISectPalaceInfoWin","refreshBdSkinBtn")


reddotControl.on_change_catch_type(CATCH_TYPE.eSectPalaceReddotChange)
end
end




function buildSkinController:showBuildSkinListWin(bdId,ubdId,skinId)
if not bdId or not ubdId then
return
end

UIManager:showWindow("UISelectBuildSkinWin",{build_id=bdId,un_build_id=ubdId,skinId=skinId})
end


function buildSkinController:refreshBuildHud(bdId)
local sfId=mapIdType.zhufeng
hudControl:refreshHUDByBDID(sfId,bdId)
end

function buildSkinController.on_item_list_changed(args)
if not systemModel.isOpen(SYSTEM_DEFINE.eBuildAppearance)then

return
end
for i,v in ipairs(args)do
buildSkinController.on_item_changed(v[1],v[2],v[3],v[4],v[5])
end
end

function buildSkinController.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
local skinIdList=buildSkinModel:getNeedListenUnLockSkinListByItemId(itemid)
if skinIdList and next(skinIdList)then
for i,skinId in ipairs(skinIdList)do
local bdId=buildSkinModel:getBuildSkinBindBuildIdBySkinId(skinId)
buildSkinModel:checkBuildSkinUnLockReddotByBuildId(bdId,true)
if bdId then

buildSkinController:refreshBuildHud(bdId)


UIManager:invokeUIMethod("UIBottomMaskWin","refreshBdSkinBtn")
UIManager:invokeUIMethod("UISectPalaceInfoWin","refreshBdSkinBtn")

reddotControl.on_change_catch_type(CATCH_TYPE.eSectPalaceReddotChange)
end
end
end
end

function buildSkinController.on_money_changed(moneyType,lastVal,val)
if not systemModel.isOpen(SYSTEM_DEFINE.eBuildAppearance)then

return
end
local skinIdList=buildSkinModel:getNeedListenUnLockSkinListByItemId(moneyType)
if skinIdList and next(skinIdList)then
for i,skinId in ipairs(skinIdList)do
local bdId=buildSkinModel:getBuildSkinBindBuildIdBySkinId(skinId)
buildSkinModel:checkBuildSkinUnLockReddotByBuildId(bdId,true)
if bdId then

buildSkinController:refreshBuildHud(bdId)


UIManager:invokeUIMethod("UIBottomMaskWin","refreshBdSkinBtn")
UIManager:invokeUIMethod("UISectPalaceInfoWin","refreshBdSkinBtn")

reddotControl.on_change_catch_type(CATCH_TYPE.eSectPalaceReddotChange)
end
end
end
end
