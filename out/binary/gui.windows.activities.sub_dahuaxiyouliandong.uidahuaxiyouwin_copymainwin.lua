







def_class("UIDaHuaXiYouWin_CopyMainWin",UIWindowBase)









function UIDaHuaXiYouWin_CopyMainWin:bindComponents()

self.backButton=UIButton.get(self,0)
self.background_0=UIObject.get(self,1)
self.background_1=UIButton.get(self,2)
self.centerEffect=UIObject.get(self,3)
self.discipleBtn=UIButton.get(self,4)
self.discipleReddot=UIObject.get(self,5)
self.eventEffect=UIObject.get(self,6)
self.eventHUD=UIObject.get(self,7)
self.eventRoot=UIObject.get(self,8)
self.fightBtn=UIButton.get(self,9)
self.diziRoot=UIObject.get(self,10)
self.goBtn=UIButton.get(self,11)
self.rewardContent=UIObject.get(self,12)
self.expPB=UIObject.get(self,13)
self.expContent=UIObject.get(self,14)
self.wanfajieshao=UIButton.get(self,15)
self.titleText=UIText.get(self,16)
self.titleBg=UIImage.get(self,17)
self.rewardText=UIText.get(self,18)
self.BgImage=UIImage.get(self,19)
self.diziflag=UIImage.get(self,20)

self.backButton:setButtonClick(function()self:onBackButton()end)

self.background_1:setButtonClick(function()self:onBackground_1()end)

self.discipleBtn:setButtonClick(function()self:onDiscipleBtn()end)

self.fightBtn:setButtonClick(function()self:onFightBtn()end)

self.goBtn:setButtonClick(function()self:onGoBtn()end)

self.wanfajieshao:setButtonClick(function()self:onWanfajieshao()end)
self.background={
[0]=self.background_0,
[1]=self.background_1,
}



end


function UIDaHuaXiYouWin_CopyMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backButton);self.backButton=nil;
_UIObject_release(self.background_0);self.background_0=nil;
_UIObject_release(self.background_1);self.background_1=nil;
_UIObject_release(self.centerEffect);self.centerEffect=nil;
_UIObject_release(self.discipleBtn);self.discipleBtn=nil;
_UIObject_release(self.discipleReddot);self.discipleReddot=nil;
_UIObject_release(self.eventEffect);self.eventEffect=nil;
_UIObject_release(self.eventHUD);self.eventHUD=nil;
_UIObject_release(self.eventRoot);self.eventRoot=nil;
_UIObject_release(self.fightBtn);self.fightBtn=nil;
_UIObject_release(self.diziRoot);self.diziRoot=nil;
_UIObject_release(self.goBtn);self.goBtn=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.expPB);self.expPB=nil;
_UIObject_release(self.expContent);self.expContent=nil;
_UIObject_release(self.wanfajieshao);self.wanfajieshao=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.titleBg);self.titleBg=nil;
_UIObject_release(self.rewardText);self.rewardText=nil;
_UIObject_release(self.BgImage);self.BgImage=nil;
_UIObject_release(self.diziflag);self.diziflag=nil;
self.background=nil;
end

















local this


local _eRoundState={
eIdle=1,
eRun=2,
}
local _eventRootHeight=-108
local _BossPos={325,1.5}

local SlotCmp={
widget=-1,
model=0,
model1=1,
}

local BackgroundSprite=5453

local _smokeEffect=11001

local _backgroundSpeed=0.15
local _tweenerType={
background=1,
monsterDisappear=2,
}

local stringF=string.format

local slotwidth=82
local maxwidth=700

local expSlotCmp=
{
selfSlot=-1,
roleIcon=0,
Completed=1,
Bg=2,
BgYellow=3,
}

local _stateRoundHandle={
[_eRoundState.eIdle]={
enter=function(window,param,callback)
local func=function()
window.fightBtn:setActive(true)
if callback then callback()end
end
func()
end,
exit=function(window,param,callback)
window.fightBtn:setActive(false)
if callback then callback()end

end,
},
[_eRoundState.eRun]={
enter=function(window,param,callback)
local posInfo=_BossPos
window:doDiscipleAnimation(eAnimationID.run)
window:animationBackground(posInfo[1],posInfo[2],function()
if callback then callback()end
this.animation=false
window:changeRoundState(_eRoundState.eIdle)
end)
end,
exit=function(window,param,callback)
if callback then callback()end
end,
},
}

local abName="ui/windows/activities/sub_dahuaxiyouliandong/pushmapact_atlas_pak.ab"

local _PlotStateHandle={
[eFangYingTingPlotState.Easy]={
enter=function(window)
window:EasyHandle()
end,
show_cfg=
{
titleName="<color=#FFE46C>%s</color>",
rewardBg="image_fyttuitu_2",
titleBG=function(window)
local sub_actcfg=window.sub_actcfg
local custom=sub_actcfg and sub_actcfg.custonPanelConfig or nil
if custom and custom.image3 and custom.image3[2]then
local spriteName=custom.image3[2]
local spriteAb=custom.image3[1]
return spriteName,spriteAb
end
return"image_fyttuitu_4",abName
end,
BgImage=function(window)
local sub_actcfg=window.sub_actcfg
local custom=sub_actcfg and sub_actcfg.custonPanelConfig or nil
if custom and custom.image5 and custom.image5[2]then
local spriteName=custom.image5[2]
local spriteAb=custom.image5[1]
return spriteName,spriteAb
end
return nil,nil
end,
},
},
[eFangYingTingPlotState.Difficult]={
enter=function(window)
window:DifficultHandle()
end,
show_cfg=
{
titleName="<color=#EE6868>%s</color>",
rewardBg="image_fyttuitu_3",
titleBG=function(window)
local sub_actcfg=window.sub_actcfg
local custom=sub_actcfg and sub_actcfg.custonPanelConfig or nil
if custom and custom.image7 and custom.image7[2]then
local spriteName=custom.image7[2]
local spriteAb=custom.image7[1]
return spriteName,spriteAb
end
return"image_fyttuitu_5",abName
end,
BgImage=function(window)
local sub_actcfg=window.sub_actcfg
local custom=sub_actcfg and sub_actcfg.custonPanelConfig or nil
if custom and custom.image6 and custom.image6[2]then
local spriteName=custom.image6[2]
local spriteAb=custom.image6[1]
return spriteName,spriteAb
end
return nil,nil
end,
},
},
}




function UIDaHuaXiYouWin_CopyMainWin:onLoaded(...)
self:bindComponents()
this=self
self.tweeners={}
self.diziRootWidget=self.diziRoot:getChildWidgetBase()
self.eventRootWidget=self.eventRoot:getChildWidgetBase()
end


function UIDaHuaXiYouWin_CopyMainWin:__delete()
this=nil
self:unbindComponents()
end




function UIDaHuaXiYouWin_CopyMainWin:onShow(argtable,afterOnloaded)
self.actID=argtable.actID
self.subType=argtable.subType
self.subid=argtable.subid

self.selectPushMapId=argtable.selectPushMapId



self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.info=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.custom=(self.sub_actcfg and self.sub_actcfg.custonPanelConfig)or{}

local img1=self.custom.image1
if img1 and img1[1]and img1[2]then
self.fightBtn:setSprite(img1[1],img1[2],false)
end


self.selectWhichAct=self.myData.selectWhichAct

self.selectPlotState=self.myData.selectPlotState

self.fightResult=self.myData.fightResult
if not self.selectPushMapId then
self.selectPushMapId=self.myData.selectPushMapId
end

self:initShow()
end


function UIDaHuaXiYouWin_CopyMainWin:initShow()
self:setBackgroundSprite()
self.TongGuan=(#self.PushMapCfg.monList==self.PushMapData.progress and self.fightResult)
self:refreshShow()
self.eventRoot:setChildAnchoredPos(_BossPos[1],_eventRootHeight)
local func=function()
if this then
this:changeRoundState(_eRoundState.eIdle)
end
end

if not self.fightResult then
self:delayDo(0.5,func)
else

if self.TongGuan then
self:gongXiTongGuan()
else
self.myData.fightResult=false
local func=function()
if this then
this:monsterDisappearAnimation()
end
end
self:delayDo(0.5,func)
end
end
end


function UIDaHuaXiYouWin_CopyMainWin:refreshShow()
self:refreshBackground()
self:initDiscipleItem()
self:initBossItem()
self:refreshRewardPanel()
self:initProgressItem()
self:setProgress()
end



function UIDaHuaXiYouWin_CopyMainWin:onHide()

end





function UIDaHuaXiYouWin_CopyMainWin:setBackgroundSprite()
self.PushMapData=self.info:getCommonActInfoData(self.selectWhichAct,self.selectPushMapId)
self.PushMapCfg=cfg_acttutuiconfig_get(self.selectPushMapId)
BackgroundSprite=self.PushMapCfg.BG
local titleName=self.PushMapCfg.titleName
local handle=_PlotStateHandle[self.selectPlotState]

local cfg=handle.show_cfg
local titleSprite,titleAbName=cfg.titleBG(self)
titleAbName=titleAbName or abName
local BgImageSprite,BgImageAbName=cfg.BgImage(self)

self.titleBg:setSprite(titleAbName,titleSprite,false)
self.titleText:setText(stringF(cfg.titleName,titleName))
if(BgImageSprite and BgImageAbName)then
self.BgImage:setSprite(BgImageAbName,BgImageSprite,false)
else
self.BgImage:setSprite(abName,cfg.rewardBg,false)
end
self.rewardText:setText(stringF(cfg.titleName,"本关\n奖励"))
end


function UIDaHuaXiYouWin_CopyMainWin:refreshBackground()
self.bgUse=0
for i,v in pairs(self.background)do
if i==self.bgUse then
v:setChildUIModelShowTarget(BackgroundSprite,1,{},eAnimationID.stand,false,false,0)
self.winlua:SetChildUIModelAnimationSpeed(v:getID(),0)
v:setChildCanvasGroupAlpha(1)
self.bgId=BackgroundSprite
else
v:setChildUIModelRemoveTarget()
v:setChildCanvasGroupAlpha(0)
end
end
end

function UIDaHuaXiYouWin_CopyMainWin:animationBackground(pos,duration,callback)
local sequence=Lua.SequenceProxy.New()



if self.bgId~=BackgroundSprite then
for i,v in pairs(self.background)do
if self.bgUse==i then
local tween=v:setChildCanvasGroupDOFade(0,duration)
tween:SetEase(DG.Tweening.Ease.Linear)
self.winlua:SetChildUIModelAnimationSpeed(v:getID(),_backgroundSpeed)
sequence:Join(tween)
else
self.bgUse=i
v:setChildUIModelShowTarget(BackgroundSprite,1,{},eAnimationID.stand,false,false,0,function()
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

sequence:AppendInterval(0.8)

sequence:AppendCallback(function()

self:freezeBackground()
self:doDiscipleAnimation(eAnimationID.stand)
self.diziflag:setChildCanvasGroupAlpha(0)
self.diziflag:setChildCanvasGroupDOFade(1,0.5,nil)

self.eventEffect:setScale(Vector3(1,1,1))
self.eventEffect:setChildShowEffect(_smokeEffect,true)

self:delayDo(0.5,function()

local groupID=self.PushMapCfg.monList[self.PushMapData.progress+1]
local mcfg=cfgHelper.get1(cfg_monstergroup_get,groupID)
local modelCfg=mcfg.model
self.eventRootWidget:SetChildUIModelShowTarget(SlotCmp.model,modelCfg[1],modelCfg[2],modelCfg[3]or defaultT,eAnimationID.idle,false,false,0,nil)
self.eventRoot:setChildCanvasGroupDOFade(1,0.5)

end)
end)
sequence:AppendInterval(1)
sequence:AppendCallback(function()
self.diziflag:setChildCanvasGroupDOFade(0,0.5,nil)
end)
sequence:AppendCallback(callback)
self:setDoTween(_tweenerType.background,sequence)
end


function UIDaHuaXiYouWin_CopyMainWin:changeRoundState(state,param,callback)
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

function UIDaHuaXiYouWin_CopyMainWin:freezeBackground()
for i,v in pairs(self.background)do
self.winlua:SetChildUIModelAnimationSpeed(v:getID(),0)
end
end

function UIDaHuaXiYouWin_CopyMainWin:setDoTween(index,tweener)
self:cleanDoTween(index,true)
self.tweeners[index]=tweener
end

function UIDaHuaXiYouWin_CopyMainWin:cleanDoTween(index,complete)
local tweener=self.tweeners[index]
if tweener and tweener:IsActive()then
tweener:Kill(complete)
end
end

function UIDaHuaXiYouWin_CopyMainWin:killAllDoTween()
for i,v in pairs(self.tweeners)do
if v:IsActive()then
v:Kill()
end
end
end

function UIDaHuaXiYouWin_CopyMainWin:onBackButton()












if UIManager:isActive("UIFightPrepareLoading")then
this:closeWin()
else
UIManager:showWindow("UIFightPrepareLoading",{
startCallback=function()
this:closeWin()
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
})
end
end


function UIDaHuaXiYouWin_CopyMainWin:closeWin()
self:closeSelf()
end


function UIDaHuaXiYouWin_CopyMainWin:onBackground_1()

end


function UIDaHuaXiYouWin_CopyMainWin:onWanfajieshao()

local args={
ruleGroupID=self.sub_actcfg.tuituHelp,
}
self:showWindow("UIRuleTipsImage2Win",args)
end


function UIDaHuaXiYouWin_CopyMainWin:onDiscipleBtn()
local args={actID=self.actID,subType=self.subType,subid=self.subid,winName="UIDaHuaXiYouWin_CopyMainWin"}
local func=function(args_)

activitiesController:jump(args_.actID,args_.subType,args_.subid,{isRefresh=true,winName=args.winName})
end
fullScreenUI.setNextActiveUICallback(func,args)
UIFullDiscipleSelectControl:showDiscipleSelectWindow()
end



function UIDaHuaXiYouWin_CopyMainWin:onFightBtn()
if self.onFightBtnClick then
return
end
local leftmodelCfg={4737,1}
local actid=self.actID
local subType=self.subType
local subid=self.subid
self:doBossAnimation(eAnimationID.attack1)
self.eventRootWidget:SetChildUIModelShowTarget(SlotCmp.model1,leftmodelCfg[1],leftmodelCfg[2],defaultT,eAnimationID.stand,false,false,0,nil)
local bossGroupId=self.PushMapCfg.monList[self.PushMapData.progress+1]
local titleName=self.PushMapCfg.titleName
local result=string.match(titleName,"-(.+)")
local func=function()
if this then
self.onFightBtnClick=false

local mcfg=cfgHelper.get(cfg_monstergroup_get,bossGroupId)
local index=self.PushMapData.index
fightController.showPrepareWin(fightPreSelectModel.fightType.tuitu,
{
enterTxt=result,
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
isHomeBattle=true,
monsterList=mcfg.monList,
groupId=bossGroupId,
editorTeam=false,
setteamlist_nil=false,
closeByCloud=true,
enterCallBack=function(guidList,zfId)
fightLaunchController:sendFight(eBattleLaunch.activitiesPushMap,guidList,mcfg.mapId or 0,zfId,{index})
end,
cancelCallBack=function()
activitiesController:jump(actid,subType,subid)
local tempArgtable={actID=actid,subType=SUB_ACTIVITY_TYPE.eFangYingTing,subid=subid}
local winName="UIDaHuaXiYouWin_CopyMainWin"
UIManager:showWindow(winName,tempArgtable)
end,
}
)
end
end
self.onFightBtnClick=true
self:delayDo(0.8,func)


end



function UIDaHuaXiYouWin_CopyMainWin:onGoBtn()

end



function UIDaHuaXiYouWin_CopyMainWin:doDiscipleAnimation(anim)
self.diziRootWidget:SetChildModelAnimationState(SlotCmp.model,anim)
end


function UIDaHuaXiYouWin_CopyMainWin:initDiscipleItem()
local leftmodelCfg=self.PushMapCfg.DiscipleCfg
local modelParams=npcModel:getImageInfoOutSide(leftmodelCfg[1])
self.diziRootWidget:SetChildUIModelShowTarget(SlotCmp.model,modelParams.body,leftmodelCfg[2],modelParams.componets or defaultT,modelParams.anim,false,false,0,nil)
self.diziRootWidget:SetChildUIModelShowFlipX(SlotCmp.model,true)
end


function UIDaHuaXiYouWin_CopyMainWin:doBossAnimation(anim)
self.eventRootWidget:SetChildModelAnimationState(SlotCmp.model,anim)
end


function UIDaHuaXiYouWin_CopyMainWin:initBossItem()
local groupID=self.PushMapCfg.monList[self.PushMapData.progress+1]
if not groupID then
self.eventRootWidget:SetChildActive(-1,false)
return
end
if not self.fightResult then
local mcfg=cfgHelper.get1(cfg_monstergroup_get,groupID)
local modelCfg=mcfg.model
self.eventRootWidget:SetChildUIModelShowTarget(SlotCmp.model,modelCfg[1],modelCfg[2],modelCfg[3]or defaultT,eAnimationID.idle,false,false,0,nil)
end
end



function UIDaHuaXiYouWin_CopyMainWin:monsterDisappearAnimation()
AudioManager.playAudio(662)
self.animation=true
local sequence=Lua.SequenceProxy.New()
self.eventRoot:setChildCanvasGroupDOFade(0,0)
sequence:AppendCallback(function()
this:changeRoundState(_eRoundState.eRun)

this:refreshRewardPanel()
end)
self:setDoTween(_tweenerType.monsterDisappear,sequence)
end


function UIDaHuaXiYouWin_CopyMainWin:refreshRewardPanel()
local bossGroupId=self.PushMapCfg.monList[self.PushMapData.progress+1]or self.PushMapCfg.monList[self.PushMapData.progress]
local bossGroupCfg=cfg_monstergroup_get(bossGroupId)
local dropsCfg=cfg_awardconfig_get(bossGroupCfg.drops[1])
local rewardList=dropsCfg.showItems or defaultT
self.rewardContent:setChildLayoutGroupCreateItems(#rewardList,function(index)
local item=self.rewardContent:getChildLayoutGroupGridItem(index-1)
local itemId,itemNum=unpack(rewardList[index])
local countStr=mathHelper.formatNumber(itemNum)
local conf={itemid=itemId,itemcount=countStr,showCountBG=true,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(-1,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetChildPropData(-1,prop)
end)

end




function UIDaHuaXiYouWin_CopyMainWin:initProgressItem()
local progress=self.PushMapData.progress
local monList=self.PushMapCfg.monList
local Count=monList
local RemainingSpacing=maxwidth-#Count*slotwidth
local Spacing=string.format("%.1f",RemainingSpacing/(#Count-1))
self.expContent:setChildLayoutGroupCreateItems(#Count,function(index)
local item=self.expContent:getChildLayoutGroupGridItem(index-1)
local isCompleted=progress>=index
local posx=(index-1)*slotwidth+(index-1)*Spacing
item:SetChildAnchoredPosition(expSlotCmp.selfSlot,Vector2(posx,0))
item:SetChildActive(expSlotCmp.Completed,isCompleted)
item:SetChildActive(expSlotCmp.BgYellow,isCompleted or progress==index-1)

local img4=self.custom.image4
if img4 and img4[1]and img4[2]then
item:SetChildCSImageSprite(expSlotCmp.roleIcon,img4[1],img4[2])
end
item:SetChildActive(expSlotCmp.roleIcon,progress==index-1)
end)
end


function UIDaHuaXiYouWin_CopyMainWin:setProgress()
local progress=self.PushMapData.progress
local monList=self.PushMapCfg.monList
self.expPB:setActive(#monList~=1)
if#monList~=1 then
local exp=progress
local needExp=#monList-1
self.expPB:setChildUIProgressbar(exp,needExp,false)
end
end


function UIDaHuaXiYouWin_CopyMainWin:gongXiTongGuan()
if self.fightResult and self.TongGuan then
self:delayDo(0.2,function()
UIManager:showWindow("UIFightEffect",{para=20367})
end)

self:delayDo(1.5,function()

local handle=_PlotStateHandle[self.selectPlotState]
if handle then
handle.enter(self)
end
end)

self.myData.fightResult=false
end
end


function UIDaHuaXiYouWin_CopyMainWin:refreshTongGuan()

end

function UIDaHuaXiYouWin_CopyMainWin:switchState()
self.switchState=true
self.fightResult=false
self.eventRootWidget:SetChildActive(-1,true)
self:initShow()
end

function UIDaHuaXiYouWin_CopyMainWin:EasyHandle()
local PushMapId,PlotState=self.info:checkPushMapId(self.sub_actcfg,self.selectWhichAct)
self.info:changePushMapId(PushMapId,PlotState)
self.selectPushMapId=self.myData.selectPushMapId
self.selectPlotState=self.myData.selectPlotState

self:showWindow('UIFangYingTingTongGuanWin',{
PlotState=eFangYingTingPlotState.Easy,
sub_actcfg=self.sub_actcfg,
})
end

function UIDaHuaXiYouWin_CopyMainWin:DifficultHandle()
self:showWindow('UIFangYingTingTongGuanWin',{
PlotState=eFangYingTingPlotState.Difficult,
sub_actcfg=self.sub_actcfg,
})
end

