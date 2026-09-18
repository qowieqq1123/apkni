









local xjEntity_MoJunRange={}


function xjEntity_MoJunRange:onInit()
local data=xianjieModel:getMoJunRange(self.data.seasonType,self.data.stageIndex)
self.pos=data:getWorldPos_1()
self.size=data:getWorldSize()
end


function xjEntity_MoJunRange:onCreateWidget(widget)

end


function xjEntity_MoJunRange:onRemoveWidget(widget)
self:showBlickEffect(false,widget)
end

function xjEntity_MoJunRange:onDelete()

end

function xjEntity_MoJunRange:showBlickEffect(show,widget)
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

return xjEntity_MoJunRange