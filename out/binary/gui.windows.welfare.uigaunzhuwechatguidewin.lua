







def_class("UIGaunZhuWechatGuideWin",UIWindowBase)









function UIGaunZhuWechatGuideWin:bindComponents()

self.Root=UIObject.get(self,0)
self.codeimg=UIImage.get(self,1)
self.desc1=UIText.get(self,2)
self.desc2=UIText.get(self,3)
self.okbtn=UIButton.get(self,4)

self.okbtn:setButtonClick(function()self:onOkbtn()end)



end


function UIGaunZhuWechatGuideWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.codeimg);self.codeimg=nil;
_UIObject_release(self.desc1);self.desc1=nil;
_UIObject_release(self.desc2);self.desc2=nil;
_UIObject_release(self.okbtn);self.okbtn=nil;
end



















function UIGaunZhuWechatGuideWin:onLoaded(...)
self:bindComponents()
end


function UIGaunZhuWechatGuideWin:__delete()
self:unbindComponents()
end




function UIGaunZhuWechatGuideWin:onShow(argtable,afterOnloaded)

self.callback=argtable and argtable.callback

self.config=cfgHelper.get(cfg_guanzhuactconfig_get,1)


local qrimg=self.config.qrcode
self.codeimg:setCSImageSprite(qrimg[1],qrimg[2])

self.desc1:setText(self.config.wxdesc1)

self.desc2:setText(self.config.wxdesc2)
end


function UIGaunZhuWechatGuideWin:onHide()

end





function UIGaunZhuWechatGuideWin:onOkbtn()
if self.callback then
self.callback()
end
self:closeSelf()
end

