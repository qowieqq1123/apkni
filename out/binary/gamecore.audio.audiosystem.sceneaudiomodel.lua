






local _MODULENAME="sceneAudioModel"


def_table(_MODULENAME)
sceneAudioModel.name=_MODULENAME
sceneAudioModel.data={}



sceneAudioModel.audioTrackCount=6

local changeAudioPitchFun={
[SOUND_GROUP_TYPE.skill]=function(audio,pitch)
local newPitch
if pitch==2 then
newPitch=1.5
elseif pitch==3 then
newPitch=2.1
end

if newPitch then
audio.pitch=newPitch
end
end
}

function sceneAudioModel.get_weight(id)
local config=cfg_soundconfig_get(id)
return config and config.weight
end




function sceneAudioModel:onAppStart()

end


function sceneAudioModel:onEnterState()
sceneAudioModel:initAudioTrack()
sceneAudioModel:initMysteryData()
end


function sceneAudioModel:onLeaveState()

self.data={}
end


function sceneAudioModel:onServerDataInitFinish()

end



function sceneAudioModel:initAudioTrack()
if self.data.trackAudio and next(self.data.trackAudio)then
for track,trackData in pairs(self.data.trackAudio)do
if 0<trackData[1]then
AudioManager.stopAudioById(trackData[1])
end
end
end
self.data.trackAudio={}

sceneAudioModel:changePitchSynchroByGroupIndex(SOUND_GROUP_TYPE.skill,true)
end

function sceneAudioModel:addTrackAudio(track,handle,weight)
self.data.trackAudio[track]={handle,weight}
end

function sceneAudioModel:getTrackAudio(track)
return self.data.trackAudio[track]
end

function sceneAudioModel:removeTrackAudio(track)
self.data.trackAudio[track]=nil
end

function sceneAudioModel:getTrackByHandle(handle)
if self.data.trackAudio and next(self.data.trackAudio)then
for track,trackData in pairs(self.data.trackAudio)do
if handle==trackData[1]then
return track
end
end
end
end

function sceneAudioModel:findEmptyTrack(weight)
local lowWeightIndex=nil
local lowWeight=nil
local curWeight=nil
for i=1,sceneAudioModel.audioTrackCount do
if self.data.trackAudio[i]==nil then
return i,1
else
curWeight=self.data.trackAudio[i][2]
if(not lowWeight)or(lowWeight and curWeight>lowWeight)then
lowWeightIndex=i
lowWeight=curWeight
end
end
end


if lowWeight>weight then
return lowWeightIndex,2
end
end


function sceneAudioModel:setAudioShieldState(flag)
self.data.audioShieldState=flag
end

function sceneAudioModel:getAudioShieldState()
return self.data.audioShieldState or false
end


function sceneAudioModel:changePitchSynchroByGroupIndex(groupId,isChangePinch)
if not self.data.pitchSynchroGroup then
self.data.pitchSynchroGroup={}
end
self.data.pitchSynchroGroup[groupId]=isChangePinch
end


function sceneAudioModel:checkIsPitchSynchroByGroupIndex(groupId)
if not self.data.pitchSynchroGroup then
return false
end

return self.data.pitchSynchroGroup[groupId]or false
end


function sceneAudioModel:getChangePitchFunByGroupIndex(groupId)
return changeAudioPitchFun[groupId]
end

function sceneAudioModel:initMysteryData()
self.data.mysteryAudioHandle={}
end

function sceneAudioModel:addMysteryEntityAudio(entityHandle,audioHandle)
self.data.mysteryAudioHandle[entityHandle]=audioHandle
end

function sceneAudioModel:getMysteryEntityAudio(entityHandle)
return self.data.mysteryAudioHandle[entityHandle]
end

function sceneAudioModel:removeMysteryEntityAudio(entityHandle)
self.data.mysteryAudioHandle[entityHandle]=nil
end


