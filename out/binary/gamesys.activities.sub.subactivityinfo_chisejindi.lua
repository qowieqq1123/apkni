









local subActivityInfo_chisejindi={name='subActivityInfo_chisejindi'}







































































local _typeLine=10
local _cdInterval=3


local _selectCopyItemHandle={
[eChiSeJinDiRoundType.Disciple]=function(info,selectIndex)
local config=info:getSubActConfig()
local copyData=info:getCopy()
local roundData=copyData.roundData
local selectData=roundData.list[selectIndex]
local discipleID=selectData.param_1
local serverCfg=config.disciple[discipleID]
selectData.param_2=1

local up=nil
for idx,id in ipairs(copyData.discipleList)do
local newId=info:doItemStarUp(id,discipleID)
if newId then
up={
roundType=eChiSeJinDiRoundType.Disciple,
oldID=copyData.discipleList[idx],
newID=newId,
}
copyData.discipleList[idx]=newId
break
end
end

local teamChange=false
local discipleLookup=info:getTeamLookup_Disciple()
if not up then
table.insert(copyData.discipleList,discipleID)

local teamCnt=table.numsEx(discipleLookup)
if teamCnt<fightPreSelectModel.maxPosNum then
local discipleServer=config.disciple[discipleID]
local job=discipleServer[6]
local jobCfg=cfgHelper.get1(cfg_disciplevocationconfig_get,job)
for i,v in ipairs(jobCfg.pospriorty)do
if not table.containsValue(discipleLookup,v)then
info:discipleTeamOn(v,discipleID)
teamChange=true
break
end
end
end
else
info:pushStarUp(up)

local pos=discipleLookup[up.oldID]
if pos then
info:discipleTeamUp(pos,up.newID)
teamChange=true
end
end

local color=serverCfg[5]
local monsterId=serverCfg[1]
local name=cfgHelper.get2(cfg_monsterconfig_get,monsterId,"name")
local colorName=FMT.cfmt(color,name)
local infoStr=up and FMT.fmt("{0}品质提升",colorName)or FMT.fmt("{0}加入队伍",colorName)
UIManager.info(infoStr)

if teamChange then
info:saveTeam()
end
copyData.dirtyDiscipleList=true
local price=serverCfg[3]
copyData.money=copyData.money-price
end,
[eChiSeJinDiRoundType.Weapon]=function(info,selectIndex)
local config=info:getSubActConfig()
local copyData=info:getCopy()
local roundData=copyData.roundData
local selectData=roundData.list[selectIndex]
local weaponID=selectData.param_1
local serverCfg=config.treasure[weaponID]
local clientCfg=config.treasureClient[weaponID]
selectData.param_2=1

local up=nil
for idx,id in ipairs(copyData.weaponList)do
local newId=info:doItemStarUp(id,weaponID)
if newId then
up={
roundType=eChiSeJinDiRoundType.Weapon,
oldID=copyData.weaponList[idx],
newID=newId,
}
copyData.weaponList[idx]=newId
break
end
end

local teamChange=false
if not up then
table.insert(copyData.weaponList,weaponID)
else
info:pushStarUp(up)

local weaponLookup=info:getTeamLookup_Weapon()
local pos=weaponLookup[up.oldID]
if pos then
info:weaponTeamUp(pos,up.newID)
teamChange=true
end
end

local color=serverCfg[6]
local name=clientCfg[1]
local colorName=FMT.cfmt(color,name)
local infoStr=up and FMT.fmt("{0}星级提升",colorName)or FMT.fmt("已获得{0}",colorName)
UIManager.info(infoStr)

if teamChange then
info:saveTeam()
end
copyData.dirtyWeaponList=true
local price=serverCfg[4]
copyData.money=copyData.money-price
end,
[eChiSeJinDiRoundType.FaZe]=function(info,selectIndex)
local config=info:getSubActConfig()
local copyData=info:getCopy()
local roundData=copyData.roundData
local selectData=roundData.list[selectIndex]
local fazeID=selectData.param_1

local up=nil
for idx,id in ipairs(copyData.fazeList)do
local newId=info:doItemStarUp(id,fazeID)
if newId then
up={
roundType=eChiSeJinDiRoundType.FaZe,
oldID=copyData.fazeList[idx],
newID=newId
}
copyData.fazeList[idx]=newId
break
end
end

if not up then
table.insert(copyData.fazeList,fazeID)
else
info:pushStarUp(up)
end
copyData.dirtyFaZeList=true

local serverCfg=config.faze[fazeID]
local fzId=serverCfg[1]
local fzLv=serverCfg[2]
local fzCfg=cfgHelper.getSSlawRule(fzId)
local qualityDesc=cfg_secretscenebaseconfig_get(1).rule_quality
local color_cfg=qualityDesc[fzLv]
local name=fzCfg.name
local colorName=FMT.fmt("<color=#{0}>{1}</color>",color_cfg[2],name)
local infoStr=FMT.fmt("已获得{0}",colorName)
UIManager.info(infoStr)
end,
}

local _sellCopyItemHandle={
[eChiSeJinDiRoundType.Disciple]=function(info,ids)
local config=info:getSubActConfig()
local copyData=info:getCopy()

local teamChange=false
local lookup=info:getTeamLookup_Disciple()
local total=0
for idx,id in ipairs(ids)do
local exist=table.removeValue(copyData.discipleList,id)
if exist then
local delta=config.disciple[id][4]
total=total+delta
copyData.money=copyData.money+delta
end

local pos=lookup[id]
if pos then
info:discipleTeamOff(pos)
teamChange=true
end
end

if teamChange then
info:saveTeam()
end
copyData.dirtyDiscipleList=true

local moneyName=itemsConfig.getItemName(config.chanceMoney)
UIManager.info(FMT.fmt("{0} +{1}",moneyName,total))
end,
[eChiSeJinDiRoundType.Weapon]=function(info,ids)
local config=info:getSubActConfig()
local copyData=info:getCopy()

local teamChange=false
local lookup=info:getTeamLookup_Weapon()
local total=0
for idx,id in ipairs(ids)do
local exist=table.removeValue(copyData.weaponList,id)
if exist then
local delta=config.treasure[id][5]
total=total+delta
copyData.money=copyData.money+delta
end
local pos=lookup[id]
if pos then
info:weaponTeamOff(pos)
teamChange=true
end
end

if teamChange then
info:saveTeam()
end
copyData.dirtyWeaponList=true

local moneyName=itemsConfig.getItemName(config.chanceMoney)
UIManager.info(FMT.fmt("{0} +{1}",moneyName,total))
end,
}

local _containsCopyItemHandle={
[eChiSeJinDiRoundType.Disciple]=function(info,id)
local copyData=info:getCopy()
for _idx,_id in ipairs(copyData.discipleList)do
local newId=info:doItemStarUp(_id,id)
if newId then
return true
end
end
return false
end,
[eChiSeJinDiRoundType.Weapon]=function(info,id)
local copyData=info:getCopy()
for _idx,_id in ipairs(copyData.weaponList)do
local newId=info:doItemStarUp(_id,id)
if newId then
return true
end
end
return false
end,
[eChiSeJinDiRoundType.FaZe]=function(info,id)
local copyData=info:getCopy()
for _idx,_id in ipairs(copyData.fazeList)do
local newId=info:doItemStarUp(_id,id)
if newId then
return true
end
end
return false
end,
}

function subActivityInfo_chisejindi:onInit()
local config=self:getSubActConfig()
local rankCfg=config.rank
local weekNum=rankCfg[1]
self.cycleDuration=7*86400*weekNum
local beginWeek=timeHelper.getWeakDateEx3(self.start_time_l)
self.cycleBegin=timeHelper.getServerZeroStamp(self.start_time_l)-(beginWeek-1)*86400

self:listenNotify(notifyConfig.onSubActivityDontHandleReddotChange,function(actId,subType,subId)
local passportParam=self:getSubActConfig("passportParam")
if self.act_id==actId and passportParam[1]==subType and passportParam[2]==subId then
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
end
end)
end

function subActivityInfo_chisejindi:onStart()

end


function subActivityInfo_chisejindi:onDelete()

end

function subActivityInfo_chisejindi:checkReddot()
local config=self:getSubActConfig()
local passportParam=config.passportParam
local actId=self.act_id
local subType=passportParam[1]
local subId=passportParam[2]
local reddot=false
if activitiesModel:isDontHandleSubType(subType)then
reddot=activitiesModel:getReddot_DontHandle(actId,subType,subId)
else
reddot=activitiesModel:checkSubActReddot(actId,subType,subId)
end
if reddot then
return true
end

if self:hasTargetFlag0()then
return true
end

local data=self:getData()
if data.continue<=0 then
local costIdx=data.copyTimes+1
local consume=config.consume
local costCfg=costIdx>=#consume and consume[#consume]or consume[costIdx]
local haveCost=#costCfg>0
if not haveCost then
return true
end
end

if data.stageFlag<data.stage then
local rewards=config.score[data.stageFlag+1][2]
local count=rewards and#rewards or 0
local reddot=count>0
if reddot then
return true
end
end

local actId=self.act_id
local passporttype=txzType.act
local passportParam=config.passportParam
local guid=UITYTongXingZhengModel:getGuidByActID(passporttype,actId,passportParam[1],passportParam[2])

if guid then
if UITYTongXingZhengController:checkReddot(guid)then
return true
end
end

return data.dailyFlag==0 and(data.copyTimes>1 or(data.copyTimes==1 and data.continue<=0))
end

function subActivityInfo_chisejindi:checkNewDay()
local todayZero=timeHelper.getTodayZeroStamp()
local deltaStamp=todayZero-self.cycleBegin
if deltaStamp%self.cycleDuration==0 then
call_activitiesHandle_func("activitiesHandle_chisejindi","reqRefreshActivityData",self.act_id,self.sub_act_id)
else
local data=self:getData()
data.dailyFlag=0
data.dailyScore=0
data.copyTimes=0

self:invokePanelMethod("refreshView")
self:refreshReddot()
end
end


function subActivityInfo_chisejindi:addTargetFlagLookup(targetList)
if targetList then
local data=self:getData()
for i,v in ipairs(targetList)do
data.targetFlagLookup[v.param_1]=v.param_2
end
end
end


function subActivityInfo_chisejindi:getTargetFlag(targetIdx)
if self:hasData()then
local data=self:getData()
return data.targetFlagLookup[targetIdx]
end
end

function subActivityInfo_chisejindi:getAllTargetFlag0()
if self:hasData()then
local data=self:getData()
local list={}
for idx,flag in pairs(data.targetFlagLookup)do
if flag==0 then
table.insert(list,idx)
end
end
return list
end
end

function subActivityInfo_chisejindi:hasTargetFlag0()
if self:hasData()then
local data=self:getData()
for idx,flag in pairs(data.targetFlagLookup)do
if flag==0 then
return true
end
end
end
return false
end

function subActivityInfo_chisejindi:containsBagItem(roundType,id)
local handle=_containsCopyItemHandle[roundType]
if handle then
return handle(self,id)
end
end

function subActivityInfo_chisejindi:pushStarUp(starUp)
if self.starUp==nil then
self.starUp={}
end
table.insert(self.starUp,starUp)
end

function subActivityInfo_chisejindi:popStarUp()
if self.starUp then
return table.remove(self.starUp,1)
end
end

function subActivityInfo_chisejindi:getStarUpCache()
return self.starUp or{}
end

function subActivityInfo_chisejindi:checkStarUp()
return self.starUp and#self.starUp>0
end

function subActivityInfo_chisejindi:clearStarUp()
if self.starUp then
table.clear(self.starUp)
end
end


function subActivityInfo_chisejindi:getRank()
return self.rank
end


function subActivityInfo_chisejindi:setRank(rankData)
self.rank=rankData
end


function subActivityInfo_chisejindi:hasRank()
return self.rank~=nil
end


function subActivityInfo_chisejindi:getCopy()
return self.copy
end


function subActivityInfo_chisejindi:setCopy(copyData)
self.copy=copyData
self:checkCopyExData(copyData)
end

function subActivityInfo_chisejindi:checkCopyExData(copyData)
if copyData==nil then return end
if not copyData.sortDiscipleList then
copyData.sortDiscipleList=function(data)
if#data.discipleList>1 and data.dirtyDiscipleList~=false then

local discipleServer=self:getSubActConfig("disciple")
table.sort(data.discipleList,function(a,b)
local colorA=discipleServer[a][5]
local colorB=discipleServer[b][5]
if colorA~=colorB then
return colorA>colorB
else
return a<b
end
end)
data.dirtyDiscipleList=false
end
end
end
if not copyData.sortWeaponList then
copyData.sortWeaponList=function(data)
if#data.weaponList>1 and data.dirtyWeaponList~=false then

local weaponServer=self:getSubActConfig("treasure")
table.sort(data.weaponList,function(a,b)
local colorA=weaponServer[a][6]
local colorB=weaponServer[b][6]
if colorA~=colorB then
return colorA>colorB
else
return a<b
end
end)
data.dirtyWeaponList=false
end
end
end
if not copyData.sortFaZeList then
copyData.sortFaZeList=function(data)
if#data.fazeList>1 and data.dirtyFaZeList~=false then
local fazeServer=self:getSubActConfig("faze")
table.sort(data.fazeList,function(a,b)
local levelA=fazeServer[a][2]
local levelB=fazeServer[b][2]
if levelA~=levelB then
return levelA>levelB
else
local cfgA=cfgHelper.getSSlawRule(fazeServer[a][1])
local cfgB=cfgHelper.getSSlawRule(fazeServer[b][1])
return cfgA.id<cfgB.id
end
end)
data.dirtyFaZeList=false
end
end
end
end

function subActivityInfo_chisejindi:refreshRoundData(roundData)
local copyData=self:getCopy()
local roundType=roundData.roundtype
local costCfg=self:getSubActConfig("refresh")
local cost=costCfg[roundType]or 0
copyData.roundData=roundData
copyData.money=copyData.money-cost
end

function subActivityInfo_chisejindi:addCopyRoundMoney()
local copyData=self:getCopy()
if copyData.roundData.roundtype~=eChiSeJinDiRoundType.Hidden then
local roundCfg=cfgHelper.get2(cfg_chisejindiroundconfig_get,copyData.template,copyData.round)
copyData.money=copyData.money+(roundCfg.chance or 0)
end
end


function subActivityInfo_chisejindi:nextCopyRound(nextRound)
local copyData=self:getCopy()
if copyData.roundData.roundtype==eChiSeJinDiRoundType.Reward then
copyData.money=copyData.money+copyData.roundData.chance
end





if nextRound.roundtype~=eChiSeJinDiRoundType.Hidden then
copyData.round=copyData.round+1
end
copyData.roundData=nextRound
end


function subActivityInfo_chisejindi:selectCopyItem(selectIdx)
local copyData=self:getCopy()
local roundtype=copyData.roundData.roundtype
local selectHandle=_selectCopyItemHandle[roundtype]
if selectHandle then
selectHandle(self,selectIdx)
end
end


function subActivityInfo_chisejindi:doItemStarUp(oId,nId)
local oType=math.floor(oId/_typeLine)
local nType=math.floor(nId/_typeLine)
if oType==nType then
return oId+1
end
end


function subActivityInfo_chisejindi:sellCopyItem(roundtype,ids)
local sellandle=_sellCopyItemHandle[roundtype]
if sellandle then
sellandle(self,ids)
end
end


function subActivityInfo_chisejindi:fightResultHandle(result,roundData)
local copyData=self:getCopy()
local cRound=copyData.roundData
if cRound.roundtype~=eChiSeJinDiRoundType.Hidden then
if result==fightResultType.Victory then
copyData.level=copyData.level+1
else
copyData.hp=math.max(copyData.hp-1,0)
end
end
if roundData then
self:nextCopyRound(roundData)
end
end


function subActivityInfo_chisejindi:resultCopy()
local data=self:getData()
local copyData=self:getCopy()
local teamData=self:getTeam()
local config=self:getSubActConfig()

local _stage=data.stage
local _stageScore=data.stageScore
local _dailyScore=data.dailyScore
local _level=copyData.level

local settleCfg=config.settle
local _addCfg=settleCfg[2]
data.dailyScore=math.min(_dailyScore+settleCfg[1][_level],config.today)

if not self:checkInResultRankTime()then
local addCfg=_addCfg[1]
for i,v in ipairs(_addCfg)do
if v[1]<=_stageScore then
addCfg=v[2]
else
break
end
end
data.stageScore=_stageScore+addCfg[_level]
end

local stage,nextDelta=self:calculateStageEx(data.stageScore)
data.stage=stage
data.stageNext=nextDelta

local resultData={
level=_level,
bStage=_stage,
aStage=stage,
bStageScore=_stageScore,
bDailyScore=_dailyScore,
aStageScore=data.stageScore,
aDailyScore=data.dailyScore,
copyData=copyData,
teamData=table.deepCopy(teamData),
}
self:setResult(resultData)
self:clearTeam()
self:saveTeam()
self:setCopy(nil)
end


function subActivityInfo_chisejindi:calculateStageEx(stageScoreNum)
local stageConfig=self:getSubActConfig("score")
local stage=0
local nextDelta=-1
for index,config in ipairs(stageConfig)do
if stageScoreNum>=config[1]then
stage=index
else
nextDelta=config[1]-stageScoreNum
break
end
end
return stage,nextDelta
end


function subActivityInfo_chisejindi:setResult(resultData)
self.result=resultData
end


function subActivityInfo_chisejindi:getResult()
return self.result
end


function subActivityInfo_chisejindi:getTeam()
if self.team==nil then
self.team=self:loadTeam()
self.teamClean1=false
self.teamClean2=false
end
if self.team==nil then
self.team=self:getEmptyTeam()
self:saveTeam()
self.teamClean1=false
self.teamClean2=false
end
return self.team
end








function subActivityInfo_chisejindi:clearTeam()
for i,v in ipairs(self.team)do
v.disciple=0
v.weapon=0
end
self.teamClean1=false
self.teamClean2=false
end

function subActivityInfo_chisejindi:getTeamLookup_Disciple()
if not self.teamClean1 or self.teamLookup1==nil then
if self.teamLookup1 then
table.clear(self.teamLookup1)
else
self.teamLookup1={}
end
for i,v in ipairs(self.team)do
if v.disciple>0 then
self.teamLookup1[v.disciple]=i
end
end
self.teamClean1=true
end
return self.teamLookup1
end

function subActivityInfo_chisejindi:getTeamLookup_Weapon()
if not self.teamClean2 or self.teamLookup2==nil then
if self.teamLookup2 then
table.clear(self.teamLookup2)
else
self.teamLookup2={}
end
for i,v in ipairs(self.team)do
if v.weapon>0 then
self.teamLookup2[v.weapon]=i
end
end
self.teamClean2=true
end
return self.teamLookup2
end


function subActivityInfo_chisejindi:loadTeam()
local key=FMT.fmt("{0}_{1}_{2}_Team",self.act_id,self.sub_act_id,self.start_time)
local teamData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eChiSeJinDi,key)
return teamData
end

function subActivityInfo_chisejindi:getEmptyTeam()
local teamData={}
for i=1,fightPreSelectModel.maxPosNum do
teamData[i]={disciple=0,weapon=0}
end
return teamData
end


function subActivityInfo_chisejindi:saveTeam()
local key=FMT.fmt("{0}_{1}_{2}_Team",self.act_id,self.sub_act_id,self.start_time)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eChiSeJinDi,key,self.team)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eChiSeJinDi)
end

function subActivityInfo_chisejindi:changeDisciplePos(tPos,oPos)
local tData=self.team[tPos]
local oData=self.team[oPos]
local temp=tData.disciple
tData.disciple=oData.disciple
oData.disciple=temp
local temp=tData.weapon
tData.weapon=oData.weapon
oData.weapon=temp
self.teamClean1=false
self.teamClean2=false
end

function subActivityInfo_chisejindi:changeWeaponPos(tPos,oPos)
local tData=self.team[tPos]
local oData=self.team[oPos]
local temp=tData.weapon
tData.weapon=oData.weapon
oData.weapon=temp
self.teamClean2=false
end


function subActivityInfo_chisejindi:discipleTeamOn(pos,disciple)
local posData=self.team[pos]
posData.disciple=disciple or 0
posData.weapon=0
self.teamClean1=false
self.teamClean2=false
end


function subActivityInfo_chisejindi:discipleTeamOff(pos)
local posData=self.team[pos]
posData.disciple=0
posData.weapon=0
self.teamClean1=false
self.teamClean2=false
end


function subActivityInfo_chisejindi:discipleTeamUp(pos,disciple)
local posData=self.team[pos]
posData.disciple=disciple or 0
self.teamClean1=false
end


function subActivityInfo_chisejindi:weaponTeamOn(pos,weapon)
local posData=self.team[pos]
if posData.disciple>0 then
posData.weapon=weapon or 0
self.teamClean2=false
end
end


function subActivityInfo_chisejindi:weaponTeamOff(pos)
local posData=self.team[pos]
posData.weapon=0
self.teamClean2=false
end


function subActivityInfo_chisejindi:weaponTeamUp(pos,weapon)
local posData=self.team[pos]
posData.weapon=weapon or 0
self.teamClean2=false
end


function subActivityInfo_chisejindi:recordCDTime()
self.cdTime=timeHelper.getServerShortTime()
end

function subActivityInfo_chisejindi:checkCDTime()
if self.cdTime then
return timeHelper.getServerShortTime()>=self.cdTime+_cdInterval
end
return true
end

function subActivityInfo_chisejindi:cancalCDTime()
if self.cdTime then
local nowTime=timeHelper.getServerShortTime()
if nowTime-self.cdTime>_cdInterval-1 then
self.cdTime=nil
else
self.cdTime=nowTime-(_cdInterval-1)
end
end
end

function subActivityInfo_chisejindi:getCopyItemStar(id)
return id%_typeLine
end

function subActivityInfo_chisejindi:checkInResultRankTime()
local config=self:getSubActConfig("rank")
local nowStamp=timeHelper.getServerLongTime()
local deltaStamp=nowStamp-self.cycleBegin
local weekSecond=deltaStamp%self.cycleDuration
return weekSecond>=(self.cycleDuration-config[2])
end

return subActivityInfo_chisejindi