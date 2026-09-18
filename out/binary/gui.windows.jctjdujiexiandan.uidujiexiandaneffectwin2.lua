







def_class("UIDuJieXianDanEffectWin2",UIWindowBase)









function UIDuJieXianDanEffectWin2:bindComponents()

self.building=UIObject.get(self,0)
self.effect=UIObject.get(self,1)
self.effect2=UIObject.get(self,2)
self.model=UIObject.get(self,3)
self.root=UIObject.get(self,4)



end


function UIDuJieXianDanEffectWin2:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.building);self.building=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.root);self.root=nil;
end



















function UIDuJieXianDanEffectWin2:onLoaded(...)
self:bindComponents()
end


function UIDuJieXianDanEffectWin2:__delete()
self:unbindComponents()
end




function UIDuJieXianDanEffectWin2:onShow(argtable,afterOnloaded)
local danling=jctjDuJieXianDanModel:hasEntityConfig()
local cfg=cfgHelper.get1(cfg_djxddanlingconfig_get,danling)
local model=cfg.model[1]
self.model:setChildUIModelShowTarget(model,cfg.model[3]*2,{},eAnimationID.dead,false,false,0)


self:delayDo(1.83,function()
self.effect2:setChildShowEffect(20387,true)
end)
self:delayDo(2.1,function()
self.effect:setChildShowEffect(20414,true)
end)


self.model:setChildCanvasGroupAlpha(1)
local t=self.model:setChildCanvasGroupDOFade(0,0.5)
t:SetDelay(2.33)

self.root:setChildCanvasGroupAlpha(1)
local t=self.root:setChildCanvasGroupDOFade(0,0.5)
t:SetDelay(5)

self:delayDo(7.33,function()
self:closeSelf()
end)
end


function UIDuJieXianDanEffectWin2:onHide()

end



