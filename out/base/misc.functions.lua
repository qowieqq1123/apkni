local require=require
local string=string
local table=table

int64.zero=int64.new(0,0)
uint64.zero=uint64.new(0,0)

function string.split(input,delimiter)
input=tostring(input)
delimiter=tostring(delimiter)
if(delimiter=='')then return false end
local pos,arr=0,{}

for st,sp in function()return string.find(input,delimiter,pos,true)end do
table.insert(arr,string.sub(input,pos,st-1))
pos=sp+1
end
table.insert(arr,string.sub(input,pos))
return arr
end

function import(moduleName,currentModuleName)
local currentModuleNameParts
local moduleFullName=moduleName
local offset=1

while true do
if string.byte(moduleName,offset)~=46 then
moduleFullName=string.sub(moduleName,offset)
if currentModuleNameParts and#currentModuleNameParts>0 then
moduleFullName=table.concat(currentModuleNameParts,".").."."..moduleFullName
end
break
end
offset=offset+1

if not currentModuleNameParts then
if not currentModuleName then
local n,v=debug.getlocal(3,1)
currentModuleName=v
end

currentModuleNameParts=string.split(currentModuleName,".")
end
table.remove(currentModuleNameParts,#currentModuleNameParts)
end

return require(moduleFullName)
end


function reimport(name)
local package=package
package.loaded[name]=nil
package.preload[name]=nil
return require(name)
end

function createTableWithPlaceHolder(input,main_table)

local data={}
local data_meta={
__index=function(t,k)
return rawget(input,k)
end,
__newindex=function(t,k,v)
error('PlaceHolderData is readonly')
end
}

setmetatable(data,data_meta)


main_table=main_table or{}
local main_table_meta=
{
__index=function(t,k)
return data
end
}
setmetatable(main_table,main_table_meta)

return main_table
end








function table.runtimeData(config_get_func,runtimeData,placeholder)

local data_id={}

local data_meta={
__index=function(t,k)

local id=rawget(t,data_id)

local config=config_get_func(id)
return config[k]
end
}

runtimeData=runtimeData or{}


local set_func=function(t,k,v)
if v~=nil then
setmetatable(v,data_meta)

rawset(v,data_id,k)
end

rawset(t,k,v)
end



local runtimeData_meta={
__newindex=function()
error('use set instead')
end
}

local lookup={set=set_func}


if placeholder then

local placeholder_proxy={}
local placeholder_proxy_meta={

__newindex=function(t,k,v)
error('data is readonly')
end,

__index=function(t,k)
return rawget(placeholder,k)
end
}

setmetatable(placeholder_proxy,placeholder_proxy_meta)


runtimeData_meta.__index=function(t,k)
local l=rawget(lookup,k)
if l then
return l
end
return placeholder_proxy
end
else
runtimeData_meta.__index=lookup
end



setmetatable(runtimeData,runtimeData_meta)

return runtimeData
end
































function table.runtimeDataFromConfig(config_get_func,data_init_func)
local _data={}
local _data_meta={
__index=function(t,k)
local ret=rawget(t,k)
if ret then
return ret
end
ret=config_get_func(k)
ret=data_init_func(ret)
rawset(t,k,ret)
return ret
end
}
setmetatable(_data,_data_meta)
return _data
end
