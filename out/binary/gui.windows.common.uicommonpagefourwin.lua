







def_class("UICommonPageFourWin",UIWindowBase)









function UICommonPageFourWin:bindComponents()

self.blackBG=UIObject.get(self,0)
self.btnClose=UIButton.get(self,1)
self.clickMask=UIButton.get(self,2)
self.infoPanel=UIObject.get(self,3)
self.root=UIObject.get(self,4)
self.titleText=UIText.get(self,5)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.clickMask:setButtonClick(function()self:onClickMask()end)



end


function UICommonPageFourWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackBG);self.blackBG=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.titleText);self.titleText=nil;
end
















local _this=nil



function UICommonPageFourWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UICommonPageFourWin:__delete()
_this=nil
self:unbindComponents()
self:closeExtra()
local winName=self.extraWin
if winName then
UIManager:removeWindowAwake(winName)
end
local cb=self.closeCB
if cb then
cb()
end
end




function UICommonPageFourWin:onShow(argtable,afterOnloaded)
self:closeExtra()
self:resetRootCanves()
self.closeCB=argtable.closeCB
self.extraWin=argtable.extraWin
self.extraParams=argtable.extraParams or{}
self.extraParams.parentWin=self

local showBG=argtable.showBG
if showBG==nil then showBG=true end
self.blackBG:setActive(showBG)
local titleName=argtable.titleName
self.titleText:setText(titleName)
if self.extraWin then
local wincfg=UIManager.get_window_config(self.extraWin)
local canvasIdx=wincfg.canvas
self:setCanvasIndex(-1,canvasIdx)
end

self.markAnim=false
self.markDragon=false
local winName=self.extraWin
if winName~=nil then
UIManager:listenWindowAwake(winName,self.showUI)
if self.extraParams==nil then
self.extraParams={}
end
self.extraParams.parentWin=self
self:showWindow(winName,self.extraParams)
end
if afterOnloaded then
self.infoPanel:setChildCanvasGroupAlpha(0)
end
self:onLoadFinish()
end


function UICommonPageFourWin:onHide()

end

function UICommonPageFourWin.showUI()
if _this==nil then return end
if _this.markDragon==false then return end
_this:showExtra()
end

function UICommonPageFourWin:showCloseBtn(bShow)
self.btnClose:setActive(bShow)
end

function UICommonPageFourWin:closeExtra()
if self.extraWin~=nil then
UIManager:closeWindow(self.extraWin)
self.extraWin=nil
self.extraParams=nil
end
end

function UICommonPageFourWin:showExtra()
if self.markAnim==true then return end
local winName=self.extraWin
if winName~=nil then
local win=UIManager:findActiveWindow(winName)
if win~=nil then
win:setChildCanvasGroupAlpha(-1,0)
win:setChildCanvasGroupDOFade(-1,1,1,nil)
self.markAnim=true
end
end
end

function UICommonPageFourWin:onLoadFinish()
self.markDragon=true
if self.markAnim==true then return end
self.infoPanel:setChildCanvasGroupDOFade(1,0.25,nil)
self:showExtra()
end

function UICommonPageFourWin:resetRootCanves(sortLayer,sortOrder)
if sortLayer==nil then
self.root:setChildRemoveCanvas()
else
self.root:setChildCanvas(sortLayer,sortOrder)
end
end




function UICommonPageFourWin:onClickMask()
self:onCloseClick()
end


function UICommonPageFourWin:onBtnClose()
self:onCloseClick()
end


function UICommonPageFourWin:onCloseClick()
self:closeSelf()
end
