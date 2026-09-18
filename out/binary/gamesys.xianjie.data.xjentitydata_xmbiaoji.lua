









local xjEntityData_XMBiaoJi={}


function xjEntityData_XMBiaoJi:onInit()
self.entityType=xjServerEnityType.eClientBuild
self.name="xjEntityData_XMBiaoJi"
self.BJkeyId=self.keyId
self.BJkeys={self.bj_x,self.bj_y,self.bj_sceneidx}
self.BJcbId=self.bj_cbid or-22
self.BJiconId=self.bj_iconid or 1
self.BJcontent=self.bj_content or"暂无数据显示"

local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,self.BJcbId)
local cfg_clientParam=cfg.clientParam or{}
local size=cfg_clientParam.size or{1,1}

self.gridX=self.bj_x
self.gridZ=self.bj_y
self.sceneidx=self.bj_sceneidx
self.gridWidth=size[1]
self.gridHeight=size[1]
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)

self.gridState=xjMapGridStateType.eBiaoji
end

function xjEntityData_XMBiaoJi:getCfg()
return
end

function xjEntityData_XMBiaoJi:createEntity(needRefreshAOI)
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then
local data=
{
keyId=self.BJkeyId,
bj_x=self.BJkeys[1],
bj_y=self.BJkeys[2],
bj_sceneidx=self.BJkeys[3],
bj_cbid=self.BJcbId,
bj_iconid=self.BJiconId,
bj_content=self.BJcontent,
}
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eXMBiaoJi,data,needRefreshAOI)
return true
end
return false
end


function xjEntityData_XMBiaoJi:onDelete()

end


function xjEntityData_XMBiaoJi:getModelData()
local cfg=self:getCfg()
local modelSet=cfg.modelSet
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

return xjEntityData_XMBiaoJi