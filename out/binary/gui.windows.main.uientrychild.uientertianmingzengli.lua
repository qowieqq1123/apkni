







def_class("UIEnterTianMingZengLi",UICloneObject)





UIEnterTianMingZengLi.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterTianMingZengLi.assetName="UIEnterNomalItem"


function UIEnterTianMingZengLi:bindComponents()

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

self.icon:setButtonClick(function()self:onIcon()end)

self.clickBg:setButtonClick(function()self:onClickBg()end)

end


function UIEnterTianMingZengLi:unbindComponents()
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
end





local iconname='button_hdrk_0045'




function UIEnterTianMingZengLi:onLoaded(...)
self:bindComponents()
end


function UIEnterTianMingZengLi:__delete()
self:unbindComponents()
end




function UIEnterTianMingZengLi:onShow(argtable,afterOnloaded)
enterConfig.preInitEnter(self)
local info=argtable.info
local enterIconType=info.enterIconType
local enterType=info.enterType
local cfg=enterConfig.getConfig(enterIconType,enterType)
local abname=enterConfig.getSpriteAB()

self.widget:SetChildCSImageSprite(0,abname,iconname)
self.widget:SetChildActive(0,true)
self.widget:SetChildUIModelRemoveTarget(7)

self.widget:SetChildActive(1,false)

self:freshReddot()

self.widget:SetChildText(2,'')

self.widget:SetChildText(3,'')

self.widget:SetChildActive(4,false)

self.extendbg:setActive(argtable.isEx or false)
self.qipao:setActive(false)
end


function UIEnterTianMingZengLi:onHide()

end

function UIEnterTianMingZengLi:freshReddot()

UIManager:invokeUIMethod('UIMain','freshSimpleBtnReddot')
local reddot,dzId=tianmingzengliModel:getTMZLEnterReddot()
self.widget:SetChildActive(1,reddot)
self.selectDzId=dzId
end


function UIEnterTianMingZengLi:onIcon()
if not systemModel.isOpen(SYSTEM_DEFINE.eTianMingZengLi)then
UIManager.info("天命赠礼未开启")
return
end

UIFullTianMingZengLiController:showMainUI({dzId=self.selectDzId})
end

function UIEnterTianMingZengLi:onClickBg()
if not systemModel.isOpen(SYSTEM_DEFINE.eTianMingZengLi)then
UIManager.info("天命赠礼未开启")
return
end

UIFullTianMingZengLiController:showMainUI({dzId=self.selectDzId})
end