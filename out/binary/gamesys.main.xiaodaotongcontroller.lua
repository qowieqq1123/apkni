







local _MODULENAME="xiaodaotongController"
gameState.addListener(def_table(_MODULENAME))
xiaodaotongController.name=_MODULENAME

local refreshTimer=nil

function xiaodaotongController:onAppStart()

end

function xiaodaotongController:onEnterState(isReconnet)
xiaodaotongModel:initData()
notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
end

function xiaodaotongController:onLeaveState(isReconnet)
xiaodaotongModel:clearData()
refreshTimer=nil
notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
end

function xiaodaotongController:onPlayerCreate(...)

end

function xiaodaotongController:onProtocolReq(isReconnet)

end

function xiaodaotongController:onLostConnection()

end

function xiaodaotongController.on_home_event(etype)
if etype==homeEvent.eEnterHome then
refreshTimer=Time.realtimeSinceStartup
timeEventController.addNormalTimerHandler(3,xiaodaotongController.name,xiaodaotongController)
xiaodaotongModel:refreshTipsList(nil,true)
elseif etype==homeEvent.eLeaveHome then
timeEventController.removeNormalTimerHandler(3,xiaodaotongController.name)
end
end

function xiaodaotongController:onNormalUpdate(delay)
if MysteryModel:is_in_mystery()then return end
local time=Time.realtimeSinceStartup
if refreshTimer==nil or time-refreshTimer>=xiaodaotongModel.refreshTime then
refreshTimer=time
xiaodaotongModel:refreshTipsList()
end
end


function xiaodaotongController:enoughOpenDialogueConditon()
if systemModel.isOpen(SYSTEM_DEFINE.eJianZhuTiShi)and mainViewsControl.isOpen()and worldController:checkNoticiateBlockOpen()and fightController.curBattle==nil then
if mainControl:isInScene(eSceneType.eZongmen)then
return not shiLianTaModel.data.isFighting
elseif mainControl:isInScene(eSceneType.eWorld)then
return not worldExperienceModel:checkScene()and not MysteryModel:is_enter_Mystery()
end
end
return false
end


function xiaodaotongController:checkAndOpenDialogue()
if self:enoughOpenDialogueConditon()then
UIManager:showWindow("UIWorldZaWuPuDialogueWin")
end
end