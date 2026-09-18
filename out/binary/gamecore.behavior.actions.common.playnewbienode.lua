





playNewbieNode=simple_class(baseNode)

function playNewbieNode:start()
playNewbieNode._base.start(self)
self.event_finish=function(id,flag)
if flag==false and id==NEWBIE_LUA_FUNC_TYPE[self.playKey]then
self.waiting=false
self.bComplete=true
self:quicklyTick()
end
end
end

function playNewbieNode:init()
self.waiting=false
self.bComplete=false
end

function playNewbieNode:broke()
self:removedEventlisten()
end

function playNewbieNode:addEventlisten()
notifySystem:listenNotify(notifyConfig.inNewbie,self.event_finish)
end

function playNewbieNode:removedEventlisten()
notifySystem:removelistener(notifyConfig.inNewbie,self.event_finish)
end

function playNewbieNode:update(interval)
if self.waiting then
return nodeState.running
end

if self.bComplete then
self:removedEventlisten()
return nodeState.success
end

self.playKey=self:getData('key')
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME[self.playKey])

self.waiting=true
self.bComplete=false
self:addEventlisten()
return nodeState.running
end