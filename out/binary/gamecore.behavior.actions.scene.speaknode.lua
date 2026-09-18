








speakNode=simple_class(baseNode)

function speakNode:reset()
speakNode._base.reset(self)
self.isSpeaking=false
end

function speakNode:broke()
self:removeUI()
end

function speakNode:removeUI()
self.loadId=nil
if self.speakHUD then
hudControl:removeHUD(self.speakHUD)
local args=self:getArgs()
hudControl:setHUDActiveByTarget(args.stId,true)
self.speakHUD=nil
end
end

function speakNode:update(interval)
if self.isSpeaking then
if Time.time>=self.endSpeakTime then
self.isSpeaking=false
self:removeUI()

return nodeState.success
end
return nodeState.running
end
local duration=self:getData('duration')or math.random(self:getData('minDuration'),self:getData('maxDuration'))
local content=self:getData('content')or''
local skin=self:getData('skin')or 1
local args=self:getArgs()
local isChangeContainer=args.isChangeContainer
local offset=_MapManager.GetObjectHeadOffset(args.stId)
self.isSpeaking=true

hudControl:setHUDActiveByTarget(args.stId,false)
self.loadId=hudControl:addHUD(INSTANCE_TYPE.eDiscipleSpeak,args.stId,offset,true,true,function(id)
if self.loadId==id then
self.speakHUD=id
local widget=hudControl:getHUDWidget(self.speakHUD)
widget:SetChildText(0,chatEmotHelper.decodeEmot(content))
local abName,skinName=discipleStateManager:getSpeakSkinInfoById(skin)
widget:SetChildCSImageSprite(1,abName,skinName)

if isChangeContainer then
hudControl:changeContainer(self.speakHUD,1)
end
else
hudControl:removeHUD(id)
end
end)
self.endSpeakTime=Time.time+duration
return nodeState.running
end