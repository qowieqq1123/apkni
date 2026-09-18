







def_class("UISubAct_YunHaiDiaoBaoWin",UIWindowBase)









function UISubAct_YunHaiDiaoBaoWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.btnCanvasGroup=UIObject.get(self,1)
self.effectLottery_1=UIObject.get(self,2)
self.effectLottery_2=UIObject.get(self,3)
self.effectLottery_3=UIObject.get(self,4)
self.effectLottery_4=UIObject.get(self,5)
self.effectLottery_5=UIObject.get(self,6)
self.effectRoot=UIObject.get(self,7)
self.fisherman=UIObject.get(self,8)
self.freeOnce=UIText.get(self,9)
self.jumpAnimation=UIToggleButton.get(self,10)
self.manyBtn=UIButton.get(self,11)
self.manyBtnReddot=UIObject.get(self,12)
self.manyBtnTx=UIText.get(self,13)
self.manyIcon=UIImage.get(self,14)
self.manyNum=UIText.get(self,15)
self.moneyBg=UIButton.get(self,16)
self.moneyIcon=UIImage.get(self,17)
self.moneyNum=UIText.get(self,18)
self.nextTx=UIText.get(self,19)
self.onceBtn=UIButton.get(self,20)
self.onceBtnReddot=UIObject.get(self,21)
self.onceBtnTx=UIText.get(self,22)
self.onceCost=UIObject.get(self,23)
self.onceIcon=UIImage.get(self,24)
self.onceNum=UIText.get(self,25)
self.rewardBtn=UIButton.get(self,26)
self.rewardList=UIObject.get(self,27)
self.rewardView=UIObject.get(self,28)
self.speakObj=UIObject.get(self,29)
self.speakText=UIText.get(self,30)
self.suipianBg=UIButton.get(self,31)
self.suipianIcon=UIObject.get(self,32)
self.tansuoBottleTx=UIText.get(self,33)
self.tansuoBtn=UIButton.get(self,34)
self.tansuoBtnReddot=UIObject.get(self,35)
self.timeTx=UIText.get(self,36)
self.isShowReddotBtn=UIButton.get(self,37)

self.manyBtn:setButtonClick(function()self:onManyBtn()end)

self.moneyBg:setButtonClick(function()self:onMoneyBg()end)

self.onceBtn:setButtonClick(function()self:onOnceBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.suipianBg:setButtonClick(function()self:onSuipianBg()end)

self.tansuoBtn:setButtonClick(function()self:onTansuoBtn()end)

self.isShowReddotBtn:setButtonClick(function()self:onIsShowReddotBtn()end)
self.effectLottery={
self.effectLottery_1,
self.effectLottery_2,
self.effectLottery_3,
self.effectLottery_4,
self.effectLottery_5,
}



end


function UISubAct_YunHaiDiaoBaoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.btnCanvasGroup);self.btnCanvasGroup=nil;
_UIObject_release(self.effectLottery_1);self.effectLottery_1=nil;
_UIObject_release(self.effectLottery_2);self.effectLottery_2=nil;
_UIObject_release(self.effectLottery_3);self.effectLottery_3=nil;
_UIObject_release(self.effectLottery_4);self.effectLottery_4=nil;
_UIObject_release(self.effectLottery_5);self.effectLottery_5=nil;
_UIObject_release(self.effectRoot);self.effectRoot=nil;
_UIObject_release(self.fisherman);self.fisherman=nil;
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
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rewardView);self.rewardView=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.suipianBg);self.suipianBg=nil;
_UIObject_release(self.suipianIcon);self.suipianIcon=nil;
_UIObject_release(self.tansuoBottleTx);self.tansuoBottleTx=nil;
_UIObject_release(self.tansuoBtn);self.tansuoBtn=nil;
_UIObject_release(self.tansuoBtnReddot);self.tansuoBtnReddot=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
_UIObject_release(self.isShowReddotBtn);self.isShowReddotBtn=nil;
self.effectLottery=nil;
end


















local _this=nil
local colorEffectList={
[eQualityColor.eRed]=18037,
[eQualityColor.eOrange]=18038,
[eQualityColor.ePurple]=18039,
[eQualityColor.eBlue]=18040,
}
local delayEffectTime={
0.5,
0.4,
0.3,
0.25,
0.25,
}
local min_X,max_X,min_Y,max_Y=-300,350,-220,-100
local _rollSpeed=10
local _rerollInterval=10
local _RollList=simple_class(LuaRollListVertical)


function UISubAct_YunHaiDiaoBaoWin:onLoaded(...)
self:bindComponents()
_this=self
self.jumpAnimation:setToggleChange(function(...)self:onJumpAnimation(...)end)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_change)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
self:addNotify(notifyConfig.onSubActivityOverBeforeEndTime24Hour,self.onSubActivityOverBeforeEndTime24Hour)
self.rollList=_RollList(self.winlua,self.rewardList)
self.value=1
end


function UISubAct_YunHaiDiaoBaoWin:__delete()
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




function UISubAct_YunHaiDiaoBaoWin:onShow(argtable,afterOnloaded)
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
self.btnCanvasGroup:setChildCanvasGroupAlpha(1)

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

self.bgModel:setChildUIModelShowTarget(6033,1,{},eAnimationID.stand)
self.fisherman:setChildUIModelShowTarget(6032,1,{},eAnimationID.stand)

if not self.activityData.data then

else
self:refreshFree()
self:refreshNext()
self:refreshExplore()
self:refreshManyReddot()
end
self:startCDTick()
self:refreshJumpAnimation()
self:refreshIsShowReddotBtn()
end


function UISubAct_YunHaiDiaoBaoWin:onHide()
self:stopAllTimer()
for i,v in ipairs(self.effectLottery)do
v:setChildShowEffect(0,false)
end
end




function UISubAct_YunHaiDiaoBaoWin:onRewardBtn()
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


function UISubAct_YunHaiDiaoBaoWin:onOnceBtn()
if self.isAnim then
return
end
self.activityData:lottery(1)
end


function UISubAct_YunHaiDiaoBaoWin:onManyBtn()
if self.isAnim then
return
end
self.activityData:lottery(2)
end

function UISubAct_YunHaiDiaoBaoWin:onMoneyBg()
local itemId=self.config.itemid
gainControl:showGainWin(itemId)
end

function UISubAct_YunHaiDiaoBaoWin:onSuipianBg()
local moneyType=self.config.money[1]
gainControl:showGainWin(moneyType)
end


function UISubAct_YunHaiDiaoBaoWin:onTansuoBtn()
if self.isAnim then
return
end

AudioManager.playBtnClick()
local jumpParam=self.config.jumpParam
jumpManager:jump(jumpParam)
end

function UISubAct_YunHaiDiaoBaoWin:onJumpAnimation(name,jump,data)
self.activityData:setJumpAnimation(jump)
end

function UISubAct_YunHaiDiaoBaoWin:startCDTick()
self:updateCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end

function UISubAct_YunHaiDiaoBaoWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UISubAct_YunHaiDiaoBaoWin:updateCDTick()
local time=activitiesModel:getSubActEndLeftTime(self.activityId,self.subType,self.subId)
self.timeTx:setText(FMT.fmt("剩余时间：{0}",timeHelper.format_time_stamp3(time)))
end

function UISubAct_YunHaiDiaoBaoWin:refreshFree()
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

function UISubAct_YunHaiDiaoBaoWin:refreshNext()
local data=self.activityData.data
local maxTimes=self.config.round
self.nextTx:setText(maxTimes-data.great)
end

function UISubAct_YunHaiDiaoBaoWin:refreshRewardList()
self:stopRerollTick()
self:stopResetRollTick()
self.rollList:stopRoll()
self.rollList:createList(#self.config.reward_list,82,8)
self.rollList:startRoll(_rollSpeed,ScrollerOrder.order)
end

function UISubAct_YunHaiDiaoBaoWin:refreshExplore()
local data=self.activityData.data
local moneyType=self.config.money[1]
local cur=moneyModel.getMoney(moneyType)































self.tansuoBottleTx:setText(cur)

end

function UISubAct_YunHaiDiaoBaoWin:refreshButton()
local list=self.config.itemnum

self.once=list[1]
self.money=self.config.itemid
self.exchangeMoney=self.config.money[1]
self.onceBtnTx:setText(FMT.fmt("钓{0}次",self.once))
self.onceIcon:setImageIcon(iconHelper.getIconName(self.money),false)
self.onceNum:setText(self.once)

self.many=list[2]
self.manyBtnTx:setText(FMT.fmt("钓{0}次",self.many))
self.manyIcon:setImageIcon(iconHelper.getIconName(self.money),false)

self.moneyIcon:setImageIcon(iconHelper.getIconName(self.money),false)
self.suipianIcon:setIcon(iconHelper.getIconName(self.exchangeMoney),false)
self:refreshMoney()
end

function UISubAct_YunHaiDiaoBaoWin:refreshJumpAnimation()

local toggle=self.activityData:getJumpAnimation()
self.jumpAnimation:setToggle(toggle)
end

function UISubAct_YunHaiDiaoBaoWin:refreshView(activityId,subType,subId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
self:refreshFree()
self:refreshNext()
self:refreshExplore()
end
end
function UISubAct_YunHaiDiaoBaoWin:randomEffectPos(radius)
radius=radius or 0
math.randomseed(os.time())
local x,y=math.random(min_X,max_X),math.random(min_Y,max_Y)
if self.lastPos and radius>0 then
local lastX,lastY=unpack(self.lastPos)
local distance=mathHelper.distance(x,y,lastX,lastY)
local count=0
while distance<radius and count<999 do
count=count+1
x,y=math.random(min_X,max_X),math.random(min_Y,max_Y)
distance=mathHelper.distance(x,y,lastX,lastY)

end
end
self.lastPos={x,y}
return x,y
end


function UISubAct_YunHaiDiaoBaoWin:play_Animation(activityId,subType,subId,rewards)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
rewards=rewards or{}
local data=self.activityData.data
if self.activityData:getJumpAnimation()then
self.activityData:showPrize(rewards)
return
end
self.isAnim=true
local spe=false
local colorArr={}
for i,v in ipairs(rewards)do
if self.config.reset_items[v.itemid]then
spe=true
end
local color=itemsConfig.getItemColor(v.itemid)
table.insert(colorArr,color)
end
if#colorArr>1 then
table.sort(colorArr,function(a,b)
return a>b
end)
end
local multi=#rewards>1
local audioId=598
if spe then
audioId=599
end

self.btnCanvasGroup:setChildCanvasGroupDOFade(0,0.3)

self.fisherman:setChildModelAnimationState(2020)
self.effectRoot:setActive(true)

local delay=0
local maxEffectObj=#self.effectLottery
for i,color in ipairs(colorArr)do
if i>maxEffectObj then
break
end
delay=delay+(delayEffectTime[i]or delayEffectTime[#delayEffectTime])
self:delayDo(delay,function()
local effectid=colorEffectList[color]
local x,y=self:randomEffectPos(150)
self.effectLottery[i]:setChildAnchoredPos(x,y)
self.effectLottery[i]:setChildShowEffect(effectid,true)
end)
end

delay=delay+(multi and 0.3 or 0.5)
self:delayDo(delay,function()
self.activityData:showPrize(rewards)
end)

delay=delay+0.3
self:delayDo(delay,function()
self.fisherman:setChildModelAnimationState(eAnimationID.stand)
self.effectRoot:setActive(false)
self.isAnim=false

self.btnCanvasGroup:setChildCanvasGroupDOFade(1,0.3)
end)

AudioManager.playAudio(audioId)
end
end


function UISubAct_YunHaiDiaoBaoWin:refresh_Animation(activityId,subType,subId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
self.isAnim=false
end
end

function UISubAct_YunHaiDiaoBaoWin:refreshView_OnlyExplore(activityId,subType,subId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
self:refreshExplore()
end
end

function UISubAct_YunHaiDiaoBaoWin:refreshView_OnlyNext(activityId,subType,subId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
self:refreshNext()
end
end

function UISubAct_YunHaiDiaoBaoWin:startFreeTick()
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

function UISubAct_YunHaiDiaoBaoWin:stopFreeTick()
if self.freeTimer then
self:stopTimerByID(self.freeTimer)
self.freeTimer=nil
end
end

function UISubAct_YunHaiDiaoBaoWin.on_item_change(changeType,itemguid,itemid,lastcount,itemcount)
if _this.money==itemid then
_this:refreshMoney()
_this:refreshManyReddot()
end
end

function UISubAct_YunHaiDiaoBaoWin.on_money_changed(mType,oldValue,newValue)
if _this.exchangeMoney==mType then
_this:refreshExplore()
end
end

function UISubAct_YunHaiDiaoBaoWin:refreshMoney()
local num=itemsModel.getCount(self.money)
self.moneyNum:setText(num)
end

function UISubAct_YunHaiDiaoBaoWin:refreshManyReddot()
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


function UISubAct_YunHaiDiaoBaoWin:doSpeaking(type)
self:clearSpeakTimer()

local speakLib=self.config[type]
local rand1=math.random(#speakLib)
local speakStr1=speakLib[rand1]
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr1,speed,nil)
self:doTalkAnim()
end


function UISubAct_YunHaiDiaoBaoWin:doTalkAnim()
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


function UISubAct_YunHaiDiaoBaoWin:talkEnd()
self:clearSpeakTimer()
local showTime=self.config.speakTime
self.speakShowTimer=self:delayDo(showTime,function()

self.speakObj:setScale(Vector3.zero)
end)
end


function UISubAct_YunHaiDiaoBaoWin:clearSpeakTimer()
if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end

function UISubAct_YunHaiDiaoBaoWin:startRerollTick()
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

function UISubAct_YunHaiDiaoBaoWin:stopRerollTick()
if self.rerollTick then
self:stopTimerByID(self.rerollTick)
self.rerollTick=nil
end
end

function UISubAct_YunHaiDiaoBaoWin:startResetRollTick()
if not self.resetRollTick then
self.resetRollTick=self:setTimer(_rerollInterval,1,function()
self.rollList:resumeRoll()
self:stopResetRollTick()
end)
end
end

function UISubAct_YunHaiDiaoBaoWin:stopResetRollTick()
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



function UISubAct_YunHaiDiaoBaoWin:refreshIsShowReddotBtn()
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

function UISubAct_YunHaiDiaoBaoWin:onIsShowReddotBtn()
local actInfo=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
local isShowReddot=actInfo:checkIsShowReddot()
isShowReddot=not isShowReddot

actInfo:setIsShowReddot(isShowReddot)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)
self:refreshIsShowReddotBtn()
end

function UISubAct_YunHaiDiaoBaoWin.onSubActivityOverBeforeEndTime24Hour(actId,subType,subId)
if _this==nil then return end
if _this.activityId==actId and _this.subType==subType and _this.subId==subId then
_this:refreshIsShowReddotBtn()
end
end

