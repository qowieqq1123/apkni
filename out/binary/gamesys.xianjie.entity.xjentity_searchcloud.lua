









local xjEntity_searchCloud={}


function xjEntity_searchCloud:onInit()
local data=self.data
self.cloudid=data[1]
self:initData()
end

function xjEntity_searchCloud:initData()
local cloudData=xianjieModel:getCloudData(self.cloudid)
self.pos=cloudData:getWorldPos()
self.size=Vector2(1,1)
end


function xjEntity_searchCloud:onCreateWidget(widget)

end


function xjEntity_searchCloud:onRemoveWidget(widget)

end

return xjEntity_searchCloud