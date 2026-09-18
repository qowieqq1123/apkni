






messageCenter={}
local t_remove=table.remove
local _center={}
function messageCenter.register(sender,funcname)
local redirect=nil
local tmp=sender[funcname]
redirect=function(...)
local ret=tmp(...)
local fl=_center[redirect]
for _,v in ipairs(fl)do
v(ret)
end
end
if _center[redirect]==nil then
_center[redirect]={}
end



sender[funcname]=redirect
end

function messageCenter.add_listener(keyfunc,callback)
local fl=_center[keyfunc]



fl[#fl+1]=callback



end


function messageCenter.remove_listener(keyfunc,callback)
local fl=_center[keyfunc]
for i,v in ipairs(fl)do
if v==callback then
t_remove(fl,i)
break
end
end



end


poster={}
function poster:post_call()

end


























