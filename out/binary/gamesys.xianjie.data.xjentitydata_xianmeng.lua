









local xjEntityData_xianmeng={}


function xjEntityData_xianmeng:onInit()
self.gridX=self.x
self.gridZ=self.y
self.x=nil
self.y=nil
local size=cfgHelper.get2(cfg_fairylandentitytypeconfig_get,self.entitytype,'size')
self.gridWidth=size[1]
self.gridHeight=size[2]
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)

self.gridState=xjMapGridStateType.eXianMeng
local speedType=xianmengModel:isMyXM2(self.guildid)and xjServerMarchType.eDefendXianMeng or xjServerMarchType.eAttackXianMeng
self.defaultSpeed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",speedType,1)
end

function xjEntityData_xianmeng:compareKey(guid)
return self.guildid_str==tostring(guid)
end

function xjEntityData_xianmeng:refreshData(d)
self.gridX=d.x
self.gridZ=d.y
self.sceneidx=d.sceneidx
self.guildicon=d.guildicon
self.guildname=d.guildname
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)
end


function xjEntityData_xianmeng:getXianYuSceneIndex()
return self.ownersceneidx
end


function xjEntityData_xianmeng:getBornAreaID()
if xianjienSceneIndexType:isMoJie(self.sceneidx)then

return self.ownersceneidx
else
return 0
end
end

function xjEntityData_xianmeng:createEntity(needRefreshAOI)
if xianjienSceneIndexType:isMoJie(self.sceneidx)then
local canCreate=xianjieModel:getMoJieEnterConfig("guild")

if canCreate and xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eXianMeng,{self.guildid},needRefreshAOI)
end
end
end


function xjEntityData_xianmeng:onDelete()

end

return xjEntityData_xianmeng