







QianJiGeController=gameState.addListener({})

function QianJiGeController:onAppStart()
socketManager:register_receiver(6,10,QianJiGeController.recv_6_10)
socketManager:register_receiver(6,11,QianJiGeController.recv_6_11)

notifySystem:listenNotify(notifyConfig.building_event,self.handleBuildingEvent)
end

function QianJiGeController:onEnterState()
QianJiGeModel:init_data()
end

function QianJiGeController:onLeaveState()
notifySystem:removelistener(notifyConfig.building_event,self.handleBuildingEvent)
end

function QianJiGeController:onPlayerCreate(...)




end

function QianJiGeController.handleBuildingEvent(etype,sfId,ubdId,arg1,arg2,arg3)
if etype==buildingEvent.buildComplete then
local bdData=zongmenModel:getBuildingData(ubdId)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local buildType=cfg.build_type
if buildType==SLG_SYSTEM_TYPE.eQianJiGe then
QianJiGeController.send_6_10()
end
end
end

function QianJiGeController:onLostConnection()

end




function QianJiGeController.send_6_10()
socketManager:send_6_10()
end

function QianJiGeController.send_6_11(configId)
socketManager:send_6_11(configId)
end


function QianJiGeController.recv_6_10(len,unlockSkillList)
QianJiGeModel:set_unlock_skill_list_data(len,unlockSkillList)
end

function QianJiGeController.recv_6_11(result,configId)
if result==0 then
QianJiGeModel:set_skill_unlock(configId)
UIManager:closeWindow("UIQJGSkillTipsWin")
UIManager:invokeUIMethod("UIQianJiGeWin","showSkillPanel")
UIManager.info("解锁成功")

AudioManager.playAudio(525)

notifySystem:postNotify(notifyConfig.onQianJiGeUnlockSkill,configId)
end
end

