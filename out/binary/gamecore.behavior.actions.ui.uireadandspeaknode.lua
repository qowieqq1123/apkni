
UIReadAndSpeakNode=simple_class(baseNode)

function UIReadAndSpeakNode:start()
local dtime=3
if self.data then
self.speakTime=self.data.speakTime or dtime
else
self.speakTime=dtime
end
end

function UIReadAndSpeakNode:update(interval)
if self.isSpeaking then
if os.time()>=self.endSpeakTime then
self:shutUp()
return nodeState.success
end
return nodeState.running
end
local args=self:getArgs()
local win=args.win
if win then
win:ai_speak(self.owner.uid)
self.isSpeaking=true
self.endSpeakTime=os.time()+self.speakTime
return nodeState.running
else
return nodeState.failure
end
end

function UIReadAndSpeakNode:reset()
UIReadAndSpeakNode._base.reset(self)
if self.isSpeaking then
self:shutUp()
end
end

function UIReadAndSpeakNode:broke()
self:shutUp()
end

function UIReadAndSpeakNode:shutUp()
self.isSpeaking=false
local args=self:getArgs()
local win=args.win
if win then
win:ai_shutup(self.owner.uid)
end
end

function UIReadAndSpeakNode:skip()
self:shutUp()
return nodeState.success
end
