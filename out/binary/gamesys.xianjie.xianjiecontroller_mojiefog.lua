




function xianjieController:onAppStart_mojieFog()
end

function xianjieController:onEnterState_mojieFog(isReconnet)
end

function xianjieController:onLeaveState_mojieFog(isReconnet)
end

function xianjieController:onEnterMap_mojieFog()
xianjieModel:onEnterMap_mojieFog()
end

function xianjieController:onExitMap_mojieFog()
xianjieModel:onExitMap_mojieFog()
end

function xianjieController.onSeasonChange_MoJie_Fog()
local handle=seasonModel:getHandleByType(eSeasonType.eMJMB)
if handle then
local curStageIdx=handle:getCurStageIdx()
xianjieController.onSeasonStageChange_MoJie_Fog(handle.id,curStageIdx)
end
end

function xianjieController.onSeasonStageChange_MoJie_Fog(season_id,chapter_idx)
local seasonType=seasonModel:getHandleConfig(season_id,'seasonType')
if seasonType==eSeasonType.eMJMB then
xianjieModel:updateMoJieFogState(season_id,chapter_idx)
else



end
end



function xianjieController:getSeaonCurFogId(seasonID)
local seasonHandle=seasonModel:getHandle(seasonID)
local curStageFog=0
if seasonHandle then
local curStageidx=seasonHandle:getCurDoingStageIdx()
local fog_dissiplate=seasonHandle:getConfig('fog_dissiplate')
if fog_dissiplate then
for index,fogid in ipairs(fog_dissiplate)do
if fogid~=0 then
if curStageidx>=index then
curStageFog=fogid
end
end
end
end
end
return curStageFog
end




function xianjieController:checkStageCanShowEntity(seasonID,stageIdx)
local seasonHandle=seasonModel:getHandle(seasonID)
if not seasonHandle then
return false
end
local curStageidx=seasonHandle:getCurDoingStageIdx()
local fog_dissiplate=seasonHandle:getConfig('fog_dissiplate')
local curStageFog=0
local aimStageFog=0
if fog_dissiplate then
for index,fogid in ipairs(fog_dissiplate)do
if fogid~=0 then
if curStageidx>index then
curStageFog=fogid
end

if stageIdx>index then
aimStageFog=fogid
end
end
end
end

if curStageidx>=stageIdx and curStageFog>0 then
return true
end

if curStageidx<=stageIdx and curStageFog==curStageFog then
return true
end

return false
end





function xianjieController:checkMoJiePosOpenFog(sceneidx,gridX,gridZ)
if not xianjienSceneIndexType:isMoJie(sceneidx)then return false end

local areaId=xianjieModel:getMapGridDataAreaID(sceneidx,gridX,gridZ)
local area=xianjieModel:getMoJieEnterConfig('area')
local chapterIdx=area[areaId]
if chapterIdx==nil then return false end


local curMoJieSeasonHandle=seasonModel:getHandleByType(eSeasonType.eMJMB)
if not curMoJieSeasonHandle then
return false
end
local curFogId=xianjieController:getSeaonCurFogId(curMoJieSeasonHandle.id)
if curFogId==nil then return false end

local fog_dissiplate=curMoJieSeasonHandle:getConfig("fog_dissiplate")
local needUnLockFogId=fog_dissiplate[chapterIdx]

if needUnLockFogId==nil then return true end

return curFogId>=needUnLockFogId
end

