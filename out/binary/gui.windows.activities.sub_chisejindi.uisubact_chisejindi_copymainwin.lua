







def_class("UISubAct_ChiSeJinDi_CopyMainWin",UIWindowBase)









function UISubAct_ChiSeJinDi_CopyMainWin:bindComponents()

self.backButton=UIButton.get(self,0)
self.background_0=UIObject.get(self,1)
self.background_1=UIButton.get(self,2)
self.bottomTipsBtn=UIObject.get(self,3)
self.centerEffect=UIObject.get(self,4)
self.discipleBtn=UIButton.get(self,5)
self.discipleReddot=UIObject.get(self,6)
self.discipleView=UIObject.get(self,7)
self.dragDisciple=UIObject.get(self,8)
self.dragWeapon=UIButton.get(self,9)
self.enemyFlag=UIObject.get(self,10)
self.eventEffect=UIObject.get(self,11)
self.eventHUD=UIObject.get(self,12)
self.eventModel=UIObject.get(self,13)
self.eventRoot=UIObject.get(self,14)
self.eventShadow=UIObject.get(self,15)
self.eventTeam=UIObject.get(self,16)
self.fazeBtn=UIButton.get(self,17)
self.fightBtn=UIButton.get(self,18)
self.fightFaZe=UIButton.get(self,19)
self.fightRoot=UIObject.get(self,20)
self.goBtn=UIButton.get(self,21)
self.hpBg=UIObject.get(self,22)
self.levelBg=UIObject.get(self,23)
self.moneyBg=UIButton.get(self,24)
self.moneyFlow=UIObject.get(self,25)
self.moneyFlowIcon=UIImage.get(self,26)
self.moneyFlowTx=UIText.get(self,27)
self.moneyIcon=UIImage.get(self,28)
self.moneyNum=UIText.get(self,29)
self.posTips=UIObject.get(self,30)
self.preview=UIObject.get(self,31)
self.randomView=UIObject.get(self,32)
self.roundTx=UIText.get(self,33)
self.sModel_1=UIButton.get(self,34)
self.sModel_2=UIButton.get(self,35)
self.sModel_3=UIButton.get(self,36)
self.sModel_4=UIButton.get(self,37)
self.sModel_5=UIButton.get(self,38)
self.tipsContent=UIText.get(self,39)
self.tipsPanel=UIButton.get(self,40)
self.weaponBtn=UIButton.get(self,41)
self.weaponReddot=UIObject.get(self,42)
self.weaponView=UIObject.get(self,43)

self.backButton:setButtonClick(function()self:onBackButton()end)

self.background_1:setButtonClick(function()self:onBackground_1()end)

self.discipleBtn:setButtonClick(function()self:onDiscipleBtn()end)

self.dragWeapon:setButtonClick(function()self:onDragWeapon()end)

self.fazeBtn:setButtonClick(function()self:onFazeBtn()end)

self.fightBtn:setButtonClick(function()self:onFightBtn()end)

self.fightFaZe:setButtonClick(function()self:onFightFaZe()end)

self.goBtn:setButtonClick(function()self:onGoBtn()end)

self.moneyBg:setButtonClick(function()self:onMoneyBg()end)

self.sModel_1:setButtonClick(function()self:onSModel_1()end)

self.sModel_2:setButtonClick(function()self:onSModel_2()end)

self.sModel_3:setButtonClick(function()self:onSModel_3()end)

self.sModel_4:setButtonClick(function()self:onSModel_4()end)

self.sModel_5:setButtonClick(function()self:onSModel_5()end)

self.tipsPanel:setButtonClick(function()self:onTipsPanel()end)

self.weaponBtn:setButtonClick(function()self:onWeaponBtn()end)
self.background={
[0]=self.background_0,
[1]=self.background_1,
}
self.sModel={
self.sModel_1,
self.sModel_2,
self.sModel_3,
self.sModel_4,
self.sModel_5,
}



end


function UISubAct_ChiSeJinDi_CopyMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backButton);self.backButton=nil;
_UIObject_release(self.background_0);self.background_0=nil;
_UIObject_release(self.background_1);self.background_1=nil;
_UIObject_release(self.bottomTipsBtn);self.bottomTipsBtn=nil;
_UIObject_release(self.centerEffect);self.centerEffect=nil;
_UIObject_release(self.discipleBtn);self.discipleBtn=nil;
_UIObject_release(self.discipleReddot);self.discipleReddot=nil;
_UIObject_release(self.discipleView);self.discipleView=nil;
_UIObject_release(self.dragDisciple);self.dragDisciple=nil;
_UIObject_release(self.dragWeapon);self.dragWeapon=nil;
_UIObject_release(self.enemyFlag);self.enemyFlag=nil;
_UIObject_release(self.eventEffect);self.eventEffect=nil;
_UIObject_release(self.eventHUD);self.eventHUD=nil;
_UIObject_release(self.eventModel);self.eventModel=nil;
_UIObject_release(self.eventRoot);self.eventRoot=nil;
_UIObject_release(self.eventShadow);self.eventShadow=nil;
_UIObject_release(self.eventTeam);self.eventTeam=nil;
_UIObject_release(self.fazeBtn);self.fazeBtn=nil;
_UIObject_release(self.fightBtn);self.fightBtn=nil;
_UIObject_release(self.fightFaZe);self.fightFaZe=nil;
_UIObject_release(self.fightRoot);self.fightRoot=nil;
_UIObject_release(self.goBtn);self.goBtn=nil;
_UIObject_release(self.hpBg);self.hpBg=nil;
_UIObject_release(self.levelBg);self.levelBg=nil;
_UIObject_release(self.moneyBg);self.moneyBg=nil;
_UIObject_release(self.moneyFlow);self.moneyFlow=nil;
_UIObject_release(self.moneyFlowIcon);self.moneyFlowIcon=nil;
_UIObject_release(self.moneyFlowTx);self.moneyFlowTx=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyNum);self.moneyNum=nil;
_UIObject_release(self.posTips);self.posTips=nil;
_UIObject_release(self.preview);self.preview=nil;
_UIObject_release(self.randomView);self.randomView=nil;
_UIObject_release(self.roundTx);self.roundTx=nil;
_UIObject_release(self.sModel_1);self.sModel_1=nil;
_UIObject_release(self.sModel_2);self.sModel_2=nil;
_UIObject_release(self.sModel_3);self.sModel_3=nil;
_UIObject_release(self.sModel_4);self.sModel_4=nil;
_UIObject_release(self.sModel_5);self.sModel_5=nil;
_UIObject_release(self.tipsContent);self.tipsContent=nil;
_UIObject_release(self.tipsPanel);self.tipsPanel=nil;
_UIObject_release(self.weaponBtn);self.weaponBtn=nil;
_UIObject_release(self.weaponReddot);self.weaponReddot=nil;
_UIObject_release(self.weaponView);self.weaponView=nil;
self.background=nil;
self.sModel=nil;
end















local _this=nil
local _effectHidden=20384
local _backgroundSpeed=0.15
local _previewCmp={
bg=0,
iconList=1,
}
local _fightRootCmp={
widget=-1,
tModel={0,1,2,3,4},
tShadow={5,6,7,8,9},
}
local _eventTeamCmp={
item={0,1,2,3,4},
model={5,6,7,8,9},
}
local _enemyFlagCmp={
widget=-1,
unknown=0,
known=1,
fightName=2,
fightValue=3,
fightHead=4,
}
local _discipleSlotCmp={
widget=-1,
slot=0,
model=1,
weapon=2,
empty=3,
shadow=4,
}
local _weaponSlotCmp={
button=-1,
empty=0,
qualityIcon=1,
icon=2,
starBg=3,
reddot=4,
starTx=5,
}
local _randomViewCmp={
randomModel=0,
}
local _discipleViewCmp={
list=0,
empty=1,
pageTx=2,
prevBtn=3,
nextBtn=4,
}
local _discipleBagCmp={
widget=-1,
bg=0,
head=1,
job=2,
tick=3,
level=4,
lvBg=5,
name=6,
color=7,
starBg=8,
starTx=9,
}
local _weaponViewCmp={
list=0,
empty=1,
pageTx=2,
prevBtn=3,
nextBtn=4,
}
local _weaponBagCmp={
widget=-1,
qualityIcon=0,
icon=1,
starBg=2,
headBg=3,
head=4,
desc=5,
desc2=6,
starTx=7,
}
local _weaponDragCmp={
widget=-1,
qualityIcon=0,
icon=1,
starBg=2,
starTx=3,
}
local _eventHUDCmp={
widget=-1,
speak=0,
speakTx=1,
flow=2,
flowIcon=3,
flowTx=4,
}

local _eRoundState={
eNone=0,
eIdle=1,
eRun=2,
eEvent=3,
}

local _eViewState={
eNone=0,
eDiscipleBag=1,
eWeaponBag=2,
eFaZeBag=3,
}
local _eventRootHeight=-108
local _specialRoundTypePos={
[eChiSeJinDiRoundType.Reward]={80,2.5},
[eChiSeJinDiRoundType.Disciple]={80,2.5},
[eChiSeJinDiRoundType.Weapon]={80,2.5},
[eChiSeJinDiRoundType.FaZe]={80,2.5},
[eChiSeJinDiRoundType.Fight]={325,1.5},
[eChiSeJinDiRoundType.Hidden]={325,1.5},
[eChiSeJinDiRoundType.Monster]={325,1.5},
}

local _doRoundTypeEventHandle={
[eChiSeJinDiRoundType.Reward]={
enter=function(window,param,callback)
window:rewardRoundAnimation(param,callback)
end,
},
[eChiSeJinDiRoundType.Disciple]={
enter=function(window,param,callback)
local args={
actId=window.actId,
subType=window.subType,
subId=window.subId,
parentWin=window,
callback=function()
if not window.autoRun then
window.autoRun=true
window:closeWindow("UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin")
call_activitiesHandle_func("activitiesHandle_chisejindi","reqNextCopyRound",window.actId,window.subId)
end
end,
}
window:showWindow("UISubAct_ChiSeJinDi_CopyDiscipleRecruitWin",args)
if callback then callback()end
end,
},
[eChiSeJinDiRoundType.Weapon]={
enter=function(window,param,callback)
window:weaponRoundEnter(param,callback)
end,
exit=function(window,param,callback)
window:weaponRoundExit(param,callback)
end,
},
[eChiSeJinDiRoundType.FaZe]={
enter=function(window,param,callback)
local args={
actId=window.actId,
subType=window.subType,
subId=window.subId,
parentWin=window,
}
window:showWindow("UISubAct_ChiSeJinDi_FaZeGainWin",args)
if callback then callback()end
end,
},
[eChiSeJinDiRoundType.Fight]={
enter=function(window,param,callback)

window:animationRandomView(callback)
end,
},
[eChiSeJinDiRoundType.Hidden]={
enter=function(window,param,callback)
window.fightBtn:setActive(true)
if callback then callback()end
end,
},
[eChiSeJinDiRoundType.Monster]={
enter=function(window,param,callback)
window.fightBtn:setActive(true)
if callback then callback()end
end,
}
}

local _stateViewHandle={
[_eViewState.eNone]={
open=function(window)
window:refreshBackBtn()
end,
},
[_eViewState.eDiscipleBag]={
open=function(window)
window.discipleView:setActive(true)
window:refreshBackBtn()
window:showTeamSlot(true)
window:refreshDiscipleBag()
window:discipleViewEnter()
end,
close=function(window)
window:discipleViewExit(function()
window.discipleView:setActive(false)
window:showTeamSlot(false)
end)
end,
},
[_eViewState.eWeaponBag]={
open=function(window)
window.weaponView:setActive(true)
window:refreshBackBtn()
window:showTeamWeapon(true)
window:refreshWeaponBag()
window:weaponViewEnter()
end,
close=function(window)
window:weaponViewExit(function()
window:showTeamWeapon(false)
window.weaponView:setActive(false)
end)
end,
},
[_eViewState.eFaZeBag]={
open=function(window)
local args={
actId=window.actId,
subType=window.subType,
subId=window.subId,
parentWin=window,
side=0,
callback=function()
window:changeViewState(_eViewState.eNone)
end
}
window:showWindow("UISubAct_ChiSeJinDi_FaZeBagWin",args)
window:refreshBackBtn()
end,
close=function(window)
window:closeWindow("UISubAct_ChiSeJinDi_FaZeBagWin")
end,
},
}

local _stateRoundHandle={
[_eRoundState.eIdle]={
enter=function(window,param,callback)
local func=function()
window.goBtn:setActive(not window.autoRun)
if callback then callback()end
end

window.eventRoot:setChildAnchoredPos(1000,_eventRootHeight)
window:refreshEventModel()
local roundType=window.copyData.roundData.roundtype
if roundType==eChiSeJinDiRoundType.Hidden then
local effectCfg=cfgHelper.get1(cfg_effectconfig_get,_effectHidden)
window.centerEffect:setChildShowEffect(_effectHidden,true)
window:delayDo(effectCfg.lifetime/1000,func)
else
func()
end
end,
exit=function(window,param,callback)
window.goBtn:setActive(false)
if callback then callback()end
end,
},
[_eRoundState.eRun]={
enter=function(window,param,callback)
local roundType=window.copyData.roundData.roundtype
local posInfo=_specialRoundTypePos[roundType]
window:doTeamDiscipleAnimation(eAnimationID.run)
window:animationBackground(posInfo[1],posInfo[2],function()
if callback then callback()end
window:changeRoundState(_eRoundState.eEvent)
end)
end,
exit=function(window,param,callback)
window:freezeBackground()
window:doTeamDiscipleAnimation(eAnimationID.stand)
if callback then callback()end
end,
},
[_eRoundState.eEvent]={
enter=function(window,param,callback)
local roundType=window.copyData.roundData.roundtype
local posInfo=_specialRoundTypePos[roundType]
window.eventRoot:setChildAnchoredPos(posInfo[1],_eventRootHeight)
window.eventHUD:setActive(true)
window:refreshEventModel()

local handle=_doRoundTypeEventHandle[roundType]
if handle and handle.enter then
window.eventRoundType=roundType
handle.enter(window,param,callback)
else
UIManager.error(FMT.fmt("没有对应副本回合类型的事件处理：{0}",roundType))
end
end,
exit=function(window,param,callback)
local func=function()
window.fightBtn:setActive(false)
window.fightRoot:setActive(false)
window.randomView:setActive(false)
window.eventModel:setActive(true)
window.eventModel:setChildCanvasGroupAlpha(1)
window.eventShadow:setActive(true)
window.eventHUD:setActive(false)
if callback then callback()end
end
if window.eventRoundType then
local handle=_doRoundTypeEventHandle[window.eventRoundType]
window.eventRoundType=nil
if handle and handle.exit then
handle.exit(window,param,func)
return
end
end
func()
end,
},
}
local _starUpWinName={
[eChiSeJinDiRoundType.Disciple]="UISubAct_ChiSeJinDi_CopyDiscipleLevelUpWin",
[eChiSeJinDiRoundType.Weapon]="UISubAct_ChiSeJinDi_CopyWeaponLevelUpWin",
}
local _modelScale=0.9
local _abName="ui/windows/activities/sub_chisejindi/chisejindi_atlas_pak.ab"
local _angleInterval=30
local _smokeEffect=3
local _tweenerType={
background=1,
randomView=2,
discipleView=3,
weaponView=4,
flowMoney=5,
rewardRound=6,
weaponRound=7,
}
local _easeLib={
DG.Tweening.Ease.OutSine,
DG.Tweening.Ease.InOutSine,
DG.Tweening.Ease.OutQuad,
DG.Tweening.Ease.InOutQuad,
DG.Tweening.Ease.OutCubic,
DG.Tweening.Ease.InOutCubic,
DG.Tweening.Ease.OutQuart,
DG.Tweening.Ease.InOutQuart,
DG.Tweening.Ease.OutQuint,
DG.Tweening.Ease.InOutQuint,
DG.Tweening.Ease.OutExpo,
DG.Tweening.Ease.InOutExpo,
DG.Tweening.Ease.OutCirc,
DG.Tweening.Ease.InOutCirc,
DG.Tweening.Ease.OutElastic,
DG.Tweening.Ease.InOutElastic,
DG.Tweening.Ease.OutBack,
DG.Tweening.Ease.InOutBack,
DG.Tweening.Ease.OutBounce,
DG.Tweening.Ease.InOutBounce,
DG.Tweening.Ease.OutFlash,
DG.Tweening.Ease.InOutFlash,
}



function UISubAct_ChiSeJinDi_CopyMainWin:onLoaded()
self:bindComponents()
_this=self

socketManager:addNotify(249,230,self.on_249_230)
socketManager:addNotify(249,237,self.on_249_237)
socketManager:addNotify(249,238,self.on_249_238)
socketManager:addNotify(249,239,self.on_249_239)
socketManager:addNotify(249,240,self.on_249_240)
socketManager:addNotify(249,241,self.on_249_241)

self._onTeamModelBeginDrag=function(...)self:onTeamModelBeginDrag(...)end
self._onTeamModelEndDrag=function(...)self:onTeamModelEndDrag(...)end
self._onTeamModelDrag=function(...)self:onTeamModelDrag(...)end

self._onSWeaponBeginDrag=function(...)self:onTeamWeaponBeginDrag(...)end
self._onSWeaponEndDrag=function(...)self:onTeamWeaponEndDrag(...)end
self._onSWeaponDrag=function(...)self:onTeamWeaponDrag(...)end

self.tweeners={}

self.sModelWidget={}
self.sWeaponWidget={}
for i,v in ipairs(self.sModel)do
local widget=v:getChildWidgetBase()
widget:SetChildUIDragEvent(_discipleSlotCmp.widget,i,self._onTeamModelBeginDrag,self._onTeamModelEndDrag,self._onTeamModelDrag)
self.sModelWidget[i]=widget

local widget2=widget:GetChildWidgetBase(_discipleSlotCmp.weapon)
self.sWeaponWidget[i]=widget2
widget2:SetChildUIDragEvent(_weaponSlotCmp.empty,i,self._onSWeaponBeginDrag,self._onSWeaponEndDrag,self._onSWeaponDrag)
widget2:SetChildButtonClick(_weaponSlotCmp.empty,function()self:onClickTeamWeapon(i)end)
end

self.discipleViewWidget=self.discipleView:getChildWidgetBase()
self.discipleViewPageItems=self.discipleViewWidget:GetChildCommonLayoutGroupWidgetList(_discipleViewCmp.list)
self.discipleViewPageItemCnt=self.discipleViewPageItems.Count
self.discipleViewWidget:SetChildButtonClick(_discipleViewCmp.prevBtn,function()
self.discipleBagPage=math.max(self.discipleBagPage-1,1)
self:refreshDisciplePageList()
end)
self.discipleViewWidget:SetChildButtonClick(_discipleViewCmp.nextBtn,function()
self.discipleBagPage=math.min(self.discipleBagPage+1,self.discipleBagPageCnt)
self:refreshDisciplePageList()
end)

self.weaponViewWidget=self.weaponView:getChildWidgetBase()
self.weaponViewPageItems=self.weaponViewWidget:GetChildCommonLayoutGroupWidgetList(_weaponViewCmp.list)
self.weaponViewPageItemCnt=self.weaponViewPageItems.Count
self.weaponViewWidget:SetChildButtonClick(_weaponViewCmp.prevBtn,function()
self.weaponBagPage=math.max(self.weaponBagPage-1,1)
self:refreshWeaponPageList()
end)
self.weaponViewWidget:SetChildButtonClick(_weaponViewCmp.nextBtn,function()
self.weaponBagPage=math.min(self.weaponBagPage+1,self.weaponBagPageCnt)
self:refreshWeaponPageList()
end)

local fightRootWidget=self.fightRoot:getChildWidgetBase()
for i,v in ipairs(_fightRootCmp.tModel)do
fightRootWidget:SetChildButtonClick(v,function()
self:onClickFightModel(i)
end)
end
self.eventTeamWidget=self.eventTeam:getChildWidgetBase()
self.eventHUDWidget=self.eventHUD:getChildWidgetBase()
self.previewWidget=self.preview:getChildWidgetBase()
end


function UISubAct_ChiSeJinDi_CopyMainWin:__delete()
self:killAllDoTween()
self:stopUpdateTick()

self:unbindComponents()
_this=nil

socketManager:removeNotify(249,230,self.on_249_230)
socketManager:removeNotify(249,237,self.on_249_237)
socketManager:removeNotify(249,238,self.on_249_238)
socketManager:removeNotify(249,239,self.on_249_239)
socketManager:removeNotify(249,240,self.on_249_240)
socketManager:removeNotify(249,241,self.on_249_241)
end




function UISubAct_ChiSeJinDi_CopyMainWin:onShow(argtable,afterOnloaded)

self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.parentWin=argtable.parentWin
self.showPreview=argtable.preview

self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.copyData=self.info:getCopy()
self.teamData=self.info:getTeam()

self:initCopyTips()

UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
self:closeAllWindow()
self:killAllDoTween()

local resultData=self.info:getResult()
if self.copyData==nil then
if resultData then
self.copyData=resultData.copyData
self.teamData=resultData.teamData
self.discipleBagDatas=self.copyData.discipleList
self.weaponBagDatas=self.copyData.weaponList
local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
parentWin=self,
callback=function()
self:quitCopy()
end,
}
self:showWindow("UISubAct_ChiSeJinDi_CopyResultWin",args)
else
self:quitCopy()
return
end
else
if self.info:checkInResultRankTime()then
self:quitCopy()
UIManager.info("结算开始，0点后可再进入")
return
end

self.discipleBagDatas=self.copyData.discipleList
self.weaponBagDatas=self.copyData.weaponList

local change=false
for i,v in ipairs(self.teamData)do
if not table.containsValue(self.discipleBagDatas,v.disciple)then
self.info:discipleTeamOff(i)
change=true
elseif not table.containsValue(self.weaponBagDatas,v.weapon)then
self.info:weaponTeamOff(i)
change=true
end
end
if change then
self.info:saveTeam()
end
end


self:startUpdateTick()
self:initView()
self:refreshBackground()
self:refreshMoney()
self:refreshRound()
self:refreshLevel()
self:refreshHP()
self:refreshTeamDisciple()
self:refreshDiscipleBtnReddot()
self:refreshWeaponBtnReddot()

if not resultData then
self:changeViewState(_eViewState.eNone)
if self.copyData.round==1 or self.copyData.roundData.recv==1 then
self:changeRoundState(_eRoundState.eEvent)
else
self:changeRoundState(_eRoundState.eIdle)
end
end

self:refreshPreview()
end


function UISubAct_ChiSeJinDi_CopyMainWin:onHide()

end




function UISubAct_ChiSeJinDi_CopyMainWin.on_249_230(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
if _this.info:compare(actId,subType,subId)then
_this:changeRoundState(_eRoundState.eRun)
_this:showRoundMoneyAdd()
end
end

function UISubAct_ChiSeJinDi_CopyMainWin.on_249_237(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
if _this.info:compare(actId,subType,subId)then
if not _this._rChanging then
_this:refreshMoney()
_this:refreshRound()
_this:changeRoundState(_eRoundState.eIdle)
_this:checkAutoRun()
end
end
end

function UISubAct_ChiSeJinDi_CopyMainWin.on_249_238(actId,subId,idx,len,roundList)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
if _this.info:compare(actId,subType,subId)then
_this:refreshMoney()

if _this.info:checkStarUp()then

_this:checkStarUpRefresh()

_this:nextStarUp()
else

_this:checkAutoTeamOnRefresh(idx)
end

if len>0 then
_this:refreshRound()
_this:changeRoundState(_eRoundState.eIdle)
end
end
end

function UISubAct_ChiSeJinDi_CopyMainWin.on_249_239(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
if _this.info:compare(actId,subType,subId)then
_this:refreshMoney()
end
end

function UISubAct_ChiSeJinDi_CopyMainWin.on_249_240(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
if _this.info:compare(actId,subType,subId)then
_this.copyData=_this.info:getCopy()
local args={
actId=actId,
subType=subType,
subId=subId,
parentWin=_this,
callback=function()
_this:quitCopy()
end,
}
_this:showWindow("UISubAct_ChiSeJinDi_CopyResultWin",args)
end
end

function UISubAct_ChiSeJinDi_CopyMainWin.on_249_241(actId,subId,roundtype,len,ids)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
if _this.info:compare(actId,subType,subId)then
_this:refreshMoney()

if roundtype==eChiSeJinDiRoundType.Disciple then
_this:refreshTeamDisciple()
if _this._vState==_eViewState.eDiscipleBag then
_this:refreshDiscipleBag()
_this:cancelDragDisciple()
end
elseif roundtype==eChiSeJinDiRoundType and _this._vState==_eViewState.eWeaponBag then
_this:refreshAllTeamWeapon()
_this:refreshWeaponBag()
_this:cancelDragWeapon()
end
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:onSModel_1()
if self.teamData[1].disciple>0 then
self:onClickSModel()
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:onSModel_2()
if self.teamData[2].disciple>0 then
self:onClickSModel()
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:onSModel_3()
if self.teamData[3].disciple>0 then
self:onClickSModel()
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:onSModel_4()
if self.teamData[4].disciple>0 then
self:onClickSModel()
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:onSModel_5()
if self.teamData[5].disciple>0 then
self:onClickSModel()
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:onBackground_1()
self:changeViewState(_eViewState.eNone)
end

function UISubAct_ChiSeJinDi_CopyMainWin:onBackButton()

local args={
content="是要进行结算还是暂离禁地？\n（中途离开后会保存进度）",
oktext="结 算",
canceltext="暂 离",
showCloseBtn=true,
okcb=function()
call_activitiesHandle_func("activitiesHandle_chisejindi","reqResultCopy",self.actId,self.subId)
end,
cancelcb=function()
self:quitCopy()
end,
}
local dialog=UIDialogManager.getConfirmDialogEx(nil,args)
dialog:show()
end

function UISubAct_ChiSeJinDi_CopyMainWin:onMoneyBg()
tipsManager.showTips({itemid=self.config.chanceMoney})
end

function UISubAct_ChiSeJinDi_CopyMainWin:onFightBtn()

if self.animation then
return
end
if self._rChanging then
return false
end
if self._rState~=_eRoundState.eEvent then
return
end



if self.copyData==nil then
return
end

local roundType=self.copyData.roundData.roundtype
if roundType~=eChiSeJinDiRoundType.Fight and roundType~=eChiSeJinDiRoundType.Hidden and roundType~=eChiSeJinDiRoundType.Monster then
return
end

local doFight=function()
call_activitiesHandle_func("activitiesHandle_chisejindi","reqCopyFight",self.actId,self.subId,
self.teamData[1].disciple,self.teamData[1].weapon,
self.teamData[2].disciple,self.teamData[2].weapon,
self.teamData[3].disciple,self.teamData[3].weapon,
self.teamData[4].disciple,self.teamData[4].weapon,
self.teamData[5].disciple,self.teamData[5].weapon)
end

local discipleLookup=self.info:getTeamLookup_Disciple()
if next(discipleLookup)==nil then
return UIManager.error("请先上阵弟子")
end
local weaponLookup=self.info:getTeamLookup_Weapon()


local discipleServer=self.config.disciple
local weaponServer=self.config.treasure
local minDiscipleColor=nil
local minWeaponColor=nil
for pos,posData in ipairs(self.teamData)do
local disciple=posData.disciple
local weapon=posData.weapon
local discipleColor=posData.disciple>0 and discipleServer[disciple][5]or 0
local weaponColor=posData.weapon>0 and weaponServer[weapon][6]or 0
minDiscipleColor=minDiscipleColor and math.min(minDiscipleColor,discipleColor)or discipleColor
minWeaponColor=minWeaponColor and math.min(minWeaponColor,weaponColor)or weaponColor
end

local checkDisciple=false
for index,discipleId in ipairs(self.discipleBagDatas)do
local color=discipleServer[discipleId][5]
if discipleLookup[discipleId]==nil and(minDiscipleColor==nil or color>minDiscipleColor)then
checkDisciple=true
break
end
end
local checkWeapon=false
for index,weaponId in ipairs(self.weaponBagDatas)do
local color=weaponServer[weaponId][6]
if weaponLookup[weaponId]==nil and(minWeaponColor==nil or color>minWeaponColor)then
checkWeapon=true
break
end
end
local tempFunc=function()
if checkWeapon then
UIDialogManager.getConfirmDialog3(nil,"存在品质更高的宝物未装备，确定是否直接进行战斗？",doFight,REPEAT_TYPE.eChiSeJinDiBetterWeapon)
else
doFight()
end
end
if checkDisciple then
UIDialogManager.getConfirmDialog3(nil,"存在品质更高的弟子未上阵，确定是否直接进行战斗？",tempFunc,REPEAT_TYPE.eChiSeJinDiBetterWeapon)
else
tempFunc()
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:onGoBtn()

if self.animation then
return false
end
if self._rChanging then
return false
end
if self._rState~=_eRoundState.eIdle then
return false
end



if self.copyData==nil then
return false
end


local lookup=self.info:getTeamLookup_Disciple()
if next(lookup)==nil then
UIManager.info("请先上阵弟子")
return false
end

local template=self.copyData.template
local round=self.copyData.round
local roundCfg=cfgHelper.get2(cfg_chisejindiroundconfig_get,template,round)
local roundData=self.copyData.roundData

if roundCfg.chance and roundCfg.chance>0 and roundData.recv==0 then
call_activitiesHandle_func("activitiesHandle_chisejindi","reqGetRoundMoney",self.actId,self.subId)
else
self:changeRoundState(_eRoundState.eRun)
end
return true
end

function UISubAct_ChiSeJinDi_CopyMainWin:onFightFaZe()
local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
parentWin=self,
side=1,
}
self:showWindow("UISubAct_ChiSeJinDi_FaZeBagWin",args)
end

function UISubAct_ChiSeJinDi_CopyMainWin:onDiscipleBtn()
self:changeViewState(_eViewState.eDiscipleBag)
end

function UISubAct_ChiSeJinDi_CopyMainWin:onWeaponBtn()
self:changeViewState(_eViewState.eWeaponBag)
end

function UISubAct_ChiSeJinDi_CopyMainWin:onFazeBtn()
self:changeViewState(_eViewState.eFaZeBag)
end

function UISubAct_ChiSeJinDi_CopyMainWin:onDiscipleBack()
self:changeViewState(_eViewState.eNone)
end

function UISubAct_ChiSeJinDi_CopyMainWin:onWeaponBack()
self:changeViewState(_eViewState.eNone)
end

function UISubAct_ChiSeJinDi_CopyMainWin:onClickBottomTipsBtn()
self.showTips=not self.showTips
self:showBottomTips()
end

function UISubAct_ChiSeJinDi_CopyMainWin:onTipsPanel()
self.showTips=false
self:showBottomTips()
end

function UISubAct_ChiSeJinDi_CopyMainWin:onClickSModel()

local roleList={}
for i,v in ipairs(self.teamData)do
if v.disciple>0 then
local data={
disciple=v.disciple,
weapon=v.weapon>0 and v.weapon or nil,
}
table.insert(roleList,data)
end
end
local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
roleList=roleList,
parentWin=self,
}
self:showWindow("UISubAct_ChiSeJinDi_CopyDiscipleDetailWin",args)

end

function UISubAct_ChiSeJinDi_CopyMainWin:initCopyTips()
local str=self.config.copyTips
self.tipsContent:setText(str)
end

function UISubAct_ChiSeJinDi_CopyMainWin:showRoundMoneyAdd()
local roundData=self.copyData.roundData
if roundData.roundtype~=eChiSeJinDiRoundType.Hidden then
local template=self.copyData.template
local round=self.copyData.round
local templateCfg=cfgHelper.get2(cfg_chisejindiroundconfig_get,template,round)
self:flowMoney(templateCfg.chance)
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:refreshDragDisciple(discipleId)
local discipleServer=self.config.disciple
local serverCfg=discipleServer[discipleId]
local monsterId=serverCfg[1]
local monsterCfg=cfgHelper.get1(cfg_monsterconfig_get,monsterId)
local modelCfg=monsterCfg.modelid
self.dragDisciple:setChildUIModelShowTarget(modelCfg[1],_modelScale,modelCfg[2]or defaultT,eAnimationID.stand,false,false,0,nil)
self.dragDisciple:setChildUIModelShowFlipX(true)
end

function UISubAct_ChiSeJinDi_CopyMainWin:refreshDragWeapon(weaponID)
local dragWidget=self.dragWeapon:getChildWidgetBase()
local weaponClient=self.config.treasureClient[weaponID]
local weaponServer=self.config.treasure[weaponID]
local color=weaponServer[6]
local iconName=weaponClient[2]
local star=self.info:getCopyItemStar(weaponID)
dragWidget:SetChildQulaity(_weaponDragCmp.qualityIcon,color)
dragWidget:SetChildCSImageIcon(_weaponDragCmp.icon,iconName,false)
dragWidget:SetChildActive(_weaponDragCmp.starBg,star>0)
dragWidget:SetChildText(_weaponDragCmp.starTx,star>0 and star or"")
end

function UISubAct_ChiSeJinDi_CopyMainWin:cancelDragDisciple()
self.dragDiscipleId=nil
self.dragDisciple:setChildUIModelRemoveTarget()
self.dragDisciple:setActive(false)
end

function UISubAct_ChiSeJinDi_CopyMainWin:cancelDragWeapon()
self.dragWeaponId=nil
self.dragWeapon:setActive(false)
end

function UISubAct_ChiSeJinDi_CopyMainWin:onTeamModelBeginDrag(index,targetPos)
if self._vState~=_eViewState.eDiscipleBag then return end
if self.dragDiscipleId~=nil then return end

local posData=self.teamData[index]
local discipleId=posData.disciple
if discipleId<=0 then
return
end
self.dragDiscipleId=discipleId
self.dragDisciple:setActive(true)
self:refreshDragDisciple(discipleId)
local widget=self.sModelWidget[index]
widget:SetChildActive(_discipleSlotCmp.model,false)
widget:SetChildActive(_discipleSlotCmp.shadow,false)
end

function UISubAct_ChiSeJinDi_CopyMainWin:onTeamModelEndDrag(index,targetPos)
if self._vState~=_eViewState.eDiscipleBag then return end
if self.dragDiscipleId==nil then return end

self:cancelDragDisciple()
local widget=self.sModelWidget[index]
widget:SetChildActive(_discipleSlotCmp.model,true)
widget:SetChildActive(_discipleSlotCmp.shadow,true)

for i,v in ipairs(self.sModel)do
local screenPos=v:getChildUIScreenPos()
local width=v:getChildRectWidth()
local height=v:getChildRectHeight()
local check=screenPos.x-width/2<=targetPos.x and screenPos.x+width/2>=targetPos.x and screenPos.y<=targetPos.y and screenPos.y+height>=targetPos.y
if check then
if i==index then
return
end

self.info:changeDisciplePos(i,index)
self.info:saveTeam()
self:refreshTeamDiscipleItem(i)
self:refreshTeamDiscipleItem(index)
return
end
end






local discipleId=self.teamData[index].disciple
self.info:discipleTeamOff(index)
self.info:saveTeam()
self:refreshTeamDiscipleItem(index)
self:refreshDisciplePageItemTickEx({discipleId})
self:refreshDiscipleBtnReddot()
self:refreshWeaponBtnReddot()

end

function UISubAct_ChiSeJinDi_CopyMainWin:onTeamModelDrag(index,targetPos,deltaTime)
if self._vState~=_eViewState.eDiscipleBag then return end
if self.dragDiscipleId==nil then return end

self.dragDisciple:setChildUIScreenPos(targetPos)
end

function UISubAct_ChiSeJinDi_CopyMainWin:onTeamWeaponBeginDrag(index,position)
if self._vState~=_eViewState.eWeaponBag then return end
if self.dragWeaponId~=nil then return end

local weaponID=self.teamData[index].weapon
if weaponID<=0 then
return
end
self.dragWeaponId=weaponID
self.dragWeapon:setActive(true)
self:refreshDragWeapon(weaponID)

local widget=self.sWeaponWidget[index]
widget:SetChildActive(_weaponSlotCmp.qualityIcon,false)
end

function UISubAct_ChiSeJinDi_CopyMainWin:onTeamWeaponEndDrag(index,targetPos)
if self._vState~=_eViewState.eWeaponBag then return end
if not self.dragWeaponId then return end

self:cancelDragWeapon()
local widget=self.sWeaponWidget[index]
widget:SetChildActive(_weaponSlotCmp.qualityIcon,true)

for i,v in ipairs(self.sWeaponWidget)do
local screenPos=v:GetChildUIScreenPos(_weaponSlotCmp.empty)
local width=v:GetChildRectWidth(_weaponSlotCmp.empty)
local height=v:GetChildRectHeight(_weaponSlotCmp.empty)
local check=screenPos.x-width/2<=targetPos.x and screenPos.x+width/2>=targetPos.x and screenPos.y-height/2<=targetPos.y and screenPos.y+height/2>=targetPos.y
if check then
if i==index then
local widget=self.sWeaponWidget[index]
widget:SetChildActive(_weaponSlotCmp.qualityIcon,true)
return
end

self.info:changeWeaponPos(i,index)
self.info:saveTeam()
self:refreshTeamPosWeapon(i)
self:refreshTeamPosWeapon(index)

local weaponId1=self.teamData[index].weapon
local weaponId2=self.teamData[i].weapon
local refreshList={weaponId1,weaponId2}
if#refreshList>0 then
self:refreshWeaponBagItemOwnerEx(refreshList)
end

local widget=self.sWeaponWidget[index]
widget:SetChildActive(_weaponSlotCmp.qualityIcon,true)
return
end
end






local weaponId=self.teamData[index].weapon
self.info:weaponTeamOff(index)
self.info:saveTeam()
self:refreshTeamPosWeapon(index)
self:refreshWeaponBtnReddot()
local index=table.findValue(self.weaponBagDatas,weaponId)
self:refreshWeaponBagItemOwnerEx({weaponId})

end

function UISubAct_ChiSeJinDi_CopyMainWin:onTeamWeaponDrag(index,targetPos,deltaTime)
if self._vState~=_eViewState.eWeaponBag then return end
if not self.dragWeaponId then return end

self.dragWeapon:setChildUIScreenPos(targetPos)
end

function UISubAct_ChiSeJinDi_CopyMainWin:onBagDiscipleBeginDrag(index,position)
if self._vState~=_eViewState.eDiscipleBag then return end
if self.dragDiscipleId~=nil then return end

self.dragDisciple:setActive(true)
local discipleId=self.discipleBagDatas[index]
self:refreshDragDisciple(discipleId)
self.dragDiscipleId=discipleId
end

function UISubAct_ChiSeJinDi_CopyMainWin:onBagDiscipleEndDrag(index,targetPos)
if self._vState~=_eViewState.eDiscipleBag then return end
if not self.dragDiscipleId then return end

self:cancelDragDisciple()

local discipleId=self.discipleBagDatas[index]
local teamLookup=self.info:getTeamLookup_Disciple()
local pos=teamLookup[discipleId]
for i,v in ipairs(self.sModel)do
local screenPos=v:getChildUIScreenPos()
local width=v:getChildRectWidth()
local height=v:getChildRectHeight()
local check=screenPos.x-width/2<=targetPos.x and screenPos.x+width/2>=targetPos.x and screenPos.y<=targetPos.y and screenPos.y+height>=targetPos.y
if check then
if i==pos then
return
end
if pos then
self.info:changeDisciplePos(i,pos)
self.info:saveTeam()
self:refreshTeamDiscipleItem(i)
self:refreshTeamDiscipleItem(pos)
else
local oDiscipleID=self.teamData[i].disciple
self.info:discipleTeamOff(i)
self.info:discipleTeamOn(i,discipleId)
self.info:saveTeam()
self:refreshTeamDiscipleItem(i)
self:refreshDiscipleBtnReddot()
self:refreshWeaponBtnReddot()
self:refreshDisciplePageItemTickEx({oDiscipleID,discipleId})
end
return
end
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:onBagDiscipleDrag(index,targetPos,deltaTime)
if self._vState~=_eViewState.eDiscipleBag then return end
if not self.dragDiscipleId then return end

self.dragDisciple:setChildUIScreenPos(targetPos)
end

function UISubAct_ChiSeJinDi_CopyMainWin:onBagWeaponBeginDrag(index,position)
if self._vState~=_eViewState.eWeaponBag then return end
if self.dragWeaponId~=nil then return end

local weaponID=self.weaponBagDatas[index]
self.dragWeapon:setActive(true)
self:refreshDragWeapon(weaponID)
self.dragWeaponId=weaponID
end

function UISubAct_ChiSeJinDi_CopyMainWin:onBagWeaponEndDrag(index,targetPos)
if self._vState~=_eViewState.eWeaponBag then return end
if not self.dragWeaponId then return end
self:cancelDragWeapon()

local weaponId=self.weaponBagDatas[index]
local lookup=self.info:getTeamLookup_Weapon()
local pos=lookup[weaponId]
for i,v in ipairs(self.sWeaponWidget)do
local posData=self.teamData[i]
if posData.disciple>0 then
local screenPos=v:GetChildUIScreenPos(_weaponSlotCmp.empty)
local width=v:GetChildRectWidth(_weaponSlotCmp.empty)
local height=v:GetChildRectHeight(_weaponSlotCmp.empty)
local check=screenPos.x-width/2<=targetPos.x and screenPos.x+width/2>=targetPos.x and screenPos.y-height/2<=targetPos.y and screenPos.y+height/2>=targetPos.y
if check then
if i==pos then
return
end
local tWeaponId=self.teamData[i].weapon
if pos then
self.info:changeWeaponPos(i,pos)
self.info:saveTeam()
self:refreshTeamPosWeapon(i)
self:refreshTeamPosWeapon(pos)
else
self.info:weaponTeamOn(i,weaponId)
self.info:saveTeam()
self:refreshTeamPosWeapon(i)
self:refreshWeaponBtnReddot()
end
self:refreshWeaponBagItemOwnerEx({tWeaponId,weaponId})
return
end
end
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:onBagWeaponDrag(index,targetPos)
if self._vState~=_eViewState.eWeaponBag then return end
if not self.dragWeaponId then return end

self.dragWeapon:setChildUIScreenPos(targetPos)
end

function UISubAct_ChiSeJinDi_CopyMainWin:changeViewState(state)










if state==nil or self._vState==state then
return false
end

local oState=self._vState

self._vState=state

if oState then
local oldHandle=_stateViewHandle[oState]
if oldHandle and oldHandle.close then
oldHandle.close(self)
end
end

local newHandle=_stateViewHandle[self._vState]
if newHandle and newHandle.open then
newHandle.open(self)
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:changeRoundState(state,param,callback)
if self.copyData==nil then return end

if self._rChanging then
loggerUtil.logErrFMT("回合状态切换未结束，被再次切换状态：{0}",state)
return
end

self._rChanging=true
local exitFunc=nil
if self._rState then
local oldHandle=_stateRoundHandle[self._rState]
exitFunc=oldHandle and oldHandle.exit or nil
end

self._rState=state

local newHandle=_stateRoundHandle[self._rState]
local enterFunc=newHandle and newHandle.enter or nil

local finish=function()
self._rChanging=false
if callback then callback()end
end
local func=function()
if enterFunc then
enterFunc(self,param,finish)
else
finish(param)
end
end
if exitFunc then
exitFunc(self,param,func)
else
func()
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:quitCopy()
self.info:setCopy()
self.info:clearStarUp()
self:doCloseWin()
end

function UISubAct_ChiSeJinDi_CopyMainWin:doCloseWin()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
UIManager:closeWindow(self.__name)
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:initView()
self.moneyIcon:setImageIcon(iconHelper.getIconName(self.config.chanceMoney),false)
self.moneyFlowIcon:setImageIcon(iconHelper.getIconName(self.config.chanceMoney),false)
self.hpBg:setChildLayoutGroupCreateItems(self.config.times)
end

function UISubAct_ChiSeJinDi_CopyMainWin:refreshBackground()
self.bgUse=0
local template=self.copyData.template
local round=self.copyData.round
round=round>1 and round-1 or 1
local templateCfg=cfgHelper.get2(cfg_chisejindiroundconfig_get,template,round)
for i,v in pairs(self.background)do
if i==self.bgUse then
v:setChildUIModelShowTarget(templateCfg.background,1,{},eAnimationID.stand,false,false,0)
self.winlua:SetChildUIModelAnimationSpeed(v:getID(),0)
v:setChildCanvasGroupAlpha(1)
self.bgId=templateCfg.background
else
v:setChildUIModelRemoveTarget()
v:setChildCanvasGroupAlpha(0)
end
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:animationBackground(pos,duration,callback)
local template=self.copyData.template
local round=self.copyData.round
local templateCfg=cfgHelper.get2(cfg_chisejindiroundconfig_get,template,round)
local sequence=Lua.SequenceProxy.New()
local tweener=self.eventRoot:setChildDOAnchorPosX(pos,duration)
tweener:SetEase(DG.Tweening.Ease.Linear)
sequence:Append(tweener)
if self.bgId~=templateCfg.background then
for i,v in pairs(self.background)do
if self.bgUse==i then
local tween=v:setChildCanvasGroupDOFade(0,duration)
tween:SetEase(DG.Tweening.Ease.Linear)
self.winlua:SetChildUIModelAnimationSpeed(v:getID(),_backgroundSpeed)
sequence:Join(tween)
else
self.bgUse=i
v:setChildUIModelShowTarget(templateCfg.background,1,{},eAnimationID.stand,false,false,0,function()
self.winlua:SetChildUIModelAnimationSpeed(v:getID(),_backgroundSpeed)
end)
local tween=v:setChildCanvasGroupDOFade(1,duration)
tween:SetEase(DG.Tweening.Ease.Linear)
sequence:Join(tween)
end
end
else
local v=self.background[self.bgUse]
self.winlua:SetChildUIModelAnimationSpeed(v:getID(),_backgroundSpeed)
end

if self.showPreview then
local pos=self.previewWidget:GetChildAnchoredPosition(_previewCmp.iconList)
for i,v in pairs(_previewCmp)do
local tween=self.previewWidget:SetChildDOAnchorPosX(v,pos.x-100,duration)
tween:SetEase(DG.Tweening.Ease.Linear)
sequence:Join(tween)
end
end

sequence:AppendCallback(callback)
self:setDoTween(_tweenerType.background,sequence)
end

function UISubAct_ChiSeJinDi_CopyMainWin:freezeBackground()
for i,v in pairs(self.background)do
self.winlua:SetChildUIModelAnimationSpeed(v:getID(),0)
end
end


function UISubAct_ChiSeJinDi_CopyMainWin:refreshMoney()
local moneyStr=mathHelper.formatNumber(self.copyData.money)
self.moneyNum:setText(moneyStr)
end


function UISubAct_ChiSeJinDi_CopyMainWin:refreshRound()
local template=self.copyData.template
local roundCfg=cfgHelper.get2(cfg_chisejindiroundconfig_get,template)
local cur=self.copyData.round-1
local max=#roundCfg-1
local str=FMT.fmt("<size=32><b>{0}</b></size>",cur)
self.roundTx:setText(str)
end


function UISubAct_ChiSeJinDi_CopyMainWin:refreshLevel()
self.levelBg:setChildLayoutGroupCreateItems(self.copyData.level)
end


function UISubAct_ChiSeJinDi_CopyMainWin:refreshHP()
local hpList=self.hpBg:getChildLayoutGroupGridList()
for i=1,hpList.Count do
local hpItem=hpList[i-1]
hpItem:SetChildActive(0,i<=self.copyData.hp)
end
end


function UISubAct_ChiSeJinDi_CopyMainWin:refreshTeamDisciple()
for i,v in ipairs(self.sModelWidget)do
self:refreshTeamDiscipleItem(i)
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:refreshTeamDiscipleItem(index)
local posData=self.teamData[index]
local v=self.sModelWidget[index]
if posData.disciple>0 then
local discipleCfg=self.config.disciple[posData.disciple]
local monsterCfg=cfgHelper.get1(cfg_monsterconfig_get,discipleCfg[1])
local modelCfg=monsterCfg.modelid
local anim=self._rState==_eRoundState.eRun and eAnimationID.run or eAnimationID.stand
v:SetChildUIModelShowTarget(_discipleSlotCmp.model,modelCfg[1],_modelScale,modelCfg[2]or defaultT,anim,false,false,0,nil)
v:SetChildUIModelShowFlipX(_discipleSlotCmp.model,true)
v:SetChildActive(_discipleSlotCmp.empty,false)
v:SetChildActive(_discipleSlotCmp.shadow,true)
else
v:SetChildUIModelRemoveTarget(_discipleSlotCmp.model)
v:SetChildActive(_discipleSlotCmp.empty,true)
v:SetChildActive(_discipleSlotCmp.shadow,false)
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:doTeamDiscipleAnimation(anim)
for i,v in ipairs(self.sModelWidget)do
local posData=self.teamData[i]
if posData.disciple>0 then
v:SetChildModelAnimationState(_discipleSlotCmp.model,anim)
end
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:refreshEventModel()
local roundData=self.copyData.roundData
if roundData.roundtype==eChiSeJinDiRoundType.Monster then
local monsterGroup=roundData.mongroupid
local monsterGroupCfg=cfgHelper.get1(cfg_monstergroup_get,monsterGroup)
self.eventModel:setActive(false)
self.eventTeam:setActive(true)
for i,v in ipairs(_eventTeamCmp.item)do
local monsterId=monsterGroupCfg.monList[i]
local show=monsterId~=nil and monsterId>0
self.eventTeamWidget:SetChildActive(i,show)
if show then
local monsterCfg=cfgHelper.get1(cfg_monsterconfig_get,monsterId)
self.eventTeamWidget:SetChildUIModelShowTarget(_eventTeamCmp.model[i],monsterCfg.modelid[1],monsterCfg.scale,nil,eAnimationID.stand,false,false,0)
end
end
elseif roundData.roundtype==eChiSeJinDiRoundType.Hidden then
local hideId=roundData.hideid
local hideCfg=self.config.hide[hideId]
local monsterGroup=hideCfg[2]
local monsterGroupCfg=cfgHelper.get1(cfg_monstergroup_get,monsterGroup)
local modelParams=monsterGroupCfg.model
self.eventModel:setActive(true)
self.eventTeam:setActive(false)
self.eventModel:setChildUIModelShowTarget(modelParams[1],modelParams[2],modelParams[3]or defaultT,eAnimationID.stand,false,false,0)
else
local round=self.copyData.round
local template=self.copyData.template
local roundCfg=cfgHelper.get2(cfg_chisejindiroundconfig_get,template,round)
local modelParams=roundCfg.model
self.eventModel:setActive(true)
self.eventTeam:setActive(false)
self.eventModel:setChildUIModelShowTarget(modelParams[1],modelParams[3],modelParams[2]or defaultT,modelParams[4],false,false,0)
end

if roundData.roundtype==eChiSeJinDiRoundType.Fight then
self.enemyFlag:setActive(true)
self:setEnemyFlagUnknown()
else
self.enemyFlag:setActive(false)
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:setEnemyFlagUnknown()
local widget=self.enemyFlag:getChildWidgetBase()
widget:SetChildActive(_enemyFlagCmp.unknown,true)
widget:SetChildActive(_enemyFlagCmp.known,false)
end

function UISubAct_ChiSeJinDi_CopyMainWin:setEnemyFlagKnown(randomName)
local roundData=self.copyData.roundData
local widget=self.enemyFlag:getChildWidgetBase()
widget:SetChildActive(_enemyFlagCmp.unknown,false)
widget:SetChildActive(_enemyFlagCmp.known,true)
widget:SetChildText(_enemyFlagCmp.fightName,roundData.actorname~=""and roundData.actorname or randomName)
playerController:setHeadIcon(widget,_enemyFlagCmp.fightHead,{iconInfo=roundData.iconInfo})
end

function UISubAct_ChiSeJinDi_CopyMainWin:showTeamSlot(show)
for i,v in ipairs(self.sModelWidget)do
local posData=self.teamData[i]
v:SetChildActive(_discipleSlotCmp.slot,show)
v:SetChildActive(_discipleSlotCmp.empty,posData.disciple<=0)
v:SetChildActive(_discipleSlotCmp.shadow,posData.disciple>0)
end
self.posTips:setActive(show)
end

function UISubAct_ChiSeJinDi_CopyMainWin:refreshDiscipleBag(assign)
local len=#self.discipleBagDatas
local empty=len<=0
self.discipleViewWidget:SetChildActive(_discipleViewCmp.empty,empty)
self.discipleViewWidget:SetChildActive(_discipleViewCmp.list,not empty)
self.discipleViewWidget:SetChildActive(_discipleViewCmp.pageTx,not empty)

if not empty then
self.copyData:sortDiscipleList()
self.discipleBagPageCnt=math.ceil(len/self.discipleViewPageItemCnt)
self.discipleBagPage=self.discipleBagPage or 1
self.discipleBagPage=Mathf.Clamp(self.discipleBagPage,1,self.discipleBagPageCnt)
self:refreshDisciplePageList()
else
self.discipleBagPage=0
self.discipleBagPageCnt=0
self.discipleViewWidget:SetChildActive(_discipleViewCmp.prevBtn,false)
self.discipleViewWidget:SetChildActive(_discipleViewCmp.nextBtn,false)
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:refreshDisciplePageList()
local onLookup=self.info:getTeamLookup_Disciple()
local discipleServer=self.config.disciple
for itemIdx=1,self.discipleViewPageItemCnt do
local item=self.discipleViewPageItems[itemIdx-1]
local index=(self.discipleBagPage-1)*self.discipleViewPageItemCnt+itemIdx
local discipleId=self.discipleBagDatas[index]
item:SetChildActive(_discipleBagCmp.widget,discipleId~=nil)
if discipleId then
local serverCfg=discipleServer[discipleId]
local color=serverCfg[5]

local job=serverCfg[6]
local star=self.info:getCopyItemStar(discipleId)
local inside=self.config.discipleInside[discipleId]
local modelParams={
body=inside[1],
componets=inside[2]or defaultT,
}
comHelper.setChildModelHeadIconBGByColor(item,_discipleBagCmp.bg,color)
comHelper.setChildModelRawImageEx(_discipleBagCmp.head,item,modelParams,eHeadCenterType.eHead)
item:SetChildActive(_discipleBagCmp.starBg,star>0)
item:SetChildText(_discipleBagCmp.starTx,star)
item:SetChildCSImageSprite(_discipleBagCmp.job,globalABLookup.global,UIDiscipleModel:getJobIconName(job))

item:SetChildActive(_discipleBagCmp.tick,onLookup[discipleId]~=nil)

item:SetChildCSImageSprite(_discipleBagCmp.color,_abName,FMT.fmt("image_chiseshilian_pz{0}",color))
item:SetChildButtonClick(_discipleBagCmp.widget,function()
self:onClickDiscipleBagItem(index)
end)
item:SetChildUIDragEvent(_discipleBagCmp.widget,index,
function(...)self:onBagDiscipleBeginDrag(...)end,
function(...)self:onBagDiscipleEndDrag(...)end,
function(...)self:onBagDiscipleDrag(...)end)
item:SetChildLongTouch(_discipleBagCmp.widget,index,1,function(...)
self:onLongTouchDiscipleBagItem(...)
end)
end
end
self.discipleViewWidget:SetChildText(_discipleViewCmp.pageTx,FMT.fmt("{0} / {1}",self.discipleBagPage,self.discipleBagPageCnt))
self.discipleViewWidget:SetChildActive(_discipleViewCmp.prevBtn,self.discipleBagPage>1)
self.discipleViewWidget:SetChildActive(_discipleViewCmp.nextBtn,self.discipleBagPage<self.discipleBagPageCnt)
end

function UISubAct_ChiSeJinDi_CopyMainWin:refreshDisciplePageItemTick(indexList)
local onLookup=self.info:getTeamLookup_Disciple()
for idx,itemIdx in ipairs(indexList)do
local index=(self.discipleBagPage-1)*self.discipleViewPageItemCnt+itemIdx
local discipleID=self.discipleBagDatas[index]
local item=self.discipleViewPageItems[itemIdx-1]
if discipleID and item then
item:SetChildActive(_discipleBagCmp.tick,onLookup[discipleID]~=nil)
end
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:refreshDisciplePageItemTickEx(disciples)
local onLookup=self.info:getTeamLookup_Disciple()
for itemIdx=1,self.discipleViewPageItemCnt do
local index=(self.discipleBagPage-1)*self.discipleViewPageItemCnt+itemIdx
local discipleID=self.discipleBagDatas[index]
if discipleID and table.containsValue(disciples,discipleID)then
local item=self.discipleViewPageItems[itemIdx-1]
item:SetChildActive(_discipleBagCmp.tick,onLookup[discipleID]~=nil)
end
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:onLongTouchDiscipleBagItem(index)
if self.dragDiscipleId~=nil then return end

local discipleId=self.discipleBagDatas[index]
local lookup=self.info:getTeamLookup_Disciple()
local pos=lookup[discipleId]
local weaponId=pos and self.teamData[pos].weapon or nil
local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
roleList={
{
disciple=discipleId,
weapon=weaponId,
}
},
parentWin=self,
}
self:showWindow("UISubAct_ChiSeJinDi_CopyDiscipleDetailWin",args)
end

function UISubAct_ChiSeJinDi_CopyMainWin:onClickDiscipleBagItem(index)
local discipleId=self.discipleBagDatas[index]
local lookup=self.info:getTeamLookup_Disciple()
local pos=lookup[discipleId]
if pos then
self.info:discipleTeamOff(pos)
self.info:saveTeam()
self:refreshTeamDiscipleItem(pos)
self:refreshDisciplePageItemTickEx({discipleId})
return
end

local discipleServer=self.config.disciple
local serverCfg=discipleServer[discipleId]
local job=serverCfg[6]
local jobCfg=cfgHelper.get1(cfg_disciplevocationconfig_get,job)
for i,v in ipairs(jobCfg.pospriorty)do
local posData=self.teamData[v]
if posData.disciple<=0 then

self.info:discipleTeamOn(v,discipleId)
self.info:saveTeam()
self:refreshDisciplePageItemTickEx({discipleId})
self:refreshTeamDiscipleItem(v)
self:refreshDiscipleBtnReddot()
self:refreshWeaponBtnReddot()
return
end
end

UIManager.info("阵容已满员，请先下阵弟子")
end

function UISubAct_ChiSeJinDi_CopyMainWin:showTeamWeapon(show)
for i,v in ipairs(self.sModelWidget)do
local posData=self.teamData[i]
if posData.disciple>0 then
v:SetChildActive(_discipleSlotCmp.weapon,show)
if show then
self:refreshTeamPosWeapon(i)
end
end
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:refreshAllTeamWeapon()
for i,v in ipairs(self.sModelWidget)do
local posData=self.teamData[i]
if posData.disciple>0 then
self:refreshTeamPosWeapon(i)
end
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:refreshTeamPosWeapon(index)
local widget=self.sWeaponWidget[index]
local posData=self.teamData[index]
local weaponID=posData.weapon
if weaponID>0 then
local weaponClient=self.config.treasureClient[weaponID]
local weaponServer=self.config.treasure[weaponID]
local color=weaponServer[6]
local iconName=weaponClient[2]
local star=self.info:getCopyItemStar(weaponID)
widget:SetChildQulaity(_weaponSlotCmp.qualityIcon,color)
widget:SetChildCSImageIcon(_weaponSlotCmp.icon,iconName,false)
widget:SetChildActive(_weaponSlotCmp.starBg,star>0)
widget:SetChildText(_weaponSlotCmp.starTx,star>0 and star or"")
else
widget:SetChildIcon(_weaponSlotCmp.qualityIcon,"",false)
widget:SetChildCSImageIcon(_weaponSlotCmp.icon,"",false)
widget:SetChildActive(_weaponSlotCmp.starBg,false)
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:refreshWeaponBag()
local len=#self.weaponBagDatas
local empty=len<=0
self.weaponViewWidget:SetChildActive(_weaponViewCmp.empty,empty)
self.weaponViewWidget:SetChildActive(_weaponViewCmp.list,not empty)
self.weaponViewWidget:SetChildActive(_weaponViewCmp.pageTx,not empty)

if not empty then
self.copyData:sortWeaponList()
self.weaponBagPageCnt=math.ceil(len/self.weaponViewPageItemCnt)
self.weaponBagPage=self.weaponBagPage or 1
self.weaponBagPage=Mathf.Clamp(self.weaponBagPage,1,self.weaponBagPageCnt)
self:refreshWeaponPageList()
else
self.weaponBagPage=0
self.weaponBagPageCnt=0
self.weaponViewWidget:SetChildActive(_weaponViewCmp.prevBtn,false)
self.weaponViewWidget:SetChildActive(_weaponViewCmp.nextBtn,false)
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:refreshWeaponPageList()
local onLookup=self.info:getTeamLookup_Weapon()
local weaponServer=self.config.treasure
local weaponClient=self.config.treasureClient
for itemIdx=1,self.weaponViewPageItemCnt do
local item=self.weaponViewPageItems[itemIdx-1]
local index=(self.weaponBagPage-1)*self.weaponViewPageItemCnt+itemIdx
local weaponId=self.weaponBagDatas[index]
item:SetChildActive(_weaponBagCmp.widget,weaponId~=nil)
if weaponId then
local clientCfg=weaponClient[weaponId]
local serverCfg=weaponServer[weaponId]
local color=serverCfg[6]
local iconName=clientCfg[2]
local star=self.info:getCopyItemStar(weaponId)
local skillid=serverCfg[2]
local skilllv=serverCfg[3]
local desc=skillModel:getSkillDesc(skillid,skilllv)
local descEx=skillModel:getSkillDescEx(skillid,skilllv)or defaultT
for i,v in ipairs(descEx)do
local str=FMT.fmt('<color=#ffff99>{0}</color>',v)
desc=FMT.fmt('{0}\n{1}',desc,str)
end
desc=comHelper.getCheckLayoutStr(item:GetChildGameObject(_weaponBagCmp.desc2),264,desc,true)
item:SetChildText(_weaponBagCmp.desc,desc)
item:SetChildQulaity(_weaponBagCmp.qualityIcon,color)
item:SetChildCSImageIcon(_weaponBagCmp.icon,iconName,false)
item:SetChildActive(_weaponBagCmp.starBg,star>0)
item:SetChildText(_weaponBagCmp.starTx,star>0 and star or"")
item:SetChildButtonClick(_weaponBagCmp.widget,function()
self:onClickWeaponBagItem(index)
end)
item:SetChildUIDragEvent(_weaponBagCmp.widget,index,
function(...)self:onBagWeaponBeginDrag(...)end,
function(...)self:onBagWeaponEndDrag(...)end,
function(...)self:onBagWeaponDrag(...)end)
item:SetChildLongTouch(_weaponBagCmp.widget,index,1,function(...)
self:onLongTouchWeaponBagItem(...)
end)
local pos=onLookup[weaponId]
item:SetChildActive(_weaponBagCmp.headBg,pos~=nil)
if pos then
local discipleId=self.teamData[pos].disciple
local discipleServer=self.config.disciple[discipleId]
local dColor=discipleServer[5]
local inside=self.config.discipleInside[discipleId]
local modelParams={
body=inside[1],
componets=inside[2]or defaultT,
}
comHelper.setChildModelHeadIconBGByColor(item,_weaponBagCmp.headBg,dColor)
comHelper.setChildModelRawImageEx(_weaponBagCmp.head,item,modelParams,eHeadCenterType.eHead)
end
end
end
self.weaponViewWidget:SetChildText(_weaponViewCmp.pageTx,FMT.fmt("{0} / {1}",self.weaponBagPage,self.weaponBagPageCnt))
self.weaponViewWidget:SetChildActive(_weaponViewCmp.prevBtn,self.weaponBagPage>1)
self.weaponViewWidget:SetChildActive(_weaponViewCmp.nextBtn,self.weaponBagPage<self.weaponBagPageCnt)
end

function UISubAct_ChiSeJinDi_CopyMainWin:onLongTouchWeaponBagItem(index)
if self.dragWeaponId~=nil then return end
local weapon=self.weaponBagDatas[index]
local args={
itemid=weapon,
funType=TIPS_FUNC_TYPE.eChiSeJinDiWeapon,
attach={
actId=self.actId,
subType=self.subType,
subId=self.subId,
}
}
tipsManager.showTips(args)
end

function UISubAct_ChiSeJinDi_CopyMainWin:refreshWeaponBagItemOwner(indexList)
local lookup=self.info:getTeamLookup_Weapon()
for idx,itemIdx in ipairs(indexList)do
local index=(self.weaponBagPage-1)*self.weaponViewPageItemCnt+itemIdx
local weaponId=self.weaponBagDatas[index]
local item=self.weaponViewPageItems[itemIdx-1]
if weaponId and item then
local pos=lookup[weaponId]
item:SetChildActive(_weaponBagCmp.headBg,pos~=nil)
if pos then
local discipleId=self.teamData[pos].disciple
local discipleServer=self.config.disciple[discipleId]
local dColor=discipleServer[5]
local inside=self.config.discipleInside[discipleId]
local modelParams={
body=inside[1],
componets=inside[2]or defaultT,
}
comHelper.setChildModelHeadIconBGByColor(item,_weaponBagCmp.headBg,dColor)
comHelper.setChildModelRawImageEx(_weaponBagCmp.head,item,modelParams,eHeadCenterType.eHead)
end
end
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:refreshWeaponBagItemOwnerEx(weapons)
local lookup=self.info:getTeamLookup_Weapon()
for itemIdx=1,self.weaponViewPageItemCnt do
local index=(self.weaponBagPage-1)*self.weaponViewPageItemCnt+itemIdx
local weaponId=self.weaponBagDatas[index]
if weaponId and table.containsValue(weapons,weaponId)then
local item=self.weaponViewPageItems[itemIdx-1]
local pos=lookup[weaponId]
item:SetChildActive(_weaponBagCmp.headBg,pos~=nil)
if pos then
local discipleId=self.teamData[pos].disciple
local discipleServer=self.config.disciple[discipleId]
local dColor=discipleServer[5]
local inside=self.config.discipleInside[discipleId]
local modelParams={
body=inside[1],
componets=inside[2]or defaultT,
}
comHelper.setChildModelHeadIconBGByColor(item,_weaponBagCmp.headBg,dColor)
comHelper.setChildModelRawImageEx(_weaponBagCmp.head,item,modelParams,eHeadCenterType.eHead)
end
end
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:onClickWeaponBagItem(index)
local weaponId=self.weaponBagDatas[index]
local lookup=self.info:getTeamLookup_Weapon()
local pos=lookup[weaponId]
if pos then
self.info:weaponTeamOff(pos)
self.info:saveTeam()
self:refreshTeamPosWeapon(pos)
self:refreshWeaponBagItemOwnerEx({weaponId})
self:refreshWeaponBtnReddot()
return
end

for i,v in ipairs(self.teamData)do
if v.disciple>0 and v.weapon<=0 then

self.info:weaponTeamOn(i,weaponId)
self.info:saveTeam()
self:refreshTeamPosWeapon(i)
self:refreshWeaponBagItemOwnerEx({weaponId})
self:refreshWeaponBtnReddot()
return
end
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:animationRandomView(callback)
self.animation=true

local roundData=self.copyData.roundData
local viewWidget=self.randomView:getChildWidgetBase()
local sHeadInfo=playerModel:getActorIconInfo()
local tHeadInfo=roundData.iconInfo
local nameLib=self.config.npcNames
local rIndex=math.random(1,#nameLib)
local nameItem=nameLib[rIndex]
local nameStr=nameItem[1]
local nameAnim=nameItem[2]

local audioHandleId=nil
local sequence=Lua.SequenceProxy.New()
local modelTweens,shadowTweens=self:refreshFightRoot()
sequence:AppendInterval(1)
sequence:AppendCallback(function()
audioHandleId=AudioManager.playAudio(666)
self.randomView:setActive(true)
viewWidget:SetChildModelAnimationState(_randomViewCmp.randomModel,nameAnim,1)
end)
sequence:AppendInterval(5)
sequence:AppendCallback(function()
if audioHandleId then
AudioManager.fadeOutStopAudioById(audioHandleId,1,false)
end
self.randomView:setActive(false)
self.fightRoot:setActive(true)
self.fightBtn:setActive(true)
self:setEnemyFlagKnown(nameStr)
self.eventModel:setActive(false)
self.eventShadow:setActive(false)
end)
for i,v in pairs(modelTweens)do
sequence:Join(v)
end
for i,v in pairs(shadowTweens)do
sequence:Join(v)
end
sequence:AppendCallback(function()
local widget=self.fightRoot:getChildWidgetBase()
for pos,tween in pairs(modelTweens)do
local cmp=_fightRootCmp.tModel[pos]
widget:SetChildModelAnimationState(cmp,eAnimationID.stand,1)
end
self.animation=false

local funcName=self.config.guide[eChiSeJinDiGuideType.FightTrigger]
funcName=NEWBIE_LUA_FUNC_NAME[funcName]
if funcName then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,funcName)
end

if callback then callback()end
end)
self:setDoTween(_tweenerType.randomView,sequence)
end

function UISubAct_ChiSeJinDi_CopyMainWin:refreshFightRoot()
local widget=self.fightRoot:getChildWidgetBase()
local roundData=self.copyData.roundData
local fightList=roundData.fightList
local tweeners1={}
local tweeners2={}
for pos,fightData in ipairs(fightList)do
local cmp=_fightRootCmp.tModel[pos]
local cmpShadow=_fightRootCmp.tShadow[pos]
local disciple=fightData.param_1
if disciple>0 then
local discipleServer=self.config.disciple[disciple]
if discipleServer==nil then
loggerUtil.logErrFMT("不存在弟子配置：{0}，{1}",pos,disciple)
widget:SetChildUIModelRemoveTarget(cmp)
widget:SetChildActive(cmpShadow,false)
else
local monsterId=discipleServer[1]
local monsterCfg=cfgHelper.get1(cfg_monsterconfig_get,monsterId)
local modelParams=monsterCfg.modelid
local modelPos1=widget:GetChildAnchoredPosition(cmp)
local modelPos2=modelPos1+Vector2.right*800
local shadowPos1=widget:GetChildAnchoredPosition(cmpShadow)
local shadowPos2=shadowPos1+Vector2.right*800
widget:SetChildUIModelShowTarget(cmp,modelParams[1],_modelScale,modelParams[2]or defaultT,eAnimationID.stand,false,false,0)
widget:SetChildActive(cmpShadow,true)
widget:SetChildModelAnimationState(cmp,eAnimationID.run,1)
widget:SetChildAnchoredPosition(cmp,modelPos2)
widget:SetChildAnchoredPosition(cmpShadow,shadowPos2)
tweeners1[pos]=widget:SetChildDOAnchorPos(cmp,modelPos1,2)
tweeners1[pos]:SetEase(DG.Tweening.Ease.Linear)
tweeners2[pos]=widget:SetChildDOAnchorPos(cmpShadow,shadowPos1,2)
tweeners2[pos]:SetEase(DG.Tweening.Ease.Linear)
end
else
widget:SetChildUIModelRemoveTarget(cmp)
widget:SetChildActive(cmpShadow,false)
end
end
return tweeners1,tweeners2
end

function UISubAct_ChiSeJinDi_CopyMainWin:onClickFightModel(index)
local roundData=self.copyData.roundData
local fightList=roundData.fightList

if fightList[index].param_1<=0 then
return
end

local roleList={}
local select=nil
for pos,fightData in ipairs(fightList)do
local disciple=fightData.param_1
local weapon=fightData.param_2
if disciple>0 then
local discipleServer=self.config.disciple[disciple]
if discipleServer~=nil then
weapon=weapon>0 and weapon or nil
if weapon and self.config.treasure[weapon]==nil then
loggerUtil.logErrFMT("不存在武器配置：{0}，{1}",pos,weapon)
weapon=nil
end
table.insert(roleList,{disciple=disciple,weapon=weapon})
if index==pos then
select=#roleList
end
else
loggerUtil.logErrFMT("不存在弟子配置：{0}，{1}",pos,disciple)
end
end
end
local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
roleList=roleList,
index=select,
parentWin=self,
}
self:showWindow("UISubAct_ChiSeJinDi_CopyDiscipleDetailWin",args)
end

function UISubAct_ChiSeJinDi_CopyMainWin:onClickTeamWeapon(index)
local posData=self.teamData[index]
if posData.weapon>0 then
local weapon=posData.weapon
self.info:weaponTeamOff(index)
self.info:saveTeam()
self:refreshTeamPosWeapon(index)
self:refreshWeaponBtnReddot()
self:refreshWeaponBagItemOwnerEx({weapon})
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:checkAutoTeamOnRefresh(index)
local roundData=self.copyData.roundData
local roundType=roundData.roundtype
if roundType==eChiSeJinDiRoundType.Disciple then
local discipleId=roundData.list[index].param_1
local lookup=self.info:getTeamLookup_Disciple()
local pos=lookup[discipleId]
if pos then
self:refreshTeamDiscipleItem(pos)
end
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:checkStarUpRefresh()
local cache=self.info:getStarUpCache()
local discipleLookup=self.info:getTeamLookup_Disciple()
local weaponLookup=self.info:getTeamLookup_Weapon()
for index,data in ipairs(cache)do
if data.roundType==eChiSeJinDiRoundType.Disciple then
local pos=discipleLookup[data.newID]
if pos then
self:refreshTeamDiscipleItem(pos)
end
if self._vState==_eViewState.eDiscipleBag then
self:refreshDiscipleBag()
if self.dragDiscipleId==data.oldID then
self.dragDiscipleId=data.newID
self:refreshDragDisciple(data.newID)
end
end
elseif data.roundType==eChiSeJinDiRoundType.Weapon then
if self._vState==_eViewState.eWeaponBag then
local pos=weaponLookup[data.newID]
if pos then
self:refreshTeamPosWeapon(pos)
end
self:refreshWeaponBag()
if self.dragWeaponId==data.oldID then
self.dragWeaponId=data.newID
self:refreshDragWeapon(data.newID)
end
end
end
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:nextStarUp()
local starUp=self.info:popStarUp()
if starUp then
local winName=_starUpWinName[starUp.roundType]
if winName then
local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
oldID=starUp.oldID,
newID=starUp.newID,
callback=function()
self:closeWindow(winName)
self:nextStarUp()
end
}
self:showWindow(winName,args)
else
self:nextStarUp()
end
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:discipleViewEnter()
self.animation=true
local sequence=Lua.SequenceProxy.New()
self.discipleView:setChildAnchoredPos(464,14)
self.posTips:setChildCanvasGroupAlpha(0)
local tween0=self.discipleView:setChildDOAnchorPosX(-19.5,0.25)
sequence:Join(tween0)
local tween1=self.posTips:setChildCanvasGroupDOFade(1,0.25)
sequence:Join(tween1)
for i,v in ipairs(self.sModelWidget)do
v:SetChildCanvasGroupAlpha(_discipleSlotCmp.slot,0)
local tween=v:SetChildCanvasGroupDOFade(_discipleSlotCmp.slot,1,0.25)
sequence:Join(tween)
end
sequence:AppendCallback(function()
self.animation=nil
end)
self:setDoTween(_tweenerType.discipleView,sequence)
end

function UISubAct_ChiSeJinDi_CopyMainWin:discipleViewExit(callback)
self.animation=true
local sequence=Lua.SequenceProxy.New()
self.discipleView:setChildAnchoredPos(-19.5,14)
self.posTips:setChildCanvasGroupAlpha(1)
local tween0=self.discipleView:setChildDOAnchorPosX(464,0.25)
sequence:Join(tween0)
local tween1=self.posTips:setChildCanvasGroupDOFade(0,0.25)
sequence:Join(tween1)
for i,v in ipairs(self.sModelWidget)do
v:SetChildCanvasGroupAlpha(_discipleSlotCmp.slot,1)
local tween=v:SetChildCanvasGroupDOFade(_discipleSlotCmp.slot,0,0.25)
sequence:Join(tween)
end
sequence:AppendCallback(function()
callback()
self.animation=nil
end)
self:setDoTween(_tweenerType.discipleView,sequence)
end

function UISubAct_ChiSeJinDi_CopyMainWin:weaponViewEnter()
self.animation=true
local sequence=Lua.SequenceProxy.New()
self.weaponView:setChildAnchoredPos(464,14)
local tween0=self.weaponView:setChildDOAnchorPosX(-19.5,0.25)
sequence:Join(tween0)
for i,v in ipairs(self.sModelWidget)do
v:SetChildCanvasGroupAlpha(_discipleSlotCmp.weapon,0)
local tween=v:SetChildCanvasGroupDOFade(_discipleSlotCmp.weapon,1,0.25)
sequence:Join(tween)
end
sequence:AppendCallback(function()
self.animation=nil
end)
self:setDoTween(_tweenerType.weaponView,sequence)
end

function UISubAct_ChiSeJinDi_CopyMainWin:weaponViewExit(callback)
self.animation=true
local sequence=Lua.SequenceProxy.New()
self.weaponView:setChildAnchoredPos(-19.5,14)
local tween0=self.weaponView:setChildDOAnchorPosX(464,0.25)
sequence:Join(tween0)
for i,v in ipairs(self.sModelWidget)do
v:SetChildCanvasGroupAlpha(_discipleSlotCmp.weapon,1)
local tween=v:SetChildCanvasGroupDOFade(_discipleSlotCmp.weapon,0,0.25)
sequence:Join(tween)
end
sequence:AppendCallback(function()
callback()
self.animation=nil
end)
self:setDoTween(_tweenerType.weaponView,sequence)
end

function UISubAct_ChiSeJinDi_CopyMainWin:refreshDiscipleBtnReddot()
local lookup=self.info:getTeamLookup_Disciple()
local onCnt=0
local offCnt=0
for i,v in ipairs(self.discipleBagDatas)do
if lookup[v]then
onCnt=onCnt+1
else
offCnt=offCnt+1
if onCnt>=fightPreSelectModel.maxPosNum then
break
end
end
end
local reddot=onCnt<fightPreSelectModel.maxPosNum and offCnt>0
self.discipleReddot:setActive(reddot)
end

function UISubAct_ChiSeJinDi_CopyMainWin:refreshWeaponBtnReddot()
local discipleLookup=self.info:getTeamLookup_Disciple()
local empty=false
for discipleID,pos in pairs(discipleLookup)do
local posData=self.teamData[pos]
if posData.weapon<=0 then
empty=true
break
end
end
if not empty then
self.weaponReddot:setActive(false)
return
end
local weaponLookup=self.info:getTeamLookup_Weapon()
for i,v in ipairs(self.weaponBagDatas)do
if weaponLookup[v]==nil then
self.weaponReddot:setActive(true)
return
end
end
self.weaponReddot:setActive(false)
end

function UISubAct_ChiSeJinDi_CopyMainWin:flowMoney(num)
if num and num>0 then
self.moneyFlowTx:setText(FMT.fmt("+{0}",num))
self.moneyFlow:setChildAnchoredPos(0,0)
self.moneyFlow:setChildCanvasGroupAlpha(1)
self.winlua:ForceLayoutRect(self.moneyFlow:getID())
local sequence=Lua.SequenceProxy.New()
local tweener1=self.moneyFlow:setChildCanvasGroupDOFade(0,1)
local tweener2=self.moneyFlow:setChildDOAnchorPosY(50,1)
sequence:Join(tweener1)
sequence:Join(tweener2)
sequence:AppendCallback(function()
self:refreshMoney()
end)
self:setDoTween(_tweenerType.flowMoney,sequence)
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:checkAutoRun()
if self.autoRun then
self.autoRun=nil
if not self:onGoBtn()then
self.goBtn:setActive(true)
end
return true
end
return false
end

function UISubAct_ChiSeJinDi_CopyMainWin:weaponRoundEnter(param,callback)
local strLib=self.config.treasureBuySpeak[1]
local r=math.random(1,#strLib)
local word=strLib[r]
local round=self.copyData.round
local onFinish=function()
if callback then callback()end
local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
parentWin=self,
callback=function(buyed)
if not self.autoRun then
self.autoRun=true
self:closeWindow("UISubAct_ChiSeJinDi_CopyWeaponBuyWin")
self:changeRoundState(_eRoundState.eNone,{buyed=buyed},function()
if round~=self.copyData.round then
self:refreshMoney()
self:refreshRound()
self:changeRoundState(_eRoundState.eIdle)
self:checkAutoRun()
end
end)
call_activitiesHandle_func("activitiesHandle_chisejindi","reqNextCopyRound",self.actId,self.subId)
end
end,
}
self:showWindow("UISubAct_ChiSeJinDi_CopyWeaponBuyWin",args)
end

AudioManager.playAudio(663)
self.animation=true
local sequence=Lua.SequenceProxy.New()
self.eventHUDWidget:SetChildText(_eventHUDCmp.speakTx,word)
self.eventHUDWidget:SetChildScale(_eventHUDCmp.speak,Vector3.zero)
self.eventHUDWidget:SetChildActive(_eventHUDCmp.speak,true)
self.eventHUDWidget:ForceLayoutRect(_eventHUDCmp.speak)
local tweener1=self.eventHUDWidget:SetChildDOScale(_eventHUDCmp.speak,1,0.2)
local tweener2=self.eventHUDWidget:SetChildDOScale(_eventHUDCmp.speak,0,0.2)
sequence:Append(tweener1)
sequence:AppendInterval(2)
sequence:Append(tweener2)
sequence:AppendCallback(function()
self.animation=false
self.eventHUDWidget:SetChildActive(_eventHUDCmp.speak,false)
onFinish()
end)
self:setDoTween(_tweenerType.weaponRound,sequence)
end

function UISubAct_ChiSeJinDi_CopyMainWin:weaponRoundExit(param,callback)
local col=(param and param.buyed)and 2 or 3
local strLib=self.config.treasureBuySpeak[col]
local r=math.random(1,#strLib)
local word=strLib[r]
local effectCfg=cfgHelper.get1(cfg_effectconfig_get,3)
local effectDuration=effectCfg.lifetime/1000
local sequence=Lua.SequenceProxy.New()
self.eventHUDWidget:SetChildText(_eventHUDCmp.speakTx,word)
self.eventHUDWidget:SetChildScale(_eventHUDCmp.speak,Vector3.zero)
self.eventHUDWidget:SetChildActive(_eventHUDCmp.speak,true)
self.eventHUDWidget:ForceLayoutRect(_eventHUDCmp.speak)
local tweener1=self.eventHUDWidget:SetChildDOScale(_eventHUDCmp.speak,1,0.2)
local tweener2=self.eventHUDWidget:SetChildDOScale(_eventHUDCmp.speak,0,0.2)
local tweener3=self.eventModel:setChildCanvasGroupDOFade(0,effectDuration)
sequence:Append(tweener1)
sequence:AppendInterval(2)
sequence:Append(tweener2)
sequence:AppendCallback(function()
self.eventHUDWidget:SetChildActive(_eventHUDCmp.speak,false)
self.eventEffect:setChildShowEffect(_smokeEffect,true)
self.eventEffect:setScale(Vector3.one*50)
end)
sequence:Append(tweener3)
sequence:AppendCallback(function()
self.animation=false
self.eventEffect:setScale(Vector3.one)
if callback then callback()end
end)
self:setDoTween(_tweenerType.weaponRound,sequence)
end

function UISubAct_ChiSeJinDi_CopyMainWin:rewardRoundAnimation(param,callback)
AudioManager.playAudio(662)
self.animation=true
local num=self.copyData.roundData.chance
local word=FMT.fmt("+{0}",num)
local pic={
iconName=iconHelper.getIconName(self.config.chanceMoney),
}
local effectCfg=cfgHelper.get1(cfg_effectconfig_get,3)
local effectDuration=effectCfg.lifetime/1000

local sequence=Lua.SequenceProxy.New()
if pic then
if pic.iconName then
self.eventHUDWidget:SetChildCSImageIcon(_eventHUDCmp.flowIcon,pic.iconName,false)
elseif pic.assetName then
self.eventHUDWidget:SetChildCSImageSprite(_eventHUDCmp.flowIcon,pic.abName,pic.assetName)
end
else
self.eventHUDWidget:SetChildCSImageIcon(_eventHUDCmp.flowIcon,"",false)
end
self.eventHUDWidget:SetChildText(_eventHUDCmp.flowTx,word)
self.eventHUDWidget:SetChildActive(_eventHUDCmp.flow,true)
self.eventHUDWidget:SetChildCanvasGroupAlpha(_eventHUDCmp.flow,1)
self.eventHUDWidget:ForceLayoutRect(_eventHUDCmp.flow)
local tweener1=self.eventHUDWidget:SetChildCanvasGroupDOFade(_eventHUDCmp.flow,0,1)
local tweener2=self.eventHUDWidget:SetChildDOAnchorPosY(_eventHUDCmp.flow,75,1)
local tweener3=self.eventModel:setChildCanvasGroupDOFade(0,effectDuration)
sequence:Join(tweener1)
sequence:Join(tweener2)
sequence:AppendCallback(function()
self.eventHUDWidget:SetChildActive(_eventHUDCmp.flow,false)
self.eventEffect:setScale(Vector3.one*50)
self.eventEffect:setChildShowEffect(_smokeEffect,true)
end)
sequence:Append(tweener3)
sequence:AppendCallback(function()
self.animation=false
self.eventEffect:setScale(Vector3.one)
call_activitiesHandle_func("activitiesHandle_chisejindi","reqNextCopyRound",self.actId,self.subId)
if callback then
callback()
end
end)
self:setDoTween(_tweenerType.rewardRound,sequence)
end

function UISubAct_ChiSeJinDi_CopyMainWin:setDoTween(index,tweener)
self:cleanDoTween(index,true)
self.tweeners[index]=tweener
end

function UISubAct_ChiSeJinDi_CopyMainWin:cleanDoTween(index,complete)
local tweener=self.tweeners[index]
if tweener and tweener:IsActive()then
tweener:Kill(complete)
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:killAllDoTween()
for i,v in pairs(self.tweeners)do
if v:IsActive()then
v:Kill()
end
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:refreshBackBtn()
self.backButton:setActive(self._vState==_eViewState.eNone)
end

function UISubAct_ChiSeJinDi_CopyMainWin:startUpdateTick()
if not self.updateTick then
self.updateTick=self:setTimer(1,0,function()
self:checkUpdateTick()
end)
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:checkUpdateTick()
if self.info:checkInResultRankTime()then
self:quitCopy()
UIManager.info("结算开始，0点后可再进入")
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:stopUpdateTick()
if self.updateTick then
self:stopTimerByID(self.updateTick)
self.updateTick=nil
end
end

function UISubAct_ChiSeJinDi_CopyMainWin:showBottomTips()
self.tipsPanel:setScale(self.showTips and Vector3.one or Vector3.zero)
end

function UISubAct_ChiSeJinDi_CopyMainWin:refreshPreview()
self.preview:setActive(self.showPreview)
if self.showPreview then
local templateCfg=cfgHelper.get1(cfg_chisejindiroundconfig_get,self.copyData.template)
local iconCnt=#templateCfg
local isHidden=self.copyData.roundData.roundtype==eChiSeJinDiRoundType.Hidden

if isHidden then
iconCnt=iconCnt+1
end
self.previewWidget:SetChildLayoutGroupCreateItems(_previewCmp.iconList,iconCnt,function(index)
local item=self.previewWidget:GetChildLayoutGroupGridItem(_previewCmp.iconList,index-1)
local cfg=templateCfg[index]
local type=cfg and cfg.params[1]or eChiSeJinDiRoundType.Hidden
item:SetChildCSImageSprite(0,_abName,"image_chiseshilian_pz"..type)
item.gameObject.name=tostring(index)
end)
self.previewWidget:ForceLayoutRect(_previewCmp.iconList)
local width=self.previewWidget:GetChildSizeDeltaX(_previewCmp.iconList)
self.previewWidget:SetChildSizeDelta(_previewCmp.bg,width,25)

local round=self.copyData.round
if isHidden then
round=round+1
end
local temp=self._rState==_eRoundState.eIdle and 2 or 1
local posX=((round-temp)*100+25)*-1
self.previewWidget:SetChildAnchoredPos(_previewCmp.bg,posX,0)
self.previewWidget:SetChildAnchoredPos(_previewCmp.iconList,posX,0)
end
end