









local xjEntity_XianMengEffect={}


function xjEntity_XianMengEffect:onInit()
local data=xianjieModel:getXianMengEffectData()
self.pos=data:getWorldPos_1()
self.size=data:getWorldSize()
end


function xjEntity_XianMengEffect:onCreateWidget(widget)
self:refreshXMEffect(widget)
end


function xjEntity_XianMengEffect:onRemoveWidget(widget)
widget:SetChildShowEffect(0,-1,false)
self.effectId=nil
end

function xjEntity_XianMengEffect:onUpdate()
local widget=self:getWidget()
if widget and self.needUpdate then
local nowTime=timeHelper.getServerShortTime()
if nowTime>=finishTime then
self:refreshXMEffect(widget)
end
end
end

function xjEntity_XianMengEffect:refreshInfo()
self:refreshPos()
self:refreshXMEffect()
end

function xjEntity_XianMengEffect:onDelete()

end

function xjEntity_XianMengEffect:refreshXMEffect(widget)
widget=widget or self:getWidget()
local data=xianjieModel:getXianMengEffectData()
local config=cfgHelper.get1(cfg_devildomdazhenconfig_get,data.lv)
local nowTime=timeHelper.getServerShortTime()
if data.shield>0 then
local finishTime=data.sec+math.floor((config.shield-data.shield)/config.recover[2])*config.recover[1]
self:changeXMEffect(widget,config.showEffect[1])
self.needUpdate=nowTime<finishTime and finishTime or nil
else
local finishTime=data.sec+config.fix
self:changeXMEffect(widget,config.showEffect[nowTime>=finishTime and 1 or 2])
self.needUpdate=nowTime<finishTime and finishTime or nil
end
end

function xjEntity_XianMengEffect:changeXMEffect(widget,effectId)
if widget then
if self.effectId~=effectId then
widget:SetChildShowEffect(0,effectId,true)
self.effectId=effectId
end
else
self.effectId=nil
end
end

function xjEntity_XianMengEffect:refreshPos()
local data=xianjieModel:getXianMengEffectData()
self.pos=data:getWorldPos_1()
self.size=data:getWorldSize()
xianjieController:resetEntityPos(self:getKey(),self.pos)
end

return xjEntity_XianMengEffect