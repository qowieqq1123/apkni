







def_class("UIAirHud",UICloneObject)





UIAirHud.abName="ui/windows/airminigame/hud/uiairhud.ab"

UIAirHud.assetName="UIAirHud"


function UIAirHud:bindComponents()

self.progressBar=UIProgressBarAni.get(self,0)

end


function UIAirHud:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.progressBar);self.progressBar=nil;
end








function UIAirHud:onLoaded(...)
self:bindComponents()
end

function UIAirHud:__delete()
self:unbindComponents()
end

function UIAirHud:onShow(argtable,afterOnloaded)

local handle=argtable.handle
local entity=airEntitySystem:getEntity(handle)
if entity==nil then
self:recycleSelf()
return
end
local hudType=argtable.hudType
self.hudType=hudType
local ent=airEntitySystem:getEntity(handle)
local max=ent:getMaxHP()
local cur=ent:getHP()
self.progressBar:animateThreeParams(cur,max,0)

local offset=ent:getHUDOffset()
self.progressBar:setChildAnchoredPos(offset[1],offset[2])


self.handle=handle
local guid=self:getPrefabid()
airHUDSystem:initCfg(guid,0,Vector3.zero,Vector2.New(0,3.2))
local bitlist={eHUDCatchType.eHP}
local bit=airHUDSystem:getHUDBit(bitlist)
airHUDSystem:bindEntityHUD(guid,handle,self)
airHUDSystem:bindHUDEvent(handle,self,bit)
end

function UIAirHud:onHide()

end



function UIAirHud:onHPChange(new,max)
self.progressBar:animateThreeParams(new,max,0.1)
end