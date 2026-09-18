







def_class("UISubAct_ChaosLingChiWin",UIWindowBase)









function UISubAct_ChaosLingChiWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.bgModel2=UIObject.get(self,1)
self.effect1=UIObject.get(self,2)
self.effectChou=UIObject.get(self,3)
self.effectFixFail=UIObject.get(self,4)
self.effectLottery=UIObject.get(self,5)
self.effectLotteryTxt=UIObject.get(self,6)
self.effectRoot=UIObject.get(self,7)
self.fixBallModel_1=UIObject.get(self,8)
self.fixBallModel_10=UIObject.get(self,9)
self.fixBallModel_2=UIObject.get(self,10)
self.fixBallModel_3=UIObject.get(self,11)
self.fixBallModel_4=UIObject.get(self,12)
self.fixBallModel_5=UIObject.get(self,13)
self.fixBallModel_6=UIObject.get(self,14)
self.fixBallModel_7=UIObject.get(self,15)
self.fixBallModel_8=UIObject.get(self,16)
self.fixBallModel_9=UIObject.get(self,17)
self.fixBg=UIObject.get(self,18)
self.fixBtn=UIButton.get(self,19)
self.fixCompleteTips=UIObject.get(self,20)
self.fixPanel=UIObject.get(self,21)
self.fixProgressBar=UIObject.get(self,22)
self.fixProgressImg=UIObject.get(self,23)
self.fixProgressTxt=UIText.get(self,24)
self.freeOnce=UIText.get(self,25)
self.jumpAnimation=UIToggleButton.get(self,26)
self.manyBtn=UIButton.get(self,27)
self.manyBtnReddot=UIObject.get(self,28)
self.manyBtnTx=UIText.get(self,29)
self.manyIcon=UIImage.get(self,30)
self.manyNum=UIText.get(self,31)
self.moneyBg=UIButton.get(self,32)
self.moneyIcon=UIImage.get(self,33)
self.moneyNum=UIText.get(self,34)
self.nextTx=UIText.get(self,35)
self.onceBtn=UIButton.get(self,36)
self.onceBtnReddot=UIObject.get(self,37)
self.onceBtnTx=UIText.get(self,38)
self.onceCost=UIObject.get(self,39)
self.onceIcon=UIImage.get(self,40)
self.onceNum=UIText.get(self,41)
self.point_1=UIButton.get(self,42)
self.point_10=UIButton.get(self,43)
self.point_2=UIButton.get(self,44)
self.point_3=UIButton.get(self,45)
self.point_4=UIButton.get(self,46)
self.point_5=UIButton.get(self,47)
self.point_6=UIButton.get(self,48)
self.point_7=UIButton.get(self,49)
self.point_8=UIButton.get(self,50)
self.point_9=UIButton.get(self,51)
self.pointArray=UIObject.get(self,52)
self.rBtnPanel=UIObject.get(self,53)
self.recordBtn=UIButton.get(self,54)
self.rewadProgress=UIObject.get(self,55)
self.rewardBtn=UIButton.get(self,56)
self.rewardContent=UIObject.get(self,57)
self.rewardGrid=UIObject.get(self,58)
self.rewardNumTxt=UIText.get(self,59)
self.rewardProgressBar=UIObject.get(self,60)
self.rewardProgresseffect=UIObject.get(self,61)
self.rewardScrollView=UIObject.get(self,62)
self.shuihuaPoint_1=UIObject.get(self,63)
self.shuihuaPoint_10=UIObject.get(self,64)
self.shuihuaPoint_2=UIObject.get(self,65)
self.shuihuaPoint_3=UIObject.get(self,66)
self.shuihuaPoint_4=UIObject.get(self,67)
self.shuihuaPoint_5=UIObject.get(self,68)
self.shuihuaPoint_6=UIObject.get(self,69)
self.shuihuaPoint_7=UIObject.get(self,70)
self.shuihuaPoint_8=UIObject.get(self,71)
self.shuihuaPoint_9=UIObject.get(self,72)
self.shuihuaPointArray=UIObject.get(self,73)
self.shuihuaSkeletonGraphic=UIObject.get(self,74)
self.SkeletonGraphic=UIObject.get(self,75)
self.speakObj=UIObject.get(self,76)
self.speakText=UIText.get(self,77)
self.suipianBg=UIButton.get(self,78)
self.suipianIcon=UIImage.get(self,79)
self.tansuoBottleTx=UIText.get(self,80)
self.tansuoBtn=UIButton.get(self,81)
self.tansuoBtnReddot=UIObject.get(self,82)
self.timeBg=UIObject.get(self,83)
self.timeTx=UIText.get(self,84)
self.isShowReddotBtn=UIButton.get(self,85)

self.fixBtn:setButtonClick(function()self:onFixBtn()end)

self.manyBtn:setButtonClick(function()self:onManyBtn()end)

self.moneyBg:setButtonClick(function()self:onMoneyBg()end)

self.onceBtn:setButtonClick(function()self:onOnceBtn()end)

self.point_1:setButtonClick(function()self:onPoint_1()end)

self.point_10:setButtonClick(function()self:onPoint_10()end)

self.point_2:setButtonClick(function()self:onPoint_2()end)

self.point_3:setButtonClick(function()self:onPoint_3()end)

self.point_4:setButtonClick(function()self:onPoint_4()end)

self.point_5:setButtonClick(function()self:onPoint_5()end)

self.point_6:setButtonClick(function()self:onPoint_6()end)

self.point_7:setButtonClick(function()self:onPoint_7()end)

self.point_8:setButtonClick(function()self:onPoint_8()end)

self.point_9:setButtonClick(function()self:onPoint_9()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.suipianBg:setButtonClick(function()self:onSuipianBg()end)

self.tansuoBtn:setButtonClick(function()self:onTansuoBtn()end)

self.isShowReddotBtn:setButtonClick(function()self:onIsShowReddotBtn()end)
self.fixBallModel={
self.fixBallModel_1,
self.fixBallModel_2,
self.fixBallModel_3,
self.fixBallModel_4,
self.fixBallModel_5,
self.fixBallModel_6,
self.fixBallModel_7,
self.fixBallModel_8,
self.fixBallModel_9,
self.fixBallModel_10,
}
self.point={
self.point_1,
self.point_2,
self.point_3,
self.point_4,
self.point_5,
self.point_6,
self.point_7,
self.point_8,
self.point_9,
self.point_10,
}
self.shuihuaPoint={
self.shuihuaPoint_1,
self.shuihuaPoint_2,
self.shuihuaPoint_3,
self.shuihuaPoint_4,
self.shuihuaPoint_5,
self.shuihuaPoint_6,
self.shuihuaPoint_7,
self.shuihuaPoint_8,
self.shuihuaPoint_9,
self.shuihuaPoint_10,
}



end


function UISubAct_ChaosLingChiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.bgModel2);self.bgModel2=nil;
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.effectChou);self.effectChou=nil;
_UIObject_release(self.effectFixFail);self.effectFixFail=nil;
_UIObject_release(self.effectLottery);self.effectLottery=nil;
_UIObject_release(self.effectLotteryTxt);self.effectLotteryTxt=nil;
_UIObject_release(self.effectRoot);self.effectRoot=nil;
_UIObject_release(self.fixBallModel_1);self.fixBallModel_1=nil;
_UIObject_release(self.fixBallModel_10);self.fixBallModel_10=nil;
_UIObject_release(self.fixBallModel_2);self.fixBallModel_2=nil;
_UIObject_release(self.fixBallModel_3);self.fixBallModel_3=nil;
_UIObject_release(self.fixBallModel_4);self.fixBallModel_4=nil;
_UIObject_release(self.fixBallModel_5);self.fixBallModel_5=nil;
_UIObject_release(self.fixBallModel_6);self.fixBallModel_6=nil;
_UIObject_release(self.fixBallModel_7);self.fixBallModel_7=nil;
_UIObject_release(self.fixBallModel_8);self.fixBallModel_8=nil;
_UIObject_release(self.fixBallModel_9);self.fixBallModel_9=nil;
_UIObject_release(self.fixBg);self.fixBg=nil;
_UIObject_release(self.fixBtn);self.fixBtn=nil;
_UIObject_release(self.fixCompleteTips);self.fixCompleteTips=nil;
_UIObject_release(self.fixPanel);self.fixPanel=nil;
_UIObject_release(self.fixProgressBar);self.fixProgressBar=nil;
_UIObject_release(self.fixProgressImg);self.fixProgressImg=nil;
_UIObject_release(self.fixProgressTxt);self.fixProgressTxt=nil;
_UIObject_release(self.freeOnce);self.freeOnce=nil;
_UIObject_release(self.jumpAnimation);self.jumpAnimation=nil;
_UIObject_release(self.manyBtn);self.manyBtn=nil;
_UIObject_release(self.manyBtnReddot);self.manyBtnReddot=nil;
_UIObject_release(self.manyBtnTx);self.manyBtnTx=nil;
_UIObject_release(self.manyIcon);self.manyIcon=nil;
_UIObject_release(self.manyNum);self.manyNum=nil;
_UIObject_release(self.moneyBg);self.moneyBg=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyNum);self.moneyNum=nil;
_UIObject_release(self.nextTx);self.nextTx=nil;
_UIObject_release(self.onceBtn);self.onceBtn=nil;
_UIObject_release(self.onceBtnReddot);self.onceBtnReddot=nil;
_UIObject_release(self.onceBtnTx);self.onceBtnTx=nil;
_UIObject_release(self.onceCost);self.onceCost=nil;
_UIObject_release(self.onceIcon);self.onceIcon=nil;
_UIObject_release(self.onceNum);self.onceNum=nil;
_UIObject_release(self.point_1);self.point_1=nil;
_UIObject_release(self.point_10);self.point_10=nil;
_UIObject_release(self.point_2);self.point_2=nil;
_UIObject_release(self.point_3);self.point_3=nil;
_UIObject_release(self.point_4);self.point_4=nil;
_UIObject_release(self.point_5);self.point_5=nil;
_UIObject_release(self.point_6);self.point_6=nil;
_UIObject_release(self.point_7);self.point_7=nil;
_UIObject_release(self.point_8);self.point_8=nil;
_UIObject_release(self.point_9);self.point_9=nil;
_UIObject_release(self.pointArray);self.pointArray=nil;
_UIObject_release(self.rBtnPanel);self.rBtnPanel=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.rewadProgress);self.rewadProgress=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardGrid);self.rewardGrid=nil;
_UIObject_release(self.rewardNumTxt);self.rewardNumTxt=nil;
_UIObject_release(self.rewardProgressBar);self.rewardProgressBar=nil;
_UIObject_release(self.rewardProgresseffect);self.rewardProgresseffect=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.shuihuaPoint_1);self.shuihuaPoint_1=nil;
_UIObject_release(self.shuihuaPoint_10);self.shuihuaPoint_10=nil;
_UIObject_release(self.shuihuaPoint_2);self.shuihuaPoint_2=nil;
_UIObject_release(self.shuihuaPoint_3);self.shuihuaPoint_3=nil;
_UIObject_release(self.shuihuaPoint_4);self.shuihuaPoint_4=nil;
_UIObject_release(self.shuihuaPoint_5);self.shuihuaPoint_5=nil;
_UIObject_release(self.shuihuaPoint_6);self.shuihuaPoint_6=nil;
_UIObject_release(self.shuihuaPoint_7);self.shuihuaPoint_7=nil;
_UIObject_release(self.shuihuaPoint_8);self.shuihuaPoint_8=nil;
_UIObject_release(self.shuihuaPoint_9);self.shuihuaPoint_9=nil;
_UIObject_release(self.shuihuaPointArray);self.shuihuaPointArray=nil;
_UIObject_release(self.shuihuaSkeletonGraphic);self.shuihuaSkeletonGraphic=nil;
_UIObject_release(self.SkeletonGraphic);self.SkeletonGraphic=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.suipianBg);self.suipianBg=nil;
_UIObject_release(self.suipianIcon);self.suipianIcon=nil;
_UIObject_release(self.tansuoBottleTx);self.tansuoBottleTx=nil;
_UIObject_release(self.tansuoBtn);self.tansuoBtn=nil;
_UIObject_release(self.tansuoBtnReddot);self.tansuoBtnReddot=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
_UIObject_release(self.isShowReddotBtn);self.isShowReddotBtn=nil;
self.fixBallModel=nil;
self.point=nil;
self.shuihuaPoint=nil;
end



















local _this=nil
local xiufuEffectID={
10731,
10732,
10733,
10734,
10735,
10736,
10737,
10738,
10739,
10740,
}
local eSpeakType={
posun='posunSpeakLib',
xiufu='xiufuSpeakLib',
restore='restoreSpeakLib',
lottery='lotterySpeakLib',
}


function UISubAct_ChaosLingChiWin:onLoaded(...)
self:bindComponents()
_this=self
self.jumpAnimation:setToggleChange(function(...)self:onJumpAnimation(...)end)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_change)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
self:addNotify(notifyConfig.onSubActivityOverBeforeEndTime24Hour,self.onSubActivityOverBeforeEndTime24Hour)
self.value=1
end


function UISubAct_ChaosLingChiWin:__delete()
self:unbindComponents()
_this=nil
self:stopCDTick()
self:stopFreeTick()
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_change)
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
end




function UISubAct_ChaosLingChiWin:onShow(argtable,afterOnloaded)
local oSubId=self.subId
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
end

self.isAnim=false
self.effectRoot:setActive(false)

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
if oSubId~=self.subId then
self:refreshButton()
end
self.recordBtn:setActive(self.config.self_record_cnt>0 or self.config.record_cnt>0)


self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end

local data=self.activityData.data
self.isJuLing=data.lib_idx>0
if afterOnloaded and deviceHelper.getAPILevel()>=18 then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.bgModel:getID(),false,true,false)
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.bgModel2:getID(),false,true,false)
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.fixBtn:getID(),false,true,false)
end
self.bgModel:setChildUIModelShowTarget(5591,1,{},eAnimationID.stand)
self.bgModel2:setChildUIModelShowTarget(5592,1,{},self.isJuLing and eAnimationID.hdlc_stand1 or eAnimationID.stand)
self.fixBtn:setChildUIModelShowTarget(5595,1,{},eAnimationID.stand)
self.effectChou:setChildShowEffect(self.isJuLing and 10742 or 10711,true)


self.nextTx:setActive(not self.isJuLing)
self.timeBg:setActive(not self.isJuLing)
self.pointArray:setActive(not self.isJuLing)
self.SkeletonGraphic:setChildSpineAnimation(eAnimationID.stand,1,nil)
self.shuihuaSkeletonGraphic:setChildSpineAnimation(eAnimationID.hdlc_xialuo,1,nil)
for i=1,#self.point do
self.point[i]:setChildShowEffect(10721,true)
end

local pointImages={self.point_3,self.point_4,self.point_5,self.point_6,self.point_9,self.point_10}
for i=1,#pointImages do
local reward=self.config.reward_tips[i]
local iconName=iconHelper.getIconName(reward)
pointImages[i]:setImageIcon(iconName,true)
pointImages[i]:setButtonClick()
pointImages[i]:setButtonClick(function()self:onEventImage(i)end)
end

self.fixPanel:setActive(self.isJuLing)
self.fixProgressBar:setActive(self.isJuLing)
if self.isJuLing then
for i=1,data.fix_time do
self.fixBallModel[i]:setChildShowEffect(xiufuEffectID[i],true)
self.fixBallModel[i]:setActive(true)
end
for i=data.fix_time+1,#self.fixBallModel do
self.fixBallModel[i]:setActive(false)
end
else
for i=1,#self.fixBallModel do
self.fixBallModel[i]:setActive(false)
end
end

if not self.activityData.data then

else
self:refreshFree()
self:refreshNext()
self:refreshExplore()
self:refreshManyReddot()
self:refreshFixPanel()
self:refreshFixProgress(true)
end
self:startCDTick()
self:refreshJumpAnimation()

self:checkExchangeTips()
self:refreshIsShowReddotBtn()

self:delayDo(0.35,function()
_this:initRewardPanel(false,true)
end)
end


function UISubAct_ChaosLingChiWin:onHide()
self:stopCDTick()
self:stopAllTimer()
self.effectLottery:setChildShowEffect(0,false)
self.effectLotteryTxt:setChildShowEffect(0,false)
end

function UISubAct_ChaosLingChiWin:checkExchangeTips()
local flag=onlineDataSetting:getData('act_exchargeShopTip_open',nil)
if flag~=true then
local day=self.activityData:getEndLeftDayTime()
if day<=1 then
local moneyType=self.config.money[1]
local num=itemsModel.getCount(moneyType)

if num>0 then
local args={
act_id=self.activityId,sub_act_type=self.subType,sub_act_id=self.subId
}
UIManager:showWindow('UISubAct_ChaosLingChiExchangeTipsWin',args)
end
end
end
end

function UISubAct_ChaosLingChiWin:OnEvent(idx)
if self.isAnim then
return
end
if idx then
local reward=self.config.reward_tips[idx]
tipsManager.showTips({itemid=reward})
end
end

function UISubAct_ChaosLingChiWin:onEventImage(idx)
if self.isAnim then
return
end
if idx then
local reward=self.config.reward_tips[idx]
tipsManager.showTips({itemid=reward})
end
end

function UISubAct_ChaosLingChiWin:onJumpAnimation(name,jump,data)
self.activityData:setJumpAnimation(jump)
end

function UISubAct_ChaosLingChiWin:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UISubAct_ChaosLingChiWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UISubAct_ChaosLingChiWin:updateCDTick()
local time=activitiesModel:getSubActEndLeftTime(self.activityId,self.subType,self.subId)
self.timeTx:setText(FMT.fmt("活动剩余时间：<color=#F7F7F7FF>{0}</color>",timeHelper.format_time_stamp3(time)))
end

function UISubAct_ChaosLingChiWin:refreshFree()
local check=self.activityData:checkFree()
self.freeOnce:setActive(check)
self.onceBtnReddot:setActive(check)
self.onceCost:setActive(not check)
if check then
self:stopFreeTick()
else
self:startFreeTick()
end
end

function UISubAct_ChaosLingChiWin:refreshNext()
local data=self.activityData.data
local lib2=self.config.lib2 or{}
local maxTimes=lib2[#lib2][2]
self.nextTx:setText(maxTimes-data.great)
end

function UISubAct_ChaosLingChiWin:refreshExplore()
local data=self.activityData.data
local moneyType=self.config.money[1]
local cur=moneyModel.getMoney(moneyType)
local value=math.min(cur,data.fullValue)/data.fullValue

if value<=self.value then
local str=cur
self.tansuoBottleTx:setText(str)
self.value=value
self.explore=cur
else
local deltaValue=(value-self.value)/50
local currValue=self.value
local deltaExplore=(cur-self.explore)/50
local currExplore=self.explore
if self.bottleTimer then
self:stopTimerByID(self.bottleTimer)
self.bottleTimer=nil
end
local count=0
self.bottleTimer=self:setTimer(0.02,50,function()
count=count+1
currValue=currValue+deltaValue
currExplore=currExplore+deltaExplore
if count>=50 then
currValue=value
currExplore=cur
end

self.value=currValue
local str=math.floor(currExplore)
self.tansuoBottleTx:setText(str)
self.explore=currExplore
end)
end
self.tansuoBtnReddot:setActive(self.activityData:exchangeReddot())
end

function UISubAct_ChaosLingChiWin:refreshButton()
local list=self.config.itemnum

self.once=list[1]
self.money=self.config.itemid
self.exchangeMoney=self.config.money[1]
self.onceBtnTx:setText("单次")
self.onceIcon:setImageIcon(iconHelper.getIconName(self.money),false)
self.onceNum:setText(self.once)

self.many=list[2]
self.manyBtnTx:setText("十连")
self.manyIcon:setImageIcon(iconHelper.getIconName(self.money),false)

self.moneyIcon:setImageIcon(iconHelper.getIconName(self.money),false)
self.suipianIcon:setImageIcon(iconHelper.getIconName(self.config.money[1]),false)
self:refreshMoney()
end

function UISubAct_ChaosLingChiWin:refreshJumpAnimation()

local toggle=self.activityData:getJumpAnimation()
self.jumpAnimation:setToggle(toggle)
end

function UISubAct_ChaosLingChiWin:refreshView(activityId,subType,subId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
self:refreshFree()
self:refreshNext()
self:refreshExplore()
self:refreshFixPanel(true)
self:initRewardPanel(true)
end
end

function UISubAct_ChaosLingChiWin:play_Animation(activityId,subType,subId,rewards)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
rewards=rewards or{}
local data=self.activityData.data
local isFix=data.fix_time>0
self.isAnim=true

self:refreshFixPanel()
if not isFix and self.activityData:getJumpAnimation()then
self.isAnim=false
self.activityData:showPrize(rewards)
return
end
local spe=false
for i,v in ipairs(rewards)do
if self.config.reset_items[v.itemid]then
spe=true
break
end
end







self.effectRoot:setActive(true)
if not isFix then
if math.random(1,2)==1 then

self:doSpeaking(eSpeakType.lottery)
end
local singleLottery=#rewards<=1

self.SkeletonGraphic:setChildSpineAnimation(eAnimationID.hdlc_xialuo,1,nil)
local qiutimes={9,13,15,19,23,24,28,29,31,34}
local shuihuatimes={6,10,12,16,20,21,25,26,28,31}
for i=1,#self.point do
self:delayDo(qiutimes[i]*0.033,function()
self.point[i]:setActive(false)
end)
self:delayDo(shuihuatimes[i]*0.033,function()
self.shuihuaPoint[i]:setChildShowEffect(10722,true)
end)
end
self:delayDo(1.4,function()
self.effect1:setChildShowEffect(singleLottery and 10723 or 10724,true)
self.SkeletonGraphic:setChildSpineAnimation(eAnimationID.stand,1,nil)
self.pointArray:setActive(false)


end)
self:delayDo(3.1,function()
self.isAnim=false
self.activityData:showPrize(rewards)
self.effectRoot:setActive(false)
self.effect1:setChildShowEffect(0,false)

self:delayDo(0.5,function()
for i=1,#self.point do
self.point[i]:setActive(true)
end
self.pointArray:setActive(true)


end)
end)
else
local animSpeed=1
if self.clickLast and(timeHelper.getServerShortTime()-self.clickLast)<=2 then
animSpeed=2
end

self:refreshFixProgress(false,animSpeed)
if#rewards==0 then
if math.random(1,2)==1 then

self:doSpeaking(eSpeakType.xiufu)
end
end

self.fixBallModel[data.fix_time]:setChildShowEffect(xiufuEffectID[data.fix_time],true)
self.fixBallModel[data.fix_time]:setActive(true)

self:delayDo(1.2,function()

if#rewards>0 then



self.effectLottery:setChildShowEffect(0,false)

self.effectLotteryTxt:setChildShowEffect(10743,true)
self:delayDo(1,function()
self.activityData:showPrize(rewards)

self.bgModel2:setChildModelAnimationState(eAnimationID.stand,1)
self.effectChou:setChildShowEffect(10711,true)
for i=1,#self.fixBallModel do
self.fixBallModel[i]:setActive(false)
end



self.fixProgressBar:setActive(false)
self.fixPanel:setActive(false)

self.fixProgressImg:setChildIconFillAmount(0)
self.fixProgressTxt:setText("0%")
self.lastRate=0
end)
self:delayDo(1.5,function()
self.isAnim=false

self:refreshFixPanel()
self.pointArray:setActive(true)
self.fixPanel:setActive(false)
end)


self:doSpeaking(eSpeakType.restore)
else
self:delayDo(0.3,function()
self.isAnim=false

self:refreshFixPanel()
end)
end
self.effectRoot:setActive(false)

self.clickLast=timeHelper.getServerShortTime()
end)
end




end
end
function UISubAct_ChaosLingChiWin:test(idx)
for i=1,#self.fixBallModel do
self:delayDo(i,function()
self.fixBallModel[i]:setChildShowEffect(xiufuEffectID[i],true)
self.fixBallModel[i]:setActive(true)
end)
end
end

function UISubAct_ChaosLingChiWin:refresh_Animation(activityId,subType,subId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
local data=self.activityData.data
if data.lib_idx>0 and data.fix_flag then
self.isAnim=true
self.isJuLing=true

self:refreshFixPanel()

self.fixProgressImg:setChildIconFillAmount(0)
self.fixProgressTxt:setText("0%")
self.lastRate=0

self.bgModel2:setChildModelAnimationState(eAnimationID.hdlc_stand1,1)
self.pointArray:setActive(false)
self.nextTx:setActive(false)
self.timeBg:setActive(false)


self.effectLottery:setChildShowEffect(10730,true)
self:delayDo(0.8,function()
self.effectLotteryTxt:setChildShowEffect(10741,true)
self.effectChou:setChildShowEffect(10742,true)
end)

self:delayDo(2.8,function()
self.isAnim=false

self:refreshFixPanel()

self.fixProgressBar:setActive(true)
self.fixPanel:setActive(true)
end)

self:doSpeaking(eSpeakType.posun)
elseif data.lib_idx==0 and data.fix_time>0 then
self.isAnim=false
self.isJuLing=false

self:refreshFixPanel()
self.nextTx:setActive(true)
self.timeBg:setActive(true)
else

self:refreshFixPanel()
end
end
end

function UISubAct_ChaosLingChiWin:refreshView_OnlyExplore(activityId,subType,subId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
self:refreshExplore()
end
end

function UISubAct_ChaosLingChiWin:refreshView_OnlyFix(activityId,subType,subId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
self:refreshFixProgress()
end
end

function UISubAct_ChaosLingChiWin:refreshView_OnlyNext(activityId,subType,subId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
self:refreshNext()
self:initRewardPanel(true)
end
end

function UISubAct_ChaosLingChiWin:startFreeTick()
if not self.freeTimer then
self.freeTimer=self:setTimer(1,0,function()

if self.activityData:checkFree()then
self.freeOnce:setActive(true)
self.onceBtnReddot:setActive(true)
self.onceCost:setActive(false)
self:stopFreeTick()
end
end)
end
end

function UISubAct_ChaosLingChiWin:stopFreeTick()
if self.freeTimer then
self:stopTimerByID(self.freeTimer)
self.freeTimer=nil
end
end

function UISubAct_ChaosLingChiWin.on_item_change(changeType,itemguid,itemid,lastcount,itemcount)
if _this.money==itemid then
_this:refreshMoney()
_this:refreshManyReddot()
end
end

function UISubAct_ChaosLingChiWin.on_money_changed(mType,oldValue,newValue)
if _this.exchangeMoney==mType then
_this:refreshExplore()
end
end

function UISubAct_ChaosLingChiWin:refreshMoney()
local num=itemsModel.getCount(self.money)
self.moneyNum:setText(num)
end

function UISubAct_ChaosLingChiWin:refreshManyReddot()
local num=itemsModel.getCount(self.money)
local manyNumStr=tostring(self.many)
if num<self.many then
manyNumStr=FMT.cfmt(FONT_COLOR.eRedColor,manyNumStr)
end
self.manyNum:setText(manyNumStr)

local onceNumStr=tostring(self.once)
if num<self.once then
onceNumStr=FMT.cfmt(FONT_COLOR.eRedColor,onceNumStr)
end
self.onceNum:setText(onceNumStr)

self.manyBtnReddot:setActive(self.activityData:lotteryEnough(self.many))
end

function UISubAct_ChaosLingChiWin:refreshFixPanel(isRefreshView)
local data=self.activityData.data
local isShowBtn=not self.isJuLing and not self.isAnim
self.onceBtn:setActive(isShowBtn)
self.manyBtn:setActive(isShowBtn)
self.jumpAnimation:setActive(isShowBtn)

if self.isJuLing or not self.isAnim then
self.rBtnPanel:setChildCanvasGroupDOFade(1,0.5,nil)
self.moneyBg:setChildCanvasGroupDOFade(1,0.5,nil)
self.suipianBg:setChildCanvasGroupDOFade(1,0.5,nil)
else
self.rBtnPanel:setChildCanvasGroupDOFade(0,0.5,nil)
self.moneyBg:setChildCanvasGroupDOFade(0,0.5,nil)
self.suipianBg:setChildCanvasGroupDOFade(0,0.5,nil)
end


local target=self.config.target_reward or{}
local max=#target
local isShow=max>0 and isShowBtn and self.isInitRewardScrollView
if isShow then
self.showReward=true
self.rewardScrollView:setChildCanvasGroupDOFade(1,0.5,nil)
else
self.showReward=false
self.rewardScrollView:setChildCanvasGroupDOFade(0,0.5,nil)
end
end

function UISubAct_ChaosLingChiWin:refreshFixProgress(isRefreshView,animSpeed)
local data=self.activityData.data
local rate=0
animSpeed=animSpeed or 1
if data.lib_idx<=0 and data.fix_time<=0 then
self.fixProgressImg:setChildIconFillAmount(0)
self.fixProgressTxt:setText("0%")
self.lastRate=0
elseif data.lib_idx<=0 and data.fix_time>0 then
if isRefreshView then
self.fixProgressImg:setChildIconFillAmount(0)
self.fixProgressTxt:setText("0%")
self.lastRate=0
else
self.fixProgressImg:setChildImageDOFillAmount(1,2/animSpeed,function()

self.lastRate=0
end)

self:startRollProgress(animSpeed,100)
end
else
local cfg=cfgHelper.get1(cfg_lotteryact7libconfig_get,data.lib_idx)
if not cfg then
loggerUtil.logErrFMT("灵气爆发聚灵进度模板未找到id：{0} 的配置",data.lib_idx)
return
end
local lib_cfg=cfg.lib_conf
local fix_time=data.fix_time or 0
local fix_rate=lib_cfg[fix_time]
for i,v in ipairs(lib_cfg)do
if i<=fix_time then
rate=rate+v
end
end
if isRefreshView then
self.fixProgressImg:setChildIconFillAmount(rate/100)
self.fixProgressTxt:setText(string.format("%d%%",rate))
self.lastRate=rate
else
self.fixProgressImg:setChildImageDOFillAmount(rate/100,2/animSpeed,function()

self.lastRate=rate
end)

if fix_rate<=0 then

end

self:startRollProgress(animSpeed,rate)
end
end
end

function UISubAct_ChaosLingChiWin:startRollProgress(animSpeed,rate)
if self.progressTimer then
self:stopTimerByID(self.progressTimer)
self.progressTimer=nil
end
local duration=2/animSpeed
local frames=10
local interval=duration/frames
self.lastRate=self.lastRate or 0
local changeRate=rate-self.lastRate
local deltaRate=changeRate/frames
local tempRate=self.lastRate
local endRate=rate
local count=0
self.progressTimer=self:setTimer(interval,frames,function()
count=count+1
tempRate=tempRate+deltaRate
if count>=frames then
tempRate=endRate
end
local formatRate=math.floor(tempRate)
self.fixProgressTxt:setText(string.format("%d%%",formatRate))

end)
end



function UISubAct_ChaosLingChiWin:doSpeaking(type)
self:clearSpeakTimer()

local speakLib=self.config[type]
local rand1=math.random(#speakLib)
local speakStr1=speakLib[rand1]
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr1,speed,nil)
self:doTalkAnim()
end


function UISubAct_ChaosLingChiWin:doTalkAnim()
if self.talkTween1~=nil then
self.talkTween1:Kill()
self.talkTween1=nil
end
self.speakObj:setScale(Vector3.zero)
self:delayDo(0.5,function()
self.speakObj:setChildCanvasGroupAlpha(1)
self.talkTween1=self.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween1=nil
_this.talkTween1=_this.speakObj:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween1=nil
return _this:talkEnd()
end)
end)
end)
end


function UISubAct_ChaosLingChiWin:talkEnd()
self:clearSpeakTimer()
local showTime=self.config.speakTime
self.speakShowTimer=self:delayDo(showTime,function()

self.speakObj:setScale(Vector3.zero)
end)
end


function UISubAct_ChaosLingChiWin:clearSpeakTimer()
if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end

function UISubAct_ChaosLingChiWin:initRewardPanel(anim,isInit)
local data=self.activityData.data
local speed=400
local stepHeight=120
local contentOffset={20,0}
self.rewardProgressBar:setChildAnchoredPosition(Vector2(0,0))
self.rewardGrid:setChildAnchoredPosition(Vector2(0,-contentOffset[1]))
self.isInitRewardScrollView=true

local target=self.config.target_reward or{}
local max=#target

if isInit then
self.showReward=false
self.rewardScrollView:setChildCanvasGroupAlpha(0)
if max>0 and not self.isJuLing then
self.showReward=true
self.rewardScrollView:setChildCanvasGroupDOFade(1,0.5,nil)

end
end
if max==0 or data.lib_idx>0 then
return
end

local total=data.total or 0
local recvIdx=data.recvIdx or 0
local curIndex=0
for i,d in ipairs(target)do
if total>=d[1]then
curIndex=i
end
end

self.rewardGrid:setChildLayoutGroupCreateItems(max)
local grids=self.rewardGrid:getChildLayoutGroupGridList()
for i=1,max do
local item=grids[i-1]
local d=target[i]
local num=d[1]
local reward=d[2][1]
local fix=total>=num
local rewardFlag=recvIdx>=i


local posY=i*stepHeight
item:SetChildAnchoredPosition(-1,Vector2(0,posY))

local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local isGray=not fix
local graynum=0
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,gray=graynum,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil or not _this.showReward then return end
_this:onClickItem(i)
end)

item:SetChildText(1,num)

item:SetChildActive(2,fix and rewardFlag)

item:SetChildActive(4,fix and not rewardFlag)

item:SetChildActive(5,fix and rewardFlag)

item:SetChildActive(6,not fix or not rewardFlag)

item:SetChildActive(7,not fix)

item:SetChildActive(8,fix and not rewardFlag)

item:SetChildImageExGray(3,isGray)
end
local content_height=max*stepHeight+contentOffset[1]+contentOffset[2]
self.rewardContent:setChildSizeDelta(100,content_height)


local max_height=max*stepHeight
self.rewardProgressBar:setChildSizeDelta(8,max_height)

local cur_height
if curIndex>=max then
cur_height=max_height
elseif curIndex<=0 then
cur_height=total/target[curIndex+1][1]*stepHeight
else
local rate=(total-target[curIndex][1])/(target[curIndex+1][1]-target[curIndex][1])
cur_height=(curIndex+rate)*stepHeight
end
if anim then
local lerp=math.abs(cur_height-6)
self.rewadProgress:setChildDOSizeDelta(Vector2(8,cur_height),lerp/speed,nil)
else
self.rewadProgress:setChildSizeDelta(8,cur_height)
end

self.rewardNumTxt:setText(FMT.fmt('次数：{0}',total))

if isInit then
local showHeight=self.rewardScrollView:getChildRectHeight()
local moveY=curIndex>1 and(curIndex-1)*stepHeight+20 or 0
local max_height_=content_height-showHeight
if moveY>max_height_ then
moveY=max_height_
end
self.rewardContent:setLocalPosY(-showHeight-moveY)
end
end

function UISubAct_ChaosLingChiWin:onClickItem(index)
if self.isAnim then
return
end
local data=self.activityData.data
local total=data.total or 0
local recvIdx=data.recvIdx or 0

local target=self.config.target_reward
local d=target[index]
local num=d[1]
local reward=d[2][1]
local fix=total>=num
local rewardFlag=recvIdx>=index

local itemid=reward[1]
if fix and not rewardFlag then
local max=index
for i=index,#target do
local num=target[i][1]
local fix=total>=num
local rewardFlag=recvIdx>=i
if fix and not rewardFlag then
max=i
else
break
end
end

call_activitiesHandle_func("activitiesHandle_chaoslingchi","reqReward",_this.activityId,_this.subId,max)
else
tipsManager.showTips({itemid=itemid,itemguid=nil,move=TIPS_MOVE_POS.eRight})
end
end




function UISubAct_ChaosLingChiWin:onFixBtn()
if self.isAnim then
return
end
self.fixBtn:setChildModelAnimationState(2307,1,nil)
local data=self.activityData.data
if data.lib_idx>0 then
call_activitiesHandle_func("activitiesHandle_chaoslingchi","reqFixChaosLingChi",_this.activityId,_this.subId)
end
end



function UISubAct_ChaosLingChiWin:onManyBtn()
if self.isAnim then
return
end
self.activityData:lottery(2)
end



function UISubAct_ChaosLingChiWin:onMoneyBg()
local itemId=self.config.itemid
gainControl:showGainWin(itemId)
end



function UISubAct_ChaosLingChiWin:onOnceBtn()
if self.isAnim then
return
end
self.activityData:lottery(1)
end



function UISubAct_ChaosLingChiWin:onRecordBtn()
local args={
activityId=self.activityId,
subType=self.subType,
subId=self.subId,
}
oneTabScreenController:openUI(SEC_FULL_TYPE.hdlcJLSecondary,args)
end



function UISubAct_ChaosLingChiWin:onRewardBtn()
if self.isAnim then
return
end
local args={
activityId=self.activityId,
subType=self.subType,
subId=self.subId,
proTitle='大奖道具预览',
normalTitle='珍稀道具预览',
}
oneTabScreenController:openUI(SEC_FULL_TYPE.lotterySecondary,args)
end



function UISubAct_ChaosLingChiWin:onSuipianBg()
local moneyType=self.config.money[1]
gainControl:showGainWin(moneyType)
end



function UISubAct_ChaosLingChiWin:onTansuoBtn()
if self.isAnim then
return
end
local args={
activityId=self.activityId,
subType=self.subType,
subId=self.subId,
activityData=self.activityData,
config=self.config,
}
UIManager:showWindow("UISubAct_ChaosLingChiExchangeWin",args)
end

function UISubAct_ChaosLingChiWin:onPoint_1()end
function UISubAct_ChaosLingChiWin:onPoint_2()end
function UISubAct_ChaosLingChiWin:onPoint_3()end
function UISubAct_ChaosLingChiWin:onPoint_4()end
function UISubAct_ChaosLingChiWin:onPoint_5()end
function UISubAct_ChaosLingChiWin:onPoint_6()end
function UISubAct_ChaosLingChiWin:onPoint_7()end
function UISubAct_ChaosLingChiWin:onPoint_8()end
function UISubAct_ChaosLingChiWin:onPoint_9()end
function UISubAct_ChaosLingChiWin:onPoint_10()end




function UISubAct_ChaosLingChiWin:refreshIsShowReddotBtn()
local actInfo=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
local isForbiddenShowReddot=actInfo:checkIsForbiddenShowReddot()
self.isShowReddotBtn:setActive(not isForbiddenShowReddot)
if isForbiddenShowReddot then
return
end

local isShowReddot=actInfo:checkIsShowReddot()
local btnWidget=self.isShowReddotBtn:getWidgetBase()
btnWidget:SetChildActive(0,not isShowReddot)
btnWidget:SetChildActive(1,isShowReddot)
end

function UISubAct_ChaosLingChiWin:onIsShowReddotBtn()
local actInfo=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
local isShowReddot=actInfo:checkIsShowReddot()
isShowReddot=not isShowReddot

actInfo:setIsShowReddot(isShowReddot)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)
self:refreshIsShowReddotBtn()
end

function UISubAct_ChaosLingChiWin.onSubActivityOverBeforeEndTime24Hour(actId,subType,subId)
if _this==nil then return end
if _this.activityId==actId and _this.subType==subType and _this.subId==subId then
_this:refreshIsShowReddotBtn()
end
end

