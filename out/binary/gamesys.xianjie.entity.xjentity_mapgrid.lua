









local xjEntity_mapGrid={}


function xjEntity_mapGrid:onInit()
self:initData()
end

function xjEntity_mapGrid:initData()
self.pos=Vector3(0,0,0)
local sceneidx=xianjieModel:getSceneIndex()
local size=xianjieModel:getMapSize3(sceneidx)
self.size=Vector2(size.x*2,size.y*2)
end


function xjEntity_mapGrid:onCreateWidget(widget)
local sceneidx=xianjieModel:getSceneIndex()
local ismj=xianjienSceneIndexType:isMoJie(sceneidx)
if ismj==true then
widget:SetChildActive(1,true)
else
widget:SetChildActive(0,true)
end
end


function xjEntity_mapGrid:onRemoveWidget(widget)
widget:SetChildActive(0,false)
widget:SetChildActive(1,false)
end

return xjEntity_mapGrid