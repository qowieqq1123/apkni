zmvisitchallengeConfig={}

local conditionTypeList={
continueShiftNum=1,
}

local conditionAnalysisList={
[conditionTypeList.continueShiftNum]=function(challenge_id,level_id,condition_data)
local levelCfg=cfgHelper.get2(cfg_zongmenvisitorchallengelayerconfig_get,challenge_id,level_id)
local monsterName=cfgHelper.get2(cfg_monstergroup_get,levelCfg.mon_id,'name')
local type=condition_data[1]
local shiftNum=condition_data[2]

return FMT.fmt('在{0}手下坚持{1}回合',monsterName,shiftNum)
end,
}

function zmvisitchallengeConfig.analysysConditionList(challenge_id,level_id,condition_data_list)
local analysysList={}

for index,conditionData in ipairs(condition_data_list)do
local type=conditionData[1]

if conditionAnalysisList[type]then
local analysysFunc=conditionAnalysisList[type]
local str=analysysFunc(challenge_id,level_id,conditionData)
table.insert(analysysList,str)
else
logErr(FMT.fmt('缺少类型为 {0} 的解析类型',type))
end
end

return analysysList
end

function zmvisitchallengeConfig.getChallengeMaxNum(challenge_id)
local cfgs=cfgHelper.get1(cfg_visitorchallengelayerconfig_get,challenge_id)
return#cfgs
end