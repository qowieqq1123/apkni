







def_class("UIJiuChongTianJieDialouge",UIWindowBase)









function UIJiuChongTianJieDialouge:bindComponents()

self.cancelButton=UIButton.get(self,0)
self.cancelText=UIText.get(self,1)
self.dialougeText=UILinkImageText.get(self,2)
self.okButton=UIButton.get(self,3)
self.okText=UIText.get(self,4)
self.okTipsText=UIText.get(self,5)
self.scrollView=UIObject.get(self,6)
self.titleText=UIText.get(self,7)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UIJiuChongTianJieDialouge:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.dialougeText);self.dialougeText=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.okTipsText);self.okTipsText=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.titleText);self.titleText=nil;
end


















local titleAB="ui/windows/jiuchongtianjieenter/enter_sub_title_atlas_pak.ab"
local imgAB="ui/windows/jiuchongtianjieenter/enter_sub_img_atlas_pak.ab"

function UIJiuChongTianJieDialouge:onLoaded(...)
self:bindComponents()
end


function UIJiuChongTianJieDialouge:__delete()
self:unbindComponents()
end




function UIJiuChongTianJieDialouge:onShow(argtable,afterOnloaded)
local systemList=argtable.systemList
self.okCall=argtable.okCallback

self.scrollView:setChildScrollViewCreateGrids(#systemList,#systemList)
local grids=self.scrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local grid=grids[i-1]
local sys=systemList[i]
local config=sys:getConfig()
grid:SetChildCSImageSprite(0,titleAB,"image_jiuchongtjsfbt_"..config.icon)
grid:SetChildCSImageSprite(2,imgAB,"image_jiuchongtjsfct_"..config.icon)
grid:SetChildButtonClick(1,function()
sys:doJump()
end)
end

self.okText:setText("继续飞升")
end


function UIJiuChongTianJieDialouge:onHide()

end





function UIJiuChongTianJieDialouge:onCancelButton()
self:closeSelf()
end

function UIJiuChongTianJieDialouge:onBGClick()
self:closeSelf()
end


function UIJiuChongTianJieDialouge:onCloseBtn()
self:closeSelf()
end



function UIJiuChongTianJieDialouge:onOkButton()
if self.okCall then
self.okCall()
end
end

