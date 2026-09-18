







def_class("UISubAct_ServerTaskWin",UIWindowBase)









function UISubAct_ServerTaskWin:bindComponents()

self.signScroller=UIObject.get(self,0)
self.signInItem_2=UIObject.get(self,1)
self.signInItem_3=UIObject.get(self,2)
self.signInItem_4=UIObject.get(self,3)
self.signInItem_5=UIObject.get(self,4)
self.signInItem_6=UIObject.get(self,5)
self.signInItem_7=UIObject.get(self,6)
self.taskTargetCount=UIText.get(self,7)
self.signInList=UIObject.get(self,8)
self.taskScroller=UIObject.get(self,9)
self.progress=UIObject.get(self,10)
self.signInItem_1=UIObject.get(self,11)
self.timeText=UIText.get(self,12)
self.signInItem={
self.signInItem_1,
self.signInItem_2,
self.signInItem_3,
self.signInItem_4,
self.signInItem_5,
self.signInItem_6,
self.signInItem_7,
}



end


function UISubAct_ServerTaskWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.signScroller);self.signScroller=nil;
_UIObject_release(self.signInItem_2);self.signInItem_2=nil;
_UIObject_release(self.signInItem_3);self.signInItem_3=nil;
_UIObject_release(self.signInItem_4);self.signInItem_4=nil;
_UIObject_release(self.signInItem_5);self.signInItem_5=nil;
_UIObject_release(self.signInItem_6);self.signInItem_6=nil;
_UIObject_release(self.signInItem_7);self.signInItem_7=nil;
_UIObject_release(self.taskTargetCount);self.taskTargetCount=nil;
_UIObject_release(self.signInList);self.signInList=nil;
_UIObject_release(self.taskScroller);self.taskScroller=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.signInItem_1);self.signInItem_1=nil;
_UIObject_release(self.timeText);self.timeText=nil;
self.signInItem=nil;
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
}

local taskItemIndex={
nBoxImg=0,
oBoxImg=1,
goBtn=2,
rewardBtn=3,
gotFlag=4,
rewards=5,
progressbar=6,
name=7,
}


function UISubAct_ServerTaskWin:onLoaded(...)
self:bindComponents()
self.signInItem={
self.signInItem_1,
self.signInItem_2,
self.signInItem_3,
self.signInItem_4,
self.signInItem_5,
self.signInItem_6,
self.signInItem_7,
}
end


function UISubAct_ServerTaskWin:__delete()
self:unbindComponents()
end




function UISubAct_ServerTaskWin:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eBigShengChanFullGoal
self.subid=argtable.sub_act_id
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
self.end_time=self.info.end_time
self:initConfig()
self:refresh()

self:setRemainingTimeTimer()
end


function UISubAct_ServerTaskWin:onHide()

end

function UISubAct_ServerTaskWin:initConfig()
self.jdRewards=self.config.jdRewards
self.allGoal=self.config.allGoal
self.jump=self.config.jump
end

function UISubAct_ServerTaskWin:refresh()
self.lockClick=false
self:refreshSignInList()
self:refreshTaskList()
end


function UISubAct_ServerTaskWin:setRemainingTimeTimer()
self:clearTimer()
local func
func=function()
self:refreshRemainingTimeTimer()
end

self.timer=self:setTimer(1,0,func)

self:refreshRemainingTimeTimer()
end


function UISubAct_ServerTaskWin:refreshRemainingTimeTimer()
local time=activitiesModel:getSubActEndLeftTime(self.actid,self.subType,self.subid)
if time>0 then

local time_str=FMT.fmt('活动剩余时间：{0}',timeHelper.format_time_stamp11(time,true))
self.timeText:setText(time_str)
else
self.timeText:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()
end
end



function UISubAct_ServerTaskWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UISubAct_ServerTaskWin:refreshSignInList()
local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
local jdReward=data and data.jdReward or 0
local finishNum=data and data.finishNum or 0
local progressIndex=0
self.taskTargetCount:setText(FMT.fmt("{0}/{1}",finishNum,self.jdRewards[#self.jdRewards][1]))
local c=#self.jdRewards
self.signScroller:setChildScrollViewCreateGrids(c,c)

local grids=self.signScroller:getChildScrollViewItemWidgets()
for i=1,c do
local signInItem=grids[i-1]
local reward=self.jdRewards[i]
if signInItem and reward then

local isSignIn=reward[1]<=finishNum
if isSignIn then
progressIndex=i
end

signInItem:SetChildActive(ItemCompentIndex.select,isSignIn)

local isGot=reward[1]<=jdReward

signInItem:SetChildActive(ItemCompentIndex.gotFlag,isGot)


signInItem:SetChildActive(ItemCompentIndex.point,isSignIn or isGot)
signInItem:SetChildActive(ItemCompentIndex.trick,isGot)


signInItem:SetChildImageExGray(ItemCompentIndex.bg,isGot)

signInItem:SetChildText(ItemCompentIndex.dayText,reward[1])


local itemid=reward[2]
local count=reward[3]

local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end

local conf
if isGot then

conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,gray=1}
else
conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG}
end

local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
signInItem:SetChildActive(ItemCompentIndex.item_1,true)
signInItem:SetChildPropData(ItemCompentIndex.item_1,prop)

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
if progressIndex<#self.jdRewards then
progressPercent=progressIndex/#self.jdRewards
else
progressPercent=1
end
self.progress:setChildIconFillAmount(progressPercent)

end


function UISubAct_ServerTaskWin:onClickSignInItem(index)
if self.lockClick then return end
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actid,self.subType,self.subid,jsonHelper.encode({2}))
self.lockClick=true
end

function UISubAct_ServerTaskWin:onClickSignInRewardItem(itemid)

tipsManager.showTips({itemid=itemid,itemguid=nil,showModel=true})

end

function UISubAct_ServerTaskWin:refreshTaskList()
self.taskList=taskModel:getSortDailyTaskData()
self:do_refreshTaskList()
end



function UISubAct_ServerTaskWin:do_refreshTaskList()

local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
local goalList=data and data.goalList or{}
self.goalList=goalList

local sortList={}
local groupType={}
for i,v in ipairs(self.allGoal)do
local gt=v[2]
local g=groupType[gt]
if g==nil then
g={}
groupType[gt]=g
end
local child=v
child.idx=i
g[#g+1]=child
end

for i,v in pairs(groupType)do
table.sort(v,function(a,b)return a.idx<b.idx end)
for j,vv in ipairs(v)do
local taskGoldData=self.goalList[vv.idx]
local isGot=taskGoldData and taskGoldData.rewardFlag==1

if not isGot or vv.lastIndex==1 then
local taskNum=vv[3]
local cur=taskGoldData and tonumber(tostring(taskGoldData.jdVal))or 0
if isGot then
vv.sortFlag=0
else
vv.sortFlag=(cur>=taskNum)and 2 or 1
end

table.insert(sortList,vv)
break
end
end
end

table.sort(sortList,function(a,b)
return a.sortFlag>b.sortFlag
end)

self.sortList=sortList
local c=#sortList
self.taskScroller:setChildScrollViewCreateGrids(c,1)

local grids=self.taskScroller:getChildScrollViewItemWidgets()
for i=1,c do
self:refreshTaskItem(grids[i-1],i)
end
end

function UISubAct_ServerTaskWin:getSendList()
local list={}
for i,taskData in ipairs(self.allGoal)do
local taskId=i
local taskGoldData=self.goalList[taskId]
local cur=taskGoldData and tonumber(tostring(taskGoldData.jdVal))or 0
local need=taskData[3]
local isCan=cur>=need
local isGot=taskGoldData and taskGoldData.rewardFlag==1
if not isGot and isCan then
table.insert(list,taskId)
end
end
return list
end

function UISubAct_ServerTaskWin:refreshTaskItem(item,index)
if item==nil then
item=self.taskScroller:getChildScrollViewItemWidget(index-1)
end

local taskData=self.sortList[index]
if not taskData then
return
end
local taskId=taskData.idx
local taskGoldData=self.goalList[taskId]
local jump=self.jump[taskId]
local taskTpye=taskData[1]
local taskItem=taskData[2]
local taskNum=taskData[3]

local config=cfgHelper.get(cfg_bigshengchanfullgoaltypeconfig_get,taskTpye)
if item then

local taskItemName=itemsConfig.getColorName(taskItem)
item:SetChildText(taskItemIndex.name,FMT.fmt(config.goalDesc,taskItemName,mathHelper.formatNumber(taskNum)))

local target=taskNum
local cur=taskGoldData and tonumber(tostring(taskGoldData.jdVal))or 0
local need=target



item:SetChildProgressValue(taskItemIndex.progressbar,(cur/need)*10000,10000)
item:SetChildProgressText(taskItemIndex.progressbar,FMT.fmt('{0}/{1}',mathHelper.formatNumber(cur),mathHelper.formatNumber(need)))


local isCan=cur>=need
local isGot=taskGoldData and taskGoldData.rewardFlag==1
local showGoBtn=jump~=nil
item:SetChildActive(taskItemIndex.goBtn,not isGot and not isCan and showGoBtn)
item:SetChildActive(taskItemIndex.rewardBtn,not isGot and isCan)
item:SetChildButtonClickWithID(taskItemIndex.goBtn,function(id)self:onClickGoBtn(id)end,taskId)
item:SetChildButtonClickWithID(taskItemIndex.rewardBtn,function(id)self:onClickRewardBtn(id)end,taskId)
item:SetChildActive(taskItemIndex.gotFlag,isGot)




local rewards=taskData[4]
item:SetChildLayoutGroupCreateItems(taskItemIndex.rewards,#rewards)
local grids=item:GetChildLayoutGroupGridList(taskItemIndex.rewards)
for i=1,#rewards do
local widget=grids[i-1]
local reward=rewards[i]
local itemid=reward[1]
local count=reward[2]
local graynum=isGot and 1 or 0
local conf={itemid=itemid,itemcount=count,showCountBG=true,gray=graynum,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickBaseItem(...)
end)
end

local conf={itemid=taskItem,itemcount="",showCountBG=false,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(taskItemIndex.oBoxImg,prop)
item:SetBaseItemClickEvent(taskItemIndex.oBoxImg,function(...)
self:onClickBaseItem(...)
end)
end
end

function UISubAct_ServerTaskWin:onClickGoBtn(taskId)

local jumpParam=self.config.jump[taskId]
if jumpParam then
local jumpType=jumpParam[1]
local jumpId=jumpParam[2]
local args=jumpParam[3]
local backFlag=nil
if jumpId==JUMP_TYPE.eShiLianTa then
backFlag=JUMP_BACK.eForceBack
elseif jumpId==JUMP_TYPE.eDouFaTai then
backFlag=JUMP_BACK.eNoBack
end
jumpManager:jump({type=jumpType,id=jumpId,args=args},nil,backFlag)
end
end

function UISubAct_ServerTaskWin:onClickBaseItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end
function UISubAct_ServerTaskWin:onClickRewardBtn(taskId)
if self.lockClick==true then return end
local list=self:getSendList()
if next(list)then
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actid,self.subType,self.subid,jsonHelper.encode({1,list}))
self.lockClick=true
end

end


