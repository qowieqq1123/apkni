






AudioManager={}


local _GameInterface=CS.GameInterface
local _SoundManager_SetFloatParams=_GameInterface.SoundManager_SetFloatParams
local _SoundManager_GetFloatParams=_GameInterface.SoundManager_GetFloatParams
local _SoundManager_SetGroupVolume=_GameInterface.SoundManager_SetGroupVolume
local _SoundManager_GetGroupVolume=_GameInterface.SoundManager_GetGroupVolume
local _SoundManager_PlaySound=_GameInterface.SoundManager_PlaySound
local _SoundManager_PlaySceneSound=_GameInterface.SoundManager_PlaySceneSound
local _SoundManager_ClearGroupAudio=_GameInterface.SoundManager_ClearGroupAudio
local _SoundManager_TransitionToSnapshot=_GameInterface.SoundManager_TransitionToSnapshot
local _SoundManager_SetMute=_GameInterface.SoundManager_SetMute
local _SoundManager_SetVolume=_GameInterface.SoundManager_SetVolume
local _SoundManager_StopGroup=_GameInterface.SoundManager_StopGroup
local _SoundManager_SetListenerActive=_GameInterface.SoundManager_SetListenerActive
local _SoundManager_StopEffect=_GameInterface.SoundManager_StopEffect
local _SoundManager_FadeOutStopEffect=_GameInterface.SoundManager_FadeOutStopEffect
local _SoundManager_SetBgMusicMute=_GameInterface.SoundManager_SetBgMusicMute
local _SoundManager_IsMute=_GameInterface.SoundManager_IsMute


local _bgFadeTime=1
local _musicReleaseTime
local _bgmVolWeight=0.8
local _effectVolWeight=1
local _roleSpeakVolWeight=1

local _lastMuteGroupTable={}
local _isMuteGroup={}
SoundID=
{
BtnClick=100,
OpenUI=100,
CloseUI=102,
}

local _GameInterface=CS.GameInterface

function AudioManager.getConfig(id)
return cfgHelper.get(cfg_soundconfig_get,id)
end

function AudioManager.getCommonConfig(id)
return cfgHelper.get(cfg_soundcommonconfig_get,id)
end





function AudioManager.playOpenUI()
AudioManager.playAudio(SoundID.OpenUI)
end


function AudioManager.playCloseUI()
AudioManager.playAudio(SoundID.CloseUI)
end


function AudioManager.playBtnClick()
AudioManager.playAudio(SoundID.BtnClick)
end





function AudioManager.setBgMusicMute(isMute)
_SoundManager_SetBgMusicMute(isMute)
end


function AudioManager.setAllEffectMute(isMute)
_SoundManager_SetMute(SOUND_GROUP_TYPE.effect,isMute)
end


function AudioManager.setGroupMute(groupId,isMute)
local apiLevel=deviceHelper.getAPILevel()
if isMute and apiLevel<45 then

local volume=AudioManager.getGroupVolume(groupId)
_lastMuteGroupTable[groupId]=volume
end

_SoundManager_SetMute(groupId,isMute)

if not isMute and apiLevel<45 then

local floatValue=_lastMuteGroupTable[groupId]
if floatValue then
AudioManager.setGroupVolume(groupId,floatValue)
end
end
end


function AudioManager.isMute(groupId)
return _SoundManager_IsMute(groupId)
end


function AudioManager.setGroupParams(groupId,key,floatValue)
_SoundManager_SetFloatParams(groupId,key,floatValue)
end


function AudioManager.getGroupParams(groupId,key)
return _SoundManager_GetFloatParams(groupId,key)
end




function AudioManager.setGroupVolume(groupId,floatValue)
local value=floatValue
local apiLevel=deviceHelper.getAPILevel()
if apiLevel<45 then

_lastMuteGroupTable[groupId]=floatValue
end

local commongCfg=cfgHelper.get(cfg_soundcommonconfig_get,groupId)
if commongCfg~=nil and commongCfg.controlTypes~=nil then
local mute=value<=0.05
for _,gID in pairs(commongCfg.controlTypes)do
_isMuteGroup[gID]=mute
end
end

_SoundManager_SetGroupVolume(groupId,value)
end


function AudioManager.getGroupVolume(groupId)
return _SoundManager_GetGroupVolume(groupId)
end


local _playAudio=function(soundId,volWeight,loop,loopInterval,priority,fadeTime,isPitchSynchro,changePitchFun)
local config=AudioManager.getConfig(soundId)
if not config then
loggerUtil.logErrFMT('没有此音乐配置{0}',soundId)
return-1
end
local isBGM=AudioManager.check(config)
if not fadeTime and(config.group==SOUND_GROUP_TYPE.BGM or config.group==SOUND_GROUP_TYPE.music)then
fadeTime=_bgFadeTime
end
local handle
if api_Available_SoundManager_GetAudioByUGUID()then
handle=_SoundManager_PlaySound(soundId,volWeight or 1,loop or false,loopInterval or 0,priority or 0,fadeTime or 0,isPitchSynchro or false,changePitchFun)
else
handle=_SoundManager_PlaySound(soundId,volWeight or 1,loop or false,loopInterval or 0,priority or 0,fadeTime or 0,isPitchSynchro or false)
end
if isBGM and handle~=-1 then
AudioManager.bgmHandle=handle
end
return handle
end


local _playSceneAudio=function(soundId,volWeight,loop,loopInterval,priority,minDistance,maxDistance,rolloffMode,fadeTime,isPitchSynchro,changePitchFun)
local config=AudioManager.getConfig(soundId)
if not config then
loggerUtil.logErrFMT('没有此音乐配置{0}',soundId)
return-1
end
AudioManager.check(config)
if not fadeTime and(config.group==SOUND_GROUP_TYPE.BGM or config.group==SOUND_GROUP_TYPE.music)then
fadeTime=_bgFadeTime
end
if api_Available_SoundManager_GetAudioByUGUID()then
return _SoundManager_PlaySceneSound(soundId,volWeight or 1,loop or false,loopInterval or 0,priority or 0,minDistance or 1,maxDistance or 500,rolloffMode or 0,fadeTime or 0,isPitchSynchro or false,changePitchFun)
else
return _SoundManager_PlaySceneSound(soundId,volWeight or 1,loop or false,loopInterval or 0,priority or 0,minDistance or 1,maxDistance or 500,rolloffMode or 0,fadeTime or 0,isPitchSynchro or false)
end
end

function AudioManager.check(config)
if not config then
return
end
local isBGM=config.group==SOUND_GROUP_TYPE.BGM or config.group==SOUND_GROUP_TYPE.music
if isBGM then
AudioManager.currentBgm=config.id
end
local currentSnap=AudioManager.currentSnap or 1
local snap=config.snap
if currentSnap~=snap then
AudioManager.currentSnap=snap
AudioManager.transitionToSnapshot(snap)
end
return isBGM
end

function AudioManager.playWidgetAudio(widget,index,id,volWeight,priority,fadeTime)
local config=AudioManager.getConfig(id)
if not config then
loggerUtil.logErrFMT('没有此音乐配置{0}',id)
return-1
end

local loopInterval=config.loopInterval or 0
local loop=config.loopInterval~=nil
local priority=priority or config.weight or 0
return widget:PlayAudioSource(index,id,volWeight or 1,loop or false,loopInterval or 0,priority or 0,fadeTime or 0)
end

function AudioManager.stopMuteGroup()
for typo,isMute in pairs(_isMuteGroup)do
if isMute then
_SoundManager_StopGroup(typo)
end
end
if _isMuteGroup[SOUND_GROUP_TYPE.music]or _isMuteGroup[SOUND_GROUP_TYPE.BGM]then
AudioManager.currentBgm=nil
end
end

function AudioManager.playAudio(id,volWeight,priority,fadeTime,isPitchSynchro,changePitchFun)
if not id or id==-1 then
return-1
end

local config=AudioManager.getConfig(id)
if not config then
loggerUtil.logErrFMT('没有此音乐配置{0}',id)
return-1
end

if _isMuteGroup[config.group]then
return-1
end

if AudioManager.checkShield(id)then
return-1
end

if isPitchSynchro==nil then
isPitchSynchro=sceneAudioModel:checkIsPitchSynchroByGroupIndex(config.group)
end

if changePitchFun==nil then
changePitchFun=sceneAudioModel:getChangePitchFunByGroupIndex(config.group)
end

local loopInterval=config.loopInterval or 0
local loop=config.loopInterval~=nil
local priority=priority or config.weight or 0
return _playAudio(id,volWeight,loop,loopInterval,priority,fadeTime,isPitchSynchro,changePitchFun)
end

function AudioManager.playSceneAudio(id,volWeight,priority,minDistance,maxDistance,rolloffMode,fadeTime,isPitchSynchro,changePitchFun)
local config=AudioManager.getConfig(id)
if not config then
loggerUtil.logErrFMT('没有此音乐配置{0}',id)
return-1
end

if isPitchSynchro==nil then
isPitchSynchro=sceneAudioModel:checkIsPitchSynchroByGroupIndex(config.group)
end

if changePitchFun==nil then
changePitchFun=sceneAudioModel:getChangePitchFunByGroupIndex(config.group)
end

local loopInterval=config.loopInterval or 0
local loop=config.loopInterval~=nil
local priority=priority or config.weight or 0
return _playSceneAudio(id,volWeight,loop,loopInterval,priority,minDistance,maxDistance,rolloffMode,fadeTime,isPitchSynchro,changePitchFun)
end



function AudioManager.playBgMusic(id,fadeTime,volWeight)
if AudioManager.currentBgm==nil then

AudioManager.stopBGMusic()
end

local config=AudioManager.getConfig(id)
if not config then
loggerUtil.logErrFMT('没有此背景音乐配置{0}',id)
return
end
if config.group~=SOUND_GROUP_TYPE.BGM and config.group~=SOUND_GROUP_TYPE.music then
loggerUtil.logErrFMT('播放id{0}不是背景音乐',id)
return
end
if config.group==SOUND_GROUP_TYPE.music then
if _musicReleaseTime then
AudioManager.setGroupParams(SOUND_GROUP_TYPE.music,"music_releaseTime",_musicReleaseTime)
else

_musicReleaseTime=AudioManager.getGroupParams(SOUND_GROUP_TYPE.music,"music_releaseTime")
end
end
return AudioManager.playAudio(id,volWeight,nil,fadeTime)
end


function AudioManager.stopBGMusic()
_SoundManager_StopGroup(SOUND_GROUP_TYPE.BGM)
_SoundManager_StopGroup(SOUND_GROUP_TYPE.music)

AudioManager.currentBgm=nil
end

function AudioManager.fadeoutBGMusic(fadeTime)
AudioManager.fadeOutStopAudioById(AudioManager.bgmHandle,fadeTime or 1,true)
AudioManager.currentBgm=nil
end


function AudioManager.setPauseBGMusic(isPause,fadeTime)
if isPause then

AudioManager.pauseBgm=AudioManager.currentBgm
AudioManager.fadeoutBGMusic(fadeTime)
else
if AudioManager.pauseBgm then
AudioManager.playBgMusic(AudioManager.pauseBgm,fadeTime)
AudioManager.pauseBgm=nil
end
end
end

function AudioManager.clearPauseBGMusic()
AudioManager.pauseBgm=nil
end



function AudioManager.clearGroupAudio(groupId)
_SoundManager_ClearGroupAudio(groupId)
end


function AudioManager.transitionToSnapshot(snapId,transTime,igonreTimeScale)
if igonreTimeScale==nil then igonreTimeScale=true end
_SoundManager_TransitionToSnapshot(snapId,transTime or 0,igonreTimeScale)
end


function AudioManager.setSoundEffectVolume(floatValue)
local volume=floatValue*_effectVolWeight
AudioManager.setGroupVolume(SOUND_GROUP_TYPE.effect,volume)
end


function AudioManager.setBgMusicVolume(floatValue)
local volume=floatValue*_bgmVolWeight
AudioManager.setGroupVolume(SOUND_GROUP_TYPE.BGM,volume)
end


function AudioManager.setRoleSpeakVolume(floatValue)
local volume=floatValue*_roleSpeakVolWeight
AudioManager.setGroupVolume(SOUND_GROUP_TYPE.rolespeak,volume)
end


function AudioManager.stopRoleSpeakMusic()
_SoundManager_StopGroup(SOUND_GROUP_TYPE.rolespeak)
end

function AudioManager.getCurrentBgm()
return AudioManager.currentBgm
end


function AudioManager.setListenerActive(flag)
_SoundManager_SetListenerActive(flag)
end

function AudioManager.initListenerPosition()
_GameInterface.SoundManager_SetListenerPosition(Vector3.New(10000,10000,10000))
end

function AudioManager.setListenerPosition(pos)
_GameInterface.SoundManager_SetListenerPosition(pos)
end


function AudioManager.stopAudioById(handleId)
if handleId and 0<handleId then
_SoundManager_StopEffect(handleId)
end
end


function AudioManager.fadeOutStopAudioById(handleId,fadeTime,isMusic)
if handleId and 0<handleId then
local callBack=nil
if isMusic then
callBack=AudioManager.musicFadeOutToStopCallBack
end
_SoundManager_FadeOutStopEffect(handleId,fadeTime,callBack)
end
end


function AudioManager.setAudioVolumeWeight(handleId,value)
_GameInterface.SoundManager_SetVolumeWeight(handleId,value)
end


function AudioManager.setAudioVolume(handleId,value)
_GameInterface.SoundManager_SetVolume(handleId,value)
end


function AudioManager.checkShield(soundId)
local isShield=false
if not sceneAudioModel:getAudioShieldState()then

return isShield
end


local needShield=AudioManager.getConfig(soundId).needShield
if needShield then
isShield=true
end

return isShield
end


function AudioManager.musicFadeOutToStopCallBack()
AudioManager.setGroupParams(SOUND_GROUP_TYPE.music,"music_releaseTime",0)
end