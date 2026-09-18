

function myzsController:startFight()

local level=myzsModel:getGameIdx()
local levelInfo=myzsModel:getlevelConf(level)

local targetId=levelInfo.obj_id
local targetType=MYZSStageType:transStageType(targetId)
if targetType~=MYZSStageType.eMonster then
logErr("当前关卡不是怪物关卡")
return
end



local teamDiscipleList=myzsModel:getDiscipleTeamList()
local teamList={}
for index,data in ipairs(teamDiscipleList)do
teamList[index]=data.discipleGuid
end

local faZeData=cfgHelper.get2(cfg_mingyuanzhushamonsterconfig_get,targetId,'faze')
local monster_group_id=cfgHelper.get2(cfg_mingyuanzhushamonsterconfig_get,targetId,'monster_group_id')
local monsterGroupCfg=cfgHelper.get1(cfg_monstergroup_get,monster_group_id)

local mapID=monsterGroupCfg.mapId

local faZeList3Args={}

for index,fzInfo in ipairs(faZeData)do
local fzid=fzInfo[1]
local fzlv=fzInfo[2]

local fzRuleCfg=cfgHelper.getSSlawRule(fzid)
local hasParam=fzRuleCfg.descparm and fzRuleCfg.descparm[fzlv]and true or false
local fzdesc=not hasParam and fzRuleCfg.desc or FMT.fmt(fzRuleCfg.desc,unpack(fzRuleCfg.descparm[fzlv]))
faZeList3Args[index]={
desc=fzdesc,
name=fzRuleCfg.name,
icon=fzRuleCfg.image,
}
end

local args={
enterTxt="冥渊诛煞",
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
monsterList=monsterGroupCfg.monList,
groupId=monster_group_id,
teamList=teamList,
showZhenFa=false,

faZeList3Args=faZeList3Args,
faZeList3Default=false,
statePriorityCheck=false,
enterCallBack=function(teamList,zfId)
if teamList and next(teamList)then
local temp={}
for index,data in ipairs(teamList)do
local guid=data[2]
local discipleData=myzsModel:getDiscipleDataByGuid(guid)
temp[#temp+1]=discipleData
end
myzsModel:setDiscipleTeamList(temp)
end
fightLaunchController:sendFight(eBattleLaunch.mingyuanzhusha,teamList,mapID,zfId,{})
UIManager.enableMoneyTips(false)
end,
cancelCallBack=function(guidList)
if guidList and next(guidList)then
local temp={}
for index,data in ipairs(guidList)do
local guid=data[2]
local discipleData=myzsModel:getDiscipleDataByGuid(guid)
temp[#temp+1]=discipleData
end
myzsModel:setDiscipleTeamList(temp)

myzsController:showFullWin()
end

end,
sortTypeList={
eDiscipleSortType.eMYZS_Hp,
eDiscipleSortType.eJingJieSort,
eDiscipleSortType.eLianTiSort,
eDiscipleSortType.eColorSort,
},
isMYZS=true,
closeByCloud=true,
}


fightController.showPrepareWin(fightPreSelectModel.fightType.mingyuanzhusha,args)
end

function myzsController.onTriggerBattle(result,log,data)

end