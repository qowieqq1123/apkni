







def_class("UISpeakVoiceWin",UIWindowBase)









function UISpeakVoiceWin:bindComponents()

self.laba=UIObject.get(self,0)
self.cancelObj=UIObject.get(self,1)
self.desc=UIText.get(self,2)
self.ani=UIObject.get(self,3)



end


function UISpeakVoiceWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.laba);self.laba=nil;
_UIObject_release(self.cancelObj);self.cancelObj=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.ani);self.ani=nil;
end


















function UISpeakVoiceWin:onLoaded(...)
self:bindComponents()
end

function UISpeakVoiceWin:__delete()
self:unbindComponents()
end

function UISpeakVoiceWin:onShow(argtable,afterOnloaded)
self:setRecord()
end

function UISpeakVoiceWin:onHide()

end



function UISpeakVoiceWin:setCancel()
self.cancelObj:setActive(true)
self.laba:setActive(false)
self.winlua:SetChildAnimationStatus(self.ani:getID(),2)
if not self.outCount then
self.desc:setText('松开取消发送')
end
end

function UISpeakVoiceWin:setRecord()
self.cancelObj:setActive(false)
self.laba:setActive(true)
self.winlua:SetChildAnimationStringID(self.ani:getID(),'chatVoice',true)
if not self.outCount then
self.desc:setText('按住说话\n手指下滑，取消发送')
end
end

function UISpeakVoiceWin:showCount(sec)
self.outCount=true
self.desc:setText(FMT.fmt('{0}秒后将停止录音 ',sec))
end
