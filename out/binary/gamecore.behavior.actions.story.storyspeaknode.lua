








storySpeakNode=simple_class(baseNode)

function storySpeakNode:broke()
self.sLoadId=nil
end

function storySpeakNode:update(interval)
local npcid=self:getData('npcid')
local duration=self:getData('duration')or 0

local guid=storyAIManager:getStoryBTBlackBoard(npcid)
if guid then
self:setSpeakContent(guid)
if duration~=0 then
if not self.isSpeaking then
self.isSpeaking=true
self.endSpeakTime=os.time()+duration
end

if self.isSpeaking then
if os.time()>=self.endSpeakTime then
self.isSpeaking=false
self:shutUp(guid)
return nodeState.success
else
return nodeState.running
end
end
else
return nodeState.success
end
end
return nodeState.failure
end

function storySpeakNode:reset()
storySpeakNode._base.reset(self)
local npcid=self:getData('npcid')
if npcid then
local guid=storyAIManager:getStoryBTBlackBoard(npcid)
self:shutUp(guid)
self.isSpeaking=false
end
end

function storySpeakNode:setSpeakContent(guid)
local content=self:getData('content')
local skin=self:getData('skin')or 1
local cusOffset=self:getData('offset')
local scale=self:getData('scale')
local hudId=self:getSharedVar(FMT.fmt('hudIdSpeak_{0}',guid))
if guid and hudId==nil then
local offset=_MapManager.GetObjectHeadOffset(guid)
if cusOffset then
offset.x=offset.x+cusOffset[1]or 0
offset.y=offset.y+cusOffset[2]or 0
end
self.sLoadId=hudControl:addHUD(INSTANCE_TYPE.eDiscipleSpeak,guid,offset,true,true,function(id)
if self.sLoadId==id then
hudId=id
local widget=hudControl:getHUDWidget(hudId)
widget:SetChildText(0,chatEmotHelper.decodeEmot(content))
local abName,skinName=discipleStateManager:getSpeakSkinInfoById(skin)
widget:SetChildCSImageSprite(1,abName,skinName)

self:setSharedVar(FMT.fmt('hudIdSpeak_{0}',guid),hudId)
hudControl:changeContainer(hudId,1)
if scale then
widget:SetChildScale(-1,Vector3.one*scale)
end
else
hudControl:removeHUD(id)
end
end)
end
end

function storySpeakNode:shutUp(guid)
self.sLoadId=nil
if guid then
local hudId=self:getSharedVar(FMT.fmt('hudIdSpeak_{0}',guid))
if hudId then
hudControl:removeHUD(hudId)
self:setSharedVar(FMT.fmt('hudIdSpeak_{0}',guid))
end
end
end

function storySpeakNode:skip()
local npcid=self:getData('npcid')
local guid=storyAIManager:getStoryBTBlackBoard(npcid)
if guid then
self:shutUp(guid)
end
return nodeState.success
end