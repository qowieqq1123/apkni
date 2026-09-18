






local _MODULENAME="worldUnitModel"




def_table(_MODULENAME)
worldUnitModel.name=_MODULENAME



worldUnitModel.data={}
worldUnitModel.enable=true
worldUnitModel.count=0

local dead_fade_time=2
local drop_info=nil

local _animation_list={
eWorldUnitTpye.MYSTERY,
eWorldUnitTpye.MONSTER,
eWorldUnitTpye.RESPOINT,
eWorldUnitTpye.FAMILY,
}

local _animation_spe={
[eWorldUnitTpye.RESPOINT]="speResPoint",
[eWorldUnitTpye.MONSTER]="speMonster",
}



function worldUnitModel:onAppStart()
drop_info=cfgHelper.get2(cfg_worldglobalconfig_get,"resPointDropEffect","value")
end


function worldUnitModel:onEnterState()

end


function worldUnitModel:onLeaveState(isReconnet)

self:clearData()
worldUnitModel.enable=true
end


function worldUnitModel:onServerDataInitFinish()

end

function worldUnitModel:checkUnitType(unitType)
for i,v in ipairs(_animation_list)do
if v==unitType then
return true
end
end
return false
end

function worldUnitModel:showUnit(unitKey,data)
local keys=worldModel:separateUnitKey(unitKey)
local unitType=tonumber(keys[1])

if self.enable or not self:checkUnitType(unitType)then
local manager=worldController:getManager()
manager:PushData(data)
self:doAnimationSpe()

if api_Available_SetUnitModelFreeze()then
local freeze=worldController:getSpecailHeightLineOver(eWorldSpecialHeightLineType.eFreezeUnitAnimation)
manager:SetUnitModelFreeze(unitKey,freeze)
end
else
self:saveData(unitKey,data)
end
end

function worldUnitModel:saveData(unitKey,data)

self.data[unitKey]=data
self.count=self.count+1
end

function worldUnitModel:getData(unitKey)
return self.data[unitKey]
end

function worldUnitModel:containData(unitKey)
return self:getData(unitKey)~=nil
end

function worldUnitModel:emptyData(unitKey)
self.data[unitKey]=nil
self.count=self.count-1
end

function worldUnitModel:clearData()
self.data={}
self.count=0
end

function worldUnitModel:resumeUnit(unitKey)

local data=self:getData(unitKey)
if data then
local manager=worldController:getManager()
manager:PushData(data)

if api_Available_SetUnitModelFreeze()then
local freeze=worldController:getSpecailHeightLineOver(eWorldSpecialHeightLineType.eFreezeUnitAnimation)
manager:SetUnitModelFreeze(unitKey,freeze)
end
end
end

function worldUnitModel:resumeType(typo)

local keys={}
for i,v in pairs(self.data)do
local infos=worldModel:separateUnitKey(i)
if tonumber(infos[1])==typo then
local manager=worldController:getManager()
manager:PushData(v)
table.insert(keys,i)

if api_Available_SetUnitModelFreeze()then
local freeze=worldController:getSpecailHeightLineOver(eWorldSpecialHeightLineType.eFreezeUnitAnimation)
manager:SetUnitModelFreeze(i,freeze)
end
end
end
for i,v in ipairs(keys)do
worldUnitModel:emptyData(v)
end
return keys
end

function worldUnitModel:resumeAll(callback)
for i,v in pairs(self.data)do
local manager=worldController:getManager()
manager:PushData(v)
if callback then
callback(i,v)
end

if api_Available_SetUnitModelFreeze()then
local freeze=worldController:getSpecailHeightLineOver(eWorldSpecialHeightLineType.eFreezeUnitAnimation)
manager:SetUnitModelFreeze(i,freeze)
end
end
self:clearData()
end

function worldUnitModel:getAnimationType(index)
return _animation_list[index]
end

function worldUnitModel:doAnimationSpe(typo,unitKey)
local func=self[_animation_spe[typo]]
if func then
return func(unitKey)
end
end

function worldUnitModel.speResPoint(unitKey)
local data=worldController:getUnit(unitKey)
if data then
local luaData=data.LuaData
local guid=luaData[2]
local subIdx=luaData[3]
local dataType=luaData[4]
local dataId=luaData[5]
local flip=luaData[6]
if dataType==eWorldResPointUnitType.Monster then
local dataCfg=cfgHelper.get1(cfg_worldresbattleconfig_get,dataId)
local patrolInfo=dataCfg.patrol
if patrolInfo then
worldMoveModel:wanderGuardianMove(unitKey,unitKey,data.Position,patrolInfo[1],patrolInfo[2],patrolInfo[2]>0)
end
elseif dataType==eWorldResPointUnitType.Collection then
local dataCfg=cfgHelper.get1(cfg_worldrescollectionconfig_get,dataId)
if dataCfg.effects then
for i,v in ipairs(dataCfg.effects)do

worldController:playModelEffect(unitKey,v[1],Vector3.zero,Vector3.one*(v[2]or 1),nil,false)
end
end
local slotHUD=dataCfg.slothud
if slotHUD then
worldController:setModelSlotIcon(unitKey,slotHUD.slotName,slotHUD.icon)
worldController:setModelScale(unitKey,slotHUD.scale or 1)
worldController:setAnimation(unitKey,-1)



end
elseif dataType==eWorldResPointUnitType.Story then
local dataCfg=cfgHelper.get1(cfg_worldresstoryconfig_get,dataId)
if dataCfg.anim then
worldController:setAnimation(unitKey,dataCfg.anim)
end
end
worldController:setModelShadow(unitKey,true)
worldController:setUnitFlipX(unitKey,flip~=false)
end
end

function worldUnitModel.speMonster(unitKey)
local data=worldController:getUnit(unitKey)
if data then
local keys=worldModel:separateUnitKey(unitKey)
local posId=keys[2]
local monster=worldMonsterModel:get_monster_by_posId(posId)
if monster then
local monsterCfg=worldMonsterModel.get_monster_group_config(monster.worldMonsterId)
if monsterCfg.patrolInfo then

worldMoveModel:wanderGuardianMove(unitKey,unitKey,data.Position,monsterCfg.patrolInfo[1],monsterCfg.patrolInfo[2])
end
worldController:setModelShadow(unitKey,true)
worldController:setUnitFlipX(unitKey,monster.flipX)
end
end
end

function worldUnitModel:unitDead(unitKey,drops,callback)
local hudObj=worldHUDModel:getHUD(unitKey)
local dropTime=0
local rewardsCnt=drops and#drops or 0
local dropCallback=dropTime>dead_fade_time and callback or nil
local deadCallback=dropTime<=dead_fade_time and callback or nil
if hudObj then
dropTime=hudObj:getDropTime(rewardsCnt)
hudObj:dropItem(rewardsCnt,drops,drop_info[1],drop_info[2],dropCallback)
end

worldController:freezeAnimation(unitKey,entityStateID.hit,0.5)
worldController:changeModelColor(unitKey,
Color.clear,dead_fade_time,deadCallback)
end

function worldUnitModel:unitAttack(unitKey,duration,callback)
local object=worldController:getUnit(unitKey)
if object then
local ways={CS.WorldWaitWay.New(object.Position,duration,
Vector3Int(0,entityStateID.attak1,0))}
local path={CS.WorldMovePath.New(ways,CS.WorldLoopType.Restart,1)}
local moveKey=unitKey
local move=CS.WorldSingelTeam.New(moveKey,path,object)
move.onComplete=function()
worldController:popMove(moveKey)
if callback then
callback()
end
end
worldController:pushMove(move)
end
end

function worldUnitModel:unitEmot(unitKey,emot,cd,callback)
local hudObj=worldHUDModel:getHUD(unitKey)
if hudObj and hudObj.showEmot then
hudObj:showEmot(emot,cd,callback)
else

if callback then
callback()
end
end
end

function worldUnitModel:unitAppear(unitKey,callback)
worldController:changeModelColor(unitKey,Color.clear,0)
worldController:changeModelColor(unitKey,Color.white,1,callback)
worldController:playModelEffect(unitKey,3)
end


function worldUnitModel:getZongMenModelRes()
local modelCfg=cfg_guildworldmodelconfig()
local zongmenLevel=zongmenModel:getLevel()
local shaneValue=UISectPalaceModel:getShanEValue()

local checkZongmenLevel=false
local checkShaneValue=false

for id,config in pairs(modelCfg)do
checkZongmenLevel=zongmenLevel>=config.level[1]and zongmenLevel<=config.level[2]
checkShaneValue=shaneValue>=config.shane[1]and shaneValue<=config.shane[2]

if checkZongmenLevel and checkShaneValue then
return id
end
end

local defaultModelRes=cfgHelper.get(cfg_worldsceneryconfig_get,1,"modelRes")
return defaultModelRes
end