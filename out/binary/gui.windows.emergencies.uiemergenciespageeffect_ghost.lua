







def_class("UIEmergenciesPageEffect_ghost",UIWindowBase)









function UIEmergenciesPageEffect_ghost:bindComponents()

self.root=UIObject.get(self,0)
self.model=UIObject.get(self,1)



end


function UIEmergenciesPageEffect_ghost:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.model);self.model=nil;
end















local _this

local ignoreWinNameList={
["UILimitActTipsWin"]=true,
["UITaskListWin"]=true,
["UIItemUseTipWin"]=true,
["UIBuildingMsgWin"]=true,
["UIMoneyDetailWin"]=true,
["UIHomeBuffWin"]=true,
["UIEmergenciesWraning"]=true,
["UIEmergenciesPageEffect_ghostBg"]=true,
["UIWeakGuideOneWin"]=true,
["UIWeakGuideTwoWin"]=true,
}




function UIEmergenciesPageEffect_ghost:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.showUI,self.showUI)
self:addNotify(notifyConfig.closeUI,self.closeUI)
self:addNotify(notifyConfig.hideUI,self.closeUI)
end


function UIEmergenciesPageEffect_ghost:__delete()
self:clearAllTween()
self:unbindComponents()
_this=nil
end




function UIEmergenciesPageEffect_ghost:onShow(argtable,afterOnloaded)
self.needClose=nil
self.root:setChildCanvasGroupAlpha(0)
self:fadeInShowModel(true)
self:showWindow("UIEmergenciesPageEffect_ghostBg")
end


function UIEmergenciesPageEffect_ghost:onHide()
self:fadeOutShowModel()
end


function UIEmergenciesPageEffect_ghost:fadeInShowModel(isInit)
local fadeInTime=1


local fadeFunc=function()
self:clearAllTween()
self.fadeInTween=self.root:setChildCanvasGroupDOFade(1,fadeInTime,function()
return _this:clearFadeInTween()
end)
end

if isInit then
local modelId=4715
if modelId then
self.model:setChildUIModelShowTarget(modelId,0.57,{},eAnimationID.stand,false,false,0,fadeFunc)
self.model:setChildUIModelShowTargetOffset(0,45)
end
else
fadeFunc()
end
end


function UIEmergenciesPageEffect_ghost:fadeOutShowModel(isClose)
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

function UIEmergenciesPageEffect_ghost:clearAllTween()
self:clearFadeInTween()
self:clearFadeOutTween()
end


function UIEmergenciesPageEffect_ghost:clearFadeInTween()
if self.fadeInTween~=nil then
self.fadeInTween:Kill()
self.fadeInTween=nil
end
end

function UIEmergenciesPageEffect_ghost:clearFadeOutTween()
if self.fadeOutTween~=nil then
self.fadeOutTween:Kill()
self.fadeOutTween=nil
end
end


function UIEmergenciesPageEffect_ghost.showUI(viewName)
if _this.needClose then
return
end
if ignoreWinNameList[viewName]then
return
end
_this:fadeOutShowModel()
end


function UIEmergenciesPageEffect_ghost.closeUI(viewName)
if _this.needClose then
return
end
if ignoreWinNameList[viewName]then
return
end
_this:fadeInShowModel()
end


