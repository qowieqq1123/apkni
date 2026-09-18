







def_class("UISubAct_ShiLianMuBiao",UIWindowBase)









function UISubAct_ShiLianMuBiao:bindComponents()

self.bg=UIImage.get(self,0)
self.showRewardsBtnGot=UIButton.get(self,1)
self.showRewardsBtn=UIButton.get(self,2)
self.helpBtn=UIButton.get(self,3)
self.title=UIImage.get(self,4)
self.signScroller=UIObject.get(self,5)
self.reddot=UIObject.get(self,6)
self.fazeIcon=UIImage.get(self,7)
self.rankBtn=UIButton.get(self,8)
self.fazeIconBtn=UIButton.get(self,9)
self.challengeBtn=UIButton.get(self,10)
self.truceBtn=UIButton.get(self,11)
self.signInList=UIObject.get(self,12)
self.number_2=UIButton.get(self,13)
self.number_3=UIButton.get(self,14)
self.number_1=UIButton.get(self,15)
self.timeText=UIText.get(self,16)
self.selfRank=UIText.get(self,17)
self.progress=UIObject.get(self,18)
self.selfScoreValue=UIText.get(self,19)

self.showRewardsBtnGot:setButtonClick(function()self:onShowRewardsBtnGot()end)

self.showRewardsBtn:setButtonClick(function()self:onShowRewardsBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.fazeIconBtn:setButtonClick(function()self:onFazeIconBtn()end)

self.challengeBtn:setButtonClick(function()self:onChallengeBtn()end)

self.truceBtn:setButtonClick(function()self:onTruceBtn()end)

self.number_2:setButtonClick(function()self:onNumber_2()end)

self.number_3:setButtonClick(function()self:onNumber_3()end)

self.number_1:setButtonClick(function()self:onNumber_1()end)
self.number={
self.number_1,
self.number_2,
self.number_3,
}



end


function UISubAct_ShiLianMuBiao:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.showRewardsBtnGot);self.showRewardsBtnGot=nil;
_UIObject_release(self.showRewardsBtn);self.showRewardsBtn=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.signScroller);self.signScroller=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.fazeIcon);self.fazeIcon=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.fazeIconBtn);self.fazeIconBtn=nil;
_UIObject_release(self.challengeBtn);self.challengeBtn=nil;
_UIObject_release(self.truceBtn);self.truceBtn=nil;
_UIObject_release(self.signInList);self.signInList=nil;
_UIObject_release(self.number_2);self.number_2=nil;
_UIObject_release(self.number_3);self.number_3=nil;
_UIObject_release(self.number_1);self.number_1=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.selfRank);self.selfRank=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.selfScoreValue);self.selfScoreValue=nil;
self.number=nil;
end


















local ItemCompentIndex={
dayText=0,
gotFlag=1,
select=2,
click=3,
point=4,
trick=5,
bg=6,
item_1=7,
sign=8,
}
local item_index=
{
zmname=0,
playername=1,
floorcount=2,
model=3,
have=4,
nothave=5,
click=6,
}

function UISubAct_ShiLianMuBiao:onLoaded(...)
self:bindComponents()
end


function UISubAct_ShiLianMuBiao:__delete()
self:unbindComponents()
end




function UISubAct_ShiLianMuBiao:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id

self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)

self:refreshBg()

if not self.sub_actInfo:sendTop3Func(self.sub_actcfg.rank_type)then

self:refreshRankInfo()
end

self:freshInfo()

self:setRemainingTimeTimer()
end


function UISubAct_ShiLianMuBiao:onHide()
self.signScroller:setChildScrollRectEnable(false)
end

function UISubAct_ShiLianMuBiao:freshInfo()
self:refreshSignInList()
self:refreshDayBtn()

end

function UISubAct_ShiLianMuBiao:refreshMyData()
local myData=self.sub_actInfo:getMyScore(self.sub_actcfg.rank_type)
self.selfScoreValue:setText(FMT.fmt("我的通关：<color=#549327>{0}层</color>",myData))
local myRank=self.sub_actInfo:getRankData(self.sub_actcfg.rank_type).myrank or 0
self.selfRank:setText(FMT.fmt("我的排名：{0}",myRank==0 and"<color=#c82c2c>未上榜</color>"or myRank))
end

local bgAB="ui/windows/activities/sub_shilianmubiao/sharedtextures/image_shilianmubiao_bg"
local titleAB="ui/windows/activities/sub_shilianmubiao/shiliantarget_title_atlas_pak.ab"
function UISubAct_ShiLianMuBiao:refreshBg()
local style=self.sub_actcfg.style
self.bg:setCSImageSprite(FMT.fmt("{0}{1}.ab",bgAB,style.bg),FMT.fmt("image_shilianmubiao_bg{0}",style.bg))
self.title:setCSImageSprite(titleAB,FMT.fmt("image_shilianmubiao_title{0}",style.title))
end

function UISubAct_ShiLianMuBiao:refreshSignInList()

self.lockClick=nil
local progressIndex=0

local target_reward=self.sub_actcfg.target_reward

self.signScroller:setChildScrollRectEnable(true)

local c=#target_reward
self.signScroller:setChildScrollViewCreateGrids(c,c)
local jumpIdx=0
local grids=self.signScroller:getChildScrollViewItemWidgets()
for i=1,c do
local signInItem=grids[i-1]
local reward=target_reward[i]
if signInItem and reward then

local isSignIn=self.sub_actInfo:checkIndexGet(i)
if isSignIn then
progressIndex=i
end
local isGot=self.sub_actInfo:checkRecvIndexGot(i)






signInItem:SetChildActive(ItemCompentIndex.gotFlag,isGot)


signInItem:SetChildActive(ItemCompentIndex.point,isSignIn and not isGot)
signInItem:SetChildActive(ItemCompentIndex.trick,isGot)

if isSignIn and not isGot then
signInItem:SetChildAnimationStringID(8,"xianshu_light",true)
end

if isGot and i~=c then
jumpIdx=i
end


signInItem:SetChildGray(ItemCompentIndex.bg,isGot)

signInItem:SetChildText(ItemCompentIndex.dayText,FMT.fmt("{0}层",reward[1]))


local itemid=reward[2][1]
local count=reward[2][2]

local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end

local conf




conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG}


local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
signInItem:SetChildActive(ItemCompentIndex.item_1,true)
signInItem:SetChildPropData(ItemCompentIndex.item_1,prop)
signInItem:SetChildGray(ItemCompentIndex.item_1,isGot)
local rewardItem=signInItem:GetChildWidgetBase(ItemCompentIndex.item_1)
if isSignIn then

rewardItem:SetChildButtonClick(1,function()
self:onClickSignInItem(i)
end)
else

rewardItem:SetChildButtonClick(1,function()
self:onClickSignInRewardItem(itemid)
end)
end

rewardItem:SetChildLongTouch(1,i,0.5,function()
self:onClickSignInRewardItem(itemid)
end)

end
end


local progressPercent
if progressIndex<c then
progressPercent=progressIndex/c
else
progressPercent=1
end

self.progress:setChildIconFillAmount(progressPercent)


self.signScroller:setChildScrollViewSelectItem(jumpIdx-1,false,false,false)
end


function UISubAct_ShiLianMuBiao:onClickSignInItem(index)
if self.lockClick then return end
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actID,self.subType,self.subid,jsonHelper.encode({2}))
self.lockClick=true
end

function UISubAct_ShiLianMuBiao:onClickSignInRewardItem(itemid)

tipsManager.showTips({itemid=itemid,itemguid=nil,showModel=true})

end


function UISubAct_ShiLianMuBiao:setRemainingTimeTimer()
self:clearTimer()
local func
func=function()
self:refreshRemainingTimeTimer()
end

self.timer=self:setTimer(1,0,func)

self:refreshRemainingTimeTimer()
end


function UISubAct_ShiLianMuBiao:refreshRemainingTimeTimer()
local time=activitiesModel:getSubActEndLeftTime(self.actID,self.subType,self.subid)
if time>0 then

local time_str=FMT.fmt('活动剩余时间：{0}',timeHelper.format_time_stamp11(time,true))
self.timeText:setText(time_str)
else
self.timeText:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()
end
end



function UISubAct_ShiLianMuBiao:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UISubAct_ShiLianMuBiao:refreshRankInfo()

self:refreshMyData()
local data=self.sub_actInfo:getTop3Data(self.sub_actcfg.rank_type)or{}
self.top3RankList=data.ranlist or{}

local top3RankLen=#self.top3RankList
if not top3RankLen or top3RankLen<=0 then

for i=1,3 do
local widget=self.number[i]:getChildWidgetBase()
widget:SetChildActive(item_index.have,false)
widget:SetChildActive(item_index.nothave,true)
end
return
end

for i=1,3 do
local actorInfo=self.top3RankList[i]
local widget=self.number[i]:getChildWidgetBase()
widget:SetChildActive(item_index.have,actorInfo~=nil)
widget:SetChildActive(item_index.nothave,actorInfo==nil)
if actorInfo then
local headArgs={}
headArgs.iconInfo=actorInfo.iconInfo
headArgs.scale=0.75
playerController:setHeadIcon(widget,-1,headArgs)


widget:SetChildButtonClick(item_index.click,function()
self:onClickPlayer(actorInfo.actor_id)
end)

local zmName=actorInfo.sect_name
local playerName=actorInfo.actor_name
widget:SetChildText(item_index.zmname,zmName)
widget:SetChildText(item_index.playername,playerName)
local floorCount=actorInfo.layer or 0
local floorStr=FMT.fmt("{0}层",floorCount)
widget:SetChildText(item_index.floorcount,floorStr)


if tostring(actorInfo.discipledata)~='0'then
local imageInfo=UIDiscipleModel.calculationDiscipleImage(actorInfo.discipledata,actorInfo.discipleimage)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo)
widget:SetChildUIModelShowTarget(item_index.model,modelParams.body,0.9,modelParams.componets,eAnimationID.stand)
end
end
end


end


function UISubAct_ShiLianMuBiao:onClickPlayer(actorId)
local attach={
type=otherPlayerController.eAttachType.Rank,
rankType=eRankListType.eShiLianTa
}
otherPlayerController:openOtherPlayerInfoWin(actorId,true,nil,attach)
end

function UISubAct_ShiLianMuBiao:refreshDayBtn()
local dayIndex=self.sub_actInfo:getDayIndex()

self.showRewardsBtnGot:setActive(dayIndex>1)
self.showRewardsBtn:setActive(dayIndex<=1)
self.reddot:setActive(dayIndex==1 or(self.sub_actInfo:getDayReddot())or self.sub_actInfo:isClear(self.sub_actcfg.rank_type))
end





function UISubAct_ShiLianMuBiao:onDailyButton()
end



function UISubAct_ShiLianMuBiao:onCredentialsListBtn()
end



function UISubAct_ShiLianMuBiao:onRankBtn()
self:showWindow("UISubAct_ShiLianMuBiaoRankWin",{act_id=self.actID,sub_act_type=self.subType,sub_act_id=self.subid,sub_actcfg=self.sub_actcfg})
end



function UISubAct_ShiLianMuBiao:onFazeIconBtn()

end



function UISubAct_ShiLianMuBiao:onNumber_3()
end



function UISubAct_ShiLianMuBiao:onNumber_2()
end



function UISubAct_ShiLianMuBiao:onNumber_1()
end



function UISubAct_ShiLianMuBiao:onTruceBtn()
end



function UISubAct_ShiLianMuBiao:onChallengeBtn()
jumpManager:jump(self.sub_actcfg.jump)
end

function UISubAct_ShiLianMuBiao:showRewardTips()
self.sub_actInfo:setDayReddot(true)
self:refreshDayBtn()
local dayIndex=self.sub_actInfo:getDayIndex()
local day_reward=self.sub_actcfg.day_reward
local itemlist={}
for i,v in ipairs(day_reward)do
table.insert(itemlist,{itemid=v[1],itemcount=v[2]})
end
local show_data={
type='UIDialougeBuyWithReward2',
title='提示',
oktext='前往挑战',
itemlist=itemlist,
tip=FMT.fmt("活动期间，每日参加<color=#b3724c>{0}</color>，\n可获得以下奖励：",self.sub_actInfo:getName(self.sub_actcfg.rank_type)),
showclosebtn=true,
okcallback=function()
jumpManager:jump(self.sub_actcfg.jump)
end,
closecallback=nil,
canvasindex=5,
bgClick=true,
gotFlag=dayIndex>1,
}
if dayIndex>1 then
show_data.oktext=nil
end

local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end

function UISubAct_ShiLianMuBiao:onShowRewardsBtn()
local dayIndex=self.sub_actInfo:getDayIndex()
self.sub_actInfo:setDayReddot(true)
if dayIndex==1 or self.sub_actInfo:isClear(self.sub_actcfg.rank_type)then
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actID,self.subType,self.subid,jsonHelper.encode({1}))
else
self:showRewardTips()
end

end

function UISubAct_ShiLianMuBiao:onShowRewardsBtnGot()
self:showRewardTips()
end

function UISubAct_ShiLianMuBiao:onHelpBtn()
local d={}
d.title='【规则说明】'
d.mode=3
d.name='shiLianMuBiao_help_%d'
UIManager:showWindow('UIRuleWin',d)
end
