







def_class("UIAirCirticalHud",UICloneObject)





UIAirCirticalHud.abName="ui/windows/airminigame/hud/uiaircirticalhud.ab"

UIAirCirticalHud.assetName="UIAirCirticalHud"


function UIAirCirticalHud:bindComponents()

self.bg=UIObject.get(self,0)
self.harm=UIText.get(self,1)
self.root=UIObject.get(self,2)

end


function UIAirCirticalHud:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.harm);self.harm=nil;
_UIObject_release(self.root);self.root=nil;
end








function UIAirCirticalHud:onLoaded(...)
self:bindComponents()
end

function UIAirCirticalHud:__delete()
self.root:setActive(false)
self:unbindComponents()
end

function UIAirCirticalHud:onShow(argtable,afterOnloaded)
local handle=argtable.handle
local ent=airEntitySystem:getEntity(handle)
if ent==nil then
self.root:setActive(false)
self:recycleSelf()
return
end
local hudType=argtable.hudType
local x=argtable.x
local y=argtable.y
self.hudType=hudType
local guid=self:getPrefabid()
self.hudGuid=guid

self.root:setChildCanvasGroupAlpha(0)
airHUDSystem:initCfg(guid,0,Vector2.zero,Vector3.New(x,0,y+0.2))
airHUDSystem:bindEntityHUD(guid,handle,self,true)

local damage=argtable.damage
self.harm:setText(damage)

ent:setHudClearTime(guid,1)
self.root:setActive(true)
end

function UIAirCirticalHud:onHide()
self.root:setActive(false)
end

