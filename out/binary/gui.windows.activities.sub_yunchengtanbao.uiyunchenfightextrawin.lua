







def_class("UIYunChenFightExtraWin",UIWindowBase)









function UIYunChenFightExtraWin:bindComponents()

self.selfHeadIcon=UIImage.get(self,0)
self.selfHeadKuang=UIImage.get(self,1)
self.selfSpeak=UIObject.get(self,2)
self.otherHeadIcon=UIImage.get(self,3)
self.otherHeadKuang=UIImage.get(self,4)
self.selfSpeakTxt=UIText.get(self,5)
self.Placeholder=UIText.get(self,6)
self.editSpeak=UIObject.get(self,7)
self.selfInfo=UIObject.get(self,8)
self.otherInfo=UIObject.get(self,9)
self.otherSpeakTxt=UIText.get(self,10)
self.InputSentence=UIInputField.get(self,11)
self.fightDescObj=UIObject.get(self,12)
self.fightDescTxt=UIText.get(self,13)
self.speakObj=UIObject.get(self,14)
self.speakText=UIText.get(self,15)
self.qipaoplayer=UIObject.get(self,16)



end


function UIYunChenFightExtraWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.selfHeadIcon);self.selfHeadIcon=nil;
_UIObject_release(self.selfHeadKuang);self.selfHeadKuang=nil;
_UIObject_release(self.selfSpeak);self.selfSpeak=nil;
_UIObject_release(self.otherHeadIcon);self.otherHeadIcon=nil;
_UIObject_release(self.otherHeadKuang);self.otherHeadKuang=nil;
_UIObject_release(self.selfSpeakTxt);self.selfSpeakTxt=nil;
_UIObject_release(self.Placeholder);self.Placeholder=nil;
_UIObject_release(self.editSpeak);self.editSpeak=nil;
_UIObject_release(self.selfInfo);self.selfInfo=nil;
_UIObject_release(self.otherInfo);self.otherInfo=nil;
_UIObject_release(self.otherSpeakTxt);self.otherSpeakTxt=nil;
_UIObject_release(self.InputSentence);self.InputSentence=nil;
_UIObject_release(self.fightDescObj);self.fightDescObj=nil;
_UIObject_release(self.fightDescTxt);self.fightDescTxt=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.qipaoplayer);self.qipaoplayer=nil;
end

















local _this


function UIYunChenFightExtraWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIYunChenFightExtraWin:__delete()
self:unbindComponents()
end




function UIYunChenFightExtraWin:onShow(argtable,afterOnloaded)
if argtable then
self.txt=argtable.txt
self.fightDescTxt:setText(self.txt or'5回合之内取得胜利')
end
_this:delayDo(1.2,function()
UIYunChenFightExtraWin:doSpeaking_player()
end)
end


function UIYunChenFightExtraWin:onHide()

end






function UIYunChenFightExtraWin:doSpeaking_player(speakType)














local speed=30
local str='吾纵横多年，未逢一败，无敌真寂寞啊'
_this.speakObj:setChildCanvasGroupAlpha(1)
_this.speakText:setChildTrendsTextPlay(str,speed,nil)
_this:doTalkAnim_player()
end

function UIYunChenFightExtraWin:doTalkAnim_player()
if _this.talkTween2~=nil then
_this.talkTween2:Kill()
_this.talkTween2=nil
end

_this.speakObj:setScale(Vector3.zero)
_this:delayDo(0.2,function()
_this.speakObj:setChildCanvasGroupAlpha(1)
_this.talkTween2=_this.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween2=nil
_this.talkTween2=_this.speakObj:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween2=nil
return _this:talkEnd()
end)
end)
end)
end
function UIYunChenFightExtraWin:talkEnd()
if _this.speakShowTimer then
_this:stopTimerByID(_this.speakShowTimer)
_this.speakShowTimer=nil
end
_this.speakShowTimer=_this:delayDo(20,function()

if _this==nil then return end
_this.speakObj:setScale(Vector3.zero)
_this.speakObj:setChildCanvasGroupAlpha(0)

if _this.speakShowTimer then
_this:stopTimerByID(_this.speakShowTimer)
_this.speakShowTimer=nil
end
end)
end