







def_class("UIXJFMChallengeWIn",UIWindowBase)









function UIXJFMChallengeWIn:bindComponents()

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
self.mask=UIButton.get(self,16)
self.posTxt=UIText.get(self,17)
self.rankReddot=UIObject.get(self,18)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.challengeBtn:setButtonClick(function()self:onChallengeBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.fastToggle:setButtonClick(function()self:onFastToggle()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIXJFMChallengeWIn:unbindComponents()
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
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.posTxt);self.posTxt=nil;
_UIObject_release(self.rankReddot);self.rankReddot=nil;
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



function UIXJFMChallengeWIn:onLoaded(...)
self:bindComponents()
self:addNotify(notifyConfig.onXianJieCameraMove,self.onXianJieCameraMove)
self:addNotify(notifyConfig.onXianJieCameraZoom,self.onXianJieCameraZoom)
_this=self
self.fast=XianJieFuMoController.fast
self.fastToggleCheck:setActive(self.fast==true)
self:addReddotNotify(REDDIT_TYPE.eXianjieFuMo,function(...)
self:refreshRankReddot(...)
end)
end


function UIXJFMChallengeWIn:__delete()
self:unbindComponents()
_this=nil
end




function UIXJFMChallengeWIn:onShow(argtable,afterOnloaded)
self.closeCallback=argtable.close
self.monsterIdx=XianJieFuMoModel:getMonsterIdx()
local data=XianJieFuMoController:getBossData()
if data then
local gridX_c,gridZ_c=data:getCenterGridPosFloor()
local pos_str=FMT.fmt('（X:{0},Y:{1}）',gridX_c,gridZ_c)
self.posTxt:setText(pos_str)
else
self.posTxt:setText("")
end


self:refreshView()
self:showMutliTeamNewbie()
self:refreshRankReddot()
end


function UIXJFMChallengeWIn:onHide()
end




function UIXJFMChallengeWIn:onCloseBtn()

if self.closeCallback then
self.closeCallback()
else
xianjieController:closeWin("UIXJFMChallengeWIn")
end
end

function UIXJFMChallengeWIn:onMask()
self:onCloseBtn()
end


function UIXJFMChallengeWIn:onRankBtn()
XianJieFuMoController:reqRankInfo()
end

function UIXJFMChallengeWIn:onRewardBtn()
UIManager:showWindow("UIDetailDropWin",{detail=self.detialList})
end


function UIXJFMChallengeWIn:onChallengeBtn()
if XianJieFuMoController.checkStopFight()then
UIManager.info("首领已击败，无法挑战")
xianjieController:closeWin("UIXJFMChallengeWIn")
return
end
local curr=XianJieFuMoModel:getChallengedCnt()
local buy=XianJieFuMoModel:getBuyedCnt()

local free=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"free")
if curr>=buy+free then
local buyCfg=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"buy")
local buymax=#buyCfg
if buy>=buymax then
UIManager.error("挑战次数已用完")
else
self:onAddBtn()
end
return
end
if self.fast then
local lastDamage=XianJieFuMoModel:getMaxdamage()
if lastDamage>0 then
XianJieFuMoController.req_248_107()
else
UIManager.error("请先进行一次挑战")
end
else
if bagControl.checkShowFullEquipBagTips('无法继续挑战')then
return
end
XianJieFuMoController:fightPrepare()
xianjieController:closeWin("UIXJFMChallengeWIn")
end
end


function UIXJFMChallengeWIn:onAddBtn()
XianJieFuMoController:showBuyDialogue()
end

function UIXJFMChallengeWIn:onFastToggle()

if not self.fast then
if XianJieFuMoModel:getMaxdamage()<=0 then
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
XianJieFuMoController.fast=self.fast
self.fastToggleCheck:setActive(self.fast)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end
return
end
self.fast=not self.fast
XianJieFuMoController.fast=self.fast
self.fastToggleCheck:setActive(self.fast)
end

function UIXJFMChallengeWIn:refreshView()

local baseCfg=cfgHelper.get1(cfg_fairylandbossconfig_get,1)
local cfg=baseCfg.monster[self.monsterIdx]
local lvIdx=XianJieFuMoModel:getData().lvIdx or 1
if cfg then
local monsterId=cfg[1][lvIdx]
comHelper.setChildModelRawImage_monsterGroup(self.winlua,monsterId,self.bossIcon:getID(),0,eHeadCenterType.eHead)


local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterId)
self.bossName:setText(monsterCfg.name)
self.jjTx:setText(FMT.fmt("境界：{0}",UIDiscipleModel:getJJName3(monsterCfg.level)))

local preMonster=monsterId
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

local isNew=preSkillLookup[skillID]==nil and not XianJieFuMoModel:isSkillReaded(self.monsterIdx,skillID)
skillItem:SetChildActive(_skillCmp.new,isNew)

skillItem:SetChildButtonClick(_skillCmp.click,function()
if isNew then
XianJieFuMoModel:setSkillReaded(self.monsterIdx,skillID)
skillItem:SetChildActive(_skillCmp.new,false)
end
local pos=skillItem:GetChildScreenPointToLocalPointRectangle(-1)

local x=pos.x-20
local y=pos.y
local center=Vector2.one*0.5

local args={
skillId=skillID,
skillLv=skillLv,
rootPoint={
anchorsMin=center,
anchorsMax=center,
pivot=Vector2.right,
anchoredPosition=Vector2.New(x,y)
}
}
UIManager:showWindow('UISimpleSkillTipsWin',args)
end)
end)
self.skillView:setChildScrollRectEnable(#skillList>3)

local rewardId=cfg[2]
local rcfg=cfgHelper.get1(cfg_awardconfig_get,rewardId)
local level=1
if rcfg.groupInfo then
logErr('仙界伏魔掉落id 配置了自适应参数，等级使用默认1 id：',rewardId)
end
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

function UIXJFMChallengeWIn:refreshTimes()
local cur=XianJieFuMoModel:getChallengedCnt()
local buy=XianJieFuMoModel:getBuyedCnt()
local free=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"free")
self.addTx:setText(FMT.fmt("次数：{0}/{1}",cur,buy+free))
end

function UIXJFMChallengeWIn:refreshChallenge()
local num=XianJieFuMoModel:getMaxdamage()
local numStr=num>0 and mathHelper.formatNumber4(num,2)or"   暂无伤害"
local str=FMT.fmt("单次挑战最高伤害：<size=30>{0}</size>",numStr)
self.lastTx:setText(str)
self:refreshTimes()
end

function UIXJFMChallengeWIn:showMutliTeamNewbie()
if not XianJieFuMoModel.mutilTeamNewBie then
local args={
ruleGroupID=ruleTipsImageGroup.eXJFMBoss,
}
self:showWindow("UIRuleTipsImage2Win",args)

XianJieFuMoModel:finishMutilTeamNewBie()
end
end

function UIXJFMChallengeWIn.onXianJieCameraMove()
if _this==nil or not _this.isVisible then return end
xianjieController:closeWin3()
end

function UIXJFMChallengeWIn.onXianJieCameraZoom()
if _this==nil or not _this.isVisible then return end
xianjieController:closeWin3()
end


function UIXJFMChallengeWIn:refreshRankReddot()
local flag=XianJieFuMoController:checkTargetReddot()
self.rankReddot:setActive(flag)
end
