






storyMysteryEventNode=simple_class(baseNode)

function storyMysteryEventNode:start()
storyMysteryEventNode._base.start(self)
self.event_finish=function(sysId,guid,groupId)
if self.sysId==sysId and self.groupId==groupId then
self.waiting=false
self.bComplete=true
self:quicklyTick()
baseFullScreenUI:openMain(false)
end
end
end

function storyMysteryEventNode:init()
self.waiting=false
self.bComplete=false
end

function storyMysteryEventNode:broke()
self:removedEventlisten()
end

function storyMysteryEventNode:addEventlisten()
notifySystem:listenNotify(notifyConfig.on_mystery_event_finish,self.event_finish)
end

function storyMysteryEventNode:removedEventlisten()
notifySystem:removelistener(notifyConfig.on_mystery_event_finish,self.event_finish)
end

function storyMysteryEventNode:update(interval)
if self.waiting then
return nodeState.running
end

if self.bComplete then
self:removedEventlisten()
return nodeState.success
end

self.sysId=self:getData('sysId')
self.groupId=self:getData('groupId')
self.isNotFullOpen=self:getData('isNotFullOpen')

MysteryEventSystem.event_start(self.sysId,self.groupId,nil,nil,self.isNotFullOpen==1)

self.waiting=true
self.bComplete=false
self:addEventlisten()
return nodeState.running
end