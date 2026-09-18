







def_class("UIWDCQLiveBroadcastRoomLotteryWin",UIWindowBase)









function UIWDCQLiveBroadcastRoomLotteryWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.helpBtn=UIButton.get(self,2)
self.hotProgressBar=UIProgress.get(self,3)
self.leastTx=UIText.get(self,4)
self.lotteryBtn=UIButton.get(self,5)
self.numList=UIObject.get(self,6)
self.poolTx=UIText.get(self,7)
self.tips=UIText.get(self,8)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.lotteryBtn:setButtonClick(function()self:onLotteryBtn()end)



end


function UIWDCQLiveBroadcastRoomLotteryWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.hotProgressBar);self.hotProgressBar=nil;
_UIObject_release(self.leastTx);self.leastTx=nil;
_UIObject_release(self.lotteryBtn);self.lotteryBtn=nil;
_UIObject_release(self.numList);self.numList=nil;
_UIObject_release(self.poolTx);self.poolTx=nil;
_UIObject_release(self.tips);self.tips=nil;
end















local _this=nil
local _progressHeight=196
local _range={-300,300}
local _intervalHeight=60
local _intervalAngle=36
local _animDuration=3

local rollItemIndex={
num_now=0,
num_next=1,
numText_now=2,
numText_next=3,
}

local _minColor=0.5



function UIWDCQLiveBroadcastRoomLotteryWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onWDCQLiveBroadcastRoomPoolNumChange,self.onWDCQLiveBroadcastRoomPoolNumChange)
self:addNotify(notifyConfig.onWDCQLiveBroadcastRoomHotChange,self.onWDCQLiveBroadcastRoomHotChange)
self:addNotify(notifyConfig.onWDCQLiveBroadcastRoomDrawChange,self.onWDCQLiveBroadcastRoomDrawChange)
self:addProNotify(38,24,self.on_38_24)

local baseCfg=cfgHelper.get1(cfg_wendingcangqiongzhibobasicconfig_get,1)
self.progressMax=baseCfg.gfjcCondition
self.moneyId=baseCfg.jcItemId
local str=FMT.fmt("热度值每累计{0}，擂台内的玩家获得1次抽取次数",self.progressMax)
self.tips:setText(str)

end


function UIWDCQLiveBroadcastRoomLotteryWin:__delete()
self:unbindComponents()
_this=nil

if self.animTweener and self.animTweener:IsActive()then
self.animTweener:Kill()
self.animTweener=nil
end

self:clearUpdateTimer()
end




function UIWDCQLiveBroadcastRoomLotteryWin:onShow(argtable,afterOnloaded)
self.group=argtable.group
self.phase=argtable.phase
self.order=argtable.order
self.parentWin=argtable.parentWin
self.closeFunc=argtable.closeFunc

if not wdcqLiveBroadcastRoomModel:isInRoom()then
self:onBackground()
return
end
local rollParam=cfgHelper.get2(cfg_xmdgauctionconfig_get,1,'rollParam')or{}
self.delayStartRollTime=rollParam.delayStartRollTime or 0
self.speedLowTime=rollParam.speedLowTime or 4
self.maxSpeed=rollParam.maxSpeed or 35
self.delayTime=rollParam.delayTime or 0.1
self.baseRoundCount=rollParam.baseRoundCount or 1
self.addRoundCount=rollParam.addRoundCount or 1
self:initRollNumData()

self.group=wdcqLiveBroadcastRoomModel:getRoomGroup()
self:refreshView()
end


function UIWDCQLiveBroadcastRoomLotteryWin:onHide()

end




function UIWDCQLiveBroadcastRoomLotteryWin:onHelpBtn()
local d={}
d.mode=3
d.title="规则介绍"
d.name='wendingcangqiongzhibojian_choujiang_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end


function UIWDCQLiveBroadcastRoomLotteryWin:onLotteryBtn()
local draw=wdcqLiveBroadcastRoomModel:getRoomDraw()
if draw>0 then
wdcqLiveBroadcastRoomController:send_38_24()
self.winlua:SetChildButtonInteractable(self.lotteryBtn:getID(),false)
else

UIManager.error("暂无抽取次数")
end
end

function UIWDCQLiveBroadcastRoomLotteryWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
elseif self.closeFunc then
self.closeFunc()
else
UIManager:closeWindow(self.__name)
end
end

function UIWDCQLiveBroadcastRoomLotteryWin:onBackground()
self:onCloseBtn()
end

function UIWDCQLiveBroadcastRoomLotteryWin:refreshView()
self:refreshHotProgress()
self:refreshPoolNum()
self:refreshDrawBtn()
end

function UIWDCQLiveBroadcastRoomLotteryWin:refreshHotProgress()
local hot=wdcqLiveBroadcastRoomModel:getRoomHot()or 0
local progressValue=hot%self.progressMax
self.hotProgressBar:setProgressValue(math.floor(progressValue/self.progressMax*10000),10000)
self.hotProgressBar:setChildProgressText(FMT.fmt("<color=#AAE252>{0}</color>/{1}",progressValue,self.progressMax))
end

function UIWDCQLiveBroadcastRoomLotteryWin:refreshPoolNum()
local num=wdcqLiveBroadcastRoomModel:getPoolNum()
self.poolTx:setText(FMT.fmt("灵玉奖池: <color=#CA631D>{0}</color>",num))
end

function UIWDCQLiveBroadcastRoomLotteryWin:refreshDrawBtn()
local draw=wdcqLiveBroadcastRoomModel:getRoomDraw()
local draw2=wdcqLiveBroadcastRoomModel:getRoomDraw2()
local max=cfgHelper.get2(cfg_wendingcangqiongzhibobasicconfig_get,1,"cjcsMax")
self.leastTx:setText((draw<=0 and max<=draw2)and"次数获取已达上限"or FMT.fmt("剩余次数:   {0}次",draw))
end

function UIWDCQLiveBroadcastRoomLotteryWin.onWDCQLiveBroadcastRoomPoolNumChange()
_this:refreshPoolNum()
end

function UIWDCQLiveBroadcastRoomLotteryWin.onWDCQLiveBroadcastRoomHotChange(group,phase,order)
if _this.group==group and _this.phase==phase and _this.order==order then
_this:refreshHotProgress()
end
end

function UIWDCQLiveBroadcastRoomLotteryWin.onWDCQLiveBroadcastRoomDrawChange(group,phase,order)
if _this.group==group and _this.phase==phase and _this.order==order then
_this:refreshDrawBtn()
end
end

function UIWDCQLiveBroadcastRoomLotteryWin.on_38_24(args)
local group=args[1]
local phase=args[2]
local order=args[3]
local num=args[4]
if _this.group==group and _this.phase==phase and _this.order==order then
_this:roll2Num(num)
end
end


function UIWDCQLiveBroadcastRoomLotteryWin:roll2NextByRollIndex(index,speed,delayStartTime,isResetRemainingData)
if not self.needUpdateRollList then
self.needUpdateRollList={}
end

if not self.needUpdateRollList[index]then
self.needUpdateRollList[index]={}
end

if not self.rollRemainingData then
self.rollRemainingData={}
end

if not self.rollRemainingData[index]then
self.rollRemainingData[index]={}
end

if isResetRemainingData then
self.rollRemainingData[index].remainingNowScale=0
self.rollRemainingData[index].remainingNextScale=0
self.rollRemainingData[index].remainingNowColor=0
self.rollRemainingData[index].remainingNextColor=0
end

self.needUpdateRollList[index].delayStartTime=delayStartTime or 0
self.needUpdateRollList[index].speed=speed
self.needUpdateRollList[index].numNowScale=1+self.rollRemainingData[index].remainingNowScale
self.needUpdateRollList[index].numNextScale=0-self.rollRemainingData[index].remainingNextScale
self.needUpdateRollList[index].numNowColor=1+self.rollRemainingData[index].remainingNowColor
self.needUpdateRollList[index].numNextColor=_minColor-self.rollRemainingData[index].remainingNextColor

self:startUpdateTimer()
end

function UIWDCQLiveBroadcastRoomLotteryWin:startUpdateTimer()
if self.updateTimer==nil then
local updateFunc=function()
local deltaTime=Time.deltaTime
self:onUpdate(deltaTime)
end

self.updateTimer=timer.new()
self.updateTimer:start(0,updateFunc)
end
end

function UIWDCQLiveBroadcastRoomLotteryWin:onUpdate(deltaTime)
if not next(self.needUpdateRollList)then

return self:clearUpdateTimer()
end

for index,data in pairs(self.needUpdateRollList)do
local isFinishCount=0
if not data.isFinish then
if data.delayStartTime and data.delayStartTime>0 then

data.delayStartTime=data.delayStartTime-deltaTime
if data.delayStartTime<0 then
data.delayStartTime=0
end
else
local speed=data.speed*deltaTime
local sizeChangeValue=speed/10
local colorChangeValue=speed/10*(1-_minColor)
local rollItem=self.rollNumItemList[index]


local targetNumNowScale=data.numNowScale-sizeChangeValue
if targetNumNowScale<=0 then
self.rollRemainingData[index].remainingNowScale=targetNumNowScale

isFinishCount=isFinishCount+1
end
rollItem:SetChildScale(rollItemIndex.num_now,Vector3.New(1,targetNumNowScale,1))
data.numNowScale=targetNumNowScale

local targetNumNextScale=data.numNextScale+sizeChangeValue
if targetNumNextScale>=1 then
self.rollRemainingData[index].remainingNextScale=1-targetNumNextScale

isFinishCount=isFinishCount+1
end
rollItem:SetChildScale(rollItemIndex.num_next,Vector3.New(1,targetNumNextScale,1))
data.numNextScale=targetNumNextScale

local targetNumNowColor=data.numNowColor-colorChangeValue
if targetNumNowColor<=_minColor then
self.rollRemainingData[index].remainingNowColor=targetNumNowColor-_minColor

isFinishCount=isFinishCount+1
end
rollItem:SetChildColor(rollItemIndex.num_now,Color.New(targetNumNowColor,targetNumNowColor,targetNumNowColor,1))
data.numNowColor=targetNumNowColor

local targetNumNextColor=data.numNextColor+colorChangeValue
if targetNumNextColor>=1 then
self.rollRemainingData[index].remainingNextColor=1-targetNumNextColor

isFinishCount=isFinishCount+1
end
rollItem:SetChildColor(rollItemIndex.num_next,Color.New(targetNumNextColor,targetNumNextColor,targetNumNextColor,1))
data.numNextColor=targetNumNextColor

if isFinishCount>=4 then
data.isFinish=true
self:finishRoll2Next(index,data.speed)
end
end
end
end
end

function UIWDCQLiveBroadcastRoomLotteryWin:finishRoll2Next(index,speed)
self.needUpdateRollList[index]=nil
local selectIndex=self.numNowSelectIndex[index]+1
if selectIndex>self.numCount then
selectIndex=1
end
self.numNowSelectIndex[index]=selectIndex

local rollTime=self.rollTimeList[index]or 0
rollTime=rollTime-1
if rollTime<=0 then
rollTime=0
end
self.rollTimeList[index]=rollTime
if rollTime>0 then
if rollTime<=self.speedLowTime then
local downLowSpeedValue=self.maxSpeed/(self.speedLowTime+1)*0.8
speed=speed-downLowSpeedValue
end
self:refreshRollItem(index,true)
return self:roll2NextByRollIndex(index,speed)
else
self:refreshRollItem(index)
return self:finishRollByIndex(index)
end
end

function UIWDCQLiveBroadcastRoomLotteryWin:clearUpdateTimer()
if self.updateTimer~=nil then
self.updateTimer:cancel()
self.updateTimer=nil
end
end

function UIWDCQLiveBroadcastRoomLotteryWin:roll2Num(num)
self:clearUpdateTimer()
self:refreshRoll()

self.finishRollNum=num
local posNum=self:getPosNumListByNum(num)

self.rollFinishCount=0
self.rollTimeList={}
local speed=self.maxSpeed
local round=self.baseRoundCount
local finishOneNextTime=self.delayTime
for i=1,self.rollNumItemCount do
local nowSelectIndex=self.numNowSelectIndex[i]
local nowNum=self.numTable[nowSelectIndex]
local needCount=self:getNow2TargetNumNeedCount(nowNum,posNum[i])
self.rollTimeList[i]=(round+i*self.addRoundCount)*self.numCount+needCount
local delayTime=(i-1)*finishOneNextTime
self:roll2NextByRollIndex(i,speed,delayTime,true)
end
end


function UIWDCQLiveBroadcastRoomLotteryWin:changRollNum(num)
local posNumList=self:getPosNumListByNum(num)


for i=1,self.rollNumItemCount do
local posNum=posNumList[i]
local posNumIndex=self.numTableIndexList_lookup[posNum]
self.numNowSelectIndex[i]=posNumIndex
end


self:refreshRoll()
end


function UIWDCQLiveBroadcastRoomLotteryWin:getNow2TargetNumNeedCount(nowNum,targetNum)
local nowNumIndex=self.numTableIndexList_lookup[nowNum]
local targetNumIndex=self.numTableIndexList_lookup[targetNum]
if targetNumIndex>nowNumIndex then
return targetNumIndex-nowNumIndex
else
return self.numCount-nowNumIndex+targetNumIndex
end
end

function UIWDCQLiveBroadcastRoomLotteryWin:getPosNumListByNum(num)
local posNum={}
posNum[1]=num%10
posNum[2]=num<10 and 0 or math.floor(num%100/10)
posNum[3]=num<100 and 0 or math.floor(num%1000/100)
posNum[4]=num<1000 and 0 or math.floor(num/1000)

return posNum
end

function UIWDCQLiveBroadcastRoomLotteryWin:finishRollByIndex(rollIndex)
self.rollFinishCount=self.rollFinishCount+1
if self.rollFinishCount>=self.rollNumItemCount then

self.isRolling=nil

local num=self.finishRollNum
self.finishRollNum=nil

self.winlua:SetChildButtonInteractable(self.lotteryBtn:getID(),true)
showPrizeControl.showWindow({{itemid=self.moneyId,num=num}})
end
end



function UIWDCQLiveBroadcastRoomLotteryWin:initRollNumData()
self.rollNumItemList={}
local grids=self.numList:getChildCommonLayoutGroupWidgetList()
self.rollNumItemCount=grids.Count
for i=1,self.rollNumItemCount do
self.rollNumItemList[i]=grids[i-1]
end



self.numTable={0,9,8,7,6,5,4,3,2,1}
self.numTableIndexList_lookup={}
self.numNowSelectIndex={1,1,1,1}
self.numCount=#self.numTable
local count=#self.numTable
for i=1,count do
local num=self.numTable[i]
self.numTableIndexList_lookup[num]=i
end


self:refreshRoll()
end

function UIWDCQLiveBroadcastRoomLotteryWin:refreshRoll()
for i=1,self.rollNumItemCount do
self:refreshRollItem(i)
end
end

function UIWDCQLiveBroadcastRoomLotteryWin:refreshRollItem(itemIndex,isSetByRollData)
local rollItem=self.rollNumItemList[itemIndex]
local selectIndex=self.numNowSelectIndex[itemIndex]
local nowNum=self.numTable[selectIndex]
local nextIndex=selectIndex+1
if nextIndex>self.numCount then
nextIndex=1
end
local nextNum=self.numTable[nextIndex]
rollItem:SetChildText(rollItemIndex.numText_now,nowNum)

local nowScale=1
local nextScale=0
local nowColor=1
local nextColor=_minColor
if isSetByRollData then
nowScale=nowScale+self.rollRemainingData[itemIndex].remainingNowScale
nextScale=nextScale-self.rollRemainingData[itemIndex].remainingNextScale
nowColor=nowColor+self.rollRemainingData[itemIndex].remainingNowColor
nextColor=nextColor-self.rollRemainingData[itemIndex].remainingNextColor
end

rollItem:SetChildColor(rollItemIndex.num_now,Color.New(nowColor,nowColor,nowColor,1))
rollItem:SetChildScale(rollItemIndex.num_now,Vector3.New(1,nowScale,1))
rollItem:SetChildScale(rollItemIndex.num_next,Vector3.New(1,nextScale,1))
rollItem:SetChildColor(rollItemIndex.num_next,Color.New(nextColor,nextColor,nextColor,1))

rollItem:SetChildText(rollItemIndex.numText_next,nextNum)
end