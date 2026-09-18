
function isometricMapSystem:initFastBuildData()
self.fastBuildData={}
end

function isometricMapSystem:addFastBuildData(otype,cfgId,flip,pos,pCfgId)
table.insert(self.fastBuildData,{otype=otype,cfgId=cfgId,flip=flip,pos=pos,pCfgId=pCfgId})
end

function isometricMapSystem:reqFastBuild()
if#self.fastBuildData<1 then
return
end
self.currFastBuildData=table.remove(self.fastBuildData,1)
local sfId=zongmenModel:getMountainId()
local cfgId=self.currFastBuildData.cfgId
local pos=self.currFastBuildData.pos
local flip=self.currFastBuildData.flip
zongmenControl:reqBuild(sfId,cfgId,pos[1],pos[2],flip)
end

function isometricMapSystem:handleFastBuild(bdData)
local data=self.currFastBuildData
if not data then
return
end

local cfgId=data.cfgId
if cfgId~=bdData.build_id then
return
end

self.currFastBuildData=nil

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,cfgId)
local mdata=self:getModelByStatus(cfgId,1,0,planStatus.eDefault)
local bx=cfg.buid_size[1]
local by=cfg.buid_size[2]
local offset=self:countOffset(bx,by)
local spos=data.pos
local pos=_MapManager.ToVector3Int(spos[1],spos[2],spos[3])
local flip=false
if data.flip==1 then
flip=true
end
local mapId=zongmenModel:getMountainId()
local entity=isometricMapSystem:createBuildingEntity(data.otype,mapId,cfgId,mdata.model,mdata.slots,mdata.layer,true,flip,
mdata.scale,pos,offset,data.pCfgId)

return entity
end