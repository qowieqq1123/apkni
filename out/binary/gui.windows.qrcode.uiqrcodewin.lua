







def_class("UIQRCodeWin",UIWindowBase)









function UIQRCodeWin:bindComponents()

self.qrcode=UIRawImage.get(self,0)



end


function UIQRCodeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.qrcode);self.qrcode=nil;
end



















function UIQRCodeWin:onLoaded(...)
self:bindComponents()
end


function UIQRCodeWin:__delete()
self:unbindComponents()
end




function UIQRCodeWin:onShow(argtable,afterOnloaded)
local url
if argtable then
url=argtable.url
end
if deviceHelper.isRunEditor()then
url='http://10.10.1.235:8080/test/qrcode.png'
end
if not url or url==''then
self:onCloseClick()
return
end
self.winlua:ChildRawImageLoader(self.qrcode:getID(),2,'',url,true)
end


function UIQRCodeWin:onHide()

end




function UIQRCodeWin:onCloseClick()
self:closeSelf()
end