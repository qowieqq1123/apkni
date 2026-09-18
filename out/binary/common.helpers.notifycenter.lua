






NotifyCenter={}


local LuaEventList={};

local _table_insert=table.insert
local _table_remove=table.remove
local _table_getn=table.getn
local _pairs=pairs





function NotifyCenter:Register(listenner,listenername,functionname)
if(listenner and listenername and functionname)then
local newObserver={listenner=listenner,listenername=listenername,functionname=functionname};
_table_insert(LuaEventList,newObserver);
end
end


function NotifyCenter:UnRegister(listenner,listenername)

local index=_table_getn(LuaEventList);
while(index>0)do
local observer=LuaEventList[index];

if(listenner==observer.listenner)then
if(listenername==nil or observer.listenername==listenername)then
_table_remove(LuaEventList,index);
end
end
index=index-1;
end
end

function NotifyCenter:ClearAll()
LuaEventList=nil;LuaEventList={};
end


function NotifyCenter:FindNotify(listenername)

for index,observer in _pairs(LuaEventList)do
if(observer.listenername==listenername)then return observer;end
end

return nil;
end




function NotifyCenter:PostNotify(listenername,...)

for index,observer in ipairs(LuaEventList)do

if observer.listenername==listenername then
observer.functionname(...);
end
end
end
