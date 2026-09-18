







def_class("UIWDCQPreGameWin",UIWindowBase)









function UIWDCQPreGameWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.selectTab_1=UIObject.get(self,1)
self.selectTab_2=UIObject.get(self,2)
self.selectTab_3=UIObject.get(self,3)
self.roleListPanel=UILoopListView.new(self,4)
self.selectRoleListPanel=UIObject.get(self,5)
self.selectFightDZRoot=UIObject.get(self,6)
self.sureBtn=UIButton.get(self,7)
self.banDZRoot=UIObject.get(self,8)
self.adjustTeamRoot=UIObject.get(self,9)
self.dzLayout=UIObject.get(self,10)
self.banItem_1=UIObject.get(self,11)
self.banItem_2=UIObject.get(self,12)
self.banSureBtn=UIButton.get(self,13)
self.playerA=UIObject.get(self,14)
self.playerB=UIObject.get(self,15)
self.dataSureBtn=UIButton.get(self,16)
self.fightIconList=UIObject.get(self,17)
self.fightIcon_1=UIButton.get(self,18)
self.fightIcon_3=UIButton.get(self,19)
self.fightIcon_2=UIButton.get(self,20)
self.replayIconList=UIObject.get(self,21)
self.replayIcon_1=UIButton.get(self,22)
self.replayIcon_2=UIButton.get(self,23)
self.replayIcon_3=UIButton.get(self,24)
self.coolDownList=UIObject.get(self,25)
self.coolDown_1=UIText.get(self,26)
self.coolDown_2=UIText.get(self,27)
self.coolDown_3=UIText.get(self,28)
self.coolDown_4=UIText.get(self,29)
self.coolDown_5=UIText.get(self,30)
self.coolDown_6=UIText.get(self,31)
self.teamItem_1=UIObject.get(self,32)
self.teamItem_2=UIObject.get(self,33)
self.teamItem_3=UIObject.get(self,34)
self.teamItem_4=UIObject.get(self,35)
self.teamItem_5=UIObject.get(self,36)
self.teamItem_6=UIObject.get(self,37)
self.stageTitle=UIImage.get(self,38)
self.roundTitle=UIImage.get(self,39)
self.selectCntTxt=UIText.get(self,40)
self.yusheTeamBtn=UIButton.get(self,41)
self.noneIconList=UIObject.get(self,42)
self.noneIcon_1=UIObject.get(self,43)
self.noneIcon_2=UIObject.get(self,44)
self.noneIcon_3=UIObject.get(self,45)
self.subbgList=UIObject.get(self,46)
self.subbg_1=UIObject.get(self,47)
self.subbg_2=UIObject.get(self,48)
self.subbg_3=UIObject.get(self,49)
self.coolDownRoot_1=UIObject.get(self,50)
self.coolDownRoot_2=UIObject.get(self,51)
self.coolDownRoot_3=UIObject.get(self,52)
self.coolDownRoot_4=UIObject.get(self,53)
self.coolDownRoot_5=UIObject.get(self,54)
self.coolDownRoot_6=UIObject.get(self,55)
self.bottomRoot=UIObject.get(self,56)
self.resulttxt=UIText.get(self,57)
self.helpBtn=UIButton.get(self,58)
self.empty=UIObject.get(self,59)
self.baohuBtn=UIButton.get(self,60)
self.baohuBtnTxt=UIText.get(self,61)
self.baohuMask=UIObject.get(self,62)
self.adjusttip=UIObject.get(self,63)
self.endRoot=UIObject.get(self,64)
self.baohuText=UIText.get(self,65)
self.slecltTip=UIObject.get(self,66)
self.scrollerView=UIObject.get(self,67)
self.jiantou=UIObject.get(self,68)
self.bottomfightBg=UIObject.get(self,69)
self.animItem=UIButton.get(self,70)
self.Root=UIObject.get(self,71)
self.selectRoleListContent=UIObject.get(self,72)
self.fightDzInfoBtn=UIButton.get(self,73)
self.prepareTipsRoot=UIObject.get(self,74)
self.prepareTips=UIText.get(self,75)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.roleListPanel:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.sureBtn:setButtonClick(function()self:onSureBtn()end)

self.banSureBtn:setButtonClick(function()self:onBanSureBtn()end)

self.dataSureBtn:setButtonClick(function()self:onDataSureBtn()end)

self.fightIcon_1:setButtonClick(function()self:onFightIcon_1()end)

self.fightIcon_3:setButtonClick(function()self:onFightIcon_3()end)

self.fightIcon_2:setButtonClick(function()self:onFightIcon_2()end)

self.replayIcon_1:setButtonClick(function()self:onReplayIcon_1()end)

self.replayIcon_2:setButtonClick(function()self:onReplayIcon_2()end)

self.replayIcon_3:setButtonClick(function()self:onReplayIcon_3()end)

self.yusheTeamBtn:setButtonClick(function()self:onYusheTeamBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.baohuBtn:setButtonClick(function()self:onBaohuBtn()end)

self.animItem:setButtonClick(function()self:onAnimItem()end)

self.fightDzInfoBtn:setButtonClick(function()self:onFightDzInfoBtn()end)
self.selectTab={
self.selectTab_1,
self.selectTab_2,
self.selectTab_3,
}
self.banItem={
self.banItem_1,
self.banItem_2,
}
self.fightIcon={
self.fightIcon_1,
self.fightIcon_2,
self.fightIcon_3,
}
self.replayIcon={
self.replayIcon_1,
self.replayIcon_2,
self.replayIcon_3,
}
self.coolDown={
self.coolDown_1,
self.coolDown_2,
self.coolDown_3,
self.coolDown_4,
self.coolDown_5,
self.coolDown_6,
}
self.teamItem={
self.teamItem_1,
self.teamItem_2,
self.teamItem_3,
self.teamItem_4,
self.teamItem_5,
self.teamItem_6,
}
self.noneIcon={
self.noneIcon_1,
self.noneIcon_2,
self.noneIcon_3,
}
self.subbg={
self.subbg_1,
self.subbg_2,
self.subbg_3,
}
self.coolDownRoot={
self.coolDownRoot_1,
self.coolDownRoot_2,
self.coolDownRoot_3,
self.coolDownRoot_4,
self.coolDownRoot_5,
self.coolDownRoot_6,
}



end


function UIWDCQPreGameWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.selectTab_1);self.selectTab_1=nil;
_UIObject_release(self.selectTab_2);self.selectTab_2=nil;
_UIObject_release(self.selectTab_3);self.selectTab_3=nil;
self.roleListPanel:deleteSelf();self.roleListPanel=nil;
_UIObject_release(self.selectRoleListPanel);self.selectRoleListPanel=nil;
_UIObject_release(self.selectFightDZRoot);self.selectFightDZRoot=nil;
_UIObject_release(self.sureBtn);self.sureBtn=nil;
_UIObject_release(self.banDZRoot);self.banDZRoot=nil;
_UIObject_release(self.adjustTeamRoot);self.adjustTeamRoot=nil;
_UIObject_release(self.dzLayout);self.dzLayout=nil;
_UIObject_release(self.banItem_1);self.banItem_1=nil;
_UIObject_release(self.banItem_2);self.banItem_2=nil;
_UIObject_release(self.banSureBtn);self.banSureBtn=nil;
_UIObject_release(self.playerA);self.playerA=nil;
_UIObject_release(self.playerB);self.playerB=nil;
_UIObject_release(self.dataSureBtn);self.dataSureBtn=nil;
_UIObject_release(self.fightIconList);self.fightIconList=nil;
_UIObject_release(self.fightIcon_1);self.fightIcon_1=nil;
_UIObject_release(self.fightIcon_3);self.fightIcon_3=nil;
_UIObject_release(self.fightIcon_2);self.fightIcon_2=nil;
_UIObject_release(self.replayIconList);self.replayIconList=nil;
_UIObject_release(self.replayIcon_1);self.replayIcon_1=nil;
_UIObject_release(self.replayIcon_2);self.replayIcon_2=nil;
_UIObject_release(self.replayIcon_3);self.replayIcon_3=nil;
_UIObject_release(self.coolDownList);self.coolDownList=nil;
_UIObject_release(self.coolDown_1);self.coolDown_1=nil;
_UIObject_release(self.coolDown_2);self.coolDown_2=nil;
_UIObject_release(self.coolDown_3);self.coolDown_3=nil;
_UIObject_release(self.coolDown_4);self.coolDown_4=nil;
_UIObject_release(self.coolDown_5);self.coolDown_5=nil;
_UIObject_release(self.coolDown_6);self.coolDown_6=nil;
_UIObject_release(self.teamItem_1);self.teamItem_1=nil;
_UIObject_release(self.teamItem_2);self.teamItem_2=nil;
_UIObject_release(self.teamItem_3);self.teamItem_3=nil;
_UIObject_release(self.teamItem_4);self.teamItem_4=nil;
_UIObject_release(self.teamItem_5);self.teamItem_5=nil;
_UIObject_release(self.teamItem_6);self.teamItem_6=nil;
_UIObject_release(self.stageTitle);self.stageTitle=nil;
_UIObject_release(self.roundTitle);self.roundTitle=nil;
_UIObject_release(self.selectCntTxt);self.selectCntTxt=nil;
_UIObject_release(self.yusheTeamBtn);self.yusheTeamBtn=nil;
_UIObject_release(self.noneIconList);self.noneIconList=nil;
_UIObject_release(self.noneIcon_1);self.noneIcon_1=nil;
_UIObject_release(self.noneIcon_2);self.noneIcon_2=nil;
_UIObject_release(self.noneIcon_3);self.noneIcon_3=nil;
_UIObject_release(self.subbgList);self.subbgList=nil;
_UIObject_release(self.subbg_1);self.subbg_1=nil;
_UIObject_release(self.subbg_2);self.subbg_2=nil;
_UIObject_release(self.subbg_3);self.subbg_3=nil;
_UIObject_release(self.coolDownRoot_1);self.coolDownRoot_1=nil;
_UIObject_release(self.coolDownRoot_2);self.coolDownRoot_2=nil;
_UIObject_release(self.coolDownRoot_3);self.coolDownRoot_3=nil;
_UIObject_release(self.coolDownRoot_4);self.coolDownRoot_4=nil;
_UIObject_release(self.coolDownRoot_5);self.coolDownRoot_5=nil;
_UIObject_release(self.coolDownRoot_6);self.coolDownRoot_6=nil;
_UIObject_release(self.bottomRoot);self.bottomRoot=nil;
_UIObject_release(self.resulttxt);self.resulttxt=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.empty);self.empty=nil;
_UIObject_release(self.baohuBtn);self.baohuBtn=nil;
_UIObject_release(self.baohuBtnTxt);self.baohuBtnTxt=nil;
_UIObject_release(self.baohuMask);self.baohuMask=nil;
_UIObject_release(self.adjusttip);self.adjusttip=nil;
_UIObject_release(self.endRoot);self.endRoot=nil;
_UIObject_release(self.baohuText);self.baohuText=nil;
_UIObject_release(self.slecltTip);self.slecltTip=nil;
_UIObject_release(self.scrollerView);self.scrollerView=nil;
_UIObject_release(self.jiantou);self.jiantou=nil;
_UIObject_release(self.bottomfightBg);self.bottomfightBg=nil;
_UIObject_release(self.animItem);self.animItem=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.selectRoleListContent);self.selectRoleListContent=nil;
_UIObject_release(self.fightDzInfoBtn);self.fightDzInfoBtn=nil;
_UIObject_release(self.prepareTipsRoot);self.prepareTipsRoot=nil;
_UIObject_release(self.prepareTips);self.prepareTips=nil;
self.selectTab=nil;
self.banItem=nil;
self.fightIcon=nil;
self.replayIcon=nil;
self.coolDown=nil;
self.teamItem=nil;
self.noneIcon=nil;
self.subbg=nil;
self.coolDownRoot=nil;
end


















local selectTabCmpIndex=
{
bg=0,
finish=1,
curtxt=2,
stageTimeTip=3,
click=4,
select=5,
bgTxt=6,
curShow=7,
}

local dzItemcmp={
wdcqdzItem=0,
back=1,
dis_name=2,
rawImage=3,
dis_job=4,
lv_Obj=5,
dis_level=6,
dis_fight=7,
select=8,
protect=9,
protectEffect=10,
tick=11,
tickEx=12,
xianmoBg=13,
spDzFlag=14,
}

local wdcqBandzItemCmp={
wdcqBandzItem=0,
back=1,
dis_name=2,
rawImage=3,
dis_job=4,
lv_Obj=5,
dis_level=6,
dis_fight=7,
ban=8,
iocnListRoot=9,
iocnList={10,11,12,13,14},
baohu=15,
protectEffect=16,
}

local teamItemCmp={
adjusting=0,
waiting=1,
hss=2,
headSlotList={3,4,5,6,7},
nodztips=8,
lastTips=9,
winFlag=10,
failFlag=11,
adjustingTxt=12,
effect=13,
layout=14,
houpailayout=15,
qianpailayout=16,
houpaioneBg=17,
houpaitwoBg=18,
qianpaipaioneBg=19,
qianpaitwoBg=20,
fightroot=21,
fight=22
}

local playerCmpIndex=
{
modelshow=0,
name=1,
win=2,
detal=3,
sever=4,
selfFlag=5,
loseModel=6,
}

local IconState={
eNone=1,
eFight=2,
eReplay=3,
}
local teamShowState={
eNone=0,
eAjusting=1,
eWaiting=2,
eShowDz=3,
eNoDZ=4,
}
local teamListCfg={
{teamIndex=1,playerIndex=1},
{teamIndex=1,playerIndex=2},
{teamIndex=2,playerIndex=2},
{teamIndex=2,playerIndex=1},
{teamIndex=3,playerIndex=1},
{teamIndex=3,playerIndex=2},
}

local infoItemCmp={
roundTitle=0,
subBg=1,
replayIcon=2,
fightIcon=3,
noData=4,
teamItemL=5,
teamItemR=6,
InfoItem=7,

}

local teamCmp={
hss=0,
headSlotList={1,2,3,4,5},
nodzTip=6,
winFlag=7,
failFlag=8,
houpailayout=9,
qianpailayout=10,
houpaioneBg=11,
houpaitwoBg=12,
qianpaipaioneBg=13,
qianpaitwoBg=14,
fightroot=15,
fight=16
}

local col=4
local abName="ui/windows/wendingcangqiong/wdcq_atlas_pak.ab"
local stageTitleAssetNameList={
[WDCQCGameStageEnum.eSixteen]="image_wdcqsqjdwz_4",
[WDCQCGameStageEnum.eEighth]="image_wdcqsqjdwz_5",
[WDCQCGameStageEnum.eFourth]="image_wdcqsqjdwz_6",
[WDCQCGameStageEnum.eSemi]="image_wdcqsqjdwz_7",
[WDCQCGameStageEnum.eThird]="image_wdcqsqjdwz_8",
[WDCQCGameStageEnum.eChampion]="image_wdcqsqjdwz_9",
}

local animTargetPos={
{{x=585,y=-336}},
{{x=521,y=-336},{x=669,y=-336}},
}

function UIWDCQPreGameWin:onLoaded(...)
self:bindComponents()
self.selectTabWidget={}
self.selectRoot={
self.selectFightDZRoot,
self.banDZRoot,
self.adjustTeamRoot,
}
for i,v in ipairs(self.selectTab)do
local widget=v:getChildWidgetBase()
self.selectTabWidget[i]=widget
widget:SetChildButtonClick(selectTabCmpIndex.click,function()

end)
end



self.baohuMode=false
end



function UIWDCQPreGameWin:__delete()
self:stopAnim()
self:unbindComponents()
self:stopAllTimer()
self.selectTabWidget=nil
self.selectRoot=nil
self.initScroll=nil
self.baohuMode=false
self.baohuDataList=nil
self.selectRoleDataList=nil
self.banDataList=nil
self.topItemList=nil
self.baohuItemList=nil

if self.prepareTipTweener~=nil then
self.prepareTipTweener:Complete()
self.prepareTipTweener:Kill()
self.prepareTipTweener=nil
end
end




function UIWDCQPreGameWin:onShow(argtable,afterOnloaded)
if argtable and argtable.showPreWin then
loadingControl.closeCloud()
end


self.closeCallBack=argtable and argtable.closeCallBack or self.closeCallBack
self.selectGroupId=argtable and argtable.groupId or self.selectGroupId
self.selectStageId=argtable and argtable.stageId or self.selectStageId
self.subGoupId=argtable and argtable.subGoupId or self.subGoupId
self.actorId=playerModel:getActorID()
local gameInfo=WDCQController.getActorGameInfo(self.actorId)

if not gameInfo then
self.empty:setActive(true)
self.stageTitle:setActive(false)
self.roundTitle:setActive(false)
return
end
self.empty:setActive(false)
self.groupId=gameInfo.groupId
self.stageId=gameInfo.stageId
self.idx=gameInfo.idx
self.posEnum=gameInfo.posEnum
self.roundCfgTemp=WDCQController.getRoundCfg(self.groupId,self.stageId,self.idx)
self.refreshCode=argtable and argtable.refreshCode or nil







self.otherActorId=gameInfo.rivalActorId
self.reqList={}
WDCQController.req_38_2(self.actorId)
self.reqList[mathHelper.int64_to_string(self.actorId)]=true
if self.otherActorId then
WDCQController.req_38_2(self.otherActorId)
self.reqList[mathHelper.int64_to_string(self.otherActorId)]=true
end


end


function UIWDCQPreGameWin:onHide()
self:stopAnim()
self:stopAllTimer()
self.initScroll=nil
self.baohuMode=false
self.baohuDataList=nil
self.selectRoleDataList=nil
self.banDataList=nil
self.topItemList=nil
self.baohuItemList=nil
self.dzLayout:setChildLayoutGroupClearAllItems()
for i,v in ipairs(self.banItem)do
if self.banMaxCnt and i<=self.banMaxCnt then
v:setActive(true)
local item=v:getWidgetBase()
item:SetChildActive(0,true)
item:SetChildActive(1,false)
else
v:setActive(false)
end
end
if self.prepareTipTweener~=nil then
self.prepareTipTweener:Complete()
self.prepareTipTweener:Kill()
self.prepareTipTweener=nil
end
end

function UIWDCQPreGameWin:onShowArgRecv(argtable)
self:onShow(argtable)
end

function UIWDCQPreGameWin:DataRecv_38_2(actor_id)
self.reqList[mathHelper.int64_to_string(actor_id)]=nil
if next(self.reqList)then
return
end
self:refresh()
end

function UIWDCQPreGameWin:refresh()
self.Root:setChildCanvasGroupAlpha(1)
self.Root:setChildCanvasGroupRaycast(true)
self:checkShowBanWin()
self:refreshTitle()
self:refreshSelectTab()
end

function UIWDCQPreGameWin:checkShowBanWin()
local key=FMT.fmt("{0}_{1}_{2}",self.groupId,self.stageId,self.idx)
local banshowFlagList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eWenDingCangQiong,"banshowFlagList",{})
if banshowFlagList[key]then
return
end
local macthStage,preStage,adjustStage=WDCQController.getMacthStage(self.groupId,self.stageId,self.idx)
if(macthStage>WDCQCMatchStageEnum.ePreTheGame and macthStage<WDCQCMatchStageEnum.eEndTheGame)
or(macthStage==WDCQCMatchStageEnum.ePreTheGame and preStage==WDCQCPreGameStageEnum.eAdjustTeam)
then
banshowFlagList[key]=true
userActorArraySetting.set(ACTOR_SETTING_TYPE.eWenDingCangQiong,"banshowFlagList",banshowFlagList)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eWenDingCangQiong)
local selfSelectDZList=WDCQController.getSelectDZList(self.actorId)
local selfBanDZList=WDCQController.getBanDZList(self.actorId)
local selfbanDataList={}
for i,v in ipairs(selfBanDZList or{})do
for ii,vv in ipairs(selfSelectDZList or{})do
if mathHelper.compareInt64(v,vv.discipleguid)then
table.insert(selfbanDataList,vv)
break
end
end
end
local otherSelectDZList=WDCQController.getSelectDZList(self.otherActorId)
local otherBanDZList=WDCQController.getBanDZList(self.otherActorId)
local otherbanDataList={}
for i,v in ipairs(otherBanDZList or{})do
for ii,vv in ipairs(otherSelectDZList or{})do
if mathHelper.compareInt64(v,vv.discipleguid)then
table.insert(otherbanDataList,vv)
break
end
end
end
local args={}
args.selfBanList=selfbanDataList
args.otherBanList=otherbanDataList
UIManager:showWindow("UIWDCQBanDZShowWin",args)
end

end

function UIWDCQPreGameWin:refreshTitle()
self.stageTitle:setActive(true)
self.roundTitle:setActive(true)
local titleName=stageTitleAssetNameList[self.stageId]
if titleName then
self.stageTitle:setCSImageSprite(abName,titleName)
else
self.stageTitle:setActive(false)
end
local macthStage,preStage,adjustStage=WDCQController.getMacthStage(self.groupId,self.stageId,self.idx)
if macthStage==WDCQCMatchStageEnum.ePreTheGame then
self.roundTitle:setCSImageSprite(abName,"image_wdcqsqjdwz_1")
elseif macthStage==WDCQCMatchStageEnum.eTimeDown or macthStage==WDCQCMatchStageEnum.eInTheGame or macthStage==WDCQCMatchStageEnum.eEndTheGame then
self.roundTitle:setCSImageSprite(abName,"image_wdcqsqjdwz_2")
else
self.roundTitle:setActive(false)
end
end

function UIWDCQPreGameWin:refreshSelectTab()
local macthStage,preStage,adjustStage=WDCQController.getMacthStage(self.groupId,self.stageId,self.idx)
for i,v in ipairs(self.selectTabWidget)do
local widget=v

if macthStage==WDCQCMatchStageEnum.ePreTheGame then
widget:SetChildActive(selectTabCmpIndex.finish,preStage>i)
if(preStage==WDCQCPreGameStageEnum.eSelectDz and i==WDCQCPreGameStageEnum.eSelectDz)
or(preStage==WDCQCPreGameStageEnum.eForbiddenDz and i==WDCQCPreGameStageEnum.eForbiddenDz)
or(preStage==WDCQCPreGameStageEnum.eAdjustTeam and i==WDCQCPreGameStageEnum.eAdjustTeam)
then
widget:SetChildActive(selectTabCmpIndex.curShow,true)
else
widget:SetChildActive(selectTabCmpIndex.curShow,false)
end

elseif macthStage==WDCQCMatchStageEnum.eTimeDown or macthStage==WDCQCMatchStageEnum.eInTheGame or macthStage==WDCQCMatchStageEnum.eEndTheGame then
widget:SetChildActive(selectTabCmpIndex.curShow,false)
widget:SetChildActive(selectTabCmpIndex.finish,true)
else
widget:SetChildActive(selectTabCmpIndex.curShow,false)
widget:SetChildActive(selectTabCmpIndex.finish,false)
end
end
self:stopAllTimer()
self:refreshSelectTabTimer()
self:refreshShowContent()
end

function UIWDCQPreGameWin:refreshSelectTabTimer()
local macthStage,preStage,adjustStage=WDCQController.getMacthStage(self.groupId,self.stageId,self.idx)
if macthStage==WDCQCMatchStageEnum.ePreTheGame and preStage~=WDCQCPreGameStageEnum.eNone then
local func=function()
local widget=self.selectTabWidget[preStage]
local roundCfgTemp=self.roundCfgTemp
local lefTime
local curTime=timeHelper.getServerShortTime()
if preStage==WDCQCPreGameStageEnum.eSelectDz then
lefTime=roundCfgTemp.selectDzEndTime-curTime
elseif preStage==WDCQCPreGameStageEnum.eForbiddenDz then
lefTime=roundCfgTemp.banDzEndTime-curTime
elseif preStage==WDCQCPreGameStageEnum.eAdjustTeam then
lefTime=roundCfgTemp.preEndTime-curTime
end
if lefTime and lefTime>0 then
widget:SetChildActive(selectTabCmpIndex.stageTimeTip,true)
widget:SetChildText(selectTabCmpIndex.stageTimeTip,FMT.fmt("阶段结束：{0}",timeHelper.format_time_stamp3(lefTime)))
else
widget:SetChildActive(selectTabCmpIndex.stageTimeTip,false)
if self.refreshCode~=1 then
self:onShow({refreshCode=1})
end
end
end
if self.refreshCode~=1 then
self.selectTabTimerId=self:setTimer(1,0,func)
end
func()
end
end

function UIWDCQPreGameWin:refreshShowContent()
local macthStage,preStage,adjustStage=WDCQController.getMacthStage(self.groupId,self.stageId,self.idx)
self.selectFightDZRoot:setActive(false)
self.banDZRoot:setActive(false)
self.adjustTeamRoot:setActive(false)
self.bottomRoot:setActive(false)
self.endRoot:setActive(true)
if macthStage==WDCQCMatchStageEnum.eNone or preStage==WDCQCPreGameStageEnum.eNone then



elseif macthStage==WDCQCMatchStageEnum.ePreTheGame then
if preStage==WDCQCPreGameStageEnum.eSelectDz then
self:refresh_SelectDz()
elseif preStage==WDCQCPreGameStageEnum.eForbiddenDz then
self:refresh_ForbiddenDz()
elseif preStage==WDCQCPreGameStageEnum.eAdjustTeam then
self:refresh_AdjustTeam()
end
else
self.adjustTeamRoot:setActive(true)
self.scrollerView:setActive(false)
self:refresh_AdjustTeam()
if macthStage==WDCQCMatchStageEnum.eTimeDown then
self.bottomRoot:setActive(true)
self.bottomfightBg:setActive(true)
local func=function()
local widget=self.selectTabWidget[preStage]
local roundCfgTemp=self.roundCfgTemp
local lefTime
local curTime=timeHelper.getServerShortTime()
lefTime=roundCfgTemp.startTime-curTime
if lefTime and lefTime>0 then
self.resulttxt:setText(FMT.fmt("对战倒计时：{0}",timeHelper.format_time_stamp3(lefTime)))
else
self.resulttxt:setText("")
if self.refreshCode~=2 then
self:onShow({refreshCode=2})
end
end
end

if self.refreshCode~=2 then
self.gameTimeDownTimerTimerId=self:setTimer(1,0,func)
end
func()
elseif macthStage==WDCQCMatchStageEnum.eInTheGame then
self.bottomRoot:setActive(true)
self.bottomfightBg:setActive(true)
self.resulttxt:setText("对战中")













elseif macthStage==WDCQCMatchStageEnum.eEndTheGame then

local stageId=WDCQController.getGroupStage(self.groupId)
if WDCQController.checkActorOut(self.actorId)or stageId==WDCQCGameStageEnum.eGameFinish then
self.bottomRoot:setActive(true)
self.bottomfightBg:setActive(false)
local rankTips=WDCQController.getActorRankName(self.actorId)
self.resulttxt:setText(FMT.fmt("最终名次：{0}",rankTips))
end
self.endRoot:setActive(false)
local fun=function(tempList,extraArgs)
if not self or self.isClose then
return
end
self.extraArgs=extraArgs
self.scrollerView:setActive(true)
self:refreshList(tempList)
end
local args=self:getshowMainArgs()
local fun1=function()
UIFullWenDingCangQiongControl:showMainWin(args)
end
WDCQController:Req_FightReplay(self.groupId,self.stageId,self.idx,false,fun,fun1,true)
end
end
end

function UIWDCQPreGameWin:refreshList(tempList)
if not tempList then
tempList={}
for i=1,3 do
table.insert(tempList,{})
end
end
self.scrollerView:setChildScrollViewCreateGrids(#tempList,1)
local grids=self.scrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local logInfo=tempList[i]
self:refreshLogItem(i,item,logInfo)
end
end

function UIWDCQPreGameWin:refreshLogItem(i,item,logInfo)
local logId=logInfo.logId
item:SetChildActive(infoItemCmp.InfoItem,true)
local str=FMT.fmt("第{0}场",i)
local aFight=0
local dFight=0
if logId then
local lookupInfo=WDCQController:getFightLogIdLookupInfo(logId)
if lookupInfo then
str=FMT.fmt("{0}队-第{1}场",lookupInfo.teamIndex,lookupInfo.fightIndex)
aFight=mathHelper.int64_to_number(lookupInfo.aFight)
dFight=mathHelper.int64_to_number(lookupInfo.dFight)
end
end

item:SetChildText(infoItemCmp.roundTitle,str)
if not logInfo.aInfoImage and not logInfo.dInfoImage then
item:SetChildActive(infoItemCmp.noData,true)
item:SetChildActive(infoItemCmp.subBg,false)
item:SetChildActive(infoItemCmp.replayIcon,false)
item:SetChildActive(infoItemCmp.fightIcon,false)
else
item:SetChildActive(infoItemCmp.noData,false)
item:SetChildActive(infoItemCmp.subBg,true)
if logInfo.aInfoImage and logInfo.dInfoImage then
item:SetChildActive(infoItemCmp.replayIcon,true)
item:SetChildActive(infoItemCmp.fightIcon,false)
else
item:SetChildActive(infoItemCmp.replayIcon,false)
item:SetChildActive(infoItemCmp.fightIcon,true)
end
end

item:SetChildButtonClick(infoItemCmp.replayIcon,function()

self:openFight(logInfo.logId)
end)
local stageInfo=logInfo and logInfo.stageInfo or{}
local teamItemL=item:GetChildWidgetBase(infoItemCmp.teamItemL)
self:setTeamItem(teamItemL,logInfo.aInfoImage,stageInfo[stageInfoTag.leftActorId],aFight)
local teamItemR=item:GetChildWidgetBase(infoItemCmp.teamItemR)
self:setTeamItem(teamItemR,logInfo.dInfoImage,stageInfo[stageInfoTag.rightActorId],dFight)
end

function UIWDCQPreGameWin:getTeamPosInfo_InfoImage(InfoImage)
local qianpaiCnt=0
local houpaiCnt=0
local tempImageList={}
for i,v in ipairs(InfoImage or{})do

tempImageList[v.pos]=v
if v.pos<=2 then
qianpaiCnt=qianpaiCnt+1
end
if v.pos>2 and v.pos<=5 then
houpaiCnt=houpaiCnt+1
end
end
local posInfo={}
posInfo.qianpaiCnt=qianpaiCnt
posInfo.houpaiCnt=houpaiCnt
posInfo.tempImageList=tempImageList
return posInfo
end

function UIWDCQPreGameWin:setTeamItem(item,InfoImage,actorId,fight)
if InfoImage then
item:SetChildActive(-1,true)
item:SetChildActive(teamCmp.hss,true)
item:SetChildActive(teamCmp.nodzTip,false)
item:SetChildActive(teamCmp.winFlag,InfoImage.result)
item:SetChildActive(teamCmp.failFlag,false)
local posInfo=self:getTeamPosInfo_InfoImage(InfoImage)
local qianpaiCnt=posInfo.qianpaiCnt
local houpaiCnt=posInfo.houpaiCnt
local tempImageList=posInfo.tempImageList
item:SetChildActive(teamCmp.qianpailayout,qianpaiCnt>0)
item:SetChildActive(teamCmp.qianpaipaioneBg,qianpaiCnt==1)
item:SetChildActive(teamCmp.qianpaitwoBg,qianpaiCnt>1)
item:SetChildActive(teamCmp.houpailayout,houpaiCnt>0)
item:SetChildActive(teamCmp.houpaioneBg,houpaiCnt==1)
item:SetChildActive(teamCmp.houpaitwoBg,houpaiCnt>1)

for i,v in ipairs(teamCmp.headSlotList)do
local info=tempImageList[i]
if info then
item:SetChildActive(v,true)
local headWidget=item:GetChildWidgetBase(v)
local typo=info.typo
local hp=info.resultHp or 1
if typo==0 then
local image=info.image
local color=mathHelper.compareInt64(actorId,playerModel:getActorID())and image.color or 0
comHelper.setChildModelHeadIconBGByColor(headWidget,0,color)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
headWidget:SetChildCSImageSprite(2,globalABLookup.global,jobicon)
headWidget:SetChildGray(0,hp==0)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(1,headWidget,modelParams,eHeadCenterType.eHead,nil,hp==0)
if mathHelper.compareInt64(actorId,playerModel:getActorID())then
UIDiscipleModel:setDiscipleXianMoHeadImage(headWidget,3,info)
headWidget:SetChildGray(3,hp==0)
end
else
local mCfg=cfgHelper.get(cfg_monsterconfig_get,typo)
if mCfg then
headWidget:SetChildActive(2,false)
headWidget:SetChildCSImageSprite(0,_abName,_bossKuang[mCfg.monType])
comHelper.setChildModelRawImage_monster(headWidget,typo,1,0,eHeadCenterType.eHead,nil,hp==0)
headWidget:SetChildGray(0,hp==0)
end
end
else
item:SetChildActive(v,false)
end
end

item:SetChildActive(teamCmp.fightroot,true)
item:SetChildText(teamCmp.fight,mathHelper.formatNumber3(fight))

else




item:SetChildActive(-1,false)
end
end

function UIWDCQPreGameWin:openFight(logId,log)
local args=self.extraArgs or{}
args.showBattle=true
args.showWinTimes=false
fightModel:setSendExtraArgs(eBattleType.wengdingcangqiong,args)
fightController:send_log_list({logId},args,true,true,1)













































end


function UIWDCQPreGameWin:stopAllTimer()
self:stopGameTimeDownTimer()
self:stopSelectTabTimer()
self:stopAdjustStageTimer()
end

function UIWDCQPreGameWin:stopGameTimeDownTimer()
if self.gameTimeDownTimerTimerId then
self:stopTimerByID(self.gameTimeDownTimerTimerId)
self.gameTimeDownTimerTimerId=nil
end
end

function UIWDCQPreGameWin:stopSelectTabTimer()
if self.selectTabTimerId then
self:stopTimerByID(self.selectTabTimerId)
self.selectTabTimerId=nil
end
end



function UIWDCQPreGameWin:refresh_SelectDz()
self.dataSureBtn:setActive(true)
self.dataSureBtn:setChildAnchoredPos(127.1,-328.4)
self.prepareTipsRoot:setActive(false)
self.selectFightDZRoot:setActive(true)
self.selectFightDZRoot:setChildCanvasGroupAlpha(1)
self.baohuMask:setActive(self.baohuMode)
self.jiantou:setActive(not self.baohuMode)
self.baohuBtnTxt:setText(self.baohuMode and"取消"or"选择保护")
self.helpBtn:setActive(not self.baohuMode)
self.slecltTip:setActive(not self.baohuMode)
local dzlist=discipleLookup:getSortDiscipleListEx(eDiscipleSortType.eFightSort)
self.maxSelectCnt=WDCQController.getSelfSelcetDZMaxCnt()

self.maxBaohuDzCnt=WDCQController.getBaohuDZMaxCnt()
if not self.selectRoleDataList then
local selcetDZGuidList=WDCQController.getSelectDZList(self.actorId)
self.selectRoleDataList={}
for i,v in ipairs(selcetDZGuidList)do
for i2,v2 in ipairs(dzlist)do
local netdata=v2.netData
local netData=netdata.net
local guid=netData.discipleguid
if mathHelper.compareInt64(v.discipleguid,guid)then
table.insert(self.selectRoleDataList,v2)
break
end
end
end
table.sort(self.selectRoleDataList,function(a,b)
local guida=a.netData.net.discipleguid
local guidb=b.netData.net.discipleguid
return UIDiscipleModel:getDiscipleFightValue(guida)>UIDiscipleModel:getDiscipleFightValue(guidb)
end)



end
if not self.baohuDataList or not self.baohuMode then
self.baohuDataList={}
local baohuList=WDCQController.getBaohuDZList(self.actorId)
for i,v in ipairs(baohuList)do
for i2,v2 in ipairs(self.selectRoleDataList)do
local netdata=v2.netData
local netData=netdata.net
local guid=netData.discipleguid
if mathHelper.compareInt64(v,guid)then
table.insert(self.baohuDataList,guid)
break
end
end
end



end

self:initScrollView(dzlist)
self:refreshSelectList()
end

function UIWDCQPreGameWin:initScrollView(dzlist)
if self.initScroll then
return
end
self.initScroll=true
local row=math.ceil(#dzlist/col)
local tempList={}
for i=1,row do
tempList[i]={}
for ii=(i-1)*col+1,i*col do
local roleData=dzlist[ii]
table.insert(tempList[i],roleData)
end
end
self.roleListPanel:initData("roleListItem",tempList)
end

function UIWDCQPreGameWin:refreshSelectList()
self.baohuItemList={}
local dataNum=#self.selectRoleDataList
self.selectCntTxt:setText(FMT.fmt("已选弟子（<color=#549327>{0}</color>/{1}）",dataNum,self.maxSelectCnt))
if self.baohuMode then
self.baohuText:setText(FMT.fmt("可保护：<color=#549327>{0}</color>/{1}",#self.baohuDataList,self.maxBaohuDzCnt))
end
self.sureBtn:setGray(dataNum<1)
self.baohuBtn:setGray(dataNum<1)
self.selectRoleListPanel:setChildScrollViewCreateGrids(dataNum,3)
if dataNum<=0 then
return
end
local grids=self.selectRoleListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local roleData=self.selectRoleDataList[i]
self:refreshRoleItem_Select(item,roleData,i,true)
end
self:onScrollViewChange()
end

function UIWDCQPreGameWin:onFreshAction(index,widget,data)
for i=0,col-1 do
local subwidget=widget:GetChildWidgetBase(i)
local roleData=data[i+1]
if roleData then
subwidget:SetChildActive(dzItemcmp.wdcqdzItem,true)
self:refreshRoleItem_Select(subwidget,roleData,(index-1)*col+1+i)
else
subwidget:SetChildActive(dzItemcmp.wdcqdzItem,false)
end
end
end

function UIWDCQPreGameWin:onStartAction()
end

function UIWDCQPreGameWin:refreshRoleItem_Select(item,roleData,index,isSelectListItem)

local netdata=roleData.netData
local netData=netdata.net
local guid=netData.discipleguid

local color=UIDiscipleModel:getDiscipleColor(guid)
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netData)
item:SetChildCSImageSprite(dzItemcmp.back,abname,iconname)


item:SetChildText(dzItemcmp.dis_name,UIDiscipleModel:getDiscipleName(guid))

comHelper.setChildModelRawImage(item,guid,dzItemcmp.rawImage,0,eHeadCenterType.eHead,nil,false,true)

local jobicon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildCSImageSprite(dzItemcmp.dis_job,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(dzItemcmp.spDzFlag,isSpDz)


item:SetChildCSImageSprite(dzItemcmp.lv_Obj,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])

local lv_str=tostring(netData.jingjielv)
item:SetChildText(dzItemcmp.dis_level,lv_str)

item:SetChildActive(dzItemcmp.dis_fight,true)
item:SetChildText(dzItemcmp.dis_fight,UIDiscipleModel:getDiscipleFightValue(guid))

local func=function()
self:OnClickRoleItemCallback(item,index,roleData)
end
local func1=function()
self:OnClickSelectRoleItemCallback(item,index,roleData)
end
item:SetChildButtonClick(-1,isSelectListItem and func1 or func,true)

if isSelectListItem then
item:SetChildActive(dzItemcmp.select,false)
local baohuFlag,baohuindex=self:checkBaohuFlag(roleData)
if baohuFlag then
item:SetChildActive(dzItemcmp.protect,true)
item:SetChildShowEffect(dzItemcmp.protectEffect,20454,true)
self.baohuItemList[baohuindex]={item,index}
else
item:SetChildActive(dzItemcmp.protect,false)
end
else
local selcetFlag=self:checkSelectFlag(roleData)
item:SetChildActive(dzItemcmp.select,selcetFlag)
item:SetChildActive(dzItemcmp.protect,false)
end

local args=self:getshowMainArgs()
item:SetChildLongTouch(dzItemcmp.wdcqdzItem,index,1,function(...)
local func=function()
args.loading=true
UIFullWenDingCangQiongControl:showMainWin(args)

end
fullScreenUI.setNextActiveUICallback(func)
UIFullDiscipleMainControl:showWindowInfo({dis_guid=guid})
end)
UIDiscipleModel:setDiscipleXianMoBackImage(item,dzItemcmp.xianmoBg,netData)
end

function UIWDCQPreGameWin:refresh_ForbiddenDz()
self.dataSureBtn:setActive(true)
self.dataSureBtn:setChildAnchoredPos(325,-328.4)
self.prepareTipsRoot:setActive(true)
if self.prepareTipTweener==nil then
local tweener=self.prepareTipsRoot:setChildDOLocalMoveY(85,0.6)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Yoyo)
self.prepareTipTweener=tweener
end


self.banDZRoot:setActive(true)
if not self.otherActorId then
return
end
local otherSelectDZList=WDCQController.getSelectDZList(self.otherActorId)
local otherBanDZList=WDCQController.getBanDZList(self.otherActorId)
self.banDataList={}
for i,v in ipairs(otherBanDZList or{})do
for ii,vv in ipairs(otherSelectDZList or{})do
if mathHelper.compareInt64(v,vv.discipleguid)then
table.insert(self.banDataList,vv)
break
end
end
end
self.banMaxCnt=WDCQController.getBanDZMaxCnt()
self.dzLayout:setChildLayoutGroupClearAllItems()




self.topItemList={}
table.sort(otherSelectDZList,function(a,b)
local aV=self:checkOtherbaohuFlag(a)and 1 or 0
local bV=self:checkOtherbaohuFlag(b)and 1 or 0
return aV>bV
end)
self.dzLayout:setChildLayoutGroupCreateItems(#otherSelectDZList,function(index)
local item=self.dzLayout:getChildLayoutGroupGridItem(index-1)
local discipleStruct=otherSelectDZList[index]
self.topItemList[tostring(discipleStruct.discipleguid)]=item
self:refreshRoleItem_Ban(item,discipleStruct,false,index)
end)
self:refreshBanList()
end

function UIWDCQPreGameWin:refreshRoleItem_Ban(item,discipleStruct,isBanListItem,index)
local netdata=discipleStruct
local image=UIDiscipleModel.calculationDiscipleImageBase(netdata)






item:SetChildText(wdcqBandzItemCmp.dis_name,netdata.disciplename)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(wdcqBandzItemCmp.rawImage,item,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
item:SetChildCSImageSprite(wdcqBandzItemCmp.dis_job,globalABLookup.global,jobicon)

local isSpDz=netdata.id and UIDiscipleModel:isSPDisciple(netdata.id)or false
item:SetChildActive(dzItemcmp.spDzFlag,isSpDz)

item:SetChildActive(wdcqBandzItemCmp.lv_Obj,false)

local lv_str=tostring(netdata.jingjielv)
item:SetChildText(wdcqBandzItemCmp.dis_level,lv_str)

item:SetChildActive(wdcqBandzItemCmp.dis_fight,false)


local func=function()
self:OnClickBanDZItemCallback(item,discipleStruct,index)
end
local func1=function()
self:OnClickSelectBanDZItemCallback(item,discipleStruct)
end
item:SetChildButtonClick(-1,isBanListItem and func1 or func,true)

if isBanListItem then
item:SetChildActive(wdcqBandzItemCmp.baohu,false)
item:SetChildActive(wdcqBandzItemCmp.ban,false)
else
local banFlag=self:checkBanFlag(discipleStruct)
item:SetChildActive(wdcqBandzItemCmp.ban,banFlag)
local baohuFlag=self:checkOtherbaohuFlag(discipleStruct)
item:SetChildActive(wdcqBandzItemCmp.baohu,baohuFlag)
item:SetChildActive(wdcqBandzItemCmp.protectEffect,false)
if baohuFlag then
item:SetChildShowEffect(wdcqBandzItemCmp.protectEffect,20454,true)
end
end

local linggenList=self:getDzLinggenList(discipleStruct)
for i,v in ipairs(wdcqBandzItemCmp.iocnList)do
if linggenList[i]then
item:SetChildActive(v,true)
local icon=ELEMENT_TYPE.getIconEx(linggenList[i].element)
item:SetChildCSImageSprite(v,globalABLookup.global,icon)
else
item:SetChildActive(v,false)
end
end
end

function UIWDCQPreGameWin:getDzLinggenList(discipleStruct)
local list={}
for i,v in ipairs(discipleStruct.specialityList)do
if v.specialitytype==DISCIPLE_SPECIALITY_TYPE.eSpiritRoot and v.len>0 then
for ii,vv in ipairs(v.specialityLst)do
local cfg=UIDiscipleModel:getSpecialityConfig(DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,vv.param_1)
table.insert(list,cfg)
end
end
end
return list
end

function UIWDCQPreGameWin:refreshBanList()

for i,v in ipairs(self.banItem)do
if i<=self.banMaxCnt then
v:setActive(true)
local item=v:getWidgetBase()
local discipleStruct=self.banDataList[i]
if discipleStruct then
item:SetChildActive(0,false)
item:SetChildActive(1,true)
local wdcqBandzItem=item:GetChildWidgetBase(1)
self:refreshRoleItem_Ban(wdcqBandzItem,discipleStruct,true)
else
item:SetChildActive(0,true)
item:SetChildActive(1,false)
end
else
v:setActive(false)
end
end
self.banSureBtn:setGray(#self.banDataList<self.banMaxCnt)
end


function UIWDCQPreGameWin:refresh_AdjustTeam()
self.scrollerView:setActive(false)
self.adjustTeamRoot:setActive(true)
self.dataSureBtn:setActive(false)
self:refreshPlayerInfo()

local macthStage,preStage,adjustStage=WDCQController.getMacthStage(self.groupId,self.stageId,self.idx)

if macthStage==WDCQCMatchStageEnum.ePreTheGame then
local isSZDZ=WDCQController.checkActorSZDZ(self.actorId)


self.yusheTeamBtn:setActive(true)

self.adjusttip:setActive(true)

if adjustStage==WDCQCAdjustTeamStageEnum.eFive then

self.coolDownList:setActive(false)
else
self.coolDownList:setActive(true)
for i,v in ipairs(self.coolDownRoot)do
if i==adjustStage then
v:setActive(true)
else
v:setActive(false)
end
end

local func=function()
local roundCfgTemp=self.roundCfgTemp
local curTime=timeHelper.getServerShortTime()
local teamUpTime=roundCfgTemp.teamUpTime
local adjustTimeCfg=teamUpTime[adjustStage]
local lefTime=adjustTimeCfg.teamUpEndTime-curTime

if lefTime and lefTime>0 then
self.coolDown[adjustStage]:setText(FMT.fmt("调整结束：{0}",timeHelper.format_time_stamp3(lefTime)))



else




if self.refreshCode~=adjustStage*10 then
self:onShow({refreshCode=adjustStage*10})
end
end
end
if self.refreshCode~=adjustStage*10 then
self.adjustStageTimerId=self:setTimer(1,0,func)
end
func()
end
else
self.coolDownList:setActive(false)






self.yusheTeamBtn:setActive(false)
self.adjusttip:setActive(false)
end
self.subbgList:setActive(true)
self.noneIconList:setActive(true)
self.fightIconList:setActive(true)
self.replayIconList:setActive(true)
for i=1,3 do
local state=self:getIconState(i,macthStage,adjustStage)
self.noneIcon[i]:setActive(state==IconState.eNone)
self.fightIcon[i]:setActive(state==IconState.eFight)
self.replayIcon[i]:setActive(state==IconState.eReplay)
self.subbg[i]:setActive(state~=IconState.eNone)
end
self:setAdjustTeamListInfo()
end

function UIWDCQPreGameWin:setAdjustTeamListInfo()
local macthStage,preStage,adjustStage=WDCQController.getMacthStage(self.groupId,self.stageId,self.idx)

for i,v in ipairs(self.teamItem)do
local cfg=teamListCfg[i]
local teamIndex=cfg.teamIndex
local playerIndex=cfg.playerIndex
local playerData=WDCQController.getPlayerData(self.groupId,self.stageId,self.idx,playerIndex)
local actorId=playerData.actorId
local showState=self:getTeamShowState(i,macthStage,adjustStage,actorId,teamIndex)
local widget=v:getWidgetBase()
if showState==teamShowState.eNone then
widget:SetChildActive(teamItemCmp.adjusting,false)
widget:SetChildActive(teamItemCmp.adjustingTxt,false)
widget:SetChildActive(teamItemCmp.waiting,false)
widget:SetChildActive(teamItemCmp.layout,false)
widget:SetChildActive(teamItemCmp.nodztips,false)
widget:SetChildActive(teamItemCmp.winFlag,false)
widget:SetChildActive(teamItemCmp.failFlag,false)
widget:SetChildActive(teamItemCmp.lastTips,false)
elseif showState==teamShowState.eAjusting then

widget:SetChildActive(teamItemCmp.adjusting,true)

widget:SetChildAnimationStringID(teamItemCmp.adjusting,"wdcqpre_select")






local flag=WDCQController.checkTeamDZ(actorId,teamIndex)and WDCQController.checkAdjustTeamPos(adjustStage,self.posEnum)and actorId==self.actorId
if flag then

widget:SetChildActive(teamItemCmp.layout,true)
widget:SetChildActive(teamItemCmp.adjustingTxt,false)
widget:SetChildActive(teamItemCmp.lastTips,false)
self:setTeamInfoList(widget,actorId,teamIndex,adjustStage==WDCQCAdjustTeamStageEnum.eFive)
else

widget:SetChildActive(teamItemCmp.layout,false)
if adjustStage==WDCQCAdjustTeamStageEnum.eFive then
if actorId==self.actorId then
widget:SetChildActive(teamItemCmp.adjustingTxt,true)
widget:SetChildActive(teamItemCmp.lastTips,false)
else
widget:SetChildActive(teamItemCmp.lastTips,true)
widget:SetChildActive(teamItemCmp.adjusting,false)
widget:SetChildActive(teamItemCmp.adjustingTxt,false)
end
else
widget:SetChildActive(teamItemCmp.adjustingTxt,true)
widget:SetChildActive(teamItemCmp.lastTips,false)
end
end
widget:SetChildActive(teamItemCmp.waiting,false)
widget:SetChildActive(teamItemCmp.nodztips,false)
widget:SetChildActive(teamItemCmp.winFlag,false)
widget:SetChildActive(teamItemCmp.failFlag,false)
elseif showState==teamShowState.eWaiting then
widget:SetChildActive(teamItemCmp.adjusting,false)
widget:SetChildActive(teamItemCmp.adjustingTxt,false)
widget:SetChildActive(teamItemCmp.waiting,true)
widget:SetChildActive(teamItemCmp.layout,false)
widget:SetChildActive(teamItemCmp.nodztips,false)
widget:SetChildActive(teamItemCmp.winFlag,false)
widget:SetChildActive(teamItemCmp.failFlag,false)
widget:SetChildActive(teamItemCmp.lastTips,false)
elseif showState==teamShowState.eShowDz then
widget:SetChildActive(teamItemCmp.adjusting,false)
widget:SetChildActive(teamItemCmp.adjustingTxt,false)
widget:SetChildActive(teamItemCmp.waiting,false)
widget:SetChildActive(teamItemCmp.layout,true)
widget:SetChildActive(teamItemCmp.nodztips,false)

widget:SetChildActive(teamItemCmp.failFlag,false)
widget:SetChildActive(teamItemCmp.lastTips,false)
self:setTeamInfoList(widget,actorId,teamIndex,true)
widget:SetChildActive(teamItemCmp.winFlag,false)






elseif showState==teamShowState.eNoDZ then
widget:SetChildActive(teamItemCmp.adjusting,false)
widget:SetChildActive(teamItemCmp.adjustingTxt,false)
widget:SetChildActive(teamItemCmp.waiting,false)
widget:SetChildActive(teamItemCmp.layout,false)
widget:SetChildActive(teamItemCmp.nodztips,true)
widget:SetChildActive(teamItemCmp.winFlag,false)
widget:SetChildActive(teamItemCmp.failFlag,false)
widget:SetChildActive(teamItemCmp.lastTips,false)
end
end

end

function UIWDCQPreGameWin:getTeamPosInfo(TeamDZList)
local qianpaiCnt=0
local houpaiCnt=0
for i,v in ipairs(TeamDZList or{})do
if v and v~=0 then
if i<=2 then
qianpaiCnt=qianpaiCnt+1
end
if i>2 and i<=5 then
houpaiCnt=houpaiCnt+1
end
end
end
local posInfo={}
posInfo.qianpaiCnt=qianpaiCnt
posInfo.houpaiCnt=houpaiCnt
return posInfo
end

function UIWDCQPreGameWin:setTeamInfoList(widget,actorId,teamIndex,flag)

local dzlist=WDCQController.getTeamDZList_TeamIndex(actorId,teamIndex)
local posInfo=self:getTeamPosInfo(dzlist)
local qianpaiCnt=posInfo.qianpaiCnt
local houpaiCnt=posInfo.houpaiCnt
widget:SetChildActive(teamItemCmp.qianpailayout,qianpaiCnt>0)
widget:SetChildActive(teamItemCmp.qianpaipaioneBg,qianpaiCnt==1)
widget:SetChildActive(teamItemCmp.qianpaitwoBg,qianpaiCnt>1)
widget:SetChildActive(teamItemCmp.houpailayout,houpaiCnt>0)
widget:SetChildActive(teamItemCmp.houpaioneBg,houpaiCnt==1)
widget:SetChildActive(teamItemCmp.houpaitwoBg,houpaiCnt>1)
local fight=0
for i,v in ipairs(teamItemCmp.headSlotList)do
if dzlist[i]and dzlist[i]~=0 then

widget:SetChildActive(v,true)
local headshot=widget:GetChildWidgetBase(v)






local netdata=dzlist[i]

local image=UIDiscipleModel.calculationDiscipleImageBase(netdata)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(1,headshot,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
headshot:SetChildCSImageSprite(2,globalABLookup.global,jobicon)

local color=mathHelper.compareInt64(actorId,playerModel:getActorID())and image.color or 0
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netdata,color)

comHelper.setChildModelHeadIconBGByColor(headshot,0,color)
fight=fight+mathHelper.int64_to_number(netdata.fightvalue)
if mathHelper.compareInt64(actorId,playerModel:getActorID())then
UIDiscipleModel:setDiscipleXianMoHeadImage(headshot,3,netdata)
end
else
widget:SetChildActive(v,false)
end
end
if flag then
widget:SetChildActive(teamItemCmp.fightroot,true)
widget:SetChildText(teamItemCmp.fight,mathHelper.formatNumber3(fight))
else
widget:SetChildActive(teamItemCmp.fightroot,false)
end



end

function UIWDCQPreGameWin:getTeamShowState(showIndex,macthStage,adjustStage,actorId,teamIndex)
if macthStage==WDCQCMatchStageEnum.ePreTheGame then

if showIndex<adjustStage then
local flag=WDCQController.checkTeamDZ(actorId,teamIndex)
if flag then
return teamShowState.eShowDz
else
return teamShowState.eNoDZ
end
elseif showIndex==adjustStage then
return teamShowState.eAjusting
elseif showIndex>adjustStage then
if adjustStage==WDCQCAdjustTeamStageEnum.eFive then
return teamShowState.eAjusting
end
local curTeamIndex=WDCQController.getAdjustTeamIndex(adjustStage)
if teamIndex==curTeamIndex then
return teamShowState.eWaiting
end
end
else
local flag=WDCQController.checkTeamDZ(actorId,teamIndex)
if flag then
return teamShowState.eShowDz
else
return teamShowState.eNoDZ
end
end
return teamShowState.eNone
end

function UIWDCQPreGameWin:getIconState(teamIndex,macthStage,adjustStage)
local state=IconState.eNone

if macthStage==WDCQCMatchStageEnum.ePreTheGame then
local curTeamIndex=WDCQController.getAdjustTeamIndex(adjustStage)
if curTeamIndex>=teamIndex then
state=IconState.eFight
end
else
local selfhasTeamDZ=WDCQController.checkTeamDZ(self.actorId,teamIndex)
local otherhasTeamDZ=WDCQController.checkTeamDZ(self.otherActorId,teamIndex)
if selfhasTeamDZ and otherhasTeamDZ and macthStage~=WDCQCMatchStageEnum.eTimeDown then
state=IconState.eFight
elseif not selfhasTeamDZ and not otherhasTeamDZ then
state=IconState.eNone
else
state=IconState.eFight
end
end
return state
end

function UIWDCQPreGameWin:stopAdjustStageTimer()
if self.adjustStageTimerId then
self:stopTimerByID(self.adjustStageTimerId)
self.adjustStageTimerId=nil
end
end

function UIWDCQPreGameWin:refreshPlayerInfo()
local groupId=self.groupId
local stageId=self.stageId
local idx=self.idx
local playerData1=WDCQController.getPlayerData(groupId,stageId,idx,WDCQPlayerIndexEnum.eLeft)
local playerData2=WDCQController.getPlayerData(groupId,stageId,idx,WDCQPlayerIndexEnum.eRight)
local playerWidget1=self.playerA:getWidgetBase()
local playerWidget2=self.playerB:getWidgetBase()
self:setPlayerInfo(playerWidget1,playerData1,WDCQPlayerIndexEnum.eLeft)
self:setPlayerInfo(playerWidget2,playerData2,WDCQPlayerIndexEnum.eRight)
end

function UIWDCQPreGameWin:setPlayerInfo(playerWidget,playerData,posEnum)
if playerData then
local isLose=mathHelper.validInt64(playerData.actorId)and playerData.name==''
local isSelfFlag=playerData.actorId==playerModel:getActorID()
playerWidget:SetChildActive(playerCmpIndex.selfFlag,isSelfFlag)
local macthStage,preStage,adjustStage=WDCQController.getMacthStage(self.groupId,self.stageId,self.idx)
local winFlag=playerData.winFlag and macthStage==WDCQCMatchStageEnum.eEndTheGame
playerWidget:SetChildActive(playerCmpIndex.win,winFlag)
local showDetal=false
if isSelfFlag then
showDetal=WDCQController.checkActorSZDZ(playerData.actorId)
else
if macthStage==WDCQCMatchStageEnum.ePreTheGame and preStage==WDCQCPreGameStageEnum.eAdjustTeam then
for i=1,3 do
local lockFlag=WDCQController.checkTeamAdjustLock(i,posEnum,adjustStage)
if lockFlag and WDCQController.checkActorSZDZ(playerData.actorId)then
showDetal=true
break
end
end
elseif WDCQCMatchStageEnum.ePreTheGame<macthStage and macthStage<WDCQCMatchStageEnum.eEndTheGame then
showDetal=true
end
end

if showDetal then
playerWidget:SetChildActive(playerCmpIndex.detal,true)
playerWidget:SetChildButtonClick(playerCmpIndex.detal,function()

WDCQController:reqShowWDCQZRInfo(playerData.actorId)
end)
else
playerWidget:SetChildActive(playerCmpIndex.detal,false)
end

playerWidget:SetChildText(playerCmpIndex.name,FMT.fmt("<color=#{0}>{1}</color>",isSelfFlag and"549327"or"171311",playerModel:getOtherActorName(playerData.name)))
local serverName=loginModel:getServerName(playerData.serverId)
playerWidget:SetChildText(playerCmpIndex.sever,FMT.fmt("<color=#{0}>[{1}]</color>",isSelfFlag and"549327"or"171311",serverName))

if not isLose then
playerController:setImage(playerWidget,playerCmpIndex.modelshow,playerData.sex,playerData.iconInfo,true)
end
playerWidget:SetChildActive(playerCmpIndex.modelshow,not isLose)
playerWidget:SetChildActive(playerCmpIndex.loseModel,isLose)
else
playerWidget:SetChildActive(playerCmpIndex.modelshow,false)
playerWidget:SetChildText(playerCmpIndex.name,"虚伪以待")
playerWidget:SetChildActive(playerCmpIndex.win,false)
playerWidget:SetChildActive(playerCmpIndex.detal,false)
playerWidget:SetChildActive(playerCmpIndex.selfFlag,false)
playerWidget:SetChildText(playerCmpIndex.sever,"")
end

end


function UIWDCQPreGameWin:showYuSheTeam()
local groupId=self.groupId
local stageId=self.stageId
local idx=self.idx
local macthStage,preStage,adjustStage=WDCQController.getMacthStage(self.groupId,self.stageId,self.idx)
local closeCallBack=self.closeCallBack
local args=self:getshowMainArgs()
local enterCallBack=function(guidList)
local list={}
for i,v in ipairs(guidList)do
for ii,vv in ipairs(v[2])do
table.insert(list,vv[2])
end
end

WDCQController.req_38_5(groupId,stageId,idx,#list,list)

loadingControl.openCloud(function()
fightController:closeSelectStage()
UIFullWenDingCangQiongControl:showMainWin(args)
end)


end

local faZeData=nil
local teamData={}
local teamLockCfgList={}
local curAdjustTeamIndex=WDCQController.getAdjustTeamIndex(adjustStage)
local defaultSelectTeamIndex























for i=1,3 do

local fightlist=WDCQController.getTeamDZList_TeamIndex(self.actorId,i)
teamData[i]={}
local lockFlag=WDCQController.checkTeamAdjustLock(i,self.posEnum,adjustStage)
teamLockCfgList[i]={lockFlag=lockFlag,teamlockTips="队伍已锁定",dzlockTips="弟子已锁定",}
for i2,v2 in ipairs(fightlist)do
if v2~=0 and not WDCQController.checkBanDZFlag(self.actorId,v2.discipleguid)then
teamData[i][tostring(v2.discipleguid)]={i2,1,v2.discipleguid}
end
end
if not lockFlag and not defaultSelectTeamIndex then
defaultSelectTeamIndex=i
end
end

local selectDzList=WDCQController.getSelectDZList(self.actorId)
local dZTempList=nil
local fightList={}
if selectDzList then
dZTempList={}
for i,v in ipairs(selectDzList)do
table.insert(dZTempList,v.discipleguid)
fightList[mathHelper.int64_to_string(v.discipleguid)]=mathHelper.int64_to_number(v.fightvalue)
end
end
local args=self:getshowMainArgs()
local winArgs=
{
enterCallBack=enterCallBack,
enterTxt="预设队伍",
mapId=818009,

faZeData=faZeData,
multipleTeams=teamData,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
skipDiscipleInjuryCheck=true,
skipShouYuanCheck=true,
cancelCallBack=function()


loadingControl.openCloud(function()
fightController:closeSelectStage()
UIFullWenDingCangQiongControl:showMainWin(args)
end)

end,
sureBodyid=2068,
sureBodyAnim=eAnimationID.dog_idle_1,
dontCloseStage=true,
notNeedDealOverTime=true,
defaultSelectTeamIndex=defaultSelectTeamIndex,
editorTeam=true,
lockSelect=dZTempList,
teamLockCfgList=teamLockCfgList,
checkBanFlagFunc=function(guid)
local actorId=playerModel:getActorID()
return WDCQController.checkBanDZFlag(actorId,guid)
end,
isSortByTeamSelect=true,
checkSelectCnt=true,
checkDZSortFunc=function(guid)
local actorId=playerModel:getActorID()
return not WDCQController.checkBanDZFlag(actorId,guid)
end,






wendingcangqiongCfg={dzFightList=fightList}
}

fightController.showPrepareWin(eFightPreSelectType.wendingcangqiongteampre,winArgs,function()

end)
end





function UIWDCQPreGameWin:onCloseBtn()


if self.closeCallBack then
self.closeCallBack()
end
self:closeSelf()
end

function UIWDCQPreGameWin:onSureBtn()
if#self.selectRoleDataList<=0 then
UIManager.info('未选择对战弟子')
return
end
if self:checkSelectNum()then
return
end
local func=function()
local dataNum=#self.selectRoleDataList
local list={}

local uniqLookup={}
local uniqueCnt=0
local nilGuidCnt=0
for i,v in ipairs(self.selectRoleDataList)do
local netdata=v.netData
local netData=netdata and netdata.net or nil
local guid=netData and netData.discipleguid or nil
if guid==nil then
nilGuidCnt=nilGuidCnt+1
else
table.insert(list,guid)
local k=mathHelper.int64_to_string and mathHelper.int64_to_string(guid)or tostring(guid)
if not uniqLookup[k]then
uniqLookup[k]=1
uniqueCnt=uniqueCnt+1
end
end
end


self._lastSubmitSelectCnt=dataNum
self._lastSubmitUniqueCnt=uniqueCnt
self._lastSubmitNilGuidCnt=nilGuidCnt
self._lastSubmitTime=timeHelper.getServerShortTime()


local abnormal=(nilGuidCnt>0)or(uniqueCnt~=dataNum)
if abnormal and platformSDK and platformSDK.printSDK then
platformSDK.printSDK('[WDCQ][PreGame][SelectDz][AbnormalSubmit]',
'groupId='..tostring(self.groupId),
'stageId='..tostring(self.stageId),
'idx='..tostring(self.idx),
'actorId='..tostring(self.actorId),
'dataNum='..tostring(dataNum),
'uniqueCnt='..tostring(uniqueCnt),
'nilGuidCnt='..tostring(nilGuidCnt),
'baohuCnt='..tostring(self.baohuDataList and#self.baohuDataList or 0)
)
end

WDCQController.req_38_3(self.groupId,self.stageId,self.idx,dataNum,list,#self.baohuDataList,self.baohuDataList)
end
if#self.baohuDataList==0 then
self.baohuMode=true
self:refresh_SelectDz()
UIManager.info("请选择保护位弟子")
elseif#self.baohuDataList<self.maxBaohuDzCnt then
local contentStr="保护位弟子未选满，是否仍要保存？"
local dialog=UIDialogManager.getConfirmDialogEx(nil,{
content=contentStr,
okcb=func,
})
dialog:show()
else
func()
end














end


function UIWDCQPreGameWin:onBanSureBtn()
local dataNum=#self.banDataList
if dataNum<self.banMaxCnt then
return
end
local list={}
for i,v in ipairs(self.banDataList)do
local guid=v.discipleguid
table.insert(list,guid)
end

WDCQController.req_38_4(self.groupId,self.stageId,self.idx,self.otherActorId,dataNum,list)
end

function UIWDCQPreGameWin:onDataSureBtn()
local selfSelectDZList=WDCQController.getSelectDZList(self.actorId)
if not selfSelectDZList or#selfSelectDZList<=0 then
UIManager.info("未选择对战弟子")
return
end

WDCQController.req_38_10()
UIManager.info("同步数据成功")
end

function UIWDCQPreGameWin:onYusheTeamBtn()
self:showYuSheTeam()
end

function UIWDCQPreGameWin:onBaohuBtn()
if#self.selectRoleDataList<=0 then
UIManager.info('未选择对战弟子')
return
end
if self:checkSelectNum()then
return
end















self.baohuMode=not self.baohuMode
self:refresh_SelectDz()

end

function UIWDCQPreGameWin:onHelpBtn()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='wdcq_pre_help_%s'})
end

function UIWDCQPreGameWin:onFightIcon_1()

end

function UIWDCQPreGameWin:onFightIcon_2()

end

function UIWDCQPreGameWin:onFightIcon_3()

end

function UIWDCQPreGameWin:onReplayIcon_1()

end

function UIWDCQPreGameWin:onReplayIcon_2()

end

function UIWDCQPreGameWin:onReplayIcon_3()







end








function UIWDCQPreGameWin:onClickSelectTab(tabIndex)










end

function UIWDCQPreGameWin:OnClickRoleItemCallback(item,index,roleData)
local isSelect,index=self:checkSelectFlag(roleData)
if isSelect then
local isBaohu,baohuindex=self:checkBaohuFlag(roleData)
if isBaohu then
self:removebaohuDz(roleData,baohuindex)
end
item:SetChildActive(dzItemcmp.select,false)
self:removeSelectDz(roleData,index)
self:refreshSelectList()
self.selectRoleListPanel:setChildScrollViewSelectItem(#self.selectRoleDataList,false,false,false)
self:onScrollViewChange()
else
if self:addSelectDz(roleData)then
item:SetChildActive(dzItemcmp.select,true)
self:refreshSelectList()
self.selectRoleListPanel:setChildScrollViewSelectItem(#self.selectRoleDataList,false,false,false)
self:onScrollViewChange()
else
UIManager.info("可选弟子已达上限")
end
end

end

function UIWDCQPreGameWin:OnClickSelectRoleItemCallback(item,index,roleData)





if self.baohuMode then
local isBaohu,index=self:checkBaohuFlag(roleData)
if isBaohu then
item:SetChildActive(dzItemcmp.protect,false)
self:removebaohuDz(roleData,index)
self:refreshSelectList()
else
if self:addBaohuDz(roleData)then
self:refreshSelectList()
else
UIManager.info("可保护弟子已达上限")
end
end
else
local isBaohu,baohuindex=self:checkBaohuFlag(roleData)
if isBaohu then
self:removebaohuDz(roleData,baohuindex)
end
local isSelect,index=self:checkSelectFlag(roleData)
if isSelect then
self:removeSelectDz(roleData,index)
end
self:refreshSelectList()
self.selectRoleListPanel:setChildScrollViewSelectItem(index-1,false,false,false)
self:onScrollViewChange()
self.roleListPanel:refreshAllItems()
end
end

function UIWDCQPreGameWin:checkSelectFlag(roleData)
for i,v in ipairs(self.selectRoleDataList)do
if mathHelper.compareInt64(v.netData.net.discipleguid,roleData.netData.net.discipleguid)then
return true,i
end
end
return false
end

function UIWDCQPreGameWin:addSelectDz(roleData)
if#self.selectRoleDataList>=self.maxSelectCnt then
return false
end
table.insert(self.selectRoleDataList,roleData)
return true
end

function UIWDCQPreGameWin:removeSelectDz(roleData,index)
table.remove(self.selectRoleDataList,index)
end

function UIWDCQPreGameWin:checkBaohuFlag(roleData)
for i,v in ipairs(self.baohuDataList)do
if mathHelper.compareInt64(v,roleData.netData.net.discipleguid)then
return true,i
end
end
return false
end

function UIWDCQPreGameWin:addBaohuDz(roleData)
if#self.baohuDataList>=self.maxBaohuDzCnt then
return false
end
table.insert(self.baohuDataList,roleData.netData.net.discipleguid)
return true
end

function UIWDCQPreGameWin:removebaohuDz(roleData,index)
table.remove(self.baohuDataList,index)
end


function UIWDCQPreGameWin:OnClickBanDZItemCallback(item,discipleStruct,ietmindex)
if self:checkOtherbaohuFlag(discipleStruct)then
UIManager.info("保护位弟子无法禁用")
return
end
local isSelect,index=self:checkBanFlag(discipleStruct)
if isSelect then
item:SetChildActive(wdcqBandzItemCmp.ban,false)
self:removeBanDz(discipleStruct,index)
self:refreshBanList()
else
if self:addBanDz(discipleStruct)then
self:doAnim(item,discipleStruct,ietmindex)
else
UIManager.info("可禁用弟子已达上限")
end
end
end

function UIWDCQPreGameWin:OnClickSelectBanDZItemCallback(item,discipleStruct)
local isSelect,index=self:checkBanFlag(discipleStruct)
if isSelect then
local topitem=self.topItemList[tostring(discipleStruct.discipleguid)]
topitem:SetChildActive(wdcqBandzItemCmp.ban,false)
self:removeBanDz(discipleStruct,index)
self:refreshBanList()
end
end

function UIWDCQPreGameWin:checkBanFlag(discipleStruct)
for i,v in ipairs(self.banDataList)do
if mathHelper.compareInt64(discipleStruct.discipleguid,v.discipleguid)then
return true,i
end
end
return false
end

function UIWDCQPreGameWin:addBanDz(discipleStruct)
if#self.banDataList>=self.banMaxCnt then
return false
end
table.insert(self.banDataList,discipleStruct)
return true
end

function UIWDCQPreGameWin:removeBanDz(discipleStruct,index)
table.remove(self.banDataList,index)
end

function UIWDCQPreGameWin:checkOtherbaohuFlag(discipleStruct)
local otherBaohuDZList=WDCQController.getBaohuDZList(self.otherActorId)
for i,v in ipairs(otherBaohuDZList)do
if mathHelper.compareInt64(discipleStruct.discipleguid,v)then
return true,i
end
end
return false
end

function UIWDCQPreGameWin:showWDCQZRInfo(index)

local actorId=playerModel:getActorID()
WDCQController:reqShowWDCQZRInfo(actorId)

















local teams={}
for i,v in ipairs(selfSelectDZList)do
local detailDisciple=table.deepCopy(v)
detailDisciple.flag=1
teams[i]=detailDisciple
end
otherPlayerModel:setActorDefTeamsDetail(otherPlayerInfoType.eWenDingCangQiong,playerModel:getActorID(),teams)
local teams,otherArgs=otherPlayerModel:getActorDefTeams(otherPlayerInfoType.eWenDingCangQiong,playerModel:getActorID())
table.sort(teams,function(a,b)
local aFight=a:fightValNum_get()
local bFight=b:fightValNum_get()
return aFight>bFight
end)
local rdata={
teamList=teams,
lookType=DOUFATAI_LOOK_TYPE.eWDCQ_SelfTeam,
title="对战弟子",
otherArgs={
playerHeadInfo=playerModel:getActorIconInfo(),
nameEx=playerModel:getActorName(),
}
}
UIManager:showWindow("UICommonDZInfoListWin",rdata)

end

function UIWDCQPreGameWin:DataRecv_38_3(baohulen)
if baohulen>0 then
self.baohuMode=false
else
self.baohuMode=true
UIManager.info("请选择保护弟子")
end
self:refresh_SelectDz()
end



function UIWDCQPreGameWin:onAnimItem()
end

function UIWDCQPreGameWin:getAnimPos(index)
local width=128
local hight=160
local spaceW=2
local spaceH=6
local lineMaxCnt=10
local line=math.ceil(index/lineMaxCnt)
local col=index%lineMaxCnt
col=col==0 and lineMaxCnt or col
local pos={}
pos.x=(col-1)*width+(col-1)*spaceW
pos.y=-((line-1)*hight+(line-1)*spaceH)
return pos
end

function UIWDCQPreGameWin:getTargetPos()
if self.banMaxCnt>1 then
return animTargetPos[2][#self.banDataList]
else
return animTargetPos[1][1]
end
end

function UIWDCQPreGameWin:doAnim(item,discipleStruct,ietmindex)
self:stopAnim()
self.animItem:setActive(true)
local animItem=self.animItem:getWidgetBase()
self:refreshRoleItem_Ban(animItem,discipleStruct,true)
local animPos=self:getAnimPos(ietmindex)
self.animItem:setChildAnchoredPos(animPos.x,animPos.y)

self.scaleTween=self.animItem:setChildDOScale(1.2,0.15,function()
if not self or self.isClose then return end
self.scaleTween=self.animItem:setChildDOScale(1,0.4)
end)
local targetPos=self:getTargetPos()
self.moveTween=self.animItem:setChildDOLocalMove(Vector3(targetPos.x,targetPos.y,0),0.5,function()
if not self or self.isClose then return end
item:SetChildActive(wdcqBandzItemCmp.ban,true)
self:refreshBanList()
self.animItem:setActive(false)
end)
end

function UIWDCQPreGameWin:stopAnim()
if self.scaleTween~=nil then
self.scaleTween:Kill()
self.scaleTween=nil
end
if self.moveTween~=nil then
self.moveTween:Kill()
self.moveTween=nil
end
self.animItem:setActive(false)
end


function UIWDCQPreGameWin:test(flag)
WDCQController.req_38_2(flag and self.otherActorId or self.actorId)
end


function UIWDCQPreGameWin:DataRecv_38_10()




end

function UIWDCQPreGameWin:onScrollViewChange()
if not self.baohuItemList then
return
end
for i,v in ipairs(self.baohuItemList)do
local item=v[1]
local index=v[2]
if self:checkShow(index)then
item:SetChildActive(dzItemcmp.protectEffect,true)
item:SetChildActive(dzItemcmp.tick,false)
item:SetChildActive(dzItemcmp.tickEx,true)
else
item:SetChildActive(dzItemcmp.protectEffect,false)
item:SetChildActive(dzItemcmp.tick,true)
item:SetChildActive(dzItemcmp.tickEx,false)
end
end
end

function UIWDCQPreGameWin:checkShow(index)
local pos=self.selectRoleListContent:getChildAnchoredPosition()
local y=pos.y
local top,bottom=self:getItemPos(index)
if(top-y)>0 and(bottom-y)<464 then
return true
end
return false
end

function UIWDCQPreGameWin:getItemPos(index)
local offest=21
local space=20
local itemHight=181
local col=math.ceil(index/3)
local top=offest+(col-1)*(itemHight+space)
local bottom=top+itemHight
return top,bottom
end

function UIWDCQPreGameWin:getshowMainArgs()
local args={}


args.showPreWin=true
args.groupId=self.selectGroupId
args.stageId=self.selectStageId
args.subGoupId=self.subGoupId
args.closeCallBack=self.closeCallBack
return args
end

function UIWDCQPreGameWin:onFightDzInfoBtn()
local selfSelectDZList=WDCQController.getSelectDZList(self.actorId)
if not selfSelectDZList or#selfSelectDZList<=0 then
UIManager.info("请选择对战弟子")
return
end

















local teams={}
for i,v in ipairs(selfSelectDZList)do
local detailDisciple=table.deepCopy(v)
detailDisciple.flag=1
teams[i]=detailDisciple
end
otherPlayerModel:setActorDefTeamsDetail(otherPlayerInfoType.eWenDingCangQiong,playerModel:getActorID(),teams)
local teams,otherArgs=otherPlayerModel:getActorDefTeams(otherPlayerInfoType.eWenDingCangQiong,playerModel:getActorID())
table.sort(teams,function(a,b)
local aFight=a:fightValNum_get()
local bFight=b:fightValNum_get()
return aFight>bFight
end)
local rdata={
teamList=teams,
lookType=DOUFATAI_LOOK_TYPE.eWDCQ_SelfTeam,
title="对战弟子",
otherArgs={
playerHeadInfo=playerModel:getActorIconInfo(),
nameEx=playerModel:getActorName(),
}
}
UIManager:showWindow("UICommonDZInfoListWin",rdata)

end


function UIWDCQPreGameWin:checkSelectNum()
local len=cfgHelper.get2(cfg_wendingcangqiongconfig_get,1,'min_dizi_cnt')
local datanum=#self.selectRoleDataList
if datanum<len then
local str=FMT.fmt('请至少选择<color=#f1ce78>{0}名</color>对战弟子',len)
UIManager.error(str)
return true
end
return false
end


