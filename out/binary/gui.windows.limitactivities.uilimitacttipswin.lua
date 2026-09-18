







def_class("UILimitActTipsWin",UIWindowBase)









function UILimitActTipsWin:bindComponents()

self.actBGImg=UIImage.get(self,0)
self.actIconImg=UIImage.get(self,1)
self.actNameTxt=UIText.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.gotoBtn=UIButton.get(self,4)
self.gotoTex=UIText.get(self,5)
self.root=UIObject.get(self,6)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)



end


function UILimitActTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.actBGImg);self.actBGImg=nil;
_UIObject_release(self.actIconImg);self.actIconImg=nil;
_UIObject_release(self.actNameTxt);self.actNameTxt=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.gotoTex);self.gotoTex=nil;
_UIObject_release(self.root);self.root=nil;
end
















local _this


function UILimitActTipsWin:onLoaded(...)
_this=self
self:bindComponents()

notifySystem:listenNotify(notifyConfig.onLimitActOpen,self.onLimitActOpen)
notifySystem:listenNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
end


function UILimitActTipsWin:__delete()
_this=nil
self:unbindComponents()

notifySystem:removelistener(notifyConfig.onLimitActOpen,self.onLimitActOpen)
notifySystem:removelistener(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
notifySystem:removelistener(notifyConfig.onNewDay,self.onNewDay)
end


function UILimitActTipsWin:onHide()

end

function UILimitActTipsWin.onLimitActOpen(actID,flag)
if _this==nil then return end
if _this.actID~=actID then return end

if not flag then
_this:onCloseClick()
end
end

function UILimitActTipsWin.onLimitActStateChange(actID,state)
if _this==nil then return end
if _this.actID~=actID then return end

if state~=limitActivitiesModel.actDoingState then
_this:onCloseClick()
end
end


function UILimitActTipsWin.onNewDay()
if _this==nil then return end

_this:onCloseClick()
end




function UILimitActTipsWin:onShow(argtable,afterOnloaded)
self.actID=argtable.actID
self.tipsType=argtable.typo
self.name=argtable.name
self.gotoExtraParams=argtable.gotoExtraParams
self:handleOtherParameters(argtable)
self:refreshView()
end

function UILimitActTipsWin:refreshView()
local actCfg=limitActivitiesModel:getActConfig(self.actID)

local iconInfo,iconInfo2=limitActivitiesModel.getActBigIcon(self.actID,1)
self.actIconImg:setSprite(iconInfo[1],iconInfo[2])

self.actBGImg:setSprite(iconInfo2[1],iconInfo2[2])

self.actNameTxt:setText(self.name or actCfg.name)
end

function UILimitActTipsWin:handleOtherParameters(argtable)
local tipsText=argtable.tipsText
local gotoText=argtable.gotoText

if tipsText then
self.name=tipsText
end

if gotoText then
self.gotoTex:setText(gotoText)
end
end

function UILimitActTipsWin:onCloseClick()
local actID=self.actID
local tipsType=self.tipsType
self:closeSelf()

mainTipsController:onCloseWin(tipsType)
end

function UILimitActTipsWin:onGotoBtn()
local actID=self.actID
local extraParams=self.gotoExtraParams
self:onCloseClick()

limitActivitiesController:jump(actID,extraParams)
end

function UILimitActTipsWin:onCloseBtn()
self:onCloseClick()
end