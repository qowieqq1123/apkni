







def_class("UIEnterVisitGameCenter",UICloneObject)





UIEnterVisitGameCenter.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterVisitGameCenter.assetName="UIEnterNomalItem"


function UIEnterVisitGameCenter:bindComponents()

self.icon=UIButton.get(self,0)
self.reddot=UIObject.get(self,1)
self.name=UIText.get(self,2)
self.time=UIText.get(self,3)
self.timeBg=UIObject.get(self,4)
self.qipao=UIObject.get(self,5)
self.qipaoText=UIText.get(self,6)
self.model=UIObject.get(self,7)
self.clickBg=UIButton.get(self,8)
self.extendbg=UIObject.get(self,9)
self.lldhQiPao=UIObject.get(self,10)

self.icon:setButtonClick(function()self:onIcon()end)

self.clickBg:setButtonClick(function()self:onClickBg()end)

end


function UIEnterVisitGameCenter:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.qipao);self.qipao=nil;
_UIObject_release(self.qipaoText);self.qipaoText=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.clickBg);self.clickBg=nil;
_UIObject_release(self.extendbg);self.extendbg=nil;
_UIObject_release(self.lldhQiPao);self.lldhQiPao=nil;
end









function UIEnterVisitGameCenter:onLoaded(...)
self:bindComponents()
end


function UIEnterVisitGameCenter:__delete()
self:unbindComponents()
end




function UIEnterVisitGameCenter:onShow(argtable,afterOnloaded)
enterConfig.preInitEnter(self)
self:changeVisitType(argtable.info.vtype)
self.widget:SetChildActive(0,true)
self.widget:SetChildUIModelRemoveTarget(7)
self.name:setText('')

self.timeBg:setActive(false)
end


function UIEnterVisitGameCenter:onHide()

end

function UIEnterVisitGameCenter:changeIcon(iconname)
local abname=enterConfig.getSpriteAB()
self.icon:setSprite(abname,iconname)
end

function UIEnterVisitGameCenter:changeVisitType(vtype)
self.vtype=vtype
if vtype==mgVisitEnterType.zfbFirstVisit then
self:changeIcon('button_hdrk_0085')
elseif vtype==mgVisitEnterType.zfbReturnVisit then
self:changeIcon('button_hdrk_0086')
elseif vtype==mgVisitEnterType.dyNavigateToSidebar then
self:changeIcon('button_hdrk_0095')
end
end




function UIEnterVisitGameCenter:showWin()
local vtype=self.vtype
if vtype==mgVisitEnterType.zfbFirstVisit or vtype==mgVisitEnterType.zfbReturnVisit then
if vtype==mgVisitEnterType.zfbFirstVisit then
webGLHelper:reportVisitEvent('center_setappc_icon_click')
else
webGLHelper:reportVisitEvent('revisit_icon_click')
end
end
UIFullWelfareController:showWindowWXAddReward({visitType=vtype})
end

function UIEnterVisitGameCenter:onIcon()
self:showWin()
end

function UIEnterVisitGameCenter:onClickBg()
self:showWin()
end