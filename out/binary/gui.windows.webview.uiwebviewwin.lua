







def_class("UIWebViewWin",UIWindowBase)









function UIWebViewWin:bindComponents()

self.btnLeftArrow=UIButton.get(self,0)
self.btnReload=UIButton.get(self,1)
self.btnRigthArrow=UIButton.get(self,2)
self.CanvasWebViewPrefab=UIObject.get(self,3)
self.urlTxt=UIText.get(self,4)
self.progressTxt=UIText.get(self,5)
self.btnClose=UIButton.get(self,6)

self.btnLeftArrow:setButtonClick(function()self:onBtnLeftArrow()end)

self.btnReload:setButtonClick(function()self:onBtnReload()end)

self.btnRigthArrow:setButtonClick(function()self:onBtnRigthArrow()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)



end


function UIWebViewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnLeftArrow);self.btnLeftArrow=nil;
_UIObject_release(self.btnReload);self.btnReload=nil;
_UIObject_release(self.btnRigthArrow);self.btnRigthArrow=nil;
_UIObject_release(self.CanvasWebViewPrefab);self.CanvasWebViewPrefab=nil;
_UIObject_release(self.urlTxt);self.urlTxt=nil;
_UIObject_release(self.progressTxt);self.progressTxt=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
end



















function UIWebViewWin:onLoaded(...)
self:bindComponents()
self.baseWebView=self.winlua:GetChildBaseWebView(self.CanvasWebViewPrefab:getID())
self.baseWebView:SetInitializedAction(function()
self:onInitialized()
end)
self.btnLeftArrow:setActive(false)
self.btnRigthArrow:setActive(false)
self.winlua:SetChildCanvasGroupAlpha(self.CanvasWebViewPrefab:getID(),0)
self.hidePage=true
end

function UIWebViewWin:__delete()
self:unbindComponents()
end

function UIWebViewWin:onShow(argtable,afterOnloaded)
self.url=argtable
self.urlTxt:setText(self.url)
end

function UIWebViewWin:onHide()

end



function UIWebViewWin:onInitialized()
self.isInit=true
self:initAction()
self:loadURL(self.url)
end

function UIWebViewWin:initAction()


self.baseWebView:SetTerminatedAction(function(code)
self:closeSelf()
end)

self.baseWebView:SetLoadFailedAction(function(code,url)
UIManager.info('加载失败')
end)







self.baseWebView:SetLoadProgressAction(function(typo,progress)

if typo==0 then
self:canGoForward()
self:canGoBack()
elseif typo==1 then
if self.hidePage==true then
self.hidePage=false
self.winlua:SetChildCanvasGroupAlpha(self.CanvasWebViewPrefab:getID(),1)
end
self:canGoForward()
self:canGoBack()
elseif typo==2 then

elseif typo==3 then

end
self.progressTxt:setText(FMT.fmt('{0}%',math.floor(progress*100)))
end)

self.baseWebView:SetSendMessageAction(function(val)

end)

self.baseWebView:SetAction(function(key,value)

if key=='CanGoBack'then
self.btnLeftArrow:setActive(value=='true')
elseif key=='CanGoForward'then
self.btnRigthArrow:setActive(value=='true')
end
end)




end

function UIWebViewWin:loadURL(url)
if not self.isInit then return end
self.url=url
self.urlTxt:setText(self.url)
self.baseWebView:LoadURL(url)
end

function UIWebViewWin:reload()
if not self.isInit then return end
self.baseWebView:Reload()
end

function UIWebViewWin:stopLoad()
if not self.isInit then return end
self.baseWebView:StopLoad()
end

function UIWebViewWin:goForward()
if not self.isInit then return end
self.baseWebView:GoForward()
end

function UIWebViewWin:goBack()
if not self.isInit then return end
self.baseWebView:GoBack()
end

function UIWebViewWin:canGoForward()
if not self.isInit then return end
self.baseWebView:CanGoForward()
end

function UIWebViewWin:canGoBack()
if not self.isInit then return end
self.baseWebView:CanGoBack()
end

function UIWebViewWin:getURL()
if not self.isInit then return end
return self.baseWebView:GetURL()
end

function UIWebViewWin:copy()
if not self.isInit then return end
self.baseWebView:Copy()
end

function UIWebViewWin:cut()
if not self.isInit then return end
self.baseWebView:Cut()
end

function UIWebViewWin:paste()
if not self.isInit then return end
self.baseWebView:Paste()
end

function UIWebViewWin:postMessage(data)
if not self.isInit then return end
self.baseWebView:PostMessage(data)
end

function UIWebViewWin:selectAll()
if not self.isInit then return end
self.baseWebView:SelectAll()
end

function UIWebViewWin:sendKey(key)
if not self.isInit then return end
self.baseWebView:SendKey()
end

function UIWebViewWin:setDefaultBackgroundEnabled(enabled)
if not self.isInit then return end
self.baseWebView:SetDefaultBackgroundEnabled(enabled)
end

function UIWebViewWin:setFocused(focused)
if not self.isInit then return end
self.baseWebView:SetFocused(focused)
end

function UIWebViewWin:zoomIn()
if not self.isInit then return end
self.baseWebView:ZoomIn()
end

function UIWebViewWin:zoomOut()
if not self.isInit then return end
self.baseWebView:ZoomOut()
end

function UIWebViewWin:captureScreenshot(path)
if not self.isInit then return end
self.baseWebView:CaptureScreenshot(path)
end

function UIWebViewWin:isInitialized()
if not self.isInit then return end
return self.baseWebView:IsInitialized()
end

function UIWebViewWin:pageLoadScripts(content)
if not self.isInit then return end
self.baseWebView:PageLoadScripts(content)
end

function UIWebViewWin:clickPoint(x,y,Focus)
if not self.isInit then return end
self.baseWebView:ClickPoint(x,y,Focus)
end


function UIWebViewWin:scrollNow(delta)
if not self.isInit then return end
self.baseWebView:ScrollNow(delta)
end


function UIWebViewWin:onBtnRigthArrow()
if not self.isInit then return end
self:goForward()
self:canGoForward()
self:canGoBack()
end

function UIWebViewWin:onBtnLeftArrow()
if not self.isInit then return end
self:goBack()
self:canGoForward()
self:canGoBack()
end

function UIWebViewWin:onBtnReload()
if not self.isInit then return end
self:reload()
end

function UIWebViewWin:onBtnClose()
self:closeSelf()
end
