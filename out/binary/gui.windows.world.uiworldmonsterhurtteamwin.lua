







def_class("UIWorldMonsterHurtTeamWin",UIWindowBase)









function UIWorldMonsterHurtTeamWin:bindComponents()

self.stopingRoot=UIObject.get(self,0)
self.teamRoot2=UIObject.get(self,1)
self.rewardRoot=UIObject.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.finishRoot=UIObject.get(self,4)
self.huntingRoot=UIObject.get(self,5)
self.perpareRoot=UIObject.get(self,6)
self.teamRoot1=UIObject.get(self,7)
self.completeBtn=UIButton.get(self,8)
self.finalPorgress=UIText.get(self,9)
self.strengthenTips=UIText.get(self,10)
self.strengthenScroll=UIObject.get(self,11)
self.finalTxBg=UIObject.get(self,12)
self.finalRewardView=UIObject.get(self,13)
self.readyBtn=UIButton.get(self,14)
self.noneSelect=UIObject.get(self,15)
self.perpareDuration=UIText.get(self,16)
self.teamList2=UIObject.get(self,17)
self.teamList1=UIObject.get(self,18)
self.stopBtn=UIButton.get(self,19)
self.progressTx=UIText.get(self,20)
self.leastTime=UIText.get(self,21)
self.finalAvangeLv=UIText.get(self,22)
self.finalTargetLv=UIText.get(self,23)
self.victoryImg=UIObject.get(self,24)
self.defeatedImg=UIObject.get(self,25)
self.stopTime=UIText.get(self,26)
self.noneReward=UIText.get(self,27)
self.finalRewards=UIObject.get(self,28)
self.strengthenCreator=UIObject.get(self,29)
self.averageIcon=UIButton.get(self,30)
self.averageTx=UIText.get(self,31)
self.titleTx=UIText.get(self,32)
self.helpBtn=UIButton.get(self,33)
self.recommendTx=UIText.get(self,34)
self.costTips=UIText.get(self,35)
self.perpareCostNum=UIText.get(self,36)
self.costIcon=UIObject.get(self,37)
self.rewardDetailBtn=UIButton.get(self,38)
self.maxNum=UIText.get(self,39)
self.perpareRewards=UIObject.get(self,40)
self.huntRewards=UIObject.get(self,41)
self.uiRoot=UIObject.get(self,42)
self.root=UIObject.get(self,43)
self.backModel=UIObject.get(self,44)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.completeBtn:setButtonClick(function()self:onCompleteBtn()end)

self.readyBtn:setButtonClick(function()self:onReadyBtn()end)

self.stopBtn:setButtonClick(function()self:onStopBtn()end)

self.averageIcon:setButtonClick(function()self:onAverageIcon()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.rewardDetailBtn:setButtonClick(function()self:onRewardDetailBtn()end)



end


function UIWorldMonsterHurtTeamWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.stopingRoot);self.stopingRoot=nil;
_UIObject_release(self.teamRoot2);self.teamRoot2=nil;
_UIObject_release(self.rewardRoot);self.rewardRoot=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.finishRoot);self.finishRoot=nil;
_UIObject_release(self.huntingRoot);self.huntingRoot=nil;
_UIObject_release(self.perpareRoot);self.perpareRoot=nil;
_UIObject_release(self.teamRoot1);self.teamRoot1=nil;
_UIObject_release(self.completeBtn);self.completeBtn=nil;
_UIObject_release(self.finalPorgress);self.finalPorgress=nil;
_UIObject_release(self.strengthenTips);self.strengthenTips=nil;
_UIObject_release(self.strengthenScroll);self.strengthenScroll=nil;
_UIObject_release(self.finalTxBg);self.finalTxBg=nil;
_UIObject_release(self.finalRewardView);self.finalRewardView=nil;
_UIObject_release(self.readyBtn);self.readyBtn=nil;
_UIObject_release(self.noneSelect);self.noneSelect=nil;
_UIObject_release(self.perpareDuration);self.perpareDuration=nil;
_UIObject_release(self.teamList2);self.teamList2=nil;
_UIObject_release(self.teamList1);self.teamList1=nil;
_UIObject_release(self.stopBtn);self.stopBtn=nil;
_UIObject_release(self.progressTx);self.progressTx=nil;
_UIObject_release(self.leastTime);self.leastTime=nil;
_UIObject_release(self.finalAvangeLv);self.finalAvangeLv=nil;
_UIObject_release(self.finalTargetLv);self.finalTargetLv=nil;
_UIObject_release(self.victoryImg);self.victoryImg=nil;
_UIObject_release(self.defeatedImg);self.defeatedImg=nil;
_UIObject_release(self.stopTime);self.stopTime=nil;
_UIObject_release(self.noneReward);self.noneReward=nil;
_UIObject_release(self.finalRewards);self.finalRewards=nil;
_UIObject_release(self.strengthenCreator);self.strengthenCreator=nil;
_UIObject_release(self.averageIcon);self.averageIcon=nil;
_UIObject_release(self.averageTx);self.averageTx=nil;
_UIObject_release(self.titleTx);self.titleTx=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.recommendTx);self.recommendTx=nil;
_UIObject_release(self.costTips);self.costTips=nil;
_UIObject_release(self.perpareCostNum);self.perpareCostNum=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.rewardDetailBtn);self.rewardDetailBtn=nil;
_UIObject_release(self.maxNum);self.maxNum=nil;
_UIObject_release(self.perpareRewards);self.perpareRewards=nil;
_UIObject_release(self.huntRewards);self.huntRewards=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.backModel);self.backModel=nil;
end















local _this=nil
local _detailShow=8
local _teamItemCmp={
background=0,
item=1,
}
local _rewardItemCmp={
item=0,
gailv=1,
}
local _winState={
prepare=1,
hunting=2,
stoping=3,
finish=4,
}
local _roots={
['finishRoot']={
bit=0x8,
showView='showFinishView',
},
['rewardRoot']={
bit=0x6,
showView='showRewardView',
},
['huntingRoot']={
bit=0x2,
showView='showHuntingView',
hideView='hideHuntingView',
},
['perpareRoot']={
bit=0x1,
showView='showPerpareView',
},
['stopingRoot']={
bit=0x4,
showView='showStopingView',
hideView='hideStopingView',
},
['teamRoot1']={
bit=0x1,
showView='showTeamView1',
},
['teamRoot2']={
bit=0x6,
showView='showTeamView2',
},
}



function UIWorldMonsterHurtTeamWin:onLoaded(...)
self:bindComponents()
_this=self
self.state=0
self:addNotify(notifyConfig.on_money_changed,self.onMoneyChanged)
self:addNotify(notifyConfig.onHuntMonsterTeamSelectMonsterChange,self.onHuntMonsterTeamSelectMonsterChange)
self:addNotify(notifyConfig.onHuntMonsterTeamSelectDiscipleChange,self.onHuntMonsterTeamSelectDiscipleChange)
self:addNotify(notifyConfig.onHuntMonsterTeamSelectWorldChange,self.onHuntMonsterTeamSelectWorldChange)
self:addNotify(notifyConfig.onHuntMonsterTeamStartTeam,self.onHuntMonsterTeamStartTeam)
self:addNotify(notifyConfig.onHuntMonsterTeamEndTeam,self.onHuntMonsterTeamEndTeam)
self:addNotify(notifyConfig.onHuntMonsterTeamFight,self.onHuntMonsterTeamFight)
self:addNotify(notifyConfig.onHuntMonsterTeamStop,self.onHuntMonsterTeamStop)
end


function UIWorldMonsterHurtTeamWin:__delete()
self:stopAllCDTimer()
self:unbindComponents()
_this=nil
if not self.jumpClearSelect then
huntMonsterTeamController:clearAllSelect()
end
end




function UIWorldMonsterHurtTeamWin:onShow(argtable,afterOnloaded)
self.winlua:SwitchChildParent(self.root:getID(),worldController:isInWorld()and-1 or self.uiRoot:getID(),false)
self.winlua:SwitchChildParent(self.backModel:getID(),worldController:isInWorld()and-1 or self.uiRoot:getID(),false)
self.parentWin=argtable.parentWin
self.world=huntMonsterTeamModel:getSelectWorld()
self.titleTx:setText(FMT.fmt("猎妖队-{0}",cfgHelper.get2(cfg_worldconfig_get,self.world,"name")))
self.maxSelect=huntMonsterTeamModel:getWorldMaxNum(self.world)

if not afterOnloaded then
self:resetView()
else
self.root:setChildCanvasGroupAlpha(0)
self.backModel:setChildUIModelShowTarget(4855,1,{},eAnimationID.enter,false,false,0,function()
self.root:setChildCanvasGroupDOFade(1,0.5)
end)
end

self:updateData()
self:refreshView()
end


function UIWorldMonsterHurtTeamWin:onHide()

end


function UIWorldMonsterHurtTeamWin:onAverageIcon()
UIManager.info("境界过低，建议提高弟子境界！")
end

function UIWorldMonsterHurtTeamWin:doCloseAnim()

self.isClose=true
self.root:setChildCanvasGroupDOFade(0,0.5)
self.backModel:setChildModelAnimationState(eAnimationID.ui_close,1,function()
self.parentWin:closeWindow("UIWorldMonsterHurtTeamWin")

end)
end

function UIWorldMonsterHurtTeamWin:onCloseBtn()
huntMonsterTeamController:onToggleShowWin()
end


function UIWorldMonsterHurtTeamWin:onHelpBtn()
local d={}
d.mode=3
d.title="规则介绍"
d.name='huntMonsterTeam_rule_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end


function UIWorldMonsterHurtTeamWin:onReadyBtn()
local monsterCnt=huntMonsterTeamModel:getSelectMonsterCount()
if monsterCnt<=0 then
UIManager.info("尚未选择妖怪")
return
elseif monsterCnt>self.maxSelect then
UIManager.info("选择妖怪数量超过上限")
return
end
if not huntMonsterTeamModel:checkSelectDiscipleValid()then
UIManager.info("尚未选择弟子")
return
end
if self.costMoney>self.currentMoney then
gainControl:showGainWin(eMoneyType.mtLingPai)
UIManager.error("令牌不足，无法进行狩猎")
return
end

local tipsStr=FMT.fmt("剩余{0}不足{1}，是否继续执行？",itemsConfig.getItemName(eMoneyType.mtLingPai),self.costMoney)
local func=function()
huntMonsterTeamController:reqStartTeam()
end
moneyPlanModel:checkHandle(eMoneyType.mtLingPai,self.costMoney,func,tipsStr)
end


function UIWorldMonsterHurtTeamWin:onRewardDetailBtn()
local monsters=huntMonsterTeamModel:getSelectMonster()
local detail=huntMonsterTeamModel:calculateMonstersRewards(monsters,true)
local actRewards=huntMonsterTeamModel:calculateMonstersActRewards(monsters)
UIManager:showWindow("UIDetailDropWin",{detail=detail,actRewards=actRewards})
end


function UIWorldMonsterHurtTeamWin:onStopBtn()
if self.data~=nil and not huntMonsterTeamModel:isTeamComplete(self.data)and not huntMonsterTeamModel:isTeamStop(self.data)then
huntMonsterTeamController:reqStopTeam(self.world)
else
if self.data==nil then
logErr('终止狩猎没反应！ 没数据！')
else
if huntMonsterTeamModel:isTeamComplete(self.data)then
loggerUtil.logErrFMT('终止狩猎没反应！ 已完成：{0}',tostring(self.data.progress))
else
loggerUtil.logErrFMT('终止狩猎没反应！ 已停止：{0}',tostring(self.data.progress))
end
end
end




end


function UIWorldMonsterHurtTeamWin:onCompleteBtn()
if self.data~=nil and huntMonsterTeamModel:isTeamComplete(self.data)then
huntMonsterTeamController:cancelTeamData(self.data)




end
end

function UIWorldMonsterHurtTeamWin:onClickTeamItem()
if self.data~=nil then return end
local monsters=huntMonsterTeamModel:getSelectMonster()
local level=huntMonsterTeamModel:calculuteMonstersMaxLevel(monsters)
local world=self.world
self.jumpClearSelect=true
fightController.showPrepareWin(eFightPreSelectType.lieyaodui,{
enterTxt="猎妖队",
isHomeBattle=false,
enterCallBack=function(selectList,zfid)
fightController:closeSelectStage(false)
UIFullFightPrepareControl:closeUI()

huntMonsterTeamController:setSelectDisciple(selectList,zfid)

if worldController:isInWorld()then
worldController:changeLeftView("UIWorldUnitListWin2",{tab=2,extra={world=world,showhunt=true}})
else
UIManager:showWindow("UIWorldMapWinEx",{showInfo=true,enter=function(index)
if not mainControl:isWaitSceneChange()then
worldController:enterWorld(index)
end
UIManager:closeWindow("UIWorldMapWinEx")
end})
UIManager:showWindow("UIWorldUnitListWin2",{tab=2,extra={world=world,showhunt=true}})
end
end,
cancelCallBack=function()

if worldController:isInWorld()then
worldController:changeLeftView("UIWorldUnitListWin2",{tab=2,extra={world=world,showhunt=true}})
else
UIManager:showWindow("UIWorldMapWinEx",{showInfo=true,enter=function(index)
if not mainControl:isWaitSceneChange()then
worldController:enterWorld(index)
end
UIManager:closeWindow("UIWorldMapWinEx")
end})
UIManager:showWindow("UIWorldUnitListWin2",{tab=2,extra={world=world,showhunt=true}})
end
end,


})
end

function UIWorldMonsterHurtTeamWin:updateData()
self.data=huntMonsterTeamModel:getTeamData(self.world)
end

function UIWorldMonsterHurtTeamWin:refreshView()
local oState=self.state

if not self.data then
self.state=_winState.prepare
elseif huntMonsterTeamModel:isTeamStop(self.data)then
self.state=_winState.stoping
elseif huntMonsterTeamModel:isTeamComplete(self.data)then
self.state=_winState.finish
else
self.state=_winState.hunting
end
for rootName,rootHandle in pairs(_roots)do
local haveOpen=mathHelper.getBitValue(rootHandle.bit,oState-1)
local willOpen=mathHelper.getBitValue(rootHandle.bit,self.state-1)
self[rootName]:setActive(willOpen)
if haveOpen and not willOpen then
if rootHandle.hideView then
self[rootHandle.hideView](self)
end
elseif not haveOpen and willOpen then
self[rootHandle.showView](self)
end
end
end

function UIWorldMonsterHurtTeamWin:resetView()
for rootName,rootHandle in pairs(_roots)do
local haveOpen=mathHelper.getBitValue(rootHandle.bit,self.state-1)
self[rootName]:setActive(haveOpen)
if haveOpen then
if rootHandle.hideView then
self[rootHandle.hideView](self)
end
end
end
self.state=0
end

function UIWorldMonsterHurtTeamWin:showFinishView()
local cur=#self.data.victory
local max=#self.data.monsters
local str=FMT.fmt('本次狩猎击杀妖怪：{0}/{1}',cur,max)
self.finalPorgress:setText(str)

local result=cur>0
self.victoryImg:setActive(result)
self.defeatedImg:setActive(not result)
self.finalRewardView:setActive(result)
self.strengthenTips:setActive(not result)
self.strengthenScroll:setActive(not result)
self.finalTxBg:setActive(not result)
if result then
local rewards={}
for i,v in ipairs(self.data.rewardList)do
table.insert(rewards,{itemsConfig.getItemColor(v.itemid),v.itemid,v.num,guid=v.itemguid})
end
table.sort(rewards,self.sortItemTemp)
self.finalRewards:setChildLayoutGroupCreateItems(#rewards,function(index)
local item=self.finalRewards:getChildLayoutGroupGridItem(index-1)
local sortData=rewards[index]
local itemid=sortData[2]
local num=sortData[3]
local itemguid=sortData.guid
local showCountBG=num>1
local countStr=showCountBG and num or""
local conf={itemid=itemid,itemcount=countStr,itemguid=itemguid,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(_rewardItemCmp.item,prop)
item:SetBaseItemClickEvent(_rewardItemCmp.item,itemsComponentHelper.onItemClickEx)
item:SetChildActive(_rewardItemCmp.gailv,false)
end)
else
self.jumpData=strengthenController:getStrengthenJumpList(strengthenFunctionType.eFightLose,true)
local jumpCnt=#self.jumpData
self.strengthenCreator:setChildLayoutGroupCreateItems(jumpCnt)
local strengthenGrid=self.strengthenCreator:getChildLayoutGroupGridList()
for i=1,jumpCnt do
local item=strengthenGrid[i-1]
local cfg=self.jumpData[i]
item:SetChildIcon(0,FMT.fmt('icon_sjtp_{0}',cfg.icon),false)
item:SetChildText(1,cfg.name)
item:SetChildButtonClickWithID(2,self.onClickStrengthenItem,i,true)
end

local tLevel=self.data.level
self.finalTargetLv:setText(UIDiscipleModel:getJJName3(tLevel))
local aLevel=huntMonsterTeamModel:calculateAverageDiscipleLv(self.data.team)
local aStr=UIDiscipleModel:getJJName3(aLevel)
if aLevel<tLevel then
aStr=FMT.cfmt(FONT_COLOR.eRedColor,aStr)
end
self.finalAvangeLv:setText(aStr)
end
end

function UIWorldMonsterHurtTeamWin.onClickStrengthenItem(index)
local cfg=_this.jumpData[index]
local jumpType=cfg.jumpType
local disciples={}
for i,v in ipairs(_this.data.team)do
if mathHelper.validInt64(v)then
table.insert(disciples,UIDiscipleModel:getDiscipleDataX(v))
end
end
local params={disciples=disciples}
strengthenController:doJump(jumpType,params)
end

function UIWorldMonsterHurtTeamWin.sortItemTemp(a,b)
for i=1,#a do
local A=a[i]
local B=b[i]
if A~=B then
return A>B
end
end
return false
end

function UIWorldMonsterHurtTeamWin:showRewardView()
local rewards={}
for i,v in ipairs(self.data.rewardList)do
table.insert(rewards,{itemsConfig.getItemColor(v.itemid),v.itemid,v.num,guid=v.itemguid})
end
table.sort(rewards,self.sortItemTemp)
local count=#rewards
self.huntRewards:setChildLayoutGroupCreateItems(count,function(index)
local item=self.huntRewards:getChildLayoutGroupGridItem(index-1)
local sortData=rewards[index]
local itemid=sortData[2]
local num=sortData[3]
local itemguid=sortData.guid
local showCountBG=num>1
local countStr=showCountBG and num or""
local conf={itemid=itemid,itemcount=countStr,itemguid=itemguid,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(_rewardItemCmp.item,prop)
item:SetBaseItemClickEvent(_rewardItemCmp.item,itemsComponentHelper.onItemClickEx)
item:SetChildActive(_rewardItemCmp.gailv,false)
end)
self.noneReward:setActive(count<=0)
end

function UIWorldMonsterHurtTeamWin:showTeamView1()
local teamData=huntMonsterTeamModel:getSelectDisciple()or{}
if#teamData<=0 then
local saveData=fightPreSelectModel:getTeamData(fightPreSelectModel.fightType.lieyaodui)
huntMonsterTeamModel:setSelectDiscipleEx(saveData)
teamData=huntMonsterTeamModel:getSelectDisciple()or{}

local saveZF=fightPreSelectModel:getZhenFaData(fightPreSelectModel.fightType.lieyaodui)
huntMonsterTeamModel:setSelectZhenFa(saveZF or 0)

self:showPerpareView()
end
local teamList=self.teamList1
local click=function()
self:onClickTeamItem()
end
local items=teamList:getChildLayoutGroupGridList()
local newbie=items.Count<=0
self:showTeamView(teamList,teamData,click,newbie)
end

function UIWorldMonsterHurtTeamWin:showTeamView2()
local teamData=self.data.team
local teamList=self.teamList2
local click=nil
self:showTeamView(teamList,teamData,click)
end

function UIWorldMonsterHurtTeamWin:showTeamView(teamList,teamData,click,newbie)
teamList:setChildLayoutGroupCreateItems(5,function(index)
local itemList=teamList:getChildLayoutGroupGridItem(index-1)
local guid=teamData[index]
itemList:SetChildButtonClick(_teamItemCmp.background,click)
local have=mathHelper.validInt64(guid)
itemList:SetChildActive(_teamItemCmp.item,have)
itemList:SetChildActive(_teamItemCmp.background,not have)
if newbie then
itemList:SetChildNewBieComponentId(_teamItemCmp.background,FMT.fmt("UIWorldMonsterHurtTeamWin.TeamView.Item_{0}",index))
end
if have then
local item=itemList:GetChildWidgetBase(_teamItemCmp.item)
local netData=UIDiscipleModel:getDiscipleData(guid)

local color=UIDiscipleModel:getDiscipleColor(guid)
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netData)
item:SetChildCSImageSprite(0,abname,iconname)

local jobicon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildCSImageSprite(1,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(22,isSpDz)

item:SetChildText(2,UIDiscipleModel:getDiscipleName(guid))

comHelper.setChildModelRawImage(item,guid,3,0,eHeadCenterType.eHead,nil,false)

item:SetChildCSImageSprite(17,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])

local lv_str=tostring(netData.jingjielv)
item:SetChildText(5,lv_str)

item:SetChildActive(6,true)
item:SetChildText(6,UIDiscipleModel:getDiscipleFightValue(guid))

UIDiscipleController.refreshCommonItemTianMing(item,netData)

item:SetChildButtonClick(-1,click)
end
end)
end

function UIWorldMonsterHurtTeamWin:showStopingView()
self:stopStopCDTimer()
local least=self.data.untilTime-timeHelper.getServerShortTime()
least=math.max(least,0)
local str=timeHelper.format_time_stamp(least)
self.stopTime:setText(str)
if least>0 then
self:startStopCDTimer()
end







end

function UIWorldMonsterHurtTeamWin:hideStopingView()
self:stopStopCDTimer()
end

function UIWorldMonsterHurtTeamWin:showHuntingView()
self:stopHuntCDTimer()
local least=self.data.untilTime-timeHelper.getServerShortTime()
least=math.max(least,0)
local str=FMT.fmt("<color=#7D3B17>狩猎剩余时长：</color>{0}",timeHelper.format_time_stamp(least))
self.leastTime:setText(str)
if least>0 then
self:startHuntCDTimer()
end
local Str=FMT.fmt("<color=#7D3B17>已狩猎怪物：</color>{0}/{1}",self.data.progress-1,#self.data.monsters)
self.progressTx:setText(Str)
end

function UIWorldMonsterHurtTeamWin:hideHuntingView()
self:stopHuntCDTimer()
end

function UIWorldMonsterHurtTeamWin:showPerpareView()
local monsters=huntMonsterTeamModel:getSelectMonster()
local disciples=huntMonsterTeamModel:getSelectDisciple()

self.maxNum:setText(#monsters)

self.targetLv=huntMonsterTeamModel:calculuteMonstersMaxLevel(monsters)
local targetLvStr=self.targetLv>0 and UIDiscipleModel:getJJName3(self.targetLv)or"<color=#725D50>未选择猎物</color>"
self.recommendTx:setText(targetLvStr)

self.averageLv=huntMonsterTeamModel:calculateAverageDiscipleLv(disciples)
local averageLvStr=nil
if self.averageLv>=0 then
averageLvStr=UIDiscipleModel:getJJName3(self.averageLv)
if self.averageLv<self.targetLv then
averageLvStr=FMT.fmt("<color=#C82C2C>{0}</color>",averageLvStr)
end
else
averageLvStr="<color=#725D50>未选择弟子</color>"
end
self.averageTx:setText(averageLvStr)
self.averageIcon:setActive(huntMonsterTeamModel:checkSelectDiscipleValid()and self.targetLv>self.averageLv)

local haveSelect=#monsters>0
self.costIcon:setActive(haveSelect)
self.noneSelect:setActive(not haveSelect)

local duration=haveSelect and huntMonsterTeamModel:calculateMonstersDuration(monsters)or 0
local durationStr=FMT.fmt("<color=#7D3B17>狩猎时长：</color>{0}",timeHelper.format_time_stamp(duration))
self.perpareDuration:setText(durationStr)

if haveSelect then
self.costMoney=huntMonsterTeamModel:calculateMonstersCost(monsters,eMoneyType.mtLingPai)
self.currentMoney=moneyModel.getMoney(eMoneyType.mtLingPai)
local str=FMT.fmt("{0}/{1}",_this.costMoney,_this.currentMoney)
if self.costMoney>self.currentMoney then
str=FMT.cfmt(FONT_COLOR.eRedColor,str)
end
self.perpareCostNum:setText(str)
self.costTips:setText("")
else
self.perpareCostNum:setText("")
self.costTips:setText("尚未选择猎物")
end

local rewards=huntMonsterTeamModel:calculateMonstersRewards(monsters,false)
local rewardsCnt=#rewards
self.perpareRewards:setChildLayoutGroupCreateItems(rewardsCnt,function(index)
local item=self.perpareRewards:getChildLayoutGroupGridItem(index-1)
local data=rewards[index]
local id=data[1]
local num=data[2]
local showCountBG=num>1
local countStr=showCountBG and num or""
local conf={itemid=id,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(_rewardItemCmp.item,prop)
item:SetBaseItemClickEvent(_rewardItemCmp.item,itemsComponentHelper.onItemClickEx)
item:SetChildActive(_rewardItemCmp.gailv,num<0)
end)
self.rewardDetailBtn:setActive(rewardsCnt>=_detailShow)
end

function UIWorldMonsterHurtTeamWin:stopHuntCDTimer()
if self.huntCDTimer then
self:stopTimerByID(self.huntCDTimer)
self.huntCDTimer=nil
end
end

function UIWorldMonsterHurtTeamWin:startHuntCDTimer()
if not self.huntCDTimer then
self.huntCDTimer=self:setTimer(1,0,function()
local least=self.data.untilTime-timeHelper.getServerShortTime()
least=math.max(least,0)
local str=FMT.fmt("<color=#7D3B17>狩猎剩余时长：</color>{0}",timeHelper.format_time_stamp(least))
self.leastTime:setText(str)
if least<=0 then
self:stopHuntCDTimer()
end
end)
end
end

function UIWorldMonsterHurtTeamWin:stopStopCDTimer()
if self.stopCDTimer then
self:stopTimerByID(self.stopCDTimer)
self.stopCDTimer=nil
end
end

function UIWorldMonsterHurtTeamWin:startStopCDTimer()
if not self.stopCDTimer then
self.stopCDTimer=self:setTimer(1,0,function()
local least=self.data.untilTime-timeHelper.getServerShortTime()
least=math.max(least,0)
local str=timeHelper.format_time_stamp(least)
self.stopTime:setText(str)
if least<=0 then
self:stopStopCDTimer()
end
end)
end
end

function UIWorldMonsterHurtTeamWin:stopAllCDTimer()
self:stopStopCDTimer()
self:stopHuntCDTimer()
end

function UIWorldMonsterHurtTeamWin.onMoneyChanged(moneyType,oldVal,newVal)
if moneyType==eMoneyType.mtLingPai then
_this.currentMoney=newVal
if _this.state==_winState.prepare then
local monsters=huntMonsterTeamModel:getSelectMonster()
local haveSelect=#monsters>0
if haveSelect then
local str=FMT.fmt("{0}/{1}",_this.costMoney,_this.currentMoney)
if _this.costMoney>_this.currentMoney then
str=FMT.cfmt(FONT_COLOR.eRedColor,str)
end
_this.perpareCostNum:setText(str)
end
end
end
end

function UIWorldMonsterHurtTeamWin.onHuntMonsterTeamSelectMonsterChange(cType,cList)
if _this.state~=_winState.prepare then return end
if _this.world~=huntMonsterTeamModel:getSelectWorld()then return end

local oldlv=_this.targetLv or 0
local monsters=huntMonsterTeamModel:getSelectMonster()
_this.maxNum:setText(#monsters)
_this.targetLv=huntMonsterTeamModel:calculuteMonstersMaxLevel(monsters)
local targetLvStr=_this.targetLv>0 and UIDiscipleModel:getJJName3(_this.targetLv)or"<color=#725D50>未选择猎物</color>"
_this.recommendTx:setText(targetLvStr)
if oldlv~=_this.targetLv then
local averageLvStr=nil
if _this.averageLv and _this.averageLv>=0 then
averageLvStr=UIDiscipleModel:getJJName3(_this.averageLv)
if _this.averageLv<_this.targetLv then
averageLvStr=FMT.fmt("<color=#C82C2C>{0}</color>",averageLvStr)
end
else
averageLvStr="<color=#725D50>未选择弟子</color>"
end
_this.averageTx:setText(averageLvStr)
_this.averageIcon:setActive(huntMonsterTeamModel:checkSelectDiscipleValid()and _this.targetLv>_this.averageLv)
end
local haveSelect=#monsters>0
_this.costIcon:setActive(haveSelect)
_this.noneSelect:setActive(not haveSelect)

local duration=haveSelect and huntMonsterTeamModel:calculateMonstersDuration(monsters)or 0
local durationStr=FMT.fmt("<color=#7D3B17>狩猎时长：</color>{0}",timeHelper.format_time_stamp(duration))
_this.perpareDuration:setText(durationStr)

if haveSelect then
_this.costMoney=huntMonsterTeamModel:calculateMonstersCost(monsters,eMoneyType.mtLingPai)
_this.currentMoney=_this.currentMoney or moneyModel.getMoney(eMoneyType.mtLingPai)
local str=FMT.fmt("{0}/{1}",_this.costMoney,_this.currentMoney)
if _this.costMoney>_this.currentMoney then
str=FMT.cfmt(FONT_COLOR.eRedColor,str)
end
_this.perpareCostNum:setText(str)
_this.costTips:setText("")
else
_this.perpareCostNum:setText("")
_this.costTips:setText("尚未选择猎物")
end

local rewards=huntMonsterTeamModel:calculateMonstersRewards(monsters,false)
local rewardsCnt=#rewards
_this.perpareRewards:setChildLayoutGroupCreateItems(rewardsCnt,function(index)
local item=_this.perpareRewards:getChildLayoutGroupGridItem(index-1)
local data=rewards[index]
local id=data[1]
local num=data[2]
local showCountBG=num>1
local countStr=showCountBG and num or""
local conf={itemid=id,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(_rewardItemCmp.item,prop)
item:SetBaseItemClickEvent(_rewardItemCmp.item,itemsComponentHelper.onItemClickEx)
item:SetChildActive(_rewardItemCmp.gailv,num<0)
end)
_this.rewardDetailBtn:setActive(rewardsCnt>=_detailShow)
end

function UIWorldMonsterHurtTeamWin.onHuntMonsterTeamSelectDiscipleChange()
if _this.state~=_winState.prepare then return end
if _this.world~=huntMonsterTeamModel:getSelectWorld()then return end

local oldlv=_this.averageLv or 0
local disciples=huntMonsterTeamModel:getSelectDisciple()
_this.averageLv=huntMonsterTeamModel:calculateAverageDiscipleLv(disciples)
local averageLvStr=nil
if _this.averageLv>=0 then
averageLvStr=UIDiscipleModel:getJJName3(_this.averageLv)
if _this.averageLv<_this.targetLv then
averageLvStr=FMT.fmt("<color=#C82C2C>{0}</color>",averageLvStr)
end
else
averageLvStr="<color=#725D50>未选择弟子</color>"
end
_this.averageTx:setText(averageLvStr)
if oldlv~=_this.averageLv then
_this.averageIcon:setActive(_this.targetLv>_this.averageLv)
end
_this:showTeamView1()
end

function UIWorldMonsterHurtTeamWin.onHuntMonsterTeamSelectWorldChange(world)
if not _this.isClose then
if world>0 then
_this:onShow({parentWin=_this.parentWin},false)
else
if _this.parentWin then
_this.parentWin:closeWindow("UIWorldMonsterHurtTeamWin")
end
end
end
end

function UIWorldMonsterHurtTeamWin.onHuntMonsterTeamStartTeam(world)
if world==_this.world then
_this:updateData()
_this:refreshView()
end
end

function UIWorldMonsterHurtTeamWin.onHuntMonsterTeamEndTeam(world)
if world==_this.world then
huntMonsterTeamController:setSelectWorld(world)
_this:updateData()
_this:refreshView()
end
end

function UIWorldMonsterHurtTeamWin.onHuntMonsterTeamFight(result,world,unitKey)
if world==_this.world then
if huntMonsterTeamModel:isTeamComplete(_this.data)then
_this:refreshView()
return
end

if result==fightResultType.Victory then
_this:showRewardView()
end
local Str=FMT.fmt("<color=#7D3B17>已狩猎怪物：</color>{0}/{1}",_this.data.progress-1,#_this.data.monsters)
_this.progressTx:setText(Str)
end
end

function UIWorldMonsterHurtTeamWin.onHuntMonsterTeamStop(world)
if world==_this.world then
_this:refreshView()
end
end