







def_class("UIWorldBigBossActivityChallengeWIn",UIWindowBase)









function UIWorldBigBossActivityChallengeWIn:bindComponents()

self.addBtn=UIButton.get(self,0)
self.addTx=UIText.get(self,1)
self.bossIcon=UIObject.get(self,2)
self.bossName=UIText.get(self,3)
self.challengeBtn=UIButton.get(self,4)
self.closeBtn=UIButton.get(self,5)
self.fastToggle=UIButton.get(self,6)
self.fastToggleCheck=UIObject.get(self,7)
self.jjTx=UIText.get(self,8)
self.lastTx=UIText.get(self,9)
self.rankBtn=UIButton.get(self,10)
self.rewardBtn=UIButton.get(self,11)
self.rewardList=UIObject.get(self,12)
self.rewardView=UIObject.get(self,13)
self.skillList=UIObject.get(self,14)
self.skillView=UIObject.get(self,15)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.challengeBtn:setButtonClick(function()self:onChallengeBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.fastToggle:setButtonClick(function()self:onFastToggle()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)



end


function UIWorldBigBossActivityChallengeWIn:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.addTx);self.addTx=nil;
_UIObject_release(self.bossIcon);self.bossIcon=nil;
_UIObject_release(self.bossName);self.bossName=nil;
_UIObject_release(self.challengeBtn);self.challengeBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.fastToggle);self.fastToggle=nil;
_UIObject_release(self.fastToggleCheck);self.fastToggleCheck=nil;
_UIObject_release(self.jjTx);self.jjTx=nil;
_UIObject_release(self.lastTx);self.lastTx=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rewardView);self.rewardView=nil;
_UIObject_release(self.skillList);self.skillList=nil;
_UIObject_release(self.skillView);self.skillView=nil;
end
















local _this=nil
local _skillCmp={
widget=-1,
icon=0,
sign=1,
lvText=2,
click=3,
lv=4,
new=5,
}



function UIWorldBigBossActivityChallengeWIn:onLoaded(...)
self:bindComponents()
_this=self
self.fast=worldLeaderController.fast
end


function UIWorldBigBossActivityChallengeWIn:__delete()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.swipe,self.on_swipe)
notifySystem:removelistener(notifyConfig.onClickEmptyInWorld,self.onClickEmptyInWorld)
end




function UIWorldBigBossActivityChallengeWIn:onShow(argtable,afterOnloaded)
notifySystem:listenNotify(notifyConfig.swipe,self.on_swipe)
notifySystem:listenNotify(notifyConfig.onClickEmptyInWorld,self.onClickEmptyInWorld)

if not(limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eShiJieShouLing)or not limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eShiJieShouLing))then
worldController:resetRightView()
return
end

self.closeCallback=argtable.close
self.monsterIdx=worldLeaderModel:getMonsterIdx()
self.stageIdx=worldLeaderModel:getStageIdx()
self:refreshView()
self:showMutliTeamNewbie()
end


function UIWorldBigBossActivityChallengeWIn:onHide()
notifySystem:removelistener(notifyConfig.swipe,self.on_swipe)
notifySystem:removelistener(notifyConfig.onClickEmptyInWorld,self.onClickEmptyInWorld)
end




function UIWorldBigBossActivityChallengeWIn:onCloseBtn()

if self.closeCallback then
self.closeCallback()
else
worldController:resetRightView()
end
end

function UIWorldBigBossActivityChallengeWIn:onRankBtn()
UIFullWorldBigBossController:showRankWindow()
end

function UIWorldBigBossActivityChallengeWIn:onRewardBtn()
UIManager:showWindow("UIDetailDropWin",{detail=self.detialList})
end


function UIWorldBigBossActivityChallengeWIn:onChallengeBtn()
local curr=worldLeaderModel:getChallengeTimes()
local buy=worldLeaderModel:getBuyTimes()
local free=cfgHelper.get2(cfg_worldbossconfig_get,1,"free")
if curr>=buy+free then
local buyCfg=cfgHelper.get2(cfg_worldbossconfig_get,1,"buy")
local buymax=#buyCfg
if buy>=buymax then
UIManager.error("挑战次数已用完")
else
self:onAddBtn()
end
return
end
if self.fast then
local lastDamage=worldLeaderModel:getLastDamage()
if lastDamage>int64.zero then
worldLeaderController:send_248_33()
else
UIManager.error("请先进行一次挑战")
end
else
if bagControl.checkShowFullEquipBagTips('无法继续挑战',function()self:onCloseBtn()end)then
return
end
worldLeaderController:fightPrepare()
worldController:resetRightView()
end
end


function UIWorldBigBossActivityChallengeWIn:onAddBtn()
worldLeaderController:showBuyDialogue()
end

function UIWorldBigBossActivityChallengeWIn:onFastToggle()

if not self.fast then
if tonumber(tostring(worldLeaderModel:getLastDamage()))<=0 then
UIManager.error("需要先进行一次挑战")
else
local show_data={
type='UIDialouge',
title='提示',
content='勾选后进行挑战会根据单次挑战最高伤害量进行快速结算，是否确认？',
oktext='确定',
canceltext='取消',
okcallback=function()
self.fast=not self.fast
worldLeaderController.fast=self.fast
self.fastToggleCheck:setActive(self.fast)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end
return
end
self.fast=not self.fast
self.fastToggleCheck:setActive(self.fast)
end

function UIWorldBigBossActivityChallengeWIn:showMutliTeamNewbie()
if not worldLeaderModel.mutilTeamNewBie then
local team_cnt=cfgHelper.get2(cfg_worldbosslevelconfig_get,self.stageIdx,"team_cnt")
if team_cnt>1 then
local args={
ruleGroupID=ruleTipsImageGroup.eWorldLeader,
}
self:showWindow("UIRuleTipsImage2Win",args)

worldLeaderModel:finishMutilTeamNewBie()
end
end
end

function UIWorldBigBossActivityChallengeWIn:refreshView()

local cfg=cfgHelper.get3(cfg_worldbossconfig_get,1,"monster",self.monsterIdx)
if cfg then
local monsterId=cfg[1][self.stageIdx]
comHelper.setChildModelRawImage_monsterGroup(self.winlua,monsterId,self.bossIcon:getID(),0,eHeadCenterType.eHead)


local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterId)
self.bossName:setText(monsterCfg.name)
self.jjTx:setText(FMT.fmt("境界：{0}",UIDiscipleModel:getJJName3(monsterCfg.level)))

local preMonster=cfg[1][1]
local preSkills=preMonster and cfgHelper.get2(cfg_monstergroup_get,preMonster,"showSkills")or{}
local preSkillLookup={}
for i,v in ipairs(preSkills)do
preSkillLookup[v[1]]=v[2]
end

local skillList=monsterCfg.showSkills or{}
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

local x=#skillList*-41+(index-1)*82+19
local args={
skillId=skillID,
skillLv=skillLv,
rootPoint={
anchorsMin=Vector2.right,
anchorsMax=Vector2.right,
pivot=Vector2.right,
anchoredPosition=Vector2.New(-265+x,427)
}
}
UIManager:showWindow('UISimpleSkillTipsWin',args)
end)
end)
self.skillView:setChildScrollRectEnable(#skillList>4)

local rewardId=cfg[2]




local lvCfg=cfgHelper.get1(cfg_worldbosslevelconfig_get,self.stageIdx)
local level=lvCfg['2']
local rewardCfg=itemsAwardConfig:getAwardInConfigByLevel(rewardId,level)
self.detialList=rewardCfg.detailItems
local rewardList=rewardCfg.showItems
self.rewardList:setChildLayoutGroupCreateItems(#rewardList,function(index)
local rewardItem=self.rewardList:getChildLayoutGroupGridItem(index-1)
local rewardData=rewardList[index]
local data={
[1]=rewardData[1],
[2]=rewardData[2],
[3]=rewardData[3],

}
widgetHelper.setNormalRewardItem(rewardItem,-1,rewardData,true)







end)
end
self.fastToggleCheck:setActive(self.fast)

self:refreshChallenge()

end

function UIWorldBigBossActivityChallengeWIn:refreshTimes()
local cur=worldLeaderModel:getChallengeTimes()
local buy=worldLeaderModel:getBuyTimes()
local free=cfgHelper.get2(cfg_worldbossconfig_get,1,"free")
self.addTx:setText(FMT.fmt("次数：{0}/{1}",cur,buy+free))
end

function UIWorldBigBossActivityChallengeWIn:refreshChallenge()
local num=tonumber(tostring(worldLeaderModel:getLastDamage()))
local numStr=num>0 and mathHelper.formatNumber4(num,2)or"暂无伤害"
self.lastTx:setText(numStr)
self:refreshTimes()
end

function UIWorldBigBossActivityChallengeWIn.onClickEmptyInWorld()
if _this then
_this:onCloseBtn()
end
end

function UIWorldBigBossActivityChallengeWIn.on_swipe()
if _this then
worldController.on_swipe_end(0)
_this:onCloseBtn()
end
end
