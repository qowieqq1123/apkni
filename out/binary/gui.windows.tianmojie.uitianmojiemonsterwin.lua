







def_class("UITianMoJieMonsterWin",UIWindowBase)









function UITianMoJieMonsterWin:bindComponents()

self.assistBtn=UIButton.get(self,0)
self.background=UIButton.get(self,1)
self.bgModel=UIObject.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.fightBtn=UIButton.get(self,4)
self.fightBtnTx=UIText.get(self,5)
self.helpBtn=UIButton.get(self,6)
self.helpPanel=UIButton.get(self,7)
self.helpTx=UIText.get(self,8)
self.model=UIObject.get(self,9)
self.monsterType=UIImage.get(self,10)
self.nameTx=UIText.get(self,11)
self.progressBar=UIProgress.get(self,12)
self.rewardDetail=UIButton.get(self,13)
self.rewardList=UIObject.get(self,14)
self.rewardTips=UIText.get(self,15)
self.root=UIObject.get(self,16)
self.scoreTx=UIText.get(self,17)
self.shareBtn=UIButton.get(self,18)
self.skillList=UIObject.get(self,19)
self.strengthCD=UIText.get(self,20)
self.strengthNum=UIText.get(self,21)

self.assistBtn:setButtonClick(function()self:onAssistBtn()end)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.fightBtn:setButtonClick(function()self:onFightBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.helpPanel:setButtonClick(function()self:onHelpPanel()end)

self.rewardDetail:setButtonClick(function()self:onRewardDetail()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)



end


function UITianMoJieMonsterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.assistBtn);self.assistBtn=nil;
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.fightBtn);self.fightBtn=nil;
_UIObject_release(self.fightBtnTx);self.fightBtnTx=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.helpPanel);self.helpPanel=nil;
_UIObject_release(self.helpTx);self.helpTx=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.monsterType);self.monsterType=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.rewardDetail);self.rewardDetail=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rewardTips);self.rewardTips=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scoreTx);self.scoreTx=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.skillList);self.skillList=nil;
_UIObject_release(self.strengthCD);self.strengthCD=nil;
_UIObject_release(self.strengthNum);self.strengthNum=nil;
end















local _this=nil
local _itemCmp={
item=0,
gailv=1,
teyou=2,
}
local _monsterTypeName={
[monType.Boss]="image_mozun",
[monType.EliteMonster]="image_mozhu",
[monType.LittleMonster]="image_mozhu",
}
local _abName="ui/windows/tianmojie/tianmojie_atlas_pak.ab"
local _tickArray={}



function UITianMoJieMonsterWin:onLoaded(...)
self:bindComponents()
_this=self
self:addProNotify(34,121,self.on_34_121)
self:addProNotify(34,122,self.on_34_122)
self:addProNotify(34,127,self.on_34_127)
self:addNotify(notifyConfig.onNewDay,self.onNewDay)
self:initView()
end


function UITianMoJieMonsterWin:__delete()
self:unbindComponents()
_this=nil

self:stopStrengthTick()
end




function UITianMoJieMonsterWin:onShow(argtable,afterOnloaded)
self.argtable=argtable
self.parentWin=argtable.parentWin
self.closeFunc=argtable.closeFunc
self.actorId=argtable.actorId
self.monsterGuid=argtable.monsterGuid
self.monsterData=tianMoJieModel:getMonster(self.actorId,self.monsterGuid)

if self.monsterData then
self:updateConfig()
self:refreshView()

self:doEnterAnimation()
else
loggerUtil.logErrFMT("没有相应的天魔劫怪物：{0}, {1}",tostring(self.actorId),tostring(self.monsterGuid))
self.canClose=true
self:onCloseBtn()
end
end


function UITianMoJieMonsterWin:onHide()

end




function UITianMoJieMonsterWin:onBackground()
self:onCloseBtn()
end


function UITianMoJieMonsterWin:onCloseBtn()
if not self.canClose then return end

if self.closeFunc then
self.closeFunc()
elseif self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end


function UITianMoJieMonsterWin:onFightBtn()
if not playerModel:checkActorId(self.actorId)then
local haveLv=zongmenModel:getLevel()
local needLv=cfgHelper.get2(cfg_tianmojiebaseconfig_get,1,"assistLv")
if haveLv<needLv then
UIManager.info(FMT.fmt("宗门等级不足{0}级，无法协助挑战",needLv))
return
end
if tianMoJieModel:getDaily()>=cfgHelper.get2(cfg_tianmojiebaseconfig_get,1,"daily")then
UIManager.error("今日协助次数已用完")
return
end
end
local isSelf=playerModel:checkActorId(self.actorId)
local monsterCfg=cfgHelper.get1(cfg_tianmojiemonconfig_get,self.monsterData.id)
local monsterGroup=cfgHelper.get1(cfg_monstergroup_get,monsterCfg.monster)
local dzList=UIDiscipleModel:getAllDiscipleData()
local jjLine=cfgHelper.get2(cfg_tianmojiebaseconfig_get,1,"jingjie")
local guidList={}
for i,v in pairs(dzList)do
local netData=v.netData.net
if netData.jingjielv>=jjLine then
table.insert(guidList,netData.discipleguid)
end
end
local txData={}
for i,v in ipairs(monsterCfg.texing)do
local index=v[2]
local temp=v[1]==1 and monsterGroup.showSkills[index]or monsterCfg.faze[index]
table.insert(txData,{v[1],temp})
end
local argtable=self.argtable
local actor=self.monsterData.actor
local guid=self.monsterData.guid
local checkDZSortFunc=nil
local checkSignType=nil
if isSelf then
checkSignType=dzSignType.eTianMoJie
checkDZSortFunc=function(guid)
return not UIDiscipleModel:haveDiscipleSign(guid,dzSignType.eTianMoJie)
end
end
local args={
dontCloseStage=false,
enterTxt=cfgHelper.get2(cfg_jctjsubsysconfig_get,JIUCHONGTIANJIE_SUB_SYS_TYPE.eTianMoJie,"name"),
groupId=monsterCfg.monster,
monsterList=monsterGroup.monList,
lockSelect=guidList,
checkDZSortFunc=checkDZSortFunc,
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
checkSignType=checkSignType,
singleFightDescStr="上阵要求：弟子境界需达到<color=#e6a200>渡劫前期</color>",
isHomeBattle=true,
enterCallBack=function(selectList,zfId)
fightLaunchController:sendFight(eBattleLaunch.tianmojie,selectList,monsterGroup.mapId or 0,zfId,{actor,guid})
end,
cancelCallBack=function()
UIManager:showWindow("UITianMoJieMonsterWin",argtable)
end,
extraWinList={"UIFightPrepareTianMoRuQinTeXingWin","UITianMoJieFighPrepareWin"},
extraParamsList={
{
title="天魔特性",
data=txData,
},
{
actor=self.monsterData.actor,
}
},
dzEmptyCountTx="暂无可上阵弟子\n上阵要求：弟子境界为渡劫期且无心魔作祟状态",
}
fightController.showPrepareWin(fightPreSelectModel.fightType.tianmojie,args)
end


function UITianMoJieMonsterWin:onHelpBtn()
self.helpPanel:setScale(Vector3.one)
self.winlua:ForceLayoutRect(self.helpPanel:getID())
end


function UITianMoJieMonsterWin:onHelpPanel()
self.helpPanel:setScale(Vector3.zero)
end


function UITianMoJieMonsterWin:onAssistBtn()
local args={
parentWin=self,
monsterGuid=self.monsterData.guid,
actorId=self.monsterData.actor,
}
self:showWindow("UITianMoJieMonsterAssistWin",args)
tianMoJieController:send_34_125(self.monsterData.actor,self.monsterData.guid)
end


function UITianMoJieMonsterWin:onRewardDetail()
local args={
parentWin=self,
monsterId=self.monsterData.id,
}
self:showWindow("UITianMoJieRewardDetailWin",args)
end


function UITianMoJieMonsterWin:onShareBtn()
if not xianmengModel:hasXM()then
UIManager.info("未加入仙盟无法分享")
return
end

local interval=tianMoJieModel:getShareInterval()
if interval>0 then
UIManager.info(FMT.fmt("{0}后可再次分享",timeHelper.format_time_stamp3(interval)))
return
end

local args={
parentWin=self,

actorId=self.monsterData.actor,
}
self:showWindow("UITianMoJieShareWin",args)
end

function UITianMoJieMonsterWin:initView()


end

function UITianMoJieMonsterWin:doEnterAnimation()
if not self.enter then
self.enter=true
self.bgModel:setChildUIModelShowTarget(4922,1,{},eAnimationID.enter,false,false,0,function()
self:delayDo(0.4,function()
self.root:setChildCanvasGroupDOFade(1,0.2)
self.canClose=true
end)
end)
else
self.root:setChildCanvasGroUITianMoJieMonsterWin32upAlpha(1)
end
end

function UITianMoJieMonsterWin:updateConfig()
self.monsterCfg=cfgHelper.get1(cfg_tianmojiemonconfig_get,self.monsterData.id)
self.monsterGroup=cfgHelper.get1(cfg_monstergroup_get,self.monsterCfg.monster)
end

function UITianMoJieMonsterWin:refreshView()
self:refreshMonsterInfo()
self:refreshMonsterBlood()
self:refreshActorInfo()
self:refreshStrengInfo()
end

function UITianMoJieMonsterWin:refreshActorInfo()
local isSelf=playerModel:checkActorId(self.monsterData.actor)
local scoreStr=isSelf and FMT.fmt("天魔被击败后可获得魔劫积分: <color=#ca631d>{0}</color>",self.monsterCfg.score)or"\n祖师只能协助挑战<color=#549327>1次</color>/每日\n（次日<color=#549327>0点</color>刷新）"
local curDaily=tianMoJieModel:getDaily()
local maxDaily=cfgHelper.get2(cfg_tianmojiebaseconfig_get,1,"daily")
self.scoreTx:setText(scoreStr)
self.fightBtnTx:setText(isSelf and"挑战"or"协助挑战")
self.shareBtn:setActive(isSelf)
self.fightBtn:setChildGraphicGray(not isSelf and curDaily>=maxDaily)

local dropId=self.monsterGroup.drops[isSelf and 2 or 1]
local dropCfg=cfgHelper.get1(cfg_awardconfig_get,dropId)
local dropList=dropCfg.showItems or{}
self.rewardList:setChildLayoutGroupCreateItems(#dropList,function(index)
local item=self.rewardList:getChildLayoutGroupGridItem(index-1)
local dropData=dropList[index]
local itemId=dropData[1]
local itemNum=dropData[2]
local range=dropData.range
local showCountBG=range==nil and itemNum>0
local conf={itemid=itemId,itemcount=itemNum,range=range,showname=false,showStage=true,showCountBG=showCountBG}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(_itemCmp.item,prop)
item:SetBaseItemClickEvent(_itemCmp.item,itemsComponentHelper.onItemClickEx)
item:SetChildActive(_itemCmp.gailv,range==nil and itemNum<0)
end)
self.rewardTips:setText(isSelf and"击败奖励"or"协助奖励")
end

function UITianMoJieMonsterWin:refreshStrengInfo()
local nowTime=timeHelper.getServerShortTime()
local passTime=nowTime-self.monsterData.since
local baseCfg=cfgHelper.get1(cfg_tianmojiebaseconfig_get,1)
local weakCnt=#baseCfg.faze
local initStrength=baseCfg.strength

local sumTime=0
self.strength=nil
self.strengthSeg={}

for index=1,initStrength-1 do
local cfg=baseCfg.faze[index]or baseCfg.faze[weakCnt]
sumTime=cfg[1]


if self.strength==nil then
if passTime<sumTime then
self.strength=initStrength-index+1
table.insert(self.strengthSeg,self.monsterData.since+sumTime)
end
else
table.insert(self.strengthSeg,self.monsterData.since+sumTime)
end
end
self.strength=self.strength or 1
self.strengthNum:setText(self.strength)

local str=cfgHelper.get3(cfg_tianmojiebaseconfig_get,1,"strengthTips",self.strength)
self.helpTx:setText(str)

if#self.strengthSeg>0 then
self:startStrengthTick()
else
self:stopStrengthTick()
self.strengthCD:setText("天魔强度已降至最低可轻松挑战")
self.helpTx:setText(cfgHelper.get3(cfg_tianmojiebaseconfig_get,1,"strengthTips",1))
end
end

function UITianMoJieMonsterWin:startStrengthTick()
if not self.strengthTick then
self:updateStrengthTick()
self.strengthTick=self:setTimer(1,0,function()
self:updateStrengthTick()
end)
end
end

function UITianMoJieMonsterWin:stopStrengthTick()
if self.strengthTick then
self:stopTimerByID(self.strengthTick)
self.strengthTick=nil
end
end

function UITianMoJieMonsterWin:updateStrengthTick()
local nowTime=timeHelper.getServerShortTime()
table.clear(_tickArray)
for i,v in ipairs(self.strengthSeg)do
if nowTime<v then
local str=FMT.fmt("距离强度下降剩余: <color=#549327>{0}</color>",timeHelper.format_time_stamp3(v-nowTime))
self.strengthCD:setText(str)
break
else
table.insert(_tickArray,i)
end
end
local removeCnt=#_tickArray
if removeCnt>0 then
for i=#_tickArray,1,-1 do
table.remove(self.strengthSeg,removes[i])
end
self.strength=self.strength-removeCnt
self.strengthNum:setText(self.strength)

local str=cfgHelper.get3(cfg_tianmojiebaseconfig_get,1,"strengthTips",self.strength)
self.helpTx:setText(str)
end
if#self.strengthSeg<=0 then
self.strengthCD:setText("天魔强度已降至最低可轻松挑战")
self:stopStrengthTick()
end
end

function UITianMoJieMonsterWin:refreshMonsterBlood()
self.progressBar:setProgressValue(self.monsterData.percent,10000)
self.progressBar:setChildProgressText(FMT.fmt("{0}%",self.monsterData.percent/100))
end

function UITianMoJieMonsterWin:refreshFightButtonGray()
local isSelf=playerModel:checkActorId(self.monsterData.actor)
local curDaily=tianMoJieModel:getDaily()
local maxDaily=cfgHelper.get2(cfg_tianmojiebaseconfig_get,1,"daily")
self.fightBtn:setChildGraphicGray(not isSelf and curDaily>=maxDaily)
end

function UITianMoJieMonsterWin:refreshMonsterInfo()
local modelParams=comHelper.getMonsterGroupModelParams(self.monsterGroup.id)
local scaleParam=isometricMapSystem:getModelScales2Pram(modelParams.body,23)
self.model:setChildUIModelShowTarget(modelParams.body,scaleParam[1],modelParams.componets,eAnimationID.stand,false,false,0,nil)
self.model:setChildUIModelShowTargetOffset(scaleParam[2],scaleParam[3])







self.nameTx:setText(self.monsterGroup.name)

local skillList=self.monsterCfg.texing
self.skillCnt=#skillList
self.skillList:setChildLayoutGroupCreateItems(self.skillCnt,function(index)
local item=self.skillList:getChildLayoutGroupGridItem(index-1)
local skillData=skillList[index]
local skillType=skillData[1]
local skillIndex=skillData[2]
local iconName=""
if skillType==1 then
local skillParam=self.monsterGroup.showSkills and self.monsterGroup.showSkills[skillIndex]or nil
if skillParam then
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillParam[1])
iconName=iconHelper.getSkillIcon(skillCfg.icon)
else
loggerUtil.logWarnFMT("天魔劫怪物无效怪物特性:{0},{1},{2}",self.monsterCfg.id,skillType,skillIndex)
end
else
local skillParam=self.monsterCfg.faze[skillIndex]
if skillParam then
local fazeID=skillParam[1]
local skillCfg=cfgHelper.getSSlawRule(fazeID)
iconName=skillCfg.image
else
loggerUtil.logWarnFMT("天魔劫怪物无效怪物特性:{0},{1},{2}",self.monsterCfg.id,skillType,skillIndex)
end
end
item:SetChildCSImageIcon(-1,iconName,false)
item:SetChildButtonClick(-1,function()
self:onClickSkill(index)
end)
end)
end

function UITianMoJieMonsterWin:onClickSkill(index)
local x=-146+78*(index-(self.skillCnt/2+0.5))
local txInfo=self.monsterCfg.texing[index]
local txType=txInfo[1]
local txIndex=txInfo[2]
local name,icon,desc
if txType==1 then
local txParam=self.monsterGroup.showSkills[txIndex]
local skillId=txParam[1]
local skillLv=txParam[2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
local is_bd=skillModel.isSkillBD(skillCfg.skillType)
name=skillCfg.name
icon=iconHelper.getSkillIcon(skillCfg.icon)
desc=skillModel:getSkillDesc(skillId,skillLv)

else
local txParam=self.monsterCfg.faze[txIndex]
local fazeID=txParam[1]
local fazeLv=txParam[2]
local fazeCfg=cfgHelper.getSSlawRule(fazeID)
local descparm=fazeCfg.descparm
name=fazeCfg.name
icon=fazeCfg.image
desc=descparm and string.format(fazeCfg.desc,unpack(descparm[fazeLv]))or fazeCfg.desc

end
local halfVector=Vector2.right*0.5
local args={
name=name,
icon=icon,
desc=desc,
bottomLeft=nil,
rootPoint={
anchorsMin=halfVector,
anchorsMax=halfVector,
pivot=halfVector*0.5,
anchoredPosition=Vector2.New(x,255),
},
arrowPos={
anchorsMin=Vector2.zero,
anchorsMax=Vector2.zero,
anchoredPosition=Vector2.right*108,
},
}
self:showWindow('UISimpleTeXingTipsWin',args)
end

function UITianMoJieMonsterWin.on_34_127(tmguid)
if playerModel:checkActorId(_this.actorId)and mathHelper.compareInt64(tmguid,_this.monsterGuid)then
_this.monsterData=tianMoJieModel:getMonster(_this.actorId,_this.monsterGuid)
if _this.monsterData then
_this:refreshMonsterBlood()
else
_this:onCloseBtn()
UIManager.error("天魔已被击败")
end
end
end

function UITianMoJieMonsterWin.on_34_122(actorid)
if mathHelper.compareInt64(actorid,_this.actorId)then
_this.monsterData=tianMoJieModel:getMonster(_this.actorId,_this.monsterGuid)
if _this.monsterData then
_this:refreshMonsterBlood()
else
_this:onCloseBtn()
UIManager.error("天魔已被击败")
end
end
end

function UITianMoJieMonsterWin.on_34_121(score,flag,daily,guidlistlen,guidList)
_this:refreshFightButtonGray()
end

function UITianMoJieMonsterWin.onNewDay()
_this:refreshFightButtonGray()
end
