









local xjEntity_MoJunTiaoZhanRange={}


function xjEntity_MoJunTiaoZhanRange:onInit()
local data=xianjieModel:getMoJunTiaoZhanRange(self.data.seasonType,self.data.stageIndex)
self.pos=data:getWorldPos_1()
self.size=data:getWorldSize()


self:showBlickEffect(true)
end


function xjEntity_MoJunTiaoZhanRange:onCreateWidget(widget)
self:showBlickEffect(true,widget)

end


function xjEntity_MoJunTiaoZhanRange:onRemoveWidget(widget)
self:showBlickEffect(false,widget)
end

function xjEntity_MoJunTiaoZhanRange:onDelete()

end

function xjEntity_MoJunTiaoZhanRange:showBlickEffect(show,widget)
widget=widget or self:getWidget()
if widget then
if show then
local twodata=self.data.twodata
local ex_effectid
if twodata then

ex_effectid=twodata.ex_effectid
end
if ex_effectid then
local ex_pos=twodata.ex_pos or{0,0,0}
local ex_rotation=twodata.ex_rotation or{0,0,0}
local ex_confid=twodata.ex_confid or 1
local ex_scale=twodata.ex_scale or{1,1,1}
local ex_isex=twodata.ex_isex

local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,XJ_ENTITY_TYPE.eMoJun)
local sortingLayer=helper.getSortingLayerID("Entity")
local config=cfgHelper.get2(cfg_seasonmojuneffectconfig_get,ex_confid,"rangeEffect")
widget:SetChildShowEffect(0,ex_effectid,true)
widget:SetChildShowEffectEx(0,ex_effectid,sortingLayer,entCfg.sortOrder-1,true)
widget:SetChildScale(0,Vector3.New(config[2][1],config[2][2],config[2][3]))
widget:SetChildLocalPosition(0,Vector3(ex_pos[1],ex_pos[2],ex_pos[3]))
widget:SetChildRotation(0,ex_rotation[1],ex_rotation[2],ex_rotation[3])
widget:SetChildScale(0,Vector3.New(ex_scale[1],ex_scale[2],ex_scale[3]))
else
local config=seasonModel:getStageConfigEx(self.data.seasonType,self.data.stageIndex,"tzRangeEffect")
widget:SetChildLocalPosition(0,Vector3(0,0,0))
widget:SetChildShowEffect(0,config[1],true)
widget:SetChildRotation(0,0,0,0)
widget:SetChildScale(0,Vector3.New(config[2][1],config[2][2],config[2][3]))
end
else
widget:SetChildShowEffect(0,-1,false)
end
end
end

function xjEntity_MoJunTiaoZhanRange:showZhanFaEffect(ex_effectid)
local widget=self:getWidget()
if widget==nil then return end
local twodata=self.data.twodata
if twodata then
widget:SetChildShowEffect(0,ex_effectid,true)
end
end

function xjEntity_MoJunTiaoZhanRange:refreshInfo()
local twoEffectDatas=xianjieModel:getZhanFaEffectData()
local twodata=self.data.twodata
if twoEffectDatas and twodata then
self.data.twodata=twoEffectDatas.twodata
self:showBlickEffect(true)
end
end

return xjEntity_MoJunTiaoZhanRange