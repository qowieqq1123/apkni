







def_class("UISubAct_longhuxiangyao_Win",UIWindowBase)









function UISubAct_longhuxiangyao_Win:bindComponents()

self.challengeList=UIObject.get(self,0)
self.challengeItem_1=UIObject.get(self,1)
self.challengeItem_2=UIObject.get(self,2)
self.challengeItem_3=UIObject.get(self,3)
self.challengeItem_4=UIObject.get(self,4)
self.challengeItem_5=UIObject.get(self,5)
self.challengeItem_6=UIObject.get(self,6)
self.challengeItem_7=UIObject.get(self,7)
self.challengeItem_8=UIObject.get(self,8)
self.challengeItem_9=UIObject.get(self,9)
self.challengeItem_10=UIObject.get(self,10)
self.infoRoot=UIObject.get(self,11)
self.TitleTx=UIText.get(self,12)
self.NameTx=UIText.get(self,13)
self.RequirementTx=UIText.get(self,14)
self.IconKuang=UIImage.get(self,15)
self.IconImg=UIObject.get(self,16)
self.bossTips=UIImage.get(self,17)
self.DescTx=UIText.get(self,18)
self.detailBtn=UIButton.get(self,19)
self.RewardTips=UIText.get(self,20)
self.ItemScrollView=UIObject.get(self,21)
self.ItemList=UIObject.get(self,22)
self.ItemCmps_1=UIBaseItem.get(self,23)
self.ItemCmps_2=UIBaseItem.get(self,24)
self.ItemCmps_3=UIBaseItem.get(self,25)
self.ItemCmps_4=UIBaseItem.get(self,26)
self.ItemCmps_5=UIBaseItem.get(self,27)
self.skillList=UIObject.get(self,28)
self.rewardRoot=UIObject.get(self,29)
self.rewardItem=UIBaseItem.get(self,30)
self.rewardreddot=UIObject.get(self,31)
self.recved=UIObject.get(self,32)
self.proTxt=UIText.get(self,33)
self.rewardEnterBtn=UIButton.get(self,34)
self.EnterBtnReddot=UIImage.get(self,35)
self.timeRoot=UIObject.get(self,36)
self.timeTxt=UIText.get(self,37)
self.challengeBtn=UIButton.get(self,38)
self.rewardList=UIObject.get(self,39)
self.collectGrid=UIObject.get(self,40)
self.rewardListcloseBtn=UIButton.get(self,41)
self.rewardListback=UIButton.get(self,42)
self.model=UIObject.get(self,43)
self.rewardmodel=UIObject.get(self,44)
self.croot=UIObject.get(self,45)
self.modelRoot=UIObject.get(self,46)
self.bossModelRoot=UIObject.get(self,47)
self.monModelRoot1=UIObject.get(self,48)
self.monModelRoot2=UIObject.get(self,49)
self.monModelRoot3=UIObject.get(self,50)
self.DZRoot=UIObject.get(self,51)
self.line_1=UIObject.get(self,52)
self.line_2=UIObject.get(self,53)
self.line_3=UIObject.get(self,54)
self.line_4=UIObject.get(self,55)
self.line_5=UIObject.get(self,56)
self.line_6=UIObject.get(self,57)
self.line_7=UIObject.get(self,58)
self.line_8=UIObject.get(self,59)
self.line_9=UIObject.get(self,60)

self.detailBtn:setButtonClick(function()self:onDetailBtn()end)

self.rewardEnterBtn:setButtonClick(function()self:onRewardEnterBtn()end)

self.challengeBtn:setButtonClick(function()self:onChallengeBtn()end)

self.rewardListcloseBtn:setButtonClick(function()self:onRewardListcloseBtn()end)

self.rewardListback:setButtonClick(function()self:onRewardListback()end)
self.challengeItem={
self.challengeItem_1,
self.challengeItem_2,
self.challengeItem_3,
self.challengeItem_4,
self.challengeItem_5,
self.challengeItem_6,
self.challengeItem_7,
self.challengeItem_8,
self.challengeItem_9,
self.challengeItem_10,
}
self.ItemCmps={
self.ItemCmps_1,
self.ItemCmps_2,
self.ItemCmps_3,
self.ItemCmps_4,
self.ItemCmps_5,
}
self.line={
self.line_1,
self.line_2,
self.line_3,
self.line_4,
self.line_5,
self.line_6,
self.line_7,
self.line_8,
self.line_9,
}



end


function UISubAct_longhuxiangyao_Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.challengeList);self.challengeList=nil;
_UIObject_release(self.challengeItem_1);self.challengeItem_1=nil;
_UIObject_release(self.challengeItem_2);self.challengeItem_2=nil;
_UIObject_release(self.challengeItem_3);self.challengeItem_3=nil;
_UIObject_release(self.challengeItem_4);self.challengeItem_4=nil;
_UIObject_release(self.challengeItem_5);self.challengeItem_5=nil;
_UIObject_release(self.challengeItem_6);self.challengeItem_6=nil;
_UIObject_release(self.challengeItem_7);self.challengeItem_7=nil;
_UIObject_release(self.challengeItem_8);self.challengeItem_8=nil;
_UIObject_release(self.challengeItem_9);self.challengeItem_9=nil;
_UIObject_release(self.challengeItem_10);self.challengeItem_10=nil;
_UIObject_release(self.infoRoot);self.infoRoot=nil;
_UIObject_release(self.TitleTx);self.TitleTx=nil;
_UIObject_release(self.NameTx);self.NameTx=nil;
_UIObject_release(self.RequirementTx);self.RequirementTx=nil;
_UIObject_release(self.IconKuang);self.IconKuang=nil;
_UIObject_release(self.IconImg);self.IconImg=nil;
_UIObject_release(self.bossTips);self.bossTips=nil;
_UIObject_release(self.DescTx);self.DescTx=nil;
_UIObject_release(self.detailBtn);self.detailBtn=nil;
_UIObject_release(self.RewardTips);self.RewardTips=nil;
_UIObject_release(self.ItemScrollView);self.ItemScrollView=nil;
_UIObject_release(self.ItemList);self.ItemList=nil;
_UIObject_release(self.ItemCmps_1);self.ItemCmps_1=nil;
_UIObject_release(self.ItemCmps_2);self.ItemCmps_2=nil;
_UIObject_release(self.ItemCmps_3);self.ItemCmps_3=nil;
_UIObject_release(self.ItemCmps_4);self.ItemCmps_4=nil;
_UIObject_release(self.ItemCmps_5);self.ItemCmps_5=nil;
_UIObject_release(self.skillList);self.skillList=nil;
_UIObject_release(self.rewardRoot);self.rewardRoot=nil;
_UIObject_release(self.rewardItem);self.rewardItem=nil;
_UIObject_release(self.rewardreddot);self.rewardreddot=nil;
_UIObject_release(self.recved);self.recved=nil;
_UIObject_release(self.proTxt);self.proTxt=nil;
_UIObject_release(self.rewardEnterBtn);self.rewardEnterBtn=nil;
_UIObject_release(self.EnterBtnReddot);self.EnterBtnReddot=nil;
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.challengeBtn);self.challengeBtn=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.collectGrid);self.collectGrid=nil;
_UIObject_release(self.rewardListcloseBtn);self.rewardListcloseBtn=nil;
_UIObject_release(self.rewardListback);self.rewardListback=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.rewardmodel);self.rewardmodel=nil;
_UIObject_release(self.croot);self.croot=nil;
_UIObject_release(self.modelRoot);self.modelRoot=nil;
_UIObject_release(self.bossModelRoot);self.bossModelRoot=nil;
_UIObject_release(self.monModelRoot1);self.monModelRoot1=nil;
_UIObject_release(self.monModelRoot2);self.monModelRoot2=nil;
_UIObject_release(self.monModelRoot3);self.monModelRoot3=nil;
_UIObject_release(self.DZRoot);self.DZRoot=nil;
_UIObject_release(self.line_1);self.line_1=nil;
_UIObject_release(self.line_2);self.line_2=nil;
_UIObject_release(self.line_3);self.line_3=nil;
_UIObject_release(self.line_4);self.line_4=nil;
_UIObject_release(self.line_5);self.line_5=nil;
_UIObject_release(self.line_6);self.line_6=nil;
_UIObject_release(self.line_7);self.line_7=nil;
_UIObject_release(self.line_8);self.line_8=nil;
_UIObject_release(self.line_9);self.line_9=nil;
self.challengeItem=nil;
self.ItemCmps=nil;
self.line=nil;
end


















local challengeItemCmpIndex={
lockRoot=0,
unlockRoot=1,
challengedRoot=2,
lockBg=3,
lockIcon=4,
unlockBg=5,
unlockIcon=6,
challengedBg=7,
challengedIcon=8,
click=9,
itemSelf=10,
}

local challengeItemState={
eLock=1,
eUnLock=2,
eChallenged=3,
}

local modelState={
eNot=0,
eBoss=1,
eMon1=2,
eMon2=3,
eMon3=4,
}

local animState={
eBossIdle=1,
eBossDead=2,
eBossAngry=3,
eMon1Dead=4,
eMon1Idle=5,
eMon2Dead=6,
eMon2Idle=7,
eMon3Dead=8,
eMon3Idle=9,
}


local RewardState={
eRecved=1,
eNotRecv=2,
eRecv=3,
}

local StageState={
eNotFinish=1,
eNotAllFinish=2,
eAllFinish=3,
}




local _abName="ui/sharedtextures/uiglobalspriteatlas_1.ab"
local _sabName="ui/windows/activities/sub_longhuxiangyao/longhuxiangyao_atlas_pak.ab"
local _bossTips={
[monType.LittleMonster]=nil,
[monType.EliteMonster]="icon_guaiwubiaoqian_2",
[monType.Boss]="icon_guaiwubiaoqian_1",
[monType.BigBoss]="icon_guaiwubiaoqian_1",
[monType.GodAnimal]="icon_guaiwubiaoqian_1",
}
local _bossKuang={
[monType.LittleMonster]="frame_guaiwukuang_1",
[monType.EliteMonster]="frame_guaiwukuang_1",
[monType.Boss]="frame_guaiwukuang_2",
[monType.BigBoss]="frame_guaiwukuang_2",
[monType.GodAnimal]="frame_guaiwukuang_2",
}

local lockiconName={
[monType.LittleMonster]="icon_longhuxiangyaoui_1",
[monType.EliteMonster]="icon_longhuxiangyaoui_2",
[monType.Boss]="icon_longhuxiangyaoui_3",
}

local animStateTemp={
[1]={animState.eBossAngry},
[2]={animState.eBossAngry},
[3]={animState.eBossAngry,animState.eMon3Dead},
[4]={animState.eBossAngry},
[5]={animState.eBossAngry},
[6]={animState.eBossAngry,animState.eMon2Dead},
[7]={animState.eBossAngry},
[8]={animState.eBossAngry},
[9]={animState.eBossAngry,animState.eMon1Dead},
[10]={animState.eBossDead},
}

local modelStateTemp={
modelState.eMon3,
modelState.eMon3,
modelState.eMon3,
modelState.eMon2,
modelState.eMon2,
modelState.eMon2,
modelState.eMon1,
modelState.eMon1,
modelState.eMon1,
modelState.eBoss,
}


function UISubAct_longhuxiangyao_Win:onLoaded(...)
self:bindComponents()
self.challengeItemWidgetList={}
local widget
for i,v in ipairs(self.challengeItem)do
widget=v:getChildWidgetBase()
self.challengeItemWidgetList[#self.challengeItemWidgetList+1]=widget

widget:SetClickerEvent("click",nil,function()
self:onClick(i)
end,nil,nil)
end
for i,v in ipairs(self.ItemCmps)do
v:setBaseItemClickEvent(itemsComponentHelper.onItemClick)
end
self.rewardItem:setBaseItemClickEvent(function()
self:onRewardItemClick()
end)
self.bossItemList={}
self.mon1ItemList={}
self.mon2ItemList={}
self.mon3ItemList={}
self.modelRootList={
[animState.eBossIdle]={self.bossItemList,eAnimationID.stand},
[animState.eBossDead]={self.bossItemList,eAnimationID.dead},
[animState.eBossAngry]={self.bossItemList,eAnimationID.attack1},
[animState.eMon1Dead]={self.mon1ItemList,eAnimationID.dead},
[animState.eMon1Idle]={self.mon1ItemList,eAnimationID.stand},
[animState.eMon2Dead]={self.mon2ItemList,eAnimationID.dead},
[animState.eMon2Idle]={self.mon2ItemList,eAnimationID.stand},
[animState.eMon3Dead]={self.mon3ItemList,eAnimationID.dead},
[animState.eMon3Idle]={self.mon3ItemList,eAnimationID.stand},
}

self.modelCreateRootList={
{self.monModelRoot1,self.mon1ItemList},
{self.monModelRoot2,self.mon2ItemList},
{self.monModelRoot3,self.mon3ItemList},
{self.bossModelRoot,self.bossItemList}
}

self.model:setChildUIModelShowTarget(5339,1,nil,eAnimationID.stand)


end

function UISubAct_longhuxiangyao_Win:createDZ()
if self.currDZ then
return
end













local initData={
speakHUDID=1,
taeget=1,
offset={-56,4},
skin=2,
connet=self:getSpeakText(),
fanzhuan=true
}

local otherData={
scale=0.5
}
local tran=self.DZRoot:getCommonComponent('Transform')
local vpos=Vector2.New(399.6,-349.7)
local topGuid


local discipleList=discipleLookup:getSortDiscipleList(eDiscipleSortType.eFightSort,nil,eSortOrder.eDown)
local discipleCount=#discipleList
if discipleCount>0 then
local netData=discipleList[1].netData
local discipleguid=netData.net.discipleguid
topGuid=discipleguid
end

if not topGuid then
return
end
uiAIManager:createUIDisciple('UISubAct_longhuxiangyao_Win','bt_ui_show_speak',topGuid,tran,vpos,initData,otherData,function(bt)
self.currDZ=bt
self.connetState=self.stageIsFinish
end)
end

function UISubAct_longhuxiangyao_Win:getSpeakText()
local state=self:getCurStageState()
local connet=self.config.connet
return connet[state]
end

function UISubAct_longhuxiangyao_Win:getCurStageState()
local state=StageState.eNotFinish
if self.stageIsFinish then
state=self.day>=self.maxDay and StageState.eAllFinish or StageState.eNotAllFinish
end
return state
end

function UISubAct_longhuxiangyao_Win:getNextStageTime()
local timeDay=0
local curday=self.sub_actInfo:getStart2NowDay()
local nextDay=self.maxDay
for i=self.day+1,self.maxDay do
if self.monsterCfglookup[i]then
nextDay=i
break
end
end

for i=curday+1,nextDay do
timeDay=timeDay+1
if self.monsterCfglookup[i]then
break
end
end
local nextTime=timeDay*86400-timeHelper.getServerTodayPass()
return nextTime>0 and nextTime or 0
end



function UISubAct_longhuxiangyao_Win:__delete()
self:unbindComponents()
self.challengeItemWidgetList=nil
uiAIManager:clearUIWinData('UISubAct_longhuxiangyao_Win')
self.currDZ=nil
end




function UISubAct_longhuxiangyao_Win:onShow(argtable,afterOnloaded)

self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id

local extraParams=argtable.extraParams or{}
self.isPlayAnim=extraParams.result and extraParams.result==fightResultType.Victory

self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)


self.data=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.monsterIndex=self.data.monster_idx
self.reward_flag=self.data.reward_flag
self.monlevel=self.data.monlevel

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.monsterCfg,self.monsterCfglookup,self.maxDay=self:handldConfig()
self.stageRewardList,self.swReward=self:handldConfig2()


self.day=self.monsterIndex==0 and 1 or self.monsterCfg[self.monsterIndex][1]
self.showMonsterCfg=self.monsterCfglookup[self.day]
self.monsterLen=#self.showMonsterCfg
self.dayIndex=self:getDayIndex()
self.stageIsFinish=self.dayIndex>=self.monsterLen
self.curIndex=self.stageIsFinish and self.monsterLen or self.dayIndex+1


if self.stageIsFinish then
local curday=self.sub_actInfo:getStart2NowDay()

for i=self.day+1,curday do

if self.monsterCfglookup[i]then

self.day=i
self.showMonsterCfg=self.monsterCfglookup[self.day]
self.monsterLen=#self.showMonsterCfg
self.dayIndex=self:getDayIndex()
self.stageIsFinish=false
self.curIndex=self.dayIndex+1
break
end
end

end

self.curMonGroupId=self.showMonsterCfg[self.curIndex][2]


self:initModel()
self:createDZ()

self:refresh()


if self.actTimer==nil then
local func=function()
self:refreshActTimer()
end
self.actTimer=self:setTimer(60,0,func)
end
self:refreshActTimer()

end

function UISubAct_longhuxiangyao_Win:initModel()
local modelCfg=self.config.modelCfg
local curStageModelCfg=modelCfg[self.day]
for i,v in ipairs(curStageModelCfg)do
local modelType=i
local create=self.modelCreateRootList[modelType][1]
local itemList=self.modelCreateRootList[modelType][2]
local num=#v
create:setChildLayoutGroupCreateItems(num,function(index)
local idx=index-1
local item=create:getChildLayoutGroupGridItem(idx)
itemList[#itemList+1]=item
local sCfg=v[index]
local modelId=sCfg[1]
local scale=sCfg[2]
local pos=sCfg[3]
item:SetChildUIModelShowTarget(0,modelId,scale,nil,eAnimationID.stand)
item:SetChildLocalPos(0,pos.x,pos.y,0)
item:SetChildScale(0,Vector3(pos.Sx,1,1))
end)
end
end



function UISubAct_longhuxiangyao_Win:onHide()
self.actTimer=nil
end


function UISubAct_longhuxiangyao_Win:refreshActTimer()
local time=activitiesModel:getSubActEndLeftTime(self.actID,self.subType,self.subid)
local hasDay=self.sub_actInfo:getEndLeftDayTime()
local time_str=""
local state=self:getCurStageState()
local hightpos=false

if hasDay<=2 then
time_str=FMT.fmt('活动剩余时间：{0}',timeHelper.format_time_stamp3(time))
else
if state==StageState.eNotAllFinish then
local nextStageTime=self:getNextStageTime()
time_str=nextStageTime==0 and""or FMT.fmt('下轮妖魔进攻将于{0}后开始',timeHelper.format_time_stamp13(nextStageTime))
hightpos=true
end
end
if self.lastPosFlag~=hightpos then
local pos=hightpos and Vector2.New(55,70)or Vector2.New(59.8,-342)
self.timeRoot:setChildAnchoredPosition(pos)
self.lastPosFlag=hightpos
end
self.timeTxt:setText(time_str)
end


function UISubAct_longhuxiangyao_Win:refresh()
self:refreshChallengeList()
self:setSWRewardItem()
self:refreshSWRewardState()
self:refreshStageRewardEnter()
self:refreshModel(self.isPlayAnim)
self.challengeBtn:setActive(not self.stageIsFinish)
if self.currDZ and self.connetState~=self.stageIsFinish then
self.connetState=self.stageIsFinish
local txt=self:getSpeakText()
self.currDZ:setSharedVar("connet",txt)

self.currDZ:broke()
self.currDZ:reset()
self.currDZ:tick(0)
end
end




function UISubAct_longhuxiangyao_Win:refreshChallengeList()
local state
local widget
local widgetCfg
local monsterGroupId
local mcfg
for i,v in ipairs(self.challengeItemWidgetList)do
widget=v
if i>self.monsterLen then
widget:SetChildActive(challengeItemCmpIndex.itemSelf,false)
else
widget:SetChildActive(challengeItemCmpIndex.itemSelf,true)
state=self:getState(i)
widget:SetChildActive(challengeItemCmpIndex.lockRoot,state==challengeItemState.eLock)
widget:SetChildActive(challengeItemCmpIndex.unlockRoot,state==challengeItemState.eUnLock)
widget:SetChildActive(challengeItemCmpIndex.challengedRoot,state==challengeItemState.eChallenged)
monsterGroupId=self.showMonsterCfg[i][2]
if state==challengeItemState.eLock then
mcfg=cfgHelper.get1(cfg_monstergroup_get,monsterGroupId)
local iconName=lockiconName[mcfg.monType]
widget:SetChildCSImageSprite(challengeItemCmpIndex.lockIcon,_sabName,iconName)
elseif state==challengeItemState.eUnLock then

elseif state==challengeItemState.eChallenged then
comHelper.setChildModelRawImage_monsterGroup(widget,monsterGroupId,challengeItemCmpIndex.challengedIcon,0,eHeadCenterType.eHead)
end



end
end
for i,v in ipairs(self.line)do
v:setActive(self.stageIsFinish and true or i<self.curIndex)
end
end


function UISubAct_longhuxiangyao_Win:setSWRewardItem()
local swRewardList=self.swReward.rewardList
local itemCfg=swRewardList[1]
local itemid=itemCfg[1]
local itemNum=itemCfg[2]
local itemcount
local conf={showname=false}
local item_data={itemid=itemid,itemcount=itemNum}
local showCountBG
if itemNum>1 then
itemcount=tostring(itemNum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showname=false,showStage=true}

local propData=itemsComponentHelper.getCommonFillData(item_data,conf)
propData[PropIndex(DataPropKey.eWidgetActive,8)]=false
propData[PropIndex(DataPropKey.eWidgetActive,9)]=propData[PropIndex(DataPropKey.eWidgetText,6)]~=""
self.rewardItem:setChildPropData(propData)
end


function UISubAct_longhuxiangyao_Win:refreshSWRewardState()
local state=self.sub_actInfo:getRewardState()
local cur,max=self.sub_actInfo:getStagePro()
self.rewardreddot:setActive(state==RewardState.eRecv)
self.recved:setActive(state==RewardState.eRecved)
self.proTxt:setText(FMT.fmt("剿灭妖王：{0}/{1}",cur,max))
end


function UISubAct_longhuxiangyao_Win:refreshStageRewardEnter()
local reddot=self.sub_actInfo:checkStageEnterState()
self.EnterBtnReddot:setActive(reddot)
end


function UISubAct_longhuxiangyao_Win:refreshModel(isPlay)
self:refreshModelRoot(isPlay)
if isPlay then
local animList=self:getAnimStateList()
for i,v in ipairs(animList)do
local root=self.modelRootList[v]
for ii,vv in ipairs(root[1])do
vv:SetChildModelAnimationState(0,root[2],1)
end
end
if animList and next(animList)then
self:setTimer(1.35,1,function()
self:refreshModelRoot()
end)
end
end
end

function UISubAct_longhuxiangyao_Win:refreshModelRoot(isPlay)
local state=self:getModelState(isPlay)




self.modelRoot:setActive(state>modelState.eNot)

self.bossModelRoot:setActive(state>=modelState.eBoss)





self.monModelRoot1:setActive(state>=modelState.eMon1)

self.monModelRoot2:setActive(state>=modelState.eMon2)

self.monModelRoot3:setActive(state>=modelState.eMon3)

end




function UISubAct_longhuxiangyao_Win:refreshRewardList()
if not self.rewardListFlag then
self.rewardListFlag=true
self.croot:setChildDOScale(1,0.4,nil)

self.rewardmodel:setChildUIModelShowTarget(5338,1,nil,eAnimationID.enter)
self.rewardList:setActive(true)
end
self:getRewardDataList()
local c=#self.rewardDatatList
local func=function(idx)
local item=self.collectGrid:getChildLayoutGroupGridItem(idx-1)
self:initItem(item,idx)
end
self.collectGrid:setChildLayoutGroupCreateItems(c,func)
end

function UISubAct_longhuxiangyao_Win:getRewardDataList()
self.rewardDatatList={}
local mcfg
local monsterGroupId
local stagerReward
local rewards
local monIdx
local monCfg
local temp
for i,v in ipairs(self.stageRewardList)do
temp={}
stagerReward=v
rewards=stagerReward.rewardList
monIdx=stagerReward.monIndex
monCfg=self.monsterCfg[monIdx]
temp.monIdx=monIdx
temp.rewardIdx=stagerReward.rewardIdx
temp.rewards=rewards
temp.state=self.sub_actInfo:getStageState(i)
monsterGroupId=monCfg[2]
mcfg=cfgHelper.get1(cfg_monstergroup_get,monsterGroupId)
temp.targetDec=FMT.fmt("消灭妖王:{0}",mcfg.name)
self.rewardDatatList[#self.rewardDatatList+1]=temp
end
table.sort(self.rewardDatatList,function(a,b)
if a.state==b.state then
return a.monIdx<b.monIdx
else
return a.state>b.state
end
end)
end

function UISubAct_longhuxiangyao_Win:initItem(item,idx)
local data=self.rewardDatatList[idx]

local goodlist=data.rewards
local goodgrid=item:GetChildCommonLayoutGroupWidgetList(1)
local godddata,gooditem,show,itemID,itemnum,itemcount,showCountBG,conf,prop
for i=1,4 do
godddata=goodlist[i]
gooditem=goodgrid[i-1]
show=godddata~=nil
gooditem:SetChildActive(1,show)
if show then
itemID=godddata[1]
itemnum=godddata[2]
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
conf={itemid=itemID,itemcount=itemcount,showCountBG=showCountBG,showname=false,showStage=true}
prop=itemsComponentHelper.getCommonFillDataSmall(conf)
gooditem:SetChildPropData(0,prop)
gooditem:SetBaseItemClickEvent(0,function(...)self:onGoodItemClick(...)end)
end
end
self:refreshItem(item,idx)
end


function UISubAct_longhuxiangyao_Win:refreshItem(item,idx)
local data=self.rewardDatatList[idx]
local state=data.state
local dec=data.targetDec

item:SetChildText(0,dec)

local showFinishSign=state==RewardState.eRecved
item:SetChildActive(3,showFinishSign)


local showBtn=state~=RewardState.eRecved
item:SetChildActive(2,showBtn)

item:SetChildButtonClick(2,function()
self:onReward(idx,state==RewardState.eRecv)
end)


item:SetChildActive(5,false)

if state==RewardState.eRecv then
item:SetChildText(6,"领取")
item:SetChildGray(2,false)
elseif state==RewardState.eNotRecv then
item:SetChildText(6,"未完成")
item:SetChildGray(2,true)
end

local showLockSing=state==RewardState.eNotRecv
item:SetChildActive(4,false)
end




function UISubAct_longhuxiangyao_Win:refreshBossInfo()

local monsterGroupId=self.curMonGroupId
local monlevel=self.monlevel
local params=comHelper.getMonsterGroupModelParams(monsterGroupId)
local mcfg=cfgHelper.get1(cfg_monstergroup_get,monsterGroupId)
local assetname=_bossTips[mcfg.monType]

self.infoRoot:setActive(true)

self.TitleTx:setText("围攻妖兽")

self.IconKuang:setSprite(_abName,_bossKuang[mcfg.monType])
comHelper.setChildModelRawImage_monsterGroup(self.winlua,monsterGroupId,self.IconImg:getID(),0,eHeadCenterType.eHead)

self.NameTx:setText(mcfg.name)

self.RequirementTx:setText(monlevel and FMT.fmt("境界：{0}",UIDiscipleModel.getJJNameCommon(monlevel,3))or"")

self.bossTips:setActive(assetname~=nil)
if assetname then
self.bossTips:setSprite(_abName,_bossTips[mcfg.monType])
end

self.DescTx:setText(mcfg.desc or"")

self:refreshBossReawrd()

self:refreshBossSkill()

end


function UISubAct_longhuxiangyao_Win:refreshBossReawrd()
local monsterGroupId=self.curMonGroupId

local monlevel=self.monlevel
self.items,self.detail=worldFightModel:getMonsterShowAwards(monsterGroupId,monlevel)
self.actRewards=worldFightModel:getMonsterExtraDropActReward(monsterGroupId)
local showItemCount=0
if self.items and next(self.items)then
local showNormalItemCount=#self.ItemCmps-#self.actRewards
if showNormalItemCount<0 then
showNormalItemCount=0
end
local rewardData,isActReward,show,showCountBG,gailv,itemShowCount,conf,item_data,propData
for i,v in ipairs(self.ItemCmps)do
rewardData=self.items and self.items[i]
isActReward=false
if i>showNormalItemCount then
rewardData=self.actRewards and self.actRewards[i-showNormalItemCount]
isActReward=true


end
show=rewardData~=nil
v:setActive(show)
if show then
showItemCount=showItemCount+1
showCountBG=false
gailv=(rewardData[3]~=nil and rewardData[3]==1)or rewardData[2]<0

itemShowCount=rewardData.showCount
if rewardData[2]>1 or(itemShowCount and itemShowCount>1)or rewardData.range then
showCountBG=true
end

conf={
showname=false,
showcount=(itemShowCount and itemShowCount>1)or rewardData[2]>1,
showCountBG=showCountBG,
showStageBg=true,
range=rewardData.range
}
item_data={
itemid=rewardData[1],
itemcount=itemShowCount or rewardData[2]
}
propData=itemsComponentHelper.getCommonFillData(item_data,conf)
propData[PropIndex(DataPropKey.eWidgetActive,8)]=gailv
propData[PropIndex(DataPropKey.eWidgetActive,9)]=propData[PropIndex(DataPropKey.eWidgetText,6)]~=""
v:setChildPropData(propData)
end
end
self.RewardTips:setText("")
else
self.RewardTips:setText("该敌人身上没有任何有价值的道具")
for i,v in ipairs(self.ItemCmps)do
v:setActive(false)
end
end
local enable=showItemCount>4
self.winlua:SetChildScrollRectEnable(self.ItemScrollView:getID(),enable)
self.ItemList:setChildAnchoredPosition(Vector2.zero)
end


function UISubAct_longhuxiangyao_Win:refreshBossSkill()
local monsterGroupId=self.curMonGroupId
local mcfg=cfgHelper.get1(cfg_monstergroup_get,monsterGroupId)

local skillList=mcfg.showSkills or{}
self.skillList:setChildLayoutGroupCreateItems(#skillList,function(index)
local skillItem=self.skillList:getChildLayoutGroupGridItem(index-1)
local skillData=skillList[index]
local skillID=skillData[1]
local skillLv=skillData[2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
skillItem:SetChildActive(-1,true)

skillItem:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),false)

local is_bd=skillModel.isSkillBD(skillCfg.skillType)
skillItem:SetChildActive(1,is_bd)

skillItem:SetChildButtonClick(3,function()
local x=-427+(index-1)*81
local y=-305
local center=Vector2.one*0.5
local leftBottom=Vector2.zero
local args={
skillId=skillID,
skillLv=skillLv,
rootPoint={
anchorsMin=center,
anchorsMax=center,
pivot=leftBottom,
anchoredPosition=Vector2.New(-138,-88)
}
}
UIManager:showWindow('UISimpleSkillTipsWin',args)
end)
end)
end



function UISubAct_longhuxiangyao_Win:handldConfig()
local monster=self.config.monster
local lookUp={}
local maxDay=0

for i,v in ipairs(monster)do
if lookUp[v[1]]then
table.insert(lookUp[v[1]],v)
else
lookUp[v[1]]={}
table.insert(lookUp[v[1]],v)
if v[1]>maxDay then
maxDay=v[1]
end
end
end
return monster,lookUp,maxDay
end

function UISubAct_longhuxiangyao_Win:handldConfig2()
local rewards=self.config.rewards
local temp={}
local temp2={}

for i,v in ipairs(rewards)do
if v[1]~=0 then
temp[#temp+1]={rewardIdx=i,monIndex=v[1],rewardList=v[2]}
else
temp2.rewardIdx=i
temp2.rewardList=v[2]
end
end
return temp,temp2
end

function UISubAct_longhuxiangyao_Win:getDayIndex()
local len=0
for k,v in pairs(self.monsterCfglookup)do
if self.day>k then
len=len+#v
end
end
local index=self.monsterIndex-len
return index
end


function UISubAct_longhuxiangyao_Win:getState(index)
if self.stageIsFinish then
return challengeItemState.eUnLock
end
if index==self.curIndex then
return challengeItemState.eChallenged
end
return index>self.curIndex and challengeItemState.eLock or challengeItemState.eUnLock
end

function UISubAct_longhuxiangyao_Win:getModelState(isPlay)
if self.stageIsFinish and not isPlay then
return modelState.eNot
end

local index=isPlay and self.curIndex-1 or self.curIndex
if self.stageIsFinish then
index=self.monsterLen
end
if index<=0 then
return modelState.eMon3
end
return modelStateTemp[index]
end

function UISubAct_longhuxiangyao_Win:getAnimStateList()
local lastIndex=self.curIndex-1
if self.stageIsFinish then
lastIndex=self.monsterLen
end
if lastIndex<=0 then
return{}
end
return animStateTemp[lastIndex]
end


function UISubAct_longhuxiangyao_Win:getItemCfg(index)
local state=self:getState(index)
local monsterGroupId=self.showMonsterCfg[index][2]
local params=comHelper.getMonsterGroupModelParams(monsterGroupId)
local mcfg=cfgHelper.get1(cfg_monstergroup_get,monsterGroupId)
local temp={}
if state==challengeItemState.eLock then
temp.iconIndex=challengeItemCmpIndex.lockIcon
temp.iconName=lockiconName[mcfg.monType]
temp.abName="ui/windows/activities/sub_longhuxiangyao/longhuxiangyao_atlas_pak.ab"
elseif state==challengeItemState.eUnLock then
temp.iconIndex=challengeItemCmpIndex.unlockIcon
temp.iconName="image_longhuxiangyaoui_3"
temp.abName="ui/windows/activities/sub_longhuxiangyao/longhuxiangyao_atlas_pak.ab"
elseif state==challengeItemState.eChallenged then
temp.iconIndex=challengeItemCmpIndex.challengedIcon
temp.iconName=params.icon_head
temp.abName=FMT.fmt("ui/icons/monsterhead/sharedtextures/{0}.ab",params.icon_head)
end
return temp
end




function UISubAct_longhuxiangyao_Win:onGoodItemClick(itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
end
end

function UISubAct_longhuxiangyao_Win:onReward(idx,flag)
if flag then
local data=self.rewardDatatList[idx]
call_activitiesHandle_func("activitiesHandle_longhuxiangyao","reqReward",self.actID,self.subid,data.rewardIdx)
else
UIManager.info("目标未完成")
end
end


function UISubAct_longhuxiangyao_Win:closeBossInfo()
self.infoRoot:setActive(false)
end

function UISubAct_longhuxiangyao_Win:onClick(index)
local state=self:getState(index)
if state==challengeItemState.eLock then
UIManager.info("请先击败当前敌人")
elseif state==challengeItemState.eUnLock then

elseif state==challengeItemState.eChallenged then
self:refreshBossInfo()
end
end

function UISubAct_longhuxiangyao_Win:onDetailBtn()
UIManager:showWindow("UIDetailDropWin",{detail=self.detail,actRewards=self.actRewards})
end

function UISubAct_longhuxiangyao_Win:onRewardEnterBtn()
self:refreshRewardList()
end

function UISubAct_longhuxiangyao_Win:onChallengeBtn()
if self.stageIsFinish then

return
end

local monsterGroupId=self.curMonGroupId
local mcfg=cfgHelper.get(cfg_monstergroup_get,monsterGroupId)
local actID=self.actID
local subid=self.subid
local monsterIndex=self.monsterIndex+1
fightController.showPrepareWin(fightPreSelectModel.fightType.longhuxiangyao,
{
enterTxt='龙虎降妖',
skipDiscipleInjuryCheck=false,
skipDiscipleStateCheck=false,
skipShouYuanCheck=false,
isHomeBattle=true,
monsterList=mcfg.monList,
groupId=monsterGroupId,
cancelCallBack=function()
call_activitiesHandle_func("activitiesHandle_longhuxiangyao","OpenActivityMainWin",actID,subid)
end,
enterCallBack=function(guidList,zfId)
fightLaunchController:sendFight(eBattleLaunch.longhuxiangyao,guidList,mcfg.mapId or 0,zfId,{actID,SUB_ACTIVITY_TYPE.eLongHuXiangYao,subid,monsterIndex})
end
})
end

function UISubAct_longhuxiangyao_Win:onRewardListcloseBtn()
self.rewardListFlag=false
self.rewardList:setActive(false)
self.croot:setChildDOScale(0,0.1,nil)
end

function UISubAct_longhuxiangyao_Win:onRewardListback()
self.rewardListFlag=false
self.rewardList:setActive(false)
self.croot:setChildDOScale(0,0.1,nil)
end

function UISubAct_longhuxiangyao_Win:onRewardItemClick()
local state=self.sub_actInfo:getRewardState()
if state==RewardState.eRecv then
call_activitiesHandle_func("activitiesHandle_longhuxiangyao","reqReward",self.actID,self.subid,self.swReward.rewardIdx)
else
local swRewardList=self.swReward.rewardList
local itemCfg=swRewardList[1]
local itemid=itemCfg[1]
itemsComponentHelper.onItemClick(itemid)
end
end





function UISubAct_longhuxiangyao_Win:newDay()

if self.stageIsFinish then
local curday=self.sub_actInfo:getStart2NowDay()


if self.day~=curday and self.monsterCfglookup[curday]then
local func=function()
if self and not self.isClose then
local argtable={}
argtable.act_id=self.actID
argtable.sub_act_type=self.subType
argtable.sub_act_id=self.subid
self:onShow(argtable)
end
end
loadingControl.openCloud(func,nil,true)
end
end
end



