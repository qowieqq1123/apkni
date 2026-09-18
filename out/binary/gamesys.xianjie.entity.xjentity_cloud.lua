









local xjEntity_cloud={}


function xjEntity_cloud:onInit()
local data=self.data
self.cloudid=data[1]
self:initData()
end

function xjEntity_cloud:initData()
local cloudEntData=xianjieModel:getCloudEntityData(self.cloudid)
self.pos=cloudEntData:getWorldPos()
self.size=cloudEntData:getWorldSize()
end


function xjEntity_cloud:refreshInfo()
self:invokeEntityHudFunc('refreshIcon')
end


function xjEntity_cloud:onCreateWidget(widget)

local effect=cfgHelper.get2(cfg_fairylandcloudconfig_get,self.cloudid,'effect')
local showEffect=effect~=nil
if showEffect then
self.showEffect=showEffect
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local sortingLayer=helper.getSortingLayerID("Entity")
widget:SetChildShowEffectEx(0,effect[1],sortingLayer,entCfg.sortOrder-1,true)
local pos=effect[2]
widget:SetChildLocalPosition(0,Vector3(pos[1],pos[2],pos[3]))
local scale=effect[3]
widget:SetChildScale(0,Vector3(scale,1,scale))
end
end


function xjEntity_cloud:onRemoveWidget(widget)
if self.showEffect then
self.showEffect=nil
widget:SetChildShowEffect(0,0,false)
end
end

return xjEntity_cloud