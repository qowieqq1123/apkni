







def_class("UIJiuChongTianJieSysOpenWin",UIWindowBase)









function UIJiuChongTianJieSysOpenWin:bindComponents()

self.arrowShadow=UIObject.get(self,0)
self.bgEffect=UIObject.get(self,1)
self.descRoot=UIObject.get(self,2)
self.icon=UIImage.get(self,3)
self.manhuaRoot=UIObject.get(self,4)
self.maskImg=UIObject.get(self,5)
self.skipBtn=UIButton.get(self,6)
self.skipClick=UIButton.get(self,7)
self.title=UIText.get(self,8)
self.topUIRoot=UIObject.get(self,9)

self.skipBtn:setButtonClick(function()self:onSkipBtn()end)

self.skipClick:setButtonClick(function()self:onSkipClick()end)



end


function UIJiuChongTianJieSysOpenWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arrowShadow);self.arrowShadow=nil;
_UIObject_release(self.bgEffect);self.bgEffect=nil;
_UIObject_release(self.descRoot);self.descRoot=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.manhuaRoot);self.manhuaRoot=nil;
_UIObject_release(self.maskImg);self.maskImg=nil;
_UIObject_release(self.skipBtn);self.skipBtn=nil;
_UIObject_release(self.skipClick);self.skipClick=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.topUIRoot);self.topUIRoot=nil;
end


















local titleAB='ui/windows/jiuchongtianjieenter/enter_title_atlas_pak.ab'


function UIJiuChongTianJieSysOpenWin:onLoaded(...)
self:bindComponents()
end


function UIJiuChongTianJieSysOpenWin:__delete()
self:unbindComponents()

self:killTween()
end




function UIJiuChongTianJieSysOpenWin:onShow(argtable,afterOnloaded)
local sysid=argtable.sysid
local callback=argtable.callback
self.callback=callback
local cfg
if sysid<=0 then
cfg=cfgHelper.get(cfg_jctjbaseconfig_get,1)
else
cfg=cfgHelper.get(cfg_jctjsubsysconfig_get,sysid)
end

if not cfg.plotText then
if callback then callback()end
self:closeSelf()
return
end
local image=cfg.plotText[1]
local strList=cfg.plotText[2]
local n=#strList

self.icon:setCSImageSprite(titleAB,image)
self.descRoot:setChildLayoutGroupCreateItems(n)
local grids=self.descRoot:getChildLayoutGroupGridList()
local grid

self.maskImg:setChildAnchoredPos(0,102.5)
self.arrowShadow:setActive(false)
for i=1,n do
grid=grids[i-1]
grid:SetChildText(0,"<color=#ffffff00>一一</color>"..strList[i])
grid:SetChildCanvasGroupAlpha(0,0)
end

local btArgs={
widget=self.winlua,
topUIRoot=self.topUIRoot:getID(),
effectCmp=self.bgEffect:getID(),
maskImage=self.maskImg:getID(),
arrowShadow=self.arrowShadow:getID(),
}
if sysid>0 and cfg.effectInfo then
btArgs.effectId=cfg.effectInfo[1]
btArgs.effectWait=cfg.effectInfo[2]or 0
end
self.bt=behaviorManager:addBehaviorTree("bt_ui_jctj_sysopen",nil,true,btArgs,true)
end


function UIJiuChongTianJieSysOpenWin:onHide()

end





function UIJiuChongTianJieSysOpenWin:onBackClick()

end

function UIJiuChongTianJieSysOpenWin:onSkipClick()
if self.tween and self.tween:IsActive()then
local maskPos=self.maskImg:getChildUIScreenPos(false)
local grids=self.descRoot:getChildLayoutGroupGridList()
for i=1,grids.Count do
local item=self.descRoot:getChildLayoutGroupGridItem(i-1)
local itemPos=item:GetChildUIScreenPos(-1,false)
if maskPos.y>itemPos.y then
self.maskImg:setChildUIScreenPos(itemPos)
local anchoredPos=self.maskImg:getChildAnchoredPosition()
local progress=(1-(anchoredPos.y-(-102.5))/205)*7
self.tween:Goto(progress,true)
return
end
end

self.tween:Kill(true)
return
end

if not self.bt then
if self.callback then self.callback()end
self:closeSelf()
end
end

function UIJiuChongTianJieSysOpenWin:onBTFinish()
self.bt=nil
end

function UIJiuChongTianJieSysOpenWin:showAllDesc()
local grids=self.descRoot:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
grid:SetChildCanvasGroupAlpha(0,1)
end
end

function UIJiuChongTianJieSysOpenWin:scrollMaskDown()
self:killTween()
self.maskImg:setChildAnchoredPos(0,102.5)
self.tween=self.maskImg:setChildDOAnchorPosY(-102.5,7,function()
self:scrollDownFinish()
end)
self.tween:SetEase(DG.Tweening.Ease.Linear)
end

function UIJiuChongTianJieSysOpenWin:scrollDownFinish()
self.arrowShadow:setActive(true)
self:onBTFinish()
end

function UIJiuChongTianJieSysOpenWin:killTween()
if self.tween and self.tween:IsActive()then
self.tween:Kill(false)
end
end