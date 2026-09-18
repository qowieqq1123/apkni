







def_class("UISevenDayGoalWin",UIWindowBase)









function UISevenDayGoalWin:bindComponents()

self.daymenu=UIObject.get(self,0)
self.scrollView=UIScrollView.get(self,1)
self.goalTypeScrollView=UIScrollView.get(self,2)
self.goalScroller=UIObject.get(self,3)
self.libaoScroller=UIObject.get(self,4)
self.goalPanel=UIObject.get(self,5)
self.libaoPanel=UIObject.get(self,6)
self.progress=UIImage.get(self,7)
self.jifenItemIcon=UIButton.get(self,8)
self.jifenCountText=UIText.get(self,9)
self.timeText=UIText.get(self,10)
self.discipleModelRoot=UIObject.get(self,11)
self.xiaoren=UIObject.get(self,12)
self.rightPanel=UIObject.get(self,13)
self.diziPanel=UIObject.get(self,14)
self.moneyRoot=UIObject.get(self,15)
self.moneyBtn=UIButton.get(self,16)
self.diziClick=UIButton.get(self,17)
self.moneyRoot_xianyu=UIObject.get(self,18)
self.moneyBtn_xianyu=UIObject.get(self,19)
self.progressRewardScrollView=UIObject.get(self,20)
self.progressBar=UIImage.get(self,21)
self.progressContent=UIObject.get(self,22)
self.moneyBtn:setButtonClick(function()self:onMoneyBtn()end)
self.diziClick:setButtonClick(function()self:onInfoBtn()end)
self.moneyBtn_xianyu:setButtonClick(function()self:onMoneyBtn_xianyu()end)



end


function UISevenDayGoalWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.daymenu);self.daymenu=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.goalTypeScrollView);self.goalTypeScrollView=nil;
_UIObject_release(self.goalScroller);self.goalScroller=nil;
_UIObject_release(self.libaoScroller);self.libaoScroller=nil;
_UIObject_release(self.goalPanel);self.goalPanel=nil;
_UIObject_release(self.libaoPanel);self.libaoPanel=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.jifenItemIcon);self.jifenItemIcon=nil;
_UIObject_release(self.jifenCountText);self.jifenCountText=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.discipleModelRoot);self.discipleModelRoot=nil;
_UIObject_release(self.xiaoren);self.xiaoren=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.diziPanel);self.diziPanel=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.moneyBtn);self.moneyBtn=nil;
_UIObject_release(self.diziClick);self.diziClick=nil;
_UIObject_release(self.moneyRoot_xianyu);self.moneyRoot_xianyu=nil;
_UIObject_release(self.moneyBtn_xianyu);self.moneyBtn_xianyu=nil;
_UIObject_release(self.progressRewardScrollView);self.progressRewardScrollView=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressContent);self.progressContent=nil;
end
















local _CMP_INDEX={
cmpSelfItem=0,
cmpName=1,
cmpReddot=2,
cmpAnim=3,
cmpBg=4,
cmpNomalIcon=5,
select=6,
lock=7,
finishFlag=8,
}

local goalItemIndex={
goBtn=0,
rewardBtn=1,
gotFlag=2,
rewards=3,
progressbar=4,
name=5,
back=6,
progressValue=7,
outTimeFlag=8,
}

local libaoItemIndex={
nameText=0,
rewards=1,
buyBtn=2,
freeBtn=3,
discountFlag=4,
discountText=5,
priceIcon=6,
priceText=7,
sellOutFlag=8,
}

local progressRewardItemIndex={
jifenText=0,
gotFlag=1,
reddot=2,
click=3,
point=4,
trick=5,
bg=6,
item=7,
tianmingFlag=8,
}

local _scrollLen=7
local _this=nil




function UISevenDayGoalWin:onLoaded(...)
self:bindComponents()

_this=self

self._on_click_callback=function(...)
self:on_click_callback(...)
end
self._on_gt_item_click=function(...)
self:on_gt_item_click(...)
end
self.scrollView:setClickAction(self._on_click_callback)

self.goalTypeScrollView:setChildScrollViewInit(0,true,self._on_gt_item_click,nil)
self.goalScroller:setChildScrollViewInit(0,true,nil,nil)
self.libaoScroller:setChildScrollViewInit(0,true,nil,nil)

self._onMoneyChange=function(...)self:onMoneyChange(...)end
self._onItemListChanged=function(...)self:onItemListChanged(...)end
notifySystem:listenNotify(notifyConfig.on_money_changed,self._onMoneyChange)
notifySystem:listenNotify(notifyConfig.on_item_list_changed,self._onItemListChanged)
end


function UISevenDayGoalWin:__delete()
self.scrollView:setClickAction(nil)
self:clearTimer()
self:clearAllFMTweener()

self:unbindComponents()
_this=nil

notifySystem:removelistener(notifyConfig.on_money_changed,self._onMoneyChange)
notifySystem:removelistener(notifyConfig.on_item_list_changed,self._onItemListChanged)
end




function UISevenDayGoalWin:onShow(argtable,afterOnloaded)
local saveIndex=sevenDayGoalModel:getSevenDayGoalIndex()
if saveIndex then
if saveIndex.dayIndex then
self.selectDayIdx=saveIndex.dayIndex
end
if saveIndex.goalTypeIndex then
self.gtSelectIndex=saveIndex.goalTypeIndex
end
end

if argtable and argtable.dayIndex then
self.selectDayIdx=argtable.dayIndex
end
if argtable and argtable.goalTypeIndex then
self.gtSelectIndex=argtable.goalTypeIndex
end

local reddotIndex=sevenDayGoalModel:getSevenDayGoalReddotIndex()
if reddotIndex.reddotDayIndex and not self.selectDayIdx then
self.selectDayIdx=reddotIndex.reddotDayIndex
end
if reddotIndex.reddotGoalTypeIndex and not self.gtSelectIndex then
self.gtSelectIndex=reddotIndex.reddotGoalTypeIndex
end

if not self.selectDayIdx and not self.gtSelectIndex then

self.selectDayIdx,self.gtSelectIndex=sevenDayGoalModel:checkFinishDayAndNotFinishIndex()
end

if not self.selectDayIdx then
self.selectDayIdx=1
end
if not self.gtSelectIndex then
self.gtSelectIndex=1
end

self.fmTweenerList={}

self.allDayGoalCfg=cfg_sevendaytargettasklistconfig()
self.dayCount=#self.allDayGoalCfg
self.needRefreshPage=false

self:freshDayMenuList()
self:refreshBottomPanel(true)
self:setRemainingTimeTimer()
self:refreshShowPanel()
end


function UISevenDayGoalWin:onHide()
self:clearTimer()
end


function UISevenDayGoalWin:refreshAllGoalPage()
local tNum=self.dayCount
self.winlua:SetChildScrollRectEnable(self.scrollView:getID(),tNum>_scrollLen)
self.scrollView:freshGridsNum(tNum,tNum,1,true)
for i=1,tNum do
self:freshDayMenuItem(i)
end
self:selectDay(self.selectDayIdx,self.gtSelectIndex)

self:refreshBottomPanel()
self:setRemainingTimeTimer()
self:refreshShowPanel()
end


function UISevenDayGoalWin:refreshNowGoalPage(dataDayIndex)
if not dataDayIndex then
dataDayIndex=self.selectDayIdx
end


self:freshDayMenuItem(dataDayIndex,true)

if dataDayIndex~=self.selectDayIdx then

return
end


self:refreshGoalTypeList(true)

self:refreshGoalListOrLibaoList(true)
end


function UISevenDayGoalWin:freshDayMenuList()
local tNum=self.dayCount
self.winlua:SetChildScrollRectEnable(self.scrollView:getID(),tNum>_scrollLen)
self.scrollView:freshGridsNum(tNum,tNum,1,true)
for i=1,tNum do
self:freshDayMenuItem(i)
end
self:selectDay(self.selectDayIdx,self.gtSelectIndex)
end


function UISevenDayGoalWin:freshDayMenuItem(index,isRecv)
local abName="ui/sharedtextures/uiglobalspriteatlas_1.ab"
local iconName="icon_tytabbeibao_1"
local item=self.scrollView:getGridObjectByindex(index-1)
item:SetBaseItemChildIndex(_CMP_INDEX.cmpSelfItem,index)
item:SetChildActive(_CMP_INDEX.cmpName,true)
item:SetChildActive(_CMP_INDEX.cmpBg,true)

item:SetChildActive(_CMP_INDEX.cmpNomalIcon,false)
item:SetChildActive(_CMP_INDEX.select,self.selectDayIdx==index)
if self.selectDayIdx==index then
item:SetChildActive(_CMP_INDEX.cmpBg,false)
item:SetChildText(_CMP_INDEX.cmpName,FMT.fmt("第{0}天",mathHelper.numberToChinese(index)))
else
item:SetChildText(_CMP_INDEX.cmpName,FMT.fmt("<color=#d0b496>第{0}天</color>",mathHelper.numberToChinese(index)))
end

local reddot=sevenDayGoalModel:checkDayReddot(index,isRecv)
item:SetChildActive(_CMP_INDEX.cmpReddot,reddot)


local isLock=sevenDayGoalModel:checkDayLock(index)
item:SetChildActive(_CMP_INDEX.lock,isLock)


local isFinish=sevenDayGoalModel:checkDayAllFinish(index,true)
item:SetChildActive(_CMP_INDEX.finishFlag,isFinish)
end


function UISevenDayGoalWin:freshDayMenuSelect(index)
if index==nil then
return
end
local item=self.scrollView:getGridObjectByindex(index-1)
item:SetChildActive(_CMP_INDEX.select,self.selectDayIdx==index)
item:SetChildActive(_CMP_INDEX.cmpBg,self.selectDayIdx~=index)

if self.selectDayIdx==index then
item:SetChildText(_CMP_INDEX.cmpName,FMT.fmt("第{0}天",mathHelper.numberToChinese(index)))
else
item:SetChildText(_CMP_INDEX.cmpName,FMT.fmt("<color=#d0b496>第{0}天</color>",mathHelper.numberToChinese(index)))
end





end


function UISevenDayGoalWin:refreshGoalTypeList(isRecv)

self:initGoalTypeList()

local typeCount=#self.gtList
self.goalTypeScrollView:setChildScrollViewCreateGrids(typeCount,0)
local grids=self.goalTypeScrollView:getChildScrollViewItemWidgets()
local count=typeCount
for i=0,count-1 do
local item=grids[i]
local index=i+1

local gtId=self.gtList[index][1]
local gtCfg=cfgHelper.get1(cfg_sevendaytargetpageconfig_get,gtId)
if self.gtSelectIndex==index then
item:SetChildText(1,FMT.fmt("<color=#d3b97a>{0}</color>",gtCfg.name))
else
item:SetChildText(1,gtCfg.name)
end
item:SetChildActive(2,self.gtSelectIndex==index)
local reddot=sevenDayGoalModel:checkGoalTypeReddot(self.selectDayIdx,gtId,isRecv)
item:SetChildActive(3,reddot)
end
end


function UISevenDayGoalWin:refreshGoalListOrLibaoList(isRecv)
if self.isRefreshing then

self.needRefreshPage=true
return
end
self.isRefreshing=true

self.goalList=self.gtList[self.gtSelectIndex]

self:initNowGoalList()

local goalType=self.goalList[1]

if not goalType then
return
end

local goalTypeCfg=cfgHelper.get1(cfg_sevendaytargetpageconfig_get,goalType)
local isLibao=false
if goalTypeCfg.isLibao and goalTypeCfg.isLibao==1 then
isLibao=true
end

if isLibao then

self.goalPanel:setActive(false)
self.libaoPanel:setActive(true)

local libaoCount=#self.goalList[2]
if not isRecv then
self.libaoScroller:setChildScrollViewCreateGrids(0,0)
end
self.libaoScroller:setChildScrollViewCreateGrids(libaoCount,1)
local grids=self.libaoScroller:getChildScrollViewItemWidgets()
for i=1,libaoCount do
self:refreshLibaoItem(grids[i-1],i)
end
else

self.goalPanel:setActive(true)
self.libaoPanel:setActive(false)

self:freshMoney(false)

local goalCount=#self.goalList[2]
self.goalScroller:setChildScrollViewCreateGrids(0,0)
self.goalScroller:setChildScrollViewCreateGrids(goalCount,1)
local grids=self.goalScroller:getChildScrollViewItemWidgets()
for i=1,goalCount do
self:refreshGoalItem(grids[i-1],i,isRecv)
end
end

self.isRefreshing=false
if self.needRefreshPage then
self.needRefreshPage=false

return self:refreshGoalListOrLibaoList(true)
end
end


function UISevenDayGoalWin:refreshGoalItem(item,index,isRecv)
if item==nil then
item=self.goalScroller:getChildScrollViewItemWidget(index-1)
end

local taskId=self.goalList[2][index].id
local goalConfig=cfgHelper.get1(cfg_sevendaytargettaskconfig_get,taskId)
local day=self.selectDayIdx
if item then

item:SetChildText(goalItemIndex.name,goalConfig.name)


local finishNum=sevenDayGoalModel:getGoalProgress(day,taskId,isRecv)

local isFinish=sevenDayGoalModel:checkGoalIsFinish(day,taskId)
local isGot=sevenDayGoalModel:checkGoalIsGot(day,taskId)
local jumpParam=goalConfig.jump
local hasJump=false
if jumpParam and next(jumpParam)then
hasJump=true
end

local isFinalDay=sevenDayGoalModel:checkFinalTime()
local canGet=not isGot and isFinish

item:SetChildImageExGray(goalItemIndex.back,isFinalDay and not canGet)
item:SetChildImageExGray(goalItemIndex.progressValue,not isGot and not isFinish and isFinalDay)

item:SetChildActive(goalItemIndex.goBtn,not isGot and not isFinish and hasJump and not isFinalDay)
item:SetChildActive(goalItemIndex.rewardBtn,not isGot and isFinish)
item:SetChildActive(goalItemIndex.outTimeFlag,not isGot and not isFinish and isFinalDay)
item:SetChildButtonClick(goalItemIndex.goBtn,function()
self:onClickGoBtn(taskId)
end)
item:SetChildButtonClick(goalItemIndex.rewardBtn,function()
self:onClickRewardBtn(day,taskId)
end)
item:SetChildActive(goalItemIndex.gotFlag,isGot)


local need=sevenDayGoalModel:getTaskNeedCountByTaskId(taskId)
if not need then
need=1
end

local cur=finishNum
if isFinish or isGot or canGet then

cur=need
end
if cur>need then
cur=need
end
item:SetChildProgressValue(goalItemIndex.progressbar,cur,need)

local taskType=goalConfig.param[1]
if taskType==9 then

item:SetChildProgressText(goalItemIndex.progressbar,FMT.fmt('{0}/{1}',mathHelper.formatNumber(cur),mathHelper.formatNumber(need)))
else
item:SetChildProgressText(goalItemIndex.progressbar,FMT.fmt('{0}/{1}',cur,need))
end

if cur>=need and not isFinish and not isGot then

local goalData=sevenDayGoalModel:getGoalDataByDayAndTaskId(day,taskId)
local goalDataStr=goalData and serializeHelper.serialize(goalData)or""
logErr(FMT.fmt("前端任务状态与实际数量不一致, 任务天数:{0}, 任务id:{1}, 任务数据:{2}",day,taskId,goalDataStr))
end



local rw={}
if goalConfig.jifen then

local jifenItemId=cfgHelper.get1(cfg_sevendaytargetbaseconfig_get,1).jifenItem
rw[1]={jifenItemId,goalConfig.jifen}
end
for i,v in ipairs(goalConfig.reward)do
rw[#rw+1]=v
end

item:SetChildLayoutGroupCreateItems(goalItemIndex.rewards,#rw)
local grids=item:GetChildLayoutGroupGridList(goalItemIndex.rewards)
for i=1,#rw do
local widget=grids[i-1]
local reward=rw[i]
local itemid=reward[1]
local count=reward[2]
if not count then
logErr(FMT.fmt("无法获取到七日目标任务id:{0} 的奖励道具{1} 的数量 请检查配置是否正确",taskId,itemid))
count=0
end
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local isGray=isGot or(not isFinish and isFinalDay)
local graynum=isGray and 1 or 0
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,gray=graynum,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
end
end



function UISevenDayGoalWin:refreshLibaoItem(item,index)
if item==nil then
item=self.libaoScroller:getChildScrollViewItemWidget(index-1)
end

local libaoId=self.goalList[2][index].id
local libaoConfig=cfgHelper.get1(cfg_sevendaytargetlibaoconfig_get,libaoId)
if item then

local rw=libaoConfig.items
item:SetChildLayoutGroupCreateItems(libaoItemIndex.rewards,#rw)
local grids=item:GetChildLayoutGroupGridList(libaoItemIndex.rewards)
for i=1,#rw do
local widget=grids[i-1]
local reward=rw[i]
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end

local isRecharge=false
local isFree=false
if libaoConfig.buy2 then

isRecharge=true
end

if not isRecharge and not libaoConfig.buy1 then

isFree=true
end

local buyCount=sevenDayGoalModel:getLibaoBuyNum(libaoId)
local isSellOut=false
if libaoConfig.buyLimit then
if buyCount>=libaoConfig.buyLimit then
isSellOut=true
end


local nameStr=FMT.fmt("{0}（限购: {1}/{2}）",libaoConfig.name,buyCount,libaoConfig.buyLimit)
item:SetChildText(libaoItemIndex.nameText,nameStr)
else

item:SetChildText(libaoItemIndex.nameText,libaoConfig.name)
end



if libaoConfig.zheKou then
item:SetChildActive(libaoItemIndex.discountFlag,true)
if pfwindowslController:checkIsGameVersion_oumei()then
item:SetChildText(libaoItemIndex.discountText,pfwindowslController:convertDiscount_yuenan(FMT.fmt("{0}0% Off",libaoConfig.zheKou)))
else
item:SetChildText(libaoItemIndex.discountText,pfwindowslController:convertDiscount_yuenan(FMT.fmt("{0}折",libaoConfig.zheKou)))
end
else
item:SetChildActive(libaoItemIndex.discountFlag,false)
end


item:SetChildActive(libaoItemIndex.sellOutFlag,isSellOut)


local libaoType=1
local buyParam=nil
if isFree then
libaoType=1
else
if not isRecharge then
libaoType=2
buyParam={}
buyParam.id=libaoConfig.buy1[1]
buyParam.price=libaoConfig.buy1[2]
else
libaoType=3
buyParam={}
buyParam.id=libaoConfig.buy2
end
end

item:SetChildActive(libaoItemIndex.freeBtn,isFree and not isSellOut)
item:SetChildButtonClick(libaoItemIndex.freeBtn,function()
self:onClickBuyLibaoBtn(libaoId,1,nil)
end)

item:SetChildActive(libaoItemIndex.buyBtn,not isFree and not isSellOut)
item:SetChildButtonClick(libaoItemIndex.buyBtn,function()
self:onClickBuyLibaoBtn(libaoId,libaoType,buyParam)
end)


if not isFree and not isSellOut then

if isRecharge then

local czId=libaoConfig.buy2
local rmb=cfgHelper.get(cfg_rechargeconfig_get,czId,"rmb")

item:SetChildActive(libaoItemIndex.priceIcon,false)

item:SetChildText(libaoItemIndex.priceText,FMT.fmt("￥{0}",rmb))
else

local moneyType=libaoConfig.buy1[1]
local moneyCount=libaoConfig.buy1[2]

item:SetChildActive(libaoItemIndex.priceIcon,true)
item:SetChildIcon(libaoItemIndex.priceIcon,iconHelper.getIconName(moneyType),false)


item:SetChildText(libaoItemIndex.priceText,FMT.fmt("{0}",moneyCount))
end
end


if not isFree and not isRecharge then
self.moneyType=libaoConfig.buy1[1]
self:freshMoney(true)
end
end
end


function UISevenDayGoalWin:refreshBottomPanel(isInit)
local nowJifen=sevenDayGoalModel:getJifen()
local nowProgressPoint=sevenDayGoalModel:getProgressPoint()
self.bottomReddotList={}


local progressCfg=sevenDayGoalModel:getProgressRewardCfg()
local progressRewardCount=#progressCfg-1
self.progressRewardScrollView:setChildScrollViewCreateGrids(progressRewardCount,progressRewardCount)
local grids=self.progressRewardScrollView:getChildScrollViewItemWidgets()
local count=grids.Count

for i=1,count do
local progressRewardItem=grids[i-1]
local itemProgressPoint=i+1
local config=progressCfg[itemProgressPoint]
if progressRewardItem and config then
local needJifen=config[1]
local reward=config[2]

local canGet=nowJifen>=needJifen
local isGot=nowProgressPoint>=itemProgressPoint


if canGet then
progressRewardItem:SetChildText(progressRewardItemIndex.jifenText,needJifen)
else
progressRewardItem:SetChildText(progressRewardItemIndex.jifenText,FMT.fmt("<color=#cfbfb2>{0}</color>",needJifen))
end


local reddot=canGet and not isGot
self.bottomReddotList[i]=reddot or nil
progressRewardItem:SetChildActive(progressRewardItemIndex.reddot,reddot)

progressRewardItem:SetChildActive(progressRewardItemIndex.gotFlag,isGot)


progressRewardItem:SetChildActive(progressRewardItemIndex.point,canGet)
progressRewardItem:SetChildActive(progressRewardItemIndex.trick,isGot)


progressRewardItem:SetChildImageExGray(progressRewardItemIndex.bg,isGot)

local itemid=reward[1][1]
local count=reward[1][2]

local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end

local conf
if isGot then

conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,gray=1}
else
conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG}
end

local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
progressRewardItem:SetChildActive(progressRewardItemIndex.item,true)
progressRewardItem:SetChildPropData(progressRewardItemIndex.item,prop)

local rewardItem=progressRewardItem:GetChildWidgetBase(progressRewardItemIndex.item)
if canGet and not isGot then

rewardItem:SetChildButtonClick(1,function()
self:onClickProgressRewardItem(itemProgressPoint)
end)
else

rewardItem:SetChildButtonClick(1,function()
self:onClickRewardItem(itemid)
end)
end

rewardItem:SetChildLongTouch(1,i,0.5,function()
self:onClickRewardItem(itemid)
end)


local funcparam=itemsConfig.getConfig(itemid).funcparam
local isDiscipleItem=false
if funcparam then
if funcparam.type==item_funtion_type.disciple and funcparam.isSpecial then
isDiscipleItem=true
end
end
progressRewardItem:SetChildActive(progressRewardItemIndex.tianmingFlag,isDiscipleItem)
end
end


self:refreshProgress(isInit)



local jifenItemId=cfgHelper.get1(cfg_sevendaytargetbaseconfig_get,1).jifenItem
local iconName=iconHelper.getIconName(jifenItemId)
self.jifenItemIcon:setImageIcon(iconName,false)
self.jifenItemIcon:setButtonClick(function()
self:onClickRewardItem(jifenItemId)
end)
self.jifenCountText:setText(nowJifen)










end


function UISevenDayGoalWin:refreshProgress(isInit)
local progressCfg=sevenDayGoalModel:getProgressRewardCfg()
local progressPercent=0
local maxProgressPoint=#progressCfg
local progressRewardCount=#progressCfg-1
local nowJifen=sevenDayGoalModel:getJifen()
local nowProgressPoint=sevenDayGoalModel:getProgressPoint()
local finalGotIndex=0


if nowJifen then
local jifenPoint=1
for i=1,#progressCfg do
if nowJifen>=progressCfg[i][1]then
jifenPoint=i
end

local itemProgressPoint=i-1
local isGot=nowProgressPoint>=i
if isGot and finalGotIndex<itemProgressPoint then

finalGotIndex=itemProgressPoint
end
end

if jifenPoint<maxProgressPoint then
local tmpNow=jifenPoint-1
if tmpNow>0 then
progressPercent=tmpNow/(maxProgressPoint-1)
else
progressPercent=0
end

local pointJifen=progressCfg[jifenPoint][1]
local nextProgressPoint=jifenPoint+1
if nextProgressPoint>maxProgressPoint then
nextProgressPoint=maxProgressPoint
end
local nextJifen=progressCfg[nextProgressPoint][1]

local addPercent=((nowJifen-pointJifen)/(nextJifen-pointJifen))

progressPercent=progressPercent+(addPercent/(maxProgressPoint-1))
else
progressPercent=1
end
end


local itemWidth=88
local space=42
local startOffset_X=91
local endOffset_X=111
local beforeWidth=580
local initProgressWidth=20

local contentWidth=startOffset_X+(itemWidth+space)*progressRewardCount-space+(endOffset_X-startOffset_X)
local progressBarWidth=beforeWidth+contentWidth-itemWidth/2-(endOffset_X-startOffset_X)
local progressBarHeight=self.progressBar:getChildSizeDeltaY()
self.progressBar:setChildSizeDelta(progressBarWidth,progressBarHeight)


local progressWidth=(progressBarWidth-(beforeWidth+initProgressWidth))*progressPercent+(beforeWidth+initProgressWidth)
if progressPercent<=0 then
progressWidth=0
end
local progressHeight=self.progress:getChildSizeDeltaY()
self.progress:setChildSizeDelta(progressWidth,progressHeight)

if isInit then

local showWidth=self.progressRewardScrollView:getChildRectWidth()
local contentPosX
local finalGotItemPos
if finalGotIndex<=0 then
finalGotItemPos=0
else
finalGotItemPos=startOffset_X+(itemWidth+space)*(finalGotIndex-1)+itemWidth/2
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


function UISevenDayGoalWin:selectDay(dayIndex,gtIndex)
if dayIndex~=self.selectDayIdx then
local oldIndex=self.selectDayIdx
self.selectDayIdx=dayIndex

self:freshDayMenuSelect(oldIndex)
self:freshDayMenuSelect(dayIndex)
end

if gtIndex then
self.gtSelectIndex=gtIndex
else

self.gtSelectIndex=1
end


self:refreshGoalTypeList()

self:selectGoalType(self.gtSelectIndex)
end


function UISevenDayGoalWin:selectGoalType(gtIndex)
if gtIndex~=self.gtSelectIndex then
local item=self.goalTypeScrollView:getChildScrollViewItemWidget(self.gtSelectIndex-1)
item:SetChildActive(2,false)
local gtId=self.gtList[self.gtSelectIndex][1]
local gtCfg=cfgHelper.get1(cfg_sevendaytargetpageconfig_get,gtId)
item:SetChildText(1,gtCfg.name)

gtId=self.gtList[gtIndex][1]
gtCfg=cfgHelper.get1(cfg_sevendaytargetpageconfig_get,gtId)
item=self.goalTypeScrollView:getChildScrollViewItemWidget(gtIndex-1)
item:SetChildActive(2,true)
item:SetChildText(1,FMT.fmt("<color=#d3b97a>{0}</color>",gtCfg.name))

self.gtSelectIndex=gtIndex
end


self:refreshGoalListOrLibaoList()
end


function UISevenDayGoalWin:initGoalTypeList()

local dayGoalCfg=sevenDayGoalModel:getDayCfgByDayIndex(self.selectDayIdx)
self.gtList={}

for i=1,#dayGoalCfg.tasks do
local taskCfg=dayGoalCfg.tasks[i]
local goal={}
goal[1]=taskCfg[1]
goal[2]=table.weakCopy(taskCfg[2])
table.insert(self.gtList,goal)
end
if dayGoalCfg.libao and next(dayGoalCfg.libao)then
local libaoCfg=dayGoalCfg.libao
local libao={}
libao[1]=libaoCfg[1]
libao[2]=table.weakCopy(libaoCfg[2])
table.insert(self.gtList,libao)
end
end


function UISevenDayGoalWin:initNowGoalList()

if not self.goalList or not next(self.goalList)then
return
end

local goalType=self.goalList[1]
local list=self.goalList[2]
local day=self.selectDayIdx

if not goalType or not list then
return
end

local goalTypeCfg=cfgHelper.get1(cfg_sevendaytargetpageconfig_get,goalType)
local isLibao=false
if goalTypeCfg.isLibao and goalTypeCfg.isLibao==1 then
isLibao=true
end


if isLibao then



for i=1,#list do
local libao={}
if type(list[i])=='number'then
libao.id=list[i]
else
libao.id=list[i].id
end
local buyCount=sevenDayGoalModel:getLibaoBuyNum(libao.id)
local limitCount=cfgHelper.get1(cfg_sevendaytargetlibaoconfig_get,libao.id).buyLimit
local isSellOut=false
if limitCount then
if buyCount>=limitCount then
isSellOut=true
end
end

local weight=1000-i
if isSellOut then
weight=weight-10000
else
weight=weight+10000
end
libao.weight=weight
list[i]=libao
end

table.sort(list,function(a,b)
return a.weight>b.weight
end)
else



for i=1,#list do
local goal={}
if type(list[i])=='number'then
goal.id=list[i]
else
goal.id=list[i].id
end
local isFinish=sevenDayGoalModel:checkGoalIsFinish(day,goal.id)
local isGot=sevenDayGoalModel:checkGoalIsGot(day,goal.id)
local sortId=cfgHelper.get1(cfg_sevendaytargettaskconfig_get,goal.id).sortid
local weight=1000-sortId
if isFinish then
if isGot then
weight=weight-10000
else
weight=weight+10000
end
end
goal.weight=weight
list[i]=goal
end

table.sort(list,function(a,b)
return a.weight>b.weight
end)
end
end

function UISevenDayGoalWin:refreshShowPanel()
local diziItemId=cfgHelper.get1(cfg_sevendaytargetbaseconfig_get,1).showDiziItem
if not diziItemId then




self.diziPanel:setActive(false)


return
else


self.diziPanel:setActive(true)


end






























end


function UISevenDayGoalWin:on_click_callback(id,index,guid,attach)
if index==self.selectDayIdx then
return
end

if sevenDayGoalModel:checkDayLock(index)then
UIManager.info(FMT.fmt("第{0}天开放",mathHelper.numberToChinese(index)))
return
end
self:selectDay(index)



end


function UISevenDayGoalWin:on_gt_item_click(clicknum,index)
local selectIndex=index+1

if selectIndex==self.gtSelectIndex then
return
end

self:selectGoalType(selectIndex)
end


function UISevenDayGoalWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eRight})
end




function UISevenDayGoalWin:onClickClose()

UIFullSevenDayGoalController:closeUI()

sevenDayGoalModel:clearSevenDayGoalIndex()
end


function UISevenDayGoalWin:onInfoBtn()
local diziItemId=cfgHelper.get1(cfg_sevendaytargetbaseconfig_get,1).showDiziItem
if not diziItemId then

logErr("没有获取到展示弟子道具id，请检查配置表是否配置")
return
end

UISevenDayGoalWin:onClickRewardItem(diziItemId)
end


function UISevenDayGoalWin:onClickGoBtn(taskId)

local goalConfig=cfgHelper.get1(cfg_sevendaytargettaskconfig_get,taskId)
local taskType=goalConfig.param[1]
local jumpParam=goalConfig.jump
if jumpParam then
local jumpType=jumpParam[1]
local jumpId=jumpParam[2]
local args=jumpParam[3]
local backFlag=nil
if jumpId==JUMP_TYPE.eShiLianTa then
backFlag=JUMP_BACK.eForceBack
elseif jumpId==JUMP_TYPE.eDouFaTai then
backFlag=JUMP_BACK.eNoBack
end


sevenDayGoalModel:setSevenDayGoalIndex(self.selectDayIdx,self.gtSelectIndex)


if jumpId==JUMP_TYPE.eXianZhan or jumpId==JUMP_TYPE.eXianZhanInteract or jumpId==JUMP_TYPE.eXianZhanShop or jumpId==JUMP_TYPE.eXianZhanInteract2 then



local isFinishRepair=false
local bdData=zongmenModel:findBuildingDataByID(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eXianZhan)
if bdData then
local ftype=zongmenModel:getBDFlagType(bdData.flag)
if ftype~=bdFlagType.sectionBuildStart and ftype~=bdFlagType.sectionBuildComplete then
isFinishRepair=true
end
end
if not isFinishRepair then

UIManager.error('仙栈尚未修复，请修复后再前往')
end

local callBack=function()
if _this==nil then return end

_this:onClickClose()
end

jumpManager:jump({type=jumpType,id=jumpId,args=args},callBack,backFlag)
elseif jumpId==JUMP_TYPE.eFriend then

local tabType=FULL_TAB_TYPE.eFriendList
local fulltabconfig=fullScreenModel.getFullTabConfig(tabType)
local ret,checkArgs=fullScreenModel.checkCND(fulltabconfig.cnd)
if ret==false then
local typo=checkArgs[1]
local sysid=checkArgs[2]
local limitType=fullScreenModel.LimitType
if typo==limitType.eSystem then
local isCan,errArgs=systemConfig.isEnoughConfigOpenCnd(sysid)
if not isCan then
local errtypo=errArgs[1]
local val=errArgs[2]
local name=systemConfig.getSystemName(sysid)
if errtypo==SYSTEM_OPEN_TYPE.eZongmemLevelChanged then
local level=val
UIManager.info(FMT.fmt('{0}级开启{1}系统',level,name))
end
end
end
return
else
jumpManager:jump({type=jumpType,id=jumpId,args=args},nil,backFlag)
end
elseif jumpId==JUMP_TYPE.eBuilding and taskType==LOCAL_CHECK_TASK_TYPE.eBuildingCount_Level then
local bdData
local bdId=goalConfig.param[3]
local needlevel=goalConfig.param[4]
local bdDatas=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,bdId)
local maxLv=0
for _,bd in ipairs(bdDatas)do
if bd.level<needlevel and bd.level>maxLv then
bdData=bd
maxLv=bd.level
if maxLv+1>needlevel then
break
end
end
end

local jumpArgs={}
if not bdData then

jumpArgs=args
else
jumpArgs=table.weakCopy(args)
jumpArgs.args={}
jumpArgs.args.un_build_id=bdData.un_build_id
end
jumpManager:jump({type=jumpType,id=jumpId,args=jumpArgs},nil,backFlag)
else
jumpManager:jump({type=jumpType,id=jumpId,args=args},nil,backFlag)
end
end
end


function UISevenDayGoalWin:onClickRewardBtn(day,taskId)


sevenDayGoalController:reqGetAllGoalReward()
end






function UISevenDayGoalWin:onClickBuyLibaoBtn(libaoId,libaoType,buyParam)
if libaoType==1 then


sevenDayGoalController:reqBuyLibao(libaoId)
elseif libaoType==2 then

local moneyType=buyParam.id
local price=buyParam.price
local exchangeType=eMoneyType.mtXianYu
local showDiaLog=sevenDayGoalModel:get_CheooseBoxValue()
if not showDiaLog then

UIFullSevenDayGoalController:showWindowLibaoBuyDialog({libaoId=libaoId,libaoType=libaoType,buyParam=buyParam,isCheckMaxSelectCount=true})
else

moneySystem:useMoney(moneyType,price,function()

sevenDayGoalController:reqBuyLibao(libaoId)
end,WARNING_TYPE.eWarning,exchangeType)
end

elseif libaoType==3 then

payControl.reqPay(buyParam.id)
end
end


function UISevenDayGoalWin:onClickProgressRewardItem(progressPoint)

sevenDayGoalController:reqGetProgressReward(progressPoint)
end


function UISevenDayGoalWin:setRemainingTimeTimer()
self:clearTimer()
local func
func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local endTime=sevenDayGoalModel:getEndTime()
if not endTime then

self:clearTimer()
return
end
local lerp=endTime-nowTime
if lerp>0 then
local timeStr=nil
local finalTime=sevenDayGoalModel:getFinalTime()
lerp=finalTime-nowTime
if lerp>=0 then

timeStr=timeHelper.format_time_stamp11(lerp,true)
self.timeText:setText(FMT.fmt("{0}<color=#fd8950>后结束</color>",timeStr))
else

self.timeText:setText("<color=#fd8950>活动已结束，请祖师们尽快领取奖励</color>")
end

local nextOpenDay=sevenDayGoalModel:getNextOpenDay()
if nextOpenDay then
lerp=sevenDayGoalModel:getDayTime(nextOpenDay)-nowTime
if lerp<=0 then

self:freshDayMenuItem(nextOpenDay)

sevenDayGoalController:refreshSevenDayGoalEnterReddot()
end
end
else
self:onClickClose()
UIManager.info("七日目标活动已结束")
end
end

self.timer=self:setTimer(1,0,func)

func()
end


function UISevenDayGoalWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UISevenDayGoalWin:onMoneyBtn()
if self.moneyType==eMoneyType.mtXianYu then
UIFullRechargeController:showRechargeWindow()
else
gainControl:showGainWin(self.moneyType)
end
end

function UISevenDayGoalWin:onMoneyBtn_xianyu()
UIFullRechargeController:showRechargeWindow()
end

function UISevenDayGoalWin:onMoneyChange(moneyType,lastVal,val)
if self.moneyType==moneyType then
self:freshMoneyValue(self.moneyType,lastVal)
end

if moneyType==eMoneyType.mtXianYu then
self:freshMoneyValue_xianyu(lastVal)
end
end

function UISevenDayGoalWin:onItemListChanged(argsTable)
for i,v in ipairs(argsTable)do
local changeType=v[1]
local itemguid=v[2]
local itemid=v[3]
local lastcount=v[4]
local itemcount=v[5]
self:onItemChange(changeType,itemguid,itemid,lastcount,itemcount)
end
end

function UISevenDayGoalWin:onItemChange(changeType,itemguid,itemid,lastcount,itemcount)
if self.moneyType==itemid then
self:freshMoneyValue(self.moneyType,lastcount)
end

if itemid==eMoneyType.mtXianYu then
self:freshMoneyValue_xianyu(lastcount)
end
end

function UISevenDayGoalWin:freshMoneyValue(moneyType,lastVal)
local widget=self.winlua:GetChildWidgetBase(self.moneyRoot:getID())
local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
self:clearFMTweenerByIndex(1)
self.fmTweenerList[1]=_DOTweenProxy.DoValueTo(function()
return lastVal
end,function(val)
lastVal=val
local moneyStr=mathHelper.formatNumber(math.floor(val),true)
widget:SetChildText(1,moneyStr)
end,moneyVal,1)
end

function UISevenDayGoalWin:freshMoneyValue_xianyu(lastVal)
local widget=self.winlua:GetChildWidgetBase(self.moneyRoot_xianyu:getID())
local moneyVal=0
if moneyConfig.isMoney(eMoneyType.mtXianYu)then
moneyVal=moneyModel.getMoney(eMoneyType.mtXianYu)
else
moneyVal=bagControl.invokeFuncByItemId(eMoneyType.mtXianYu,'getItemCountByItemID',eMoneyType.mtXianYu)
end
self:clearFMTweenerByIndex(2)
self.fmTweenerList[2]=_DOTweenProxy.DoValueTo(function()
return lastVal
end,function(val)
lastVal=val
local moneyStr=mathHelper.formatNumber(math.floor(val),true)
widget:SetChildText(1,moneyStr)
end,moneyVal,1)
end

function UISevenDayGoalWin:clearFMTweenerByIndex(index)
if self.fmTweenerList[index]then
self.fmTweenerList[index]:Kill()
self.fmTweenerList[index]=nil
end
end

function UISevenDayGoalWin:clearAllFMTweener()
for index,tweener in pairs(self.fmTweenerList)do
tweener:Kill()
self.fmTweenerList[index]=nil
end
end

function UISevenDayGoalWin:freshMoney(isShow)
if isShow==self.showMoney then
return
end
self.showMoney=isShow
self.moneyRoot:setActive(isShow)
local isSameMoneyType=self.moneyType==eMoneyType.mtXianYu
self.moneyRoot_xianyu:setActive(isShow and not isSameMoneyType)

if not isShow then
return
end

local widget=self.winlua:GetChildWidgetBase(self.moneyRoot:getID())
local moneyType=self.moneyType

local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildIcon(0,iconHelper.getIconName(moneyType),false)
widget:SetChildText(1,moneyStr)



if not isSameMoneyType then
local widget=self.winlua:GetChildWidgetBase(self.moneyRoot_xianyu:getID())
local moneyType=eMoneyType.mtXianYu

local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildIcon(0,iconHelper.getIconName(moneyType),false)
widget:SetChildText(1,moneyStr)
end
end


function UISevenDayGoalWin:doPunchRotationWithBottomReddot(isreddot)
if isreddot then
if self.reddotTweenerList==nil then
self.reddotTweenerList={}
end
for i,v in pairs(self.bottomReddotList)do
if v and self.reddotTweenerList[i]==nil then

local item=self.progressRewardScrollView:getChildScrollViewItemWidget(i-1)
item:SetChildRotation(progressRewardItemIndex.reddot,0,0,0)
local tweener=item:SetChildDOPunchRotation(progressRewardItemIndex.reddot,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweenerList[i]=tweener
end
end
else
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return
end
for i,v in pairs(self.reddotTweenerList)do
if v~=nil then
v:Complete()
v=nil

local item=self.progressRewardScrollView:getChildScrollViewItemWidget(i-1)
item:SetChildRotation(progressRewardItemIndex.reddot,0,0,0)
end
end
end
end
