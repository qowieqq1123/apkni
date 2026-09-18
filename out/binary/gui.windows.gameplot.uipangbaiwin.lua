







def_class("UIPangBaiWin",UIWindowBase)









function UIPangBaiWin:bindComponents()

self.talkdesc=UIText.get(self,0)



end


function UIPangBaiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.talkdesc);self.talkdesc=nil;
end

















local lookingTime=5


function UIPangBaiWin:onLoaded(...)
self:bindComponents()
end


function UIPangBaiWin:__delete()
self:unbindComponents()
end




function UIPangBaiWin:onShow(argtable,afterOnloaded)
self.speakList=argtable.speakList
self.showType=argtable.showType
self.callback=argtable.callback

if self.speakList==nil or#self.speakList==0 then
self.speakList={'没有设置旁白话语'}
end

self.speakNum=#self.speakList
self.speakIndex=0

self:doNext()
end


function UIPangBaiWin:onHide()

end

function UIPangBaiWin:doNext()
self.speakIndex=self.speakIndex+1
if self.speakIndex<=self.speakNum then
self:showTalk()
else
self:onCommitClick()
end
end

function UIPangBaiWin:showTalk()

local desc=self.speakList[self.speakIndex]
local showType=self.showType or 0
if showType==0 then
self.talkdesc:setText(desc)
else
self.talkdesc:setChildCanvasGroupAlpha(0)

local speed=20
local func=function()
self:talkFinish()
end
self.talking=true
self.talkdesc:setChildTrendsTextPlay(desc,speed,func)

self.talkdesc:setChildCanvasGroupDOFade(1,0.3,nil)
end
end

function UIPangBaiWin:checkFinalDialogue()
return self.speakIndex>=self.speakNum
end

function UIPangBaiWin:talkFinish()
self.talking=false
if not self:checkFinalDialogue()then
self:clearLookingTimer()
self:setLookingTimer()
end
end

function UIPangBaiWin:setLookingTimer()
local func=function()
self:doNext()
end
self.lookingTimer=self:setTimer(lookingTime,1,func)
end

function UIPangBaiWin:clearLookingTimer()
if self.lookingTimer~=nil then
self:stopTimerByID(self.lookingTimer)
self.lookingTimer=nil
end
end



function UIPangBaiWin:onBackClick()
if self.talking then
self.talkdesc:setChildTrendsTextStop()
self.talking=false
self:clearLookingTimer()
self:setLookingTimer()
else
self:clearLookingTimer()
self:doNext()
end
end

function UIPangBaiWin:closeWin()
UIManager:closeWindow('UIPangBaiWin')
end

function UIPangBaiWin:onCommitClick()
if self:checkFinalDialogue()then
local cb=self.callback
self:closeWin()
if cb~=nil then cb()end
end
end