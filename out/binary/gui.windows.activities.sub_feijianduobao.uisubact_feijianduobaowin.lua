







def_class("UISubAct_FeiJianDuoBaoWin",UIWindowBase)









function UISubAct_FeiJianDuoBaoWin:bindComponents()

self.bagPanel=UIObject.get(self,0)
self.bgModel=UIObject.get(self,1)
self.brownBag_1=UIObject.get(self,2)
self.brownBag_2=UIObject.get(self,3)
self.brownBag_3=UIObject.get(self,4)
self.brownBag_4=UIObject.get(self,5)
self.brownBag_5=UIObject.get(self,6)
self.effectLottery=UIObject.get(self,7)
self.effectLotteryTxt=UIObject.get(self,8)
self.effectRoot=UIObject.get(self,9)
self.fixBtn=UIButton.get(self,10)
self.fixDropModel_1=UIObject.get(self,11)
self.fixDropModel_10=UIObject.get(self,12)
self.fixDropModel_2=UIObject.get(self,13)
self.fixDropModel_3=UIObject.get(self,14)
self.fixDropModel_4=UIObject.get(self,15)
self.fixDropModel_5=UIObject.get(self,16)
self.fixDropModel_6=UIObject.get(self,17)
self.fixDropModel_7=UIObject.get(self,18)
self.fixDropModel_8=UIObject.get(self,19)
self.fixDropModel_9=UIObject.get(self,20)
self.fixPanel=UIObject.get(self,21)
self.fixProgressImg=UIObject.get(self,22)
self.fixProgressTxt=UIText.get(self,23)
self.freeOnce=UIText.get(self,24)
self.frog=UIObject.get(self,25)
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
self.redBag_1=UIObject.get(self,42)
self.redBag_2=UIObject.get(self,43)
self.redBag_3=UIObject.get(self,44)
self.redBag_4=UIObject.get(self,45)
self.redBag_5=UIObject.get(self,46)
self.rewardBtn=UIButton.get(self,47)
self.rewardList=UIObject.get(self,48)
self.rewardView=UIObject.get(self,49)
self.speakObj=UIObject.get(self,50)
self.speakText=UIText.get(self,51)
self.suipianBg=UIButton.get(self,52)
self.sword_1=UIObject.get(self,53)
self.sword_10=UIObject.get(self,54)
self.sword_2=UIObject.get(self,55)
self.sword_3=UIObject.get(self,56)
self.sword_4=UIObject.get(self,57)
self.sword_5=UIObject.get(self,58)
self.sword_6=UIObject.get(self,59)
self.sword_7=UIObject.get(self,60)
self.sword_8=UIObject.get(self,61)
self.sword_9=UIObject.get(self,62)
self.swordPanel=UIObject.get(self,63)
self.tansuoBottleTx=UIText.get(self,64)
self.tansuoBtn=UIButton.get(self,65)
self.tansuoBtnReddot=UIObject.get(self,66)
self.timeTx=UIText.get(self,67)
self.yellowBag_1=UIObject.get(self,68)
self.yellowBag_2=UIObject.get(self,69)
self.yellowBag_3=UIObject.get(self,70)
self.yellowBag_4=UIObject.get(self,71)
self.yellowBag_5=UIObject.get(self,72)
self.isShowReddotBtn=UIButton.get(self,73)

self.fixBtn:setButtonClick(function()self:onFixBtn()end)

self.manyBtn:setButtonClick(function()self:onManyBtn()end)

self.moneyBg:setButtonClick(function()self:onMoneyBg()end)

self.onceBtn:setButtonClick(function()self:onOnceBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.suipianBg:setButtonClick(function()self:onSuipianBg()end)

self.tansuoBtn:setButtonClick(function()self:onTansuoBtn()end)

self.isShowReddotBtn:setButtonClick(function()self:onIsShowReddotBtn()end)
self.brownBag={
self.brownBag_1,
self.brownBag_2,
self.brownBag_3,
self.brownBag_4,
self.brownBag_5,
}
self.fixDropModel={
self.fixDropModel_1,
self.fixDropModel_2,
self.fixDropModel_3,
self.fixDropModel_4,
self.fixDropModel_5,
self.fixDropModel_6,
self.fixDropModel_7,
self.fixDropModel_8,
self.fixDropModel_9,
self.fixDropModel_10,
}
self.redBag={
self.redBag_1,
self.redBag_2,
self.redBag_3,
self.redBag_4,
self.redBag_5,
}
self.sword={
self.sword_1,
self.sword_2,
self.sword_3,
self.sword_4,
self.sword_5,
self.sword_6,
self.sword_7,
self.sword_8,
self.sword_9,
self.sword_10,
}
self.yellowBag={
self.yellowBag_1,
self.yellowBag_2,
self.yellowBag_3,
self.yellowBag_4,
self.yellowBag_5,
}



end


function UISubAct_FeiJianDuoBaoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bagPanel);self.bagPanel=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.brownBag_1);self.brownBag_1=nil;
_UIObject_release(self.brownBag_2);self.brownBag_2=nil;
_UIObject_release(self.brownBag_3);self.brownBag_3=nil;
_UIObject_release(self.brownBag_4);self.brownBag_4=nil;
_UIObject_release(self.brownBag_5);self.brownBag_5=nil;
_UIObject_release(self.effectLottery);self.effectLottery=nil;
_UIObject_release(self.effectLotteryTxt);self.effectLotteryTxt=nil;
_UIObject_release(self.effectRoot);self.effectRoot=nil;
_UIObject_release(self.fixBtn);self.fixBtn=nil;
_UIObject_release(self.fixDropModel_1);self.fixDropModel_1=nil;
_UIObject_release(self.fixDropModel_10);self.fixDropModel_10=nil;
_UIObject_release(self.fixDropModel_2);self.fixDropModel_2=nil;
_UIObject_release(self.fixDropModel_3);self.fixDropModel_3=nil;
_UIObject_release(self.fixDropModel_4);self.fixDropModel_4=nil;
_UIObject_release(self.fixDropModel_5);self.fixDropModel_5=nil;
_UIObject_release(self.fixDropModel_6);self.fixDropModel_6=nil;
_UIObject_release(self.fixDropModel_7);self.fixDropModel_7=nil;
_UIObject_release(self.fixDropModel_8);self.fixDropModel_8=nil;
_UIObject_release(self.fixDropModel_9);self.fixDropModel_9=nil;
_UIObject_release(self.fixPanel);self.fixPanel=nil;
_UIObject_release(self.fixProgressImg);self.fixProgressImg=nil;
_UIObject_release(self.fixProgressTxt);self.fixProgressTxt=nil;
_UIObject_release(self.freeOnce);self.freeOnce=nil;
_UIObject_release(self.frog);self.frog=nil;
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
_UIObject_release(self.redBag_1);self.redBag_1=nil;
_UIObject_release(self.redBag_2);self.redBag_2=nil;
_UIObject_release(self.redBag_3);self.redBag_3=nil;
_UIObject_release(self.redBag_4);self.redBag_4=nil;
_UIObject_release(self.redBag_5);self.redBag_5=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rewardView);self.rewardView=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.suipianBg);self.suipianBg=nil;
_UIObject_release(self.sword_1);self.sword_1=nil;
_UIObject_release(self.sword_10);self.sword_10=nil;
_UIObject_release(self.sword_2);self.sword_2=nil;
_UIObject_release(self.sword_3);self.sword_3=nil;
_UIObject_release(self.sword_4);self.sword_4=nil;
_UIObject_release(self.sword_5);self.sword_5=nil;
_UIObject_release(self.sword_6);self.sword_6=nil;
_UIObject_release(self.sword_7);self.sword_7=nil;
_UIObject_release(self.sword_8);self.sword_8=nil;
_UIObject_release(self.sword_9);self.sword_9=nil;
_UIObject_release(self.swordPanel);self.swordPanel=nil;
_UIObject_release(self.tansuoBottleTx);self.tansuoBottleTx=nil;
_UIObject_release(self.tansuoBtn);self.tansuoBtn=nil;
_UIObject_release(self.tansuoBtnReddot);self.tansuoBtnReddot=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
_UIObject_release(self.yellowBag_1);self.yellowBag_1=nil;
_UIObject_release(self.yellowBag_2);self.yellowBag_2=nil;
_UIObject_release(self.yellowBag_3);self.yellowBag_3=nil;
_UIObject_release(self.yellowBag_4);self.yellowBag_4=nil;
_UIObject_release(self.yellowBag_5);self.yellowBag_5=nil;
_UIObject_release(self.isShowReddotBtn);self.isShowReddotBtn=nil;
self.brownBag=nil;
self.fixDropModel=nil;
self.redBag=nil;
self.sword=nil;
self.yellowBag=nil;
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
local redBagPos={
{-107.9,234.8},{26.4,226.3},{161.9,225.9},{291,230.3},{422,245},
}
local yellowBagPos={
{-108.7,69.1},{26.3,63.9},{161.4,62.7},{291.7,69.6},{421.3,80.9},
}
local brownBagPos={
{-91.5,-98.7},{38.4,-104.3},{158.7,-106.8},{288.6,-102.3},{408.9,-92.2},
}
local yellowBagFixPos={
{-108.7,10},{26.3,10},{161.4,10},{291.7,10},{421.3,10},{-66.3,10},{64.3,10},{226.4,10},{356.5,10},{-178.5,10},
}
local shuffleArray=function(arr)
mathHelper.randomSeed()
local n=#arr
for idx=n,2,-1 do
local randomIdx=math.random(idx)
arr[idx],arr[randomIdx]=arr[randomIdx],arr[idx]
end
end
local fixAnimTime=1
local animFrames=30
local _rollSpeed=10
local _rerollInterval=10
local _RollList=simple_class(LuaRollListVertical)


function UISubAct_FeiJianDuoBaoWin:onLoaded(...)
self:bindComponents()
_this=self
self.jumpAnimation:setToggleChange(function(...)self:onJumpAnimation(...)end)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_change)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
self:addNotify(notifyConfig.onSubActivityOverBeforeEndTime24Hour,self.onSubActivityOverBeforeEndTime24Hour)
self.rollList=_RollList(self.winlua,self.rewardList)
self.value=1
self.redBagIdx={1,2,3,4,5}
self.yellowBagIdx={1,2,3,4,5}
self.brownBagIdx={1,2,3,4,5}
self.redBagDropIdx={}
self.yellowBagDropIdx={}
self.brownBagDropIdx={}
self.yellowBagFixPosIdx=table.toTable(1,#yellowBagFixPos)
shuffleArray(self.yellowBagFixPosIdx)
end


function UISubAct_FeiJianDuoBaoWin:__delete()
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




function UISubAct_FeiJianDuoBaoWin:onShow(argtable,afterOnloaded)
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
self.bgModel:setChildUIModelShowTarget(6069,1,{},data.lib_idx>0 and eAnimationID.fjdb_stand_posun or eAnimationID.fjdb_stand)
if data.lib_idx>0 then
for i=1,data.fix_time do
self.fixDropModel[i]:setChildUIModelShowTarget(6118,1,{},eAnimationID.fjdb_fix_stand_yellow)
self.fixDropModel[i]:setActive(true)
local idx=self.yellowBagFixPosIdx[i]
local pos=yellowBagFixPos[idx]
self.fixDropModel[i]:setChildAnchoredPos(pos[1],pos[2])
end
for i=data.fix_time+1,#self.fixDropModel do
self.fixDropModel[i]:setActive(false)
end
self.bagPanel:setChildCanvasGroupAlpha(0)
else
for i=1,#self.fixDropModel do
self.fixDropModel[i]:setActive(false)
end
self.bagPanel:setChildCanvasGroupAlpha(1)
end

local toggle=self.activityData:getJumpAnimation()
self.frog:setChildUIModelShowTarget(6072,1,{},data.lib_idx>0 and eAnimationID.fjdb_stand_frog_2 or(toggle and eAnimationID.fjdb_stand_frog_1 or eAnimationID.fjdb_stand_frog_2))

if not self.activityData.data then

else
self:refreshBagModel()
self:refreshFree()
self:refreshNext()
self:refreshExplore()
self:refreshManyReddot()
self:refreshFixPanel()
self:refreshFixProgress(true)
end
self:startCDTick()
self:refreshJumpAnimation()
self:refreshIsShowReddotBtn()

self:checkExchangeTips()
end

function UISubAct_FeiJianDuoBaoWin:refreshBagModel()
for i,v in ipairs(self.redBag)do
v:setChildUIModelShowTarget(6070,1,{},eAnimationID.fjdb_stand_red)
local pos=redBagPos[i]
v:setChildAnchoredPos(pos[1],pos[2])
end
for i,v in ipairs(self.yellowBag)do
v:setChildUIModelShowTarget(6070,1,{},eAnimationID.fjdb_stand_yellow)
local pos=yellowBagPos[i]
v:setChildAnchoredPos(pos[1],pos[2])
end
for i,v in ipairs(self.brownBag)do
v:setChildUIModelShowTarget(6070,1,{},eAnimationID.fjdb_stand_brown)
local pos=brownBagPos[i]
v:setChildAnchoredPos(pos[1],pos[2])
end
end


function UISubAct_FeiJianDuoBaoWin:onHide()
self.effectLottery:setChildShowEffect(0,false)
self.effectLotteryTxt:setChildShowEffect(0,false)
end

function UISubAct_FeiJianDuoBaoWin:checkExchangeTips()
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
UIManager:showWindow('UISubAct_FeiJianDuoBaoExchangeTipsWin',args)
end
end
end
end



function UISubAct_FeiJianDuoBaoWin:onRewardBtn()
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


function UISubAct_FeiJianDuoBaoWin:onOnceBtn()
if self.isAnim then
return
end
local nowTime=Time.realtimeSinceStartup
if self.lotteryTime and(nowTime-self.lotteryTime)<0.5 then
return
end
self.lotteryTime=nowTime
self.activityData:lottery(1)
end


function UISubAct_FeiJianDuoBaoWin:onManyBtn()
if self.isAnim then
return
end
local nowTime=Time.realtimeSinceStartup
if self.lotteryTime and(nowTime-self.lotteryTime)<0.5 then
return
end
self.lotteryTime=nowTime
self.activityData:lottery(2)
end

function UISubAct_FeiJianDuoBaoWin:onMoneyBg()
local itemId=self.config.itemid
gainControl:showGainWin(itemId)
end

function UISubAct_FeiJianDuoBaoWin:onSuipianBg()
local moneyType=self.config.money[1]
gainControl:showGainWin(moneyType)
end

function UISubAct_FeiJianDuoBaoWin:OnEvent(idx)







end


function UISubAct_FeiJianDuoBaoWin:onTansuoBtn()
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
UIManager:showWindow("UISubAct_FeiJianDuoBaoExchangeWin",args)
end

function UISubAct_FeiJianDuoBaoWin:onJumpAnimation(name,jump,data)
self.activityData:setJumpAnimation(jump)
self:refreshJumpAnimation()
end

function UISubAct_FeiJianDuoBaoWin:onFixBtn()
if self.isAnim then
return
end
local data=self.activityData.data
if data.lib_idx>0 then
call_activitiesHandle_func("activitiesHandle_feijianduobao","reqRepair",_this.activityId,_this.subId)
end
end

function UISubAct_FeiJianDuoBaoWin:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UISubAct_FeiJianDuoBaoWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UISubAct_FeiJianDuoBaoWin:updateCDTick()
local time=activitiesModel:getSubActEndLeftTime(self.activityId,self.subType,self.subId)
self.timeTx:setText(FMT.fmt("活动剩余时间：<color=#F7F7F7FF>{0}</color>",timeHelper.format_time_stamp3(time)))
end

function UISubAct_FeiJianDuoBaoWin:refreshFree()
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

function UISubAct_FeiJianDuoBaoWin:refreshNext()
local data=self.activityData.data
local maxTimes=self.config.round
self.nextTx:setText(maxTimes-data.great)
end

function UISubAct_FeiJianDuoBaoWin:refreshRewardList()
self:stopRerollTick()
self:stopResetRollTick()
self.rollList:stopRoll()
self.rollList:createList(#self.config.reward_list,82,8)
self.rollList:startRoll(_rollSpeed,ScrollerOrder.order)
end

function UISubAct_FeiJianDuoBaoWin:refreshExplore()
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

function UISubAct_FeiJianDuoBaoWin:refreshButton()
local list=self.config.itemnum

self.once=list[1]
self.money=self.config.itemid
self.exchangeMoney=self.config.money[1]
self.onceBtnTx:setText(FMT.fmt("飞剑{0}次",self.once))
self.onceIcon:setImageIcon(iconHelper.getIconName(self.money),false)
self.onceNum:setText(self.once)

self.many=list[2]
self.manyBtnTx:setText(FMT.fmt("飞剑{0}次",self.many))
self.manyIcon:setImageIcon(iconHelper.getIconName(self.money),false)

self.moneyIcon:setImageIcon(iconHelper.getIconName(self.money),false)
self:refreshMoney()
end

function UISubAct_FeiJianDuoBaoWin:refreshJumpAnimation()

local toggle=self.activityData:getJumpAnimation()
local data=self.activityData.data
self.jumpAnimation:setToggle(toggle)
self.frog:setChildModelAnimationState(data.lib_idx>0 and eAnimationID.fjdb_stand_frog_2 or(toggle and eAnimationID.fjdb_stand_frog_1 or eAnimationID.fjdb_croak_frog))
end

function UISubAct_FeiJianDuoBaoWin:refreshView(activityId,subType,subId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
self:refreshFree()
self:refreshNext()
self:refreshExplore()
self:refreshFixPanel(true)
end
end

function UISubAct_FeiJianDuoBaoWin:play_Animation(activityId,subType,subId,rewards)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
rewards=rewards or{}
local data=self.activityData.data
local isFix=data.fix_time>0
self.isAnim=true
if not isFix and self.activityData:getJumpAnimation()then
self.isAnim=false
self.activityData:showPrize(rewards)
return
end
local ordinary=0
local spe=0
for i,v in ipairs(rewards)do
if self.config.reset_items[v.itemid]then
spe=spe+1
else
ordinary=ordinary+1
end
end
local audioId=598
if spe>0 then
audioId=599
end
if not isFix then

self:refreshFixPanel()
local singleLottery=#rewards<=1
local showPrizeTime=singleLottery and 1 or 2.2

self:lotteryAnim(ordinary,spe)
self:delayDo(showPrizeTime,function()
self.isAnim=false
self.activityData:showPrize(rewards)
self.effectRoot:setActive(false)
end)
else
local animSpeed=1
if self.clickLast and(timeHelper.getServerShortTime()-self.clickLast)<=2 then
animSpeed=1
end

self.bgModel:setChildModelAnimationState(eAnimationID.fjdb_xiufu,animSpeed)

self.fixDropModel[data.fix_time]:setActive(true)
self.fixDropModel[data.fix_time]:setChildUIModelShowTarget(6118,1,{},eAnimationID.fjdb_fix_drop_yellow)
local idx=self.yellowBagFixPosIdx[data.fix_time]
local pos=yellowBagFixPos[idx]
self.fixDropModel[data.fix_time]:setChildAnchoredPos(pos[1],pos[2])

self:refreshFixProgress(false,animSpeed)

self:delayDo(fixAnimTime/animSpeed,function()
self.isAnim=false

self.bgModel:setChildModelAnimationState(eAnimationID.fjdb_stand_posun,animSpeed)

if#rewards>0 then
self.activityData:showPrize(rewards)
for i=1,#self.fixDropModel do
self.fixDropModel[i]:setActive(false)
end
shuffleArray(self.yellowBagFixPosIdx)
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

function UISubAct_FeiJianDuoBaoWin:selectBag(special)
local type
local idx
if special then
type=1
local selectidx=math.random(1,#self.redBagIdx)
idx=self.redBagIdx[selectidx]
table.remove(self.redBagIdx,selectidx)
else
if#self.yellowBagIdx<=0 then
type=3
elseif#self.brownBagIdx<=0 then
type=2
else
type=math.random(2,3)
end
if type==2 then
local selectidx=math.random(1,#self.yellowBagIdx)
idx=self.yellowBagIdx[selectidx]
table.remove(self.yellowBagIdx,selectidx)
else
local selectidx=math.random(1,#self.brownBagIdx)
idx=self.brownBagIdx[selectidx]
table.remove(self.brownBagIdx,selectidx)
end
end
return type,idx
end

function UISubAct_FeiJianDuoBaoWin:lotteryAnim(ordinary,spe)
self.redBagIdx={1,2,3,4,5}
self.yellowBagIdx={1,2,3,4,5}
self.brownBagIdx={1,2,3,4,5}
self.redBagDropIdx={}
self.yellowBagDropIdx={}
self.brownBagDropIdx={}

local animfunc=function(type,idx,sword_idx,delay,is_last)
local pos
local bagModel
local anim
if type==1 then
pos=redBagPos[idx]
bagModel=self.redBag[idx]
anim=eAnimationID.fjdb_drop_red
table.insert(self.redBagDropIdx,idx)
elseif type==2 then
pos=yellowBagPos[idx]
bagModel=self.yellowBag[idx]
anim=eAnimationID.fjdb_drop_yellow
table.insert(self.yellowBagDropIdx,idx)
elseif type==3 then
pos=brownBagPos[idx]
bagModel=self.brownBag[idx]
anim=eAnimationID.fjdb_drop_brown
table.insert(self.brownBagDropIdx,idx)
end
self:delayDo(delay,function()
self.sword[sword_idx]:setChildAnchoredPos(pos[1],pos[2])
self.sword[sword_idx]:setChildUIModelShowTarget(6071,1,{},eAnimationID.fjdb_fj)
bagModel:setChildModelAnimationState(anim)
if not is_last then
self.winlua:SetChildUIModelShowFadeToColor(bagModel:getID(),Color.New(1,1,1,0),0.5,0.4,nil)
end
end)
end

ordinary=math.min(ordinary,10-spe)
local temp={}

for i=1,ordinary do
local type,idx=self:selectBag(false)
table.insert(temp,{type,idx})
end

for i=1,spe do
local type,idx=self:selectBag(true)
table.insert(temp,{type,idx})
end

local max_type=3
local max_type_idx=1
local selectIdx
for i,v in ipairs(temp)do
local type=v[1]
if type<max_type then
max_type=type
max_type_idx=v[2]
selectIdx=i
end
end
if selectIdx then
table.remove(temp,selectIdx)
table.insert(temp,{max_type,max_type_idx})
end

local delay=0
local sword_idx=0
local total=ordinary+spe
for i,v in ipairs(temp)do
local type,idx=v[1],v[2]
sword_idx=sword_idx+1
animfunc(type,idx,sword_idx,delay,i==total)
delay=delay+0.15
end
end

function UISubAct_FeiJianDuoBaoWin:restoreBag()
for _,idx in ipairs(self.redBagDropIdx)do
self.redBag[idx]:setChildUIModelShowTarget(6070,1,{},eAnimationID.fjdb_stand_red)
end
for _,idx in ipairs(self.yellowBagDropIdx)do
self.yellowBag[idx]:setChildUIModelShowTarget(6070,1,{},eAnimationID.fjdb_stand_yellow)
end
for _,idx in ipairs(self.brownBagDropIdx)do
self.brownBag[idx]:setChildUIModelShowTarget(6070,1,{},eAnimationID.fjdb_stand_brown)
end
end

function UISubAct_FeiJianDuoBaoWin:refresh_Animation(activityId,subType,subId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
local data=self.activityData.data
if data.lib_idx>0 and data.fix_flag then
self.isAnim=true

self:refreshFixPanel()

self.fixProgressTxt:setText("0%")
self.fixProgressImg:setChildIconFillAmount(0)
self.lastRate=0

self.bagPanel:setChildCanvasGroupDOFade(0,1,function()

self.bgModel:setChildModelAnimationState(eAnimationID.fjdb_posun,1)

self.effectLottery:setChildShowEffect(20364,true)
self:delayDo(1,function()
self.effectLotteryTxt:setChildShowEffect(20363,true)
end)

self:delayDo(2.8,function()
self.isAnim=false

self:refreshFixPanel()
end)
end)

self.frog:setChildModelAnimationState(eAnimationID.fjdb_stand_frog_2)

self:doSpeaking(eSpeakType.posun)
elseif data.lib_idx==0 and data.fix_time>0 then
self.isAnim=true

self:refreshFixPanel()

self.bgModel:setChildModelAnimationState(eAnimationID.fjdb_xiufu_finish)

self.effectLottery:setChildShowEffect(20365,true)
self:delayDo(1,function()

self.fixProgressTxt:setText("0%")
self.fixProgressImg:setChildIconFillAmount(0)
self.lastRate=0

self.effectLotteryTxt:setChildShowEffect(20366,true)
end)
self:delayDo(2.8,function()
self.isAnim=false

self:refreshFixPanel()

self:restoreBag()

self.bagPanel:setChildCanvasGroupDOFade(1,0.5)

local toggle=self.activityData:getJumpAnimation()
self.frog:setChildModelAnimationState(toggle and eAnimationID.fjdb_stand_frog_1 or eAnimationID.fjdb_croak_frog)
end)

self:doSpeaking(eSpeakType.restore)
else

self:restoreBag()

self:refreshFixPanel()
end
end
end

function UISubAct_FeiJianDuoBaoWin:refreshView_OnlyExplore(activityId,subType,subId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
self:refreshExplore()
end
end

function UISubAct_FeiJianDuoBaoWin:refreshView_OnlyFix(activityId,subType,subId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
self:refreshFixProgress()
end
end

function UISubAct_FeiJianDuoBaoWin:refreshView_OnlyNext(activityId,subType,subId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
self:refreshNext()
end
end

function UISubAct_FeiJianDuoBaoWin:startFreeTick()
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

function UISubAct_FeiJianDuoBaoWin:stopFreeTick()
if self.freeTimer then
self:stopTimerByID(self.freeTimer)
self.freeTimer=nil
end
end

function UISubAct_FeiJianDuoBaoWin.on_item_change(changeType,itemguid,itemid,lastcount,itemcount)
if _this.money==itemid then
_this:refreshMoney()
_this:refreshManyReddot()
end
end

function UISubAct_FeiJianDuoBaoWin.on_money_changed(mType,oldValue,newValue)
if _this.exchangeMoney==mType then
_this:refreshExplore()
end
end

function UISubAct_FeiJianDuoBaoWin:refreshMoney()
local num=itemsModel.getCount(self.money)
self.moneyNum:setText(num)
end

function UISubAct_FeiJianDuoBaoWin:refreshManyReddot()
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

function UISubAct_FeiJianDuoBaoWin:refreshFixPanel(isRefreshView)
local data=self.activityData.data
self.fixPanel:setActive(data.lib_idx>0 and not self.isAnim)
self.onceBtn:setActive(data.lib_idx<=0 and not self.isAnim)
self.manyBtn:setActive(data.lib_idx<=0 and not self.isAnim)
end

function UISubAct_FeiJianDuoBaoWin:refreshFixProgress(isRefreshView,animSpeed)
local data=self.activityData.data
local rate=0
animSpeed=animSpeed or 1
if data.lib_idx<=0 and data.fix_time<=0 then
self.fixProgressTxt:setText("0%")
self.fixProgressImg:setChildIconFillAmount(0)
self.lastRate=0
elseif data.lib_idx<=0 and data.fix_time>0 then
if isRefreshView then
self.fixProgressTxt:setText("0%")
self.fixProgressImg:setChildIconFillAmount(0)
self.lastRate=0
else

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
self.fixProgressTxt:setText(string.format("%d%%",rate))
self.fixProgressImg:setChildIconFillAmount(rate/100)
self.lastRate=rate
else

if fix_rate<=0 then

end

self:startRollProgress(animSpeed,rate)
end
end
end

function UISubAct_FeiJianDuoBaoWin:startRollProgress(animSpeed,rate)
if self.progressTimer then
self:stopTimerByID(self.progressTimer)
self.progressTimer=nil
end
local duration=fixAnimTime/animSpeed
self.fixProgressImg:setChildImageDOFillAmount(rate/100,duration)
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
self.lastRate=rate==100 and 0 or rate
end
local formatRate=math.floor(tempRate)
self.fixProgressTxt:setText(string.format("%d%%",formatRate))

end)
end



function UISubAct_FeiJianDuoBaoWin:doSpeaking(type)









end


function UISubAct_FeiJianDuoBaoWin:doTalkAnim()
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


function UISubAct_FeiJianDuoBaoWin:talkEnd()
self:clearSpeakTimer()
local showTime=self.config.speakTime
self.speakShowTimer=self:delayDo(showTime,function()

self.speakObj:setScale(Vector3.zero)
end)
end


function UISubAct_FeiJianDuoBaoWin:clearSpeakTimer()
if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end

function UISubAct_FeiJianDuoBaoWin:startRerollTick()
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

function UISubAct_FeiJianDuoBaoWin:stopRerollTick()
if self.rerollTick then
self:stopTimerByID(self.rerollTick)
self.rerollTick=nil
end
end

function UISubAct_FeiJianDuoBaoWin:startResetRollTick()
if not self.resetRollTick then
self.resetRollTick=self:setTimer(_rerollInterval,1,function()
self.rollList:resumeRoll()
self:stopResetRollTick()
end)
end
end

function UISubAct_FeiJianDuoBaoWin:stopResetRollTick()
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



function UISubAct_FeiJianDuoBaoWin:refreshIsShowReddotBtn()
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

function UISubAct_FeiJianDuoBaoWin:onIsShowReddotBtn()
local actInfo=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
local isShowReddot=actInfo:checkIsShowReddot()
isShowReddot=not isShowReddot

actInfo:setIsShowReddot(isShowReddot)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)
self:refreshIsShowReddotBtn()
end

function UISubAct_FeiJianDuoBaoWin.onSubActivityOverBeforeEndTime24Hour(actId,subType,subId)
if _this==nil then return end
if _this.activityId==actId and _this.subType==subType and _this.subId==subId then
_this:refreshIsShowReddotBtn()
end
end

