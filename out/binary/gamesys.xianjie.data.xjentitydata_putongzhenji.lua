









local xjEntityData_PuTongZhenJi={}


function xjEntityData_PuTongZhenJi:onInit()
self.gridX=self.x
self.gridZ=self.y
self.x=nil
self.y=nil
local size=cfgHelper.get2(cfg_fairylandentitytypeconfig_get,self.entitytype,'size')
self.gridWidth=size[1]
self.gridHeight=size[2]
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)

self.gridState=xjMapGridStateType.eMoJingZhenJi_Normal
self.defaultSpeed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eMoJingZhenJi_Normal,1)
end

function xjEntityData_PuTongZhenJi:createEntity(needRefreshAOI)
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then
local args={
infoguid=self.infoguid,
}
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.ePuTongZhenJi,args,needRefreshAOI)
return true
end

return false
end

function xjEntityData_PuTongZhenJi:refreshData(d)

self.bufflistlen=d.bufflistlen or 0
self.buffList=d.buffList

self.useMoJing=d.useMoJing
end

function xjEntityData_PuTongZhenJi:getName()
local cfg=self:getCfg()
return cfg.name or"五行阵基"
end


function xjEntityData_PuTongZhenJi:onDelete()

end

function xjEntityData_PuTongZhenJi:getCfg()
local cfg=xianjieController:xjrzgetCfg_hj(self.entitytype,self.infoid)





return cfg
end

function xjEntityData_PuTongZhenJi:compareKey(guid)
return self.infoguid_str==tostring(guid)
end

function xjEntityData_PuTongZhenJi:getModelData()
local cfg=self:getCfg()
local info=cfg.sceneModel
local isFinish=false
local modelId=isFinish and info[2]or info[1]
local offset=cfg.sceneModelOffset
return modelId,offset
end

return xjEntityData_PuTongZhenJi
