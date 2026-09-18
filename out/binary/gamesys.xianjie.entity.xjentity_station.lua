









local xjEntity_station={}


function xjEntity_station:onInit()
local data=self.data
self.infoguid=data[1]
local stationData=xianjieModel:getStationData(self.infoguid)
self.pos=stationData:getWorldPos_1()
self.size=stationData:getWorldSize()
self.canSelect=true
self.allowClickGrid=true
end

function xjEntity_station:get_infoguid()
return self.infoguid
end


function xjEntity_station:onCreateWidget(widget)
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local boxParams=self:handleBoxParams()
local modelData=entCfg.display[1]
local modelId=modelData[1]
local offset=modelData[2]
local scale=modelData[3]
widget:SetChildSceneEntityCreateModel(0,modelId,{},'Entity',entCfg.sortOrder,scale,nil,false)
widget:SetChildSceneEntityAddModelBoxCollider(0,boxParams,helper.LAYER_ACTOR)
widget:SetChildLocalPosition(0,Vector3(offset[1],offset[2],offset[3]))
end


function xjEntity_station:onSelectHandle(widget,isSelect)
if not widget then
self.selectEffect=nil
return
end
if isSelect then
if self.selectEffect==nil then
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local effect=entCfg.display[2]
if effect then
self.selectEffect=effect[1]
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


function xjEntity_station:onRemoveWidget(widget)
widget:SetChildSceneEntityRemoveModel(0)
end

function xjEntity_station:modelPlayAnimation(anim)
local widget=self:getWidget()
if widget then
widget:SetChildSceneEntityPlayAnimation(0,anim)
end
end


function xjEntity_station:onMyClick(boxParams)
local infoguid=self.infoguid
xianjieController:openStationInfoWin(infoguid)
end

function xjEntity_station:onDelete()

end

return xjEntity_station