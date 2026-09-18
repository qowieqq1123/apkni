







def_class("UIAirBossHud",UICloneObject)





UIAirBossHud.abName="ui/windows/airminigame/hud/uiairbosshud.ab"

UIAirBossHud.assetName="UIAirBossHud"


function UIAirBossHud:bindComponents()

self.progressBar=UIProgressBarAni.get(self,0)

end


function UIAirBossHud:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.progressBar);self.progressBar=nil;
end








function UIAirBossHud:onLoaded(...)
self:bindComponents()
end

function UIAirBossHud:__delete()
self:unbindComponents()
end

function UIAirBossHud:onShow(argtable,afterOnloaded)

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

local guid=self:getPrefabid()
airHUDSystem:initCfg(guid,0,Vector3.zero,Vector2.New(0,2.5))
local bitlist={eHUDCatchType.eHP}
local bit=airHUDSystem:getHUDBit(bitlist)
airHUDSystem:bindEntityHUD(guid,handle,self)
airHUDSystem:bindHUDEvent(handle,self,bit)
ent:setHudScaleSetting(1,30,0.2,1)
end

function UIAirBossHud:onHide()

end



function UIAirBossHud:onHPChange(new,max)
self.progressBar:animateThreeParams(new,max,0.1)
end