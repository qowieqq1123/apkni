







def_class("UICommonPageWin",UIWindowBase)









function UICommonPageWin:bindComponents()

self.blackBG=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.titleText=UIText.get(self,2)
self.btnClose=UIButton.get(self,3)
self.back=UIObject.get(self,4)
self.infoPanel=UIObject.get(self,5)

self.btnClose:setButtonClick(function()self:onBtnClose()end)



end


function UICommonPageWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackBG);self.blackBG=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
end


















local _this=nil


function UICommonPageWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UICommonPageWin:__delete()
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


function UICommonPageWin:onHide()

end

function UICommonPageWin.showUI()
if _this==nil then return end
if _this.markDragon==false then return end
_this:showExtra()
end




function UICommonPageWin:onShow(argtable,afterOnloaded)
self:setRootLPosX(0)
self:closeExtra()
self:resetRootCanves()
self.closeCB=argtable.closeCB
self.extraWin=argtable.extraWin
self.extraParams=argtable.extraParams or{}
self.extraParams.parentWin=self

local showBG=argtable.showBG
if showBG==nil then showBG=true end
self.blackBG:setActive(showBG)
local showClose=argtable.showClose
if showClose==nil then showClose=true end
self.btnClose:setActive(showClose)
local titleName=argtable.titleName
self.defaultTitleName=titleName
self:refreshTitle(titleName)
self.moveX=self:doMove(argtable.pos)
if self.extraWin then
local wincfg=UIManager.get_window_config(self.extraWin)
local canvasIdx=wincfg.canvas
self:setCanvasIndex(-1,canvasIdx)
end

local cb=function()
self:onLoadFinish()
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
self.back:setChildUIModelShowTarget(3037,1,{},eAnimationID.bd_stand,false,false,0,cb)
else
cb()
end
end

function UICommonPageWin:doMove(pos)

pos=pos or 2
local moveX=0
if pos==1 then
moveX=-430
elseif pos==3 then
moveX=430
elseif pos==4 then
moveX=-250
elseif pos==5 then
moveX=337
elseif pos==6 then
moveX=-357
end
self.infoPanel:setLocalPosX(moveX)
self.back:setLocalPosX(moveX)
return moveX
end

function UICommonPageWin:showCloseBtn(bShow)
self.btnClose:setActive(bShow)
end

function UICommonPageWin:closeExtra()
if self.extraWin~=nil then
UIManager:closeWindow(self.extraWin)
self.extraWin=nil
self.extraParams=nil
end
end

function UICommonPageWin:showExtra()
if self.markAnim==true then return end
local winName=self.extraWin
local moveX=self.moveX
if winName~=nil then
local win=UIManager:findActiveWindow(winName)
if win~=nil then
win:setChildCanvasGroupAlpha(-1,0)
win:setChildCanvasGroupDOFade(-1,1,1,nil)
win:setChildLocalPosX(-1,moveX)
self.markAnim=true
end
end
end

function UICommonPageWin:onLoadFinish()
self.markDragon=true
if self.markAnim==true then return end
local func=function()
self.infoPanel:setChildCanvasGroupDOFade(1,0.25,nil)
self:showExtra()
end
self:delayDo(0.3,func)
end

function UICommonPageWin:onCloseClick()
self:closeSelf()
end

function UICommonPageWin:onBtnClose()
self:onCloseClick()
end

function UICommonPageWin:resetRootCanves(sortLayer,sortOrder)
if sortLayer==nil then
self.root:setChildRemoveCanvas()
else
self.root:setChildCanvas(sortLayer,sortOrder)
end
end

function UICommonPageWin:moveRoot(moveX,duration)
self.root:setChildDOLocalMoveX(moveX,duration)
end

function UICommonPageWin:setRootLPosX(xpos)
local pos=self.root:getChildLocalPosition()
pos.x=xpos
self.root:setChildLocalPosition(pos)
end

function UICommonPageWin:refreshTitle(titleName)
titleName=titleName or self.defaultTitleName
self.titleText:setText(titleName)
end