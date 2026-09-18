







def_class("UISubAct_chanllengeBossWin",UIWindowBase)









function UISubAct_chanllengeBossWin:bindComponents()

self.centerRoot=UIObject.get(self,0)
self.Content=UIObject.get(self,1)
self.costRoot=UIObject.get(self,2)
self.dropButton=UIButton.get(self,3)
self.freeRoot=UIObject.get(self,4)
self.freeText=UIText.get(self,5)
self.helpButton=UIButton.get(self,6)
self.itemPanel=UIObject.get(self,7)
self.jxReddot=UIObject.get(self,8)
self.left=UIObject.get(self,9)
self.leftBtn=UIButton.get(self,10)
self.leftReddot=UIObject.get(self,11)
self.level=UIText.get(self,12)
self.mask=UIObject.get(self,13)
self.npcModel=UIObject.get(self,14)
self.packScrollerView=UIObject.get(self,15)
self.right=UIObject.get(self,16)
self.rightBtn=UIButton.get(self,17)
self.rightReddot=UIObject.get(self,18)
self.root=UIObject.get(self,19)
self.ruleText=UIText.get(self,20)
self.ruleTextValue=UIText.get(self,21)
self.selectButton=UIButton.get(self,22)
self.skillList=UIObject.get(self,23)
self.skipBtn=UIButton.get(self,24)
self.skipSelectImg=UIObject.get(self,25)
self.slList=UIObject.get(self,26)
self.spineObject=UIImage.get(self,27)
self.time=UIText.get(self,28)
self.weakList=UIObject.get(self,29)
self.weakText=UIText.get(self,30)
self.weakTitle=UIText.get(self,31)
self.zyCost=UIText.get(self,32)
self.zyicon=UIButton.get(self,33)

self.dropButton:setButtonClick(function()self:onDropButton()end)

self.helpButton:setButtonClick(function()self:onHelpButton()end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.selectButton:setButtonClick(function()self:onSelectButton()end)

self.skipBtn:setButtonClick(function()self:onSkipBtn()end)

self.zyicon:setButtonClick(function()self:onZyicon()end)



end


function UISubAct_chanllengeBossWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.centerRoot);self.centerRoot=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.costRoot);self.costRoot=nil;
_UIObject_release(self.dropButton);self.dropButton=nil;
_UIObject_release(self.freeRoot);self.freeRoot=nil;
_UIObject_release(self.freeText);self.freeText=nil;
_UIObject_release(self.helpButton);self.helpButton=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
_UIObject_release(self.jxReddot);self.jxReddot=nil;
_UIObject_release(self.left);self.left=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.leftReddot);self.leftReddot=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.packScrollerView);self.packScrollerView=nil;
_UIObject_release(self.right);self.right=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.rightReddot);self.rightReddot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleText);self.ruleText=nil;
_UIObject_release(self.ruleTextValue);self.ruleTextValue=nil;
_UIObject_release(self.selectButton);self.selectButton=nil;
_UIObject_release(self.skillList);self.skillList=nil;
_UIObject_release(self.skipBtn);self.skipBtn=nil;
_UIObject_release(self.skipSelectImg);self.skipSelectImg=nil;
_UIObject_release(self.slList);self.slList=nil;
_UIObject_release(self.spineObject);self.spineObject=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.weakList);self.weakList=nil;
_UIObject_release(self.weakText);self.weakText=nil;
_UIObject_release(self.weakTitle);self.weakTitle=nil;
_UIObject_release(self.zyCost);self.zyCost=nil;
_UIObject_release(self.zyicon);self.zyicon=nil;
end



















local _this
local boss_index=
{
root=0,
npcmodel=1,
}

local abname='ui/icons/monsterhead/sharedtextures/'


function UISubAct_chanllengeBossWin:onLoaded(...)
self:bindComponents()
_this=self

self.pageCount=0
self.pageLength=1
self.isDrag=false
self.targetHor=0
self.smooting=10

self.pageIndex=0
self.selectIdx=1

self.skipFlag={false,false,false,false}

self.winlua:SetChildUIDragEvent(self.packScrollerView:getID(),0,self.beginDragCallback,self.endDragCallback,nil)
self.updateTimer=self:setTimer(0.02,0,self.onScrollChanged)

notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_change)
end


function UISubAct_chanllengeBossWin:__delete()
self:unbindComponents()
UIManager:closeWindow("UITopMoneyWin2")
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_change)
end




function UISubAct_chanllengeBossWin:onShow(argtable,afterOnloaded)
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
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
end

if argtable.extraParams then
if argtable.extraParams.isRefresh then
self.isRefresh=argtable.extraParams.isRefresh
end
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
self.sublist=activitiesModel:getActSubList_open_doing(self.activityId)

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end

self.beginTime=self.activityData.start_time
self.endTime=self.activityData.end_time

self:refreshBgModel()
self:setRemainingTimeTimer()


self:freshTopScrollerView()
self:refreshScrollerView()
self:initFirstShowPage()
self:checkArrowBtn()
self:refreshRuleAndWeak()

self.spineObject:setChildCanvasGroupAlpha(0)
self.spineObject:setChildCanvasGroupDOFade(1,0.2,nil)
self.centerRoot:setChildCanvasGroupDOFade(1,0.5,nil)

self:showWindow("UITopMoneyWin2",{moneys={{self.itemId}},offsetX=530,offsetY=-237})
end


function UISubAct_chanllengeBossWin:onHide()
self:clearTimer()
UIManager:closeWindow("UITopMoneyWin2")
end


function UISubAct_chanllengeBossWin:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.endTime and self.endTime-nowTime or 0
if lerp>0 then

self.time:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp11(lerp,true)))
else
self.time:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()
end
end
func()
self.timer=self:setTimer(1,0,func)
end


function UISubAct_chanllengeBossWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UISubAct_chanllengeBossWin:refreshBgModel()
local bgModelId=self.config.bgModelId
if bgModelId then
local animId=eAnimationID.stand
self.spineObject:setChildUIModelShowTarget(bgModelId,1,{},animId,false,false,0)
self.spineObject:setActive(true)
else
self.spineObject:setActive(false)
self.spineObject:setChildUIModelRemoveTarget()
end
end

function UISubAct_chanllengeBossWin:refreshweakIconGrid()
local iconList
local iconCfg=self.config.fzicon

if iconCfg[self.selectIdx]then
iconList=iconCfg[self.selectIdx]
elseif iconCfg[1]then
iconList=iconCfg[1]
end

if iconList then
local cnt=#iconList
_this.weakList:setActive(true)
_this.weakList:setChildLayoutGroupCreateItems(cnt,function(index)
local iconName=iconList[index]
local abname="ui/sharedtextures/uiglobalspriteatlas_1.ab"
local item=_this.weakList:getChildLayoutGroupGridItem(index-1)
item:SetChildCSImageSprite(-1,abname,iconName)
end)
else
_this.weakList:setActive(false)
end
end

function UISubAct_chanllengeBossWin:refreshSkillGrid()
local monsterid
local monsterList=_this.config.monster_groub_id
local skillList=_this.config.monster_skill_id

if monsterList then
monsterid=monsterList[self.selectIdx]
if monsterid and skillList[monsterid]then
_this.monSkillList=skillList[monsterid]
end
end

if _this.monSkillList then
self.skillCnt=#_this.monSkillList
_this.skillList:setActive(true)
_this.skillList:setChildLayoutGroupCreateItems(self.skillCnt,function(index)
local item=_this.skillList:getChildLayoutGroupGridItem(index-1)
local skillType
local skillIndex
local iconName=""
local skillParam=_this.monSkillList[index]
if skillParam then
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillParam)
iconName=iconHelper.getSkillIcon(skillCfg.icon)
else
loggerUtil.logWarnFMT("试炼怪物无效怪物特性:{0},{1},{2}",_this.monster,skillType,skillIndex)
end
item:SetChildCSImageIcon(-1,iconName,false)
item:SetChildButtonClick(-1,function()
_this:onClickSkill(index)
end)
end)
else
_this.skillList:setActive(false)
end
end


function UISubAct_chanllengeBossWin:onClickSkill(index)
local skillList=_this.monSkillList or{}
local x=-146+78*(index-(_this.skillCnt/2+0.5))
local name,icon,desc,bottomLeft
local skillParam=skillList[index]

if skillParam then
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillParam)
name=skillCfg.name
icon=iconHelper.getSkillIcon(skillCfg.icon)
else
loggerUtil.logWarnFMT("镇妖试炼怪物无效怪物特性:{0},{1},{2}",_this.monster)
end
desc=skillModel:getSkillDesc(skillParam,1)
local halfVector=Vector2.right*0.5
local args={
name=name,
icon=icon,
desc=desc,
bottomLeft=nil,
rootPoint={
anchorsMin=halfVector,
anchorsMax=halfVector,
pivot=halfVector,
anchoredPosition=Vector2.New(x,245),
}
}
UISubAct_chanllengeBossWin:showWindow('UISimpleTeXingTipsWin',args)
end


function UISubAct_chanllengeBossWin:initFirstShowPage()
local firstShowIndex=1
local firstCanGetIndex=activitiesHandle_zhenyaoshilian:getCurMemoryBossIdx()or 1

firstShowIndex=firstCanGetIndex and firstCanGetIndex or 1
self.pageIndex=firstShowIndex-1
self.targetHor=self.pageLength*self.pageIndex
self.selectIdx=firstCanGetIndex
self.packScrollerView:setChildScrollViewSelectItem(self.pageIndex,false,false,false)

self:refreshBossName()
end


function UISubAct_chanllengeBossWin:refreshScrollerView()
_this.showList=self.config.monster_groub_id
_this.pageCount=#_this.showList
_this.pageLength=1/((_this.pageCount-1)==1 and 1 or(_this.pageCount-1))
_this.packScrollerView:setChildScrollViewCreateGrids(_this.pageCount,_this.pageCount)
local grids=_this.packScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local mosterid=_this.showList[i]
local modelParams=comHelper.getMonsterGroupModelParams(mosterid)
local scaleParam=isometricMapSystem:getModelScales2Pram(modelParams.body,22)
item:SetChildUIModelShowTarget(boss_index.npcmodel,modelParams.body,scaleParam[1],modelParams.componets,eAnimationID.stand,false,false,0,nil)
item:SetChildUIModelShowTargetOffset(boss_index.npcmodel,scaleParam[2],scaleParam[3])
end
end
end


function UISubAct_chanllengeBossWin:freshTopScrollerView()
local cfg_List=_this.config.monster_groub_id
local bosstopimage=_this.config.bosstopimage
if cfg_List and#cfg_List>0 then
_this.slList:setChildScrollViewCreateGrids(#cfg_List,#cfg_List)
local grids=_this.slList:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=cfg_List[i]


if bosstopimage[i]then
local aabname=string.format("%s%s.ab",abname,bosstopimage[i])
item:SetChildCSImageSprite(7,aabname,bosstopimage[i])
else

end

item:SetChildActive(3,false)
item:SetChildActive(4,false)

item:SetChildActive(8,_this.selectIdx==i)

item:SetChildButtonClick(6,function()
if _this==nil then return end
self:onTopBtn(i,data)
end)
end
end
end


function UISubAct_chanllengeBossWin:freshTopSingleItem()
local grids=_this.slList:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local reddot=activitiesHandle_zhenyaoshilian:getMemoryBossReddotIdx(i)
item:SetChildActive(4,reddot)
item:SetChildActive(8,false)
item:SetChildActive(8,_this.selectIdx==i)
end
end

function UISubAct_chanllengeBossWin:refreshBossName()
local name
local monsterid
local monsterCfg

local monsterGroupCfg=self.config.monster_groub_id
if monsterGroupCfg[self.selectIdx]then
monsterid=monsterGroupCfg[self.selectIdx]
monsterCfg=cfgHelper.get(cfg_monstergroup_get,monsterid)
end

if monsterCfg then
name=monsterCfg.name
self.curName=name
self.level:setActive(true)
self.level:setText(name)
else
self.level:setActive(false)
end

local reward=self.config.normal_rw_id
local dropId=reward[self.selectIdx]
local dropCfg=cfgHelper.get(cfg_awardconfig_get,dropId)
local itemList=dropCfg.showItems

if itemList then
self:showItemPanel(itemList)
end

activitiesHandle_zhenyaoshilian:setMemoryBossReddotIdx(self.selectIdx,false)

self:refreshSkipBtn()
self:refreshCost()
self:refreshSkillGrid()
self:refreshweakIconGrid()
self:freshTopSingleItem()
self:refreshRuleAndWeak()
end


function UISubAct_chanllengeBossWin:checkArrowBtn()

self.left:setActive(self.pageIndex>0)

self.right:setActive(self.pageIndex<self.pageCount-1)
end


function UISubAct_chanllengeBossWin:onTopBtn(pageIndex,_data)
if self.selectIdx and self.selectIdx==pageIndex then
return
end
if pageIndex>=0 and pageIndex<=self.pageCount then
self.pageIndex=pageIndex-1
self.targetHor=self.pageLength*self.pageIndex
self.selectIdx=pageIndex
end

self:checkArrowBtn()
self:refreshBossName()
end


function UISubAct_chanllengeBossWin.beginDragCallback()
_this.isDrag=true
end

function UISubAct_chanllengeBossWin.endDragCallback()
_this.isDrag=false
local posX=_this.winlua:GetChildScrollRectNormalizedPosition(_this.packScrollerView:getID(),true)
local index=0
local offset=Mathf.Abs(-posX)
for i=1,_this.pageCount do
local temp=Mathf.Abs(_this.pageLength*i-posX)
if(temp<offset)then
index=i
offset=temp
end
end
_this.pageIndex=index

_this.targetHor=_this.pageLength*_this.pageIndex
_this:checkArrowBtn()

if _this.selectIdx==_this.pageIndex+1 then
return
else
_this.selectIdx=_this.pageIndex+1
_this:refreshBossName()
end
end

function UISubAct_chanllengeBossWin.onScrollChanged()

if not _this.isDrag then
local np=_this.winlua:GetChildScrollRectNormalizedPosition(_this.packScrollerView:getID(),true)
_this.winlua:SetChildScrollRectNormalizedPosition(_this.packScrollerView:getID(),true,Mathf.Lerp(np,_this.targetHor,Time.deltaTime*_this.smooting))
end
end

function UISubAct_chanllengeBossWin:refreshCost()
local text
local zyItem
local costCfg=self.config.cost
local freeCnt=self.config.free_cnt

if costCfg[self.selectIdx]then
zyItem=costCfg[self.selectIdx]
else
zyItem=costCfg[1]
end

local need=zyItem[2]
local itemid=zyItem[1]
local has=itemsModel.getCount(itemid)
local isfree=self.activityData.challenge_cnt<freeCnt
local freeCount=freeCnt-self.activityData.challenge_cnt
local enough=has>=need
local textStr=enough and FMT.fmt('{0}',need)or FMT.cfmt(FONT_COLOR.eRedColor,'{0}',need)
self.zyicon:setIcon(iconHelper.getIconName(zyItem[1]),false)
self.zyCost:setText(text or textStr)

if isfree then
self.freeText:setText(string.format("每日免费次数：%s",freeCount))
end

self.freeRoot:setActive(isfree)
self.costRoot:setActive(not isfree)

self.itemId=itemid
end

function UISubAct_chanllengeBossWin:showItemPanel(args)
self.itemPanel:setActive(false)

local itemList=args
if itemList then
local count=#itemList
self.itemPanel:setChildScrollViewCreateGrids(count,count)
local grids=self.itemPanel:getChildScrollViewItemWidgets()
local count=grids.Count
self.itemPanel:setActive(true)

for i=0,count-1 do
local item=grids[i]
local reward=itemList[i+1]

if reward then
local rewardNum=reward[2]
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1
local probability=rewardNum==-1

local gray=0
local conf={itemid=reward[1],showCountBG=showCountBG,itemcount=countStr,showStage=probability,showname=false,itemIndex=i,gray=gray}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(2,self.onClickItem)
item:SetChildPropData(2,prop)
if not self.isRefresh then
item:SetChildCanvasGroupDOFade(2,0,0)
end
else
item:SetChildActive(1,false)
end
end
self:refreshEffect()
end
end

function UISubAct_chanllengeBossWin:refreshEffect()
if self.isRefresh then
self.isRefresh=false
return
end

local grids=self.itemPanel:getChildScrollViewItemWidgets()

grids[0]:SetChildShowEffect(3,10078,true)
grids[0]:SetChildCanvasGroupDOFade(2,1,0.2)
self:delayDo(0.2,function()
grids[1]:SetChildShowEffect(3,10078,true)
grids[1]:SetChildCanvasGroupDOFade(2,1,0.2)
end)
self:delayDo(0.4,function()
grids[2]:SetChildShowEffect(3,10078,true)
grids[2]:SetChildCanvasGroupDOFade(2,1,0.2)
end)
self:delayDo(0.6,function()
grids[3]:SetChildShowEffect(3,10078,true)
grids[3]:SetChildCanvasGroupDOFade(2,1,0.2)
end)
end

function UISubAct_chanllengeBossWin.onClickItem(itemid,index,itemguid,attach)
itemsComponentHelper.onItemClickEx(itemid,index,itemguid,attach)
end

function UISubAct_chanllengeBossWin:refreshRuleAndWeak()
local text1
local text2
local cfg=self.config.fz_conf
local temp=cfg[self.selectIdx]
if temp then
local id1=temp[1][1]
local lv1=temp[1][2]
local id2=temp[2][1]
local lv2=temp[2][2]

self.ruleId=id1
self.ruleLv=lv1

local config=cfgHelper.get1(cfg_sslawruleconfig_get,id1)
text1=config.desc
local value=string.format("%d%%",unpack(config.descparm[lv1]))
text2=self.config.fzdesc[self.selectIdx]or""

self.weakText:setText(text2)
self.ruleText:setText(text1)
self.ruleTextValue:setText(value)
end
end


function UISubAct_chanllengeBossWin.on_money_changed(moneyType,lastVal,val)
local costCfg=_this.config.cost[1]
local costId=costCfg[1]
local subType=SUB_ACTIVITY_TYPE.eZhenYaoShiLian

if costId and costId==moneyType then
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
_this:refreshCost()
end


function UISubAct_chanllengeBossWin.on_item_change(changeType,itemguid,itemid,lastcount,itemcount)
local costCfg=_this.config.cost[1]
local costId=costCfg[1]
if costId and costId==itemid then
_this:refreshCost()
end
end

function UISubAct_chanllengeBossWin:onNewDay()

_this.activityData=activitiesModel:getSubActInfo(_this.activityId,_this.subType,_this.subId)
_this:refreshCost()
end

function UISubAct_chanllengeBossWin:refreshSkipBtn()
self.skipSelectImg:setActive(self.skipFlag[self.selectIdx])
end




function UISubAct_chanllengeBossWin:onDropButton()
local dropId
local rewardList=self.config.normal_rw_id
if rewardList[self.selectIdx]then
dropId=rewardList[self.selectIdx]
else
dropId=rewardList[1]
end

local dropCfg=cfgHelper.get(cfg_awardconfig_get,dropId)
local itemList=dropCfg.detailItems

if itemList then
UIManager:showWindow("UISubAct_detailRewardShowWin",{rewardList=itemList})
else
UIManage.error("未读取到详细奖励配置！！！")
end
end

function UISubAct_chanllengeBossWin:checkIsCanCheck()
local maxBox

if self.activityData.boxList then
maxBox=self.activityData.boxList[self.selectIdx]
end

if not maxBox or maxBox==0 then
return
end

return maxBox
end


function UISubAct_chanllengeBossWin:onSelectButton()
local cost
local costCfg=self.config.cost
local freeCnt=self.config.free_cnt
local freeCount=freeCnt-self.activityData.challenge_cnt

if costCfg[self.selectIdx]then
cost=costCfg[self.selectIdx]
else
cost=costCfg[1]
end

local itemId=cost[1]
local useCount=cost[2]
local haveCount=itemsModel.getCount(itemId)

if self.activityData.challenge_cnt<freeCnt then
useCount=0
end

local monsterid
local monsterCfg
local bossidx=self.selectIdx
local monsterGroupCfg=self.config.monster_groub_id
if monsterGroupCfg[self.selectIdx]then
monsterid=monsterGroupCfg[self.selectIdx]
monsterCfg=cfgHelper.get(cfg_monstergroup_get,monsterid)
end

if haveCount<useCount then
gainControl:showGainWin(itemId)
return
end

if self.skipFlag[self.selectIdx]then
local max=itemsModel.getCount(self.itemId)
if freeCount>0 then
max=max+freeCount
end

if max>10 then max=10 end

local maxBox=self:checkIsCanCheck()
if not maxBox or maxBox==0 then
local str=string.format("请先完成1次对首领%s的挑战",self.curName)
UIManager.error(str)
return
end

local costColor=FONT_COLOR_VAL[FONT_COLOR.eGreenColor]
local refresh=function(num)
local freeCnt=self.config.free_cnt
local freeCount=freeCnt-self.activityData.challenge_cnt

local costIconName=iconHelper.getIconName(self.itemId)
local costIconStr=chatEmotHelper.getIconEmotMesg(costIconName,40)

local costStr=nil
if freeCount>0 and num<=freeCount then
return FMT.fmt("是否消耗<color={1}>{0}次</color>免费次数进行快捷挑战",num,costColor)
elseif freeCount>0 and num>freeCount then
costStr=FMT.fmt("<color={1}>{0}次</color>免费次数",freeCount,costColor)
num=num-freeCount
end

local splite=costStr and"和"or""
local costIconName=iconHelper.getIconName(self.itemId)
local costIconStr=chatEmotHelper.getIconEmotMesg(costIconName,40)
costStr=FMT.fmt('{0}{1}{2}<color={4}>{3}</color>',costStr or"",splite,costIconStr,num,costColor)
local contentStr=FMT.fmt("是否消耗{0}进行快捷挑战",costStr)
return contentStr
end

local show_data={
type='UIDialougeBuyCount',
title='提示',
refreshcallback=refresh,
max=max,
tips=FMT.fmt("（单次挑战历史最高纪录：<color={1}>{0}个</color>宝箱）",maxBox,costColor),
oktext='确定',
canceltext='取消',
okcallback=function(num)
local jstr=jsonHelper.encode({self.selectIdx,num})
activitiesHandle_zhenyaoshilian:setChallenge_cnt(self.activityId,self.subId,num)
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.activityId,self.subType,self.subId,jstr)
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
local actid=self.activityId
local subType=self.subType
local subid=self.subId
local id=self.ruleId
local lv=self.ruleLv
fightController.showPrepareWin(eFightPreSelectType.zhenyaoshilian,
{
enterTxt='镇妖试炼',
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
monsterList=monsterCfg.monList,
groupId=monsterid,
showZhenFa=false,
enterCallBack=function(guidList,zfId)
fightLaunchController:sendFight(eBattleLaunch.zhenyaoshilian,guidList,monsterCfg.mapId or 0,zfId,{actid,subType,subid,bossidx})
end,
cancelCallBack=function()
activitiesController:jump(actid,subType,subid,{isRefresh=true})
end,
},
function()
activitiesHandle_zhenyaoshilian:setMemoryBossIdx(bossidx)
UIManager:showWindow('UISubAct_zyslFightExtraWin',{actid,subType,subid,bossidx,id,lv})
end)
end

end


function UISubAct_chanllengeBossWin:onHelpButton()
local name=self.config.infoDesc
if name then
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name=name})
end
end


function UISubAct_chanllengeBossWin:onZyicon()

tipsManager.showTips({itemid=self.itemId})
end


function UISubAct_chanllengeBossWin:onLeftBtn()
if self.pageIndex-1>=0 then
self.pageIndex=self.pageIndex-1
self.targetHor=self.pageLength*self.pageIndex
self.selectIdx=self.pageIndex+1
end

self:checkArrowBtn()
self:refreshBossName()
end


function UISubAct_chanllengeBossWin:onRightBtn()
if self.pageIndex+1<self.pageCount then
self.pageIndex=self.pageIndex+1
self.targetHor=self.pageLength*self.pageIndex
self.selectIdx=self.pageIndex+1
end

self:checkArrowBtn()
self:refreshBossName()
end

function UISubAct_chanllengeBossWin:onSkipBtn()

local max=self:checkIsCanCheck()
if not max or max==0 then
self.skipFlag[self.selectIdx]=false
local str=string.format("请先完成1次对首领%s的挑战",self.curName)
UIManager.error(str)
elseif self.skipFlag[self.selectIdx]then
self.skipFlag[self.selectIdx]=false
elseif not self.skipFlag[self.selectIdx]then
local showdata=
{
type='UIDialouge',
title='提示',
content='勾选后进行挑战时会根据单次挑战历史最高获取的宝箱数量来进行快速结算，是否确认？',
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function()
self.skipFlag[self.selectIdx]=true
self:refreshSkipBtn()
end,
showclosebtn=true,
}
local dialog=UIDialogManager.newDialog(showdata)
dialog:show()
end
self:refreshSkipBtn()
end
