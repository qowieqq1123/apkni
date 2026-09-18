







def_class("UIAirTargetHud",UICloneObject)





UIAirTargetHud.abName="ui/windows/airminigame/hud/uiairtargethud.ab"

UIAirTargetHud.assetName="UIAirTargetHud"


function UIAirTargetHud:bindComponents()


end


function UIAirTargetHud:unbindComponents()
local _UIObject_release=UIObject.release
end








function UIAirTargetHud:onLoaded(...)
self:bindComponents()
end

function UIAirTargetHud:__delete()
self:unbindComponents()
end

function UIAirTargetHud:onShow(argtable,afterOnloaded)
local handle=argtable.handle
local entity=airEntitySystem:getEntity(handle)
if entity==nil then
self:recycleSelf()
return
end
local hudType=argtable.hudType
self.hudType=hudType
local guid=self:getPrefabid()
airHUDSystem:initCfg(guid,0,Vector3.zero,Vector2.New(0,0.2))
airHUDSystem:bindEntityHUD(guid,handle,self)
end

function UIAirTargetHud:onHide()

end


