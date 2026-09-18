







def_class("UIMonthInvestorDailyWin",UIWindowBase)









function UIMonthInvestorDailyWin:bindComponents()

self.mask=UIButton.get(self,0)
self.btnClose=UIButton.get(self,1)
self.rewardScrollView=UIObject.get(self,2)
self.normalCardTime=UIText.get(self,3)
self.highCardTime=UIText.get(self,4)
self.getRewardBtn=UIButton.get(self,5)
self.expireTipsPanel=UIObject.get(self,6)
self.npcModel=UIObject.get(self,7)
self.speakObj=UIObject.get(self,8)
self.speakText=UIText.get(self,9)
self.npcClick=UIButton.get(self,10)

self.mask:setButtonClick(function()self:onMask()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.getRewardBtn:setButtonClick(function()self:onGetRewardBtn()end)

self.npcClick:setButtonClick(function()self:onNpcClick()end)



end


function UIMonthInvestorDailyWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.normalCardTime);self.normalCardTime=nil;
_UIObject_release(self.highCardTime);self.highCardTime=nil;
_UIObject_release(self.getRewardBtn);self.getRewardBtn=nil;
_UIObject_release(self.expireTipsPanel);self.expireTipsPanel=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.npcClick);self.npcClick=nil;
end
















local _this




function UIMonthInvestorDailyWin:onLoaded(...)
_this=self
self:bindComponents()
local _onClickRewardItem=function(...)
self:onClickRewardItem(...)
end
self.rewardScrollView:setChildScrollViewInit(0.5,true,_onClickRewardItem,nil)
end


function UIMonthInvestorDailyWin:__delete()
self:unbindComponents()
_this=nil
self:clearTimer()
self:clearSpeakTimer()
end




function UIMonthInvestorDailyWin:onShow(argtable,afterOnloaded)
self.showExpireTipsDayCount=cfgHelper.get2(cfg_yuekabaseconfig_get,1,"showExpireDayCount")
self.showExpireTipsState=false


self:initData()


self:refresh()
end


function UIMonthInvestorDailyWin:onHide()
self:clearTimer()
self:clearSpeakTimer()
end


function UIMonthInvestorDailyWin:refresh()

self.rewardScrollView:setChildScrollViewCreateGrids(#self.rewardsList,#self.rewardsList)
local grids=self.rewardScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local reward=self.rewardsList[i]
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
item:SetChildPropData(-1,prop)
end
end


self:refreshLeftoverTimeTextByCardId()

self:setRemainingTimeTimer()
end

function UIMonthInvestorDailyWin:initData()

local cfg=cfg_yuekaconfig()
self.activeMonthCardList={}

self.rewardsList={}
self.rewardsList_lookup={}

for i=1,#cfg do
local cardId=cfg[i].id
local isActive=rechargeModel:checkCardActive(cardId)
if isActive then
local isGotReward=rechargeModel:checkCardGetReward(cardId)
local activeCardInfo={
id=cardId,
isGotReward=isGotReward,
name=cfg[i].name
}
self.activeMonthCardList[#self.activeMonthCardList+1]=activeCardInfo

if not isGotReward then
local rewards=cfg[i].dayItems
for _,reward in ipairs(rewards)do
local itemId=reward[1]
local itemCount=reward[2]
if self.rewardsList_lookup[itemId]then

self.rewardsList_lookup[itemId][2]=self.rewardsList_lookup[itemId][2]+itemCount
else

self.rewardsList[#self.rewardsList+1]={itemId,itemCount}
self.rewardsList_lookup[itemId]=self.rewardsList[#self.rewardsList]
end
end
end
end
end
end

function UIMonthInvestorDailyWin:refreshLeftoverTimeTextByCardId(cardId,remainingDay,cardIdName)
if not cardId then

self.normalCardTime:setActive(false)
self.highCardTime:setActive(false)
elseif cardId==1 then

self.normalCardTime:setActive(true)
self.normalCardTime:setText(FMT.fmt("<color=#6833c0>{0}</color>    剩余 <color=#549327>{1}</color> 天",cardIdName,remainingDay))
elseif cardId==2 then

self.highCardTime:setActive(true)
self.highCardTime:setText(FMT.fmt("<color=#ca631d>{0}</color>    剩余 <color=#549327>{1}</color> 天",cardIdName,remainingDay))
end
end

function UIMonthInvestorDailyWin:refreshExpirePanel(cardId)
self.expireTipsPanel:setActive(self.showExpireTipsState)
if self.showExpireTipsState then

local npcId=3
local cfg=cfgHelper.get1(cfg_yuekanpcconfig_get,npcId)
local cardCfg=cfgHelper.get1(cfg_yuekaconfig_get,cardId)
self.speakContent=cfg.npcTalk_expire
self.speakContentCardName=cardCfg.name
local npcModelParms=cfg.npcModel
local modelId=npcModelParms[1]
local scale=npcModelParms[2]
local modelOffSet=npcModelParms[3]
self.npcModel:setChildUIModelShowTarget(modelId,scale,{},eAnimationID.stand,false,false,0.5)
self.npcModel:setChildUIModelShowTargetOffset(modelOffSet[1],modelOffSet[2])
local isFlip=cfg.isFlip==true
self.npcModel:setChildUIModelShowFlipX(isFlip)

self.npcTalkTime=cfg.npcTalkTime
self.npcTalkShowTime=cfg.npcTalkShowTime

self:delayDo(0.3,function()
self:doSpeaking()
end)
else

self:clearSpeakTimer()

self.npcModel:setChildUIModelRemoveTarget()
end
end


function UIMonthInvestorDailyWin:doSpeaking()
self:clearSpeakTimer()
local speakList={}
speakList=self.speakContent

local rand=math.random(1,#speakList)
local selectStr=speakList[rand]
local speakStr=FMT.fmt(selectStr,self.speakContentCardName)
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
self.npcModel:setChildModelAnimationState(2099)
self:doTalkAnim()
end


function UIMonthInvestorDailyWin:doTalkAnim()
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


function UIMonthInvestorDailyWin:talkEnd()
self:clearSpeakTimer()
self.speakShowTimer=self:delayDo(self.npcTalkShowTime,function()

self.speakObj:setScale(Vector3.zero)

self.speakTimer=self:delayDo(self.npcTalkTime,function()
return self:doSpeaking()
end)
end)
end



function UIMonthInvestorDailyWin:onMask()



wagesMsgConfig:doReceiveWages(wagesTypeEnum.eYueKa)
end



function UIMonthInvestorDailyWin:onBtnClose()
self:closeSelf()
end



function UIMonthInvestorDailyWin:onGetRewardBtn()


wagesMsgConfig:doReceiveWages(wagesTypeEnum.eYueKa)
end

function UIMonthInvestorDailyWin:onNpcClick()

local jumpParam={0,JUMP_TYPE.eReCharge,{tabType=FULL_TAB_TYPE.eMonthInvestor}}
local jumpType=jumpParam[1]
local jumpId=jumpParam[2]
local args=jumpParam[3]


wagesMsgConfig:doReceiveWages(wagesTypeEnum.eYueKa)
self:closeSelf()


return jumpManager:jump({type=jumpType,id=jumpId,args=args})
end


function UIMonthInvestorDailyWin:onClickRewardItem(clickCount,index)

local itemid=nil
local itemguid=nil

itemid=self.rewardsList[index+1][1]

if itemid==-1 or itemid==0 then
return
end
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
end


function UIMonthInvestorDailyWin:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local minRemainingDay
local minRemainingDayCardId
local oldState=self.showExpireTipsState
local needRefresh=false
if self.activeMonthCardList and next(self.activeMonthCardList)then

for i,activeCard in ipairs(self.activeMonthCardList)do
local remainingDay=rechargeModel:getCardRemainDay(activeCard.id)
if remainingDay>0 then

self:refreshLeftoverTimeTextByCardId(activeCard.id,remainingDay,activeCard.name)

if not minRemainingDay or remainingDay<=minRemainingDay then
minRemainingDay=remainingDay
minRemainingDayCardId=activeCard.id
end
else

needRefresh=true
end
end
else

self:clearTimer()
return self:onBtnClose()
end

if needRefresh then
self:clearTimer()

self:initData()

self:refresh()
else
self.showExpireTipsState=minRemainingDay and minRemainingDay<=self.showExpireTipsDayCount or false
if self.showExpireTipsState~=oldState then

self:refreshExpirePanel(minRemainingDayCardId)
UIManager:invokeUIMethod("UIWagesInfoWin",'freshQuickBtn')
end
end
end
self.timer=self:setTimer(1,0,func)
func()
end


function UIMonthInvestorDailyWin:clearSpeakTimer()
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end


function UIMonthInvestorDailyWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UIMonthInvestorDailyWin:closeSelfDelay(delay)
self:delayDo(delay,function()
self:closeSelf()
end)
end