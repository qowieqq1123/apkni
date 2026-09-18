







def_class("UIWDCQMainWin",UIWindowBase)









function UIWDCQMainWin:bindComponents()

self.championBg=UIObject.get(self,0)
self.championBg1=UIObject.get(self,1)
self.championBg2=UIObject.get(self,2)
self.championEffect=UIObject.get(self,3)
self.championgroupItem_1=UIObject.get(self,4)
self.championRoot=UIObject.get(self,5)
self.closeBtn=UIButton.get(self,6)
self.comboCtrl=UIButton.get(self,7)
self.comboScrollView=UIComboScrollView.get(self,8)
self.eightBg=UIObject.get(self,9)
self.eightgroupItem_1=UIObject.get(self,10)
self.eightgroupItem_2=UIObject.get(self,11)
self.eightgroupItem_3=UIObject.get(self,12)
self.eightgroupItem_4=UIObject.get(self,13)
self.eightRoot=UIObject.get(self,14)
self.gameListBtn=UIButton.get(self,15)
self.gameListBtnReddot=UIObject.get(self,16)
self.gameStageImg=UIImage.get(self,17)
self.gameStageTip=UIText.get(self,18)
self.gameStageTipRoot=UIObject.get(self,19)
self.group16Tab_1=UIObject.get(self,20)
self.group16Tab_2=UIObject.get(self,21)
self.group32Tab_1=UIObject.get(self,22)
self.group32Tab_2=UIObject.get(self,23)
self.group32Tab_3=UIObject.get(self,24)
self.group32Tab_4=UIObject.get(self,25)
self.groupItem16Content=UIObject.get(self,26)
self.groupItem16ScrollView=UIObject.get(self,27)
self.groupItem32Content=UIObject.get(self,28)
self.groupItem32ScrollView=UIObject.get(self,29)
self.honorBtn=UIButton.get(self,30)
self.honorBtnReddot=UIObject.get(self,31)
self.insertPanelBg=UIObject.get(self,32)
self.noInGameTip=UIText.get(self,33)
self.noRank=UIText.get(self,34)
self.noRewadTips=UIText.get(self,35)
self.prepareBtn=UIButton.get(self,36)
self.prepareBtnReddot=UIObject.get(self,37)
self.prepareStageImg=UIImage.get(self,38)
self.prepareTips=UIText.get(self,39)
self.prepareTipsRoot=UIObject.get(self,40)
self.rankTips=UIText.get(self,41)
self.rankTitle=UIText.get(self,42)
self.reddot=UIObject.get(self,43)
self.rewardBtn=UIButton.get(self,44)
self.rewardBtnReddot=UIObject.get(self,45)
self.rewardContent=UIObject.get(self,46)
self.rewardScrollView=UIObject.get(self,47)
self.semiBg=UIObject.get(self,48)
self.semigroupItem_1=UIObject.get(self,49)
self.semigroupItem_2=UIObject.get(self,50)
self.semiRoot=UIObject.get(self,51)
self.shopBtn=UIButton.get(self,52)
self.shopBtnReddot=UIObject.get(self,53)
self.sixteenBg=UIObject.get(self,54)
self.sixteengroupItem_1=UIObject.get(self,55)
self.sixteengroupItem_2=UIObject.get(self,56)
self.sixteengroupItem_3=UIObject.get(self,57)
self.sixteengroupItem_4=UIObject.get(self,58)
self.sixteengroupItem_5=UIObject.get(self,59)
self.sixteengroupItem_6=UIObject.get(self,60)
self.sixteengroupItem_7=UIObject.get(self,61)
self.sixteengroupItem_8=UIObject.get(self,62)
self.sixteenRoot=UIObject.get(self,63)
self.sugBtn=UIButton.get(self,64)
self.thirdBg=UIObject.get(self,65)
self.thirdBg1=UIObject.get(self,66)
self.thirdBg2=UIObject.get(self,67)
self.thirdEffect=UIObject.get(self,68)
self.thirdgroupItem_1=UIObject.get(self,69)
self.thirdRoot=UIObject.get(self,70)
self.thitrtyTwoBg=UIObject.get(self,71)
self.thitrtyTwogroupItem_1=UIObject.get(self,72)
self.thitrtyTwogroupItem_10=UIObject.get(self,73)
self.thitrtyTwogroupItem_11=UIObject.get(self,74)
self.thitrtyTwogroupItem_12=UIObject.get(self,75)
self.thitrtyTwogroupItem_13=UIObject.get(self,76)
self.thitrtyTwogroupItem_14=UIObject.get(self,77)
self.thitrtyTwogroupItem_15=UIObject.get(self,78)
self.thitrtyTwogroupItem_16=UIObject.get(self,79)
self.thitrtyTwogroupItem_2=UIObject.get(self,80)
self.thitrtyTwogroupItem_3=UIObject.get(self,81)
self.thitrtyTwogroupItem_4=UIObject.get(self,82)
self.thitrtyTwogroupItem_5=UIObject.get(self,83)
self.thitrtyTwogroupItem_6=UIObject.get(self,84)
self.thitrtyTwogroupItem_7=UIObject.get(self,85)
self.thitrtyTwogroupItem_8=UIObject.get(self,86)
self.thitrtyTwogroupItem_9=UIObject.get(self,87)
self.thitrtyTwoRoot=UIObject.get(self,88)
self.timeTip=UIText.get(self,89)
self.timeTipRoot=UIObject.get(self,90)
self.tipsBtn=UIButton.get(self,91)
self.changeBtn=UIButton.get(self,92)
self.dropDownGroupRoot=UIObject.get(self,93)
self.dropDownStageRoot=UIObject.get(self,94)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.comboCtrl:setButtonClick(function()self:onComboCtrl()end)

self.gameListBtn:setButtonClick(function()self:onGameListBtn()end)

self.honorBtn:setButtonClick(function()self:onHonorBtn()end)

self.prepareBtn:setButtonClick(function()self:onPrepareBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.shopBtn:setButtonClick(function()self:onShopBtn()end)

self.sugBtn:setButtonClick(function()self:onSugBtn()end)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)

self.changeBtn:setButtonClick(function()self:onChangeBtn()end)
self.championgroupItem={
self.championgroupItem_1,
}
self.eightgroupItem={
self.eightgroupItem_1,
self.eightgroupItem_2,
self.eightgroupItem_3,
self.eightgroupItem_4,
}
self.group16Tab={
self.group16Tab_1,
self.group16Tab_2,
}
self.group32Tab={
self.group32Tab_1,
self.group32Tab_2,
self.group32Tab_3,
self.group32Tab_4,
}
self.semigroupItem={
self.semigroupItem_1,
self.semigroupItem_2,
}
self.sixteengroupItem={
self.sixteengroupItem_1,
self.sixteengroupItem_2,
self.sixteengroupItem_3,
self.sixteengroupItem_4,
self.sixteengroupItem_5,
self.sixteengroupItem_6,
self.sixteengroupItem_7,
self.sixteengroupItem_8,
}
self.thirdgroupItem={
self.thirdgroupItem_1,
}
self.thitrtyTwogroupItem={
self.thitrtyTwogroupItem_1,
self.thitrtyTwogroupItem_2,
self.thitrtyTwogroupItem_3,
self.thitrtyTwogroupItem_4,
self.thitrtyTwogroupItem_5,
self.thitrtyTwogroupItem_6,
self.thitrtyTwogroupItem_7,
self.thitrtyTwogroupItem_8,
self.thitrtyTwogroupItem_9,
self.thitrtyTwogroupItem_10,
self.thitrtyTwogroupItem_11,
self.thitrtyTwogroupItem_12,
self.thitrtyTwogroupItem_13,
self.thitrtyTwogroupItem_14,
self.thitrtyTwogroupItem_15,
self.thitrtyTwogroupItem_16,
}



end


function UIWDCQMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.championBg);self.championBg=nil;
_UIObject_release(self.championBg1);self.championBg1=nil;
_UIObject_release(self.championBg2);self.championBg2=nil;
_UIObject_release(self.championEffect);self.championEffect=nil;
_UIObject_release(self.championgroupItem_1);self.championgroupItem_1=nil;
_UIObject_release(self.championRoot);self.championRoot=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.comboCtrl);self.comboCtrl=nil;
_UIObject_release(self.comboScrollView);self.comboScrollView=nil;
_UIObject_release(self.eightBg);self.eightBg=nil;
_UIObject_release(self.eightgroupItem_1);self.eightgroupItem_1=nil;
_UIObject_release(self.eightgroupItem_2);self.eightgroupItem_2=nil;
_UIObject_release(self.eightgroupItem_3);self.eightgroupItem_3=nil;
_UIObject_release(self.eightgroupItem_4);self.eightgroupItem_4=nil;
_UIObject_release(self.eightRoot);self.eightRoot=nil;
_UIObject_release(self.gameListBtn);self.gameListBtn=nil;
_UIObject_release(self.gameListBtnReddot);self.gameListBtnReddot=nil;
_UIObject_release(self.gameStageImg);self.gameStageImg=nil;
_UIObject_release(self.gameStageTip);self.gameStageTip=nil;
_UIObject_release(self.gameStageTipRoot);self.gameStageTipRoot=nil;
_UIObject_release(self.group16Tab_1);self.group16Tab_1=nil;
_UIObject_release(self.group16Tab_2);self.group16Tab_2=nil;
_UIObject_release(self.group32Tab_1);self.group32Tab_1=nil;
_UIObject_release(self.group32Tab_2);self.group32Tab_2=nil;
_UIObject_release(self.group32Tab_3);self.group32Tab_3=nil;
_UIObject_release(self.group32Tab_4);self.group32Tab_4=nil;
_UIObject_release(self.groupItem16Content);self.groupItem16Content=nil;
_UIObject_release(self.groupItem16ScrollView);self.groupItem16ScrollView=nil;
_UIObject_release(self.groupItem32Content);self.groupItem32Content=nil;
_UIObject_release(self.groupItem32ScrollView);self.groupItem32ScrollView=nil;
_UIObject_release(self.honorBtn);self.honorBtn=nil;
_UIObject_release(self.honorBtnReddot);self.honorBtnReddot=nil;
_UIObject_release(self.insertPanelBg);self.insertPanelBg=nil;
_UIObject_release(self.noInGameTip);self.noInGameTip=nil;
_UIObject_release(self.noRank);self.noRank=nil;
_UIObject_release(self.noRewadTips);self.noRewadTips=nil;
_UIObject_release(self.prepareBtn);self.prepareBtn=nil;
_UIObject_release(self.prepareBtnReddot);self.prepareBtnReddot=nil;
_UIObject_release(self.prepareStageImg);self.prepareStageImg=nil;
_UIObject_release(self.prepareTips);self.prepareTips=nil;
_UIObject_release(self.prepareTipsRoot);self.prepareTipsRoot=nil;
_UIObject_release(self.rankTips);self.rankTips=nil;
_UIObject_release(self.rankTitle);self.rankTitle=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rewardBtnReddot);self.rewardBtnReddot=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.semiBg);self.semiBg=nil;
_UIObject_release(self.semigroupItem_1);self.semigroupItem_1=nil;
_UIObject_release(self.semigroupItem_2);self.semigroupItem_2=nil;
_UIObject_release(self.semiRoot);self.semiRoot=nil;
_UIObject_release(self.shopBtn);self.shopBtn=nil;
_UIObject_release(self.shopBtnReddot);self.shopBtnReddot=nil;
_UIObject_release(self.sixteenBg);self.sixteenBg=nil;
_UIObject_release(self.sixteengroupItem_1);self.sixteengroupItem_1=nil;
_UIObject_release(self.sixteengroupItem_2);self.sixteengroupItem_2=nil;
_UIObject_release(self.sixteengroupItem_3);self.sixteengroupItem_3=nil;
_UIObject_release(self.sixteengroupItem_4);self.sixteengroupItem_4=nil;
_UIObject_release(self.sixteengroupItem_5);self.sixteengroupItem_5=nil;
_UIObject_release(self.sixteengroupItem_6);self.sixteengroupItem_6=nil;
_UIObject_release(self.sixteengroupItem_7);self.sixteengroupItem_7=nil;
_UIObject_release(self.sixteengroupItem_8);self.sixteengroupItem_8=nil;
_UIObject_release(self.sixteenRoot);self.sixteenRoot=nil;
_UIObject_release(self.sugBtn);self.sugBtn=nil;
_UIObject_release(self.thirdBg);self.thirdBg=nil;
_UIObject_release(self.thirdBg1);self.thirdBg1=nil;
_UIObject_release(self.thirdBg2);self.thirdBg2=nil;
_UIObject_release(self.thirdEffect);self.thirdEffect=nil;
_UIObject_release(self.thirdgroupItem_1);self.thirdgroupItem_1=nil;
_UIObject_release(self.thirdRoot);self.thirdRoot=nil;
_UIObject_release(self.thitrtyTwoBg);self.thitrtyTwoBg=nil;
_UIObject_release(self.thitrtyTwogroupItem_1);self.thitrtyTwogroupItem_1=nil;
_UIObject_release(self.thitrtyTwogroupItem_10);self.thitrtyTwogroupItem_10=nil;
_UIObject_release(self.thitrtyTwogroupItem_11);self.thitrtyTwogroupItem_11=nil;
_UIObject_release(self.thitrtyTwogroupItem_12);self.thitrtyTwogroupItem_12=nil;
_UIObject_release(self.thitrtyTwogroupItem_13);self.thitrtyTwogroupItem_13=nil;
_UIObject_release(self.thitrtyTwogroupItem_14);self.thitrtyTwogroupItem_14=nil;
_UIObject_release(self.thitrtyTwogroupItem_15);self.thitrtyTwogroupItem_15=nil;
_UIObject_release(self.thitrtyTwogroupItem_16);self.thitrtyTwogroupItem_16=nil;
_UIObject_release(self.thitrtyTwogroupItem_2);self.thitrtyTwogroupItem_2=nil;
_UIObject_release(self.thitrtyTwogroupItem_3);self.thitrtyTwogroupItem_3=nil;
_UIObject_release(self.thitrtyTwogroupItem_4);self.thitrtyTwogroupItem_4=nil;
_UIObject_release(self.thitrtyTwogroupItem_5);self.thitrtyTwogroupItem_5=nil;
_UIObject_release(self.thitrtyTwogroupItem_6);self.thitrtyTwogroupItem_6=nil;
_UIObject_release(self.thitrtyTwogroupItem_7);self.thitrtyTwogroupItem_7=nil;
_UIObject_release(self.thitrtyTwogroupItem_8);self.thitrtyTwogroupItem_8=nil;
_UIObject_release(self.thitrtyTwogroupItem_9);self.thitrtyTwogroupItem_9=nil;
_UIObject_release(self.thitrtyTwoRoot);self.thitrtyTwoRoot=nil;
_UIObject_release(self.timeTip);self.timeTip=nil;
_UIObject_release(self.timeTipRoot);self.timeTipRoot=nil;
_UIObject_release(self.tipsBtn);self.tipsBtn=nil;
_UIObject_release(self.changeBtn);self.changeBtn=nil;
_UIObject_release(self.dropDownGroupRoot);self.dropDownGroupRoot=nil;
_UIObject_release(self.dropDownStageRoot);self.dropDownStageRoot=nil;
self.championgroupItem=nil;
self.eightgroupItem=nil;
self.group16Tab=nil;
self.group32Tab=nil;
self.semigroupItem=nil;
self.sixteengroupItem=nil;
self.thirdgroupItem=nil;
self.thitrtyTwogroupItem=nil;
end


















local _this

local mainItemIndex=
{
btn=0,
select=1,
name=2,
reddot=3,
txtImg=4,
}

local subItemIndex=
{
btn=0,
select=1,
name=2,
reddot=3,
txtImg=4,
}

local sixteenGroudTabCmpIndex=
{
bg=0,
select=1,
txt=2,
reddot=3,
click=4,
}

local thirtyTwoGroudTabCmpIndex=
{
bg=0,
select=1,
txt=2,
reddot=3,
click=4,
}

local matchItemCmpIndex={
bg=0,
effect=1,
hotTxt=2,
guessBtn=3,
preBg=4,
playerRoot1=5,
playerRoot2=6,
timeDownBg=7,
overBg=8,
time=9,
noPe=10,
hotRoot=11,
fightBg=12,
model=13,
fightingModel=14,
guessEffect=15,
enterBtn=16,
reddot=17,
}

local playerItemCmpIndex={
bg=0,
winFlag=1,
headKuang=2,
headIocn=3,
selfSerFlag=4,
name=5,
failFlag=6,
selfFlag=7,
noPeo=8,
severBg=9,
severName=10,
zan=11,
headBg=12,
headClick=13,
nopeobg=14,
}

local sixteenPageNum=2
local smooting=5
local sixteenPageLenth=1/((sixteenPageNum-1)==1 and 1 or(sixteenPageNum-1))
local thirtyTwoPageNum=4
local thirtyTwoPageLenth=1/((thirtyTwoPageNum-1)==1 and 1 or(thirtyTwoPageNum-1))

local abName="ui/windows/wendingcangqiong/wdcq_atlas_pak.ab"
local txtImageList=
{
["凡修组"]="image_wdcqwz_1",
["地仙组"]="image_wdcqwz_2",
["天尊组"]="image_wdcqwz_3",
["帝君组"]="image_wdcqwz_4",

["32强赛"]="image_wdcqszwz_1",
["16强赛"]="image_wdcqszwz_2",
["8强赛"]="image_wdcqszwz_3",
["4强赛"]="image_wdcqszwz_4",
["半决赛"]="image_wdcqszwz_5",
["季军赛"]="image_wdcqszwz_6",
["冠军赛"]="image_wdcqszwz_7",
}

function UIWDCQMainWin:onLoaded(...)
_this=self
self:bindComponents()
self.rootListCfg={
[WDCQCGameStageEnum.eSixteen]={cmpRoot=self.thitrtyTwoRoot,itemList=self.thitrtyTwogroupItem,bgList={self.thitrtyTwoBg},bgModelList={5556},itemModel=5557,bgPos={x=-149,y=84},fightModel=5587},
[WDCQCGameStageEnum.eEighth]={cmpRoot=self.sixteenRoot,itemList=self.sixteengroupItem,bgList={self.sixteenBg},bgModelList={5556},itemModel=5557,bgPos={x=-149,y=84},fightModel=5587},
[WDCQCGameStageEnum.eFourth]={cmpRoot=self.eightRoot,itemList=self.eightgroupItem,bgList={self.eightBg},bgModelList={5556},itemModel=5557,bgPos={x=-149,y=84},fightModel=5587},
[WDCQCGameStageEnum.eSemi]={cmpRoot=self.semiRoot,itemList=self.semigroupItem,bgList={self.semiBg},bgModelList={5580},itemModel=5558,bgPos={x=-149,y=84},fightModel=5587},
[WDCQCGameStageEnum.eThird]={cmpRoot=self.thirdRoot,itemList=self.thirdgroupItem,bgList={self.thirdBg,self.thirdBg1,self.thirdBg2},bgModelList={5566,5565,5564},itemModel=5582,bgPos={x=0,y=0},fightModel=5587},
[WDCQCGameStageEnum.eChampion]={cmpRoot=self.championRoot,itemList=self.championgroupItem,bgList={self.championBg,self.championBg1,self.championBg2},bgModelList={5566,5565,5564},itemModel=5582,bgPos={x=0,y=0},fightModel=5587},
}

self.thirdEffect:setChildShowEffect(20443,true)
self.championEffect:setChildShowEffect(20443,true)
for k,v in pairs(self.rootListCfg)do
for ii,vv in ipairs(v.bgList)do
local bg=vv
bg:setChildUIModelShowTarget(v.bgModelList[ii],1,nil,eAnimationID.stand)
end
for ii,vv in ipairs(v.itemList)do
local widget=vv:getChildWidgetBase()
widget:SetChildUIModelShowTarget(matchItemCmpIndex.model,v.itemModel,0.4,nil,eAnimationID.stand)
widget:SetChildAnchoredPos(matchItemCmpIndex.bg,v.bgPos.x,v.bgPos.y)
widget:SetChildUIModelShowTarget(matchItemCmpIndex.fightingModel,v.fightModel,1,nil,eAnimationID.stand)
end
end








self.winlua:SetChildUIDragEvent(self.groupItem16ScrollView:getID(),0,self.beginDrag16Callback,self.endDrag16Callback,nil)
self.winlua:SetChildUIDragEvent(self.groupItem32ScrollView:getID(),0,self.beginDrag32Callback,self.endDrag32Callback,nil)

self.group16TabWidget={}
for i,v in ipairs(self.group16Tab)do
local widget=v:getChildWidgetBase()
self.group16TabWidget[i]=widget
widget:SetChildButtonClick(sixteenGroudTabCmpIndex.click,function()
self:onClickSixteenGroudTab(i)
end)
end


self.group32TabWidget={}
for i,v in ipairs(self.group32Tab)do
local widget=v:getChildWidgetBase()
self.group32TabWidget[i]=widget
widget:SetChildButtonClick(thirtyTwoGroudTabCmpIndex.click,function()
self:onClickThirtyTwoGroudTab(i)
end)
end

self.selfActorId=playerModel:getActorID()

self:showWindow("UIWDCQDanMuWin")
end


function UIWDCQMainWin:__delete()
self:stopAllTimer()
if self.prepareTipTweener~=nil then
self.prepareTipTweener:Complete()
self.prepareTipTweener:Kill()
self.prepareTipTweener=nil
end
self:unbindComponents()
self.rootListCfg=nil
self.tabList=nil
self.selectIndex=nil
self.group16TabWidget=nil
self.group32TabWidget=nil
self.gameInfo=nil
self.lastexpandIdnex=nil
self.expandIdnex=nil
_this=nil
end




function UIWDCQMainWin:onShow(argtable,afterOnloaded)
self.gameInfo=WDCQController.getActorGameInfo(self.selfActorId)
if self.gameInfo then
self.otherActorId=self.gameInfo.rivalActorId
end
self:stopAllTimer()
self.tabList=WDCQController.getTabList()
for i,v in ipairs(self.tabList)do
if v.tabEnum==WDCQCTabEnum.eGroup then
for i2,v2 in ipairs(v.child)do
local groupId=v2.subTabEnum
local stageId=WDCQController.getGroupStage(groupId)
if stageId~=WDCQCGameStageEnum.eNone and stageId~=WDCQCGameStageEnum.eGameFinish then
local macthList=WDCQModel:getData_MacthList(groupId,stageId)
if macthList then
for i3,v3 in ipairs(macthList)do
local idx=i3
local macthstage=WDCQController.getMacthStage(groupId,stageId,idx)
if macthstage==WDCQCMatchStageEnum.ePreTheGame or macthstage==WDCQCMatchStageEnum.eTimeDown then
WDCQController.req_38_8(groupId,stageId,idx)
end
end
end
end
end
end
end

local selfGroupId,selfStageId,subGoupId
if not self.selectIndex and not self.sixteenGroudTabIndex and not self.thirtyTwoGroudTabIndex then
if argtable and argtable.groupId and argtable.stageId then
selfGroupId=argtable.groupId
selfStageId=argtable.stageId
subGoupId=argtable.subGoupId or 1
else
if self.gameInfo then
local gameInfo=WDCQController.getActorGameInfo(self.selfActorId)
self.otherActorId=gameInfo.rivalActorId
selfGroupId=gameInfo.groupId

subGoupId=gameInfo.subGoupId
else
for i,v in ipairs(self.tabList)do
if v.tabEnum==WDCQCTabEnum.eGroup then
selfGroupId=v.child[#v.child].subTabEnum
end
end
end
selfStageId=WDCQController.getGroupStage(selfGroupId)
if selfStageId==WDCQCGameStageEnum.eGameFinish then
selfStageId=WDCQCGameStageEnum.eChampion
elseif selfStageId==WDCQCGameStageEnum.eNone then
local currtime=gameUtilityModel.getServerShortTime()
local startTime=WDCQController.getGameStartTime()
local endTime=WDCQController.getGameEnterEndTime()

if currtime<startTime then
selfStageId=WDCQCGameStageEnum.eSixteen
elseif currtime<=endTime then
selfStageId=WDCQCGameStageEnum.eChampion
elseif currtime>endTime then
selfStageId=WDCQCGameStageEnum.eSixteen
end
end
end

self.sixteenGroudTabIndex=1
self.thirtyTwoGroudTabIndex=1
if selfStageId==WDCQCGameStageEnum.eSixteen then
self.thirtyTwoGroudTabIndex=subGoupId or 1
elseif selfStageId==WDCQCGameStageEnum.eEighth then
self.sixteenGroudTabIndex=subGoupId or 1
end

else
selfGroupId=self.selectIndex[WDCQCTabEnum.eGroup]
selfStageId=self.selectIndex[WDCQCTabEnum.eStage]
end


for i,v in ipairs(self.tabList)do
if v.tabEnum==WDCQCTabEnum.eGroup then
local maxTab=v.child[#v.child].subTabEnum
local flag=false
for i2,v2 in ipairs(v.child)do
if v2.subTabEnum==selfGroupId then
flag=true
break
end
end
if not flag then
selfGroupId=maxTab
end
end
end
self.selectIndex={
[WDCQCTabEnum.eGroup]=selfGroupId,
[WDCQCTabEnum.eStage]=selfStageId,
}





self:initDropDown()
self:onClickSixteenGroudTab(self.sixteenGroudTabIndex)
self:onClickThirtyTwoGroudTab(self.thirtyTwoGroudTabIndex)

self:refreshGameStageTip()
self:refreshRoot()
self:refreshBottom()
self:refreshPrepareBtn()
local hasSubWin=false
if argtable and argtable.showPreWin then
hasSubWin=true
self:showWindow("UIWDCQPreGameWin",argtable)
end

if argtable and argtable.showLiveWin then
wdcqLiveBroadcastRoomController:enterLiveRoom(argtable.groupId,argtable.stageId,argtable.idx)
end

if argtable and argtable.showGuessWin then
hasSubWin=true

self:showWindow("UIWDCQGuessWin",argtable)
end
if not hasSubWin then
loadingControl.closeCloud()
end
self:startTimer()
local curGroupId=self.selectIndex[WDCQCTabEnum.eGroup]
WDCQController.checkShowGuessResult(curGroupId)

self:refreshTestWin()
end


function UIWDCQMainWin:onHide()
self:onComboCtrl()
self:stopAllTimer()
if self.prepareTipTweener~=nil then
self.prepareTipTweener:Complete()
self.prepareTipTweener:Kill()
self.prepareTipTweener=nil
end
self:clearAllTweener()

self.lastexpandIdnex=nil
self.expandIdnex=nil
end

function UIWDCQMainWin:onShowArgRecv(argtable)
self:onShow(argtable)
end

function UIWDCQMainWin:stopAllTimer()
if self.startTimerId then
self:stopTimerByID(self.startTimerId)
self.startTimerId=nil
end
end

function UIWDCQMainWin:startTimer()
local func=function()
self:refreshGameStageTip()
self:checkItemStateChange()
self:refreshPrepareBtn(true)
end
self.startTimerId=self:setTimer(1,0,func)
end

function UIWDCQMainWin:DataRecv()
UIManager:invokeUIMethod("UIWDCQDanMuWin","checkShowDanMu")
self:onShow()





end


function UIWDCQMainWin:checkItemStateChange()
local curGroupId=self.selectIndex[WDCQCTabEnum.eGroup]
local curStage=self.selectIndex[WDCQCTabEnum.eStage]
local roundListCfg=WDCQController.getRoundListCfg(curGroupId,curStage)
local idx,roundCfg
local curtime=gameUtilityModel.getServerShortTime()
if roundListCfg and next(roundListCfg)then
for i,v in ipairs(roundListCfg)do
idx=i
roundCfg=v
if self:checkrefreshTrigger(curGroupId,curStage,idx,roundCfg,curtime)then

self:refreshMacthItem(curGroupId,curStage,idx)
end
end
end
end

function UIWDCQMainWin:checkrefreshTrigger(groupEnum,stageEnum,idx,roundCfg,curTime)
for k,v in pairs(roundCfg)do
if type(v)=="table"then
for i,v2 in ipairs(v)do
for k3,v3 in pairs(v2)do
if curTime==v3 then
return true,k,k3
end
end
end
else
if curTime==v then
return true,k
end
end

end
return false






















































end


function UIWDCQMainWin:refreshMacthItem(groupId,stageId,idx)
local curGroupId=self.selectIndex[WDCQCTabEnum.eGroup]
local curStage=self.selectIndex[WDCQCTabEnum.eStage]
if curGroupId~=groupId or curStage~=stageId then
return
end
local itemList=self.rootListCfg[stageId].itemList
local item=itemList[idx]
self:setMacthItem(item,groupId,stageId,idx)
end





function UIWDCQMainWin:refreshBottom()
self.rankTitle:setActive(true)
if not self.gameInfo then
self.noRank:setActive(true)
self.noRewadTips:setActive(true)

self.rankTips:setActive(false)
self.rewardContent:setChildLayoutGroupClearAllItems()
self.rewardScrollView:setActive(false)
return
end

self.noRank:setActive(false)
self.noRewadTips:setActive(false)

self.rankTips:setActive(true)
self.rewardScrollView:setActive(true)
local rankTips=WDCQController.getActorRankName(self.selfActorId)
self.rankTips:setText(rankTips)
local rewards=WDCQController.getRankRewards(self.selfActorId)
if rewards then
self.rewardContent:setChildLayoutGroupCreateItems(#rewards,function(index)
local item=self.rewardContent:getChildLayoutGroupGridItem(index-1)
local data=rewards[index]
widgetHelper.setNormalRewardItem(item,0,data)
end)
end
end

function UIWDCQMainWin:refreshPrepareBtn(recvFlag,actor_id)
if not self.gameInfo then
self.prepareBtn:setActive(false)
return
end
local selfActorId=self.selfActorId
local gameInfo=WDCQController.getActorGameInfo(self.selfActorId)
self.otherActorId=gameInfo.rivalActorId
local selfGroupId=gameInfo.groupId
local selfStageId=gameInfo.stageId
local idx=gameInfo.idx
local posEnum=gameInfo.posEnum
local hasRival=WDCQController.checkMacthRival(selfGroupId,selfStageId,idx)
local macthStage,preStage,adjustStage=WDCQController.getMacthStage(selfGroupId,selfStageId,idx)

if macthStage==WDCQCMatchStageEnum.ePreTheGame and hasRival then
local otherActorId=self.otherActorId









self.prepareBtn:setActive(true)
self.prepareStageImg:setCSImageSprite(abName,"image_wdcqszwz_8")
if preStage==WDCQCPreGameStageEnum.eNone then
self.prepareTipsRoot:setActive(false)
return
end

if preStage==WDCQCPreGameStageEnum.eAdjustTeam and not WDCQController.checkAdjustTeamPos(adjustStage,posEnum)then
self.prepareTipsRoot:setActive(false)
return
end
if recvFlag then
if actor_id and self.reqList then
self.reqList[mathHelper.int64_to_string(actor_id)]=nil
if next(self.reqList)then
return
end
end
else
self.reqList={}
WDCQController.req_38_2(selfActorId)
self.reqList[mathHelper.int64_to_string(selfActorId)]=true
if otherActorId then
WDCQController.req_38_2(otherActorId)
self.reqList[mathHelper.int64_to_string(otherActorId)]=true
end
return
end








local flag,tips=WDCQController.checkPreStageFlag(selfActorId,preStage,adjustStage,otherActorId)
if flag then
self.prepareTipsRoot:setActive(false)
else
self.prepareTipsRoot:setActive(true)
if self.prepareTipTweener==nil then
local tweener=self.prepareTipsRoot:setChildDOLocalMoveY(94.5,0.6)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Yoyo)
self.prepareTipTweener=tweener
end
self.prepareTips:setText(tips)
end
elseif macthStage==WDCQCMatchStageEnum.eTimeDown or macthStage==WDCQCMatchStageEnum.eInTheGame or macthStage==WDCQCMatchStageEnum.eEndTheGame or not hasRival then
self.prepareBtn:setActive(true)
self.prepareStageImg:setCSImageSprite(abName,"image_wdcqszwz_9")
self.prepareTipsRoot:setActive(false)
else
self.prepareBtn:setActive(false)
end
end

function UIWDCQMainWin:refreshFun(stage,itemList)
local groupId=self.selectIndex[WDCQCTabEnum.eGroup]
local stageId=stage
local idx
for i,v in ipairs(itemList)do
idx=i
self:setMacthItem(v,groupId,stageId,idx)
end
end

function UIWDCQMainWin:setMacthItem(item,groupId,stageId,idx)
local widget=item:getChildWidgetBase()
local needshowEnter=self:checkShowEnter(groupId,stageId,idx)
widget:SetChildActive(matchItemCmpIndex.enterBtn,needshowEnter)
if needshowEnter then
widget:SetChildButtonClick(matchItemCmpIndex.bg,function()
self:onClickMatchItem(groupId,stageId,idx)
end)
widget:SetChildButtonClick(matchItemCmpIndex.enterBtn,function()
self:onClickMatchItem(groupId,stageId,idx)
end)
widget:SetChildActive(matchItemCmpIndex.reddot,WDCQController:checkMatchReddot(groupId,stageId,idx))
end
local macthStage=WDCQController.getMacthStage(groupId,stageId,idx)
local hasRival=WDCQController.checkMacthRival(groupId,stageId,idx)

if not hasRival then
if macthStage==WDCQCMatchStageEnum.ePreTheGame then
macthStage=WDCQCMatchStageEnum.eTimeDown
elseif macthStage==WDCQCMatchStageEnum.eInTheGame then
macthStage=WDCQCMatchStageEnum.eEndTheGame
end
end
widget:SetChildActive(matchItemCmpIndex.preBg,macthStage==WDCQCMatchStageEnum.ePreTheGame)
widget:SetChildActive(matchItemCmpIndex.timeDownBg,macthStage==WDCQCMatchStageEnum.eTimeDown)
widget:SetChildActive(matchItemCmpIndex.overBg,macthStage==WDCQCMatchStageEnum.eEndTheGame)
widget:SetChildActive(matchItemCmpIndex.noPe,macthStage==WDCQCMatchStageEnum.eNone)
widget:SetChildActive(matchItemCmpIndex.fightBg,macthStage==WDCQCMatchStageEnum.eInTheGame)
if stageId==WDCQCGameStageEnum.eChampion or stageId==WDCQCGameStageEnum.eThird then
local color=Color.New(1,1,1,0)
widget:SetChildColor(matchItemCmpIndex.preBg,color)
widget:SetChildColor(matchItemCmpIndex.timeDownBg,color)
widget:SetChildColor(matchItemCmpIndex.overBg,color)

widget:SetChildColor(matchItemCmpIndex.fightBg,color)
end
if macthStage==WDCQCMatchStageEnum.eNone then
widget:SetChildActive(matchItemCmpIndex.effect,false)
widget:SetChildActive(matchItemCmpIndex.guessBtn,false)
widget:SetChildActive(matchItemCmpIndex.hotRoot,false)
widget:SetChildActive(matchItemCmpIndex.playerRoot1,false)
widget:SetChildActive(matchItemCmpIndex.playerRoot2,false)
widget:SetChildActive(matchItemCmpIndex.guessEffect,false)
return
end
if macthStage==WDCQCMatchStageEnum.eTimeDown then
local roundCfgTemp=WDCQController.getRoundCfg(groupId,stageId,idx)
local roundStartTime=roundCfgTemp.startTime
local syear,smonth,sday,shour,smin,ssec=timeHelper.getServerStampData(timeHelper.convertLongStamp(roundStartTime))
widget:SetChildText(matchItemCmpIndex.time,FMT.fmt(smin~=0 and"{0}时{1}分对决"or"{0}时对决",shour,smin))
end


local playerData1=WDCQController.getPlayerData(groupId,stageId,idx,1)
local playerData2=WDCQController.getPlayerData(groupId,stageId,idx,2)
local showGuess=playerData1 and playerData2
if showGuess then
widget:SetChildActive(matchItemCmpIndex.guessBtn,true)
widget:SetChildActive(matchItemCmpIndex.hotRoot,true)
widget:SetChildButtonClick(matchItemCmpIndex.guessBtn,function()
self:onClickGuessBtn(groupId,stageId,idx)
end)
local guessFlag=WDCQController.checkGuessFlag(groupId,stageId,idx)
widget:SetChildCSImageSprite(matchItemCmpIndex.guessBtn,abName,guessFlag and"button_wdcqui_8"or"button_wdcqui_4")
local hotCount=WDCQController.getHotCount(groupId,stageId,idx)
widget:SetChildText(matchItemCmpIndex.hotTxt,hotCount)
if macthStage==WDCQCMatchStageEnum.eEndTheGame then
widget:SetChildActive(matchItemCmpIndex.guessEffect,false)
else
local effectId,effectpos,effectScale=self:getEffectCfg(stageId,hotCount)
if not effectId or effectId==0 then
widget:SetChildActive(matchItemCmpIndex.guessEffect,false)
else
widget:SetChildActive(matchItemCmpIndex.guessEffect,true)
widget:SetChildScale(matchItemCmpIndex.guessEffect,Vector3.New(effectScale.Sx,effectScale.Sy,1))
widget:SetChildAnchoredPos(matchItemCmpIndex.guessEffect,effectpos.x,effectpos.y)
widget:SetChildShowEffect(matchItemCmpIndex.guessEffect,effectId,true)
end

end

else
widget:SetChildActive(matchItemCmpIndex.guessBtn,false)
widget:SetChildActive(matchItemCmpIndex.hotRoot,false)
widget:SetChildActive(matchItemCmpIndex.guessEffect,false)
end
widget:SetChildActive(matchItemCmpIndex.playerRoot1,true)
widget:SetChildActive(matchItemCmpIndex.playerRoot2,true)
local playerWidget1=widget:GetChildWidgetBase(matchItemCmpIndex.playerRoot1)
local playerWidget2=widget:GetChildWidgetBase(matchItemCmpIndex.playerRoot2)
self:setPlayerInfo(playerWidget1,playerData1,stageId,macthStage,groupId,idx)
self:setPlayerInfo(playerWidget2,playerData2,stageId,macthStage,groupId,idx)
end


function UIWDCQMainWin:setPlayerInfo(playerWidget,playerData,stageId,macthStage,groupId,idx)
local showServerInfo=stageId==WDCQCGameStageEnum.eThird or stageId==WDCQCGameStageEnum.eChampion
local isLose=playerData and mathHelper.validInt64(playerData.actorId)and playerData.name==''
playerWidget:SetChildActive(playerItemCmpIndex.severBg,showServerInfo)
playerWidget:SetChildActive(playerItemCmpIndex.bg,true)
playerWidget:SetChildActive(playerItemCmpIndex.name,true)
playerWidget:SetChildActive(playerItemCmpIndex.nopeobg,false)
if not playerData then
playerWidget:SetChildActive(playerItemCmpIndex.headBg,true)
playerWidget:SetChildActive(playerItemCmpIndex.noPeo,true)
playerWidget:SetChildActive(playerItemCmpIndex.headKuang,true)
playerWidget:SetChildText(playerItemCmpIndex.name,"暂无对手")
playerWidget:SetChildText(playerItemCmpIndex.severName,"暂无信息")
if showServerInfo then
playerWidget:SetChildActive(playerItemCmpIndex.nopeobg,true)
playerWidget:SetChildActive(playerItemCmpIndex.severBg,false)
playerWidget:SetChildActive(playerItemCmpIndex.bg,false)
playerWidget:SetChildActive(playerItemCmpIndex.name,false)
end

playerWidget:SetChildActive(playerItemCmpIndex.headIocn,false)
playerWidget:SetChildActive(playerItemCmpIndex.headClick,false)
playerWidget:SetChildActive(playerItemCmpIndex.selfSerFlag,false)
playerWidget:SetChildActive(playerItemCmpIndex.failFlag,false)
playerWidget:SetChildActive(playerItemCmpIndex.selfFlag,false)
playerWidget:SetChildActive(playerItemCmpIndex.zan,false)
return
else
playerWidget:SetChildActive(playerItemCmpIndex.headBg,false)
playerWidget:SetChildActive(playerItemCmpIndex.headIocn,true)
playerWidget:SetChildActive(playerItemCmpIndex.headClick,true)
playerController:setHeadIcon(playerWidget,playerItemCmpIndex.headIocn,{iconInfo=playerData.iconInfo,scale=HEAD_SCALE_TYPE.e60x60})
playerWidget:SetChildButtonClick(playerItemCmpIndex.headClick,function()
self:onClickHead(playerData.actorId)
end)
end
local isSelfFlag=playerData.actorId==self.selfActorId
playerWidget:SetChildActive(playerItemCmpIndex.selfFlag,isSelfFlag)
local serverId=playerData.serverId
local isSelfServerFlag=loginModel:isMySameServerZoneByServerID(serverId)
if isSelfFlag then
playerWidget:SetChildActive(playerItemCmpIndex.selfSerFlag,false)
else
playerWidget:SetChildActive(playerItemCmpIndex.selfSerFlag,isSelfServerFlag)
end
if macthStage==WDCQCMatchStageEnum.eEndTheGame and WDCQController.checkHasWinActorId(groupId,stageId,idx)then
local winFlag=playerData.winFlag
playerWidget:SetChildActive(playerItemCmpIndex.failFlag,false)
playerWidget:SetChildActive(playerItemCmpIndex.winFlag,winFlag)
else
playerWidget:SetChildActive(playerItemCmpIndex.failFlag,false)
playerWidget:SetChildActive(playerItemCmpIndex.winFlag,false)
end
local surportFlag=playerData.surportFlag
playerWidget:SetChildActive(playerItemCmpIndex.zan,surportFlag)
local serverName=loginModel:getServerName(playerData.serverId)
playerWidget:SetChildText(playerItemCmpIndex.severName,FMT.fmt("<color=#{0}>[{1}]</color>",isSelfFlag and"aae252"or"ECECEC",serverName))
playerWidget:SetChildText(playerItemCmpIndex.name,FMT.fmt("<color=#{0}>{1}</color>",isSelfFlag and"aae252"or"ECECEC",playerModel:getOtherActorName(playerData.name)))

if isLose then
playerWidget:SetChildActive(playerItemCmpIndex.headBg,true)
playerWidget:SetChildActive(playerItemCmpIndex.noPeo,true)
playerWidget:SetChildActive(playerItemCmpIndex.headKuang,true)
playerWidget:SetChildActive(playerItemCmpIndex.headIocn,false)
end
end

function UIWDCQMainWin:onClickHead(actorId)
WDCQController:reqShowWDCQZRInfo(actorId)
end

function UIWDCQMainWin:onClickMatchItem(groupId,stageId,idx)

wdcqLiveBroadcastRoomController:enterLiveRoom(groupId,stageId,idx)
end

function UIWDCQMainWin:onClickGuessBtn(groupId,stageId,idx)

UIManager:showWindow("UIWDCQGuessWin",{groupId=groupId,stageId=stageId,idx=idx})
end

function UIWDCQMainWin:refreshGameStageTip()
local groupId=self.selectIndex[WDCQCTabEnum.eGroup]
local stageId=WDCQController.getGroupStage(groupId)
if stageId==WDCQCGameStageEnum.eNone or stageId==WDCQCGameStageEnum.eGameFinish then
self.gameStageTipRoot:setActive(false)
self.timeTipRoot:setActive(false)
self.noInGameTip:setActive(true)
local txt=""
local currtime=gameUtilityModel.getServerShortTime()
local startTime=WDCQController.getGameStartTime()
local endTime=WDCQController.getGameEnterEndTime()

if currtime<startTime then
local startTime=WDCQController.getGameStartTime()
local syear,smonth,sday,shour,smin,ssec=timeHelper.getServerStampData(timeHelper.convertLongStamp(startTime))
txt=FMT.fmt('{0}月{1}日开启',smonth,sday)
elseif currtime<=endTime then
txt="比赛已结束"
elseif currtime>endTime then
local nextStartTime=WDCQController.getNextGameStartTime()
local syear,smonth,sday,shour,smin,ssec=timeHelper.getServerStampData(timeHelper.convertLongStamp(nextStartTime))
txt=FMT.fmt('{0}月{1}日开启',smonth,sday)
end
self.noInGameTip:setText(txt)
else
self.gameStageTipRoot:setActive(true)
self.timeTipRoot:setActive(true)
self.noInGameTip:setActive(false)
self.gameStageImg:setCSImageSprite(abName,txtImageList[WDCQCGameStageNmae[stageId]])
local tips=WDCQController.getGroupStageTimeTips(groupId)
if tips then
self.timeTipRoot:setActive(true)
self.timeTip:setText(tips)
else
self.timeTipRoot:setActive(false)
end
end
end


function UIWDCQMainWin:refreshRoot()
local data
for i,v in ipairs(self.tabList)do
if v.tabEnum==WDCQCTabEnum.eStage then
data=v
break
end
end
if not data then
return
end
local gameState=self.selectIndex[WDCQCTabEnum.eStage]


for i,v in ipairs(data.child or{})do
local cmpRoot=self.rootListCfg[v.subTabEnum].cmpRoot
local bgList=self.rootListCfg[v.subTabEnum].bgList

for ii,vv in ipairs(bgList)do
local bg=vv
bg:setActive(i==gameState)
end

if i==gameState then
cmpRoot:setActive(true)
local itemList=self.rootListCfg[v.subTabEnum].itemList
self:refreshFun(v.subTabEnum,itemList)
else
cmpRoot:setActive(false)
end
end
end

function UIWDCQMainWin.beginDrag16Callback()
_this.isDrag16=true
local posX=_this.winlua:GetChildScrollRectNormalizedPosition(_this.groupItem16ScrollView:getID(),true)
_this.drag16PosX=posX
end

function UIWDCQMainWin.beginDrag32Callback()
_this.isDrag32=true
local posX=_this.winlua:GetChildScrollRectNormalizedPosition(_this.groupItem32ScrollView:getID(),true)
_this.drag32PosX=posX
end


function UIWDCQMainWin.endDrag16Callback()
_this.isDrag16=false
local posX=_this.winlua:GetChildScrollRectNormalizedPosition(_this.groupItem16ScrollView:getID(),true)
local index=_this.sixteenGroudTabIndex
local offset=posX-_this.drag16PosX
if offset>0.05 then
index=_this.sixteenGroudTabIndex+1
elseif offset<-0.05 then
index=_this.sixteenGroudTabIndex-1
end
if index<1 then
index=1
end
if index>sixteenPageNum then
index=sixteenPageNum
end

_this.sixteenGroudTabIndex=index
_this:onClickSixteenGroudTab(index)
end

function UIWDCQMainWin.endDrag32Callback()
_this.isDrag32=false
local posX=_this.winlua:GetChildScrollRectNormalizedPosition(_this.groupItem32ScrollView:getID(),true)
local index=_this.thirtyTwoGroudTabIndex
local offset=posX-_this.drag32PosX
if offset>0.05 then
index=_this.thirtyTwoGroudTabIndex+1
elseif offset<-0.05 then
index=_this.thirtyTwoGroudTabIndex-1
end
if index<1 then
index=1
end
if index>thirtyTwoPageNum then
index=thirtyTwoPageNum
end

_this.thirtyTwoGroudTabIndex=index
_this:onClickThirtyTwoGroudTab(index)
end


function UIWDCQMainWin:mainClickAction(mainItem)
local oldMainIndex=self.mainIndex
local index=mainItem.Index+1
if index==oldMainIndex then
return
end
self.mainIndex=index
end

function UIWDCQMainWin:subClickAction(subItem)
local subIndex=subItem.Index+1
local mainIndex=subItem.Mainindex+1
local data=self.tabList[mainIndex]
local tabEnum=data.tabEnum
local new=self:getComboSubTab(tabEnum,subIndex)
local old=self.selectIndex[tabEnum]
self.comboScrollView:clickItem(mainIndex-1)
if new==old then
return
end
self.selectIndex[tabEnum]=new
local mainItem=self.comboScrollView:getMainItem(mainIndex-1)
local name=data.name
if data.child and data.child[subIndex]then
name=data.child[subIndex].name
end

mainItem:SetChildCSImageSprite(mainItemIndex.txtImg,abName,txtImageList[name])
self:refreshRoot()
self:refreshGameStageTip()
end

function UIWDCQMainWin:mainCreateAction(mainItem)
local index=mainItem.Index+1
local data=self.tabList[index]
if data then
local tabEnum=data.tabEnum
local subTab=self.selectIndex[tabEnum]
local name=self:getComboSubTabNmae(tabEnum,subTab)





mainItem:SetChildCSImageSprite(mainItemIndex.txtImg,abName,txtImageList[name])

if data.child then
mainItem:SetAddExpandColumCount(#data.child)
else
mainItem:SetAddExpandColumCount(0)
end
local reddot=false
local reddotCheck=data.reddot
if reddotCheck then
reddot=reddotCheck(self.selectIndex[WDCQCTabEnum.eGroup])
end
mainItem:SetChildActive(mainItemIndex.reddot,reddot)
end
end


function UIWDCQMainWin:subCreateAction(subItem)
local index=subItem.Index+1
local mainIndex=subItem.Mainindex+1
local data=self.tabList[mainIndex]
if data then
if data.child then
local cData=data.child[index]
local tabEnum=data.tabEnum


subItem:SetChildCSImageSprite(subItemIndex.txtImg,abName,txtImageList[cData.name])
local new=self:getComboSubTab(tabEnum,index)
subItem:SetChildActive(subItemIndex.select,new==self.selectIndex[tabEnum])

local reddot=false
if cData then
local reddotCheck=cData.reddot
if reddotCheck then
reddot=reddotCheck(self.selectIndex[WDCQCTabEnum.eGroup],cData.subTabEnum)
end
end
subItem:SetChildActive(subItemIndex.reddot,reddot)
end
end


end


function UIWDCQMainWin:onExpandAction(index)


self.comboCtrl:setActive(index>=0)
local delay=false
local delayTime=0
if index>=0 then
if self.lastexpandIdnex and self.lastexpandIdnex~=index then
delayTime=0.3
end
self.lastexpandIdnex=index
end

if self.expandIdnex then
local mainItem=self.comboScrollView:getMainItem(self.expandIdnex)
mainItem:SetChildActive(mainItemIndex.select,false)
self.expandIdnex=nil
self.insertPanelBg:setChildDOScaleY(0,0.25)
delay=true
end
if index>=0 then
local mainItem=self.comboScrollView:getMainItem(index)
mainItem:SetChildActive(mainItemIndex.select,true)
self.expandIdnex=index
end

if index>=0 then
local mainIndex=index+1
local mainItemH=55
local mainItemSpace=5
local subItemH=55
local subItemSpace=5
local subItemOffet=5
local data=self.tabList[mainIndex]
local len=#data.child
local x=0
local y=-(mainIndex*mainItemH+mainItemSpace*(mainIndex-1)-35)
local w=184
local h=len*subItemH+subItemSpace*(len-1)+len*subItemOffet+35+5

if delay then
self:delayDo(0.25,function()
self.insertPanelBg:setChildAnchoredPos(x,y)
self.insertPanelBg:setChildSizeDelta(w,h)
self.insertPanelBg:setChildDOScaleY(1,0.3)
end)
else
self.insertPanelBg:setChildAnchoredPos(x,y)
self.insertPanelBg:setChildSizeDelta(w,h)

if delayTime>0 then
self:delayDo(delayTime,function()
self.insertPanelBg:setChildDOScaleY(1,0.3)
end)
else
self.insertPanelBg:setChildDOScaleY(1,0.3)
end

end




else
self.insertPanelBg:setChildDOScaleY(0,0.25)
end
end





function UIWDCQMainWin:onCloseBtn()
fullScreenUI.closeActiveUI()
end

function UIWDCQMainWin:onComboCtrl()



if self.comboOpenFlag then
for i,v in ipairs(self.comboOpenFlag)do
if v then
self:doAni(i,false)
end
end
end
end

function UIWDCQMainWin:onShopBtn()
funcShopController:openShopWin({shopId=eFuncShopType.eWenDingCangQiong})
end

function UIWDCQMainWin:onRewardBtn()
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.wdcqMC,{})
end

function UIWDCQMainWin:refreshHonorReddot()
self.honorBtnReddot:setActive(WDCQController.checkHonorReddot())
end

function UIWDCQMainWin:onHonorBtn()
UIManager:showWindow('UILDRongYuTongWin',{ftype=3})
end

function UIWDCQMainWin:onPrepareBtn()

if not self.gameInfo then
return
end
local gameInfo=WDCQController.getActorGameInfo(self.selfActorId)
self.otherActorId=gameInfo.rivalActorId
local selfGroupId=gameInfo.groupId
local selfStageId=gameInfo.stageId
local idx=gameInfo.idx
local posEnum=gameInfo.posEnum
local hasRival=WDCQController.checkMacthRival(selfGroupId,selfStageId,idx)
if hasRival then
local selectGroupId=self.selectIndex[WDCQCTabEnum.eGroup]
local selectStageId=self.selectIndex[WDCQCTabEnum.eStage]
local args={}
args.groupId=selectGroupId
args.stageId=selectStageId
local subGoupId=1
if selectStageId==WDCQCGameStageEnum.eSixteen then
subGoupId=self.thirtyTwoGroudTabIndex
elseif selectStageId==WDCQCGameStageEnum.eEighth then
subGoupId=self.sixteenGroudTabIndex
end
args.subGoupId=subGoupId
self:showWindow("UIWDCQPreGameWin",args)



else
UIManager.info("本轮暂无对手，直接晋级")
end
end

function UIWDCQMainWin:onTipsBtn()


local ruleList={}
table.insert(ruleList,{mode=3,name='wdcq_main_help_%s',btnTxt="对战规则",title="对战规则",})
table.insert(ruleList,{mode=3,name='wdcq_pre_help_%s',btnTxt="赛前规则",title="赛前规则",})
table.insert(ruleList,{mode=3,name='wdcq_guess_help_%s',btnTxt="竞猜规则",title="竞猜规则",})
local args={}
args.ruleList=ruleList
args.showBlack=true

UIManager:showWindow('UIRuleListWin',args)
end

function UIWDCQMainWin:onChangeBtn()
UIFullWenDingCangQiongControl:showHaiXuanWin({loading=true})
end



function UIWDCQMainWin:onGameListBtn()

if not WDCQController.checkInTheGame()then
return
end

local args={
parentWin=self,
group=self.selectIndex[WDCQCTabEnum.eGroup],
}
self:showWindow("UIWDCQScheduleWin",args)
end

function UIWDCQMainWin:onSugBtn()

local systemIndexType=UISettingModel:getSystemIndexType()
UIManager:showWindow("UITestTagBtnWin",{systemId=systemIndexType.WengDingCangQiong,})
end

function UIWDCQMainWin:refreshTestWin()
local checkReddot
local systemIndexType=UISettingModel:getSystemIndexType()
local checkBtn=UISettingModel:checkIsOpenTest(systemIndexType.WengDingCangQiong)

if not checkBtn then
UIManager:invokeUIMethod("UITestTagBtnWin",'closeWin')
else
checkReddot=UISettingModel:checkTestTagReddot(systemIndexType.WengDingCangQiong)
self.winlua:SetChildActive(self.reddot:getID(),checkReddot)
end

self.winlua:SetChildActive(self.sugBtn:getID(),checkBtn)
end

function UIWDCQMainWin:onClickSixteenGroudTab(tabIndex)
for i,v in ipairs(self.group16Tab)do
local widget=self.group16TabWidget[i]
if tabIndex==i then
widget:SetChildActive(sixteenGroudTabCmpIndex.select,true)
else
widget:SetChildActive(sixteenGroudTabCmpIndex.select,false)
end
end
local targetHor=sixteenPageLenth*(tabIndex-1)
_this.winlua:SetChildScrollRectNormalizedPosTo(_this.groupItem16ScrollView:getID(),targetHor,smooting,0,0,nil)
end

function UIWDCQMainWin:onClickThirtyTwoGroudTab(tabIndex)
for i,v in ipairs(self.group32Tab)do
local widget=self.group32TabWidget[i]
if tabIndex==i then
widget:SetChildActive(thirtyTwoGroudTabCmpIndex.select,true)
else
widget:SetChildActive(thirtyTwoGroudTabCmpIndex.select,false)
end
end
local targetHor=thirtyTwoPageLenth*(tabIndex-1)
_this.winlua:SetChildScrollRectNormalizedPosTo(_this.groupItem32ScrollView:getID(),targetHor,smooting,0,0,nil)
end

function UIWDCQMainWin:getComboSubTab(tabEnum,subIdnex)
for i,v in ipairs(self.tabList)do
if v.tabEnum==tabEnum and v.child and v.child[subIdnex]then
return v.child[subIdnex].subTabEnum
end
end
end

function UIWDCQMainWin:getComboSubTabNmae(tabEnum,subTab)
for i,v in ipairs(self.tabList)do
if v.tabEnum==tabEnum and v.child then
for i2,v2 in ipairs(v.child)do
if v2.subTabEnum==subTab then
return v2.name
end
end
end
end
end

function UIWDCQMainWin:getEffectCfg(stage,cnt)
local guessEffectCfg=cfgHelper.get2(cfg_wendingcangqiongconfig_get,1,'guessEffectCfg')








local cfg=guessEffectCfg[stage]
if not cfg then
logErr(FMT.fmt("没有阶段{0}的特效配置",stage))
end
local range=cfg.range
local index=0
for i,v in ipairs(range)do
if v[2]~=-1 then
if v[1]<=cnt and cnt<=v[2]then
index=i
break
end
else
if v[1]<=cnt then
index=i
break
end
end
end
local effectId=cfg.effectId
local effectPos=cfg.effectPos
local effectScale=cfg.effectScale
return effectId[index],effectPos[index],effectScale[index]
end

function UIWDCQMainWin:checkShowEnter(groupId,stageId,idx)
local room_conf=cfgHelper.get3(cfg_wendingcangqiongmatchconfig_get,groupId,stageId,"room_conf")
if room_conf~=1 then
return false
end
if stageId==WDCQCGameStageEnum.eChampion or stageId==WDCQCGameStageEnum.eThird then
local macthStage=WDCQController.getMacthStage(groupId,stageId,idx)
local hasRival=WDCQController.checkMacthRival(groupId,stageId,idx)
if not hasRival then
return false
end
if macthStage==WDCQCMatchStageEnum.eNone then
return false
end
if WDCQController.checkInTheGame2()then
local cPhase=WDCQController.getServerGroupStage(groupId)
if cPhase>WDCQCGameStageEnum.eNone and cPhase<stageId then
return false
end
return true
end

end

return false
end

function UIWDCQMainWin:refreshAllComboReddot()
local mainItemList=self.comboScrollView:getMainItemsList()
for i=1,mainItemList.Count do
local mainItem=mainItemList[i-1]
local index=mainItem.Index+1
local data=self.tabList[index]
if data then
local reddot=false
local reddotCheck=data.reddot
if reddotCheck then
reddot=reddotCheck(self.selectIndex[WDCQCTabEnum.eGroup])
end
mainItem:SetChildActive(mainItemIndex.reddot,reddot)
end
end
local subItemList=self.comboScrollView:getSubItemsList()
for i=1,subItemList.Count do
local subItem=subItemList[i-1]
local mainIndex=subItem.Mainindex+1
local data=self.tabList[mainIndex]
if data then
if data.child then
local cData=data.child[i]
local reddot=false
if cData then
local reddotCheck=cData.reddot
if reddotCheck then
reddot=reddotCheck(cData.subTabEnum)
end
end
subItem:SetChildActive(subItemIndex.reddot,reddot)
end
end
end
end



local CmpDropDownWidgetIndex={
scrollView=0,
list=1,
selectItem=2,
open=3,
selectIcon=4,
scrollViewEx=5,
}


local _dropOptiongroupItemHeight=82
local _dropOptionItemHeight=55
local _dropOptionListTopPadding=5
local _dropOptionListBottonPadding=30
local _dropOptionListSpacing=5
local _dropOptionScrollViewWidth=184


local _aniMoveDuration=0.2

local mainItemIndex={
eGroup=1,
eStage=2,
}

function UIWDCQMainWin:initDropDown()
self.comboCfg={
[mainItemIndex.eGroup]={
tab=WDCQCTabEnum.eGroup,
isGroup=true,
widget=self.dropDownGroupRoot:getWidgetBase(),
otherIndex=mainItemIndex.eStage,
hideFunc=function(callback)
self:hideGroupListList(callback)
end,
openFunc=function(callback)
self:playOpenGroupListAni(callback)
end,
data=self.tabList[mainItemIndex.eGroup],
aniCmpList={
{CmpDropDownWidgetIndex.scrollView,self:caculateGroupDropListHeight(),_aniMoveDuration},
{CmpDropDownWidgetIndex.scrollViewEx,self:caculateGroupDropListHeight()-27.5,_aniMoveDuration}
}
},
[mainItemIndex.eStage]={
tab=WDCQCTabEnum.eStage,
isGroup=true,
widget=self.dropDownStageRoot:getWidgetBase(),
otherIndex=mainItemIndex.eGroup,
hideFunc=function(callback)
self:hideStageListList(callback)
end,
openFunc=function(callback)
self:playOpenStageListAni(callback)
end,
data=self.tabList[mainItemIndex.eStage],
aniCmpList={
{CmpDropDownWidgetIndex.scrollView,self:caculateStageDropListHeight(),_aniMoveDuration}
}
}
}
self.comboOpenFlag={
[mainItemIndex.eGroup]=false,
[mainItemIndex.eStage]=false
}
for i,v in ipairs(self.comboCfg)do
local widget=v.widget
widget:SetChildButtonClick(CmpDropDownWidgetIndex.selectItem,function()
if self.comboOpenFlag[i]then
v.hideFunc()
else
if self.comboOpenFlag[v.otherIndex]then
self.comboCfg[v.otherIndex].hideFunc(v.openFunc)
else
v.openFunc()
end
end
end)
end
self:refreshSelectItem()
self:refreshSubItemList()

end


function UIWDCQMainWin:refreshSelectItem()
for i,v in ipairs(self.comboCfg)do
local widget=v.widget
local cubSelectTab=self.selectIndex[v.tab]
local tabNmae=self:getComboSubTabNmae(v.tab,cubSelectTab)
widget:SetChildCSImageSprite(CmpDropDownWidgetIndex.selectIcon,abName,txtImageList[tabNmae])
end
end

function UIWDCQMainWin:refreshSubItemList()
for i,v in ipairs(self.comboCfg)do
local widget=v.widget
local data=v.data
local num=#data.child
local createFunc=function(index)
local subItem=widget:GetChildLayoutGroupGridItem(CmpDropDownWidgetIndex.list,index-1)
local cData=data.child[index]
subItem:SetChildCSImageSprite(0,abName,txtImageList[cData.name])

if i==mainItemIndex.eGroup then
subItem:SetChildText(1,cData.tips)
end

subItem:SetBaseItemClickEvent(-1,function()
local subIndex=index
local tabEnum=data.tabEnum
local new=self:getComboSubTab(tabEnum,subIndex)
local old=self.selectIndex[tabEnum]
v.hideFunc()
if new==old then
return
end
self.selectIndex[tabEnum]=new
self:refreshSelectItem()
self:refreshRoot()
self:refreshGameStageTip()
end)
end
widget:SetChildLayoutGroupCreateItems(CmpDropDownWidgetIndex.list,num,createFunc)
end
end

function UIWDCQMainWin:clearAllTweener()
if self.tweenrList then
for i,v in ipairs(self.tweenrList)do
v:Complete()
v:Kill()
end
self.tweenrList=nil
end

end

function UIWDCQMainWin:doAni(mainIndex,openFlag,callback)
self:clearAllTweener()
local cfg=self.comboCfg[mainIndex]
local widget=cfg.widget
local aniCmpList=cfg.aniCmpList
self.tweenrList={}
for i,v in ipairs(aniCmpList)do
self.tweenrList[i]=widget:SetChildDOSizeDelta(v[1],Vector2(_dropOptionScrollViewWidth,openFlag and v[2]or 0),v[3],function()
if callback then
callback()
end
end)
end
self.comboOpenFlag[mainIndex]=openFlag
widget:SetChildActive(CmpDropDownWidgetIndex.open,openFlag)
self.comboCtrl:setActive(openFlag)
end

function UIWDCQMainWin:playOpenGroupListAni()
self:doAni(mainItemIndex.eGroup,true)
end

function UIWDCQMainWin:hideGroupListList(callback)
self:doAni(mainItemIndex.eGroup,false,callback)
end

function UIWDCQMainWin:playOpenStageListAni()
self:doAni(mainItemIndex.eStage,true)
end

function UIWDCQMainWin:hideStageListList(callback)
self:doAni(mainItemIndex.eStage,false,callback)
end

function UIWDCQMainWin:caculateGroupDropListHeight()
local data=self.tabList[mainItemIndex.eGroup]
local num=#data.child
return(num*_dropOptiongroupItemHeight)+((num-1)*_dropOptionListSpacing)+_dropOptionListTopPadding+_dropOptionListBottonPadding
end

function UIWDCQMainWin:caculateStageDropListHeight()
local data=self.tabList[mainItemIndex.eStage]
local num=#data.child
return(num*_dropOptionItemHeight)+((num-1)*_dropOptionListSpacing)+_dropOptionListTopPadding+_dropOptionListBottonPadding
end


