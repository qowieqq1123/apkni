









local xjEntity_emptyPos={}


function xjEntity_emptyPos:onInit()
self:initData()
end

function xjEntity_emptyPos:initData()
local data=self.data
self.pos=xianjieController:worldGridPos2WorldPos11(data[1],data[2],data[3],data[4])
local width,height=xianjieController:gridSize2WorldSize(data[3],data[4])
self.size=Vector2(width,height)
end

function xjEntity_emptyPos:refreshPos(gridX,gridZ)
self.data[1]=gridX
self.data[2]=gridZ
self:initData()
xianjieController:resetEntityPos(self:getKey(),self.pos)
end


function xjEntity_emptyPos:onCreateWidget(widget)
local effect=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'emptyPosEffect')
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local sortingLayer=helper.getSortingLayerID("Entity")
widget:SetChildShowEffectEx(0,effect[1],sortingLayer,entCfg.sortOrder-1,true)
local pos=effect[2]
widget:SetChildLocalPosition(0,Vector3(pos[1],pos[2],pos[3]))
local scale=effect[3]
widget:SetChildScale(0,Vector3(scale,scale,scale))
end


function xjEntity_emptyPos:onRemoveWidget(widget)
widget:SetChildShowEffect(0,0,false)
end

function xjEntity_emptyPos:onDelete()

end

return xjEntity_emptyPos