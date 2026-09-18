









local xjEntity_ZhenTaiRange={}


function xjEntity_ZhenTaiRange:onInit()
local data=xianjieModel:getZhenTaiRange(self.data.seasonType,self.data.stageIndex,self.data.build_id)
self.pos=data:getWorldPos_1()
self.size=data:getWorldSize()
end


function xjEntity_ZhenTaiRange:onCreateWidget(widget)

end


function xjEntity_ZhenTaiRange:onRemoveWidget(widget)
self:showBlickEffect(false,widget)
end

function xjEntity_ZhenTaiRange:onDelete()

end

function xjEntity_ZhenTaiRange:showBlickEffect(show,widget)
widget=widget or self:getWidget()
if widget then
if show then
local config=seasonModel:getStageConfigEx(self.data.seasonType,self.data.stageIndex,"rangeEffect")
widget:SetChildShowEffect(0,config[1],true)
widget:SetChildScale(0,Vector3.New(config[2][1],config[2][2],config[2][3]))
else
widget:SetChildShowEffect(0,-1,false)
end
end
end

return xjEntity_ZhenTaiRange