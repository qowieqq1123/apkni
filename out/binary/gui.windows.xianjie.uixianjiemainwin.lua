







def_class("UIXianJieMainWin",UIWindowBase)









function UIXianJieMainWin:bindComponents()

self.arenaBtnPanel=UIObject.get(self,0)
self.arenaRankBtn=UIButton.get(self,1)
self.arenaZhanLingBtn=UIButton.get(self,2)
self.bg0=UIObject.get(self,3)
self.bg1=UIObject.get(self,4)
self.bg2=UIObject.get(self,5)
self.bg3=UIObject.get(self,6)
self.bg4=UIObject.get(self,7)
self.BottomList=UIObject.get(self,8)
self.btnChange_concise=UIButton.get(self,9)
self.btnChange_normal=UIButton.get(self,10)
self.buffBtn=UIButton.get(self,11)
self.buoyRoot=UIObject.get(self,12)
self.ButtonBack=UIButton.get(self,13)
self.ButtonBack1=UIObject.get(self,14)
self.ButtonBack2=UIObject.get(self,15)
self.chatContent=UIObject.get(self,16)
self.chatCreater=UIGameobjectClone.new(self,17)
self.chatEmoreddot=UIImage.get(self,18)
self.chatReddot=UIObject.get(self,19)
self.chatRedPacket=UIObject.get(self,20)
self.chatRoot=UIObject.get(self,21)
self.chatScrollView=UIObject.get(self,22)
self.clickMask=UIObject.get(self,23)
self.closeBtn=UIButton.get(self,24)
self.extraTeamItem=UIButton.get(self,25)
self.feedBookBtn=UIButton.get(self,26)
self.feedBookReddot=UIObject.get(self,27)
self.filterHUD2Btn=UIButton.get(self,28)
self.freeMoveZmLeftTime=UIText.get(self,29)
self.freeMoveZmLeftTimeBg=UIObject.get(self,30)
self.freeTeamItem=UIButton.get(self,31)
self.hightCameraPanel=UIObject.get(self,32)
self.homeBtn=UIButton.get(self,33)
self.jianhuaBtn=UIButton.get(self,34)
self.jianhuaSelect=UIObject.get(self,35)
self.jiJieBtn=UIButton.get(self,36)
self.jijieNumObj=UIObject.get(self,37)
self.jijieNumTxt=UIText.get(self,38)
self.leftFuncBtnLayout=UIObject.get(self,39)
self.leftSpTipsLayout=UIObject.get(self,40)
self.limitMoveZMBtn=UIButton.get(self,41)
self.listBg=UIObject.get(self,42)
self.listLayout=UIGameobjectClone.new(self,43)
self.mapNameTxt=UIText.get(self,44)
self.menuGroup=UIObject.get(self,45)
self.menuGroupEx=UIGameobjectClone.new(self,46)
self.miniMapBtn=UIButton.get(self,47)
self.MiZangBtn=UIButton.get(self,48)
self.MJBXBtn=UIObject.get(self,49)
self.mjRankBtn=UIButton.get(self,50)
self.mjReddot=UIObject.get(self,51)
self.mjShopBtn=UIButton.get(self,52)
self.mjShopBtnReddotEx=UIObject.get(self,53)
self.mjslimg=UIButton.get(self,54)
self.mjsReddot=UIObject.get(self,55)
self.Money3TipsPanel=UIObject.get(self,56)
self.Money3TipsTx=UIText.get(self,57)
self.moneybar=UIObject.get(self,58)
self.moneyBars_1=UIButton.get(self,59)
self.moneyBars_2=UIButton.get(self,60)
self.moneyBars_3=UIButton.get(self,61)
self.moneyBars_4=UIButton.get(self,62)
self.mozongStageRoot=UIObject.get(self,63)
self.newSign=UIObject.get(self,64)
self.normalPanel=UIObject.get(self,65)
self.noTeamTips=UIObject.get(self,66)
self.numText=UIText.get(self,67)
self.posBtn=UIButton.get(self,68)
self.posTxt=UIText.get(self,69)
self.recordBtn=UIButton.get(self,70)
self.rightBtnLayout=UIObject.get(self,71)
self.seasonRoot=UIGameobjectClone.new(self,72)
self.shoumoAuto=UIButton.get(self,73)
self.shoumoautoclose=UIButton.get(self,74)
self.shoumomodel=UIObject.get(self,75)
self.tanChaBtn=UIButton.get(self,76)
self.tanChaBtnreddotEx=UIObject.get(self,77)
self.tanChaReddot=UIObject.get(self,78)
self.taskBtn=UIButton.get(self,79)
self.taskBtnReddot=UIImage.get(self,80)
self.taskItem=UIButton.get(self,81)
self.taskPanal=UIObject.get(self,82)
self.teamGrid=UIObject.get(self,83)
self.title_mgzd_bg=UIObject.get(self,84)
self.title_mj_bg=UIObject.get(self,85)
self.title_xj_bg=UIObject.get(self,86)
self.uiroot=UIObject.get(self,87)
self.xbnum=UIText.get(self,88)
self.xianbangBtn=UIButton.get(self,89)
self.xjPanel=UIObject.get(self,90)
self.zdPanel=UIObject.get(self,91)
self.zdTeamScrollView=UIObject.get(self,92)

self.arenaRankBtn:setButtonClick(function()self:onArenaRankBtn()end)

self.arenaZhanLingBtn:setButtonClick(function()self:onArenaZhanLingBtn()end)

self.btnChange_concise:setButtonClick(function()self:onBtnChange_concise()end)

self.btnChange_normal:setButtonClick(function()self:onBtnChange_normal()end)

self.buffBtn:setButtonClick(function()self:onBuffBtn()end)

self.ButtonBack:setButtonClick(function()self:onButtonBack()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.extraTeamItem:setButtonClick(function()self:onExtraTeamItem()end)

self.feedBookBtn:setButtonClick(function()self:onFeedBookBtn()end)

self.filterHUD2Btn:setButtonClick(function()self:onFilterHUD2Btn()end)

self.freeTeamItem:setButtonClick(function()self:onFreeTeamItem()end)

self.homeBtn:setButtonClick(function()self:onHomeBtn()end)

self.jianhuaBtn:setButtonClick(function()self:onJianhuaBtn()end)

self.jiJieBtn:setButtonClick(function()self:onJiJieBtn()end)

self.limitMoveZMBtn:setButtonClick(function()self:onLimitMoveZMBtn()end)

self.miniMapBtn:setButtonClick(function()self:onMiniMapBtn()end)

self.MiZangBtn:setButtonClick(function()self:onMiZangBtn()end)

self.mjRankBtn:setButtonClick(function()self:onMjRankBtn()end)

self.mjShopBtn:setButtonClick(function()self:onMjShopBtn()end)

self.mjslimg:setButtonClick(function()self:onMjslimg()end)

self.moneyBars_1:setButtonClick(function()self:onMoneyBars_1()end)

self.moneyBars_2:setButtonClick(function()self:onMoneyBars_2()end)

self.moneyBars_3:setButtonClick(function()self:onMoneyBars_3()end)

self.moneyBars_4:setButtonClick(function()self:onMoneyBars_4()end)

self.posBtn:setButtonClick(function()self:onPosBtn()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.shoumoAuto:setButtonClick(function()self:onShoumoAuto()end)

self.shoumoautoclose:setButtonClick(function()self:onShoumoautoclose()end)

self.tanChaBtn:setButtonClick(function()self:onTanChaBtn()end)

self.taskBtn:setButtonClick(function()self:onTaskBtn()end)

self.taskItem:setButtonClick(function()self:onTaskItem()end)

self.xianbangBtn:setButtonClick(function()self:onXianbangBtn()end)
self.moneyBars={
self.moneyBars_1,
self.moneyBars_2,
self.moneyBars_3,
self.moneyBars_4,
}
self.btnChange={
["concise"]=self.btnChange_concise,
["normal"]=self.btnChange_normal,
}
self.title_mgzd={
["bg"]=self.title_mgzd_bg,
}
self.title_mj={
["bg"]=self.title_mj_bg,
}
self.title_xj={
["bg"]=self.title_xj_bg,
}



end


function UIXianJieMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arenaBtnPanel);self.arenaBtnPanel=nil;
_UIObject_release(self.arenaRankBtn);self.arenaRankBtn=nil;
_UIObject_release(self.arenaZhanLingBtn);self.arenaZhanLingBtn=nil;
_UIObject_release(self.bg0);self.bg0=nil;
_UIObject_release(self.bg1);self.bg1=nil;
_UIObject_release(self.bg2);self.bg2=nil;
_UIObject_release(self.bg3);self.bg3=nil;
_UIObject_release(self.bg4);self.bg4=nil;
_UIObject_release(self.BottomList);self.BottomList=nil;
_UIObject_release(self.btnChange_concise);self.btnChange_concise=nil;
_UIObject_release(self.btnChange_normal);self.btnChange_normal=nil;
_UIObject_release(self.buffBtn);self.buffBtn=nil;
_UIObject_release(self.buoyRoot);self.buoyRoot=nil;
_UIObject_release(self.ButtonBack);self.ButtonBack=nil;
_UIObject_release(self.ButtonBack1);self.ButtonBack1=nil;
_UIObject_release(self.ButtonBack2);self.ButtonBack2=nil;
_UIObject_release(self.chatContent);self.chatContent=nil;
self.chatCreater:deleteSelf();self.chatCreater=nil;
_UIObject_release(self.chatEmoreddot);self.chatEmoreddot=nil;
_UIObject_release(self.chatReddot);self.chatReddot=nil;
_UIObject_release(self.chatRedPacket);self.chatRedPacket=nil;
_UIObject_release(self.chatRoot);self.chatRoot=nil;
_UIObject_release(self.chatScrollView);self.chatScrollView=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.extraTeamItem);self.extraTeamItem=nil;
_UIObject_release(self.feedBookBtn);self.feedBookBtn=nil;
_UIObject_release(self.feedBookReddot);self.feedBookReddot=nil;
_UIObject_release(self.filterHUD2Btn);self.filterHUD2Btn=nil;
_UIObject_release(self.freeMoveZmLeftTime);self.freeMoveZmLeftTime=nil;
_UIObject_release(self.freeMoveZmLeftTimeBg);self.freeMoveZmLeftTimeBg=nil;
_UIObject_release(self.freeTeamItem);self.freeTeamItem=nil;
_UIObject_release(self.hightCameraPanel);self.hightCameraPanel=nil;
_UIObject_release(self.homeBtn);self.homeBtn=nil;
_UIObject_release(self.jianhuaBtn);self.jianhuaBtn=nil;
_UIObject_release(self.jianhuaSelect);self.jianhuaSelect=nil;
_UIObject_release(self.jiJieBtn);self.jiJieBtn=nil;
_UIObject_release(self.jijieNumObj);self.jijieNumObj=nil;
_UIObject_release(self.jijieNumTxt);self.jijieNumTxt=nil;
_UIObject_release(self.leftFuncBtnLayout);self.leftFuncBtnLayout=nil;
_UIObject_release(self.leftSpTipsLayout);self.leftSpTipsLayout=nil;
_UIObject_release(self.limitMoveZMBtn);self.limitMoveZMBtn=nil;
_UIObject_release(self.listBg);self.listBg=nil;
self.listLayout:deleteSelf();self.listLayout=nil;
_UIObject_release(self.mapNameTxt);self.mapNameTxt=nil;
_UIObject_release(self.menuGroup);self.menuGroup=nil;
self.menuGroupEx:deleteSelf();self.menuGroupEx=nil;
_UIObject_release(self.miniMapBtn);self.miniMapBtn=nil;
_UIObject_release(self.MiZangBtn);self.MiZangBtn=nil;
_UIObject_release(self.MJBXBtn);self.MJBXBtn=nil;
_UIObject_release(self.mjRankBtn);self.mjRankBtn=nil;
_UIObject_release(self.mjReddot);self.mjReddot=nil;
_UIObject_release(self.mjShopBtn);self.mjShopBtn=nil;
_UIObject_release(self.mjShopBtnReddotEx);self.mjShopBtnReddotEx=nil;
_UIObject_release(self.mjslimg);self.mjslimg=nil;
_UIObject_release(self.mjsReddot);self.mjsReddot=nil;
_UIObject_release(self.Money3TipsPanel);self.Money3TipsPanel=nil;
_UIObject_release(self.Money3TipsTx);self.Money3TipsTx=nil;
_UIObject_release(self.moneybar);self.moneybar=nil;
_UIObject_release(self.moneyBars_1);self.moneyBars_1=nil;
_UIObject_release(self.moneyBars_2);self.moneyBars_2=nil;
_UIObject_release(self.moneyBars_3);self.moneyBars_3=nil;
_UIObject_release(self.moneyBars_4);self.moneyBars_4=nil;
_UIObject_release(self.mozongStageRoot);self.mozongStageRoot=nil;
_UIObject_release(self.newSign);self.newSign=nil;
_UIObject_release(self.normalPanel);self.normalPanel=nil;
_UIObject_release(self.noTeamTips);self.noTeamTips=nil;
_UIObject_release(self.numText);self.numText=nil;
_UIObject_release(self.posBtn);self.posBtn=nil;
_UIObject_release(self.posTxt);self.posTxt=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.rightBtnLayout);self.rightBtnLayout=nil;
self.seasonRoot:deleteSelf();self.seasonRoot=nil;
_UIObject_release(self.shoumoAuto);self.shoumoAuto=nil;
_UIObject_release(self.shoumoautoclose);self.shoumoautoclose=nil;
_UIObject_release(self.shoumomodel);self.shoumomodel=nil;
_UIObject_release(self.tanChaBtn);self.tanChaBtn=nil;
_UIObject_release(self.tanChaBtnreddotEx);self.tanChaBtnreddotEx=nil;
_UIObject_release(self.tanChaReddot);self.tanChaReddot=nil;
_UIObject_release(self.taskBtn);self.taskBtn=nil;
_UIObject_release(self.taskBtnReddot);self.taskBtnReddot=nil;
_UIObject_release(self.taskItem);self.taskItem=nil;
_UIObject_release(self.taskPanal);self.taskPanal=nil;
_UIObject_release(self.teamGrid);self.teamGrid=nil;
_UIObject_release(self.title_mgzd_bg);self.title_mgzd_bg=nil;
_UIObject_release(self.title_mj_bg);self.title_mj_bg=nil;
_UIObject_release(self.title_xj_bg);self.title_xj_bg=nil;
_UIObject_release(self.uiroot);self.uiroot=nil;
_UIObject_release(self.xbnum);self.xbnum=nil;
_UIObject_release(self.xianbangBtn);self.xianbangBtn=nil;
_UIObject_release(self.xjPanel);self.xjPanel=nil;
_UIObject_release(self.zdPanel);self.zdPanel=nil;
_UIObject_release(self.zdTeamScrollView);self.zdTeamScrollView=nil;
self.moneyBars=nil;
self.btnChange=nil;
self.title_mgzd=nil;
self.title_mj=nil;
self.title_xj=nil;
end
















local _this=nil
local _Moneys1={eMoneyType.mtLingShi,eMoneyType.mtLingYu,eMoneyType.mtXianLing}
local _Moneys2={eMoneyType.mtLingShi,eMoneyType.mtLingYu,eMoneyType.mtMoLing}
local _Moneys3_OnlyMoJie={eMoneyType.mtMoZhenYiHe,eMoneyType.mtLingYu,eMoneyType.mtMoLing}
local _Moneys=_Moneys1
local _showMoneyTips3=false
local _teamItemCmpIndex={
icon=0,
name=1,
desc=2,
stateIcon=3,
speedUpBtn=4,
speedUpSelect=5,
progressbar=6,
retract=7,
detailBtn=8,
}
local signChangeType={
eZongmenExp=1,
}
local taskDoingCheckSingFunc={
[taskTypeClientCheckType.eZongMenLevel]={
changes={signChangeType.eZongmenExp,},
check=function(taskcfg)
local curExp=tonumber(tostring(zongmenModel:getExp()))
local level=zongmenModel:getLevel()
local next_cfg=cfg_guildexpconfig_get(level+1)
if next_cfg then
return curExp>=next_cfg.exp,'image_keshengji_1'
end
return false
end,
}
}

local _taskItemCmpIndex={
title=0,
desc=1,
rewardIcon=2,
rewardFlag=3,
lockFlag=4,
clickArea=5,
effect=6,
talk=7,
talkDesc=8,
effect2=9,
doingSign=10,
followFlag=11,
taskInfoRoot=12,
notTaskRoot=13,
}

local _zdItemCmpIndex={
targetText=0,
initiatorText=1,
stateText=2,
bg=3,
}
local highLODModel=3
local _seasonCmp={
icon=0,
cdTx=1,
progressBar=2,
chapterTx=3,
reddot=4,
bg=5,
}
local iconAbName="ui/windows/xianjie/xianjiemain_atlas_pak.ab"
local mjslabname='ui/windows/mojieforce/mojieforce_atlas_pak.ab'
local mojierankabname='ui/windows/mojierank/mojierank_atlas_pak.ab'

function UIXianJieMainWin:onLoaded(...)
_this=self
self:bindComponents()

self:addNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
self:addNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
self:addNotify(notifyConfig.onSeasonStageDataChange,self.onSeasonStageDataChange)
self:addNotify(notifyConfig.onSeasonEnterConditionChange,self.onSeasonEnterConditionChange)
self:addNotify(notifyConfig.onSubActivityStateChange,self.onSubActivityStateChange)
self:addNotify(notifyConfig.onSubActivityOpen,self.onSubActivityOpen)
self:addNotify(notifyConfig.onCSJDGuildDataChange,self.onCSJDGuildDataChange)
self:addNotify(notifyConfig.onXMHBGuildDataChange,self.onXMHBGuildDataChange)
self:addNotify(notifyConfig.showUI,self.showUI)
self:addNotify(notifyConfig.onXianJieCameraMove,self.onXianJieCameraMove)
self:addNotify(notifyConfig.onXianJieCameraZoom,self.onXianJieCameraZoom)
self:addNotify(notifyConfig.onXianJieCameraZoomMax,self.onXianJieCameraZoomMax)
self:addNotify(notifyConfig.onXianJieCameraLookAt,self.onXianJieCameraLookAt)
self:addNotify(notifyConfig.onXianJieCameraMoveEnd,self.onXianJieCameraMoveEnd)
self:addNotify(notifyConfig.onXianJieChangeLOD,self.onXianJieChangeLOD)
self:addNotify(notifyConfig.onXianJieBuoyAdd,self.onXianJieBuoyAdd)
self:addNotify(notifyConfig.onClickXianJiePlane,self.onClickXianJiePlane)
self:addNotify(notifyConfig.onXianJieZMMove,self.onXianJieZMMove)
self:addNotify(notifyConfig.on_money_changed,self.onUpdateMoney)
self:addNotify(notifyConfig.on_money_init,self.onInitMoney)
self:addNotify(notifyConfig.onRecvMessage,function(...)self:onRecvMessage(...)end)
self:addNotify(notifyConfig.onNewDay,self.onNewDay)
self:addNotify(notifyConfig.onZongMengLevelChange,self.onZongMengLevelChange)
self:addNotify(notifyConfig.touchUp,self.on_touch_up)
self:addNotify(notifyConfig.iconUnlock,self.onIconUnlock)
self:addNotify(notifyConfig.on_system_open,self.onSystemOpen)
self:addNotify(notifyConfig.onTaskInit,self.onTaskInit)
self:addNotify(notifyConfig.onTaskChange,self.onTaskChange)
self:addNotify(notifyConfig.onTaskRecommand,self.onTaskRecommand)
self:addNotify(notifyConfig.onTaskRemove,self.onTaskRemove)
self:addNotify(notifyConfig.onEnterXianJieBt,self.onEnterXianJieBt)
self:addNotify(notifyConfig.onLeaveXianJieBt,self.onLeaveXianJieBt)

self:addNotify(notifyConfig.onXianJieWaiPaiChange,self.onXianJieWaiPaiChange)
self:addNotify(notifyConfig.onXianJieMapDataInit,self.onXianJieMapDataInit)

self:addNotify(notifyConfig.onXianMengChange,self.onXianMengChange)
self:addNotify(notifyConfig.onXianJieCloudUnlockAddQueue,self.onXianJieCloudUnlockAddQueue)

self:addNotify(notifyConfig.onZongMenBuffFresh,self.onXianJieBuffFresh)
self:addNotify(notifyConfig.onXianJieBuffFresh,self.onXianJieBuffFresh)

self:addNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
self:addNotify(notifyConfig.onLimitActOpen,self.onLimitActOpen)
self:addNotify(notifyConfig.onXianJieFactionReddotChange,self.onXianJieFactionReddotChange)
self:addNotify(notifyConfig.enterXianJie,self.onEnterXianJie)
self:addNotify(notifyConfig.onXianJieMonsterChange,self.onXianJieMonsterChange)

self:addNotify(notifyConfig.onXianJieMainWinSimpleStateChange,self.onXianJieMainWinSimpleStateChange)

self:addProNotify(35,90,self.on_35_90)
self:addProNotify(35,95,self.on_35_95)

self:addNotify(notifyConfig.onTYTXZRewardChange,self.onTYTXZRewardChange)

self:addNotify(notifyConfig.onFPSJianHuaChange,self.onFPSJianHuaChange)

self.groupBtnNodeID={
[MAIN_ICON_GROUP_TYPE.eBottom]=function()
return self.BottomList:getID()
end,
}

self.touchOverUI_Money3Tips=function(over)self:touchOverUI_Money3(over)end
self.winlua:SetTouchOverUI(self.Money3TipsPanel:getID(),self.touchOverUI_Money3Tips)

local buoyWidgetRoot=self.buoyRoot:getWidgetBase()
xianjieController:setBuoyParent(buoyWidgetRoot)
self.iconRoots={}
local iconRoots=self.iconRoots
iconRoots[#iconRoots+1]=self.bg0
iconRoots[#iconRoots+1]=self.bg1
iconRoots[#iconRoots+1]=self.bg2
iconRoots[#iconRoots+1]=self.bg3
iconRoots[#iconRoots+1]=self.bg4

myxpcall(function()
self.handler=chatMessageMainHandler.create(self.chatCreater,self.chatContent:getID(),self)
self:registerChatMainHandle()
self.chatCreater:setRefreshAction(function(...)self:onFinishChatCreatAction(...)end)
chatControl.freshMainMesgPanel(MAIN_HOLD_TYPE.eMain,self.handler)
end)

self.loadIcons={}
self.iconLuaObjectLookup={}
end


function UIXianJieMainWin:__delete()
self:clearStateTimer()
self:releaseAllButton()
self:unregisterChatMainHandle()
self.chatCreater:setRefreshAction(nil)
_this=nil
_showMoneyTips3=false
self:unbindComponents()

xianjieController:setBuoyParent(nil)
xianjieController:refreshAllBuoy(false)
clear_xjBuoyWidgetPool()
xianjieModel:clearSceneState_closeMain()
end


function UIXianJieMainWin:onHide()

if self.handler then
self.handler:pauseRecvMsg()
end

if self.mytimer~=nil then
self:stopTimerByID(self.mytimer)
self.mytimer=nil
end
if self.mytimer_fast~=nil then
self:stopTimerByID(self.mytimer_fast)
self.mytimer_fast=nil
end
self:clearStateTimer()
xianjieModel:clearSceneState_closeMain()
self:hideSeasonAllEnterItem()
end




function UIXianJieMainWin:onShow(argtable,afterOnloaded)
local sceneIdx=xianjieModel:getSceneIndex()

if xianjienSceneIndexType:isMoGongZhengDuo(sceneIdx)then
_Moneys=_Moneys2
elseif xianjienSceneIndexType:isMoJie(sceneIdx)and self:checkIsDisplayMoJieYiHeInMoJie()then
_Moneys=_Moneys3_OnlyMoJie
elseif xianjienSceneIndexType:isMoJie(sceneIdx)then
_Moneys=_Moneys2
else
_Moneys=_Moneys1
end
self:initMoneyBar()
if self.handler then
self.handler:resumeRecvMsg()
end

if self.mytimer==nil then
self.mytimer=self:setTimer(1,0,function()
self:refreshTime()
end)
self:refreshTime()
end
if self.mytimer_fast==nil then
self.mytimer_fast=self:setTimer(0.2,0,function()
self:refreshTime_fast()
end)
self:refreshTime_fast()
end
self:refreshSeasonEnter()
self:freshChatReddot()
self:setContentBottom()
self:refreshMapViewPos()
self:refreshMapName()
self:creatGroupBtns()
self:refreshTaskPanel()
self:refreshTeamPanel(true)
self:refreshHomeBtn()
self:refreshJiJieBtn()
self:refreshBuffBtn()
self:refreshTanChaBtn()

self:refreshFeedBookBtn()
self:refreshXianbangBtn()
self:initMiZangPanel(true)
xianjieController:refreshAllBuoy(false)
xianjieController:updataAllBuoy()

self.onInitMoney()

self:showWindow('UIXianJie_MsgWin')

self:checkActMode(true)
self:checkExtraWindow()
self:refreshShouMoAuto()
buildlightController:setBLState(false)

self:initRedPacket()
self:refreshRedPacket()
self:refreshButtonBack()
self:refreshLeftMenuExPanel()
self:refreshMjRank()
self:refreshMoZongBtn()
self:refreshMjShop()
self:refreshMoJiePanel()
self:refreshLimitMoveZMBtn()
self:refreshEasyDealBtns()

self:freshSimpleBtn()

self:refreshAllPartSimpleState()

end

function UIXianJieMainWin:refreshTime()
local cameraFollow=xianjieModel:checkCameraFollow()
if self.mapPosChange or cameraFollow then
self:refreshMapViewPos()
self.mapPosChange=nil
end
if cameraFollow then
xianjieController:refreshAllBuoy(true)
self.buoyChange=nil
end
xianjieController:updataAllBuoy()
if self.winChange then
xianjieModel:checkSceneState_winOpen(self.winChangeName)
self.winChange=nil
end
end

function UIXianJieMainWin:refreshTime_fast()
if self.buoyChange then
xianjieController:refreshAllBuoy(true)
self.buoyChange=nil
end
end

function UIXianJieMainWin:onReConnection()
if self.handler then
self.handler:resumeRecvMsg()
end
self:freshMainMesgPanel()
end

function UIXianJieMainWin:freshMainMesgPanel()
self.chatCreater:recycleAll()
chatControl.freshMainMesgPanel(MAIN_HOLD_TYPE.eMain,self.handler)
end

function UIXianJieMainWin.showUI(name)
if _this==nil or not _this.isVisible then return end
_this.winChange=true
_this.winChangeName=name
end

function UIXianJieMainWin.onXianJieCameraMove()
if _this==nil or not _this.isVisible then return end
_this.mapPosChange=true
_this.buoyChange=true
end

function UIXianJieMainWin.onXianJieCameraLookAt()
if _this==nil or not _this.isVisible then return end
_this.mapPosChange=true
_this.buoyChange=true
end

function UIXianJieMainWin.onXianJieCameraMoveEnd()
if _this==nil or not _this.isVisible then return end
_this.mapPosChange=true
_this.buoyChange=true
end

function UIXianJieMainWin.onXianJieCameraZoom()
if _this==nil or not _this.isVisible then return end
_this.buoyChange=true
end

function UIXianJieMainWin.onXianJieCameraZoomMax()
if _this==nil or not _this.isVisible then return end

end

function UIXianJieMainWin.onXianJieChangeLOD(lodLevel)
if _this==nil or not _this.isVisible then return end
local showHignLOD=lodLevel>=highLODModel
_this.hightCameraPanel:setActive(showHignLOD)

local alpha=not showHignLOD and 1 or 0
local raycast=not showHignLOD
_this.winlua:SetChildCanvasGroupAlpha(_this.chatRoot:getID(),alpha)
_this.winlua:SetChildCanvasGroupRaycast(_this.chatRoot:getID(),raycast)
_this:closeFilterHUD2Win()
end

function UIXianJieMainWin.onXianJieBuoyAdd()
if _this==nil or not _this.isVisible then return end
_this.buoyChange=true
end

function UIXianJieMainWin.onClickXianJiePlane(gridX,gridZ,worldX,worldZ)
if _this==nil or not _this.isVisible then return end

end

function UIXianJieMainWin.onXianJieZMMove()
if _this==nil or not _this.isVisible then return end
_this:refreshHomeBtn()
end

function UIXianJieMainWin.onZongMengLevelChange()
if _this==nil or not _this.isVisible then return end
_this:freshChatReddot()
end

function UIXianJieMainWin.onNewDay()
if _this==nil or not _this.isVisible then return end
_this:freshChatReddot()
_this:refreshFeedBookBtn()
_this:refreshSeasonEnter()
end

function UIXianJieMainWin.on_touch_up(fingerIndex,touchCount,screenPoint,guid)
if _this==nil or not _this.isVisible then return end
if _showMoneyTips3 then

end
end

function UIXianJieMainWin.onIconUnlock(iconTypes)
if _this==nil or not _this.isVisible then return end
_this:onIconRefresh(iconTypes)
end

function UIXianJieMainWin.onTaskInit()
if _this==nil or not _this.isVisible then return end
_this:refreshTaskPanel()
end

function UIXianJieMainWin.onSystemOpen(sysid)
if _this==nil or not _this.isVisible then return end
if sysid==SYSTEM_DEFINE.eJiuChongTianJieComplete then
_this:refreshSeasonEnter()
end
end

function UIXianJieMainWin.onTaskRemove(taskid)
if _this==nil or not _this.isVisible then return end
_this:refreshTaskPanel()
end

function UIXianJieMainWin.onTaskChange(taskid,taskstate,cur_num,old_num)
if _this==nil or not _this.isVisible then return end
_this:refreshTaskPanel()
end

function UIXianJieMainWin.onTaskRecommand()
if _this==nil or not _this.isVisible then return end
_this:refreshTaskPanel()
end

function UIXianJieMainWin.onXianJieWaiPaiChange(changeType,param)
if _this==nil or not _this.isVisible then return end
local isInit=false
if changeType==CHANGE_TYPE.eInit then
isInit=true
elseif changeType==CHANGE_TYPE.eAdd then
if param then
local teamHandle=param
_this:addTeamHandle(teamHandle.m_ID)
end
elseif changeType==CHANGE_TYPE.eDelete then
if param then
local teamHandleId=param
_this:removeTeamHandle(teamHandleId)
end
end

if _this.isShowLeftMenu then
_this:refreshLeftMenuPanel(isInit)
else
_this:refreshTeamPanel(isInit)
end

if changeType==CHANGE_TYPE.eAdd then
if param and param.teamType==xjTeamHandleType.eMarchMJBoxCJ then
_this:refreshMJBXBtn()
end
end
end

function UIXianJieMainWin.onXianJieMapDataInit()
if _this==nil or not _this.isVisible then return end
if _this.isShowLeftMenu then
_this:refreshLeftMenuPanel(true)
else
_this:refreshTeamPanel(true)
end
end

function UIXianJieMainWin.onXianMengChange()
if _this==nil or not _this.isVisible then return end
_this:refreshJiJieBtn()
end

function UIXianJieMainWin.onXianJieCloudUnlockAddQueue()
if _this==nil or not _this.isVisible then return end
if _this.isShowLeftMenu then
_this:refreshLeftMenuPanel()
else
_this:refreshTeamPanel()
end
end

function UIXianJieMainWin.onXianJieBuffFresh()
if _this==nil or not _this.isVisible then return end
_this:refreshBuffBtn()
end

function UIXianJieMainWin.onLimitActStateChange(actID,actState)
if _this==nil or not _this.isVisible then return end
if actState==limitActivitiesModel.actDoingState or actState==limitActivitiesModel.actFinishState then
if actID==LIMIT_ACT_TYPE.eLeiTaiYanWu then

_this:checkActMode()
if actState==limitActivitiesModel.actDoingState then
_this:checkExtraWindow()
end
end
_this:refreshLeftMenuExPanel()
end
if actID==LIMIT_ACT_TYPE.eMojieSaiJi then
_this:refreshButtonBack()
_this:refreshSeasonEnter()
end
end

function UIXianJieMainWin.onLimitActOpen(actID)
if _this==nil or not _this.isVisible then return end
if actID==LIMIT_ACT_TYPE.eMoJiang then
_this:refreshLeftMenuExPanel()
end
end

function UIXianJieMainWin.onEnterXianJieBt()
if _this==nil or not _this.isVisible then return end
_this:checkActMode()
_this:checkExtraWindow()
_this:refreshLeftMenuExPanel()
end

function UIXianJieMainWin.onLeaveXianJieBt()
if _this==nil or not _this.isVisible then return end
_this:checkActMode()
_this:checkExtraWindow()
_this:refreshLeftMenuExPanel()
end

function UIXianJieMainWin.onXianJieFactionReddotChange()
if _this==nil or not _this.isVisible then return end
_this:refreshTanChaReddot()
end



function UIXianJieMainWin:refreshMapViewPos()
local pos=xianjieController:getCameraLookAtPlanePos()
local sceneType=xianjieModel:getScenceType()
local mapName

if sceneType==xianjienSceneType.eXianJie or xianjienSceneType:isMoJie(sceneType)or xianjienSceneType:isMoGongZhengDuo(sceneType)then

mapName=cfgHelper.get2(cfg_xianjiesceneconfig_get,sceneType,'name')
else

local serverName=xianjieController:getCrossServerNamebySCidx(sceneType-2)or""
mapName=serverName
end
local pos_str
if pos then
local gridX,gridZ=xianjieController:worldPos2WorldGridPos(pos.x,pos.z)

pos_str=FMT.fmt("{0} [{1},{2}]",mapName,gridX,gridZ)
else

pos_str=mapName
end
self.posTxt:setText(pos_str)
end

function UIXianJieMainWin:refreshMapName()
local sceneType=xianjieModel:getScenceType()
local name=cfgHelper.get2(cfg_xianjiesceneconfig_get,sceneType,'name')
self.mapNameTxt:setText(name)
end

function UIXianJieMainWin:getCrossServerName()
local severId=xianjieModel:getXianYuCrossServerId()
local info=severId and loginModel:getServerZoneInfoDataByServerID(severId)or nil
if info and info.zone_name then
return info.zone_name
else
local sceneType=xianjieModel:getScenceType()
local name=sceneType and cfgHelper.get2(cfg_xianjiesceneconfig_get,sceneType,'name')or nil
if name then
return name
else
return"未知仙域"
end
end
end

function UIXianJieMainWin:onMiniMapBtn()
self:openMiniMap()

end

function UIXianJieMainWin:onPosBtn()
UIManager:showWindow('UIXianJie_jumpPosWin')
end

function UIXianJieMainWin:onCloseBtn()
mainControl:enterHome({eSceneType.eZongmen})
end
function UIXianJieMainWin:onRecordBtn()
self:showWindow('UIXianJieRecordWin')
end

function UIXianJieMainWin:onJiJieBtn()

local page=1
local reddotNum_PVE=xianjieModel:getJiJieDirtyDataTypeNum(xjJjJieBaseType.eMonster)
local reddotNum_PVP=xianjieModel:getJiJieDirtyDataTypeNum(xjJjJieBaseType.eWar)
if reddotNum_PVE<=0 and reddotNum_PVP>0 then
page=2
end

UIManager:showWindow('UIXianJie_JiJie_teamListBgWin',{page=page})
end

function UIXianJieMainWin:onBuffBtn()
local win=UIManager:findActiveWindow('UIXianJieHomeBuffWin')
if not win then
UIManager:showWindow('UIXianJieHomeBuffWin')
else
win:showHomeBuffPanel()
end
self:hideChatRoot(true)
end



function UIXianJieMainWin:refreshHomeBtn()
local check=false
local zmData=xianjieModel:getMyZongMenData()
if zmData~=nil and not zmData:checkInCurScene()then
check=true
end
self.homeBtn:setActive(check)
end

function UIXianJieMainWin:onHomeBtn()

xianjieModel:jumpMyZongMen()
end




function UIXianJieMainWin:refreshTaskPanel()
local isShow=not xianjieController:checkInMoGongZhengDuo()
self.taskPanal:setActive(isShow)
if not isShow then return end

local show_list=taskModel:getTaskList_show()
local isShowTaskInfo=#show_list>0
self.showTaskData=nil
local item=self.taskItem:getWidgetBase()
item:SetChildActive(_taskItemCmpIndex.taskInfoRoot,isShowTaskInfo)
item:SetChildActive(_taskItemCmpIndex.notTaskRoot,not isShowTaskInfo)
if isShowTaskInfo then

local taskdata=self:getFirstShowSortTaskData(show_list)
self.showTaskData=taskdata
local taskid=taskdata.taskid
local taskcfg=taskdata.cfg
local taskstateResult=taskModel:getTaskState(taskdata)
local t_taskstate=taskstateResult.state
local cur=taskstateResult.curnum
local max=taskstateResult.maxnum


local title_str=taskModel:getTaskPrefixAndName(taskcfg)
local desc_str=taskcfg.taskaimdesc
local islock=false
local showreward=false
if t_taskstate==taskModel.taskAcceptState then
islock=not taskModel:fitAcceptCondition(taskid)
if islock then
desc_str=FMT.fmt('{0}（未解锁）',desc_str)
else
desc_str=FMT.fmt('{0}（未接取）',desc_str)
end
elseif t_taskstate==taskModel.taskDoingState then
desc_str=FMT.fmt('{0}（{1}/{2}）',desc_str,mathHelper.formatBIGNumbereEx(cur),mathHelper.formatBIGNumbereEx(max))
elseif t_taskstate==taskModel.taskRewardState then
self.curTaskHasReward=true
desc_str=FMT.fmt('{0}',desc_str)
end
if taskcfg.taskfinishDesc and t_taskstate==taskModel.taskRewardState then
desc_str=taskcfg.taskfinishDesc
else



end

item:SetChildText(_taskItemCmpIndex.title,taskModel.getLineTitleColorStr(taskdata.taskline,title_str))
item:SetChildText(_taskItemCmpIndex.desc,desc_str)
item:SetChildActive(_taskItemCmpIndex.lockFlag,islock)













local rewardEffectID=10761
local hasReward=t_taskstate==taskModel.taskRewardState
showreward=hasReward

local showrewardIcon=showreward
item:SetChildActive(_taskItemCmpIndex.rewardIcon,showrewardIcon)
item:SetChildActive(_taskItemCmpIndex.rewardFlag,showreward)
item:SetChildShowEffect(_taskItemCmpIndex.effect,rewardEffectID,showreward)

local showSign=false
local flag,signImg
if t_taskstate==taskModel.taskDoingState then
local lp=taskDoingCheckSingFunc[taskcfg.tasktype]
if lp then
flag,signImg=lp.check(taskcfg)
if flag then
showSign=true
end
end
end
item:SetChildActive(_taskItemCmpIndex.doingSign,showSign)
if showSign then
item:SetChildCSImageSprite(_taskItemCmpIndex.doingSign,globalABLookup.global,signImg)
end


local isTraceTask=taskModel:isZhuiZongTask(taskdata.taskline)
local isShowFollowFlag=isTraceTask and not showreward and not showSign
item:SetChildActive(_taskItemCmpIndex.followFlag,isShowFollowFlag)
local newtaskweak=taskModel:GetnewtaskweakGuide()
if next(newtaskweak)then
if taskid==newtaskweak[2]then

taskModel:newtaskweakGuide()
else
weakGuideController:beginGuide(newtaskweak[1])
taskModel:newtaskweakGuide()
end
end
if taskModel:GetisNewTask(taskcfg.tasklineid)then
taskModel:SavetaskModel_newtask(taskcfg.tasklineid,nil)
end
local flag1,flag2,flag3=taskModel:GetHaveNewTask()
self.newSign:setActive(flag1 or flag2 or flag3)
end
end


function UIXianJieMainWin:onTaskBtn()

local show_list=taskModel:getTaskList_show()
if#show_list>0 then
UIFullTaskMainControl:showWindowTask()
else
UIManager.error('暂无任务')
end
end


function UIXianJieMainWin:onTaskItem()
if not self.showTaskData then
return
end

local taskdata=self.showTaskData
local taskid=taskdata.taskid
local cickTask=logPoint.GetValue('onClickFirstTask',false)
if cickTask==false then
logPoint.SetValue('onClickFirstTask',true)
logPoint.UploadLog(logPoint.logType.clickFirstTask)
end
local t_taskstate=taskModel:getTaskState_transfromstate(taskdata)
if t_taskstate==taskModel.taskAcceptState then
local fit,w_str=taskModel:fitAcceptCondition(taskid)
if not fit then
UIManager.error(w_str)
return
end
taskController:doAcceptTask(taskid)
elseif t_taskstate==taskModel.taskDoingState then
taskController:doJump(taskid)
elseif t_taskstate==taskModel.taskRewardState then
taskController:doGetTaskReward_before(taskid)
end
self:startClickNewBie(taskid,t_taskstate,taskdata.taskline)
end


function UIXianJieMainWin:getFirstShowSortTaskData(taskList)
local maxData
for i,taskdata in ipairs(taskList)do
local taskstate=taskModel:getTaskState_transfromstate(taskdata)

local isCanGetReward=taskstate==taskModel.taskRewardState
local isTraceTask=taskModel:isZhuiZongTask(taskdata.taskline)
local isXianJieTask=taskModel:isXianJieTask(taskdata.taskline)
local isMainTask=taskdata.taskline==taskModel.lineMain

local weight=0
if isCanGetReward then
weight=100000
elseif isTraceTask then
weight=90000
elseif isMainTask then
if taskstate==taskModel.taskDoingState then
weight=80000
elseif taskstate==taskModel.taskAcceptState then
weight=60000
end
elseif isXianJieTask then
weight=70000
end

if not maxData then
maxData={weight=weight,data=taskdata}
else
if weight>maxData.weight then
maxData={weight=weight,data=taskdata}
elseif weight==maxData.weight and taskdata.taskline>maxData.data.taskline then
maxData={weight=weight,data=taskdata}
end
end
end

if maxData then
return maxData.data
end
end

function UIXianJieMainWin:startClickNewBie(taskid,t_taskstate,taskline)
local typo=t_taskstate==taskModel.taskAcceptState and NEW_BIE_CND_TYPE.eNotAcceptTask or
t_taskstate==taskModel.taskDoingState and NEW_BIE_CND_TYPE.eAcceptTask or
t_taskstate==taskModel.taskRewardState and NEW_BIE_CND_TYPE.eDoTask or
NEW_BIE_CND_TYPE.eFinshTask
newbieControl.startNewbie(typo,taskid,t_taskstate,1)
end



function UIXianJieMainWin:refreshTeamPanel(isInit)
self:clearStateTimer()

local allTeamCount=xianjieModel:getWaiPaiTeamMaxNum()

local teamHandleIdList=self:getTeamHandleIdList(isInit)
local doingTeamCount=#teamHandleIdList

local unlockTeamCount=xianjieModel:getWaiPaiTeamUnlockNum()
local maxExtraTeamCount=xianjieModel:getWaiPaiTeamMaxExtraNum()

if(self.isShowLeftMenu and self.selectMenuPageIndex~=2)or(not self.isHideSkin and self.mainExPanelCfg and not self.mainExPanelCfg.checkTaskShow(self))then

return
end


self.teamGrid:setChildLayoutGroupCreateItems(doingTeamCount,function(index)
local widget=self.teamGrid:getChildLayoutGroupGridItem(index-1)
local teamHandleId=teamHandleIdList[index]
local teamHandle=xianjieController:getXJTeamHandle(teamHandleId)
if teamHandle then
widget:SetChildActive(-1,true)
local teamType=teamHandle.teamType
local teamState=teamHandle:getTeamState()

local targetIconName=teamHandle:getTargetIconName(teamState)
widget:SetChildCSImageSprite(_teamItemCmpIndex.icon,iconAbName,targetIconName)


local targetName=teamHandle:getTargetName(teamState)
if targetName then
widget:SetChildText(_teamItemCmpIndex.name,targetName)
end

local isShowProgress=teamHandle:checkIsShowProgress(teamState)
widget:SetChildActive(_teamItemCmpIndex.progressbar,isShowProgress)
widget:SetChildActive(_teamItemCmpIndex.desc,not isShowProgress)
if isShowProgress then

local lerpTime,wayTime=teamHandle:geLerpTime()
if wayTime and lerpTime>0 then
lerpTime=math.ceil(lerpTime)
widget:SetChildProgressValue(_teamItemCmpIndex.progressbar,wayTime-lerpTime,wayTime)
local time_str=timeHelper.format_time_stamp(lerpTime,true)
widget:SetChildProgressText(_teamItemCmpIndex.progressbar,time_str)
else
widget:SetChildProgressValue(_teamItemCmpIndex.progressbar,100,100)
local time_str=timeHelper.format_time_stamp(0,true)
widget:SetChildProgressText(_teamItemCmpIndex.progressbar,time_str)






end
else

local desc=teamHandle:getTargetDesc(teamState)or""
widget:SetChildText(_teamItemCmpIndex.desc,desc)
end

local isCanSpeedUp=teamHandle:checkSpeeUp()
widget:SetChildActive(_teamItemCmpIndex.speedUpBtn,isCanSpeedUp)

local isCanRetract=teamHandle:checkRetract()
widget:SetChildActive(_teamItemCmpIndex.retract,not isCanSpeedUp and isCanRetract)

local isShowDetail=teamHandle:checkDetail()
widget:SetChildActive(_teamItemCmpIndex.detailBtn,not isCanSpeedUp and not isCanRetract and isShowDetail)

if isCanSpeedUp then
widget:SetChildActive(_teamItemCmpIndex.stateIcon,false)

local isSelect=self.selectSpeedUpOnlyKey==teamHandle.onlykey
widget:SetChildActive(_teamItemCmpIndex.speedUpSelect,isSelect)


widget:SetChildButtonClick(_teamItemCmpIndex.speedUpBtn,function()
return self:onClickSpeedUpBtn(teamHandleId,teamHandle.onlykey)
end,true)
elseif isCanRetract then
widget:SetChildActive(_teamItemCmpIndex.stateIcon,false)

widget:SetChildButtonClick(_teamItemCmpIndex.retract,function()
return self:onClickRetract(index)
end,true)
elseif isShowDetail then

widget:SetChildButtonClick(_teamItemCmpIndex.detailBtn,function()
return self:onClickDetailBtn(index)
end,true)
else

local stateIconName=teamHandle:getStateIconName(teamState)
local isShowStateIcon=stateIconName~=nil
widget:SetChildActive(_teamItemCmpIndex.stateIcon,isShowStateIcon)
if isShowStateIcon then
widget:SetChildCSImageSprite(_teamItemCmpIndex.stateIcon,iconAbName,stateIconName)
end
end

local jumpFunc=function()
local sceneidx,gridX,gridZ

local clickEntKey=teamHandle:getTeamEnityKey()
xianjieModel:enterSceneState_clickTeam_before(clickEntKey)
if not clickEntKey then

local teamSceneIdx
if teamHandle.teamType==xjTeamHandleType.eMoJunBoxTeam then
teamSceneIdx=xianjienSceneIndexType.eMoJie
else
teamSceneIdx=teamHandle.teamData and(teamHandle.teamData.sceneidx or teamHandle.teamData.tarsceneidx)or xianjienSceneIndexType.eXianJie
end
local teamLogicSceneType=xianjieController:transSceneIdxToLogicSceneType(teamSceneIdx)
local nowSceneIdx=xianjieModel:getSceneIndex()
local nowLogicSceneType=xianjieController:transSceneIdxToLogicSceneType(nowSceneIdx)

if teamLogicSceneType~=nowLogicSceneType then
local content="该队伍不在当前场景 是否跳转至对应场景？"
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='前往',
canceltext='取消',
okcallback=function()
local sceneType=xianjieModel:sceneIndex2SceneType(teamSceneIdx)
return xianjieController:jumpXianJie(sceneType,nil,function()
local sceneidx,gridX,gridZ=teamHandle:getTargetPos()
if sceneidx then
return xianjieController:jumpGrid(sceneidx,gridX,gridZ,nil,true)
end
end)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return false
end


sceneidx,gridX,gridZ=teamHandle:getTargetPos()
end
if sceneidx then
xianjieController:jumpGrid(sceneidx,gridX,gridZ,nil,true)
end
end


if teamType==xjTeamHandleType.eJiJieJoin or teamType==xjTeamHandleType.eJiJieChuZheng then
local showMsgWinFunc=function()
local actorId
if teamType==xjTeamHandleType.eJiJieJoin then
actorId=teamHandle.teamData.taractorid
elseif teamType==xjTeamHandleType.eJiJieChuZheng then
actorId=teamHandle.teamData.actorid
end
local guid=int64.new(tostring(teamHandle.teamData.massguid))

local teamSceneIdx=teamHandle.teamData and(teamHandle.teamData.sceneidx or teamHandle.teamData.tarsceneidx)or xianjienSceneIndexType.eXianJie

UIManager:showWindow("UIXianJie_JiJie_msgWin",{actorId=actorId,guid=guid,sceneidx=teamSceneIdx})
end

local infoFunc=function()
local teamSceneIdx=teamHandle.teamData and(teamHandle.teamData.sceneidx or teamHandle.teamData.tarsceneidx)or xianjienSceneIndexType.eXianJie
local teamLogicSceneType=xianjieController:transSceneIdxToLogicSceneType(teamSceneIdx)
local nowSceneIdx=xianjieModel:getSceneIndex()
local nowLogicSceneType=xianjieController:transSceneIdxToLogicSceneType(nowSceneIdx)

if teamLogicSceneType~=nowLogicSceneType then
local content="该队伍不在当前场景 是否跳转至对应场景？"
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='前往',
canceltext='取消',
okcallback=function()
local sceneType=xianjieModel:sceneIndex2SceneType(teamSceneIdx)
return xianjieController:jumpXianJie(sceneType,nil,function()
return showMsgWinFunc()
end)
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return false
end
return showMsgWinFunc()
end
widget:SetChildButtonClick(-1,infoFunc,true)
elseif teamType==xjTeamHandleType.eJiJieWait then
local infoFunc=function()

return teamHandle:onDetailShow()
end
widget:SetChildButtonClick(-1,infoFunc,true)
else
widget:SetChildButtonClick(-1,jumpFunc,true)
end

widget:SetChildButtonClick(_teamItemCmpIndex.icon,jumpFunc,true)

if index>=doingTeamCount then






self:setStateTimer()
end
else
widget:SetChildActive(-1,false)
end
end)


local freeTeamCount=allTeamCount-doingTeamCount
local isShowFreeTeam=freeTeamCount>0
self.freeTeamItem:setActive(isShowFreeTeam)
if isShowFreeTeam then
local widget=self.freeTeamItem:getWidgetBase()
widget:SetChildText(0,FMT.fmt("{0}个队列空闲中......",freeTeamCount))
end


local isShowExtraPanel=unlockTeamCount<maxExtraTeamCount
self.extraTeamItem:setActive(isShowExtraPanel)
end

function UIXianJieMainWin:refreshTeamPanel_update()
local grids=self.teamGrid:getChildLayoutGroupGridList()
local teamHandleIdList=self:getTeamHandleIdList()
for i=1,grids.Count do
local widget=grids[i-1]
local teamHandleId=teamHandleIdList[i]
local teamHandle=xianjieController:getXJTeamHandle(teamHandleId)
if teamHandle then
widget:SetChildActive(-1,true)

local teamState=teamHandle:getTeamState()

local targetIconName=teamHandle:getTargetIconName(teamState)
widget:SetChildCSImageSprite(_teamItemCmpIndex.icon,iconAbName,targetIconName)


local targetName=teamHandle:getTargetName(teamState)
if targetName then
widget:SetChildText(_teamItemCmpIndex.name,targetName)
end

local isShowProgress=teamHandle:checkIsShowProgress(teamState)
widget:SetChildActive(_teamItemCmpIndex.progressbar,isShowProgress)
widget:SetChildActive(_teamItemCmpIndex.desc,not isShowProgress)
if isShowProgress then

local lerpTime,wayTime=teamHandle:geLerpTime()
if wayTime and lerpTime>0 then
lerpTime=math.ceil(lerpTime)
widget:SetChildProgressValue(_teamItemCmpIndex.progressbar,wayTime-lerpTime,wayTime)
local time_str=timeHelper.format_time_stamp(lerpTime,true)
widget:SetChildProgressText(_teamItemCmpIndex.progressbar,time_str)
else
widget:SetChildProgressValue(_teamItemCmpIndex.progressbar,100,100)
local time_str=timeHelper.format_time_stamp(0,true)
widget:SetChildProgressText(_teamItemCmpIndex.progressbar,time_str)

return self:refreshTeamPanel()
end
else

local desc=teamHandle:getTargetDesc(teamState)or""
widget:SetChildText(_teamItemCmpIndex.desc,desc)
end

local isCanSpeedUp=teamHandle:checkSpeeUp()
widget:SetChildActive(_teamItemCmpIndex.speedUpBtn,isCanSpeedUp)
if isCanSpeedUp then
widget:SetChildActive(_teamItemCmpIndex.stateIcon,false)

local isSelect=self.selectSpeedUpOnlyKey==teamHandle.onlykey
widget:SetChildActive(_teamItemCmpIndex.speedUpSelect,isSelect)
else

local stateIconName=teamHandle:getStateIconName(teamState)
local isShowStateIcon=stateIconName~=nil
widget:SetChildActive(_teamItemCmpIndex.stateIcon,isShowStateIcon)
if isShowStateIcon then
widget:SetChildCSImageSprite(_teamItemCmpIndex.stateIcon,iconAbName,stateIconName)
end
end
end
end
end

function UIXianJieMainWin:refreshTeamPanel_onlySelect(isClearKey)
if isClearKey then
self.selectSpeedUpOnlyKey=nil
end
local grids=self.teamGrid:getChildLayoutGroupGridList()
local teamHandleIdList=self:getTeamHandleIdList()
for i=1,grids.Count do
local widget=grids[i-1]
local teamHandleId=teamHandleIdList[i]
local teamHandle=xianjieController:getXJTeamHandle(teamHandleId)
if teamHandle then
local isCanSpeedUp=teamHandle:checkSpeeUp()
if isCanSpeedUp then

local isSelect=self.selectSpeedUpOnlyKey==teamHandle.onlykey
widget:SetChildActive(_teamItemCmpIndex.speedUpSelect,isSelect)
end
end
end
end

function UIXianJieMainWin:setStateTimer()
self:clearStateTimer()
local func=function()
if not _this then return end
if self.isShowLeftMenu then
return self:refreshLeftMenuPanel_update()
else
return self:refreshTeamPanel_update()
end
end

self.stateUpdateTimer=self:setTimer(0.25,0,func)
end

function UIXianJieMainWin:clearStateTimer()
if self.stateUpdateTimer then
self:stopTimerByID(self.stateUpdateTimer)
self.stateUpdateTimer=nil
end
end


function UIXianJieMainWin:onFreeTeamItem()

self:onTanChaBtn()
end


function UIXianJieMainWin:onExtraTeamItem()

local args={}
args.titleName='队伍拓展'
args.showClose=false
args.pos=2
args.extraWin='UIXianJie_extraTeamGainWin'


local extraParams={}
args.extraParams=extraParams

UIManager:showWindow('UICommonPageWin',args)
end

function UIXianJieMainWin:openSpeedUpWinByOnlyKey(onlyKey)
local teamHandleIdList=self:getTeamHandleIdList()

for i,teamHandleId in ipairs(teamHandleIdList)do

local teamHandle=xianjieController:getXJTeamHandle(teamHandleId)
if teamHandle and teamHandle.onlykey==onlyKey then
return self:onClickSpeedUpBtn(teamHandleId,onlyKey)
end
end
end

function UIXianJieMainWin:onClickSpeedUpBtn(teamHandleId,onlyKey)











self.selectSpeedUpOnlyKey=onlyKey


local teamHandle=xianjieController:getXJTeamHandle(teamHandleId)
local marchtype=teamHandle:getMarchtype()

self:showWindow("UIXianJie_speedUpWin",{onlykey=onlyKey,marchtype=marchtype})
self:refreshTeamPanel_onlySelect()
end

function UIXianJieMainWin:onClickRetract(index)
local teamHandleIdList=self:getTeamHandleIdList()
local teamHandleId=teamHandleIdList[index]
local teamHandle=xianjieController:getXJTeamHandle(teamHandleId)
if teamHandle then
if teamHandle.teamType==xjTeamHandleType.eMarchYuanZhu then
local showdata=
{
type='UIDialouge',
title='提示',
content='祖师是否要撤回援军？',
oktext='撤回',
canceltext='取消',
allowclickBG=false,
okcallback=function(...)
teamHandle:doRetract()
end,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
else
teamHandle:doRetract()
end
end
end

function UIXianJieMainWin:onClickDetailBtn(index)
local teamHandleIdList=self:getTeamHandleIdList()
local teamHandleId=teamHandleIdList[index]
local teamHandle=xianjieController:getXJTeamHandle(teamHandleId)
if teamHandle then
teamHandle:onDetailShow()
end
end

function UIXianJieMainWin:getTeamHandleIdList(isReset)
if not isReset and self.teamHandleIdList then
return self.teamHandleIdList
end

local teamHandleList=xianjieModel:getAllWaiPaiTeamHandle()
self.teamHandleIdList={}
for i,teamHandle in ipairs(teamHandleList)do
self.teamHandleIdList[#self.teamHandleIdList+1]=teamHandle.m_ID
end

return self.teamHandleIdList
end

function UIXianJieMainWin:addTeamHandle(teamHandleId)
self.teamHandleIdList[#self.teamHandleIdList+1]=teamHandleId
end

function UIXianJieMainWin:removeTeamHandle(teamHandleId)
local newList={}
for index,handleId in ipairs(self.teamHandleIdList)do
if handleId~=teamHandleId then
newList[#newList+1]=handleId
end
end
self.teamHandleIdList=newList
end



function UIXianJieMainWin:onTanChaBtn(page)
page=page or 1


local sceneType=xianjieModel:getScenceType()
if xianjienSceneType:isMoJie(sceneType)then
xianjieController:openWin('UIMoJieExplorationWin',{page=1})
return
end

xianjieController:openWin('UIXianJieExplorationWin',{page=1})
end


function UIXianJieMainWin:onXianbangBtn()
local win=UIManager:findActiveWindow('UIXianJieExplorationWin')
if not win then
xianjieController:openWin('UIXianJieExplorationWin',{page=5})
end
end


function UIXianJieMainWin:registerChatMainHandle()
if not self.isMainHandle then
self.isMainHandle=true
chatControl.registerMainHandler(MAIN_HOLD_TYPE.eMain,self.handler)
end
end

function UIXianJieMainWin:unregisterChatMainHandle()
if self.isMainHandle then
self.isMainHandle=false
chatControl.unregisterMainHandler(MAIN_HOLD_TYPE.eMain,self.handler)
end
end

function UIXianJieMainWin:onFinishChatCreatAction(assetName,guid,luaid,isInit)
if not isInit then
self:setContentBottom(true)
self.chatCreater:callChildFunc(luaid,'playAni')
end
end

function UIXianJieMainWin:freshChatReddot()
local channels={CHAT_CHANNNEL.eWorld,CHAT_CHANNNEL.eXianmeng,CHAT_CHANNNEL.eKuafu,CHAT_CHANNNEL.ePrivate}
local num=0
for _,channelId in ipairs(channels)do
if chatControl.hasNewMesgByChannel(channelId)then
num=num+chatControl.getNewestMesgNumByChannel(channelId)
end
end
local reddot=num>0
self.chatReddot:setActive(reddot)
if num>99 then
num='99+'
elseif num<=0 then
num=''
end
self.numText:setText(num)
end


function UIXianJieMainWin:onRecvMessage()
self:freshChatReddot()
end

function UIXianJieMainWin:onReadNewestMesg(channel,actorid)
self:freshChatReddot()
end


function UIXianJieMainWin:setContentBottom(ani)
local height=self.winlua:GetChildSizeDeltaY(self.chatContent:getID())
self.winlua:SetStopChildScrollRect(self.chatScrollView:getID())
self.winlua:SetChildDOAnchorPosY(self.chatContent:getID(),0,ani and 0.2 or 0)
end



function UIXianJieMainWin:creatGroupBtns()
local index=self.BottomList:getID()
local configs=mainConfig.getBottomGroupConfig()
local indexArray={}
local parentIndexArray={}
local keys={}
local cfgs={}
local idx=0
for i,v in ipairs(configs)do
idx=idx+1
indexArray[idx]=v.UIPrefabIndex
parentIndexArray[idx]=idx-1
keys[idx]=v.key
cfgs[#cfgs+1]=v
end
local len=#cfgs
for i=1,#self.iconRoots do
local flag=i<=len
self.iconRoots[i]:setActive(flag)
end

local temp={}
for i=1,len do
local cfg2=cfgs[i]
temp[cfg2.key]=true
end
if self.iconLuaObjectLookup and next(self.iconLuaObjectLookup)then
for k,luaObjet in pairs(self.iconLuaObjectLookup)do
if not temp[k]then
if luaObjet and luaObjet.release then
luaObjet:release()
end
self.iconLuaObjectLookup[k]=nil
end
end
end

self.winlua:SetCreatChildClonePrefabEx(index,indexArray,parentIndexArray,keys)
for i=1,len do
local config=cfgs[i]
local buildType=config.buildType
local key=config.key
local iconType=config.iconType

local lookup=self.iconLuaObjectLookup
local luaObjet=lookup[key]
local widget=self.winlua:GetChildCloneWidget(index,i-1)
if luaObjet==nil then
mainBtnConfig.PreloadCtor(config)
local ctor=config.ctor
luaObjet=ctor(widget,i,config)
lookup[key]=luaObjet
luaObjet:onLoaded()
else
luaObjet:init(widget,i,config)
end
local isinit=self.loadIcons[key]==nil
self.loadIcons[key]=true
luaObjet:onShow(isinit)
local comName=FMT.fmt('{0}.xianjieClick',keys[i])
luaObjet:setNewBieComponentId(1,comName)
luaObjet:setChildWeakGuideComponentId(1,comName)
end
self.winlua:StartChildClonePrefabTween(index,0,DG.Tweening.Ease.InOutBack)
end


function UIXianJieMainWin:onButtonBack()

local btnList={
MAIN_BTNS_TYPE.eSubMoJie,
MAIN_BTNS_TYPE.eSubWorld,
MAIN_BTNS_TYPE.eSubXianJie,
MAIN_BTNS_TYPE.eSubXianYu,
MAIN_BTNS_TYPE.eSubZM,
}

local posVector2=self.ButtonBack:getChildScreenPointToLocalPointRectangle(-1)
local pos={posVector2.x-70,posVector2.y+115}

UIManager:showWindow("UIMainSubEnterPanelWin",{btnList=btnList,pos=pos,posType=2})
end

function UIXianJieMainWin:refreshButtonBack()
local checkMoJie=xianjieModel:checkCurrentMoJieEnterTime()
self.ButtonBack1:setActive(not checkMoJie)
self.ButtonBack2:setActive(checkMoJie)
end

function UIXianJieMainWin:onIconRefresh(openIconTypes)
local iconGroupType=MAIN_ICON_GROUP_TYPE.eBottom
local iconTypes=mainConfig.getGroupIconTypeList(iconGroupType)
local flag=table.containsTableValue(iconTypes,openIconTypes)
if flag then
self:creatGroupBtns()
end
end

function UIXianJieMainWin:releaseAllButton()
for _,luaObjet in pairs(self.iconLuaObjectLookup)do
if luaObjet and luaObjet.release then
luaObjet:release()
end
end
self.iconLuaObjectLookup={}
end




function UIXianJieMainWin:initMoneyBar()





for i,v in ipairs(self.moneyBars)do
local wb=v:getChildWidgetBase()
local mType=_Moneys[i]
if mType then
local icon=moneyModel.getIconNameEx(mType)
wb:SetChildIcon(0,icon,false)
if mType~=eMoneyType.mtLingPai then
wb:SetChildButtonClickWithID(2,self.onClickMoney,i)
else
wb:SetChildButtonClickWithID(2,self.onClickMoney2,i)
end
else
v:setActive(false)
end
end
end

function UIXianJieMainWin.onUpdateMoney(moneyType,lastVal,val)
if _this==nil or not _this.isVisible then return end
for i,v in ipairs(_this.moneyBars)do
if moneyType==_Moneys[i]then
local wb=v:getChildWidgetBase()
local desc=moneyModel.getMoneyDesc1(moneyType)
wb:SetChildText(1,desc)
break
end
end

if shouhundingModel:isDataType(moneyType)then
_this:refreshTanChaReddot()
end
end

function UIXianJieMainWin.onInitMoney()
if _this==nil or not _this.isVisible then return end
for i,v in ipairs(_this.moneyBars)do
if _Moneys[i]then
local wb=v:getChildWidgetBase()
local desc=moneyModel.getMoneyDesc1(_Moneys[i])
wb:SetChildText(1,desc)
end
end

_this:refreshTanChaReddot()
end

function UIXianJieMainWin.onClickMoney(index)
if _this==nil or not _this.isVisible then return end
_this:clickMoney(index)
end

function UIXianJieMainWin.onClickMoney2(index)
if _this==nil or not _this.isVisible then return end
moneySystem:showBuyTips(_Moneys[index])
end

function UIXianJieMainWin:onMoneyBars_1()
self:clickMoney(1)
end

function UIXianJieMainWin:onMoneyBars_2()
self:clickMoney(2)
end

function UIXianJieMainWin:onMoneyBars_3()


self:clickMoney(3)
end

function UIXianJieMainWin:onMoneyBars_4()
self:clickMoney(4)
end

function UIXianJieMainWin:clickMoney(idx)
local moneyType=_Moneys[idx]
if moneyType==eMoneyType.mtXianYu then
UIFullRechargeController:showRechargeWindow()
else
gainControl:showGainWin(moneyType)
end
end

function UIXianJieMainWin:refreshMoney3TipsPanel(show)
_showMoneyTips3=show
self.Money3TipsPanel:setActive(show)
self:stopMoney3Tick()
if show then
self:startMoney3Tick()
end
end

function UIXianJieMainWin:startMoney3Tick()
self:updateMoney3Tick()
if not self.money3Tick then
self.money3Tick=self:setTimer(1,0,function()
self:updateMoney3Tick()
end)
end
end

function UIXianJieMainWin:updateMoney3Tick()
local moneytype=_Moneys[3]
local check,buidId=moneyAutoIncreaseModel:checkBuilding(moneytype)
local moneyname=moneyModel.getMoneyName(moneytype)
if check then
if moneyAutoIncreaseModel:isNotMax(moneytype)then
local least=moneyAutoIncreaseModel:getLeastTime(moneytype)
least=math.max(least,0)
local autoCfg=cfgHelper.get2(cfg_moneyconfig_get,moneytype,'autoincr')
self.Money3TipsTx:setText(FMT.fmt("将在<color=#29ad0f>{0}</color>后恢复{1}{2}",timeHelper.format_time_stamp(least,true),autoCfg[2],moneyname))
else
self.Money3TipsTx:setText(FMT.fmt("{0}已达上限",moneyname))
end
else
local bdCfg=cfgHelper.get1(cfg_monijybuildconfig_get,buidId)
self.Money3TipsTx:setText(FMT.fmt("尚未建造{0}无法恢复{1}",bdCfg.name,moneyname))
end
end

function UIXianJieMainWin:stopMoney3Tick()
if self.money3Tick then
self:stopTimerByID(self.money3Tick)
self.money3Tick=nil
end
end

function UIXianJieMainWin:touchOverUI_Money3(over)
if not over then

end
end



function UIXianJieMainWin:onFilterHUD2Btn()
self.filterHUD2Flag=not self.filterHUD2Flag
local icon=self.filterHUD2Flag and'button_sjbiaoshi_2'or'button_sjbiaoshi_1'
self.filterHUD2Btn:setCSImageSprite(globalABLookup.zzshicons,icon)
if self.filterHUD2Flag then
self:showWindow('UIXianJie_filteHUD2Win')
else
self:closeWindow('UIXianJie_filteHUD2Win')
end
end

function UIXianJieMainWin:closeFilterHUD2Win()
if self.filterHUD2Flag then
self:onFilterHUD2Btn()
end
end

function UIXianJieMainWin:closeFilterHUD2Win2()
self.filterHUD2Flag=nil
end


function UIXianJieMainWin:openMiniMap()
if not xianjieController:check2DMapModel()then
UIManager:showWindow('UIXianJie_mapWin',{})
end
end


function UIXianJieMainWin:refreshJiJieBtn()

local isCanJiJie=xianjieModel:checkCanJiJie()and(not xianjieController:checkInMoGongZhengDuo())
self.jiJieBtn:setActive(isCanJiJie)

if isCanJiJie then

local jiJieCount=xianjieModel:getJiJieDirtyDataAllNum()
local isShowJiJieNum=jiJieCount>0
self.jijieNumObj:setActive(isShowJiJieNum)
if isShowJiJieNum then
self.jijieNumTxt:setText(jiJieCount)
end
end
end

function UIXianJieMainWin:refreshBuffBtn()

local hasBuff=xianjieModel:isCanShowBuffList()
self.buffBtn:setActive(hasBuff)
end

function UIXianJieMainWin:refreshTanChaBtn()
local sceneidx=xianjieModel:getSceneIndex()
if XingYuController.checkFirstReddot()then
self.tanChaBtnreddotEx:setActive(true)
self.tanChaReddot:setActive(false)
if sceneidx then
if xianjienSceneIndexType:isMoJie(sceneidx)then
self.tanChaBtnreddotEx:setActive(false)
end
end
return
end
self.tanChaBtnreddotEx:setActive(false)
local reddot=xianjieModel:getAllForceReddot()or taskModel:explorTaskAllreddot()
if sceneidx then
if xianjienSceneIndexType:isMoJie(sceneidx)then
reddot=false
end
else
reddot=false
end
self.tanChaReddot:setActive(reddot)
end






function UIXianJieMainWin:refreshTanChaReddot()
local reddot=xianjieModel:getAllForceReddot()or taskModel:explorTaskAllreddot()
local sceneidx=xianjieModel:getSceneIndex()
if sceneidx then
if xianjienSceneIndexType:isMoJie(sceneidx)then
reddot=false
end
else
reddot=false
end
self.tanChaReddot:setActive(reddot)
end

function UIXianJieMainWin:refreshXianbangBtn()
local sceneidx=xianjieModel:getSceneIndex()
if xianjienSceneIndexType:isMoJie(sceneidx)or xianjienSceneIndexType:isMoGongZhengDuo(sceneidx)then
_this.xianbangBtn:setActive(false)
else
local num=xianjiexianbangModel:getHaveTaskNum()
_this.xianbangBtn:setActive(num>0)
_this.xbnum:setText(num)
end
end


local _checkTableListSame=function(ta,tb)
if ta==nil or next(ta)==nil then return false end
if tb==nil or next(tb)==nil then return false end

if#ta~=#tb then return false end

for index,ainfo in ipairs(ta)do
local binfo=tb[index]
if binfo==nil then
return false
end
if ainfo[1]~=binfo[1]or ainfo[2]~=binfo[2]then
return false
end
end

return true
end
function UIXianJieMainWin:refreshSeasonEnter()
local isShow=not xianjieController:checkInMoGongZhengDuo()
self.seasonRoot:setActive(isShow)
if not isShow then return end

local seasonList=seasonModel:getSeasonEnterList()or defaultT
local isShowSeasonRoot=next(seasonList)~=nil
self.seasonRoot:setActive(isShowSeasonRoot)
if not isShowSeasonRoot then
self:clearSeasonEnterItem()
self.seasonList=defaultT
self.seasonRoot:recycleAll()
return
end

self.seasonList=self.seasonList or defaultT
local isDiff=not _checkTableListSame(self.seasonList,seasonList)

if isDiff then
self.seasonRoot:recycleAll()

self.seasonEnterLuaIdList={}

local parentIdx=self.seasonRoot:getID()

for index,seasonInfo in ipairs(seasonList)do
local prefabType=seasonInfo[1]
local seasonType=seasonInfo[2]
local enterPrefabName
if prefabType==1 then
enterPrefabName=seasonModel:getHandleConfig(seasonType,'enterPrefabName')
elseif prefabType==2 then
enterPrefabName=cfgHelper.get2(cfg_devildomseasonconfig_get,seasonType,'preEnterPrefabName')
end
local enterItemName=enterPrefabName[2]
local args={seasonType=seasonType}
local luaid=self.seasonRoot:createObject(enterItemName,parentIdx,index,args)
self.seasonEnterLuaIdList[seasonType]=luaid
end
else
self:refreshSeasonAllEnterItem()
end

self.seasonList=seasonList
end


function UIXianJieMainWin:refreshSeasonAllEnterItem()
if self.seasonEnterLuaIdList==nil then return end
for seasonType,luaid in pairs(self.seasonEnterLuaIdList)do
local luaObject=self.seasonRoot:getLuaObject(luaid)
if luaObject then
local args={seasonType=seasonType}
luaObject:onShow(args)
end
end
end

function UIXianJieMainWin:hideSeasonAllEnterItem()
if self.seasonEnterLuaIdList==nil then return end
for seasonType,luaid in pairs(self.seasonEnterLuaIdList)do
local luaObject=self.seasonRoot:getLuaObject(luaid)
if luaObject then
local args={seasonType=seasonType}
luaObject:onHide(args)
end
end
end

function UIXianJieMainWin:refreshSeasonEnterItem(seasonId)
local luaid=self.seasonEnterLuaIdList and self.seasonEnterLuaIdList[seasonId]
if luaid then
local luaObject=self.seasonRoot:getLuaObject(luaid)
if luaObject then
local args={seasonType=seasonId}
luaObject:onShow(args)
end
end
end

function UIXianJieMainWin:callSeasonEnterFunc(seasonId,funcName)
local luaid=self.seasonEnterLuaIdList and self.seasonEnterLuaIdList[seasonId]
if luaid then
local luaObject=self.seasonRoot:getLuaObject(luaid)
if luaObject and luaObject[funcName]~=nil then
luaObject[funcName](luaObject)
end
end
end

function UIXianJieMainWin:clearSeasonEnterItem()
if self.seasonEnterLuaIdList==nil then return end
if next(self.seasonEnterLuaIdList)==nil then return end
self.seasonRoot:recycleAll()
self.seasonEnterLuaIdList=nil
end

function UIXianJieMainWin.onSeasonChange()
if _this==nil or not _this.isVisible then return end
_this:refreshSeasonEnter()


if _this.isShowLeftMenu then
_this:refreshLeftMenuPanel()
else
_this:refreshTeamPanel()
end

_this:refreshJiJieBtn()

_this:refreshMoZongBtn()
end

function UIXianJieMainWin.onSeasonEnterConditionChange()
if _this==nil or not _this.isVisible then return end
_this:refreshSeasonEnter()
end

function UIXianJieMainWin.onSeasonStageChange(season_id,chapter_idx)
if _this==nil or not _this.isVisible then return end
_this:refreshSeasonEnter()

local stage=seasonModel:getStage(season_id,chapter_idx)
if stage and stage.type==seasonStageType.eTZMJ then
_this:refreshLeftMenuExPanel()
end
if _this.isShowLeftMenu then
local stage=seasonModel:getStage(season_id,chapter_idx)
if stage and stage.type==seasonStageType.eMJHD then
_this:refreshLeftMenuPanel()
end
end
_this:refreshMoZongBtn()
end

function UIXianJieMainWin.onSeasonStageDataChange(season_id,chapter_idx)
if _this==nil or not _this.isVisible then return end

_this:refreshSeasonEnter()

if season_id==0 then
if _this.isShowLeftMenu then
_this:refreshLeftMenuPanel()
else
_this:refreshTeamPanel()
end

_this:refreshJiJieBtn()
end
_this:refreshMoZongBtn()
end



function UIXianJieMainWin:freshSimpleBtn()
local isConcise=xianjieMainWinSimpleModeConfig:getRecordState()
self.btnChange["concise"]:setActive(isConcise)
self.btnChange["normal"]:setActive(not isConcise)
end


function UIXianJieMainWin:onBtnChange_concise()
self:changeSimpleBtn(false)
end


function UIXianJieMainWin:onBtnChange_normal()
self:changeSimpleBtn(true)
end

function UIXianJieMainWin:changeSimpleBtn(flag)

xianjieMainWinSimpleModeConfig:changeSceneRecordState()

self:freshSimpleBtn()

notifySystem:postNotify(notifyConfig.onXianJieMainWinSimpleStateChange)
end

function UIXianJieMainWin.onXianJieMainWinSimpleStateChange()
_this:refreshAllPartSimpleState()
end

local _nomalNodeSimpleModeList={
"listLayout",
"leftFuncBtnLayout",
"leftSpTipsLayout",
"chatRoot",
"rightBtnLayout",
}

function UIXianJieMainWin:refreshAllPartSimpleState()


for index,nodeName in ipairs(_nomalNodeSimpleModeList)do
local uiObj=_this[nodeName]
if uiObj~=nil then
local simpleKey=string.format("UIXianJieMainWin.%s",nodeName)
local simpleState
simpleState=xianjieMainWinSimpleModeConfig:getRecordState(simpleKey)
uiObj:setActive(not simpleState)
else



end
end



self:refreshLeftMenuExPanel()

end

function UIXianJieMainWin:refreshMenuGroupExSimpleState()
UIXianJieMainWin:callExtraFunc('onXianJieMainWinSimpleStateChange')
end



function UIXianJieMainWin:checkExtraWindow()

local isOpenAct=xianJieArenaActModel:checkIsXJArenaActDoing()
local isOpen=xianJieArenaActModel:checkIsXJArenaActCanOpen()

local nowSceneIdx=xianjieModel:getSceneIndex()
local isInMoJie=nowSceneIdx and xianjienSceneIndexType:isMoJie(nowSceneIdx)or false

local win=UIManager:findActiveWindow("UIXianJieExtra_LTYWWin")
if isOpenAct and isOpen and not isInMoJie then
if xianjieController:chcekIsInStoryMode()then

return
end

if win and win.isVisible then
win:refresh()
else
self:showWindow("UIXianJieExtra_LTYWWin")
end
else
if win then
win:closeSelf()
end
end
end




function UIXianJieMainWin:checkActMode(isInit)





self:refreshArenaBtnPanel()
self:delayDo(1,function()

return self:checkActAutoOpenWin()
end)
end

function UIXianJieMainWin:checkActAutoOpenWin()
if xianjieController:isShowSideWin()then

return
end

local isOpenAct=xianJieArenaActModel:checkIsXJArenaActDoing()
local isOpen=xianJieArenaActModel:checkIsXJArenaActCanOpen()
if isOpen and not isOpenAct then

local nowSceneIdx=xianjieModel:getSceneIndex()
local isInMoJie=nowSceneIdx and xianjienSceneIndexType:isMoJie(nowSceneIdx)or false
if isInMoJie then

return
end


local isInSettlement,delaySettleTime=xianJieArenaActController:checkActIsInSettlement()
if isInSettlement then

return
end

local winShowFlag=xianJieArenaActModel:getArenaRewardWinShowFlag()
local hasOccupy=xianJieArenaActModel:checkArenaHasOccupy()
if winShowFlag==0 and hasOccupy then

local page=4

msgWinControl:addMsgWin(msgWinType.eLTYWRankBg,{page=page,extraArgs={isAutoOpen=true}})
end
end
end

function UIXianJieMainWin:setLeftMenuPanel(isShow)
if not self.isShowLeftMenu then
self.isShowLeftMenu=false
end

if self.isShowLeftMenu==isShow then
return
end
self.isShowLeftMenu=isShow
self.menuGroup:setActive(isShow)
self.listBg:setActive(isShow)

if isShow then
return self:refreshLeftMenuPanel()
else

self.xjPanel:setActive(true)
self.zdPanel:setActive(false)
self.selectMenuPageIndex=nil
end
end

function UIXianJieMainWin:refreshLeftMenuPanel(isInit)
if not self.selectMenuPageIndex then
self.selectMenuPageIndex=1
end


local grids=self.menuGroup:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local widget=grids[i-1]
local isSelect=self.selectMenuPageIndex==i
widget:SetChildActive(0,not isSelect)
widget:SetChildActive(1,isSelect)

widget:SetChildButtonClick(2,function()
if not _this then return end
return self:selectMenuPage(i)
end,true)
end

self.zdPanel:setActive(self.selectMenuPageIndex==1)
self.xjPanel:setActive(self.selectMenuPageIndex==2)
if self.selectMenuPageIndex==1 then
self:getTeamHandleIdList(isInit)
self:refreshZhengDuoPanel(isInit)
elseif self.selectMenuPageIndex==2 then
self:refreshTeamPanel(isInit)
end
end

function UIXianJieMainWin:refreshLeftMenuPanel_update()
self.zdPanel:setActive(self.selectMenuPageIndex==1)
self.xjPanel:setActive(self.selectMenuPageIndex==2)
if self.selectMenuPageIndex==1 then
self:refreshZhengDuoPanel_update()
elseif self.selectMenuPageIndex==2 then
self:refreshTeamPanel_update()
end
end

function UIXianJieMainWin:selectMenuPage(index)
if self.selectMenuPageIndex==index then
return
end

self.selectMenuPageIndex=index
return self:refreshLeftMenuPanel()
end

function UIXianJieMainWin:refreshZhengDuoPanel(isInit)
if isInit then
xianjieController:reqMassTeamList()
end
self:clearStateTimer()

local teamsList=self:getXMArenaTeamList()
local count=#teamsList
self.zdTeamScrollView:setChildScrollViewCreateGrids(count,1)
local grids=self.zdTeamScrollView:getChildScrollViewItemWidgets()
local nowTime=timeHelper.getServerShortTime()
for i=1,grids.Count do
local widget=grids[i-1]
local data=teamsList[i]
if data then
local arenaId=mathHelper.int64_to_number(data.guid)
local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,arenaId)

local arenaNameStr=cfg and cfg.name or"未知擂台"
widget:SetChildText(_zdItemCmpIndex.targetText,FMT.fmt("目标：{0}",arenaNameStr))


local actorId=data.actorid
local zmData=xianjieModel:getZongMenData(actorId)
local nameStr="未知祖师"
if zmData then
nameStr=zmData.actorname
end
widget:SetChildText(_zdItemCmpIndex.initiatorText,FMT.fmt("队长：{0}",nameStr))


local chuZhenTime=data.sec or 0
local marchGuid=data.marchguid
local stateStr=''
local timeStr=""
if chuZhenTime==0 then
stateStr="出击中"
if marchGuid and marchGuid~=0 then
local marchData=xianjieModel:getMarchTeamData(marchGuid)
if marchData then
local teamHandle=marchData:getTeamHandle()
local state,timeData,lerp=teamHandle:getTeamState()
if lerp and lerp>0 then
local lerpTime=math.ceil(lerp)
stateStr="出击中："
if state==xjMarchTeamStateType.eBattle then
stateStr="战斗中："
local isSelfXianYu=false
local arenaData=xianJieArenaActModel:getArenaBuildData(arenaId)or{}
if arenaData then
local occupyServerId=arenaData.occupyServerId
local occupySceneIdx=arenaData.sceneidx
local hasOccupy=occupySceneIdx and occupySceneIdx~=0 or nil
if hasOccupy then
local cross_sid=loginModel:getCrossServerId()
isSelfXianYu=occupyServerId==cross_sid
end
end
if isSelfXianYu then
stateStr="进驻中："
end
end
timeStr=timeHelper.format_time_stamp(lerpTime)
end
end
end
elseif nowTime>=chuZhenTime then
stateStr="准备出击"
else
stateStr="集结中："
timeStr=timeHelper.format_time_stamp(chuZhenTime-nowTime)
end
widget:SetChildText(_zdItemCmpIndex.stateText,FMT.fmt("{0}{1}",stateStr,timeStr))

local teamSceneIdx=data.sceneidx

widget:SetChildButtonClick(_zdItemCmpIndex.bg,function()
if not _this then return end
return self:onClickZdItem(actorId,data.massguid,marchGuid,teamSceneIdx)
end,true)
end
end
self.noTeamTips:setActive(count<=0)
if count>0 then
self:setStateTimer()
end
end

function UIXianJieMainWin:refreshZhengDuoPanel_update()
local teamsList=self:getXMArenaTeamList()
local grids=self.zdTeamScrollView:getChildScrollViewItemWidgets()
local nowTime=timeHelper.getServerShortTime()
for i=1,grids.Count do
local widget=grids[i-1]
local data=teamsList[i]
if data then

local chuZhenTime=data.sec or 0
local arenaId=mathHelper.int64_to_number(data.guid)
local stateStr=''
local timeStr=""
if chuZhenTime==0 then
stateStr="出击中"
local marchGuid=data.marchguid
if marchGuid and marchGuid~=0 then
local marchData=xianjieModel:getMarchTeamData(marchGuid)
if marchData then
local teamHandle=marchData:getTeamHandle()
local state,timeData,lerp=teamHandle:getTeamState()
if lerp and lerp>0 then
local lerpTime=math.ceil(lerp)
stateStr="出击中："
if state==xjMarchTeamStateType.eBattle then
stateStr="战斗中："
local isSelfXianYu=false
local arenaData=xianJieArenaActModel:getArenaBuildData(arenaId)or{}
if arenaData then
local occupyServerId=arenaData.occupyServerId
local occupySceneIdx=arenaData.sceneidx
local hasOccupy=occupySceneIdx and occupySceneIdx~=0 or nil
if hasOccupy then
local cross_sid=loginModel:getCrossServerId()
isSelfXianYu=occupyServerId==cross_sid
end
end
if isSelfXianYu then
stateStr="进驻中："
end
end
timeStr=timeHelper.format_time_stamp(lerpTime)
end
end
end
elseif nowTime>=chuZhenTime then
stateStr="准备出击"
else
stateStr="集结中："
timeStr=timeHelper.format_time_stamp3(chuZhenTime-nowTime)
end
widget:SetChildText(_zdItemCmpIndex.stateText,FMT.fmt("{0}{1}",stateStr,timeStr))
end
end
end

function UIXianJieMainWin:getXMArenaTeamList()
if self.xmArenaTeamList then
return self.xmArenaTeamList
end

self.xmArenaTeamList=xianJieArenaActModel:getSelfXMArenaJiJieDataList()
return self.xmArenaTeamList
end

function UIXianJieMainWin:onClickZdItem(actorId,guid,marchGuid,sceneidx)
local openFunc=function()
if not _this then return end
return _this:showWindow("UIXianJie_JiJie_msgWin",{actorId=actorId,guid=guid,sceneidx=sceneidx})
end

local teamHandle
if marchGuid and marchGuid~=0 then
local marchData=xianjieModel:getMarchTeamData(marchGuid)
if marchData then
teamHandle=marchData:getTeamHandle()
end
else
local teamData=xianjieModel:getSelfJiJieTeamData(guid)
if teamData then
local teamHandleId=teamData.teamHandleId
teamHandle=xianjieController:getXJTeamHandle(teamHandleId)
end
end

local sceneidx,gridX,gridZ
if teamHandle then

local clickEntKey=teamHandle:getTeamEnityKey()
xianjieModel:enterSceneState_clickTeam_before(clickEntKey,openFunc)
if not clickEntKey then

sceneidx,gridX,gridZ=teamHandle:getTargetPos()
end
end

if sceneidx then
xianjieController:jumpGrid(sceneidx,gridX,gridZ,openFunc,true)
else

return openFunc()
end
end

function UIXianJieMainWin:onMassDetailDataChangeRecv(actorId,guid,flag)

self:refreshJiJieBtn()

if self.isShowLeftMenu or(self.mainExPanelCfg and self.mainExPanelCfg.checkTaskShow(self))then

xianjieController:reqMassTeamList(guid)
end
end

function UIXianJieMainWin:onMassTeamListInitRecv()

self:refreshJiJieBtn()

self.xmArenaTeamList=nil
if self.isShowLeftMenu and self.selectMenuPageIndex==1 then
self:refreshLeftMenuPanel()
end
end

function UIXianJieMainWin:refreshArenaBtnPanel()
local isOpenedAct=xianJieArenaActModel:checkIsXJArenaActOpened()
local isOpen=xianJieArenaActModel:checkIsXJArenaActCanOpen()

local nowSceneIdx=xianjieModel:getSceneIndex()
local isInMoJie=nowSceneIdx and xianjienSceneIndexType:isMoJie(nowSceneIdx)or false
self.arenaBtnPanel:setActive(isOpenedAct and isOpen and not isInMoJie)
end

function UIXianJieMainWin:onArenaRankBtn()
local page=1

msgWinControl:addMsgWin(msgWinType.eLTYWRankBg,{page=page,isHideSettlement=true})
end

function UIXianJieMainWin:onArenaZhanLingBtn()

end


local _simpleKey_menuGroupEx="UIXianJieMainWin.menuGroupEx"
function UIXianJieMainWin:refreshLeftMenuExPanel()
local hasView=false
local mainCfg=nil
local mainType=nil
for k,v in pairs(XianJieLeftMenu.getXianJieAllConfig())do
if v.check()then
mainCfg=v
mainType=k
hasView=true
end
if hasView then
break
end
end
local lastCfg=self.mainExPanelCfg
self.mainExPanelCfg=mainCfg
self:recycleLeftMemu()
local hideSkin=false
if mainCfg and mainCfg.hideMenuSkin then
if mainCfg:hideMenuSkin()then
hideSkin=true
self.isHideSkin=true
end
end

self.menuGroupEx:setActive(hasView and not hideSkin)
if lastCfg and lastCfg.close then
lastCfg.close(self)
end
if hasView then
if not hideSkin and mainCfg.menuSkin then
self.lmComponent=self.menuGroupEx:createObject(mainCfg.menuSkin,self.menuGroupEx:getID(),0,{parent=self})
end
if mainCfg.open then
mainCfg.open(self)
end
if hideSkin then
self.xjPanel:setActive(true)
end
else
self.xjPanel:setActive(true)
end
self:refreshTeamPanel()
end

function UIXianJieMainWin:recycleLeftMemu()
if self.lmComponent then
self.menuGroupEx:recycleItemById(self.lmComponent)
self.lmComponent=nil
end
end

function UIXianJieMainWin:callExtraFunc(func_name,...)
if self.lmComponent then
return self.menuGroupEx:callChildFunc(self.lmComponent,func_name,...)
end
end



function UIXianJieMainWin:refreshFeedBookBtn()
local sceneIdx=xianjieModel:getSceneIndex()or-1
local systemIndexType=UISettingModel:getSystemIndexType()
local type
if sceneIdx==xianjienSceneIndexType.eXianJie then
type=systemIndexType.XianJie
elseif xianjienSceneIndexType:isXianYu(sceneIdx)then
type=systemIndexType.XianYu
end

local checkReddot
local checkBtn=false
if type~=nil then
checkBtn=UISettingModel:checkIsOpenTest(type)

if not checkBtn then
UIManager:invokeUIMethod("UITestTagBtnWin",'closeWin')
else
checkReddot=UISettingModel:checkTestTagReddot(type)
self.winlua:SetChildActive(self.feedBookReddot:getID(),checkReddot)
end
end

self.winlua:SetChildActive(self.feedBookBtn:getID(),checkBtn)
end

function UIXianJieMainWin:onFeedBookBtn()
local sceneIdx=xianjieModel:getSceneIndex()or-1
local systemIndexType=UISettingModel:getSystemIndexType()
local type
if sceneIdx==xianjienSceneIndexType.eXianJie then
type=systemIndexType.XianJie
elseif xianjienSceneIndexType:isXianYu(sceneIdx)then
type=systemIndexType.XianYu
end
UIManager:showWindow("UITestTagBtnWin",{systemId=type,})
end

function UIXianJieMainWin:refreshTestWin()
self:refreshFeedBookBtn()
end




function UIXianJieMainWin:test_openSpeedUpWin()
self:showWindow("UIXianJie_speedUpWin")
end


function UIXianJieMainWin:getPositionByKey(key)
local btnGroupType=mainConfig.getIconGroupType(key)
if btnGroupType then
local index=self:getGroupBtnNodeID(btnGroupType)
return self.winlua:GetChildClonePositionByKey(index,key)
end
end

function UIXianJieMainWin:getGroupBtnNodeID(btnGroupType)
return self.groupBtnNodeID[btnGroupType]()
end

function UIXianJieMainWin:getWidgetByKey(key)
local btnGroupType=mainConfig.getIconGroupType(key)
if btnGroupType then
local index=self:getGroupBtnNodeID(btnGroupType)
return self.winlua:GetChildCloneWidgetByKey(index,key)
end
end

function UIXianJieMainWin:getLuaObjectByKey(key)
for _,lookup in pairs(self.iconLuaObjectLookup)do
if lookup[key]then
return lookup[key]
end
end

return nil
end

function UIXianJieMainWin:doFadeNomal(key)
local luaObjet=self:getLuaObjectByKey(key)
if luaObjet then
luaObjet:setChildCanvasGroupAlpha(-1,1)
end
end

function UIXianJieMainWin:hideChatRoot(hide)
if _this==nil or not _this.isVisible then return end
local showHignLOD=xianjieController.curlodLevel>=highLODModel
local alpha=(not hide and not showHignLOD)and 1 or 0
local raycast=not hide and not showHignLOD
_this.winlua:SetChildCanvasGroupAlpha(_this.chatRoot:getID(),alpha)
_this.winlua:SetChildCanvasGroupRaycast(_this.chatRoot:getID(),raycast)
end

function UIXianJieMainWin:refreshShouMoAuto()
local check=false
local zmData=xianjieModel:getMyZongMenData()
if zmData~=nil and not zmData:checkInCurScene()then
check=true
end
if xianjieModel:GetAutoStage()and not check then
self.shoumomodel:setActive(true)
self.shoumomodel:setChildUIModelShowTarget(5756,1,{},eAnimationID.stand,false,false,0)
else
self.shoumomodel:setActive(false)
end


end

function UIXianJieMainWin:onShoumoautoclose()
xianjieModel:SetAutoStage(false)
UIManager.info("自动狩猎已停止")
end

function UIXianJieMainWin:onShoumoAuto()
local arg=xianjieModel:GetrecordlastSelectType()
UIManager:showWindow('UIXianJie_ShouMoList',arg)
end

function UIXianJieMainWin:initRedPacket()
local subList=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eCaiShenJiaDao)
local list={}
for index,info in ipairs(subList)do

table.insert(list,info)

end
if#list>1 then
table.sort(list,function(a,b)
return a.start_time<b.start_time
end)
end
self.redpacketInfo_CSJD=list[1]

local sub_actList_xmhb=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eXianMengHongBao)
if#sub_actList_xmhb>0 then
self.redpacketInfo_XMHB=sub_actList_xmhb[1]
end
end

function UIXianJieMainWin:refreshRedPacket()
if self.redpacketInfo_CSJD or self.redpacketInfo_XMHB then
local count=0
if self.redpacketInfo_CSJD then
local count_csjd=self.redpacketInfo_CSJD:countGuildDataStatus(eCSJDRedPacketStatus.eNormal)
count=count+count_csjd
end
if self.redpacketInfo_XMHB then
local count_xmhb=self.redpacketInfo_XMHB:getGuildDataCanGetRedPacketCount()
count=count+count_xmhb
end

self.chatRedPacket:setActive(count>0)
else
self.chatRedPacket:setActive(false)
end
end

function UIXianJieMainWin.onSubActivityStateChange(actId,subType,subId,state)
if _this==nil or not _this.isVisible then return end
if subType==SUB_ACTIVITY_TYPE.eCaiShenJiaDao then
_this:initRedPacket()
_this:refreshRedPacket()
end
end

function UIXianJieMainWin.onSubActivityOpen(actId,subType,subId,flag)
if _this==nil or not _this.isVisible then return end
if subType==SUB_ACTIVITY_TYPE.eCaiShenJiaDao then
_this:initRedPacket()
_this:refreshRedPacket()
end
end

function UIXianJieMainWin.onCSJDGuildDataChange(actId,subType,subId,guid,reSort)
if _this==nil or not _this.isVisible then return end
if reSort then
_this:refreshRedPacket()
end
end

function UIXianJieMainWin.onXMHBGuildDataChange(actId,subType,subId,guid,reSort)
if _this==nil or not _this.isVisible then return end
if reSort then
_this:refreshRedPacket()
end
end


function UIXianJieMainWin:refreshMjRank()
local isMJtime=xianjieController:CheckMoJieSaiJieActityeTime()
local sceneidx=xianjieModel:getSceneIndex()
local ismojie=xianjienSceneIndexType:isMoJie(sceneidx)
if isMJtime and ismojie then
self.mjRankBtn:setActive(true)
self:refreshMojieRank()
else
self.mjRankBtn:setActive(false)
end
end
function UIXianJieMainWin:onMjRankBtn()
local showlist=xianjieController:GetShowRank()
if#showlist>1 then
UIManager:showWindow("UIMoJieRankSelectWin")
else
xianjieController:OpenMoJieRankWin(2,1)
end

end

function UIXianJieMainWin:refreshMjShop()
local isMJtime=xianjieController:CheckMoJieSaiJieActityeTime()
local sceneidx=xianjieModel:getSceneIndex()
local ismojie=xianjienSceneIndexType:isMoJie(sceneidx)
if isMJtime and ismojie then
self.mjShopBtn:setActive(true)
local guid=UITYTongXingZhengModel:getGuidBySysID(txzType.sys,SYSTEM_DEFINE.eXianYuEnter,0)
local reddot=UITYTongXingZhengModel:getReddot(guid)
self.mjShopBtnReddotEx:setActive(reddot)
else
self.mjShopBtn:setActive(false)
end
end
function UIXianJieMainWin:onMjShopBtn()










self:showWindow("UIJXGJumpWin")
end

function UIXianJieMainWin:refreshMoZongBtn()

self.mozongStageRoot:setActive(false)


















































end



function UIXianJieMainWin.onEnterXianJie(sceneType)
if _this==nil or not _this.isVisible then return end

end

function UIXianJieMainWin:checkIsDisplayMoJieYiHeInMoJie()
local enterData=xianjieModel:getMoJieEnterData()
local isDisplay=cfgHelper.get2(cfg_devildomseasonconfig_get,enterData.sId,"displayMoJieYiHeInMoJie")

return enterData and isDisplay and isDisplay==1
end


function UIXianJieMainWin:refreshMoJiePanel()
if not xianjieController:isMoJiShiLiShow()then
return false
end
local nowSceneIdx=xianjieModel:getSceneIndex()
local isInMoJie=nowSceneIdx and(xianjienSceneIndexType:isMoJie(nowSceneIdx))or false
local isInMGZD=nowSceneIdx and xianjienSceneIndexType:isMoGongZhengDuo(nowSceneIdx)or false
local isInXJ=not(isInMoJie or isInMGZD)
self.title_xj_bg:setActive(isInXJ)
self.title_mj_bg:setActive(isInMoJie)
self.title_mgzd_bg:setActive(isInMGZD)

self.mjslimg:setActive(isInMoJie)


if isInMGZD then
_Moneys=_Moneys2
elseif isInMoJie then
if not self:checkIsDisplayMoJieYiHeInMoJie()then
_Moneys=_Moneys2
end
else
_Moneys=_Moneys1
end
self:initMoneyBar()

if isInMoJie or isInMGZD then
self.winlua:SetChildLocalPosX(self.moneybar:getID(),120)

local forceid=xianjieController:getForce()
if forceid>0 then
local cfg=cfg_devildomforceconfig_get(forceid)
if cfg and cfg.icon2 then
self.winlua:SetChildCSImageSprite(self.mjslimg:getID(),mjslabname,cfg.icon2)
end
else
self.winlua:SetChildCSImageSprite(self.mjslimg:getID(),mjslabname,'image_mojie_2')
end
else
self.winlua:SetChildLocalPosX(self.moneybar:getID(),70)
end
end

function UIXianJieMainWin:severfreshmjpanel()
_this:refreshMoJiePanel()
_this:creatGroupBtns()
end

function UIXianJieMainWin:onMjslimg()
xianjieController:OpenMoJieShiLiWinByForce()
end


function UIXianJieMainWin.onXianJieMonsterChange(typo,infoguid)

if typo==CHANGE_TYPE.eAdd or typo==CHANGE_TYPE.eChanged then
local monsterData=xianjieModel:getMonsterData(infoguid)
if monsterData and monsterData.entitytype==xjServerEnityType.eMoJieBox then
_this:refreshMJBXBtn()
end
end
end

function UIXianJieMainWin:OutrefreshMJBXBtn()
if _this==nil then return end
_this:delayDo(1,function()
if _this==nil then return end
_this:refreshMJBXBtn()
end)
end

function UIXianJieMainWin:initMiZangPanel(init)
self:initMJBXBtn(init)
end

function UIXianJieMainWin:initMJBXBtn(init)
if init then
_this:delayDo(1,function()
if _this==nil then return end
self:refreshMJBXBtn()
end)
else
self:refreshMJBXBtn()
end
local widget=self.MJBXBtn:getWidgetBase()
widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onmjbxBtn()
end)
end

function UIXianJieMainWin:refreshMJBXBtn()
local isSGshow=xianjieController:CheckMjJieDuanSanShow()
local infoguid_str=xianjieController:check_MjJieDuanSan_BaoXiangNum()
if isSGshow and infoguid_str then
local monsterData=xianjieModel:getMonsterDataEx(infoguid_str)
if monsterData then
self._infoguid_str=infoguid_str
self:CheckMJBXTime(monsterData.expiresec)
end
self.MJBXBtn:setActive(true)
else
self.MJBXBtn:setActive(false)
end
end
function UIXianJieMainWin:CheckMJBXTime(expiresec)
if expiresec and expiresec>0 then
local widget=self.MJBXBtn:getWidgetBase()
local curTime=expiresec
local nowTime=timeHelper.getServerShortTime()
local least2=math.max(curTime-nowTime,0)
local timeStr=FMT.fmt("{0}",timeHelper.format_time_stamp3(least2))
widget:SetChildText(2,timeStr)

if least2>0 then
self:stopSelfTimerMJBX()
local func=function()
local serTime=timeHelper.getServerShortTime()
local least=math.max(curTime-serTime,0)
widget:SetChildText(2,timeHelper.format_time_stamp3(least))
if least<=0 then
self:stopSelfTimerMJBX()
end
end
self.timermjsl=self:setTimer(1,0,func)
else
self.MJBXBtn:setActive(false)
end
else
self.MJBXBtn:setActive(false)
end
end
function UIXianJieMainWin:stopSelfTimerMJBX()
if self.timermjsl then
self:stopTimerByID(self.timermjsl)
self.timermjsl=nil
end
end

function UIXianJieMainWin:onmjbxBtn()
if self._infoguid_str then
local monsterData=xianjieModel:getMonsterDataEx(self._infoguid_str)
if monsterData and monsterData.entitytype==xjServerEnityType.eMoJieBox then
if xianjienSceneIndexType:isOhterXianYu(monsterData.sceneidx)then
UIManager.error('无法采集其他仙域宝箱')
return
end
local winParams={infoguid=monsterData.infoguid}
winParams.lookAtPos=monsterData:getWorldPos()
xianjieController:openWin('UIXianJie_MJBoxInfoWin',winParams)
end
end
end

function UIXianJieMainWin.on_35_90()
if _this==nil then return end
_this:refreshSeasonEnter()
end

function UIXianJieMainWin.on_35_95()
if _this==nil then return end
_this:refreshSeasonEnter()
end

function UIXianJieMainWin:refreshLimitMoveZMBtn(backTimer)
self:stopLimitMoveZMLeftTimer()
local sceneIdx=xianjieModel:getSceneIndex()
local lastTime=moGongZhengDuoActModel:getMoveZongMenLastTime()
local isShow=xianjienSceneIndexType:isMoGongZhengDuo(sceneIdx)and lastTime~=nil
self.limitMoveZMBtn:setActive(isShow)
if not isShow then return end


local curTime=timeHelper.getServerShortTime()
local moveCD=moGongZhengDuoActModel:getBaseConfig('moveCD')
local left=curTime-lastTime
local isInCD=left<moveCD
self.freeMoveZmLeftTimeBg:setActive(true)

if isInCD and not backTimer then
self:startLimitMoveZMLeftTimer(lastTime,moveCD)
else
self.freeMoveZmLeftTime:setText("免费迁城")
end
end

function UIXianJieMainWin:stopLimitMoveZMLeftTimer()
if self.limitMoveZMLeftTimer then
self:stopTimerByID(self.limitMoveZMLeftTimer)
self.limitMoveZMLeftTimer=nil
end
end

function UIXianJieMainWin:startLimitMoveZMLeftTimer(lastTime,moveCD)
local curTime=timeHelper.getServerShortTime()
local left=moveCD-(curTime-lastTime)
local str

local func=function()
curTime=timeHelper.getServerShortTime()
left=moveCD-(curTime-lastTime)
str=timeHelper.format_time_stamp3(left)
str=toColorStringX("#e60000",str)

self.freeMoveZmLeftTime:setText(str)

if left<=0 then
self:stopLimitMoveZMLeftTimer()
self:refreshLimitMoveZMBtn(true)
end
end
self.limitMoveZMLeftTimer=self:setTimer(1,0,func)
func()
end



function UIXianJieMainWin:onLimitMoveZMBtn()

if moGongZhengDuoActModel:checkInReadyTime()then
UIManager.error('准备阶段期间无法迁移')
end
end


function UIXianJieMainWin:refreshEasyDealBtns()
self.tanChaBtn:setActive(not xianjieController:checkInMoGongZhengDuo())
end

function UIXianJieMainWin.onTYTXZRewardChange(passport_guid)

local guid=UITYTongXingZhengModel:getGuidBySysID(txzType.sys,SYSTEM_DEFINE.eXianYuEnter,0)
if passport_guid==guid then
_this:refreshMjShop()
end
end


function UIXianJieMainWin.onFPSJianHuaChange(isShow,isInit)
_this.jianhuaBtn:setActive(not isInit or isShow)
_this.jianhuaSelect:setActive(isShow)
end


function UIXianJieMainWin:onJianhuaBtn()
local flag=xianjieController:getJianHuaMode()
xianjieController:onSetJianHuaMode(not flag)
end

function UIXianJieMainWin:refreshMojieRank()
local showlist=xianjieController:GetShowRank()
if#showlist>1 then
self.winlua:SetChildCSImageSprite(self.mjRankBtn:getID(),mojierankabname,'button_moyuzhanbang')
else
self.winlua:SetChildCSImageSprite(self.mjRankBtn:getID(),mojierankabname,'button_zhengfabang_1')
end
end
