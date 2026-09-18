







def_class("UIWorldBillBoardWin",UIWindowBase)









function UIWorldBillBoardWin:bindComponents()

self.root=UIObject.get(self,0)
self.creator=UIGameobjectClone.new(self,1)



end


function UIWorldBillBoardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
self.creator:deleteSelf();self.creator=nil;
end
















local _Components={}
local _this=nil



function UIWorldBillBoardWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.onAddBillBoard,self.onAddData)
notifySystem:listenNotify(notifyConfig.onRemoveBillBoard,self.onDeleteData)
notifySystem:listenNotify(notifyConfig.exitWorld,self.onExitWorld)
notifySystem:listenNotify(notifyConfig.onWorldUnitColorChange,self.onWorldUnitColorChange)
end


function UIWorldBillBoardWin:__delete()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.onAddBillBoard,self.onAddData)
notifySystem:removelistener(notifyConfig.onRemoveBillBoard,self.onDeleteData)
notifySystem:removelistener(notifyConfig.exitWorld,self.onExitWorld)
notifySystem:removelistener(notifyConfig.onWorldUnitColorChange,self.onWorldUnitColorChange)
end




function UIWorldBillBoardWin:onShow(argtable,afterOnloaded)
self.root:setActive(true)
end


function UIWorldBillBoardWin:onHide()




self.root:setActive(false)
end



function UIWorldBillBoardWin.onAddData(unitKey,slotName,handle,offset,scale,param)
local args={
unitKey=unitKey,
slotName=slotName,
offset=offset,
scale=scale,
param=param,
}
local luaid=_this.creator:createObject(handle,_this.root:getID(),0,args)
_Components[luaid]=unitKey
end

function UIWorldBillBoardWin.onDeleteData(unitKey)
for luaid,unit in pairs(_Components)do
if unitKey==unit then
_this.creator:deleteItemByLuaid(luaid)
_Components[luaid]=nil
end
end
end

function UIWorldBillBoardWin.onWorldUnitColorChange(unitKey,color,duration,callback)
for luaid,unit in pairs(_Components)do
if unitKey==unit then
_this.creator:callChildFunc(luaid,"changeColor",color,duration)
end
end
end

function UIWorldBillBoardWin.onExitWorld(world)
for luaid,unit in pairs(_Components)do
_this.creator:deleteItemByLuaid(luaid)
end
_Components={}
end