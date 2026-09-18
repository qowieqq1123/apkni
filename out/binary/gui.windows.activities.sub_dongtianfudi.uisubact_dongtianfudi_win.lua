







def_class("UISubAct_dongtianfudi_Win",UIWindowBase)









function UISubAct_dongtianfudi_Win:bindComponents()

self.bgModel=UIObject.get(self,0)
self.cost1=UILinkImageText.get(self,1)
self.cost2=UILinkImageText.get(self,2)
self.costBg_1=UIObject.get(self,3)
self.costBg_2=UIObject.get(self,4)
self.countDown=UIText.get(self,5)
self.effect_1=UIObject.get(self,6)
self.effect_2=UIObject.get(self,7)
self.effect_3=UIObject.get(self,8)
self.effect_4=UIObject.get(self,9)
self.enableReddotTipsToggle=UIToggleButton.get(self,10)
self.ieffect=UIObject.get(self,11)
self.infoBg=UIObject.get(self,12)
self.infoRoot=UIObject.get(self,13)
self.infoText=UIText.get(self,14)
self.itemsRoot=UIObject.get(self,15)
self.lockpos=UIObject.get(self,16)
self.mask=UIObject.get(self,17)
self.model=UIObject.get(self,18)
self.moneyBtn=UIButton.get(self,19)
self.moneyRoot=UIObject.get(self,20)
self.oneButton=UIButton.get(self,21)
self.oneReddot=UIObject.get(self,22)
self.posButton=UIButton.get(self,23)
self.posReddot=UIObject.get(self,24)
self.rewardList=UIObject.get(self,25)
self.ruleButton=UIButton.get(self,26)
self.showModel_1=UIButton.get(self,27)
self.showModel_2=UIButton.get(self,28)
self.showModel_3=UIButton.get(self,29)
self.showModel_4=UIButton.get(self,30)
self.SkeletonGraphic=UIObject.get(self,31)
self.SkeletonGraphic2=UIObject.get(self,32)
self.skip=UIToggleButton.get(self,33)
self.tenButton=UIButton.get(self,34)
self.tenReddot=UIObject.get(self,35)
self.Text1=UIText.get(self,36)
self.title=UIImage.get(self,37)

self.moneyBtn:setButtonClick(function()self:onMoneyBtn()end)

self.oneButton:setButtonClick(function()self:onOneButton()end)

self.posButton:setButtonClick(function()self:onPosButton()end)

self.ruleButton:setButtonClick(function()self:onRuleButton()end)

self.showModel_1:setButtonClick(function()self:onShowModel_1()end)

self.showModel_2:setButtonClick(function()self:onShowModel_2()end)

self.showModel_3:setButtonClick(function()self:onShowModel_3()end)

self.showModel_4:setButtonClick(function()self:onShowModel_4()end)

self.tenButton:setButtonClick(function()self:onTenButton()end)
self.costBg={
self.costBg_1,
self.costBg_2,
}
self.effect={
self.effect_1,
self.effect_2,
self.effect_3,
self.effect_4,
}
self.showModel={
self.showModel_1,
self.showModel_2,
self.showModel_3,
self.showModel_4,
}



end


function UISubAct_dongtianfudi_Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.cost1);self.cost1=nil;
_UIObject_release(self.cost2);self.cost2=nil;
_UIObject_release(self.costBg_1);self.costBg_1=nil;
_UIObject_release(self.costBg_2);self.costBg_2=nil;
_UIObject_release(self.countDown);self.countDown=nil;
_UIObject_release(self.effect_1);self.effect_1=nil;
_UIObject_release(self.effect_2);self.effect_2=nil;
_UIObject_release(self.effect_3);self.effect_3=nil;
_UIObject_release(self.effect_4);self.effect_4=nil;
_UIObject_release(self.enableReddotTipsToggle);self.enableReddotTipsToggle=nil;
_UIObject_release(self.ieffect);self.ieffect=nil;
_UIObject_release(self.infoBg);self.infoBg=nil;
_UIObject_release(self.infoRoot);self.infoRoot=nil;
_UIObject_release(self.infoText);self.infoText=nil;
_UIObject_release(self.itemsRoot);self.itemsRoot=nil;
_UIObject_release(self.lockpos);self.lockpos=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.moneyBtn);self.moneyBtn=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.oneButton);self.oneButton=nil;
_UIObject_release(self.oneReddot);self.oneReddot=nil;
_UIObject_release(self.posButton);self.posButton=nil;
_UIObject_release(self.posReddot);self.posReddot=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.ruleButton);self.ruleButton=nil;
_UIObject_release(self.showModel_1);self.showModel_1=nil;
_UIObject_release(self.showModel_2);self.showModel_2=nil;
_UIObject_release(self.showModel_3);self.showModel_3=nil;
_UIObject_release(self.showModel_4);self.showModel_4=nil;
_UIObject_release(self.SkeletonGraphic);self.SkeletonGraphic=nil;
_UIObject_release(self.SkeletonGraphic2);self.SkeletonGraphic2=nil;
_UIObject_release(self.skip);self.skip=nil;
_UIObject_release(self.tenButton);self.tenButton=nil;
_UIObject_release(self.tenReddot);self.tenReddot=nil;
_UIObject_release(self.Text1);self.Text1=nil;
_UIObject_release(self.title);self.title=nil;
self.costBg=nil;
self.effect=nil;
self.showModel=nil;
end
















local _this




local animList={{2131,2132,2133,2134},{2135,2136,2137,2138},{2140,2141,2142,2143}}
function UISubAct_dongtianfudi_Win:onLoaded(...)
self:bindComponents()
_this=self
self.isShowMoney=true
self.ieffect:setChildShowEffect(10357,true)


self:addNotify(notifyConfig.onShowPrize,function(prizeType,rewards,effectData)
if prizeType==ePrizeType.eDongTianFuDi then
self:onShowPrize(prizeType,rewards,effectData)
end
end)

self:addNotify(notifyConfig.onSubActivityOverBeforeEndTime24Hour,_this.onSubActivityOverBeforeEndTime24Hour)


self.skip:setToggleChange(function(name,isOn)






self:onSkipBtn(isOn)
end)
self.enableReddotTipsToggle:setToggleChange(function(...)
self:OnEnableReddotTipsToggleChanged(...)
end)
local pos=self:getChildCanvas(-1)
self.sortLayer=pos[1]
self.sortOrder=pos[2]

self:showInfoRoot(1)
end


function UISubAct_dongtianfudi_Win:__delete()
self:unbindComponents()
self.clickCD=nil
end




function UISubAct_dongtianfudi_Win:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eDongTianFuDi
self.subid=argtable.sub_act_id
if argtable.extraParams then
self.jumpIdx=argtable.extraParams.jumpIndex
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
self.newFuDiList={}

self:refreshReward()
self:refreshFuDi(true)
self:refreshFuDiPos()
self:refreshTotalNum()
self:refreshBuyBtn()
self:refreshPosBtn()


local typo=ACTOR_SETTING_TYPE.eDongtianfudi
local data=userActorArraySetting.getBase(typo,{})
self.isSkip=data['1']or false
self.skip:setToggle(self.isSkip)
self.enableReddotTipsToggle:setToggle(self.info:checkIsShowReddot())

self:startCountDown()
end

function UISubAct_dongtianfudi_Win:onRecv()
self:refreshFuDi()
self:refreshTotalNum()
self:refreshBuyBtn()
self:refreshPosBtn()
end

function UISubAct_dongtianfudi_Win:refreshPosBtn()
local info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
if not info then
self.lockpos:setActive(true)
self.posButton:setGray(true)
self.isLockPos=true
else
local lock=not info:checkUnlockPos()
self.lockpos:setActive(lock)
self.isLockPos=lock
self.posButton:setGray(lock)
end
end

function UISubAct_dongtianfudi_Win:refreshFuDi(init)
local lotteryList=self.config.lotteryList
local modelList=self.config.model



local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)

local total_num=data.total_num




local num=0
for i=1,#modelList do

local widget=self.showModel[i]:getChildWidgetBase()
local lotteryList=self.config.lotteryList
local lottery=lotteryList[i]
local needLo=lottery[1]



local isUnlock=total_num>=needLo



widget:SetChildActive(1,not isUnlock)
widget:SetChildProgress(1,total_num,needLo)
widget:SetChildProgressText(1,FMT.fmt("{0}/{1}",total_num,needLo))
local flag,times=activitiesHandle_dongtianfudi:getCanBuyTimes(self.actid,self.subid,i)
widget:SetChildCanvasGroupAlpha(3,flag==1 and 1 or 0)
self:doPunchRotation(widget,3,i,flag==1)
widget:SetChildButtonClick(0,function()
activitiesHandle_dongtianfudi:showGaiLvWin(self,i,self.activityArgs)
end)
if isUnlock then
num=num+1
end
end


local lottery=lotteryList[1]
local lotteryKu=lottery[5]
if lotteryKu then
self.dajiangMax=lotteryKu[#lotteryKu][1]
end

if init then
self.num=num
self.SkeletonGraphic:setChildSpineAnimation(animList[1][num],1)


end
self:refreshReward()
end

function UISubAct_dongtianfudi_Win:getState()
local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
local total_num=data.total_num
local modelList=self.config.model
local num=0
for i=1,#modelList do
local lotteryList=self.config.lotteryList
local lottery=lotteryList[i]
local needLo=lottery[1]

local isUnlock=total_num>=needLo
if isUnlock then
num=num+1
end
end
return num
end

function UISubAct_dongtianfudi_Win:showInfoRoot(alpha)
self.infoRoot:setChildCanvasGroupAlpha(alpha)
end

function UISubAct_dongtianfudi_Win:refreshFuDiPos(hide)
local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
local lock_idx=data.lock_idx

for i,spos in ipairs(self.showModel)do
local widget=self.showModel[i]:getChildWidgetBase()
widget:SetChildActive(2,(not hide)and i==lock_idx)
widget:SetChildShowEffect(2,10345,(not hide)and i==lock_idx)
end
self:refreshReward()
end

function UISubAct_dongtianfudi_Win:refreshFuDiReddot()
local modelList=self.config.model
for i,smodel in ipairs(self.showModel)do
local model=modelList[i]
if model then
local flag,times=activitiesHandle_dongtianfudi:getCanBuyTimes(self.actid,self.subid,i)

local widget=self.showModel[i]:getChildWidgetBase()
widget:SetChildCanvasGroupAlpha(3,flag==1 and 1 or 0)
self:doPunchRotation(widget,3,i,flag==1)
else
smodel:setActive(false)
end
end
end

function UISubAct_dongtianfudi_Win:refreshReward()
local rewards=self.config.show
local new=self:getState()
local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
local lock_idx=data.lock_idx
local rewardList=rewards[2][new]
if lock_idx>0 then
rewardList=rewards[1][lock_idx]
end
local num=#rewardList
self.rewardList:setChildScrollViewCreateGrids(num,num)
local grids=self.rewardList:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local reward=rewardList[i]
local grid=grids[i-1]
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end

local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
grid:SetChildPropData(0,prop)
grid:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end
self.rewardList:setChildScrollViewSelectItem(0,false,false,false)
end

function UISubAct_dongtianfudi_Win:refreshTotalNum()
local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
local lottery_num=data.lottery_num
self.infoText:setText(FMT.fmt("再探索{0}次必出大奖",self.dajiangMax-lottery_num))
end

function UISubAct_dongtianfudi_Win:refreshBuyBtn()
local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
local use_free_num=data.use_free_num or 0
local freeTimes=self.config.free_num
local lottery_item=self.config.lottery_item
local iconname=iconHelper.getIconName(lottery_item)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,40)
local cost=cfgHelper.getdef(cfg_dtfdactivityconfig,'item_num')

self.moneyType=lottery_item
if freeTimes-use_free_num>0 then
self.Text1:setText("本次免费")
self.costBg_1:setActive(false)
self.oneReddot:setActive(true)
else
self.costBg_1:setActive(true)
self.Text1:setText("探索一次")
self.cost1:setText(FMT.fmt("{0}{1}",iconStr,cost[1]))
if pfwindowslController:checkIsGameVersion_yuenan()then
self.cost1:setText(FMT.fmt("{0}  {1}",iconStr,cost[1]))
end
self.oneReddot:setActive(false)
end


local count=itemsModel.getCount(lottery_item)
self.tenReddot:setActive(count>=cost[2])

self.cost2:setText(FMT.fmt("{0}{1}",iconStr,cost[2]))
if pfwindowslController:checkIsGameVersion_yuenan()then
self.cost2:setText(FMT.fmt("{0}  {1}",iconStr,cost[2]))
end
self:freshMoney()
end


function UISubAct_dongtianfudi_Win:onHide()

end
function UISubAct_dongtianfudi_Win:freshMoney()
if not self.isShowMoney then
self.moneyRoot:setActive(false)
return
end

self.moneyRoot:setActive(true)
local widget=self.winlua:GetChildWidgetBase(self.moneyRoot:getID())
local moneyType=self.moneyType
local isAdd=true
local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildIcon(0,iconHelper.getIconName(moneyType),false)
widget:SetChildText(1,moneyStr)
widget:SetChildActive(2,isAdd)
widget:SetChildButtonClick(2,function()self:onAddClick(moneyType)end,true)
end
function UISubAct_dongtianfudi_Win:ScrollToIndex(q,w,e,r)


end

function UISubAct_dongtianfudi_Win:doAnim(cb,fudi_num,fudiList,newFuDiList)
if newFuDiList then
for i,v in pairs(newFuDiList)do
self.newFuDiList[i]=true
end
end
self:refreshPosReddot()
if not self.isSkip then
local new=self:getState()

self.itemsRoot:setChildCanvasGroupAlpha(0)
self.SkeletonGraphic:setChildSpineAnimation(animList[2][new],1)

self.lockAnim=true
self.mask:setActive(true)
self:refreshFuDiPos(true)

AudioManager.playAudio(644)

for i,smodel in ipairs(self.showModel)do
local widget=self.showModel[i]:getChildWidgetBase()
widget:SetChildCanvasGroupAlpha(3,0)
end

self:delayDo(3.3,function()
self.ieffect:setScale(Vector3.one)
self.ieffect:setChildShowEffect(10357,true)


if self.rewardColor then
self.rewardColor=nil
end
end)

self:delayDo(3.5,function()
self.mask:setActive(false)
if self.showReward then

self:showRewardWin(self.showReward,self.showTips,self.effectList)
self.showReward=nil
end
self.lockAnim=nil
if self and not self.isClose then
self:onRecv()
end
self:refreshFuDiPos()
self:refreshFuDiReddot()



self.itemsRoot:setChildCanvasGroupAlpha(1)
if newFuDiList and newFuDiList[1]then
activitiesHandle_dongtianfudi:unlockPos()
end
end)
else
local new=self:getState()

if self.num~=new then
self.SkeletonGraphic:setChildSpineAnimation(animList[3][new],1)
end

self.num=new

if newFuDiList and newFuDiList[1]then
activitiesHandle_dongtianfudi:unlockPos()
end
end
end

function UISubAct_dongtianfudi_Win:setPosButtonActive(active)
self.lockpos:setScale(active and Vector3.one or Vector3.zero)
self.posButton:setScale(active and Vector3.one or Vector3.zero)
end

function UISubAct_dongtianfudi_Win:getEffectList()
if not self.effectItemList then
local show2=self.config.show2
local effectList={}
for _,v in ipairs(show2)do
for _,v2 in ipairs(v)do
if v2[4]==1 then
effectList[v2[1]]=1
end
end
end
self.effectItemList=effectList
end
return self.effectItemList
end

function UISubAct_dongtianfudi_Win:onShowPrize(prizeType,rewards,effectData)

local showReward={}
local showTips=''
local topColor=1
local tipsCount=1
local effectList={}
local effectCfg=self:getEffectList()
for i,v in ipairs(rewards)do
local isMoney=false
for _,money in ipairs(activitiesHandle_dongtianfudi.exchangeMoneyType)do
if v.itemid==money then
isMoney=true
local iconname=iconHelper.getIconName(money)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,40)
if tipsCount==1 then
showTips=FMT.fmt("获得：{0}{1}",iconStr,v.num)
else
if pfwindowslController:checkIsGameVersion_yuenan()then
showTips=FMT.fmt("{0}  {1}  {2}",showTips,iconStr,v.num)
else
showTips=FMT.fmt("{0}  {1}{2}",showTips,iconStr,v.num)
end
end
tipsCount=tipsCount+1
break
end
end

if not isMoney then
table.insert(showReward,v)
end
local color=itemsConfig.getItemColor(v.itemid)
if color>topColor then
topColor=color
end

if effectCfg[v.itemid]then
effectList[v.itemid]=true
end
end


if self.isSkip then
self.mask:setActive(false)


self:showRewardWin(showReward,showTips,effectList)

self.lockAnim=nil
self:onRecv()
self:refreshFuDiPos()

self.showReward=nil
self.showTips=nil
self.rewardColor=nil
else
self.showReward=showReward
self.showTips=showTips

self.rewardColor=topColor
self.effectList=effectList
end
end


function UISubAct_dongtianfudi_Win:showRewardWin(rewards,showTips,effectList)
local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
local use_free_num=data.use_free_num or 0
local freeTimes=self.config.free_num
local lottery_item=self.config.lottery_item
local cost=cfgHelper.getdef(cfg_dtfdactivityconfig,'item_num')
local btnData={
{
text=freeTimes-use_free_num>0 and'本次免费'or'探索一次',
cost=freeTimes-use_free_num>0 and nil or{lottery_item,cost[1]},
callback=function()
if not self.isSkip then
UIManager:closeWindow("UICommonShowPrizeThreeWin")
end
self:onOneButton()
end
},
{
text='探索十次',
cost={lottery_item,cost[2]},
callback=function()
if not self.isSkip then
UIManager:closeWindow("UICommonShowPrizeThreeWin")
end
self:onTenButton()
end
},
}

local args={
list=rewards,
tips=showTips,
btnData=btnData,
closeTips="",
effect=effectList,
moneytypes={{lottery_item}},
}
UIManager:showWindow('UICommonShowPrizeThreeWin',args)
end





function UISubAct_dongtianfudi_Win:doPunchRotation(widget,componentIndex,reddotIndex,isReddot)
if isReddot then
if self.reddotTweenerList==nil then
self.reddotTweenerList={}
end
if not reddotIndex then
reddotIndex=#self.reddotTweenerList+1
end

if self.reddotTweenerList[reddotIndex]==nil then

widget:SetChildRotation(componentIndex,0,0,0)
local tweener=widget:SetChildDOPunchRotation(componentIndex,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweenerList[reddotIndex]={}
self.reddotTweenerList[reddotIndex].tweener=tweener
self.reddotTweenerList[reddotIndex].widget=widget
self.reddotTweenerList[reddotIndex].componentIndex=componentIndex
end

return reddotIndex
else
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return nil
end
if self.reddotTweenerList[reddotIndex]~=nil then
self.reddotTweenerList[reddotIndex].tweener:Complete()
self.reddotTweenerList[reddotIndex].tweener:Kill()
self.reddotTweenerList[reddotIndex]=nil
widget:SetChildRotation(componentIndex,0,0,0)
return nil
end
end
end


function UISubAct_dongtianfudi_Win:endAllReddotPunchRotation()
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return
end
for i,v in pairs(self.reddotTweenerList)do
if v~=nil then
v.tweener:Complete()
v.tweener:Kill()
local widget=v.widget
local componentIndex=v.componentIndex
widget:SetChildRotation(componentIndex,0,0,0)

self.reddotTweenerList[i]=nil
end
end
end
function UISubAct_dongtianfudi_Win:refreshPosReddot()
self.posReddot:setActive(next(self.newFuDiList)~=nil)
end

function UISubAct_dongtianfudi_Win:callActivityInfoFunc(fname,...)
local info=activitiesModel:getSubActInfo(self.actid,SUB_ACTIVITY_TYPE.eDongTianFuDi,self.subid)
return info[fname](info,...)
end


function UISubAct_dongtianfudi_Win:startCountDown()
local time=self:callActivityInfoFunc('getEndLeftTime')
local endTime=os.time()+time
local tick=function()
local dt=endTime-os.time()
self.countDown:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp11(dt,true)))
if dt<=0 then
self:clearTimer()
end
end
self:clearTimer()
self.timer=self:setTimer(1,time+5,tick)
tick()
end

function UISubAct_dongtianfudi_Win:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end





function UISubAct_dongtianfudi_Win:onShowModel_1()
activitiesHandle_dongtianfudi:showGaiLvWin(self,1,self.activityArgs)
end



function UISubAct_dongtianfudi_Win:onOneButton()
if self.lockAnim then
return
end

local lottery_item=self.config.lottery_item
local cost=cfgHelper.getdef(cfg_dtfdactivityconfig,'item_num')
local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
local use_free_num=data.use_free_num or 0
local freeTimes=self.config.free_num

local cb=function()

if self.clickCD then
return
end
self:delayDo(1,function()
self.clickCD=nil
end)

activitiesHandle_dongtianfudi.sendLottery(self.actid,self.subid,1)
self.clickCD=true
end
local count=itemsModel.getCount(lottery_item)
if count>=cost[1]or freeTimes-use_free_num>0 then
cb()
else
gainControl:showGainWin(lottery_item)
end
end



function UISubAct_dongtianfudi_Win:onTenButton()
if self.lockAnim then
return
end
local lottery_item=self.config.lottery_item
local cost=cfgHelper.getdef(cfg_dtfdactivityconfig,'item_num')
local cb=function()
if self.clickCD then
return
end
self:delayDo(1,function()
self.clickCD=nil
end)

activitiesHandle_dongtianfudi.sendLottery(self.actid,self.subid,2)
self.clickCD=true
end

local count=itemsModel.getCount(lottery_item)

if count>=cost[2]then
cb()
else
gainControl:showGainWin(lottery_item)
end
end



function UISubAct_dongtianfudi_Win:onRuleButton()
local d={}
d.title='活动规则'
d.mode=3
d.name='act_dongtianfudi_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end



function UISubAct_dongtianfudi_Win:onPosButton()
if self.isLockPos then
local config=activitiesModel:getSubActivityConfig(SUB_ACTIVITY_TYPE.eDongTianFuDi,self.subid)
local lotteryList=config.lotteryList
local total=self.info and self.info.data.total_num or 0

local needCount=lotteryList[1][2]-total
UIManager:showWindow('UISubAct_dongtianfudi_posLock_Win',{needCount})
return
end
self:showWindow("UISubAct_dongtianfudi_pos_win",{args=self.activityArgs,newFuDi=self.newFuDiList})
self.newFuDiList={}
self:refreshPosReddot()
end



function UISubAct_dongtianfudi_Win:onShowModel_2()
activitiesHandle_dongtianfudi:showGaiLvWin(self,2,self.activityArgs)
end



function UISubAct_dongtianfudi_Win:onShowModel_3()
activitiesHandle_dongtianfudi:showGaiLvWin(self,3,self.activityArgs)
end



function UISubAct_dongtianfudi_Win:onShowModel_4()
activitiesHandle_dongtianfudi:showGaiLvWin(self,4,self.activityArgs)
end

function UISubAct_dongtianfudi_Win:onMoneyBtn()
if self.lockAnim then
return
end
if self.moneyType==eMoneyType.mtXianYu then
UIFullRechargeController:showRechargeWindow()
else
gainControl:showGainWin(self.moneyType)
end
end

function UISubAct_dongtianfudi_Win:onSkipBtn(isOn)
local typo=ACTOR_SETTING_TYPE.eDongtianfudi
local data=userActorArraySetting.getBase(typo,{})
data['1']=isOn
self.isSkip=isOn
userActorArraySetting.setBase(typo,data)
userActorArraySetting.flush(typo)
end

function UISubAct_dongtianfudi_Win:OnEnableReddotTipsToggleChanged(name,isOn,data)
self.info:setIsShowReddot(isOn)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)
end

function UISubAct_dongtianfudi_Win.onSubActivityOverBeforeEndTime24Hour(actId,subType,subId)
if _this==nil then return end
if _this.actid==actId and _this.subType==subType and _this.subid==subId then
_this:OnEnableReddotTipsToggleChanged(nil,true,nil)
end
end