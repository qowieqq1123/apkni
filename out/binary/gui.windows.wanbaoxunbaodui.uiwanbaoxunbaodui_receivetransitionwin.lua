







def_class("UIWanBaoXunBaoDui_ReceiveTransitionWin",UIWindowBase)









function UIWanBaoXunBaoDui_ReceiveTransitionWin:bindComponents()

self.catModelTemp=UIObject.get(self,0)
self.playDoingAnimatPart=UIObject.get(self,1)
self.playDoingModelList=UIObject.get(self,2)
self.playDoingProgressBar=UIObject.get(self,3)
self.playDoingProgressKuang=UIProgressBarAni.get(self,4)
self.playDoingTipTxt=UIText.get(self,5)
self.progressWaitSpine=UIObject.get(self,6)
self.Root=UIObject.get(self,7)



end


function UIWanBaoXunBaoDui_ReceiveTransitionWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.catModelTemp);self.catModelTemp=nil;
_UIObject_release(self.playDoingAnimatPart);self.playDoingAnimatPart=nil;
_UIObject_release(self.playDoingModelList);self.playDoingModelList=nil;
_UIObject_release(self.playDoingProgressBar);self.playDoingProgressBar=nil;
_UIObject_release(self.playDoingProgressKuang);self.playDoingProgressKuang=nil;
_UIObject_release(self.playDoingTipTxt);self.playDoingTipTxt=nil;
_UIObject_release(self.progressWaitSpine);self.progressWaitSpine=nil;
_UIObject_release(self.Root);self.Root=nil;
end



















function UIWanBaoXunBaoDui_ReceiveTransitionWin:onLoaded(...)
self:bindComponents()
end


function UIWanBaoXunBaoDui_ReceiveTransitionWin:__delete()
self:unbindComponents()
end




function UIWanBaoXunBaoDui_ReceiveTransitionWin:onShow(argtable,afterOnloaded)
self.channel_ids=argtable and argtable.channel_ids or{}
self.catList=argtable and argtable.catList or{}

self:preparePlayDoingAnimation()


self:delayDo(15,function()
if not self or self.isClose then return end
self:closeSelf()
end)
end


function UIWanBaoXunBaoDui_ReceiveTransitionWin:onHide()

end





function UIWanBaoXunBaoDui_ReceiveTransitionWin:initPlayAnmation()
self.playDoingAnimatPart:setActive(false)
end

function UIWanBaoXunBaoDui_ReceiveTransitionWin:preparePlayDoingAnimation()

self.playDoingAnimatPart:setActive(true)
self.playDoingProgressBar:setChildIconFillAmount(0)


local len=#self.catList
if len>0 then
self.playDoingModelList:setChildLayoutGroupCreateItems(len,function(index)
local item=self.playDoingModelList:getChildLayoutGroupGridItem(index-1)

local catGuid=self.catList[index]
local catData=wanBaoXunBaoDuiModel:getCatData(catGuid)

local modelid,components=wanbaoXunBaoDuiHelper:getCatModelCaptureImageParam(catData)
item:SetChildUIModelShowTarget(-1,modelid,1.5,components,eAnimationID.run,false,false,0.2,nil)
item:SetChildUIModelShowFlipX(-1,true)
end)
end


self:playDoingAnimation(1)
end

function UIWanBaoXunBaoDui_ReceiveTransitionWin:playDoingAnimation(len)
local _this=self


local timeList={}
local doing_time={0.02,0.3}
local totalDuration=0

local start_end_txt={"猫猫收入探险奖励中"}
local txtList={string.toTable(start_end_txt[1])}

local caculTime=function(worlds,isShowWaitSpine)
local startWorldTime=#worlds*doing_time[1]
totalDuration=totalDuration+startWorldTime
if isShowWaitSpine then
totalDuration=totalDuration+doing_time[2]
end
timeList[#txtList]=totalDuration
end
caculTime(txtList[1],true)


local curTime=0

local getTxtTSubStr=function(txtT,sIndex,eIndex)
local strTemp=""
for index=sIndex,eIndex do
strTemp=strTemp..txtT[index]
end
return strTemp
end


local getTxt=function(index,time)
local txtT=txtList[index]
local charLen=#txtT

local preTime=timeList[index-1]or 0
local residueTime=time-preTime
local charIndex=Mathf.Ceil(residueTime/doing_time[1])
local isSplit=charLen>=charIndex
charIndex=isSplit and charIndex or charLen

return getTxtTSubStr(txtT,1,charIndex),isSplit
end

local curShowSpeakIndex=1
local isShowWaitSpine=false
local func=function()
curTime=curTime+Time.deltaTime
if curTime>=totalDuration then
_this:stopTimerByID(_this.playTimerID)
_this.playTimerID=nil

_this:finishPlayDoingAnimation(len)
else

self.playDoingProgressBar:setChildIconFillAmount(curTime/totalDuration)


local txt,isSplit=getTxt(curShowSpeakIndex,curTime)
_this.playDoingTipTxt:setText(txt)
_this.progressWaitSpine:setActive(not isSplit)
if not isSplit and not isShowWaitSpine then
isShowWaitSpine=true
_this.progressWaitSpine:setChildUIModelShowTarget(5476,1,{},eAnimationID.stand,false,false,0.1)
end

if curTime>=timeList[curShowSpeakIndex]then
curShowSpeakIndex=curShowSpeakIndex+1
isShowWaitSpine=false
end
end
end

if self.playTimerID then
_this:stopTimerByID(self.playTimerID)
self.playTimerID=nil
end

self.playTimerID=self:setTimer(0.05,-1,func)
end

function UIWanBaoXunBaoDui_ReceiveTransitionWin:finishPlayDoingAnimation(len)
wanBaoXunBaoDuiController:reqFinishReturn(self.channel_ids)
end