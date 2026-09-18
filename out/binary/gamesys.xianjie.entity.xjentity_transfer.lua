









local xjEntity_transfer={}


function xjEntity_transfer:onInit()
local data=self.data
self.s_sceneidx=data[1]
self.e_sceneidx=data[2]
self:initData()
end

function xjEntity_transfer:initData()
local transferData=xianjieModel:getTransfer(self.s_sceneidx,self.e_sceneidx)
self.pos=transferData:getWorldPos()
self.size=transferData:getWorldSize()
end


function xjEntity_transfer:onCreateWidget(widget)
local transferData=xianjieModel:getTransfer(self.s_sceneidx,self.e_sceneidx)

local effect=transferData.effectCfg
local showEffect=effect~=nil
if showEffect then
self.showEffect=true
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local sortingLayer=helper.getSortingLayerID("Entity")
widget:SetChildShowEffectEx(0,effect[1],sortingLayer,entCfg.sortOrder,true)
local pos=effect[4]
widget:SetChildLocalPosition(0,Vector3(pos[1],pos[2],pos[3]))
local scale=effect[2]
widget:SetChildScale(0,Vector3(scale,1,scale))
local rot=effect[3]
widget:SetChildRotation(0,rot[1],rot[2],rot[3])
end
end


function xjEntity_transfer:onRemoveWidget(widget)
if self.showEffect then
self.showEffect=nil
widget:SetChildShowEffect(0,0,false)
end
end

return xjEntity_transfer