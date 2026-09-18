









local xjEntity_MoJunEffectRange={}


function xjEntity_MoJunEffectRange:onInit()
local data=xianjieModel:getMoJunEffectRange(self.data.seasonType,self.data.stageIndex,self.data.idx)
self.pos=data:getWorldPos_1()
self.size=data:getWorldSize()

self:showEffect(true)
end


function xjEntity_MoJunEffectRange:onCreateWidget(widget)
self:showEffect(true,widget)
end

function xjEntity_MoJunEffectRange:refreshInfo()

end


function xjEntity_MoJunEffectRange:onRemoveWidget(widget)
self:showEffect(false,widget)
end

function xjEntity_MoJunEffectRange:onDelete()

end

function xjEntity_MoJunEffectRange:showEffect(show,widget)
widget=widget or self:getWidget()
if widget then
if show then
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local sortingLayer=helper.getSortingLayerID("Entity")
local config=cfgHelper.get2(cfg_seasonmojuneffectconfig_get,self.data.confid,"rangeEffect")
widget:SetChildShowEffect(0,config[1],true)
widget:SetChildShowEffectEx(0,config[1],sortingLayer,entCfg.sortOrder-1,true)
widget:SetChildScale(0,Vector3.New(config[2][1],config[2][2],config[2][3]))

xianjieModel:playMoJunZMEffect(self.data.idx)









else
widget:SetChildShowEffect(0,-1,false)
widget:SetChildActive(1,false)
end
end
if not show and self.data then
xianjieModel:stopMoJunZMEffect(self.data.areaId)
end
end

return xjEntity_MoJunEffectRange
