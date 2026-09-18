







def_class("UISubAct_DaoBingGeWin",UIWindowBase)









function UISubAct_DaoBingGeWin:bindComponents()

self.spmodel=UIObject.get(self,0)
self.mainPanelRoot=UIObject.get(self,1)
self.taskPanelRoot=UIObject.get(self,2)
self.leftMainRoot=UIObject.get(self,3)
self.buyRoot=UIObject.get(self,4)
self.taskRoot=UIObject.get(self,5)
self.leftBtnsRoot=UIObject.get(self,6)
self.godbBtn=UIButton.get(self,7)
self.slBtn=UIButton.get(self,8)
self.timeText=UIText.get(self,9)
self.exp=UIText.get(self,10)
self.expPB=UIObject.get(self,11)
self.selectModel=UIObject.get(self,12)
self.taskscrollView=UIObject.get(self,13)
self.level=UIText.get(self,14)
self.dayTaskBtn=UIButton.get(self,15)
self.taskBtn=UIButton.get(self,16)
self.buyLevelBtn=UIButton.get(self,17)
self.unlock=UIButton.get(self,18)
self.dbmodel=UIObject.get(self,19)
self.dbclick=UIButton.get(self,20)
self.switchDaoBing=UIButton.get(self,21)
self.scrollView=UIObject.get(self,22)
self.spReward=UIObject.get(self,23)
self.taskReddot=UIObject.get(self,24)
self.reddot=UIObject.get(self,25)

self.godbBtn:setButtonClick(function()self:onGodbBtn()end)

self.slBtn:setButtonClick(function()self:onSlBtn()end)

self.dayTaskBtn:setButtonClick(function()self:onDayTaskBtn()end)

self.taskBtn:setButtonClick(function()self:onTaskBtn()end)

self.buyLevelBtn:setButtonClick(function()self:onBuyLevelBtn()end)

self.unlock:setButtonClick(function()self:onUnlock()end)

self.dbclick:setButtonClick(function()self:onDbclick()end)

self.switchDaoBing:setButtonClick(function()self:onSwitchDaoBing()end)


self.sprite_image_xianshuui_15=0
self.sprite_image_xianshuui_14=1

end


function UISubAct_DaoBingGeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.spmodel);self.spmodel=nil;
_UIObject_release(self.mainPanelRoot);self.mainPanelRoot=nil;
_UIObject_release(self.taskPanelRoot);self.taskPanelRoot=nil;
_UIObject_release(self.leftMainRoot);self.leftMainRoot=nil;
_UIObject_release(self.buyRoot);self.buyRoot=nil;
_UIObject_release(self.taskRoot);self.taskRoot=nil;
_UIObject_release(self.leftBtnsRoot);self.leftBtnsRoot=nil;
_UIObject_release(self.godbBtn);self.godbBtn=nil;
_UIObject_release(self.slBtn);self.slBtn=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.exp);self.exp=nil;
_UIObject_release(self.expPB);self.expPB=nil;
_UIObject_release(self.selectModel);self.selectModel=nil;
_UIObject_release(self.taskscrollView);self.taskscrollView=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.dayTaskBtn);self.dayTaskBtn=nil;
_UIObject_release(self.taskBtn);self.taskBtn=nil;
_UIObject_release(self.buyLevelBtn);self.buyLevelBtn=nil;
_UIObject_release(self.unlock);self.unlock=nil;
_UIObject_release(self.dbmodel);self.dbmodel=nil;
_UIObject_release(self.dbclick);self.dbclick=nil;
_UIObject_release(self.switchDaoBing);self.switchDaoBing=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.spReward);self.spReward=nil;
_UIObject_release(self.taskReddot);self.taskReddot=nil;
_UIObject_release(self.reddot);self.reddot=nil;
end

















local _this
local _animationId="xianshu_light"
local _tabType=
{
eDayTask=1,
eTask=2,
eBuyLevel=3,
}
local _taskType=
{
eDayTask=1,
eTask=2,
}

local _taskData=
{
[_tabType.eDayTask]=
{
tasktype=_taskType.eDayTask,
cfg=function(model)
return model:getDayTaskCfg()
end,
data=function(model,taskline,idx)
return model:getDayTaskData(taskline,idx)
end,
reddot=function(model)
return model:hasDayTaskReddot()
end
},
[_tabType.eTask]={
tasktype=_taskType.eTask,
cfg=function(model)
return model:getTaskCfg()
end,
data=function(model,taskline,idx)
return model:getTaskData(taskline,idx)
end,
reddot=function(model)
return model:hasTaskReddot()
end
}
}

function UISubAct_DaoBingGeWin:onLoaded(...)
self:bindComponents()

_this=self

self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)

self.winlua:SetChildScrollViewInitScrollEvent(self.scrollView:getID(),240,60,function(index)
local nextlevel=self:getNextSPRewardLevel(index+2)
if self.showSPLevel~=nextlevel then
self.showSPLevel=nextlevel
local clevel=self:getNextSPRewardLevel()
local maxLevel=self.maxLevel
local isFinish=clevel>=maxLevel
if not isFinish then
self:freshSpecialItem(nextlevel)
end
end
end)
self:addNotify(notifyConfig.on_money_changed,function(...)self:onMoneyChanged(...)end)

local btnlist={}
btnlist[#btnlist+1]=self.dayTaskBtn
btnlist[#btnlist+1]=self.taskBtn
self.btnlist=btnlist
self.tasktimer={}
self:addNotify(notifyConfig.onNewDay,function(...)
if self.page~=2 then return end
if tabType==_tabType.eBuyLevel then return end
self:freshTaskList()
self:freshTaskBtns()
self:freshBuyRoot()
end)
end

function UISubAct_DaoBingGeWin:__delete()
self.scrollView:setChildScrollViewStopGridCreate()
self:unbindComponents()
_this=nil
end

function UISubAct_DaoBingGeWin:onShow(argtable,afterOnloaded)
local actId=argtable.act_id
local subType=argtable.sub_act_type
local subId=argtable.sub_act_id
self.actId=actId
self.subType=subType
self.subId=subId
self.subCfg=activitiesModel:getSubActivityConfig(subType,subId)
self.model=activitiesModel:getSubActInfo(actId,subType,subId)
self.data=self.model:getData()
self.showSpeEffect1=false
self.showSpeEffect2=false

self.selectitemid=self.model:getRecordDaoBingItemid()

self.page=1
self:freshInfo()
if self.selectitemid==nil then
weakGuideController:beginGuide(3550)
end
end

function UISubAct_DaoBingGeWin:onHide()
self.dbmodel:setChildShowEffect(0,false)
end





function UISubAct_DaoBingGeWin:onSlBtn()
self:openBuyPanel()
end

function UISubAct_DaoBingGeWin:onGodbBtn()
self:openMainPanel()
end



function UISubAct_DaoBingGeWin:onUnlock()
UIManager:showWindow('UISubAct_DaoBingGeActiveWin',
{actId=self.actId,subType=self.subType,subId=self.subId})
end

function UISubAct_DaoBingGeWin:onDbclick()
UIManager:showWindow('UISubAct_DaoBingGePreviewWin',
{actId=self.actId,subType=self.subType,subId=self.subId})
end

function UISubAct_DaoBingGeWin:onSwitchDaoBing()
UIManager:showWindow('UISubAct_DaoBingGePreviewWin',
{actId=self.actId,subType=self.subType,subId=self.subId})
end

function UISubAct_DaoBingGeWin:freshInfo()
if self.page==1 then
self:freshMainInfo()
else
self:freshTaskInfo()
end
end

function UISubAct_DaoBingGeWin:openMainPanel()
if self.page==1 then return end
self.page=1
self:freshMainInfo()
self.leftMainRoot:setChildCanvasGroupAlpha(0)
self.fadetimer=self:delayDo(0.3,function()
self.leftMainRoot:setChildCanvasGroupDOFade(1,0.5)
end)
end

function UISubAct_DaoBingGeWin:freshMainInfo()
self.page=1
self.mainPanelRoot:setActive(true)
self.taskPanelRoot:setActive(false)
self:freshModel(2040)
self:freshArgs()
self:freshTop()
self:freshGrids()
self:stopFadeTimer()
self:freshSpecialItem()
self:freshZhuanShu()
self:freshUnlcokBtn()
end

function UISubAct_DaoBingGeWin:freshArgs()
local subCfg=self.subCfg
local actId=self.actId
local subType=self.subType
local subId=self.subId
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
local prizelv,prizeluxuryLv=self.model:getPrizelv()
self.norRLevel=prizelv
self.speRLevel=prizeluxuryLv
self.curLevel=data.lv

self.lvrewards=subCfg.lv_rewards
local lv_info=subCfg.lv_info
self.needExp=lv_info[2]
self.maxLevel=lv_info[1]
self.moneyType=subCfg.money_type

self.selectLevel=nil
self.buyMoneyType=subCfg.buy_cost[1]
end

function UISubAct_DaoBingGeWin:freshTop()
local actId=self.actId
local subType=self.subType
local subId=self.subId
local subCfg=self.subCfg
local lv_info=subCfg.lv_info
local needExp=self.needExp
local maxLevel=self.maxLevel
local level=self.curLevel
if level<maxLevel then
local exp=moneyModel.getMoney(self.moneyType)
self.exp:setText(FMT.fmt('{0}/{1}',exp,needExp))
self.expPB:setChildUIProgressbar(exp,needExp,false)
else
self.exp:setText('已满级')
self.expPB:setChildUIProgressbar(1,1,false)
end

self.level:setText(level)

self:freshTime()

self:freshTopBtn()
end

function UISubAct_DaoBingGeWin:freshTopBtn()
self.slBtn:setActive(self.page==1)
self.godbBtn:setActive(self.page==2)
self.taskReddot:setActive(self.model:hasDayTaskReddot()or
self.model:hasTaskReddot())
self.reddot:setActive(self.model:hasAnyPrize())
end

function UISubAct_DaoBingGeWin:freshExp()
local actId=self.actId
local subType=self.subType
local subId=self.subId
local subCfg=self.subCfg
local needExp=self.needExp
local maxLevel=self.maxLevel
local level=self.curLevel
if level<maxLevel then
local exp=moneyModel.getMoney(self.moneyType)
self.exp:setText(FMT.fmt('{0}/{1}',exp,needExp))
self.expPB:setChildUIProgressbar(exp,needExp,false)
else
self.exp:setText('已满级')
self.expPB:setChildUIProgressbar(1,1,false)
end
end


function UISubAct_DaoBingGeWin:freshTime()
if self.timer then
self:stopTimerByID(self.timer)
end
local actId=self.actId
local subType=self.subType
local subId=self.subId
local model=self.model
local activityCfg=activitiesModel:getSubActivityConfig(subType,subId)
local activityData=activitiesModel:getSubActInfoData(actId,subType,subId)
local func=function()
local endTime=model.end_time
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=endTime-nowTime
self.timeText:setText(FMT.fmt("剩余活动时间：{0}",timeHelper.format_time_stamp3(lerp,true)))
end
self.timer=self:setTimer(1,0,func)
func()
end

function UISubAct_DaoBingGeWin:freshGrids()
local actId=self.actId
local subType=self.subType
local subId=self.subId
local subCfg=self.subCfg
local len=#self.lvrewards
self.scrollView:setChildScrollViewDelayCreateGrids(len,0,0.02,5,false,false,function(index,item)
local level=index+1
self:setRewardItem(level,item)
if level==self.curLevel then
self.scrollView:setChildScrollViewSelectItem(index,false,false,false)
end
end)
end

function UISubAct_DaoBingGeWin:freshItemLevel(index,item)
local level=index
local curLevel=self.curLevel
local levelwidget=item:GetChildWidgetBase(3)
levelwidget:SetChildText(0,FMT.fmt('{0}级',level))


end

function UISubAct_DaoBingGeWin:setRewardItem(index,item,speReward)
local data=self.lvrewards[index]
local level=index
local topwidget=item:GetChildWidgetBase(0)
local bottomwidget=item:GetChildWidgetBase(1)
local model=self.model
local prizelv=self.norRLevel
local prizeluxuryLv=self.speRLevel
local curLevel=self.curLevel
local canPrize=level<=curLevel


local isPrize=prizelv>=level
local rewards=data[1]or{}
local rewards1=rewards[1]or{}
local rewards2=rewards[2]or{}
local len1=#rewards1
local len2=#rewards2
local hasReward1=len1>0
local hasReward2=len2>0
local showAnimation=canPrize and not isPrize
local itemwidget=bottomwidget
itemwidget:SetChildActive(0,hasReward1)
itemwidget:SetChildActive(1,hasReward2)
if hasReward1 then
self:freshItem(itemwidget,0,rewards1,false,isPrize,showAnimation,false)
end
if hasReward2 then
self:freshItem(itemwidget,1,rewards2,false,isPrize,showAnimation,false)
end


local isRecharge=model:isRecharge()
local isPrize=level<=prizeluxuryLv
local rewards=data[2]or{}
local rewards1=rewards[1]or{}
local rewards2=rewards[2]or{}
local len1=#rewards1
local len2=#rewards2
local hasReward1=len1>0
local hasReward2=len2>0
local showAnimation=canPrize and not isPrize and isRecharge
local itemwidget=topwidget

itemwidget:SetChildActive(0,hasReward1)
itemwidget:SetChildActive(1,hasReward2)
if hasReward1 then
self:freshItem(itemwidget,0,rewards1,not isRecharge,isPrize,showAnimation,not isRecharge)
end
if hasReward2 then
self:freshItem(itemwidget,1,rewards2,not isRecharge,isPrize,showAnimation,not isRecharge)
end



item:SetChildActive(2,canPrize)

self:freshItemLevel(index,item)

item:SetChildButtonClick(2,function()
local func=function()
local uit={4,level}
local jsonStr=jsonHelper.encode(uit)
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actId,self.subType,self.subId,jsonStr)
end
if self.norRLevel<self.curLevel then
func()
return
end
if isRecharge and self.speRLevel<self.curLevel then
func()
return
end
end,true)
end

function UISubAct_DaoBingGeWin:getNextSPRewardLevel(level)
if not level then
level=math.min(self.norRLevel,self.speRLevel)
if level<1 then level=1 end
end
for i=level,#self.lvrewards do
local cfg=self.lvrewards[i]
if cfg[3]==1 then
return i
end
end
return#self.lvrewards
end

function UISubAct_DaoBingGeWin:freshSpecialItem(index)
local item=self.spReward:getChildWidgetBase()
local level=self:getNextSPRewardLevel()
local maxLevel=self.maxLevel
local isRecharge=self.model:isRecharge()
local cost_num=self.subCfg.cost_num
local curLevel=self.curLevel
local isMax=curLevel>=maxLevel


item:SetChildActive(4,isMax)

item:SetChildActive(6,not isMax)

self:setRewardItem(index or level,item,true)


item:SetChildActive(7,not isMax)


item:SetChildActive(8,isMax)

if isMax then

local levelwidget=item:GetChildWidgetBase(3)
levelwidget:SetChildActive(-1,false)


local specailwidget=item:GetChildWidgetBase(4)
local moneyType=self.moneyType
local exp=moneyModel.getMoney(moneyType)
local canPrize=exp>=self.needExp
specailwidget:SetChildText(2,FMT.fmt('{0}/{1}',exp,self.needExp))


item:SetChildActive(2,canPrize)

local gift=self.subCfg.gift
specailwidget:SetChildText(3,FMT.fmt('每{0}点经验可兑换一个道兵阁宝',cost_num))

local func1=function()
local func=function()
local exp=moneyModel.getMoney(self.moneyType)
local num=math.floor(exp/cost_num)
if num>0 then
local uit={3,num}
local jsonStr=jsonHelper.encode(uit)
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actId,self.subType,self.subId,jsonStr)
end
end
func()












end

if canPrize then
item:SetChildButtonClick(2,func1)
self:freshItem(specailwidget,1,gift,false,false,canPrize,nil,func1)
else
self:freshItem(specailwidget,1,gift,false,false,canPrize)
end
end
end

function UISubAct_DaoBingGeWin:freshZhuanShu()
if self.page==2 then return end
local itemid=self.selectitemid
local hasModel=itemid~=nil
self.selectModel:setActive(not hasModel)
if hasModel then
local itemsCfg=itemsConfig.getConfig(itemid)
local modelParams=itemsCfg.model
local effectInfo=modelParams[1]
self.dbmodel:setChildShowEffect(effectInfo[1],true)
self.dbclick:setActive(false)
self.switchDaoBing:setActive(true)
else
self.dbmodel:setChildShowEffect(0,false)
self.dbclick:setActive(true)
self.switchDaoBing:setActive(false)
end
end

function UISubAct_DaoBingGeWin:freshModel(ani)
if self.modelAni==ani then return end
self.spmodel:setChildUIModelShowTarget(4111,1,{},ani)
self.modelAni=ani
end

function UISubAct_DaoBingGeWin:freshUnlcokBtn()
local isRechargeBest=self.model:isRechargeBest()
self.unlock:setActive(not isRechargeBest)
end

function UISubAct_DaoBingGeWin:freshItem(widget,index,data,gray,isPrize,showAni,lock,action)
local item=widget:GetChildWidgetBase(index)
local itemid=data[1]
local itemCount=data[2]or 1
local itemCfg=itemsConfig.getConfig(itemid)
gray=gray or false
isPrize=isPrize or false
showAni=showAni or false
item:SetChildQulaityEx(1,itemCfg.colorPage or 0,itemCfg.color)
item:SetChildIcon(2,iconHelper.getIconName(itemid),true)
itemsComponentHelper.setUIBaseItemSmallSignCommon(item,2,itemid,gray,nil)
item:SetChildActive(3,gray)
item:SetChildActive(4,itemCount>1)
item:SetChildText(5,itemCount>1 and mathHelper.formatNumber2(itemCount)or'')
item:SetChildActive(6,isPrize)
item:SetChildActive(7,showAni)
item:SetChildActive(8,lock or false)
if showAni then
item:SetChildAnimationStringID(7,_animationId,false)
end
item:SetChildButtonClick(2,function()
if action then
action()
else
itemsComponentHelper.onItemClickEx(itemid)
end
end,true)
end

function UISubAct_DaoBingGeWin:onMoneyChanged(moneyType,oldVal,newVal)
if self.moneyType==moneyType then
self:freshExp()
if self.page==1 then
self:freshSpecialItem()
end
elseif moneyType==self.buyMoneyType then
if self.page==2 then
self:freshBuyMoney()
end
end
end

function UISubAct_DaoBingGeWin:onChangeDaoBing(itemid)
if self.page~=1 then return end
if self.selectitemid==itemid then return end
self.selectitemid=itemid
self:freshZhuanShu()
end

function UISubAct_DaoBingGeWin:onExchargeDaoBing(itemid)
if self.page~=1 then return end
if self.selectitemid==itemid then return end
self.selectitemid=itemid
self:freshZhuanShu()
end


function UISubAct_DaoBingGeWin:showDialog(content,callback,ok,cancel)
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext=ok or'确定',
canceltext=cancel or'取消',
allowclickBG='false',
okcallback=callback,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end



function UISubAct_DaoBingGeWin:openBuyPanel()
if self.page==2 then return end
self.page=2
self.taskPanelRoot:setActive(true)
self.mainPanelRoot:setActive(false)
self.tabType=self.tabType or _tabType.eDayTask
self:freshArgs()
self:freshModel(2068)
self:freshTaskList()
self:freshTop()
self:freshBuyRoot()
self:freshBuyMoney()
self:freshTaskBtns()
self.leftBtnsRoot:setChildCanvasGroupAlpha(0)
self.fadetimer=self:delayDo(0.3,function()
self.leftBtnsRoot:setChildCanvasGroupDOFade(1,0.5)
end)
end

function UISubAct_DaoBingGeWin:stopFadeTimer()
if self.fadetimer then
self:stopTimerByID(self.fadetimer)
end
self.fadetimer=nil
self.leftBtnsRoot:setChildCanvasGroupAlpha(1)
self.leftMainRoot:setChildCanvasGroupAlpha(1)
end

function UISubAct_DaoBingGeWin:onBuyRet()
if self.page==1 then return end
self:freshArgs()
self:freshTop()
self:freshTaskList()
self:freshBuyRoot()
self:freshBuyMoney()
end

function UISubAct_DaoBingGeWin:onSelectTab(tab)
if tab==self.tabType then return end
self.tabType=tab
self.selectLevel=nil
self:freshTaskInfo()
end

function UISubAct_DaoBingGeWin:onBuyBtn()
local subCfg=self.subCfg
local buycost=subCfg.buy_cost
local moneyType=buycost[1]
local cost=buycost[2]
local need=cost*self.buyLevelNum
local have=moneyModel.getMoney(moneyType)
local func1=function()
local func=function()
local uit={2,self.selectLevel}
local jsonStr=jsonHelper.encode(uit)
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actId,self.subType,self.subId,jsonStr)
end
moneySystem:useMoney(moneyType,need,func,WARNING_TYPE.eWarning)
end
local moneyname=moneyModel.getMoneyName(moneyType)
local str=FMT.fmt('是否确定花费{0}{1}购买至等级{2}？',need,moneyname,self.selectLevel)
UIDialogManager.getConfirmDialog3(nil,str,func1,REPEAT_TYPE.eBuyDaoBingLv)
end

function UISubAct_DaoBingGeWin:onAddBtn()
if self.selectLevel>=self.maxLevel then return end
self.createCount=18
local widget=self.buyRoot:getWidgetBase()
widget:SetChildSliderValue(2,self.selectLevel+1)
self.createCount=1
end

function UISubAct_DaoBingGeWin:onCutBtn()
if self.selectLevel<=self.minLevel then return end
self.createCount=18
local widget=self.buyRoot:getWidgetBase()
widget:SetChildSliderValue(2,self.selectLevel-1)
self.createCount=1
end

function UISubAct_DaoBingGeWin:onDayTaskBtn()
self:onSelectTab(_tabType.eDayTask)
end



function UISubAct_DaoBingGeWin:onTaskBtn()
self:onSelectTab(_tabType.eTask)
end



function UISubAct_DaoBingGeWin:onBuyLevelBtn()
self:onSelectTab(_tabType.eBuyLevel)
end


function UISubAct_DaoBingGeWin:freshTaskInfo()
self.page=2
self.mainPanelRoot:setActive(false)
self.taskPanelRoot:setActive(true)
self:freshModel(2068)
self:freshArgs()
self:freshTop()
self:freshTaskBtns()
self:freshTaskList()
self:freshBuyRoot()
self:freshBuyMoney()
end

function UISubAct_DaoBingGeWin:freshCurTaskInfo()
if self.page~=2 then return end
self:freshTaskInfo()
end

function UISubAct_DaoBingGeWin:freshTaskArgs()
local subCfg=self.subCfg
local actId=self.actId
local subType=self.subType
local subId=self.subId
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
self.curLevel=data.lv
self.lvrewards=subCfg.lv_rewards
local lv_info=subCfg.lv_info
self.needExp=lv_info[2]
self.maxLevel=lv_info[1]
self.moneyType=subCfg.money_type
self.selectLevel=nil
self.buyMoneyType=subCfg.buy_cost[1]
end

function UISubAct_DaoBingGeWin:freshTaskBtns()
self:stopFadeTimer()
local tabType=self.tabType
for i,v in ipairs(self.btnlist)do
local widget=v:getWidgetBase()
widget:SetChildActive(0,tabType~=i)
widget:SetChildActive(1,tabType==i)
widget:SetChildActive(2,_taskData[i].reddot(self.model))
end

self:freshBuyLevelBtn()
end

function UISubAct_DaoBingGeWin:freshBuyLevelBtn()
local tabType=self.tabType
local buy_open_day=self.subCfg.buy_open_day
local dayIdx=self.model:getOpenDayIndex()
local maxLevel=self.maxLevel
local level=self.curLevel
local max=level>=maxLevel

self.buyLevelBtn:setActive(dayIdx>=buy_open_day and not max)

local widget=self.buyLevelBtn:getWidgetBase()
widget:SetChildActive(0,tabType~=_tabType.eBuyLevel)
widget:SetChildActive(1,tabType==_tabType.eBuyLevel)
widget:SetChildActive(2,false)
end

function UISubAct_DaoBingGeWin:freshReddot()
for i,v in ipairs(self.btnlist)do
local widget=v:getWidgetBase()
widget:SetChildActive(2,_taskData[i].reddot(self.model))
end
end

function UISubAct_DaoBingGeWin:getTaskCfgs()
local tabType=self.tabType
local cfgs=_taskData[tabType].cfg(self.model)
local taskType=_taskData[tabType].tasktype
local temp={}
local sortTag={}
local check={}
for _,v in ipairs(cfgs)do
local idx=v[1]
local taskCfg=v[2]
local taskline=v[3]
local task=_taskData[tabType].data(self.model,taskline,idx)or{}
local sort=taskCfg[5]or idx
if check[sort]then
loggerUtil.logErrFMT('任务排序配置相同，请修复！')
end
check[sort]=true
local canPrizeTag=self.model:canPrizeByCfg(taskType,taskline,idx,taskCfg)and 1 or 0
local isPrizeTag=self.model:isPrize(task)and 1 or 0
sortTag[taskline*100+idx]=canPrizeTag*1000000+sort-isPrizeTag*100
end

table.sort(cfgs,function(a,b)
return sortTag[a[3]*100+a[1]]>sortTag[b[3]*100+b[1]]
end)

return cfgs
end

function UISubAct_DaoBingGeWin:freshTaskList()
local tabType=self.tabType
local vis=tabType~=_tabType.eBuyLevel
self.taskRoot:setActive(vis)
if not vis then return end
local taskList=self:getTaskCfgs()
local taskType=_taskData[tabType].tasktype
local len=#taskList
local subCfg=self.subCfg
local model=self.model
self.taskscrollView:setChildScrollViewCreateGrids(len,1)

local grids=self.taskscrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local cfg=taskList[i]
local idx=cfg[1]
local taskCfg=cfg[2]
local taskline=cfg[3]
local taskInfo=taskCfg[6]
local jumpArgs=taskCfg[7]
local task=_taskData[tabType].data(self.model,taskline,idx)or{}
local num=task.task_progress or 0
local flag=task.task_flag or 0
local canPrize=model:canPrizeByCfg(taskType,taskline,idx,taskCfg)
local isPrize=model:isPrize(task)
local visGo=not canPrize and not isPrize or false
local desc=FMT.fmt('{0}<color=#7d3b17>({1}/{2})</color>',taskInfo[2],num,taskCfg[2][1])
item:SetChildText(0,taskInfo[1])
item:SetChildText(1,desc)


item:SetChildActive(2,visGo)
if visGo then
item:SetChildButtonClick(2,function()
jumpManager:jump(jumpArgs)
end)
end


item:SetChildActive(3,canPrize)
if canPrize then
item:SetChildButtonClick(3,function()
local uit={1}
local jsonStr=jsonHelper.encode(uit)
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actId,self.subType,self.subId,jsonStr)
end)
end


item:SetChildActive(4,isPrize)

widgetHelper.setNormalRewardItem(item,5,taskCfg[2][3])

item:SetChildActive(4,isPrize)

self:startTaskTimer(item,taskType,taskline,idx,taskCfg)
end
end

function UISubAct_DaoBingGeWin:freshBuyRoot()
local tabType=self.tabType
local vis=tabType==_tabType.eBuyLevel
self.buyRoot:setActive(vis)
if not vis then return end

local curLevel=self.data.lv
if self.selectLevel==nil then
self.selectLevel=curLevel+1
end
if self.selectLevel>self.maxLevel then self.selectLevel=self.maxLevel end
self.minLevel=self.selectLevel

local subCfg=self.subCfg
self.createCount=1
self.buyLevelNum=self.selectLevel-curLevel

local needexp=self.needExp
local buycost=subCfg.buy_cost
local costMoneyType=buycost[1]
local cost=buycost[2]
local model=self.model
local isMax=curLevel>=self.maxLevel

local widget=self.buyRoot:getWidgetBase()

widget:SetChildScrollViewStopGridCreate(4)

widget:SetChildScrollViewCreateGrids(4,0,0)

widget:SetChildButtonClick(0,function()
self:onCutBtn()
end,true)
widget:SetChildActive(0,not isMax)

widget:SetChildButtonClick(1,function()
self:onAddBtn()
end,true)
widget:SetChildActive(1,not isMax)

widget:SetChildSliderInit(2,self.selectLevel,self.selectLevel,self.maxLevel,function(val)
if val~=self.selectLevel then
self.selectLevel=val
self:freshBuyInfo(val)
end
end)
widget:SetChildActive(2,not isMax)

widget:SetChildButtonClick(3,function()
self:onBuyBtn()
end,true)
widget:SetChildActive(3,not isMax)
local isRecharge=self.model:isRecharge()
local datas={}
if not isMax then
local nextLevel=curLevel+1
datas=self.model:getBuyPrizeByRecharge(isRecharge,nextLevel,self.selectLevel)
end

local len=#datas
widget:SetChildScrollViewDelayCreateGrids(4,len,0,0.02,self.createCount,false,false,function(index,item)
local data=datas[index+1]
widgetHelper.setNormalRewardItem(item,0,data)
end)

widget:SetChildText(5,isMax and'道兵阁已满级'or FMT.fmt('道兵阁等级提升至{0}级，可获得以下奖励',self.selectLevel))

widget:SetChildText(6,not isMax and FMT.fmt('购买至{0}级',self.selectLevel)or'')

local need=cost*self.buyLevelNum
local have=moneyModel.getMoney(costMoneyType)
local str=have>=need and need or FMT.fmt('<color=red>{0}</color>',need)
widget:SetChildText(7,str)

widget:SetChildIcon(8,iconHelper.getIconName(costMoneyType),true)

widget:SetChildActive(9,isMax)
end

function UISubAct_DaoBingGeWin:freshBuyMoney()
local widget=self.buyRoot:getWidgetBase()
local moneyType=self.buyMoneyType
widget:SetChildText(12,moneyModel.getMoney(moneyType))
local moneyIconName=iconHelper.getIconName(moneyType)
widget:SetChildIcon(11,moneyIconName,false)
widget:SetChildButtonClick(10,function()
gainControl:showGainWin(moneyType)
end)
end

function UISubAct_DaoBingGeWin:freshBuyInfo(buylv)
local curLevel=self.data.lv
self.selectLevel=buylv

local subCfg=self.subCfg
self.createCount=1
self.buyLevelNum=buylv-curLevel


local needexp=self.needExp
local buycost=subCfg.buy_cost
local moneyType=buycost[1]
local cost=buycost[2]
local isRecharge=self.model:isRecharge()

local widget=self.buyRoot:getWidgetBase()

widget:SetChildScrollViewStopGridCreate(4)

widget:SetChildScrollViewCreateGrids(4,0,0)

local datas=self.model:getBuyPrizeByRecharge(isRecharge,curLevel+1,self.selectLevel)
local len=#datas
widget:SetChildScrollViewDelayCreateGrids(4,len,0,0.02,self.createCount,false,false,function(index,item)
local data=datas[index+1]
widgetHelper.setNormalRewardItem(item,0,data)
end)

widget:SetChildText(5,FMT.fmt('道兵阁等级提升至{0}级，可获得以下奖励',self.selectLevel))

widget:SetChildText(6,FMT.fmt('购买至{0}级',self.selectLevel))

local need=cost*self.buyLevelNum
local have=moneyModel.getMoney(moneyType)
local str=have>=need and need or FMT.fmt('<color=red>{0}</color>',need)
widget:SetChildText(7,str)
end

function UISubAct_DaoBingGeWin:freshExp()
local actId=self.actId
local subType=self.subType
local subId=self.subId
local subCfg=self.subCfg
local needExp=self.needExp
local maxLevel=self.maxLevel
local level=self.curLevel
if level<maxLevel then
local exp=moneyModel.getMoney(self.moneyType)
self.exp:setText(FMT.fmt('{0}/{1}',exp,needExp))
self.expPB:setChildUIProgressbar(exp,needExp,false)
else
self.exp:setText('已满级')
self.expPB:setChildUIProgressbar(1,1,false)
end
end

function UISubAct_DaoBingGeWin:startTaskTimer(widget,tasktype,taskline,idx,taskCfg)
if self.tasktimer[idx]then
self:stopTimerByID(self.tasktimer[idx])
self.tasktimer[idx]=nil
end

local func=function()
if not self or self.isClose then return end
local left=self.model:getLeftTaskTime(tasktype,taskline,idx,taskCfg)
if left>0 then
widget:SetChildText(6,timeHelper.format_time_stamp3(left))
widget:SetChildActive(7,true)
else
widget:SetChildActive(7,false)
widget:SetChildText(6,'')
if self.tasktimer[idx]then
self:stopTimerByID(self.tasktimer[idx])
self.tasktimer[idx]=nil
end
end
end
self.tasktimer[idx]=self:setTimer(1,0,func)
func()
end
