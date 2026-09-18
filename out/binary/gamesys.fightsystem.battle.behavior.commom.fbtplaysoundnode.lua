


registry_pool_class(fBTNodeTypo.PlaySound,'fBTPlaySoundNode',fBTBaseNode)

function fBTPlaySoundNode:__init(guid)
self.typo=fBTNodeTypo.PlaySound
end

function fBTPlaySoundNode:parser(rawData)
self.audioId=rawData[1]
self.filter=rawData[2]
self.volWeight=rawData[3]
self.randomWeight=rawData[4]
self.isBGM=rawData[5]
self.fadeTime=rawData[6]
end




function fBTPlaySoundNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
end

function fBTPlaySoundNode:start()
self:play()

end


function fBTPlaySoundNode:update(delta)
return self.state
end

function fBTPlaySoundNode:play()
local soundIdList=self:getSoundIdList()

local random=math.random(0,100)
local isPlaySound=random<=self.randomWeight

if isPlaySound then
local selectSoundId

local soundCount=#soundIdList
if soundCount>1 then

local selectIndex=math.random(1,soundCount)
selectSoundId=soundIdList[selectIndex]
else

selectSoundId=soundIdList[1]
end

if self.isBGM then
if selectSoundId==-1 then

AudioManager.fadeoutBGMusic(self.fadeTime)
else
self.handle=AudioManager.playBgMusic(selectSoundId,self.fadeTime)
end
else
self.handle=AudioManager.playAudio(selectSoundId,self.volWeight)
end
end
self.state=fBTNodeState.success
end

function fBTPlaySoundNode:onDespawn()
if self.handle then

end
self.entity=nil

self.filter=0
self.volWeight=0
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

function fBTPlaySoundNode:getSoundIdList()
local soundIdList={}
if type(self.audioId)=='number'then
local soundId=self.audioId
table.insert(soundIdList,soundId)
elseif type(self.audioId)=='table'then
soundIdList=self.audioId
elseif type(self.audioId)=='string'then
string.gsub(self.audioId,'[^,]+',function(soundIdStr)
local soundId=tonumber(soundIdStr)
table.insert(soundIdList,soundId)
end)
end

return soundIdList
end


