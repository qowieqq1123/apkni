






notifyListener=simple_class()

notifyListener={}

function notifyListener.create(class)
class=class or{}
for k,v in pairs(notifyListener)do
class[k]=v
end
return class
end

function notifyListener:__init_notifyListener()
self._listeners={}
end

function notifyListener:listenNotify(id,func)

if not func then
assert(false,id)
return
end
self._listeners[id]=func
notifySystem:listenNotify(id,func)
end

function notifyListener:unlistenNotify(id)

local func=self._listeners[id]
if func then
notifySystem:removelistener(id,func)
self._listeners[id]=nil
end
end

function notifyListener:clearNotify()
if self._listeners~=nil then
for k,v in ipairs(self._listeners)do
notifySystem:removelistener(k,v)
end
end
self._listeners={}
end