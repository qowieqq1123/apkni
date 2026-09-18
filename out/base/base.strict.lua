








local skip_strict_what={
['C']=true,
['main']=true
}


local skip_strict_name={
['def_class']=true,
['def_table']=true,
['def_interface']=true,
}


local _if_strict=true
function strict_if_strict(if_strict)
_if_strict=if_strict
end


local getinfo,error,rawset,rawget=debug.getinfo,error,rawset,rawget
local _private_G={}
local mt=getmetatable(_G)
if mt==nil then
mt={}
setmetatable(_G,mt)
end


mt.__declared={}


local function what()
local d=getinfo(3,"Sn")
if not d then
d={}
d.source='unknown'
d.lastlinedefined=0
d.what='C'
elseif d.what==nil then
d.what='C'
end
return d.what,d
end


mt.__newindex=function(t,n,v)
if not _if_strict then
rawset(_G,n,v)
return
end



local _trace=mt.__declared[n]
if not _trace then
local w,d=what()
if not skip_strict_what[w]and not skip_strict_name[d.name]then
error(string.format("assign to undeclared variable %q from function %q",n,d.name),2)
end
mt.__declared[n]=d

elseif _if_strict then

local s=string.format("modify global is not allowed \'%s\' %s %d",n,_trace.source,_trace.lastlinedefined)
error(s,2)
end
rawset(_private_G,n,v)
end


mt.__index=function(t,n)
if not _if_strict then
return rawget(_private_G,n)
end


if not mt.__declared[n]and what()~="C"then
error("variable '"..n.."' is not declared",2)
end
return rawget(_private_G,n)
end


function private_G()
return _private_G
end

