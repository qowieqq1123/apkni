





refObject=simple_class({})


function refObject:__init(name,key)
self:__create(name,key)
end

function refObject:init(...)

end

function refObject:__create(name,key)
self.__ref=1
self.__name=name
self.__key=key
if self.__guid==nil then self.__guid=key end
end

function refObject:getName()
return self.__name
end

function refObject:getRef()
return self.__ref
end

function refObject:getguid()
return self.__guid
end

function refObject:getkey()
return self.__key
end

function refObject:onRelease()
self.__key=nil
self.__ref=0
end

function refObject:retain()
self.__ref=self.__ref+1
end

function refObject:isAliveSelf(guid,key)
return self.__key==key and self.__guid==guid
end

function refObject:isRelease(guid,key)
return self.__key~=key and self.__guid==guid
end

function refObject.releaseChild(ref)
if ref._baseList then
local _size=#ref._baseList
for i=_size,1,-1 do
local releaseFunc=ref._baseList[i].onRelease
if releaseFunc then
releaseFunc(ref)
end
end
end
end

function refObject.initChild(ref,...)
if ref._base and ref._base.init then
ref._base.init(ref,...)
end
end


local UIObjectPool={}
local UIObjectPoolMaxCount=256
local table_remove=table.remove
local UIObject_create=refObject.__create
local key=0

function refObject.get(name,...)

key=key+1
if UIObjectPool[name]and#UIObjectPool[name]>0 then
local top=table_remove(UIObjectPool[name])
if top then
UIObject_create(top,name,key)
top:init(...)
return top
end
end
local src=refSrcConfig[name]
if src==nil then
loggerUtil.logErrFMT('尚未配置{0}脚本路径',name)
return
end
local ctor=refObject.PreloadCtor(name,src)
local obj=ctor(name,key)
obj:init(...)
return obj
end

function refObject.getX(name,...)

key=key+1
if UIObjectPool[name]and#UIObjectPool[name]>0 then
local top=table_remove(UIObjectPool[name])
if top then
UIObject_create(top,name,key)
top:initChild()
top:init(...)
return top
end
end
local src=refSrcConfig[name]
if src==nil then
loggerUtil.logErrFMT('尚未配置{0}脚本路径',name)
return
end
local ctor=refObject.PreloadCtor(name,src)
local obj=ctor(name,key)
obj:initChild()
obj:init(...)
return obj
end




function refObject.release(o,force)
if o==nil then return end
local name=o:getName()
if name==nil then return end
o.__ref=o.__ref-1
if o.__ref>1 and not force then
return
end
if UIObjectPool[name]and#UIObjectPool[name]>UIObjectPoolMaxCount then return end
o:releaseChild()
if o:onRelease()then
o=nil
end
if o==nil then return end
if UIObjectPool[name]==nil then UIObjectPool[name]={}end
UIObjectPool[name][#UIObjectPool[name]+1]=o
end



local _ctor={}

local function _PreloadCtor(creator,src)

local ctor=_ctor[creator]
if ctor==nil then
require(src)
ctor=_G[creator]
_ctor[creator]=ctor
end
return ctor
end
























refObject.PreloadCtor=_PreloadCtor
