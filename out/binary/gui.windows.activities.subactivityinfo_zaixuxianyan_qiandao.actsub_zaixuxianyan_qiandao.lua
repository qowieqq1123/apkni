







def_class("ActSub_ZaiXuXianyan_QianDao",UIWindowBase)









function ActSub_ZaiXuXianyan_QianDao:bindComponents()

self.signInScroller=UIObject.get(self,0)
self.timeText=UIText.get(self,1)
self.model=UIObject.get(self,2)



end


function ActSub_ZaiXuXianyan_QianDao:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.signInScroller);self.signInScroller=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.model);self.model=nil;
end



















function ActSub_ZaiXuXianyan_QianDao:onLoaded(...)
self:bindComponents()
end


function ActSub_ZaiXuXianyan_QianDao:__delete()
self:unbindComponents()
self:clearTimer()
end
local signInItemIndex={
select=0,
dayText=1,
rewards=2,
makeUpBtn=3,
rewardBtn=4,
rewardBtnText=5,
gotFlag=6,
}



function ActSub_ZaiXuXianyan_QianDao:onShow(argtable,afterOnloaded)
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




self.beginTime=self.activityData.start_time-timeHelper.getServerStampPass(self.activityData.start_time)
self.rewards=self:jude_reward()
self.allDayCount=#self.rewards[2]

self.endTime=self.activityData.end_time
self.dayTimeList={}
for i=1,self.allDayCount do
self.dayTimeList[i]=self.beginTime+86400*(i-1)
end


self.model:setChildUIModelShowTarget(4021,1,{},eAnimationID.stand)


self:initTodayIndexAndFreshTime()

self:refresh()

end


function ActSub_ZaiXuXianyan_QianDao:onHide()
self:clearTimer()
end


function ActSub_ZaiXuXianyan_QianDao:jude_reward()
local openday=timeHelper.getServerOpenDay()
for i=#self.config.rewards,1,-1 do
if openday>=self.config.rewards[i][1]then
return self.config.rewards[i]
end
end
return self.config.rewards[1]

end

function ActSub_ZaiXuXianyan_QianDao:refresh()

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)




self:initSignInList()


self.needRefreshTimeItemList=nil

local signInCount=#self.sortSignInList
self.signInScroller:setChildScrollViewCreateGrids(0,0)
self.signInScroller:setChildScrollViewCreateGrids(signInCount,1)
local grids=self.signInScroller:getChildScrollViewItemWidgets()
for i=1,signInCount do
self:refreshSignInItem(grids[i-1],i)
end


self:setRemainingTimeTimer()
end


function ActSub_ZaiXuXianyan_QianDao:initTodayIndexAndFreshTime()

local nowTime=gameUtilityModel.getServerShortTime()
local deltaTime=nowTime-self.beginTime
self.todayIndex=math.ceil((deltaTime+1)/86400)
if self.todayIndex+1<=self.allDayCount then
self.nextFreshTime=self.dayTimeList[self.todayIndex+1]
else
self.nextFreshTime=self.endTime
end

end


function ActSub_ZaiXuXianyan_QianDao:initSignInList()
if not self.config or not next(self.config)then
return
end
if not self.signInList then
self.signInList={}
end
local list={}

for i=1,self.allDayCount do
local isGot
if self.activityData.data and self.activityData.data[1]then
isGot=bitHelper.check_pos(self.activityData.data[1],i-1)
end

local sortId=i
local weight=1000-sortId
if isGot then
weight=weight-10000
else
weight=weight+10000
end

self.signInList[i]={dayIndex=i,isGot=isGot,rewards=self.rewards[2][i],weight=weight}
list[i]={dayIndex=i,isGot=isGot,rewards=self.rewards[2][i],weight=weight}
end

table.sort(list,function(a,b)
return a.weight>b.weight
end)

self.sortSignInList=list
end




function ActSub_ZaiXuXianyan_QianDao:refreshSignInItem(item,index)
if item==nil then
item=self.signInScroller:getChildScrollViewItemWidget(index-1)
end

local day=self.sortSignInList[index].dayIndex
local signInData=self.sortSignInList[index]
if item and signInData then


local dayStr=FMT.fmt("第{0}天",day)
item:SetChildText(signInItemIndex.dayText,dayStr)



local isGot=signInData.isGot
local canGet=not isGot and day==self.todayIndex
local canMakeUp=not isGot and day<self.todayIndex
local notSignIn=not isGot and day>self.todayIndex


item:SetChildActive(signInItemIndex.select,isGot)


item:SetChildActive(signInItemIndex.rewardBtn,not isGot)

item:SetChildButtonEnable(signInItemIndex.rewardBtn,canGet or canMakeUp,not canGet and not canMakeUp)
local rewardBtnTextStr="领取"
if notSignIn then


if not self.needRefreshTimeItemList then
self.needRefreshTimeItemList={}
end
local refreshItem={item=item,index=index}
table.insert(self.needRefreshTimeItemList,refreshItem)
end
item:SetChildText(signInItemIndex.rewardBtnText,rewardBtnTextStr)


item:SetChildButtonClick(signInItemIndex.rewardBtn,function()
self:onClickRewardBtn(day)
end)
item:SetChildActive(signInItemIndex.gotFlag,isGot)


local rw=signInData.rewards


item:SetChildLayoutGroupCreateItems(signInItemIndex.rewards,#rw)
local grids=item:GetChildLayoutGroupGridList(signInItemIndex.rewards)
for i=1,#rw do
local widget=grids[i-1]
local reward=rw[i]
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local isGray=isGot
local graynum=isGray and 1 or 0
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,gray=graynum,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
end
end


function ActSub_ZaiXuXianyan_QianDao:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end


function ActSub_ZaiXuXianyan_QianDao:onClickRewardBtn(day)

if not self['checkEnd']or self:checkEnd()then
UIManager.error("限时签到活动已结束")
return
end


activitiesController:sendProtocol(actSendType.eComonReqHandle,self.activityId,self.subType,self.subId,jsonHelper.encode({0}))
end



function ActSub_ZaiXuXianyan_QianDao:onClickClose()
self:closeSelf()
end


function ActSub_ZaiXuXianyan_QianDao:setRemainingTimeTimer()
self:clearTimer()
local func
func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.endTime and self.endTime-nowTime or 0
if lerp>0 then

self.timeText:setText(FMT.fmt("活动时间：{0}",timeHelper.format_time_stamp11(lerp,true)))

lerp=self.nextFreshTime-nowTime
if lerp>0 then
if self.needRefreshTimeItemList and next(self.needRefreshTimeItemList)then
for i=1,#self.needRefreshTimeItemList do
local refreshTimeItem=self.needRefreshTimeItemList[i]
local item=refreshTimeItem.item
if item then
local day=self.sortSignInList[refreshTimeItem.index].dayIndex
lerp=self.dayTimeList[day]-nowTime

local timeStr=""
if lerp>=86400 then


local day=math.ceil(lerp/86400)
timeStr=FMT.fmt("{0}天后",day)
else
timeStr=timeHelper.format_time_stamp(lerp,true)
end
item:SetChildText(signInItemIndex.rewardBtnText,timeStr)
end
end
end
else

self:initTodayIndexAndFreshTime()

self:refresh()

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eGuiTuQianDao)
end
else
self.timeText:setText("活动已结束")

UIManager.error("限时签到活动已结束")
self:clearTimer()
end
end

self.timer=self:setTimer(1,0,func)

func()
end


function ActSub_ZaiXuXianyan_QianDao:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function ActSub_ZaiXuXianyan_QianDao:checkEnd()
local isEnd=false
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.endTime-nowTime
if lerp<=0 then
isEnd=true
end

return isEnd
end