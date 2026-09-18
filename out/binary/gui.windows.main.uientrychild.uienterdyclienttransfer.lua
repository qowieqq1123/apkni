







def_class("UIEnterDYClientTransfer",UICloneObject)





UIEnterDYClientTransfer.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterDYClientTransfer.assetName="UIEnterNomalItem"


function UIEnterDYClientTransfer:bindComponents()

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


function UIEnterDYClientTransfer:unbindComponents()
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









function UIEnterDYClientTransfer:onLoaded(...)
self:bindComponents()
end


function UIEnterDYClientTransfer:__delete()
self:unbindComponents()
end




function UIEnterDYClientTransfer:onShow(argtable,afterOnloaded)
enterConfig.preInitEnter(self)
self.info=argtable.info
local enterIconType=self.info.enterIconType
local enterType=self.info.enterType
local iconname=self.info.iconname
self.cfg=enterConfig.getConfig(enterIconType,enterType)

local abname=enterConfig.getSpriteAB()
self.widget:SetChildCSImageSprite(0,abname,iconname)
self.widget:SetChildActive(0,true)
self.widget:SetChildUIModelRemoveTarget(7)
self.reddot:setActive(true)

self.widget:SetChildText(3,'')

self.widget:SetChildActive(4,false)

self.qipao:setActive(false)
end


function UIEnterDYClientTransfer:onHide()

end




function UIEnterDYClientTransfer:freshReddot()

local flag=self.info.getReddotFun()
self.reddot:setActive(flag)
end

function UIEnterDYClientTransfer:onIcon()

end

function UIEnterDYClientTransfer:onClickBg()
local isOpen=houtaiModel:getDYClientTransferOpen()
platformSDK.printSDK('checkDYClientTransferOpen-onClickBg',isOpen)
if isOpen then
platformSDK:invoke("PopupShow")
end
end