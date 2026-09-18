







def_class("UIAirHarmHud",UICloneObject)





UIAirHarmHud.abName="ui/windows/airminigame/hud/uiairharmhud.ab"

UIAirHarmHud.assetName="UIAirHarmHud"


function UIAirHarmHud:bindComponents()

self.harm=UIText.get(self,0)
self.root=UIObject.get(self,1)

end


function UIAirHarmHud:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.harm);self.harm=nil;
_UIObject_release(self.root);self.root=nil;
end








function UIAirHarmHud:onLoaded(...)
self:bindComponents()
end

function UIAirHarmHud:__delete()
self.root:setActive(false)
self:unbindComponents()
end

function UIAirHarmHud:onShow(argtable,afterOnloaded)
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

ent:setHudClearTime(guid,0.75)
self.root:setActive(true)
end

function UIAirHarmHud:onHide()
self.root:setActive(false)
end

