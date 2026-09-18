







def_class("UICommonLoadingWinEx",UIWindowBase)









function UICommonLoadingWinEx:bindComponents()

self.ani=UIObject.get(self,0)
self.effect=UIObject.get(self,1)
self.mask=UIObject.get(self,2)
self.progressBar=UIProgressBarAni.get(self,3)
self.root=UIObject.get(self,4)
self.title=UIText.get(self,5)



end


function UICommonLoadingWinEx:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ani);self.ani=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.title);self.title=nil;
end















local _this=nil



function UICommonLoadingWinEx:onLoaded(...)
self:bindComponents()
_this=self
self.progressBar:setFinishAction(function()
self:onProgressForwardFinish()
end)
end


function UICommonLoadingWinEx:__delete()
self:unbindComponents()
_this=nil

if self.overTimer then
self:stopTimerByID(self.overTimer)
self.overTimer=nil
end
end




function UICommonLoadingWinEx:onShow(argtable,afterOnloaded)
self.count=argtable.count
self.duration=argtable.duration or 0.5
self.overTime=argtable.over or 10
self.onSeg=argtable.onSeg
self.onCheck=argtable.onCheck
self.onComplete=argtable.onComplete
self.onOver=argtable.onOver
self.effectId=argtable.effect
self.index=0

self.title:setText(argtable.title or"请稍候片刻")
if self.effectId then
self.ani:setActive(false)
self.effect:setChildShowEffect(self.effectId,true)
else
self.ani:setActive(true)
self.winlua:SetChildSpineAnimation(self.ani:getID(),11,1,nil)
end
self:doProgressForward()
end


function UICommonLoadingWinEx:onHide()

end



function UICommonLoadingWinEx:doProgressForward()
local old=self.index
self.index=self.index+1
if self.index>self.count then
self.onComplete()
else
self.progressBar:animateFiveParams(old,self.index,self.count,self.duration,false)
if self.onSeg then
self.onSeg(self.index)
end
end
end

function UICommonLoadingWinEx:onProgressForwardFinish()
local complete=true
if self.onCheck then
complete=self.onCheck(self.index)
end

if complete then
self:doProgressForward()
else
self.countdown=self.overTime
self.overTimer=self:setTimer(1,self.overTime,function()
self:onOverTime()
end)
end
end

function UICommonLoadingWinEx:onOverTime()
self.countdown=self.countdown-1
local complete=true
if self.onCheck then
complete=self.onCheck(self.index)
end
if complete then
if self.overTimer then
self:stopTimerByID(self.overTimer)
self.overTimer=nil
end
self:doProgressForward()
elseif self.countdown<=0 then
if self.onOver then
self.onOver(self.index)
end
end
end