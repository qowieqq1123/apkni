







def_class("UIEmergenciesPageEffect_ghostBg",UIWindowBase)









function UIEmergenciesPageEffect_ghostBg:bindComponents()

self.root=UIObject.get(self,0)
self.model=UIObject.get(self,1)



end


function UIEmergenciesPageEffect_ghostBg:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.model);self.model=nil;
end
















local _this



function UIEmergenciesPageEffect_ghostBg:onLoaded(...)
_this=self
self:bindComponents()
end


function UIEmergenciesPageEffect_ghostBg:__delete()
self:clearAllTween()
self:unbindComponents()
_this=nil
end




function UIEmergenciesPageEffect_ghostBg:onShow(argtable,afterOnloaded)
self.needClose=nil
self.root:setChildCanvasGroupAlpha(0)
self:fadeInShowModel(true)
end


function UIEmergenciesPageEffect_ghostBg:onHide()
self:fadeOutShowModel()
end

function UIEmergenciesPageEffect_ghostBg:fadeInShowModel(isInit)
local fadeInTime=1


local fadeFunc=function()
self:clearAllTween()
self.fadeInTween=self.root:setChildCanvasGroupDOFade(1,fadeInTime,function()
return _this:clearFadeInTween()
end)
end

if isInit then
local modelId=4716
if modelId then
self.model:setChildUIModelShowTarget(modelId,0.75,{},eAnimationID.stand,false,false,0,fadeFunc)
end
else
fadeFunc()
end
end

function UIEmergenciesPageEffect_ghostBg:fadeOutShowModel(isClose)
local fadeOutTime=1


if isClose then
self.needClose=true
end
self:clearAllTween()
self.fadeOutTween=self.root:setChildCanvasGroupDOFade(0,fadeOutTime,function()

if isClose then
return self:closeSelf()
else
return self:clearFadeOutTween()
end
end)
end

function UIEmergenciesPageEffect_ghostBg:clearAllTween()
self:clearFadeInTween()
self:clearFadeOutTween()
end

function UIEmergenciesPageEffect_ghostBg:clearFadeInTween()
if self.fadeInTween~=nil then
self.fadeInTween:Kill()
self.fadeInTween=nil
end
end

function UIEmergenciesPageEffect_ghostBg:clearFadeOutTween()
if self.fadeOutTween~=nil then
self.fadeOutTween:Kill()
self.fadeOutTween=nil
end
end


