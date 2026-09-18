







def_class("UITargetActivityWin",UIWindowBase)









function UITargetActivityWin:bindComponents()

self.reddotL=UIObject.get(self,0)
self.reddotR=UIObject.get(self,1)
self.model=UIObject.get(self,2)
self.leftBtn=UIButton.get(self,3)
self.rightBtn=UIButton.get(self,4)
self.count=UIText.get(self,5)
self.title=UIText.get(self,6)
self.rwScrollView=UIObject.get(self,7)
self.receiveBtn=UIButton.get(self,8)
self.receiveIcon=UIObject.get(self,9)
self.targetScrollView=UIObject.get(self,10)
self.countDown=UIText.get(self,11)
self.countDesc=UIText.get(self,12)
self.helpBtn=UIToggleButton.get(self,13)
self.helpPanelPos=UIObject.get(self,14)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.receiveBtn:setButtonClick(function()self:onReceiveBtn()end)



end


function UITargetActivityWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.reddotL);self.reddotL=nil;
_UIObject_release(self.reddotR);self.reddotR=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.count);self.count=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.receiveBtn);self.receiveBtn=nil;
_UIObject_release(self.receiveIcon);self.receiveIcon=nil;
_UIObject_release(self.targetScrollView);self.targetScrollView=nil;
_UIObject_release(self.countDown);self.countDown=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.helpPanelPos);self.helpPanelPos=nil;
end
















local _task_item={
targetDes=0,
count=1,
gotoBtn=2,
receiveBtn=3,
receiveIcon=4,
rewards={5,6,7}
}

local _modelList={
2059,
2058,
2057,
2056,
2055,
}

local _this



function UITargetActivityWin:onLoaded(...)
_this=self
self:bindComponents()

self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)
self.targetScrollView:setChildScrollViewInit(0.5,true,nil,nil)

self.helpBtn:setToggleChange(function(name,isOn,data)
if isOn then
self:onHelpBtn()
end
end)

self.helpPos=self.helpPanelPos:getChildAnchoredPosition()
end


function UITargetActivityWin:__delete()
_this=nil
self:unbindComponents()
end




function UITargetActivityWin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.actId=argtable.act_id
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

local cfg=cfgHelper.get1(cfg_targetactivity1config_get,self.subId)

self.countDes=cfg.countDes
self.taskDes=cfg.taskDes


self.groups=self:initSortGroups()
self.helpDes=cfg.helpDes
self.groupIndex=self:getStartGroupIndex()
self.groupId=self.groups[self.groupIndex]
self:showCurrentGroup()
self:startCountDown()
self:showPageBtn()
end


function UITargetActivityWin:initSortGroups()
local cfg=cfgHelper.get1(cfg_targetactivity1config_get,self.subId)
local groups={}
local grouprewards=cfg.grouprewards

for id,v in pairs(grouprewards)do
groups[#groups+1]=id
end


table.sort(groups,function(a,b)
return a<b
end)

return groups
end

function UITargetActivityWin:getStartGroupIndex()
for i,v in ipairs(self.groups)do
local isReceive=self:callActivityInfoFunc('isGroupRewardReceive',v)
if not isReceive then
return i
end

local isComplete=self:callActivityInfoFunc('isGroupComplete',self.subId,v)
if not isComplete then
return i
end
end
return 1
end

function UITargetActivityWin:refresh()
self:showCurrentGroup()
end

function UITargetActivityWin:callActivityFunc(fname,...)
return call_activitiesHandle_func('activitiesHandle_targetActivity',fname,self.actId,self.subId,...)
end

function UITargetActivityWin:callActivityInfoFunc(fname,...)
local info=activitiesModel:getSubActInfo(self.actId,SUB_ACTIVITY_TYPE.eMuBiaoHuoDong,self.subId)
return info[fname](info,...)
end


function UITargetActivityWin:onHide()

end

function UITargetActivityWin:startCountDown()
local time=self:callActivityInfoFunc('getEndLeftTime')
local endTime=os.time()+time
local tick=function()
local dt=endTime-os.time()
self.countDown:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp11(dt,true)))
if dt<=0 then
self:clearTimer()
end
end
self:clearTimer()
self.timer=self:setTimer(1,time+5,tick)
tick()
end

function UITargetActivityWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UITargetActivityWin:showCurrentGroup()
self.countDesc:setText(self.countDes)
self.count:setText(self:callActivityInfoFunc('getTargetProgress'))
self.title:setText(FMT.fmt('第{0}轮',mathHelper.numberToChinese(self.groupId)))
self:setTargetRewards()
self:setTargetTasks()

if self.helpDes then

self.helpBtn:setActive(true)
else

self.helpBtn:setActive(false)
end

local gstate=self:callActivityInfoFunc('getGroupState',self.groupId)
local receive=false
if gstate then
receive=gstate==3
end
self.receiveBtn:setActive(not receive)
self.receiveIcon:setActive(receive)
if not receive then
local isComplete=self:callActivityInfoFunc('isGroupComplete',self.subId,self.groupId)
self.receiveBtn:setButtonEnable(isComplete,not isComplete)
end


local modelId=_modelList[self.groupId]
if not modelId then
modelId=_modelList[#_modelList]
end
self.model:setChildUIModelShowTarget(modelId,1.5,{},eAnimationID.stand,false,false,0.5)
self.model:setChildUIModelShowFlipX(true)
end

function UITargetActivityWin:setTargetRewards()
local cfg=cfgHelper.get1(cfg_targetactivity1config_get,self.subId)
local rewards=cfg.grouprewards[self.groupId].rewards
local len=#rewards
self.rwScrollView:setChildScrollViewCreateGrids(len,math.min(len,3))
local grids=self.rwScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=rewards[i]
local itemId=data[1]
local itemCount=data[2]
local showEffFlag=data[3]==1
local countStr=itemCount>1 and mathHelper.formatNumber2(itemCount)or''
local showCountBG=itemCount>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=showEffFlag}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
end

function UITargetActivityWin:setTargetTasks()
local datas=self:getTargetDatas()
local len=#datas
self.targetScrollView:setChildScrollViewCreateGrids(len,1)
local grids=self.targetScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=datas[i]
local taskId=data.taskId
local taskData=self:callActivityInfoFunc('getTaskData',taskId)
local cfg=cfgHelper.get1(cfg_targetactivity1config_get,self.subId)
local td=cfg.tasks[taskId]
item:SetChildText(_task_item.targetDes,FMT.fmt(self.taskDes,td.task[1]))
item:SetChildText(_task_item.count,FMT.fmt('{0}/{1}',taskData and taskData.taskprogress or 0,td.task[1]))
local jumpArgs=td.jump
local state=taskData and taskData.taskstate or 1
local check1=state==1 and jumpArgs~=nil
local check2=state==2
local check3=state==3
item:SetChildActive(_task_item.gotoBtn,check1)
item:SetChildActive(_task_item.receiveBtn,check2)
item:SetChildActive(_task_item.receiveIcon,check3)
item:SetChildActive(_task_item.count,not check3)
if check1 then
item:SetChildButtonClick(_task_item.gotoBtn,function()
jumpManager:jump(jumpArgs)
end)
end
if check2 then
item:SetChildButtonClick(_task_item.receiveBtn,function()
self:callActivityFunc('reqTaskReward',self.groupId)
end)
end
local rwArr=td.task_rewards
for i,v in ipairs(_task_item.rewards)do
local rw=rwArr[i]
if rw then
item:SetChildActive(v,true)
widgetHelper.setNormalRewardItem(item,v,rw)
else
item:SetChildActive(v,false)
end
end
end
end

function UITargetActivityWin:getTargetDatas()
local cfg=cfgHelper.get1(cfg_targetactivity1config_get,self.subId)
local list={}
local tasks=cfg.grouprewards[self.groupId].task_ids
for i,v in ipairs(tasks)do
local taskData=self:callActivityInfoFunc('getTaskData',v)
local state=taskData and taskData.taskstate or 3
table.insert(list,{taskId=v,taskState=state})
end
local svd={2,1,3}
table.sort(list,function(a,b)
if svd[a.taskState]==svd[b.taskState]then

return a.taskId<b.taskId
else
return svd[a.taskState]<svd[b.taskState]
end
end)
return list
end



function UITargetActivityWin:showPageBtn()
local showL=self.groupIndex>1
local showR=self.groupIndex<#self.groups
self.leftBtn:setActive(showL)
self.rightBtn:setActive(showR)
if showL then
self.reddotL:setActive(self:callActivityInfoFunc('checkGroupReddot',self.subId,self.groupIndex-1))
end
if showR then
self.reddotR:setActive(self:callActivityInfoFunc('checkGroupReddot',self.subId,self.groupIndex+1))
end
end

function UITargetActivityWin:onLeftBtn()
if self.groupIndex>1 then
self.groupIndex=self.groupIndex-1
self.groupId=self.groups[self.groupIndex]
self:showCurrentGroup()
self:showPageBtn()
end
end

function UITargetActivityWin:onRightBtn()
if self.groupIndex<#self.groups then
self.groupIndex=self.groupIndex+1
self.groupId=self.groups[self.groupIndex]
self:showCurrentGroup()
self:showPageBtn()
end
end

function UITargetActivityWin:onReceiveBtn()
local isComplete=self:callActivityInfoFunc('isGroupComplete',self.subId,self.groupId)
if isComplete then
self:callActivityFunc('reqGroupReward',self.groupId)
else
UIManager.error('完成本轮全部任务方可领取')
end
end

function UITargetActivityWin:onHelpBtn()
if not self.helpDes then
return
end

local contentStr=self.helpDes
local x=self.helpPos.x
local y=self.helpPos.y
self:showWindow('UICommonHelpTwo',
{content=contentStr,
doScaleType=2,
x=x,
y=y,
ptype=3,
closeCB=function()
self.helpBtn:setToggle(false)
end})
end

function UITargetActivityWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,showModel=true})
end