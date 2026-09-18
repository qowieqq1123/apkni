







def_class("UIJiuChongTianJiePreviewWin",UIWindowBase)









function UIJiuChongTianJiePreviewWin:bindComponents()

self.btnJiYuan=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.noselectJiYuan=UIObject.get(self,2)
self.selectJiYuan=UIObject.get(self,3)
self.txtJiYuan=UIText.get(self,4)
self.reddotJiYuan=UIObject.get(self,5)

self.btnJiYuan:setButtonClick(function()self:onBtnJiYuan()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIJiuChongTianJiePreviewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnJiYuan);self.btnJiYuan=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.noselectJiYuan);self.noselectJiYuan=nil;
_UIObject_release(self.selectJiYuan);self.selectJiYuan=nil;
_UIObject_release(self.txtJiYuan);self.txtJiYuan=nil;
_UIObject_release(self.reddotJiYuan);self.reddotJiYuan=nil;
end



















function UIJiuChongTianJiePreviewWin:onLoaded(...)
self:bindComponents()
end


function UIJiuChongTianJiePreviewWin:__delete()
self:unbindComponents()
end




function UIJiuChongTianJiePreviewWin:onShow(argtable,afterOnloaded)
self:freshJiYuan()
end


function UIJiuChongTianJiePreviewWin:onHide()

end

function UIJiuChongTianJiePreviewWin:freshJiYuan()
local jiYuan=zheXianLingModel:hasJiYuanItems()
if jiYuan then
self.btnJiYuan:setActive(true)
self.reddotJiYuan:setActive(zheXianLingModel:hasJiYuanTimes())
else
self.btnJiYuan:setActive(false)
end
end






function UIJiuChongTianJiePreviewWin:onCloseBtn()
self:closeSelf()
end

function UIJiuChongTianJiePreviewWin:onBtnJiYuan()
UIFullZheXianControl:showZheXianLingWindow({winType=UIFullZheXianControl.winType.eJiYuan})
end