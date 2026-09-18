









local xjEntity_plotEvent={}


function xjEntity_plotEvent:onInit()
local data=self.data
self.cloudid=data[1]
self.plotIdx=data[2]
local cloudPlotData=xianjieModel:getCloudPlotData(self.cloudid,self.plotIdx)
self.pos=cloudPlotData:getWorldPos_1()
self.size=cloudPlotData:getWorldSize()
end


function xjEntity_plotEvent:onCreateWidget(widget)
local cfg=cfgHelper.get2(cfg_fairylandclouddataconfig_get,self.cloudid,self.plotIdx)
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local boxParams=self:handleBoxParams()
widget:SetChildSceneEntityCreateModel(0,cfg.spineID,{},'Entity',entCfg.sortOrder,1,nil,false)
widget:SetChildSceneEntityAddModelBoxCollider(0,boxParams,helper.LAYER_ACTOR)
end


function xjEntity_plotEvent:onRemoveWidget(widget)
widget:SetChildSceneEntityRemoveModel(0)
end


function xjEntity_plotEvent:onMyClick(boxParams)
xianjieController:createCloudPlotBehavior(self.cloudid,self.plotIdx,true)
end

function xjEntity_plotEvent:onDelete()

end

return xjEntity_plotEvent