







def_class("UISubAct_AnniversarySignInWin",UIWindowBase)









function UISubAct_AnniversarySignInWin:bindComponents()

self.activationBtn=UIButton.get(self,0)
self.aiModel=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.day=UIText.get(self,3)
self.effect=UIObject.get(self,4)
self.mbg=UIObject.get(self,5)
self.panel1=UIObject.get(self,6)
self.panel2=UIObject.get(self,7)
self.pickUpGBClick=UIButton.get(self,8)
self.pickUpGBModel=UIObject.get(self,9)
self.pickUpPanel=UIObject.get(self,10)
self.pickUpShowLBtn=UIButton.get(self,11)
self.pickUpShowRBtn=UIButton.get(self,12)
self.pickUpTime=UIText.get(self,13)
self.pickUpTimePanel=UIObject.get(self,14)
self.progressBar=UIObject.get(self,15)
self.progressContent=UIObject.get(self,16)
self.progressRewardScrollView=UIObject.get(self,17)
self.progressValue=UIObject.get(self,18)
self.repairBtn=UIButton.get(self,19)
self.rewardFlag=UIObject.get(self,20)
self.rewardList=UIObject.get(self,21)
self.rewardReddot=UIObject.get(self,22)
self.rewardRoot=UIObject.get(self,23)
self.rewardScrollView=UIObject.get(self,24)
self.timeText=UIText.get(self,25)
self.titleImage=UIImage.get(self,26)

self.activationBtn:setButtonClick(function()self:onActivationBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.pickUpGBClick:setButtonClick(function()self:onPickUpGBClick()end)

self.pickUpShowLBtn:setButtonClick(function()self:onPickUpShowLBtn()end)

self.pickUpShowRBtn:setButtonClick(function()self:onPickUpShowRBtn()end)

self.repairBtn:setButtonClick(function()self:onRepairBtn()end)



end


function UISubAct_AnniversarySignInWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.activationBtn);self.activationBtn=nil;
_UIObject_release(self.aiModel);self.aiModel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.day);self.day=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.panel1);self.panel1=nil;
_UIObject_release(self.panel2);self.panel2=nil;
_UIObject_release(self.pickUpGBClick);self.pickUpGBClick=nil;
_UIObject_release(self.pickUpGBModel);self.pickUpGBModel=nil;
_UIObject_release(self.pickUpPanel);self.pickUpPanel=nil;
_UIObject_release(self.pickUpShowLBtn);self.pickUpShowLBtn=nil;
_UIObject_release(self.pickUpShowRBtn);self.pickUpShowRBtn=nil;
_UIObject_release(self.pickUpTime);self.pickUpTime=nil;
_UIObject_release(self.pickUpTimePanel);self.pickUpTimePanel=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressContent);self.progressContent=nil;
_UIObject_release(self.progressRewardScrollView);self.progressRewardScrollView=nil;
_UIObject_release(self.progressValue);self.progressValue=nil;
_UIObject_release(self.repairBtn);self.repairBtn=nil;
_UIObject_release(self.rewardFlag);self.rewardFlag=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.rewardRoot);self.rewardRoot=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.titleImage);self.titleImage=nil;
end
















local _this
local pickUpGBLoopTime=10



function UISubAct_AnniversarySignInWin:onLoaded(...)
self:bindComponents()
_this=self

self.initShowBg1=nil
self.initShowBg2=nil
self.pickUpShowGBList=nil
end


function UISubAct_AnniversarySignInWin:__delete()
if self.actorAudioHandleId then
AudioManager.fadeOutStopAudioById(self.actorAudioHandleId,0.5)
end

self:unbindComponents()
self:closeWindow("UIRawImageBackWin")

self:stopPickUpGBModelLoadTimer()

self.initShowBg1=nil
self.initShowBg2=nil

_this=nil
end




function UISubAct_AnniversarySignInWin:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eZhouNianQingQianDao
self.subid=argtable.sub_act_id
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)

local isActive=self.info:checkActive()
if isActive then
self:refreshPanel1()
else
self:refreshPanel2()
end

if self.activityArgs.parentWin then
UIManager:callWindowFunc(self.activityArgs.parentWin,"hideClose")
else
local arrs=self:getChildCanvas(-1)
local sortLayer=arrs[1]
local sortOrder=arrs[2]-1
self:showWindow("UIRawImageBackWin",{sortLayer=sortLayer,sortOrder=sortOrder})
end
end

function UISubAct_AnniversarySignInWin:refreshPanel1()
self.panel2:setActive(false)
self.panel1:setActive(true)
local openPanel=self.config.openPanel
if openPanel[1][2]and not self.initShowBg1 then
self.initShowBg1=true
local modelParams=openPanel[1][2].modelParams

if modelParams then
self.panel1:setChildCanvasGroupAlpha(0)
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
self.mbg:setChildUIModelShowTarget(modelParams.body,modelParams.scale or 1,modelParams.components or{},eAnimationID.enter,false,nil,0)
self.mbg:setChildUIModelShowTargetOffset(modelParams.offsetX or 0,modelParams.offsetY or 0)
self:setTimer(0.4,0,function()
if _this==nil then return end
_this.panel1:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end
end

self:setRemainingTimeTimer()

self:refreshList()
self:refreshSignReward()
end

function UISubAct_AnniversarySignInWin:refreshPanel2()
self.panel1:setActive(false)
self.panel2:setActive(true)
local openPanel=self.config.openPanel
if openPanel[1][2]and not self.initShowBg2 then
self.initShowBg2=true
local modelParams=openPanel[1][2].modelParams2

if modelParams then
self.panel2:setChildCanvasGroupAlpha(0)
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
self.mbg:setChildUIModelShowTarget(modelParams.body,modelParams.scale or 1,modelParams.components or{},eAnimationID.enter,false,nil,0)
self.mbg:setChildUIModelShowTargetOffset(modelParams.offsetX or 0,modelParams.offsetY or 0)
self:setTimer(0.4,0,function()
if _this==nil then return end
_this.panel2:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end
end

local rewards={}
for i,v in ipairs(self.config.rewards)do
local itemid=v[1]
local count=v[2]
rewards[itemid]=(rewards[itemid]or 0)+count*30
end
for i,v in ipairs(self.config.accumulative_rewards)do
for i,v in ipairs(v[2])do
local itemid=v[1]
local count=v[2]
rewards[itemid]=(rewards[itemid]or 0)+count
end
end
local list={}
for itemid,count in pairs(rewards)do
local cfg=itemsConfig.getConfig(itemid)
local rareLv=itemsConfig.getRareLv(itemid)
local sortWeight=rareLv*10000
sortWeight=sortWeight+cfg.color*1000
if itemsConfig.isEquip(itemid)then
sortWeight=sortWeight+100
end
table.insert(list,{itemid=itemid,count=count,sortWeight=sortWeight})
end
table.sort(list,function(a,b)
return a.sortWeight>b.sortWeight
end)

local len=#list
self.rewardScrollView:setChildScrollViewCreateGrids(len,3)
local grids=self.rewardScrollView:getChildScrollViewItemWidgets()
for i=1,len do
local widget=grids[i-1]
local itemid=list[i].itemid
local count=list[i].count

local showCountBG=count>1
local countStr=showCountBG and count or""
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClickEx(...)
end)
end
end

function UISubAct_AnniversarySignInWin:refreshSignReward()
local canSign=self.info:checkSign()
self.rewardList:setChildLayoutGroupCreateItems(#self.config.rewards,function(index)
local widget=self.rewardList:getChildLayoutGroupGridItem(index-1)
local reward=self.config.rewards[index]
local itemid=reward[1]
local count=reward[2]
local showCountBG=count>1
local countStr=showCountBG and count or""

local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,colorEffect=canSign}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(-1,prop)
widget:SetChildActive(7,not canSign)
widget:SetBaseItemClickEvent(-1,function(...)
if canSign then
self.info:reqGetDayReward()
else
itemsComponentHelper.onItemClickEx(...)
end
end)
end)

self.rewardReddot:setActive(canSign)
self.rewardFlag:setActive(not canSign)
local canRepairSign=self.info:checkRepairSign()
self.repairBtn:setActive(canRepairSign)
end

function UISubAct_AnniversarySignInWin:refreshList()
local accumulative_rewards=self.config.accumulative_rewards

local len=#accumulative_rewards

local curValue=self.info:getSignDay()
self.progressRewardScrollView:setChildScrollViewCreateGrids(len,len)

self.day:setText(curValue)

local maxGotIdx=0
local finalFinishIdx=0
local grids=self.progressRewardScrollView:getChildScrollViewItemWidgets()
for i=1,len do
local item=grids[i-1]
local accumulative=accumulative_rewards[i]
local day=accumulative[1]
local rewards=accumulative[2]

local isGot=self.info:checkGot(i)
local canGot=curValue>=day and not isGot
if curValue>=day then
maxGotIdx=i
end
if isGot and i>finalFinishIdx then
finalFinishIdx=i
end

local itemId=rewards[1][1]
local itemNum=rewards[1][2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local itemConf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,colorEffect=canGot}
local itemProp=itemsComponentHelper.getCommonFillDataSmall(itemConf)
item:SetChildPropData(0,itemProp)
item:SetBaseItemClickEvent(0,function(...)
if canGot then
_this.info:reqGetProgressReward(i)
else
itemsComponentHelper.onItemClickEx(...)
end
end)

item:SetChildText(1,FMT.fmt("{0}天",day))
item:SetChildActive(2,canGot)
item:SetChildActive(3,isGot)
end

local jumpIndex=finalFinishIdx
if jumpIndex<0 then
jumpIndex=0
end
self.progressRewardScrollView:setChildScrollRectEnable(false)
self.progressRewardScrollView:setChildScrollViewSelectItem(jumpIndex-1,false,false,false)
self.progressRewardScrollView:setChildScrollRectEnable(true)

local progressBarWidth=self.progressBar:getChildRectWidth()
local progressValueWidth=progressBarWidth-5
local progressValueHeight=self.progressValue:getChildRectHeight()
local nowValue=0
if maxGotIdx<len then
local accumulative=accumulative_rewards[maxGotIdx+1]
local day=accumulative[1]

local _s=30
local _w=82
if maxGotIdx>0 then
local oldDay=accumulative_rewards[maxGotIdx][1]
if curValue==oldDay then
nowValue=maxGotIdx*(_w+_s)-_w/2
else
nowValue=maxGotIdx*(_w+_s)-_w/2+(_s+_w)*(curValue-oldDay)/(day-oldDay)
end
else
nowValue=(_s+_w/2)*curValue/day
end
else
nowValue=progressValueWidth
end
self.progressValue:setChildSizeDelta(nowValue,progressValueHeight)

local list,day,idx=self.info:getBigRewardList()
if curValue<day then
self.pickUpTime:setText(FMT.fmt("还需{0}天可领取",day-curValue))
elseif curValue>=day and not self.info:checkGot(idx)then
self.pickUpTime:setText("可领取")
else
self.pickUpTime:setText("已领取")
end
if not self.pickUpShowBigDay or self.pickUpShowBigDay~=day then
self.pickUpShowGBList=list
self.pickUpShowBigDay=day
self:flushPickUpPanel()
end
end


function UISubAct_AnniversarySignInWin:setRemainingTimeTimer()
self:clearTimer()
local func
func=function()
self:refreshRemainingTimeTimer()
end

self.timer=self:setTimer(1,0,func)

self:refreshRemainingTimeTimer()
end


function UISubAct_AnniversarySignInWin:refreshRemainingTimeTimer()
local time=activitiesModel:getSubActEndLeftTime(self.actid,self.subType,self.subid)
if time>0 then

local time_str=FMT.fmt('活动剩余时间：{0}',timeHelper.format_time_stamp11(time,true))
self.timeText:setText(time_str)
else
self.timeText:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()
self:onCloseBtn()
end
end


function UISubAct_AnniversarySignInWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UISubAct_AnniversarySignInWin:clearPanel2()
self.rewardScrollView:setChildScrollViewStopGridCreate()
end


function UISubAct_AnniversarySignInWin:onHide()

end


function UISubAct_AnniversarySignInWin:flushPickUpPanel()
local pickUpShowGBList=self.pickUpShowGBList
if pickUpShowGBList and next(pickUpShowGBList)then
self.showPickUpGbSelectIndex=1
local showCount=#pickUpShowGBList
self.showPickUpGbMaxSelectIndex=showCount
self.pickUpPanel:setActive(true)
self:refreshPickUpGBModel()
if showCount<=1 then

self.pickUpShowLBtn:setActive(false)
self.pickUpShowRBtn:setActive(false)
self.nextPickUpGBShowTime=nil
else

self.pickUpShowLBtn:setActive(true)
self.pickUpShowRBtn:setActive(true)
local nowTime=timeHelper.getServerLongTime()
self.nextPickUpGBShowTime=nowTime+pickUpGBLoopTime
end

self:setPickUpGBShowTimer()
else

self.pickUpPanel:setActive(false)
end
end

function UISubAct_AnniversarySignInWin:setPickUpGBShowTimer()
self:stopPickUpGBShowTimer()
local timerFun=function(isFirst)
local nowTime=timeHelper.getServerLongTime()
if not isFirst and nowTime>=self.nextPickUpGBShowTime then
self:onPickUpShowRBtn()
end
end
self.pickUpShowTimer=self:setTimer(1,0,function()
return timerFun()
end)
timerFun(true)
end

function UISubAct_AnniversarySignInWin:stopPickUpGBShowTimer()
if self.pickUpShowTimer then
self:stopTimerByID(self.pickUpShowTimer)
self.pickUpShowTimer=nil
end
end

function UISubAct_AnniversarySignInWin:refreshPickUpGBModel()
self.pickUpGBModel:setChildShowEffect(0,false)
local pickUpShowGBList=self.pickUpShowGBList
local showGBItemId=pickUpShowGBList[self.showPickUpGbSelectIndex]
local isDaoBing=itemsConfig.isDaoBing(showGBItemId)
local isGuBao=itemsConfig.isGubao(showGBItemId)

local scale=Vector3.New(0.6,0.6,0.6)
self.pickUpGBModel:setScale(Vector3.zero)
if isDaoBing then
local modelParams=itemsConfig.getConfig(showGBItemId).model
self.pickUpGBModel:setChildShowEffect(modelParams[1][1],true)
elseif isGuBao then
local gbId=gubaoLookup:good2GuBao(showGBItemId)
local itemCfg=itemsConfig.getConfig(gbId,ITEM_CONFIG_TYPE.eGuBao)
local pram=itemCfg.relevantPram.pram
local effectId=pram.effectid
self.pickUpGBModel:setChildShowEffect(effectId,true)
end

self:stopPickUpGBModelLoadTimer()
self.pickUpModelLoadTimer=self:delayDo(0.2,function()
if _this==nil then return end

_this.pickUpGBModel:setScale(scale)
end)
end

function UISubAct_AnniversarySignInWin:stopPickUpGBModelLoadTimer()
if self.pickUpModelLoadTimer then
self:stopTimerByID(self.pickUpModelLoadTimer)
self.pickUpModelLoadTimer=nil
end
end






function UISubAct_AnniversarySignInWin:onCloseBtn()
if self.activityArgs.parentWin then
UIManager:callWindowFunc(self.activityArgs.parentWin,"onBtnClose")
else
self:closeSelf()
end
end



function UISubAct_AnniversarySignInWin:onPickUpGBClick()

local pickUpShowGBList=self.pickUpShowGBList
local showGBItemId=pickUpShowGBList[self.showPickUpGbSelectIndex]
itemsComponentHelper.onItemClickEx(showGBItemId)
end



function UISubAct_AnniversarySignInWin:onPickUpShowLBtn()
local nowTime=timeHelper.getServerLongTime()
self.nextPickUpGBShowTime=nowTime+pickUpGBLoopTime
if self.showPickUpGbSelectIndex<=1 then
self.showPickUpGbSelectIndex=self.showPickUpGbMaxSelectIndex
else
self.showPickUpGbSelectIndex=self.showPickUpGbSelectIndex-1
end
self:refreshPickUpGBModel()
end



function UISubAct_AnniversarySignInWin:onPickUpShowRBtn()
local nowTime=timeHelper.getServerLongTime()
self.nextPickUpGBShowTime=nowTime+pickUpGBLoopTime
if self.showPickUpGbSelectIndex>=self.showPickUpGbMaxSelectIndex then
self.showPickUpGbSelectIndex=1
else
self.showPickUpGbSelectIndex=self.showPickUpGbSelectIndex+1
end
self:refreshPickUpGBModel()
end



function UISubAct_AnniversarySignInWin:onRepairBtn()
local conmuse=self.config.cost
local itemid=conmuse[1]
local count=conmuse[2]
local name=itemsConfig.getItemName(itemid)

local refresh=function(num)
return FMT.fmt("{0}{1}",count*num,name)
end
local left=self.info:getRepairSignMaxNum()
local showItem=self.config.rewards
local show_data={
type='UIDialougeBuyCountNoTip',
rewards=showItem,
title='补领奖励',
isRefreshRewards=true,
refreshcallback=refresh,
selectCntDesc="{0}天",
max=left,
tips='',
oktext='补领',
canceltext='取消',
tipContent='',
tipsPos=Vector2.New(152,-7),
okcallback=function(num)
local callback=function()
_this.info:reqRepairSignInReward(num)
end
moneySystem:useMoney(itemid,count*num,callback,WARNING_TYPE.eWarning)
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end



function UISubAct_AnniversarySignInWin:onActivationBtn()
self.info:saveActive()
self:clearPanel2()
self:refreshPanel1()
end
