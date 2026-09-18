function serialize(o,nl,tgap)
local table_concat=table.concat

local string_find=string.find
local string_format=string.format
local t={}
local tab=''
nl=nl or'\n'
tgap=tgap or'    '
local function _serialize(o,tab)
if type(o)=='number'then
t[#t+1]=tostring(o)
elseif tonumber(o)then
if string_find(o,'+')then
t[#t+1]=string_format('%q',o)
else
t[#t+1]=tostring(o)
end
elseif type(o)=='string'then
t[#t+1]=string_format('%q',o)
elseif type(o)=='table'then
t[#t+1]='{'..nl
for k,v in pairs(o)do
if type(k)=='number'then
t[#t+1]=string_format(tab..' [%s]=',k)
else
t[#t+1]=string_format(tab..' [\'%s\']=',k)
end
_serialize(v,tab..tgap)
t[#t+1]=','..nl
end
t[#t+1]=tab..'}'..nl
elseif type(o)=='boolean'then
if o then
t[#t+1]='true'
else
t[#t+1]='false'
end
else
t[#t+1]=tostring(o)
end
end

_serialize(o,tab)

return table_concat(t)
end

local function printcall(t,k,...)
local name=nil
local k='__call';
local pname=rawget(t,'__anyTableName');
if pname then
name=pname..'.'..k
else
name=k
end

return name
end
local meta={
__index=function(t,k)
local name=nil
local pname=rawget(t,'__anyTableName');
if pname then
name=pname..'.'..k
else
name=k
end
local ret=anyTable(name)
rawset(t,k,ret)
return ret
end,
__call=function(t,...)
printcall(t,'__call',...)
return anyTable(name)
end,
__eq=function(t)

printcall(t,'__eq')
return true;
end,
__lt=function(t)

printcall(t,'__lt')
return true;
end,
__le=function(t)

printcall(t,'__le')
return true;
end
}

anyTable=function(name)
local o={__anyTableName=name}
setmetatable(o,meta)
return o;
end

setAnyTable=function(t,name)
local n=anyTable(name)
rawset(t,name,n)
end

argPrint=function(...)


end


