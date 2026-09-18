







def_class("UIEnterUwpHaoPing",UICloneObject)





UIEnterUwpHaoPing.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterUwpHaoPing.assetName="UIEnterNomalItem"


function UIEnterUwpHaoPing:bindComponents()

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


function UIEnterUwpHaoPing:unbindComponents()
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








local iconname='act_entericon_80'

function UIEnterUwpHaoPing:onLoaded(...)
self:bindComponents()
end


function UIEnterUwpHaoPing:__delete()
self:unbindComponents()
end




function UIEnterUwpHaoPing:onShow(argtable,afterOnloaded)
enterConfig.preInitEnter(self)
local info=argtable.info
local enterIconType=info.enterIconType
local enterType=info.enterType
local cfg=enterConfig.getConfig(enterIconType,enterType)
local abname=enterConfig.getSpriteAB()

self.widget:SetChildCSImageSprite(0,abname,iconname)

self.widget:SetChildActive(0,true)

self.widget:SetChildUIModelRemoveTarget(7)


self:freshReddot()

self.widget:SetChildText(2,'')

self.widget:SetChildText(3,'')

self.widget:SetChildActive(4,false)

self.widget:SetChildButtonClick(0,function()
UIManager:showWindow("UI_UwpHaoPingWin")
end,true)

self.widget:SetChildButtonClick(self.clickBg:getID(),function()
UIManager:showWindow("UI_UwpHaoPingWin")
end,true)

self.extendbg:setActive(false)
self.qipao:setActive(false)
self.lldhQiPao:setActive(false)
end


function UIEnterUwpHaoPing:onHide()
end

function UIEnterUwpHaoPing:freshReddot()
self.widget:SetChildActive(1,true)
end

function UIEnterUwpHaoPing:onIcon()

end

function UIEnterUwpHaoPing:onClickBg()

end