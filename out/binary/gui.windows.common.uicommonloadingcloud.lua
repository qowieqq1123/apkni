







def_class("UICommonLoadingCloud",UIWindowBase)









function UICommonLoadingCloud:bindComponents()

self.uiRoot=UIObject.get(self,0)
self.ani=UIObject.get(self,1)
self.progress=UIProgress.get(self,2)



end


function UICommonLoadingCloud:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.ani);self.ani=nil;
_UIObject_release(self.progress);self.progress=nil;
end



















function UICommonLoadingCloud:onLoaded(...)
self:bindComponents()
CS.BindWidget(self.ani:getWidgetBase(),self)
end


function UICommonLoadingCloud:__delete()
if not self.isStart then
self:onCloseFinish()
end
self:unbindComponents()
end

function UICommonLoadingCloud:onHide()
self.isClose=true
end




function UICommonLoadingCloud:onShow(argtable,afterOnloaded)
if argtable then
self.startCallback=argtable.startCallback
self.endCallback=argtable.endCallback
self.autoClose=argtable.autoClose or false


if argtable.closeDelay~=nil then
local delayClose=tonumber(argtable.closeDelay)
if delayClose>0 then
self:setTimer(delayClose,1,function()
if self and not self.isClose then
self:endAni()
self:delayDo(0.8,function()
if self and not self.isClose then
self:closeSelf()
end
end)
end
end)
end
end
end

if afterOnloaded==false then

if self.startCallback then
self.startCallback()
end

if self.endCallback then
self.endCallback()
end
return
end

self:startAni()

if self.outTime then
self:stopTimerByID(self.outTime)
end
self.outTime=self:delayDo(10,function()
if self and not self.isClose then
self:endAni()
end
end)
end


function UICommonLoadingCloud:onHide()

end

function UICommonLoadingCloud:startAni()
if self==nil or self.isClose then return end

AudioManager.playAudio(404)

self.winlua:SetChildAnimatorInteger(self.ani:getID(),'state',0,true)
end

function UICommonLoadingCloud:endAni()
if self.isPlayEnd then return end
self.isPlayEnd=true
notifySystem:postNotify(notifyConfig.startEndCloud,3)
if self==nil or self.isClose then return true end
self.winlua:SetChildAnimatorInteger(self.ani:getID(),'state',1,true)
return true
end

function UICommonLoadingCloud:onOpenSee()
notifySystem:postNotify(notifyConfig.endCloud,3)
end

function UICommonLoadingCloud:onCloseFinish()
if self==nil or self.isClose then return end
if self.startCallback then
self.startCallback()
self.isStart=true
if self.autoClose then
self:endAni()
end
end
end

function UICommonLoadingCloud:onOpenFinish()
if self==nil or self.isClose then return end
if self.endCallback then
self.endCallback()
end
self:closeSelf()
end
