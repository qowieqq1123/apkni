







def_class("UISubAct_TianMoRuQin_QingBaoWin",UIWindowBase)









function UISubAct_TianMoRuQin_QingBaoWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.tabList=UIObject.get(self,1)
self.catModel=UIObject.get(self,2)
self.catTalk=UIObject.get(self,3)
self.moneyBg=UIButton.get(self,4)
self.refreshBtnTx=UIText.get(self,5)
self.catTalkDesc=UIText.get(self,6)
self.rewardBtn=UIButton.get(self,7)
self.chooseList=UIObject.get(self,8)
self.refreshBtn=UIButton.get(self,9)
self.scrollerScript=UIEnhancedScrollerLua.get(self,10)
self.none=UIObject.get(self,11)
self.moneyIcon=UIImage.get(self,12)
self.moneyNum=UIText.get(self,13)
self.moneyAdd=UIButton.get(self,14)

self.moneyBg:setButtonClick(function()self:onMoneyBg()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.refreshBtn:setButtonClick(function()self:onRefreshBtn()end)

self.moneyAdd:setButtonClick(function()self:onMoneyAdd()end)



end


function UISubAct_TianMoRuQin_QingBaoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.tabList);self.tabList=nil;
_UIObject_release(self.catModel);self.catModel=nil;
_UIObject_release(self.catTalk);self.catTalk=nil;
_UIObject_release(self.moneyBg);self.moneyBg=nil;
_UIObject_release(self.refreshBtnTx);self.refreshBtnTx=nil;
_UIObject_release(self.catTalkDesc);self.catTalkDesc=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.chooseList);self.chooseList=nil;
_UIObject_release(self.refreshBtn);self.refreshBtn=nil;
_UIObject_release(self.scrollerScript);self.scrollerScript=nil;
_UIObject_release(self.none);self.none=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyNum);self.moneyNum=nil;
_UIObject_release(self.moneyAdd);self.moneyAdd=nil;
end















local _this=nil
local _tabCmp={
root=-1,
selected=0,
name=1,
reddot=2,
nameBg=3,
lock=4
}
local _tabConfig={
[1]={
tab=TianMoRuQinQingBaoType.eWorld,
name="世界情报",
style=1,
},
[2]={
tab=TianMoRuQinQingBaoType.eXianMeng,
name="仙盟情报",
style=1,
check=function()
return xianmengModel:hasXM(),cfgHelper.getlang("haveNotXianMengTips")
end,
open=function(config)
if config.xmChannelLimit then
return timeHelper.getServerOpenLongTime()<timeHelper.getDateStamp(config.xmChannelLimit)
end
return true
end
},
[3]={
tab=TianMoRuQinQingBaoType.eSelf,
name="正在进行",
style=2,
filters=0,
reddot=function(info)
return info:checkQingBaoChannelReddot(TianMoRuQinQingBaoType.eSelf)
end,
},
}
local _rankCmp={
root=-1,
image=0,
name=1,
progressBar=2,
timeTx=3,
peopleTx=4,
fightBtn=5,
rewardBtn=6,
finish=7,
owner=8,
iconBg=9,
tag=10,
decorate=11,
costIcon=12,
costNum=13,
costRoot=14,
}
local _chooseCmp={
root=-1,
gou=0,
name=1,
bg=2,
}
local _iconAb="ui/sharedtextures/uiglobalspriteatlas_1.ab"
local _iconBg={
[monType.LittleMonster]="image_gwtouxiangpjk_2",
[monType.EliteMonster]="image_gwtouxiangpjk_3",
[monType.Boss]="image_gwtouxiangpjk_5",
[monType.GodAnimal]="image_gwtouxiangpjk_7",
}
local _iconTag={

[monType.EliteMonster]="icon_gwbz_3",
[monType.Boss]="icon_gwbz_2",
[monType.GodAnimal]="icon_gwbz_1",
}
local UIPrepareEnScroller=simple_class(UIEnhancedScroller)



function UISubAct_TianMoRuQin_QingBaoWin:onLoaded(...)
self:bindComponents()
_this=self

notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)

self.enhancedscrollscript=UIPrepareEnScroller(self.scrollerScript:getGameObject(),self.scrollerScript:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self

self.bgModel:setChildUIModelShowTarget(4930,1,{},eAnimationID.stand,false,false,0)
end


function UISubAct_TianMoRuQin_QingBaoWin:__delete()
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)

self:unbindComponents()
_this=nil

self:stopRefreshCDTick()
self:stopCDTick()
if self.bt then
behaviorManager:removeBehaviorTree(self.bt)
self.bt=nil
end
end




function UISubAct_TianMoRuQin_QingBaoWin:onShow(argtable,afterOnloaded)
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

local extraParams=argtable.extraParams
if extraParams then
self:handleExtraParams(extraParams)
end
end
call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqQingBao",self.activityId,self.subId)
self:checkRefreshBtnCDTick()

self.info:clearQingBaoXin()
notifySystem:postNotify(notifyConfig.onActTabFlagChange,SUBACT_DEFINETAB_TYPE.eTianMoRuQin_qingbao)
end
end


function UISubAct_TianMoRuQin_QingBaoWin:onHide()
self:stopCDTick()
end



function UISubAct_TianMoRuQin_QingBaoWin:handleExtraParams(extraParams)

if extraParams.channel then
for i,v in ipairs(self.tabShow)do
if v.tab==extraParams.channel then
if v.check then
local check,tips=v.check()
if not check then
return UIManager.error(tips)
end
end
self:onClickTab(i)
break
end
end
end

if extraParams.monsterGuid then
local guid=extraParams.monsterGuid
local guidStr=tostring(guid)
local index=table.findValue(self.listData,guidStr)
if index then
local rankData=self.info:getRankData(guid)
if rankData.hp>0 then
self:onClickRank1(index)
end
end
end
end


function UISubAct_TianMoRuQin_QingBaoWin:onRefreshBtn()
local check=call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqQingBao",self.activityId,self.subId,true)
if check then
UIManager.info("刷新成功")
self:checkRefreshBtnCDTick()
end
end


function UISubAct_TianMoRuQin_QingBaoWin:onRewardBtn()
if self.tabShow[self.selectedTab].tab==TianMoRuQinQingBaoType.eSelf then
local list={}
local nowTime=timeHelper.getServerShortTime()
for index,guidStr in ipairs(self.listData)do
local data=self.info:getRankDataImp(guidStr)

if data.hp<=0 and data.leaveTime>=nowTime then
table.insert(list,data.guid)
end
end
if#list>0 then
call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqMonsterReward",self.activityId,self.subId,unpack(list))
end
end
end

function UISubAct_TianMoRuQin_QingBaoWin:initView()
self:initCost()
self:initChooseList()
self:initTabList()


local modelParams=self.config.catModel
self.catModel:setChildUIModelShowTarget(modelParams[1],modelParams[2]or 1,modelParams[3]or{},modelParams[4]or eAnimationID.stand,false,false,0)

if self.bt then
behaviorManager:removeBehaviorTree(self.bt)
self.bt=nil
self.catTalk:setScale(Vector3.zero)
end
local args={
widget=self.winlua,
compenont=self.catTalk:getID(),
}
self.bt=behaviorManager:addBehaviorTree("bt_ui_tmrq_qb_cattalk",nil,true,args)
end

function UISubAct_TianMoRuQin_QingBaoWin:checkRefreshBtnCDTick()
local least=self.info:getQingBaoRefreshLeast()
if least>0 then
self:startRefreshCDTick(true)
else
self:stopRefreshCDTick(true)
end
end

function UISubAct_TianMoRuQin_QingBaoWin:startRefreshCDTick(refresh)
if not self.refreshCDTick then
self.refreshCDTick=self:setTimer(1,0,function()
local least=self.info:getQingBaoRefreshLeast()
if least>0 then
self:updateRefreshCDTick()
else
self:stopRefreshCDTick(true)
end
end)
end
if refresh then
self:updateRefreshCDTick()
self.refreshBtn:setChildImageExGray(true)
end
end

function UISubAct_TianMoRuQin_QingBaoWin:stopRefreshCDTick(refresh)
if self.refreshCDTick then
self:stopTimerByID(self.refreshCDTick)
self.refreshCDTick=nil
end
if refresh then
self.refreshBtn:setChildImageExGray(false)
self.refreshBtnTx:setText("刷新")
end
end

function UISubAct_TianMoRuQin_QingBaoWin:updateRefreshCDTick(least)
local least=least or self.info:getQingBaoRefreshLeast()
self.refreshBtnTx:setText(FMT.fmt("刷新 ({0})",least))
end

function UISubAct_TianMoRuQin_QingBaoWin:refreshView()
if not self.selectedTab then
self:onClickTab(1)
else
self:refreshTabReddot()
self:refreshList()
end
end

function UISubAct_TianMoRuQin_QingBaoWin:initChooseList()
self.fliterTypes=call_activitiesHandle_func("activitiesHandle_tianmoruqin","getFilterMonsterTypes")
self.filters=call_activitiesHandle_func("activitiesHandle_tianmoruqin","getFilterSettings")
self.chooseList:setChildLayoutGroupCreateItems(#self.fliterTypes,function(index)
local item=self.chooseList:getChildLayoutGroupGridItem(index-1)
local monsterType=self.fliterTypes[index]
local check=mathHelper.getBitValue(self.filters,monsterType)
local name=call_activitiesHandle_func("activitiesHandle_tianmoruqin","getFilterMonsterName",monsterType)
item:SetChildButtonClick(_chooseCmp.root,function()
self:onClickChoose(index)
end)
item:SetChildText(_chooseCmp.name,name)
item:SetChildActive(_chooseCmp.gou,not check)
end)
end

function UISubAct_TianMoRuQin_QingBaoWin:onClickChoose(index)
local monsterType=self.fliterTypes[index]
local check=mathHelper.getBitValue(self.filters,monsterType)
local item=self.chooseList:getChildLayoutGroupGridItem(index-1)
if check then
self.filters=mathHelper.clrbit(self.filters,monsterType)
item:SetChildActive(_chooseCmp.gou,true)
else
self.filters=mathHelper.setbit(self.filters,monsterType)
item:SetChildActive(_chooseCmp.gou,false)
end
call_activitiesHandle_func("activitiesHandle_tianmoruqin","setFilterSettings",self.filters)
self:refreshList()
end

function UISubAct_TianMoRuQin_QingBaoWin:initTabList()
self.tabShow={}
for i,v in ipairs(_tabConfig)do
if v.open==nil or v.open(self.config)then
table.insert(self.tabShow,v)
end
end
self.tabList:setChildLayoutGroupCreateItems(#self.tabShow,function(index)
local item=self.tabList:getChildLayoutGroupGridItem(index-1)
local config=self.tabShow[index]
local reddot=config.reddot and config.reddot(self.info)or false
item:SetChildButtonClick(_tabCmp.root,function()
self:onClickTab(index)
end)
item:SetChildText(_tabCmp.name,config.name)
item:SetChildActive(_tabCmp.selected,self.selectedTab==index)
item:SetChildActive(_tabCmp.reddot,reddot)
item:SetChildText(_tabCmp.nameBg,config.name)
local lock=false
if config.check then
lock=not config.check()
end
item:SetChildActive(_tabCmp.lock,lock)
end)
end

function UISubAct_TianMoRuQin_QingBaoWin:refreshTabReddot()
for index,config in ipairs(self.tabShow)do
local item=self.tabList:getChildLayoutGroupGridItem(index-1)
local reddot=config.reddot and config.reddot(self.info)or false
item:SetChildActive(_tabCmp.reddot,reddot)
end
end

function UISubAct_TianMoRuQin_QingBaoWin:onClickTab(index)
if self.selectedTab~=index then

local config=self.tabShow[index]
if config.check then
local check,tips=config.check()
if not check then
return UIManager.error(tips)
end
end

if self.selectedTab then
local item=self.tabList:getChildLayoutGroupGridItem(self.selectedTab-1)
item:SetChildActive(_tabCmp.selected,false)
end

self.selectedTab=index

local item=self.tabList:getChildLayoutGroupGridItem(self.selectedTab-1)
item:SetChildActive(_tabCmp.selected,true)

self:refreshList()
end
end

function UISubAct_TianMoRuQin_QingBaoWin:refreshList()
local config=self.tabShow[self.selectedTab]
local filters=config.filters or self.filters
local listData,listTime=self.info:getRankCache(config.tab,filters)
self.listData=listData
self.listTime=listTime
local dataCnt=#self.listData

self.enhancedscrollscript:initData(self.listData,110,dataCnt)
self.none:setActive(dataCnt<=0)

local otherHandle=FMT.fmt("refreshOther{0}",config.style)
self[otherHandle](self)

if self.listTime and dataCnt>0 then
self:startCDTick()
else
self:stopCDTick()
end
end

function UISubAct_TianMoRuQin_QingBaoWin:refreshOther1()
self.chooseList:setActive(true)
self.rewardBtn:setActive(false)
end

function UISubAct_TianMoRuQin_QingBaoWin:refreshOther2()
self.chooseList:setActive(false)
for index,guidStr in ipairs(self.listData)do
local data=self.info:getRankDataImp(guidStr)
if data.hp<=0 then
self.rewardBtn:setActive(true)
return
end
end
self.rewardBtn:setActive(false)
end

function UISubAct_TianMoRuQin_QingBaoWin:onClickRank(index)
local tabCfg=self.tabShow[self.selectedTab]
local clickName=FMT.fmt("onClickRank{0}",tabCfg.style)
self[clickName](self,index)
end

function UISubAct_TianMoRuQin_QingBaoWin:onClickRank1(index)
local guidStr=self.listData[index]
local data=self.info:getRankDataImp(guidStr)
local tabType=SUBACT_DEFINETAB_TYPE.eTianMoRuQin_qingbao
local channel=self.tabShow[self.selectedTab].tab
local jumpType=activitiesModel:getSubActDefineTabIndex(tabType)
local jumpParam={
id=JUMP_TYPE.eActivity,
args={
subType=self.subType,
subid=self.subId,
extraParams={
tab_idx=jumpType,
channel=channel,
monsterGuid=data.guid,
},
}
}
call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqMonsterDetail",self.activityId,self.subId,data.guid,jumpType,jumpParam)
end

function UISubAct_TianMoRuQin_QingBaoWin:onClickRank2(index)
local guidStr=self.listData[index]
local data=self.info:getRankDataImp(guidStr)
if data.hp>0 then
self:onClickRank1(index)
end
end

function UISubAct_TianMoRuQin_QingBaoWin:onClickFight(dataIndex)
local guidStr=self.listData[dataIndex]
local data=self.info:getRankDataImp(guidStr)
if data.peopleMax<=data.people and not data.flag then
return UIManager.error("挑战人数已满")
end


local monsterId=data.monster
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterId)
local monType=monsterCfg.monType
local monsterInfo=self.config.monster[monType]
local fighted=data.fighted
local personal=self.info:findMonsterIndex(data.guid)
local costConfig=personal and monsterInfo[4]or monsterInfo[5]
local costNum=costConfig[fighted+1]or costConfig[#costConfig]
local costId=self.config.money[1]
local haveNum=itemsModel.getCount(costId)
if haveNum<costNum then
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(costId)))
gainControl:showGainWin(costId)
return
end

local actId=self.activityId
local subType=self.subType
local subId=self.subId
local tabType=SUBACT_DEFINETAB_TYPE.eTianMoRuQin_qingbao
local tab_idx=activitiesModel:getSubActDefineTabIndex(tabType)
local index=dataIndex
local channel=self.tabShow[self.selectedTab].tab
local guid=data.guid
local subActInfo=self.info
local args={
dontCloseStage=false,
enterTxt=self.config.sub_name,
groupId=monsterId,
monsterList=monsterCfg.monList,
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
isHomeBattle=false,
enterCallBack=function(selectList,zfId)
if not subActInfo:checkDoing()then
UIManager.error("活动已结束")
return
end

local nowTime=timeHelper.getServerShortTime()
if data.leaveTime>0 and nowTime>=data.leaveTime then
UIManager.error("天魔已离开")
jumpManager:jump({id=JUMP_TYPE.eActivity,args={subType=subType,subid=subId,extraParams={tab_idx=tab_idx,channel=channel}}})
return
end
fightLaunchController:sendFight(eBattleLaunch.tianmoruqin_tm,selectList,monsterCfg.mapId or 0,zfId,{actId,subType,subId,guid})

local tabType=SUBACT_DEFINETAB_TYPE.eTianMoRuQin_qingbao
local jumpType=activitiesModel:getSubActDefineTabIndex(tabType)
local channel=channel
local jumpParam={
id=JUMP_TYPE.eActivity,
args={
subType=subType,
subid=subId,
extraParams={tab_idx=tab_idx,channel=channel,monsterGuid=guid},
}
}
subActInfo:pushFightMonsterJump(guid,jumpType,jumpParam)
end,
cancelCallBack=function()
jumpManager:jump({id=JUMP_TYPE.eActivity,args={subType=subType,subid=subId,extraParams={tab_idx=tab_idx,channel=channel}}})
end,
}
local config=self.config
local monster=monsterId
fightController.showPrepareWin(fightPreSelectModel.fightType.tianmoruqin_tm,args,function()
local txList=config.texing[monster]
local datas={}
for i,v in ipairs(txList)do
local type=v[1]
local index=v[2]
local param={}
if type==1 then
param=monsterCfg.showSkills and monsterCfg.showSkills[index]or nil
else
param=config.faze[monster]and config.faze[monster][index]or nil
end
if param then
local data={type,param}
table.insert(datas,data)
else
loggerUtil.logWarnFMT("天魔入侵怪物无效特性配置：{0},{1},{2}",monster,type,index)
end
end
local args={
title="天魔特性",
data=datas,
}
UIFullFightPrepareControl:showWindow("UIFightPrepareTianMoRuQinTeXingWin",args)
end)
end

function UISubAct_TianMoRuQin_QingBaoWin:onClickReward(index)
local guidStr=self.listData[index]
local data=self.info:getRankDataImp(guidStr)
local nowTime=timeHelper.getServerShortTime()

if data.flag and data.hp<=0 and(data.leaveTime<=0 or data.leaveTime>=nowTime)then
call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqMonsterReward",self.activityId,self.subId,data.guid)
end
end

function UISubAct_TianMoRuQin_QingBaoWin:startCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UISubAct_TianMoRuQin_QingBaoWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UISubAct_TianMoRuQin_QingBaoWin:updateCDTick()

local nowTime=timeHelper.getServerShortTime()
if(self.listTime>0 and self.listTime<nowTime)or(#self.listData<=0)then
self:refreshList()
return
end

local startIdx=_this.enhancedscrollscript:getStartCellViewIndex()
local endIdx=_this.enhancedscrollscript:getEndCellViewIndex()

for i=startIdx,endIdx do
local dataIndex=i+1
local guidStr=self.listData[dataIndex]
local cell=_this.enhancedscrollscript:GetCell(i)
_this.enhancedscrollscript:RefreshCellTime(dataIndex,dataIndex,cell,nowTime)
end
end

function UISubAct_TianMoRuQin_QingBaoWin:randomCatTalk(bt)
local r=math.random(1,#self.config.catTalk)
self.catTalkDesc:setText(self.config.catTalk[r])
end

function UISubAct_TianMoRuQin_QingBaoWin:on_249_135(actId,subType,subId)
if self.info:compare(actId,subType,subId)then
self:refreshView()
end
end

function UISubAct_TianMoRuQin_QingBaoWin:onMoneyAdd()
self.info:showMoneyBuyPanel(self.costItem)
end

function UISubAct_TianMoRuQin_QingBaoWin:onMoneyBg()
gainControl:showGainWin(self.costItem)
end

function UISubAct_TianMoRuQin_QingBaoWin:initCost()
self.costItem=self.config.money[1]
self.costMax=self.config.money[2]
local iconName=iconHelper.getIconName(self.costItem)
self.moneyIcon:setImageIcon(iconName,false)

self:refreshCost()
end

function UISubAct_TianMoRuQin_QingBaoWin:refreshCost(val)
local cur=val or itemsModel.getCount(self.costItem)
local str=FMT.fmt("{0}/{1}",cur,self.costMax)
self.moneyNum:setText(str)
end

function UISubAct_TianMoRuQin_QingBaoWin.on_money_changed(moneyType,lastVal,val)
if moneyType==_this.costItem then
_this:refreshCost(val)
end
end

function UISubAct_TianMoRuQin_QingBaoWin.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if itemid==_this.costItem then
_this:refreshCost(newcount)
end
end

function UIPrepareEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:RefreshCell(dataIndex,cellIndex,cell)
if self.window and self.window.isClose then
return
end
local tabCfg=self.window.tabShow[self.window.selectedTab]
local refreshName=FMT.fmt("RefreshCell{0}",tabCfg.style)
self[refreshName](self,dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:RefreshCellTime(dataIndex,cellIndex,cell,nowTime)
if self.window and self.window.isClose then
return
end

local tabCfg=self.window.tabShow[self.window.selectedTab]
local refreshName=FMT.fmt("RefreshCellTime{0}",tabCfg.style)
self[refreshName](self,dataIndex,cellIndex,cell,nowTime)
end

function UIPrepareEnScroller:RefreshCell1(dataIndex,cellIndex,cell)
local guidStr=self.window.listData[dataIndex]
local data=self.window.info:getRankDataImp(guidStr)
local mCfg=cfgHelper.get1(cfg_monstergroup_get,data.monster)
local mType=mCfg.monType



cell:SetChildButtonClick(_rankCmp.fightBtn,function()
self.window:onClickFight(dataIndex)
end)
cell:SetChildButtonClick(_rankCmp.rewardBtn,nil)
comHelper.setChildModelRawImage_monsterGroup(cell,data.monster,_rankCmp.image,0,eHeadCenterType.eHead)
local bgName=_iconBg[mType]
if bgName then
cell:SetChildCSImageSprite(_rankCmp.iconBg,_iconAb,bgName)
else
cell:SetChildCSImageIcon(_rankCmp.iconBg,nil,true)
end
local tagName=_iconTag[mType]
if tagName then
cell:SetChildCSImageSprite(_rankCmp.tag,_iconAb,tagName)
else
cell:SetChildCSImageIcon(_rankCmp.tag,nil,true)
end
cell:SetChildText(_rankCmp.name,mCfg.name)
cell:SetChildAnchoredPos(_rankCmp.name,-234,13)

cell:SetChildActive(_rankCmp.progressBar,true)
local bloodPrecent=Mathf.Clamp(data.hp/data.maxHp,0,1)
cell:SetChildProgressValue(_rankCmp.progressBar,math.ceil(bloodPrecent*10000),10000)
cell:SetChildProgressText(_rankCmp.progressBar,FMT.fmt("{0}%",math.ceil(bloodPrecent*100)))

local leastTime=data.leaveTime-timeHelper.getServerShortTime()
local isLeave=leastTime<0
local timeStr="已离开"
if not isLeave then
timeStr=timeHelper.format_time_stamp(leastTime)
timeStr=FMT.fmt("<color=#529224>{0}后离开</color>",timeStr)
end
cell:SetChildText(_rankCmp.timeTx,timeStr)

cell:SetChildText(_rankCmp.peopleTx,FMT.fmt("{0}/{1}",data.people,data.peopleMax))
cell:SetChildActive(_rankCmp.rewardBtn,false)
cell:SetChildActive(_rankCmp.fightBtn,true)
cell:SetChildImageExGray(_rankCmp.fightBtn,data.people>=data.peopleMax and not data.flag)
cell:SetChildActive(_rankCmp.owner,data.fighted>0)
cell:SetChildActive(_rankCmp.finish,false)
cell:SetChildActive(_rankCmp.decorate,dataIndex>1)

if data.hp>0 then
local col=self.window.info:findMonsterIndex(data.guid)and 4 or 5
local costList=self.window.config.monster[mType][col]
local costCnt=costList[data.fighted+1]or costList[#costList]
cell:SetChildActive(_rankCmp.costIcon,costCnt>0)
cell:SetChildCSImageIcon(_rankCmp.costIcon,iconHelper.getIconName(self.window.costItem),false)
cell:SetChildText(_rankCmp.costNum,costCnt<=0 and"免费"or costCnt)
else
cell:SetChildCSImageIcon(_rankCmp.costIcon,"",false)
cell:SetChildActive(_rankCmp.costIcon,false)
cell:SetChildText(_rankCmp.costNum,"无")
end
cell:ForceLayoutRect(_rankCmp.costRoot)
end

function UIPrepareEnScroller:RefreshCellTime1(dataIndex,cellIndex,cell,nowTime)
nowTime=nowTime or timeHelper.getServerShortTime()
local guidStr=self.window.listData[dataIndex]
local data=self.window.info:getRankDataImp(guidStr)
local leastTime=data and data.leaveTime-nowTime or-1
local isLeave=leastTime<0
local timeStr="已离开"
if not isLeave then
timeStr=timeHelper.format_time_stamp(leastTime)
timeStr=FMT.fmt("<color=#529224>{0}后离开</color>",timeStr)
end
cell:SetChildText(_rankCmp.timeTx,timeStr)
end

function UIPrepareEnScroller:RefreshCell2(dataIndex,cellIndex,cell)
local guidStr=self.window.listData[dataIndex]
local data=self.window.info:getRankDataImp(guidStr)
local mCfg=cfgHelper.get1(cfg_monstergroup_get,data.monster)
local mType=mCfg.monType



cell:SetChildButtonClick(_rankCmp.fightBtn,function()
self.window:onClickFight(dataIndex)
end)
cell:SetChildButtonClick(_rankCmp.rewardBtn,function()
self.window:onClickReward(dataIndex)
end)
comHelper.setChildModelRawImage_monsterGroup(cell,data.monster,_rankCmp.image,0,eHeadCenterType.eHead)
local bgName=_iconBg[mType]
if bgName then
cell:SetChildCSImageSprite(_rankCmp.iconBg,_iconAb,bgName)
else
cell:SetChildCSImageIcon(_rankCmp.iconBg,nil,true)
end
local tagName=_iconTag[mType]
if tagName then
cell:SetChildCSImageSprite(_rankCmp.tag,_iconAb,tagName)
else
cell:SetChildCSImageIcon(_rankCmp.tag,nil,true)
end
cell:SetChildText(_rankCmp.name,mCfg.name)

local isLive=data.hp>0
cell:SetChildActive(_rankCmp.progressBar,isLive)
cell:SetChildAnchoredPos(_rankCmp.name,-234,isLive and 13 or 0)
if isLive then
local bloodPrecent=Mathf.Clamp(data.hp/data.maxHp,0,1)
cell:SetChildProgressValue(_rankCmp.progressBar,math.ceil(bloodPrecent*10000),10000)
cell:SetChildProgressText(_rankCmp.progressBar,FMT.fmt("{0}%",math.ceil(bloodPrecent*100)))
end

cell:SetChildText(_rankCmp.peopleTx,FMT.fmt("{0}/{1}",data.people,data.peopleMax))

local timeStr="暂无"
if not isLive then
timeStr="已击败"
elseif data.leaveTime>0 then
local leastTime=data.leaveTime-timeHelper.getServerShortTime()
local isLeave=leastTime<0
if isLeave then
timeStr="已离开"
else
timeStr=timeHelper.format_time_stamp(leastTime)
timeStr=FMT.fmt("<color=#529224>{0}后离开</color>",timeStr)
end
end
cell:SetChildText(_rankCmp.timeTx,timeStr)

cell:SetChildActive(_rankCmp.rewardBtn,not isLive)
cell:SetChildActive(_rankCmp.fightBtn,isLive)
cell:SetChildActive(_rankCmp.owner,false)
cell:SetChildActive(_rankCmp.finish,not isLive)
cell:SetChildActive(_rankCmp.decorate,dataIndex>1)
if isLive then
local col=self.window.info:findMonsterIndex(data.guid)and 4 or 5
local costList=self.window.config.monster[mType][col]
local costCnt=costList[data.fighted+1]or costList[#costList]
cell:SetChildActive(_rankCmp.costIcon,costCnt>0)
cell:SetChildCSImageIcon(_rankCmp.costIcon,iconHelper.getIconName(self.window.costItem),false)
cell:SetChildText(_rankCmp.costNum,costCnt<=0 and"免费"or costCnt)
cell:SetChildImageExGray(_rankCmp.fightBtn,false)
else
cell:SetChildCSImageIcon(_rankCmp.costIcon,"",false)
cell:SetChildActive(_rankCmp.costIcon,false)
cell:SetChildText(_rankCmp.costNum,"无")
end
cell:ForceLayoutRect(_rankCmp.costRoot)
end

function UIPrepareEnScroller:RefreshCellTime2(dataIndex,cellIndex,cell,nowTime)
nowTime=nowTime or timeHelper.getServerShortTime()
local guidStr=self.window.listData[dataIndex]
local data=self.window.info:getRankDataImp(guidStr)
local timeStr="暂无"
if data then
local isLive=data.hp>0
if not isLive then
timeStr="已击败"
elseif data.leaveTime>0 then
local leastTime=data.leaveTime-nowTime
local isLeave=leastTime<0
if isLeave then
timeStr="已离开"
else
timeStr=timeHelper.format_time_stamp(leastTime)
timeStr=FMT.fmt("<color=#529224>{0}后离开</color>",timeStr)
end
end
end
cell:SetChildText(_rankCmp.timeTx,timeStr)
end

function UIPrepareEnScroller:onItemClick(eventName,clickCount,index,cell)
self.window:onClickRank(index+1)
end
