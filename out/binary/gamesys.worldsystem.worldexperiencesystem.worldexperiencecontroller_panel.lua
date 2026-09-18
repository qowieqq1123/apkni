
function worldExperienceController:readyTaskExperience(world,block,plotDisciple)
if not plotDisciple then
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
plotDisciple=blockCfg.eTaskPlotDizi or{}
end
fightController.showPrepareWin(fightPreSelectModel.fightType.worldExperience,{
enterTxt="历练",
isHomeBattle=false,
monsterList=nil,
plotDiscipleList=plotDisciple.plotDiscipleList,
plotGrayDiscipleList=plotDisciple.plotGrayDiscipleList,
plotHideDiscipleList=plotDisciple.plotHideDiscipleList,
cancelCallBack=function()
end,
enterCallBack=function(selectList,zfId)
fightController:closeSelectStage(false)
UIFullFightPrepareControl:closeUI()
local guidList={}
local guidCnt=0
for k,v in ipairs(selectList)do
if v[1]==fightPreSelectModel.teamEntityType.dizi then
table.insert(guidList,v[2])
guidCnt=guidCnt+1
elseif v[1]==fightPreSelectModel.teamEntityType.empty then
table.insert(guidList,int64.zero)
end
end
if guidCnt>0 then
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
worldTaskController:startMission(eWorldUnitTpye.EXPERIENCE,int64.zero,blockCfg.fog2,guidList,zfId)
else
UIManager.info("请选择弟子")
end
end})
end

function worldExperienceController:showFightWin(point,id)
local battleCfg=cfgHelper.get1(cfg_experiencebattleconfig_get,id)
local experienceCfg=cfgHelper.get1(cfg_experienceconfig_get,point)
local mcfg=cfgHelper.get(cfg_monstergroup_get,battleCfg.groupid)
local cWorld=worldExperienceModel:getCurrentWorld()
local cBlock=worldExperienceModel:getCurrentBlock()
local targetKey=worldExperienceModel:convertTaskTargetKey(cWorld,cBlock)
local taskKey=worldTaskModel:findLastTaskKey_ByTarget(targetKey)
local task=worldTaskModel:getTask(taskKey)
local zfId=task and task.zfId or 0
local showZF=zfId>0
local lv=mcfg.level
local items=worldFightModel:getMonsterShowAwards(battleCfg.groupid,lv)
local actRewards=worldFightModel:getMonsterExtraDropActReward(battleCfg.groupid)
local jumpBossWin=battleCfg.jumpBossWin
local plotDisciple=battleCfg.eTaskPlotDizi or{}
local winParam={
name=mcfg.name,
icon=mcfg.model,
level=lv,
skills=mcfg.showSkills,
desc=mcfg.desc,
items=items,
actRewards=actRewards,
title=experienceCfg.name,
groupId=battleCfg.groupid,
highestType=mcfg.monType,
close=function()
UIManager:invokeUIMethod("UIWorldExperienceWin","showContinue",true)
self.progress=nil
end,
cost=nil,
}
winParam.challenge=function()
if battleCfg.jumpPrepare then
local selectList=task:getBattleTeam()
local mapId=mcfg.mapId or 0
local zfId=task.zfId or 0
fightLaunchController:sendFight(eBattleLaunch.experience,selectList,mapId,zfId,{point})
UIManager:closeWindow("UIWorldBossWin")
return
end

local sortList=battleCfg.discipleSortList
if sortList and#sortList<=0 then
sortList=nil
end
local teamList=nil
if not battleCfg.hidePrepare then
teamList={}
for i,v in ipairs(task.team)do
if v>int64.zero then
teamList[i]=v
end
end
end

local dzCountLeast=battleCfg.number0 or#task.disciples
if plotDisciple.plotGrayDiscipleList then
dzCountLeast=dzCountLeast-#plotDisciple.plotGrayDiscipleList
end
if plotDisciple.plotNPCDiscipleList then
dzCountLeast=dzCountLeast-#plotDisciple.plotNPCDiscipleList
end
dzCountLeast=dzCountLeast<0 and 1 or dzCountLeast

worldController:displayHUD(false)
fightController.showPrepareWin(fightPreSelectModel.fightType.worldExperienceBoss,{
enterTxt="历练",
isHomeBattle=false,
monsterList=mcfg.monList,
groupId=battleCfg.groupid,
sortTypeList=sortList,
dzCountLimit=battleCfg.number,
dzCountLeast=dzCountLeast,
teamList=teamList,
editorTeam=battleCfg.editorTeam,
npcList=battleCfg.tempNPC,
lockSelect=task.disciples,
skipDiscipleStateCheck=true,
skipDiscipleInjuryCheck=true,
plotDiscipleList=plotDisciple.plotDiscipleList,
plotGrayDiscipleList=plotDisciple.plotGrayDiscipleList,
plotHideDiscipleList=plotDisciple.plotHideDiscipleList,
plotNPCDiscipleList=plotDisciple.plotNPCDiscipleList,
showZhenFa=showZF,
lockZhenFa=showZF and zfId or nil,
cancelCallBack=function()
self.progress=nil
end,
enterCallBack=function(selectList,zfId)
local zhenfaId=task and task.zfId or 0
local mapId=mcfg.mapId or 0
if not plotDisciple.plotGrayDiscipleList and not plotDisciple.plotNPCDiscipleList then
local temp=fightPreSelectModel.convertFightStruct2Disciple(selectList)
local check=task:checkTeam(temp)
if check<0 then
UIManager.error("弟子选择有误")
loggerUtil.logErrFMT("大世界区块历练战斗布阵检查出问题：{0}",check)
UIFullFightPrepareControl:closeUI(true,true)
fightController:closeSelectStage()
return
elseif check>0 then
task:changeTeamPos(selectList)
task:save()
end
end
fightLaunchController:sendFight(eBattleLaunch.experience,selectList,mapId,zhenfaId,{point})
end})
UIManager:closeWindow("UIWorldBossWin")
end

UIManager:invokeUIMethod("UIWorldExperienceWin","showContinue",false)
if jumpBossWin then
winParam.challenge()
else
UIManager:showWindow("UIWorldBossWin",winParam)
end
end

function worldExperienceController:showCompleteWin(world,block,callback)
local winParams=worldExperienceModel:getCompleteWinArgs(world,block,callback)
UIManager:showWindow("UIWorldExperienceCompleteWin",winParams)
end
