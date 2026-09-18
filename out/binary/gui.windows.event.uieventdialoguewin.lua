







def_class("UIEventDialogueWin",UIWindowBase)









function UIEventDialogueWin:bindComponents()

self.root=UIObject.get(self,0)
self.reddotImage=UIObject.get(self,1)
self.clockRoot=UIObject.get(self,2)
self.finishImage=UIObject.get(self,3)
self.btn=UIButton.get(self,4)
self.info=UIObject.get(self,5)
self.reddotTxt=UIText.get(self,6)
self.time=UIText.get(self,7)
self.eventInfo1=UIObject.get(self,8)
self.eventInfo2=UIObject.get(self,9)
self.eventInfo3=UIObject.get(self,10)
self.eventInfo4=UIObject.get(self,11)
self.eventInfo5=UIObject.get(self,12)

self.btn:setButtonClick(function()self:onBtn()end)



end


function UIEventDialogueWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.reddotImage);self.reddotImage=nil;
_UIObject_release(self.clockRoot);self.clockRoot=nil;
_UIObject_release(self.finishImage);self.finishImage=nil;
_UIObject_release(self.btn);self.btn=nil;
_UIObject_release(self.info);self.info=nil;
_UIObject_release(self.reddotTxt);self.reddotTxt=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.eventInfo1);self.eventInfo1=nil;
_UIObject_release(self.eventInfo2);self.eventInfo2=nil;
_UIObject_release(self.eventInfo3);self.eventInfo3=nil;
_UIObject_release(self.eventInfo4);self.eventInfo4=nil;
_UIObject_release(self.eventInfo5);self.eventInfo5=nil;
end


















function UIEventDialogueWin:onLoaded(...)
self:bindComponents()
self._timer=self:setTimer(1,0,function()
if self and not self.isClose then

end
end)
self.infoList={}
local infoList=self.infoList
infoList[#infoList+1]=self.eventInfo1
infoList[#infoList+1]=self.eventInfo2
infoList[#infoList+1]=self.eventInfo3
infoList[#infoList+1]=self.eventInfo4
infoList[#infoList+1]=self.eventInfo5
end

function UIEventDialogueWin:__delete()
self:unbindComponents()
self:stopTimerByID(self._timer)
end

function UIEventDialogueWin:onShow(argtable,afterOnloaded)

end

function UIEventDialogueWin:onHide()

end


















































































