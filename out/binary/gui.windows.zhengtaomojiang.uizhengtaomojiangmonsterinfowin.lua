







def_class("UIZhengTaoMoJiangMonsterInfoWin",UIWindowBase)









function UIZhengTaoMoJiangMonsterInfoWin:bindComponents()

self.background=UIButton.get(self,0)
self.buffBg=UIObject.get(self,1)
self.buffBtn=UIButton.get(self,2)
self.buffItem_1=UIText.get(self,3)
self.buffItem_2=UIText.get(self,4)
self.buffTips=UIButton.get(self,5)
self.buffTx=UIText.get(self,6)
self.closeBtn=UIButton.get(self,7)
self.deadRoot=UIObject.get(self,8)
self.fazeList=UIObject.get(self,9)
self.fazeView=UIObject.get(self,10)
self.fightBtn=UIButton.get(self,11)
self.fightCntTx=UIText.get(self,12)
self.head=UIObject.get(self,13)
self.headBG=UIButton.get(self,14)
self.headEmpty=UIObject.get(self,15)
self.helpBtn=UIButton.get(self,16)
self.hpProgressBar=UIProgress.get(self,17)
self.infoPanel=UIObject.get(self,18)
self.infoSelect=UIObject.get(self,19)
self.infoTab=UIButton.get(self,20)
self.killTime=UIText.get(self,21)
self.killTips=UIText.get(self,22)
self.killTipsBg=UIObject.get(self,23)
self.leftBtn=UIButton.get(self,24)
self.liveRoot=UIObject.get(self,25)
self.lockTx=UIText.get(self,26)
self.lockTxBg=UIObject.get(self,27)
self.monsterModel=UIObject.get(self,28)
self.monsterName=UIText.get(self,29)
self.openCDBg=UIObject.get(self,30)
self.openCDTx=UIText.get(self,31)
self.playerName=UIText.get(self,32)
self.rankBtn=UIButton.get(self,33)
self.recordBtn=UIButton.get(self,34)
self.rewardBtn=UIButton.get(self,35)
self.rewardReddot=UIObject.get(self,36)
self.rightBtn=UIButton.get(self,37)
self.root=UIObject.get(self,38)
self.serverName=UIText.get(self,39)
self.skillList=UIObject.get(self,40)
self.skillPanel=UIObject.get(self,41)
self.skillSelect=UIObject.get(self,42)
self.skillTab=UIButton.get(self,43)
self.skillView=UIObject.get(self,44)
self.spine=UIObject.get(self,45)
self.stageBg=UIObject.get(self,46)
self.stageBtn=UIButton.get(self,47)
self.stageCheck=UIText.get(self,48)
self.stageRule=UIText.get(self,49)
self.stageTips=UIButton.get(self,50)
self.stageTx=UIText.get(self,51)
self.stateBtn=UIButton.get(self,52)
self.stateCDBg=UIObject.get(self,53)
self.stateCDTx=UIText.get(self,54)
self.stateTx=UIText.get(self,55)
self.timeTx=UIText.get(self,56)
self.xmBGIcon=UIButton.get(self,57)
self.xmIcon=UIImage.get(self,58)
self.xmKuangIcon=UIImage.get(self,59)
self.xmName=UIText.get(self,60)
self.mjslpanel=UIObject.get(self,61)
self.mjslskill=UIObject.get(self,62)

self.background:setButtonClick(function()self:onBackground()end)

self.buffBtn:setButtonClick(function()self:onBuffBtn()end)

self.buffTips:setButtonClick(function()self:onBuffTips()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.fightBtn:setButtonClick(function()self:onFightBtn()end)

self.headBG:setButtonClick(function()self:onHeadBG()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.infoTab:setButtonClick(function()self:onInfoTab()end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.skillTab:setButtonClick(function()self:onSkillTab()end)

self.stageBtn:setButtonClick(function()self:onStageBtn()end)

self.stageTips:setButtonClick(function()self:onStageTips()end)

self.stateBtn:setButtonClick(function()self:onStateBtn()end)

self.xmBGIcon:setButtonClick(function()self:onXmBGIcon()end)
self.buffItem={
self.buffItem_1,
self.buffItem_2,
}



end


function UIZhengTaoMoJiangMonsterInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.buffBg);self.buffBg=nil;
_UIObject_release(self.buffBtn);self.buffBtn=nil;
_UIObject_release(self.buffItem_1);self.buffItem_1=nil;
_UIObject_release(self.buffItem_2);self.buffItem_2=nil;
_UIObject_release(self.buffTips);self.buffTips=nil;
_UIObject_release(self.buffTx);self.buffTx=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.deadRoot);self.deadRoot=nil;
_UIObject_release(self.fazeList);self.fazeList=nil;
_UIObject_release(self.fazeView);self.fazeView=nil;
_UIObject_release(self.fightBtn);self.fightBtn=nil;
_UIObject_release(self.fightCntTx);self.fightCntTx=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.headBG);self.headBG=nil;
_UIObject_release(self.headEmpty);self.headEmpty=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.hpProgressBar);self.hpProgressBar=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.infoSelect);self.infoSelect=nil;
_UIObject_release(self.infoTab);self.infoTab=nil;
_UIObject_release(self.killTime);self.killTime=nil;
_UIObject_release(self.killTips);self.killTips=nil;
_UIObject_release(self.killTipsBg);self.killTipsBg=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.liveRoot);self.liveRoot=nil;
_UIObject_release(self.lockTx);self.lockTx=nil;
_UIObject_release(self.lockTxBg);self.lockTxBg=nil;
_UIObject_release(self.monsterModel);self.monsterModel=nil;
_UIObject_release(self.monsterName);self.monsterName=nil;
_UIObject_release(self.openCDBg);self.openCDBg=nil;
_UIObject_release(self.openCDTx);self.openCDTx=nil;
_UIObject_release(self.playerName);self.playerName=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.serverName);self.serverName=nil;
_UIObject_release(self.skillList);self.skillList=nil;
_UIObject_release(self.skillPanel);self.skillPanel=nil;
_UIObject_release(self.skillSelect);self.skillSelect=nil;
_UIObject_release(self.skillTab);self.skillTab=nil;
_UIObject_release(self.skillView);self.skillView=nil;
_UIObject_release(self.spine);self.spine=nil;
_UIObject_release(self.stageBg);self.stageBg=nil;
_UIObject_release(self.stageBtn);self.stageBtn=nil;
_UIObject_release(self.stageCheck);self.stageCheck=nil;
_UIObject_release(self.stageRule);self.stageRule=nil;
_UIObject_release(self.stageTips);self.stageTips=nil;
_UIObject_release(self.stageTx);self.stageTx=nil;
_UIObject_release(self.stateBtn);self.stateBtn=nil;
_UIObject_release(self.stateCDBg);self.stateCDBg=nil;
_UIObject_release(self.stateCDTx);self.stateCDTx=nil;
_UIObject_release(self.stateTx);self.stateTx=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
_UIObject_release(self.xmBGIcon);self.xmBGIcon=nil;
_UIObject_release(self.xmIcon);self.xmIcon=nil;
_UIObject_release(self.xmKuangIcon);self.xmKuangIcon=nil;
_UIObject_release(self.xmName);self.xmName=nil;
_UIObject_release(self.mjslpanel);self.mjslpanel=nil;
_UIObject_release(self.mjslskill);self.mjslskill=nil;
self.buffItem=nil;
end















local _this=nil
local slskillidx=
{
skillbtn=0,
icon=1,
name=2,
djsbg=3,
djs=4
}



function UIZhengTaoMoJiangMonsterInfoWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
self:addNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
self:addNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
self:addNotify(notifyConfig.onNewDay,self.onNewDay)
self:addProNotify(39,11,self.on_39_11)
self:addProNotify(39,10,self.on_39_10)
self:addProNotify(39,185,self.on_39_185)
self:addProNotify(39,2,self.on_39_2)
self:initView()
end


function UIZhengTaoMoJiangMonsterInfoWin:__delete()
self:unbindComponents()
_this=nil
self:stopSelfTimerMJSL()
self:stopStateTick()
self:stopInfoTick()


if self.monsterTween and self.monsterTween:IsActive()then
self.monsterTween:Kill()
self.monsterTween=nil
end
end




function UIZhengTaoMoJiangMonsterInfoWin:onShow(argtable,afterOnloaded)
self.seasonType=argtable.seasonType
self.stageIndex=argtable.stageIndex
self.build_id=argtable.build_id
self:updateData()
self:refreshView(afterOnloaded)

if self.entityData.killTime<=0 and limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eMoJiang)and timeHelper.getServerShortTime()>=self.stage.beginTime+self.stageCfg.open then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.FirstCanFightMoJiang)
end
end


function UIZhengTaoMoJiangMonsterInfoWin:onHide()

end




function UIZhengTaoMoJiangMonsterInfoWin:onBackground()
self:closeSelf()
end

function UIZhengTaoMoJiangMonsterInfoWin:onCloseBtn()
self:closeSelf()
end


function UIZhengTaoMoJiangMonsterInfoWin:onBuffBtn()
self.buffTips:setActive(true)

if self.initTips==nil then
for i,v in ipairs(self.buffItem)do
self.winlua:ForceLayoutRect(v:getID())
end
self.winlua:ForceLayoutRect(self.buffBg:getID())
self.initTips=true
end
end


function UIZhengTaoMoJiangMonsterInfoWin:onBuffTips()
self.buffTips:setActive(false)
end


function UIZhengTaoMoJiangMonsterInfoWin:onFightBtn()
if not limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eMoJiang)then
UIManager.error(self.openStr)
return
end

if self.entityData.fightTimes>=self.stageCfg.times then
UIManager.error("今日剩余次数不足")
return
end







local flag,g_list,errorParams=self.entityData:checkMovePathCondition(true)

if not flag then
if errorParams then
local errStr=""
local isSelfInNeutralArea=errorParams.isSelfInNeutralArea
local isTargetInNeutralArea=errorParams.isTargetInNeutralArea
if isSelfInNeutralArea then

errStr="处于阵外无法进攻本阵内的魔将"
elseif isTargetInNeutralArea then

errStr="处于本阵内无法进攻阵外的魔将"
else

errStr="处于本阵内无法进攻其他本阵内的魔将"
end
UIManager.error(errStr)
end
return
end
local seasonType=self.seasonType
local stageIndex=self.stageIndex
local build_id=self.build_id

local doFunc=function()
local wayTime=self.entityData:getBaseWayTime()
local args={
callback=function(selectDzList,selectMoneyList,boatId)
local params=jsonHelper.encode({seasonType,stageIndex})
local guid=mathHelper.number_to_int64(build_id)
xianjieController:reqOrder(guid,xjOrderType.eAttackBoss,selectDzList,selectMoneyList,params,boatId,nil,g_list)
end,
confirmCheckFunc=function()
local leftTime=limitActivitiesModel:getActEndLeftTime(LIMIT_ACT_TYPE.eMoJiang)
if leftTime<=wayTime then
UIManager.error("活动剩余时间已不足挑战魔将")
return false,1,nil
end
return true
end,




wayTime=wayTime,
orderType=xjOrderType.eAttackBoss
}
UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx(args)
end

if xianjieModel:checkMoJiangFightPlot(seasonType,stageIndex,build_id)then
doFunc()
else
local config=seasonModel:getStageConfigEx(seasonType,stageIndex,"mojiang",build_id)
if config.plot then
xianjieModel:setMoJiangFightPlot(seasonType,stageIndex,build_id)
worldStoryController:showStoryTree(config.plot,doFunc,nil,nil,{isFullOpen=false})
else
doFunc()
end
end
end


function UIZhengTaoMoJiangMonsterInfoWin:onHelpBtn()





local args={
ruleGroupID=ruleTipsImageGroup.eZhengTaoMoJiang,
}
UIManager:showWindow("UIRuleTipsImage2Win",args)
end


function UIZhengTaoMoJiangMonsterInfoWin:onInfoTab()
if self.tabSelect==1 then return end
self.tabSelect=1
self.infoSelect:setActive(true)
self.infoPanel:setActive(true)
self.skillSelect:setActive(false)
self.skillPanel:setActive(false)

local items=self.fazeList:getChildLayoutGroupGridList()
for i=1,items.Count do
local item=items[i-1]
item:ForceLayoutRect(2)
item:ForceLayoutRect(4)
end
self.winlua:ForceLayoutRect(self.fazeList:getID())
end


function UIZhengTaoMoJiangMonsterInfoWin:onRankBtn()
local args={
parentWin=self,
seasonType=self.seasonType,
stageIndex=self.stageIndex,
build_id=self.build_id,
}
self:showWindow("UIZhengTaoMoJiangRankWin",args)
end


function UIZhengTaoMoJiangMonsterInfoWin:onRecordBtn()
local args={
parentWin=self,
seasonType=self.seasonType,
stageIndex=self.stageIndex,
build_id=self.build_id,
}
self:showWindow("UIZhengTaoMoJiangFightRecordWin",args)
end


function UIZhengTaoMoJiangMonsterInfoWin:onRewardBtn()
local args={
parentWin=self,
seasonType=self.seasonType,
stageIndex=self.stageIndex,
build_id=self.build_id,
}
self:showWindow("UIZhengTaoMoJiangRewardWin",args)
end


function UIZhengTaoMoJiangMonsterInfoWin:onSkillTab()
if self.tabSelect==2 then return end
self.tabSelect=2
self.infoSelect:setActive(false)
self.infoPanel:setActive(false)
self.skillSelect:setActive(true)
self.skillPanel:setActive(true)

local items=self.skillList:getChildLayoutGroupGridList()
for i=1,items.Count do
local item=items[i-1]
item:ForceLayoutRect(3)
item:ForceLayoutRect(6)
end
self.winlua:ForceLayoutRect(self.skillList:getID())
end


function UIZhengTaoMoJiangMonsterInfoWin:onStateBtn()
local args={
parentWin=self,
seasonType=self.seasonType,
stageIndex=self.stageIndex,
build_id=self.build_id,
}
self:showWindow("UIZhengTaoMoJiangMonsterStateWin",args)
end

function UIZhengTaoMoJiangMonsterInfoWin:onLeftBtn()
self.sortIndex=self.sortIndex-1
if self.sortIndex<=0 then
self.sortIndex=#self.sortData
end
self.build_id=self.sortData[self.sortIndex].id
self.buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.build_id)
self.entityData=xianjieModel:getMoJiangEntity(self.seasonType,self.stageIndex,self.build_id)
self.stageCfg=self.stage:getConfig("mojiang",self.entityData.build_id)
self.monsterCfg=cfgHelper.get1(cfg_monstergroup_get,self.entityData.monster_id)
self:refreshView()
end

function UIZhengTaoMoJiangMonsterInfoWin:onRightBtn()
self.sortIndex=self.sortIndex+1
if self.sortIndex>#self.sortData then
self.sortIndex=1
end
self.build_id=self.sortData[self.sortIndex].id
self.buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.build_id)
self.entityData=xianjieModel:getMoJiangEntity(self.seasonType,self.stageIndex,self.build_id)
self.stageCfg=self.stage:getConfig("mojiang",self.entityData.build_id)
self.monsterCfg=cfgHelper.get1(cfg_monstergroup_get,self.entityData.monster_id)
self:refreshView()
end


function UIZhengTaoMoJiangMonsterInfoWin:onHeadBG()
if self.entityData.bestPlayer and mathHelper.validInt64(self.entityData.bestPlayer.actorId)then
otherPlayerController:openOtherPlayerInfoWin(self.entityData.bestPlayer.actorId,nil,nil,{serverid=self.entityData.bestPlayer.actorServer,isXianJie=true})
end
end


function UIZhengTaoMoJiangMonsterInfoWin:onXmBGIcon()
if self.entityData.bestGuild and mathHelper.validInt64(self.entityData.bestGuild.guildId)and self.entityData.bestGuild.guildIcon>0 and self.entityData.bestGuild.guildName~=""then
local _xmData=xianjieModel:getXianMengData(self.entityData.bestGuild.guildId)
if _xmData then
local isOther=xianjienSceneIndexType:isOhterXianYu(_xmData.ownersceneidx)
if not isOther then
local wincfg=UIManager.get_window_config(self.__name)
xianmengController:openXMDetailInfoWin(self.entityData.bestGuild.guildId,wincfg.canvas+1)
else
UIManager.error('不同仙域的仙盟，无法探知其信息')
end
return
end
end
UIManager.info("不可知的神秘仙盟")
end


function UIZhengTaoMoJiangMonsterInfoWin:onStageBtn()
self.stageTips:setActive(true)
self.winlua:ForceLayoutRect(self.stageBg:getID())
end


function UIZhengTaoMoJiangMonsterInfoWin:onStageTips()
self.stageTips:setActive(false)
end

function UIZhengTaoMoJiangMonsterInfoWin:initView()
local stageStr=cfgHelper.getlang("zhengtaomojiangstagetips")
local obj=self.stageCheck:getGameObject()
local width=self.stageCheck:getChildSizeDeltaX()
stageStr=comHelper.getCheckLayoutStr(obj,width,stageStr)
self.stageRule:setText(stageStr)
self.winlua:ForceLayoutRect(self.stageRule:getID())
self.winlua:ForceLayoutRect(self.stageBg:getID())
end

function UIZhengTaoMoJiangMonsterInfoWin:updateData()
self.buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.build_id)
self.entityData=xianjieModel:getMoJiangEntity(self.seasonType,self.stageIndex,self.build_id)
self.stage=seasonModel:getStage(self.seasonType,self.stageIndex)
self.stageCfg=self.stage:getConfig("mojiang",self.entityData.build_id)
self.monsterCfg=cfgHelper.get1(cfg_monstergroup_get,self.entityData.monster_id)
self.sortData=xianjieModel:getMoJiangSortList(self.seasonType,self.stageIndex)
for i,v in ipairs(self.sortData)do
if v.id==self.build_id then
self.sortIndex=i
break
end
end
self.tabSelect=self.tabSelect or 1

self.actCfg=limitActivitiesModel:getActConfig(LIMIT_ACT_TYPE.eMoJiang)
self.openHour=nil
self.openMin=nil
for i,v in ipairs(self.actCfg.status)do
if v.statusid==2 then
self.openHour=v.hour
self.openMin=v.min
break
end
end
local str=timeHelper.format_time_stamp3(self.openHour*3600+self.openMin*60)
self.openStr=FMT.fmt("每日{0}开启征讨",str)
self.lockTx:setText(self.openStr)
end

function UIZhengTaoMoJiangMonsterInfoWin:refreshView(init)
local isLive=self.entityData.killTime<=0
self.liveRoot:setActive(isLive)
self.deadRoot:setActive(not isLive)
self.recordBtn:setActive(isLive)

if isLive then
self:refreshLiveView(init)
else
self:refreshDeadView(init)
end
self:refreshRewardReddot()
self.initTips=nil




if not isLive and self.stageCfg.plot2~=nil and not xianjieModel:checkMoJiangDeadPlot(self.seasonType,self.stageIndex,self.build_id)then
xianjieModel:setMoJiangDeadPlot(self.seasonType,self.stageIndex,self.build_id)
worldStoryController:showStoryTree(self.stageCfg.plot2,nil,nil,nil,{isFullOpen=false})
end
end

function UIZhengTaoMoJiangMonsterInfoWin:refreshRewardReddot()
local rewardReddot=self.entityData:checkRewardReddot()
self.rewardReddot:setActive(rewardReddot)
end

function UIZhengTaoMoJiangMonsterInfoWin:refreshDeadView(init)
self.xmBGIcon:setActive(true)
self.xmName:setText(self.entityData.bestGuild and self.entityData.bestGuild.guildName~=""and self.entityData.bestGuild.guildName or"神秘仙盟")
local image=self.entityData.bestGuild and self.entityData.bestGuild.guildIcon>0 and xianmengModel.splitGuildIcon(self.entityData.bestGuild.guildIcon)or xianmengModel.getDefualtGuildIamge()
local abname=globalABLookup.xianmengicons
self.xmIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))
self.xmBGIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))
self.xmKuangIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

if self.entityData.bestPlayer and mathHelper.validInt64(self.entityData.bestPlayer.actorId)then
self.headEmpty:setActive(false)
playerController:setHeadIcon(self.winlua,self.head:getID(),{iconInfo=self.entityData.bestPlayer.iconInfo})
self.playerName:setText(self.entityData.bestPlayer.actorName)
self.serverName:setText(loginModel:getServerName(self.entityData.bestPlayer.actorServer))
else
self.headEmpty:setActive(true)
playerController:setHeadIcon(self.winlua,self.head:getID(),nil)
self.playerName:setText("")
self.serverName:setText("")
end

local str=FMT.fmt("斩杀<color=#c82c2c>{0}</color>时刻",self.buildCfg.name)
self.killTips:setText(str)
self.killTime:setText(timeHelper.getFormatByShortStamp6(self.entityData.killTime))
self.winlua:ForceLayoutRect(self.killTips:getID())
self.winlua:ForceLayoutRect(self.killTipsBg:getID())

local buffs=self.stageCfg.buff
local buffStr=nil
for i,v in ipairs(buffs)do
local str=nil
if v[1]==1 then
str=homeBuffModel:getBuffDescByStateId(v[2])
elseif v[1]==2 then
str=cfgHelper.get2(cfg_fairylandbuffconfig_get,v[2],"desc2")
end
if str then
buffStr=buffStr and string.format("%s\n%s",buffStr,str)or str
end
end
self.buffTx:setText(buffStr or"")

self:refreshStateData(self.entityData.killTime,init)
end

function UIZhengTaoMoJiangMonsterInfoWin:refreshLiveView(init)
local nowTime=timeHelper.getServerShortTime()

self.infoSelect:setActive(self.tabSelect==1)
self.infoPanel:setActive(self.tabSelect==1)

self.skillSelect:setActive(self.tabSelect==2)
self.skillPanel:setActive(self.tabSelect==2)

local buffWidget=self.buffItem_1:getWidgetBase()
local str=FMT.fmt("击败<color=#efb150>{0}</color>后，积分排名第一的仙盟会占领本堡垒",self.buildCfg.name)
local obj=buffWidget:GetChildGameObject(1)
local width=buffWidget:GetChildSizeDeltaX(1)
str=comHelper.getCheckLayoutStr(obj,width,str)
self.buffItem_1:setText(str)

local buffs=self.stageCfg.buff
local buffStr=nil
for i,v in ipairs(buffs)do
local str=nil
if v[1]==1 then
str=homeBuffModel:getBuffDescByStateId(v[2])
elseif v[1]==2 then
str=cfgHelper.get2(cfg_fairylandbuffconfig_get,v[2],"desc")
end
if str then
buffStr=buffStr and string.format("%s\n%s",buffStr,str)or str
end
end
buffWidget=self.buffItem_2:getWidgetBase()
str=FMT.fmt("归属仙盟所有盟员获得效果：\n<color=#aae252>{0}</color>",buffStr)
obj=buffWidget:GetChildGameObject(1)
width=buffWidget:GetChildSizeDeltaX(1)
str=comHelper.getCheckLayoutStr(obj,width,str)
self.buffItem_2:setText(str)


local stageStr=tostring(self.entityData.stage)
self.stageTx:setText(stageStr)

self.monsterName:setText(self.buildCfg.name)

if self.monsterTween and self.monsterTween:IsActive()then
self.monsterTween:Kill()
self.monsterTween=nil
end
local modelParams=comHelper.getMonsterGroupModelParams(self.entityData.monster_id)
local scales2=comHelper.getModelScales2Config(modelParams.body,30)or defaultT
self.monsterModel:setChildUIModelShowTarget(modelParams.body,scales2[1]or modelParams.scale,modelParams.componets,eAnimationID.stand,false,false,0,nil)
self.monsterModel:setChildUIModelShowTargetOffset(scales2[2]or 0,scales2[3]or 0)
self.monsterModel:setChildUIModelShowFlipX(true)

self.hpProgressBar:setProgressValue(self.entityData.hp,10000)
self.hpProgressBar:setChildProgressText(FMT.fmt("{0}%",self.entityData.hp/100))

self:refreshStateInfo(nowTime,init)

self:refreshTimeInfo(nowTime)

local fazeDatas=self.stageCfg.faze
local fazeCnt=#fazeDatas
self.fazeList:setChildLayoutGroupCreateItems(fazeCnt,function(index)
local item=self.fazeList:getChildLayoutGroupGridItem(index-1)
local fazeData=fazeDatas[index]
local fazeId=fazeData[1]
local fazeLv=fazeData[2]
local fazeCfg=cfgHelper.getSSlawRule(fazeId)
local descparm=fazeCfg.descparm
local desc=descparm and string.format(fazeCfg.desc,unpack(descparm[fazeLv]))or fazeCfg.desc
local obj=item:GetChildGameObject(3)
local width=item:GetChildSizeDeltaX(3)
desc=comHelper.getCheckLayoutStr(obj,width,desc)
item:SetChildCSImageIcon(1,fazeCfg.image)
item:SetChildText(2,desc)
item:ForceLayoutRect(2)
item:ForceLayoutRect(4)
end)
self.winlua:ForceLayoutRect(self.fazeList:getID())
self.fazeView:setChildScrollRectEnable(fazeCnt>=2)

local skillDatas=self.monsterCfg.showSkills or defaultT
local skillCnt=#skillDatas
self.skillList:setChildLayoutGroupCreateItems(skillCnt,function(index)
local item=self.skillList:getChildLayoutGroupGridItem(index-1)
local skillData=skillDatas[index]
local skillId=skillData[1]
local skillLv=skillData[2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
local is_bd=skillModel.isSkillBD(skillCfg.skillType)
local desc=skillModel:getSkillDesc(skillId,skillLv)
local obj=item:GetChildGameObject(4)
local width=item:GetChildSizeDeltaX(4)
desc=comHelper.getCheckLayoutStr(obj,width,desc)
item:SetChildText(2,skillCfg.name)
item:SetChildCSImageIcon(1,iconHelper.getSkillIcon(skillCfg.icon))
item:SetChildText(3,desc)
item:SetChildActive(5,is_bd)
item:ForceLayoutRect(3)
item:ForceLayoutRect(6)
end)
self.winlua:ForceLayoutRect(self.skillList:getID())
self.skillView:setChildScrollRectEnable(skillCnt>=3)
end

function UIZhengTaoMoJiangMonsterInfoWin:refreshStateData(nowTime,init)
nowTime=nowTime or timeHelper.getServerShortTime()
local stateCfg=self.stageCfg.stage
local deltaTime=nowTime-self.stage.beginTime
local stateCnt=#stateCfg
self.state=#stateCfg
for i,v in ipairs(stateCfg)do
if deltaTime<=v[1]then
self.state=i
break
end
end
local animContent=init and"enter{0}"or"stand{0}"
local animName=FMT.fmt(animContent,self.state>1 and self.state or"")
if init then
self.spine:setChildUIModelShowTarget(6282,1,{},eAnimationID[animName],false,false,0,function()
self.root:setActive(true)
end)
else
self.spine:setChildModelAnimationState(eAnimationID[animName],1)
end
end

function UIZhengTaoMoJiangMonsterInfoWin:refreshStateInfo(nowTime,init)
self:refreshStateData(nowTime,init)

local stateName=self.stageCfg.stage[self.state][5]
self.stateTx:setText(stateName)

local openTime=self.stageCfg.open+self.stage.beginTime
local endTime=self.stage.beginTime+self.stageCfg.stage[self.state][1]
if nowTime<openTime then
self.stateCDBg:setActive(false)
self:startStateTick(openTime,0)
elseif self.state>=#self.stageCfg.stage or nowTime>=endTime then
self.stateCDBg:setActive(false)
self:stopStateTick()
else
self.stateCDBg:setActive(true)
self.stateCDTx:setText(timeHelper.format_time_stamp3(endTime-nowTime))
self:startStateTick(endTime,1)
end
end

function UIZhengTaoMoJiangMonsterInfoWin:startStateTick(cdTime,cdType)
self.cdTime=cdTime
self.cdType=cdType
if self.stateTick==nil then
self.stateTick=self:setTimer(1,0,function()
self:updateStateTick()
end)
end
end

function UIZhengTaoMoJiangMonsterInfoWin:stopStateTick()
self.cdTime=nil
self.cdType=nil
if self.stateTick then
self:stopTimerByID(self.stateTick)
self.stateTick=nil
end
end

function UIZhengTaoMoJiangMonsterInfoWin:updateStateTick()
local nowTime=timeHelper.getServerShortTime()
if self.cdTime>nowTime then
if self.cdType==1 then
self.stateCDTx:setText(timeHelper.format_time_stamp3(self.cdTime-nowTime))
end
else
self:refreshStateInfo(nowTime)
end
end

function UIZhengTaoMoJiangMonsterInfoWin:refreshTimeInfo(nowTime)
nowTime=nowTime or timeHelper.getServerShortTime()
local openTime=self.stage.beginTime+self.stageCfg.open
if nowTime>=openTime then
if limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eMoJiang)then
local lefTime=limitActivitiesModel:getActEndLeftTime(LIMIT_ACT_TYPE.eMoJiang)
self.timeTx:setText(FMT.fmt("攻打结束：{0}",timeHelper.format_time_stamp3(lefTime)))
self:startInfoTick(nowTime+lefTime)
self.fightBtn:setActive(true)
self.openCDBg:setActive(false)
self.lockTxBg:setActive(false)

local cnt=math.max(self.stageCfg.times-self.entityData.fightTimes,0)
self.fightCntTx:setText(FMT.fmt("今天剩余次数：<color=#ca631d>{0}</color>",cnt))

self:freshMoJieSkillPnael()
self:freshMoJiePnael()
else
self.timeTx:setText(self.openStr)
self.fightBtn:setActive(false)
self.openCDBg:setActive(false)
self.lockTxBg:setActive(true)
self:stopInfoTick()

self.mjslpanel:setActive(false)
self.mjslskill:setActive(false)
end
else
self.timeTx:setText(self.openStr)
self.fightBtn:setActive(false)
self.openCDBg:setActive(true)
self.lockTxBg:setActive(false)
self:stopInfoTick()
local leastTime=openTime-timeHelper.convertShortStamp(timeHelper.getTodayZeroStamp())
self.openCDTx:setText(FMT.fmt("{0}后开启",timeHelper.formatSimpleTime(leastTime)))

self.mjslpanel:setActive(false)
self.mjslskill:setActive(false)
end
end

function UIZhengTaoMoJiangMonsterInfoWin:startInfoTick(time)
self.infoTime=time
if self.infoTick==nil then
self.infoTick=self:setTimer(1,0,function()
self:updateInfoTick()
end)
end
end

function UIZhengTaoMoJiangMonsterInfoWin:stopInfoTick()
self.infoTime=nil
if self.infoTick then
self:stopTimerByID(self.infoTick)
self.infoTick=nil
end
end

function UIZhengTaoMoJiangMonsterInfoWin:updateInfoTick()
local nowTime=timeHelper.getServerShortTime()
if self.infoTime>nowTime then
self.timeTx:setText(FMT.fmt("攻打结束：{0}",timeHelper.format_time_stamp3(self.infoTime-nowTime)))
else
self:refreshTimeInfo(nowTime)
end
end

function UIZhengTaoMoJiangMonsterInfoWin.onNewDay()
if _this.entityData.killTime<=0 then
_this:refreshLiveView()
end
end

function UIZhengTaoMoJiangMonsterInfoWin.onLimitActStateChange(actId,state)
if actId==LIMIT_ACT_TYPE.eMoJiang and _this.entityData.killTime<=0 then
_this:refreshTimeInfo()
_this:refreshRewardReddot()
end
end

function UIZhengTaoMoJiangMonsterInfoWin.onSeasonChange()
_this.stage=seasonModel:getStage(_this.seasonType,_this.stageIndex)
if _this.stage then
_this.entityData=xianjieModel:getMoJiangEntity(_this.seasonType,_this.stageIndex,_this.build_id)
_this:refreshView()
else
_this:onCloseBtn()
end
end

function UIZhengTaoMoJiangMonsterInfoWin.onSeasonStageChange(seasonType,stageIndex)
if seasonType==_this.seasonType and stageIndex==_this.stageIndex then
_this:refreshView()
end
end

function UIZhengTaoMoJiangMonsterInfoWin.on_39_11(seasonType,stageIndex,build_id,hp)
if _this.entityData.killTime<=0 and seasonType==_this.seasonType and stageIndex==_this.stageIndex then
_this.hpProgressBar:setProgressValue(_this.entityData.hp,10000)
_this.hpProgressBar:setChildProgressText(FMT.fmt("{0}%",_this.entityData.hp/100))
end
end

function UIZhengTaoMoJiangMonsterInfoWin.on_39_10(seasonType,stageIndex,build_id,damage)
if seasonType==_this.seasonType and stageIndex==_this.stageIndex then
_this:refreshRewardReddot()
end
end

function UIZhengTaoMoJiangMonsterInfoWin.on_39_185(args)
if _this.entityData.killTime<=0 and limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eMoJiang)then
local guid=args[1]
local ordertype=args[2]
if xjOrderType.eAttackBoss==ordertype and mathHelper.int64_to_number(guid)==_this.build_id then
local params=args[8]
params=jsonHelper.decode(params)
local seasonType=params[1]
local stageIndex=params[2]
if seasonType==_this.seasonType and stageIndex==_this.stageIndex then

local cnt=math.max(_this.stageCfg.times-entityData.fightTimes,0)
_this.fightCntTx:setText(FMT.fmt("今天剩余次数：{0}",cnt))
end
end
end
end

function UIZhengTaoMoJiangMonsterInfoWin.on_39_2(seasonType,stageIndex,dataType,build_id)
if seasonType==_this.seasonType and stageIndex==_this.stageIndex and build_id==_this.build_id and(dataType==6 or dataType==7)then
_this:refreshRewardReddot()
end
end



function UIZhengTaoMoJiangMonsterInfoWin:freshMoJiePnael()
local monsterData=self.entityData
local isMJtime=xianjieController:CheckMoJieSaiJieActityeTime()
if isMJtime then
self:freshMoJiBuffnum(monsterData)
local widget=self.mjslpanel:getWidgetBase()
widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMoJiBuffClick(widget,monsterData)
end)
else
self.mjslpanel:setActive(false)
end
end

function UIZhengTaoMoJiangMonsterInfoWin:freshMoJiBuffnum()
local monsterData=self.entityData
local buffTemp={}
local buffNum=0
if monsterData and monsterData.bufflistlen and monsterData.bufflistlen>0 then
local buffList_lookup=monsterData.buffList or{}
buffTemp,buffNum=xianjieController:handleFaZeDieJia(buffList_lookup)
end


local widget=self.mjslpanel:getWidgetBase()
widget:SetChildText(1,buffNum)
if buffTemp and next(buffTemp)then
self.mjslpanel:setActive(true)
else
self.mjslpanel:setActive(false)
end
end

function UIZhengTaoMoJiangMonsterInfoWin:onMoJiBuffClick(_posWidget,monsterData)

local buffTemp={}
local buffNum=0
if monsterData and monsterData.bufflistlen and monsterData.bufflistlen>0 then
local buffList_lookup=monsterData.buffList or{}
buffTemp,buffNum=xianjieController:handleFaZeDieJia(buffList_lookup)
end
local widget=_this.mjslpanel:getWidgetBase()
widget:SetChildText(1,buffNum)


if buffTemp and next(buffTemp)then
self:showWindow('UIMoJieShiLiBuffTips',{posWidget=_posWidget,posWidgetIndex=0,pos={x=-265,y=65},exparem={{140,-40,0},{-204,-107,0},{0,0,-90}},bufflsit=buffTemp})
else
UIManager.info('暂无获得的魔界势力状态')
end
end

function UIZhengTaoMoJiangMonsterInfoWin:freshMoJieShiLiItem()
local isopen=xianjieController:CheckMoJieShiLiSkillZongMenBtn()
if isopen then
local forceid=0
if forceid>0 then
self.slItem:setActive(true)
local cfg=cfg_devildomforceconfig_get(forceid)
self.slNameText:setText(cfg.name)
else
self.slItem:setActive(false)
end
end
end



function UIZhengTaoMoJiangMonsterInfoWin:freshMoJieSkillPnael()
local isopen=xianjieController:CheckMoJieShiLiSkillZongMenBtn()
local monsterData=self.entityData
if isopen then
if monsterData==nil then return end
local forceid=xianjieController:getForce()
if forceid>0 and xianjieController:getShiLiDebuffCheck(forceid)then
local Skillidx,Taskidx=xianjieController:getForceCfg()
if Skillidx==nil then
self.mjslskill:setActive(false)
logErr(FMT.fmt('获取势力配置为nil,查看魔界赛季配置表的force字段'))
return
end
self.mjslskill:setActive(true)
self.skillcfg=xianjieController:getForceSkillCfg(forceid,Skillidx)
local skillcfg=self.skillcfg

local widget=self.mjslskill:getWidgetBase()
widget:SetChildText(slskillidx.name,skillcfg.name)
local iconName=iconHelper.getSkillIcon(skillcfg.skillicon)
widget:SetChildCSImageIcon(slskillidx.icon,iconName,false)
widget:SetChildButtonClick(slskillidx.skillbtn,function()
if _this==nil then return end
_this:onUseMoJiSkillbtn(monsterData)
end)
self:CheckUseMoJiSkillTime()
else
self.mjslskill:setActive(false)
end
else
self.mjslskill:setActive(false)
end
end

function UIZhengTaoMoJiangMonsterInfoWin:onUseMoJiSkillbtn(monsterData)
local sceneidx=xianjieModel:getSceneIndex()
if xianjienSceneIndexType:isMoJie(sceneidx)then
local flag,g_list,errorParams=monsterData:checkMovePathCondition(true)
if not flag then
if errorParams then
local errStr=""
local isSelfInNeutralArea=errorParams.isSelfInNeutralArea
local isTargetInNeutralArea=errorParams.isTargetInNeutralArea
if isSelfInNeutralArea then

errStr="处于阵外无法对本阵内的魔将使用"
elseif isTargetInNeutralArea then

errStr="处于本阵内无法对阵外的魔将使用"
else

errStr="处于本阵内无法对其他本阵内的魔将使用"
end
UIManager.error(errStr)
end
return
end

local lastsec=xianjieController:getForceLastsec()
local curTime=timeHelper.getServerShortTime()
local skilldata=self.skillcfg.skill
local lvl=xianjieController:getForceSkilllv()
local skill_data=skilldata[lvl]
local skill_time=skill_data[2]
local endTime=lastsec+skill_time
if endTime>curTime then
UIManager.info('技能冷却中')
return
end
local build_id=self.build_id
local actorid=int64.new(tostring(build_id))

local _fun=function()
xianjieController:useMoJieShiLiSkill(actorid)
self:closeSelf()
end
local UseSkilldesc=self.skillcfg.UseSkilldesc
local skillname=self.skillcfg.name
local parem1=UseSkilldesc[1]
local parem2=UseSkilldesc[2][lvl]
local strdesc=''
xpcall(function()
strdesc=FMT.fmt(parem1,unpack(parem2))
end,function(err)
logErr(FMT.fmt('魔界势力技能参数报错，配置字段UseSkilldesc,技能名字：{0},技能等级：{1}',skillname,lvl))
end)
local str=FMT.fmt("是否使用<color=#ca631d>【{0}】</color>技能\n\n{1}",skillname,strdesc)
xianjieController:showUseSkillWin(_fun,str)
else
UIManager.info('势力技能只能在魔界使用')
end
end

function UIZhengTaoMoJiangMonsterInfoWin:serverMoJiSkill()
if _this==nil then return end
_this:CheckUseMoJiSkillTime()
end

function UIZhengTaoMoJiangMonsterInfoWin:CheckUseMoJiSkillTime()
local widget=self.mjslskill:getWidgetBase()
local lastsec=xianjieController:getForceLastsec()
local curTime=timeHelper.getServerShortTime()
local skilldata=self.skillcfg.skill
local lvl=xianjieController:getForceSkilllv()
local skill_data=skilldata[lvl]
local skill_time=skill_data[2]
local endTime=lastsec+skill_time
if endTime>curTime then

widget:SetChildActive(slskillidx.djsbg,true)
widget:SetChildGray(slskillidx.icon,true)
self:stopSelfTimerMJSL()
local timeStr=timeHelper.format_time_stamp(endTime-curTime,true)
widget:SetChildText(slskillidx.djs,timeStr)
local func=function()
local serTime=timeHelper.getServerShortTime()
local dtTime=endTime-serTime
local showTime=dtTime>=0 and dtTime or 0
timeStr=timeHelper.format_time_stamp(showTime,true)
widget:SetChildText(slskillidx.djs,timeStr)
if dtTime<=0 then
self:stopSelfTimerMJSL()
widget:SetChildActive(slskillidx.djsbg,false)
widget:SetChildGray(slskillidx.icon,false)
end
end
self.timermjsl=self:setTimer(1,0,func)
else
widget:SetChildActive(slskillidx.djsbg,false)
widget:SetChildGray(slskillidx.icon,false)
end
end
function UIZhengTaoMoJiangMonsterInfoWin:stopSelfTimerMJSL()
if self.timermjsl then
self:stopTimerByID(self.timermjsl)
self.timermjsl=nil
end
end