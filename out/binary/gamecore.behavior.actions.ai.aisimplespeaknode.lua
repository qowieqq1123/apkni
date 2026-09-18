









aiSimpleSpeakNode=simple_class(baseNode)

function aiSimpleSpeakNode:reset()
aiSimpleSpeakNode._base.reset(self)
self.isSpeaking=false
self.endTime=nil
end

function aiSimpleSpeakNode:broke()
self:clearAll()
end

function aiSimpleSpeakNode:clearAll()
self.loadId=nil
if self.hudId then
hudControl:removeHUD(self.hudId)
self.hudId=nil
end
end

function aiSimpleSpeakNode:update(interval)
if self.isSpeaking then
if os.time()>=self.endTime then
self:clearAll()
return nodeState.success
end
return nodeState.running
end

self.isSpeaking=true
local args=self:getArgs()
local duration=self:getData('duration')or math.random(self:getData('minDuration'),self:getData('maxDuration'))
self.endTime=os.time()+duration
local offset=_MapManager.GetObjectHeadOffset(args.stId)
self.loadId=hudControl:addHUD(INSTANCE_TYPE.eDiscipleSpeak,args.stId,offset,true,true,function(id)
if self.loadId==id then
self.hudId=id
local widget=hudControl:getHUDWidget(self.hudId)
local content=self:getData('content')or''
widget:SetChildText(0,chatEmotHelper.decodeEmot(content))
local skin=self:getData('skin')or 1
local abName,skinName=discipleStateManager:getSpeakSkinInfoById(skin)
widget:SetChildCSImageSprite(1,abName,skinName)
else
hudControl:removeHUD(id)
end
end)
return nodeState.running
end