







def_class("UIFightPrepareTwoWin",UIWindowBase)









function UIFightPrepareTwoWin:bindComponents()

self.autoSelectButton=UIButton.get(self,0)
self.cancelButton=UIButton.get(self,1)
self.clearButton=UIButton.get(self,2)
self.conditionList=UIObject.get(self,3)
self.defTeamLgBg=UIImage.get(self,4)
self.defTeamLgImage=UIImage.get(self,5)
self.defTeamLgRoot=UIObject.get(self,6)
self.defTeamTips=UIObject.get(self,7)
self.dragObject=UIObject.get(self,8)
self.emptySelectTx=UIText.get(self,9)
self.faze2contect=UIObject.get(self,10)
self.fazeBtn2=UIButton.get(self,11)
self.fazeBtn2Bg=UIButton.get(self,12)
self.fazeBtn2Reddot=UIObject.get(self,13)
self.faZeList=UIObject.get(self,14)
self.faZeList2=UIObject.get(self,15)
self.faZeOne=UIObject.get(self,16)
self.fazeRoot2=UIObject.get(self,17)
self.fazeRoot2Ex=UIObject.get(self,18)
self.fightDescObj_1=UIObject.get(self,19)
self.fightDescObj_2=UIObject.get(self,20)
self.fightDescTxt_1=UIText.get(self,21)
self.fightDescTxt_2=UIText.get(self,22)
self.fightText=UIText.get(self,23)
self.helpButton=UIButton.get(self,24)
self.mask=UIObject.get(self,25)
self.moneyCost=UIObject.get(self,26)
self.moneyCostCountText=UIText.get(self,27)
self.moneyCostIcon=UIImage.get(self,28)
self.rightFightText=UIText.get(self,29)
self.multiFight=UIObject.get(self,30)
self.RoleTypeListPanel=UIObject.get(self,31)
self.ScrollerScript=UIEnhancedScrollerLua.get(self,32)
self.selectButton=UIButton.get(self,33)
self.selectText=UIText.get(self,34)
self.leftFightText=UIText.get(self,35)
self.singleFight=UIObject.get(self,36)
self.targetFightBG=UIObject.get(self,37)
self.targetFightDesc=UIText.get(self,38)
self.teamButton=UIButton.get(self,39)
self.teamList=UIObject.get(self,40)
self.titleRoot=UIObject.get(self,41)
self.titleText=UIText.get(self,42)
self.topMask=UIObject.get(self,43)
self.wayTimeBg=UIObject.get(self,44)
self.wayTimeText=UIText.get(self,45)
self.zfBtn=UIButton.get(self,46)
self.zfIcon=UIImage.get(self,47)
self.zfName=UIText.get(self,48)

self.autoSelectButton:setButtonClick(function()self:onAutoSelectButton()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.clearButton:setButtonClick(function()self:onClearButton()end)

self.fazeBtn2:setButtonClick(function()self:onFazeBtn2()end)

self.fazeBtn2Bg:setButtonClick(function()self:onFazeBtn2Bg()end)

self.helpButton:setButtonClick(function()self:onHelpButton()end)

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


function UIFightPrepareTwoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.autoSelectButton);self.autoSelectButton=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.clearButton);self.clearButton=nil;
_UIObject_release(self.conditionList);self.conditionList=nil;
_UIObject_release(self.defTeamLgBg);self.defTeamLgBg=nil;
_UIObject_release(self.defTeamLgImage);self.defTeamLgImage=nil;
_UIObject_release(self.defTeamLgRoot);self.defTeamLgRoot=nil;
_UIObject_release(self.defTeamTips);self.defTeamTips=nil;
_UIObject_release(self.dragObject);self.dragObject=nil;
_UIObject_release(self.emptySelectTx);self.emptySelectTx=nil;
_UIObject_release(self.faze2contect);self.faze2contect=nil;
_UIObject_release(self.fazeBtn2);self.fazeBtn2=nil;
_UIObject_release(self.fazeBtn2Bg);self.fazeBtn2Bg=nil;
_UIObject_release(self.fazeBtn2Reddot);self.fazeBtn2Reddot=nil;
_UIObject_release(self.faZeList);self.faZeList=nil;
_UIObject_release(self.faZeList2);self.faZeList2=nil;
_UIObject_release(self.faZeOne);self.faZeOne=nil;
_UIObject_release(self.fazeRoot2);self.fazeRoot2=nil;
_UIObject_release(self.fazeRoot2Ex);self.fazeRoot2Ex=nil;
_UIObject_release(self.fightDescObj_1);self.fightDescObj_1=nil;
_UIObject_release(self.fightDescObj_2);self.fightDescObj_2=nil;
_UIObject_release(self.fightDescTxt_1);self.fightDescTxt_1=nil;
_UIObject_release(self.fightDescTxt_2);self.fightDescTxt_2=nil;
_UIObject_release(self.fightText);self.fightText=nil;
_UIObject_release(self.helpButton);self.helpButton=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.moneyCost);self.moneyCost=nil;
_UIObject_release(self.moneyCostCountText);self.moneyCostCountText=nil;
_UIObject_release(self.moneyCostIcon);self.moneyCostIcon=nil;
_UIObject_release(self.rightFightText);self.rightFightText=nil;
_UIObject_release(self.multiFight);self.multiFight=nil;
_UIObject_release(self.RoleTypeListPanel);self.RoleTypeListPanel=nil;
_UIObject_release(self.ScrollerScript);self.ScrollerScript=nil;
_UIObject_release(self.selectButton);self.selectButton=nil;
_UIObject_release(self.selectText);self.selectText=nil;
_UIObject_release(self.leftFightText);self.leftFightText=nil;
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
local selectFight_left=0
local selectFight_right=0
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
color=5,
tipsTx=6,
tipsBg=7,
job=8,
state=11,
npc=12,
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
}

local teamNameList={
[1]="进攻",
[2]="防守",
}

local teamPosMask={
[1]={1,2,3,4,5},
[2]={6,7,8,9,10},
}

function UIFightPrepareTwoWin:getLookUp(list)
local lookUp={}
for i,v in ipairs(list)do
lookUp[v]=v
end
return lookUp
end


function UIFightPrepareTwoWin:onLoaded(...)
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


worldController:stopCameraControl()

self.teamList:setChildScrollViewInit(1,true,self.on_team_select,nil)
self.conditionList:setChildScrollViewInit(0,true,nil,nil)
self.faZeList:setChildScrollViewInit(0.5,true,nil,nil)

self:addNotify(notifyConfig.inNewbie,self.inNewbie)
end


function UIFightPrepareTwoWin:__delete()
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
selectFight_left=0
selectFight_right=0
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




function UIFightPrepareTwoWin:onShow(argtable,afterOnloaded)
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
self.skipCheckTeamHasDz=argtable.skipCheckTeamHasDz

self.executeCallback=argtable.executeCallback

self.faZeData=argtable.faZeData
self.faZeList2Args=argtable.faZeList2Args
self.faZeList2Reddot=argtable.faZe2Reddot or false
self.faZeList2Vis=argtable.faZeList2Default

self.costList=argtable.costList

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

self.mustList=argtable.mustList
self.dzSpeakList=argtable.dzSpeakList

self.statePriorityCheck=argtable.statePriorityCheck~=false

enterTxt=argtable.enterTxt
maxSelect=self.dzCountLimit or 5
minSelect=self.dzCountLeast or 1
npcList=argtable.npcList or{}










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

if argtable.checkBanFlagFunc then
self.checkBanFlagFunc=argtable.checkBanFlagFunc
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

self.singleFight:setActive(false)
self.multiFight:setActive(true)

local showMultiTitle=self.multiTitleStr~=nil
local multiWidget=self.multiFight:getChildWidgetBase()
multiWidget:SetChildActive(0,showMultiTitle)
if showMultiTitle then
multiWidget:SetChildText(1,self.multiTitleStr)
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

self.wayTimeBg:setActive(false)

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

self:refreshShieldEntity()

self:OnClickRoleSortItemCallback(1,0)

self:setFight()



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

end


function UIFightPrepareTwoWin:onHide()

end

function UIFightPrepareTwoWin.inNewbie(newbieid,flag)
if _this==nil then return end
if not flag then
_this:registerEasyTouch(true)
end
end

function UIFightPrepareTwoWin.onEventChange(evtType,entityId,nativePosIndex)

if not _this then
return
end

local curTeam=_this.selectIndex+1
local isLeft=curTeam==1
local posIndex=nativePosIndex
if nativePosIndex~=-1 then
posIndex=isLeft and posIndex or posIndex-5
end


if evtType==1 then
dragIndex=posIndex
if selectList[posIndex]then
dragGuid=selectList[posIndex]
dragDataIndex=selectLookUp[_this.getLookUpKey(dragGuid[1],tostring(dragGuid[2]))]
end

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

function UIFightPrepareTwoWin:setTopMask(active)
self.topMask:setActive(active)
end


function UIFightPrepareTwoWin:getCanUseShouYuanDisciples()
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


function UIFightPrepareTwoWin:maskDispatch(list)
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


function UIFightPrepareTwoWin:checkDispatchCondition(guidlist,warning,multi)
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


function UIFightPrepareTwoWin:checkState(discipleData,warring,isInit)
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
end
return true
end


function UIFightPrepareTwoWin:getNetDataList()
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

self.disciplesList_lookup={}
for i,v in ipairs(diziList)do
table.insert(slist,{uType=fightPreSelectModel.teamEntityType.dizi,data=v})

local netData=v.netData.net
local guid=netData.discipleguid
local guidStr=tostring(guid)
self.disciplesList_lookup[guidStr]=v
end
self.disciplesList=slist
end

function UIFightPrepareTwoWin:checkCanAddToList(netData)



if self.mustList then
if table.containsValueEx(self.mustList,netData.discipleguid,function(value)
return tostring(value)
end)then
return false
end
end
return true
end

function UIFightPrepareTwoWin:initRoleTypeListPanel()
self.RoleTypeListPanel:setChildScrollViewCreateGrids(#self.sortTypeList,1)
local grids=self.RoleTypeListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
item:SetChildText(0,eDiscipleSortTypeName:getName1(i))
item:SetChildCSImageSprite(1,imageabname,FMT.fmt('{0}{1}',imageassetname,i))
end
end

function UIFightPrepareTwoWin:OnClickRoleSortItemCallback(clicknum,index)
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

function UIFightPrepareTwoWin:initTeamModelPanel()
if self.teamSelectData then
local behaviourList={
[1]=self.leftPosBehavior,
[2]=self.rightPosBehavior,
}
for teamIdx,teamList in ipairs(self.teamSelectData)do
local tempTeamList={}
local isLeft=teamIdx==1
local behaviour=behaviourList[teamIdx]
for guidStr,v in pairs(teamList)do

if self.disciplesList_lookup[guidStr]then

tempTeamList[guidStr]=v
local index=v[1]
local ntype=v[2]
local guid=v[3]
local posIdx=isLeft and index or 5+index
local modelId
local jobId
local id
if ntype==fightPreSelectModel.teamEntityType.dizi then
local netdata=UIDiscipleModel:getDiscipleData(guid)
modelId=netdata.discipleimage
jobId=UIDiscipleModel:getDiscipleJob(guid)
id=netdata.id
elseif ntype==fightPreSelectModel.teamEntityType.npc then
local npcData=self.npcLookUp[guid]
if npcData then
local npcId=npcData[1]
modelId=fightPreSelectModel.getNPCOutSideModel(npcId)
jobId=fightPreSelectModel.getNPCJob(npcId)
id=fightPreSelectModel.getNPCMonster(npcId)
end
end
self:addEntity(posIdx,ntype,id,guid,modelId,jobId,behaviour)
end
end
self.teamSelectData[teamIdx]=tempTeamList
end
end
end

function UIFightPrepareTwoWin:addEntityShield(shieldId,isLeft)

self.selectStage:addEntityShield(shieldId,isLeft)
end

function UIFightPrepareTwoWin:refreshShieldEntity()
if self.sheildParam then
self:addEntityShield(self.sheildParam[1],self.sheildParam[2])
end
end

function UIFightPrepareTwoWin:refreshRoleList()
if self.disciplesList then
local dataNum=#self.disciplesList

self.enhancedscrollscript:initData(self.disciplesList,160,dataNum)
self.emptySelectTx:setText(dataNum<=0 and self.dzEmptyCountTx or"")
end
end

function UIFightPrepareTwoWin:initRoleListPanel(behaviour)
if self.disciplesList then
self:refreshRoleList()

if self.teamSelectData then
local idx=self.defaultSelectTeamIndex or 1
idx=idx-1
self.on_team_select(0,idx)
preloadList={}
self.npcLookUp={}

self:initTeamModelPanel()
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


function UIFightPrepareTwoWin:clearSelect()
local curTeam=self.selectIndex+1
local isLeft=curTeam==1
if self.teamSelectData then
self.selectStage:clearEntity(isLeft)
selectLookUp={}
table.clear(selectList)
selectNum=0
self.teamSelectData[curTeam]={}
else
for i,v in pairs(selectList)do
if v[1]==fightPreSelectModel.teamEntityType.dizi then
selectLookUp[self.getLookUpKey(v[1],tostring(v[2]))]=nil
selectList[i]=nil
selectNum=selectNum-1
local posIdx=isLeft and i or 5+i
self.selectStage:removeEntity(posIdx)
end
end
end

self:doRefreshActiveCellViews()

self:showAutoSelectButton()

notifySystem:postNotify(notifyConfig.onFightPrepareSelectChange,selectList)
end


function UIFightPrepareTwoWin:fastSelect(diziLookUp,npcLookUp,behaviour,delay,warring)
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
self.enhancedscrollscript:checkAndClick(nil,nil,v,nil,nil,behaviour,nil,nil,true,warring)
end
end)
end


function UIFightPrepareTwoWin:refreshSelectByTeamChange(diziLookUp,npcLookUp)
if self.teamSelectData then
selectLookUp={}
table.clear(selectList)
selectNum=0

local tempList={}
local npcTempList={}
local diziTempList={}
for i,v in ipairs(self.disciplesList)do
if v.uType==fightPreSelectModel.teamEntityType.npc then
local guid=v.data.guid
if npcLookUp and npcLookUp[guid]then
tempList[npcLookUp[guid][2]]=i-1
npcTempList[npcLookUp[guid][2]]=i-1
end
elseif v.uType==fightPreSelectModel.teamEntityType.dizi then
local guid=tostring(v.data.netData.net.discipleguid)
if diziLookUp and diziLookUp[guid]then
tempList[diziLookUp[guid]]=i-1
diziTempList[diziLookUp[guid]]=i-1
end
end
end

local addSelectFunc=function(dataIndex,exchangeIndex)
dataIndex=dataIndex+1
local guid
local jobId
local unitData=self.disciplesList[dataIndex]
if unitData.uType==fightPreSelectModel.teamEntityType.dizi then
local netdata=unitData.data.netData.net
guid=netdata.discipleguid
jobId=UIDiscipleModel:getDiscipleJob(guid)
elseif unitData.uType==fightPreSelectModel.teamEntityType.npc then
guid=unitData.data.guid
jobId=fightPreSelectModel.getNPCJob(unitData.data.id)
end
local lookUpKey=self.getLookUpKey(unitData.uType,tostring(guid))

if exchangeIndex then
selectLookUp[lookUpKey]=dataIndex
selectList[exchangeIndex]={unitData.uType,guid,unitData.data.id and int64.new(unitData.data.id)or guid}
selectNum=selectNum+1
else
local emptyIndex=_this.getJobPosPriorty(jobId)
if emptyIndex then
selectNum=selectNum+1
selectList[emptyIndex]={unitData.uType,guid,unitData.data.id and int64.new(unitData.data.id)or guid}
selectLookUp[lookUpKey]=dataIndex
end
end
end

for i,v in pairs(tempList)do
if not(diziTempList[i]and npcTempList[i])then
npcTempList[i]=nil
end

addSelectFunc(v,i)
end
for i,v in pairs(npcTempList)do

addSelectFunc(v)
end

end

self:doRefreshActiveCellViews()
self:showAutoSelectButton()
notifySystem:postNotify(notifyConfig.onFightPrepareSelectChange,selectList)
end

function UIFightPrepareTwoWin:onFastSelect(diziLookUp)
self:onClearButton()
self:fastSelect(diziLookUp)
end


function UIFightPrepareTwoWin:setFight()
selectFight=0
selectFight_left=0
selectFight_right=0
local teamSelectList=self.teamSelectData
for teamIndex,list in pairs(teamSelectList)do
for i,v in pairs(list)do
local ntype=v[2]
local dzguid=v[3]
local fightValue=0
if ntype==fightPreSelectModel.teamEntityType.dizi then
fightValue=_this:getDzFightValue(dzguid)
elseif ntype==fightPreSelectModel.teamEntityType.npc then

end

local isLeft=teamIndex==1
if isLeft then
selectFight_left=selectFight_left+fightValue
else
selectFight_right=selectFight_right+fightValue
end
end
end
self.fightText:setText(UIDiscipleModel:fightValueConversion(selectFight))

self.leftFightText:setText(mathHelper.formatNumber7(selectFight_left,1,2))
self.rightFightText:setText(mathHelper.formatNumber7(selectFight_right,1,2))
















end

function UIFightPrepareTwoWin:setMonsterFight()
local mons_fight
if self.monsterFight then
mons_fight=self.monsterFight
elseif self.monsterFightEx then
local idx=self.selectIndex or 0
mons_fight=self.monsterFightEx[idx+1]
end
self.monsterFightText:setText(mons_fight or 0)
end


function UIFightPrepareTwoWin:getJingJie()
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

function UIFightPrepareTwoWin.getEmpty()
for i=1,maxPos do
if not selectList[i]then
return i
end
end
end


function UIFightPrepareTwoWin.getJobPosPriorty(jobId)
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

function UIFightPrepareTwoWin.getGUIDIndex(teamEntityType,guid)
for i,v in pairs(selectList)do
if teamEntityType==v[1]and guid==v[2]then
return i
end
end
end



function UIFightPrepareTwoWin.getLookUpKey(teamEntityType,guid)
return table.concat({teamEntityType,guid},"-")
end

function UIFightPrepareTwoWin.exchangeRoleItem(index,targetindex)
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

function UIFightPrepareTwoWin:exchangeRoleItemWithEntity(index,targetindex)
if selectList[index]then
self.exchangeRoleItem(index,targetindex)
self.selectStage:exchangeEntityIndex(index,targetindex)
end
end

function UIFightPrepareTwoWin.getSortGuidList()
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


function UIFightPrepareTwoWin:getDiziList()
local guidList={}
for k,v in pairs(selectList)do
if v[1]==fightPreSelectModel.teamEntityType.dizi then
guidList[k]=v[3]
end
end
return guidList
end


function UIFightPrepareTwoWin:checkPosEnough()
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


function UIFightPrepareTwoWin:checkPosEmpty()
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

function UIFightPrepareTwoWin:addEntity(posIndex,uType,id,guid,modelId,jobid,behaviour,tips)
if uType==fightPreSelectModel.teamEntityType.npc then
self.selectStage:addEntity(posIndex,fightEntityType.monster,id,jobid,nil,behaviour,tips)
elseif uType==fightPreSelectModel.teamEntityType.dizi then
self.selectStage:addEntity(posIndex,fightEntityType.diZi,guid,jobid,nil,behaviour,tips)
else
self.selectStage:addEntity(posIndex,fightEntityType.monster,modelId,jobid,self.monsterPosType,behaviour,tips)
end
end

function UIFightPrepareTwoWin:getEntity(posIndex)
return self.selectStage:getEntity(posIndex)
end

function UIFightPrepareTwoWin:getListIndex(posIndex)
if selectList[posIndex]then
local guidString=self.getLookUpKey(selectList[posIndex][1],tostring(selectList[posIndex][2]))
return selectLookUp[guidString]
end
end

function UIFightPrepareTwoWin:selectDisciple(listIndex,posIndex)
self.enhancedscrollscript:checkAndClick(nil,nil,listIndex-1,nil,posIndex)
end


function UIFightPrepareTwoWin:registerEasyTouch(register)
self.selectStage:registerEasyTouch(register)
end

function UIFightPrepareTwoWin:showFaZeList2()
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

function UIFightPrepareTwoWin:refreshMoneyCostPanel()

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

function UIFightPrepareTwoWin:setZhenFa(zfId)
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




function UIFightPrepareTwoWin:onAutoSelectButton(isInit)
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



function UIFightPrepareTwoWin:onCancelButton()
if not self.needClosePreSelectStage then
return
end
roleAudioController:stopRoleSpeak()
self:onCloseFunc()
end



function UIFightPrepareTwoWin:onClearButton()
_this.isShangZhenging=false
self:clearSelect()
self:setFight()
end



function UIFightPrepareTwoWin:onFazeBtn2()
self.faZeList2Vis=not self.faZeList2Vis
self.faZeList2Reddot=false
self:showFaZeList2()
end



function UIFightPrepareTwoWin:onFazeBtn2Bg()
self.faZeList2Vis=false
self.faZeList2Reddot=false
self:showFaZeList2()
end



function UIFightPrepareTwoWin:onHelpButton()
UIManager:showWindow("UIFightPrepareTipsWin")
end



function UIFightPrepareTwoWin:onSelectButton()
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
if self.checkTeamFullDzFunc and self.notFullTeamIndex then
if not self.checkTeamFullDzDialougeFlag then
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
return UIManager.error(FMT.fmt("请至少选择{0}名弟子",minSelect))
end
end



function UIFightPrepareTwoWin:onTeamButton()
local teamList=self.getSortGuidList()
UIManager:showWindow("UIFightTeamPrefabPanel",{teamList=teamList,winName=self.__name})
end



function UIFightPrepareTwoWin:onZfBtn()
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

function UIFightPrepareTwoWin:onSelectClickDown()
if self.sureBodyAnim then
self.selectButton:setChildModelAnimationState(self.sureBodyAnim)
else
self.selectButton:setChildModelAnimationState(eAnimationID.idle1)
end
end

function UIFightPrepareTwoWin:clearAndStartFight()
self.executeCallback=nil
self:onSelectButton()
end

function UIFightPrepareTwoWin:onCancelFunc()
local isFullOpen_=self.isFullOpen
local cb=self.cancelCallBack
if isFullOpen_ and(not self.dontCloseStage)then
UIFullFightPrepareControl:closeActiveUI()
else
UIManager:closeWindow('UIFightPrepareWin')

end
if cb then
cb()
end
end

function UIFightPrepareTwoWin:onCloseFunc()
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

function UIFightPrepareTwoWin:onLongTouchDizi(id)
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

function UIFightPrepareTwoWin:checkFightWarring(enterCallBack)
if self.fightCompareTips and(self.fightCompareJingJie and self:getJingJie()<self.fightCompareJingJie)then
fightPreSelectModel:showCheckFightTips(self.fightType,self.fightCompareTips,enterCallBack)
else
enterCallBack()
end
end

function UIFightPrepareTwoWin:doRefreshActiveCellViews()
self.enhancedscrollscript:doRefreshActiveCellViews()
end

function UIFightPrepareTwoWin:onHelpButton2()
self:onHelpButton()
end




function UIFightPrepareTwoWin:onDragUpdate()

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

local isBanVoc=false
if _this.checkBanFlagFunc then
local checkFlag=_this.checkBanFlagFunc(guid)
item:SetChildActive(roleItemIndex.ban,checkFlag)
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

item:SetChildActive(roleItemIndex.teamIcon,false)
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

item:SetChildActive(roleItemIndex.otherBg,false)

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
item:SetChildText(roleItemIndex.fight,FMT.fmt('{0} {1}',FMT.cfmt(FONT_COLOR.eOrangeColor,'战'),fightPreSelectModel.getNPCFightValue(unitData.data.id)))
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

self:checkAndClick(data,cellIndex,dataIndex,cell,exchangeIndex,behaviour,notTips,appearTips)
end

function UIPrepareEnScroller:checkAndClick(data,cellIndex,dataIndex,cell,exchangeIndex,behaviour,notTips,appearTips,isInit,warring)
dataIndex=dataIndex+1
self:onItemClickEx(data,cellIndex,dataIndex,cell,exchangeIndex,behaviour,notTips,appearTips,isInit,warring)
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
local curTeam=_this.selectIndex+1
local isLeft=curTeam==1
local posIdx=isLeft and guidIndex or 5+guidIndex
_this.selectStage:removeEntity(posIdx)
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


local curTeam=_this.selectIndex+1
local isLeft=curTeam==1
if exchangeIndex then
local posIdx=isLeft and exchangeIndex or 5+exchangeIndex
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
_this.selectStage:removeEntity(posIdx)
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
_this:addEntity(posIdx,unitData.uType,unitData.data.monsterId,guid,modelId,jobId,behaviour,tipsStr)
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

local posIdx=isLeft and emptyIndex or 5+emptyIndex
_this:addEntity(posIdx,unitData.uType,unitData.data.monsterId,guid,modelId,jobId,behaviour,tipsStr)
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
notifySystem:postNotify(notifyConfig.onFightPrepareSelectChange,selectList)

self.window:showAutoSelectButton()
end

function UIPrepareEnScroller:onItemBeginDrag(dataIndex,screenPos,cell)
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
dragEndData={dataIndex,screenPos,cell}
end


function UIFightPrepareTwoWin:setFaZeItem(item,i,data)

end
function UIFightPrepareTwoWin:showFaZeList()
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

function UIFightPrepareTwoWin:setConditionList()
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

function UIFightPrepareTwoWin:addDZToTeam(index,guid,ntype)
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

function UIFightPrepareTwoWin:checkOtherTeam(guid)

return false








end

function UIFightPrepareTwoWin:checkAndPlaceToTeam(guid,callback)













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

function UIFightPrepareTwoWin:getDZTeam(guid)
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


function UIFightPrepareTwoWin:getTeamDZNum(teamId)
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


function UIFightPrepareTwoWin:getCurTeamDZNumInMuitiTeam()
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

function UIFightPrepareTwoWin.on_team_select(cnum,index)
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

function UIFightPrepareTwoWin:refreshMonsterTeam(index)

end

function UIFightPrepareTwoWin:showSelectTeam()
local curTeam=self.selectIndex+1
local teamList=self.teamSelectData[curTeam]
local selectMask=teamPosMask[curTeam]
self.selectStage:setSelectMask(selectMask)


local lookup={}
for k,v in pairs(teamList)do
lookup[k]=v[1]
end

self:refreshSelectByTeamChange(lookup,nil)
end

function UIFightPrepareTwoWin:showTeamList()
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
local teamNameStr
if teamNameList[i]then
teamNameStr=FMT.fmt("{0}队伍",teamNameList[i])
else
teamNameStr=FMT.fmt('第{0}队',i)
end
item:SetChildText(1,teamNameStr)

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

function UIFightPrepareTwoWin:checkCanStart(wraning)
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
if not next(v)and not self.skipCheckTeamHasDz then
if wraning then

UIManager.error("每支队伍至少要上阵<color=#c82c2c>1名弟子</color>")
end
return false,i
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

return true
end

function UIFightPrepareTwoWin:checkMust(guidlist)
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

function UIFightPrepareTwoWin:checkPlotDisciple(guidlist,warring)
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


function UIFightPrepareTwoWin:getTeamNotFullDzDialouge()
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

function UIFightPrepareTwoWin:showDialogue(content,callback)
local dialog=UIDialogManager.getConfirmDialogEx(nil,{
content=content,
okcb=callback,
})
dialog:show()
end

function UIFightPrepareTwoWin:showAutoSelectButton()
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



function UIFightPrepareTwoWin:OnEnable()

end


function UIFightPrepareTwoWin:OnDisable()

end


function UIFightPrepareTwoWin:checkHasSelectDz()
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

function UIFightPrepareTwoWin:getDzFightValue(guid)
local fight=UIDiscipleModel:getDiscipleFightValue(guid)
if _this.wendingcangqiongCfg then
local dzFightList=_this.wendingcangqiongCfg.dzFightList
if dzFightList and dzFightList[mathHelper.int64_to_string(guid)]then
fight=dzFightList[mathHelper.int64_to_string(guid)]
end
end
return fight
end
