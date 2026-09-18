







def_class("UIEnterXianYuanXunFang",UICloneObject)





UIEnterXianYuanXunFang.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterXianYuanXunFang.assetName="UIEnterNomalItem"


function UIEnterXianYuanXunFang:bindComponents()

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


function UIEnterXianYuanXunFang:unbindComponents()
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







function UIEnterXianYuanXunFang:onLoaded(...)
self:bindComponents()
end


function UIEnterXianYuanXunFang:__delete()
self:unbindComponents()
end


function UIEnterXianYuanXunFang:onHide()

end




function UIEnterXianYuanXunFang:onShow(argtable,afterOnloaded)
self.model:setChildUIModelRemoveTarget()
self.icon:setActive(true)
local abname,iconname=activitiesModel.getEnterIcon(1)
self.widget:SetChildCSImageSprite(0,abname,iconname)


self:freshReddot()

self.widget:SetChildText(2,'')

self.widget:SetChildText(3,'')

self.widget:SetChildActive(4,false)




self.extendbg:setActive(false)
self.qipao:setActive(false)
end

function UIEnterXianYuanXunFang:freshReddot()
local isReddot=xianyuanxunfangController:checkReddot()
self.widget:SetChildActive(1,isReddot)
end

function UIEnterXianYuanXunFang:onIcon()
xianyuanxunfangController:jumpWin2()
end

function UIEnterXianYuanXunFang:onClickBg()
xianyuanxunfangController:jumpWin2()
end