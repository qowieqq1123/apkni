






local _MODULENAME="worldDailyEventController"




gameState.addListener(def_table(_MODULENAME))
worldDailyEventController.name=_MODULENAME
worldDailyEventController.data={}



function worldDailyEventController:onAppStart()

worldDailyEventModel:onAppStart()






notifySystem:listenNotify(notifyConfig.on_mystery_event_new,self.onMysteryEventNew)
notifySystem:listenNotify(notifyConfig.on_mystery_event_init,self.onMysteryEventInit)
notifySystem:listenNotify(notifyConfig.onClickObjectInWorld,self.onClickObjectInWorld)
notifySystem:listenNotify(notifyConfig.onWorldPositionReRandom,self.onWorldPositionReRandom)
notifySystem:listenNotify(notifyConfig.on_mystery_event_finish_s,self.onEventFinish)
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:listenNotify(notifyConfig.on_mystery_event_break,self.onQiYuEventBreak)

worldController:registerSceneState(1,3,function()
worldDailyEventController:showAllUnit()
end)

end


function worldDailyEventController:onEnterState()
worldDailyEventModel:onEnterState()
end


function worldDailyEventController:onServerDataInitFinish()
worldExperienceModel:onServerDataInitFinish()
end


function worldDailyEventController:onLeaveState(isReconnet)
worldDailyEventModel:onLeaveState(isReconnet)
end


function worldDailyEventController:onLostConnection()

end

function worldDailyEventController:onProtocolReq()

end


function worldDailyEventController:onReConnection(isReconnect)
if not isReconnect then
worldDailyEventModel:onReConnection()
return
end

end

function worldDailyEventController.onWorldPositionReRandom(rData,aData)
if rData.unitType==eWorldUnitTpye.DAILYEVENT then
worldDailyEventModel:onWorldPositionReRandom(rData,aData)
end
end

function worldDailyEventController.onMysteryEventInit()
worldDailyEventModel:clear_all_unit_count()
worldDailyEventModel:initEventData()
worldDailyEventController:refreshWorldWin()
end

function worldDailyEventController.onNewDay5am()
if systemModel.isOpen(SYSTEM_DEFINE.eWorldDailyQiYuEvent)then
local time=timeHelper.getServerShortTime()
local list=worldDailyEventModel:getEventDataByType(2)
local curGuid=UIManager:invokeUIMethod("UIMysteryEventWin","getCurEvtGuid")
local guidList={}
for i,v in ipairs(list)do
if v.guid~=curGuid and time-v.otherData.evtTime>120 then
table.insert(guidList,v.guid)

end
end
MysteryEventSystem.req_18_12(SYSTEM_DEFINE.eWorldDailyQiYuEvent,#guidList,guidList)
end
end


function worldDailyEventController.onClickObjectInWorld(args,atOnce)
local guid=args[2]
local callback=function()
worldDailyEventController:showEventPanel(guid)
end


local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.DAILYEVENT,tostring(guid)})
if atOnce then
local cameraPosition=worldController:getCameraPosition()
worldController:lookAtUnit(unitKey,cameraPosition.y,atOnce or false,callback)
else
local minZoom=worldController:getCameraZoomRange_Normal()[1]
local unitData=worldController:getUnit(unitKey)
local cameraPosition=worldController:getCameraPosition()
if unitData then
worldResPointBaseModel:setTempCemaraData(unitKey,unitData.Position,cameraPosition.y)
end
worldController:lookAtUnit(unitKey,minZoom,atOnce or false,callback)
end

end

function worldDailyEventController.onQiYuEventBreak(sysId)
if sysId==SYSTEM_DEFINE.eWorldDailyQiYuEvent then
local tempData=worldResPointBaseModel:getTempCemaraData()
if tempData and tempData[2]~=nil and tempData[3]~=nil then
worldController:lookAtPosition(tempData[2],tempData[3])
worldResPointBaseModel:setTempCemaraData()
end
end
end




function worldDailyEventController:showEventPanel(guid)



MysteryEventSystem:showEventByGuid(SYSTEM_DEFINE.eWorldDailyQiYuEvent,guid,{})

end

function worldDailyEventController.onMysteryEventNew(sysid,qiyuList)
if sysid==SYSTEM_DEFINE.eWorldDailyQiYuEvent then
worldDailyEventModel:onNewEventDataList(qiyuList)
worldDailyEventController:refreshWorldWin()
end
end

function worldDailyEventController.onEventFinish(guid,endData)
worldDailyEventModel:onEventFinish(guid)
worldDailyEventModel:del_world_unit(guid)
worldDailyEventController:refreshWorldWin()
end



function worldDailyEventController:showAllUnit()
local data=worldDailyEventModel:getEventData()
if data then
for guid,v in pairs(data)do
worldDailyEventModel:add_daily_event_unit(guid)
end
end
end

function worldDailyEventController:refreshWorldWin()
UIManager:callWindowFunc("UIWorldWin","refreshEventWin")
end

function worldDailyEventController:jumpToOneEvent()
local guid=worldDailyEventModel:get_unit_key()
if guid then
return worldDailyEventController:jumpToEvent(guid)
end
return false
end

function worldDailyEventController:jumpToEvent(guid,moveCam)
local posData=worldDailyEventModel:get_world_unit(guid)
local sceneType=mainControl:getSceneType()
local key=tostring(guid)
if posData then
if sceneType==eSceneType.eWorld and worldModel:isSameWorld(posData[1])then
if moveCam then
local cameraPosition=worldController:getCameraPosition()
worldController:lookAtUnit(worldModel:convertUnitKey({eWorldUnitTpye.DAILYEVENT,key}),cameraPosition.y,false,nil)
else
worldDailyEventController.onClickObjectInWorld({worldModel.UNITTYPE.DAILYEVENT,key})
end
return true
else
local position=nil
local worldId=posData[1]
position=worldPositionConfig:getPosition(posData[1],{posData[2],posData[3]})

if not position then
return false
end
local worldName=cfgHelper.get2(cfg_worldconfig_get,worldId,'name')
local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt('是否前往<color=#18a736>{0}</color>？',worldName),
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function()
local args={lookAt=position}
local flag=mainControl:enterWorld({worldId,args},function()
if moveCam then
local cameraPosition=worldController:getCameraPosition()
worldController:lookAtUnit(worldModel:convertUnitKey({eWorldUnitTpye.DAILYEVENT,key}),cameraPosition.y,false,nil)
else
worldDailyEventController.onClickObjectInWorld({worldModel.UNITTYPE.DAILYEVENT,key})
end
end)
end,
showclosebtn=false,
}
local comfirmDialogEnter=UIDialogManager.newDialog(showdata)
comfirmDialogEnter:show()

return true
end
end
return false
end





















