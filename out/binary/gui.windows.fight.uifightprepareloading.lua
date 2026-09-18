







def_class("UIFightPrepareLoading",UIWindowBase)









function UIFightPrepareLoading:bindComponents()

self.uiRoot=UIObject.get(self,0)
self.ani=UIObject.get(self,1)
self.progress=UIProgress.get(self,2)



end


function UIFightPrepareLoading:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.ani);self.ani=nil;
_UIObject_release(self.progress);self.progress=nil;
end



















function UIFightPrepareLoading:onLoaded(...)
self:bindComponents()
CS.BindWidget(self.ani:getWidgetBase(),self)
end


function UIFightPrepareLoading:__delete()
if not self.isStart then
self:onCloseFinish()
end
self:unbindComponents()
end




function UIFightPrepareLoading:onShow(argtable,afterOnloaded)
if argtable then
self.startCallback=argtable.startCallback
self.endCallback=argtable.endCallback
self.endDelay=argtable.endDelay

if argtable.para~=nil then
local delayClose=tonumber(argtable.para)
if delayClose>0 then
self:setTimer(delayClose,1,function()
if self and not self.isClose then
self:endAni()
self:setTimer(0.8,1,function()
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
end


function UIFightPrepareLoading:onHide()

end

function UIFightPrepareLoading:startAni()

AudioManager.playAudio(404)
self.winlua:SetChildAnimatorInteger(self.ani:getID(),'state',0,true)
end

function UIFightPrepareLoading:endAni()
notifySystem:postNotify(notifyConfig.startEndCloud,2)
self.winlua:SetChildAnimatorInteger(self.ani:getID(),'state',1,true)
if self.endDelay then
self:delayDo(self.endDelay,function()
UIManager:closeWindow('UIFightPrepareLoading')
end)
end
return true
end

function UIFightPrepareLoading:onOpenSee()
notifySystem:postNotify(notifyConfig.endCloud,2)
end

function UIFightPrepareLoading:onCloseFinish()
if self.startCallback then
self.startCallback()
self.isStart=true
end
end

function UIFightPrepareLoading:onOpenFinish()
if self.endCallback then
self.endCallback()
end
self:closeSelf()
end



