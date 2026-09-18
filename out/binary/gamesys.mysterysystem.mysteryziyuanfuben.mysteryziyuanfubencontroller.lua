






local _MODULENAME="mysteryZiYuanFuBenController"

gameState.addListener(def_table(_MODULENAME))
mysteryZiYuanFuBenController.name=_MODULENAME
mysteryZiYuanFuBenController.data={}

function mysteryZiYuanFuBenController:onAppStart()

mysteryZiYuanFuBenModel:onAppStart()







notifySystem:listenNotify(notifyConfig.onClickObjectInWorld,self.onClickObjectInWorld)

socketManager:register_receiver(4,78,mysteryZiYuanFuBenController.recv_4_78)
socketManager:register_receiver(4,79,mysteryZiYuanFuBenController.recv_4_79)
notifySystem:listenNotify(notifyConfig.onWorldPositionReRandom,self.onWorldPositionReRandom)
notifySystem:listenNotify(notifyConfig.on_system_open,self.onSystemOpen)
notifySystem:listenNotify(notifyConfig.on_mystery_quit,self.on_mystery_quit)
worldController:registerSceneState(1,1,function()
mysteryZiYuanFuBenController:showWorldAllUnit()

mysteryZiYuanFuBenController:checkLockMystery()
end)
end

function mysteryZiYuanFuBenController.on_mystery_quit()
if systemModel.isOpen(SYSTEM_DEFINE.eMiJingRand)then
mysteryZiYuanFuBenController.send_4_78()
end
end

function mysteryZiYuanFuBenController.onWorldPositionReRandom(rData,aData)
if rData.unitType==eWorldUnitTpye.RESMYSTERY then
mysteryZiYuanFuBenModel:onWorldPositionReRandom(rData,aData)
end
end


function mysteryZiYuanFuBenController:onEnterState(isReconnect)
mysteryZiYuanFuBenModel:onEnterState()
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
end


function mysteryZiYuanFuBenController:onProtocolReq()
mysteryZiYuanFuBenModel:onProtocolReq()




end

function mysteryZiYuanFuBenController.onSystemOpen(sysid)
if sysid==SYSTEM_DEFINE.eMiJingRand then
mysteryZiYuanFuBenController.send_4_78()
end
if sysid==SYSTEM_DEFINE.eLingShou then
mysteryZiYuanFuBenModel:initFBList()
end
end

function mysteryZiYuanFuBenController.send_4_78()
socketManager:send_4_78()
end

function mysteryZiYuanFuBenController.recv_4_78(len,resList,initLevel)
mysteryZiYuanFuBenModel:initZiYuanMysteryData(resList)
mysteryZiYuanFuBenModel:setInitLevel(initLevel)
if not mysteryZiYuanFuBenModel.initFBListFlag then
mysteryZiYuanFuBenModel:initFBList()

end
end

function mysteryZiYuanFuBenController.test_reset()
userActorArraySetting.clear(ACTOR_SETTING_TYPE.eResMystery)
mysteryZiYuanFuBenModel:initZiYuanMysteryData({})
mysteryZiYuanFuBenModel:initFBList()
end

function mysteryZiYuanFuBenController.send_4_79(tagId,resId,mjGroupIndex)
socketManager:send_4_79(tagId,resId,mjGroupIndex)
end

function mysteryZiYuanFuBenController.recv_4_79(tagId,resId,mjGroupIndex,stRWFlag)
mysteryZiYuanFuBenModel:setZiYuanMysteryData(tagId,mjGroupIndex,stRWFlag)

UIManager:invokeUIMethod("UIMysteryEnterZiYuanWin","refreshWin")

UIManager:invokeUIMethod("UIMysteryListWin","refreshMainReddot")
UIManager:invokeUIMethod("UIMysteryListWin","refreshChildReddot")

notifySystem:postNotify(notifyConfig.on_UIWorldWin_infoBtn_reddotChange)
notifySystem:postNotify(notifyConfig.on_UIWorldUnitListWin2_reddotChange,SYSTEM_DEFINE.eMiJing)
end


function mysteryZiYuanFuBenController:onLeaveState(isReconnect)
mysteryZiYuanFuBenModel:onLeaveState(isReconnect)
notifySystem:removelistener(notifyConfig.onNewDay5am,self.onNewDay5am)

self.data={}

end


function mysteryZiYuanFuBenController:onLostConnection()

end


function mysteryZiYuanFuBenController:onReConnection(isInitPro)

end

function mysteryZiYuanFuBenController.onNewDay5am()
local probeCountCfg=cfg_secretsceneziyuanfubenbaseconfig_get(1).probeCount
for k,v in pairs(probeCountCfg)do
mysteryZiYuanFuBenModel:SetprobeNum(k)
end

end

function mysteryZiYuanFuBenController.onClickObjectInWorld(args)
if args and args[1]==worldModel.UNITTYPE.RESMYSTERY then

AudioManager.playBtnClick()
local group=string.split(args[2],'-')
worldController:changeRightView("UIMysteryEnterZiYuanWin",group)
end
end
function mysteryZiYuanFuBenController:showWorldAllUnit(worldId)
local fbList=mysteryZiYuanFuBenModel:getFbData()
for tagId,v in pairs(fbList)do
mysteryZiYuanFuBenModel:add_World_Mystery_unit(tagId,v.curId)
end
end

function mysteryZiYuanFuBenController:jumpToMystery(groupId)
local data=mysteryZiYuanFuBenModel:getGroupFbData(groupId)
if data then
local sceneType=mainControl:getSceneType()
local key=table.concat({groupId,data.curId},"-")
local posData=mysteryZiYuanFuBenModel:get_mysteryFB_unit(key)
if posData then
if sceneType==eSceneType.eWorld and worldModel:isSameWorld(posData[1])then
local key=worldModel:convertUnitKey({worldModel.UNITTYPE.RESMYSTERY,key})
if key then
worldController:lookAtUnit(key)
end
worldController:changeRightView("UIMysteryEnterZiYuanWin",{groupId,data.curId})
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
content=FMT.fmt('确认前往<color=#18a736>{0}</color>？',worldName),
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function()
local args={lookAt=position}
local flag=mainControl:enterWorld({worldId,args},function()
worldController:changeRightView("UIMysteryEnterZiYuanWin",{groupId,data.curId})
end)
end,
showclosebtn=false,
}
local comfirmDialogEnter=UIDialogManager.newDialog(showdata)
comfirmDialogEnter:show()

return true
end
end
end
return false
end

function mysteryZiYuanFuBenController:jumpToMysteryNoDialouge(groupId)
local data=mysteryZiYuanFuBenModel:getGroupFbData(groupId)
if data then
local sceneType=mainControl:getSceneType()
local key=table.concat({groupId,data.curId},"-")
local posData=mysteryZiYuanFuBenModel:get_mysteryFB_unit(key)
if posData then
if sceneType==eSceneType.eWorld and worldModel:isSameWorld(posData[1])then
local key=worldModel:convertUnitKey({worldModel.UNITTYPE.RESMYSTERY,key})
if key then
worldController:lookAtUnit(key)
end
worldController:changeRightView("UIMysteryEnterZiYuanWin",{groupId,data.curId})
return true
else
local position=nil
local worldId=posData[1]
position=worldPositionConfig:getPosition(posData[1],{posData[2],posData[3]})

if not position then
return false
end
local args={lookAt=position}
local flag=mainControl:enterWorld({worldId,args},function()
worldController:changeRightView("UIMysteryEnterZiYuanWin",{groupId,data.curId})
end)

return flag or false
end
end
end
return false
end

function mysteryZiYuanFuBenController:checkLockMystery()
local allconfig=cfg_secretsceneziyuanfubenconfig()
if mysteryZiYuanFuBenModel.data.ziYuanMysteryData then
for tagId,v in pairs(mysteryZiYuanFuBenModel.data.ziYuanMysteryData)do
if v.layerData then
local curLayer=v.curLayer
local curResId=v.curResId or 0
if curLayer and curLayer>0 then
for i,vv in pairs(v.layerData)do
if curResId~=0 then
local config=allconfig[tagId][curResId]
if not mysteryZiYuanFuBenModel:checkCond(tagId,curResId,curLayer)then
local mjId=config.mjGroup[curLayer]
MysteryController.send_4_4(mjId)
MysteryController.send_4_5(mjId)
end
end
end
end
end
end
end
end