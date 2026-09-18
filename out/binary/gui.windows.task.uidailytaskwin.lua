







def_class("UIDailyTaskWin",UIWindowBase)









function UIDailyTaskWin:bindComponents()

self.tqmodel=UIObject.get(self,0)
self.reddot=UIObject.get(self,1)
self.targetTaskTips=UIText.get(self,2)
self.taskTargetCount=UIText.get(self,3)
self.rewardList=UIObject.get(self,4)
self.rewardBtn=UIButton.get(self,5)
self.gotFlag=UIObject.get(self,6)
self.taskScroller=UIObject.get(self,7)
self.speakKuang=UIObject.get(self,8)
self.speakContent=UIText.get(self,9)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)



end


function UIDailyTaskWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tqmodel);self.tqmodel=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.targetTaskTips);self.targetTaskTips=nil;
_UIObject_release(self.taskTargetCount);self.taskTargetCount=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.gotFlag);self.gotFlag=nil;
_UIObject_release(self.taskScroller);self.taskScroller=nil;
_UIObject_release(self.speakKuang);self.speakKuang=nil;
_UIObject_release(self.speakContent);self.speakContent=nil;
end

















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
local _this=nil


function UIDailyTaskWin:onLoaded(...)
_this=self
self:bindComponents()
local _onClickRewardItem=function(...)
self:onClickRewardItem(...)
end
self.rewardList:setChildScrollViewInit(0.5,true,_onClickRewardItem,nil)

self.taskScroller:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIDailyTaskWin:__delete()
UIDailyTaskWin:stopTqModelSpeak()
_this=nil
self:unbindComponents()
end




function UIDailyTaskWin:onShow(argtable,afterOnloaded)
self:onShowArgRecv()
end


function UIDailyTaskWin:onHide()

end

function UIDailyTaskWin:onShowArgRecv()
local taskList=taskModel:getDailyTaskData()
if taskList==nil then
logErr('每日任务数据没有任务列表')
return
end
self:refreshTaskList()

self:refreshRewardList()
self:refreshLeftPanel()

self:refreshTQModel()
end

function UIDailyTaskWin:rec_getReward(taskId)
self.lockClick=false
self:refreshLeftPanel()

local oldRewardTaskIndex=self:getTaskIndex(taskId)
self:refreshTaskItem(nil,oldRewardTaskIndex)
local old=table.remove(self.taskList,oldRewardTaskIndex)
table.insert(self.taskList,old)
local curRewardTaskIndex=#self.taskList
local sIndex=oldRewardTaskIndex-1
local dIndex=curRewardTaskIndex-1






self.taskScroller:setChildScrollViewChangeItemList(sIndex,dIndex,true)
self.lockClick=true
local func=function()
self.lockClick=false
end
self:delayDo(0.3,func)
end

function UIDailyTaskWin:rec_getRewardEx()
self.lockClick=false
end





function UIDailyTaskWin:onRewardBtn()

local rewardIdx=taskModel:getDailyTaskTargetRewardIdx()
local targetReward=taskModel:GetDayTaskTargetReward(rewardIdx)
for i=1,#targetReward do
local itemData=targetReward[i]
if itemData then
local itemid=itemData[1]
local bagType=itemsConfig.getBagType(itemid)
if bagType then
if bagHelper.checkBagFull(bagType)then

return
end
end
end
end
taskController:req_daily_targetReward()
end

function UIDailyTaskWin:refreshLeftPanel()
local curFinishNum=taskModel:getDailyTaskTargetNum()
local rewardIdx=taskModel:getDailyTaskTargetRewardIdx()
local needNum=cfgHelper.get2(cfg_everydaytasktargetconfig_get,rewardIdx,'condition')
curFinishNum=curFinishNum>needNum and needNum or curFinishNum
self.taskTargetCount:setText(FMT.fmt('{0}/{1}',curFinishNum,needNum))
local isCan=curFinishNum>=needNum
local isGot=taskModel:checkDailyTaskTargetisGot()
local isReddot=not isGot and isCan
self.rewardBtn:setButtonEnable(isReddot,not isReddot)
self.reddot:setActive(isReddot)
self.rewardBtn:setActive(not isGot)
self.gotFlag:setActive(isGot)
self.targetTaskTips:setText(FMT.fmt('完成右侧{0}个任务即可领取',needNum))
end

function UIDailyTaskWin:refreshRewardList()
local rewardIdx=taskModel:getDailyTaskTargetRewardIdx()
local targetReward=taskModel:GetDayTaskTargetReward(rewardIdx)
self.rewardList:setChildScrollViewCreateGrids(#targetReward,3)

local grids=self.rewardList:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local itemData=targetReward[i]
if item and itemData then
local itemid=itemData[1]
local count=itemData[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(-1,prop)
end
end
end

function UIDailyTaskWin:onClickRewardItem(clickCount,index)

local rewardIdx=taskModel:getDailyTaskTargetRewardIdx()
local targetReward=taskModel:GetDayTaskTargetReward(rewardIdx)
local itemData=targetReward[index+1]
local itemid=itemData[1]
tipsManager.showTips({itemid=itemid,itemguid=nil})
end


function UIDailyTaskWin:testPlay(sIndex,dIndex)

self.taskScroller:setChildScrollViewChangeItemList(sIndex,dIndex,true)
end

function UIDailyTaskWin:getTaskIndex(taskId)
for i,v in ipairs(self.taskList)do
if v.id==taskId then
return i
end
end
return nil
end

function UIDailyTaskWin:refreshTaskList()
self.taskList=taskModel:getSortDailyTaskData()
self:do_refreshTaskList()
end

function UIDailyTaskWin:do_refreshTaskList()
local c=#self.taskList
self.taskScroller:setChildScrollViewCreateGrids(c,1)

local grids=self.taskScroller:getChildScrollViewItemWidgets()
for i=1,c do
self:refreshTaskItem(grids[i-1],i)
end
end

function UIDailyTaskWin:refreshTaskItem(item,index)
if item==nil then
item=self.taskScroller:getChildScrollViewItemWidget(index-1)
end
local taskData=self.taskList[index]
local taskId=taskData.id
local config=taskData.cfg
if item then

item:SetChildText(taskItemIndex.name,config.desc)

local target=config.require
local cur=taskModel:getDailyTaskFinishNumById(taskData)
local need=target[2]
if cur>need then
cur=need
end
item:SetChildProgressValue(taskItemIndex.progressbar,cur,need)
item:SetChildProgressText(taskItemIndex.progressbar,FMT.fmt('{0}/{1}',cur,need))


local isCan=cur>=need
local isGot=taskModel:checkDailyTaskIsGotById(taskData)
local showGoBtn=config.jump~=nil
item:SetChildActive(taskItemIndex.goBtn,not isGot and not isCan and showGoBtn)
item:SetChildActive(taskItemIndex.rewardBtn,not isGot and isCan)
item:SetChildButtonClickWithID(taskItemIndex.goBtn,function(id)self:onClickGoBtn(id)end,taskId)
item:SetChildButtonClickWithID(taskItemIndex.rewardBtn,function(id)self:onClickRewardBtn(id,config)end,taskId)
item:SetChildActive(taskItemIndex.gotFlag,isGot)

item:SetChildActive(taskItemIndex.nBoxImg,not isGot)
item:SetChildActive(taskItemIndex.oBoxImg,isGot)

local rewards=taskModel:GetDayTaskReward(taskId)
local rw=nil
local zmlv=zongmenModel:getLevel()
for i,v in ipairs(rewards)do
if zmlv>=v[1]and zmlv<=v[2]then
rw=v[3]
break
end
end
if rw==nil then
rw=rewards[#rewards][3]
end
item:SetChildLayoutGroupCreateItems(taskItemIndex.rewards,#rw)
local grids=item:GetChildLayoutGroupGridList(taskItemIndex.rewards)
for i=1,#rw do
local widget=grids[i-1]
local reward=rw[i]
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
end
end

function UIDailyTaskWin:onClickBaseItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end

function UIDailyTaskWin:onClickGoBtn(taskId)
local config=cfgHelper.get1(cfg_everydaytaskconfig_get,taskId)
local jumpParam=config.jump
local target=config.require

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

function UIDailyTaskWin:onClickRewardBtn(taskId,config)







local rewards=taskModel:GetDayTaskReward(taskId)
local rw=nil
local zmlv=zongmenModel:getLevel()
for i,v in ipairs(rewards)do
if zmlv>=v[1]and zmlv<=v[2]then
rw=v[3]
break
end
end
if rw==nil then
rw=rewards[#rewards][3]
end
for i=1,#rw do
local reward=rw[i]
local itemid=reward[1]

local bagType=itemsConfig.getBagType(itemid)
if bagType then
if bagHelper.checkBagFull(bagType)then

return
end
end
end

taskController:req_dailyReward_once()
end





















function UIDailyTaskWin:refreshTQModel()
local tqState=taskController:getOpenTQState()
self.tqmodel:setActive(tqState)

if tqState then

local params=taskController:getTqModelParams()
if params then
local npcImgId=params[1]
local npcInfo=npcModel:getImageInfoOutSide(npcImgId)
local modelid=npcInfo.body
local scale=params[2]or npcInfo.scale
local compoments=npcInfo.componets
local animation=params[3]or npcInfo.anim
local pos=params[4]or{0,0}
local flipx=params[5]or 0
local kuangOffset=params[6]or{0,0}
local modelOffset=params[7]or{0,0}

local cb=function()

self:startTqModelSpeak()
end
self.tqmodel:setChildUIModelShowTarget(modelid,scale,compoments,animation,false,false,0.2,cb)
self.tqmodel:setChildAnchoredPos(pos[1],pos[2])
self.tqmodel:setChildUIModelShowFlipX(flipx==1)
self.speakKuang:setChildAnchoredPos(kuangOffset[1],kuangOffset[2])
self.tqmodel:setChildUIModelShowTargetOffset(modelOffset[1],modelOffset[2])
else

end
else


self:stopTqModelSpeak()
self.speakKuang:setActive(false)
end
end

function UIDailyTaskWin:stopTqModelSpeak()
if self.tqModelSpeakTimeId then
self:stopTimerByID(self.tqModelSpeakTimeId)
self.tqModelSpeakTimeId=nil
end
end

function UIDailyTaskWin:startTqModelSpeak()
local speakList=taskController:getTqSpeakList()

self:stopTqModelSpeak()
self.speakKuang:setActive(false)

local stamp=timeHelper.getServerShortTime()
local interval=0
local durationInterval
local state=0
local content
local speakIndex=0
local speakLen=#speakList
local func=function()
if not _this then return end

local curStamp=timeHelper.getServerShortTime()

if curStamp-stamp>=interval and state==0 then
content=speakList[speakIndex+1]
_this.speakKuang:setActive(true)
_this.speakContent:setText(content)
state=1
stamp=curStamp
durationInterval=Mathf.Random(5,6)
end

if state==1 and curStamp-stamp>=durationInterval then
_this.speakKuang:setActive(false)
state=0
interval=1
stamp=curStamp
speakIndex=(speakIndex+1)%speakLen
end
end

self.tqModelSpeakTimeId=self:setTimer(1,0,func)
end


function UIDailyTaskWin:onJumpTQAct()
local openState,actInfo=taskController:checkActOpenAndHasTQEffect()
if openState then
jumpManager:jump({id=JUMP_TYPE.eActivity,args={subType=actInfo.sub_act_type,subid=actInfo.sub_act_id}},function()

end)
end
end
