







def_class("UIFightAllMsgWin",UIWindowBase)









function UIFightAllMsgWin:bindComponents()

self.addHp=UIText.get(self,0)
self.alladdHp=UIButton.get(self,1)
self.allhurt=UIButton.get(self,2)
self.allinfoBtn=UIButton.get(self,3)
self.allinfoPanel=UIObject.get(self,4)
self.closebtn=UIButton.get(self,5)
self.controlnum=UIText.get(self,6)
self.dienum=UIText.get(self,7)
self.dikangnum=UIText.get(self,8)
self.discipleJobBtn=UIButton.get(self,9)
self.discipleJobIcon=UIImage.get(self,10)
self.discipleModelRoot=UIObject.get(self,11)
self.hurt=UIText.get(self,12)
self.infoRoot=UIObject.get(self,13)
self.injure=UIText.get(self,14)
self.killnum=UIText.get(self,15)
self.leftlistItem=UIObject.get(self,16)
self.MonsterModelRoot=UIObject.get(self,17)
self.myrelivenum=UIText.get(self,18)
self.name=UIText.get(self,19)
self.otherrelivenum=UIText.get(self,20)
self.rightlistItem=UIObject.get(self,21)
self.rolespbtn=UIButton.get(self,22)
self.shanbinum=UIText.get(self,23)
self.Shield=UIText.get(self,24)
self.wudinum=UIText.get(self,25)
self.allShield=UIButton.get(self,26)
self.jobSkillRoot=UIObject.get(self,27)
self.gfSkillRoot=UIObject.get(self,28)
self.stSkillRoot=UIObject.get(self,29)
self.tmSkillRoot=UIObject.get(self,30)
self.rightScrollView=UIObject.get(self,31)
self.enemyPanel=UIObject.get(self,32)
self.suitSkillRoot=UIObject.get(self,33)
self.xixueTextRoot=UIObject.get(self,34)
self.xixueText=UIText.get(self,35)
self.root=UIObject.get(self,36)
self.onlyXixuePanel=UIObject.get(self,37)
self.onlyXixueClickMask=UIButton.get(self,38)
self.onlyXixueText=UIText.get(self,39)
self.teamGrid=UIObject.get(self,40)
self.namebg=UIObject.get(self,41)
self.discipleJobIcon2=UIImage.get(self,42)
self.spBg=UIObject.get(self,43)

self.alladdHp:setButtonClick(function()self:onAlladdHp()end)

self.allhurt:setButtonClick(function()self:onAllhurt()end)

self.allinfoBtn:setButtonClick(function()self:onAllinfoBtn()end)

self.closebtn:setButtonClick(function()self:onClosebtn()end)

self.discipleJobBtn:setButtonClick(function()self:onDiscipleJobBtn()end)

self.rolespbtn:setButtonClick(function()self:onRolespbtn()end)

self.allShield:setButtonClick(function()self:onAllShield()end)

self.onlyXixueClickMask:setButtonClick(function()self:onOnlyXixueClickMask()end)



end


function UIFightAllMsgWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addHp);self.addHp=nil;
_UIObject_release(self.alladdHp);self.alladdHp=nil;
_UIObject_release(self.allhurt);self.allhurt=nil;
_UIObject_release(self.allinfoBtn);self.allinfoBtn=nil;
_UIObject_release(self.allinfoPanel);self.allinfoPanel=nil;
_UIObject_release(self.closebtn);self.closebtn=nil;
_UIObject_release(self.controlnum);self.controlnum=nil;
_UIObject_release(self.dienum);self.dienum=nil;
_UIObject_release(self.dikangnum);self.dikangnum=nil;
_UIObject_release(self.discipleJobBtn);self.discipleJobBtn=nil;
_UIObject_release(self.discipleJobIcon);self.discipleJobIcon=nil;
_UIObject_release(self.discipleModelRoot);self.discipleModelRoot=nil;
_UIObject_release(self.hurt);self.hurt=nil;
_UIObject_release(self.infoRoot);self.infoRoot=nil;
_UIObject_release(self.injure);self.injure=nil;
_UIObject_release(self.killnum);self.killnum=nil;
_UIObject_release(self.leftlistItem);self.leftlistItem=nil;
_UIObject_release(self.MonsterModelRoot);self.MonsterModelRoot=nil;
_UIObject_release(self.myrelivenum);self.myrelivenum=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.otherrelivenum);self.otherrelivenum=nil;
_UIObject_release(self.rightlistItem);self.rightlistItem=nil;
_UIObject_release(self.rolespbtn);self.rolespbtn=nil;
_UIObject_release(self.shanbinum);self.shanbinum=nil;
_UIObject_release(self.Shield);self.Shield=nil;
_UIObject_release(self.wudinum);self.wudinum=nil;
_UIObject_release(self.allShield);self.allShield=nil;
_UIObject_release(self.jobSkillRoot);self.jobSkillRoot=nil;
_UIObject_release(self.gfSkillRoot);self.gfSkillRoot=nil;
_UIObject_release(self.stSkillRoot);self.stSkillRoot=nil;
_UIObject_release(self.tmSkillRoot);self.tmSkillRoot=nil;
_UIObject_release(self.rightScrollView);self.rightScrollView=nil;
_UIObject_release(self.enemyPanel);self.enemyPanel=nil;
_UIObject_release(self.suitSkillRoot);self.suitSkillRoot=nil;
_UIObject_release(self.xixueTextRoot);self.xixueTextRoot=nil;
_UIObject_release(self.xixueText);self.xixueText=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.onlyXixuePanel);self.onlyXixuePanel=nil;
_UIObject_release(self.onlyXixueClickMask);self.onlyXixueClickMask=nil;
_UIObject_release(self.onlyXixueText);self.onlyXixueText=nil;
_UIObject_release(self.teamGrid);self.teamGrid=nil;
_UIObject_release(self.namebg);self.namebg=nil;
_UIObject_release(self.discipleJobIcon2);self.discipleJobIcon2=nil;
_UIObject_release(self.spBg);self.spBg=nil;
end
















local _itemWidgetIdx=
{
cmpItemQualityIdx=0,
cmpItemIconIdx=1,
cmpItemTxtCount=2,
cmpItemAdd=3,
cmpItemName=4,
cmpItemStage=5,
cmpItemStageBg=6,
cmpItemNew=7,
cmpItemReddot=8,
cmpLock=9,
cmpFabaoTag=10,
cmpCountBg=11,
cmpStar=12,
cmpSuitIcon=13,
cmpLiandon=14,
}
local _maxRightNum=5
local _equipSlotIndex={
[EQUIP_TYPE.eWeapon]=0,
[EQUIP_TYPE.eClothes]=1,
[EQUIP_TYPE.eCap]=2,
[EQUIP_TYPE.eShoot]=3,
}

local _skillStatisticsType={
eNormalAtk=1,
eJobSkill=2,
eGongFaSkill=3,
eTianMingSkill=4,
eFaBaoSkill=5,
eDaoBingSkill=6,
eSuitSkill=7,
}



function UIFightAllMsgWin:onLoaded(...)
self:bindComponents()
end


function UIFightAllMsgWin:__delete()
self:unbindComponents()
end

local headcmp=
{
head=0,
image=1,
select=2,
}



function UIFightAllMsgWin:onShow(argtable,afterOnloaded)
if argtable then
self.fightDataList=argtable.fightData
self.teamIndex=argtable.teamIndex or 1
self.fightData=self.fightDataList[self.teamIndex]

self.battleId=argtable.battleId
self.battleType=argtable.battleType
self.isShareFight=argtable.isShareFight
end



self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.5)

self.jobSkillList={}
self.dbSkillList={}
self.tmSkillList={}
self.suitSkillList={}

self:updateView()
end


function UIFightAllMsgWin:onHide()

end


function UIFightAllMsgWin:updateView()
local leftId=self.fightData.leftId
local rightId=self.fightData.rightId
local actorId=playerModel:getActorID()
local isLeftSelf=leftId~=nil and mathHelper.int64_to_number(leftId)==mathHelper.int64_to_number(actorId)
local isRightSelf=rightId~=nil and mathHelper.int64_to_number(rightId)==mathHelper.int64_to_number(actorId)

if isLeftSelf then
self.leftdata=table.weakCopy(self.fightData.left)
elseif isRightSelf then
self.leftdata=table.weakCopy(self.fightData.right)
else

self.leftdata=table.weakCopy(self.fightData.left)
logErr('请检查战斗数据，找不到己方阵营数据')
end

self.selectindex=1

self.leftnum=#self.leftdata
if self.leftnum>0 then

table.sort(self.leftdata,function(a,b)
return a.totalAttack>b.totalAttack
end)
end
self.leftlistItem:setChildLayoutGroupCreateItems(self.leftnum)
local childGrids=self.leftlistItem:getChildLayoutGroupGridList()
for i=1,self.leftnum do
local childItem=childGrids[i-1]
childItem:SetChildButtonClick(-1,function()
self:headiconClick(childItem,i)
end)

local enityType=self.leftdata[i].enityType
if enityType==fightEntityType.diZi then
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(self.leftdata[i].image)
comHelper.setChildModelRawImageEx(0,childItem,modelParams,eHeadCenterType.eHead)
else
comHelper.setChildModelRawImage_monster(childItem,self.leftdata[i].monsterID,0,0,eHeadCenterType.eHead)
end


childItem:SetChildActive(headcmp.select,self.selectindex==i)
end

local isShowEnemy=true
if self.battleType and self.battleType==eBattleType.tianyuanshouchao then

isShowEnemy=false
end

self.enemyPanel:setActive(isShowEnemy)
if isShowEnemy then

self.rightdata=table.weakCopy(self.fightData.right)

if isLeftSelf then
self.rightdata=table.weakCopy(self.fightData.right)
elseif isRightSelf then
self.rightdata=table.weakCopy(self.fightData.left)
else

self.rightdata=table.weakCopy(self.fightData.right)
logErr('请检查战斗数据，找不到己方阵营数据')
end
local rightnum=#self.rightdata
if rightnum>0 then

table.sort(self.rightdata,function(a,b)
return a.totalAttack>b.totalAttack
end)
end
self.rightlistItem:setChildLayoutGroupCreateItems(rightnum)
self.rightScrollView:setChildScrollRectEnable(rightnum>_maxRightNum)
local rightGrids=self.rightlistItem:getChildLayoutGroupGridList()
for i=1,rightnum do
local rightItem=rightGrids[i-1]

rightItem:SetChildButtonClick(-1,function()

self:headiconClick(rightItem,i+self.leftnum)
end)


local enityType=self.rightdata[i].enityType
if enityType==fightEntityType.diZi then
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(self.rightdata[i].image)
comHelper.setChildModelRawImageEx(0,rightItem,modelParams,eHeadCenterType.eHead)
else
comHelper.setChildModelRawImage_monster(rightItem,self.rightdata[i].monsterID,0,0,eHeadCenterType.eHead)
end

rightItem:SetChildActive(headcmp.select,self.selectindex==i+self.leftnum)
end
end

self.nowitem=childGrids[0]

self:Refresh()

self.allinfoPanel:setActive(false)
end

function UIFightAllMsgWin:headiconClick(item,index)
if self.selectindex==index then
return
end
if self.nowitem then
self.nowitem:SetChildActive(headcmp.select,false)
end
self.nowitem=item
self.selectindex=index
self.nowitem:SetChildActive(headcmp.select,true)

self:Refresh()
end


function UIFightAllMsgWin:Refresh()
self:refreshTeamGridsList()
self:RefreshData(self.selectindex)
self:RefreshMainData()
self:RefreshRightNum()
end


function UIFightAllMsgWin:refreshTeamGridsList()
local count=#self.fightDataList
if count>1 then
self.teamGrid:setChildLayoutGroupCreateItems(count,function(idx)
local item=self.teamGrid:getChildLayoutGroupGridItem(idx-1)
item:SetChildText(1,FMT.fmt("第{0}场",idx))
item:SetChildButtonClick(0,function()
self.fightData=self.fightDataList[idx]
local old=self.teamIndex
if old then
local oitem=self.teamGrid:getChildLayoutGroupGridItem(old-1)
oitem:SetChildActive(2,false)
end
self.teamIndex=idx
item:SetChildActive(2,true)
self:updateView()
end)

item:SetChildActive(2,self.teamIndex==idx)

end)
end
end


function UIFightAllMsgWin:RefreshData(index)
local data=self.leftdata[index]

self.isSelectLeft=index<=self.leftnum
if index>self.leftnum then
index=index-self.leftnum
data=self.rightdata[index]
end
if not data then
logErr('请检查数据')
return
end
self.data=data
end

function UIFightAllMsgWin:RefreshMainData()
local data=self.data

local hurtdata=data.totalAttack
local Defenddata=data.totalDefend
local cueData=data.totalCue

local shieldData=0
if self.data and self.battleId then
local id=self.data.id
local battleId=self.battleId
local battle=fightModel:getBattle(battleId)
if battle then
shieldData=battle:getStatisticsSkillAllShield(self.teamIndex,id)

hurtdata=battle:getStatisticsSkillAllDemage(self.teamIndex,id)
cueData=battle:getStatisticsSkillAllHeal(self.teamIndex,id)


end
end

local hasHurt=hurtdata>0
local hurttext=mathHelper.formatNumber4(hurtdata,1)
self.hurt:setText(hurttext)

local Defendtext=mathHelper.formatNumber4(Defenddata,1)
self.injure:setText(Defendtext)

local hasCue=cueData>0
local cueText=mathHelper.formatNumber4(cueData,1)
self.addHp:setText(cueText)

local shieldText=mathHelper.formatNumber4(shieldData,1)
self.Shield:setText(shieldText)
local hasShield=shieldData>0

self.discipleModelRoot:setChildUIModelRemoveTarget()
self.MonsterModelRoot:setChildUIModelRemoveTarget()
local isShowInfoBtn=false
local jobBtnPos={-373,257}
local namePos={0,-1}

local isSelfDz=false
if data.dis_guid and not mathHelper.compareInt64(data.dis_guid,int64.new('0'))then
local netData=UIDiscipleModel:getDiscipleData(data.dis_guid)
if netData then
isSelfDz=true
end
end
self._isSelfDz=isSelfDz

local skillList_lookup={}
if self.battleId then
local id=self.data.id
local battleId=self.battleId
local battle=fightModel:getBattle(battleId)
skillList_lookup[1]=battle:getStatisticsSkillDemage(self.teamIndex,id)
skillList_lookup[2]=battle:getStatisticsSkillHeal(self.teamIndex,id)
skillList_lookup[3]=battle:getStatisticsSkillShield(self.teamIndex,id)

end
self.skillList_lookup=skillList_lookup

if isSelfDz then
local args={bgFisrt=true}
local fightSwitchIdx
local isSPdz=UIDiscipleModel:isSPDiscipleEx(data.dis_guid)
if isSPdz then
local jobId=data.image and data.image.job or nil
if jobId then
fightSwitchIdx=UIDiscipleModel:getSPDiscipleSwitchIdxWithSameJobId(data.dis_guid,jobId)
end
end
comHelper.setChildInSideModel(self.discipleModelRoot,data.dis_guid,0.85,nil,0,0,false,false,nil,args,fightSwitchIdx)
local name=UIDiscipleModel:getDiscipleName(data.dis_guid)
self.namebg:setActive(true)
self.name:setText(name)


self.discipleJobBtn:setActive(true)
namePos={15,-1}
local jobicon=UIDiscipleModel:getJobIconNameX(data.dis_guid,fightSwitchIdx)
self.discipleJobIcon:setSprite(globalABLookup.global,jobicon)
self.discipleJobIcon2:setActive(isSPdz)
self.spBg:setActive(isSPdz)
if isSPdz then
local otherSwitchIdx=fightSwitchIdx==1 and 0 or 1
local switchJobIcon=UIDiscipleModel:getJobIconNameX(data.dis_guid,otherSwitchIdx)
self.discipleJobIcon2:setSprite(globalABLookup.global,switchJobIcon)
self.discipleJobIcon:setChildAnchoredPos(-10,10)
local scale=54/68
self.discipleJobIcon:setScale(Vector3(scale,scale,scale))
else
self.discipleJobIcon:setChildAnchoredPos(0,0)
self.discipleJobIcon:setScale(Vector3.one)
end


isShowInfoBtn=true






















else
if data.enityType==fightEntityType.diZi then

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(data.image)
comHelper.setChildInSideModelEx(self.discipleModelRoot,modelParams,0.85,nil,0,0,false,false,nil)
local name=data.name
self.namebg:setActive(true)
self.name:setText(name)
local jobId=data.image and data.image.job or nil
if jobId then
local jobicon=UIDiscipleModel:getJobIconName(jobId)
self.discipleJobIcon:setSprite(globalABLookup.global,jobicon)
self.discipleJobBtn:setActive(true)
self.discipleJobIcon2:setActive(false)
self.spBg:setActive(false)
self.discipleJobIcon:setChildAnchoredPos(0,0)
self.discipleJobIcon:setScale(Vector3.one)
namePos={15,-1}
else
self.discipleJobBtn:setActive(false)
end
isShowInfoBtn=true
elseif data.monsterID then
local cfg=cfgHelper.get1(cfg_monsterconfig_get,data.monsterID)
local name=cfg.name
local modelParams=comHelper.getMonsterModelParams(data.monsterID)
local jobId=cfg.job
if jobId then

self.namebg:setActive(false)
local jobicon=UIDiscipleModel:getJobIconName(jobId)
self.discipleJobIcon:setSprite(globalABLookup.global,jobicon)
self.discipleJobIcon2:setActive(false)
self.spBg:setActive(false)
self.discipleJobIcon:setChildAnchoredPos(0,0)
self.discipleJobIcon:setScale(Vector3.one)
jobBtnPos={-443,202}
self.discipleJobBtn:setActive(true)
else
self.namebg:setActive(true)
self.discipleJobBtn:setActive(false)
end
if cfg.npcID~=nil then
comHelper.setChildInSideModelEx(self.discipleModelRoot,modelParams,0.85,nil,0,0,false,false,nil)
else
local showParam=cfg.winShowModelParam or{}
local scale=showParam.scale or(cfg.scale~=nil and cfg.scale*1.1)or 1.1
local offset=showParam.offset or{0,0}
self.MonsterModelRoot:setChildUIModelShowTarget(modelParams.body,scale,modelParams.componets or{},eAnimationID.stand,false,false,0,nil)
self.MonsterModelRoot:setChildUIModelShowTargetOffset(offset[1],offset[2])
end

self.name:setText(name)
end
end
self.discipleJobBtn:setChildAnchoredPos(jobBtnPos[1],jobBtnPos[2])
self.allhurt:setActive(isShowInfoBtn and hasHurt)
self.alladdHp:setActive(isShowInfoBtn and hasCue)
self.allShield:setActive(isShowInfoBtn and hasShield)
self.name:setChildAnchoredPos(namePos[1],namePos[2])
end


function UIFightAllMsgWin:RefreshRightNum()
local killNum=0
local controlNum=0
local wudiNum=0
local myreliveNum=0
local dieNum=0
local dikangNum=0
local shanbiNum=0
local otherreliveNum=0

if self.data and self.battleId then
local id=self.data.id
local battleId=self.battleId
local battle=fightModel:getBattle(battleId)
if battle then
killNum=battle:getStatisticsTimes(self.teamIndex,FIGHT_STATISTICS_TYPE.killTimes,id)
controlNum=battle:getStatisticsTimes(self.teamIndex,FIGHT_STATISTICS_TYPE.addStateTimes,id)
wudiNum=battle:getStatisticsTimes(self.teamIndex,FIGHT_STATISTICS_TYPE.resistDemageTimes,id)
myreliveNum=battle:getStatisticsTimes(self.teamIndex,FIGHT_STATISTICS_TYPE.rebirthTimes,id)
dieNum=battle:getStatisticsTimes(self.teamIndex,FIGHT_STATISTICS_TYPE.deadTimes,id)
dikangNum=battle:getStatisticsTimes(self.teamIndex,FIGHT_STATISTICS_TYPE.resistDebuffTimes,id)
shanbiNum=battle:getStatisticsTimes(self.teamIndex,FIGHT_STATISTICS_TYPE.dodgeTimes,id)
otherreliveNum=battle:getStatisticsTimes(self.teamIndex,FIGHT_STATISTICS_TYPE.rebirthOtherTimes,id)
end
end

local killNumStr=killNum<=0 and FMT.cfmt(FONT_COLOR.eNomalBlackColor,killNum)or tostring(killNum)
local controlNumStr=controlNum<=0 and FMT.cfmt(FONT_COLOR.eNomalBlackColor,controlNum)or tostring(controlNum)
local wudiNumStr=wudiNum<=0 and FMT.cfmt(FONT_COLOR.eNomalBlackColor,wudiNum)or tostring(wudiNum)
local myreliveNumStr=myreliveNum<=0 and FMT.cfmt(FONT_COLOR.eNomalBlackColor,myreliveNum)or tostring(myreliveNum)
local dieNumStr=dieNum<=0 and FMT.cfmt(FONT_COLOR.eNomalBlackColor,dieNum)or tostring(dieNum)
local dikangNumStr=dikangNum<=0 and FMT.cfmt(FONT_COLOR.eNomalBlackColor,dikangNum)or tostring(dikangNum)
local shanbiNumStr=shanbiNum<=0 and FMT.cfmt(FONT_COLOR.eNomalBlackColor,shanbiNum)or tostring(shanbiNum)
local otherreliveNumStr=otherreliveNum<=0 and FMT.cfmt(FONT_COLOR.eNomalBlackColor,otherreliveNum)or tostring(otherreliveNum)
self.killnum:setText(killNumStr)
self.controlnum:setText(controlNumStr)
self.wudinum:setText(wudiNumStr)
self.myrelivenum:setText(myreliveNumStr)

self.dienum:setText(dieNumStr)
self.dikangnum:setText(dikangNumStr)
self.shanbinum:setText(shanbiNumStr)
self.otherrelivenum:setText(otherreliveNumStr)
end



function UIFightAllMsgWin:SetAllInfoPanel(infoType)
if self.data and self.battleId then
local id=self.data.id
local battleId=self.battleId
local battle=fightModel:getBattle(battleId)
if battle then
local skillList_lookup={}
if infoType==1 then

skillList_lookup=self.skillList_lookup[1]or{}
elseif infoType==2 then

skillList_lookup=self.skillList_lookup[2]or{}
elseif infoType==3 then

skillList_lookup=self.skillList_lookup[3]or{}
end
























local jobSkillList={}
local gfSkillList={}
local stSkillList={}
local tmSkillList={}
local suitSkillList={}
for skillId,v in pairs(skillList_lookup)do
local demage=v.val
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
if skillCfg then
if skillCfg.callSkill then
skillId=skillCfg.callSkill
skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
end
local weight=skillId
local callSkillId=skillCfg.callSkill
local statisticsType=skillCfg.statisticsType
if statisticsType then
if callSkillId then
skillId=callSkillId
skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
end
if statisticsType==_skillStatisticsType.eNormalAtk or statisticsType==_skillStatisticsType.eJobSkill then

if statisticsType==_skillStatisticsType.eNormalAtk then
weight=weight-100000
end
jobSkillList[#jobSkillList+1]={
skillId=skillId,
weight=weight,
val=demage,
level=v.level,
}
elseif statisticsType==_skillStatisticsType.eGongFaSkill then

gfSkillList[#gfSkillList+1]={
skillId=skillId,
weight=weight,
val=demage,
level=v.level,
}
elseif statisticsType==_skillStatisticsType.eFaBaoSkill then

stSkillList[#stSkillList+1]={
skillId=skillId,
weight=weight,
val=demage,
level=v.level,
equipType=EQUIP_TYPE.eFabao
}
elseif statisticsType==_skillStatisticsType.eDaoBingSkill then

stSkillList[#stSkillList+1]={
skillId=skillId,
weight=weight,
val=demage,
level=v.level,
equipType=EQUIP_TYPE.eDaoBing
}
elseif statisticsType==_skillStatisticsType.eTianMingSkill then

tmSkillList[#tmSkillList+1]={
skillId=skillId,
weight=weight,
val=demage,
level=v.level,
}
elseif statisticsType==_skillStatisticsType.eSuitSkill then

local suitParam=skillCfg.suitParam
if suitParam then
local suitId=suitParam[1]
local suitEffNum=suitParam[2]
suitSkillList[#suitSkillList+1]={
skillId=skillId,
weight=weight,
val=demage,
level=v.level,
suitId=suitId,
suitEffNum=suitEffNum,
}
end
end
end
end
end

local isShowJobSkillRoot=next(jobSkillList)~=nil and#jobSkillList>0
local isShowGfSkillRoot=next(gfSkillList)~=nil and#gfSkillList>0
local isShowStSkillRoot=next(stSkillList)~=nil and#stSkillList>0
local isShowTmSkillRoot=next(tmSkillList)~=nil and#tmSkillList>0
local isShowSuitSkillRoot=next(suitSkillList)~=nil and#suitSkillList>0




self.jobSkillRoot:setActive(isShowJobSkillRoot)
if isShowJobSkillRoot then
local sortList=self:mergeSkillList(jobSkillList)
table.sort(sortList,function(a,b)
return a.weight<b.weight
end)

self.jobSkillRoot:setChildLayoutGroupCreateItems(#sortList,function(index)
local widget=self.jobSkillRoot:getChildLayoutGroupGridItem(index-1)
local data=sortList[index]
self:refreshSkillGrid(widget,data,eSkillTipsType.eDZSkill,infoType)
end)
end


self.gfSkillRoot:setActive(isShowGfSkillRoot)
if isShowGfSkillRoot then
local sortList=self:mergeSkillList(gfSkillList)
table.sort(sortList,function(a,b)
return a.weight<b.weight
end)

self.gfSkillRoot:setChildLayoutGroupCreateItems(#sortList,function(index)
local widget=self.gfSkillRoot:getChildLayoutGroupGridItem(index-1)
local data=sortList[index]
self:refreshSkillGrid(widget,data,eSkillTipsType.eDZGFSkill,infoType)
end)
end


self.tmSkillRoot:setActive(isShowTmSkillRoot)
if isShowTmSkillRoot then
local sortList=self:mergeSkillList(tmSkillList)
table.sort(sortList,function(a,b)
return a.weight<b.weight
end)

self.tmSkillRoot:setChildLayoutGroupCreateItems(#sortList,function(index)
local widget=self.tmSkillRoot:getChildLayoutGroupGridItem(index-1)
local data=sortList[index]
self:refreshSkillGrid(widget,data,nil,infoType,true)
end)
end


self.stSkillRoot:setActive(isShowStSkillRoot)
if isShowStSkillRoot then
local sortList=self:mergeSkillList(stSkillList)
table.sort(sortList,function(a,b)
return a.weight<b.weight
end)

self.stSkillRoot:setChildLayoutGroupCreateItems(#sortList,function(index)
local widget=self.stSkillRoot:getChildLayoutGroupGridItem(index-1)
local data=sortList[index]
self:refreshSkillGrid(widget,data,eSkillTipsType.eDZSTSkill,infoType)
end)
end


self.suitSkillRoot:setActive(isShowSuitSkillRoot)
if isShowSuitSkillRoot then
local sortList=self:mergeSkillList(suitSkillList,true)
table.sort(sortList,function(a,b)
return a.weight<b.weight
end)

self.suitSkillRoot:setChildLayoutGroupCreateItems(#sortList,function(index)
local widget=self.suitSkillRoot:getChildLayoutGroupGridItem(index-1)
local data=sortList[index]
self:refreshSkillGrid(widget,data,nil,infoType,nil,true)
end)
end


if infoType==1 then

local val=battle:getStatisticsTimes(self.teamIndex,FIGHT_STATISTICS_TYPE.fanShe,id)
local isShowXixueTextRoot=val and val>0 or false
local isOnlyXixue=isShowXixueTextRoot and not isShowJobSkillRoot and not isShowGfSkillRoot and not isShowStSkillRoot and not isShowTmSkillRoot and not isShowSuitSkillRoot
local xixueNumStr=mathHelper.formatNumber4(val,1)
if isOnlyXixue then

self.onlyXixuePanel:setActive(true)
self.allinfoPanel:setActive(false)
self.onlyXixueText:setText(FMT.fmt("本场战斗反射伤害：<color=#f1ce78>{0}</color>",xixueNumStr))
else
self.xixueTextRoot:setActive(isShowXixueTextRoot)
if isShowXixueTextRoot then
self.xixueText:setText(FMT.fmt("本场战斗反射伤害：<color=#f1ce78>{0}</color>",xixueNumStr))
end
end
elseif infoType==2 then

local xixueVal=battle:getStatisticsTimes(self.teamIndex,FIGHT_STATISTICS_TYPE.xixue,id)
local isShowXixueTextRoot=xixueVal and xixueVal>0 or false
local isOnlyXixue=isShowXixueTextRoot and not isShowJobSkillRoot and not isShowGfSkillRoot and not isShowStSkillRoot and not isShowTmSkillRoot and not isShowSuitSkillRoot
local xixueNumStr=mathHelper.formatNumber4(xixueVal,1)
if isOnlyXixue then

self.onlyXixuePanel:setActive(true)
self.allinfoPanel:setActive(false)
self.onlyXixueText:setText(FMT.fmt("本场战斗伤害吸血治疗：<color=#f1ce78>{0}</color>",xixueNumStr))
else
self.xixueTextRoot:setActive(isShowXixueTextRoot)
if isShowXixueTextRoot then
self.xixueText:setText(FMT.fmt("本场战斗伤害吸血治疗：<color=#f1ce78>{0}</color>",xixueNumStr))
end
end
else
self.xixueTextRoot:setActive(false)
end
end
end
end


function UIFightAllMsgWin:refreshSkillGrid(widget,skilldata,st,infoType,isTmSkill,isSuitSkill)
if not skilldata then
widget:SetChildActive(-1,false)
return
end
local d=skilldata
local skillID=d.skillId
local skillLv=d.level
local skillVal=d.val

local skillCfg
skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
if not skillCfg then
widget:SetChildActive(-1,false)
return
end

widget:SetChildActive(-1,true)
local infoTypeStr
if infoType==1 then
infoTypeStr="伤害"
elseif infoType==2 then
infoTypeStr="治疗"
elseif infoType==3 then
infoTypeStr="护盾"
end

if isSuitSkill then

local suitId=d.suitId
local suitCfg=cfgHelper.get1(cfg_discipleequipsuitconfig_get,suitId)

local iconName=equipsHelper.getEquipSuitIconById(suitId)
widget:SetChildIcon(0,iconName,false)

widget:SetChildText(3,suitCfg.name)

local suitEffNum=d.suitEffNum
widget:SetChildText(1,FMT.fmt("{0}件套",suitEffNum))

widget:SetChildText(2,FMT.fmt("{0}：{1}",infoTypeStr,mathHelper.formatNumber4(skillVal,1)))

widget:SetChildButtonClick(4,function()
self:onSuitItemClick(widget,suitId,suitEffNum)
end,true)

else

local islock=skillLv<=0

local icon=skillCfg.icon
if self.data then

if not self._isSelfDz then
local netData=otherPlayerModel:getDZData(self.data.dis_guid)
if netData then
local base=netData.base
icon=skillModel.getSkillIconChange(skillCfg,base)
end
else
local netData=UIDiscipleModel:getDiscipleData(self.data.dis_guid)
icon=skillModel.getSkillIconChange(skillCfg,netData)
end
end







widget:SetChildIcon(0,iconHelper.getSkillIcon(icon),false)

local isgray=islock
widget:SetChildImageExGray(0,isgray)

if st and st==eSkillTipsType.eDZSkill then

local is_bd=skillModel.isSkillBD(skillCfg.skillType)
widget:SetChildActive(1,is_bd)
else
widget:SetChildActive(1,false)
end


local isShowLv=true
local skillLvStr=""
skillLvStr=skillModel:getSkillLvStr(skillLv)



































widget:SetChildActive(4,isShowLv)
widget:SetChildText(2,skillLvStr)

widget:SetChildActive(5,islock)

widget:SetChildText(7,skillCfg.name)

widget:SetChildText(8,FMT.fmt("{0}：{1}",infoTypeStr,mathHelper.formatNumber4(skillVal,1)))


local equipType=d.equipType
local isFabao=equipType and equipType==EQUIP_TYPE.eFabao
local isDaoBing=equipType and equipType==EQUIP_TYPE.eDaoBing
widget:SetChildActive(9,isFabao)
widget:SetChildActive(10,isDaoBing)













widget:SetChildButtonClick(3,function()
self:onSkillItemClick(st,skillID,skillLv)
end,true)
























end
end

function UIFightAllMsgWin:refreshItemGrid(equip,widget)
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local jinglianStr=''
local iconName
local isFabao=false
local stage=itemConfig.stage
local showStage=stage~=nil
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=showStage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local star=0
local suitIconName=''
local isLD=false
if itemsConfig.isFabao(itemid)then
isFabao=true
local jinglianlv=equip.itemData and equip.itemData.jilianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
iconName=itemsModel.getIconName(equip)
elseif itemsConfig.isEquip(itemid)then
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
iconName=iconHelper.getIconName(itemid)
suitIconName=equipsHelper.getEquipSuitIcon(equip)
isLD=liandonModel:getIsLianDonItem(itemid)
elseif itemsConfig.isDaoBing(itemid)then
iconName=iconHelper.getIconName(itemid)
star=equip.itemData and equip.itemData.star or 0
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
stageStr=''
isLD=liandonModel:getIsLianDonItem(itemid)
end

if star>0 then
local starWidget=widget:GetChildWidgetBase(_itemWidgetIdx.cmpStar)
for i=1,5 do
if star>=i then
starWidget:SetChildAnimationStringID(i-1,'daobing',false)
end
end
end

widgetHelper.setItemQulaity(widget,itemid,_itemWidgetIdx.cmpItemQualityIdx)
widget:SetChildIcon(_itemWidgetIdx.cmpItemIconIdx,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,jinglianStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,stageStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,stageStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,isFabao)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,jinglianStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,isLD)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,star)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,star)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,suitIconName,false)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)
widget:SetBaseItemClickEvent(-1,function(...)
self:onEquipItemClick(...)
end)
else

widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,false)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,false)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,0)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,0)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,'',false)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
widget:SetBaseItemClickEvent(-1,function(...)
return
end)
end
end


function UIFightAllMsgWin:getDzJobSkillList_lookup(dzGuid)
local dzGuidStr=tostring(dzGuid)
if self.jobSkillList and self.jobSkillList[dzGuidStr]then
return self.jobSkillList[dzGuidStr]
end

local jobSkillList_lookup={}
local jobSkillList=UIDiscipleModel:getDiscipleJobSkillList(dzGuid)
if jobSkillList~=nil and#jobSkillList>0 then
for _,v in ipairs(jobSkillList)do
local skillId=v[1]
local skillLv=v[2]
jobSkillList_lookup[skillId]=skillId

local relevantSkill_lookup=self:getRelevantSkillIdList(skillId,skillLv)
if relevantSkill_lookup and next(relevantSkill_lookup)then
for c_skillId,_ in pairs(relevantSkill_lookup)do
jobSkillList_lookup[c_skillId]=skillId
end
end
end
end

self.jobSkillList[dzGuidStr]=jobSkillList_lookup
return self.jobSkillList[dzGuidStr]
end


function UIFightAllMsgWin:getDzDbSkillList_lookup(dzGuid)
local dzGuidStr=tostring(dzGuid)
if self.dbSkillList[dzGuidStr]then
return self.dbSkillList[dzGuidStr]
end

local dbSkillList_lookup={}
local dbSkillList=daobingHelper.getDzUseSkills(dzGuid)
if dbSkillList~=nil and#dbSkillList>0 then
for _,v in ipairs(dbSkillList)do
local skillId=v[1]
local skillLv=v[2]
dbSkillList_lookup[skillId]=true

local relevantSkill_lookup=self:getRelevantSkillIdList(skillId,skillLv)
if relevantSkill_lookup and next(relevantSkill_lookup)then
for c_skillId,_ in pairs(relevantSkill_lookup)do
dbSkillList_lookup[c_skillId]=true
end
end
end
end

self.dbSkillList[dzGuidStr]=dbSkillList_lookup
return self.dbSkillList[dzGuidStr]
end


function UIFightAllMsgWin:getDzTmSkillList_lookup(dzGuid)
local dzGuidStr=tostring(dzGuid)
if self.tmSkillList[dzGuidStr]then
return self.tmSkillList[dzGuidStr]
end

local tmSkillList_lookup={}
local netData=UIDiscipleModel:getDiscipleData(dzGuid)
if netData and netData.tmlistlen and netData.tmlistlen>0 then
local tmList=netData.tmList
for idx,tmId in ipairs(tmList)do
local tmCfg=cfgHelper.get1(cfg_discipletianmingconfig_get,tmId)
if tmCfg and tmCfg.skill then
local skillId=tmCfg.skill
local skillLv=1
tmSkillList_lookup[skillId]=tmId

local relevantSkill_lookup=self:getRelevantSkillIdList(skillId,skillLv)
if relevantSkill_lookup and next(relevantSkill_lookup)then
for c_skillId,_ in pairs(relevantSkill_lookup)do
tmSkillList_lookup[c_skillId]=tmId
end
end
end
end
end

self.tmSkillList[dzGuidStr]=tmSkillList_lookup
return self.tmSkillList[dzGuidStr]
end


function UIFightAllMsgWin:getDzSuitSkillList_lookup(dzGuid)
local dzGuidStr=tostring(dzGuid)
if self.suitSkillList[dzGuidStr]then
return self.suitSkillList[dzGuidStr]
end

local suitSkillList_lookup={}
local suitList={}
for equipType,idx in ipairs(_equipSlotIndex)do
local equip=equipsHelper.getEquipByDizi(dzGuid,equipType)
if equip then
local suit=equip.itemData.suitid
if suit>0 then
suitList[suit]=(suitList[suit]or 0)+1
end
end
end
for suitId,suitNum in pairs(suitList)do
local suitCfg=cfgHelper.get1(cfg_discipleequipsuitconfig_get,suitId)
if suitNum>1 and suitCfg.skill2 then

local skillParam=suitCfg.skill2
for _,v in ipairs(skillParam)do
local skillId=v[1]
local skillLv=v[2]
suitSkillList_lookup[skillId]={suitId=suitId,num=2}

local relevantSkill_lookup=self:getRelevantSkillIdList(skillId,skillLv)
if relevantSkill_lookup and next(relevantSkill_lookup)then
for c_skillId,_ in pairs(relevantSkill_lookup)do
suitSkillList_lookup[c_skillId]={suitId=suitId,num=2}
end
end
end
end

if suitNum>2 and suitCfg.skill3 then

local skillParam=suitCfg.skill3
for _,v in ipairs(skillParam)do
local skillId=v[1]
local skillLv=v[2]
suitSkillList_lookup[skillId]={suitId=suitId,num=3}

local relevantSkill_lookup=self:getRelevantSkillIdList(skillId,skillLv)
if relevantSkill_lookup and next(relevantSkill_lookup)then
for c_skillId,_ in pairs(relevantSkill_lookup)do
suitSkillList_lookup[c_skillId]={suitId=suitId,num=3}
end
end
end
end
end

self.suitSkillList[dzGuidStr]=suitSkillList_lookup
return self.suitSkillList[dzGuidStr]
end


function UIFightAllMsgWin:getRelevantSkillIdList(skillId,skillLv,relevantSkill_lookup)
relevantSkill_lookup=relevantSkill_lookup or{}
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
if skillCfg then

relevantSkill_lookup=self:getRelevantSkillIdList_passive(skillId,skillLv,relevantSkill_lookup)


relevantSkill_lookup=self:getRelevantSkillIdList_effect(skillId,relevantSkill_lookup)
end

return relevantSkill_lookup
end


function UIFightAllMsgWin:getRelevantSkillIdList_passive(skillId,skillLv,skillLookup)
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
if skillCfg and skillCfg.passive then
local passive_lv=skillCfg.passive[skillLv]
if passive_lv then
for i,v in ipairs(passive_lv)do
if v[1]>0 then

local c_skillId=v[5]
local c_skillLv=v[6]
skillLookup[c_skillId]=true
skillLookup=self:getRelevantSkillIdList(c_skillId,c_skillLv,skillLookup)
end
end
end
end

return skillLookup
end


function UIFightAllMsgWin:getRelevantSkillIdList_effect(skillId,skillLookup)
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
if skillCfg.eActionId and next(skillCfg.eActionId)then
for i,actionId in pairs(skillCfg.eActionId)do
local actionCfg=cfgHelper.get1(cfg_skillaction_get,actionId)
if actionCfg.resultType and actionCfg.resultType==51 then

local actionValue=skillCfg.eActionValue[i]
for _,v in ipairs(actionValue)do
local c_skillId=v[1]
local isUseActorSkill=v[3]==1
if not isUseActorSkill then
skillLookup[c_skillId]=true
local c_skillLv=1
skillLookup=self:getRelevantSkillIdList(c_skillId,c_skillLv,skillLookup)
end
end
end
end
end

return skillLookup
end


function UIFightAllMsgWin:mergeSkillList(skillList,isSuit)
local mergeList={}
local mergeList_lookup={}
if skillList and next(skillList)then
for _,v in ipairs(skillList)do
local key
if not isSuit then

key=v.skillId
elseif isSuit then

key=FMT.fmt("{0}_{1}",v.suitId,v.suitEffNum)
end

if not mergeList_lookup[key]then
mergeList_lookup[key]=v
else
local val=v.val
mergeList_lookup[key].val=mergeList_lookup[key].val+val
end
end

for _,v in pairs(mergeList_lookup)do
mergeList[#mergeList+1]=v
end
end


return mergeList
end



function UIFightAllMsgWin:onClosebtn()
self:closeSelf()
end

function UIFightAllMsgWin:onClickClose()
self:onClosebtn()
end

function UIFightAllMsgWin:onSkillItemClick(skillType,skillID,skillLv)

local args={skillID=skillID,skillLv=skillLv,attend=skillType}
self:showWindow('UIDiscipleJobSkillTipsWin',args)
end

function UIFightAllMsgWin:onTmSkillItemClick(tmId,skillIconId)
local netData=UIDiscipleModel:getDiscipleData(self.data.dis_guid)
local args={tmId=tmId,tmState=true,tmLv=netData.tmlv,needFloor=0,guid=self.data.dis_guid,skillIconId=skillIconId}
self:showWindow("UIDiscipleTianMingSkillTipsWin",args)
end

function UIFightAllMsgWin:onEquipItemClick(id,equipType,guid,attach)
if id>0 then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eWatchRoleItem,itemguid=guid,attach={diziguid=self.disciple_guid}})
end
end

function UIFightAllMsgWin:onSuitItemClick(widget,suitId,suitEffNum)
local data={suitId,suitEffNum}
local args={}
args.data=data
args.pos=widget:GetChildScreenPointToLocalPointRectangle(-1)
args.offset={0,35}
UIManager:showWindow('UIShowEquipSuitInfoWin',args)
end

function UIFightAllMsgWin:onRolespbtn()

end


function UIFightAllMsgWin:onAllhurt()
self.allinfoPanel:setActive(true)

self:SetAllInfoPanel(1)
end


function UIFightAllMsgWin:onAlladdHp()
self.allinfoPanel:setActive(true)

self:SetAllInfoPanel(2)
end


function UIFightAllMsgWin:onAllShield()
self.allinfoPanel:setActive(true)

self:SetAllInfoPanel(3)
end


function UIFightAllMsgWin:onAllinfoBtn()
self.allinfoPanel:setActive(false)
end


function UIFightAllMsgWin:onDiscipleJobBtn()
if not self.data.dis_guid or mathHelper.compareInt64(self.data.dis_guid,int64.new('0'))then
return
end
local dzID=UIDiscipleModel:getDiscipleID(self.data.dis_guid)
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(self.data.dis_guid)
local jobid=imageInfo.job
local args={}
args.posItem=self.discipleJobIcon
args.pos=Vector2.New(0,-20)
commonTipsHelper.showDiscipleJpbTips(dzID,jobid,args)
end


function UIFightAllMsgWin:onOnlyXixueClickMask()
self.onlyXixuePanel:setActive(false)
end



function UIFightAllMsgWin:test_printNowMonsterId()
if not self.data then
self:RefreshData(self.selectindex)
end
local data=self.data
if data.monsterID then

else

end
end
