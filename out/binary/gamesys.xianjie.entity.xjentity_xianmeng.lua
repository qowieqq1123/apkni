









local xjEntity_xianmeng={}


function xjEntity_xianmeng:onInit()
local data=self.data
self.guildid=data[1]
self.guildid_str=mathHelper.int64_to_string(self.guildid)
local xmData=xianjieModel:getXianMengDataEx(self.guildid_str)
self.pos=xmData:getWorldPos_1()
self.size=xmData:getWorldSize()
self.xmData=xmData
self.ent_name=xmData.guildname
self.xjicontype=nil
self.data.xjicontype=nil

self.canSelect=true
self.allowClickGrid=true
end


function xjEntity_xianmeng:onSelectHandle(widget,isSelect)
if not widget then
self.selectEffect=nil
return
end
if isSelect then
if self.selectEffect==nil then
local modelset=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'modelSet_xm')
local effect=modelset.selectEffect
if effect then
self.selectEffect=effect[1]
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local sortingLayer=helper.getSortingLayerID("Entity")
widget:SetChildShowEffectEx(1,self.selectEffect,sortingLayer,entCfg.sortOrder-1,true)
local pos=effect[2]
widget:SetChildLocalPosition(1,Vector3(pos[1],pos[2],pos[3]))
local scale=effect[3]
widget:SetChildScale(1,Vector3(scale,scale,scale))
end
end
else
if self.selectEffect then
self.selectEffect=nil
widget:SetChildShowEffect(1,0,false)
end
end
end


function xjEntity_xianmeng:onCreateWidget(widget)
local modelset=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'modelSet_xm')
local modelId=modelset.model
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local boxParams=self:handleBoxParams()
widget:SetChildSceneEntityCreateModel(0,modelId,{},'Entity',entCfg.sortOrder,modelset.scale,nil,false)
widget:SetChildSceneEntityAddModelBoxCollider(0,boxParams,helper.LAYER_ACTOR)
local offset=modelset.offset
widget:SetChildLocalPosition(0,Vector3(offset[1],offset[2],offset[3]))
end


function xjEntity_xianmeng:onRemoveWidget(widget)
widget:SetChildSceneEntityRemoveModel(0)
end


function xjEntity_xianmeng:onMyClick(boxParams)
xianjieController:openXianMengWin(self.guildid)
end

function xjEntity_xianmeng:onDelete()

end

return xjEntity_xianmeng