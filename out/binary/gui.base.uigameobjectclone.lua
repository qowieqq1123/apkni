





UIGameobjectClone=simple_class(UIObject)


function UIGameobjectClone:setCreatAction(action)
self._creatAction=action
end



function UIGameobjectClone:setRefreshAction(action)
self._freshAction=action
end


function UIGameobjectClone:_setRefreshAction(action)
self.__owner.widget:SetRefreshFinishActionByClonePool(self.__id,action)
end


function UIGameobjectClone:_setCreatAction(action)
self.__owner.widget:SetLoadFinishActionByClonePool(self.__id,action)
end


function UIGameobjectClone:createItem(abName,assetName,parentIdx,order,xpos,ypos,attach,delay,loadActive)
if loadActive==nil then loadActive=true end
return self.__owner.widget:CreatItemByClonePool(self.__id,abName,assetName,parentIdx,order,xpos,ypos,attach,delay,loadActive)
end


function UIGameobjectClone:activeList(luaidList)
local luaStr=table.concat(luaidList,',')
self.__owner.widget:SetItemsActiveByClonePool(self.__id,luaStr)
end

function UIGameobjectClone:freshItemsSibling()
self.__owner.widget:SetItemsSiblingByClonePool(self.__id)
end


function UIGameobjectClone:deleteItem(prefabid)
if self.__owner and self.__owner.widget then
self.__owner.widget:DeleteItemByClonePool(self.__id,prefabid)
end
end


function UIGameobjectClone:deleteItemByLuaid(luaid)
if self.__owner and self.__owner.widget then
self.__owner.widget:DeleteItemByClonePoolByAttach(self.__id,luaid)
end
end


function UIGameobjectClone:getItemObj(prefabid)
return self.__owner.widget:GetItemByClonePool(self.__id,prefabid)
end


function UIGameobjectClone:getItemWidget(prefabid)
return self.__owner.widget:GetItemWidgetByClonePool(self.__id,prefabid)
end

function UIGameobjectClone:init()
self.__luaObjects={}
self.__luaidQueue={}
self._creatAction=nil
self._freshAction=nil
self.__maxNum=nil
self._configList={}
self:_setCreatAction(function(...)self:onCreatChildItem(...)end)
self:_setRefreshAction(function(...)self:onFreshChildItem(...)end)
end

function UIGameobjectClone:setMaxNum(num)
self.__maxNum=num
end




function UIGameobjectClone:createObjectList(configList)
self:recycleAll()
local temp={}

for i,v in ipairs(configList or{})do
local luaid=self:createLuaObject(v.name,
v.parentIdx,
v.order,
v.xpos,
v.ypos,
v.delay,
true,
v.args)
v._index=i
v.luaid=luaid
self._configList[#self._configList+1]=v
temp[#temp+1]=luaid
end


for i,luaid in ipairs(temp)do
local luaobject=self:getLuaObject(luaid)
luaobject:createItem()
end
end


function UIGameobjectClone:createObject(name,parentIdx,order,args,loadActive)
if loadActive==nil then loadActive=true end
local luaid=self:createLuaObject(name,parentIdx,order,0,0,0,loadActive,args)
if luaid==nil then return end
local luaObject=self.__luaObjects[luaid]
luaObject:createItem()
return luaid
end


function UIGameobjectClone:createLuaObject(name,parentIdx,order,xpos,ypos,delay,loadActive,args)
if order==nil then order=0 end
if xpos==nil then xpos=0 end
if ypos==nil then ypos=0 end
if delay==nil then delay=0 end
if loadActive==nil then loadActive=true end
self:recycleOverItem()
local luaObject=UICloneObject.get(name,self,parentIdx,order,xpos,ypos,delay,loadActive,args)
local luaid=luaObject:getId()
if luaid==nil then
loggerUtil.logErrFMT("luaid为空 name:{0}",name)
return
end
if self.__luaObjects[luaid]then
loggerUtil.logErrFMT("{0}已存在数据：",luaid)
end
self.__luaObjects[luaid]=luaObject
self:addQueue(luaid)
return luaid
end

function UIGameobjectClone:getLuaObject(luaid)
return self.__luaObjects[luaid]
end

function UIGameobjectClone:callChildFunc(luaid,funcname,...)
local luaObject=self.__luaObjects[luaid]
if luaObject and luaObject[funcname]then
return luaObject[funcname](luaObject,...)
end
end

function UIGameobjectClone:callWinFunc(funcname,...)
return self.__owner[funcname](self.__owner,...)
end

function UIGameobjectClone:callAllChildFunc(funcname)
for luaid,luaObject in pairs(self.__luaObjects)do
if luaObject and luaObject[funcname]then
luaObject[funcname](luaObject)
end
end
end


function UIGameobjectClone:onCreatChildItem(assetName,prefabid,luaid)
if prefabid==-1 then
if assetName and assetName~=''then
loggerUtil.logErrFMT('创建失败：{0}',assetName)
else

end
return
end
local luaObject=self.__luaObjects[luaid]
local widget=self:getItemWidget(prefabid)
if luaObject==nil or widget==nil then
self:deleteItem(prefabid)
self:removeQueue(luaid)

return
end
luaObject:onCreatFinish(luaid,assetName,prefabid,widget)
if self._creatAction then
self._creatAction(assetName)
end
end

function UIGameobjectClone:onFreshChildItem(assetName,prefabid,luaid)
if luaid==nil then return end
local luaObject=self.__luaObjects[luaid]
if luaObject==nil then

return
end

local widget=self:getItemWidget(prefabid)
luaObject:onFreshFinish(luaid,assetName,prefabid,widget)
if self._freshAction then
self._freshAction(assetName,prefabid,luaid)
end
end

function UIGameobjectClone:removeConfig(luaid)
for i,v in ipairs(self._configList)do
if v.luaid==luaid then
table.remove(self._configList,i)
break
end
end
end

function UIGameobjectClone:removeQueue(luaid)
if self.__luaidQueue==nil then return end
table.removeValue(self.__luaidQueue,luaid)
end

function UIGameobjectClone:addQueue(luaid)
if self.__luaidQueue==nil then self.__luaidQueue={}end
local list=self.__luaidQueue
if table.removeValue(list,luaid)then
loggerUtil.logErrFMT('预制尚未回收/删除又重复启用')
end
list[#list+1]=luaid
end


function UIGameobjectClone:getAliveNum()
if self.__luaidQueue==nil then return 0 end
return#self.__luaidQueue
end

function UIGameobjectClone:getConfigList()
return self._configList
end

function UIGameobjectClone:deQueue()
if self.__luaidQueue==nil then return end
local list=self.__luaidQueue
if#list>0 then
return table.remove(list,1)
end
end



function UIGameobjectClone:notifyRecycle(luaid)
for _,luaObject in pairs(self.__luaObjects)do
if luaObject and luaObject.onRecycle and luaObject:hasObj()then
luaObject:onRecycle(luaid)
end
end
end



function UIGameobjectClone:recycleOverItem()
if self.__maxNum then
local aliveNum=self:getAliveNum()
if aliveNum>=self.__maxNum then
local luaid=self:deQueue()
local luaObject=self.__luaObjects[luaid]
self:recycleItem(luaObject)
end
end
end

function UIGameobjectClone:recycleAll()
for luaid,luaObject in pairs(self.__luaObjects)do
if luaObject and UICloneObject.release(luaObject)then
luaObject=nil
end
end
self.__luaObjects={}
self.__luaidQueue={}
self._configList={}
end

function UIGameobjectClone:releaseLua(luaid)
self.__luaObjects[luaid]=nil
self:removeQueue(luaid)
end


function UIGameobjectClone:recycleItem(luaObject)
if luaObject then
local luaid=luaObject:getId()
if UICloneObject.release(luaObject)then
luaObject=nil
end
if luaid==nil then return end
self.__luaObjects[luaid]=nil
self:removeQueue(luaid)
self:removeConfig(luaid)
self:notifyRecycle(luaid)
end
end

function UIGameobjectClone:recycleItemById(luaid)
local luaObject=self.__luaObjects[luaid]
if luaObject then
if UICloneObject.release(luaObject)then
luaObject=nil
end
end
self.__luaObjects[luaid]=nil
self:removeQueue(luaid)
self:removeConfig(luaid)
self:notifyRecycle(luaid)
end

function UIGameobjectClone:__delete()
self:recycleAll()
self:_setCreatAction(nil)
self:_setRefreshAction(nil)
self._creatAction=nil
self._freshAction=nil
self.__maxNum=nil
end
