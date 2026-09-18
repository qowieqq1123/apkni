




UICloneObject=simple_class(UIWidgetBase)


function UICloneObject:__init(name,id,creater,parentIdx,order,xpos,ypos,delay,loadActive,args)
assert(self.assetName)
assert(self.abName)
self.__name=name
if self.__guid==nil then self.__guid=id end
self:init(id,creater,parentIdx,order,xpos,ypos,delay,loadActive,args)
end

function UICloneObject:init(id,creater,parentIdx,order,xpos,ypos,delay,loadActive,args)
self.__id=tostring(id)
self.isClose=nil
self.__isPause=nil
self:setInfo(creater,parentIdx,order,xpos,ypos,delay,loadActive,args)
end

function UICloneObject:createItem()
if not self:hasObj()then
self.__creater:createItem(self.abName,self.assetName,self.__parentIdx,self.__order,self.__xpos,self.__ypos,self.__id,self.__delay,self.__loadActive)
else
self:freshItem()
end
end

function UICloneObject:getId()
return self.__id
end

function UICloneObject:isLastItem()
local luaid=self:getId()
local configList=self.__creater:getConfigList()
if#configList==0 then return false end
local luaObjet=configList[#configList]
return luaObjet.luaid==luaid
end

function UICloneObject:getCreater()
return self.__creater
end

function UICloneObject:setInfo(creater,parentIdx,order,xpos,ypos,delay,loadActive,args)
self.__creater=creater
self.__parentIdx=parentIdx
self.__order=order
self.__xpos=xpos
self.__ypos=ypos
self.__delay=delay
self.__args=args
self.__loadActive=loadActive
end

function UICloneObject:setAssetInfo(abName,assetName)
self.abName=abName
self.assetName=assetName
end

function UICloneObject:getParent()
return self.__parentIdx,self.__order
end

function UICloneObject:getArgs()
return self.__args
end

function UICloneObject:setName(name)
self.__name=name
end


function UICloneObject:getName()
return self.__name
end

function UICloneObject:getWidget()
return self.widget
end

function UICloneObject:setWidget(widget)
self.widget=widget
end

function UICloneObject:isLoadActive()
return self.__loadActive
end

function UICloneObject:setCreater(creater)
self.__creater=creater
end

function UICloneObject:setArgs(args)
self.__args=args
end

function UICloneObject:setArgsKeyVal(key,val)
if self.__args==nil then
loggerUtil.logErrFMT('使用刷新方法设置参数{0}错误',key)
return
end
self.__args[key]=val
end


function UICloneObject:hasObj()
return self.__prefabid~=nil
end

function UICloneObject:getPrefabid()
return self.__prefabid
end

function UICloneObject:recycleSelf()
if self.__creater==nil then return end
self.__creater:recycleItem(self)
end


function UICloneObject:recycleObj()

if self.__creater==nil then return end

self.__creater:deleteItemByLuaid(self.__id)







end

function UICloneObject:onCreatFinish(luaid,assetName,prefabid,widget)
if luaid==self.__id then
self.__prefabid=prefabid
self.widget=widget
if widget==nil then
loggerUtil.logErrFMT('没有找到widget {0}',self.__name)
end
if self.onLoaded then
self:onLoaded()
end
self.__delete__=false
self:freshItem()
else

end
end


function UICloneObject:onFreshFinish(luaid,assetName,prefabid,widget)
if luaid==self.__id then
if widget==nil then
loggerUtil.logErrFMT('没有找到widget {0}',self.__name)
end
if self.onFreshed then
self:onFreshed()
end
end
end

function UICloneObject:freshItem()
if self.onShow then
self:onShow(self.__args)
end
end


function UICloneObject:delayDo(delay,func)
return self:setTimer(delay,1,func)
end



function UICloneObject:setTimer(delay,count,func)
if count==0 then count=-1 end
if self.__timer==nil then self.__timer={}end
if self.__timerid==nil then self.__timerid=0 end
self.__timerid=self.__timerid+1
local timerid=self.__timerid
self.__timer[timerid]=timer.new()
self.__timer[timerid]:start(delay,func,count)
return timerid
end

function UICloneObject:stopTimerByID(timerid)
if self.__timer==nil then return end
local oldtimer=self.__timer[timerid]
if oldtimer then
oldtimer:cancel()
end
end

function UICloneObject:stopAllTimer()
if self.__timer==nil then return end
for _,oldtimer in pairs(self.__timer)do
oldtimer:cancel()
end
self.__timer={}
end

function UICloneObject:pauseAllTimers()
if self.__isPause then return end
self.__isPause=true
if self.__timer==nil then return end
for _,v in pairs(self.__timer)do
if v then
v:pause()
end
end
end

function UICloneObject:continueAllTimers()
if not self.__isPause then return end
self.__isPause=nil
if self.__timer==nil then return end
for _,v in pairs(self.__timer)do
if v then
v:continue()
end
end
end

function UICloneObject:pauseTimerByID(timerid)
if self.__timer==nil then return end
local oldtimer=self.__timer[timerid]
if oldtimer then
oldtimer:pause()
end
end

function UICloneObject:continueTimerByID(timerid)
if self.__timer==nil then return end
local oldtimer=self.__timer[timerid]
if oldtimer then
oldtimer:continue()
end
end


function UICloneObject:onReConnection()

end

function UICloneObject:onReConnectionEx()
self:continueAllTimers()
self:onReConnection()
end


function UICloneObject:onLostConnection()

end

function UICloneObject:onLostConnectionEx()
self:pauseAllTimers()
self:onLostConnection()
end

function UICloneObject:addProNotify(sid,pid,func)
if self.__protocolregister==nil then self.__protocolregister={}end
if self.__protocolregister[sid]==nil then self.__protocolregister[sid]={}end
if self.__protocolregister[sid][pid]==nil then self.__protocolregister[sid][pid]={}end
if self.__protocolregisterOgi==nil then self.__protocolregisterOgi={}end
if self.__protocolregisterOgi[sid]==nil then self.__protocolregisterOgi[sid]={}end
if self.__protocolregisterOgi[sid][pid]==nil then self.__protocolregisterOgi[sid][pid]={}end
local t1=self.__protocolregisterOgi[sid][pid]
if t1[func]==true then return end
t1[func]=true

local t=self.__protocolregister[sid][pid]
local newfunc=function(...)
if not self or self.isClose or self.__isPause then return end
func(...)
end
t[#t+1]=newfunc
socketManager:addNotify(sid,pid,newfunc)
end

function UICloneObject:addNotify(id,func)
if self.__register==nil then self.__register={}end
if self.__register[id]==nil then self.__register[id]={}end
if self.__registerOgi==nil then self.__registerOgi={}end
if self.__registerOgi[id]==nil then self.__registerOgi[id]={}end
local t1=self.__registerOgi[id]
if t1[func]==true then return end
t1[func]=true

local t=self.__register[id]
local newfunc=function(...)
if not self or self.isClose then return end
func(...)
end
t[#t+1]=newfunc
notifySystem:listenNotify(id,newfunc)
end

function UICloneObject:addReddotNotify(id,func)
if self.__registerReddot==nil then self.__registerReddot={}end
if self.__registerReddot[id]==nil then self.__registerReddot[id]={}end
if self.__registerReddotOgi==nil then self.__registerReddotOgi={}end
if self.__registerReddotOgi[id]==nil then self.__registerReddotOgi[id]={}end
local t1=self.__registerReddotOgi[id]
if t1[func]==true then return end
t1[func]=true

local t=self.__registerReddot[id]
local newfunc=function(...)
if not self or self.isClose or self.__isPause then return end
func(...)
end
t[#t+1]=newfunc
reddotClassManager.register_event(id,newfunc)
end

function UICloneObject:stopAllReddotNotify()
if self.__registerReddot then
for k,v in pairs(self.__registerReddot)do
for _,func in ipairs(v)do
reddotClassManager.unregister_event(k,func)
end
end
end
self.__registerReddot=nil
self.__registerReddotOgi=nil
end

function UICloneObject:onRelease()
self.isClose=true
self.__isPause=nil
if self.__timer then
for _,v in pairs(self.__timer)do
if v then
v:cancel()
end
end
end
self.__timer=nil
if self.__delete and self.__delete__==false then
self:__delete()
end
self.__delete__=true
self:recycleObj()
if self.__creater and self.__id then
self.__creater:releaseLua(self.__id)
end
self.__id=nil
self.__creater=nil
self.__prefabid=nil
self.abName=nil
self.assetName=nil
self.__parentIdx=nil
self.__order=nil
self.widget=nil
self.__args=nil
self.__xpos=nil
self.__ypos=nil
self.__delay=0
self.__loadActive=true

if self.__register then
for id,v in pairs(self.__register)do
for _,func in ipairs(v)do
notifySystem:removelistener(id,func)
end
end
end
self.__register={}
self.__registerOgi={}

if self.__protocolregister then
for sid,v in pairs(self.__protocolregister)do
for pid,func in ipairs(v)do
socketManager:removeNotify(sid,pid,func)
end
end
end
self.__protocolregister=nil
self.__protocolregisterOgi=nil

self:stopAllReddotNotify()
end




local UIObjectPool={}
local _objectList={}
local UIObjectPoolMaxCount=32
local table_remove=table.remove
local UIObject_init=UICloneObject.init
local _numList={}
local id=0

function UICloneObject.get(name,...)

id=id+1
local useReload=false









local assetNamePool=UIObjectPool[name]
if not useReload and assetNamePool and#assetNamePool>0 then
local top=table_remove(assetNamePool)
if top then
UIObject_init(top,id,...)
return top
end
end
local info=UIWidgetConfig[name]
if info==nil then
logErr(FMT.fmt('UIWidgetConfig没找到{0}的信息',name))
end
UICloneObject.PreloadCtor(info)
local ctor=info.ctor
local object=ctor(name,id,...)
_objectList[object.__guid]=object
_numList[name]=(_numList[name]or 0)+1

return object
end


function UICloneObject.release(o)
if o==nil then return true end
local id=o.__guid
local name=o:getName()
if _objectList[id]then
_objectList[id]=nil
_numList[name]=(_numList[name]or 0)-1

end
o:onRelease()
if UIObjectPool[name]==nil then UIObjectPool[name]={}end
local assetNamePool=UIObjectPool[name]
if#assetNamePool>UIObjectPoolMaxCount then return true end
assetNamePool[#assetNamePool+1]=o
return false

end

function UICloneObject.callAllFunction(func,...)
for k,v in pairs(_objectList)do
if v and v[func]then
v[func](v,...)
end
end
end


local _ctor={}
local _reloadStamp={}
local function _PreloadCtor(info)

local src=info.src
local ctor=_ctor[info.creator]
if ctor==nil then
require(src)
ctor=_G[info.creator]
_ctor[info.creator]=ctor
info.ctor=ctor
end
end

function UICloneObject.getAssetName(name)
local info=UIWidgetConfig[name]
UICloneObject.PreloadCtor(info)
local ctor=info.ctor
return ctor.abName,ctor.assetName
end

































UICloneObject.PreloadCtor=_PreloadCtor
