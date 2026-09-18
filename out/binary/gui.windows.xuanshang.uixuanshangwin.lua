







def_class("UIXuanShangWin",UIWindowBase)









function UIXuanShangWin:bindComponents()

self.ruleBtn=UIButton.get(self,0)
self.cloud=UIButton.get(self,1)
self.quickCostNum=UIText.get(self,2)
self.quickCostIcon=UIObject.get(self,3)
self.refreshCostIcon=UIObject.get(self,4)
self.refreshCostValue=UIText.get(self,5)
self.costTime=UIText.get(self,6)
self.quickCost=UIObject.get(self,7)
self.cdText=UIText.get(self,8)
self.refreshBtnText=UIText.get(self,9)
self.refreshCostRoot=UIObject.get(self,10)
self.check1=UIObject.get(self,11)
self.check2=UIObject.get(self,12)
self.applyBtn=UIButton.get(self,13)
self.selectBtn=UIButton.get(self,14)
self.quickBtn=UIButton.get(self,15)
self.cdProgress=UIObject.get(self,16)
self.jqItemIcon=UIButton.get(self,17)
self.headRoot3=UIButton.get(self,18)
self.headRoot2=UIButton.get(self,19)
self.headRoot1=UIButton.get(self,20)
self.scrollView=UIObject.get(self,21)
self.refreshBtn=UIButton.get(self,22)
self.condition1=UIText.get(self,23)
self.condition2=UIText.get(self,24)
self.helpBtn=UIButton.get(self,25)
self.xsLevel=UIText.get(self,26)
self.rwScrollView=UIObject.get(self,27)
self.jqPanel=UIObject.get(self,28)
self.xsDes=UIText.get(self,29)
self.weituo=UIText.get(self,30)
self.xsName=UIText.get(self,31)
self.zxPanel=UIObject.get(self,32)
self.xsNameBG=UIImage.get(self,33)
self.receiveBtn=UIButton.get(self,34)
self.jqItemCount=UIText.get(self,35)
self.countDes=UIText.get(self,36)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.cloud:setButtonClick(function()self:onCloud()end)

self.applyBtn:setButtonClick(function()self:onApplyBtn()end)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)

self.quickBtn:setButtonClick(function()self:onQuickBtn()end)

self.jqItemIcon:setButtonClick(function()self:onJqItemIcon()end)

self.headRoot3:setButtonClick(function()self:onHeadRoot3()end)

self.headRoot2:setButtonClick(function()self:onHeadRoot2()end)

self.headRoot1:setButtonClick(function()self:onHeadRoot1()end)

self.refreshBtn:setButtonClick(function()self:onRefreshBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.receiveBtn:setButtonClick(function()self:onReceiveBtn()end)


self.sprite_image_dygou=0
self.sprite_image_dycha=1

end


function UIXuanShangWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.cloud);self.cloud=nil;
_UIObject_release(self.quickCostNum);self.quickCostNum=nil;
_UIObject_release(self.quickCostIcon);self.quickCostIcon=nil;
_UIObject_release(self.refreshCostIcon);self.refreshCostIcon=nil;
_UIObject_release(self.refreshCostValue);self.refreshCostValue=nil;
_UIObject_release(self.costTime);self.costTime=nil;
_UIObject_release(self.quickCost);self.quickCost=nil;
_UIObject_release(self.cdText);self.cdText=nil;
_UIObject_release(self.refreshBtnText);self.refreshBtnText=nil;
_UIObject_release(self.refreshCostRoot);self.refreshCostRoot=nil;
_UIObject_release(self.check1);self.check1=nil;
_UIObject_release(self.check2);self.check2=nil;
_UIObject_release(self.applyBtn);self.applyBtn=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.quickBtn);self.quickBtn=nil;
_UIObject_release(self.cdProgress);self.cdProgress=nil;
_UIObject_release(self.jqItemIcon);self.jqItemIcon=nil;
_UIObject_release(self.headRoot3);self.headRoot3=nil;
_UIObject_release(self.headRoot2);self.headRoot2=nil;
_UIObject_release(self.headRoot1);self.headRoot1=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.refreshBtn);self.refreshBtn=nil;
_UIObject_release(self.condition1);self.condition1=nil;
_UIObject_release(self.condition2);self.condition2=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.xsLevel);self.xsLevel=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.jqPanel);self.jqPanel=nil;
_UIObject_release(self.xsDes);self.xsDes=nil;
_UIObject_release(self.weituo);self.weituo=nil;
_UIObject_release(self.xsName);self.xsName=nil;
_UIObject_release(self.zxPanel);self.zxPanel=nil;
_UIObject_release(self.xsNameBG);self.xsNameBG=nil;
_UIObject_release(self.receiveBtn);self.receiveBtn=nil;
_UIObject_release(self.jqItemCount);self.jqItemCount=nil;
_UIObject_release(self.countDes);self.countDes=nil;
end
















local _this

local _iconBg={
[1]="image_gwtouxiangpjk_5",
[2]="image_gwtouxiangpjk_4",
[3]="image_gwtouxiangpjk_3",
[4]="image_gwtouxiangpjk_6",
[5]="image_gwtouxiangpjk_2",
}

local _item_index={
select=0,
name=1,
paiqian=2,
wancheng=3,
bg=4,
item=5,
reddot=6,
info=7,
}




function UIXuanShangWin:onLoaded(...)
self:bindComponents()

_this=self

self.conditions={
self.condition1,
self.condition2,
}

self.checks={
self.check1,
self.check2,
}

self.headRoots={
self.headRoot1,
self.headRoot2,
self.headRoot3,
}

self.sortIndexs={
[1]={4,1,2,3},
[2]={4,2,1,3},
[3]={4,3,1,2},
}

self.bgModels={4739,4740,4741,4742,4743}
self.bgAnimStates={1,1,1,1,1,1}
self.playCount=0

self.selectDZData={}

self.rotationList={}
for i=1,6 do
self.rotationList[i]=math.random(-3,3)
end

self.abName='ui/windows/xuanshang/sharedtextures/xuanshang.ab'

self.scrollView:setChildScrollViewInit(0.5,true,self.on_item_click,nil)
self.rwScrollView:setChildScrollViewInit(0,true,nil,nil)

notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)


local func=function(id)
local widget=self:getChildExpandUI(-1,id)
if widget then
local pos=self:getChildCanvas(-1)
local sortLayer=pos[1]
local sortOrder=pos[2]
widget:SetChildCanvas(-1,sortLayer,sortOrder+3)
end
end
self.cloud_guid=self:setChildGreateExpandUI(-1,self.cloud:getID(),INSTANCE_TYPE.eCommonCloudUIExpand,func)
end


function UIXuanShangWin:__delete()
if self.cloud_guid~=nil then
self:setChildRemoveExpandUI(-1,self.cloud_guid)
self.cloud_guid=nil
end

self:unbindComponents()

_this=nil

notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
end

function UIXuanShangWin.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if itemid==_this.coseItem then
_this:setInfo()
end
end

function UIXuanShangWin.on_item_click(clickNum,index)
local id=index+1
if not _this.bRefresh and _this.currSelect==id then
return
end

if _this.currSelect then
local item=_this.scrollView:getChildScrollViewItemWidget(_this.currSelect-1)
item:SetChildActive(_item_index.select,false)
end

_this.bRefresh=false
_this:clearSelect()
_this.currSelect=id

local item=_this.scrollView:getChildScrollViewItemWidget(_this.currSelect-1)
item:SetChildActive(_item_index.select,true)

local data=_this.datas[_this.currSelect]
_this.currTask=data.taskId
_this:refreshTaskPanel(data)
end

function UIXuanShangWin:setSelectDZData(taskId,index,dzId)
local data=self.selectDZData[taskId]or{}
data[index]=dzId
self.selectDZData[taskId]=data
end

function UIXuanShangWin:getSelectDZData(taskId)
return self.selectDZData[taskId]
end




function UIXuanShangWin:onShow(argtable,afterOnloaded)
self.bdData=argtable.data
self.sfId=zongmenModel:getMountainId()

self:refresh()
end

function UIXuanShangWin:refresh(lastTasks)
local select=self.currSelect
self.currSelect=nil
self:setInfo()
self:setRefreshAnim(lastTasks)
self:refreshTaskList()

local count=self:getUnPaiTaskCount()
self.winlua:SetChildGraphicGray(self.refreshBtn:getID(),count<=0,true)

if#self.datas>0 then
self.bRefresh=true
local index=self:getCurrTaskIndex()
if index==0 and select then
select=math.min(select,#self.datas)
index=select-1
end
self.on_item_click(0,index)
end
end

function UIXuanShangWin:setRefreshAnim(lastTasks)
if lastTasks then
local curTasks=self:getTaskList()
for i=1,6 do
local state=lastTasks[i]
local data=curTasks[i]
if state and data then
if state==1 then
self.bgAnimStates[i]=2
end
elseif state then
self.bgAnimStates[i]=3
elseif data then
self.bgAnimStates[i]=4
end
end
end
end

function UIXuanShangWin:playRefreshAnim(item,state,func)
if state==2 then
self.playCount=self.playCount+1
item:SetChildCanvasGroupAlpha(_item_index.info,0)
item:SetChildModelAnimationState(_item_index.bg,2123,1,function()
func(2130)
self:delayDo(0.5,function()
item:SetChildModelAnimationState(_item_index.bg,2122,1,function()
item:SetChildCanvasGroupAlpha(_item_index.info,1)
self.playCount=self.playCount-1
end)
end)
end)
elseif state==3 then
self.playCount=self.playCount+1
item:SetChildCanvasGroupAlpha(_item_index.info,0)
item:SetChildModelAnimationState(_item_index.bg,2123,1,function()
item:SetChildCanvasGroupAlpha(_item_index.info,1)
func(2130)
self.playCount=self.playCount-1
end)
elseif state==4 then
self.playCount=self.playCount+1
func(2129)
item:SetChildCanvasGroupAlpha(_item_index.info,0)
item:SetChildModelAnimationState(_item_index.bg,2122,1,function()
item:SetChildCanvasGroupAlpha(_item_index.info,1)
self.playCount=self.playCount-1
end)
end
end

function UIXuanShangWin:getCurrTaskIndex(taskId)
if not taskId then
taskId=self.currTask or-1
end
for i,v in ipairs(self.datas)do
if v.taskId==taskId then
return i-1
end
end
return 0
end


function UIXuanShangWin:onHide()

end

function UIXuanShangWin:setInfo()
local level=UIXuanShangControl:getXuanShangLevel()
self.xsLevel:setText(FMT.fmt('悬赏等级：{0}级',level))

local count=UIXuanShangControl:getFreeDispatchNum()
if count>0 then
self.countDes:setText(FMT.fmt('接取任务次数：{0}',count))
self.jqItemIcon:setActive(false)
self.jqItemCount:setText('')
else
count=UIXuanShangControl:getItemDispatchNum()
local useItem=cfgHelper.get2(cfg_zongmenxuanshangtaskbaseconfig_get,1,'useItem2')
local coseItem=useItem[1]
self.coseItem=coseItem
local name=itemsConfig.getItemName(self.coseItem)
local itemCount=itemsModel.getCount(self.coseItem)
local color=count>0 and'#fd8950'or FONT_COLOR_VAL[FONT_COLOR.eRedColor]
self.countDes:setText(FMT.fmt('{1}接取任务次数：<color={2}>{0}</color>',count,name,color))
self.jqItemIcon:setActive(true)
self.jqItemIcon:setChildIcon(iconHelper.getIconName(useItem[1]),true)
self.jqItemCount:setText(itemCount)
end

count=UIXuanShangControl:getFreeRefreshNum()
if count>0 then
self.refreshBtnText:setText(FMT.fmt('刷新\n<size=20>（剩余{0}次）</size>',count))
self.refreshCostRoot:setActive(false)
else
local useItem=cfgHelper.get2(cfg_zongmenxuanshangtaskbaseconfig_get,1,'useItem')
self.refreshBtnText:setText('刷新')
self.refreshCostRoot:setActive(true)
self.refreshCostIcon:setChildIcon(iconHelper.getIconName(useItem[1]),true)
self.refreshCostValue:setText(useItem[2])
end
end

function UIXuanShangWin:getTaskList(taskList)
local list={}
local datas=taskList or UIXuanShangControl:getTaskList()
for k,v in pairs(datas)do

list[v.index]=v
end



return list
end

function UIXuanShangWin:refreshTaskList()
local datas=self:getTaskList()
self.datas=datas
local len=6
self.scrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.scrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=datas[i]
if data then
item:SetChildActive(-1,true)
local cfg=cfgHelper.get1(cfg_zongmenxuanshangtaskconfig_get,data.taskId)
item:SetChildRotation(-1,0,0,self.rotationList[i])
item:SetChildActive(_item_index.select,false)

local func=function(animId)
item:SetChildUIModelShowTarget(_item_index.bg,self.bgModels[cfg.color],1,nil,animId,false,false,0)
end
local state=self.bgAnimStates[i]
if state>1 then
self:playRefreshAnim(item,state,func)
else
func(2129)
end
self.bgAnimStates[i]=0
item:SetChildText(_item_index.name,cfg.name)
local rwId=self:getRewardId(cfg)
local rwcfg=cfgHelper.get1(cfg_awardconfig_get,rwId)
local rewards=rwcfg.showItems
local rw=rewards[1]
widgetHelper.setNormalRewardItem(item,_item_index.item,{rw[1],0,noClick=true,showStage=true,range=rw.range})
if data.endTime>0 then
local curTime=gameUtilityModel.getServerShortTime()
if curTime>=data.endTime then
item:SetChildActive(_item_index.paiqian,false)
item:SetChildActive(_item_index.wancheng,true)
item:SetChildActive(_item_index.reddot,true)
else
item:SetChildActive(_item_index.paiqian,true)
item:SetChildActive(_item_index.wancheng,false)
item:SetChildActive(_item_index.reddot,false)
end
else
item:SetChildActive(_item_index.paiqian,false)
item:SetChildActive(_item_index.wancheng,false)
item:SetChildActive(_item_index.reddot,false)
end
else
item:SetChildActive(-1,false)
end
end
end

function UIXuanShangWin:getUnPaiTaskCount()
local datas=self:getTaskList()
local count=0
for i,v in ipairs(datas)do
if v.endTime<=0 then
count=count+1
end
end
return count
end


function UIXuanShangWin:checkOrderPT(conds)
local GameVersion=pfwindowslController:getGameVersion()
local pfid=loginModel:getPfid()
local cond={}
local cfg=conds[GameVersion]or conds[1]
if cfg then
if cfg[-1]then
cond=cfg[-1]
else
if pfid and cfg[pfid]then
cond=cfg[pfid]
end
end
end
return cond
end
function UIXuanShangWin:getRewardId(cfg)
local zmLevel=zongmenModel:getLevel()
local _reward=self:checkOrderPT(cfg.reward)
for i,v in ipairs(_reward)do
if zmLevel>=v[1]and zmLevel<=v[2]then
return v[3]
end
end
return-1
end

function UIXuanShangWin:getCondition(cfg)
local zmLevel=zongmenModel:getLevel()
for i,v in ipairs(cfg.condition)do
if zmLevel>=v[1]and zmLevel<=v[2]then
return v[3]
end
end
return nil
end

function UIXuanShangWin:refreshCondition()
local data=self.datas[self.currSelect]
local cfg=cfgHelper.get1(cfg_zongmenxuanshangtaskconfig_get,data.taskId)
self:setConditions(self:getCondition(cfg),data.taskId)
end

function UIXuanShangWin:refreshTaskPanel(data)
local cfg=cfgHelper.get1(cfg_zongmenxuanshangtaskconfig_get,data.taskId)
self.xsNameBG:setCSImageSprite(self.abName,'image_xsrwdw_'..cfg.color)
self.xsName:setText(cfg.name)
self.weituo:setText(FMT.fmt('委托宗门：{0}（声望值+{1}）',
systemZongMenModel:getInfoDataName(data.zmGuid)or'神秘宗门',
cfg.wjAddVal))
self.xsDes:setText(cfg.desc)
local rwId=self:getRewardId(cfg)
local rwcfg=cfgHelper.get1(cfg_awardconfig_get,rwId)
local rewards=rwcfg.showItems
local len=#rewards
self.rwScrollView:setChildScrollViewCreateGrids(len,math.min(len,3))
local grids=self.rwScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local rw=rewards[i]
widgetHelper.setNormalRewardItem(item,0,{rw[1],rw[2],showStage=true,range=rw.range})
end
self:setConditions(self:getCondition(cfg),data.taskId)

self.teamMaxNum=cfg.teamNum
for i,v in ipairs(self.headRoots)do
local canShow=i<=self.teamMaxNum
v:setActive(canShow)
if canShow then
local widget=v:getChildWidgetBase()
widget:SetChildActive(1,false)
end
end

local needTime=cfg.time*60
self.costTime:setText(FMT.fmt('耗时：{0}',timeHelper.format_time_stamp11(needTime)))
self:clearTimer()
local cddata=UIXuanShangControl:getCDData(data.taskId)
if cddata then
self.jqPanel:setActive(false)
self:setHeadByDZList(data.dzList)
if cddata.complete then
self.zxPanel:setActive(false)
self.receiveBtn:setActive(true)
else
self.zxPanel:setActive(true)
self.receiveBtn:setActive(false)
self:startTimer(data.taskId)
end
else
self.jqPanel:setActive(true)
self.zxPanel:setActive(false)
self.receiveBtn:setActive(false)
end
end

function UIXuanShangWin:setQuickFinishCost(taskId,firstTick)
local param=cfgHelper.get2(cfg_zongmenxuanshangtaskbaseconfig_get,1,'gsParam')
local data=UIXuanShangControl:getCDData(taskId)
local cd=data.cd
local check=cd>60
self.quickCost:setActive(check)
if check then
local use=math.ceil(cd/(param[1]*60))
local cost=use*param[3]
if firstTick then
self.quickCostIcon:setChildIcon(iconHelper.getIconName(param[2]),true)
end
self.quickCostNum:setText(cost)
end
end

function UIXuanShangWin:startTimer(taskId)
local firstTick=true
local tick=function()
self:setQuickFinishCost(taskId,firstTick)
local data=UIXuanShangControl:getCDData(taskId)
local dtime=data.dtime
local ntime=data.ntime
if firstTick then
self.cdProgress:setChildUIProgressbar(dtime,ntime,false)
else
self.cdProgress:setChildUIProgressbar(dtime+1,ntime,true)
end
self.cdText:setText(timeHelper.format_time_stamp11(data.cd))
if data.cd<=0 then
self:clearTimer()
end
end
tick()
firstTick=false
local data=UIXuanShangControl:getCDData(taskId)
self.timer=self:setTimer(1,data.ntime+5,tick)
end

function UIXuanShangWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIXuanShangWin:setConditions(condition,taskId)
local seldata=self:getSelectDZData(taskId)or{}
for i,v in ipairs(self.conditions)do
local cnd=condition[i]
local check=self.checks[i]
if cnd then
v:setActive(true)
v:setText(UIXuanShangControl:getConditionText(cnd))
check:setImageSprite(UIXuanShangControl:checkPQCondition(seldata,cnd,false)and self.sprite_image_dygou or self.sprite_image_dycha)
else
v:setActive(false)
end
end
end

function UIXuanShangWin:getSelectConditions(condition)
local list={}
local slist={}
local jlist={}
for i,v in ipairs(condition)do
local stype=v[1]
local job=-1
table.insert(list,stype)
if stype==1 then
table.insert(slist,'境界')
elseif stype==2 then
table.insert(slist,'品质')
elseif stype==3 then
job=v[3]
table.insert(slist,UIDiscipleModel:getJobName(job))
end
table.insert(jlist,job)
end
return list,slist,jlist
end

function UIXuanShangWin:selectDZ(index,callback)
local data=self.datas[self.currSelect]
if UIXuanShangControl:isDispatching(data.taskId)then
return
end
local cfg=cfgHelper.get1(cfg_zongmenxuanshangtaskconfig_get,data.taskId)
local ulist,slist,jlist=self:getSelectConditions(self:getCondition(cfg))

local seldata=self:getSelectDZData(data.taskId)
local currDz
local ignore={}
if seldata then
for k,v in pairs(seldata)do
if k~=index then
ignore[tostring(v)]=true
else
currDz=v
end
end
end

zongmenControl:showSelectManagerWin(self.sfId,self.bdData,dzSelectWinOpenType.eXuanShang)
local args={
openType=dzSelectWinOpenType.eXuanShang,
effectType=dzSelectEffectType.ePlan,
bdData=self.bdData,
sfId=self.sfId,
funcIndex=1,
useList=ulist,
sortList=slist,
jobList=jlist,
ignore=ignore,
currDZ=currDz,
dzList=seldata or{},
taskId=data.taskId,
selectIndex=index,
callback=function(dzId)
callback(dzId)
end
}
discipleSelectController:openDiscipleSelect(args)
end

function UIXuanShangWin:checkPaiQian(seldata,wraning)
local data=self.datas[self.currSelect]
local cfg=cfgHelper.get1(cfg_zongmenxuanshangtaskconfig_get,data.taskId)
for i,v in ipairs(self:getCondition(cfg))do
if not UIXuanShangControl:checkPQCondition(seldata,v,wraning)then
return false
end
end
return true
end

function UIXuanShangWin:checkCanSelect(dzId)
local inTask=UIXuanShangControl:isDiscipleInTask(dzId)
if inTask then
return false
end

if UIDiscipleModel:checkDiscipleState2(dzId,DISCIPLE_STATE_TYPE.eChuiWei)then
return false
end

return true
end

function UIXuanShangWin:getPassList(nlevel,ncolor,njob)
local list=UIDiscipleModel:getSortList()
local datas={}
for i,v in ipairs(list)do
local guid=v.discipleguid
if self:checkCanSelect(guid)then
local level=v.jingjielv
local color=UIDiscipleModel:getDiscipleColor(guid)
local job=UIDiscipleModel:getDiscipleJob(guid)
local checkLevel=level>=nlevel
local checkColor=color>=ncolor
local checkJob=job==njob
if checkLevel or checkColor or checkJob then
local data={}
data.dzData=v
data.level=level
data.color=color
data.job=job
data.checkLevel=checkLevel
data.checkColor=checkColor
data.checkJob=checkJob
table.insert(datas,data)
end
end
end
return datas
end

function UIXuanShangWin:getSortList(stype,slist,nlevel,ncolor,njob)
local list=self:getPassList(nlevel,ncolor,njob)
for i,v in ipairs(list)do
local job=v.checkJob and 1 or 0
local sorts={}
if stype==1 then
if v.checkLevel then
sorts[4]=(v.checkColor and 1000 or 0)+(v.checkJob and 1000 or 0)
else
sorts[4]=0
end
elseif stype==2 then
if v.checkColor then
sorts[4]=(v.checkLevel and 1000 or 0)+(v.checkJob and 1000 or 0)
else
sorts[4]=0
end
elseif stype==3 then
if v.checkJob then
sorts[4]=(v.checkLevel and 1000 or 0)+(v.checkColor and 1000 or 0)
else
sorts[4]=0
end
end
sorts[1]=-v.level
sorts[2]=-v.color
sorts[3]=job
v.sorts=sorts
end
mathHelper.sortWeightListEx(list,'sorts',slist)
return list
end

function UIXuanShangWin:autoSelect()
local data=self.datas[self.currSelect]
local cfg=cfgHelper.get1(cfg_zongmenxuanshangtaskconfig_get,data.taskId)
local slist={}
local nlist={}
local clist={}
for i,v in ipairs(self:getCondition(cfg))do
local stype=v[1]
table.insert(slist,stype)
nlist[stype]=v[2]
clist[stype]=v[3]
end
local ncv=10000000
local rlist={}
local srlist={}
for i,v in ipairs(slist)do
local datas=self:getSortList(v,self.sortIndexs[v],clist[1]or ncv,clist[2]or ncv,clist[3]or-1)
table.insert(srlist,datas)
end

local srlen=#srlist
local count=0
local tlen=0
for i,v in ipairs(srlist)do
tlen=tlen+#v
end
local check=0
for i=1,tlen do
local index=count%srlen+1
local t=srlist[index]
local v=t[1]
if v then
table.remove(t,1)
local guid=v.dzData.discipleguid
local idstr=tostring(guid)
if not rlist[idstr]then
rlist[idstr]=guid
check=check+1
end
if check>=self.teamMaxNum then
break
end
end
end

local dzlist={}
for k,v in pairs(rlist)do
table.insert(dzlist,v)
end
return dzlist
end



function UIXuanShangWin:onQuickBtn()
if self.playCount~=0 then
return
end
local data=self.datas[self.currSelect]
local param=cfgHelper.get2(cfg_zongmenxuanshangtaskbaseconfig_get,1,'gsParam')
local cddata=UIXuanShangControl:getCDData(data.taskId)
local cd=cddata.cd
local use=math.ceil(cd/(param[1]*60))
local cost=use*param[3]


local content=FMT.fmt('是否消耗<color=#42b62f>{0}*{1}</color>立即完成？',itemsConfig.getItemName(param[2]),cost)
self:showDialog(content,nil,function()
local func=function()
UIXuanShangControl:reqQuickFinish(data.taskId)
end
moneySystem:useMoney(param[2],cost,func,WARNING_TYPE.eWarning)
end)



end

function UIXuanShangWin:onReceiveBtn()
if self.playCount~=0 then
return
end








UIXuanShangControl:reqReward(0)
end

function UIXuanShangWin:setHeadByDZList(dzlist)
if dzlist then
for i,v in ipairs(dzlist)do
if i<=self.teamMaxNum then
self:setHead(i,v)
end
end
end
end

function UIXuanShangWin:onSelectBtn()
local dzlist=self:autoSelect()
local len=#dzlist
if len>0 and self:checkPaiQian(dzlist)then
self:clearSelect()
self:setHeadByDZList(dzlist)
else
UIManager.error('没有符合要求的队伍')
end
end

function UIXuanShangWin:onApplyBtn()
if self.playCount~=0 then
return
end
local count=UIXuanShangControl:getFreeDispatchNum()
if count<=0 then
count=UIXuanShangControl:getItemDispatchNum()
if count<=0 then
UIManager.error('剩余派遣次数不足')
return
else
local useItem=cfgHelper.get2(cfg_zongmenxuanshangtaskbaseconfig_get,1,'useItem2')
local have=itemsModel.getCount(useItem[1])
if have<useItem[2]then

gainControl:showGainWin(useItem[1])
return
end
end
end
local data=self.datas[self.currSelect]
local seldata=self:getSelectDZData(data.taskId)or{}
if self:checkPaiQian(seldata,true)then
local list={}
for i,v in pairs(seldata)do
table.insert(list,v)
end
UIXuanShangControl:reqPaiQian(data.taskId,#list,list)
end
end

function UIXuanShangWin:onRefreshBtn()
if self.playCount~=0 then
return
end








local left=self:getUnPaiTaskCount()
if left==0 then
UIManager.error('所有任务均被接取')
return
end
local showTips
local check=UIXuanShangControl:getDialogShowFlag(1)
if not check then
local taskList=UIXuanShangControl:getTaskList()
for k,v in pairs(taskList)do
local cfg=cfgHelper.get1(cfg_zongmenxuanshangtaskconfig_get,v.taskId)
if cfg.color>=3 then
local cddata=UIXuanShangControl:getCDData(v.taskId)
if not cddata then
showTips=true
end
end
end
end
if showTips then





local desc='当前存在高品质的悬赏任务\n是否确认刷新？'
local func=function()
self:handleRefresh()
end
UIDialogManager.getConfirmDialog3(nil,desc,func,REPEAT_TYPE.eXuanShangHighQualityRefresh,nil,nil)
else
self:handleRefresh()
end
end

function UIXuanShangWin:handleRefresh()
local showTips
local check=UIXuanShangControl:getDialogShowFlag(2)
local count=UIXuanShangControl:getFreeRefreshNum()
if not check and count<=0 then
showTips=true
end
local useItem=cfgHelper.get2(cfg_zongmenxuanshangtaskbaseconfig_get,1,'useItem')
local useMoney=table.deepCopy(useItem)
if count>0 then
useMoney[2]=0
end
if showTips then






local desc=FMT.fmt('是否消耗{0}{1}来进行刷新？',useMoney[2],moneyModel.getMoneyName(useMoney[1]))
local func=function()
self:checkAndReqRefresh(useMoney)
end
UIDialogManager.getConfirmDialog3(nil,desc,func,REPEAT_TYPE.eXuanShangCostRefresh,nil,nil)
else
self:checkAndReqRefresh(useMoney)
end
end

function UIXuanShangWin:checkAndReqRefresh(useItem)
local func=function()
UIXuanShangControl:reqRefresh()
end
moneySystem:useMoney(useItem[1],useItem[2],func,WARNING_TYPE.eWarning)
end

function UIXuanShangWin:clearSelect()
for i,v in ipairs(self.headRoots)do
local widget=v:getChildWidgetBase()
widget:SetChildActive(1,false)
end
local data=self.datas[self.currSelect]
if data then
self.selectDZData[data.taskId]=nil
end
end

function UIXuanShangWin:setHead(index,dzId)
local headRoot=self.headRoots[index]
local widget=headRoot:getChildWidgetBase()
local data=self.datas[self.currSelect]
if dzId then
widget:SetChildActive(1,true)
self:setSelectDZData(data.taskId,index,dzId)
local dzData=UIDiscipleModel:getDiscipleData(dzId)
if dzData then
widget:SetChildActive(2,true)
widget:SetChildActive(4,false)
comHelper.setChildModelRawImage(widget,dzId,2,0,eHeadCenterType.eHead)
local jobicon=UIDiscipleModel:getJobIconNameX(dzId)
widget:SetChildCSImageSprite(3,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(dzId)
widget:SetChildActive(6,isSpDz)
local info=UIDiscipleModel:getDiscipleImageInfo(dzId)

comHelper.setChildModelHeadIconBGByColor(widget,5,info.color)
else
widget:SetChildActive(2,false)
widget:SetChildActive(4,true)

comHelper.setChildModelHeadIconBGByColor(widget,5,1)
end
else
self:setSelectDZData(data.taskId,index,nil)
widget:SetChildActive(1,false)
end
self:refreshCondition()
end

function UIXuanShangWin:onHeadRoot1()
self:selectDZ(1,function(dzId)
self:setHead(1,dzId)
end)
end

function UIXuanShangWin:onHeadRoot2()
self:selectDZ(2,function(dzId)
self:setHead(2,dzId)
end)
end

function UIXuanShangWin:onHeadRoot3()
self:selectDZ(3,function(dzId)
self:setHead(3,dzId)
end)
end

function UIXuanShangWin:showDialog(content,onChoose,onOK)
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
allowclickBG='false',
choosetext='本次登录不再提示',
choosecallback=onChoose,
okcallback=onOK,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end

function UIXuanShangWin:onHelpBtn()
UIManager:showWindow('UIXSLevelUpTipsWin')
end

function UIXuanShangWin:onRuleBtn()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='ui_xuanshang_rule_%s'})
end

function UIXuanShangWin:onJqItemIcon()
local useItem=cfgHelper.get2(cfg_zongmenxuanshangtaskbaseconfig_get,1,'useItem2')
tipsManager.showTips({formType=TIPS_FORM_TYPE.eClearBtn,itemid=useItem[1]})
end

function UIXuanShangWin:oncloseClick()

UIXuanShangControl:closeUI()
end