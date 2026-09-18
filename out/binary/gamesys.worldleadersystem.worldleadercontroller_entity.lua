local fightCount=0

function worldLeaderController:startAI()
local args={
stateId=0,
}
self.bt=behaviorManager:addBehaviorTree("bw_worldleader",nil,true,args)
end

function worldLeaderController:stopAI()
if self.bt then

behaviorManager:removeBehaviorTree(self.bt)
end
end

function worldLeaderController:showBossUnit()
local monsterIdx=worldLeaderModel:getMonsterIdx()
local stageIdx=worldLeaderModel:getStageIdx()
local cfg=cfgHelper.get1(cfg_worldbossconfig_get,1)
local modelcfg=cfg.model
local modelId=modelcfg[monsterIdx][stageIdx]

local position=worldPositionConfig:getPosition(cfg.world,cfg.position)

local unitKey="8_0_0"
local modelSettings=worldModel:getModelSettings(modelId,eWorldUnitTpye.WORLDLEADER)
local hudSettings=worldModel:getHUDSetting(cfg.hud)
local sysmbolSettting=worldModel:getSymbolSetting(cfg.symbol)
local data={eWorldUnitTpye.WORLDLEADER,0,0}
worldController:pushUnit(unitKey,position,data,modelSettings,hudSettings,sysmbolSettting)
end

function worldLeaderController:hideBossUnit()
local unitKey="8_0_0"
worldController:popUnit(unitKey)
end

function worldLeaderController:showDiscipleUnits()
local cfg=cfgHelper.get1(cfg_worldbossconfig_get,1)
for i=1,2 do
for j=1,5 do
local data={eWorldUnitTpye.WORLDLEADER,i,j}
local unitKey=worldModel:convertUnitKey(data)
local modelId=nil
local modelSettings=worldModel:getModelSettings(modelId,eWorldUnitTpye.WORLDLEADER)
local hudSettings=j==1 and worldModel:getHUDSetting(cfg.hud2)or nil
local sysmbolSettting=nil
worldController:pushUnit(unitKey,Vector3.zero,data,modelSettings,hudSettings,sysmbolSettting)
worldController:showUnitModel(unitKey,false)
end
end
end

function worldLeaderController:hideDiscipleUnits()
local cfg=cfgHelper.get1(cfg_worldbossconfig_get,1)
for i=1,2 do
for j=1,5 do
local data={eWorldUnitTpye.WORLDLEADER,i,j}
local unitKey=worldModel:convertUnitKey(data)
worldController:popUnit(unitKey)
end
end
end

function worldLeaderController:addFightCount()
if fightCount<=0 then
worldController:setAnimation("8_0_0",1010)
end
fightCount=fightCount+1
end

function worldLeaderController:delFightCount()
fightCount=fightCount-1
if fightCount<=0 then
worldController:setAnimation("8_0_0",0)
end
end

function worldLeaderController:randomDiscipleModel(team,index)
local cfg=cfgHelper.get1(cfg_worldbossconfig_get,1)
local data={eWorldUnitTpye.WORLDLEADER,team,index}
local unitKey=worldModel:convertUnitKey(data)
local modelId=cfg.npc[math.random(1,#cfg.npc)]
local modelSettings=worldModel:getModelSettings(modelId,eWorldUnitTpye.WORLDLEADER)
worldController:changeUnitModel(unitKey,modelSettings)
end
