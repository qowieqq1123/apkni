







def_class("UIZhengTaoMoJiangRankWin",UIWindowBase)









function UIZhengTaoMoJiangRankWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.monsterList=UIObject.get(self,2)
self.owner_1=UIObject.get(self,3)
self.owner_2=UIObject.get(self,4)
self.panel_1=UIObject.get(self,5)
self.panel_2=UIObject.get(self,6)
self.scrollView_1=UILoopListView.new(self,7)
self.scrollView_2=UILoopListView.new(self,8)
self.tips_1=UIObject.get(self,9)
self.tips_2=UIObject.get(self,10)
self.tipsBtn1_1=UIButton.get(self,11)
self.tipsBtn2_1=UIButton.get(self,12)
self.tipsBtn2_2=UIButton.get(self,13)
self.tipsPanel=UIButton.get(self,14)
self.typeList=UIObject.get(self,15)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.scrollView_1:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.scrollView_2:bindLoopListView(function(...)
self:onFreshAction_2(...)
end,function(...)
self:onStartAction_2(...)
end)
self.tipsBtn1_1:setButtonClick(function()self:onTipsBtn1_1()end)

self.tipsBtn2_1:setButtonClick(function()self:onTipsBtn2_1()end)

self.tipsBtn2_2:setButtonClick(function()self:onTipsBtn2_2()end)

self.tipsPanel:setButtonClick(function()self:onTipsPanel()end)
self.owner={
self.owner_1,
self.owner_2,
}
self.panel={
self.panel_1,
self.panel_2,
}
self.scrollView={
self.scrollView_1,
self.scrollView_2,
}
self.tips={
self.tips_1,
self.tips_2,
}
self.tipsBtn1={
self.tipsBtn1_1,
}
self.tipsBtn2={
self.tipsBtn2_1,
self.tipsBtn2_2,
}



end


function UIZhengTaoMoJiangRankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.monsterList);self.monsterList=nil;
_UIObject_release(self.owner_1);self.owner_1=nil;
_UIObject_release(self.owner_2);self.owner_2=nil;
_UIObject_release(self.panel_1);self.panel_1=nil;
_UIObject_release(self.panel_2);self.panel_2=nil;
self.scrollView_1:deleteSelf();self.scrollView_1=nil;
self.scrollView_2:deleteSelf();self.scrollView_2=nil;
_UIObject_release(self.tips_1);self.tips_1=nil;
_UIObject_release(self.tips_2);self.tips_2=nil;
_UIObject_release(self.tipsBtn1_1);self.tipsBtn1_1=nil;
_UIObject_release(self.tipsBtn2_1);self.tipsBtn2_1=nil;
_UIObject_release(self.tipsBtn2_2);self.tipsBtn2_2=nil;
_UIObject_release(self.tipsPanel);self.tipsPanel=nil;
_UIObject_release(self.typeList);self.typeList=nil;
self.owner=nil;
self.panel=nil;
self.scrollView=nil;
self.tips=nil;
self.tipsBtn1=nil;
self.tipsBtn2=nil;
end















local _this=nil
local _monsterCmp={
root=-1,
name=0,
flag=1,
select=2,
}
local _typeCmp={
root=-1,
name=1,
select=0,
}
local _typeDatas={
[1]={
type=1,
name="祖师",
colName="actorrank",
isDrop=false,
panel=1,
rankItem="item1",
refreshOwner=function(win,num,score)
win:refreshOwner1(num,score)
win:stopCDTick()
end,
getStateRewawrds=function(win,build_id,stageCfg,beginTime)
return defaultT
end,
},
[2]={
type=2,
name="仙盟",
colName="guildrank",
isDrop=true,
panel=2,
rankItem="item2",
refreshOwner=function(win,num,score)
win:refreshOwner2(num,score)
win:startCDTick()
end,
getStateRewawrds=function(win,build_id,stageCfg,beginTime)
if win.lastBuild~=build_id then
win.lastBuild=build_id
win.xmStateRewards={}
for i,v in ipairs(stageCfg.stage)do
local rewards=v[4]>0 and cfgHelper.get2(cfg_awardconfig_get,v[4],"showItems")or defaultT
if next(rewards)then
local endTime=beginTime+v[1]
for j,w in ipairs(rewards)do
local temp={
w[1],
w[2],
{
state=i,
name=v[5],
endTime=endTime,
corner=v[9],
openTime=beginTime+stageCfg.open,
}
}
table.insert(win.xmStateRewards,temp)
end
end
end
end
return win.xmStateRewards
end,
}
}
local _owner1Cmp={
rankImage=0,
rankImageTx=1,
rankTx=2,
headBG=3,
head=4,
playerName=5,
serverName=6,
score=7,
rewardList=8,
noReward=9,
rewardView=10,
}
local _owner2Cmp={
rankImage=0,
rankImageTx=1,
rankTx=2,
xmBGIcon=3,
xmIcon=4,
xmKuangIcon=5,
xmName=6,
score=7,
rewardList=8,
noReward=9,
serverName=10,
rewardView=11,
}
local _item1Cmp={
rankImage=0,
rankImageTx=1,
rankTx=2,
playerList=3,
score=4,
rewardList=5,
noPlayer=6,
rewardView=7,
}
local _item2Cmp={
rankImage=0,
rankImageTx=1,
rankTx=2,
xmList=3,
score=4,
rewardList=5,
noPlayer=6,
rewardView=7,
}
local tips1Pos={
{295,187},
{185,187},
}
local _abName="ui/windows/zhengtaomojiang/zhengtaomojiang_info_atlas_pak.ab"



function UIZhengTaoMoJiangRankWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
self:addNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
self:addProNotify(39,12,self.on_39_12)
self:addProNotify(39,13,self.on_39_13)

self.ownerWidget={}
for i,v in ipairs(self.owner)do
local widget=v:getChildWidgetBase()
self.ownerWidget[i]=widget
end

self.tips_2:setChildLayoutGroupCreateItems(1,function(index)
local item=self.tips_2:getChildLayoutGroupGridItem(index-1)
local str=cfgHelper.getlang("zhengtaomojiangstagetips2")
local obj=item:GetChildGameObject(1)
local width=item:GetChildSizeDeltaX(1)
str=comHelper.getCheckLayoutStr(obj,width,str)
item:SetChildText(0,str)
item:ForceLayoutRect(0)
end)
self.winlua:ForceLayoutRect(self.tips_2:getID())

self.dataCache={}
self.cdItems={}
end


function UIZhengTaoMoJiangRankWin:__delete()
self:unbindComponents()
_this=nil

self:stopCDTick()
end




function UIZhengTaoMoJiangRankWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.seasonType=argtable.seasonType
self.stageIndex=argtable.stageIndex
self.build_id=argtable.build_id

self:updateDatas()
self:refresTipsPanel()
self:refreshMonsterList()
self:refreshTypeList()
self:refreshRankList()
end


function UIZhengTaoMoJiangRankWin:onHide()

end




function UIZhengTaoMoJiangRankWin:onBackground()
self:onCloseBtn()
end


function UIZhengTaoMoJiangRankWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end


function UIZhengTaoMoJiangRankWin:onTipsPanel()
self.tipsPanel:setActive(false)
end

function UIZhengTaoMoJiangRankWin:onTipsBtn1_1()
self:showTipsPanel(1,tips1Pos[2])
end

function UIZhengTaoMoJiangRankWin:onTipsBtn2_1()
self:showTipsPanel(1,tips1Pos[2])
end

function UIZhengTaoMoJiangRankWin:onTipsBtn2_2()
self:showTipsPanel(2)
end

function UIZhengTaoMoJiangRankWin:showTipsPanel(index,pos)
self.tipsPanel:setActive(true)
for i,v in ipairs(self.tips)do
local show=index==i
v:setActive(show)
if show then
if pos then
v:setChildAnchoredPos(pos[1],pos[2])
end
self.winlua:ForceLayoutRect(v:getID())
end
end
self.winlua:ForceLayoutRect(self.tipsPanel:getID())
end

function UIZhengTaoMoJiangRankWin:refresTipsPanel()
local scoreCfg=seasonModel:getStageConfigEx(self.seasonType,self.stageIndex,"score")
local build_id=self.monsterDatas[self.monsterSelect].id
local entityData=xianjieModel:getMoJiangEntity(self.seasonType,self.stageIndex,build_id)
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,entityData.monster_id)
local soldierLv=monsterCfg.jzInfo[1][1]
local score1=scoreCfg[1][soldierLv]
local score2=scoreCfg[2]
local tipStrs={}
if score1>0 then
table.insert(tipStrs,FMT.fmt("击杀1个魔兵=<color=#f1ce78>{0}积分</color>",score1))
end
if score2>0 then
table.insert(tipStrs,FMT.fmt("对魔将每造成{0}伤害=<color=#f1ce78>1积分</color>",mathHelper.formatNumber(score2)))
end
self.tips_1:setChildLayoutGroupCreateItems(#tipStrs,function(index)
local item=self.tips_1:getChildLayoutGroupGridItem(index-1)
local str=tipStrs[index]
local obj=item:GetChildGameObject(1)
local width=item:GetChildSizeDeltaX(1)
str=comHelper.getCheckLayoutStr(obj,width,str)
item:SetChildText(0,str)
item:ForceLayoutRect(0)
end)
self.winlua:ForceLayoutRect(self.tips_1:getID())
end

function UIZhengTaoMoJiangRankWin:onStartAction()

end

function UIZhengTaoMoJiangRankWin:onFreshAction(index,widget)
local cfg=self.rankCfg[index]
local minRank=cfg[1]
local maxRank=cfg[2]




local number=maxRank-minRank+1
local multi=number>1
local showRankImage=not multi and 1<=minRank and minRank<=3
widget:SetChildActive(_item1Cmp.rankImage,showRankImage)
widget:SetChildActive(_item1Cmp.rankTx,not showRankImage)
if showRankImage then
widget:SetChildCSImageSprite(_item1Cmp.rankImage,globalABLookup.global,'icon_phbmingci_'..minRank)
widget:SetChildText(_item1Cmp.rankImageTx,minRank)
elseif minRank==maxRank then
widget:SetChildText(_item1Cmp.rankTx,tostring(minRank))
else
widget:SetChildText(_item1Cmp.rankTx,FMT.fmt("{0}~{1}",minRank,maxRank))
end
local rankDatas={}
for i=1,math.min(number,4)do
table.insert(rankDatas,self.rankList[minRank+i-1])
end
local rankCnt=#rankDatas
widget:SetChildLayoutGroupCreateItems(_item1Cmp.playerList,rankCnt,function(index)
local item=widget:GetChildLayoutGroupGridItem(_item1Cmp.playerList,index-1)
local rankData=rankDatas[index]
playerController:setHeadIcon(item,1,{iconInfo=rankData.iconInfo})
local nameStr=""
local serverStr=""
if not multi then
nameStr=playerModel:checkActorId(rankData.actorid)and FMT.cfmt(FONT_COLOR.eGreenColor,rankData.actorname)or rankData.actorname
serverStr=FMT.fmt("[{0}]",loginModel:getServerName(rankData.serverid))
serverStr=playerModel:checkActorId(rankData.actorid)and FMT.cfmt(FONT_COLOR.eGreenColor,serverStr)or serverStr
end
item:SetChildText(2,nameStr)
item:SetChildText(3,serverStr)
item:SetChildButtonClick(0,function()
self:onClickPlayer(rankData)
end)
end)
widget:SetChildActive(_item1Cmp.noPlayer,rankCnt<=0)

local scoreStr=nil
if not multi then
scoreStr="暂无"
if rankDatas[1]then
scoreStr=tostring(rankDatas[1].score)
scoreStr=playerModel:checkActorId(rankDatas[1].actorid)and FMT.cfmt(FONT_COLOR.eGreenColor,scoreStr)or scoreStr
end
else
scoreStr=next(rankDatas)==nil and"暂无"or""
end
widget:SetChildText(_item1Cmp.score,scoreStr)
local rewards=cfg[3]

widget:SetChildLayoutGroupCreateItems(_item1Cmp.rewardList,#rewards,function(index)
local item=widget:GetChildLayoutGroupGridItem(_item1Cmp.rewardList,index-1)
local rewardData=rewards[index]
local itemId=rewardData[1]
local itemNum=rewardData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local _conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local _prop=itemsComponentHelper.getCommonFillDataSmall(_conf)
item:SetChildPropData(-1,_prop)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
widget:SetChildAnchoredPos(_item1Cmp.rewardList,0,0)
widget:SetChildScrollRectEnable(_item1Cmp.rewardView,#rewards>=5)
end

function UIZhengTaoMoJiangRankWin:onStartAction_2()

end

function UIZhengTaoMoJiangRankWin:onFreshAction_2(index,widget)
local nowTime=timeHelper.getServerShortTime()
local cfg=self.rankCfg[index]
local minRank=cfg[1]
local maxRank=cfg[2]




local number=maxRank-minRank+1
local multi=number>1
local showRankImage=not multi and 1<=minRank and minRank<=3
widget:SetChildActive(_item2Cmp.rankImage,showRankImage)
widget:SetChildActive(_item2Cmp.rankTx,not showRankImage)
if showRankImage then
widget:SetChildCSImageSprite(_item2Cmp.rankImage,globalABLookup.global,'icon_phbmingci_'..minRank)
widget:SetChildText(_item2Cmp.rankImageTx,minRank)
elseif minRank==maxRank then
widget:SetChildText(_item2Cmp.rankTx,tostring(minRank))
else
widget:SetChildText(_item2Cmp.rankTx,FMT.fmt("{0}~{1}",minRank,maxRank))
end

local rankDatas={}
for i=1,math.min(number,4)do
table.insert(rankDatas,self.rankList[minRank+i-1])
end
local rankCnt=#rankDatas
widget:SetChildLayoutGroupCreateItems(_item2Cmp.xmList,rankCnt,function(index)
local item=widget:GetChildLayoutGroupGridItem(_item2Cmp.xmList,index-1)
local rankData=rankDatas[index]
local image=rankData.guildicon>0 and xianmengModel.splitGuildIcon(rankData.guildicon)or xianmengModel:getDefualtGuildIamge()
local abname=globalABLookup.xianmengicons
item:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))
item:SetChildCSImageSprite(0,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))
item:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
local nameStr=""
local serverStr=""
if not multi then
nameStr=rankData.guildname~=""and rankData.guildname or"神秘仙盟"
nameStr=rankData.guildname~=""and xianmengModel:isMyXM2(rankData.guildid)and FMT.cfmt(FONT_COLOR.eGreenColor,nameStr)or nameStr
serverStr=""
if rankData.guildname~=""then
serverStr=FMT.fmt("[{0}]",loginModel:getServerName(rankData.serverid))
serverStr=xianmengModel:isMyXM2(rankData.guildid)and FMT.cfmt(FONT_COLOR.eGreenColor,serverStr)or serverStr
end
end
item:SetChildText(3,nameStr)
item:SetChildText(4,serverStr)
item:SetChildButtonClick(0,function()
self:onClickXM(rankData)
end)
end)
widget:SetChildActive(_item2Cmp.noPlayer,rankCnt<=0)

local scoreStr=nil
if not multi then
scoreStr="暂无"
if rankDatas[1]then
scoreStr=tostring(rankDatas[1].score)
scoreStr=xianmengModel:isMyXM2(rankDatas[1].guildid)and FMT.cfmt(FONT_COLOR.eGreenColor,scoreStr)or scoreStr
end
else
scoreStr=next(rankDatas)==nil and"暂无"or""
end
widget:SetChildText(_item2Cmp.score,scoreStr)

local rewards=cfg[3]

local stateRewardCnt=#self.stateRewards
local showCnt=stateRewardCnt+#rewards
if self.cdItems[index]==nil then
self.cdItems[index]={}
else
table.clear(self.cdItems[index])
end
local build_id=self.monsterDatas[self.monsterSelect].id
local entityData=xianjieModel:getMoJiangEntity(self.seasonType,self.stageIndex,build_id)
widget:SetChildLayoutGroupCreateItems(_item2Cmp.rewardList,showCnt,function(idx)
local item=widget:GetChildLayoutGroupGridItem(_item2Cmp.rewardList,idx-1)
local rewardData=idx<=stateRewardCnt and self.stateRewards[idx]or rewards[idx-stateRewardCnt]
local itemId=rewardData[1]
local itemNum=rewardData[2]
local state=rewardData[3]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local gray=0
local haveState=state~=nil and type(state)=='table'
if haveState then
if entityData.killTime<=0 and nowTime>=state.endTime then
gray=1
elseif entityData.killTime>0 and entityData.killTime>=state.endTime then
gray=1
end
end
local _conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,gray=gray}
local _prop=itemsComponentHelper.getCommonFillDataSmall(_conf)
item:SetChildPropData(0,_prop)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
if haveState then
local showTx=false
if state.corner~=nil and state.corner~=""then
item:SetChildCSImageSprite(1,_abName,state.corner)
else
item:SetChildCSImageIcon(1,"",true)
end
item:SetChildText(2,state.name)
if nowTime>=state.openTime then
if entityData.killTime<=0 then
if nowTime<state.endTime then
item:SetChildText(4,FMT.cfmt3('a1ec58',timeHelper.format_time_stamp3(state.endTime-nowTime)))
self.cdItems[index][idx]={openTime=state.openTime,endTime=state.endTime,state=2}
showTx=true
else
item:SetChildText(4,"无法获得")
showTx=true
end
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
self.cdItems[index][idx]={openTime=state.openTime,endTime=state.endTime,state=1}
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
widget:SetChildAnchoredPos(_item2Cmp.rewardList,0,0)
widget:SetChildScrollRectEnable(_item2Cmp.rewardView,showCnt>=5)
end

function UIZhengTaoMoJiangRankWin:refreshTypeList()
self.typeList:setChildLayoutGroupCreateItems(#_typeDatas,function(index)
local item=self.typeList:getChildLayoutGroupGridItem(index-1)
local typeData=_typeDatas[index]
item:SetChildButtonClick(_typeCmp.root,function()
self:onClickType(index)
end)
item:SetChildText(_typeCmp.name,typeData.name)
item:SetChildActive(_typeCmp.select,self.typeSelect==index)
end)
end

function UIZhengTaoMoJiangRankWin:onClickType(index)
if self.typeSelect~=index then
if self.typeSelect then
local item=self.typeList:getChildLayoutGroupGridItem(self.typeSelect-1)
item:SetChildActive(_typeCmp.select,false)
end

self.typeSelect=index

local item=self.typeList:getChildLayoutGroupGridItem(self.typeSelect-1)
item:SetChildActive(_typeCmp.select,true)

self:refreshRankList()
end
end

function UIZhengTaoMoJiangRankWin:updateDatas()
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
self.typeSelect=self.typeSelect or 1
end

function UIZhengTaoMoJiangRankWin:refreshMonsterList()
self.monsterList:setChildLayoutGroupCreateItems(#self.monsterDatas,function(index)
local item=self.monsterList:getChildLayoutGroupGridItem(index-1)
local build_id=self.monsterDatas[index].id
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,build_id)
local entity=xianjieModel:getMoJiangEntity(self.seasonType,self.stageIndex,build_id)
local flag=entity.killTime>0
item:SetChildButtonClick(_monsterCmp.root,function()
self:onClickMonster(index)
end)
item:SetChildText(_monsterCmp.name,buildCfg.name)
item:SetChildActive(_monsterCmp.flag,flag)
item:SetChildActive(_monsterCmp.select,self.monsterSelect==index)
end)
end

function UIZhengTaoMoJiangRankWin:refreshMonstersFlag()
for i,v in ipairs(self.monsterDatas)do
local item=self.monsterList:getChildLayoutGroupGridItem(i-1)
local build_id=v.id
local entity=xianjieModel:getMoJiangEntity(self.seasonType,self.stageIndex,build_id)
local flag=entity.killTime>0
item:SetChildActive(_monsterCmp.flag,flag)
end
end

function UIZhengTaoMoJiangRankWin:onClickMonster(index)
if self.monsterSelect~=index then
if self.monsterSelect then
local item=self.monsterList:getChildLayoutGroupGridItem(self.monsterSelect-1)
item:SetChildActive(_monsterCmp.select,false)
end

self.monsterSelect=index

local item=self.monsterList:getChildLayoutGroupGridItem(self.monsterSelect-1)
item:SetChildActive(_monsterCmp.select,true)

self:refresTipsPanel()
self:refreshRankList()
end
end

function UIZhengTaoMoJiangRankWin:refreshRankList()
local temp=self.dataCache[self.monsterSelect]
if temp==nil then
temp={}
self.dataCache[self.monsterSelect]=temp
end
local typeData=_typeDatas[self.typeSelect]
local rankType=typeData.type
local rankData=temp[self.typeSelect]
local monsterData=self.monsterDatas[self.monsterSelect]
local build_id=monsterData.id
if rankData==nil then
xianjieController:reqMoJiangRankDataList(self.seasonType,self.stageIndex,build_id,rankType)
rankData=xianjieModel:getMoJiangRank(self.seasonType,self.stageIndex,build_id,rankType)
temp[self.typeSelect]=rankData
end
self.rankList=rankData and rankData[1]or defaultT
local rankNum=rankData and rankData[2]or 0
local rankScore=rankData and rankData[3]or 0
local panelType=typeData.panel
local rankItem=typeData.rankItem
for i,v in ipairs(self.panel)do
v:setActive(i==panelType)
end
local cfgName=typeData.colName
local isDrop=typeData.isDrop
local stage=seasonModel:getStage(self.seasonType,self.stageIndex)
local stageCfg=stage:getConfig("mojiang",build_id)
self.rankCfg={}
local createList={}
self.ownerRewards=nil
local last=0
local entityData=xianjieModel:getMoJiangEntity(self.seasonType,self.stageIndex,build_id)
local rankInfo=stageCfg[cfgName][entityData.stage]or defaultT
for i,v in ipairs(rankInfo)do
local rewards=v[2]
if isDrop then
rewards=v[2]>0 and cfgHelper.get2(cfg_awardconfig_get,v[2],"showItems")or defaultT
end
if v[3]==1 then
local index=#self.rankCfg+1
table.insert(self.rankCfg,{last+1,v[1],rewards})
table.insert(createList,index)
last=v[1]
else
for j=last+1,v[1]do
local index=#self.rankCfg+1
table.insert(self.rankCfg,{j,j,rewards})
table.insert(createList,index)
last=j
end
end
if self.ownerRewards==nil and rankNum>0 and rankNum<=v[1]then
self.ownerRewards=rewards
end
end

local defaultReward=stageCfg[cfgName][entityData.stage][0]
if self.ownerRewards==nil and defaultReward~=nil and rankScore>0 then
if isDrop then
if defaultReward>0 then
self.ownerRewards=cfgHelper.get2(cfg_awardconfig_get,defaultReward,"showItems")
end
else
self.ownerRewards=defaultReward
end
end
self.stateRewards=typeData.getStateRewawrds(self,build_id,stageCfg,stage.beginTime)
typeData.refreshOwner(self,rankNum,rankScore)
self.scrollView[panelType]:initData(rankItem,createList,#createList)
end

function UIZhengTaoMoJiangRankWin:refreshOwner1(num,score)
local widget=self.ownerWidget[1]
local showRankImage=1<=num and num<=3
widget:SetChildActive(_owner1Cmp.rankImage,showRankImage)
widget:SetChildActive(_owner1Cmp.rankTx,not showRankImage)
if showRankImage then
widget:SetChildCSImageSprite(_owner1Cmp.rankImage,globalABLookup.global,'icon_phbmingci_'..num)
widget:SetChildText(_owner1Cmp.rankImageTx,num)
else
widget:SetChildText(_owner1Cmp.rankTx,num>0 and num or"未上榜")
end
playerController:setHeadIcon(widget,_owner1Cmp.head,{})
widget:SetChildText(_owner1Cmp.playerName,playerModel:getActorName())
widget:SetChildText(_owner1Cmp.serverName,FMT.fmt("[{0}]",loginModel:getMyServerName()))
widget:SetChildText(_owner1Cmp.score,tostring(score))

local rewardCnt=self.ownerRewards~=nil and#self.ownerRewards or 0
widget:SetChildLayoutGroupCreateItems(_owner1Cmp.rewardList,rewardCnt,function(index)
local item=widget:GetChildLayoutGroupGridItem(_owner1Cmp.rewardList,index-1)
local rewardData=self.ownerRewards[index]
local itemId=rewardData[1]
local itemNum=rewardData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local _conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local _prop=itemsComponentHelper.getCommonFillDataSmall(_conf)
item:SetChildPropData(-1,_prop)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
widget:SetChildActive(_owner1Cmp.noReward,self.ownerRewards==nil or#self.ownerRewards<0)
widget:SetChildAnchoredPos(_owner1Cmp.rewardList,0,0)
widget:SetChildScrollRectEnable(_owner1Cmp.rewardView,rewardCnt>=5)
end

function UIZhengTaoMoJiangRankWin:refreshOwner2(num,score)
local widget=self.ownerWidget[2]
local showRankImage=1<=num and num<=3
widget:SetChildActive(_owner2Cmp.rankImage,showRankImage)
widget:SetChildActive(_owner2Cmp.rankTx,not showRankImage)
if showRankImage then
widget:SetChildCSImageSprite(_owner2Cmp.rankImage,globalABLookup.global,'icon_phbmingci_'..num)
widget:SetChildText(_owner2Cmp.rankImageTx,num)
else
widget:SetChildText(_owner2Cmp.rankTx,num>0 and num or"未上榜")
end

local xmData=xianmengModel:getMyXMDetialData()
if xmData then
local image=xianmengModel.splitGuildIcon(xmData.guildicon)
local abname=globalABLookup.xianmengicons
widget:SetChildCSImageSprite(_owner2Cmp.xmIcon,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))
widget:SetChildCSImageSprite(_owner2Cmp.xmBGIcon,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))
widget:SetChildCSImageSprite(_owner2Cmp.xmKuangIcon,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
widget:SetChildText(_owner2Cmp.xmName,xmData.guildname)
widget:SetChildText(_owner2Cmp.serverName,FMT.fmt("[{0}]",loginModel:getServerName(xmData.leaderserverid)))
else
widget:SetChildCSImageIcon(_owner2Cmp.xmIcon,"",false)
widget:SetChildCSImageIcon(_owner2Cmp.xmBGIcon,"",false)
widget:SetChildCSImageIcon(_owner2Cmp.xmKuangIcon,"",false)
widget:SetChildText(_owner2Cmp.xmName,"")
widget:SetChildText(_owner2Cmp.serverName,"")
end

widget:SetChildText(_owner2Cmp.score,tostring(score))

local stateRewardCnt=#self.stateRewards
local showCnt=0
if score>0 then
showCnt=stateRewardCnt+(self.ownerRewards and#self.ownerRewards or 0)
end
local nowTime=timeHelper.getServerShortTime()
if self.cdItems[0]==nil then
self.cdItems[0]={}
else
table.clear(self.cdItems[0])
end
local build_id=self.monsterDatas[self.monsterSelect].id
local entityData=xianjieModel:getMoJiangEntity(self.seasonType,self.stageIndex,build_id)
widget:SetChildLayoutGroupCreateItems(_owner2Cmp.rewardList,showCnt,function(index)
local item=widget:GetChildLayoutGroupGridItem(_owner2Cmp.rewardList,index-1)
local rewardData=index<=stateRewardCnt and self.stateRewards[index]or self.ownerRewards[index-stateRewardCnt]
local itemId=rewardData[1]
local itemNum=rewardData[2]
local state=rewardData[3]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local gray=0
local haveState=state~=nil and type(state)=="table"
if haveState then
if entityData.killTime<=0 and nowTime>=state.endTime then
gray=1
elseif entityData.killTime>0 and entityData.killTime>=state.endTime then
gray=1
end
end
local _conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,gray=gray}
local _prop=itemsComponentHelper.getCommonFillDataSmall(_conf)
item:SetChildPropData(0,_prop)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
if haveState then
local showTx=false
if state.corner~=nil and state.corner~=""then
item:SetChildCSImageSprite(1,_abName,state.corner)
else
item:SetChildCSImageIcon(1,"",true)
end
item:SetChildText(2,state.name)
if nowTime>=state.openTime then
if entityData.killTime<=0 then
if nowTime<state.endTime then
item:SetChildText(4,FMT.cfmt3('a1ec58',timeHelper.format_time_stamp3(state.endTime-nowTime)))
self.cdItems[0][index]={openTime=state.openTime,endTime=state.endTime,state=2}
showTx=true
else
item:SetChildText(4,"无法获得")
showTx=true
end
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
self.cdItems[0][index]={openTime=state.openTime,endTime=state.endTime,state=1}
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
widget:SetChildScrollRectEnable(_owner2Cmp.rewardView,showCnt>=5)
widget:SetChildAnchoredPos(_owner2Cmp.rewardList,0,0)
widget:SetChildActive(_owner2Cmp.noReward,showCnt<=0)
end

function UIZhengTaoMoJiangRankWin:startCDTick()
if self.cdTick==nil then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UIZhengTaoMoJiangRankWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UIZhengTaoMoJiangRankWin:refreshCDItem(index1,index2,item,nowTime,info)
if info.state==1 then
if nowTime>=info.openTime then
self.cdItems[index1][index2].state=2

if nowTime<info.endTime then
item:SetChildText(4,FMT.cfmt3('a1ec58',timeHelper.format_time_stamp3(info.endTime-nowTime)))
else
item:SetChildText(4,"无法获得")

local prop={}
prop[PropIndex(DataPropKey.eWidgetGray,0)]=true
prop[PropIndex(DataPropKey.eWidgetGray,1)]=true
prop[PropIndex(DataPropKey.eWidgetActive,7)]=true
item:SetChildPropData(0,prop)

self.cdItems[index1][index2]=nil
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

self.cdItems[index1][index2]=nil
end
end
end

function UIZhengTaoMoJiangRankWin:updateCDTick()
local nowTime=timeHelper.getServerShortTime()
for i,v in pairs(self.cdItems)do
if next(v)then
if i>0 then
local widget=self.scrollView[2]:getItemWidget(i)
if widget then
for j,w in pairs(v)do
local item=widget:GetChildLayoutGroupGridItem(_item2Cmp.rewardList,j-1)
self:refreshCDItem(i,j,item,nowTime,w)
end
end
else
local widget=self.ownerWidget[2]
for j,w in pairs(v)do
local item=widget:GetChildLayoutGroupGridItem(_owner2Cmp.rewardList,j-1)
self:refreshCDItem(i,j,item,nowTime,w)
end
end
end
end
end

function UIZhengTaoMoJiangRankWin:onClickPlayer(playerData)
otherPlayerController:openOtherPlayerInfoWin(playerData.actorid,nil,nil,{serverid=playerData.serverid,isXianJie=true})
end

function UIZhengTaoMoJiangRankWin:onClickXM(xmData)
if mathHelper.validInt64(xmData.guildid)and xmData.guildname~=nil and xmData.guildicon>0 then
local _xmData=xianjieModel:getXianMengData(xmData.guildid)
if _xmData then
local isOther=xianjienSceneIndexType:isOhterXianYu(_xmData.ownersceneidx)
if not isOther then
local wincfg=UIManager.get_window_config(self.__name)
xianmengController:openXMDetailInfoWin(xmData.guildid,wincfg.canvas+1)
else
UIManager.error('不同仙域的仙盟，无法探知其信息')
end
return
end
end
UIManager.info("不可知的神秘仙盟")
end

function UIZhengTaoMoJiangRankWin.on_39_12(args)
local seasonType=args[1]
local stageIndex=args[2]
local build_id=args[3]
if _this.seasonType==seasonType and _this.stageIndex==stageIndex then
local _build_id=_this.monsterDatas[_this.monsterSelect].id
if _build_id==build_id then
local typeData=_typeDatas[_this.typeSelect]
local rankType=typeData.type
if rankType==1 and _this.dataCache[_this.monsterSelect]then
_this.dataCache[_this.monsterSelect][_this.typeSelect]=xianjieModel:getMoJiangRank(seasonType,stageIndex,build_id,rankType)
_this:refreshRankList()
end
end
end
end

function UIZhengTaoMoJiangRankWin.on_39_13(args)
local seasonType=args[1]
local stageIndex=args[2]
local build_id=args[3]
if _this.seasonType==seasonType and _this.stageIndex==stageIndex then
local _build_id=_this.monsterDatas[_this.monsterSelect].id
if _build_id==build_id then
local typeData=_typeDatas[_this.typeSelect]
local rankType=typeData.type
if rankType==2 and _this.dataCache[_this.monsterSelect]then
_this.dataCache[_this.monsterSelect][_this.typeSelect]=xianjieModel:getMoJiangRank(seasonType,stageIndex,build_id,rankType)
_this:refreshRankList()
end
end
end
end

function UIZhengTaoMoJiangRankWin.onSeasonChange()
local stage=seasonModel:getStage(_this.seasonType,_this.stageIndex)
if not stage then
_this:onCloseBtn()
else
_this:refreshMonstersFlag()
end
end

function UIZhengTaoMoJiangRankWin.onSeasonStageChange(seasonType,stageIndex)
if _this.seasonType==seasonType and _this.stageIndex==stageIndex then
_this:refreshMonstersFlag()
end
end