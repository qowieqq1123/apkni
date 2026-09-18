







def_class("UIEnterAuction",UICloneObject)





UIEnterAuction.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterAuction.assetName="UIEnterNomalItem"


function UIEnterAuction:bindComponents()

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


function UIEnterAuction:unbindComponents()
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






local iconname='button_hdrk_0012'
local _isInit=false

function UIEnterAuction:onLoaded()
self:bindComponents()
end

function UIEnterAuction:__delete()
self:stopTimer()
notifySystem:removelistener(notifyConfig.endCloud,self.endCloud)
_isInit=false
self:unbindComponents()
end

function UIEnterAuction:onShow(info)
enterConfig.preInitEnter(self)
local cfg=self.__config
local abname=enterConfig.getSpriteAB()

if not _isInit then
notifySystem:listenNotify(notifyConfig.endCloud,self.endCloud)
_isInit=true
end

self.widget:SetChildCSImageSprite(0,abname,iconname)
self.widget:SetChildActive(0,true)
self.widget:SetChildUIModelRemoveTarget(7)





self.reddot:setActive(false)


self.name:setText('')


self.qipao:setActive(false)

self.qipaoText:setText("竞价被超")

self.extendbg:setActive(info.isEx or false)

if systemModel.isOpen(SYSTEM_DEFINE.eAuction)then
local state=auctionModel:getAuctionState()
if state==0 or state==3 then

auctionController:removeAuctionEnter()
else
if state==1 then

self.time:setText('')
self.timeBg:setActive(true)
elseif state==2 then

self.time:setText('')
self.timeBg:setActive(false)
end

self:startTimer()
end
end
end

function UIEnterAuction:onHide()

end

function UIEnterAuction:freshReddot()
if not initProControl.isDone()then
return
end

local reddot=false
self.reddot:setActive(reddot)
end

function UIEnterAuction:startTimer()
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

function UIEnterAuction:stopTimer()
if self.timer then
self.timer:cancel()
end
self.timer=nil
end

function UIEnterAuction:stopBubbleTimer()
if self.bubbleTimer then
self.bubbleTimer:cancel()
end
self.bubbleTimer=nil
end

function UIEnterAuction:ShowBubble()
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

function UIEnterAuction:onIcon()
if not systemModel.isOpen(SYSTEM_DEFINE.eAuction)then
UIManager.info("拍卖会系统未开启")
return
end

local args=nil
if self.jumpToSelfBiddingType then
args={}
args.selectItemType=2
self.jumpToSelfBiddingType=false
end
UIFullAuctionController:showMainUI(args)
end

function UIEnterAuction.endCloud(type)
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

function UIEnterAuction:onClickBg()
self:onIcon()
end