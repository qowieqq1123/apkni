






listenerBase=simple_class()

function listenerBase:__init(addCallback,removeCallback)
self._listeners={}
end

function listenerBase:listen(id,func)

if not func then
assert(false,id)
return
end
self._listeners[id]=func
addCallback(id,func)
end

function listenerBase:removeAll()
for k,v in ipairs(self._listeners)do
removeCallback(k,v)
end
self._listeners={}
end
