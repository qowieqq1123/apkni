







def_class("UIYYHYdafengshouWin",UIWindowBase)









function UIYYHYdafengshouWin:bindComponents()

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
self.rwScrollView2=UIObject.get(self,15)
self.titleyuhuo3=UIText.get(self,16)
self.closebtn1=UIButton.get(self,17)
self.chushouBtn=UIButton.get(self,18)
self.speakObjai=UIObject.get(self,19)
self.speakTextai=UIText.get(self,20)
self.jiacheng=UIImage.get(self,21)
self.titleyuhuotwo=UIText.get(self,22)
self.jifenimg=UIImage.get(self,23)
self.panela=UIObject.get(self,24)
self.panelb=UIObject.get(self,25)
self.panelc=UIObject.get(self,26)
self.rewardItema=UIObject.get(self,27)
self.paneld=UIObject.get(self,28)
self.rewardItemb=UIObject.get(self,29)
self.rewardItembb=UIObject.get(self,30)
self.rewardItemc=UIObject.get(self,31)
self.rewardItemcc=UIObject.get(self,32)
self.rewardItemccc=UIObject.get(self,33)
self.spinebg=UIObject.get(self,34)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.receiveBtn:setButtonClick(function()self:onReceiveBtn()end)

self.closebtn1:setButtonClick(function()self:onClosebtn1()end)

self.chushouBtn:setButtonClick(function()self:onChushouBtn()end)



end


function UIYYHYdafengshouWin:unbindComponents()
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
_UIObject_release(self.countDesc);self.countDesc=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.helpPanelPos);self.helpPanelPos=nil;
_UIObject_release(self.rwScrollView2);self.rwScrollView2=nil;
_UIObject_release(self.titleyuhuo3);self.titleyuhuo3=nil;
_UIObject_release(self.closebtn1);self.closebtn1=nil;
_UIObject_release(self.chushouBtn);self.chushouBtn=nil;
_UIObject_release(self.speakObjai);self.speakObjai=nil;
_UIObject_release(self.speakTextai);self.speakTextai=nil;
_UIObject_release(self.jiacheng);self.jiacheng=nil;
_UIObject_release(self.titleyuhuotwo);self.titleyuhuotwo=nil;
_UIObject_release(self.jifenimg);self.jifenimg=nil;
_UIObject_release(self.panela);self.panela=nil;
_UIObject_release(self.panelb);self.panelb=nil;
_UIObject_release(self.panelc);self.panelc=nil;
_UIObject_release(self.rewardItema);self.rewardItema=nil;
_UIObject_release(self.paneld);self.paneld=nil;
_UIObject_release(self.rewardItemb);self.rewardItemb=nil;
_UIObject_release(self.rewardItembb);self.rewardItembb=nil;
_UIObject_release(self.rewardItemc);self.rewardItemc=nil;
_UIObject_release(self.rewardItemcc);self.rewardItemcc=nil;
_UIObject_release(self.rewardItemccc);self.rewardItemccc=nil;
_UIObject_release(self.spinebg);self.spinebg=nil;
end
















local _task_item={
targetDes=0,
count=1,
gotoBtn=2,
receiveBtn=3,
receiveIcon=4,
rewards={5,6,7}
}

local _yuhuo_item={
icon=0,
textnum=3,
}

local _modelList={
2059,
2058,
2057,
2056,
2055,
}

local rewindex=
{
icon=0,
name=1,
xin=2,
weight=3,
min=4,
max=5,
bg=6,
shouhuo=7,
}

local _this
local abname_yyhy='ui/windows/yiyuhuiyou/yyhyimage_atlas_pak.ab'



function UIYYHYdafengshouWin:onLoaded(...)
_this=self
self:bindComponents()

self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)
self.targetScrollView:setChildScrollViewInit(0.5,true,nil,nil)









end


function UIYYHYdafengshouWin:__delete()
_this=nil
self:unbindComponents()
end




function UIYYHYdafengshouWin:onShow(argtable,afterOnloaded)















if argtable then
self.dafengshou_list=argtable[1]
else
self.dafengshou_list={}
end


























_this.spinebg:setActive(true)
_this.spinebg:setChildShowEffect(10321,true)
UIYYHYdafengshouWin:setTargetYuHuo()
end


function UIYYHYdafengshouWin:initSortGroups()
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

function UIYYHYdafengshouWin:getStartGroupIndex()
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

function UIYYHYdafengshouWin:refresh()
self:showCurrentGroup()
end

function UIYYHYdafengshouWin:callActivityFunc(fname,...)
return call_activitiesHandle_func('activitiesHandle_targetActivity',fname,self.actId,self.subId,...)
end

function UIYYHYdafengshouWin:callActivityInfoFunc(fname,...)
local info=activitiesModel:getSubActInfo(self.actId,SUB_ACTIVITY_TYPE.eMuBiaoHuoDong,self.subId)
return info[fname](info,...)
end


function UIYYHYdafengshouWin:onHide()

end

function UIYYHYdafengshouWin:startCountDown()
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

function UIYYHYdafengshouWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIYYHYdafengshouWin:showCurrentGroup()
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


local modelId=2059
if not modelId then
modelId=_modelList[#_modelList]
end
self.model:setChildUIModelShowTarget(modelId,1.5,{},eAnimationID.stand,false,false,0.5)
self.model:setChildUIModelShowFlipX(true)
end



function UIYYHYdafengshouWin:updataInfo()























end



function UIYYHYdafengshouWin:setTargetRewards()
local rewardlist=YiYuHuiYouModel:getRewardData()
local rewards={{2,200},{11079,10},{21015,3},{17320,60},{16001,40},{1,60000},}
local len=#rewards

_this.rwScrollView:setChildScrollViewCreateGrids(len,len)
local grids=_this.rwScrollView:getChildScrollViewItemWidgets()
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


function UIYYHYdafengshouWin:setTargetYuHuo()

local js_data=_this.dafengshou_list

if#js_data==1 then
_this.panela:setActive(true)
local itemid=js_data[1][1].itemid
local num=js_data[1][1].num or'-1'
local weight=js_data[1][1].weight or'-1'
local flag=js_data[1][2]

local cfg=itemsConfig.getConfig(itemid)
local name=cfg.name or'-1'


local item=_this.rewardItema:getWidgetBase()



local booksid=cfg.bookid
local modelid=cfg_ylcinfoconfig_get(booksid).model
local ssdata=isometricMapSystem:getModelScales2Pram(modelid,7)

item:SetChildUIModelShowTarget(rewindex.icon,modelid,ssdata[1],nil,eAnimationID.stand,true)





item:SetChildText(rewindex.name,name)
item:SetChildText(rewindex.weight,FMT.fmt('重量：{0}斤',weight))

if flag==1 then
item:SetChildActive(rewindex.min,true)
item:SetChildActive(rewindex.max,false)
item:SetChildActive(rewindex.shouhuo,false)
elseif flag==2 then
item:SetChildActive(rewindex.min,false)
item:SetChildActive(rewindex.max,true)
item:SetChildActive(rewindex.shouhuo,false)
elseif flag==0 then
item:SetChildActive(rewindex.min,false)
item:SetChildActive(rewindex.max,false)
item:SetChildActive(rewindex.shouhuo,true)
end

elseif#js_data==2 then
_this.panelb:setActive(true)

local guids={_this.rewardItemb,_this.rewardItembb}
for k,v in ipairs(js_data)do
local guid=guids[k]
local item=guid:getWidgetBase()

local itemid=v[1].itemid
local num=v[1].num or'-1'
local weight=v[1].weight or'-1'
local flag=v[2]

local cfg=itemsConfig.getConfig(itemid)
local name=cfg.name or'-1'

local booksid=cfg.bookid
local modelid=cfg_ylcinfoconfig_get(booksid).model
local ssdata=isometricMapSystem:getModelScales2Pram(modelid,7)

item:SetChildUIModelShowTarget(rewindex.icon,modelid,ssdata[1],nil,eAnimationID.stand,true)





item:SetChildText(rewindex.name,name)
item:SetChildText(rewindex.weight,FMT.fmt('重量：{0}斤',weight))

if flag==1 then
item:SetChildActive(rewindex.min,true)
item:SetChildActive(rewindex.max,false)
item:SetChildActive(rewindex.shouhuo,false)
elseif flag==2 then
item:SetChildActive(rewindex.min,false)
item:SetChildActive(rewindex.max,true)
item:SetChildActive(rewindex.shouhuo,false)
elseif flag==0 then
item:SetChildActive(rewindex.min,false)
item:SetChildActive(rewindex.max,false)
item:SetChildActive(rewindex.shouhuo,true)
end
end

elseif#js_data==3 then
_this.panelc:setActive(true)

local guids={_this.rewardItemc,_this.rewardItemcc,_this.rewardItemccc}
for k,v in ipairs(js_data)do
local guid=guids[k]
local item=guid:getWidgetBase()

local itemid=v[1].itemid
local num=v[1].num or'-1'
local weight=v[1].weight or'-1'
local flag=v[2]

local cfg=itemsConfig.getConfig(itemid)
local name=cfg.name or'-1'

local booksid=cfg.bookid
local modelid=cfg_ylcinfoconfig_get(booksid).model
local ssdata=isometricMapSystem:getModelScales2Pram(modelid,7)

item:SetChildUIModelShowTarget(rewindex.icon,modelid,ssdata[1],nil,eAnimationID.stand,true)





item:SetChildText(rewindex.name,name)
item:SetChildText(rewindex.weight,FMT.fmt('重量：{0}斤',weight))

if flag==1 then
item:SetChildActive(rewindex.min,true)
item:SetChildActive(rewindex.max,false)
item:SetChildActive(rewindex.shouhuo,false)
elseif flag==2 then
item:SetChildActive(rewindex.min,false)
item:SetChildActive(rewindex.max,true)
item:SetChildActive(rewindex.shouhuo,false)
elseif flag==0 then
item:SetChildActive(rewindex.min,false)
item:SetChildActive(rewindex.max,false)
item:SetChildActive(rewindex.shouhuo,true)
end
end

elseif#js_data>3 then
_this.paneld:setActive(true)

local len=#js_data
_this.rwScrollView2:setChildScrollViewCreateGrids(len,len)

local grids=_this.rwScrollView2:getChildScrollViewItemWidgets()
local count=grids.Count
for k,v in ipairs(js_data)do
local item=grids[k-1]
local itemid=v[1].itemid
local num=v[1].num or'-1'
local weight=v[1].weight or'-1'
local flag=v[2]

local cfg=itemsConfig.getConfig(itemid)
local name=cfg.name or'-1'

local booksid=cfg.bookid
local modelid=cfg_ylcinfoconfig_get(booksid).model
local ssdata=isometricMapSystem:getModelScales2Pram(modelid,7)

item:SetChildUIModelShowTarget(rewindex.icon,modelid,ssdata[1],nil,eAnimationID.stand,true)





item:SetChildText(rewindex.name,name)
item:SetChildText(rewindex.weight,FMT.fmt('重量：{0}斤',weight))

if flag==1 then
item:SetChildActive(rewindex.min,true)
item:SetChildActive(rewindex.max,false)
item:SetChildActive(rewindex.shouhuo,false)
elseif flag==2 then
item:SetChildActive(rewindex.min,false)
item:SetChildActive(rewindex.max,true)
item:SetChildActive(rewindex.shouhuo,false)
elseif flag==0 then
item:SetChildActive(rewindex.min,false)
item:SetChildActive(rewindex.max,false)
item:SetChildActive(rewindex.shouhuo,true)
end
end
end
end


function UIYYHYdafengshouWin:onClosebtn1()
self:closeSelf()




end

function UIYYHYdafengshouWin:onChushouBtn()
UIManager.error('快速出售')
end



function UIYYHYdafengshouWin:doSpeaking()
local ku_id=1
if _this.iswin==0 then
ku_id=1
else
ku_id=2
end
local speakList=cfg_yiyuhuiyouspeckkuconfig_get(ku_id).text_list
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
_this.speakObjai:setChildCanvasGroupAlpha(1)
_this.speakTextai:setChildTrendsTextPlay(speakStr,speed,nil)
_this:doTalkAnim()
end

function UIYYHYdafengshouWin:doTalkAnim()
if _this.talkTween~=nil then
_this.talkTween:Kill()
_this.talkTween=nil
end
_this.speakObjai:setScale(Vector3.zero)
_this:delayDo(0.2,function()
_this.speakObjai:setChildCanvasGroupAlpha(1)
_this.talkTween=_this.speakObjai:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween=nil
_this.talkTween=_this.speakObjai:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween=nil
end)
end)
end)
end



function UIYYHYdafengshouWin:setTargetTasks()
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
self:callActivityFunc('reqTaskReward',taskId)
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

function UIYYHYdafengshouWin:getTargetDatas()
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



function UIYYHYdafengshouWin:showPageBtn()
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

function UIYYHYdafengshouWin:onLeftBtn()
if self.groupIndex>1 then
self.groupIndex=self.groupIndex-1
self.groupId=self.groups[self.groupIndex]
self:showCurrentGroup()
self:showPageBtn()
end
end

function UIYYHYdafengshouWin:onRightBtn()
if self.groupIndex<#self.groups then
self.groupIndex=self.groupIndex+1
self.groupId=self.groups[self.groupIndex]
self:showCurrentGroup()
self:showPageBtn()
end
end

function UIYYHYdafengshouWin:onReceiveBtn()
local isComplete=self:callActivityInfoFunc('isGroupComplete',self.subId,self.groupId)
if isComplete then
self:callActivityFunc('reqGroupReward',self.groupId)
else
UIManager.error('完成本轮全部任务方可领取')
end
end

function UIYYHYdafengshouWin:onHelpBtn()
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

function UIYYHYdafengshouWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil})
end
