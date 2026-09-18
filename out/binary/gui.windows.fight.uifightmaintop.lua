







def_class("UIFightMainTop",UIWindowBase)









function UIFightMainTop:bindComponents()

self.accBtn=UIButton.get(self,0)
self.backBtn=UIButton.get(self,1)
self.backEffect=UIObject.get(self,2)
self.chatBtn=UIButton.get(self,3)
self.chatReddot=UIObject.get(self,4)
self.closeStateBtn=UIButton.get(self,5)
self.DebugInfo=UIButton.get(self,6)
self.fightTimes=UIText.get(self,7)
self.fightTimesBg=UIObject.get(self,8)
self.jzBarItem_1=UIObject.get(self,9)
self.jzBarItem_2=UIObject.get(self,10)
self.jzRoot=UIObject.get(self,11)
self.left=UIObject.get(self,12)
self.leftSpeEffect=UIGameobjectClone.new(self,13)
self.leftYuanJunCur=UIText.get(self,14)
self.leftYuanJunTotal=UIText.get(self,15)
self.lockskip=UIObject.get(self,16)
self.numText=UIText.get(self,17)
self.rightSpeEffect=UIGameobjectClone.new(self,18)
self.rightYuanJunCur=UIText.get(self,19)
self.rightYuanJunTotal=UIText.get(self,20)
self.Root=UIObject.get(self,21)
self.roundCur=UIText.get(self,22)
self.roundInfo=UIObject.get(self,23)
self.roundTotal=UIText.get(self,24)
self.skipAllBtn=UIButton.get(self,25)
self.skipBtn=UIButton.get(self,26)
self.speEffectRoot=UIObject.get(self,27)
self.stateBtn=UIButton.get(self,28)
self.StateEffect=UIObject.get(self,29)
self.StateText=UIText.get(self,30)
self.totalDamge=UIObject.get(self,31)
self.totalDamgebg=UIObject.get(self,32)
self.totalDamgeText=UIText.get(self,33)
self.totalDamgeTitle=UIObject.get(self,34)
self.totalHeal=UIObject.get(self,35)
self.totalHealbg=UIObject.get(self,36)
self.totalHealText=UIText.get(self,37)
self.totalHealTitle=UIObject.get(self,38)
self.yuanjunLeft=UIObject.get(self,39)
self.yuanjunRight=UIObject.get(self,40)

self.accBtn:setButtonClick(function()self:onAccBtn()end)

self.backBtn:setButtonClick(function()self:onBackBtn()end)

self.chatBtn:setButtonClick(function()self:onChatBtn()end)

self.closeStateBtn:setButtonClick(function()self:onCloseStateBtn()end)

self.DebugInfo:setButtonClick(function()self:onDebugInfo()end)

self.skipAllBtn:setButtonClick(function()self:onSkipAllBtn()end)

self.skipBtn:setButtonClick(function()self:onSkipBtn()end)

self.stateBtn:setButtonClick(function()self:onStateBtn()end)
self.jzBarItem={
self.jzBarItem_1,
self.jzBarItem_2,
}


self.sprite_button_zdjiasu_1=0
self.sprite_button_zdjiasu_2=1
self.sprite_button_zdjiasu_3=2

end


function UIFightMainTop:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.accBtn);self.accBtn=nil;
_UIObject_release(self.backBtn);self.backBtn=nil;
_UIObject_release(self.backEffect);self.backEffect=nil;
_UIObject_release(self.chatBtn);self.chatBtn=nil;
_UIObject_release(self.chatReddot);self.chatReddot=nil;
_UIObject_release(self.closeStateBtn);self.closeStateBtn=nil;
_UIObject_release(self.DebugInfo);self.DebugInfo=nil;
_UIObject_release(self.fightTimes);self.fightTimes=nil;
_UIObject_release(self.fightTimesBg);self.fightTimesBg=nil;
_UIObject_release(self.jzBarItem_1);self.jzBarItem_1=nil;
_UIObject_release(self.jzBarItem_2);self.jzBarItem_2=nil;
_UIObject_release(self.jzRoot);self.jzRoot=nil;
_UIObject_release(self.left);self.left=nil;
self.leftSpeEffect:deleteSelf();self.leftSpeEffect=nil;
_UIObject_release(self.leftYuanJunCur);self.leftYuanJunCur=nil;
_UIObject_release(self.leftYuanJunTotal);self.leftYuanJunTotal=nil;
_UIObject_release(self.lockskip);self.lockskip=nil;
_UIObject_release(self.numText);self.numText=nil;
self.rightSpeEffect:deleteSelf();self.rightSpeEffect=nil;
_UIObject_release(self.rightYuanJunCur);self.rightYuanJunCur=nil;
_UIObject_release(self.rightYuanJunTotal);self.rightYuanJunTotal=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.roundCur);self.roundCur=nil;
_UIObject_release(self.roundInfo);self.roundInfo=nil;
_UIObject_release(self.roundTotal);self.roundTotal=nil;
_UIObject_release(self.skipAllBtn);self.skipAllBtn=nil;
_UIObject_release(self.skipBtn);self.skipBtn=nil;
_UIObject_release(self.speEffectRoot);self.speEffectRoot=nil;
_UIObject_release(self.stateBtn);self.stateBtn=nil;
_UIObject_release(self.StateEffect);self.StateEffect=nil;
_UIObject_release(self.StateText);self.StateText=nil;
_UIObject_release(self.totalDamge);self.totalDamge=nil;
_UIObject_release(self.totalDamgebg);self.totalDamgebg=nil;
_UIObject_release(self.totalDamgeText);self.totalDamgeText=nil;
_UIObject_release(self.totalDamgeTitle);self.totalDamgeTitle=nil;
_UIObject_release(self.totalHeal);self.totalHeal=nil;
_UIObject_release(self.totalHealbg);self.totalHealbg=nil;
_UIObject_release(self.totalHealText);self.totalHealText=nil;
_UIObject_release(self.totalHealTitle);self.totalHealTitle=nil;
_UIObject_release(self.yuanjunLeft);self.yuanjunLeft=nil;
_UIObject_release(self.yuanjunRight);self.yuanjunRight=nil;
self.jzBarItem=nil;
end



















local eUnlockType=
{
zongmenLevel=1,
}

local hideDemageType=
{
[eBattleType.qieshishenshou]=true,
}

local _this=nil


local _AppConfig_GetBool=CS.AppDataModel.AppConfig_GetBool
function UIFightMainTop:onLoaded(...)
self:bindComponents()
_this=self
local openFightReport=_AppConfig_GetBool('openFightReport',false)
self.DebugInfo:setActive(deviceHelper.isRunEditor()or openFightReport)
self:addNotify(notifyConfig.onRecvMessage,function(...)self:onRecvMessage(...)end)

self.needChangeTo3=nil

self.spLeftComponent={}
self.spRightComponent={}
end


function UIFightMainTop:__delete()
self:endAllReddotPunchRotation()
if self.startFightTimer~=nil then
self:stopTimerByID(self.startFightTimer)
self.startFightTimer=nil
self.battle:startTimer()
end
if self.delay then
self:stopTimerByID(self.delay)
end
if self.guideDelay~=nil then
self.guideDelay:cancel()
end
self.skipActive=nil
self:unbindComponents()

_this=nil
end




function UIFightMainTop:onShow(_battle,afterOnloaded)

self.battle=_battle

self.totalDamgebg:setScale(Vector3(0,0,0))
self.totalHealbg:setScale(Vector3(0,0,0))
self.totalDamgeTitle:setChildCanvasGroupAlpha(0)
self.totalHealTitle:setChildCanvasGroupAlpha(0)
self.Root:setChildCanvasGroupAlpha(0)
self.delay=self:setTimer(1.5,1,function()
self.Root:setChildCanvasGroupDOFade(1,0.5,function()
if self and not self.isClose then

local isGuide,weakGuideId=self:checkShiLianTaAutoFightWeakGuide()
if isGuide then
weakGuideController:beginGuide(weakGuideId)
end
end

end)

end)

self.lockskip:setActive(false)

if self.battle.newbieGuide then
self.skipBtn:setActive(false)
self.skipActive=true
self.accBtn:setActive(false)
self.chatBtn:setActive(false)
end


local global=cfgHelper.get2(cfg_worldglobalconfig_get,"noviciateBlock","value")
local plotCfg={1,3,1,1}
if worldExperienceModel:sameScene(global[1],global[2])then
local point=worldExperienceModel:getCurrentPoint()
local pointCfg=cfgHelper.get1(cfg_experienceconfig_get,point)
plotCfg=pointCfg.fightUI or plotCfg
if pointCfg.fightUI then
if plotCfg[2]==3 then
self.needChangeTo3=true
end
end
else
local taskData=taskModel:getTaskByLine(taskModel.lineMain)
if taskData then
plotCfg=taskData.cfg.fightUI or plotCfg
if taskData.cfg.fightUI then
if plotCfg[2]==3 then
self.needChangeTo3=true
end
end
end
end

self.skipBtn:setActive(plotCfg[1]==1)
self.skipActive=plotCfg[1]~=1
if plotCfg[2]>0 then
self.accBtn:setActive(true)
self.battle:setAccLimit(plotCfg[2]-1)
else
self.accBtn:setActive(false)
end

self.chatBtn:setActive(plotCfg[3]==1)

self.backBtn:setActive(plotCfg[4]==1)
self.skipAllBtn:setActive(false)


local weakGuide=plotCfg[5]
if weakGuide then
local isGuide=userActorSetting.get(FMT.fmt("weakGuide_{0}",weakGuide),0)
if isGuide~=1 then
self.guideDelay=timeEventController.delayDo(2,function()
weakGuideController:beginGuide(plotCfg[5])
self.battle.weakGuide=plotCfg[5]
userActorSetting.flushVal(FMT.fmt("weakGuide_{0}",weakGuide),1)
end)
end
end

if(not self.battle.isRePlay)or(not self.battle.isRestart)then


if shiLianTaModel:isFightShow()then
local layer=shiLianTaModel:getFightingLayer()
local skipUnlock=cfgHelper.get(cfg_traintowerglobalconfig_get,1,"fightSkipUnlock")
if layer and skipUnlock then
self.isLockSkip=false
self.lockSkipTips=''
if layer<=skipUnlock then
self.isLockSkip=true
self.lockSkipTips=FMT.fmt('通关{0}层后解锁',skipUnlock)
end
end
if not self.skipActive then
self.lockskip:setActive(self.isLockSkip)
self.skipBtn:setGray(self.isLockSkip)
end
else

if douFaTaiModel:isInFight()then
local tzNum=douFaTaiModel:get_doufatai_tzNum()
local skipUnlock=cfgHelper.get(cfg_doufataibasicconfig_get,1,"fightSkipNum")
if tzNum and skipUnlock then
self.isLockSkip=false
self.lockSkipTips=''
if tzNum<skipUnlock then
self.isLockSkip=true
self.lockSkipTips=FMT.fmt('再进行{0}场战斗开启',skipUnlock-tzNum)
end
end
if not self.skipActive then
self.lockskip:setActive(self.isLockSkip)
self.skipBtn:setGray(self.isLockSkip)
end
else
local skipUnlock=cfgHelper.get(cfg_globalconfig_get,1,"skipFightUnlock")
if skipUnlock then
self.isLockSkip=false
self.lockSkipTips=''
local unlockType=skipUnlock.type
local param=skipUnlock.param
local check=self.checkLock(unlockType,param)
if check then
self.isLockSkip=true
if unlockType==eUnlockType.zongmenLevel then
self.lockSkipTips=FMT.fmt('宗门{0}级解锁',param)
end
end

if not self.skipActive then
self.lockskip:setActive(self.isLockSkip)
self.skipBtn:setGray(self.isLockSkip)
end
end
end

end
end

local lundaoZhiBoFlag=lundaodahuiModel:getZhiBoFlag()
if lundaoZhiBoFlag then






self.skipBtn:setActive(false)
else
if self.battle.isRestart then
self.isLockSkip=nil
self.lockskip:setActive(false)
self.skipBtn:setGray(false)
end
end


if self.battle.hideExitWatch then
self.backBtn:setActive(false)
end

if self.battle.showSkipAll then
self.skipAllBtn:setActive(true)
self.backBtn:setActive(false)
end


if self.battle.repeatPlayRound then
self.Root:setActive(false)
end

local mustLook=self.battle.mustLook or false

if mustLook then
self.skipBtn:setActive(false)
end

if lundaoZhiBoFlag then
self.limitAcc=1
self.battle:setAccLimit(1)



else
local accUnlock=cfgHelper.get(cfg_globalconfig_get,1,"accFightUnlock")
if accUnlock then

local unlockType,param=nil,nil
local check2=false
if accUnlock[2]then
unlockType=accUnlock[2].type
param=accUnlock[2].param
check2=self.checkLock(unlockType,param)
end
if check2 then
self.limitAcc=0
self.battle:setAccLimit(0)
if unlockType==eUnlockType.zongmenLevel then
self.acc2Tips=FMT.fmt('宗门{0}级开启2倍加速',param)
end
else

local check3=false
if accUnlock[3]then
unlockType=accUnlock[3].type
param=accUnlock[3].param
check3=self.checkLock(unlockType,param)
end
if check3 then
self.limitAcc=1
self.battle:setAccLimit(1)
if unlockType==eUnlockType.zongmenLevel then
self.acc3Tips=FMT.fmt('宗门{0}级开启3倍加速',param)
end
end
end
end
end

local stateUnlock=cfgHelper.get(cfg_globalconfig_get,1,"stateFightUnlock")
if stateUnlock then
self.isLockState=false
self.lockStateTips=''
local unlockType=stateUnlock.type
local param=stateUnlock.param
local check=self.checkLock(unlockType,param)
if check then
self.isLockState=true
if unlockType==eUnlockType.zongmenLevel then
self.lockStateTips=FMT.fmt('宗门{0}级解锁',param)
end
end

self.stateBtn:setActive(not self.isLockState)
end

self:flushRoundInfo()
self.accBtn:setImageSprite(self.battle:getAccMulti(),true)
self:flushYuanJunInfo()
self:onRecvMessage()

if self.battle.stageCfg then
local UIEffect=self.battle.stageCfg.UIEffect
if UIEffect then
self.backEffect:setChildShowEffect(UIEffect,true)
end
end



if MysteryGuildOrder:isInAuto()then
self:delayDo(5,function()
self:onSkipBtn()
end)
end

local activityData=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eCloudCityTreasure)
if activityData then
local sub_actInfo=activityData[1]
if sub_actInfo then
if sub_actInfo:isfrightAuto()then
self:delayDo(5,function()
self:onSkipBtn()
end)
end
end
end

if self.battle.fightMode==fightPlayModeType.eJunZhen then
self.roundInfo:setActive(false)
self.stateBtn:setActive(false)
self:initJunZhen(self.battle.jzMaxLeft,self.battle.jzMaxRight)
else
self.roundInfo:setActive(true)
self.stateBtn:setActive(true)
self:showJunZhen(false)
end
end

function UIFightMainTop:onShowArgRecv(argtable)
local lundaoZhiBoFlag=lundaodahuiModel:getZhiBoFlag()
if lundaoZhiBoFlag then
self.isLockSkip=true
local skipRoundList=cfgHelper.get(cfg_globalconfig_get,1,"fightSkipRound")
local skipRound=skipRoundList~=nil and skipRoundList[self.battle.battleType]or nil
self.lockSkipTips=FMT.fmt("第{0}回合可跳过",skipRound)
self.lockskip:setActive(true)
self.skipBtn:setGray(true)
end

self:onShow(argtable,false)
end


function UIFightMainTop:onHide()

end

function UIFightMainTop:restart()
if self.battle.isRestart then
self.isLockSkip=nil
self.lockskip:setActive(false)
self.skipBtn:setGray(false)
if self.limitAcc then
self.battle:setAccLimit(self.limitAcc)
end
self:flushYuanJunInfo()
end
end


function UIFightMainTop.checkLock(unlockType,param)
if unlockType==eUnlockType.zongmenLevel then
local lv=zongmenModel:getLevel()or 0
if lv<param then
return true
end
else

end
end

function UIFightMainTop:onRecvMessage()
local channels={CHAT_CHANNNEL.eWorld,CHAT_CHANNNEL.eXianmeng,CHAT_CHANNNEL.eKuafu,CHAT_CHANNNEL.ePrivate}

local num=0
for _,channelId in ipairs(channels)do
if chatControl.hasNewMesgByChannel(channelId)then
num=num+chatControl.getNewestMesgNumByChannel(channelId)
end
end
local reddot=num>0
if num>99 then
num='99+'
elseif num<=0 then
num=''
end
self.chatReddot:setActive(reddot)
self.numText:setText(num)
self.chatReddotIndex=self:doPunchRotation(self.widget,self.chatReddot:getID(),self.chatReddotIndex,reddot)
end

function UIFightMainTop:onReadNewestMesg()
self:onRecvMessage()
end



local speEffectLeftItem="speEffectLeftItem"
local speItemMax=5
function UIFightMainTop:insertSpeEffectLeft(effectId)
self.speEffectLeft=self.speEffectLeft or{}

if self:checkSameSpe(effectId,self.speEffectLeft)or not self:checkShowSpe(effectId)then
return
end
if not skillShowTypeTag[effectId]or not skillShowTypeTag[effectId].imageID or not skillShowTypeTag[effectId].speImageID then
return
end
table.insert(self.speEffectLeft,effectId)

local index=#self.speEffectLeft

if index>speItemMax then
self.speEffectLeftTemp=self.speEffectLeftTemp or{}
table.insert(self.speEffectLeftTemp,effectId)
return
end

self.spLeftComponent[index]=self.leftSpeEffect:createObject(speEffectLeftItem,self.leftSpeEffect:getID(),0,{parent=self,index=index,val=effectId,hideCall=self.hideSpComponentCall})
end

local speEffectRightItem="speEffectRightItem"
function UIFightMainTop:insertSpeEffectRight(effectId)
self.speEffectRight=self.speEffectRight or{}

if self:checkSameSpe(effectId,self.speEffectRight)and not self:checkShowSpe(effectId)then
return
end
if not skillShowTypeTag[effectId]or not skillShowTypeTag[effectId].imageID or not skillShowTypeTag[effectId].speImageID then
return
end
table.insert(self.speEffectRight,effectId)

local index=#self.speEffectRight

if index>speItemMax then
self.speEffectRightTemp=self.speEffectRightTemp or{}
table.insert(self.speEffectRightTemp,effectId)
return
end
self.spRightComponent[index]=self.rightSpeEffect:createObject(speEffectRightItem,self.rightSpeEffect:getID(),0,{parent=self,index=index,val=effectId,hideCall=self.hideSpComponentCall})
end

function UIFightMainTop:checkSameSpe(effectId,list)
for i,v in ipairs(list)do
if effectId==v then
return true
end
end
end

function UIFightMainTop:checkShowSpe(effectId)
local show_spe_skill_type=cfgHelper.getdef(cfg_buffconfig,"show_spe_skill_type")
return show_spe_skill_type[effectId]
end

function UIFightMainTop.hideSpComponentCall(self,isLeft)
if not self or self.isClose then return end
self.speEffectLeft=self.speEffectLeft or{}
self.speEffectRight=self.speEffectRight or{}
self.speEffectLeftTemp=self.speEffectLeftTemp or{}
self.speEffectRightTemp=self.speEffectRightTemp or{}
local val
if isLeft then
table.remove(self.speEffectLeft,1)
val=self.speEffectLeftTemp[1]
table.insert(self.speEffectLeft,val)
else
table.remove(self.speEffectRight,1)
val=self.speEffectLeftTemp[1]
table.insert(self.speEffectRight,val)
end

if not val or not skillShowTypeTag[val]then
return
end

local index=isLeft and#self.speEffectLeft or#self.speEffectRight
if index>speItemMax then
table.insert(isLeft and self.speEffectLeftTemp or self.speEffectRightTemp,1,val)
return
end

local spRoot=isLeft and self.leftSpeEffect or self.rightSpeEffect
local compName=isLeft and speEffectLeftItem or speEffectRightItem
local spComp=spRoot:createObject(compName,spRoot:getID(),0,{parent=self,index=index,val=val,hideCall=self.hideSpComponentCall})
if isLeft then
self.spLeftComponent[index]=spComp
else
self.spRightComponent[index]=spComp
end
end



function UIFightMainTop:setRoundInfo(cur,total)

end



function UIFightMainTop:onBackBtn()
if shiLianTaModel:isFightShow()then

local weakGuide=3520
local isGuide=userActorSetting.get(FMT.fmt("weakGuide_{0}",weakGuide),0)
if isGuide~=1 then

userActorSetting.flushVal(FMT.fmt("weakGuide_{0}",weakGuide),1)
end
end
fightController:closeBattle(self.battle.id)
end


function UIFightMainTop:onSkipAllBtn()
fightController:completeBattle(self.battle.id,true,true)
end




function UIFightMainTop:onSkipBtn()
if self.isLockSkip then
if self.lockSkipTips then
UIManager.error(self.lockSkipTips)
end
return
end
if self.battle.showSkipAllByleftBottom then
if self.battle.showSkipAllByleftBottom==1 or(self.battle.showSkipAllByleftBottom==2 and not self.battle.isRestart)then
self:onSkipAllBtn()
return
end
end
if self.battle:isInBeginNextBattle()then
return
end

self.battle:skipProcess()
end


function UIFightMainTop:onAccBtn()
local curAcc=self.battle:getAccMulti()
if curAcc==0 then
if self.acc2Tips then
UIManager.error(self.acc2Tips)
end
end
if curAcc==1 then
if self.acc3Tips then
UIManager.error(self.acc3Tips)
end
end

if self.battle.isOver or self.battle.isDelayOver then
return
end

if self.needChangeTo3 then
self.battle:setAccMulti(2,true)
self.accBtn:setImageSprite(2,true)
self.needChangeTo3=nil
else
self.accBtn:setImageSprite(self.battle:addAccMulti(),true)
end


end


function UIFightMainTop:onChatBtn()
UIManager:showWindow('UIChatWin')
end

function UIFightMainTop:onDebugInfo()
UIManager:showWindow("UIFightReport")
end

function UIFightMainTop:flushRoundInfo()
if self.battle~=nil then

if self.battle.fightMode==fightPlayModeType.eJunZhen then
self.roundCur:setText(self.battle.jzRoundIndex)
self.roundTotal:setText(self.battle.jzTotalRound)
return
end

local curRound,totalRound=self.battle:getRoundIndexInfo()
self.roundCur:setText(curRound)
self.roundTotal:setText(totalRound)

local battleType=self.battle.battleType
if battleType then
local skipRoundList=cfgHelper.get(cfg_globalconfig_get,1,"fightSkipRound")
local skipRound=skipRoundList~=nil and skipRoundList[battleType]or nil
if skipRound and self.isLockSkip then
local isLockSkip=curRound<skipRound
if not isLockSkip then
self.isLockSkip=false
self.lockskip:setActive(false)
self.skipBtn:setGray(false)
end
end
end
end
end

function UIFightMainTop:startFight()
self.StateEffect:setChildShowEffect(10067,true)


end

function UIFightMainTop:flushState()



end

function UIFightMainTop:flushYuanJunInfo()

if self.battle.fightMode==fightPlayModeType.eJunZhen then
self.yuanjunLeft:setActive(false)
self.yuanjunRight:setActive(false)
return
end

local leftCur,leftTotal,rightCur,rightTotal=self.battle:getYuanJunInfo()
if leftTotal>0 then
self.yuanjunLeft:setActive(true)
self.leftYuanJunCur:setText(leftCur)
self.leftYuanJunTotal:setText(leftTotal)
else
self.yuanjunLeft:setActive(false)
end

if rightTotal>0 then
self.yuanjunRight:setActive(true)

self.rightYuanJunTotal:setText(rightTotal-rightCur)
else
self.yuanjunRight:setActive(false)
end
end


function UIFightMainTop:checkShiLianTaAutoFightWeakGuide()
if not self.battle.hideExitWatch then

if shiLianTaModel:isFightShow()then

local weakGuide=3520
local isGuide=userActorSetting.get(FMT.fmt("weakGuide_{0}",weakGuide),0)
if isGuide~=1 then
return true,weakGuide
end
end
end

return false,nil
end

function UIFightMainTop:onStateBtn()
self.stateBtn:setActive(false)
self.closeStateBtn:setActive(true)
self:showWindow("UIFightBuffStateReport",{battle=self.battle})
end


function UIFightMainTop:onCloseStateBtn()
self.stateBtn:setActive(true)
self.closeStateBtn:setActive(false)
end


function UIFightMainTop:addDemage(demage)
if self.demageTween then
self.demageTween:Complete()
end
if self.demageTween2 then
self.demageTween2:Complete()
end

local battleType=self.battle.battleType
if battleType and hideDemageType[battleType]then
return
end

if not self.showDemage then
self.showDemage=true
self.demageVal=0
self:showDemageAnim()
self.totalDamgeText:setChildCanvasGroupAlpha(0)
self.demageTween2=self.totalDamgeText:setChildCanvasGroupDOFade(1,0.5)

self.totalDamgeText:setScale(Vector3(1,1,1))
self.demageTween=self.totalDamgeText:setChildDOScale(1.25,0.3)
self.demageTween:SetLoops(2,_LoopType.Yoyo)
else
self.totalDamgeText:setScale(Vector3(1,1,1))
self.demageTween=self.totalDamgeText:setChildDOScale(1.25,0.3)





self.demageTween:SetLoops(2,_LoopType.Yoyo)
end
self.demageVal=self.demageVal+demage


self.totalDamgeText:setText(mathHelper.formatNumber7(self.demageVal,nil,2))

end

function UIFightMainTop:hideDemagePanel()
if self.showDemage then
self.demageVal=0
self.showDemage=false
if self.demageTween then
self.demageTween:Complete()
end
if self.demageTween2 then
self.demageTween2:Complete()
end
self.totalDamgeText:setChildCanvasGroupAlpha(1)
self.demageTween=self.totalDamgeText:setChildCanvasGroupDOFade(0,0.5)
self:hideDemageAnim(1)
self.demageTween:SetDelay(1)

end
end


function UIFightMainTop:showDemageAnim()
if self.demageShowTween then
self.demageShowTween:Complete()
end
if self.demageShowTween2 then
self.demageShowTween2:Complete()
end
self.totalDamgebg:setChildCanvasGroupAlpha(1)
self.totalDamgebg:setScale(Vector3(0,1,1))
self.totalDamgebg:setChildDOScale(1,0.25)
self.demageShowTween=self.totalDamgeTitle:setChildCanvasGroupDOFade(1,0.25)
self.demageShowTween:SetDelay(0.1)
end

function UIFightMainTop:hideDemageAnim(delay)
if self.demageShowTween then
self.demageShowTween:Complete()
end
if self.demageShowTween2 then
self.demageShowTween2:Complete()
end
self.demageShowTween=self.totalDamgeTitle:setChildCanvasGroupDOFade(0,0.5)
self.demageShowTween2=self.totalDamgebg:setChildCanvasGroupDOFade(0,0.5)
if delay then
self.demageShowTween:SetDelay(delay)
self.demageShowTween2:SetDelay(delay)
end
end

function UIFightMainTop:showHealAnim()
if self.healShowTween then
self.healShowTween:Complete()
end
if self.healShowTween2 then
self.healShowTween2:Complete()
end
self.totalHealbg:setChildCanvasGroupAlpha(1)
self.totalHealbg:setChildDOScale(1,0.25)
self.healShowTween=self.totalHealTitle:setChildCanvasGroupDOFade(1,0.25)
self.healShowTween:SetDelay(0.1)
end
function UIFightMainTop:hideHealAnim(delay)
if self.healShowTween then
self.healShowTween:Complete()
end
if self.healShowTween2 then
self.healShowTween2:Complete()
end
self.healShowTween=self.totalHealTitle:setChildCanvasGroupDOFade(0,0.5)
self.healShowTween2=self.totalHealbg:setChildCanvasGroupDOFade(0,0.5)
if delay then
self.healShowTween:SetDelay(delay)
self.healShowTween2:SetDelay(delay)
end
end

function UIFightMainTop:addHeal(healVal)
if self.healTween then
self.healTween:Complete()
end
if self.healTween2 then
self.healTween2:Complete()
end

local battleType=self.battle.battleType
if battleType and hideDemageType[battleType]then
return
end

if not self.showHeal then
self.showHeal=true
self.healVal=0
self:showHealAnim()


self.totalHealText:setChildCanvasGroupAlpha(0)
self.healTween2=self.totalHealText:setChildCanvasGroupDOFade(1,0.5)

self.totalHealText:setScale(Vector3(1,1,1))
self.healTween=self.totalHealText:setChildDOScale(1.25,0.3)
self.healTween:SetLoops(2,_LoopType.Yoyo)
else
self.totalHealText:setScale(Vector3(1,1,1))
self.healTween=self.totalHealText:setChildDOScale(1.25,0.3)




self.healTween:SetLoops(2,_LoopType.Yoyo)
end
self.healVal=self.healVal+healVal


self.totalHealText:setText(mathHelper.formatNumber7(math.abs(self.healVal),nil,2))


end

function UIFightMainTop:hideHealPanel()
if self.showHeal then
self.healVal=0
self.showHeal=false
if self.healTween then
self.healTween:Complete()
end
if self.healTween2 then
self.healTween2:Complete()
end

self.totalHealText:setChildCanvasGroupAlpha(1)
self.healTween=self.totalHealText:setChildCanvasGroupDOFade(0,0.5)
self:hideHealAnim(1)
self.healTween:SetDelay(1)
end
end

function UIFightMainTop:initJunZhen(leftNum,rightNum)
self.jzLeftNum=leftNum
self.jzRightNum=rightNum
self.jzRoot:setChildCanvasGroupDOFade(1,0.2)
local widget1=self.jzBarItem_1:getChildWidgetBase()
widget1:SetProgressBarAniWithThreeParams(0,leftNum,leftNum,0)
widget1:SetChildText(1,leftNum)
local widget2=self.jzBarItem_2:getChildWidgetBase()
widget2:SetProgressBarAniWithThreeParams(0,rightNum,rightNum,0)

widget2:SetChildText(1,rightNum)
end

function UIFightMainTop:showJunZhen(flag)
self.jzRoot:setChildCanvasGroupDOFade(flag and 1 or 0,0.2)
end

function UIFightMainTop:updatejunZhen(leftNum,rightNum)
self:updatejunZhenLeft(leftNum)
self:updatejunZhenRight(rightNum)
end

local deathTimeLine={1.5,1.5,0.5,0.5,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25}

function UIFightMainTop:updatejunZhenLeft(leftNum)
local old=self.jzLeftNum
local widget=self.jzBarItem_1:getChildWidgetBase()

local times=#deathTimeLine
local sub=math.ceil((old-leftNum)/times)
local num=old
local index=1
local delay=0

local updateFunc=function()
if delay<=0 then
local old=num
num=num-sub
index=index+1
if index<times then
widget:SetChildText(1,num)
delay=deathTimeLine[index-1]
widget:SetProgressBarAniWithFiveParams(0,old,num,self.battle.jzMaxLeft,delay,old>num)
else
widget:SetChildText(1,leftNum)
widget:SetProgressBarAniWithFiveParams(0,old,leftNum,self.battle.jzMaxLeft,0.25,old>leftNum)
if self.leftJZTimer then self:stopTimerByID(self.leftJZTimer)end
end
end
delay=delay-0.25
end

updateFunc()
self.leftJZTimer=self:setTimer(0.25,0,updateFunc)

self.jzLeftNum=leftNum
end

function UIFightMainTop:updatejunZhenRight(rightNum)
local old=self.jzRightNum
local widget=self.jzBarItem_2:getChildWidgetBase()

local times=#deathTimeLine
local sub=math.ceil((old-rightNum)/times)
local num=old
local index=1
local delay=0

local updateFunc=function()
if delay<=0 then
old=num
num=num-sub
index=index+1
if index<times then
widget:SetChildText(1,num)
delay=deathTimeLine[index-1]
widget:SetProgressBarAniWithFiveParams(0,old,num,self.battle.jzMaxRight,delay,old>num)
else
widget:SetChildText(1,rightNum)
widget:SetProgressBarAniWithFiveParams(0,old,rightNum,self.battle.jzMaxRight,0.25,old>rightNum)
if self.rightJZTimer then self:stopTimerByID(self.rightJZTimer)end
end
end
delay=delay-0.25
end
updateFunc()
self.rightJZTimer=self:setTimer(0.25,0,updateFunc)

self.jzRightNum=rightNum
end






function UIFightMainTop:doPunchRotation(widget,componentIndex,reddotIndex,isReddot)
if isReddot then
if self.reddotTweenerList==nil then
self.reddotTweenerList={}
end
if not reddotIndex then
reddotIndex=#self.reddotTweenerList+1
end

if self.reddotTweenerList[reddotIndex]==nil then
widget:SetChildRotation(componentIndex,0,0,0)
local tweener=widget:SetChildDOPunchRotation(componentIndex,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweenerList[reddotIndex]={}
self.reddotTweenerList[reddotIndex].tweener=tweener
self.reddotTweenerList[reddotIndex].widget=widget
self.reddotTweenerList[reddotIndex].componentIndex=componentIndex
end

return reddotIndex
else
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return nil
end
if self.reddotTweenerList[reddotIndex]~=nil then
self.reddotTweenerList[reddotIndex].tweener:Complete()
self.reddotTweenerList[reddotIndex].tweener:Kill()
self.reddotTweenerList[reddotIndex]=nil
widget:SetChildRotation(componentIndex,0,0,0)
return nil
end
end
end


function UIFightMainTop:endAllReddotPunchRotation()
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return
end
for i,v in pairs(self.reddotTweenerList)do
if v~=nil then
v.tweener:Complete()
v.tweener:Kill()
local widget=v.widget
local componentIndex=v.componentIndex
widget:SetChildRotation(componentIndex,0,0,0)

self.reddotTweenerList[i]=nil
end
end
end