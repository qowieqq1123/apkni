







def_class("UIFightPrepareWin",UIWindowBase)









function UIFightPrepareWin:bindComponents()

self.autoSelectButton=UIButton.get(self,0)
self.cancelButton=UIButton.get(self,1)
self.catFight=UIObject.get(self,2)
self.catfightText=UIText.get(self,3)
self.catprogressbar=UIProgress.get(self,4)
self.catprogresstext=UIText.get(self,5)
self.catprogressValue=UIImage.get(self,6)
self.catprogressValueup=UIImage.get(self,7)
self.clearButton=UIButton.get(self,8)
self.conditionList=UIObject.get(self,9)
self.defTeamLgBg=UIImage.get(self,10)
self.defTeamLgImage=UIImage.get(self,11)
self.defTeamLgRoot=UIObject.get(self,12)
self.defTeamTips=UIObject.get(self,13)
self.dragObject=UIObject.get(self,14)
self.dzSelectTips=UIText.get(self,15)
self.dzSelectTipsRoot=UIObject.get(self,16)
self.emptySelectTx=UIText.get(self,17)
self.enemyTeamList=UIObject.get(self,18)
self.enemyTeamPanel=UIObject.get(self,19)
self.faze2contect=UIObject.get(self,20)
self.faze3contect=UIObject.get(self,21)
self.fazeBtn2=UIButton.get(self,22)
self.fazeBtn2Bg=UIButton.get(self,23)
self.fazeBtn2Reddot=UIObject.get(self,24)
self.fazeBtn3=UIButton.get(self,25)
self.fazeBtn3Bg=UIButton.get(self,26)
self.faZeList=UIObject.get(self,27)
self.faZeList2=UIObject.get(self,28)
self.faZeList3=UIObject.get(self,29)
self.faZeOne=UIObject.get(self,30)
self.fazeRoot2=UIObject.get(self,31)
self.fazeRoot2Ex=UIObject.get(self,32)
self.fazeRoot3=UIObject.get(self,33)
self.fazeRoot3Ex=UIObject.get(self,34)
self.fightDescObj_1=UIObject.get(self,35)
self.fightDescObj_2=UIObject.get(self,36)
self.fightDescTxt_1=UIText.get(self,37)
self.fightDescTxt_2=UIText.get(self,38)
self.fightText=UIText.get(self,39)
self.helpButton=UIButton.get(self,40)
self.helpButton2=UIButton.get(self,41)
self.mask=UIObject.get(self,42)
self.moneyCost=UIObject.get(self,43)
self.moneyCostCountText=UIText.get(self,44)
self.moneyCostIcon=UIImage.get(self,45)
self.monsterFightText=UIText.get(self,46)
self.multiFight=UIObject.get(self,47)
self.myzsLingLiLimitTips=UIObject.get(self,48)
self.place=UIText.get(self,49)
self.placeRoot=UIObject.get(self,50)
self.rewardPanel=UIObject.get(self,51)
self.RoleTypeListPanel=UIObject.get(self,52)
self.rwScrollView=UIObject.get(self,53)
self.ScrollerScript=UIEnhancedScrollerLua.get(self,54)
self.selectButton=UIButton.get(self,55)
self.selectText=UIText.get(self,56)
self.selfFightText=UIText.get(self,57)
self.singleFight=UIObject.get(self,58)
self.targetFightBG=UIObject.get(self,59)
self.targetFightDesc=UIText.get(self,60)
self.teamButton=UIButton.get(self,61)
self.teamList=UIObject.get(self,62)
self.titleRoot=UIObject.get(self,63)
self.titleText=UIText.get(self,64)
self.topMask=UIObject.get(self,65)
self.wayTimeBg=UIObject.get(self,66)
self.wayTimeText=UIText.get(self,67)
self.zfBtn=UIButton.get(self,68)
self.zfIcon=UIImage.get(self,69)
self.zfName=UIText.get(self,70)

self.autoSelectButton:setButtonClick(function()self:onAutoSelectButton()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.clearButton:setButtonClick(function()self:onClearButton()end)

self.fazeBtn2:setButtonClick(function()self:onFazeBtn2()end)

self.fazeBtn2Bg:setButtonClick(function()self:onFazeBtn2Bg()end)

self.fazeBtn3:setButtonClick(function()self:onFazeBtn3()end)

self.fazeBtn3Bg:setButtonClick(function()self:onFazeBtn3Bg()end)

self.helpButton:setButtonClick(function()self:onHelpButton()end)

self.helpButton2:setButtonClick(function()self:onHelpButton2()end)

self.selectButton:setButtonClick(function()self:onSelectButton()end)

self.teamButton:setButtonClick(function()self:onTeamButton()end)

self.zfBtn:setButtonClick(function()self:onZfBtn()end)
self.fightDescObj={
self.fightDescObj_1,
self.fightDescObj_2,
}
self.fightDescTxt={
self.fightDescTxt_1,
self.fightDescTxt_2,
}



end


function UIFightPrepareWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.autoSelectButton);self.autoSelectButton=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.catFight);self.catFight=nil;
_UIObject_release(self.catfightText);self.catfightText=nil;
_UIObject_release(self.catprogressbar);self.catprogressbar=nil;
_UIObject_release(self.catprogresstext);self.catprogresstext=nil;
_UIObject_release(self.catprogressValue);self.catprogressValue=nil;
_UIObject_release(self.catprogressValueup);self.catprogressValueup=nil;
_UIObject_release(self.clearButton);self.clearButton=nil;
_UIObject_release(self.conditionList);self.conditionList=nil;
_UIObject_release(self.defTeamLgBg);self.defTeamLgBg=nil;
_UIObject_release(self.defTeamLgImage);self.defTeamLgImage=nil;
_UIObject_release(self.defTeamLgRoot);self.defTeamLgRoot=nil;
_UIObject_release(self.defTeamTips);self.defTeamTips=nil;
_UIObject_release(self.dragObject);self.dragObject=nil;
_UIObject_release(self.dzSelectTips);self.dzSelectTips=nil;
_UIObject_release(self.dzSelectTipsRoot);self.dzSelectTipsRoot=nil;
_UIObject_release(self.emptySelectTx);self.emptySelectTx=nil;
_UIObject_release(self.enemyTeamList);self.enemyTeamList=nil;
_UIObject_release(self.enemyTeamPanel);self.enemyTeamPanel=nil;
_UIObject_release(self.faze2contect);self.faze2contect=nil;
_UIObject_release(self.faze3contect);self.faze3contect=nil;
_UIObject_release(self.fazeBtn2);self.fazeBtn2=nil;
_UIObject_release(self.fazeBtn2Bg);self.fazeBtn2Bg=nil;
_UIObject_release(self.fazeBtn2Reddot);self.fazeBtn2Reddot=nil;
_UIObject_release(self.fazeBtn3);self.fazeBtn3=nil;
_UIObject_release(self.fazeBtn3Bg);self.fazeBtn3Bg=nil;
_UIObject_release(self.faZeList);self.faZeList=nil;
_UIObject_release(self.faZeList2);self.faZeList2=nil;
_UIObject_release(self.faZeList3);self.faZeList3=nil;
_UIObject_release(self.faZeOne);self.faZeOne=nil;
_UIObject_release(self.fazeRoot2);self.fazeRoot2=nil;
_UIObject_release(self.fazeRoot2Ex);self.fazeRoot2Ex=nil;
_UIObject_release(self.fazeRoot3);self.fazeRoot3=nil;
_UIObject_release(self.fazeRoot3Ex);self.fazeRoot3Ex=nil;
_UIObject_release(self.fightDescObj_1);self.fightDescObj_1=nil;
_UIObject_release(self.fightDescObj_2);self.fightDescObj_2=nil;
_UIObject_release(self.fightDescTxt_1);self.fightDescTxt_1=nil;
_UIObject_release(self.fightDescTxt_2);self.fightDescTxt_2=nil;
_UIObject_release(self.fightText);self.fightText=nil;
_UIObject_release(self.helpButton);self.helpButton=nil;
_UIObject_release(self.helpButton2);self.helpButton2=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.moneyCost);self.moneyCost=nil;
_UIObject_release(self.moneyCostCountText);self.moneyCostCountText=nil;
_UIObject_release(self.moneyCostIcon);self.moneyCostIcon=nil;
_UIObject_release(self.monsterFightText);self.monsterFightText=nil;
_UIObject_release(self.multiFight);self.multiFight=nil;
_UIObject_release(self.myzsLingLiLimitTips);self.myzsLingLiLimitTips=nil;
_UIObject_release(self.place);self.place=nil;
_UIObject_release(self.placeRoot);self.placeRoot=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.RoleTypeListPanel);self.RoleTypeListPanel=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.ScrollerScript);self.ScrollerScript=nil;
_UIObject_release(self.selectButton);self.selectButton=nil;
_UIObject_release(self.selectText);self.selectText=nil;
_UIObject_release(self.selfFightText);self.selfFightText=nil;
_UIObject_release(self.singleFight);self.singleFight=nil;
_UIObject_release(self.targetFightBG);self.targetFightBG=nil;
_UIObject_release(self.targetFightDesc);self.targetFightDesc=nil;
_UIObject_release(self.teamButton);self.teamButton=nil;
_UIObject_release(self.teamList);self.teamList=nil;
_UIObject_release(self.titleRoot);self.titleRoot=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.topMask);self.topMask=nil;
_UIObject_release(self.wayTimeBg);self.wayTimeBg=nil;
_UIObject_release(self.wayTimeText);self.wayTimeText=nil;
_UIObject_release(self.zfBtn);self.zfBtn=nil;
_UIObject_release(self.zfIcon);self.zfIcon=nil;
_UIObject_release(self.zfName);self.zfName=nil;
self.fightDescObj=nil;
self.fightDescTxt=nil;
end

















local UIPrepareEnScroller=simple_class(UIEnhancedScroller)


local m_sorttypeindex=1

local selectList={}
local selectLookUp={}
local preloadList={}
local npcList={}
local selectNum=0
local selectFight=0
local maxSelect=5
local minSelect=1
local maxPos=5
local selectZF=nil
local _this=nil

local dragIndex=nil
local dragBeginData=nil
local dragEndData=nil
local dragDataIndex=nil
local dragGuid=nil
local mysteryModelQueue={}

local globalab='ui/sharedtextures/uiglobalspriteatlas_1.ab'
local imageabname='ui/windows/fight/sharedtextures/fight_prepare.ab'
local diziabname='ui/windows/disciple/sharedtextures/uidisciplecolorframeicons.ab'
local imageassetname='icon_zdtabtp_'
local catabname="ui/windows/wanbaoxunbaodui/wanbaoxunbaodui_atlas_pak.ab"
local tgslabname="ui/windows/activities/sub_taigushilian/taigushilian_atlas_pak.ab"

local ColorToFrame={
[eQualityColor.eGreen]='frame_dzkplvse',
[eQualityColor.eBlue]='frame_dzkplanse',
[eQualityColor.ePurple]='frame_dzkpzise',
[eQualityColor.eOrange]='frame_dzkpchengse',
[eQualityColor.eRed]='frame_dzkphongse',
}
local _signTypeCmp={
[dzSignType.eTianMoJie]=31
}


local sortType=
{
eDiscipleSortType.eFightSort,
eDiscipleSortType.eJingJieSort,
eDiscipleSortType.eLianTiSort,
eDiscipleSortType.eColorSort,
}

local roleItemIndex=
{
name=0,
fight=1,
stateName=2,
color=5,
tipsTx=6,
tipsBg=7,
job=8,
state=11,
npc=12,
state2=17,
teamIcon=18,
must=19,
blood=20,
bloodProgress=21,
bloodNum=22,
zanli=23,
juqing=24,
tgslflag=25,
flsybg=27,
flsytxt=28,
banFlag=29,
ban=30,
xmzs=31,
xjState=32,
xjStateName=33,
xianmoBg=34,
otherBg=35,
otherTx=36,
xingyu=37,
spDzFlag=38,
myzs=39,
myzs_hp=40,
myzs_hpbar=41,
myzs_hptxt=42,
myzs_ll=43,
myzs_lltxt=44,
myzs_death=45,
}



function UIFightPrepareWin:getLookUp(list)
local lookUp={}
for i,v in ipairs(list)do
lookUp[v]=v
end
return lookUp
end


function UIFightPrepareWin:onLoaded(...)
self:bindComponents()
_this=self
mysteryModelQueue={}

self.enhancedscrollscript=UIPrepareEnScroller(self.ScrollerScript:getGameObject(),self.ScrollerScript:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self

local _OnClickRoleSortItemCallback=function(...)
self:OnClickRoleSortItemCallback(...)
end

self.RoleTypeListPanel:setChildScrollViewInit(-1,true,_OnClickRoleSortItemCallback,nil)

selectFight=0

self.teamList:setChildAnchoredPosition(Vector2.New(0,-15))
self.teamList:setChildDOAnchorPosX(-280,0.5,nil)

self.monsterList={}
worldController:stopCameraControl()

self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)
self.teamList:setChildScrollViewInit(1,true,self.on_team_select,nil)
self.conditionList:setChildScrollViewInit(0,true,nil,nil)
self.faZeList:setChildScrollViewInit(0.5,true,nil,nil)

self:addNotify(notifyConfig.inNewbie,self.inNewbie)
end


function UIFightPrepareWin:__delete()
fightLaunchController:setPrepareFight(nil)

if self.needClosePreSelectStage then
if(not self.dontCloseStage)then
fightController:closeSelectStage()
else
fightController:clearPreEntity()
end
end




if self.isHomeBattle then
isometricMapSystem:leaveBattleMode()
end
self.winid:SetChildColor(self.topMask:getID(),Color.New(1,1,1,0))
self:setTopMask(true)
self:unbindComponents()
worldController:resumeCameraControl()
selectFight=0
selectNum=0
selectZF=nil
selectList={}
selectLookUp={}
npcList={}
preloadList={}
_this=nil

viewModeControl:exitMode()

if self.extraWin then
self:closeWindow(self.extraWin)
end
end




function UIFightPrepareWin:onShow(argtable,afterOnloaded)
local enterTxt
selectNum=0
table.clear(selectList)
selectLookUp={}

self.needClosePreSelectStage=true
self.sortTypeList=sortType

if argtable then
self.kofMode=argtable.kofMode
self.sheildParam=argtable.sheildParam
self.forceAutoSelect=argtable.forceAutoSelect
self.setteamlist_nil=argtable.setteamlist_nil
self.closeByCloud=argtable.closeByCloud or false
self.closeByCloudDelay=argtable.closeByCloudDelay
self.closeByCloudAuto=argtable.closeByCloudAuto
self.dontCloseStage=argtable.dontCloseStage
self.isFullOpen=argtable.isFullOpen
self.fightType=argtable.fightType
self.enterCallBack=argtable.enterCallBack
self.cancelCallBack=argtable.cancelCallBack
self.monsterGroupID=argtable.groupId
self.monsterList=argtable.monsterList
self.monsterListEx=argtable.monsterListEx
self.monsterFight=argtable.monsterFight
self.monsterFightEx=argtable.monsterFightEx
self.multiTitleStr=argtable.multiTitleStr
self.singleFightDescStr=argtable.singleFightDescStr
self.singleFightDescStr2=argtable.singleFightDescStr2
self.isHomeBattle=argtable.isHomeBattle

self.skipDiscipleStateCheck=argtable.skipDiscipleStateCheck

self.skipDZDispatchCheck=self.skipDiscipleStateCheck
self.skipDiscipleInjuryCheck=argtable.skipDiscipleInjuryCheck
self.skipDiscipleWuDaoRuMoCheck=argtable.skipDiscipleWuDaoRuMoCheck
self.checkSignType=argtable.checkSignType
self.skipChuiWeiCheck=argtable.skipChuiWeiCheck
self.skipShouYuanCheck=argtable.skipShouYuanCheck
self.isCheckInjuryState=argtable.isCheckInjuryState
self.isCheckVocBan=argtable.isCheckVocBan
self.isCheckXJOccupyType=argtable.isCheckXJOccupyType
self.isCheckLingShanState=argtable.isCheckLingShanState
self.cantEnter=argtable.cantEnter
self.cantEnterTips=argtable.cantEnterTips
self.sortTypeList=argtable.sortTypeList or sortType
self.lockSelect=argtable.lockSelect
self.lockSelectList=argtable.lockSelectList
self.isUseFusionSort=argtable.isUseFusionSort
self.sortOrderList=argtable.sortOrderList
self.dzMaskList=argtable.dzMaskList
self.dzCountLimit=argtable.dzCountLimit
self.dzCountLeast=argtable.dzCountLeast
self.dzEmptyCountTx=argtable.dzEmptyCountTx
self.editorTeam=not(argtable.editorTeam==false)
self.needSaveTeam=argtable.needSaveTeam
self.isSortByTeamSelect=argtable.isSortByTeamSelect
if argtable.showZhenFa~=nil then
self.showZhenFa=argtable.showZhenFa
else
self.showZhenFa=true
end
self.lockZhenFa=argtable.lockZhenFa
self.enterBehaviorId=argtable.enterBehaviorId
self.sureBodyid=argtable.sureBodyid
self.sureBodyAnim=argtable.sureBodyAnim

self.targetFight=argtable.targetFight
self.notNeedDealOverTime=argtable.notNeedDealOverTime
self.fightCompareTips=argtable.fightCompareTips
self.fightCompareValue=argtable.fightCompareValue
self.fightCompareJingJie=argtable.fightCompareJingJie
self.otherArgs=argtable.otherArgs
self.showRewards=argtable.showRewards
self.showDefTeamTips=argtable.showDefTeamTips
self.defTeamLingGenLimit=argtable.defTeamLingGenLimit
self.defTeamLingGenLimitlist=argtable.defTeamLingGenLimitlist
self.linggen=argtable.linggen
self.extraWin=argtable.extraWin
self.extraParams=argtable.extraParams or{}
self.extraWinList=argtable.extraWinList
self.extraParamsList=argtable.extraParamsList or{}
self.dzInfoFuncList=argtable.dzInfoFuncList
self.checkDZSortFunc=argtable.checkDZSortFunc
self.checkDZTopSortFunc=argtable.checkDZTopSortFunc
self.checkTeamFullDzFunc=argtable.checkTeamFullDzFunc
self.mustHasDz=argtable.mustHasDz
self.noDzSZFunc=argtable.noDzSZFunc

self.executeCallback=argtable.executeCallback
self.lsMountType=argtable.lsMountType

self.faZeData=argtable.faZeData
self.faZeList2Args=argtable.faZeList2Args
self.faZeList3Args=argtable.faZeList3Args
self.faZeList2Reddot=argtable.faZe2Reddot or false
self.faZeList2Vis=argtable.faZeList2Default
self.faZeList3Vis=argtable.faZeList3Default

self.xjWayTime=argtable.xjWayTime
self.costList=argtable.costList

self.gbslAddInfo=argtable.gbslAddInfo

self.isMYZS=argtable.isMYZS

if argtable.dzSelectTips then
self.dzSelectTipsRoot:setActive(true)
self.dzSelectTips:setText(argtable.dzSelectTips)
else
self.dzSelectTipsRoot:setActive(false)
end

if self.skipDiscipleStateCheck==true then
if self.skipChuiWeiCheck==nil then
self.skipChuiWeiCheck=true
end
end

if self.skipChuiWeiCheck==true then
self.skipShouYuanCheck=true
end

self.fazeRoot2:setActive(self.faZeList2Args~=nil)
if self.faZeList2Args then
if self.faZeList2Vis==nil then self.faZeList2Vis=true end
self:showFaZeList2()
end

self.fazeRoot3:setActive(self.faZeList3Args~=nil)
if self.faZeList3Args then
if self.faZeList3Vis==nil then self.faZeList3Vis=true end
self:showFaZeList3()
end

self.placeTxt=argtable.place
self.placeRoot:setActive(self.placeTxt~=nil)
self.place:setText(self.placeTxt or'')

self.mustList=argtable.mustList
self.dzSpeakList=argtable.dzSpeakList

self.statePriorityCheck=argtable.statePriorityCheck~=false

local showReward=self.showRewards~=nil
self.rewardPanel:setActive(showReward)
if showReward then
self:setShowReward()
end

enterTxt=argtable.enterTxt
maxSelect=self.dzCountLimit or 5
minSelect=self.dzCountLeast or 1
npcList=argtable.npcList or{}
self.monsterPosType=stagePosType.TwoThree
if self.monsterGroupID~=nil then
self.monsterPosType=cfgHelper.get2(cfg_monstergroup_get,self.monsterGroupID,"teamType")or stagePosType.TwoThree
elseif argtable.monsterPosType~=nil then
self.monsterPosType=argtable.monsterPosType
end
if argtable.teamList and not argtable.setteamlist_nil then
for posIndex,v in pairs(argtable.teamList)do
preloadList[tostring(v)]=posIndex
end
end

if argtable.titleText then
self.titleText:setText(argtable.titleText)
end
if argtable.multipleTeams then
self.teamSelectData=argtable.multipleTeams
self.defaultSelectTeamIndex=argtable.defaultSelectTeamIndex
self.teamUnlockCNDFuncList=argtable.teamUnlockCNDFuncList
self.teamLockCfgList=argtable.teamLockCfgList
self.checkSelectCnt=argtable.checkSelectCnt
self.teamList:setActive(self.kofMode==nil)
else
self.teamList:setActive(false)
end

if argtable.multipleMonsterList then
self.multipleMonsterList=argtable.multipleMonsterList
end
if argtable.multipleMonsterListEx then
self.multipleMonsterListEx=argtable.multipleMonsterListEx
end

if argtable.conditionDatas then
self.conditionDatas=argtable.conditionDatas
end


if argtable.plotDiscipleList then
self.plotDiscipleList=argtable.plotDiscipleList
self.plotDiscipleList=self:getLookUp(self.plotDiscipleList)
else
self.plotDiscipleList={}
end

if argtable.plotGrayDiscipleList then
self.plotGrayDiscipleList=argtable.plotGrayDiscipleList
self.plotGrayDiscipleList=self:getLookUp(self.plotGrayDiscipleList)
else
self.plotGrayDiscipleList={}
end

if argtable.plotHideDiscipleList then
self.plotHideDiscipleList=argtable.plotHideDiscipleList
self.plotHideDiscipleList=self:getLookUp(self.plotHideDiscipleList)
else
self.plotHideDiscipleList={}
end

if self.lockSelectList then
self.lockSelect=self.lockSelectList[1]
end

if argtable.plotNPCDiscipleList then
local lookUp={}
for i,v in ipairs(argtable.plotNPCDiscipleList)do
local diziId=v[1]
local npcId=v[2]
if self.lockSelect then
local lockpos=nil
for pos,v2 in ipairs(self.lockSelect)do
if tostring(v)~='0'then
local data=UIDiscipleModel:getDiscipleDataX(v2)
if data and data.netData.net.id==diziId then
lockpos=pos
break
end
end
end
if lockpos then
table.insert(npcList,{npcId,lockpos})
end
end
lookUp[diziId]=diziId
end
self.plotHideDiscipleList=lookUp
end

if not worldController:checkNoticiateBlockOpen()then
enterTxt=nil
self.singleFight:setActive(false)
self.titleRoot:setActive(false)
self.autoSelectButton:setActive(false)
self.clearButton:setActive(false)
self.editorTeam=false
end

self.selectStage=argtable.selectStage
self.mapId=argtable.mapId
self.selectStage.onEventChange=self.onEventChange

local fightPrepareSortList=cfgHelper.get(cfg_globalconfig_get,1,"fightPrepareSort")
local fightPrepareSort=fightPrepareSortList~=nil and fightPrepareSortList[self.fightType]or nil
if fightPrepareSort then
self.statePriorityCheck=fightPrepareSort==1
end

if argtable.specialfaze_templist and argtable.specialfaze_fazeidx then
self.specialfaze_templist=argtable.specialfaze_templist
self.specialfaze_fazeidx=argtable.specialfaze_fazeidx

end
if argtable.fuyao_datas then
self.specialfaze_fuyao_templist=argtable.fuyao_datas.specialfaze_fuyao_templist
self.specialfaze_fuyao_fazeidx=argtable.fuyao_datas.specialfaze_fuyao_fazeidx
self.lg_fuyao_templist=argtable.fuyao_datas.lg_fuyao_templist
self.lg_fuyao_alllevel=argtable.fuyao_datas.lg_fuyao_alllevel
self.ct_fuyao_templist=argtable.fuyao_datas.ct_fuyao_templist
self.ct_fuyao_alllevel=argtable.fuyao_datas.ct_fuyao_alllevel

end
if argtable.xbsl_datas then

self.xbsl_datas=argtable.xbsl_datas
self.xbsl_buff_joblist=argtable.xbsl_datas.xbsl_buff_joblist
self.xbsl_ban_voclist=argtable.xbsl_datas.xbsl_ban_voclist
end

if argtable.catCatMiJing then
self.catCatMiJing=argtable.catCatMiJing
self.CatFrightDialougeFlag=false
self.catFight:setActive(true)
self.singleFight:setActive(false)
end

if argtable.yunchentanbao then
self.yunchentanbao=argtable.yunchentanbao
end

if argtable.sfpy_enter then
self.sfpy_enter=argtable.sfpy_enter
end


if argtable.shanhaiyubeidui then
self.shanhaiyubeidui=argtable.shanhaiyubeidui

end

if argtable.checkBanFlagFunc then
self.checkBanFlagFunc=argtable.checkBanFlagFunc
end

if argtable.wendingcangqiongCfg then
self.wendingcangqiongCfg=argtable.wendingcangqiongCfg
end

if argtable.checkXingYuFlagFunc then
self.checkXingYuFlagFunc=argtable.checkXingYuFlagFunc
end
end

if self.isFullOpen then
baseFullScreenUI:openMain(false)
end

self.zfBtn:setActive(self.showZhenFa and systemModel.isOpen(SYSTEM_DEFINE.eZhenFa))
if self.lockZhenFa then
self:setZhenFa(self.lockZhenFa)
else
if self.showZhenFa then
local defaultzf=fightPreSelectModel:getZhenFaData(self.fightType)
if defaultzf then
self:setZhenFa(defaultzf)
end
end
end

if self.isHomeBattle then
isometricMapSystem:enterBattleMode()
end


m_sorttypeindex=1

self.sortOrder=eSortOrder.eDown

if enterTxt then
self.selectText:setText(enterTxt)
else
self.cancelButton:setActive(false)
end

if self.cantEnter then
self.selectButton:setGray(true)
end

if self.monsterFight or self.monsterFightEx then
self.singleFight:setActive(false)
self.multiFight:setActive(true)
self:setMonsterFight()
local showMultiTitle=self.multiTitleStr~=nil
local multiWidget=self.multiFight:getChildWidgetBase()
multiWidget:SetChildActive(0,showMultiTitle)
if showMultiTitle then
multiWidget:SetChildText(1,self.multiTitleStr)
end
end
self.defTeamTips:setActive(self.showDefTeamTips==true)
self.defTeamLgRoot:setActive(self.defTeamLingGenLimit~=nil or self.defTeamLingGenLimitlist~=nil)
if self.defTeamLingGenLimit then
local lgInfo=self.defTeamLingGenLimit
local bgInfo=lgInfo[1]
local spriteInfo=lgInfo[2]

if pfwindowslController:checkIsGameVersion_yuenan()then
if bgInfo[1]==9 then
spriteInfo[2]=50
elseif bgInfo[1]==10 then
spriteInfo[2]=85
end
end
iconHelper.setChildIcon_1(self.winlua,self.defTeamLgBg:getID(),bgInfo[1],bgInfo[4],bgInfo[5],bgInfo[2],bgInfo[3])
iconHelper.setChildIcon_1(self.winlua,self.defTeamLgImage:getID(),spriteInfo[1],spriteInfo[4],spriteInfo[5],spriteInfo[2],spriteInfo[3])
end

if self.defTeamLingGenLimitlist then
local lgInfo=self.defTeamLingGenLimitlist[1]
local bgInfo=lgInfo[1]
local spriteInfo=lgInfo[2]

if pfwindowslController:checkIsGameVersion_yuenan()then
if bgInfo[1]==9 then
spriteInfo[2]=50
elseif bgInfo[1]==10 then
spriteInfo[2]=85
end
end
iconHelper.setChildIcon_1(self.winlua,self.defTeamLgBg:getID(),bgInfo[1],bgInfo[4],bgInfo[5],bgInfo[2],bgInfo[3])
iconHelper.setChildIcon_1(self.winlua,self.defTeamLgImage:getID(),spriteInfo[1],spriteInfo[4],spriteInfo[5],spriteInfo[2],spriteInfo[3])
end

local singleFightDescStrlist={self.singleFightDescStr,self.singleFightDescStr2}
for i=1,2 do
local showSingleFightDesc=singleFightDescStrlist[i]~=nil
self.fightDescObj[i]:setActive(showSingleFightDesc)
if showSingleFightDesc then
self.fightDescTxt[i]:setText(singleFightDescStrlist[i])
end

end

if self.sureBodyid then
self.selectButton:setChildDragonTarget(self.sureBodyid,1,nil,eAnimationID.stand,false,0,false,nil)
else
self.selectButton:setChildDragonTarget(2030,1,nil,eAnimationID.stand,false,0,false,nil)
end
self.teamButton:setActive(self.editorTeam)


if self.enterBehaviorId then
local enterBehaviorCfg=cfgHelper.get1(cfg_fightprepareentergroupconfig_get,self.enterBehaviorId)
self.leftPosBehavior=enterBehaviorCfg.leftPos
self.rightPosBehavior=enterBehaviorCfg.rightPos
self.leftOutPosBehavior=enterBehaviorCfg.leftOutPos
self.rightOutPosBehavior=enterBehaviorCfg.rightOutPos
end

if self.xjWayTime then
self.wayTimeBg:setActive(true)
local wayTime=math.ceil(self.xjWayTime)
local time_str=timeHelper.format_time_stamp3(wayTime)
self.wayTimeText:setText(FMT.fmt("路程：{0}",time_str))
else
self.wayTimeBg:setActive(false)
end

self:refreshMoneyCostPanel()

self.isShangZhenging=false
self.isShangZhenginit=true
self:setConditionList()
self:showFaZeList()
self:showTeamList()


self:getNetDataList()

self:initRoleTypeListPanel()

self:initRoleListPanel(self.leftPosBehavior)
_this.isShangZhenginit=false


self:initMonsterModelPanel(self.rightPosBehavior)
self:initMonsterModelPanelEx(self.rightPosBehavior)

self:refreshShieldEntity()

self:OnClickRoleSortItemCallback(1,0)

self:setFight()
self:refreshEnemyTeamPanel()



if newbieControl.isInNewbie()then
self:registerEasyTouch(false)

end

if newbieControl.isCurrentNewbie(10030)then
self.topMask:setActive(true)
end

if npcList then
local nbFunc=function()
local config=newbieModel.getLookupConfig(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.enterNewbieDragNPC)
if config then
local newbieId=config.id
if not newbieModel.isFinish(newbieId)then
self:setTopMask(true)
self.winid:SetChildColor(self.topMask:getID(),Color.New(1,1,1,0))
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.enterNewbieDragNPC)

self:registerEasyTouch(false)
end
end
end
for i,v in ipairs(npcList)do
if v[1]==1 then


nbFunc()
break
end
end
end


if self.extraWin then
self.extraParams.base_selectList=selectList
self:showWindow(self.extraWin,self.extraParams)
end
if self.extraWinList then
for i,v in ipairs(self.extraWinList)do
self:showWindow(v,self.extraParamsList[i])
end
end


if _this.specialfaze_templist and _this.specialfaze_fazeidx then
_this:delayDo(1,function()
if not _this then return end
UIFightPrepareWin:CheckspecialfazeInit(argtable.teamList)
end)
end
if _this.specialfaze_fuyao_templist and _this.specialfaze_fuyao_fazeidx then
_this:delayDo(1,function()
if not _this then return end
UIFightPrepareWin:CheckspecialfazeInitfuyao(argtable.teamList)
end)
end
















if self.yunchentanbao then

end
end


function UIFightPrepareWin.inNewbie(newbieid,flag)
if _this==nil then return end
if not flag then
_this:registerEasyTouch(true)
end
end

function UIFightPrepareWin:setShowReward()
local rewards=self.showRewards
local len=#rewards
self.rwScrollView:setChildScrollViewCreateGrids(len,math.min(len,3))
local grids=self.rwScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=rewards[i]
local cfg=itemsConfig.getConfig(data[1])
widgetHelper.setNormalRewardItem(item,0,{data[1],data[2],stage=cfg.stage})
end
end

function UIFightPrepareWin.onEventChange(evtType,entityId,posIndex)

if not _this then
return
end
if not _this:checkTaskLimit(true)then
return
end
if evtType==1 then
dragIndex=posIndex
if selectList[posIndex]then
dragGuid=selectList[posIndex]
dragDataIndex=selectLookUp[_this.getLookUpKey(dragGuid[1],tostring(dragGuid[2]))]
end
_this:excuteDouFaTaiEvent(evtType,entityId,posIndex)
elseif evtType==3 then
if _this then
if dragBeginData and posIndex~=-1 then
_this.enhancedscrollscript:checkAndClick(nil,nil,dragEndData[1],dragEndData[3],nil,nil,true)
end
if dragEndData and posIndex~=-1 then
_this.enhancedscrollscript:checkAndClick(nil,nil,dragEndData[1],dragEndData[3],posIndex)
end
if dragIndex then
if posIndex~=-1 then
_this.exchangeRoleItem(dragIndex,posIndex)
else
if dragGuid and dragDataIndex then
_this.enhancedscrollscript:checkAndClick(nil,nil,dragDataIndex-1,nil)
end
end
end
end

dragDataIndex=nil
dragGuid=nil
dragBeginData=nil
dragEndData=nil
dragIndex=nil
end
end


function UIFightPrepareWin:excuteDouFaTaiEvent(evtType,entityId,posIndex)
if(self.fightType==fightPreSelectModel.fightType.doufatai
or self.fightType==fightPreSelectModel.fightType.xianfawendao)and posIndex>5 then
local ent=self:getEntity(posIndex)
if ent and ent.isAssistant then
return
end

if UIManager:isActive("UIOtherDiscipleMainWin")then
return
end


if self.monsterListEx and self.otherArgs and self.otherArgs[6]==DOUFATAI_ROBOTTYPE.player then
local disciplesInfo=self.monsterListEx[posIndex-5]
local list={}
for k,v in pairs(self.monsterListEx)do
local dzData=otherPlayerModel:getDZData(v.guid)
table.insert(list,dzData)
end
self.dontCloseStage=false
otherPlayerController:openOtherPlayerDZInfoWin2(disciplesInfo.guid,list)
else
UIManager.info('对手过于神秘，无法查看信息')
end
end
end

function UIFightPrepareWin:setTopMask(active)
self.topMask:setActive(active)
end


function UIFightPrepareWin:getCanUseShouYuanDisciples()
local list={}
local disciples=UIDiscipleModel:getAllDiscipleDataX()
if self.skipShouYuanCheck then
return disciples
end
for k,v in pairs(disciples)do
local net=v.netData.net
local guid=net.discipleguid
local shouyuan=UIDiscipleModel:getDiscipleShouYuan(guid)
if shouyuan~=0 or((self.plotDiscipleList[net.id])or(self.plotGrayDiscipleList[net.id]))then
table.insert(list,v)
end
end
return list
end


function UIFightPrepareWin:maskDispatch(list)
local c=#list
for i=c,1,-1 do
local net=list[i].netData.net
local guid=net.discipleguid
local isremove=false

if not UIDiscipleModel:checkDZStateToDoSomething(guid,eCheckDiscipleStateOpType.eDispatch2,false)then
isremove=true
end
if isremove then
table.remove(list,i)
end
end
end


function UIFightPrepareWin:checkDispatchCondition(guidlist,warning,multi)
if not self.skipDiscipleStateCheck then
local checkFalse=function(data)
local guid=data[2]
if data[1]==fightPreSelectModel.teamEntityType.dizi and mathHelper.validInt64(guid)
and not UIDiscipleModel:checkDZStateToDoSomething(guid,eCheckDiscipleStateOpType.eDispatch2,warning)
and not UIDiscipleModel:checkDZStateToDoSomething(guid,DISCIPLE_STATE_TYPE.eDuJieXianDan,warning)
then
return true
end
end

for i,v in pairs(guidlist)do
if multi then
for ii,vv in pairs(v)do
if checkFalse(vv)then
return false
end
end
else
if checkFalse(v)then
return false
end
end

end
end
return true
end


function UIFightPrepareWin:checkState(discipleData,warring,isInit)
if discipleData.uType==fightPreSelectModel.teamEntityType.dizi then
local netdata=discipleData.data.netData.net

if self.plotGrayDiscipleList then
if self.plotGrayDiscipleList[netdata.id]then
if warring then
UIManager.error("暂离状态不可上阵")
end
return
end
end

if not self.skipChuiWeiCheck then

if UIDiscipleModel:checkDiscipleState2(netdata.discipleguid,DISCIPLE_STATE_TYPE.eChuiWei)then
if warring then
UIManager.error("垂危状态不可派遣")
end
return
end
end

if not self.skipShouYuanCheck then
local shouyuan=UIDiscipleModel:getDiscipleShouYuan(netdata.discipleguid)
if shouyuan==0 then

if warring then
UIManager.error("垂危状态不可派遣")
end
return
end
end

if not self.skipDiscipleInjuryCheck then
local checkLowLoyalty=UIDiscipleModel:checkLowLoyalty(netdata.discipleguid)
if checkLowLoyalty then
if warring then
UIManager.error("忠诚度低不可派遣")
end
return
end
end

if not self.skipDiscipleStateCheck then
if not UIDiscipleModel:checkDZStateToDoSomething(netdata.discipleguid,eCheckDiscipleStateOpType.eDispatch2,warring)then
return
end
if UIDiscipleModel:checkDiscipleState2(netdata.discipleguid,DISCIPLE_STATE_TYPE.eDuJieXianDan)then
if warring then
UIManager.error("弟子正在炼制渡劫仙丹")
end
return
end
end

if self.checkSignType then
if UIDiscipleModel:haveDiscipleSign(netdata.discipleguid,self.checkSignType)then
if not isInit and warring then
UIManager.error(FMT.fmt("{0}，无法出战",dzSignTypeName[self.checkSignType]))
end
return
end
end

if self.isCheckVocBan then
if self.xbsl_datas and self.xbsl_ban_voclist then

local vocbanflag=self:CheckspecialfazeVocBan_xbsl(netdata.discipleguid)
if vocbanflag then
if warring then
UIManager.error("此关卡无法上阵该职业弟子")
end
return
end
end
end

if self.isCheckXJOccupyType then
local dzState,stateStr=xianjieModel:getDZState(netdata.discipleguid,true)
local isOccupy=dzState~=nil
if isOccupy then
if warring then
UIManager.error(FMT.fmt("弟子{0},无法上阵",stateStr))
end
return
end
end

if self.isCheckLingShanState then
local check=UILSZDControl:isDiZiInLingShan(netdata.discipleguidStr)
if check then
if warring then
UIManager.error("弟子已入驻,无法上阵")
end
return
end

local check2=UILSZDControl:isForbidDisciple(self.lsMountType,netdata.discipleguidStr)
if check2 then
if warring then
UIManager.error("仙缘弟子无法上阵")
end
return
end
end

if self.isMYZS then
local discipleData_myzs=myzsModel:getDiscipleDataByGuid(netdata.discipleguid)
if discipleData_myzs==nil then return end
if discipleData_myzs.hpPercent<=0 then
if warring then
UIManager.error("弟子已阵亡")
end
return
end
if discipleData_myzs.llPercent<=0 then
if warring then
UIManager.error("弟子灵力不足")
end
return
end
end

local guidStr=tostring(netdata.discipleguid)
local checkStateFunc=nil
if self.dzInfoFuncList then
local sData=self.dzInfoFuncList[guidStr]
if sData then
checkStateFunc=sData.checkState
end
end
if checkStateFunc then
if not checkStateFunc(netdata.discipleguid,warring)then
return
end
end
if self.checkBanFlagFunc and self.checkBanFlagFunc(netdata.discipleguid)then
if warring then
UIManager.error("弟子被禁用")
end
return
end
if self.checkXingYuFlagFunc and self.checkXingYuFlagFunc(netdata.discipleguid)then
if warring then
UIManager.error("弟子已参与本轮星域")
end
return
end
end
return true
end


function UIFightPrepareWin:getNetDataList()
local slist={}
if self.mustList then
for i,v in ipairs(self.mustList)do
local dzData={uType=fightPreSelectModel.teamEntityType.dizi,data=UIDiscipleModel:getDiscipleDataX(v)}
table.insert(slist,dzData)
end
end
self.npcLookUp={}
if next(npcList)then
local npcData=nil
for i,v in ipairs(npcList)do
npcData={uType=fightPreSelectModel.teamEntityType.npc,data={id=v[1],guid=table.concat(v,""),monsterId=fightPreSelectModel.getNPCMonster(v[1])}}
table.insert(slist,npcData)
self.npcLookUp[npcData.data.guid]=v
end
end
local diziList={}
if self.lockSelect then
for i,v in ipairs(self.lockSelect)do
if tostring(v)~='0'then
local check=true
local data=UIDiscipleModel:getDiscipleDataX(v)



if self.plotHideDiscipleList then
if data and self.plotHideDiscipleList[data.netData.net.id]then
check=false
end
end

if not self.skipChuiWeiCheck then
local checkChuiWei=UIDiscipleModel:checkDiscipleState(v,DISCIPLE_STATE_TYPE.eChuiWei)
if checkChuiWei then
check=false
end
end

if not self.skipShouYuanCheck then
local shouyuan=UIDiscipleModel:getDiscipleShouYuan(v)
if shouyuan==0 then
check=false
end
end

if self.isCheckVocBan then
if self.xbsl_datas and self.xbsl_ban_voclist then

local vocbanflag=self:CheckspecialfazeVocBan_xbsl(v)
if vocbanflag then
check=false
end
end
end

if self.isCheckXJOccupyType then
local isOccupy=xianjieModel:checkDzXJOccupy(v)
if isOccupy then
check=false
end
end

if check then
table.insert(diziList,UIDiscipleModel:getDiscipleDataX(v))
end
end
end
local topLookUp={}
if self.plotDiscipleList then
for id,v in pairs(self.plotDiscipleList)do
topLookUp[id]=v
end
end
if self.plotGrayDiscipleList then
for id,v in pairs(self.plotGrayDiscipleList)do
topLookUp[id]=v
end
end

local teamSortFunc
local teamSortFuncParam
local isSortByTeamSelect=self.isSortByTeamSelect
local checkDZTopSortFunc=self.checkDZTopSortFunc
if isSortByTeamSelect then
local nowSelectTeam=self.selectIndex and self.selectIndex+1 or self.defaultSelectTeamIndex
local teamCount=#self.teamSelectData
teamSortFuncParam={selectTeam=nowSelectTeam,teamCount=teamCount}
teamSortFunc=function(dzGuid,param)
if not _this then
return
end
local selectTeam=param and param.selectTeam
local teamCount=param and param.teamCount
local currTeam=_this:getDZTeam(dzGuid)
if not currTeam then
return teamCount+1
else
if currTeam==selectTeam then
return teamCount+2
else
return teamCount-currTeam+1
end
end
end
end

local sortTypeArgs=self.sortTypeList[m_sorttypeindex]
local isUseFusionSort=self.isUseFusionSort
local sortParams={false,self.statePriorityCheck,nil,topLookUp,nil,self.checkDZSortFunc,teamSortFunc,teamSortFuncParam,checkDZTopSortFunc}
if isUseFusionSort then
local sortOrderList=self.sortOrderList[m_sorttypeindex]
discipleLookup:fusionSortList(diziList,sortTypeArgs,sortOrderList,sortParams)
else
discipleLookup:sortList(diziList,sortTypeArgs,self.sortOrder,sortParams)
end
else
local list=self:getCanUseShouYuanDisciples()

local checkMask=self.dzMaskList~=nil
for i,v in pairs(list)do
local netData=v.netData.net

if self:checkCanAddToList(netData)then
local check=true
if not self.skipDZDispatchCheck then
local check1=UIDiscipleModel:checkDiscipleState(netData.discipleguid,DISCIPLE_STATE_TYPE.edsDispatch)
local check2=self.plotDiscipleList[netData.id]or self.plotGrayDiscipleList[netData.id]
if check1 and(not check2)then
check=false
end
end
if check and checkMask then
local dzkey=tostring(netData.discipleguid)
if self.dzMaskList[dzkey]~=nil then
check=false
end
end

if self.plotHideDiscipleList[netData.id]then
check=false
end

if not self.skipChuiWeiCheck then
local checkChuiWei=UIDiscipleModel:checkDiscipleState(netData.discipleguid,DISCIPLE_STATE_TYPE.eChuiWei)
if checkChuiWei then
check=false
end
end

if check then
table.insert(diziList,v)
end
end
end
local topLookUp={}
if self.plotDiscipleList then
for id,v in pairs(self.plotDiscipleList)do
topLookUp[id]=v
end
end
if self.plotGrayDiscipleList then
for id,v in pairs(self.plotGrayDiscipleList)do
topLookUp[id]=v
end
end
local checkDZSortFunc=self.checkDZSortFunc
local checkDZTopSortFunc=self.checkDZTopSortFunc
local sortTypeArgs=self.sortTypeList[m_sorttypeindex]
local isUseFusionSort=self.isUseFusionSort
local isSortByTeamSelect=self.isSortByTeamSelect
local teamSortFunc
local teamSortFuncParam
if isSortByTeamSelect then
local nowSelectTeam=self.selectIndex and self.selectIndex+1 or self.defaultSelectTeamIndex
local teamCount=#self.teamSelectData
teamSortFuncParam={selectTeam=nowSelectTeam,teamCount=teamCount}
teamSortFunc=function(dzGuid,param)
if not _this then
return
end
local selectTeam=param and param.selectTeam
local teamCount=param and param.teamCount
local currTeam=_this:getDZTeam(dzGuid)
if not currTeam then
return teamCount+1
else
if currTeam==selectTeam then
return teamCount+2
else
return teamCount-currTeam+1
end
end

end
end
if isUseFusionSort then
local sortOrderList=self.sortOrderList[m_sorttypeindex]
discipleLookup:fusionSortList(diziList,sortTypeArgs,sortOrderList,{false,self.statePriorityCheck,nil,topLookUp,nil,checkDZSortFunc,teamSortFunc,teamSortFuncParam,checkDZTopSortFunc})
else
discipleLookup:sortList(diziList,sortTypeArgs,self.sortOrder,{false,self.statePriorityCheck,nil,topLookUp,nil,checkDZSortFunc,teamSortFunc,teamSortFuncParam,checkDZTopSortFunc})
end
end
for i,v in ipairs(diziList)do
table.insert(slist,{uType=fightPreSelectModel.teamEntityType.dizi,data=v})
end
self.disciplesList=slist
end

function UIFightPrepareWin:checkCanAddToList(netData)



if self.mustList then
if table.containsValueEx(self.mustList,netData.discipleguid,function(value)
return tostring(value)
end)then
return false
end
end
return true
end

function UIFightPrepareWin:initRoleTypeListPanel()
self.RoleTypeListPanel:setChildScrollViewCreateGrids(#self.sortTypeList,1)
local grids=self.RoleTypeListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local id=self.sortTypeList[i]
item:SetChildText(0,eDiscipleSortTypeName:getName1(id))
item:SetChildCSImageSprite(1,imageabname,FMT.fmt('{0}{1}',imageassetname,i))
end
end

function UIFightPrepareWin:OnClickRoleSortItemCallback(clicknum,index)
local oldIndex
if index+1~=m_sorttypeindex then
oldIndex=m_sorttypeindex
end
m_sorttypeindex=index+1
local grid=self.RoleTypeListPanel:getChildScrollViewItemWidget(index)
if grid then
grid:SetChildActive(2,true)
end
if oldIndex then
grid=self.RoleTypeListPanel:getChildScrollViewItemWidget(oldIndex-1)
if grid then
grid:SetChildActive(2,false)
end
self:getNetDataList()
self:refreshRoleList()
end
end

function UIFightPrepareWin:initMonsterModelPanel(behaviour)
if self.monsterList then
local max=5
local posType=self.monsterPosType
if posType==stagePosType.TwoThree then
max=5
elseif posType==stagePosType.OneTwo or posType==stagePosType.TwoOne then
max=3
elseif posType==stagePosType.OnePos then
max=1
else
max=5
end
local cur=0
for i,v in ipairs(self.monsterList)do
if i<6 then


if v~=0 then
self.selectStage:addEntity(5+i,fightEntityType.monster,v,nil,self.monsterPosType,behaviour)
cur=cur+1
end
if cur>=max then
break
end
end
end
end
end

function UIFightPrepareWin:refreshMonsterModelPanel(monsterList)
self.monsterList=monsterList
self:initMonsterModelPanel(self.rightPosBehavior)
end

function UIFightPrepareWin:initMonsterModelPanelEx(behaviour)
if self.monsterListEx then
for i,v in pairsBySortKey(self.monsterListEx)do
if i<6 then
local pos
if v.pos~=nil then
pos=5+v.pos
else
pos=5+i
end
if v.typo==fightEntityType.diZi then
if v.netData then
self.selectStage:addEntityEx(pos,v.typo,v.netData,nil,self.monsterPosType,behaviour)
else
self.selectStage:addEntity(pos,v.typo,v.guid,nil,self.monsterPosType,behaviour)
end
else
self.selectStage:addEntity(pos,v.typo,v.monsterID,nil,self.monsterPosType,behaviour)
end
end
end
end
end

function UIFightPrepareWin:addEntityShield(shieldId,isLeft)

self.selectStage:addEntityShield(shieldId,isLeft)
end

function UIFightPrepareWin:refreshShieldEntity()
if self.sheildParam then
self:addEntityShield(self.sheildParam[1],self.sheildParam[2])
end
end

function UIFightPrepareWin:refreshMonsterModelPanelEx(monsterListex)
self.monsterListEx=monsterListex
self:initMonsterModelPanelEx()
end

function UIFightPrepareWin:refreshRoleList()
if self.disciplesList then
local dataNum=#self.disciplesList

self.enhancedscrollscript:initData(self.disciplesList,160,dataNum)
self.emptySelectTx:setText(dataNum<=0 and self.dzEmptyCountTx or"")
end
end

function UIFightPrepareWin:initRoleListPanel(behaviour)
if self.disciplesList then
self:refreshRoleList()

if self.teamSelectData then
local idx=self.defaultSelectTeamIndex or 1
idx=idx-1
self.on_team_select(0,idx)
preloadList={}
self.npcLookUp={}
return
end


if not self.lockSelect and#self.disciplesList<=5 and next(preloadList)==nil and next(self.npcLookUp)==nil and not self.setteamlist_nil then
for i,v in ipairs(self.disciplesList)do
self.enhancedscrollscript:checkAndClick(nil,nil,i-1,nil,nil,behaviour,nil,nil,true)
end
end


if next(preloadList)or next(self.npcLookUp)then
self:fastSelect(preloadList,self.npcLookUp,behaviour,0.1,false)
preloadList={}
self.npcLookUp={}
end
end

if self.forceAutoSelect then
self:delayDo(0.2,function()
self:onAutoSelectButton(true)
end)
end
end


function UIFightPrepareWin:clearSelect()
if self.teamSelectData then
self.selectStage:clearEntity(true)
selectLookUp={}
table.clear(selectList)
selectNum=0
local curTeam=self.selectIndex+1
self.teamSelectData[curTeam]={}
else
for i,v in pairs(selectList)do
if v[1]==fightPreSelectModel.teamEntityType.dizi then
selectLookUp[self.getLookUpKey(v[1],tostring(v[2]))]=nil
selectList[i]=nil
selectNum=selectNum-1
self.selectStage:removeEntity(i)
end
end
end

self:doRefreshActiveCellViews()

self:showAutoSelectButton()

notifySystem:postNotify(notifyConfig.onFightPrepareSelectChange,selectList)
end


function UIFightPrepareWin:fastSelect(diziLookUp,npcLookUp,behaviour,delay,warring,delayFunc)
local warring=warring or warring==nil
self:clearSelect()
local guid
timeEventController.delayDo(delay or 0.5,function()
local tempList={}
local npcTempList={}
local diziTempList={}
for i,v in ipairs(self.disciplesList)do
if v.uType==fightPreSelectModel.teamEntityType.npc then
guid=v.data.guid
if npcLookUp and npcLookUp[guid]then
tempList[npcLookUp[guid][2]]=i-1
npcTempList[npcLookUp[guid][2]]=i-1
end
elseif v.uType==fightPreSelectModel.teamEntityType.dizi then
guid=tostring(v.data.netData.net.discipleguid)
if diziLookUp and diziLookUp[guid]then
tempList[diziLookUp[guid]]=i-1
diziTempList[diziLookUp[guid]]=i-1
end
end
end

for i,v in pairs(tempList)do
if not(diziTempList[i]and npcTempList[i])then
npcTempList[i]=nil
end
self.enhancedscrollscript:checkAndClick(nil,nil,v,nil,i,behaviour,nil,nil,true,warring)
end
for i,v in pairs(npcTempList)do
self.enhancedscrollscript:checkAndClick(nil,nil,v,nil,i,behaviour,nil,nil,true,warring)
end
if delayFunc then
delayFunc(false)
end
end)
end

function UIFightPrepareWin:onFastSelect(diziLookUp)
self:onClearButton()
self:fastSelect(diziLookUp)
end


function UIFightPrepareWin:setFight()
selectFight=0
for i,v in pairs(selectList)do
if v[1]==fightPreSelectModel.teamEntityType.dizi then
selectFight=selectFight+_this:getDzFightValue(v[2])
elseif v[1]==fightPreSelectModel.teamEntityType.npc then
selectFight=selectFight+fightPreSelectModel.getNPCFightValue(tonumber(tostring(v[3])))
end
end
self.fightText:setText(UIDiscipleModel:fightValueConversion(selectFight))

if self.monsterFight or self.monsterFightEx then
local strFight=UIDiscipleModel:fightValueConversion(selectFight)
self.selfFightText:setText(strFight)
end

self.targetFightBG:setActive(self.targetFight~=nil)
if self.targetFight~=nil then

local fightDesc=""
if self.targetFight<selectFight*0.7 then
fightDesc=FMT.cfmt1(FONT_COLOR.eGreenColor,"敌军不堪一击")
elseif self.targetFight<=selectFight*1.2 then
fightDesc=FMT.cfmt1(FONT_COLOR.eWhiteColor,"敌军势均力敌")
else
fightDesc=FMT.cfmt1(FONT_COLOR.eRedColor,"敌军不可力敌")
end
self.targetFightDesc:setText(fightDesc)
end

self:setCatFightPanel(selectFight)

self.myzsLingLiLimitTips:setActive(self.isMYZS)
end

function UIFightPrepareWin:setMonsterFight()
local mons_fight=0
if self.monsterFight then
mons_fight=self.monsterFight
elseif self.monsterFightEx then
local idx=self.selectIndex or 0
mons_fight=self.monsterFightEx[idx+1]
end
if not mons_fight then mons_fight=0 end
local strFight=UIDiscipleModel:fightValueConversion(mons_fight)
self.monsterFightText:setText(strFight)
end


function UIFightPrepareWin:getJingJie()
local topJingjie=0
for i,v in pairs(selectList)do
if v[1]==fightPreSelectModel.teamEntityType.dizi then
local jjlv=UIDiscipleModel:getDiscipleData(v[2]).jingjielv
if jjlv>topJingjie then
topJingjie=jjlv
end
end
end
return topJingjie
end

function UIFightPrepareWin.getEmpty()
for i=1,maxPos do
if not selectList[i]then
return i
end
end
end


function UIFightPrepareWin.getJobPosPriorty(jobId)
local posIndex
local pospriorty=UIDiscipleModel.getJobPosPriorty(jobId)
if pospriorty then
for i,listPos in ipairs(pospriorty)do
if not selectList[listPos]then
return listPos
end
end
else
posIndex=self.getEmpty()
end
end

function UIFightPrepareWin.getGUIDIndex(teamEntityType,guid)
for i,v in pairs(selectList)do
if teamEntityType==v[1]and guid==v[2]then
return i
end
end
end



function UIFightPrepareWin.getLookUpKey(teamEntityType,guid)
return table.concat({teamEntityType,guid},"-")
end

function UIFightPrepareWin.exchangeRoleItem(index,targetindex)
if selectList[index]then
local temp=selectList[index]
selectList[index]=selectList[targetindex]
selectList[targetindex]=temp
end
if _this.teamSelectData then
local teamList=_this.teamSelectData[_this.selectIndex+1]
local v1,v2
for k,v in pairs(teamList)do
if v[1]==index then
v1=v
elseif v[1]==targetindex then
v2=v
end
end
if v1 then
v1[1]=targetindex
end
if v2 then
v2[1]=index
end
_this.enhancedscrollscript:doRefreshActiveCellViews()
end
end

function UIFightPrepareWin:exchangeRoleItemWithEntity(index,targetindex)
if selectList[index]then
self.exchangeRoleItem(index,targetindex)
self.selectStage:exchangeEntityIndex(index,targetindex)
end
end

function UIFightPrepareWin.getSortGuidList()
if _this.teamSelectData then
local retList={}
for i,v in ipairs(_this.teamSelectData)do
local indexList={}
for kk,vv in pairs(v)do
indexList[vv[1]]=vv
end
local teamList={}
for ii=1,maxPos do
local data=indexList[ii]
if data then
teamList[ii]={data[2],data[3]}
else
teamList[ii]={0,int64.zero}
end
end
retList[i]=teamList
end
return retList,1,true
end

local guidList={}
local guidCnt=0
for i=1,maxPos do
if selectList[i]then
table.insert(guidList,i,{selectList[i][1],selectList[i][3]})
guidCnt=guidCnt+1
else
table.insert(guidList,i,{0,int64.zero})
end
end
return guidList,guidCnt,false
end


function UIFightPrepareWin:getDiziList()
local guidList={}
for k,v in pairs(selectList)do
if v[1]==fightPreSelectModel.teamEntityType.dizi then
guidList[k]=v[3]
end
end
return guidList
end


function UIFightPrepareWin:checkPosEnough()
local list
local cnt=0
if self.teamSelectData then
local teamIndex=self.selectIndex+1
list=self.teamSelectData[teamIndex]or{}
for k,v in pairs(list)do
cnt=cnt+1
end
else
list=selectList
for i=1,5 do
if list[i]~=nil then
cnt=cnt+1
end
end
end
return cnt>=maxSelect
end


function UIFightPrepareWin:checkPosEmpty()
local list
local cnt=0
if self.teamSelectData then
local teamIndex=self.selectIndex+1
list=self.teamSelectData[teamIndex]or{}
for k,v in pairs(list)do
cnt=cnt+1
end
else
list=selectList
for i=1,5 do
if list[i]~=nil then
cnt=cnt+1
end
end
end
return cnt<=0
end

function UIFightPrepareWin:addEntity(posIndex,uType,id,guid,modelId,jobid,behaviour,tips)
if uType==fightPreSelectModel.teamEntityType.npc then
self.selectStage:addEntity(posIndex,fightEntityType.monster,id,jobid,nil,behaviour,tips)
elseif uType==fightPreSelectModel.teamEntityType.dizi then
self.selectStage:addEntity(posIndex,fightEntityType.diZi,guid,jobid,nil,behaviour,tips)
else
self.selectStage:addEntity(posIndex,fightEntityType.monster,modelId,jobid,self.monsterPosType,behaviour,tips)
end
end

function UIFightPrepareWin:getEntity(posIndex)
return self.selectStage:getEntity(posIndex)
end

function UIFightPrepareWin:getListIndex(posIndex)
if selectList[posIndex]then
local guidString=self.getLookUpKey(selectList[posIndex][1],tostring(selectList[posIndex][2]))
return selectLookUp[guidString]
end
end

function UIFightPrepareWin:selectDisciple(listIndex,posIndex)
self.enhancedscrollscript:checkAndClick(nil,nil,listIndex-1,nil,posIndex)
end


function UIFightPrepareWin:registerEasyTouch(register)
self.selectStage:registerEasyTouch(register)
end

function UIFightPrepareWin:showFaZeList2()
self.fazeRoot2Ex:setActive(self.faZeList2Vis)
self.fazeBtn2Reddot:setActive(self.faZeList2Reddot or false)
if not self.faZeList2Vis then return end
local faZeList2Args=self.faZeList2Args
local len=#faZeList2Args
self.faZeList2:setChildScrollViewCreateGrids(len,0)
local grids=self.faZeList2:getChildScrollViewItemWidgets()
local count=grids.Count
local tSize=0
for i=1,count do
local info=faZeList2Args[i]
local item=grids[i-1]
item:SetChildText(0,info.desc)
item:SetChildIcon(1,info.icon,false)
item:SetChildActive(2,count~=i)
item:SetChildText(3,info.name)
local descSizeY=item:GetChildPreferredSize(0,1)
local offset=40
if descSizeY>50 then offset=25 end
local fix=52
local sizeY=fix+offset+descSizeY
if sizeY<=130 then sizeY=130 end
item:SetChildSizeWithCurrentAnchors(0,1,descSizeY)
item:SetChildSizeWithCurrentAnchors(-1,1,sizeY)
tSize=tSize+sizeY
end
self.winlua:SetChildSizeWithCurrentAnchors(self.faze2contect:getID(),1,tSize)
end

function UIFightPrepareWin:showFaZeList3()
self.fazeRoot3Ex:setActive(self.faZeList3Vis)

if not self.faZeList3Vis then return end
local faZeList2Args=self.faZeList3Args
local len=#faZeList2Args
self.faZeList3:setChildScrollViewCreateGrids(len,0)
local grids=self.faZeList3:getChildScrollViewItemWidgets()
local count=grids.Count
local tSize=0
for i=1,count do
local info=faZeList2Args[i]
local item=grids[i-1]
item:SetChildText(0,info.desc)
item:SetChildIcon(1,info.icon,false)
item:SetChildActive(2,count~=i)
item:SetChildText(3,info.name)









end

end

function UIFightPrepareWin:refreshMoneyCostPanel()

local isShowCost=self.costList and next(self.costList)~=nil or false
self.moneyCost:setActive(isShowCost)
if isShowCost then
local cost=self.costList[1]
local moneyType=cost[1]
local moneyCount=cost[2]
local hasCount=itemsModel.getCount(moneyType)
local countStr=mathHelper.formatNumber(moneyCount)
if hasCount<moneyCount then
countStr=FMT.cfmt(FONT_COLOR.eRedColor,countStr)
end
self.moneyCostCountText:setText(countStr)
self.moneyCostIcon:setIcon(iconHelper.getIconName(moneyType),false)
end
end

function UIFightPrepareWin:onSelectClickDown()
if self.sureBodyAnim then
self.selectButton:setChildModelAnimationState(self.sureBodyAnim)
else
self.selectButton:setChildModelAnimationState(eAnimationID.idle1)
end
end

function UIFightPrepareWin:clearAndStartFight()
self.executeCallback=nil
self:onSelectButton()
end


function UIFightPrepareWin:onSelectButton()
local checkStart,idx=self:checkCanStart(true)
if not checkStart then
self.on_team_select(0,idx-1)
return
end
if self.executeCallback then
local guidList,guidCnt=self.getSortGuidList()
self.executeCallback(guidList)
return
end
if self.cantEnter then
if self.cantEnterTips then
UIManager.error(self.cantEnterTips)
end
return
end
local iscat=self:getIsCatFright()
if not iscat then
return
end
if _this.catCatMiJing then
if _this.CatFrightDialougeFlag then
self:getIsCatFrightDialouge()
return
end
end

if self.noDzSZFunc and self.noDzSZFuncIndex then
if not self.noDzSZFuncFlag then
self.noDzSZFuncFlag=true
self:getNoDzSZFuncDialouge()
return
end
end

if self.checkTeamFullDzFunc and self.notFullTeamIndex then
if not self.checkTeamFullDzDialougeFlag and not self.noDzSZFuncFlag then
self.checkTeamFullDzDialougeFlag=true
self:getTeamNotFullDzDialouge()
return
end
end
local guidList,guidCnt,multi=self.getSortGuidList()

if guidCnt>=minSelect then
if guidCnt>maxSelect then
return UIManager.error(FMT.fmt("出阵人数不得大于{0}",maxSelect))
end

if not self:checkMust(guidList)then
local dzStr=nil
for i,v in ipairs(self.mustList)do
if dzStr then
dzStr=FMT.fmt("{0}、{1}",dzStr,UIDiscipleModel:getDiscipleName(v))
else
dzStr=UIDiscipleModel:getDiscipleName(v)
end
end
return UIManager.error(FMT.fmt("需将弟子 {0} 排入阵容",dzStr))
end

if self.plotDiscipleList and next(self.plotDiscipleList)then
if guidCnt<maxSelect then
return UIManager.error("此次历练凶险,需派遣5名弟子")
end
end

if not self:checkPlotDisciple(guidList,true)then
return
end

if not self.isHomeBattle then

if not self:checkDispatchCondition(guidList,true,multi)then

return
end
end
if self.gbslAddInfo then
local check=false
for i,v in pairs(guidList)do
if v[1]==fightPreSelectModel.teamEntityType.dizi and UIDiscipleModel:getDiscipleJob(v[2])==self.gbslAddInfo.job then
check=true
break
end
end
if not check then
UIManager.error(FMT.fmt("至少需要上阵1名{0}",UIDiscipleModel:getJobName(self.gbslAddInfo.job)))
return
end
end

local cb=self.enterCallBack
if cb then
if not self.needClosePreSelectStage then
return
end
local enterCB=function()
if not self.notNeedDealOverTime then

local delay=self:setTimer(10,1,function()
if self and not self.isClose then
self:onCancelFunc()
end
end)
self.needClosePreSelectStage=false
end
fightController:recordPreSelect()
if not self.teamSelectData then
fightPreSelectModel:setTeamData(self.fightType,self:getDiziList(),selectZF)
else
local sendList={}
local saveData={}
local otherData={self.mapId or 0,selectZF or 0}
for i,v in ipairs(guidList)do
sendList[i]={#v,v,otherData}
local sdata={}
for ii,vv in ipairs(v)do
local s=tostring(vv[2])
if s~='0'then
sdata[s]=ii
end
end
saveData[i]=sdata
end
if self.needSaveTeam~=false then
fightPreSelectModel:setMulTeamSaveData(self.fightType,saveData,self.linggen)
end
guidList=sendList
end
cb(guidList,selectZF or 0,self.mapId or 0)
end

self:checkFightWarring(enterCB)
end
else
if self.shanhaiyubeidui then
local cb=self.enterCallBack
if cb then
cb(guidList,selectZF or 0,self.mapId or 0)
else
return UIManager.error(FMT.fmt("请至少选择{0}名弟子",minSelect))
end
else
return UIManager.error(FMT.fmt("请至少选择{0}名弟子",minSelect))
end
end
end

function UIFightPrepareWin:onCancelButton()
if not self.needClosePreSelectStage then
return
end
roleAudioController:stopRoleSpeak()
self:onCloseFunc()
end

function UIFightPrepareWin:onCancelFunc()
local isFullOpen_=self.isFullOpen
local cb=self.cancelCallBack
local guidList,guidCnt,multi=self.getSortGuidList()
if isFullOpen_ and(not self.dontCloseStage)then
UIFullFightPrepareControl:closeActiveUI()
else
UIManager:closeWindow('UIFightPrepareWin')

end
if cb then
cb(guidList)
end
end

function UIFightPrepareWin:onCloseFunc()
local closeByCloud=self.closeByCloud
local closeByCloudDelay=self.closeByCloudDelay
local closeByCloudAuto=self.closeByCloudAuto
if closeByCloudAuto==nil and closeByCloudDelay==nil then
closeByCloudDelay=1
end
local func=function()
if self and not self.isClose then
self:onCancelFunc()
end
end
if closeByCloud then
loadingControl.openCloud(func,closeByCloudDelay,closeByCloudAuto)
else
func()
end
end

function UIFightPrepareWin:onTeamButton()
local teamList=self.getSortGuidList()
UIManager:showWindow("UIFightTeamPrefabPanel",{teamList=teamList,winName=self.__name})
end

function UIFightPrepareWin:onZfBtn()
if self.lockZhenFa then return end
local extraParams={

init=selectZF,
team=self:getDiziList(),
callback=function(zfId)
self:setZhenFa(zfId)
end
}
UIManager:showWindow('UIZhenFaChooseWin',extraParams)
end

function UIFightPrepareWin:onFazeBtn2()
self.faZeList2Vis=not self.faZeList2Vis
self.faZeList2Reddot=false
self:showFaZeList2()
end

function UIFightPrepareWin:onFazeBtn2Bg()
self.faZeList2Vis=false
self.faZeList2Reddot=false
self:showFaZeList2()
end

function UIFightPrepareWin:onFazeBtn3()
self.faZeList3Vis=not self.faZeList3Vis
self.faZeList3Reddot=false
self:showFaZeList3()
end

function UIFightPrepareWin:onFazeBtn3Bg()
self.faZeList3Vis=false
self.faZeList3Reddot=false
self:showFaZeList3()
end

function UIFightPrepareWin:setZhenFa(zfId)
selectZF=zfId
if selectZF then
local zfCfg=cfgHelper.get1(cfg_zhenfaconfig_get,selectZF)
self.zfIcon:setIcon(zfCfg.icon,false)
self.zfName:setText(zfCfg.name)
else
self.zfIcon:setIcon("",false)
self.zfName:setText("")
end
end


function UIFightPrepareWin:onAutoSelectButton(isInit)
isInit=isInit==true
local copyList={}
local guid=nil
local data=nil
local fight=nil
local lookUpKey=nil
local yuyindizilist={}
for i,v in ipairs(self.disciplesList)do
if v.uType==fightPreSelectModel.teamEntityType.npc then
guid=v.data.guid
lookUpKey=self.getLookUpKey(v.uType,tostring(guid))
if self:checkState(v,false)and not selectLookUp[lookUpKey]and not self:checkOtherTeam(guid)then
fight=fightPreSelectModel.getNPCFightValue(v.data.id)
data=v
data.index=i
data.fight=fight
data.guidStr=tostring(guid)
table.insert(copyList,data)
end
elseif v.uType==fightPreSelectModel.teamEntityType.dizi then
guid=tostring(v.data.netData.net.discipleguid)
lookUpKey=self.getLookUpKey(v.uType,tostring(guid))
if self:checkState(v,false)and not selectLookUp[lookUpKey]and not self:checkOtherTeam(guid)then
fight=_this:getDzFightValue(guid)
data=v
data.index=i
data.fight=fight
data.guidStr=guid
data.isSWDZ=UIDiscipleModel:isShuWuDiscipleEx(guid)
table.insert(copyList,data)
end
end
end
table.sort(copyList,function(a,b)
local aScore=a.fight
local bScore=b.fight
if a.data.netData then
if self.plotDiscipleList[a.data.netData.net.id]then
aScore=aScore+1000000000
end
if a.isSWDZ then
aScore=aScore-1000000000
end
end
if b.data.netData then
if self.plotDiscipleList[b.data.netData.net.id]then
bScore=bScore+1000000000
end
if b.isSWDZ then
bScore=bScore-1000000000
end
end
return aScore>bScore
end)

if#copyList>0 then
for i,v in ipairs(copyList)do
if self.teamSelectData then
if self.teamDZMaxNum then
local currTeam=self.selectIndex+1

if self:getTeamDZNum(currTeam)>=self.teamDZMaxNum[currTeam]then
break
end
end
end

if self:checkPosEnough()then
break
end
yuyindizilist[#yuyindizilist+1]=v.guidStr
_this.isShangZhenging=true
self.enhancedscrollscript:checkAndClick(nil,nil,v.index-1,nil,nil,nil,nil,i==1,true,not isInit)
end

roleAudioController:fightOneKeyRoleSpeak(yuyindizilist)
else
UIManager.info("暂无可上阵弟子")
end
end

function UIFightPrepareWin:onClearButton()
_this.isShangZhenging=false
if _this.specialfaze_templist and _this.specialfaze_fazeidx then
UIManager:invokeUIMethod('UISubAct_tgslFightExtraWin','refreshdizifaze',nil,nil)
end
if _this.specialfaze_fuyao_templist and _this.specialfaze_fuyao_fazeidx then
UIManager:invokeUIMethod('UISubAct_fyslFightExtraWin','refreshdizifaze',nil,nil)
end
if _this.lg_fuyao_templist and _this.lg_fuyao_alllevel then
UIManager:invokeUIMethod('UISubAct_fyslFightExtraWin','refreshlinggen',nil,nil)
end
if _this.ct_fuyao_templist and _this.ct_fuyao_alllevel then
UIManager:invokeUIMethod('UISubAct_fyslFightExtraWin','refreshcuiti',nil,nil)
end
self:clearSelect()
self:setFight()
end

function UIFightPrepareWin:onLongTouchDizi(id)
local disciplelist={}
local dis_guid
for i,v in pairs(self.disciplesList)do
if v.uType==fightPreSelectModel.teamEntityType.dizi then
table.insert(disciplelist,v.data)
if i==id then
dis_guid=v.data.netData.net.discipleguid
end
end
end
if dis_guid then

oneTabScreenController:openUI(SEC_FULL_TYPE.discipleInfoSecondary,{dis_guid=dis_guid})
end
end

function UIFightPrepareWin:checkFightWarring(enterCallBack)
if self.fightCompareTips and((self.monsterFight and selectFight*(self.fightCompareValue or 1)<self.monsterFight)or(self.fightCompareJingJie and self:getJingJie()<self.fightCompareJingJie))then
fightPreSelectModel:showCheckFightTips(self.fightType,self.fightCompareTips,enterCallBack)
else
enterCallBack()
end
end

function UIFightPrepareWin:doRefreshActiveCellViews()
self.enhancedscrollscript:doRefreshActiveCellViews()
end



function UIFightPrepareWin:onDragUpdate()

end


function UIPrepareEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end


function UIPrepareEnScroller:RefreshCell(dataIndex,cellIndex,cell)
local item=cell
if self.window and self.window.isClose then
return
end


item:SetChildNewBieComponentId(14,'UIFightPrepareWin.DiscipleItem'..dataIndex)

local unitData=self.window.disciplesList[dataIndex]
local modelId
local guid
local lookUpKey
if unitData.uType==fightPreSelectModel.teamEntityType.dizi then
local netdata=unitData.data.netData.net
UIDiscipleModel:setDiscipleXianMoBackImage(item,roleItemIndex.xianmoBg,netdata)
guid=netdata.discipleguid
local guidStr=tostring(guid)
modelId=netdata.discipleimage
lookUpKey=self.window.getLookUpKey(unitData.uType,guidStr)
item:SetChildText(roleItemIndex.name,UIDiscipleModel:getDiscipleName(guid))
item:SetChildActive(roleItemIndex.tgslflag,false)
item:SetChildActive(roleItemIndex.flsybg,false)
if _this.specialfaze_templist and _this.specialfaze_fazeidx then
local tgslflag=UIFightPrepareWin:Checkspecialfaze(guid)
item:SetChildCSImageSprite(roleItemIndex.tgslflag,tgslabname,"image_shilianboss_09")
item:SetChildActive(roleItemIndex.tgslflag,tgslflag)
end
if _this.specialfaze_fuyao_templist and _this.specialfaze_fuyao_fazeidx then
local tgslflag=UIFightPrepareWin:Checkspecialfazefuyao(guid)
item:SetChildCSImageSprite(roleItemIndex.tgslflag,tgslabname,"image_shilianboss_09")
item:SetChildActive(roleItemIndex.tgslflag,tgslflag)
end
if _this.lg_fuyao_templist and _this.lg_fuyao_alllevel then
local tgslflag=UIFightPrepareWin:CheckspecialfazeLGfuyao(guid)
item:SetChildCSImageSprite(roleItemIndex.tgslflag,tgslabname,"image_shilianboss_09")
item:SetChildActive(roleItemIndex.tgslflag,tgslflag)
local lglevel=UIDiscipleModel:getDiscipleTotalLinggenLevel(guid)
if lglevel>0 then
item:SetChildActive(roleItemIndex.flsybg,true)
item:SetChildText(roleItemIndex.flsytxt,FMT.fmt("灵:{0}级",lglevel))
end
end
if _this.ct_fuyao_templist and _this.ct_fuyao_alllevel then
local tgslflag=UIFightPrepareWin:CheckspecialfazeCTfuyao(guid)
item:SetChildCSImageSprite(roleItemIndex.tgslflag,tgslabname,"image_shilianboss_09")
item:SetChildActive(roleItemIndex.tgslflag,tgslflag)
if netdata.qzctlv>0 then
item:SetChildActive(roleItemIndex.flsybg,true)
item:SetChildText(roleItemIndex.flsytxt,FMT.fmt("体:{0}级",netdata.qzctlv))
end
end

local isBanVoc=false
if _this.xbsl_datas then
if _this.xbsl_buff_joblist then
local tuijianflag=UIFightPrepareWin:CheckspecialfazeJobTuiJian_xbsl(guid)
item:SetChildCSImageSprite(roleItemIndex.tgslflag,tgslabname,"image_shilianboss_09")
item:SetChildActive(roleItemIndex.tgslflag,tuijianflag)
end

if _this.xbsl_ban_voclist then
local vocbanflag=UIFightPrepareWin:CheckspecialfazeVocBan_xbsl(guid)
item:SetChildActive(roleItemIndex.banFlag,vocbanflag)
isBanVoc=vocbanflag
end
end

if _this.checkBanFlagFunc then
local checkFlag=_this.checkBanFlagFunc(guid)
item:SetChildActive(roleItemIndex.ban,checkFlag)
end

if _this.checkXingYuFlagFunc then
local checkFlag=_this.checkXingYuFlagFunc(guid)
item:SetChildActive(roleItemIndex.xingyu,checkFlag)
end

local isXJOccupy=false
if _this.isCheckXJOccupyType then
local dzState,stateStr=xianjieModel:getDZState(netdata.discipleguid,true)
local isOccupy=dzState~=nil
isXJOccupy=isOccupy
item:SetChildActive(roleItemIndex.xjState,isOccupy)
if isOccupy then
item:SetChildText(roleItemIndex.xjStateName,stateStr)
end
end

local sortTypeArgs=self.window.sortTypeList[m_sorttypeindex]
local hasSortType_lookup={}
if type(sortTypeArgs)=="table"then
for _,sortType in pairs(sortTypeArgs)do
hasSortType_lookup[sortType]=true
end
else
local sortType=sortTypeArgs
hasSortType_lookup[sortType]=true
end
if hasSortType_lookup[eDiscipleSortType.eJingJieSort]then
local jjlv=netdata.jingjielv
local n,p,pN=UIDiscipleModel:getJJNameX(jjlv)
local jj_str=''
if p~=nil then
jj_str=FMT.fmt('{0}{1}阶',n,p)
else
jj_str=n
end
item:SetChildText(roleItemIndex.fight,jj_str)
elseif hasSortType_lookup[eDiscipleSortType.eLianTiSort]then
local ltlv=netdata.liantilv
local n1,p1=UIDiscipleModel:getLTNameX(ltlv)
local lt_str=''
if p1~=nil then
lt_str=FMT.fmt('{0}{1}层',n1,p1)
else
lt_str=n1
end
item:SetChildText(roleItemIndex.fight,lt_str)
else
local fightValue=_this:getDzFightValue(guid)
item:SetChildText(roleItemIndex.fight,FMT.fmt('<color=#7d3b17>战</color> {0}',UIDiscipleModel:fightValueConversion(fightValue)))
end
if selectLookUp[lookUpKey]~=nil then
selectLookUp[lookUpKey]=dataIndex
item:SetChildActive(4,true)
else
item:SetChildActive(4,false)
end

item:SetChildActive(roleItemIndex.juqing,self.window.plotDiscipleList[netdata.id]~=nil)
item:SetChildActive(roleItemIndex.zanli,self.window.plotGrayDiscipleList[netdata.id]~=nil)

local dzState=UIDiscipleModel:getDiscipleState(guid)

local checkChuiWei=UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.eChuiWei)

if self.window.statePriorityCheck and fightPreSelectModel.fightType.worldExperienceBoss~=self.window.fightType then
if dzState==DISCIPLE_STATE_TYPE.eFree then
if not netdata:check_in()and worldController:checkNoticiateBlockOpen()then
item:SetChildActive(17,true)
item:SetChildText(2,"无居所")
else
item:SetChildActive(17,false)
end
item:SetChildActive(9,false)
elseif dzState==DISCIPLE_STATE_TYPE.eChuiWei then
item:SetChildActive(17,false)
elseif dzState==DISCIPLE_STATE_TYPE.eInjuryChuiWei or dzState==DISCIPLE_STATE_TYPE.eShouYuanChuiWei then
item:SetChildActive(17,false)
else
DISCIPLE_STATE_TYPE.getFreeName()
item:SetChildActive(17,true)
if not netdata:check_in()then
item:SetChildText(2,"无居所")
else
item:SetChildText(2,DISCIPLE_STATE_TYPE:getName(dzState))
end
end
elseif self.window.checkSignType then
local show=UIDiscipleModel:haveDiscipleSign(netdata.discipleguid,self.window.checkSignType)
local cmp=_signTypeCmp[self.window.checkSignType]
item:SetChildActive(cmp,show)
item:SetChildActive(17,false)




else
item:SetChildActive(17,false)
end

if _this.isCheckLingShanState then
local check=UILSZDControl:isDiZiInLingShan(netdata.discipleguidStr)
item:SetChildActive(roleItemIndex.state2,check)
if check then
item:SetChildText(roleItemIndex.stateName,'已入驻')
end
end

local checkLowLoyalty=UIDiscipleModel:checkLowLoyalty(guid)
local injury=UIDiscipleModel:getDiscipleInjury(guid)
local injury_icon=eInjuryType:getIcon(injury)
local showinjury=injury_icon~=nil
if _this.skipChuiWeiCheck then
checkChuiWei=false
if not _this.isCheckInjuryState then
showinjury=false
end
end
if _this.skipDiscipleInjuryCheck then
checkLowLoyalty=false
end
local sData=nil
local showElseIcon=nil
local elseABName=nil
local elseMask=false
if _this.dzInfoFuncList then
sData=_this.dzInfoFuncList[guidStr]
if sData and sData.getStateIcon then
showElseIcon,elseABName=sData.getStateIcon(guid)
elseMask=sData.checkMask(guid)
if sData.isUseXJStateBg then
item:SetChildActive(roleItemIndex.xjState,isXJOccupy or elseMask)
if elseMask then
local stateStr=sData.getStateStrFunc(guid)
item:SetChildText(roleItemIndex.xjStateName,stateStr)
end
end
end
end
local showElse=showElseIcon~=nil

item:SetChildActive(roleItemIndex.state,(checkChuiWei or showinjury or checkLowLoyalty or showElse)and(not self.window.plotDiscipleList[netdata.id]and not self.window.plotGrayDiscipleList[netdata.id]))

item:SetChildActive(9,checkChuiWei or checkLowLoyalty or elseMask or self.window.plotGrayDiscipleList[netdata.id]~=nil or isBanVoc)
if checkChuiWei then
item:SetChildCSImageSprite(roleItemIndex.state,globalab,'image_zhuangtai_3')
elseif checkLowLoyalty then
item:SetChildCSImageSprite(roleItemIndex.state,globalab,'image_zhuangtai_4')
elseif showinjury then
item:SetChildCSImageSprite(roleItemIndex.state,globalab,injury_icon)
elseif showElse then
if elseABName==nil then
elseABName=globalab
end
item:SetChildCSImageSprite(roleItemIndex.state,elseABName,showElseIcon)
end


local bloodData=nil
if sData and sData.getBlood then
bloodData=sData.getBlood(guid)
end
local showBlood=bloodData~=nil
item:SetChildActive(roleItemIndex.blood,showBlood)
if showBlood then
local blood_rate=bloodData[1]
local blood_txt=bloodData[2]
item:SetChildIconFillAmount(roleItemIndex.bloodProgress,blood_rate or 0)
item:SetChildText(roleItemIndex.bloodNum,blood_txt or'')
end

comHelper.setChildModelRawImage(item,guid,3,0,eHeadCenterType.eHalf)

local color=UIDiscipleModel:getDiscipleColor(guid)
item:SetChildCSImageSprite(roleItemIndex.color,diziabname,ColorToFrame[color])

local jobIcon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildCSImageSprite(roleItemIndex.job,globalab,jobIcon)
local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(roleItemIndex.spDzFlag,isSpDz)

local currTeam=_this:getDZTeam(guid)
if currTeam and _this.selectIndex and currTeam~=_this.selectIndex+1 then
item:SetChildActive(roleItemIndex.teamIcon,true)
item:SetChildCSImageSprite(roleItemIndex.teamIcon,globalABLookup.fight_prepare,FMT.fmt('icon_duibiao_{0}',currTeam))
else
item:SetChildActive(roleItemIndex.teamIcon,false)
end
if _this.dzSpeakList and _this.dzSpeakList[guidStr]then
item:SetChildText(roleItemIndex.tipsTx,_this.dzSpeakList[guidStr])
item:SetChildActive(roleItemIndex.tipsBg,true)
else
item:SetChildText(roleItemIndex.tipsTx,"")
item:SetChildActive(roleItemIndex.tipsBg,false)
end
local must=_this.mustList and table.containsValueEx(_this.mustList,guid,function(value)return tostring(value)end)or false
item:SetChildActive(roleItemIndex.must,must)

UIDiscipleController.refreshCommonItemTianMing(item,netdata,26)

if self.window.gbslAddInfo then
local isAddJob=self.window.gbslAddInfo.job==UIDiscipleModel:getDiscipleJob(guid)
if isAddJob then
local jjLv=UIDiscipleModel:getDiscipleJJLevel(guid)
local ltLv=UIDiscipleModel:getDiscipleLTLevel(guid)
local sumLv=jjLv+ltLv
for i,v in ipairs(self.window.gbslAddInfo.list)do
if v[1]<=sumLv and sumLv<=v[2]then
item:SetChildActive(roleItemIndex.otherBg,true)
local str=nil
for j,w in ipairs(v[3])do
local fzId=w[1]
local fzLv=w[2]
local fzRuleCfg=cfgHelper.getSSlawRule(fzId)
local hasParam=fzRuleCfg.descparm and fzRuleCfg.descparm[fzLv]and true or false
local fzdesc=not hasParam and fzRuleCfg.desc or string.format(fzRuleCfg.desc,unpack(fzRuleCfg.descparm[fzLv]))
str=str and FMT.fmt("{0} {1}",str,fzdesc)or fzdesc
end
item:SetChildText(roleItemIndex.otherTx,str)
return
end
end
end
end
item:SetChildActive(roleItemIndex.otherBg,false)


item:SetChildActive(roleItemIndex.myzs,_this.isMYZS)
if _this.isMYZS then
local discipleData_MYZS=myzsModel:getDiscipleDataByGuid(guid)
if discipleData_MYZS then
local isDeath=discipleData_MYZS.hpPercent<=0

item:SetChildActive(roleItemIndex.myzs_ll,not isDeath)
item:SetChildActive(roleItemIndex.myzs_hp,discipleData_MYZS.hpPercent>0)

item:SetChildActive(roleItemIndex.myzs_death,isDeath)

if isDeath then


else
item:SetChildIconFillAmount(roleItemIndex.myzs_hpbar,discipleData_MYZS.hpPercent/100)
item:SetChildText(roleItemIndex.myzs_hptxt,string.format("%d%%",discipleData_MYZS.hpPercent))

local ll_color=discipleData_MYZS.llPercent>0 and"#aae252"or"#f36666"
item:SetChildText(roleItemIndex.myzs_lltxt,toColorStringX(ll_color,string.format("灵力:%d%%",discipleData_MYZS.llPercent)))









end
else
logErr("未找到冥渊诛煞弟子特殊数据")
item:SetChildActive(roleItemIndex.myzs,false)
end
end

elseif unitData.uType==fightPreSelectModel.teamEntityType.npc then
guid=unitData.data.guid
modelId=fightPreSelectModel.getNPCOutSideModel(unitData.data.id)
lookUpKey=_this.getLookUpKey(unitData.uType,tostring(guid))
local npcConfig=fightPreSelectModel.getNPCConfig(unitData.data.id)
local imageInfo=fightPreSelectModel.getNPCInSideModel(unitData.data.id)
if imageInfo then
item:SetChildModelCaptureImage(3,imageInfo.body,imageInfo.componets,1,0,0,0,Vector2(0,15),1,false)
end
item:SetChildText(roleItemIndex.name,npcConfig.name)
local color=fightPreSelectModel.getNPCColor(unitData.data.id)
item:SetChildCSImageSprite(roleItemIndex.color,diziabname,ColorToFrame[color])
item:SetChildText(roleItemIndex.fight,FMT.fmt('{0} {1}',FMT.cfmt(FONT_COLOR.eOrangeColor,'战'),UIDiscipleModel:fightValueConversion(fightPreSelectModel.getNPCFightValue(unitData.data.id))))
local jobIcon=fightPreSelectModel:getJobIconNameX(unitData.data.id)
item:SetChildCSImageSprite(roleItemIndex.job,globalab,jobIcon)
item:SetChildActive(roleItemIndex.spDzFlag,false)

item:SetChildActive(12,true)
item:SetChildActive(roleItemIndex.teamIcon,false)

item:SetChildText(roleItemIndex.tipsTx,"")
item:SetChildActive(roleItemIndex.tipsBg,false)
item:SetChildActive(roleItemIndex.must,false)

item:SetChildActive(roleItemIndex.otherBg,false)
end

if selectLookUp[lookUpKey]~=nil then
_this:setFight()
end
end

function UIPrepareEnScroller:onItemClick(data,cellIndex,dataIndex,cell,exchangeIndex,behaviour,notTips,appearTips)
if self.isLongTouch then
return
end

if not _this:checkTaskLimit(true)then
return
end

self:checkAndClick(data,cellIndex,dataIndex,cell,exchangeIndex,behaviour,notTips,appearTips)
end

function UIPrepareEnScroller:checkAndClick(data,cellIndex,dataIndex,cell,exchangeIndex,behaviour,notTips,appearTips,isInit,warring)
dataIndex=dataIndex+1

if _this.teamSelectData then
local unitData=_this.disciplesList[dataIndex]
_this:checkAndPlaceToTeam(unitData.data.netData.net.discipleguid,function()
self:onItemClickEx(data,cellIndex,dataIndex,cell,exchangeIndex,behaviour,notTips,appearTips,isInit,warring)
end)
else
self:onItemClickEx(data,cellIndex,dataIndex,cell,exchangeIndex,behaviour,notTips,appearTips,isInit,warring)
end
end

function UIPrepareEnScroller:onItemClickEx(data,cellIndex,dataIndex,cell,exchangeIndex,behaviour,notTips,appearTips,isInit,warring)
warring=warring or warring==nil
local unitData=_this.disciplesList[dataIndex]
local modelId
local guid
local jobId
if unitData.uType==fightPreSelectModel.teamEntityType.dizi then
local netdata=unitData.data.netData.net
guid=netdata.discipleguid
modelId=netdata.discipleimage
jobId=UIDiscipleModel:getDiscipleJob(guid)
elseif unitData.uType==fightPreSelectModel.teamEntityType.npc then
guid=unitData.data.guid
modelId=fightPreSelectModel.getNPCOutSideModel(unitData.data.id)
jobId=fightPreSelectModel.getNPCJob(unitData.data.id)
end

local lookUpKey=_this.getLookUpKey(unitData.uType,tostring(guid))


if not _this:checkState(unitData,warring,isInit)then
return
end

local tipsStr=nil
if jobId and appearTips then
local speakList=cfgHelper.get(cfg_disciplevocationbuildspeakconfig_get,jobId,"preparespeak")
tipsStr=speakList[math.random(1,#speakList)]
end

if selectLookUp[lookUpKey]then
if unitData.uType~=fightPreSelectModel.teamEntityType.npc then
selectNum=selectNum-1
local guidIndex=_this.getGUIDIndex(unitData.uType,guid)
selectList[guidIndex]=nil
selectLookUp[lookUpKey]=nil
_this:addDZToTeam(guidIndex,nil)
if cell then
cell:SetChildActive(4,false)
else
cell=self:GetCell(dataIndex-1)
if cell then
cell:SetChildActive(4,false)
end
end
_this.selectStage:removeEntity(guidIndex)
_this:setFight()
else
UIManager.error("助战仙友无法下阵")
end
else
local shangzhenCB=function()
local check=true
if _this.selectIndex then
local currTeam=_this.selectIndex+1

if _this.teamDZMaxNum and _this:getTeamDZNum(currTeam)>=_this.teamDZMaxNum[currTeam]then
local unitData=_this.disciplesList[dataIndex]
if not _this:getDZTeam(unitData.data.netData.net.discipleguid)then
check=false
end
end
end
if check then
if self.window:checkPosEnough()then
check=false
end
end

if exchangeIndex then

if selectList[exchangeIndex]then
if selectList[exchangeIndex][1]==fightPreSelectModel.teamEntityType.npc then
UIManager.error("助战仙友无法下阵")

return
end
local otherType=selectList[exchangeIndex][1]
local otherGUID=selectList[exchangeIndex][2]
local guidString=_this.getLookUpKey(otherType,tostring(otherGUID))
local tempDataIndex=selectLookUp[guidString]
selectLookUp[guidString]=nil
local changeCell=self:GetCell(tempDataIndex-1)
if changeCell then
changeCell:SetChildActive(4,false)
end
local guidIndex=_this.getGUIDIndex(unitData.uType,otherGUID)
if guidIndex then
_this:addDZToTeam(guidIndex,nil)
end
_this.selectStage:removeEntity(exchangeIndex)
else
if not check then
UIManager.error('队伍人数已达上限')
return
end
selectNum=selectNum+1
end
_this:addDZToTeam(exchangeIndex,guid,unitData.uType)
selectLookUp[lookUpKey]=dataIndex
selectList[exchangeIndex]={unitData.uType,guid,unitData.data.id and int64.new(unitData.data.id)or guid}
if cell then
cell:SetChildActive(4,true)
else
cell=self:GetCell(dataIndex-1)
if cell then
cell:SetChildActive(4,true)
end
end

_this:addEntity(exchangeIndex,unitData.uType,unitData.data.monsterId,guid,modelId,jobId,behaviour,tipsStr)
_this:setFight()
else
if not check then
UIManager.error('队伍人数已达上限')
return
end
local emptyIndex=_this.getJobPosPriorty(jobId)
if emptyIndex then
_this:addDZToTeam(emptyIndex,guid,unitData.uType)
selectNum=selectNum+1
selectList[emptyIndex]={unitData.uType,guid,unitData.data.id and int64.new(unitData.data.id)or guid}
selectLookUp[lookUpKey]=dataIndex
if cell then
cell:SetChildActive(4,true)
else
cell=self:GetCell(dataIndex-1)
if cell then
cell:SetChildActive(4,true)
end
end
_this:addEntity(emptyIndex,unitData.uType,unitData.data.monsterId,guid,modelId,jobId,behaviour,tipsStr)
_this:setFight()


AudioManager.playAudio(454)

if _this.isShangZhenging==false and _this.isShangZhenginit==false then
roleAudioController:playRoleSpeakMany(guid,roleAudioNodeType.Fight_Shangzhen)
end
end
end
end

local shangzhenCBEx=function()
local showAsk=false
if not isInit and unitData.uType==fightPreSelectModel.teamEntityType.dizi then
local netData=unitData.data.netData.net
if UIDiscipleModel:isShuWuDisciple(netData.id)then
showAsk=true
_this:showDialogue('庶务弟子并不擅长斗法，确认让其参战吗？',function()
shangzhenCB()
end)
end
end
if not showAsk then
shangzhenCB()
end
end

local isPlantCreate=UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.ePlantCreate)
if not notTips and isPlantCreate then
fightPreSelectModel:showProductiontips(UIDiscipleModel:getDiscipleName(guid),shangzhenCBEx)
else
shangzhenCBEx()
end
end
if _this.specialfaze_templist and _this.specialfaze_fazeidx then
UIFightPrepareWin:CheckspecialfazeNow()
end
if _this.specialfaze_fuyao_templist and _this.specialfaze_fuyao_fazeidx then
UIFightPrepareWin:CheckspecialfazeNowfuyao()
end
if _this.lg_fuyao_templist and _this.lg_fuyao_alllevel then
UIFightPrepareWin:CheckspecialfazeNowLGfuyao()
end
if _this.ct_fuyao_templist and _this.ct_fuyao_alllevel then
UIFightPrepareWin:CheckspecialfazeNowCTfuyao()
end

if _this.sfpy_enter then
UIManager:invokeUIMethod('UISiFangPingYaoExtraWin','onFazeMask')
UIManager:invokeUIMethod('UISiFangPingYaoExtraWin','getShangZhendizi',selectList)
end

notifySystem:postNotify(notifyConfig.onFightPrepareSelectChange,selectList)

self.window:showAutoSelectButton()
end

function UIPrepareEnScroller:onItemBeginDrag(dataIndex,screenPos,cell)
if not _this:checkTaskLimit(true)then
return
end

dataIndex=dataIndex+1

local unitData=_this.disciplesList[dataIndex]
local modelId,jobid
local guid
local lookUpKey
if unitData.uType==fightPreSelectModel.teamEntityType.dizi then
local netdata=unitData.data.netData.net
guid=netdata.discipleguid
modelId=netdata.discipleimage
lookUpKey=_this.getLookUpKey(unitData.uType,tostring(guid))
jobid=UIDiscipleModel:getDiscipleJob(netdata.discipleguid)
local dzState=UIDiscipleModel:getDiscipleState(netdata.discipleguid)
elseif unitData.uType==fightPreSelectModel.teamEntityType.npc then
jobid=fightPreSelectModel.getNPCJob(unitData.data.id)
return
end

if selectLookUp[lookUpKey]then
dragBeginData={dataIndex,screenPos,cell}
end
_this:addEntity(-1,unitData.uType,unitData.data.monsterId,guid,modelId,jobid)

end

function UIPrepareEnScroller:onItemDrag(dataIndex,screenPos)
end

function UIPrepareEnScroller:onItemEndDrag(dataIndex,screenPos,cell)
if not _this:checkTaskLimit(true)then
return
end
dragEndData={dataIndex,screenPos,cell}
end


function UIFightPrepareWin:setFaZeItem(item,i,data)

end
function UIFightPrepareWin:showFaZeList()
local showCND=self.conditionDatas and#self.conditionDatas[1]>0

local len=self.faZeData and#self.faZeData or 0
if showCND then
len=len+1
end
local showOne=len==1 and not showCND
self.faZeOne:setActive(showOne)
if showOne then
local id=self.faZeData[1]
local item=self.faZeOne:getWidgetBase()
local cfg=cfgHelper.getSSlawRule(id)
item:SetChildText(0,cfg.desc)
item:SetChildIcon(1,cfg.image,true)
else
self.faZeList:setChildScrollViewCreateGrids(len,0)
self.grids=self.faZeList:getChildScrollViewItemWidgets()
local count=self.grids.Count
for i=1,count do
local item=self.grids[i-1]
if showCND then
if i==1 then
local cdata=self.conditionDatas[1][1]
self.teamDZMaxNum=cdata.cnd[2]
local sstr
for ii,vv in ipairs(self.teamDZMaxNum)do
local c=FMT.fmt(cdata.text,ii,vv)
if sstr then
sstr=FMT.fmt('{0}\n{1}',sstr,c)
else
sstr=c
end
end
item:SetChildText(0,sstr)
item:SetChildIcon(1,cdata.image,true)
else
local id=self.faZeData[i-1]
local cfg=cfgHelper.getSSlawRule(id)
item:SetChildText(0,cfg.desc)
item:SetChildIcon(1,cfg.image,true)
end
else
local id=self.faZeData[i]
local cfg=cfgHelper.getSSlawRule(id)
item:SetChildText(0,cfg.desc)
item:SetChildIcon(1,cfg.image,true)
end
end
end

end

function UIFightPrepareWin:setConditionList()
if not self.conditionDatas then
return
end
local cndData=self.conditionDatas[2]

local len=#cndData
self.conditionList:setChildScrollViewCreateGrids(len,1)
self.grids=self.conditionList:getChildScrollViewItemWidgets()
local count=self.grids.Count
for i=1,count do
local item=self.grids[i-1]
local data=cndData[i]
item:SetChildText(0,data.text)
end
end

function UIFightPrepareWin:addDZToTeam(index,guid,ntype)
if not self.teamSelectData then
return
end

local teamList=self.teamSelectData[self.selectIndex+1]or{}
if not guid then
for k,v in pairs(teamList)do
if v[1]==index then
teamList[k]=nil
break
end
end
else
local guidStr=tostring(guid)
teamList[guidStr]={index,ntype,guid}
end
self.teamSelectData[self.selectIndex+1]=teamList
end

function UIFightPrepareWin:checkOtherTeam(guid)
if not self.teamSelectData then
return false
end
local currTeam=self.selectIndex+1
local lastTeam=self:getDZTeam(guid)
return lastTeam and lastTeam~=currTeam
end

function UIFightPrepareWin:checkAndPlaceToTeam(guid,callback)













local guidStr=tostring(guid)
local currTeam=self.selectIndex+1
local lastTeam=self:getDZTeam(guid)
if self.teamLockCfgList and self.teamLockCfgList[lastTeam]and self.teamLockCfgList[lastTeam].lockFlag then
UIManager.info(self.teamLockCfgList[lastTeam].dzlockTips)
return
end


if lastTeam and lastTeam~=currTeam then
local name=UIDiscipleModel:getDiscipleName(guid)
fightPreSelectModel:showCheckMultiFightTips(FMT.fmt('{0}已在<color=#ca631d>第{1}队</color>上阵，是否将该弟子上阵至当前队伍？',name,lastTeam),function()
self.teamSelectData[lastTeam][guidStr]=nil
callback()
self.enhancedscrollscript:doRefreshActiveCellViews()
end)
else
callback()
end
end

function UIFightPrepareWin:getDZTeam(guid)
if not self.teamSelectData then
return
end
local guidStr=tostring(guid)
for i,v in ipairs(self.teamSelectData)do
if v[guidStr]then
return i
end
end
return nil
end


function UIFightPrepareWin:getTeamDZNum(teamId)
if not self.teamSelectData then
return 0
end
local count=0
for i,v in ipairs(self.teamSelectData)do
if not teamId or i==teamId then
for k,vv in pairs(v)do
count=count+1
end
end
end
return count
end


function UIFightPrepareWin:getCurTeamDZNumInMuitiTeam()
if not self.teamSelectData then
return 0
end
local count=0
local list=self.teamSelectData[self.selectIndex+1]or{}
for i,v in pairs(list)do
count=count+1
end
return count
end

function UIFightPrepareWin.on_team_select(cnum,index)
if _this.selectIndex==index then
return
end

local isUnlock=true
if _this.teamUnlockCNDFuncList and _this.teamUnlockCNDFuncList[index+1]then
local checkFunc=_this.teamUnlockCNDFuncList[index+1]
isUnlock=checkFunc()
end
if _this.teamLockCfgList and _this.teamLockCfgList[index+1]and _this.teamLockCfgList[index+1].lockFlag then
isUnlock=false
end
if not isUnlock then
return
end

if _this.selectIndex then
local widget=_this.teamList:getChildScrollViewItemWidget(_this.selectIndex)
if widget then
widget:SetChildActive(0,false)
end
end

_this.selectIndex=index

local widget=_this.teamList:getChildScrollViewItemWidget(_this.selectIndex)
if widget then
widget:SetChildActive(0,true)
end

_this:showSelectTeam()


_this.selectStage:clearEntity(false)

if _this.multipleMonsterList then
_this:refreshMonsterModelPanel(_this.multipleMonsterList[index+1])
end
if _this.multipleMonsterListEx then
_this:refreshMonsterModelPanelEx(_this.multipleMonsterListEx[index+1])
end
if _this.monsterFightEx then
_this:setMonsterFight()
end


_this:setFight()

if _this.lockSelectList and _this.lockSelectList[index+1]then
_this.lockSelect=_this.lockSelectList[index+1]
end
if _this.isSortByTeamSelect then
_this:getNetDataList()
_this:refreshRoleList()
end

if _this.defTeamLingGenLimitlist then
local lgInfo=_this.defTeamLingGenLimitlist[index+1]
local bgInfo=lgInfo[1]
local spriteInfo=lgInfo[2]

if pfwindowslController:checkIsGameVersion_yuenan()then
if bgInfo[1]==9 then
spriteInfo[2]=50
elseif bgInfo[1]==10 then
spriteInfo[2]=85
end
end
iconHelper.setChildIcon_1(_this.winlua,_this.defTeamLgBg:getID(),bgInfo[1],bgInfo[4],bgInfo[5],bgInfo[2],bgInfo[3])
iconHelper.setChildIcon_1(_this.winlua,_this.defTeamLgImage:getID(),spriteInfo[1],spriteInfo[4],spriteInfo[5],spriteInfo[2],spriteInfo[3])
end

end

function UIFightPrepareWin:refreshMonsterTeam(index)

end

function UIFightPrepareWin.postPrepareChangeTeamEvent(flag)
notifySystem:postNotify(notifyConfig.onFightPrepareChangeTeam,flag)
end

function UIFightPrepareWin:showSelectTeam()
self.postPrepareChangeTeamEvent(true)
local teamList=self.teamSelectData[self.selectIndex+1]
self:clearSelect()
local lookup={}
for k,v in pairs(teamList)do
lookup[k]=v[1]
end

self:fastSelect(lookup,nil,self.leftPosBehavior,0.1,nil,self.postPrepareChangeTeamEvent)
end

function UIFightPrepareWin:showTeamList()
if not self.teamSelectData then
return
end
local len=#self.teamSelectData
if len<2 then
return
end
self.teamList:setChildScrollViewCreateGrids(len,1)
self.grids=self.teamList:getChildScrollViewItemWidgets()
local count=self.grids.Count
for i=1,count do
local item=self.grids[i-1]
item:SetChildActive(0,false)
item:SetChildText(1,FMT.fmt('第{0}队',i))

local isUnlock=true
local lockTipsStr=""
local lockClickFun
if self.teamUnlockCNDFuncList and self.teamUnlockCNDFuncList[i]then
local checkFunc=self.teamUnlockCNDFuncList[i]
isUnlock,lockTipsStr,lockClickFun=checkFunc()
end
item:SetChildActive(2,not isUnlock)
if not isUnlock then
item:SetChildText(3,lockTipsStr)
if not lockClickFun then
lockClickFun=function()
return
end
end
item:SetChildButtonClick(2,lockClickFun,true)
end

if self.teamLockCfgList and self.teamLockCfgList[i]and self.teamLockCfgList[i].lockFlag then
item:SetChildActive(4,true)
item:SetChildButtonClick(4,function()
UIManager.info(self.teamLockCfgList[i].teamlockTips)
end,true)
else
item:SetChildActive(4,false)
end
end
end

function UIFightPrepareWin:checkCanStart(wraning)
if not self.teamSelectData or self.kofMode~=nil then
return true
end
for i,v in ipairs(self.teamSelectData)do
local isUnlock=true
if self.teamUnlockCNDFuncList and self.teamUnlockCNDFuncList[i]then
local checkFunc=self.teamUnlockCNDFuncList[i]
isUnlock=checkFunc()
end

if self.teamLockCfgList and self.teamLockCfgList[i]and self.teamLockCfgList[i].lockFlag then
isUnlock=false
end

if self.checkSelectCnt and not self:checkHasSelectDz()then
isUnlock=false
end
if isUnlock then
if not next(v)then

if self.noDzSZFunc and not self:checkHasSelectDz()and not self.noDzSZFuncIndex then
self.noDzSZFuncIndex=i
return true
else
if wraning then
UIManager.error(FMT.fmt('第{0}队未有弟子上阵',i))
end
return false,i
end
else
if self.checkTeamFullDzFunc and not self.notFullTeamIndex then
local cnt=0
for k,vv in pairs(v)do
if not mathHelper.compareInt64(vv[3],Int64_0)then
cnt=cnt+1
end
end
if cnt~=0 and cnt<5 then
self.notFullTeamIndex=i
end
end
end
end
end
if self.mustHasDz then
local checkhasDz=false
























for i,v in ipairs(self.teamSelectData)do
if next(v)then
checkhasDz=true
break
end
end

if not checkhasDz then
UIManager.error('请选择弟子上阵')
return false,self.selectIndex+1
end
end

return true
end

function UIFightPrepareWin:checkMust(guidlist)
if self.mustList and#self.mustList>0 then
local dzList={}
for i,v in pairs(guidlist)do
if v[1]==fightPreSelectModel.teamEntityType.dizi then
table.insert(dzList,v[2])
end
end
for i,v in ipairs(self.mustList)do
if not table.containsValueEx(dzList,v,function(value)return tostring(value)end)then
return false
end
end
end
return true
end

function UIFightPrepareWin:checkPlotDisciple(guidlist,warring)
if self.plotDiscipleList then
local dzList={}
for i,v in pairs(guidlist)do
if v[1]==fightPreSelectModel.teamEntityType.dizi then
local netData=UIDiscipleModel:getDiscipleData(v[2])
if netData then
table.insert(dzList,netData)
end
end
end
local checkAll=true
for id,v in pairs(self.plotDiscipleList)do
local check=false
for i,v in ipairs(dzList)do
if v.id==id then
check=true
break
end
end
if not check then
checkAll=false
if warring then
local name=cfgHelper.get2(cfg_discipleconfig_get,id,"name")
UIManager.error(FMT.fmt("需将弟子{0}排入阵容",name))
end
end
end
return checkAll
end
return true
end


function UIFightPrepareWin:CheckspecialfazeNow()
if _this.specialfaze_templist and _this.specialfaze_fazeidx then

local templist=_this.specialfaze_templist
local maxfazeid=0
local diziID=nil
if selectList then
for k,v in pairs(selectList)do
for i,j in ipairs(templist)do
if v[3]==j[3]then
if maxfazeid<j[2]then
maxfazeid=j[2]
diziID=j[1]
end
end
end
end
end
UIManager:invokeUIMethod('UISubAct_tgslFightExtraWin','refreshdizifaze',diziID,diziID)
end
end

function UIFightPrepareWin:CheckspecialfazeInit(list)
if _this.specialfaze_templist and _this.specialfaze_fazeidx then

local templist=_this.specialfaze_templist
local maxfazeid=0
local diziID=nil
if list and#list>0 then
for k,v in pairs(list)do
for i,j in ipairs(templist)do
if v==j[3]then
if maxfazeid<j[2]then
maxfazeid=j[2]
diziID=j[1]
end
end
end
end
UIManager:invokeUIMethod('UISubAct_tgslFightExtraWin','refreshdizifaze',diziID,diziID)
end
end
end

function UIFightPrepareWin:Checkspecialfaze(guid)
if _this.specialfaze_templist and _this.specialfaze_fazeidx then
local netData=UIDiscipleModel:getDiscipleData(guid)
local diziid=netData.id
local list=_this.specialfaze_templist
local maxfaze_id=_this.specialfaze_fazeidx
if#list>0 and maxfaze_id then
for k,v in ipairs(list)do
if v[1]==diziid then

if v[2]==maxfaze_id then
return true
end
end
end
end
return false
else
return false
end
end


function UIFightPrepareWin:CheckspecialfazeNowfuyao()
if _this.specialfaze_fuyao_templist and _this.specialfaze_fuyao_fazeidx then

local templist=_this.specialfaze_fuyao_templist
local maxfazeid=0
local diziID=nil
if selectList then
for k,v in pairs(selectList)do
for i,j in ipairs(templist)do
if v[3]==j[3]then
if maxfazeid<j[2]then
maxfazeid=j[2]
diziID=j[1]
end
end
end
end
end
UIManager:invokeUIMethod('UISubAct_fyslFightExtraWin','refreshdizifaze',diziID,diziID)
end
end

function UIFightPrepareWin:CheckspecialfazeInitfuyao(list)
if _this.specialfaze_fuyao_templist and _this.specialfaze_fuyao_fazeidx then

local templist=_this.specialfaze_fuyao_templist
local maxfazeid=0
local diziID=nil
if list and#list>0 then
for k,v in pairs(list)do
for i,j in ipairs(templist)do
if v==j[3]then
if maxfazeid<j[2]then
maxfazeid=j[2]
diziID=j[1]
end
end
end
end
UIManager:invokeUIMethod('UISubAct_fyslFightExtraWin','refreshdizifaze',diziID,diziID)
end
end
end

function UIFightPrepareWin:Checkspecialfazefuyao(guid)
if _this.specialfaze_fuyao_templist and _this.specialfaze_fuyao_fazeidx then
local netData=UIDiscipleModel:getDiscipleData(guid)
local diziid=netData.id
local list=_this.specialfaze_fuyao_templist
local maxfaze_id=_this.specialfaze_fuyao_fazeidx
if#list>0 and maxfaze_id then
for k,v in ipairs(list)do
if v[1]==diziid then
if v[2]==maxfaze_id then
return true
end
end
end
end
return false
else
return false
end
end


function UIFightPrepareWin:CheckspecialfazeNowLGfuyao()
if _this.lg_fuyao_templist and _this.lg_fuyao_alllevel then

local alllglevel=0
if selectList then
for k,v in pairs(selectList)do
local guid=v[3]
local lglevel=UIDiscipleModel:getDiscipleTotalLinggenLevel(guid)
if lglevel>0 then
alllglevel=alllglevel+lglevel
end
end
end
UIManager:invokeUIMethod('UISubAct_fyslFightExtraWin','refreshlinggen',alllglevel,alllglevel)
end
end

function UIFightPrepareWin:CheckspecialfazeInitLGfuyao(list)
if _this.lg_fuyao_templist and _this.lg_fuyao_alllevel then
if list and#list>0 then
local alllglevel=0
for k,v in pairs(list)do
local guid=v
local lglevel=UIDiscipleModel:getDiscipleTotalLinggenLevel(guid)
if lglevel>0 then
alllglevel=alllglevel+lglevel
end
end
UIManager:invokeUIMethod('UISubAct_fyslFightExtraWin','refreshlinggen',alllglevel,alllglevel)
end
end
end

function UIFightPrepareWin:CheckspecialfazeLGfuyao(guid)
if _this.lg_fuyao_templist and _this.lg_fuyao_alllevel then
local netData=UIDiscipleModel:getDiscipleData(guid)
local diziid=netData.id
local list=_this.lg_fuyao_templist

if list[tostring(guid)]then
return true
else
return false
end
else
return false
end
end


function UIFightPrepareWin:CheckspecialfazeNowCTfuyao()
if _this.ct_fuyao_templist and _this.ct_fuyao_alllevel then

local alllglevel=0
if selectList then
for k,v in pairs(selectList)do
local guid=v[3]
local netData=UIDiscipleModel:getDiscipleData(guid)

local ltlv=netData.qzctlv
if ltlv>0 then
alllglevel=alllglevel+ltlv
end
end
end
UIManager:invokeUIMethod('UISubAct_fyslFightExtraWin','refreshcuiti',alllglevel,alllglevel)
end
end

function UIFightPrepareWin:CheckspecialfazeInitCTfuyao(list)
if _this.ct_fuyao_templist and _this.ct_fuyao_alllevel then
if list and#list>0 then
local alllglevel=0
for k,v in pairs(list)do
local guid=v
local netData=UIDiscipleModel:getDiscipleData(guid)

local ltlv=netData.qzctlv
if ltlv>0 then
alllglevel=alllglevel+ltlv
end
end
UIManager:invokeUIMethod('UISubAct_fyslFightExtraWin','refreshcuiti',alllglevel,alllglevel)
end
end
end

function UIFightPrepareWin:CheckspecialfazeCTfuyao(guid)
if _this.ct_fuyao_templist and _this.ct_fuyao_alllevel then
local netData=UIDiscipleModel:getDiscipleData(guid)
local diziid=netData.id
local list=_this.ct_fuyao_templist

if list[tostring(guid)]then
return true
else
return false
end
else
return false
end
end


function UIFightPrepareWin:CheckspecialfazeJobTuiJian_xbsl(guid)
if _this.xbsl_datas and _this.xbsl_buff_joblist then
local diziJob=UIDiscipleModel:getDiscipleJob(guid)
local list=_this.xbsl_buff_joblist
if list[diziJob]then
return true
else
return false
end
else
return false
end
end


function UIFightPrepareWin:CheckspecialfazeVocBan_xbsl(guid)
if _this.xbsl_datas and _this.xbsl_ban_voclist then
local diziJob=UIDiscipleModel:getDiscipleJob(guid)
local list=_this.xbsl_ban_voclist
if list[diziJob]then
return true
else
return false
end
else
return false
end
end


function UIFightPrepareWin:setCatFightPanel(selectFight)
if _this.catCatMiJing then

_this.winlua:SetChildCSImageSprite(_this.catprogressbar:getID(),catabname,"image_zhanliyqui_1")
_this.winlua:SetChildCSImageSprite(_this.catprogressValue:getID(),catabname,"image_zhanliyqui_3")
_this.winlua:SetChildCSImageSprite(_this.catprogressValueup:getID(),catabname,"image_zhanliyqui_2")

local cfg_mj_ditu=cfg_secretscenefubenconfig_get(_this.catCatMiJing)
if cfg_mj_ditu then
local maxfright=cfg_mj_ditu.teamFight or 100000
local maxfright_tj=cfg_mj_ditu.teamFightTuiJian or 100000
local cur=selectFight
local need=maxfright
local max=maxfright_tj
_this.catcanfright=cur>=need
_this.catprogresstext:setText(mathHelper.formatNumber(need))
if cur<max then
_this.CatFrightDialougeFlag=true
_this.CatFrightDialougeValue=max
else
_this.CatFrightDialougeFlag=false
end

if cur<=need then
local left=mathHelper.formatNumber(selectFight)
local right=mathHelper.formatNumber(max)
_this.winlua:SetChildProgressText(_this.catprogressbar:getID(),FMT.fmt('{0}/{1}',left,right))
local rate=cur/need
if rate>1 then
rate=0.7
else
rate=rate*0.7
end
_this.winlua:SetChildIconFillAmount(_this.catprogressValueup:getID(),rate)
_this.winlua:SetChildIconFillAmount(_this.catprogressValue:getID(),0)
else
local rate=cur/max
if rate>1 then
rate=1
elseif rate<0 then
rate=0
end
local left=mathHelper.formatNumber(selectFight)
local right=mathHelper.formatNumber(max)
_this.winlua:SetChildProgressText(_this.catprogressbar:getID(),FMT.fmt('{0}/{1}',left,right))
_this.winlua:SetChildIconFillAmount(_this.catprogressValueup:getID(),0.7)
_this.winlua:SetChildIconFillAmount(_this.catprogressValue:getID(),rate)
end

else
loggerUtil.log(FMT.fmt("UIFightPrepareWin cat mijinid not find {0}",_this.catCatMiJing))
_this.catFight:setActive(false)
end
end
end

function UIFightPrepareWin:getIsCatFright()
if _this.catCatMiJing then
if _this.catcanfright then
return true
else
UIManager.error('当前战力不足，无法进入秘境')
return false
end
else
return true
end
end

function UIFightPrepareWin:getIsCatFrightDialouge()
local catFightvalue=_this.CatFrightDialougeValue or 10000
local catFightstr=FMT.fmt("该秘境推荐战力<color=#c82c2c>{0}</color>，高于您当前的弟子阵容，确定要进行挑战吗？",mathHelper.formatNumber(catFightvalue))
local show_data=
{
title='提示',
tipsText=catFightstr,
cellcallback=function()
if _this==nil then return end
_this.CatFrightDialougeFlag=false
_this:onSelectButton()
end,
}
UIManager:showWindow('UIDialougeNormalTip',show_data)
end


function UIFightPrepareWin:getTeamNotFullDzDialouge()
local content=self.checkTeamFullDzFunc(self.notFullTeamIndex)
self.notFullTeamIndex=nil
local callback=function()
if _this==nil then return end
_this:onSelectButton()
if _this==nil then return end
_this.checkTeamFullDzDialougeFlag=false
end
local cancelcb=function()
if _this==nil then return end
_this.checkTeamFullDzDialougeFlag=false
end






UIDialogManager.getConfirmDialog3(nil,content,callback,nil,cancelcb,cancelcb)
end


function UIFightPrepareWin:getNoDzSZFuncDialouge()
local content=self.noDzSZFunc(self.noDzSZFuncIndex)
self.noDzSZFuncIndex=nil
local callback=function()
if _this==nil then return end
_this:onSelectButton()
if _this==nil then return end
_this.noDzSZFuncFlag=false
end
local cancelcb=function()
if _this==nil then return end
_this.noDzSZFuncFlag=false
end






UIDialogManager.getConfirmDialog3(nil,content,callback,nil,cancelcb,cancelcb)
end

function UIFightPrepareWin:showDialogue(content,callback)
local dialog=UIDialogManager.getConfirmDialogEx(nil,{
content=content,
okcb=callback,
})
dialog:show()
end



function UIFightPrepareWin:showAutoSelectButton()
if worldController:checkNoticiateBlockOpen()then
local subNum=0
if self.plotGrayDiscipleList then
for i,v in pairs(self.plotGrayDiscipleList)do
subNum=subNum+1
end
end
local diziNum=#self.disciplesList-subNum

local isShowSelect=true
if self.teamSelectData then
local currTeam=self.selectIndex+1
local num=self:getTeamDZNum(currTeam)
local oneNum=self:getCurTeamDZNumInMuitiTeam()
if self.teamDZMaxNum then
isShowSelect=num>=self.teamDZMaxNum[currTeam]or num>=diziNum or oneNum>=maxSelect
else
isShowSelect=oneNum>=maxSelect or num>=diziNum
end
else
isShowSelect=selectNum>=maxSelect or selectNum>=diziNum
end

if isShowSelect then
self.autoSelectButton:setActive(false)
self.clearButton:setActive(true)
_this.isShangZhenging=true
else
self.autoSelectButton:setActive(true)
self.clearButton:setActive(false)
_this.isShangZhenging=false
end
end
end

function UIFightPrepareWin:onHelpButton()
UIManager:showWindow("UIFightPrepareTipsWin")
end

function UIFightPrepareWin:onHelpButton2()
self:onHelpButton()
end


function UIFightPrepareWin:OnEnable()

end


function UIFightPrepareWin:OnDisable()

end


function UIFightPrepareWin:refreshEnemyTeamPanel()
self.enemyTeamPanel:setActive(self.kofMode~=nil)
if self.kofMode then
self.enemyTeamList:setChildLayoutGroupCreateItems(self.kofMode,function(index)
local item=self.enemyTeamList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(0,self.selectIndex==index-1)
item:SetChildText(1,FMT.fmt("{0}",index))
item:SetChildButtonClick(-1,function()
self:onClickEnemyTeam(index)
end)
end)
self:onClickEnemyTeam(self.selectIndex and(self.selectIndex+1)or 1)
end
end

function UIFightPrepareWin:onClickEnemyTeam(index)
if self.selectIndex==index-1 then return end
if self.selectIndex then
local item=self.enemyTeamList:getChildLayoutGroupGridItem(self.selectIndex)
item:SetChildActive(0,false)
end

self.on_team_select(0,index-1)

local item=self.enemyTeamList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(0,true)























end


function UIFightPrepareWin:checkHasSelectDz()
local guid=nil
local lookUpKey=nil
for i,v in ipairs(self.disciplesList)do
if v.uType==fightPreSelectModel.teamEntityType.npc then
guid=v.data.guid
lookUpKey=self.getLookUpKey(v.uType,tostring(guid))
if self:checkState(v)and not selectLookUp[lookUpKey]and not self:checkOtherTeam(guid)then
return true
end
elseif v.uType==fightPreSelectModel.teamEntityType.dizi then
guid=tostring(v.data.netData.net.discipleguid)
lookUpKey=self.getLookUpKey(v.uType,tostring(guid))
if self:checkState(v)and not selectLookUp[lookUpKey]and not self:checkOtherTeam(guid)then
return true
end
end
end
return false
end

function UIFightPrepareWin:getDzFightValue(guid)
local fight=UIDiscipleModel:getDiscipleFightValue(guid)
if _this.wendingcangqiongCfg then
local dzFightList=_this.wendingcangqiongCfg.dzFightList
if dzFightList and dzFightList[mathHelper.int64_to_string(guid)]then
fight=dzFightList[mathHelper.int64_to_string(guid)]
end
end
if _this.isMYZS then
fight=myzsModel:getDiscipleFightValForLingLi3(guid,fight)
end
return fight
end

function UIFightPrepareWin:checkTaskLimit(warring)
if not cfgHelper.getglobal1("isShieldFightPositionSys")then
return true
end
if systemModel.isOpen(SYSTEM_DEFINE.eFightPosition)then
return true
else
if warring then
local str=systemModel.getOpenTips(SYSTEM_DEFINE.eFightPosition)
UIManager.error(str)
end
end
end
