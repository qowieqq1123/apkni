







def_class("UISubAct_monthInvestorGiftWin",UIWindowBase)









function UISubAct_monthInvestorGiftWin:bindComponents()

self.rewards=UIObject.get(self,0)
self.normalRequirementTrick=UIObject.get(self,1)
self.normalRequirementSelect=UIObject.get(self,2)
self.highRequirementTrick=UIObject.get(self,3)
self.highRequirementSelect=UIObject.get(self,4)
self.goBtn=UIButton.get(self,5)
self.rewardBtn=UIButton.get(self,6)
self.gotFlag=UIObject.get(self,7)
self.timeText=UIText.get(self,8)
self.normalDescText_1=UIText.get(self,9)
self.normalDescText_2=UIText.get(self,10)
self.highDescText_1=UIText.get(self,11)
self.highDescText_2=UIText.get(self,12)
self.npcModel=UIObject.get(self,13)
self.speakObj=UIObject.get(self,14)
self.speakText=UIText.get(self,15)
self.normalDiscountFlag=UIImage.get(self,16)
self.highDiscountFlag=UIImage.get(self,17)
self.highDescText_3=UIText.get(self,18)

self.goBtn:setButtonClick(function()self:onGoBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)
self.normalDescText={
self.normalDescText_1,
self.normalDescText_2,
}
self.highDescText={
self.highDescText_1,
self.highDescText_2,
self.highDescText_3,
}



end


function UISubAct_monthInvestorGiftWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rewards);self.rewards=nil;
_UIObject_release(self.normalRequirementTrick);self.normalRequirementTrick=nil;
_UIObject_release(self.normalRequirementSelect);self.normalRequirementSelect=nil;
_UIObject_release(self.highRequirementTrick);self.highRequirementTrick=nil;
_UIObject_release(self.highRequirementSelect);self.highRequirementSelect=nil;
_UIObject_release(self.goBtn);self.goBtn=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.gotFlag);self.gotFlag=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.normalDescText_1);self.normalDescText_1=nil;
_UIObject_release(self.normalDescText_2);self.normalDescText_2=nil;
_UIObject_release(self.highDescText_1);self.highDescText_1=nil;
_UIObject_release(self.highDescText_2);self.highDescText_2=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.normalDiscountFlag);self.normalDiscountFlag=nil;
_UIObject_release(self.highDiscountFlag);self.highDiscountFlag=nil;
_UIObject_release(self.highDescText_3);self.highDescText_3=nil;
self.normalDescText=nil;
self.highDescText=nil;
end
















local _this




function UISubAct_monthInvestorGiftWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UISubAct_monthInvestorGiftWin:__delete()
_this=nil
self:unbindComponents()
self:clearAllTimer()
end




function UISubAct_monthInvestorGiftWin:onShow(argtable,afterOnloaded)
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

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.beginTime=self.activityData.start_time
self.endTime=self.activityData.end_time

self:refresh(true)
end


function UISubAct_monthInvestorGiftWin:onHide()
self:clearAllTimer()
end


function UISubAct_monthInvestorGiftWin:refresh(isInit)

local rewardList=self.config.items

self.rewards:setChildLayoutGroupCreateItems(#rewardList)
local grids=self.rewards:getChildLayoutGroupGridList()
for i=1,#rewardList do
local widget=grids[i-1]
local reward=rewardList[i]
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local colorEffect=i==1
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=colorEffect}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end


local normalRequirementFinish=self.activityData.data.normalRequirement~=0
local highRequirementFinish=self.activityData.data.highRequirement~=0
self.normalRequirementTrick:setActive(normalRequirementFinish)
self.normalRequirementSelect:setActive(normalRequirementFinish)
self.highRequirementTrick:setActive(highRequirementFinish)
self.highRequirementSelect:setActive(highRequirementFinish)


local normalMonthCardType=1
local normalHasDiscount=self.activityData:checkHasDiscount(normalMonthCardType)
local highMonthCardType=2
local highHasDiscount=self.activityData:checkHasDiscount(highMonthCardType)
self.normalDiscountFlag:setActive(normalHasDiscount)
self.highDiscountFlag:setActive(highHasDiscount)


local isGot=self.activityData.data.normalRequirement==2 and self.activityData.data.highRequirement==2
self.gotFlag:setActive(isGot)

if not isGot then

if normalRequirementFinish and highRequirementFinish then
self.goBtn:setActive(false)
self.rewardBtn:setActive(true)
else
self.goBtn:setActive(true)
self.rewardBtn:setActive(false)
end
else

self.goBtn:setActive(false)
self.rewardBtn:setActive(false)
end


for i=1,#self.normalDescText do
local descStr=self.config.normalDesc[i]or""
self.normalDescText[i]:setText(descStr)
end


for i=1,#self.highDescText do
local descStr=self.config.highDesc[i]or""
self.highDescText[i]:setText(descStr)
end


self:refreshNPCModel(isInit)


self:setRemainingTimeTimer()
end



function UISubAct_monthInvestorGiftWin:refreshNPCModel(isInit)
local fadeTime=isInit and 0.5 or 0
self.speakContent=self.config.npcTalk
local npcModelParms=self.config.npcModel
local modelId=npcModelParms[1]
local scale=npcModelParms[2]
local modelOffSet=npcModelParms[3]
self.npcModel:setChildUIModelShowTarget(modelId,scale,{},eAnimationID.stand,false,false,fadeTime)
self.npcModel:setChildUIModelShowTargetOffset(modelOffSet[1],modelOffSet[2])
local isFlip=self.config.isFlip==true
self.npcModel:setChildUIModelShowFlipX(isFlip)

self.npcTalkTime=self.config.npcTalkTime
self.npcTalkShowTime=self.config.npcTalkShowTime

if isInit then

self.speakObj:setScale(Vector3.zero)
end


self:delayDo(0.3,function()
self:doSpeaking()
end)
end


function UISubAct_monthInvestorGiftWin:doSpeaking()
self:clearSpeakTimer()
self:clearModelSpeakAnimTimer()

local rand=math.random(1,#self.speakContent)
local speakStr=self.speakContent[rand]
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
self.npcModel:setChildModelAnimationState(eAnimationID.button_click)
self.modelSpeakAnimTimer=self:delayDo(2.6,function()
self.npcModel:setChildModelAnimationState(eAnimationID.stand)
end)
self:doTalkAnim()
end


function UISubAct_monthInvestorGiftWin:doTalkAnim()
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end
self.speakObj:setScale(Vector3.zero)
self:delayDo(0.5,function()
self.speakObj:setChildCanvasGroupAlpha(1)
self.talkTween=self.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween=nil
_this.talkTween=_this.speakObj:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween=nil
return _this:talkEnd()
end)
end)
end)
end


function UISubAct_monthInvestorGiftWin:talkEnd()
self:clearSpeakTimer()
self.speakShowTimer=self:delayDo(self.npcTalkShowTime,function()

self.speakObj:setScale(Vector3.zero)
if self.modelSpeakAnimTimer then
self.npcModel:setChildModelAnimationState(eAnimationID.stand)
self:clearModelSpeakAnimTimer()
end

self.speakTimer=self:delayDo(self.npcTalkTime,function()
return self:doSpeaking()
end)
end)
end




function UISubAct_monthInvestorGiftWin:onGoBtn()

local jumpParam={0,JUMP_TYPE.eReCharge,{tabType=FULL_TAB_TYPE.eMonthInvestor}}
local jumpType=jumpParam[1]
local jumpId=jumpParam[2]
local args=jumpParam[3]
local tabType=FULL_TAB_TYPE.eMonthInvestor
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
UIManager.error(FMT.fmt('{0}级开启{1}系统',level,name))
end
else

local name=systemConfig.getSystemName(sysid)
logErr(FMT.fmt("{0}系统配置了屏蔽 请检查配置",name))
UIManager.error(FMT.fmt('{0}系统尚未开启',name))
end
return
end
end

UIFullCommonControl:closeUI()


jumpManager:jump({type=jumpType,id=jumpId,args=args})
end


function UISubAct_monthInvestorGiftWin:onRewardBtn()

if not self['checkEnd']or self:checkEnd()then
UIManager.error("活动已结束")
return
end


activitiesController:sendProtocol(actSendType.eComonReqHandle,self.activityId,self.subType,self.subId,"")
end


function UISubAct_monthInvestorGiftWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end

function UISubAct_monthInvestorGiftWin:onClickClose()
self:closeSelf()
end


function UISubAct_monthInvestorGiftWin:setRemainingTimeTimer()
self:clearTimer()
local func
func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.endTime and self.endTime-nowTime or 0
if lerp>0 then

self.timeText:setText(FMT.fmt("{0}后结束",timeHelper.format_time_stamp11(lerp,true)))
else
self.timeText:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()
end
end

self.timer=self:setTimer(1,0,func)

func()
end


function UISubAct_monthInvestorGiftWin:clearAllTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end

if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end

if self.modelSpeakAnimTimer then
self:stopTimerByID(self.modelSpeakAnimTimer)
self.modelSpeakAnimTimer=nil
end
end


function UISubAct_monthInvestorGiftWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UISubAct_monthInvestorGiftWin:clearSpeakTimer()
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end


function UISubAct_monthInvestorGiftWin:clearModelSpeakAnimTimer()
if self.modelSpeakAnimTimer then
self:stopTimerByID(self.modelSpeakAnimTimer)
self.modelSpeakAnimTimer=nil
end
end



function UISubAct_monthInvestorGiftWin:checkEnd()
local isEnd=false
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.activityData.end_time-nowTime
if lerp<=0 then
isEnd=true
end

return isEnd
end


function UISubAct_monthInvestorGiftWin:onNPCClick()
self:doSpeaking()
end