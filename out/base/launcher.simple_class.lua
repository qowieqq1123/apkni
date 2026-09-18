













local _in_obj_ins_map={}
local _in_obj_ins_id=0

local function _visit_constructor(obj,t)
if obj then
t[#t+1]=obj
end

if obj._base then
_visit_constructor(obj._base,t)
else
return
end
end

local function getinfo()
local info=debug.getinfo(3,"Sl")
return{info.source,info.currentline}
end


function simple_class(base)
local c={}
local _baseList=nil
if type(base)=='table'then

for i,v in pairs(base)do
c[i]=v
end

c._base=base

_baseList={}
_visit_constructor(base,_baseList)
c._baseList=_baseList
end


c.__index=c
c.__init=false
c.__delete=false




local cls_obj_ins_map={}
_in_obj_ins_map[c]=cls_obj_ins_map
setmetatable(cls_obj_ins_map,{__mode='v'})


local mt={}
local newfunc=function(...)
local obj={}
setmetatable(obj,c)

local baseInitFunc
if _baseList then
local _size=#_baseList
for i=_size,1,-1 do
local initFunc=_baseList[i].__init;
if initFunc then
initFunc(obj,...)
end
end
end
if c.__init then
c.__init(obj,...)
end
obj._class=c





_in_obj_ins_id=_in_obj_ins_id+1
cls_obj_ins_map[_in_obj_ins_id]=obj
obj.__instanceID=_in_obj_ins_id
return obj
end
mt.__call=function(v,...)
return newfunc(...)
end
c.new=newfunc
c.New=newfunc
c.is_a=function(self,klass)
local m=getmetatable(self)
while m do
if m==klass then return true end
m=m._base
end
return false
end

c.deleteSelf=function(self)
if self.__deleted__ then
return
end






local _this_class=self._class
while _this_class~=nil do
local deleteFunc=_this_class.__delete;
local baseClass=_this_class._base;
if deleteFunc and(not baseClass or deleteFunc~=baseClass.__delete)then
deleteFunc(self)
end
_this_class=baseClass
end

rawset(self,'__deleted__',true)











end


























setmetatable(c,mt)
return c
end

function instance_info()

















































end

local function copy_interface(resdata,...)
local Interfaces={...};
for i=#Interfaces,1,-1 do
for key,value in pairs(Interfaces[i])do
if resdata[key]~=nil then



else
resdata[key]=value;
end
end
end
return resdata;
end

function create_interface(...)
local child=copy_interface({},...)
function child.new(data)
setmetatable(data,child);
child.__index=child;
return data;
end
return child;
end

local _classes={}
local _interface={}
local _table={}
local _runtime_overload_queue={}
local _runtime_flag=false;
local __generate_methodProxy__='__generate_methodProxy__'
local function generate_methodProxy(name,newclass)
if rawget(newclass,__generate_methodProxy__)then
return
end
rawset(newclass,__generate_methodProxy__,true)

local meta=getmetatable(newclass)
if not meta then
meta={}
setmetatable(newclass,meta)
end
local __methods={}
local __injectLog={}
meta.__newindex=function(t,k,v)
if type(v)=='function'then
local methodProxy=function(...)
local f=rawget(__methods,k,v)
if __injectLog[k]then
logErr(name,k,...)
end
return f(...)
end
rawset(__methods,k,v)
rawset(t,k,methodProxy)
else
rawset(t,k,v)
end
end
newclass.__methods=__methods
newclass.__injectLog=__injectLog
end




function def_class(name,base)
local newclass=simple_class(base)












_classes[name]=newclass
_G[name]=newclass
return newclass
end




function def_interface(name,...)

local newinterface=create_interface(...)










_interface[name]=newinterface
_G[name]=newinterface
return newinterface
end




function def_table(name,newtable)

newtable=newtable or{}










_table[name]=newtable
_G[name]=newtable
return newtable
end

































































