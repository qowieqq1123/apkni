







def_class("UISubAct_NiuDanJiWin",UIWindowBase)









function UISubAct_NiuDanJiWin:bindComponents()

self.onceNum=UIText.get(self,0)
self.onceIcon=UIImage.get(self,1)
self.fixBtn=UIButton.get(self,2)
self.fixBg=UIObject.get(self,3)
self.fixProgressTxt=UIText.get(self,4)
self.effectFixFail=UIObject.get(self,5)
self.fixProgressImg=UIObject.get(self,6)
self.timeTx=UIText.get(self,7)
self.tansuoBottleTx=UIText.get(self,8)
self.moneyIcon=UIImage.get(self,9)
self.moneyNum=UIText.get(self,10)
self.manyBtnTx=UIText.get(self,11)
self.manyBtnReddot=UIObject.get(self,12)
self.onceBtnTx=UIText.get(self,13)
self.freeOnce=UIText.get(self,14)
self.onceCost=UIObject.get(self,15)
self.onceBtnReddot=UIObject.get(self,16)
self.tansuoBtnReddot=UIObject.get(self,17)
self.rewardList=UIObject.get(self,18)
self.manyIcon=UIImage.get(self,19)
self.manyNum=UIText.get(self,20)
self.timeBg=UIObject.get(self,21)
self.effectLottery=UIObject.get(self,22)
self.fixPanel=UIObject.get(self,23)
self.effectLotteryTxt=UIObject.get(self,24)
self.fixCompleteTips=UIObject.get(self,25)
self.effectRoot=UIObject.get(self,26)
self.bgModel=UIObject.get(self,27)
self.polygonArea=UIObject.get(self,28)
self.speakObj=UIObject.get(self,29)
self.rewardView=UIObject.get(self,30)
self.suipianBg=UIButton.get(self,31)
self.moneyBg=UIButton.get(self,32)
self.nextTx=UIText.get(self,33)
self.jumpAnimation=UIToggleButton.get(self,34)
self.manyBtn=UIButton.get(self,35)
self.onceBtn=UIButton.get(self,36)
self.tansuoBtn=UIButton.get(self,37)
self.rewardBtn=UIButton.get(self,38)
self.fixProgressBar=UIObject.get(self,39)
self.fixBallModel_10=UIObject.get(self,40)
self.fixBallModel_9=UIObject.get(self,41)
self.fixBallModel_8=UIObject.get(self,42)
self.fixBallModel_7=UIObject.get(self,43)
self.fixBallModel_1=UIObject.get(self,44)
self.fixBallModel_5=UIObject.get(self,45)
self.fixBallModel_4=UIObject.get(self,46)
self.fixBallModel_3=UIObject.get(self,47)
self.fixBallModel_2=UIObject.get(self,48)
self.fixBallModel_6=UIObject.get(self,49)
self.speakText=UIText.get(self,50)
self.isShowReddotBtn=UIButton.get(self,51)

self.fixBtn:setButtonClick(function()self:onFixBtn()end)

self.suipianBg:setButtonClick(function()self:onSuipianBg()end)

self.moneyBg:setButtonClick(function()self:onMoneyBg()end)

self.manyBtn:setButtonClick(function()self:onManyBtn()end)

self.onceBtn:setButtonClick(function()self:onOnceBtn()end)

self.tansuoBtn:setButtonClick(function()self:onTansuoBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

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



end


function UISubAct_NiuDanJiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.onceNum);self.onceNum=nil;
_UIObject_release(self.onceIcon);self.onceIcon=nil;
_UIObject_release(self.fixBtn);self.fixBtn=nil;
_UIObject_release(self.fixBg);self.fixBg=nil;
_UIObject_release(self.fixProgressTxt);self.fixProgressTxt=nil;
_UIObject_release(self.effectFixFail);self.effectFixFail=nil;
_UIObject_release(self.fixProgressImg);self.fixProgressImg=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
_UIObject_release(self.tansuoBottleTx);self.tansuoBottleTx=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyNum);self.moneyNum=nil;
_UIObject_release(self.manyBtnTx);self.manyBtnTx=nil;
_UIObject_release(self.manyBtnReddot);self.manyBtnReddot=nil;
_UIObject_release(self.onceBtnTx);self.onceBtnTx=nil;
_UIObject_release(self.freeOnce);self.freeOnce=nil;
_UIObject_release(self.onceCost);self.onceCost=nil;
_UIObject_release(self.onceBtnReddot);self.onceBtnReddot=nil;
_UIObject_release(self.tansuoBtnReddot);self.tansuoBtnReddot=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.manyIcon);self.manyIcon=nil;
_UIObject_release(self.manyNum);self.manyNum=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.effectLottery);self.effectLottery=nil;
_UIObject_release(self.fixPanel);self.fixPanel=nil;
_UIObject_release(self.effectLotteryTxt);self.effectLotteryTxt=nil;
_UIObject_release(self.fixCompleteTips);self.fixCompleteTips=nil;
_UIObject_release(self.effectRoot);self.effectRoot=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.polygonArea);self.polygonArea=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.rewardView);self.rewardView=nil;
_UIObject_release(self.suipianBg);self.suipianBg=nil;
_UIObject_release(self.moneyBg);self.moneyBg=nil;
_UIObject_release(self.nextTx);self.nextTx=nil;
_UIObject_release(self.jumpAnimation);self.jumpAnimation=nil;
_UIObject_release(self.manyBtn);self.manyBtn=nil;
_UIObject_release(self.onceBtn);self.onceBtn=nil;
_UIObject_release(self.tansuoBtn);self.tansuoBtn=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.fixProgressBar);self.fixProgressBar=nil;
_UIObject_release(self.fixBallModel_10);self.fixBallModel_10=nil;
_UIObject_release(self.fixBallModel_9);self.fixBallModel_9=nil;
_UIObject_release(self.fixBallModel_8);self.fixBallModel_8=nil;
_UIObject_release(self.fixBallModel_7);self.fixBallModel_7=nil;
_UIObject_release(self.fixBallModel_1);self.fixBallModel_1=nil;
_UIObject_release(self.fixBallModel_5);self.fixBallModel_5=nil;
_UIObject_release(self.fixBallModel_4);self.fixBallModel_4=nil;
_UIObject_release(self.fixBallModel_3);self.fixBallModel_3=nil;
_UIObject_release(self.fixBallModel_2);self.fixBallModel_2=nil;
_UIObject_release(self.fixBallModel_6);self.fixBallModel_6=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.isShowReddotBtn);self.isShowReddotBtn=nil;
self.fixBallModel=nil;
end


















local _this=nil
local startFrames={
0,
90,
180,
270,
360,
450,
}
local xiufuAnimationID={
eAnimationID.ndj_xiufu_qiu1,
eAnimationID.ndj_xiufu_qiu2,
eAnimationID.ndj_xiufu_qiu3,
eAnimationID.ndj_xiufu_qiu4,
eAnimationID.ndj_xiufu_qiu5,
eAnimationID.ndj_xiufu_qiu6,
eAnimationID.ndj_xiufu_qiu7,
eAnimationID.ndj_xiufu_qiu8,
eAnimationID.ndj_xiufu_qiu9,
eAnimationID.ndj_xiufu_qiu10,
}
local eSpeakType={
posun='posunSpeakLib',
xiufu='xiufuSpeakLib',
restore='restoreSpeakLib',
lottery='lotterySpeakLib',
}
local animFrames=30
local _rollSpeed=10
local _rerollInterval=10
local _RollList=simple_class(LuaRollListVertical)


function UISubAct_NiuDanJiWin:onLoaded(...)
self:bindComponents()
_this=self
self.jumpAnimation:setToggleChange(function(...)self:onJumpAnimation(...)end)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_change)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
self:addNotify(notifyConfig.onSubActivityOverBeforeEndTime24Hour,self.onSubActivityOverBeforeEndTime24Hour)
self.rollList=_RollList(self.winlua,self.rewardList)
self.value=1
end


function UISubAct_NiuDanJiWin:__delete()
self:unbindComponents()
_this=nil
self:stopCDTick()
self:stopFreeTick()
self:stopRerollTick()
self:stopResetRollTick()
self.rollList:deleteSelf()
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_change)
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
end




function UISubAct_NiuDanJiWin:onShow(argtable,afterOnloaded)
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
self:refreshRewardList()
self:refreshButton()
end


self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end

local data=self.activityData.data
if afterOnloaded and deviceHelper.getAPILevel()>=18 then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.bgModel:getID(),false,true,false)
end
self.bgModel:setChildUIModelShowTarget(5424,1,{},data.lib_idx>0 and eAnimationID.ndj_stand_posun or eAnimationID.ndj_stand)
self.fixProgressBar:setActive(data.lib_idx>0)
if data.lib_idx>0 then
for i=1,data.fix_time do
self.fixBallModel[i]:setChildUIModelShowTarget(5425,1,{},xiufuAnimationID[i])
self.fixBallModel[i]:setActive(true)
self.winlua:SetChildModelAnimationStop(self.fixBallModel[i]:getID(),xiufuAnimationID[i],1)
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
end


function UISubAct_NiuDanJiWin:onHide()
self.effectLottery:setChildShowEffect(0,false)
self.effectLotteryTxt:setChildShowEffect(0,false)
end

function UISubAct_NiuDanJiWin:checkExchangeTips()
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
UIManager:showWindow('UISubAct_NiuDanJiExchangeTipsWin',args)
end
end
end
end



function UISubAct_NiuDanJiWin:onRewardBtn()
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


function UISubAct_NiuDanJiWin:onOnceBtn()
if self.isAnim then
return
end
self.activityData:lottery(1)
end


function UISubAct_NiuDanJiWin:onManyBtn()
if self.isAnim then
return
end
self.activityData:lottery(2)
end

function UISubAct_NiuDanJiWin:onMoneyBg()
local itemId=self.config.itemid
gainControl:showGainWin(itemId)
end

function UISubAct_NiuDanJiWin:onSuipianBg()
local moneyType=self.config.money[1]
gainControl:showGainWin(moneyType)
end

function UISubAct_NiuDanJiWin:OnEvent(idx)







end


function UISubAct_NiuDanJiWin:onTansuoBtn()
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
UIManager:showWindow("UISubAct_NiuDanJiExchangeWin",args)
end

function UISubAct_NiuDanJiWin:onJumpAnimation(name,jump,data)
self.activityData:setJumpAnimation(jump)
end

function UISubAct_NiuDanJiWin:onFixBtn()
if self.isAnim then
return
end
local data=self.activityData.data
if data.lib_idx>0 then
call_activitiesHandle_func("activitiesHandle_niudanji","reqFixNiuDanJi",_this.activityId,_this.subId)
end
end

function UISubAct_NiuDanJiWin:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UISubAct_NiuDanJiWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UISubAct_NiuDanJiWin:updateCDTick()
local time=activitiesModel:getSubActEndLeftTime(self.activityId,self.subType,self.subId)
self.timeTx:setText(FMT.fmt("剩余时间：<color=#F7F7F7FF>{0}</color>",timeHelper.format_time_stamp3(time)))
end

function UISubAct_NiuDanJiWin:refreshFree()
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

function UISubAct_NiuDanJiWin:refreshNext()
local data=self.activityData.data
local maxTimes=self.config.round
self.nextTx:setText(maxTimes-data.great)
end

function UISubAct_NiuDanJiWin:refreshRewardList()
self:stopRerollTick()
self:stopResetRollTick()
self.rollList:stopRoll()
self.rollList:createList(#self.config.reward_list,82,8)
self.rollList:startRoll(_rollSpeed,ScrollerOrder.order)
end

function UISubAct_NiuDanJiWin:refreshExplore()
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

function UISubAct_NiuDanJiWin:refreshButton()
local list=self.config.itemnum

self.once=list[1]
self.money=self.config.itemid
self.exchangeMoney=self.config.money[1]
self.onceBtnTx:setText(FMT.fmt("扭{0}次",self.once))
self.onceIcon:setImageIcon(iconHelper.getIconName(self.money),false)
self.onceNum:setText(self.once)

self.many=list[2]
self.manyBtnTx:setText(FMT.fmt("扭{0}次",self.many))
self.manyIcon:setImageIcon(iconHelper.getIconName(self.money),false)

self.moneyIcon:setImageIcon(iconHelper.getIconName(self.money),false)
self:refreshMoney()
end

function UISubAct_NiuDanJiWin:refreshJumpAnimation()

local toggle=self.activityData:getJumpAnimation()
self.jumpAnimation:setToggle(toggle)
end

function UISubAct_NiuDanJiWin:refreshView(activityId,subType,subId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
self:refreshFree()
self:refreshNext()
self:refreshExplore()
self:refreshFixPanel(true)
end
end

function UISubAct_NiuDanJiWin:play_Animation(activityId,subType,subId,rewards)
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
local audioId=598
if spe then
audioId=599
end
if not isFix then
if math.random(1,2)==1 then

self:doSpeaking(eSpeakType.lottery)
end
local singleLottery=#rewards<=1

self.bgModel:setChildModelAnimationState(singleLottery and eAnimationID.ndj_1chou or eAnimationID.ndj_10chou,1,function()
self.isAnim=false
self.activityData:showPrize(rewards)
self.effectRoot:setActive(false)
end)
else
local animSpeed=1
if self.clickLast and(timeHelper.getServerShortTime()-self.clickLast)<=2 then
animSpeed=2
end

if deviceHelper.getAPILevel()>=40 then
local startFrame=startFrames[math.random(#startFrames)]
local sec=tonumber(string.format("%.1f",startFrame/animFrames))
self.winlua:SetChildModelAnimationStateWithProgress(self.bgModel:getID(),eAnimationID.ndj_stand_xiufu,sec/20,animSpeed)
else
self.bgModel:setChildModelAnimationState(eAnimationID.ndj_stand_xiufu,animSpeed)
end

self:refreshFixProgress(false,animSpeed)
if math.random(1,2)==1 then

self:doSpeaking(eSpeakType.xiufu)
end

self:delayDo(1/animSpeed,function()
self.fixBallModel[data.fix_time]:setChildUIModelShowTarget(5425,1,{},xiufuAnimationID[data.fix_time])
self.fixBallModel[data.fix_time]:setActive(true)
self.fixBallModel[data.fix_time]:setChildModelAnimationState(xiufuAnimationID[data.fix_time],animSpeed)
end)

self:delayDo(2/animSpeed,function()
self.isAnim=false

self.bgModel:setChildModelAnimationState(eAnimationID.ndj_stand_posun)

if#rewards>0 then
self.activityData:showPrize(rewards)
for i=1,#self.fixBallModel do
self.fixBallModel[i]:setActive(false)
end
else

self:refreshFixPanel()
end
self.effectRoot:setActive(false)

self.clickLast=timeHelper.getServerShortTime()
end)
end

self.effectRoot:setActive(true)

AudioManager.playAudio(audioId)
end
end
function UISubAct_NiuDanJiWin:test(idx)





for i=1,#self.fixBallModel do
self:delayDo(i,function()
self.fixBallModel[i]:setChildUIModelShowTarget(5425,1,{},xiufuAnimationID[i])
self.fixBallModel[i]:setActive(true)
self.fixBallModel[i]:setChildModelAnimationState(xiufuAnimationID[i],1)
end)
end
end

function UISubAct_NiuDanJiWin:refresh_Animation(activityId,subType,subId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
local data=self.activityData.data
if data.lib_idx>0 and data.fix_flag then
self.isAnim=true

self:refreshFixPanel()

self.fixProgressImg:setChildIconFillAmount(0)
self.fixProgressTxt:setText("0%")
self.lastRate=0

self.bgModel:setChildModelAnimationState(eAnimationID.ndj_posun,1)

self.effectLottery:setChildShowEffect(20364,true)
self:delayDo(1,function()
self.effectLotteryTxt:setChildShowEffect(20363,true)
end)

self:delayDo(2.8,function()
self.isAnim=false

self:refreshFixPanel()

self.fixProgressBar:setActive(true)
end)

self:doSpeaking(eSpeakType.posun)
elseif data.lib_idx==0 and data.fix_time>0 then
self.isAnim=true

self:refreshFixPanel()

self.bgModel:setChildModelAnimationState(eAnimationID.ndj_xiufu)
self.fixCompleteTips:setActive(true)

self.effectLottery:setChildShowEffect(20365,true)
self:delayDo(1,function()

self.fixCompleteTips:setActive(false)

self.fixProgressBar:setActive(false)

self.fixProgressImg:setChildIconFillAmount(0)
self.fixProgressTxt:setText("0%")
self.lastRate=0

self.effectLotteryTxt:setChildShowEffect(20366,true)
end)
self:delayDo(2.8,function()
self.isAnim=false

self:refreshFixPanel()
end)

self:doSpeaking(eSpeakType.restore)
else

self:refreshFixPanel()
end
end
end

function UISubAct_NiuDanJiWin:refreshView_OnlyExplore(activityId,subType,subId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
self:refreshExplore()
end
end

function UISubAct_NiuDanJiWin:refreshView_OnlyFix(activityId,subType,subId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
self:refreshFixProgress()
end
end

function UISubAct_NiuDanJiWin:refreshView_OnlyNext(activityId,subType,subId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
self:refreshNext()
end
end

function UISubAct_NiuDanJiWin:startFreeTick()
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

function UISubAct_NiuDanJiWin:stopFreeTick()
if self.freeTimer then
self:stopTimerByID(self.freeTimer)
self.freeTimer=nil
end
end

function UISubAct_NiuDanJiWin.on_item_change(changeType,itemguid,itemid,lastcount,itemcount)
if _this.money==itemid then
_this:refreshMoney()
_this:refreshManyReddot()
end
end

function UISubAct_NiuDanJiWin.on_money_changed(mType,oldValue,newValue)
if _this.exchangeMoney==mType then
_this:refreshExplore()
end
end

function UISubAct_NiuDanJiWin:refreshMoney()
local num=itemsModel.getCount(self.money)
self.moneyNum:setText(num)
end

function UISubAct_NiuDanJiWin:refreshManyReddot()
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

function UISubAct_NiuDanJiWin:refreshFixPanel(isRefreshView)
local data=self.activityData.data
self.fixPanel:setActive(data.lib_idx>0 and not self.isAnim)
self.onceBtn:setActive(data.lib_idx<=0 and not self.isAnim)
self.manyBtn:setActive(data.lib_idx<=0 and not self.isAnim)
end

function UISubAct_NiuDanJiWin:refreshFixProgress(isRefreshView,animSpeed)
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
local cfg=cfgHelper.get1(cfg_lotteryact6libconfig_get,data.lib_idx)
if not cfg then
loggerUtil.logErrFMT("扭蛋机抽奖修复进度模板未找到id：{0} 的配置",data.lib_idx)
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
self.effectFixFail:setChildShowEffect(20368,true)
end

self:startRollProgress(animSpeed,rate)
end
end
end

function UISubAct_NiuDanJiWin:startRollProgress(animSpeed,rate)
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



function UISubAct_NiuDanJiWin:doSpeaking(type)
self:clearSpeakTimer()

local speakLib=self.config[type]
local rand1=math.random(#speakLib)
local speakStr1=speakLib[rand1]
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr1,speed,nil)
self:doTalkAnim()
end


function UISubAct_NiuDanJiWin:doTalkAnim()
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


function UISubAct_NiuDanJiWin:talkEnd()
self:clearSpeakTimer()
local showTime=self.config.speakTime
self.speakShowTimer=self:delayDo(showTime,function()

self.speakObj:setScale(Vector3.zero)
end)
end


function UISubAct_NiuDanJiWin:clearSpeakTimer()
if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end

function UISubAct_NiuDanJiWin:startRerollTick()
if not self.rerollTick and self.delayReroll>0 then
self.rerollTick=self:setTimer(1,0,function()
self.delayReroll=self.delayReroll-1

if self.delayReroll<=0 then
self.rollList:startRoll(_rollSpeed,ScrollerOrder.order)
self:stopRerollTick()
end
end)
end
end

function UISubAct_NiuDanJiWin:stopRerollTick()
if self.rerollTick then
self:stopTimerByID(self.rerollTick)
self.rerollTick=nil
end
end

function UISubAct_NiuDanJiWin:startResetRollTick()
if not self.resetRollTick then
self.resetRollTick=self:setTimer(_rerollInterval,1,function()
self.rollList:resumeRoll()
self:stopResetRollTick()
end)
end
end

function UISubAct_NiuDanJiWin:stopResetRollTick()
if self.resetRollTick then
self:stopTimerByID(self.resetRollTick)
self.resetRollTick=nil
end
end

function _RollList:onRefershItem(item,dataIndex)

local data=_this.config.reward_list[dataIndex]
local rewardId=data[1]
local rewardNum=data[2]
local rewardFlag=data[3]==1
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1
local conf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,colorEffect=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(0,function(...)self:onClickItem(...)end)
item:SetChildPropData(0,prop)
item:SetChildActive(2,rewardFlag)
end

function _RollList:onClickItem(itemid,index,itemguid,attach)
if itemid==nil or itemid==-1 then return end
local callback=function()
_this:startResetRollTick()
end
tipsManager.showTips({itemid=itemid,itemguid=itemguid,attach=attach,closeCallback=callback})
self:pauseRoll()
end

function _RollList:beginDrag(pos)
LuaRollListVertical.beginDrag(self,pos)
_this.delayReroll=_rerollInterval
end

function _RollList:endDrag(pos)
LuaRollListVertical.endDrag(self,pos)
_this:startRerollTick()
end



function UISubAct_NiuDanJiWin:refreshIsShowReddotBtn()
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

function UISubAct_NiuDanJiWin:onIsShowReddotBtn()
local actInfo=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
local isShowReddot=actInfo:checkIsShowReddot()
isShowReddot=not isShowReddot

actInfo:setIsShowReddot(isShowReddot)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)
self:refreshIsShowReddotBtn()
end

function UISubAct_NiuDanJiWin.onSubActivityOverBeforeEndTime24Hour(actId,subType,subId)
if _this==nil then return end
if _this.activityId==actId and _this.subType==subType and _this.subId==subId then
_this:refreshIsShowReddotBtn()
end
end

