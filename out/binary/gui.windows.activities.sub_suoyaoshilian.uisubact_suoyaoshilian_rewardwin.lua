







def_class("UISubAct_suoyaoshilian_rewardWin",UIWindowBase)









function UISubAct_suoyaoshilian_rewardWin:bindComponents()

self.menuBtn_1=UIButton.get(self,0)
self.menuBtn_2=UIButton.get(self,1)
self.menuBtn_3=UIButton.get(self,2)
self.menuBtn_select_1=UIObject.get(self,3)
self.menuBtn_select_2=UIObject.get(self,4)
self.menuBtn_select_3=UIObject.get(self,5)
self.shilianRankPanel=UIObject.get(self,6)
self.shilianSelfPanel=UIObject.get(self,7)
self.shilianFullPanel=UIObject.get(self,8)
self.rankListScroller=UIObject.get(self,9)
self.shilianSelfListScroller=UIObject.get(self,10)
self.shilianFullListScroller=UIObject.get(self,11)
self.selfRankText=UIText.get(self,12)
self.tips=UIText.get(self,13)
self.menuBtn_reddot_2=UIImage.get(self,14)
self.menuBtn_reddot_3=UIImage.get(self,15)

self.menuBtn_1:setButtonClick(function()self:onMenuBtn_1()end)

self.menuBtn_2:setButtonClick(function()self:onMenuBtn_2()end)

self.menuBtn_3:setButtonClick(function()self:onMenuBtn_3()end)
self.menuBtn={
self.menuBtn_1,
self.menuBtn_2,
self.menuBtn_3,
}
self.menuBtn_select={
self.menuBtn_select_1,
self.menuBtn_select_2,
self.menuBtn_select_3,
}
self.menuBtn_reddot={
self.menuBtn_reddot_2,
self.menuBtn_reddot_3,
}



end


function UISubAct_suoyaoshilian_rewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.menuBtn_1);self.menuBtn_1=nil;
_UIObject_release(self.menuBtn_2);self.menuBtn_2=nil;
_UIObject_release(self.menuBtn_3);self.menuBtn_3=nil;
_UIObject_release(self.menuBtn_select_1);self.menuBtn_select_1=nil;
_UIObject_release(self.menuBtn_select_2);self.menuBtn_select_2=nil;
_UIObject_release(self.menuBtn_select_3);self.menuBtn_select_3=nil;
_UIObject_release(self.shilianRankPanel);self.shilianRankPanel=nil;
_UIObject_release(self.shilianSelfPanel);self.shilianSelfPanel=nil;
_UIObject_release(self.shilianFullPanel);self.shilianFullPanel=nil;
_UIObject_release(self.rankListScroller);self.rankListScroller=nil;
_UIObject_release(self.shilianSelfListScroller);self.shilianSelfListScroller=nil;
_UIObject_release(self.shilianFullListScroller);self.shilianFullListScroller=nil;
_UIObject_release(self.selfRankText);self.selfRankText=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.menuBtn_reddot_2);self.menuBtn_reddot_2=nil;
_UIObject_release(self.menuBtn_reddot_3);self.menuBtn_reddot_3=nil;
self.menuBtn=nil;
self.menuBtn_select=nil;
self.menuBtn_reddot=nil;
end

local _this=nil
local _MenuType={
eShilianRank=1,
eShilianSelf=2,
eShilianFull=3,
}

local _RefreshPanelFun={
[_MenuType.eShilianRank]=function()
_this:refreshShilianRankPanel()
end,
[_MenuType.eShilianSelf]=function()
_this:refreshShilianSelfPanel()
end,
[_MenuType.eShilianFull]=function()
_this:refreshShilianFullPanel()
end,
}

local rankItemIndex={
rankframe=0,
rankNo=1,
headIconCreater=2,
levelTx=3,
playerName=4,
floorCount=5,
headEmpty=6,
headBg=7,
rewards=8,
playerInfo=9,
notPlayer=10,
headList=11,
}

local taskItemIndex={
taskDesc=0,
rewards=1,
getRewardsBtn=2,
gotFlag=3,
unfinishFlag=4,
}

local headItemIndex={
headBg=0,
headIconCreater=1,
levelTx=2,
}
















function UISubAct_suoyaoshilian_rewardWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_suoyaoshilian_rewardWin:__delete()

UIManager:invokeUIMethod('UISubAct_suoyaoshilianWin','changeRootHideState',true)
self:unbindComponents()
_this=nil
end




function UISubAct_suoyaoshilian_rewardWin:onShow(argtable,afterOnloaded)
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
if argtable.selectMenuIndex then
self.selectMenuIndex=argtable.selectMenuIndex
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
self.rankMiniNumFloor=self.config.limit
self.maxRankCount=self.config.shilianMon[#self.config.shilianMon][2]
self.maxShowRankNum=self.config.showRankNum

if not self.selectMenuIndex then

self.selectMenuIndex=_MenuType.eShilianRank
end


self.playerInfo=rankListModel:getPlayerInfo(eRankListType.eShiLianTa)


activitiesController:sendProtocol(actSendType.eComonReqInfo,self.activityId,self.subType,self.subId)

self:refresh()
end


function UISubAct_suoyaoshilian_rewardWin:onHide()

UIManager:invokeUIMethod('UISubAct_suoyaoshilianWin','changeRootHideState',true)
end

function UISubAct_suoyaoshilian_rewardWin:refresh()

for i=1,#self.menuBtn do
self.menuBtn_select[i]:setActive(i==self.selectMenuIndex)
if i>1 then
local taskType=i-1
local reddot=self:getMenuReddot(taskType)
self.menuBtn_reddot[taskType]:setActive(reddot)
end
end


_RefreshPanelFun[self.selectMenuIndex]()
end


function UISubAct_suoyaoshilian_rewardWin:refreshShilianRankPanel()

self.shilianRankPanel:setActive(true)

self.shilianSelfPanel:setActive(false)
self.shilianFullPanel:setActive(false)

if not self.rankList or not next(self.rankList)then

self:initRankList()


local count=#self.rankList

self.rankListScroller:setChildScrollViewCreateGrids(0,0)
self.rankListScroller:setChildScrollViewCreateGrids(count,1)
local grids=self.rankListScroller:getChildScrollViewItemWidgets()
for i=1,count do
self:refreshRankItem(grids[i-1],i)
end
end


local numStr="未上榜"
if self.playerInfo.number>0 and self.playerInfo.number<=self.maxRankCount and self.playerInfo.data>=self.rankMiniNumFloor then

numStr=self.playerInfo.number
end
self.selfRankText:setText(FMT.fmt("我的排名：{0}",numStr))


self.tips:setText(FMT.fmt("通关锁妖塔{0}层才可参与排名",self.rankMiniNumFloor))
end


function UISubAct_suoyaoshilian_rewardWin:refreshShilianSelfPanel()

self.shilianSelfPanel:setActive(true)

self.shilianRankPanel:setActive(false)
self.shilianFullPanel:setActive(false)


self:SortShiLianSelfTaskList()


local count=#self.sortShiLianSelfTaskList
self.shilianSelfListScroller:setChildScrollViewCreateGrids(count,1)
local grids=self.shilianSelfListScroller:getChildScrollViewItemWidgets()
local taskType=1
for i=1,count do
self:refreshTaskItem(grids[i-1],i,taskType)
end
end


function UISubAct_suoyaoshilian_rewardWin:refreshShilianFullPanel()

self.shilianFullPanel:setActive(true)

self.shilianSelfPanel:setActive(false)
self.shilianRankPanel:setActive(false)


self:SortShiLianFullTaskList()


local count=#self.sortShiLianFullTaskList
self.shilianFullListScroller:setChildScrollViewCreateGrids(count,1)
local grids=self.shilianFullListScroller:getChildScrollViewItemWidgets()
local taskType=2
for i=1,count do
self:refreshTaskItem(grids[i-1],i,taskType)
end
end


function UISubAct_suoyaoshilian_rewardWin:selectMenuPanel(selectIndex)
self.selectMenuIndex=selectIndex


self:refresh()
end

function UISubAct_suoyaoshilian_rewardWin:initRankList()
local originalRankList=rankListModel:getRankList(eRankListType.eShiLianTa)
local rangeCount=#self.config.shilianMon
self.showRankRangeStartIndex=nil
for i=1,rangeCount do
local range_s=self.config.shilianMon[i][1]
local range_e=self.config.shilianMon[i][2]
local num=self.maxShowRankNum+1
if num>=range_s and num<=range_e then
self.showRankRangeStartIndex=i
break
end
end

local count=self.maxShowRankNum

if self.showRankRangeStartIndex then

local leftoverRangeNum=rangeCount-self.showRankRangeStartIndex+1
count=count+leftoverRangeNum
end

self.rankList={}

for i=1,count do
if i<=self.maxShowRankNum then

local rankInfo=originalRankList[i]
if rankInfo then

local floor=rankInfo.data[1]
if floor>=self.rankMiniNumFloor then
self.rankList[#self.rankList+1]=rankInfo
else

self.rankList[#self.rankList+1]={isShowByRange=false,isNullRank=true}
end
else

self.rankList[#self.rankList+1]={isShowByRange=false,isNullRank=true}
end
else

local rangeIndex=i-self.maxShowRankNum+self.showRankRangeStartIndex-1
local range_s=self.config.shilianMon[rangeIndex][1]
if range_s<i then

range_s=i
end
local showRangeInfoList={}
local showCount=3
for i=1,showCount do
local rankIndex=range_s+i-1
local rankInfo=originalRankList[rankIndex]
if rankInfo then
local floor=rankInfo.data[1]
if floor>=self.rankMiniNumFloor then

table.insert(showRangeInfoList,rankInfo)
end
end
end

self.rankList[#self.rankList+1]={isShowByRange=true,rangeIndex=rangeIndex,showRangeInfoList=showRangeInfoList}
end


end
end


function UISubAct_suoyaoshilian_rewardWin:SortShiLianSelfTaskList()
if not self.activityData.data.shilianSelfCfg or not next(self.activityData.data.shilianSelfCfg)then
return
end

if not self.sortShiLianSelfTaskList then
self.sortShiLianSelfTaskList={}
end

local list={}
for i=1,#self.activityData.data.shilianSelfCfg do
local isFinish=false
local isGot=false
local taskData=self.activityData.data.shilianSelfCfg[i]
isFinish=self.playerInfo.data>=taskData.clearFloor
if self.activityData.data.shilianInfo_self and self.activityData.data.shilianInfo_self[taskData.clearFloor]then
isGot=true
end

local sortId=i
local weight=1000-sortId
if isFinish then
if isGot then
weight=weight-10000
else
weight=weight+10000
end
end

list[i]={taskData=taskData,weight=weight}
end

table.sort(list,function(a,b)
return a.weight>b.weight
end)

self.sortShiLianSelfTaskList=list
end


function UISubAct_suoyaoshilian_rewardWin:SortShiLianFullTaskList()
if not self.activityData.data.shilianFullCfg or not next(self.activityData.data.shilianFullCfg)then
return
end

if not self.sortShiLianFullTaskList then
self.sortShiLianFullTaskList={}
end
local list={}
for i=1,#self.activityData.data.shilianFullCfg do
local isFinish=false
local isGot=false
local taskData=self.activityData.data.shilianFullCfg[i]

local finishCount=0
local gotMaxTargetCount=self.activityData.data.shilianInfo_full and self.activityData.data.shilianInfo_full[taskData.clearFloor].gotMaxTargetCount or 0
local nextTargetIndex=taskData.targetIndexLookup[gotMaxTargetCount]and taskData.targetIndexLookup[gotMaxTargetCount]+1 or 1
if nextTargetIndex>#taskData.targetList then
nextTargetIndex=#taskData.targetList
end
local needCount=taskData.targetList[nextTargetIndex].needPlayerCount
if self.activityData.data.shilianInfo_full and self.activityData.data.shilianInfo_full[taskData.clearFloor]then
finishCount=self.activityData.data.shilianInfo_full[taskData.clearFloor].clearCount
isGot=gotMaxTargetCount>=needCount
end
if finishCount>needCount then
finishCount=needCount
end

isFinish=finishCount>=needCount

local sortId=i
local weight=1000-sortId
if isFinish then
if isGot then
weight=weight-10000
else
weight=weight+10000
end
end

list[i]={taskData=taskData,weight=weight}
end

table.sort(list,function(a,b)
return a.weight>b.weight
end)

self.sortShiLianFullTaskList=list
end


function UISubAct_suoyaoshilian_rewardWin:refreshRankItem(item,index)
if item==nil then
item=self.rankListScroller:getChildScrollViewItemWidget(index-1)
end

local rankData=self.rankList[index]
if item then
local isShowByRange=false

if rankData then
if not rankData.isShowByRange then

if not rankData.isNullRank then

item:SetChildActive(rankItemIndex.playerInfo,true)

item:SetChildActive(rankItemIndex.notPlayer,false)


local headArgs={}
headArgs.iconInfo=rankData.head
headArgs.scale=0.75
playerController:setHeadIcon(item,-1,headArgs)
item:SetChildButtonClickWithID(rankItemIndex.headBg,function(index)
self:onClickHead(index)
end,index)

item:SetChildText(rankItemIndex.levelTx,rankData.zmLevel)
item:SetChildText(rankItemIndex.playerName,rankData.playerName)

local floorCount=rankData.data[1]
local floorStr=FMT.fmt("{0}层",floorCount)
item:SetChildText(rankItemIndex.floorCount,floorStr)
else

item:SetChildActive(rankItemIndex.playerInfo,false)

item:SetChildActive(rankItemIndex.notPlayer,true)
end

item:SetChildActive(rankItemIndex.headList,false)
else

isShowByRange=true

item:SetChildActive(rankItemIndex.playerInfo,false)
local showRangeInfoList=rankData.showRangeInfoList
if showRangeInfoList and next(showRangeInfoList)then

item:SetChildActive(rankItemIndex.notPlayer,false)
local showCount=#showRangeInfoList
item:SetChildLayoutGroupCreateItems(rankItemIndex.headList,showCount)
local grids=item:GetChildLayoutGroupGridList(rankItemIndex.headList)
for i=1,grids.Count do
local widget=grids[i-1]
local rankInfo=showRangeInfoList[i]
if rankInfo then
local actorId=rankInfo.actorId
local headArgs={}
headArgs.iconInfo=rankInfo.head
headArgs.scale=0.75
widget:SetChildActive(-1,true)
widget:SetChildButtonClick(headItemIndex.headBg,function(...)
self:onClickHeadByActorId(actorId)
end)
playerController:setHeadIcon(widget,-1,headArgs)
widget:SetChildText(headItemIndex.levelTx,rankInfo.zmLevel)
else
widget:SetChildActive(-1,false)
end
end


item:SetChildActive(rankItemIndex.headList,true)
else

item:SetChildActive(rankItemIndex.notPlayer,true)

item:SetChildActive(rankItemIndex.headList,false)
end

end
else
logErr(FMT.fmt("找不到index: {0} 对应的排名信息",index))
end






local frameName=rankListModel.getFrameName(index)
if frameName then
item:SetChildCSImageSprite(rankItemIndex.rankframe,globalABLookup.rankList,frameName)
else
item:SetChildIcon(rankItemIndex.rankframe,"",false)
end


local rankNum=0
if not isShowByRange then

rankNum=index
item:SetChildText(rankItemIndex.rankNo,rankNum)
else

local range_s=self.config.shilianMon[rankData.rangeIndex][1]
if range_s<index then

range_s=index
end

local range_e=self.config.shilianMon[rankData.rangeIndex][2]

local rankStr=FMT.fmt("{0}~{1}",range_s,range_e)
item:SetChildText(rankItemIndex.rankNo,rankStr)
rankNum=range_s
end




local rewards=self.activityData.data.rankRewardsCfg_lookup[rankNum]
item:SetChildLayoutGroupCreateItems(rankItemIndex.rewards,#rewards)
local grids=item:GetChildLayoutGroupGridList(rankItemIndex.rewards)
for i=1,#rewards do
local widget=grids[i-1]
local reward=rewards[i]
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

widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
end
end




function UISubAct_suoyaoshilian_rewardWin:refreshTaskItem(item,index,taskType)
if item==nil then
if taskType==1 then
item=self.shilianSelfListScroller:getChildScrollViewItemWidget(index-1)
elseif taskType==2 then
item=self.shilianFullListScroller:getChildScrollViewItemWidget(index-1)
end
end

local taskData=nil
if taskType==1 then
taskData=self.sortShiLianSelfTaskList[index].taskData
elseif taskType==2 then
taskData=self.sortShiLianFullTaskList[index].taskData
end

if item and taskData then
local isFinish=false
local isGot=false
local rewards={}
local exParam={}
if taskType==1 then

isFinish=self.playerInfo.data>=taskData.clearFloor
if self.activityData.data.shilianInfo_self and self.activityData.data.shilianInfo_self[taskData.clearFloor]then
isGot=true
end


local taskDescStr=FMT.fmt("锁妖塔通关{0}层",taskData.clearFloor)
item:SetChildText(taskItemIndex.taskDesc,taskDescStr)
rewards=taskData.rewards
elseif taskType==2 then

local finishCount=0
local gotMaxTargetCount=self.activityData.data.shilianInfo_full and self.activityData.data.shilianInfo_full[taskData.clearFloor].gotMaxTargetCount or 0
local nextTargetIndex=taskData.targetIndexLookup[gotMaxTargetCount]and taskData.targetIndexLookup[gotMaxTargetCount]+1 or 1
if nextTargetIndex>#taskData.targetList then
nextTargetIndex=#taskData.targetList
end
local needCount=taskData.targetList[nextTargetIndex].needPlayerCount
if self.activityData.data.shilianInfo_full and self.activityData.data.shilianInfo_full[taskData.clearFloor]then
finishCount=self.activityData.data.shilianInfo_full[taskData.clearFloor].clearCount
isGot=gotMaxTargetCount>=needCount
end
if finishCount>needCount then
finishCount=needCount
end

isFinish=finishCount>=needCount
rewards=taskData.targetList[nextTargetIndex].rewards
exParam.renshu=needCount


local taskDescStr=FMT.fmt("全服累计{0}人通关{1}层 <color=#ca631d>({2}/{0})</color>",needCount,taskData.clearFloor,finishCount)
item:SetChildText(taskItemIndex.taskDesc,taskDescStr)
end


item:SetChildLayoutGroupCreateItems(taskItemIndex.rewards,#rewards)
local grids=item:GetChildLayoutGroupGridList(taskItemIndex.rewards)
for i=1,#rewards do
local widget=grids[i-1]
local reward=rewards[i]
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

widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end


item:SetChildActive(taskItemIndex.getRewardsBtn,isFinish and not isGot)
item:SetChildButtonClick(taskItemIndex.getRewardsBtn,function()
self:onClickGetRewardBtn(taskType,taskData.clearFloor,exParam)
end)


item:SetChildActive(taskItemIndex.gotFlag,isGot)


item:SetChildActive(taskItemIndex.unfinishFlag,not isFinish)

end
end



function UISubAct_suoyaoshilian_rewardWin:onMenuBtn_1()

self:selectMenuPanel(_MenuType.eShilianRank)
end

function UISubAct_suoyaoshilian_rewardWin:onMenuBtn_2()

self:selectMenuPanel(_MenuType.eShilianSelf)
end

function UISubAct_suoyaoshilian_rewardWin:onMenuBtn_3()

self:selectMenuPanel(_MenuType.eShilianFull)
end


function UISubAct_suoyaoshilian_rewardWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end


function UISubAct_suoyaoshilian_rewardWin:onClickGetRewardBtn(taskType,floor,exParam)

if taskType==2 then
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.activityId,self.subType,self.subId,jsonHelper.encode({taskType,floor,exParam.renshu}))
else
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.activityId,self.subType,self.subId,jsonHelper.encode({taskType,floor}))
end
end


function UISubAct_suoyaoshilian_rewardWin:onClickHead(index)
local rankData=self.rankList[index]

if rankData and rankData.actorId then
local attach={
type=otherPlayerController.eAttachType.Rank,
rankType=eRankListType.eShiLianTa
}
otherPlayerController:openOtherPlayerInfoWin(rankData.actorId,true,nil,attach)
end
end

function UISubAct_suoyaoshilian_rewardWin:onClickHeadByActorId(actorId)
if actorId then
local attach={
type=otherPlayerController.eAttachType.Rank,
rankType=eRankListType.eShiLianTa
}
otherPlayerController:openOtherPlayerInfoWin(actorId,true,nil,attach)
end
end




function UISubAct_suoyaoshilian_rewardWin:getMenuReddot(taskType)
local reddot=false
if taskType==1 then

local shilianCfgLen_self=#self.activityData.data.shilianSelfCfg
for i=1,shilianCfgLen_self do
local cfg=self.activityData.data.shilianSelfCfg[i]
local floor=cfg.clearFloor
local isGot=self.activityData.data.shilianInfo_self and self.activityData.data.shilianInfo_self[floor]or false
if not isGot then
local isFinish=self.playerInfo.data>=floor
if isFinish then
reddot=true
return reddot
end
end
end
elseif taskType==2 then

local shilianCfgLen_full=#self.activityData.data.shilianFullCfg
for i=1,shilianCfgLen_full do
local cfg=self.activityData.data.shilianFullCfg[i]
local floor=cfg.clearFloor
local maxTargetCount=cfg.maxTargetCount
local gotMaxTargetCount=self.activityData.data.shilianInfo_full and self.activityData.data.shilianInfo_full[floor].gotMaxTargetCount or 0
local isGot=gotMaxTargetCount>=maxTargetCount or false
if not isGot then
local nextTargetIndex=cfg.targetIndexLookup[gotMaxTargetCount]and cfg.targetIndexLookup[gotMaxTargetCount]+1 or 1
local needCount=cfg.targetList[nextTargetIndex].needPlayerCount
local isFinish=self.activityData.data.shilianInfo_full[floor].clearCount>=needCount
if isFinish then
reddot=true
return reddot
end
end
end
end

return reddot
end