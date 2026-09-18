







def_class("UIXMXianWuLouModelWin",UIWindowBase)









function UIXMXianWuLouModelWin:bindComponents()

self.root=UIObject.get(self,0)
self.npcModel=UIObject.get(self,1)
self.speakObj=UIObject.get(self,2)
self.speakText=UIText.get(self,3)



end


function UIXMXianWuLouModelWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
end















local _this=nil



function UIXMXianWuLouModelWin:onLoaded(...)
self:bindComponents()
_this=self
self.speakIndex=1
self:initTalkTimer()
end


function UIXMXianWuLouModelWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXMXianWuLouModelWin:onShow(argtable,afterOnloaded)

local npcid=cfgHelper.get2(cfg_xianwuloubaseconfig_get,1,'npcid')
local modelParams=npcModel:getImageInfoOutSide(npcid)
local scale=1
self.npcModel:setChildUIModelShowTarget(modelParams.body,scale,modelParams.componets,eAnimationID.stand,false,true)
self.npcModel:setChildUIModelShowFlipX(true)

self:doMyAnim()
end


function UIXMXianWuLouModelWin:onHide()

end

function UIXMXianWuLouModelWin:onShowArgRecv()
self.speakIndex=1
self:finishSpeak()
end


function UIXMXianWuLouModelWin:doMyAnim()
self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.15,function()
self.root:setChildCanvasGroupDOFade(1,0.5)
end)
end



function UIXMXianWuLouModelWin:initTalkTimer()
local func=function()
self:updataTalk()
end
self:setTimer(1,0,func)
self.updataTimer=gameUtilityModel.getServerShortTime()+1
end

function UIXMXianWuLouModelWin:updataTalk()
if gameUtilityModel.getServerShortTime()>=self.updataTimer then
local delay
if UIFullXianMengXianWuLouControl.tabType==FULL_TAB_TYPE.eXianWuLou then
delay=self:updateTalkImp1()
elseif UIFullXianMengXianWuLouControl.tabType==FULL_TAB_TYPE.eXianMengKuFang then
delay=self:updateTalkImp3()
else
delay=self:updateTalkImp2()
end
self.updataTimer=gameUtilityModel.getServerShortTime()+delay
end
end

function UIXMXianWuLouModelWin:updateTalkImp1()
local delay
local delay2
local hasTask=xianmengModel:checkXWLHasTask()
if not hasTask then
delay=30
delay2=25
else
delay=10
delay2=5
end
self:doSpeaking(delay2,hasTask)
return delay
end

function UIXMXianWuLouModelWin:updateTalkImp3()
local delay=math.random(10,20)
local delay2=math.random(4,5)
local kfSelectTab=UIManager:invokeUIMethod("UIXMKuFangTabWin","getSelectTab")or 1
local cfgList=kfSelectTab==1 and"npctalklist3"or"npctalklist4"
local speakList=cfgHelper.get2(cfg_xianwuloubaseconfig_get,1,cfgList)
self.speakIndex=math.random(#speakList)
local speakStr=speakList[self.speakIndex]

self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setText(speakStr)
self:doTalkAnim()

self:delayDo(delay2,function()
self:finishSpeak()
end)
return delay+delay2
end

function UIXMXianWuLouModelWin:updateTalkImp2()
local delay=math.random(10,20)
local delay2=math.random(4,5)

local speakList=cfgHelper.get2(cfg_xianwuloubaseconfig_get,1,'npctalklist2')
self.speakIndex=math.random(#speakList)
local speakStr=speakList[self.speakIndex]

self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setText(speakStr)
self:doTalkAnim()

self:delayDo(delay2,function()
self:finishSpeak()
end)
return delay+delay2
end

function UIXMXianWuLouModelWin:doSpeaking(delay,hasTask)
local speakStr
if hasTask then
local npctalklist=cfgHelper.get2(cfg_xianwuloubaseconfig_get,1,'npctalklist')
local speakIndex=self.speakIndex
speakStr=npctalklist[speakIndex]
speakIndex=speakIndex+1
if speakIndex>#npctalklist then
speakIndex=1
end
self.speakIndex=speakIndex
else
speakStr=cfgHelper.get2(cfg_xianwuloubaseconfig_get,1,'npctalk')
end
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setText(speakStr)
self:doTalkAnim()

self:delayDo(delay,function()
self:finishSpeak()
end)
end

function UIXMXianWuLouModelWin:doTalkAnim()
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end
self.speakObj:setScale(Vector3.zero)
self:delayDo(0.2,function()
self.speakObj:setChildCanvasGroupAlpha(1)
self.talkTween=self.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween=nil
_this.talkTween=_this.speakObj:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween=nil
end)
end)
end)
end

function UIXMXianWuLouModelWin:finishSpeak()
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end
self.speakObj:setChildCanvasGroupAlpha(0)
end

