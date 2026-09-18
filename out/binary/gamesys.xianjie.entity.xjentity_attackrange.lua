









local xjEntity_AttackRange={}


function xjEntity_AttackRange:onInit()
self.pos=self.data.pos
self.size=self.data.size
self.width=self.data.width
self.height=self.data.height
end


function xjEntity_AttackRange:onSelectHandle(widget,isSelect)

end


function xjEntity_AttackRange:onCreateWidget(widget)
if not widget then
return
end
local _sX=25
local _sY=25

widget:SetChildActive(0,true)
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local sortingLayerName='Entity'
local sortingOrder=entCfg.sortOrder
widget:SetChildSpriteRendererSortingLayer(0,sortingLayerName,sortingOrder-1)
widget:SetChildScale(0,Vector3.New(_sX*self.width,_sY*self.height,0))
end


function xjEntity_AttackRange:onRemoveWidget(widget)
if not widget then
return
end
widget:SetChildActive(0,false)
end


function xjEntity_AttackRange:onMyClick(boxParams)

end

function xjEntity_AttackRange:chanegeBossAmiState(animId)

end

function xjEntity_AttackRange:onDelete()

end

return xjEntity_AttackRange