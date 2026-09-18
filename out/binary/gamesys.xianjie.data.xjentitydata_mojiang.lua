









local xjEntityData_MoJiang={}


function xjEntityData_MoJiang:onInit()
local typeCfg=cfgHelper.get1(cfg_fairylandentitytypeconfig_get,xjServerEnityType.eClientBuild)
local cfg=self:getCfg()
self.sceneidx=xianjieController:getXJClientBuildSceneIndex(self.build_id)
self.gridX,self.gridZ,self.gridWidth,self.gridHeight=xianjieModel:getClientPositionAndSize(cfg.x,cfg.y,typeCfg.size[1],typeCfg.size[2],cfg.size[1],cfg.size[2])
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)
self.gridState=xjMapGridStateType.eMoJiang
self.defaultSpeed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eKillBossMonster,1)
self:refreshStage()
end

function xjEntityData_MoJiang:getCfg()
return cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.build_id)
end

function xjEntityData_MoJiang:createEntity(needRefreshAOI)
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then
local args={
seasonType=self.seasonType,
stageIndex=self.stageIndex,
build_id=self.build_id,
}
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eMoJiang,args,needRefreshAOI)
end
end

function xjEntityData_MoJiang:refreshData(d)
self.hp=d.hp
self.killTime=d.killTime
self.bestGuild=d.bestGuild
self.bestPlayer=d.bestPlayer
self.damage=d.damage
self.damageFlag=d.damageFlag
self.fightTimes=d.fightTimes
self.fighted=d.fighted,
self:refreshStage()
end


function xjEntityData_MoJiang:onDelete()

end

function xjEntityData_MoJiang:getName()
return self:getCfg().name
end

function xjEntityData_MoJiang:getModelData()
local cfg=self:getCfg()
local modelSet=cfg.clientParam.modelSet
local body=modelSet.model
local componets=modelSet.components or{}
local scale=modelSet.scale or 1
local flip=modelSet.flip==1
local offset=modelSet.offset and mathHelper.convertArrayToVector(modelSet.offset)or Vector3.zero
local mount=modelSet.mount
local effect=modelSet.effect
local slotInfo=nil
if modelSet.replaceSlot and modelSet.replaceIcon then
slotInfo={modelSet.replaceSlot,modelSet.replaceIcon}
end
return body,componets,scale,flip,offset,slotInfo,mount,effect
end

function xjEntityData_MoJiang:getSelectEffect()
local cfg=self:getCfg()
return cfg.clientParam.modelSet.selectEffect
end

function xjEntityData_MoJiang:checkRewardReddot()
return self:checkRankReddot()or self:checkDailyReddot()
end

function xjEntityData_MoJiang:checkRankReddot()
local config=seasonModel:getStageConfigEx(self.seasonType,self.stageIndex,"mojiang",self.build_id)
for i,v in ipairs(config.damage)do
if self.damageFlag<i and self.damage>=v[1]then
return true
end
end
return false
end

function xjEntityData_MoJiang:getDailyRewardTarget()
local seasonStage=seasonModel:getStage(self.seasonType,self.stageIndex)
local config=seasonModel:getStageConfigEx(self.seasonType,self.stageIndex,"mojiang",self.build_id)
local deltaDay=config.grade[2]/86400
if seasonStage and seasonStage.beginTime>0 then
local nowTime=timeHelper.getServerShortTime()
local openTime=seasonStage.beginTime+config.open
if nowTime>openTime then
local openZero=timeHelper.getServerZeroShortStamp(openTime)
local limitActInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eMoJiang)
if self.killTime>0 then
local max=math.ceil((self.killTime-openZero)/86400)
local temp=timeHelper.checkInSameDay2(self.killTime,limitActInfo.start_time)and timeHelper.checkInSameDay2(self.killTime,nowTime)and-1 or 0
return max+temp
else
local max=math.ceil((nowTime-openZero)/86400)
local temp=nowTime<limitActInfo.start_time and not timeHelper.checkInSameDay2(nowTime,limitActInfo.start_time)and 0 or-1
return max+temp
end
end
end
return-1
end

function xjEntityData_MoJiang:checkDailyReddot()
local seasonStage=seasonModel:getStage(self.seasonType,self.stageIndex)
local config=seasonModel:getStageConfigEx(self.seasonType,self.stageIndex,"mojiang",self.build_id)
local openTime=seasonStage.beginTime+config.open
local openZero=timeHelper.getServerZeroShortStamp(openTime)
local limitActInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eMoJiang)
local limitActEndZero=timeHelper.getServerZeroShortStamp(limitActInfo.end_time)
local tempB=(openTime-openZero)<(limitActInfo.end_time-limitActEndZero)and 1 or 2
return(self.dailyFlag+tempB)<=self:getDailyRewardTarget()
end

function xjEntityData_MoJiang:refreshStage()
local seasonStage=seasonModel:getStage(self.seasonType,self.stageIndex)
local config=seasonModel:getStageConfigEx(self.seasonType,self.stageIndex,"mojiang",self.build_id)
if seasonStage and seasonStage.beginTime>0 then
local nowTime=timeHelper.getServerShortTime()
local openTime=seasonStage.beginTime+config.open
if nowTime>openTime then
local temp=math.floor(((self.killTime>0 and self.killTime or nowTime)-openTime)/config.grade[2])
self.stage=math.max(config.grade[1]-temp,1)
self.monster_id=config.monster[self.stage]
return
end
end
self.stage=config.grade[1]
self.monster_id=config.monster[self.stage]
end

function xjEntityData_MoJiang:getDailyRewardStage()
local seasonStage=seasonModel:getStage(self.seasonType,self.stageIndex)
local config=seasonModel:getStageConfigEx(self.seasonType,self.stageIndex,"mojiang",self.build_id)
local deltaDay=config.grade[2]/86400
if seasonStage and seasonStage.beginTime>0 then
local nowTime=timeHelper.getServerShortTime()
local openTime=seasonStage.beginTime+config.open
if nowTime>openTime then
local openZero=timeHelper.getServerZeroShortStamp(openTime)
local limitActInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eMoJiang)
local stages={}
local limitActEndZero=timeHelper.getServerZeroShortStamp(limitActInfo.end_time)
local tempB=(openTime-openZero)<(limitActInfo.end_time-limitActEndZero)and 1 or 2
if self.killTime>0 then
local max=math.ceil((self.killTime-openZero)/86400)
local tempE=timeHelper.checkInSameDay2(self.killTime,limitActInfo.start_time)and timeHelper.checkInSameDay2(self.killTime,nowTime)and-1 or 0
for i=self.dailyFlag+tempB,max+tempE do
local stage=config.grade[1]-math.floor(i-1/deltaDay)
stage=math.max(stage,1)
table.insert(stages,{stage,i==max})
end
else
local max=math.ceil((nowTime-openZero)/86400)
local tempE=nowTime<limitActInfo.start_time and not timeHelper.checkInSameDay2(nowTime,limitActInfo.start_time)and 0 or-1
for i=self.dailyFlag+tempB,max+tempE do
local stage=config.grade[1]-math.floor(i-1/deltaDay)
stage=math.max(stage,1)
table.insert(stages,{stage,false})
end
end
return stages
end
end
return defaultT
end

return xjEntityData_MoJiang