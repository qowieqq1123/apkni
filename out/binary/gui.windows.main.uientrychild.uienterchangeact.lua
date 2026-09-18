







def_class("UIEnterChangeAct",UICloneObject)





UIEnterChangeAct.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterChangeAct.assetName="UIEnterNomalItem"


function UIEnterChangeAct:bindComponents()

self.icon=UIButton.get(self,0)
self.reddot=UIObject.get(self,1)
self.name=UIText.get(self,2)
self.time=UIText.get(self,3)
self.timeBg=UIObject.get(self,4)
self.qipao=UIObject.get(self,5)
self.qipaoText=UIText.get(self,6)
self.model=UIObject.get(self,7)
self.clickBg=UIButton.get(self,8)
self.extendbg=UIObject.get(self,9)
self.lldhQiPao=UIObject.get(self,10)

self.icon:setButtonClick(function()self:onIcon()end)

self.clickBg:setButtonClick(function()self:onClickBg()end)

end


function UIEnterChangeAct:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.qipao);self.qipao=nil;
_UIObject_release(self.qipaoText);self.qipaoText=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.clickBg);self.clickBg=nil;
_UIObject_release(self.extendbg);self.extendbg=nil;
_UIObject_release(self.lldhQiPao);self.lldhQiPao=nil;
end






local iconname='act_entericon_59'
local _isInit=false

function UIEnterChangeAct:onLoaded()
self:bindComponents()
end

function UIEnterChangeAct:__delete()
self:stopTimer()

self:unbindComponents()
_isInit=false
end

function UIEnterChangeAct:onShow(info)
enterConfig.preInitEnter(self)
local cfg=self.__config
local abname=globalABLookup.mainEntrySprite

if not _isInit then

_isInit=true
end

self.widget:SetChildCSImageSprite(0,abname,iconname)
self.widget:SetChildActive(0,true)
self.widget:SetChildUIModelRemoveTarget(7)





self.reddot:setActive(false)


self.name:setText('')


self.qipao:setActive(false)

self.qipaoText:setText("")

self.extendbg:setActive(info.isEx or false)

self.time:setText('')
self.timeBg:setActive(false)

local _reddot=ChangeActController:checkHdReddotAll()
self.reddot:setActive(_reddot)

if false then
auctionController:removeAuctionEnter()
end

end

function UIEnterChangeAct:onHide()

end

function UIEnterChangeAct:freshReddot()
if not initProControl.isDone()then
return
end
local reddot=ChangeActController:checkHdReddotAll()
self.reddot:setActive(reddot)
end


function UIEnterChangeAct:startTimer()
self:stopTimer()
self.timer=timer.new()

local func
func=function()
local startTime,endTime,finalEndTime=auctionModel:getAuctionTime()
local nowTime=gameUtilityModel.getServerLongTime()
if not startTime then

self:stopTimer()
return
end

local lerp=endTime-nowTime
if lerp>0 then

local timeStr=nil
timeStr=timeHelper.format_time_stamp3(lerp,true)
self.time:setText(timeStr)
self.timeBg:setActive(true)
else
lerp=finalEndTime-nowTime
if lerp>0 then

self.time:setText('')
self.timeBg:setActive(false)
else

auctionController:removeAuctionEnter()
end
end
end
self.timer:start(1,func)

func()
end
function UIEnterChangeAct:stopTimer()
if self.timer then
self.timer:cancel()
end
self.timer=nil
end
function UIEnterChangeAct:stopBubbleTimer()
if self.bubbleTimer then
self.bubbleTimer:cancel()
end
self.bubbleTimer=nil
end
function UIEnterChangeAct:ShowBubble()
self:stopBubbleTimer()


self.qipao:setActive(true)

self.qipaoText:setText('竞价被超')

self.bubbleTimer=timer.new()


local bubbleShowTime=auctionModel:getBubbleShowTime()
self.bubbleTimer:start(bubbleShowTime,function()
self.qipao:setActive(false)
self:stopBubbleTimer()
end,1)


auctionModel:setBubbleShowFlag(false)

self.jumpToSelfBiddingType=true
end
function UIEnterChangeAct.endCloud(type)
if type==1 then


local cur=mainControl:getSceneType()
if cur==eSceneType.eZongmen then

auctionController.checkBubble()
end
elseif type==2 then


if zongmenControl:isMountid(mapIdType.zhufeng)then

auctionController.checkBubble()
end
end
end


function UIEnterChangeAct:onIcon()



UIFullWelfareController:showWindowChangeAct()
end
function UIEnterChangeAct:onClickBg()
self:onIcon()
end