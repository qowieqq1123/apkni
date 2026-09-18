







def_class("UISubAct_TianMoRuQin_MainWin",UIWindowBase)









function UISubAct_TianMoRuQin_MainWin:bindComponents()

self.moneyIcon=UIImage.get(self,0)
self.moneyNum=UIText.get(self,1)
self.moneyAdd=UIButton.get(self,2)
self.bgModel=UIObject.get(self,3)
self.moneyBg=UIButton.get(self,4)
self.topBg=UIObject.get(self,5)
self.monsters=UIObject.get(self,6)
self.progressView=UIObject.get(self,7)
self.helpBtn=UIButton.get(self,8)
self.timeTx=UIText.get(self,9)
self.progressSp=UIObject.get(self,10)
self.stageList=UIObject.get(self,11)
self.eventCDTx=UIText.get(self,12)

self.moneyAdd:setButtonClick(function()self:onMoneyAdd()end)

self.moneyBg:setButtonClick(function()self:onMoneyBg()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)



end


function UISubAct_TianMoRuQin_MainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyNum);self.moneyNum=nil;
_UIObject_release(self.moneyAdd);self.moneyAdd=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.moneyBg);self.moneyBg=nil;
_UIObject_release(self.topBg);self.topBg=nil;
_UIObject_release(self.monsters);self.monsters=nil;
_UIObject_release(self.progressView);self.progressView=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
_UIObject_release(self.progressSp);self.progressSp=nil;
_UIObject_release(self.stageList);self.stageList=nil;
_UIObject_release(self.eventCDTx);self.eventCDTx=nil;
end















local _this=nil
local _stageCmp={
name=0,
time=1,
effect=2,
button=3,
background2=4,
background1=5,
icon=6,
reddot=7
}
local _monsterCmp={
root=-1,
model=0,
timeTx=1,
typeImg=2,
progressBar=3,
rewardBtn=4,
refreshFlag=5,
refreshBtn=6,
costNum=7,
timeBg=8,
effect1=9,
effect2=10,
reddot=11,
}
local _appearance=1.5
local _comingEvent=3



function UISubAct_TianMoRuQin_MainWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)

self.bgModel:setChildUIModelShowTarget(4901,1,{},eAnimationID.stand,false,false,0)
end


function UISubAct_TianMoRuQin_MainWin:__delete()
self:stopCDTick()

self:unbindComponents()
_this=nil

notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:removelistener(notifyConfig.onNewDay,self.onNewDay)
end




function UISubAct_TianMoRuQin_MainWin:onShow(argtable,afterOnloaded)
if argtable then
local old=self.activityId==argtable.act_id and self.subType==argtable.sub_act_type and self.subId==argtable.sub_act_id
self.activityId=argtable.act_id
self.subType=argtable.sub_act_type
self.subId=argtable.sub_act_id
self.parentWin=argtable.parentWin
self.argtable=argtable
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.info=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
if not old then
self:initView()
end
if self.info and self.info:hasData()then
self:refreshView()

self:handleExtraParams(argtable.extraParams)
end
call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqQingBao",self.activityId,self.subId)
end
self.monsters:setActive(true)
self.progressView:setActive(true)
end


function UISubAct_TianMoRuQin_MainWin:onHide()
self.monsters:setActive(false)
self.progressView:setActive(false)
end




function UISubAct_TianMoRuQin_MainWin:onMoneyBg()

gainControl:showGainWin(self.costItem)
end


function UISubAct_TianMoRuQin_MainWin:onHelpBtn()
local d={}
d.title='规则'
d.mode=3
d.name='tianmoruqin_yuwaitianmo_help_%d'
self:showWindow('UIRuleWin',d)
end

function UISubAct_TianMoRuQin_MainWin:onMoneyAdd()
self.info:showMoneyBuyPanel(self.costItem)
end

function UISubAct_TianMoRuQin_MainWin:handleExtraParams(extraParams)
if extraParams then
if extraParams.index then
local data=self.info:getMonsterData(extraParams.index)
if data then
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,data.monster)
local monType=monsterCfg.monType
local damageNum=tonumber(tostring(data.damage))
local maxBlood=self.info:getMaxBloods(monType)
local maxBloodNum=tonumber(tostring(maxBlood))
if damageNum>=maxBloodNum then
return
end
end
local tabType=SUBACT_DEFINETAB_TYPE.eTianMoRuQin_main
local jumpType=activitiesModel:getSubActDefineTabIndex(tabType)
local jumpParam={
id=JUMP_TYPE.eActivity,
args={
subType=self.subType,
subid=self.subId,
extraParams={
tab_idx=jumpType,
index=extraParams.index
}
}
}
call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqMonsterDetail",self.activityId,self.subId,data.guid,jumpType,jumpParam)
end
end
end

function UISubAct_TianMoRuQin_MainWin:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UISubAct_TianMoRuQin_MainWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UISubAct_TianMoRuQin_MainWin:updateCDTick()
local time=activitiesModel:getSubActEndLeftTime(self.activityId,self.subType,self.subId)
self.timeTx:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp3(time)))
self:updateProgress()
self:updateMonsterLeaveTime()
self:updateEventCD()
end

function UISubAct_TianMoRuQin_MainWin:updateEventCD()
local nowTime=timeHelper.getServerShortTime()
for i,v in ipairs(self.aimSec)do
if nowTime<v then
local aimDesc=self.config.aimDesc[i]
self.eventCDTx:setText(FMT.fmt("“{0}”将在<color=#FC8950>{1}</color>后解锁",aimDesc[1],timeHelper.format_time_stamp3(v-nowTime)))
self.topBg:setActive(true)
return
end
end
self.topBg:setActive(false)
end

function UISubAct_TianMoRuQin_MainWin:initCost()
self.costItem=self.config.money[1]
self.costMax=self.config.money[2]
local iconName=iconHelper.getIconName(self.costItem)
self.moneyIcon:setImageIcon(iconName,false)

self:refreshCost()
end

function UISubAct_TianMoRuQin_MainWin:refreshCost(val)
local cur=val or itemsModel.getCount(self.costItem)
local str=FMT.fmt("{0}/{1}",cur,self.costMax)
self.moneyNum:setText(str)
end






function UISubAct_TianMoRuQin_MainWin:initProgress()
self.stageCnt=#self.config.aim
self.startTime=self.info.start_time
self.endTime=self.info.end_time
self.aimSec={}
for i,v in ipairs(self.config.aim)do
local aimSec=v[1]
self.aimSec[i]=self.startTime+aimSec
end
self.aimFlag={}
self.aimTime={}

local nowTime=timeHelper.getServerShortTime()

self.stageUpdates={}
self.stageList:setChildLayoutGroupCreateItems(self.stageCnt,function(index)
local stageItem=self.stageList:getChildLayoutGroupGridItem(index-1)
stageItem:SetChildButtonClick(_stageCmp.button,function()
self:onClickStage(index)
end)


local startSec=self.aimSec[index]
local show=nowTime>=startSec
if api_Available_SetChildUIModelGray()then
stageItem:SetChildUIModelGray(_stageCmp.icon,not show)
else
stageItem:SetChildUIModelShowColor(_stageCmp.icon,show and Color.white or Color.gray)
end
local descCfg=self.config.aimDesc[index]

stageItem:SetChildText(_stageCmp.name,descCfg[1])






stageItem:SetChildActive(_stageCmp.background1,not show)
stageItem:SetChildActive(_stageCmp.background2,show)
stageItem:SetChildAnimationStringID(_stageCmp.effect,"tianmoruqineffect",true)
stageItem:SetChildActive(_stageCmp.effect,false)
stageItem:SetChildActive(_stageCmp.reddot,false)
end)

local nextIndex=#self.aimSec
for index,startSec in ipairs(self.aimSec)do
if nowTime<startSec then
nextIndex=index
break
end
end
local x=115+nextIndex*150-798
x=math.max(x,0)
self.stageList:setChildAnchoredPos(-x,0)
end

function UISubAct_TianMoRuQin_MainWin:refreshProgress()
local nowTime=timeHelper.getServerShortTime()
for i,v in ipairs(self.config.aim)do
local stageItem=self.stageList:getChildLayoutGroupGridItem(i-1)
local show=nowTime>=self.aimSec[i]and self.info:checkEventReddot(i)
stageItem:SetChildActive(_stageCmp.effect,show)
stageItem:SetChildActive(_stageCmp.reddot,show)
end
end

function UISubAct_TianMoRuQin_MainWin:updateProgress()
local nowTime=timeHelper.getServerShortTime()
local progress=803
local data=self.info:getData()
for i=1,self.stageCnt do

local startSec=self.aimSec[i-1]or self.startTime
local endSec=self.aimSec[i]or self.endTime
local stageSeg=i>1 and 150 or 115
if nowTime>startSec then
if nowTime>endSec then
stageSeg=stageSeg
else
stageSeg=(nowTime-startSec)/(endSec-startSec)*stageSeg
end
else
stageSeg=0
end

progress=progress+stageSeg


if data then
local stageItem=self.stageList:getChildLayoutGroupGridItem(i-1)
local stageCfg=self.config.aim[i]

local arriveTime=nowTime>=endSec
if arriveTime==not self.aimFlag[i]then
local reddot=self.info:checkEventReddot(i)
stageItem:SetChildActive(_stageCmp.effect,reddot)
stageItem:SetChildActive(_stageCmp.reddot,reddot)
stageItem:SetChildActive(_stageCmp.background1,false)
stageItem:SetChildActive(_stageCmp.background2,true)
if api_Available_SetChildUIModelGray()then
stageItem:SetChildUIModelGray(_stageCmp.icon,not arriveTime)
else
stageItem:SetChildUIModelShowColor(_stageCmp.icon,arriveTime and Color.white or Color.gray)
end
self.aimFlag[i]=arriveTime









end











end
end

self.progressSp:setChildSizeDelta(progress,8)
end

function UISubAct_TianMoRuQin_MainWin:initMonsters()
self.refreshCount={}
self.refreshSum=0
for i,v in pairs(self.config.item)do
if self.config.onlyItem==nil or self.config.onlyItem==i then
local haveNum=itemsModel.getCount(i)
self.refreshCount[i]=haveNum
self.refreshSum=self.refreshSum+haveNum
end
end

self.monsters:setChildLayoutGroupCreateItems(TianMoRuQinMonsterCount,function(index)
local item=self.monsters:getChildLayoutGroupGridItem(index-1)

item:SetChildButtonClick(_monsterCmp.root,function()
self:onClickMonster(index)
end)
item:SetChildButtonClick(_monsterCmp.rewardBtn,function()
self:onClickMonsterReward(index)
end)
item:SetChildButtonClick(_monsterCmp.refreshBtn,function()
self:onClickMonsterRefresh(index)
end)
item:SetChildText(_monsterCmp.costNum,FMT.fmt("{1}X{0}",self.refreshSum,self.config.itemName))
end)
self.leaveStrs={}
end

function UISubAct_TianMoRuQin_MainWin:refreshMonster(index,flag)
local item=self.monsters:getChildLayoutGroupGridItem(index-1)
local data=self.info:getMonsterData(index)

if data and data.monster>0 then
local nowTime=timeHelper.getServerShortTime()
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,data.monster)
local monType=monsterCfg.monType

local rewardFlag=data.fighted<0
local leastTime=nil
local monsterInfo=self.config.monster[monType]
if data.since>0 then
local deadLine=self.info:getMonsterDeadTimeEx(data)
leastTime=deadLine-nowTime
end

if not leastTime or leastTime>=0 then
local maxBlood=tonumber(tostring(self.info:getMaxBloods(monType)))
local damageBlood=tonumber(tostring(data.damage))
local isLive=damageBlood<maxBlood

if isLive then
local modelParams=comHelper.getMonsterGroupModelParams(data.monster)
item:SetChildShowEffect(_monsterCmp.effect1,-1,false)
item:SetChildShowEffect(_monsterCmp.effect2,-1,false)
if flag then
local func=function()
local scaleParam=isometricMapSystem:getModelScales2Pram(modelParams.body,9)
item:SetChildShowEffect(_monsterCmp.effect1,10452,true)
item:SetChildUIModelShowTarget(_monsterCmp.model,modelParams.body,scaleParam[1],modelParams.componets,eAnimationID.stand,false,false,1,nil)
item:SetChildUIModelShowTargetOffset(_monsterCmp.model,scaleParam[2],scaleParam[3])
end
if monsterInfo[7]then
item:SetChildUIModelRemoveTarget(_monsterCmp.model)
item:SetChildShowEffect(_monsterCmp.effect2,10453,true)

self:delayDo(_appearance,func)
else
func()
end
else
local scaleParam=isometricMapSystem:getModelScales2Pram(modelParams.body,9)
item:SetChildUIModelShowTarget(_monsterCmp.model,modelParams.body,scaleParam[1],modelParams.componets,eAnimationID.stand,false,false,0,nil)
item:SetChildUIModelShowTargetOffset(_monsterCmp.model,scaleParam[2],scaleParam[3])
item:SetChildShowEffect(_monsterCmp.effect1,10452,true)
end
local abName=globalABLookup.global
local assetName=monTypeTagA[monType]
if assetName then
item:SetChildCSImageSprite(_monsterCmp.typeImg,abName,assetName)
else
item:SetChildIcon(_monsterCmp.typeImg,"",false)
end
else
item:SetChildUIModelRemoveTarget(_monsterCmp.model)
item:SetChildIcon(_monsterCmp.typeImg,"",false)
item:SetChildShowEffect(_monsterCmp.effect1,10450,true)
end

local timeStr=nil
if leastTime then
leastTime=math.min(leastTime,self.endTime-nowTime)
timeStr=timeHelper.format_time_stamp3(leastTime)
timeStr=isLive and FMT.fmt("{0}后离开",timeStr)or FMT.fmt("{0}后天魔入侵",timeStr)
end
item:SetChildText(_monsterCmp.timeTx,timeStr or"")
item:SetChildActive(_monsterCmp.timeBg,timeStr~=nil)
self.leaveStrs[index]=timeStr


item:SetChildActive(_monsterCmp.progressBar,isLive)
if isLive then
local curProgress=(maxBlood-damageBlood)/maxBlood
item:SetChildProgressValue(_monsterCmp.progressBar,math.ceil(curProgress*10000),10000)
item:SetChildProgressText(_monsterCmp.progressBar,FMT.fmt("{0}%",math.ceil(curProgress*100)))
end


item:SetChildActive(_monsterCmp.rewardBtn,not isLive and not rewardFlag)
item:SetChildActive(_monsterCmp.refreshBtn,not isLive and rewardFlag)
item:SetChildActive(_monsterCmp.refreshFlag,false)
item:SetChildActive(_monsterCmp.reddot,false)
return
end
end
item:SetChildShowEffect(_monsterCmp.effect1,10451,true)
item:SetChildUIModelRemoveTarget(_monsterCmp.model)
item:SetChildText(_monsterCmp.timeTx,"")
item:SetChildActive(_monsterCmp.timeBg,false)
item:SetChildIcon(_monsterCmp.typeImg,"",false)
item:SetChildActive(_monsterCmp.progressBar,false)
item:SetChildActive(_monsterCmp.rewardBtn,false)
item:SetChildActive(_monsterCmp.refreshBtn,false)
item:SetChildActive(_monsterCmp.refreshFlag,false)
item:SetChildActive(_monsterCmp.reddot,true)
self.leaveStrs[index]=nil
end

function UISubAct_TianMoRuQin_MainWin:updateMonsterLeaveTime()
if self.info:hasData()then
local nowTime=timeHelper.getServerShortTime()
for i=1,TianMoRuQinMonsterCount do
local item=self.monsters:getChildLayoutGroupGridItem(i-1)
local data=self.info:getMonsterData(i)
local timeStr=nil
local check=true
if data and data.monster>0 then
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,data.monster)
local monType=monsterCfg.monType
if data.since>0 then
local deadLine=self.info:getMonsterDeadTimeEx(data)
local leastTime=deadLine-nowTime
if leastTime>=0 then
local maxBlood=tonumber(tostring(self.info:getMaxBloods(monType)))
local damageBlood=tonumber(tostring(data.damage))
local isLive=damageBlood<maxBlood

leastTime=math.min(leastTime,self.endTime-nowTime)
timeStr=timeHelper.format_time_stamp3(leastTime)
timeStr=isLive and FMT.fmt("{0}后离开",timeStr)or FMT.fmt("{0}后天魔入侵",timeStr)
self.stageUpdates[i]=true
else
if self.stageUpdates[i]then
self:refreshMonster(i,false)
end
check=false
self.stageUpdates[i]=false
end
end
end

if check and self.leaveStrs[i]~=timeStr then
item:SetChildText(_monsterCmp.timeTx,timeStr or"")
if self.leaveStrs[i]==nil then
item:SetChildActive(_monsterCmp.timeBg,true)
elseif timeStr==nil then
item:SetChildActive(_monsterCmp.timeBg,false)
end
self.leaveStrs[i]=timeStr
end
end
end
end

function UISubAct_TianMoRuQin_MainWin:refreshAllMonster()
for i=1,TianMoRuQinMonsterCount do
self:refreshMonster(i,false)
end
end

function UISubAct_TianMoRuQin_MainWin:initView()
if self.info and self.info:hasData()then
local data=self.info:getData()
if not timeHelper.isTodayStamp(timeHelper.convertLongStamp(data.moneySec))then
call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqMoneyRefresh",self.activityId,self.subId)
end
end
call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqServerKill",self.activityId,self.subId)

self:initCost()
self:initMonsters()
self:initProgress()
self:startCDTick()

end

function UISubAct_TianMoRuQin_MainWin:refreshView()

self:refreshAllMonster()
self:refreshProgress()

end

function UISubAct_TianMoRuQin_MainWin:onClickStage(index)
if not self.startTime then return end
if not self.info:hasData()then return end


local nowTime=timeHelper.getServerShortTime()






local args={
actId=self.activityId,
subType=self.subType,
subId=self.subId,
index=index,
open=nowTime>=self.startTime+self.config.aim[index][1],
}
self:showWindow("UISubAct_TianMoRuQin_EventDialog",args)
end

function UISubAct_TianMoRuQin_MainWin:onClickMonster(index)
if self.info:hasData()then
local data=self.info:getMonsterData(index)
if data and data.monster>0 then
local nowTime=timeHelper.getServerShortTime()
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,data.monster)
local monType=monsterCfg.monType
local leastTime=nil
if data.since>0 then
local deadLine=self.info:getMonsterDeadTimeEx(data)
leastTime=deadLine-nowTime
end
if not leastTime or leastTime>0 then
local maxBlood=tonumber(tostring(self.info:getMaxBloods(monType)))
local damageBlood=tonumber(tostring(data.damage))
local isLive=damageBlood<maxBlood
if isLive then

local tabType=SUBACT_DEFINETAB_TYPE.eTianMoRuQin_main
local jumpType=activitiesModel:getSubActDefineTabIndex(tabType)
local jumpParam={
id=JUMP_TYPE.eActivity,
args={
subType=self.subType,
subid=self.subId,
extraParams={
index=index
}
}
}
call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqMonsterDetail",self.activityId,self.subId,data.guid,jumpType,jumpParam)
end
return
end
end

call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqNewMonster",self.activityId,self.subId,index)
end
end

function UISubAct_TianMoRuQin_MainWin:onClickMonsterReward(index)
if self.info:hasData()then
local data=self.info:getMonsterData(index)
if data and data.monster>0 then
local nowTime=timeHelper.getServerShortTime()
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,data.monster)
local monType=monsterCfg.monType
local leastTime=nil
if data.since>0 then
local deadLine=self.info:getMonsterDeadTimeEx(data)
leastTime=deadLine-nowTime
end
if leastTime and leastTime>0 then
local maxBlood=tonumber(tostring(self.info:getMaxBloods(monType)))
local damageBlood=tonumber(tostring(data.damage))
local isLive=damageBlood<maxBlood
local rewardFlag=data.fighted<0
if not isLive and not rewardFlag then

call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqMonsterReward",self.activityId,self.subId,data.guid)
end
end
end
end
end

function UISubAct_TianMoRuQin_MainWin:onClickMonsterRefresh(index)
if self.info:hasData()then
local data=self.info:getMonsterData(index)
if data and data.monster>0 then
local nowTime=timeHelper.getServerShortTime()
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,data.monster)
local monType=monsterCfg.monType
local leastTime=nil
if data.since>0 then
local deadLine=self.info:getMonsterDeadTimeEx(data)
leastTime=deadLine-nowTime
end
if leastTime and leastTime>0 then
local maxBlood=tonumber(tostring(self.info:getMaxBloods(monType)))
local damageBlood=tonumber(tostring(data.damage))
local isLive=damageBlood<maxBlood
local rewardFlag=data.fighted<0
if not isLive and rewardFlag then

local items={}



if self.config.onlyItem and self.config.item[self.config.onlyItem]then
local haveNum=itemsModel.getCount(self.config.onlyItem)
local needNum=self.config.item[self.config.onlyItem][1]
if haveNum>=needNum then
local desc=FMT.fmt("是否确认使用{0}搜寻天魔？",itemsConfig.getColorName(self.config.onlyItem))
UIDialogManager.getConfirmDialog3(nil,desc,function()
local haveNum=itemsModel.getCount(self.config.onlyItem)
local needNum=self.config.item[self.config.onlyItem][1]
if haveNum>=needNum then
call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqNewMonster",self.activityId,self.subId,index,self.config.onlyItem)
else
UIManager.error(FMT.fmt("{0}不足，暂无法搜寻",self.config.itemName))
gainControl:showGainWin(self.config.onlyItem)
end
end,REPEAT_TYPE.eTianMoRuQinSearch)
else
UIManager.error(FMT.fmt("{0}不足，暂无法搜寻",self.config.itemName))
gainControl:showGainWin(self.config.onlyItem)
end
else
for i,v in ipairs(self.config.itemTips)do
local itemId=v[1]
local itemCost=self.config.item[itemId][1]
local tips=v[2]
table.insert(items,{itemId,itemCost,tips})
end
local args={
items=items,
callback=function(selected)
local itemData=items[selected]
local itemId=itemData[1]
call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqNewMonster",self.activityId,self.subId,index,itemId)
end,
}
self:showWindow("UISubAct_TianMoRuQin_SummonDialog",args)
end
end
end
end

end
end

function UISubAct_TianMoRuQin_MainWin.on_money_changed(moneyType,lastVal,val)
if moneyType==_this.costItem then
_this:refreshCost(val)
end

local old=_this.refreshCount[moneyType]
if old then
_this.refreshSum=_this.refreshSum+(val-old)
_this.refreshCount[moneyType]=val

for index=1,TianMoRuQinMonsterCount do
local item=_this.monsters:getChildLayoutGroupGridItem(index-1)
item:SetChildText(_monsterCmp.costNum,FMT.fmt("{1}X{0}",_this.refreshSum,_this.config.itemName))
end
end
end

function UISubAct_TianMoRuQin_MainWin.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if itemid==_this.costItem then
_this:refreshCost(newcount)
end

local old=_this.refreshCount[itemid]
if old then
_this.refreshSum=_this.refreshSum+(newcount-old)
_this.refreshCount[itemid]=newcount

for index=1,TianMoRuQinMonsterCount do
local item=_this.monsters:getChildLayoutGroupGridItem(index-1)
item:SetChildText(_monsterCmp.costNum,FMT.fmt("{1}X{0}",_this.refreshSum,_this.config.itemName))
end
end
end

function UISubAct_TianMoRuQin_MainWin.onNewDay()
if _this.info and _this.info:hasData()then
local data=_this.info:getData()
if not timeHelper.isTodayStamp(timeHelper.convertLongStamp(data.moneySec))then
call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqMoneyRefresh",_this.activityId,_this.subId)
end
end
end

function UISubAct_TianMoRuQin_MainWin:on_249_130(actId,subType,subId,monsterIndex)
self:on_249_133(actId,subType,subId,monsterIndex,false)
end

function UISubAct_TianMoRuQin_MainWin:on_249_131(actId,subType,subId)
if self.info:compare(actId,subType,subId)then
self:refreshView()
end
end

function UISubAct_TianMoRuQin_MainWin:on_249_132(actId,subType,subId,eventIndex)
if self.info:compare(actId,subType,subId)then
local eventItem=self.stageList:getChildLayoutGroupGridItem(eventIndex-1)
local reddot=self.info:checkEventReddot(eventIndex)
eventItem:SetChildActive(_stageCmp.effect,reddot)
eventItem:SetChildActive(_stageCmp.reddot,reddot)
end
end

function UISubAct_TianMoRuQin_MainWin:on_249_133(actId,subType,subId,monsterIndex,change)
if self.info:compare(actId,subType,subId)then
self:refreshMonster(monsterIndex,true)
end
end

function UISubAct_TianMoRuQin_MainWin:on_249_138(actId,subType,subId)



end