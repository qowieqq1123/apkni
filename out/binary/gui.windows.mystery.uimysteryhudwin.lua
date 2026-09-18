







def_class("UIMysteryHUDWin",UIWindowBase)









function UIMysteryHUDWin:bindComponents()

self.creator=UIGameobjectClone.new(self,0)
self.flow=UIHUDFlow.get(self,1)
self.hud=UIObject.get(self,2)



end


function UIMysteryHUDWin:unbindComponents()
local _UIObject_release=UIObject.release
self.creator:deleteSelf();self.creator=nil;
_UIObject_release(self.flow);self.flow=nil;
_UIObject_release(self.hud);self.hud=nil;
end



















local entityHudIdHolder={}
local posHudIdHolder={}


function UIMysteryHUDWin:onLoaded(...)
self:bindComponents()
end


function UIMysteryHUDWin:__delete()
entityHudIdHolder={}
posHudIdHolder={}
self.creator:recycleAll()
self:unbindComponents()
end




function UIMysteryHUDWin:onShow(argtable,afterOnloaded)

end


function UIMysteryHUDWin:onHide()

end




function UIMysteryHUDWin:addMonsterHUD(guid)
entityHudIdHolder[guid]=self.creator:createObject('UIMysteryHUD',self.hud:getID(),0,{guid=guid})
end

function UIMysteryHUDWin:removeMonsterHUDByGuid(guid)
if guid~=nil and entityHudIdHolder[guid]~=nil then
self.creator:recycleItemById(entityHudIdHolder[guid])
entityHudIdHolder[guid]=nil
end
end

function UIMysteryHUDWin:removeMonsterHUD(hudWin)
if hudWin~=nil then
self.creator:recycleItem(hudWin)
end
end

function UIMysteryHUDWin:addUIHUD(name,args)
return self.creator:createObject(name,self.hud:getID(),0,args)
end

function UIMysteryHUDWin:removeUIHUD(guid)
self.creator:recycleItemById(guid)
end

function UIMysteryHUDWin:refreshUIHUD(guid,funcname,...)
return self.creator:callChildFunc(guid,funcname,...)
end

function UIMysteryHUDWin:addModelHUD(pos,layer,modelArgs)
layer=layer or HexMapLayer.Ground
local posstr=table.concat({pos.x,pos.y,layer},"-")
posHudIdHolder[posstr]=self.creator:createObject('UIMysteryModelHUD',self.hud:getID(),0,{pos=pos,layer=layer,modelArgs=modelArgs})
end

function UIMysteryHUDWin:addEffectHUD(pos,layer,effectArgs)
layer=layer or HexMapLayer.Ground
local posstr=table.concat({pos.x,pos.y,layer},"-")
posHudIdHolder[posstr]=self.creator:createObject('UIMysteryModelHUD',self.hud:getID(),0,{pos=pos,layer=layer,effectArgs=effectArgs})
end


function UIMysteryHUDWin:removeModelHUDByPos(pos,layer)
layer=layer or HexMapLayer.Ground
local posstr=table.concat({pos.x,pos.y,layer},"-")
if pos~=nil and posHudIdHolder[posstr]~=nil then
self.creator:recycleItemById(posHudIdHolder[posstr])
posHudIdHolder[posstr]=nil
end
end

function UIMysteryHUDWin:addEndPointHUD(pos,layer)
layer=layer or HexMapLayer.Ground
if not self.endPoint then
self.endPoint=self.creator:createObject('UIMysteryEndPointHUD',self.hud:getID(),0,{pos=pos,layer=layer})
end
end

function UIMysteryHUDWin:removeEndPointHUD()
if self.endPoint then
self.creator:recycleItemById(self.endPoint)
self.endPoint=nil
end
end