







def_class("UIWeekInvestorDailyWin",UIWindowBase)









function UIWeekInvestorDailyWin:bindComponents()

self.btnClose=UIButton.get(self,0)
self.expireTipsPanel=UIObject.get(self,1)
self.getRewardBtn=UIButton.get(self,2)
self.mask=UIButton.get(self,3)
self.npcClick=UIButton.get(self,4)
self.npcModel=UIObject.get(self,5)
self.rewardList=UIObject.get(self,6)
self.rewardScrollView=UIObject.get(self,7)
self.speakObj=UIObject.get(self,8)
self.speakText=UIText.get(self,9)
self.timeList=UIObject.get(self,10)
self.timeView=UIObject.get(self,11)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.getRewardBtn:setButtonClick(function()self:onGetRewardBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.npcClick:setButtonClick(function()self:onNpcClick()end)



end


function UIWeekInvestorDailyWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.expireTipsPanel);self.expireTipsPanel=nil;
_UIObject_release(self.getRewardBtn);self.getRewardBtn=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.npcClick);self.npcClick=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.timeList);self.timeList=nil;
_UIObject_release(self.timeView);self.timeView=nil;
end















local _this=nil



function UIWeekInvestorDailyWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onNewDay,self.onNewDay)
self:addProNotify(14,30,self.on_14_30)
self:addProNotify(14,31,self.on_14_31)
self:addProNotify(14,32,self.on_14_32)
end


function UIWeekInvestorDailyWin:__delete()
self:unbindComponents()
_this=nil


self:clearSpeakTimer()
end




function UIWeekInvestorDailyWin:onShow(argtable,afterOnloaded)
self.showExpireTipsDayCount=cfgHelper.get2(cfg_zhoukabaseconfig_get,1,"appendDay")


self:initData()


self:refresh()
end


function UIWeekInvestorDailyWin:onHide()

self:clearSpeakTimer()
end




function UIWeekInvestorDailyWin:onBtnClose()
self:closeSelf()
end


function UIWeekInvestorDailyWin:onGetRewardBtn()
wagesMsgConfig:doReceiveWages(wagesTypeEnum.eZhouKa)
end


function UIWeekInvestorDailyWin:onMask()
wagesMsgConfig:doReceiveWages(wagesTypeEnum.eZhouKa)
end


function UIWeekInvestorDailyWin:onNpcClick()

local jumpId=JUMP_TYPE.eReCharge
local args={tabType=FULL_TAB_TYPE.eMonthInvestor,subTabType=2,subTabArgs={id=self.showExpireMin.id}}

wagesMsgConfig:doReceiveWages(wagesTypeEnum.eZhouKa)
self:closeSelf()


return jumpManager:jump({id=jumpId,args=args})
end


function UIWeekInvestorDailyWin:onClickRewardItem(clickCount,index)

local itemid=nil
local itemguid=nil

itemid=self.rewardsData[index+1][1]

if itemid==-1 or itemid==0 then
return
end
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
end


function UIWeekInvestorDailyWin:doSpeaking()
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


function UIWeekInvestorDailyWin:doTalkAnim()
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


function UIWeekInvestorDailyWin:talkEnd()
self:clearSpeakTimer()
self.speakShowTimer=self:delayDo(self.npcTalkShowTime,function()

self.speakObj:setScale(Vector3.zero)

self.speakTimer=self:delayDo(self.npcTalkTime,function()
return self:doSpeaking()
end)
end)
end


function UIWeekInvestorDailyWin:clearSpeakTimer()
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end









function UIWeekInvestorDailyWin:initData()

local datas=rechargeModel:getWeekCardDatas()
self.canRewardList={}

self.rewardsData={}
self.rewardsData_lookup={}
self.showExpireMin=nil

local nowTime=timeHelper.getServerShortTime()
local todayZero=timeHelper.getServerZeroShortStamp(nowTime)
for i,v in pairs(datas)do
local isValid=nowTime<v.valid
if isValid then
local cfg=cfgHelper.get1(cfg_zhoukaconfig_get,v.id)
local leastDay=math.floor((v.valid-todayZero)/86400+0.5)
local isGotReward=timeHelper.checkInSameDay2(v.daily,nowTime)
if not isGotReward then
local activeCardInfo={
id=v.id,
name=cfg.name,
time=leastDay,
}
self.canRewardList[#self.canRewardList+1]=activeCardInfo

local rewards=defaultT
for j,w in ipairs(cfg.dayItems)do
if w[1]<=v.level and v.level<=w[2]then
rewards=w[3]
break
end
end
for _,reward in ipairs(rewards)do
local itemId=reward[1]
local itemCount=reward[2]
if self.rewardsData_lookup[itemId]then

self.rewardsData_lookup[itemId][2]=self.rewardsData_lookup[itemId][2]+itemCount
else

self.rewardsData[#self.rewardsData+1]={itemId,itemCount}
self.rewardsData_lookup[itemId]=self.rewardsData[#self.rewardsData]
end
end
end

if leastDay<=self.showExpireTipsDayCount then
if self.showExpireMin==nil or v.id<self.showExpireMin.id then
self.showExpireMin=self.showExpireMin or{}
self.showExpireMin.id=v.id
self.showExpireMin.name=cfg.name
self.showExpireMin.time=leastDay
end
end
end
end
end

function UIWeekInvestorDailyWin:refresh()
if#self.canRewardList<=0 then
self:onBtnClose()
return
end


self:refreshRewardList()
self:refreshLeastTime()
self:refreshExpirePanel()
end

function UIWeekInvestorDailyWin:refreshRewardList()
self.rewardList:setChildLayoutGroupCreateItems(#self.rewardsData,function(index)
local item=self.rewardList:getChildLayoutGroupGridItem(index-1)
local reward=self.rewardsData[index]
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
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
self.rewardScrollView:setChildScrollRectEnable(#self.rewardsData>=3)
end

function UIWeekInvestorDailyWin:refreshExpirePanel()
self.expireTipsPanel:setActive(self.showExpireMin~=nil)
if self.showExpireMin then

local npcId=cfgHelper.get2(cfg_zhoukabaseconfig_get,1,'npc')
local cfg=cfgHelper.get1(cfg_yuekanpcconfig_get,npcId)
local name=self.showExpireMin.name
self.speakContent=cfg.npcTalk_expire
self.speakContentCardName=name
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

function UIWeekInvestorDailyWin:refreshLeastTime()
self.timeList:setChildLayoutGroupCreateItems(#self.canRewardList,function(index)
local item=self.timeList:getChildLayoutGroupGridItem(index-1)
local data=self.canRewardList[index]
item:SetChildText(0,FMT.fmt("<color=#ca631d>{0}</color>    剩余 <color=#549327>{1}</color> 天",data.name,data.time))
end)
self.timeView:setChildScrollRectEnable(#self.canRewardList>=5)
end

function UIWeekInvestorDailyWin.onNewDay()
_this:initData()
_this:refresh()
end

function UIWeekInvestorDailyWin.on_14_30(len,list)
_this:initData()
_this:refresh()
end

function UIWeekInvestorDailyWin.on_14_31(id)
if id==0 then
self:delayDo(0.5,function()
self:closeSelf()
end)
else
_this:initData()
_this:refresh()
end
end

function UIWeekInvestorDailyWin.on_14_32(data)
_this:initData()
_this:refresh()
end