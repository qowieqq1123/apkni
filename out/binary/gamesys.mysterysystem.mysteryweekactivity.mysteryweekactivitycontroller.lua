






local _MODULENAME="mysteryWeekActivityController"

gameState.addListener(def_table(_MODULENAME))
mysteryWeekActivityController.name=_MODULENAME
mysteryWeekActivityController.data={}

function mysteryWeekActivityController:onAppStart()

mysteryWeekActivityModel:onAppStart()








socketManager:register_receiver(4,72,mysteryWeekActivityController.recv_4_72)
socketManager:register_receiver(4,75,mysteryWeekActivityController.recv_4_75)
socketManager:register_receiver(4,76,mysteryWeekActivityController.recv_4_76)
socketManager:register_receiver(4,77,mysteryWeekActivityController.recv_4_77)
notifySystem:listenNotify(notifyConfig.building_event,self.onBuildingEvent)

notifySystem:listenNotify(notifyConfig.on_mystery_quit,self.on_mystery_quit)
notifySystem:listenNotify(notifyConfig.endCloud,self.onCloudOpenDely)
notifySystem:listenNotify(notifyConfig.on_system_open,self.onSystemOpen)
notifySystem:listenNotify(notifyConfig.onNewWeek5am,self.eNewWeek5am)
end


function mysteryWeekActivityController:onEnterState(isReconnect)
mysteryWeekActivityModel:onEnterState()
end


function mysteryWeekActivityController:onProtocolReq()
mysteryWeekActivityModel:onProtocolReq()
if systemModel.isOpen(SYSTEM_DEFINE.eMiJingDangerMap)then
self:send_4_72()
end
local bdData=zongmenModel:findBuildingDataByType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eQianJiGe)
if bdData then
self:send_4_75()
end
if systemModel.isOpen(SYSTEM_DEFINE.eMiJingDangerMap)then
local sTime,eTime=mysteryWeekActivityModel:getEndTime()
limitActivitiesModel:addClientAct(LIMIT_ACT_TYPE.eShangGuXianDi,sTime,eTime)
end
end

function mysteryWeekActivityController.onSystemOpen(sysid)
if SYSTEM_DEFINE.eMiJingDangerMap==sysid then
local sTime,eTime=mysteryWeekActivityModel:getEndTime()
limitActivitiesModel:addClientAct(LIMIT_ACT_TYPE.eShangGuXianDi,sTime,eTime)
end
end

function mysteryWeekActivityController.eNewWeek5am(islogin)
if islogin then
return
end
if systemModel.isOpen(SYSTEM_DEFINE.eMiJingDangerMap)then
local sTime,eTime=mysteryWeekActivityModel:getEndTime()
limitActivitiesModel:addClientAct(LIMIT_ACT_TYPE.eShangGuXianDi,sTime,eTime)
end
end

function mysteryWeekActivityController.onCloudOpenDely()
if mainControl:isSceneType(eSceneType.eWorld)then
if mysteryWeekActivityModel:isNewMystery()and not fullScreenUI.isActiveBaseFull()then
mysteryWeekActivityController:showTieLian()
end
mysteryWeekActivityModel:setNewMytery(nil)
end
end


function mysteryWeekActivityController:onLeaveState(isReconnect)
mysteryWeekActivityModel:onLeaveState(isReconnect)

self.data={}

notifySystem:removelistener(notifyConfig.building_event,self.onBuildingEvent)
end


function mysteryWeekActivityController:onLostConnection()

end


function mysteryWeekActivityController:onReConnection(isInitPro)

end

function mysteryWeekActivityController.on_mystery_quit()

mysteryWeekActivityController:send_4_75()
end

function mysteryWeekActivityController.onBuildingEvent(etype,sfId,ubdId,arg1,arg2,arg3)
if etype==buildingEvent.buildComplete then
local bdData=zongmenModel:getBuildingData(ubdId)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local buildType=cfg.build_type
if buildType==SLG_SYSTEM_TYPE.eQianJiGe then

mysteryWeekActivityController:send_4_75()
end
end
end

function mysteryWeekActivityController:openWeekEnterWin(fbid)
local posData=MysteryModel:get_mysteryFB_unit(fbid)
if posData then
local world=posData[1]
local sceneType=mainControl:getSceneType()
if sceneType==eSceneType.eWorld and worldModel:isSameWorld(posData[1])then
local key=worldModel:convertUnitKey({worldModel.UNITTYPE.MYSTERY,fbid})
local cPos=worldController:getCameraPosition()
local showCB=function()
UIManager:showWindow("UIMysteryWeekEnterWin",{fbid=fbid,returnHeight=cPos.y})
end
local callback=function()
local minZoom=worldController:getCameraZoomRange_Normal()[1]
worldController:lookAtUnit_Duration(key,minZoom,0.25,showCB)
end
worldController:lookAtUnit(key,nil,false,callback,DG.Tweening.Ease.OutQuart)
else
local worldName=cfgHelper.get2(cfg_worldconfig_get,world,'name')
local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt('确认前往<color=#18a736>{0}</color>？',worldName),
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function(...)

local key=worldModel:convertUnitKey({worldModel.UNITTYPE.MYSTERY,fbid})
local args={lookAtUnit=key,}
if key then
local flag=mainControl:enterWorld({posData[1],args},function()
local minZoom=worldController:getCameraZoomRange_Normal(world)[1]
worldController:lookAtUnit(key,minZoom,false,function()
UIManager:showWindow("UIMysteryWeekEnterWin",fbid)
end)
end)
end
end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end
else
UIManager:showWindow("UIMysteryWeekEnterWin",fbid)
end


end

function mysteryWeekActivityController:showTieLian()
UIManager:showWindow("UISGXDTieLianWin")
end

function mysteryWeekActivityController:closeTieLian()
UIManager:closeWindow("UISGXDTieLianWin")
end

function mysteryWeekActivityController:openFightWeekEnterWin()
local fb=mysteryWeekActivityModel:getNextMystery()
if fb then
mysteryWeekActivityController:openWeekEnterWin(fb.id)
return true
end
return false
end

function mysteryWeekActivityController:refreshBuildHud()
local sfId=zongmenModel:getMountainId()
local bdData=zongmenModel:findBuildingDataByType(sfId,SLG_SYSTEM_TYPE.eQianJiGe)
if bdData then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end


function mysteryWeekActivityController.recv_4_72(passLayer,freeLayerLast,feeLayerLast,mhTimeout,jhFlag)
mysteryWeekActivityModel:initXDTouZiData(passLayer,freeLayerLast,feeLayerLast,mhTimeout,jhFlag)

UIManager:callWindowFunc("UIQianJiGeSGXDWin","refresh")
UIManager:callWindowFunc("UITouZiQianJiGeSGXDRewardsWin","refresh")
reddotControl.on_change_catch_type(CATCH_TYPE.eXianDiTouZi)
mysteryWeekActivityController:refreshBuildHud()

if mysteryWeekActivityController.isBuySGXDTouZi then
UIManager.info("已激活上级密函")
end
mysteryWeekActivityController.isBuySGXDTouZi=nil
end

function mysteryWeekActivityController.recv_4_75(len,fzList,sjlen,rwHis)
mysteryWeekActivityModel:initTuJianData(len,fzList,rwHis)


UIManager:callWindowFunc("UIQianJiGeTuJianWin","refreshList")

reddotControl.on_change_catch_type(CATCH_TYPE.eFaZeBaoDian)
mysteryWeekActivityController:refreshBuildHud()
end

function mysteryWeekActivityController.recv_4_76(tjId)
mysteryWeekActivityModel:setTuJianJHReward(tjId)
UIManager:callWindowFunc("UIQianJiGeTuJianWin","refreshList")
UIManager:callWindowFunc("UIQianJiGeTuJianWin","refreshReddot")
reddotControl.on_change_catch_type(CATCH_TYPE.eFaZeBaoDian)
mysteryWeekActivityController:refreshBuildHud()

AudioManager.playAudio(503)
end

function mysteryWeekActivityController.recv_4_77(tagId,maxRw)
mysteryWeekActivityModel:setTuJiansjId(tagId,maxRw)

UIManager:callWindowFunc("UIQianJiGeTuJianShouJiWin","refreshList")
UIManager:invokeUIMethod("UIQianJiGeTuJianWin","refreshShouJiReddot")
UIManager:callWindowFunc("UIQianJiGeTuJianWin","refreshReddot")
reddotControl.on_change_catch_type(CATCH_TYPE.eFaZeBaoDian)
mysteryWeekActivityController:refreshBuildHud()

AudioManager.playAudio(503)
end


function mysteryWeekActivityController.send_4_73(layer)
socketManager:send_4_73(layer)
end


function mysteryWeekActivityController.send_4_74()
socketManager:send_4_74()
end

function mysteryWeekActivityController:send_4_72()
socketManager:send_4_72()
end
function mysteryWeekActivityController:send_4_75()
socketManager:send_4_75()
end
function mysteryWeekActivityController:send_4_76(tjId)
socketManager:send_4_76(tjId)
end
function mysteryWeekActivityController:send_4_77(tabId)
socketManager:send_4_77(tabId)
end