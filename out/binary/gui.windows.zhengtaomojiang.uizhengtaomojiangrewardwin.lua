







def_class("UIZhengTaoMoJiangRewardWin",UIWindowBase)









function UIZhengTaoMoJiangRewardWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.content_1=UIObject.get(self,2)
self.content_2=UIObject.get(self,3)
self.content_3=UIObject.get(self,4)
self.monsterList=UIObject.get(self,5)
self.tipsBg=UIObject.get(self,6)
self.tipsCheck=UIText.get(self,7)
self.tipsPanel=UIButton.get(self,8)
self.tipsTx=UIText.get(self,9)
self.typeList=UIObject.get(self,10)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.tipsPanel:setButtonClick(function()self:onTipsPanel()end)
self.content={
self.content_1,
self.content_2,
self.content_3,
}



end


function UIZhengTaoMoJiangRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.content_1);self.content_1=nil;
_UIObject_release(self.content_2);self.content_2=nil;
_UIObject_release(self.content_3);self.content_3=nil;
_UIObject_release(self.monsterList);self.monsterList=nil;
_UIObject_release(self.tipsBg);self.tipsBg=nil;
_UIObject_release(self.tipsCheck);self.tipsCheck=nil;
_UIObject_release(self.tipsPanel);self.tipsPanel=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
_UIObject_release(self.typeList);self.typeList=nil;
self.content=nil;
end















local _this=nil
local _monsterCmp={
root=-1,
name=0,
flag=1,
select=2,
reddot=3,
}
local _typeCmp={
root=-1,
name=0,
select=1,
reddot=2,
}
local _hurtCmp={
desc=0,
rewards=1,
getBtn=2,
getFlag=3,
getNot=4,
rewardsView=5,
}
local _content1Cmp={
hurtView=0,
hurtTx=1,
}
local _content2Cmp={
rewardList_1=0,
rewardList_2=1,
tips_1=2,
helpBtn=3,
}
local _content3Cmp={
stageTx=0,
deadView=1,
deadList=2,
liveView=3,
liveList=4,
rewardBtn=5,
rewardView=6,
rewardList=7,
rewardEmpty=8,
}
local _typeHandle={
[1]={
name="伤害",
refresh=function(win)
win:refreshPanel_1()
end,
reddot=function(seasonType,stageIndex,monsterDatas)
for i,v in ipairs(monsterDatas)do
local entity=xianjieModel:getMoJiangEntity(seasonType,stageIndex,v.id)
if entity:checkRankReddot()then
return true
end
end
return false
end,
},
[2]={
name="阶数",
refresh=function(win)
win:refreshPanel_3()
end,
reddot=function(seasonType,stageIndex,monsterDatas)
for i,v in ipairs(monsterDatas)do
local entity=xianjieModel:getMoJiangEntity(seasonType,stageIndex,v.id)
if entity:checkDailyReddot()then
return true
end
end
return false
end,
},
[3]={
name="奖励",
refresh=function(win)
win:refreshPanel_2()
end,
},
}
local _abName="ui/windows/zhengtaomojiang/zhengtaomojiang_info_atlas_pak.ab"



function UIZhengTaoMoJiangRewardWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
self:addNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
self:addNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
self:addNotify(notifyConfig.onNewDay,self.onNewDay)
self:addProNotify(39,10,self.on_39_10)
self:addProNotify(39,2,self.on_39_2)
self.cdItems={}
self:initTypeList()

self.contentWidget={}
for i,v in ipairs(self.content)do
table.insert(self.contentWidget,v:getWidgetBase())
end

self._loopListView=self.contentWidget[1]:GetChildUILoopListView(_content1Cmp.hurtView)
self._loopListView:SetAction(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.contentWidget[2]:SetChildButtonClick(_content2Cmp.helpBtn,function()
self:onHelpBtn()
end)
self.contentWidget[3]:SetChildButtonClick(_content3Cmp.rewardBtn,function()
self:onClickDaily()
end)

local obj=self.tipsCheck:getGameObject()
local width=self.tipsCheck:getChildSizeDeltaX()
local str=cfgHelper.getlang("zhengtaomojiangstagetips2")
local tipsStr=comHelper.getCheckLayoutStr(obj,width,str,true)
self.tipsTx:setText(tipsStr)
self.winlua:ForceLayoutRect(self.tipsTx:getID())
end


function UIZhengTaoMoJiangRewardWin:__delete()
self:unbindComponents()
_this=nil
self._loopListView:SetAction(nil,nil)
self:stopCDTick()
end




function UIZhengTaoMoJiangRewardWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.seasonType=argtable.seasonType
self.stageIndex=argtable.stageIndex
self.build_id=argtable.build_id

self:updateDatas()
self:refreshAllTypeReddot()
self:refreshMonsterList()
self:refreshPanel()
end


function UIZhengTaoMoJiangRewardWin:onHide()

end




function UIZhengTaoMoJiangRewardWin:onBackground()
self:onCloseBtn()
end

function UIZhengTaoMoJiangRewardWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end


function UIZhengTaoMoJiangRewardWin:onHelpBtn()
self.tipsPanel:setActive(true)
self.winlua:ForceLayoutRect(self.tipsBg:getID())
end


function UIZhengTaoMoJiangRewardWin:onTipsPanel()
self.tipsPanel:setActive(false)
end

function UIZhengTaoMoJiangRewardWin:onClickReward(index)
local monsterData=self.monsterDatas[self.monsterSelect]
local build_id=monsterData.id
local entityData=xianjieModel:getMoJiangEntity(self.seasonType,self.stageIndex,build_id)
local stageCfg=seasonModel:getStageConfigEx(self.seasonType,self.stageIndex,'mojiang',build_id)
local hurtData=self.hurtDatas[index]
local getted=entityData.damageFlag>=hurtData.index
local enough=entityData.damage>=stageCfg.damage[hurtData.index][1]
if getted then
UIManager.error("已领取")
elseif not enough then
UIManager.error("未满足条件")
else
local highest=hurtData.index
for i=index,#self.hurtDatas do
local hData=self.hurtDatas[i]
if hData.state==0 then
highest=hData.index
else
break
end
end
xianjieController:reqMoJiangDamageReward(self.seasonType,self.stageIndex,build_id,highest)
end
end

function UIZhengTaoMoJiangRewardWin:onClickDaily()
if not limitActivitiesModel:checkAct_Open_Doing()then
local monsterData=self.monsterDatas[self.monsterSelect]
local build_id=monsterData.id
local entityData=xianjieModel:getMoJiangEntity(self.seasonType,self.stageIndex,build_id)
local target=entityData:getDailyRewardTarget()+1
if entityData.dailyFlag<target then
local monsterData=self.monsterDatas[self.monsterSelect]
local build_id=monsterData.id
xianjieController:reqMoJiangDailyReward(self.seasonType,self.stageIndex,build_id,target)
else
UIManager.error("没有可领取")
end
else
UIManager.error("活动未结束")
end
end

function UIZhengTaoMoJiangRewardWin:onStartAction()

end

function UIZhengTaoMoJiangRewardWin:onFreshAction(index,widget)
index=index+1
local monsterData=self.monsterDatas[self.monsterSelect]
local build_id=monsterData.id
local stageCfg=seasonModel:getStageConfigEx(self.seasonType,self.stageIndex,'mojiang',build_id)
local hurtData=self.hurtDatas[index]
local config=stageCfg.damage[hurtData.index]
local state=hurtData.state
widget:SetChildText(_hurtCmp.desc,FMT.fmt("累计造成<color=#7D3B17>{0}</color>伤害",mathHelper.formatNumber7(config[1],2,2)))
widget:SetChildLayoutGroupCreateItems(_hurtCmp.rewards,#config[2],function(idx)
local item=widget:GetChildLayoutGroupGridItem(_hurtCmp.rewards,idx-1)
local itemData=config[2][idx]
local itemId=itemData[1]
local itemNum=itemData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local _itemConf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local _itemProp=itemsComponentHelper.getCommonFillDataSmall(_itemConf)
item:SetChildPropData(0,_itemProp)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
item:SetChildActive(1,state==2)
end)
widget:SetChildAnchoredPos(_hurtCmp.rewards,0,0)
widget:SetChildScrollRectEnable(_hurtCmp.rewardsView,#config[2]>=5)
widget:SetChildActive(_hurtCmp.getBtn,state==0)
widget:SetChildActive(_hurtCmp.getNot,state==1)
widget:SetChildActive(_hurtCmp.getFlag,state==2)
widget:SetChildButtonClick(_hurtCmp.getBtn,function()
self:onClickReward(index)
end)
end

function UIZhengTaoMoJiangRewardWin:updateDatas()
self.monsterDatas=xianjieModel:getMoJiangSortList(self.seasonType,self.stageIndex)
if self.build_id then
for i,v in ipairs(self.monsterDatas)do
if v.id==self.build_id then
self.monsterSelect=i
break
end
end
end
self.monsterSelect=self.monsterSelect or 1
end

function UIZhengTaoMoJiangRewardWin:initTypeList()
self.typeSelect=1
self.typeList:setChildLayoutGroupCreateItems(#_typeHandle,function(index)
local item=self.typeList:getChildLayoutGroupGridItem(index-1)
item:SetChildText(_typeCmp.name,_typeHandle[index].name)
item:SetChildActive(_typeCmp.select,self.typeSelect==index)
item:SetChildButtonClick(_typeCmp.root,function()
self:onClickType(index)
end)
end)
end

function UIZhengTaoMoJiangRewardWin:refreshAllTypeReddot()
for i,v in ipairs(_typeHandle)do
self:refreshTypeReddot(i)
end
end

function UIZhengTaoMoJiangRewardWin:refreshTypeReddot(index)
local typeHandle=_typeHandle[index]
local item=self.typeList:getChildLayoutGroupGridItem(index-1)
local reddot=typeHandle.reddot and typeHandle.reddot(self.seasonType,self.stageIndex,self.monsterDatas)or false
item:SetChildActive(_typeCmp.reddot,reddot)
end

function UIZhengTaoMoJiangRewardWin:onClickType(index)
if self.typeSelect~=index then
if self.typeSelect then
local item=self.typeList:getChildLayoutGroupGridItem(self.typeSelect-1)
item:SetChildActive(_typeCmp.select,false)
end

self.typeSelect=index

local item=self.typeList:getChildLayoutGroupGridItem(self.typeSelect-1)
item:SetChildActive(_typeCmp.select,true)

self:refreshPanel()
self:refreshAllMonsterReddot()
end
end

function UIZhengTaoMoJiangRewardWin:refreshMonsterList()
self.monsterList:setChildLayoutGroupCreateItems(#self.monsterDatas,function(index)
local item=self.monsterList:getChildLayoutGroupGridItem(index-1)
local monsterData=self.monsterDatas[index]
local build_id=monsterData.id
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,build_id)
local entity=xianjieModel:getMoJiangEntity(self.seasonType,self.stageIndex,build_id)
local reddot=false
if self.typeSelect==1 then
reddot=entity:checkRankReddot()
elseif self.typeSelect==2 then
reddot=entity:checkDailyReddot()
end
item:SetChildButtonClick(_monsterCmp.root,function()
self:onClickMonster(index)
end)
item:SetChildText(_monsterCmp.name,buildCfg.name)
item:SetChildActive(_monsterCmp.flag,entity.killTime>0)
item:SetChildActive(_monsterCmp.select,self.monsterSelect==index)
item:SetChildActive(_monsterCmp.reddot,reddot)
end)
end

function UIZhengTaoMoJiangRewardWin:refreshMonsterReddot(build_id)
for index,monsterData in ipairs(self.monsterDatas)do
if monsterData.id==build_id then
local item=self.monsterList:getChildLayoutGroupGridItem(index-1)
local entity=xianjieModel:getMoJiangEntity(self.seasonType,self.stageIndex,build_id)
local reddot=false
if self.typeSelect==1 then
reddot=entity:checkRankReddot()
elseif self.typeSelect==2 then
reddot=entity:checkDailyReddot()
end
item:SetChildActive(_monsterCmp.reddot,reddot)
return
end
end
end

function UIZhengTaoMoJiangRewardWin:refreshAllMonsterReddot()
for index,monsterData in ipairs(self.monsterDatas)do
local item=self.monsterList:getChildLayoutGroupGridItem(index-1)
local build_id=monsterData.id
local entity=xianjieModel:getMoJiangEntity(self.seasonType,self.stageIndex,build_id)
local reddot=false
if self.typeSelect==1 then
reddot=entity:checkRankReddot()
elseif self.typeSelect==2 then
reddot=entity:checkDailyReddot()
end
item:SetChildActive(_monsterCmp.reddot,reddot)
end
end

function UIZhengTaoMoJiangRewardWin:refreshMonstersFlag()
for i,v in ipairs(self.monsterDatas)do
local item=self.monsterList:getChildLayoutGroupGridItem(i-1)
local build_id=v.id
local entity=xianjieModel:getMoJiangEntity(self.seasonType,self.stageIndex,build_id)
item:SetChildActive(_monsterCmp.flag,entity.killTime>0)
end
end

function UIZhengTaoMoJiangRewardWin:onClickMonster(index)
if self.monsterSelect~=index then
if self.monsterSelect then
local item=self.monsterList:getChildLayoutGroupGridItem(self.monsterSelect-1)
item:SetChildActive(_monsterCmp.select,false)
end

self.monsterSelect=index

local item=self.monsterList:getChildLayoutGroupGridItem(self.monsterSelect-1)
item:SetChildActive(_monsterCmp.select,true)

self:refreshPanel()
end
end

function UIZhengTaoMoJiangRewardWin:refreshPanel()
_typeHandle[self.typeSelect].refresh(self)
end

function UIZhengTaoMoJiangRewardWin:showContentPanel(id)
for i,v in ipairs(self.content)do
v:setActive(i==id)
end
end

function UIZhengTaoMoJiangRewardWin:refreshPanel_3()
self:showContentPanel(3)

local contentWidget=self.contentWidget[3]
local monsterData=self.monsterDatas[self.monsterSelect]
local build_id=monsterData.id
local stageCfg=seasonModel:getStageConfigEx(self.seasonType,self.stageIndex,'mojiang',build_id)
local entityData=xianjieModel:getMoJiangEntity(self.seasonType,self.stageIndex,build_id)
contentWidget:SetChildText(_content3Cmp.stageTx,FMT.fmt("当前魔将阶数：{0}",entityData.stage))

local reward1=stageCfg.reward[entityData.stage][1]
contentWidget:SetChildLayoutGroupCreateItems(_content3Cmp.deadList,#reward1,function(index)
local item=contentWidget:GetChildLayoutGroupGridItem(_content3Cmp.deadList,index-1)
local data=reward1[index]
local itemId=data[1]
local itemNum=data[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local _conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local _prop=itemsComponentHelper.getCommonFillDataSmall(_conf)
item:SetChildPropData(-1,_prop)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
contentWidget:SetChildAnchoredPos(_content3Cmp.deadList,0,0)
contentWidget:SetChildScrollRectEnable(_content3Cmp.deadView,#reward1>=5)

local reward2=stageCfg.reward[entityData.stage][2]
contentWidget:SetChildLayoutGroupCreateItems(_content3Cmp.liveList,#reward2,function(index)
local item=contentWidget:GetChildLayoutGroupGridItem(_content3Cmp.liveList,index-1)
local data=reward2[index]
local itemId=data[1]
local itemNum=data[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local _conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local _prop=itemsComponentHelper.getCommonFillDataSmall(_conf)
item:SetChildPropData(-1,_prop)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
contentWidget:SetChildAnchoredPos(_content3Cmp.liveList,0,0)
contentWidget:SetChildScrollRectEnable(_content3Cmp.liveView,#reward2>=5)

local stages=entityData:getDailyRewardStage()


local lookup={}
for i,v in ipairs(stages)do
local _stage=v[1]
local _flag=v[2]
local _rewards=stageCfg.reward[_stage][_flag and 1 or 2]
for j,w in ipairs(_rewards)do
local itemid=w[1]
local itemnum=w[2]
lookup[itemid]=(lookup[itemid]or 0)+itemnum
end
end
local reward3={}
for i,v in pairs(lookup)do
table.insert(reward3,{i,v})
end
local cnt=#reward3
contentWidget:SetChildLayoutGroupCreateItems(_content3Cmp.rewardList,cnt,function(index)
local item=contentWidget:GetChildLayoutGroupGridItem(_content3Cmp.rewardList,index-1)
local data=reward3[index]
local itemId=data[1]
local itemNum=data[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local _conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local _prop=itemsComponentHelper.getCommonFillDataSmall(_conf)
item:SetChildPropData(-1,_prop)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
contentWidget:SetChildAnchoredPos(_content3Cmp.rewardList,0,0)
contentWidget:SetChildScrollRectEnable(_content3Cmp.rewardView,cnt>=6)
contentWidget:SetChildActive(_content3Cmp.rewardEmpty,cnt<=0)

contentWidget:SetChildActive(_content3Cmp.rewardBtn,cnt>0)
end

function UIZhengTaoMoJiangRewardWin:refreshPanel_1()
self:showContentPanel(1)

local contentWidget=self.contentWidget[1]
local monsterData=self.monsterDatas[self.monsterSelect]
local build_id=monsterData.id
local stageCfg=seasonModel:getStageConfigEx(self.seasonType,self.stageIndex,'mojiang',build_id)
local entityData=xianjieModel:getMoJiangEntity(self.seasonType,self.stageIndex,build_id)
local idList={}
local nameList={}
self.hurtDatas={}
for i,v in ipairs(stageCfg.damage)do
table.insert(idList,i)
table.insert(nameList,"hurtItem")

local getted=entityData.damageFlag>=i
local enough=entityData.damage>=v[1]
table.insert(self.hurtDatas,{index=i,state=getted and 2 or(enough and 0 or 1)})
end
table.sort(self.hurtDatas,function(a,b)
if a.state~=b.state then
return a.state<b.state
else
return a.index<b.index
end
end)
self._loopListView:InitDataList(#self.hurtDatas,nameList,idList,nil,nil)
contentWidget:SetChildText(_content1Cmp.hurtTx,FMT.fmt("当前累计伤害：<color=#ca631d>{0}</color>",mathHelper.formatNumber(entityData.damage)))
end

function UIZhengTaoMoJiangRewardWin:refreshPanel_2()
self:showContentPanel(2)

local contentWidget=self.contentWidget[2]
local seasonCfg=seasonModel:getHandleConfig(self.seasonType)
contentWidget:SetChildText(_content2Cmp.tips_1,FMT.fmt("（{0}第{1}章期间，征讨该魔将最多可获得1次首战奖励）",seasonCfg.name,self.stageIndex))

local stage=seasonModel:getStage(self.seasonType,self.stageIndex)
local monsterData=self.monsterDatas[self.monsterSelect]
local build_id=monsterData.id
local entityData=xianjieModel:getMoJiangEntity(self.seasonType,self.stageIndex,build_id)
local stageCfg=stage:getConfig("mojiang",build_id)
local rewards_1=stageCfg.challenge[entityData.stage]
contentWidget:SetChildLayoutGroupCreateItems(_content2Cmp.rewardList_1,#rewards_1,function(index)
local item=contentWidget:GetChildLayoutGroupGridItem(_content2Cmp.rewardList_1,index-1)
local rewardData=rewards_1[index]
local itemId=rewardData[1]
local itemNum=rewardData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local _conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local _prop=itemsComponentHelper.getCommonFillDataSmall(_conf)
item:SetChildPropData(-1,_prop)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)

table.clear(self.cdItems)
local nowTime=timeHelper.getServerShortTime()
local isLive=entityData.killTime<=0
local rewards_2={}
for i,v in ipairs(stageCfg.stage)do
if next(v[3])then
local endTime=stage.beginTime+v[1]
for j,w in ipairs(v[3])do
local temp={
w[1],
w[2],
{
state=i,
name=v[5],
endTime=endTime,
openTime=stage.beginTime+stageCfg.open,
corner=v[9],
}
}
table.insert(rewards_2,temp)
end
end
end
for i,v in ipairs(stageCfg.kill[entityData.stage])do
table.insert(rewards_2,v)
end
contentWidget:SetChildLayoutGroupCreateItems(_content2Cmp.rewardList_2,#rewards_2,function(index)
local item=contentWidget:GetChildLayoutGroupGridItem(_content2Cmp.rewardList_2,index-1)
local rewardData=rewards_2[index]
local itemId=rewardData[1]
local itemNum=rewardData[2]
local state=rewardData[3]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""

local gray=0
if state then
if isLive and nowTime>=state.endTime then
gray=1
elseif not isLive and entityData.killTime>=state.endTime then
gray=1
end
end
local _conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,gray=gray}
local _prop=itemsComponentHelper.getCommonFillDataSmall(_conf)
item:SetChildPropData(0,_prop)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
if state then
if state.corner~=nil and state.corner~=""then
item:SetChildCSImageSprite(1,_abName,state.corner)
else
item:SetChildCSImageIcon(1,"",true)
end
item:SetChildText(2,state.name)
local showTx=false
if nowTime>=state.openTime then
if isLive then
if nowTime<state.endTime then
item:SetChildText(4,FMT.cfmt3('a1ec58',timeHelper.format_time_stamp3(state.endTime-nowTime)))
self.cdItems[index]={openTime=state.openTime,endTime=state.endTime,state=2}
else
item:SetChildText(4,"无法获得")
end
showTx=true
else
if entityData.killTime>=state.endTime then
item:SetChildText(4,"无法获得")
showTx=true
else
item:SetChildText(4,"已获得")
end
end
else
if nowTime<state.endTime then
self.cdItems[index]={openTime=state.openTime,endTime=state.endTime,state=1}
else
item:SetChildText(4,"无法获得")
showTx=true
end
end
item:SetChildActive(3,showTx)
else
item:SetChildCSImageIcon(1,"",true)
item:SetChildText(2,"")
item:SetChildActive(3,false)
end
end)

if next(self.cdItems)then
self:startCDTick()
else
self:stopCDTick()
end
end

function UIZhengTaoMoJiangRewardWin:startCDTick()
if self.cdTick==nil then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UIZhengTaoMoJiangRewardWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UIZhengTaoMoJiangRewardWin:updateCDTick()
local nowTime=timeHelper.getServerShortTime()
local contentWidget=self.contentWidget[2]
for index,info in pairs(self.cdItems)do
local item=contentWidget:GetChildLayoutGroupGridItem(_content2Cmp.rewardList_2,index-1)
local state=info.state
if state==1 then
if nowTime>=info.openTime then
self.cdItems[index].state=2

if nowTime<info.endTime then
item:SetChildText(4,FMT.cfmt3('a1ec58',timeHelper.format_time_stamp3(info.endTime-nowTime)))
else
item:SetChildText(4,"无法获得")

local prop={}
prop[PropIndex(DataPropKey.eWidgetGray,0)]=true
prop[PropIndex(DataPropKey.eWidgetGray,1)]=true
prop[PropIndex(DataPropKey.eWidgetActive,7)]=true
item:SetChildPropData(0,prop)

self.cdItems[index]=nil
end
end
else
if nowTime<info.endTime then
item:SetChildText(4,FMT.cfmt3('a1ec58',timeHelper.format_time_stamp3(info.endTime-nowTime)))
else
item:SetChildText(4,"无法获得")

local prop={}
prop[PropIndex(DataPropKey.eWidgetGray,0)]=true
prop[PropIndex(DataPropKey.eWidgetGray,1)]=true
prop[PropIndex(DataPropKey.eWidgetActive,7)]=true
item:SetChildPropData(0,prop)

self.cdItems[index]=nil
end
end
end
if next(self.cdItems)==nil then
self:stopCDTick()
end
end

function UIZhengTaoMoJiangRewardWin.onSeasonChange()
local stage=seasonModel:getStage(_this.seasonType,_this.stageIndex)
if not stage then
_this:onCloseBtn()
else
_this:refreshPanel()
end
end

function UIZhengTaoMoJiangRewardWin.onSeasonStageChange(seasonType,stageIndex)
if _this.seasonType==seasonType and _this.stageIndex==stageIndex then
_this:refreshPanel()
end
end

function UIZhengTaoMoJiangRewardWin.onLimitActStateChange(actId,state)
if actId==LIMIT_ACT_TYPE.eMoJiang then
if _this.typeSelect==2 then
_typeHandle[_this.typeSelect].refresh(_this)
_this:refreshAllMonsterReddot()
end
_this:refreshTypeReddot(2)
end
end

function UIZhengTaoMoJiangRewardWin.onNewDay()
if _this.typeSelect==2 then
_this:refreshPanel()
end
end

function UIZhengTaoMoJiangRewardWin.on_39_10(seasonType,stageIndex,build_id,damage)
if _this.seasonType==seasonType and _this.stageIndex==stageIndex then
local monsterData=_this.monsterDatas[_this.monsterSelect]
local _build_id=monsterData.id
if _this.typeSelect==1 then
if _build_id==build_id then
_typeHandle[_this.typeSelect].refresh(_this)
end
_this:refreshMonsterReddot(build_id)
end
_this:refreshTypeReddot(1)
end
end

function UIZhengTaoMoJiangRewardWin.on_39_2(seasonType,stageIndex,dataType,build_id)
if _this.seasonType==seasonType and _this.stageIndex==stageIndex then
if dataType==6 then
local monsterData=_this.monsterDatas[_this.monsterSelect]
local _build_id=monsterData.id
if _this.typeSelect==1 then
if _build_id==build_id then
_typeHandle[_this.typeSelect].refresh(_this)
end
_this:refreshMonsterReddot(build_id)
end
_this:refreshTypeReddot(1)

elseif dataType==7 then
local monsterData=_this.monsterDatas[_this.monsterSelect]
local _build_id=monsterData.id
if _this.typeSelect==2 then
if _build_id==build_id then
_typeHandle[_this.typeSelect].refresh(_this)
end
_this:refreshMonsterReddot(build_id)
end
_this:refreshTypeReddot(2)
end
end
end