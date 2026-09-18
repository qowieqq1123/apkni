









local xjEntity_RPCtCollectible={}


function xjEntity_RPCtCollectible:onInit()
self.dataGuid=self.data.guid
local data=xianjieModel:getResPointData(self.dataGuid)
self.pos=data:getWorldPos_1()
self.size=data:getWorldSize()
self.allowClickGrid=true
local cfg=data:getCfg()
self.ent_name=cfg.name
self.cfgselectEffect=cfg.selectEffect
self.canSelect=true
end


function xjEntity_RPCtCollectible:onCreateWidget(widget)






























end


function xjEntity_RPCtCollectible:onRemoveWidget(widget)

if self.dead then
xianjieController:removeEntity(self:getKey())
end
end


function xjEntity_RPCtCollectible:onSelectHandle(widget,isSelect)

if not widget then
self.selectEffect=nil
return
end
if isSelect then
if self.selectEffect==nil then

local effect=self.cfgselectEffect or{10758,{0,0,0},1}
if effect then
self.selectEffect=effect[1]
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local sortingLayer=helper.getSortingLayerID("Entity")
widget:SetChildShowEffectEx(2,self.selectEffect,sortingLayer,entCfg.sortOrder-1,true)
local pos=effect[2]
widget:SetChildLocalPosition(2,Vector3(pos[1],pos[2],pos[3]))
local scale=effect[3]
widget:SetChildScale(2,Vector3(scale,scale,scale))
end
end
else
if self.selectEffect then
self.selectEffect=nil
widget:SetChildShowEffect(2,0,false)
end
end
end

function xjEntity_RPCtCollectible:onMyClick(boxParams)

end

function xjEntity_RPCtCollectible:refreshInfo()
local hud=self:getHud()
if hud and hud.refreshInfo then
hud:refreshInfo()
end
end



















































































function xjEntity_RPCtCollectible:checkLogicShow()
local data=xianjieModel:getResPointData(self.dataGuid)
if data.source.srctype==xjResPointSourceType.ePlot then
return not xianjieController:checkCloudUnlockAnim(data.source.cloudid)
end
return true
end


return xjEntity_RPCtCollectible