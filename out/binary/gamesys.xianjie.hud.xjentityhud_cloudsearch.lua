









local xjEntityHud_cloudSearch={}


function xjEntityHud_cloudSearch:onInit()
self.needFollow=true

self.uiOffset={Vector2(0,0),Vector2(0,0)}
local data=self.data
self.cloudid=data[1]
end


function xjEntityHud_cloudSearch:onCreateWidget(widget)

widget:SetChildButtonClick(0,function()
self:onClick()
end)

local cloudData=xianjieModel:getCloudData(self.cloudid)
local netData=cloudData:getDZData()
local image=UIDiscipleModel.calculationDiscipleImageBase(netData)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(1,widget,modelParams,eHeadCenterType.eHead,nil,false)

widget:SetChildText(2,netData.disciplename)

local sortingLayer=helper.getSortingLayerID("CanvasBottom")
widget:SetChildShowEffectEx(3,20461,sortingLayer,1,true)
end


function xjEntityHud_cloudSearch:onRemoveWidget(widget)
widget:SetChildShowEffect(3,0,false)
end

function xjEntityHud_cloudSearch:onClick()
if not self:checkWidget()then return end
xianjieController:handleClickCloud(self.cloudid)
end


function xjEntityHud_cloudSearch:onDelete()

end

return xjEntityHud_cloudSearch