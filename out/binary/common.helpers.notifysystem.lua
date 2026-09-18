






notifySystem={}


local _notify_listeners={}
local _notify_interal={}
local _post_delay_timer=nil
local _notify_queue={}
local _t_remove=table.remove
local _callback_timer
local _callback_queue={}



function notifySystem:init()

end


function notifySystem:leave()

end


function notifySystem:registerInternalNotify(notify_id)
_notify_interal[notify_id]=true
end

local function do_notify_queue()
local front=_notify_queue[1]
if front==nil then
_post_delay_timer:cancel()
_post_delay_timer=nil
return
end

notifySystem:postNotify(front[1],unpack(front[2]))
_t_remove(_notify_queue,1)
end


function notifySystem:postNotify(notify_id,...)
if notifyInitConfig[notify_id]and not initProControl.isDone()then
loggerUtil.logWarnFMT('notify={0}不能在初始化前派发，直接抛弃',notifyConfig_list[notify_id])
return
end
local notify=_notify_listeners[notify_id]
if notify then
local remove_i=nil






for i,v in ipairs(notify)do
if v.cb~=nil then
xpcall(v.cb,function(err)
logErr('listen Notify err:',err)
end,...)
else
remove_i=i
end
end

if remove_i then
_t_remove(notify,remove_i)
end



end

end


function notifySystem:postNotifyDelay(notify_id,...)
local notify=_notify_listeners[notify_id]
if notify then
if _post_delay_timer==nil then
_post_delay_timer=timer.new()
_post_delay_timer:start(0,do_notify_queue)
end

_notify_queue[#_notify_queue+1]={notify_id,{...}}
end
end





function notifySystem:listenNotify(notify_id,func)
local notify=_notify_listeners[notify_id]
if not notify then
notify={}
_notify_listeners[notify_id]=notify
else
for i,v in ipairs(notify)do
if v.cb==func then
return
end
end
end
notify[#notify+1]={cb=func}
end


function notifySystem:removelistener(event_id,func)
local event=_notify_listeners[event_id]
if not event then
return
end

for i,v in ipairs(event)do
if v.cb==func then
v.cb=nil
break
end
end
end


function notifySystem:cleanup()
for notify_id,notify in pairs(_notify_listeners)do
if not _notify_interal[notify_id]then
_notify_listeners[notify_id]=nil
end
end
notifySystem.isPostNotify=0
end



local function do_callback_queue()
local front=_callback_queue[1]
if front==nil then
_callback_timer:cancel()
_callback_timer=nil
return
end
local v=front[1]
if v.f then
v.f(unpack(front[2]))
end
_t_remove(_callback_queue,1)
end

function notifySystem:postNotifyQueue(notify_id,...)
local notify=_notify_listeners[notify_id]
if notify then
if not _callback_timer then
_callback_timer=timer.new()
_callback_timer:start(0,do_callback_queue)
end
local remove_i=nil
for i,v in ipairs(notify)do
if v.f then
_callback_queue[#_callback_queue+1]={v,{...}}
else
remove_i=i
end
end
if remove_i then
table.remove(notify,remove_i)
end
end
end
