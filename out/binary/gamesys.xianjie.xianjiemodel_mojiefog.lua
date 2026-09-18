





function xianjieModel:onEnterMap_mojieFog()
self:createMoJieFog()
end

function xianjieModel:onExitMap_mojieFog()
self:removeMoJieFog()
end

function xianjieModel:createMoJieFog()
local sceneType=xianjieModel:getSceneIndex()
if xianjienSceneIndexType:isMoJie(sceneType)then
local seasonHandle=seasonModel:getHandleByType(eSeasonType.eMJMB)
if seasonHandle==nil then
logErr("缺少赛季数据")
return
end
self.curFogId_MoJie=xianjieController:getSeaonCurFogId(seasonHandle.id)
self.ent_key_fog=xianjieController:addEntity(XJ_ENTITY_TYPE.eMoJieFog,{pos={0,0,0},seasonID=seasonHandle.id},false)
end
end

function xianjieModel:removeMoJieFog()
if self.ent_key_fog then
xianjieController:removeEntity(self.ent_key_fog,true)
end
self.curFogId_MoJie=nil
end

function xianjieModel:updateMoJieFogState(season_id,chapter_idx)
if self.ent_key_fog then
local fog_dissiplate=seasonModel:getHandleConfig(season_id,'fog_dissiplate')
local fog_dissiplate_duration=seasonModel:getHandleConfig(season_id,'fog_dissiplate_duration')
local stageFogId=fog_dissiplate[chapter_idx]
if stageFogId==0 then



return
end
if stageFogId~=self.curFogId_MoJie then
xianjieController:invokeEntityFunc(self.ent_key_fog,'playFogDissipate',stageFogId)
local delaytTime=fog_dissiplate_duration[stageFogId]
timeEventController.delayDo(delaytTime,function()
xianjieController:invokeEntityFunc(self.ent_key_fog,'refreshInfo')
notifySystem:postNotify(notifyConfig.onMoJieSeasonFogDissipate,season_id,chapter_idx,stageFogId)
end)
self.curFogId_MoJie=stageFogId
else



end
end
end











