







def_class("UISubAct_zongmendabi_score_win",UIWindowBase)









function UISubAct_zongmendabi_score_win:bindComponents()

self.progress=UIObject.get(self,0)
self.jifenCountText=UIText.get(self,1)
self.timeText=UIText.get(self,2)
self.progressRewardScrollView=UIObject.get(self,3)
self.progressBar=UIObject.get(self,4)
self.progressContent=UIObject.get(self,5)



end


function UISubAct_zongmendabi_score_win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.jifenCountText);self.jifenCountText=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.progressRewardScrollView);self.progressRewardScrollView=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressContent);self.progressContent=nil;
end














local _this
local progressRewardItemIndex={
jifenText=0,
select=1,
click=2,
itemList=3,
mask=4,
gotFlag=5,
effect=6,
}




function UISubAct_zongmendabi_score_win:onLoaded(...)
_this=self
self:bindComponents()

self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function UISubAct_zongmendabi_score_win:__delete()
self.progressRewardScrollView:setActive(false)
self:unbindComponents()
_this=nil
end




function UISubAct_zongmendabi_score_win:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.activityId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
if argtable.parentWin then
self.parentWin=argtable.parentWin
end














self.rewardCfg=cfg_sectscoreconfig()

self:refresh(true)
end
end


function UISubAct_zongmendabi_score_win:onHide()
self.progressRewardScrollView:setActive(false)
end


function UISubAct_zongmendabi_score_win:refreshData()


self.zmScore=moneyModel.getMoney(eMoneyType.mtSectScore)
self.nowProgressPoint=zongmenModel:getZongMenScoreGetRewardProgressPoint()






end


function UISubAct_zongmendabi_score_win:refresh(isNeedJump)
self:refreshData()
local nowJifen=self.zmScore
local nowProgressPoint=self.nowProgressPoint


local progressCfg=self.rewardCfg
local progressRewardCount=#progressCfg
self.progressRewardScrollView:setChildScrollViewCreateGrids(progressRewardCount,progressRewardCount)
self.progressRewardScrollView:setActive(true)
local grids=self.progressRewardScrollView:getChildScrollViewItemWidgets()
local count=grids.Count

for index=1,count do
local progressRewardItem=grids[index-1]
local config=progressCfg[index]
if progressRewardItem and config then
local needJifen=config.score
local rewardList=config.reward

local canGet=nowJifen>=needJifen
local isGot=nowProgressPoint>=index


progressRewardItem:SetChildText(progressRewardItemIndex.jifenText,needJifen)


local isSelect=canGet and not isGot
progressRewardItem:SetChildActive(progressRewardItemIndex.select,isSelect)
local effectId="zmdb_score"
progressRewardItem:SetChildActive(progressRewardItemIndex.effect,isSelect)
if isSelect then
progressRewardItem:SetChildAnimationStringID(progressRewardItemIndex.effect,effectId,false)
end


progressRewardItem:SetChildActive(progressRewardItemIndex.gotFlag,isGot)
progressRewardItem:SetChildActive(progressRewardItemIndex.mask,isGot)


if canGet and not isGot then

progressRewardItem:SetChildButtonClick(progressRewardItemIndex.click,function()
self:onClickProgressRewardItem(index)
end)
elseif isGot then

progressRewardItem:SetChildButtonClick(progressRewardItemIndex.click,function()
end)
else

progressRewardItem:SetChildButtonClick(progressRewardItemIndex.click,function()
UIManager.error("累计积分不足")
end)
end


local rewardsGrids=progressRewardItem:GetChildCommonLayoutGroupWidgetList(progressRewardItemIndex.itemList)
for i=1,rewardsGrids.Count do
local rewardItem=rewardsGrids[i-1]
local reward=rewardList[i]
if reward then
local itemid=reward[1]
local itemCount=reward[2]
local countStr=''
local showCountBG=false
if itemCount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemCount)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildActive(-1,true)
rewardItem:SetChildPropData(-1,prop)


if canGet and not isGot then

rewardItem:SetChildButtonClick(1,function()
self:onClickProgressRewardItem(index)
end)
else

rewardItem:SetChildButtonClick(1,function()
self:onClickRewardItem(itemid)
end)
end

rewardItem:SetChildLongTouch(1,i,0.5,function()
self:onClickRewardItem(itemid)
end)
else
rewardItem:SetChildActive(-1,false)
end
end
end
end


self:refreshProgress(isNeedJump)



self.jifenCountText:setText(nowJifen)
end


function UISubAct_zongmendabi_score_win:refreshProgress(isNeedJump)
local progressCfg=self.rewardCfg
local progressPercent=0
local maxProgressPoint=#progressCfg
local nowJifen=self.zmScore
local nowProgressPoint=self.nowProgressPoint


if nowJifen then
local jifenPoint=0
for i=1,maxProgressPoint do
if nowJifen>=progressCfg[i].score then
jifenPoint=progressCfg[i].id
else
break
end
end

if jifenPoint<maxProgressPoint then
if jifenPoint>0 then
progressPercent=jifenPoint/maxProgressPoint
else
progressPercent=0
end

local pointJifen=jifenPoint>0 and progressCfg[jifenPoint].score or 0
local nextProgressPoint=jifenPoint+1
if nextProgressPoint>maxProgressPoint then
nextProgressPoint=maxProgressPoint
end
local nextJifen=progressCfg[nextProgressPoint].score

local addPercent=((nowJifen-pointJifen)/(nextJifen-pointJifen))

progressPercent=progressPercent+(addPercent/maxProgressPoint)
else
progressPercent=1
end
end


local itemWidth=159
local space=1
local startOffset_X=105
local endOffset_X=145
local beforeWidth=580
local initProgressWidth=110

local contentWidth=startOffset_X+(itemWidth+space)*maxProgressPoint-space+(endOffset_X-startOffset_X)
local progressBarWidth=beforeWidth+contentWidth-itemWidth/2-(endOffset_X-startOffset_X)
local progressBarHeight=self.progressBar:getChildSizeDeltaY()
self.progressBar:setChildSizeDelta(progressBarWidth+2,progressBarHeight)


local firstPointDis=itemWidth/2+startOffset_X-initProgressWidth
local firstProgressPercent=1/maxProgressPoint
local afterProgressPercent=progressPercent-firstProgressPercent
if progressPercent<firstProgressPercent then
firstProgressPercent=progressPercent
afterProgressPercent=0
end

local progressWidth=firstPointDis*(firstProgressPercent*maxProgressPoint)
+(progressBarWidth-(beforeWidth+initProgressWidth+firstPointDis))*(afterProgressPercent*maxProgressPoint/(maxProgressPoint-1))
+(beforeWidth+initProgressWidth)
if progressPercent<=0 then
progressWidth=0
end
local progressHeight=self.progress:getChildSizeDeltaY()
self.progress:setChildSizeDelta(progressWidth,progressHeight)

if isNeedJump then

local showWidth=self.progressRewardScrollView:getChildRectWidth()
local contentPosX
local finalGotItemPos
if nowProgressPoint<=0 then
finalGotItemPos=0
else
finalGotItemPos=startOffset_X+(itemWidth+space)*(nowProgressPoint-1)+itemWidth/2
end

local targetShowPos=startOffset_X-30

if finalGotItemPos<=targetShowPos then

contentPosX=0
elseif finalGotItemPos>=contentWidth-(showWidth-targetShowPos)then

contentPosX=contentWidth-showWidth
else

contentPosX=finalGotItemPos-targetShowPos
end
self.progressContent:setLocalPosX(-contentPosX)
end
end



function UISubAct_zongmendabi_score_win:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid,})
end


function UISubAct_zongmendabi_score_win:onClickProgressRewardItem(progressPoint)
local maxIndex=progressPoint

local nowJifen=self.zmScore
local nowProgressPoint=self.nowProgressPoint


local progressCfg=self.rewardCfg
local progressRewardCount=#progressCfg

for index=progressPoint,progressRewardCount do
local config=progressCfg[index]
local needJifen=config.score

local canGet=nowJifen>=needJifen
local isGot=nowProgressPoint>=index

if canGet and not isGot then
maxIndex=math.max(maxIndex,index)
else
break
end
end



zongmenControl:reqGetZongmenScoreReward(maxIndex)
end


function UISubAct_zongmendabi_score_win.on_money_changed(moneyType,lastVal,val)
if moneyType==eMoneyType.mtSectScore then

_this:refresh()
end
end

