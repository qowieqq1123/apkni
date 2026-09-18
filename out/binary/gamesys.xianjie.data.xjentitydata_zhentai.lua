









local xjEntityData_ZhenTai={}


function xjEntityData_ZhenTai:onInit()
local typeCfg=cfgHelper.get1(cfg_fairylandentitytypeconfig_get,xjServerEnityType.eClientBuild)
local cfg=self:getCfg()
self.sceneidx=xianjieController:getXJClientBuildSceneIndex(self.client_build_id)
self.gridX,self.gridZ,self.gridWidth,self.gridHeight=xianjieModel:getClientPositionAndSize(cfg.x,cfg.y,typeCfg.size[1],typeCfg.size[2],cfg.size[1],cfg.size[2])
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)
self.gridState=xjMapGridStateType.eZhenTai
end

function xjEntityData_ZhenTai:getCfg()
return cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.client_build_id)
end

function xjEntityData_ZhenTai:createEntity(needRefreshAOI)
if xianjienSceneIndexType:isMoJie(self.sceneidx)then
local isUnLockFog=xianjieController:checkMoJiePosOpenFog(self.sceneidx,self.gridX,self.gridZ)
if not isUnLockFog then
return
end
end
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then
local args={
seasonType=self.seasonType,
stageIndex=self.stageIndex,
build_id=self.build_id,
client_build_id=self.client_build_id,
}
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eZhenTai,args,needRefreshAOI)
end
end

function xjEntityData_ZhenTai:refreshData(d)
self.finish_cnt=d.finish_cnt
self.buff_begin_times=d.buff_begin_times
self.fix_finish_rw=d.fix_finish_rw
end


function xjEntityData_ZhenTai:onDelete()

end

function xjEntityData_ZhenTai:getName()
return self:getCfg().name
end

function xjEntityData_ZhenTai:getModelData()
local cfg=self:getCfg()
local node=xianjieModel:getZhenTaiNode(self.seasonType,self.stageIndex,self.build_id)
local modelSet=cfg.clientParam[node]
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

function xjEntityData_ZhenTai:getSelectEffect()
local cfg=self:getCfg()
return cfg.clientParam.selectEffect
end

return xjEntityData_ZhenTai