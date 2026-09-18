





































packetDispatcher={}

local _DO_PROTOCOL_FUNC_FORMAT="do_protocol_%d_%d"



function packetDispatcher:init()
packetDispatcher:ignore()
end


function packetDispatcher:ignore()



end


function packetDispatcher:recv_packet(sysid,pid,pack)


local h=protocol_func_map_server[sysid]
if h then
local func=h[pid]
if func then
func(pack)
else

end
else

end

end



local _protocol_control_t={}
function packetDispatcher:register_control(sysid,pid,func)
local cc=_protocol_control_t[sysid]
if not cc then
cc={}
_protocol_control_t[sysid]=cc
end
assert(cc[pid]==nil,string.format('pid already registered %d %d',sysid,pid))

cc[pid]=func
end


function packetDispatcher:dispather(sid,pid,...)

local cc=_protocol_control_t[sid]
if not cc then

return
end
local func=cc[pid]
if not func then

return
end
func(...)
end


function packetDispatcher:send_protocol(prot_id_t,...)

local prot_func=nil
local sysid=prot_id_t[1]or""
local pid=prot_id_t[2]or""
local sys=protocol_func_map_client[sysid]
local prot_func=sys[pid]
if prot_func then

prot_func(...)
else
printError("Can't find the function : ",sysid,pid)
end
end
