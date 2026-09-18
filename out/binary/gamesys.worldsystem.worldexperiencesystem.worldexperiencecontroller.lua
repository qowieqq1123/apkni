






local _MODULENAME="worldExperienceController"




gameState.addListener(def_table(_MODULENAME))
worldExperienceController.name=_MODULENAME
worldExperienceController.data={}

local _this=worldExperienceController


function worldExperienceController:onAppStart()

worldExperienceModel:onAppStart()



socketManager:register_receiver(5,7,self.recv_5_7)
socketManager:register_receiver(5,11,self.recv_5_11)
socketManager:register_receiver(5,12,self.recv_5_12)

notifySystem:listenNotify(notifyConfig.onMissionDiscipleChanged,self.onMissionDiscipleChanged)
notifySystem:listenNotify(notifyConfig.onStartMissionInWorld,self.onStartMissionInWorld)
notifySystem:listenNotify(notifyConfig.onWorldBlockDataChanged,self.onWorldBlockDataChanged)
notifySystem:listenNotify(notifyConfig.onDiscipleCreate,self.onDiscipleCreate)


worldController:registerSceneState(1,3,function()
self:onEnterWorldEvent(worldModel.world)
end)



end


function worldExperienceController:onEnterState()
worldExperienceModel:onEnterState()
end


function worldExperienceController:onServerDataInitFinish()
worldExperienceModel:onServerDataInitFinish()
end


function worldExperienceController:onLeaveState(isReconnet)
worldExperienceModel:onLeaveState(isReconnet)
self:cleanWalkBt()
end


function worldExperienceController:onLostConnection()
self.autoContinue=nil
end

function worldExperienceController:onProtocolReq()
self:checkReConnection(true)
end






















function worldExperienceController:checkReConnection(onInit)
if worldController:isInWorld()then
worldExperienceController:onEnterWorldEvent(worldModel.world)
local world=worldExperienceModel:getCurrentWorld()
local block=worldExperienceModel:getCurrentBlock()
if worldExperienceModel:checkScene()then
if not worldExperienceModel:sameScene(world,block)then
local noviciate=cfgHelper.get2(cfg_worldglobalconfig_get,"noviciateBlock","value")
local sceneWorld,sceneBlock=worldExperienceModel:getScene()
if sceneWorld==noviciate[1]and sceneBlock==noviciate[2]then
worldExperienceModel:outScene()
worldController:exitWorld()
return
else
local w,b=worldExperienceModel:getScene()
local unitKey=worldExperienceModel:convertTaskTargetKey(w,b)
local taskKey=worldTaskModel:findTaskKey_ByTargetProgress(unitKey,eWorldTripProgress.Work)
if taskKey then
worldTaskController:returnMission(taskKey)
end

worldExperienceController:exitExperience()
worldExperienceModel:outScene()
end

elseif onInit then
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
self.autoContinue=blockCfg.eAutoContinue





end
end
if worldModel:isSameWorld(world)then
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.FOG,blockCfg.fog2})
worldHUDModel:onUpdateHUD(unitKey)
end
end
end