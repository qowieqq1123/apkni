










local _showUnitHandle={
[eWorldResPointUnitType.Monster]="showResPointUnit_Monster",
[eWorldResPointUnitType.Collection]="showResPointUnit_Collection",
[eWorldResPointUnitType.Event]="showResPointUnit_Event",
[eWorldResPointUnitType.Story]="showResPointUnit_Story",
[eWorldResPointUnitType.Mystery]="showResPointUnit_Mystery",
}

local _clickUnitHandle={
[eWorldResPointUnitType.Monster]="onClickUnit_Monster",
[eWorldResPointUnitType.Collection]="onClickUnit_Collection",
[eWorldResPointUnitType.Event]="onClickUnit_Event",
[eWorldResPointUnitType.Story]="onClickUnit_Story",
[eWorldResPointUnitType.Mystery]="onClickUnit_Mystery",
}



function worldResPointController:showWorldResPoint(world)
local worldDatas=worldResPointDataModel:getWorldGuids(world)or{}
for block,list in pairs(worldDatas)do
if worldBlockModel:checkBlockState(world,block,eWorldBlockState.OPEN)then
for index,guid in ipairs(list)do
self:showResPointUnits(guid)
end
end
end
end

function worldResPointController:showBlockResPoint(world,block)
local blockDatas=worldResPointDataModel:getBlockGuids(world,block)or{}
for index,guid in ipairs(blockDatas)do
self:showResPointUnits(guid)
end
end

function worldResPointController:showResPointUnits(guid)
local data=worldResPointDataModel:getPointData(guid)
if worldController:isInWorld()and data and worldModel:isSameWorld(data.world)then

for subIdx,subData in pairs(data.datas)do
local position,flip=worldResPointDataModel:getSubPointPosition(guid,subIdx)
if position and position~=Vector3.zero then
self:showResPointUnit(guid,subIdx,subData[1],subData[2],position,false,flip)
else
loggerUtil.logErrFMT("创建资源点单位失败（不存在坐标）:  {0}, {1}, {2}",tostring(guid),subIdx,serializeHelper.serialize(data))
end
end
end
end






function worldResPointController:showResPointUnit(guid,subIdx,dataType,dataId,position,fast,flip)
local showUnitHandle=_showUnitHandle[dataType]

self[showUnitHandle](self,guid,subIdx,dataId,position,fast,flip)
end

function worldResPointController:hideWorldResPoint(world)
if worldController:isInWorld()and worldModel:isSameWorld(world)then
local worldDatas=worldResPointDataModel:getWorldGuids(world)or{}
for block,list in pairs(worldDatas)do
for index,guid in ipairs(list)do
self:hideResPointAllUnit(guid)
end
end
end
end



function worldResPointController:hideResPointUnit(unitKey)
worldController:popMove(unitKey)
worldController:popUnit(unitKey)

end

function worldResPointController:hideResPointUnitEx(guid,subIdx)
local unitKey=worldResPointBaseModel:convertUnitKey(guid,subIdx)
self:hideResPointUnit(unitKey)
end



function worldResPointController:hideResPointAllUnit(guid)
local pointData=worldResPointDataModel:getPointData(guid)
if pointData and worldController:isInWorld()and worldModel:isSameWorld(pointData.world)then
for subIdx,subData in pairs(pointData.datas)do
local unitKey=worldResPointBaseModel:convertUnitKey(guid,subIdx)
worldController:popMove(unitKey)
worldController:popUnit(unitKey)
end
end

end





function worldResPointController:showResPointUnit_Monster(guid,subIdx,id,position,fast,flip)
local cfg=cfgHelper.get1(cfg_worldresbattleconfig_get,id)
if cfg then
local unitKey=worldResPointBaseModel:convertUnitKey(guid,subIdx)
local modelSettings=worldModel:getModelSettings(cfg.model,worldModel.UNITTYPE.RESPOINT)
local hudSettings=worldModel:getHUDSetting(cfg.hud)
local data={eWorldUnitTpye.RESPOINT,guid,subIdx,eWorldResPointUnitType.Monster,id,flip~=false}
worldController:pushUnit(unitKey,position,data,modelSettings,hudSettings)
if not fast then
worldUnitModel.speResPoint(unitKey)
else
worldController:setUnitFlipX(unitKey,flip~=false)
end
else

end
end





function worldResPointController:showResPointUnit_Collection(guid,subIdx,id,position,fast,flip)
local cfg=cfgHelper.get1(cfg_worldrescollectionconfig_get,id)
if cfg then
local unitKey=worldResPointBaseModel:convertUnitKey(guid,subIdx)
local modelSettings=worldModel:getModelSettings(cfg.model,worldModel.UNITTYPE.RESPOINT)
local hudSettings=worldModel:getHUDSetting(cfg.hud)
local data={eWorldUnitTpye.RESPOINT,guid,subIdx,eWorldResPointUnitType.Collection,id,false}
worldController:pushUnit(unitKey,position,data,modelSettings,hudSettings)

if not fast then
worldUnitModel.speResPoint(unitKey)
end
else

end
end





function worldResPointController:showResPointUnit_Event(guid,subIdx,id,position,fast,flip)
local cfg=cfgHelper.get1(cfg_worldreseventconfig_get,id)
if cfg then
local unitKey=worldResPointBaseModel:convertUnitKey(guid,subIdx)
local modelSettings=worldModel:getModelSettings(cfg.model,worldModel.UNITTYPE.RESPOINT)
local hudSettings=worldModel:getHUDSetting(cfg.hud)
local data={eWorldUnitTpye.RESPOINT,guid,subIdx,eWorldResPointUnitType.Event,id,flip~=false}
worldController:pushUnit(unitKey,position,data,modelSettings,hudSettings)
if not fast then
worldUnitModel.speResPoint(unitKey)
else
worldController:setUnitFlipX(unitKey,flip~=false)
end
else

end
end





function worldResPointController:showResPointUnit_Story(guid,subIdx,id,position,fast,flip)
local cfg=cfgHelper.get1(cfg_worldresstoryconfig_get,id)
if cfg then
local unitKey=worldResPointBaseModel:convertUnitKey(guid,subIdx)
local modelSettings=worldModel:getModelSettings(cfg.model)
local hudSettings=worldModel:getHUDSetting(cfg.hud)
local data={eWorldUnitTpye.RESPOINT,guid,subIdx,eWorldResPointUnitType.Story,id,flip}
worldController:pushUnit(unitKey,position,data,modelSettings,hudSettings)

if not fast then
worldUnitModel.speResPoint(unitKey)
end
else

end
end

function worldResPointController:showResPointUnit_Mystery(guid,subIdx,id,position,fast,flip)
local cfg=cfgHelper.get1(cfg_worldresmysteryconfig_get,id)
if cfg then
local mysteryCfg=cfgHelper.get1(cfg_secretscenefubenconfig_get,cfg.mystery)
local unitKey=worldResPointBaseModel:convertUnitKey(guid,subIdx)
local modelSettings=worldModel:getModelSettings(mysteryCfg.modelRes)
local hudSettings=worldModel:getHUDSetting(mysteryCfg.hudRes)
local data={eWorldUnitTpye.RESPOINT,guid,subIdx,eWorldResPointUnitType.Mystery,id,flip}
worldController:pushUnit(unitKey,position,data,modelSettings,hudSettings)

if not fast then
worldUnitModel.speResPoint(unitKey)
end
else

end
end






function worldResPointController:onClickUnit(guid,subIdx,dataType,dataId)
local clickUnitHandle=_clickUnitHandle[dataType]
self[clickUnitHandle](self,guid,subIdx,dataId)
end




function worldResPointController:onClickUnit_Monster(guid,subIdx,id)
local cPos=worldController:getCameraPosition()
local unitKey=worldResPointBaseModel:convertUnitKey(guid,subIdx)
local callback=function()
if huntMonsterTeamModel:findMonsterWorld(unitKey)then
UIManager.info("猎妖队狩猎中，请稍后")
return
end
local pointData=worldResPointDataModel:getPointData(guid)
self:showMonsterPanel(guid,subIdx,id,pointData.level,cPos.y)
end

local minZoom=worldController:getCameraZoomRange_Normal()[1]
worldController:lookAtUnit(unitKey,minZoom,false,callback)
end




function worldResPointController:onClickUnit_Collection(guid,subIdx,id)

worldResPointController:send_5_43(guid,subIdx,worldModel.world)
end




function worldResPointController:onClickUnit_Event(guid,subIdx,id)
local callback=function()
worldResPointController:showEventPanel(guid,subIdx,id)
end

local minZoom=worldController:getCameraZoomRange_Normal()[1]
local unitKey=worldResPointBaseModel:convertUnitKey(guid,subIdx)
local unitData=worldController:getUnit(unitKey)
local cameraPosition=worldController:getCameraPosition()
worldResPointBaseModel:setTempCemaraData(unitKey,unitData.Position,cameraPosition.y)
worldController:lookAtUnit(unitKey,minZoom,false,callback)
end




function worldResPointController:onClickUnit_Story(guid,subIdx,id)
local storyCfg=cfgHelper.get1(cfg_worldresstoryconfig_get,id)
local callback=function()

worldResPointController:send_5_43(guid,subIdx,worldModel.world)
end
worldStoryController:showStoryTree(storyCfg.story,callback)
end

function worldResPointController:onClickUnit_Mystery(guid,subIdx,id)
worldResPointController:showMysteryPanel(guid,subIdx,id)
end
