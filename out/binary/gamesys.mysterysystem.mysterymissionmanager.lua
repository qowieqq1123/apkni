







mysteryMissionManager={}




function mysteryMissionManager:startMission(fbId,multiNum)

local typo=MysteryModel:get_mystery_sence_type(fbId)
local targetKey
if typo==MysterySenceType.ZiYuan then
local group=mysteryZiYuanFuBenModel:getZiYuanGroupByFbid(fbId)

targetKey=worldModel:convertUnitKey({worldModel.UNITTYPE.MYSTERY,fbId})
else
targetKey=worldModel:convertUnitKey({worldModel.UNITTYPE.MYSTERY,fbId})
end
local taskKey=worldTaskModel:findLastTaskKey_ByTarget(targetKey)

local check=taskKey==nil
if not check then
local task=worldTaskModel:getTask(taskKey)
check=task.progress_state>=eWorldTripProgress.Back
end


if check then

local probeTeam=MysteryModel:get_fb_task_team()

if not probeTeam then

else
local team={}
for i,v in ipairs(probeTeam)do
if v.unitType==fightPreSelectModel.teamEntityType.dizi then
table.insert(team,v.unitId)
else
table.insert(team,int64.zero)
end
end

local zfId=MysteryModel:get_select_zhenFa()

if typo==MysterySenceType.World then
local unit=MysteryModel:get_mysteryFB_unit(fbId)
worldTaskController:startMission(eWorldUnitTpye.MYSTERY,unit[5],fbId,team,zfId)
elseif typo==MysterySenceType.ResPoint then
local data,guid,subIdx=worldResPointDataModel:findMysteryData(fbId)
worldTaskController:startMission(eWorldUnitTpye.MYSTERY,guid,fbId,team,zfId)
elseif typo==MysterySenceType.ZiYuan then
local group=mysteryZiYuanFuBenModel:getZiYuanGroupByFbid(fbId)
worldTaskController:startMission(eWorldUnitTpye.MYSTERY,int64.new(group[1]*1000),fbId,team,zfId)
end

end
MysteryModel:set_mysteryFB_currentOutId(fbId)

end

MysteryController.send_4_1(fbId,multiNum)
end


function mysteryMissionManager:stopMission(fbId)






MysteryModel:set_mysteryFB_currentOutId(0)
end


function mysteryMissionManager:checkMission(fbId,isWarning)

local targetKey=worldModel:convertUnitKey({worldModel.UNITTYPE.MYSTERY,fbId})
local taskKey=worldTaskModel:findTaskKey_ByTarget(targetKey)

if taskKey then
if isWarning then

end
return true
end

return false
end

function mysteryMissionManager:isWaitingBack(fbId)
local targetKey=worldModel:convertUnitKey({worldModel.UNITTYPE.MYSTERY,fbId})
local taskKey=worldTaskModel:findTaskKey_ByTarget(targetKey)
return worldTaskModel:isWaitingBack(taskKey)
end

