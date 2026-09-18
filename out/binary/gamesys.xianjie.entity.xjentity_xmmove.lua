









local xjEntity_xmmove={}


function xjEntity_xmmove:onInit()
self:initData()
end

function xjEntity_xmmove:initData()
local data=self.data
local xmData=xianjieModel:getMyXianMengData()
local posList={}
self.inCurScene=xmData:checkInCurScene()
self.xm_gridX=xmData.gridX
self.xm_gridZ=xmData.gridZ
data[3]=xmData.gridWidth
data[4]=xmData.gridHeight
local tpos=xianjieController:worldGridPos2WorldPos11(data[1],data[2],data[3],data[4])
if self.inCurScene then
local pos=xianjieController:worldGridPos2WorldPos11(xmData.gridX,xmData.gridZ,xmData.gridWidth,xmData.gridHeight,xmData.sceneidx)
posList[1]=pos
posList[2]=tpos
else
posList[1]=tpos
posList[2]=tpos
end
self.posList=posList
self.mapGridKey=data[5]
end

function xjEntity_xmmove:refreshPos(gridX,gridZ)
local data=self.data
if data[1]==gridX and data[2]==gridZ then return end
data[1]=gridX
data[2]=gridZ
self:initData()
xianjieController:resetEntityPosList(self:getKey(),self.posList)

local widget=self:getWidget()
if widget then
self:refreshWidget(widget)
self:invokeEntityHudFunc('refreshPos')
end

end

function xjEntity_xmmove:checkInRange(gridX,gridZ)
local data=self.data
local gridX_=data[1]
local gridZ_=data[2]
local width=data[3]
local height=data[4]
for i=0,width-1 do
for j=0,height-1 do
if gridX==gridX_+i and gridZ==gridZ_+j then
return true
end
end
end
return false
end

function xjEntity_xmmove:checkInRange2(gridX,gridZ)
if self.inCurScene==true then
local data=self.data
local gridX_=self.xm_gridX
local gridZ_=self.xm_gridZ
local width=data[3]
local height=data[4]
for i=0,width-1 do
for j=0,height-1 do
if gridX==gridX_+i and gridZ==gridZ_+j then
return true
end
end
end
end
return false
end


function xjEntity_xmmove:onCreateWidget(widget)
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local sortingLayerName='Entity'
local sortingOrder=entCfg.sortOrder

self:refreshWidget(widget)


widget:SetChildSpriteRendererSortingLayer(1,sortingLayerName,sortingOrder-1)

widget:SetChildSpriteRendererSortingLayer(2,sortingLayerName,sortingOrder-1)

widget:SetChildSpriteRendererSortingLayer(3,sortingLayerName,sortingOrder-1)

widget:SetChildSpriteRendererSortingLayer(4,sortingLayerName,sortingOrder-1)

local boxParams=self:handleBoxParams()
local boxSize=Vector2(5,5)
widget:SetChildBoxColliderAdd(5,boxSize,Vector2.zero,1,boxParams,helper.LAYER_ACTOR)

local modelset=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'modelSet_xm')
local boxParams=self:handleBoxParams()
local modelId=modelset.model
widget:SetChildSceneEntityCreateModel(6,modelId,{},sortingLayerName,sortingOrder,modelset.scale,nil,false)
widget:SetChildSceneEntityChangeColor(6,Color.New(1,1,1,0.7),0,nil)

local offset=modelset.offset
widget:SetChildLocalPosition(6,Vector3(offset[1],offset[2],offset[3]))


end

function xjEntity_xmmove:refreshWidget(widget)

local ePos=self.posList[2]
widget:SetChildPosition(0,ePos)

local data=self.data
local sceneidx=xianjieModel:getSceneIndex()
local gridX=data[1]
local gridZ=data[2]
local abname=globalABLookup.xjhudicons
local icon

icon=self:getGridIcon(sceneidx,gridX,gridZ)
widget:SetChildSpriteRendererWithBundle(1,abname,icon,false)

icon=self:getGridIcon(sceneidx,gridX+1,gridZ)
widget:SetChildSpriteRendererWithBundle(2,abname,icon,false)

icon=self:getGridIcon(sceneidx,gridX,gridZ+1)
widget:SetChildSpriteRendererWithBundle(3,abname,icon,false)

icon=self:getGridIcon(sceneidx,gridX+1,gridZ+1)
widget:SetChildSpriteRendererWithBundle(4,abname,icon,false)
end

function xjEntity_xmmove:getGridIcon(sceneidx,gridX,gridZ)
local data=self.data
if xianjieController:checkGridInMap(gridX,gridZ,sceneidx)then
if self:checkInRange2(gridX,gridZ)then

return'image_xjbs_6'
else
local flag=xianjieModel:checkGridState2(sceneidx,gridX,gridZ)
if flag then

return'image_xjbs_7'
else

return'image_xjbs_6'
end
end
else

return'image_xjbs_7'
end
end

function xjEntity_xmmove:refreshLine()
if self.inCurScene then
self:drawMyLines2(sceneLineType.eGreenArrow,0,nil)
else
self:removeMyLines(false)
end
end


function xjEntity_xmmove:onRemoveWidget(widget)

widget:SetChildBoxColliderRemove(5)

widget:SetChildSceneEntityRemoveModel(6)
end


function xjEntity_xmmove:onMyClick(boxParams)

end

function xjEntity_xmmove:onDelete()
if self.mapGridKey~=nil then
xianjieController:removeEntity(self.mapGridKey)
self.mapGridKey=nil
end
end

return xjEntity_xmmove