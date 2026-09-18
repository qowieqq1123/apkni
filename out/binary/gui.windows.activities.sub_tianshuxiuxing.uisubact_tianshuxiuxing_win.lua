







def_class("UISubAct_tianshuxiuxing_win",UIWindowBase)









function UISubAct_tianshuxiuxing_win:bindComponents()

self.root=UIObject.get(self,0)
self.frameSp=UIObject.get(self,1)
self.targetScrollView=UIObject.get(self,2)
self.raceTimeTxt=UIText.get(self,3)
self.taskNumTxt=UIText.get(self,4)
self.rewardScrollView=UIObject.get(self,5)
self.rewardSignLeft=UIObject.get(self,6)
self.rewardSignRight=UIObject.get(self,7)
self.targetGrid=UIObject.get(self,8)



end


function UISubAct_tianshuxiuxing_win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.targetScrollView);self.targetScrollView=nil;
_UIObject_release(self.raceTimeTxt);self.raceTimeTxt=nil;
_UIObject_release(self.taskNumTxt);self.taskNumTxt=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.rewardSignLeft);self.rewardSignLeft=nil;
_UIObject_release(self.rewardSignRight);self.rewardSignRight=nil;
_UIObject_release(self.targetGrid);self.targetGrid=nil;
end
















local _this
local ab_name="ui/windows/activities/sub_tianshuxiuxing/tianshuxiuxing_atlas_pak.ab"

function UISubAct_tianshuxiuxing_win:onLoaded(...)
_this=self
self:bindComponents()
self.rewardScrollView:setChildScrollViewInit(1,true,nil,nil)
end


function UISubAct_tianshuxiuxing_win:__delete()
_this=nil
self:unbindComponents()
end


function UISubAct_tianshuxiuxing_win:onHide()

end




function UISubAct_tianshuxiuxing_win:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.parentWin=argtable.parentWin

self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)

if self.myTimer==nil then
self.myTimer=self:setTimer(1,0,function()
self:refreshActTime()
self:refreshRewardSign()
end)
end
self:refreshActTime()
self:refreshTargetsGrid()
self:initRewardPanel()

if afterOnloaded then
self.targetScrollView:setChildCanvasGroupAlpha(0)
self.frameSp:setChildUIModelShowTarget(4120,1,{},0,false,false,0,function()
if _this==nil then return end
_this.targetScrollView:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end
end

function UISubAct_tianshuxiuxing_win:refreshActTime()
local lerp=self.sub_actInfo:getEndLeftTime()
if lerp<0 then
lerp=0
end
local time_str=FMT.fmt('剩余时间：<color=#f7f7f7>{0}</color>',timeHelper.format_time_stamp3(lerp))
self.raceTimeTxt:setText(time_str)
end

function UISubAct_tianshuxiuxing_win:refreshRewardSign()
local showLeftSign=false
local showRightSign=false
if self.curRewardIndx~=nil then
local side=0
local grids=self.rewardScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local item=grids[i-1]
local pos=item:GetChildAnchoredPosition(-1)
if pos.y>340 then
if self.curRewardIndx==i then
if side==1 then
showRightSign=true
else
showLeftSign=true
end
break
end
else
side=1
end
end
end
self.rewardSignLeft:setActive(showLeftSign)
self.rewardSignRight:setActive(showRightSign)
end

function UISubAct_tianshuxiuxing_win:onJump2Reward()
self.rewardScrollView:setChildScrollViewSelectItem(self.curRewardIndx-1,false,false,true)
end

function UISubAct_tianshuxiuxing_win:refreshTaskFinishNum()
local num_str=tostring(self.finishNum)
self.taskNumTxt:setText(num_str)
end

function UISubAct_tianshuxiuxing_win:findTaskIndex(taskidx)
for i,task in ipairs(self.tasklist)do
if task.groupIndex==taskidx then
return i
end
end
return nil
end

function UISubAct_tianshuxiuxing_win:refreshTargetsGrid()
local tasklist={}
local finishNum=0
for i,taskData in pairsBySortKey(self.myData.taskLookup)do
local sortWeight
if activitiesHandle_tianshuxiuxing.checkTaskReward(taskData)then
sortWeight=30000
elseif activitiesHandle_tianshuxiuxing.checkTaskFinish(taskData)then
sortWeight=10000
else
sortWeight=20000
end
finishNum=finishNum+taskData.rewardIndex
sortWeight=sortWeight+taskData.sortid
taskData.sortWeight=sortWeight
table.insert(tasklist,taskData)
end
self.tasklist=tasklist
self.finishNum=finishNum
local c=#self.tasklist
if c>1 then
table.sort(self.tasklist,function(a,b)
return a.sortWeight>b.sortWeight
end)
end
self.targetGrid:setChildLayoutGroupCreateItems(c)
local grids=self.targetGrid:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
self:refreshTaskItem(item,i)

item:SetChildButtonClick(5,function()
if _this==nil then return end
_this:onTaskItemClick(i)
end)
item:SetChildButtonClick(6,function()
if _this==nil then return end
_this:onTaskItemClick(i)
end)
end
self:refreshTaskFinishNum()
end

function UISubAct_tianshuxiuxing_win:refreshTaskItem(item,idx)
if item==nil then
item=self.targetGrid:getChildLayoutGroupGridItem(idx-1)
end

local taskData=self.tasklist[idx]
local info=self.sub_actcfg.task[taskData.groupIndex]
local maxnum=taskData.aimnum
local curnum=taskData.task_progress
local maxnum_str=mathHelper.formatNumber2(maxnum)
local curnum_str=mathHelper.formatNumber2(curnum)
local hasReward=activitiesHandle_tianshuxiuxing.checkTaskReward(taskData)
local isFinish=activitiesHandle_tianshuxiuxing.checkTaskFinish(taskData)


local rewards=taskData.rewards
item:SetChildLayoutGroupCreateItems(1,#rewards)
local grids=item:GetChildLayoutGroupGridList(1)
for i=1,#rewards do
local rewardItem=grids[i-1]
local reward=rewards[i]
local itemid=reward[1]
local itemNum=reward[2]
local itemcount,showCountBG
if itemNum>1 then
itemcount=tostring(itemNum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(itemid)
end)
end

local desc_str=info[5]
if desc_str~=nil then
desc_str=FMT.fmt(desc_str,maxnum_str)
else
desc_str='待定'
end



item:SetChildText(2,desc_str)

local rate=curnum/maxnum
item:SetChildIconFillAmount(3,rate)
item:SetChildText(4,FMT.fmt('{0}/{1}',curnum_str,maxnum_str))

item:SetChildActive(7,isFinish)
item:SetChildActive(5,hasReward)
item:SetChildActive(6,not isFinish and not hasReward and info[6]~=nil)
end

function UISubAct_tianshuxiuxing_win:onClickItem(itemid)
tipsManager.showTips({itemid=itemid,itemguid=nil,move=TIPS_MOVE_POS.eRight})
end

function UISubAct_tianshuxiuxing_win:onTaskItemClick(idx)

local taskData=self.tasklist[idx]
local hasReward=activitiesHandle_tianshuxiuxing.checkTaskReward(taskData)

if hasReward then

local claimedTaskRewards={}
for _,data in ipairs(self.tasklist)do
local canClaimed=activitiesHandle_tianshuxiuxing.checkTaskReward(data)

local cfg=self.sub_actcfg.task[data.groupIndex]
local targetData=cfg[3]

local reward=0
local cur=data.curIndex
while cur<=#targetData do
local target=targetData[cur][1]
if data.task_progress>=target then
reward=reward+1
else
break
end
cur=cur+1
end
if canClaimed then
table.insert(claimedTaskRewards,{data.groupIndex,data.rewardIndex+reward})
end
end

local json_str=jsonHelper.encode({1,claimedTaskRewards})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actID,self.subType,self.subid,json_str)
else
local info=self.sub_actcfg.task[taskData.groupIndex]
if info[6]then
local jumpType=0
local jumpId=info[6].id
local args=info[6].args
jumpManager:jump({type=jumpType,id=jumpId,args=args})
end
end
end

function UISubAct_tianshuxiuxing_win:initRewardPanel()
self.curRewardIndx=nil
self.curFixIndex=nil
local target=self.sub_actcfg.target
local n=#target
self.rewardScrollView:setChildScrollViewCreateGrids(n,0)
local grids=self.rewardScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local item=grids[i-1]
self:refreshRewardItem(item,i)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickRewardItem(i)
end)
end
local jumpIndex=self.curRewardIndx
if jumpIndex==nil then
jumpIndex=self.curFixIndex
end
if jumpIndex then
if jumpIndex>4 then
jumpIndex=jumpIndex+3
end
self.rewardScrollView:setChildScrollViewSelectItem(jumpIndex-1,false,false,true)
end
end

function UISubAct_tianshuxiuxing_win:refreshRewardPanel()
self.curRewardIndx=nil
self.curFixIndex=nil
local grids=self.rewardScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local item=grids[i-1]
self:refreshRewardItem(item,i)
end
end

function UISubAct_tianshuxiuxing_win:refreshRewardItem(item,index)
if item==nil then
item=self.rewardScrollView:getChildScrollViewItemWidget(index-1)
end
local target=self.sub_actcfg.target
local total=self.finishNum
local targetidx=self.myData.targetidx

local d=target[index]
local num=d[1]
local reward=d[2][1]
local fix=total>=num
local rewardFlag=index<=targetidx


local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>0 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local isGray=fix and rewardFlag
local graynum=0
if isGray then
graynum=mathHelper.setbit(graynum,eGrayType.eGray-1)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,gray=graynum,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)

local num_str
if fix and not rewardFlag then
num_str=FMT.fmt('<color=#b13a0c>{0}</color>',num)
else
num_str=FMT.fmt('{0}',num)
end
item:SetChildText(3,num_str)

item:SetChildActive(2,fix and not rewardFlag)

item:SetChildActive(1,fix and rewardFlag)

if fix and rewardFlag then
item:SetChildCSImageSprite(4,ab_name,"image_tianshuxiuxingui_8")
else
item:SetChildCSImageSprite(4,ab_name,"image_tianshuxiuxingui_7")
end

if fix and not rewardFlag then
self.curRewardIndx=index
elseif fix then
self.curFixIndex=index
end
end

function UISubAct_tianshuxiuxing_win:onClickRewardItem(index)
local total=self.finishNum
local targetidx=self.myData.targetidx

local target=self.sub_actcfg.target
local d=target[index]
local num=d[1]
local reward=d[2][1]
local fix=total>=num
local rewardFlag=index<=targetidx

local itemid=reward[1]
if fix and not rewardFlag and self.curRewardIndx~=nil then
local json_str=jsonHelper.encode({2,self.curRewardIndx})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actID,self.subType,self.subid,json_str)
else
tipsManager.showTips({itemid=itemid,itemguid=nil,move=TIPS_MOVE_POS.eRight})
end
end

function UISubAct_tianshuxiuxing_win:recv_taskReward()

AudioManager.playAudio(503)

self:refreshTargetsGrid()
self:refreshRewardPanel()
end

function UISubAct_tianshuxiuxing_win:recv_tagReward()
self:refreshRewardPanel()
end

function UISubAct_tianshuxiuxing_win:recv_taskRefresh(taskidx)
local idx=self:findTaskIndex(taskidx)
if idx then
self:refreshTaskItem(nil,idx)
end
end
