







def_class("UISubAct_YuFuActivityWin",UIWindowBase)









function UISubAct_YuFuActivityWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.timeTx=UIText.get(self,1)
self.model=UIObject.get(self,2)
self.title=UIImage.get(self,3)
self.rewardRoot=UIButton.get(self,4)
self.rewardReddot=UIObject.get(self,5)
self.rewardList=UIObject.get(self,6)
self.progressBar=UIProgress.get(self,7)
self.rewardFlag=UIObject.get(self,8)
self.getzhangjieBtn=UIButton.get(self,9)
self.tasknum=UIText.get(self,10)
self.tabList=UIObject.get(self,11)
self.progressTx=UIText.get(self,12)
self.taskList=UIObject.get(self,13)

self.rewardRoot:setButtonClick(function()self:onRewardRoot()end)

self.getzhangjieBtn:setButtonClick(function()self:onGetzhangjieBtn()end)



end


function UISubAct_YuFuActivityWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.rewardRoot);self.rewardRoot=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.rewardFlag);self.rewardFlag=nil;
_UIObject_release(self.getzhangjieBtn);self.getzhangjieBtn=nil;
_UIObject_release(self.tasknum);self.tasknum=nil;
_UIObject_release(self.tabList);self.tabList=nil;
_UIObject_release(self.progressTx);self.progressTx=nil;
_UIObject_release(self.taskList);self.taskList=nil;
end


















local _tabCmp={
button=-1,
select=0,
name=1,
reddot=2,
}
local itemCmp=
{
rewardBtn=0,
jumpBtn=1,
descTx=2,
rewards=3,
getted=4,
}

local tabs_data={}

function UISubAct_YuFuActivityWin:onLoaded(...)
self:bindComponents()

tabs_data={}
end


function UISubAct_YuFuActivityWin:__delete()
self:unbindComponents()
end




function UISubAct_YuFuActivityWin:onShow(argtable,afterOnloaded)

self.bgModel:setChildUIModelShowTarget(5374,1,{},0)
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



end
self.argtable=argtable
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfoData(self.activityId,self.subType,self.subId)
self.info=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self:initTask()
end


function UISubAct_YuFuActivityWin:onHide()

end








function UISubAct_YuFuActivityWin:refresh()
self:refreshTask()

self:setTaskItem(self.index)

self:refreshRewardBoard(self.index)

end

function UISubAct_YuFuActivityWin:initTask()
self:startCDTick()
self.index=1

self:refreshTask()




self:setTaskItem(self.index)

self:refreshRewardBoard(self.index)

end


function UISubAct_YuFuActivityWin:refreshTask()
self.tabs=self.config.taskList
self.yqid_tb=self.config.yqid
self.tabList:setChildLayoutGroupCreateItems(#self.yqid_tb,function(index)
local item=self.tabList:getChildLayoutGroupGridItem(index-1)
local yqindex=self.yqid_tb[index]
local name=cfgHelper.get2(cfg_yufumubiaoacttagconfig_get,yqindex,'name')
item:SetChildText(_tabCmp.name,name or"")
item:SetChildActive(_tabCmp.select,index==self.index)
item:SetChildButtonClick(_tabCmp.button,function()
self:onClickTab(index,item)
end)
local reddotflag=self:SingleChapterAllreddot(index)
item:SetChildActive(_tabCmp.reddot,reddotflag)
end)

end


function UISubAct_YuFuActivityWin:setTaskItem(index)
local tasksall=table.weakCopy(self.tabs[self.yqid_tb[index]])
local tasks={}

local tasksdata={}
local finishtaskNum=0

for k,v in ipairs(tasksall)do
local cfg=cfg_yufumubiaoacttaskconfig_get(v)

local finishNum1,rwFlag1,finishFlag1=self:findfinishNum(v,cfg)
if rwFlag1==1 then
tasks[k]={v,sort=10000+k}
elseif finishFlag1==1 then
tasks[k]={v,sort=k}
else
tasks[k]={v,sort=1000+k}
end
end
table.sort(tasks,function(a,b)
return a.sort<b.sort
end)
for k,v in ipairs(tasks)do
local cfg=cfg_yufumubiaoacttaskconfig_get(v[1])

local finishNum,rwFlag,finishFlag=self:findfinishNum(v[1],cfg)

tasksdata[#tasksdata+1]={cfg=cfg,finishNum=finishNum,rwFlag=rwFlag,finishFlag=finishFlag}
if finishFlag==1 then
finishtaskNum=finishtaskNum+1
end
end


self.tasknum:setText(FMT.fmt("{0}/{1}",finishtaskNum,#tasks))
self.taskList:setChildLayoutGroupCreateItems(#tasks,function(index)
local item=self.taskList:getChildLayoutGroupGridItem(index-1)
self:refreshTaskItem(item,tasksdata,index)
end)


self:refreshRewardProgress(self.index,finishtaskNum,#tasks)
end

function UISubAct_YuFuActivityWin:findfinishNum(taskid,cfg)

if not self.activityData then
return
end
local finishNum=0
local tasklist=self.activityData.tasklist and self.activityData.tasklist or{}


if taskModel:checkClientCheckTask(cfg.tasktype)then
finishNum=self.activityData.clientID[taskid]and self.activityData.clientID[taskid][1]or 0
local rwFlag=0
local finishFlag=0
for k,v in ipairs(tasklist)do
if v.taskId==taskid then

rwFlag=v.rwFlag
finishFlag=v.finishFlag
end
end
if self.activityData.clientID[taskid]and(self.activityData.clientID[taskid][1]>=self.activityData.clientID[taskid][2])then
finishFlag=1
end

return finishNum,rwFlag,finishFlag
else
for k,v in ipairs(tasklist)do
if v.taskId==taskid then

return v.finishNum,v.rwFlag,v.finishFlag
end
end
end

return 0,0,0
end


function UISubAct_YuFuActivityWin:refreshTaskItem(item,tasksdata,index)

local itemdata=tasksdata[index]
if not itemdata then
logErr("数据有问题")
return
end
local tasktype=activitiesHandle_yufutarget.clientTaskType

local cfg_data=itemdata.cfg
local aimnum=cfg_data.aimnum

local str=cfg_data.name
local numstr=FMT.fmt("（{0}/{1}）",itemdata.finishNum,aimnum)
if itemdata.rwFlag==1 or itemdata.finishFlag==1 then
numstr=FMT.fmt("<color=#ca631d>（{0}/{1}）</color>",aimnum,aimnum)
end
item:SetChildText(itemCmp.descTx,FMT.fmt(str,numstr))

if itemdata.finishFlag==0 and itemdata.rwFlag==0 then


if cfg_data.jump then
item:SetChildActive(itemCmp.jumpBtn,true)
else
item:SetChildActive(itemCmp.jumpBtn,false)
end
item:SetChildActive(itemCmp.rewardBtn,false)
item:SetChildActive(itemCmp.getted,false)

item:SetChildButtonClick(itemCmp.jumpBtn,function()
local jump=cfg_data.jump
jumpManager:jump(jump)
end)
elseif itemdata.finishFlag==1 and itemdata.rwFlag==0 then

item:SetChildActive(itemCmp.jumpBtn,false)
item:SetChildActive(itemCmp.rewardBtn,true)
item:SetChildActive(itemCmp.getted,false)

item:SetChildButtonClick(itemCmp.rewardBtn,function()

if itemdata and itemdata.finishFlag==1 then
call_activitiesHandle_func('activitiesHandle_yufutarget','reqtaskReward',self.activityId,self.subId,1)
end
end)
elseif itemdata.rwFlag==1 then

item:SetChildActive(itemCmp.jumpBtn,false)
item:SetChildActive(itemCmp.rewardBtn,false)
item:SetChildActive(itemCmp.getted,true)
end



local rewards=cfg_data.reward
item:SetChildLayoutGroupCreateItems(itemCmp.rewards,#rewards,function(idx)
local rewardItem=item:GetChildLayoutGroupGridItem(itemCmp.rewards,idx-1)
local rewardData=rewards[idx]
local showCountBG=rewardData[2]>1
local countStr=showCountBG and rewardData[2]or""
local conf={itemid=rewardData[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
rewardItem:SetChildActive(1,itemsConfig.getItemColor(rewardData[1])>=eQualityColor.eRed)
end)

end


function UISubAct_YuFuActivityWin:onClickTab(index,item)
if self.index==index then
return
end
local item_before=self.tabList:getChildLayoutGroupGridItem(self.index-1)
item_before:SetChildActive(_tabCmp.select,false)
item:SetChildActive(_tabCmp.select,true)
self.index=index

self:setTaskItem(index)

self:refreshRewardBoard(index)

end


function UISubAct_YuFuActivityWin:refreshRewardBoard(index)
local groupCfg=self.config.zjReward


local rewards=groupCfg[self.yqid_tb[index]]
self.rewardList:setChildLayoutGroupCreateItems(#rewards,function(index)
local rewardItem=self.rewardList:getChildLayoutGroupGridItem(index-1)
local rewardData=rewards[index]
local showCountBG=rewardData[2]>1
local countStr=showCountBG and rewardData[2]or""
local conf={itemid=rewardData[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(-1,prop)
rewardItem:SetBaseItemClickEvent(-1,function(...)
itemsComponentHelper.onItemClickEx(...)
end)
end)
self.rewardReddot:setActive(false)
self.getzhangjieBtn:setActive(false)

if self.activityData.recordFinishTaskGroup and next(self.activityData.recordFinishTaskGroup)then

for k,v in ipairs(self.activityData.recordFinishTaskGroup)do
if v==self.yqid_tb[self.index]then
self.rewardReddot:setActive(true)
self.getzhangjieBtn:setActive(true)
end
end
end

self.rewardFlag:setActive(false)
if self.activityData.zjrwTagList and next(self.activityData.zjrwTagList)then
for k,v in pairs(self.activityData.zjrwTagList)do
if v==self.yqid_tb[self.index]then
self.rewardFlag:setActive(true)
self.rewardReddot:setActive(false)
end
end
end
end


function UISubAct_YuFuActivityWin:refreshRewardProgress(index,cnt,max)


self.progressTx:setText(FMT.fmt("{0}/{1}",cnt,max))
self.progressBar:setProgressValue(math.floor(cnt/max*10000),10000)
self.progressBar:setChildProgressText(FMT.fmt("{0}/{1}",cnt,max))

end


function UISubAct_YuFuActivityWin:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UISubAct_YuFuActivityWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UISubAct_YuFuActivityWin:updateCDTick()
local time=activitiesModel:getSubActEndLeftTime(self.activityId,self.subType,self.subId)
self.timeTx:setText(FMT.fmt("{0}后结束",timeHelper.format_time_stamp3(time)))
end


function UISubAct_YuFuActivityWin:onGetzhangjieBtn()

if not next(self.activityData.recordFinishTaskGroup)then
return
end
if self.activityData.zjrwTagList and next(self.activityData.zjrwTagList)then
for k,v in pairs(self.activityData.zjrwTagList)do
if v==self.yqid_tb[self.index]then

return
end
end
end

for k,v in ipairs(self.activityData.recordFinishTaskGroup)do
if v==self.yqid_tb[self.index]then
call_activitiesHandle_func('activitiesHandle_yufutarget','reqtaskReward',self.activityId,self.subId,2)
end
end
end


function UISubAct_YuFuActivityWin:SingleChapterAllreddot(index)
local tasks=self.tabs[self.yqid_tb[index]]
for k,v in ipairs(tasks)do
local cfg=cfg_yufumubiaoacttaskconfig_get(v)

local finishNum,rwFlag,finishFlag=self:findfinishNum(v,cfg)
if rwFlag==0 and finishFlag==1 then
return true
end
end

if self.activityData.zjrwTagList and next(self.activityData.zjrwTagList)then
for k,v in pairs(self.activityData.zjrwTagList)do
if v==self.yqid_tb[index]then

return false
end
end
end
if self.activityData.recordFinishTaskGroup and next(self.activityData.recordFinishTaskGroup)then

for k,v in ipairs(self.activityData.recordFinishTaskGroup)do
if v==self.yqid_tb[index]then
return true
end
end
end
end

function UISubAct_YuFuActivityWin:onRewardRoot()

end
