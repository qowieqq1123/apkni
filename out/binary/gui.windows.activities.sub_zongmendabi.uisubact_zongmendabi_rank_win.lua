







def_class("UISubAct_zongmendabi_rank_win",UIWindowBase)









function UISubAct_zongmendabi_rank_win:bindComponents()

self.menuGridPanel=UIObject.get(self,0)
self.noItemTips=UIText.get(self,1)
self.rankItem=UIObject.get(self,2)
self.rankScrollView=UILoopListView.new(self,3)
self.rankTips=UIText.get(self,4)
self.timeText=UIText.get(self,5)
self.titleTxt=UIText.get(self,6)

self.rankScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UISubAct_zongmendabi_rank_win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.menuGridPanel);self.menuGridPanel=nil;
_UIObject_release(self.noItemTips);self.noItemTips=nil;
_UIObject_release(self.rankItem);self.rankItem=nil;
self.rankScrollView:deleteSelf();self.rankScrollView=nil;
_UIObject_release(self.rankTips);self.rankTips=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
end



















local rankItemCmp={
rank=0,
name=1,
moneyIcon=2,
moneyNum=3,
rewardGrid=4,
tips=5,
rankIcon=6,
headBg=7,
playerInfo=8,
notPlayerInfo=9,
}

local _this=nil
local menu_slot_name='button_dytab'
local rankScrollViewHeight={412,509}


function UISubAct_zongmendabi_rank_win:onLoaded(...)
_this=self
self:bindComponents()
end


function UISubAct_zongmendabi_rank_win:__delete()
self:clearTimer()
self:unbindComponents()
_this=nil
end




function UISubAct_zongmendabi_rank_win:onShow(argtable,afterOnloaded)
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

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.beginTime=self.activityData.start_time
self.endTime=self.activityData.end_time

if not self.selectMenuIndex then
self.selectMenuIndex=1

local selfZoneType=self.activityData.data.zone_type
for index,zoneType in pairs(self.config.ranklist)do
if zoneType==selfZoneType then
self.selectMenuIndex=index
break
end
end
end

self.rankListInit={}
self.selfActorId=playerModel:getActorID()
self.selfRankData={}


activitiesController:sendProtocol(actSendType.eComonReqHandle,self.activityId,self.subType,self.subId,jsonHelper.encode({7}))

self:refresh(true)
end
end


function UISubAct_zongmendabi_rank_win:onHide()
self:clearTimer()
end

function UISubAct_zongmendabi_rank_win:refresh(isInit)
if isInit then
local raceList=self.config.ranklist
local cnt=#raceList
self.menuGridPanel:setChildLayoutGroupCreateItems(cnt)
local grids=self.menuGridPanel:getChildLayoutGroupGridList()
for i=1,cnt do
local item=grids[i-1]
local reaceName=activitiesHandle_zongmendabi.getRaceLevelName(self.subId,raceList[i])
item:SetChildText(1,reaceName)
local isSelected=i==self.selectMenuIndex
local func=function()
if _this==nil then return end
if isSelected then

item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,isSelected and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end
end
item:SetChildUIModelShowTarget(2,2017,1,{},eAnimationID.common_window_enter,false,false,0,func)
self:refreshMenuItemSelect(item,i,i==self.selectMenuIndex)
item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMenuItemClick(i)
end)
end


self:setRemainingTimeTimer()
end

self:refreshRankPanel()
end


function UISubAct_zongmendabi_rank_win:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end

if flag then
item:SetChildModelAnimationState(2,eAnimationID.common_window_dianji)
end

item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,flag and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end

function UISubAct_zongmendabi_rank_win:changeMenuPage(menuIndex)





self:refreshRankPanel()
end


function UISubAct_zongmendabi_rank_win:refreshRankPanel(refreshTypeIndex)
if refreshTypeIndex and refreshTypeIndex~=self.selectMenuIndex then

return
end

local reaceName=activitiesHandle_zongmendabi.getRaceLevelName(self.subId,self.selectMenuIndex)
self.titleTxt:setText(FMT.fmt('{0}排行榜',reaceName))

local selectZoneType=self.config.ranklist[self.selectMenuIndex]
if not self.rankListInit[selectZoneType]then

activitiesController:sendProtocol(actSendType.eComonReqHandle,self.activityId,self.subType,self.subId,jsonHelper.encode({2,selectZoneType}))
self.rankListInit[selectZoneType]=true
end


if not self.headRewardList then
self.headRewardList={}
end
if not self.headRewardList[selectZoneType]then

self.headRewardList[selectZoneType]=self.activityData:getHeadReward(selectZoneType)
end

self.selfRankData={}
local maxShowRankNum=self.config.sports_rank_num

local selfRankZoneType=self.activityData.data.zone_type
local isShowSelfRank=selfRankZoneType==selectZoneType
local rankScrollViewNeedHeight=0
if isShowSelfRank then
rankScrollViewNeedHeight=rankScrollViewHeight[1]
else
rankScrollViewNeedHeight=rankScrollViewHeight[2]
end
local width=self.rankScrollView:getChildSizeDeltaX()
self.rankScrollView:setChildSizeDelta(width,rankScrollViewNeedHeight)

local createCount=maxShowRankNum
local createList={}
for i=1,createCount do createList[#createList+1]=i end
self.rankScrollView:initData('rankItem',createList)


self:refreshSelfRankItem()


local rankNeedLv=activitiesModel:getSubActivityConfig(SUB_ACTIVITY_TYPE.eSectCompetition,self.subId,'rank_zmlv')
local rankNeedLvName=activitiesHandle_zongmendabi.getZMLevelInfo(self.subId,rankNeedLv)
self.rankTips:setText(FMT.fmt("达到{0}才可参与排名",rankNeedLvName))
end

function UISubAct_zongmendabi_rank_win:onFreshAction(i,item)
if _this==nil then return end
local selectZoneType=self.config.ranklist[self.selectMenuIndex]
local rankList=self.activityData.data.rankList and self.activityData.data.rankList[selectZoneType]or nil
local data=rankList and rankList[i]or nil
if data then
if data.actor_id and mathHelper.compareInt64(self.selfActorId,data.actor_id)then
self.selfRankData=data
end


item:SetChildActive(rankItemCmp.playerInfo,true)

item:SetChildActive(rankItemCmp.notPlayerInfo,false)


local headArgs={}
headArgs.iconInfo=data.iconInfo
headArgs.scale=0.75
playerController:setHeadIcon(item,-1,headArgs)
item:SetChildButtonClickWithID(rankItemCmp.headBg,function(index)
self:onClickHead(index)
end,i)


local zmName=data.zm_name

local playerName=data.actor_name
item:SetChildText(rankItemCmp.name,FMT.fmt("<color=#ca631d>[{0}]</color>{1}",zmName,playerName))


local icon=moneyModel.getIconNameEx(eMoneyType.mtSectScore)
item:SetChildCSImageIcon(rankItemCmp.moneyIcon,icon,false)
local score=data.score
local lv,cur,max,isfull=activitiesHandle_zongmendabi.getZMLevelByScore(self.subId,score)
local scorelvname,scorelvIcon=activitiesHandle_zongmendabi.getZMLevelInfo(self.subId,lv)
item:SetChildText(rankItemCmp.moneyNum,FMT.fmt("{0}（{1}）",score,scorelvname))
else

item:SetChildActive(rankItemCmp.playerInfo,false)

item:SetChildActive(rankItemCmp.notPlayerInfo,true)
end


local isTop3=false
local frameName=rankListModel.getFrameName(i)
if frameName then
item:SetChildActive(rankItemCmp.rankIcon,true)
item:SetChildCSImageSprite(rankItemCmp.rankIcon,globalABLookup.rankList,frameName)
isTop3=true
else
item:SetChildIcon(rankItemCmp.rankIcon,"",false)
item:SetChildActive(rankItemCmp.rankIcon,false)
end

local rankNum=i
item:SetChildText(rankItemCmp.rank,rankNum)


local rankRewardCfgList=self.activityData.rankRewardList_lookup[rankNum]or{}
local rewardList=table.weakCopy(rankRewardCfgList)

local rewardSharePercent=self.activityData.rewardShareList_lookup[selectZoneType][rankNum]
if rewardSharePercent then
local itemId=self.config.rewardPoolShowItem or eMoneyType.mtLingYu
local rewardShareItem={itemId,rewardSharePercent,2}
table.insert(rewardList,1,rewardShareItem)
end
if isTop3 then

local headRewardItem=self.headRewardList[selectZoneType][rankNum]
if headRewardItem then
local itemId=headRewardItem.itemid
local itemCount=headRewardItem.itemcount
local reward={itemId,itemCount,1}
reward.itemguid=headRewardItem.itemguid
table.insert(rewardList,1,reward)
end
end

local rewardCount=0
if rewardList~=nil then
rewardCount=#rewardList
end
local showReward=rewardCount>0
item:SetChildActive(rankItemCmp.rewardGrid,showReward)
item:SetChildActive(rankItemCmp.tips,not showReward)
if showReward then
item:SetChildLayoutGroupCreateItems(rankItemCmp.rewardGrid,rewardCount)
local grids=item:GetChildLayoutGroupGridList(rankItemCmp.rewardGrid)
for i=1,rewardCount do
local rewardItem=grids[i-1]
local reward=rewardList[i]
local itemid=reward[1]
local itemnum=reward[2]
local itemguid=reward.itemguid
local isHeadRewardItem=rewardList[i][3]==1 or false
local isRewardShareItem=rewardList[i][3]==2 or false
local rewardRateArgs
local itemcount,showCountBG
if not isRewardShareItem then

if not isRewardShareItem and itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
else

itemcount=''
showCountBG=true
rewardRateArgs={
needShowRewardRate=true,
rateTitle=" · 奖池比例:",
rate=itemnum,
rewardTitle=" · 获得灵玉:",
allCount=self.activityData.data.item_pool_num,
}
end
if itemguid~=nil then
local itemData=self.activityData:findHeadReward(itemguid)
if itemData then
local watch=watchModel.getItem(itemguid)
if watch==nil then
watchModel.setItem(itemData)
end
end
end
local conf={itemid=itemid,itemcount=itemcount,itemguid=itemguid,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(rewardRateArgs,...)
end)

rewardItem:SetChildActive(2,isHeadRewardItem)


rewardItem:SetChildText(3,FMT.fmt("{0}%",itemnum))
rewardItem:SetChildActive(3,isRewardShareItem)
end
end
end

function UISubAct_zongmendabi_rank_win:onStartAction()

end

function UISubAct_zongmendabi_rank_win:refreshSelfRankItem()
local selfRankZoneType=self.activityData.data.zone_type
local selectZoneType=self.config.ranklist[self.selectMenuIndex]
local isShowSelfRank=selfRankZoneType==selectZoneType

if isShowSelfRank then
self.rankItem:setActive(true)
local hasSelfRankData=false
if self.selfRankData and next(self.selfRankData)then
hasSelfRankData=true
end

local numStr=""
local selfRankNum=hasSelfRankData and self.selfRankData.rank_id or nil
local selfScore=hasSelfRankData and self.selfRankData.score or nil
if not selfRankNum then

selfRankNum=self.activityData.data.my_rank~=0 and self.activityData.data.my_rank or nil
selfScore=self.activityData.data.score or 0
if selfRankNum and not activitiesHandle_zongmendabi.canInRank(self.subId,selfScore)then

selfRankNum=nil
end
end
local selfRankItem=self.rankItem:getWidgetBase()
local isTop3=false
if selfRankNum then
numStr=tostring(selfRankNum)

local frameName=rankListModel.getFrameName(selfRankNum)
if frameName then
selfRankItem:SetChildActive(rankItemCmp.rankIcon,true)
selfRankItem:SetChildCSImageSprite(rankItemCmp.rankIcon,globalABLookup.rankList,frameName)
isTop3=true
else
selfRankItem:SetChildIcon(rankItemCmp.rankIcon,"",false)
selfRankItem:SetChildActive(rankItemCmp.rankIcon,false)
end
else
numStr="未上榜"
selfRankItem:SetChildIcon(rankItemCmp.rankIcon,"",false)
selfRankItem:SetChildActive(rankItemCmp.rankIcon,false)
end

selfRankItem:SetChildText(rankItemCmp.rank,numStr)


if not self.isInitSelfHead then

local headArgs={}
headArgs.scale=0.75
playerController:setHeadIcon(selfRankItem,-1,headArgs)

self.isInitSelfHead=true
end


local zmName=UISettingModel:getZMName()

local playerName=playerModel:getActorName()
selfRankItem:SetChildText(rankItemCmp.name,FMT.fmt("<color=#ca631d>[{0}]</color>{1}",zmName,playerName))


local icon=moneyModel.getIconNameEx(eMoneyType.mtSectScore)
selfRankItem:SetChildCSImageIcon(rankItemCmp.moneyIcon,icon,false)
local score=selfScore
local lv,cur,max,isfull=activitiesHandle_zongmendabi.getZMLevelByScore(self.subId,score)
local scorelvname,scorelvIcon=activitiesHandle_zongmendabi.getZMLevelInfo(self.subId,lv)
selfRankItem:SetChildText(rankItemCmp.moneyNum,FMT.fmt("{0}（{1}）",score,scorelvname))


local rewardList={}
if selfRankNum then

local rankRewardCfgList=self.activityData.rankRewardList_lookup[selfRankNum]or{}
rewardList=table.weakCopy(rankRewardCfgList)

local rewardSharePercent=self.activityData.rewardShareList_lookup[selectZoneType][selfRankNum]
if rewardSharePercent then
local itemId=self.config.rewardPoolShowItem or eMoneyType.mtLingYu
local rewardShareItem={itemId,rewardSharePercent,2}
table.insert(rewardList,1,rewardShareItem)
end
if isTop3 then

local headRewardItem=self.headRewardList[selectZoneType][selfRankNum]
if headRewardItem then
local itemId=headRewardItem.itemid
local itemCount=headRewardItem.itemcount
local reward={itemId,itemCount,1}
reward.itemguid=headRewardItem.itemguid
table.insert(rewardList,1,reward)
end
end
end
local rewardCount=#rewardList
local showReward=rewardCount>0
selfRankItem:SetChildActive(rankItemCmp.rewardGrid,showReward)
selfRankItem:SetChildActive(rankItemCmp.tips,not showReward)
if showReward then
selfRankItem:SetChildLayoutGroupCreateItems(rankItemCmp.rewardGrid,rewardCount)
local grids=selfRankItem:GetChildLayoutGroupGridList(rankItemCmp.rewardGrid)
for i=1,rewardCount do
local rewardItem=grids[i-1]
local reward=rewardList[i]
local itemid=reward[1]
local itemnum=reward[2]
local itemguid=reward.itemguid
local isHeadRewardItem=rewardList[i][3]==1 or false
local isRewardShareItem=rewardList[i][3]==2 or false
local rewardRateArgs
local itemcount,showCountBG
if not isRewardShareItem then

if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
else

itemcount=''
showCountBG=true
rewardRateArgs={
rateTitle="奖池比例:",
rate=itemnum,
rewardTitle="获得灵玉:",
allCount=self.activityData.data.item_pool_num,
}
end
if itemguid~=nil then
local itemData=self.activityData:findHeadReward(itemguid)
if itemData then
local watch=watchModel.getItem(itemguid)
if watch==nil then
watchModel.setItem(itemData)
end
end
end
local conf={itemid=itemid,itemguid=itemguid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(rewardRateArgs,...)
end)

rewardItem:SetChildActive(2,isHeadRewardItem)


rewardItem:SetChildText(3,FMT.fmt("{0}%",itemnum))
rewardItem:SetChildActive(3,isRewardShareItem)
end
end
else
self.rankItem:setActive(false)
end
end


function UISubAct_zongmendabi_rank_win:refreshRemainingTimeTimer()
local time=activitiesModel:getSubActEndLeftTime(self.activityId,self.subType,self.subId)
if time>0 then

local time_str=FMT.fmt('奖励结算倒计时：<color=#171311>{0}</color>',timeHelper.format_time_stamp11(time,true))
self.timeText:setText(time_str)
else
self.timeText:setText("奖励已结算")
self:clearTimer()
end
end

function UISubAct_zongmendabi_rank_win:setRemainingTimeTimer(menuIndex)
self:clearTimer()
local func
func=function()
self:refreshRemainingTimeTimer()
end

self.timer=self:setTimer(1,0,func)

self:refreshRemainingTimeTimer()
end


function UISubAct_zongmendabi_rank_win:onMenuItemClick(menuIndex)
if menuIndex==self.selectMenuIndex then
return
end

local old=self.selectMenuIndex
self.selectMenuIndex=menuIndex
if old~=nil then
self:refreshMenuItemSelect(nil,old,false)
end
self:refreshMenuItemSelect(nil,menuIndex,true)
self:changeMenuPage(menuIndex)
end

function UISubAct_zongmendabi_rank_win:onClickItem(rewardRateArgs,itemId,index,guid,attach)
if guid then
local reward=self.activityData:findHeadReward(guid)
if reward then
local watch=watchModel.getItem(guid)
if watch==nil then
watchModel.setItem(reward)
end
end
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft,attach={rewardRateArgs=rewardRateArgs}})
end

function UISubAct_zongmendabi_rank_win:onClickHead(index)

local selectZoneType=self.config.ranklist[self.selectMenuIndex]
local rankList=self.activityData.data.rankList and self.activityData.data.rankList[selectZoneType]or nil
local data=rankList and rankList[index]or nil

if data then
if data.actor_id and mathHelper.compareInt64(self.selfActorId,data.actor_id)then

return
end


local args={serverid=data.server_id,actID=self.activityId,subType=self.subType,subid=self.subId}
local callback=function(teamDzList)
if _this==nil then return end
activitiesHandle_zongmendabi.showOtherPlayerRivalInfo(_this.subId,teamDzList)
end
otherPlayerModel:reqActorDefTeams(otherPlayerInfoType.eZongMenDaBiDef2,data.actor_id,args,callback,true)
end
end


function UISubAct_zongmendabi_rank_win:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


