









local xjEntity_MoJunFenShen={}


function xjEntity_MoJunFenShen:onInit()
local data=xianjieModel:getMoJunFenShenData(self.data.infoguid)
self.pos=data:getWorldPos_1()
self.size=data:getWorldSize()
self.allowClickGrid=false
end


function xjEntity_MoJunFenShen:onSelectHandle(widget,isSelect)
end


function xjEntity_MoJunFenShen:onCreateWidget(widget)
end


function xjEntity_MoJunFenShen:onRemoveWidget(widget)

end


function xjEntity_MoJunFenShen:onMyClick(boxParams)

end

function xjEntity_MoJunFenShen:onDelete()

end


return xjEntity_MoJunFenShen