







def_class("UIChuanSongZhenWaitRewardWin",UIWindowBase)









function UIChuanSongZhenWaitRewardWin:bindComponents()

self.dzModelTemp=UIObject.get(self,0)
self.playDoingAnimatPart=UIObject.get(self,1)
self.playDoingProgressBar=UIObject.get(self,2)
self.playDoingProgressKuang=UIProgressBarAni.get(self,3)
self.playDoingTipTxt=UIText.get(self,4)
self.Root=UIObject.get(self,5)



end


function UIChuanSongZhenWaitRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.dzModelTemp);self.dzModelTemp=nil;
_UIObject_release(self.playDoingAnimatPart);self.playDoingAnimatPart=nil;
_UIObject_release(self.playDoingProgressBar);self.playDoingProgressBar=nil;
_UIObject_release(self.playDoingProgressKuang);self.playDoingProgressKuang=nil;
_UIObject_release(self.playDoingTipTxt);self.playDoingTipTxt=nil;
_UIObject_release(self.Root);self.Root=nil;
end
















local _this

local defaultEntrustSlotItemName='CatEntrustItem'




function UIChuanSongZhenWaitRewardWin:onLoaded(...)
self:bindComponents()


_this=self
end


function UIChuanSongZhenWaitRewardWin:__delete()
self:unbindComponents()
if self.playTimerID then
self:stopTimerByID(self.playTimerID)
self.playTimerID=nil
end
end




function UIChuanSongZhenWaitRewardWin:onShow(argtable,afterOnloaded)


self:preparePlayDoingAnimation(argtable)

end


function UIChuanSongZhenWaitRewardWin:onHide()

end


function UIChuanSongZhenWaitRewardWin:preparePlayDoingAnimation()
local cfg=cfg_worldtravelconfig()
local dzguidList={}
for i,v in pairs(cfg)do
if type(i)=='number'and worldBlockModel:getWorldStateCount(i,eWorldBlockState.OPEN)>0 then
local list=chuanSongZhenModel:getDisciples(i)
for i,discipleGuid in pairs(list)do
table.insert(dzguidList,discipleGuid)
end
end
end

local dzguid=dzguidList[math.random(1,#dzguidList)]


self.playDoingAnimatPart:setActive(true)
local item=self.winlua:GetChildWidgetBase(self.dzModelTemp:getID())

local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(dzguid,true,1)
self.dzModelTemp:setChildUIModelShowTarget(modelParams.body,modelParams.scale,modelParams.componets,eAnimationID.run,false,false)
self.dzModelTemp:setChildUIModelShowTargetOffset(0,0)


self:playDoingAnimation()
end

function UIChuanSongZhenWaitRewardWin:playDoingAnimation()
local totalDuration=1
local curTime=0
local str="弟子正在整理收获"
local txtTab=string.toTable(str)

local getTxtTSubStr=function(txtT,sIndex,eIndex)
local strTemp=""
for index=sIndex,eIndex do
strTemp=strTemp..txtT[index]
end
return strTemp
end

local getTxt=function(time)
local txtT=txtTab
local charLen=#txtT

local charIndex=Mathf.Ceil(time/0.02)
local isSplit=charLen>=charIndex
charIndex=isSplit and charIndex or charLen

return getTxtTSubStr(txtT,1,charIndex),isSplit
end

local isShowWaitSpine=false
local func=function()
curTime=curTime+Time.deltaTime
if curTime>=totalDuration then
_this:stopTimerByID(_this.playTimerID)
_this.playTimerID=nil
_this:finishPlayDoingAnimation()
else

_this.playDoingProgressBar:setChildIconFillAmount(curTime/totalDuration)
if not isShowWaitSpine then

local txt,isSplit=getTxt(curTime)
_this.playDoingTipTxt:setText(txt)
if not isSplit then
isShowWaitSpine=true
end
end
end
end

if self.playTimerID then
_this:stopTimerByID(self.playTimerID)
self.playTimerID=nil
end

self.playTimerID=self:setTimer(0.05,-1,func)
end

function UIChuanSongZhenWaitRewardWin:finishPlayDoingAnimation()
self:closeSelf()
chuanSongZhenController.showPrize()
end
