






local _MODULENAME="worldSceneryController"




gameState.addListener(def_table(_MODULENAME))
worldSceneryController.name=_MODULENAME
worldSceneryController.data={}

local _click={
[worldSceneryModel.CLICKFUNCTION.BACKZONGMEN]=function()
if not worldExperienceModel:checkScene()then
worldController:exitWorld()
end
end,
}


function worldSceneryController:onAppStart()

worldSceneryModel:onAppStart()







notifySystem:listenNotify(notifyConfig.onClickObjectInWorld,self.onClickScenery)
notifySystem:listenNotify(notifyConfig.onWorldBlockDataChanged,self.onWorldBlockDataChanged)
notifySystem:listenNotify(notifyConfig.on_system_open,self.onSystemOpen)
worldController:registerSceneState(1,1,function()
self:onInitWorld(worldModel.world)
end)
worldController:registerSceneState(2,1,function()
self.data={}
end)


end


function worldSceneryController:onEnterState()
worldSceneryModel:onEnterState()
end


function worldSceneryController:onServerDataInitFinish()
worldSceneryModel:onServerDataInitFinish()
end


function worldSceneryController:onLeaveState()
worldSceneryModel:onLeaveState()

self.data={}
end


function worldSceneryController:onLostConnection()

end






















function worldSceneryController:onInitWorld(world)
local cfg=cfgHelper.get1(cfg_worldanimalconfig_get,world)
if cfg then
for i,v in ipairs(cfg.paths)do
local choose=self:extractMove(world,i)
if choose then
self:startMove(world,i,choose)
end
end
end
cfg=cfgHelper.get1(cfg_lookupworldsceneryconfig_get,world)
if cfg then
for block,list in pairs(cfg)do
for index,id in ipairs(list)do
local config=cfgHelper.get1(cfg_worldsceneryconfig_get,id)
local state=worldBlockModel:getBlockState(world,block)
if config.state==nil or(bit.band(config.state,state)~=0)then
if worldSceneryModel:checkShowCondition(config.extraShow)then
worldSceneryController:createUnit(id)
end
end
end
end
end
end

function worldSceneryController:resumeMove()
local world=worldModel.world
local cfg=cfgHelper.get1(cfg_worldanimalconfig_get,world)
if cfg then
for i,v in ipairs(cfg.paths)do
local choose=self:extractMove(world,i)
if choose then
self:startMove(world,i,choose)
end
end
end
end

function worldSceneryController:stopMove()
for group,move in pairs(self.data)do
local members=move:GetMembers()
for i=1,#members do
worldController:popUnit(members[i].Key)
end
worldController:popMove(move.Key)
self.data[group]=nil
end
end

function worldSceneryController:extractMove(world,group)
local cfg=cfgHelper.get3(cfg_worldanimalconfig_get,world,"paths",group)
local cnt=#cfg
if cnt>0 then
local extract=math.random(1,cnt)

return extract
end
end

function worldSceneryController:startMove(world,group,index)
local cfg=cfgHelper.get3(cfg_worldanimalconfig_get,world,"paths",group)
local dataCfg=cfg[index]
local paths=dataCfg[2]
local members=dataCfg[1]


local offsets={}
local objects={}
for i,v in ipairs(members)do
local offset=mathHelper.convertArrayToVector(v[1])
local model=v[2]
table.insert(offsets,offset)
local modelSettings=worldModel:getModelSettings(model,worldModel.UNITTYPE.SCENERY)
local unitKey=worldSceneryModel:getAnimalKey(group,i)
worldController:pushUnit(unitKey,offset,
{worldModel.UNITTYPE.ANIMAL,group,i},modelSettings,nil,nil,false)

table.insert(objects,worldController:getUnit(unitKey))
end
local moveWays={}
for i,v in ipairs(paths)do
local startPoint=mathHelper.convertArrayToVector(v[1])
local endPoint=mathHelper.convertArrayToVector(v[2])
local speed=v[3]
local rotation=mathHelper.convertArrayToVector(v[4])
table.insert(moveWays,CS.WorldLineWay.New(startPoint,endPoint,rotation,speed,Vector3Int(0,worldDispatchFactory.flyAnimtion,0)))
end
local movePath={CS.WorldMovePath.New(moveWays,CS.WorldLoopType.Restart,1)}
local move=CS.WorldOffsetTeam.New(worldMoveModel:convertAnimalKey(group),movePath,objects,offsets)
move.onComplete=function(key,pass)self:onMoveComplete(world,group)end
worldController:pushMove(move)
self.data[group]=move
end

function worldSceneryController:onMoveComplete(world,group)
local move=self.data[group]
if move then
local members=move:GetMembers()
for i=1,#members do
worldController:popUnit(members[i].Key)
end
worldController:popMove(move.Key)
self.data[group]=nil
end

local choose=self:extractMove(world,group)
if choose then
self:startMove(world,group,choose)
end
end

function worldSceneryController.onClickScenery(args)
if(args and args[1]==worldModel.UNITTYPE.SCENERY)then
local id=args[2]
local cfg=cfgHelper.get1(cfg_worldsceneryconfig_get,id)
if cfg.func and _click[cfg.func]then
_click[cfg.func]()
end
end
end

function worldSceneryController:createUnit(id)
local unitType=eWorldUnitTpye.SCENERY
local config=cfgHelper.get1(cfg_worldsceneryconfig_get,id)
local unitKey=worldModel:convertUnitKey({unitType,id})
local modelSettings=worldModel:getModelSettings(config.modelRes,unitType)
local hudSetting=worldModel:getHUDSetting(config.hudRes)
local symbolSetting=worldModel:getSymbolSetting(config.symbolRes)
local position=#config.position==3 and mathHelper.convertArrayToVector(config.position)or worldPositionConfig:getPosition(config.worldId,config.position)
worldController:pushUnit(unitKey,position,{unitType,id},modelSettings,hudSetting,symbolSetting)

if config.flipX~=nil then
worldController:setUnitFlipX(unitKey,config.flipX)
end
end

function worldSceneryController:deleteUnit(id)
local unitType=eWorldUnitTpye.SCENERY
local unitKey=worldModel:convertUnitKey({unitType,id})
worldController:popUnit(unitKey)
end

function worldSceneryController.onWorldBlockDataChanged(world,block,state,oState)
if worldController:isInWorld()and worldModel:isSameWorld(world)then
local list=cfgHelper.get1(cfg_lookupworldsceneryconfig_get,world)
if list and list[block]then
list=list[block]
for i,v in ipairs(list)do
local cfg=cfgHelper.get1(cfg_worldsceneryconfig_get,v)
local o=cfg.state and(bit.band(cfg.state,oState)~=0)or true
local n=cfg.state and(bit.band(cfg.state,state)~=0)or true
if o~=n then
if n then
if worldSceneryModel:checkShowCondition(cfg.extraShow)then
worldSceneryController:createUnit(v)
end
else
worldSceneryController:deleteUnit(v)
end
end
end
end
end
end

function worldSceneryController.onSystemOpen(sysId)
if worldController:isInWorld()then
local world=worldModel.world
local blockList=cfgHelper.get1(cfg_lookupworldsceneryconfig_get,world)
for block,blockConfig in pairs(blockList)do
local blockState=worldBlockModel:getBlockState(world,block)
for index,id in ipairs(blockConfig)do
local config=cfgHelper.get1(cfg_worldsceneryconfig_get,id)
if config.state==nil or bit.band(config.state,blockState)~=0 then
if worldSceneryModel:checkHaveCondition(config.extraShow,1,sysId)then
if worldSceneryModel:checkShowCondition(config.extraShow)then
worldSceneryController:createUnit(id)
else
worldSceneryController:deleteUnit(id)
end
end
end
end
end
end
end

