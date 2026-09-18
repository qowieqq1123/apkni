







def_class("UISubAct_TianMoRuQin_MonsterDialog",UIWindowBase)









function UISubAct_TianMoRuQin_MonsterDialog:bindComponents()

self.background=UIButton.get(self,0)
self.bgModel=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.source=UIObject.get(self,3)
self.shareBtn=UIButton.get(self,4)
self.buttonBg1=UIObject.get(self,5)
self.settingBtn=UIButton.get(self,6)
self.costBg=UIObject.get(self,7)
self.fightNum=UIText.get(self,8)
self.fightBtn=UIButton.get(self,9)
self.rankBtn=UIButton.get(self,10)
self.monsterType=UIImage.get(self,11)
self.moneyBg=UIButton.get(self,12)
self.leastTime=UIText.get(self,13)
self.progressBar=UIProgress.get(self,14)
self.model=UIObject.get(self,15)
self.skillList=UIObject.get(self,16)
self.closeBtn=UIButton.get(self,17)
self.fightPeople=UIText.get(self,18)
self.buttonBg2=UIObject.get(self,19)
self.sourceHead=UIObject.get(self,20)
self.sourceName=UIText.get(self,21)
self.costIcon=UIImage.get(self,22)
self.costNum=UIText.get(self,23)
self.moneyNum=UIText.get(self,24)
self.moneyIcon=UIImage.get(self,25)
self.moneyAdd=UIButton.get(self,26)
self.rewardList=UIObject.get(self,27)
self.nameTx=UIText.get(self,28)

self.background:setButtonClick(function()self:onBackground()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)

self.settingBtn:setButtonClick(function()self:onSettingBtn()end)

self.fightBtn:setButtonClick(function()self:onFightBtn()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.moneyBg:setButtonClick(function()self:onMoneyBg()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.moneyAdd:setButtonClick(function()self:onMoneyAdd()end)



end


function UISubAct_TianMoRuQin_MonsterDialog:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.source);self.source=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.buttonBg1);self.buttonBg1=nil;
_UIObject_release(self.settingBtn);self.settingBtn=nil;
_UIObject_release(self.costBg);self.costBg=nil;
_UIObject_release(self.fightNum);self.fightNum=nil;
_UIObject_release(self.fightBtn);self.fightBtn=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.monsterType);self.monsterType=nil;
_UIObject_release(self.moneyBg);self.moneyBg=nil;
_UIObject_release(self.leastTime);self.leastTime=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.skillList);self.skillList=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.fightPeople);self.fightPeople=nil;
_UIObject_release(self.buttonBg2);self.buttonBg2=nil;
_UIObject_release(self.sourceHead);self.sourceHead=nil;
_UIObject_release(self.sourceName);self.sourceName=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costNum);self.costNum=nil;
_UIObject_release(self.moneyNum);self.moneyNum=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyAdd);self.moneyAdd=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
end















local _this=nil



function UISubAct_TianMoRuQin_MonsterDialog:onLoaded(...)
self:bindComponents()
_this=self

notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
end


function UISubAct_TianMoRuQin_MonsterDialog:__delete()
self:unbindComponents()
_this=nil

notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
end




function UISubAct_TianMoRuQin_MonsterDialog:onShow(argtable,afterOnloaded)
self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.config=activitiesModel:getSubActivityConfig(argtable.subType,argtable.subId)
self.info=activitiesModel:getSubActInfo(argtable.actId,argtable.subType,argtable.subId)
self.monster=argtable.monster
self.fighted=argtable.fighted
self.peopleNum=argtable.people
self.leaveTime=argtable.leaveTime
self.damage=argtable.damage
self.actorData=argtable.source
self.shared=argtable.shareFlag
self.guid=argtable.guid
self.jumpParams=argtable.jumpParams
self.jumpType=argtable.jumpType
self.level=argtable.level

self.bgModel:setChildUIModelShowTarget(4922,1,{},eAnimationID.enter,false,false,0,function()
self:delayDo(0.4,function()
self.root:setChildCanvasGroupAlpha(1)
self.canClose=true
end)
end)

self.monsterCfg=cfgHelper.get1(cfg_monstergroup_get,self.monster)
self.monType=self.monsterCfg.monType
local modelParams=comHelper.getMonsterGroupModelParams(self.monster)
local scaleParam=isometricMapSystem:getModelScales2Pram(modelParams.body,10)
self.model:setChildUIModelShowTarget(modelParams.body,scaleParam[1],modelParams.componets,eAnimationID.stand,false,false,0,nil)
self.model:setChildUIModelShowTargetOffset(scaleParam[2],scaleParam[3])
local abName=globalABLookup.global
local assetName=monTypeTagA[self.monType]
if assetName then
self.monsterType:setSprite(abName,assetName)
else
self.monsterType:setImageIcon("",false)
end
self.nameTx:setText(self.monsterCfg.name)

local monsterInfo=self.config.monster[self.monType]
local rewards={}
if self.monsterCfg.drops and self.monsterCfg.drops[1]then
rewards=worldFightModel:getMonsterShowAwardsEx2({self.monsterCfg.drops[1]},self.level)
end

self.rewardList:setChildLayoutGroupCreateItems(#rewards,function(index)
local item=self.rewardList:getChildLayoutGroupGridItem(index-1)
local data=rewards[index]
local showCountBG=data.range~=nil or data[2]>1
local countStr=data[2]>1 and data[2]or""
local conf={itemid=data[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,range=data.range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
item:SetChildActive(1,data[2]==-1)
end)

local skillList=self.config.texing[self.monster]or{}

self.skillCnt=#skillList
self.skillList:setChildLayoutGroupCreateItems(self.skillCnt,function(index)
local item=self.skillList:getChildLayoutGroupGridItem(index-1)
local skillData=skillList[index]
local skillType=skillData[1]
local skillIndex=skillData[2]
local iconName=""
if skillType==1 then
local skillParam=self.monsterCfg.showSkills and self.monsterCfg.showSkills[skillIndex]or nil
if skillParam then
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillParam[1])
iconName=iconHelper.getSkillIcon(skillCfg.icon)
else
loggerUtil.logWarnFMT("天魔魔碑怪物无效怪物特性:{0},{1},{2}",self.monster,skillType,skillIndex)
end
else
local skillParam=self.config.faze[self.monster]
if skillParam then
local fazeID=skillParam[skillIndex][1]
local skillCfg=cfgHelper.getSSlawRule(fazeID)
iconName=skillCfg.image
else
loggerUtil.logWarnFMT("天魔魔碑怪物无效怪物特性:{0},{1},{2}",self.monster,skillType,skillIndex)
end
end
item:SetChildCSImageIcon(-1,iconName,false)
item:SetChildButtonClick(-1,function()
self:onClickSkill(index)
end)
end)

local damage=tonumber(tostring(self.damage))
local maxBlood=tonumber(tostring(self.info:getMaxBloods(self.monType)))
self.bloodPrecent=(maxBlood-damage)/maxBlood
self.progressBar:setProgressValue(math.ceil(self.bloodPrecent*10000),10000)
self.progressBar:setChildProgressText(FMT.fmt("{0}%",math.ceil(self.bloodPrecent*100)))

local personal=self.info:findMonsterIndex(self.guid)
self.isSelf=personal~=nil
self.settingBtn:setActive(self.isSelf)
self.shareBtn:setActive(self.isSelf)
self.source:setActive(not self.isSelf)
self.buttonBg1:setActive(not self.isSelf)
self.buttonBg2:setActive(self.isSelf)
if not self.isSelf then
playerController:setHeadIcon(self.winlua,self.sourceHead:getID(),{iconInfo=self.actorData.iconInfo})
self.sourceName:setText(self.actorData.actorName)
else
self.shareBtn:setChildImageExGray(self.fighted<=0)
end

self.maxPeople=monsterInfo[2]
self.fightPeople:setText(FMT.fmt("挑战人数 <color=#5C9731>({0}/{1})</color>",self.peopleNum,self.maxPeople))
self.fightNum:setText(FMT.fmt("已挑战次数：{0}",self.fighted))

local monsterCost=self.config.monster[self.monType]
monsterCost=self.isSelf and monsterCost[4]or monsterCost[5]
local costNum=monsterCost[self.fighted+1]or monsterCost[#monsterCost]
self.costIcon:setActive(costNum>0)
if costNum>0 then
self.costIcon:setImageIcon(iconHelper.getIconName(self.config.money[1]),false)
self.costNum:setText(costNum)
else
self.costNum:setText("首次免费")
end
self.winlua:ForceLayoutRect(self.costBg:getID())


self:initMoney()
self:updateLeaveTick()
self:startLeaveTick()
end


function UISubAct_TianMoRuQin_MonsterDialog:onHide()

end





function UISubAct_TianMoRuQin_MonsterDialog:onBackground()
if self.canClose then
self:closeSelf()
end
end



function UISubAct_TianMoRuQin_MonsterDialog:onShareBtn()
if self.fighted>0 then
if self.leaveTime>0 then
local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
guid=self.guid,
shared=self.shared,
leaveTime=self.leaveTime,
monster=self.monster,
precent=self.bloodPrecent,
level=self.level,
}
self:showWindow("UISubAct_TianMoRuQin_ShareDialog",args)
end
else
UIManager.info("天魔挑战后方可分享")
end
end



function UISubAct_TianMoRuQin_MonsterDialog:onRankBtn()
if not self.isSelf or self.fighted>0 then
call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqMonsterRank",self.actId,self.subId,self.guid)
else

local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
guid=self.guid,
id=self.monster,
datas={},
}
self:showWindow("UISubAct_TianMoRuQin_RankDialog",args)
end
end



function UISubAct_TianMoRuQin_MonsterDialog:onFightBtn()
if self.peopleNum>=self.maxPeople and self.fighted<=0 then
return UIManager.error("挑战人数已满")
end

local monsterCost=self.config.monster[self.monType]
monsterCost=self.isSelf and monsterCost[4]or monsterCost[5]
local needNum=monsterCost[self.fighted+1]or monsterCost[#monsterCost]
local costId=self.config.money[1]
local haveNum=itemsModel.getCount(costId)

if needNum>haveNum then
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(costId)))
gainControl:showGainWin(costId)
return
end


local nowTime=timeHelper.getServerShortTime()
local leaveTime=self.leaveTime
if leaveTime>0 and nowTime>=leaveTime then
return UIManager.error("天魔已离开")
end

local monsterId=self.monster
local actId=self.actId
local subType=self.subType
local subId=self.subId
local guid=self.guid
local index=self.info:findMonsterIndex(self.guid)


local jumpParams=self.jumpParams
local jumpType=self.jumpType
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterId)
local params={
actId=self.actId,
subType=self.subType,
subId=self.subId,
source=self.actorData,
monster=self.monster,
leaveTime=self.leaveTime,
people=self.peopleNum,
fighted=self.fighted,
damage=self.damage,
guid=self.guid,
shareFlag=self.shared,
jumpParams=self.jumpParams,
}
local subActInfo=self.info
local args={
dontCloseStage=false,
enterTxt=self.config.sub_name,
groupId=monsterId,
monsterList=monsterCfg.monList,
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
isHomeBattle=false,
enterCallBack=function(selectList,zfId)
if not subActInfo:checkDoing()then
UIManager.error("活动已结束")
return
end

if leaveTime>0 and nowTime>=leaveTime then
UIManager.error("天魔已离开")
if jumpParams then
jumpManager:jump(jumpParams)
else
UIManager:showWindow("UISubAct_TianMoRuQin_MonsterDialog",params)
end
return
end
fightLaunchController:sendFight(eBattleLaunch.tianmoruqin_tm,selectList,monsterCfg.mapId or 0,zfId,{actId,subType,subId,guid})
subActInfo:pushFightMonsterJump(guid,jumpType,jumpParams)
end,
cancelCallBack=function()
if jumpParams then
jumpManager:jump(jumpParams)
else
UIManager:showWindow("UISubAct_TianMoRuQin_MonsterDialog",params)
end
end,
}

local config=self.config
local monster=self.monster
fightController.showPrepareWin(fightPreSelectModel.fightType.tianmoruqin_tm,args,function()
local txList=config.texing[monster]or{}
local datas={}
for i,v in ipairs(txList)do
local type=v[1]
local index=v[2]
local param={}
if type==1 then
param=monsterCfg.showSkills and monsterCfg.showSkills[index]or nil
else
param=config.faze[monster]and config.faze[monster][index]or nil
end
if param then
local data={type,param}
table.insert(datas,data)
else
loggerUtil.logWarnFMT("天魔入侵怪物无效特性配置：{0},{1},{2}",monster,type,index)
end
end
local args={
title="天魔特性",
data=datas,
}
UIFullFightPrepareControl:showWindow("UIFightPrepareTianMoRuQinTeXingWin",args)

end)
end


function UISubAct_TianMoRuQin_MonsterDialog:onCloseBtn()
self:onBackground()
end


function UISubAct_TianMoRuQin_MonsterDialog:onSettingBtn()
local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
}
self:showWindow("UISubAct_TianMoRuQin_ShareSettingDialog",args)
end

function UISubAct_TianMoRuQin_MonsterDialog:onClickSkill(index)
local x=-146+78*(index-(self.skillCnt/2+0.5))
local txInfo=self.config.texing[self.monster][index]
local txType=txInfo[1]
local txIndex=txInfo[2]
local name,icon,desc,bottomLeft
if txType==1 then
local txParam=self.monsterCfg.showSkills[txIndex]
local skillId=txParam[1]
local skillLv=txParam[2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
local is_bd=skillModel.isSkillBD(skillCfg.skillType)
name=skillCfg.name
icon=iconHelper.getSkillIcon(skillCfg.icon)
desc=skillModel:getSkillDesc(skillId,skillLv)
bottomLeft=is_bd and{globalABLookup.global,"icon_jnbeidong"}or nil
else
local txParam=self.config.faze[self.monster][txIndex]
local fazeID=txParam[1]
local fazeLv=txParam[2]
local fazeCfg=cfgHelper.getSSlawRule(fazeID)
local descparm=fazeCfg.descparm
name=fazeCfg.name
icon=fazeCfg.image
desc=descparm and string.format(fazeCfg.desc,unpack(descparm[fazeLv]))or fazeCfg.desc
bottomLeft=nil
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
pivot=halfVector,
anchoredPosition=Vector2.New(x,245),
}
}
self:showWindow('UISimpleTeXingTipsWin',args)
end

function UISubAct_TianMoRuQin_MonsterDialog:startLeaveTick()
local nowTime=timeHelper.getServerShortTime()
if not self.leaveTick then
if self.leaveTime>0 and nowTime<self.leaveTime then
self.leaveTick=self:setTimer(1,0,function()
self:updateLeaveTick()
end)
end
end
end

function UISubAct_TianMoRuQin_MonsterDialog:updateLeaveTick()
if self.leaveTime>0 then
local nowTime=timeHelper.getServerShortTime()
local leastTime=self.leaveTime-nowTime
if leastTime>0 then
self.leastTime:setText(FMT.fmt("{0}后离开",timeHelper.format_time_stamp(leastTime)))
else
self.leastTime:setText("已离开")
self:stopLeaveTick()
end
else
self.leastTime:setText("")
self:stopLeaveTick()
end
end

function UISubAct_TianMoRuQin_MonsterDialog:stopLeaveTick()
if self.leaveTick then
self:stopTimerByID(self.leaveTick)
self.leaveTick=nil
end
end

function UISubAct_TianMoRuQin_MonsterDialog:on_249_134(actId,subId,monsterGuid,flag)
if self.info:compare(actId,self.subType,subId)and self.guid==monsterGuid then
self.shared=flag
end
end

function UISubAct_TianMoRuQin_MonsterDialog.on_money_changed(moneyType,lastVal,val)
if moneyType==_this.costItem then
_this:refreshMoney(val)
end
end

function UISubAct_TianMoRuQin_MonsterDialog.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if itemid==_this.costItem then
_this:refreshMoney(newcount)
end
end

function UISubAct_TianMoRuQin_MonsterDialog:initMoney()
self.costItem=self.config.money[1]
local iconName=iconHelper.getIconName(self.costItem)
self.moneyIcon:setImageIcon(iconName,false)

self:refreshMoney()
end

function UISubAct_TianMoRuQin_MonsterDialog:refreshMoney(val)
local cur=val or itemsModel.getCount(self.costItem)
self.moneyNum:setText(cur)
end

function UISubAct_TianMoRuQin_MonsterDialog:onMoneyAdd()
self.info:showMoneyBuyPanel(self.costItem)
end

function UISubAct_TianMoRuQin_MonsterDialog:onMoneyBg()
gainControl:showGainWin(self.costItem)
end

function UISubAct_TianMoRuQin_MonsterDialog:onActivityEnd(actId,subType,subId)
if _this.info:compare(actId,subType,subId)then
_this:closeSelf()
end
end