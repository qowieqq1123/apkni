






local _MODULENAME="sceneAudioController"




gameState.addListener(def_table(_MODULENAME))
sceneAudioController.name=_MODULENAME

sceneAudioController.distanceWeight=
{
[0]=1,
[1]=0.8,
[2]=0.6,
[3]=0.4,
[4]=0.2,
[5]=0,
}

sceneAudioController.data={}

function sceneAudioController:onAppStart()

sceneAudioModel:onAppStart()

end


function sceneAudioController:onEnterState()
sceneAudioModel:onEnterState()

notifySystem:listenNotify(notifyConfig.on_mystery_entity_enter_view,self.on_mystery_entity_enter_view)
notifySystem:listenNotify(notifyConfig.on_mystery_entity_leave_view,self.on_mystery_entity_leave_view)
notifySystem:listenNotify(notifyConfig.on_mystery_entity_view_change,self.on_mystery_entity_view_change)

notifySystem:listenNotify(notifyConfig.onWorldCameraBlockChanged,self.onWorldCameraBlockChanged)

notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.enterXianJie,self.onEnterXianJie)


end


function sceneAudioController:onServerDataInitFinish()
sceneAudioModel:onServerDataInitFinish()
end


function sceneAudioController:onLeaveState(isReconnect)
sceneAudioModel:onLeaveState()

self.data={}

AudioManager.setListenerActive(true)

notifySystem:removelistener(notifyConfig.on_mystery_entity_enter_view,self.on_mystery_entity_enter_view)
notifySystem:removelistener(notifyConfig.on_mystery_entity_leave_view,self.on_mystery_entity_leave_view)
notifySystem:removelistener(notifyConfig.on_mystery_entity_view_change,self.on_mystery_entity_view_change)

notifySystem:removelistener(notifyConfig.onWorldCameraBlockChanged,self.onWorldCameraBlockChanged)

notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
notifySystem:removelistener(notifyConfig.enterXianJie,self.onEnterXianJie)


if isReconnect then

AudioManager.setPauseBGMusic(false)
end
AudioManager.clearPauseBGMusic()
end


function sceneAudioController:onLostConnection()

end






function sceneAudioController:addTrackAudio(id,volWeight)
local weight=sceneAudioModel.get_weight(id)
local track,getType=sceneAudioModel:findEmptyTrack(weight)
if track then
if getType==2 then
sceneAudioController:removeTrackAudio(track)
end
local handle=AudioManager.playAudio(id,volWeight or 1,weight)
sceneAudioModel:addTrackAudio(track,handle,weight)
return track,handle
end
end

function sceneAudioController:setTrackAudioWeightByHandle(handle,volWeight)
AudioManager.setAudioVolumeWeight(handle,volWeight)
end

function sceneAudioController:removeTrackAudioByHandle(handle)
local track=sceneAudioModel:getTrackByHandle(handle)
if track then
sceneAudioController:removeTrackAudio(track)
end
end

function sceneAudioController:removeTrackAudio(track)
local trackAudio=sceneAudioModel:getTrackAudio(track)
if trackAudio then
AudioManager.stopAudioById(trackAudio[1])
sceneAudioModel:removeTrackAudio(track)
end
end

function sceneAudioController:stopAllTrackAudio()
sceneAudioModel:initAudioTrack()
end



function sceneAudioController.on_mystery_entity_enter_view(distance,entityData)
sceneAudioController:addEntityAudio(distance,entityData)
end

function sceneAudioController.on_mystery_entity_leave_view(distance,entityData)
sceneAudioController:removeEntityAudio(distance,entityData)
end

function sceneAudioController.on_mystery_entity_view_change(distance,entityData)
sceneAudioController:setEntityAudioWeight(distance,entityData)
end

function sceneAudioController:addEntityAudio(distance,entityData)
if entityData then
local weight=self.distanceWeight[distance]or 0
if weight>0 then
local config=mysteryEntityController.invokeFuncByMysteryEntityType(entityData.entityType,"get_config",entityData.id)
if config then
local soundId=config.soundId
if soundId then
local track,handle=sceneAudioController:addTrackAudio(soundId,weight)
sceneAudioModel:addMysteryEntityAudio(entityData.guid,handle)
end
end
end
end
end

function sceneAudioController:removeEntityAudio(distance,entityData)
if entityData then
local handle=sceneAudioModel:getMysteryEntityAudio(entityData.guid)
if handle then
sceneAudioController:removeTrackAudioByHandle(handle)
sceneAudioModel:removeMysteryEntityAudio(entityData.guid)
end
end
end

function sceneAudioController:setEntityAudioWeight(distance,entityData)
if entityData then
local handle=sceneAudioModel:getMysteryEntityAudio(entityData.guid)
if handle then
local weight=self.distanceWeight[distance]or 0
if weight>0 then
sceneAudioController:setTrackAudioWeightByHandle(handle,weight)
else
sceneAudioController:removeTrackAudioByHandle(handle)
sceneAudioModel:removeMysteryEntityAudio(entityData.guid)
end
end
end
end



function sceneAudioController.onWorldCameraBlockChanged(sight,horizontal)

if JiuChongTianJieEnterController:checkInFSJQ()then
return
end

local curWorldId=worldModel.world
if curWorldId then
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,curWorldId,sight)
if blockCfg and blockCfg.bgMusic then
AudioManager.playBgMusic(blockCfg.bgMusic)
end
end
end



function sceneAudioController.on_building_event(etype,sfId,bdId,args)
if etype==buildingEvent.buildComplete then

elseif etype==buildingEvent.moveBuilding then

elseif etype==buildingEvent.levelUpComplete then
AudioManager.playAudio(310)
elseif etype==buildingEvent.levelUpStart then
AudioManager.playAudio(311)
elseif etype==buildingEvent.speedUpComplete then
local isSpecialSound=false
local type2=args and args.type2
local ignorePlayAudio=args and args.ignorePlayAudio
if ignorePlayAudio then
return
end


if type2 and type2==speedUpType.eExecutePlant then
local bdData=zongmenModel:getBuildingData(bdId)
local specialBdList={
[SLG_SYSTEM_TYPE.eYaoPu]=true,
[SLG_SYSTEM_TYPE.eLinChang]=true,
[SLG_SYSTEM_TYPE.eKuangMai]=true,
[SLG_SYSTEM_TYPE.eFuLuFang]=true,
}

if bdData and specialBdList[bdData.build_id]then
isSpecialSound=true
end
end
if isSpecialSound then

AudioManager.playAudio(504)
else
AudioManager.playAudio(312)
end
end
end


function sceneAudioController.on_home_event(etype)
if etype==homeEvent.eEnterHome then

sceneAudioController.playZongMenBgMusic()
timeEventController.addNormalTimerHandler(1,'sceneAudioController',sceneAudioController)
elseif etype==homeEvent.eLeaveHome then
timeEventController.removeNormalTimerHandler(1,'sceneAudioController')
end
end










function sceneAudioController:playLoginBgMusic()
AudioManager.initListenerPosition()
local bgMusic=cfgHelper.get2(cfg_systemsetconfig_get,1,"login_back_music")
local specialParam=loginModel:getSpecialLoginWinParam()
if specialParam then
if specialParam.bgmId then
bgMusic=specialParam.bgmId
end
else
local pfDefaultParam=loginModel:getPfDefaultLoginWinParam()
if pfDefaultParam and pfDefaultParam.bgmId then
bgMusic=pfDefaultParam.bgmId
end
end

if bgMusic then
AudioManager.playBgMusic(bgMusic)
end
end

function sceneAudioController:playMysteryBgMusic()
AudioManager.initListenerPosition()
local fbId=MysteryModel:get_cur_fbid()
if fbId then
local bgMusic=cfgHelper.get2(cfg_secretscenefubenconfig_get,fbId,"bgMusic")
if bgMusic then
AudioManager.playBgMusic(bgMusic)
end
end
end

function sceneAudioController:playMysteryEnterMusic()

AudioManager.playAudio(541)
end

function sceneAudioController.playZongMenBgMusic()
AudioManager.initListenerPosition()
local mountainId=zongmenModel:getMountainId()
if mountainId then
local bgMusic=cfgHelper.get2(cfg_monijysfconfig_get,mountainId,"bgMusic")
if bgMusic then
AudioManager.playBgMusic(bgMusic)
end
end
end



function sceneAudioController.onEnterXianJie(sceneType)
local sceneIndex=xianjieModel:getSceneIndex(sceneType)
sceneAudioController.playXianJieBgMusicBySceneIndex(sceneIndex)
end

function sceneAudioController.playXianJieBgMusicBySceneIndex(sceneIndex)
AudioManager.initListenerPosition()

if sceneIndex then
local bgMusic=cfgHelper.get2(cfg_fairylandsceneidxconfig_get,sceneIndex,"bgMusic")
if bgMusic then
AudioManager.playBgMusic(bgMusic)
end
end
end