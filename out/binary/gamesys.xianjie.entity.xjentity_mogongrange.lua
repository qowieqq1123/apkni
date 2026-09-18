









local xjEntity_MoGongRange={}


function xjEntity_MoGongRange:onInit()
local data=xianjieModel:getMoGongRangeDataByMoGongId(self.data.moGongId)
self.pos=data:getWorldPos_1()
self.size=data:getWorldSize()
end


function xjEntity_MoGongRange:onCreateWidget(widget)

end


function xjEntity_MoGongRange:onRemoveWidget(widget)
self:showBlickEffect(false,widget)
end

function xjEntity_MoGongRange:onDelete()

end

function xjEntity_MoGongRange:showBlickEffect(show,widget)
widget=widget or self:getWidget()
if widget then
if show then
local config=cfgHelper.get(cfg_mogongzhengduobaseconfig_get,1,'rangeEffect')
widget:SetChildShowEffect(0,config[1],true)
widget:SetChildScale(0,Vector3.New(config[2][1],config[2][2],config[2][3]))
else
widget:SetChildShowEffect(0,-1,false)
end
end
end

return xjEntity_MoGongRange