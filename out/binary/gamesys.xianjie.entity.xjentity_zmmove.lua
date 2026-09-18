









local xjEntity_zmmove={}


function xjEntity_zmmove:onInit()
self:initData()
end

function xjEntity_zmmove:initData()
local data=self.data
local zmData=xianjieModel:getMyZongMenData()
local posList={}
self.inCurScene=zmData:checkInCurScene()
self.zm_gridX=zmData.gridX
self.zm_gridZ=zmData.gridZ
data[3]=zmData.gridWidth
data[4]=zmData.gridHeight
local tpos=xianjieController:worldGridPos2WorldPos11(data[1],data[2],data[3],data[4])
if self.inCurScene then
local pos=xianjieModel:getZongMenWorldPos_1(zmData)
posList[1]=pos
posList[2]=tpos
else
posList[1]=tpos
posList[2]=tpos
end
self.posList=posList
self.mapGridKey=data[5]
end

function xjEntity_zmmove:refreshPos(gridX,gridZ)
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

function xjEntity_zmmove:checkInRange(gridX,gridZ)
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

function xjEntity_zmmove:checkInRange2(gridX,gridZ)
if self.inCurScene==true then
local data=self.data
local gridX_=self.zm_gridX
local gridZ_=self.zm_gridZ
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


function xjEntity_zmmove:onCreateWidget(widget)
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

local modelset=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'modelSet_zmMove')
local boxParams=self:handleBoxParams()
local modelId=modelset.model
local zmData=xianjieModel:getMyZongMenData()
if zmData and zmData.sectdress and zmData.sectdress~=0 then
local sectdressId=zmData.sectdress
local settingcfg=UISettingConfig.getCfg(KUANGE_TYPE.zongmen,sectdressId)
if settingcfg then
modelId=settingcfg.modelId
end
end
widget:SetChildSceneEntityCreateModel(6,modelId,{},sortingLayerName,sortingOrder,modelset.scale,nil,false)
widget:SetChildSceneEntityChangeColor(6,Color.New(1,1,1,0.7),0,nil)

local offset=modelset.offset
widget:SetChildLocalPosition(6,Vector3(offset[1],offset[2],offset[3]))


end

function xjEntity_zmmove:refreshWidget(widget)

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

function xjEntity_zmmove:getGridIcon(sceneidx,gridX,gridZ)
local data=self.data
if xianjieController:checkGridInMap(gridX,gridZ,sceneidx)then
if self:checkInRange2(gridX,gridZ)then

return'image_xjbs_6'
else

local flag2=xianjieModel:checkGridLimit(sceneidx,gridX,gridZ)
if flag2 then

return'image_xjbs_7'
else
local flag=xianjieModel:checkGridState2(sceneidx,gridX,gridZ)
if flag then

return'image_xjbs_7'
else

return'image_xjbs_6'
end
end
end
else

return'image_xjbs_7'
end
end

function xjEntity_zmmove:refreshLine()
if self.inCurScene then
self:drawMyLines2(sceneLineType.eGreenArrow,0,nil)
else
self:removeMyLines(false)
end
end


function xjEntity_zmmove:onRemoveWidget(widget)

widget:SetChildBoxColliderRemove(5)

widget:SetChildSceneEntityRemoveModel(6)
end


function xjEntity_zmmove:onMyClick(boxParams)

end

function xjEntity_zmmove:onDelete()
if self.mapGridKey~=nil then
xianjieController:removeEntity(self.mapGridKey)
self.mapGridKey=nil
end
end

return xjEntity_zmmove