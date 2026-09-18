







def_class("UIDialougeXianGuanCampaign",UIWindowBase)









function UIDialougeXianGuanCampaign:bindComponents()

self.dialougeText=UILinkImageText.get(self,0)
self.okButton=UIButton.get(self,1)
self.okText=UIText.get(self,2)
self.titleText=UIText.get(self,3)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UIDialougeXianGuanCampaign:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.dialougeText);self.dialougeText=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.titleText);self.titleText=nil;
end



















function UIDialougeXianGuanCampaign:onLoaded(...)
self:bindComponents()
end


function UIDialougeXianGuanCampaign:__delete()
self:unbindComponents()
end




function UIDialougeXianGuanCampaign:onShow(showdata,afterOnloaded)

self.titleText:setText(showdata.title or"竞选宣言")
self.okText:setText(showdata.oktext or"发布")

self.showdata=showdata
end


function UIDialougeXianGuanCampaign:onHide()

end





function UIDialougeXianGuanCampaign:onOkButton()
local okcallback=self.showdata.okcallback
self.showdata:deleteSelf()
self:close()
if okcallback then
okcallback()
end
end

function UIDialougeXianGuanCampaign:onBGClick()
self.showdata:deleteSelf()
self:close()
end