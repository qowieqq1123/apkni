







def_class("UISubAct_suoyaoshilianWin",UIWindowBase)









function UISubAct_suoyaoshilianWin:bindComponents()

self.number_1=UIButton.get(self,0)
self.number_2=UIButton.get(self,1)
self.number_3=UIButton.get(self,2)
self.selfRankBg=UIImage.get(self,3)
self.selfRankText=UIText.get(self,4)
self.selfFloorCount=UIText.get(self,5)
self.selfName=UIText.get(self,6)
self.headIconCreater=UIObject.get(self,7)
self.showRewardsBtn=UIButton.get(self,8)
self.challengeBtn=UIButton.get(self,9)
self.timeText=UIText.get(self,10)
self.reddot=UIObject.get(self,11)
self.showRankBtn=UIButton.get(self,12)
self.root=UIObject.get(self,13)

self.number_1:setButtonClick(function()self:onNumber_1()end)

self.number_2:setButtonClick(function()self:onNumber_2()end)

self.number_3:setButtonClick(function()self:onNumber_3()end)

self.showRewardsBtn:setButtonClick(function()self:onShowRewardsBtn()end)

self.challengeBtn:setButtonClick(function()self:onChallengeBtn()end)

self.showRankBtn:setButtonClick(function()self:onShowRankBtn()end)
self.number={
self.number_1,
self.number_2,
self.number_3,
}



end


function UISubAct_suoyaoshilianWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.number_1);self.number_1=nil;
_UIObject_release(self.number_2);self.number_2=nil;
_UIObject_release(self.number_3);self.number_3=nil;
_UIObject_release(self.selfRankBg);self.selfRankBg=nil;
_UIObject_release(self.selfRankText);self.selfRankText=nil;
_UIObject_release(self.selfFloorCount);self.selfFloorCount=nil;
_UIObject_release(self.selfName);self.selfName=nil;
_UIObject_release(self.headIconCreater);self.headIconCreater=nil;
_UIObject_release(self.showRewardsBtn);self.showRewardsBtn=nil;
_UIObject_release(self.challengeBtn);self.challengeBtn=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.showRankBtn);self.showRankBtn=nil;
_UIObject_release(self.root);self.root=nil;
self.number=nil;
end



















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
local _this=nil

function UISubAct_suoyaoshilianWin:onLoaded(...)
_this=self
self:bindComponents()

notifySystem:listenNotify(notifyConfig.shilianta_change,self.shilianta_change)
end


function UISubAct_suoyaoshilianWin:__delete()
self:clearSubWindow()
self:clearTimer()
_this=nil
self:unbindComponents()

notifySystem:removelistener(notifyConfig.shilianta_change,self.shilianta_change)
end




function UISubAct_suoyaoshilianWin:onShow(argtable,afterOnloaded)
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


rankListController:req_rankList_data(eRankListType.eShiLianTa)

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.beginTime=self.activityData.start_time
self.endTime=self.activityData.end_time

self.rankMiniNumFloor=self.config.limit
self.maxRankCount=self.config.shilianMon[#self.config.shilianMon][2]
self.maxShowRankNum=self.config.showRankNum


self:changeRootHideState(true)


activitiesController:sendProtocol(actSendType.eComonReqInfo,self.activityId,self.subType,self.subId)

self:refresh()
end


function UISubAct_suoyaoshilianWin:onHide()
self:clearSubWindow()
self:clearTimer()
end

function UISubAct_suoyaoshilianWin:refresh()

self:refreshRankInfo()


self:refreshPlayerInfo()


local reddot=activitiesModel:checkSubActReddot(self.activityId,self.subType,self.subId)
self.reddot:setActive(reddot)


self:setRemainingTimeTimer()
end

function UISubAct_suoyaoshilianWin:refreshRankInfo()

local top3RankLen=self.activityData.data.top3RankListLen
self.top3RankList=self.activityData.data.top3RankList

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
self:onClickPlayer(actorInfo.playerId)
end)

local zmName=actorInfo.zmName
local playerName=actorInfo.name
widget:SetChildText(item_index.zmname,zmName)
widget:SetChildText(item_index.playername,playerName)
local floorCount=actorInfo.layer or 0
local floorStr=FMT.fmt("{0}层",floorCount)
widget:SetChildText(item_index.floorcount,floorStr)


if tostring(actorInfo.dzData)~='0'then
local imageInfo=UIDiscipleModel.calculationDiscipleImage(actorInfo.dzData,actorInfo.dzBody)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo)
widget:SetChildUIModelShowTarget(item_index.model,modelParams.body,0.9,modelParams.componets,eAnimationID.stand)
else

end
end
end

end

function UISubAct_suoyaoshilianWin:refreshPlayerInfo()

self.playerInfo=rankListModel:getPlayerInfo(eRankListType.eShiLianTa)

if not self.playerInfo or not next(self.playerInfo)then

return
end



local floor=self.playerInfo.data
local floorStr=FMT.fmt("层数：<color=#7d3b17>{0}层</color>",floor)
self.selfFloorCount:setText(floorStr)


local numStr="<color=#65615f>未上榜</color>"
if self.playerInfo.number>0 and self.playerInfo.number<=self.maxRankCount and floor>=self.rankMiniNumFloor then

numStr=self.playerInfo.number
end
self.selfRankText:setText(numStr)

local hasRankBg=false
if self.playerInfo.number>0 and self.playerInfo.number<=3 then
hasRankBg=true
end
self.selfRankBg:setActive(hasRankBg)
local frameName=rankListModel.getFrameName(self.playerInfo.number)
if frameName then
self.selfRankBg:setSprite(globalABLookup.rankList,frameName)
else
self.selfRankBg:setImageIcon("",false)
end

local headArgs={}
headArgs.iconInfo=self.playerInfo.head
headArgs.scale=0.75
local headWidget=self.headIconCreater:getWidgetBase()
playerController:setHeadIcon(headWidget,-1,headArgs)


self.selfName:setText(self.playerInfo.playerName)
end



function UISubAct_suoyaoshilianWin:onShowRewardsBtn()

self:showWindow('UISubAct_suoyaoshilian_rewardWin',{act_id=self.activityId,sub_act_type=self.subType,sub_act_id=self.subId})


self:changeRootHideState(false)
end

function UISubAct_suoyaoshilianWin:onChallengeBtn()

jumpManager:jump({type=0,id=JUMP_TYPE.eShiLianTa})
end

function UISubAct_suoyaoshilianWin:onShowRankBtn()

self:showWindow('UISubAct_suoyaoshilian_rewardWin',{act_id=self.activityId,sub_act_type=self.subType,sub_act_id=self.subId})


self:changeRootHideState(false)
end


function UISubAct_suoyaoshilianWin:setRemainingTimeTimer()
self:clearTimer()
local func
func=function()
self:refreshRemainingTimeTimer()
end

self.timer=self:setTimer(1,0,func)

self:refreshRemainingTimeTimer()
end


function UISubAct_suoyaoshilianWin:refreshRemainingTimeTimer()
local time=activitiesModel:getSubActEndLeftTime(self.activityId,self.subType,self.subId)
if time>0 then

local time_str=FMT.fmt('活动剩余时间：{0}',timeHelper.format_time_stamp11(time,true))
self.timeText:setText(time_str)
else
self.timeText:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()
end
end



function UISubAct_suoyaoshilianWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UISubAct_suoyaoshilianWin:changeRootHideState(isHide)
self.root:setActive(isHide)
end


function UISubAct_suoyaoshilianWin:clearSubWindow()
self:closeWindow('UISubAct_suoyaoshilian_rewardWin')
end


function UISubAct_suoyaoshilianWin:onClickPlayer(actorId)
local attach={
type=otherPlayerController.eAttachType.Rank,
rankType=eRankListType.eShiLianTa
}
otherPlayerController:openOtherPlayerInfoWin(actorId,true,nil,attach)
end

function UISubAct_suoyaoshilianWin.shilianta_change(oLayer,nLayer,isClearAll)
if oLayer~=nLayer then

activitiesController:sendProtocol(actSendType.eComonReqInfo,_this.activityId,_this.subType,_this.subId)
end
end