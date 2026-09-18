







def_class("UIWorldBigBossActivityRankWin",UIWindowBase)









function UIWorldBigBossActivityRankWin:bindComponents()

self.addBtn=UIButton.get(self,0)
self.addTx=UIText.get(self,1)
self.bossModel=UIObject.get(self,2)
self.bossName=UIImage.get(self,3)
self.bossTime=UIText.get(self,4)
self.closeBtn=UIButton.get(self,5)
self.closeTx=UIText.get(self,6)
self.gotoBtn=UIButton.get(self,7)
self.helpBtn=UIButton.get(self,8)
self.myRankName=UIText.get(self,9)
self.myRankNo=UIText.get(self,10)
self.myRankValue=UIText.get(self,11)
self.noneTips=UIText.get(self,12)
self.rankList=UIObject.get(self,13)
self.rewardBtn=UIButton.get(self,14)
self.skillList=UIObject.get(self,15)
self.skillView=UIObject.get(self,16)
self.stageDropdown=UIDropdown.get(self,17)
self.Template=UIObject.get(self,18)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)



end


function UIWorldBigBossActivityRankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.addTx);self.addTx=nil;
_UIObject_release(self.bossModel);self.bossModel=nil;
_UIObject_release(self.bossName);self.bossName=nil;
_UIObject_release(self.bossTime);self.bossTime=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.closeTx);self.closeTx=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.myRankName);self.myRankName=nil;
_UIObject_release(self.myRankNo);self.myRankNo=nil;
_UIObject_release(self.myRankValue);self.myRankValue=nil;
_UIObject_release(self.noneTips);self.noneTips=nil;
_UIObject_release(self.rankList);self.rankList=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.skillList);self.skillList=nil;
_UIObject_release(self.skillView);self.skillView=nil;
_UIObject_release(self.stageDropdown);self.stageDropdown=nil;
_UIObject_release(self.Template);self.Template=nil;
end
















local _this=nil
local _rankItemCmp={
no=0,
value=1,
name=2,
}
local _skillCmp={
widget=-1,
icon=0,
sign=1,
lvText=2,
click=3,
lv=4,
new=5,
}
local _altasAB='ui/windows/worldbigboss/worldbigboss_atlas_pak.ab'



function UIWorldBigBossActivityRankWin:onLoaded(...)
self:bindComponents()
_this=self
self.stageDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
local str=limitActivitiesModel:getActConfig(LIMIT_ACT_TYPE.eShiJieShouLing,"name")
self.closeTx:setText(str)
end


function UIWorldBigBossActivityRankWin:__delete()
self:unbindComponents()
_this=nil
worldLeaderModel:cleanRank()
end




function UIWorldBigBossActivityRankWin:onShow(argtable,afterOnloaded)
self.stageDropdown:setOption(worldLeaderModel:getStageNameList())

if worldLeaderModel.init then
self.monsterIdx=worldLeaderModel:getMonsterIdx()
self.stageIdx=self.stageIdx or(worldLeaderModel:getStageIdx()-1)
self.stageDropdown:setValue(self.stageIdx)
self:refreshView(self.stageIdx)
else
worldLeaderController:send_248_31()
end
end


function UIWorldBigBossActivityRankWin:onHide()

end




function UIWorldBigBossActivityRankWin:onCloseBtn()
UIFullWorldBigBossController:closeUI()
if worldController:isInWorld()then
local cameraConfig=cfgHelper.get1(cfg_worldconfig_get,worldModel.world)
local y=cameraConfig.cameraPos[2]
local unitKey="8_0_0"
local argstable={
close=function()
worldController:lookAtUnit(unitKey,y,false)
worldController:resetRightView()
end
}
worldController:changeRightView("UIWorldBigBossActivityChallengeWIn",argstable)
end
end


function UIWorldBigBossActivityRankWin:onHelpBtn()
local d={}
d.mode=3
d.title="规则介绍"
d.name='worldbigboss_rank_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end


function UIWorldBigBossActivityRankWin:onGotoBtn()
local cfg=cfgHelper.get1(cfg_worldbossconfig_get,1)
local world=cfg.world
local position=worldPositionConfig:getPosition(world,cfg.position)
if worldController:isInWorld()and worldModel:isSameWorld(cfg.world)then
worldController:lookAtPosition(position)
self:onCloseBtn()
else
worldController:enterWorld(cfg.world,{lookAt=position})
end
end


function UIWorldBigBossActivityRankWin:onRewardBtn()
local args={
monsterIdx=self.monsterIdx,
stageIdx=self.stageIdx+1,
}
oneTabScreenController:openUI(SEC_FULL_TYPE.worldLeaderRewardSecondary,args)

end

function UIWorldBigBossActivityRankWin:onAddBtn()
worldLeaderController:showBuyDialogue()
end

function UIWorldBigBossActivityRankWin:onDropdownChange(index)
if index~=self.stageIdx then
self.stageIdx=index
self:refreshView(index)
end
end

function UIWorldBigBossActivityRankWin:refreshView(idx)
local _idx=idx+1

local baseCfg=cfgHelper.get1(cfg_worldbossconfig_get,1)
local cfg=baseCfg.monster[self.monsterIdx]
if cfg then
local monsterId=cfg[1][_idx]
local uiModelPos=baseCfg.uiModelPos[self.monsterIdx][_idx]
local uiNamePos=baseCfg.uiNamePos[self.monsterIdx][_idx]
local monsterParam=comHelper.getMonsterGroupModelParams(monsterId)
local scaleParam=isometricMapSystem:getModelScales2Pram(monsterParam.body,25)
self.bossModel:setChildUIModelShowTarget(monsterParam.body,scaleParam[1],monsterParam.componets,eAnimationID.stand)
self.bossModel:setChildUIModelShowTargetOffset(scaleParam[2],scaleParam[3])
local teamCnt=cfgHelper.get2(cfg_worldbosslevelconfig_get,self.stageIdx+1,"team_cnt")
local imageName=cfgHelper.get4(cfg_worldbossconfig_get,1,"nameImage",self.monsterIdx,teamCnt)
self.bossName:setSprite(_altasAB,imageName)
self.bossModel:setChildAnchoredPosition(mathHelper.convertArrayToVector(uiModelPos))
self.bossName:setChildAnchoredPosition(mathHelper.convertArrayToVector(uiNamePos))

local preMonster=cfg[1][1]
local preSkills=preMonster and cfgHelper.get2(cfg_monstergroup_get,preMonster,"showSkills")or{}
local preSkillLookup={}
for i,v in ipairs(preSkills)do
preSkillLookup[v[1]]=v[2]
end

local skillList=cfgHelper.get2(cfg_monstergroup_get,monsterId,"showSkills")or{}
self.skillList:setChildLayoutGroupCreateItems(#skillList,function(index)
local skillItem=self.skillList:getChildLayoutGroupGridItem(index-1)
local skillData=skillList[index]
local skillID=skillData[1]
local skillLv=skillData[2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
skillItem:SetChildActive(_skillCmp.widget,true)

skillItem:SetChildIcon(_skillCmp.icon,iconHelper.getSkillIcon(skillCfg.icon),false)

local is_bd=skillModel.isSkillBD(skillCfg.skillType)
skillItem:SetChildActive(_skillCmp.sign,is_bd)

local isNew=preSkillLookup[skillID]==nil and not worldLeaderModel:isSkillReaded(self.monsterIdx,skillID)

skillItem:SetChildActive(_skillCmp.new,isNew)

skillItem:SetChildButtonClick(_skillCmp.click,function()
if isNew then
worldLeaderModel:setSkillReaded(self.monsterIdx,skillID)
skillItem:SetChildActive(_skillCmp.new,false)
end

local x=-427+(index-1)*81
local y=-305
local center=Vector2.one*0.5
local leftBottom=Vector2.zero
local args={
skillId=skillID,
skillLv=skillLv,
rootPoint={
anchorsMin=center,
anchorsMax=center,
pivot=leftBottom,
anchoredPosition=Vector2.New(x,y)
}
}
UIManager:showWindow('UISimpleSkillTipsWin',args)
end)
end)
self.skillView:setChildScrollRectEnable(#skillList>4)
else
self.bossModel:setChildUIModelRemoveTarget()
self.bossName:setImageIcon("",true)

end
local info=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eShiJieShouLing)
self.bossTime:setText(FMT.fmt("首领将于{0}离开",timeHelper.dateServerStamp('%H:%M',info.end_time_l)))


local rankInfo=worldLeaderModel:getRank(_idx)
if rankInfo then
local rankCnt=#rankInfo.list
self.rankList:setChildLayoutGroupCreateItems(rankCnt,function(index)
local rankItem=self.rankList:getChildLayoutGroupGridItem(index-1)
local rankData=rankInfo.list[index]
rankItem:SetChildText(_rankItemCmp.no,FMT.fmt("第{0}名",index))
rankItem:SetChildText(_rankItemCmp.value,mathHelper.formatNumber(tonumber(tostring(rankData.param_2)),false))
rankItem:SetChildText(_rankItemCmp.name,rankData.param_1)
end)
local check=rankInfo.rank>0
self.myRankNo:setText(check and FMT.fmt("第{0}名",rankInfo.rank)or"未上榜")
self.myRankValue:setText(check and mathHelper.formatNumber(tonumber(tostring(worldLeaderModel:getTotalDamage())),false)or"————")
self.myRankName:setText(playerModel:getActorName()or"")
self.noneTips:setActive(rankCnt<=0)
else
worldLeaderController:send_248_32(_idx)
end

self:refreshTimes()
end

function UIWorldBigBossActivityRankWin:resetView()
if not self.monsterIdx then
self.monsterIdx=worldLeaderModel:getMonsterIdx()
end
if not self.stageIdx then
self.stageIdx=worldLeaderModel:getStageIdx()-1
self.stageDropdown:setValue(self.stageIdx)
end
self:refreshView(self.stageIdx)
end

function UIWorldBigBossActivityRankWin:refreshRankList(index)

if index~=self.stageIdx+1 then return end

local rankInfo=worldLeaderModel:getRank(index)

local rankCnt=#rankInfo.list
self.rankList:setChildLayoutGroupCreateItems(rankCnt,function(index)
local rankItem=self.rankList:getChildLayoutGroupGridItem(index-1)
local rankData=rankInfo.list[index]
rankItem:SetChildText(_rankItemCmp.no,FMT.fmt("第{0}名",index))
rankItem:SetChildText(_rankItemCmp.value,mathHelper.formatNumber(tonumber(tostring(rankData.param_2)),false))
rankItem:SetChildText(_rankItemCmp.name,rankData.param_1)
end)
local check=rankInfo.rank>0
self.myRankNo:setText(check and FMT.fmt("第{0}名",rankInfo.rank)or"未上榜")
self.myRankValue:setText(check and mathHelper.formatNumber(tonumber(tostring(worldLeaderModel:getTotalDamage())),false)or"————")
self.myRankName:setText(playerModel:getActorName()or"")
self.noneTips:setActive(rankCnt<=0)
end

function UIWorldBigBossActivityRankWin:refreshTimes()
local cur=worldLeaderModel:getChallengeTimes()
local buy=worldLeaderModel:getBuyTimes()
local free=cfgHelper.get2(cfg_worldbossconfig_get,1,"free")
self.addTx:setText(FMT.fmt("挑战次数：{0}/{1}",cur,buy+free))
end
