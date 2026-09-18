





local hideObjType=
{
objectType.eRole,
objectType.eStillSundrise,
objectType.eMovementSundrise,
objectType.eFangKe,
objectType.eVisitRole,
objectType.eZMVisitor,
objectType.eXianChong,
objectType.eYunYouMerchant,
objectType.eYiShiLaiKe,
}

function isometricMapSystem:setDesignMode(mode)
self.designMode=mode


end

function isometricMapSystem:getDesignMode()
return self.designMode
end

function isometricMapSystem:startDesign()
isometricMapSystem:setDesignMode(true)

UIManager.disableAllTips()

isometricMapSystem:enterDesignMap()
end

function isometricMapSystem:endDesign()
if not isometricMapSystem:getDesignMode()then
return
end
isometricMapSystem:setDesignMode(nil)

UIManager.enableAllTips()



isometricMapSystem:leaveDesignMap()
end


function isometricMapSystem:fakeDesignMountainData()
local monijySF={}
monijySF.sf_id=mapIdType.zhufeng_design
monijySF.sf_name="设计地图"
monijySF.sf_dizi_id=int64.zero
monijySF.opentime=timeHelper.getServerShortTime()
monijySF.begintime=timeHelper.getServerShortTime()
monijySF.unlockareacnt=0
monijySF.task_idx=0
monijySF.taskFlag=1
monijySF.open_sf_dizi_len=0
monijySF.opensfdiziList={}
monijySF.open_area_list_len=0
monijySF.areaList={}

monijySF.open_build_list_len=0
monijySF.buildList={}

monijySF.reducetimes=0
monijySF.repair_build_len=0
monijySF.repairbuildList={}
monijySF.road_len=0
monijySF.roadList={}
monijySF.randomItemLen=0
monijySF.randomList={}
zongmenModel:setMountainDatas(monijySF)
end

function isometricMapSystem:enterDesignMap()
local sfId=zongmenModel:getMountainId()
if sfId and sfId~=mapIdType.zhufeng_design then
self.oSf=zongmenModel:getMountainId()
end
ims_design_layout:initGongMenData()
isometricMapSystem:fakeDesignMountainData()
zongmenModel:loadSelectDesignLayoutId()
mountainControl:loadAndswitchMapEx(mapIdType.zhufeng_design,true,function()
UIManager:callWindowFunc("UILayoutEditWin","showRootWin",true)
UIManager:callWindowFunc("UILayoutEditWin","showBtnWin",true)
end)
end

function isometricMapSystem:leaveDesignMap()
mountainControl:loadAndswitchMapEx(self.oSf or mapIdType.zhufeng,true,function()
UIManager:callWindowFunc("UILayoutEditWin","showRootWin",false)
UIManager:callWindowFunc("UILayoutEditWin","showBtnWin",false)
isometricMapSystem:onLeaveDesignMap()
end)
self.oSf=nil
end

function isometricMapSystem:onLeaveDesignMap()
isometricMapSystem:showDesignObj(true)
isometricMapSystem:removeDesignSundrise()
mountainControl:removeMap(mapIdType.zhufeng_design)
if self.leaveDesignCall then
self.leaveDesignCall()
end
end


function isometricMapSystem:clearDesignMap()
local mapId=mapIdType.zhufeng_design
if zongmenModel.data.designBuildingMapData then
for i,v in pairs(zongmenModel.data.designBuildingMapData)do
_MapManager.PickUpFromMap(v.entityId)
_MapManager.RemoveTilemapObject(v.entityId)
hudControl:clearHUDByEntityID(v.entityId)
end
end
if self.designModelList then
for i,v in pairs(self.designModelList)do
_EntityManager:RemoveEntity(v)
end
self.designModelList=nil
end
if self.previewModelList then
for i,v in ipairs(self.previewModelList)do
_MapManager.PickUpFromMap(v)
_MapManager.RemoveTilemapObject(v)
hudControl:clearHUDByEntityID(v)
end
self.previewModelList=nil
end

if zongmenModel.data.designData then
for i,v in pairs(zongmenModel.data.designData)do
if v.entityId then
if _MapManager.IsPlace(v.entityId)then
_MapManager.PickUpFromMap(v.entityId)
end
_MapManager.RemoveTilemapObject(v.entityId)
hudControl:clearHUDByEntityID(v.entityId)
end
end
end

local repairDatas=isometricMapSystem:getRepairDatas(mapId)
for index,repairData in ipairs(repairDatas)do
_MapManager.PickUpFromMap(repairData.guid)
_MapManager.RemoveTilemapObject(repairData.guid)
hudControl:clearHUDByEntityID(repairData.guid)
isometricMapSystem:removeRepairData(mapId,repairData.guid)
end
end

function isometricMapSystem:showDesignGrid()

local sfId=mapIdType.zhufeng
local mapId=mapIdType.zhufeng_design
local areas=zongmenModel:getAllAreaData(sfId)
for k,v in pairs(areas)do
_MapManager.DrawByArea(mapId,v.area_id,TILE_TYPE.eGrid,mapLayer.Grid,conditionConfig.drawGrid)
end

end


function isometricMapSystem:hideDesignGrid()
if zongmenModel:getMountainId()==mapIdType.zhufeng_design then
_MapManager.Erase(mapIdType.zhufeng_design,mapLayer.Grid)
end
end

function isometricMapSystem:createDesignBuilding()
local sfId=mapIdType.zhufeng
local thisId=mapIdType.zhufeng_design
local buildingDatas=zongmenModel:getAllBuildingData(sfId)
self.designModelList=self.designModelList or{}
for k,v in pairs(buildingDatas)do
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.build_id)
if cfg==nil then
loggerUtil.logErrFMT("没有建筑配置 id:{0}",v.build_id)
end
local mdata=self:getModelByData(v)
local bx=cfg.buid_size[1]
local by=cfg.buid_size[2]
local offset=self:countOffset(bx,by)

local ubdId=v.un_build_id

local designData=zongmenModel:getDesignBuildingData(ubdId)

local storageData=zongmenModel:getDesignStorageBuildingData(ubdId)
if not storageData then

local x=designData and designData.x or v.x
local y=designData and designData.y or v.y

local orientation=designData and designData.orientation or v.orientation

local pos=_MapManager.ToVector3Int(x,y,0)

if ims_design_layout:IsCanPlace(thisId,v.build_id,x,y,orientation)then
local guid=isometricMapSystem:createBuildingEntity(objectType.ePlaceObject,thisId,v.build_id,mdata.model,mdata.slots,mdata.layer,true,
orientation~=0,mdata.scale,pos,offset,cfg.pCfgId)


self:showNormalModel(guid,cfg.etype,mdata.hideNormalModel~=true)

if cfg.sp_model then

if v.flag>0 and v.flag~=2 and v.level==1 then
local st=self:showSpecialModel(guid,cfg,0,true,v.flag)
st:SetPosition(Vector3.New(20000,0,0))
self.designModelList[guid]=st.GUID
else
local st=self:showSpecialModel(guid,cfg,v.level,false)
st:SetPosition(Vector3.New(20000,0,0))
self.designModelList[guid]=st.GUID
end
end

if mdata.offset then
_MapManager.SetOffset(guid,Vector3.New(mdata.offset[1],mdata.offset[2],0))
end



if cfg.showShadow then
_MapManager.ShowShadow(guid,true)
end

local status=zongmenModel:getRepairStatusById(sfId,v.un_build_id)
if status and status~=repairStatus.eNotRepaired then
if v.flag==1 then
self:setLockPlaceObject(guid,true)
end
end
zongmenModel:setDesignBuildingMapData(sfId,ubdId)
zongmenModel:setDesignEntityId(ubdId,guid)
else
if v.flag==0 then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.build_id)
if cfg.is_move~=0 then
zongmenModel:setDesignStorageData(sfId,ubdId)
end
end
end



end

end

local storageData=zongmenModel:getAllstorageBuilding()
for i,v in pairs(storageData)do
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.build_id)
local ubdId=v.un_build_id

local designData=zongmenModel:getDesignBuildingData(ubdId)
local storageData=zongmenModel:getDesignStorageBuildingData(ubdId)
if designData and not storageData then





local x=designData and designData.x or v.x
local y=designData and designData.y or v.y

local orientation=designData and designData.orientation or v.orientation

local guid=isometricMapSystem:createABuildingToMap(thisId,{build_id=v.build_id,level=1,x=x,y=y,orientation=orientation})
if cfg.showShadow then
_MapManager.ShowShadow(guid,true)
end
local data=table.deepCopy(v)
data.x=x
data.y=y
data.orientation=orientation
zongmenModel:setDesignBuildingMapData(sfId,ubdId,data)

zongmenModel:setDesignEntityId(ubdId,guid)
end
end

UIManager:invokeUIMethod("UILayoutEditWin","refreshSortCount")
end

function isometricMapSystem:loadAndSetDesignMountain()
isometricMapSystem:setLayoutMode(layoutMode.eDesign)
isometricMapSystem:setEditorMode(editorMode.eDefault)


local sfId=mapIdType.zhufeng
local thisId=mapIdType.zhufeng_design

isometricMapSystem:unlockMountainArea(sfId,thisId)
isometricMapSystem:setNewAreaShow(thisId)

if not zongmenModel.data.isInitDesignData then
zongmenModel:loadDesignData()


end

if not zongmenModel.data.designRoadData and(((not zongmenModel.data.designData)or not next(zongmenModel.data.designData))and((not zongmenModel.data.designStorageData)or not next(zongmenModel.data.designStorageData)))then
isometricMapSystem:useZMDesignRoadData()
end

self:createDesignBuilding()


local cfg=cfgHelper.get1(cfg_monijysfconfig_get,sfId)
local rplist=cfg.repair_build_list
for k,v in pairs(rplist)do
local bdId=k
for ii,vv in ipairs(v)do
local key=vv
local areaId=isometricMapSystem:getPosIndexArea(key)
if isometricMapSystem:isCanShowArea(areaId)then

local status=zongmenModel:getRepairStatus(sfId,key)
if status and status==repairStatus.eNotRepaired then
isometricMapSystem:createRepairBuilding(thisId,bdId,key)
end
end
end
end

isometricMapSystem:drawDesignRoad()

self:drawArea(thisId,-1)


self:setAreaCellBrightness(thisId,-1,true)

isometricMapSystem:showDesignGrid()
end




function zongmenModel:loadDesignData()
local sfId=mapIdType.zhufeng
zongmenModel.data.designData={}
zongmenModel.data.isInitDesignData=true
local saveDesignData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eZongMenDesign,'designData',{})

zongmenModel.data.designStorageData={}
local saveStorageData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eZongMenDesign,'storageData',{})
for i,v in ipairs(saveStorageData)do
local ubdId=v
local data=zongmenModel:getBuildingData(ubdId)
if data and data.flag==0 then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)

if cfg.is_move~=0 then
zongmenModel:setDesignStorageData(sfId,ubdId)
end
end
end

for i,v in ipairs(saveDesignData)do
local ubdId=v[1]
local sdata
sdata=zongmenModel:getStorageBuilding(ubdId)
if sdata then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,sdata.build_id)
if cfg.is_move~=0 then
zongmenModel:saveDesignBuildingData(sfId,ubdId,{un_build_id=sdata.unbuild_id,build_id=sdata.build_id,level=v.level,x=v[2],y=v[3],orientation=v[4]})
end
else
local data=zongmenModel:getBuildingData(ubdId)
if data then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
if cfg.is_move~=0 then
zongmenModel:saveDesignBuildingData(sfId,ubdId,{un_build_id=data.unbuild_id,build_id=data.build_id,level=data.level,x=v[2],y=v[3],orientation=v[4]})
end
end
end
end

local saveRoadData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eZongMenDesign,'roadData',nil)

local roadData={}
if saveRoadData then
for i,v in ipairs(saveRoadData)do
local key=FMT.fmt('{0}_{1}',v[1],v[2])
roadData[key]=v
end
else
if not next(zongmenModel.data.designData)and not next(zongmenModel.data.designStorageData)then
local roadDatas=zongmenModel:getMountainRoadDatas(sfId)
if roadDatas then
for k,v in pairs(roadDatas)do
roadData[k]={v.x,v.y,v.type,v.style}
end
end
end
end
zongmenModel:initDesignRoadData(roadData)

UIManager:invokeUIMethod("UILayoutEditWin","refreshSortCount")
end

function isometricMapSystem:drawDesignRoad()
if zongmenModel.data.designRoadData then
local cfgs=cfg_roadstyleconfig()
local rdlists={}
for k,v in pairs(cfgs)do
rdlists[k]={}
end
for k,v in pairs(zongmenModel.data.designRoadData)do
local rt=v[3]
local rdlist=rdlists[rt]
local count=#rdlist+1
rdlist[count]=v[1]
count=count+1
rdlist[count]=v[2]
count=count+1
rdlist[count]=0
count=count+1
rdlist[count]=rt
count=count+1
rdlist[count]=v[4]
end
for k,v in pairs(rdlists)do
local cfg=cfgHelper.get1(cfg_roadstyleconfig_get,k)
_MapManager.DrawRoadByData(mapIdType.zhufeng_design,v,mapLayer[cfg.layer])
end
end

end

function isometricMapSystem:clearDesignRoadData()
local mapId=mapIdType.zhufeng_design
if api_Available_SetCellCoverTypeByPosList()then
if zongmenModel.data.designRoadData then
local posArr={}
for i,v in pairs(zongmenModel.data.designRoadData)do
table.insert(posArr,v[1])
table.insert(posArr,v[2])
table.insert(posArr,0)
end
_MapManager.SetCellCoverTypeByPosList(mapId,posArr,0)
end
end

zongmenModel.data.designRoadData=nil

_MapManager.Erase(mapId,mapLayer.Road1)
_MapManager.Erase(mapId,mapLayer.Data)
end

function isometricMapSystem:useZMDesignRoadData()
local roadData={}
local roadDatas=zongmenModel:getMountainRoadDatas(mapIdType.zhufeng)
if roadDatas then
for k,v in pairs(roadDatas)do
roadData[k]={v.x,v.y,v.type,v.style}
end
end
zongmenModel.data.designRoadData=roadData
end

function isometricMapSystem:showDesignObj(flag)
for i,v in ipairs(hideObjType)do
_MapManager.SetObjectDisplay(v,flag)
end

end

function isometricMapSystem:onDesignMove(sfId,bdId,x,y,orientation,notPickUp)


local building=isometricMapSystem:getPreviewBuilding()
if building and building.bdData and building.bdData.un_build_id==bdId then
hudControl:removeHUD(building.hudId)
end
local data=zongmenModel:getDesignBuilding(bdId)

local isStorage=true

data.x=x
data.y=y
data.orientation=orientation

zongmenModel:saveDesignBuildingData(sfId,bdId,data)


if not notPickUp and _MapManager.IsPlace(data.entityId)then
_MapManager.PickUpFromMap(data.entityId)
end
_MapManager.SetPosition(data.entityId,_MapManager.ToVector3Int(data.x,data.y,0))
isometricMapSystem:setflipX(data.entityId,data,data.orientation==1)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)

_MapManager.PlaceToMap(data.entityId,conditionConfig.designPlace)

local layer
if cfg.etype==2 then

layer=SortingLayers.ITBuilding
local idArr=_MapManager.GetLayoutBuildingMembersGUID(data.entityId,1)
local st=_EntityManager:GetEntity(idArr[1])
st:SetSortingLayer(SortingLayers.ITGrid2)
else
layer=SortingLayers.ITBuilding
end
_MapManager.SetSortingLayer(data.entityId,layer)

hudControl:setHUDShow(data.un_build_id,true)
buildingEffectControl:playEffectByEID(data.un_build_id,data.build_id,buildEffectType.ePlace)




if not isStorage then
local blist=buildingEffectControl:getPlayBenefitBuildingList(sfId,bdId)
isometricMapSystem:setBuildingLinkRoad(sfId,bdId)

isometricMapSystem:setBenefitBuffBuildingById(sfId,bdId)
buildingEffectControl:playBenefitBuildingEffect(sfId,blist)
buildingEffectControl:refreshBuildingBuffEffect(sfId,bdId)
end

isometricMapSystem:clearStatus()

end

function isometricMapSystem:onApplyDesignMove(sfId,bdId)
local data=zongmenModel:getBuildingData(bdId)




_MapManager.SetPosition(data.entityId,_MapManager.ToVector3Int(data.x,data.y,0))
isometricMapSystem:setflipX(data.entityId,data,data.orientation==1)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)

_MapManager.PlaceToMap(data.entityId,conditionConfig.designPlace)

local layer
if cfg.etype==2 then

layer=SortingLayers.ITBuilding
local idArr=_MapManager.GetLayoutBuildingMembersGUID(data.entityId,1)
local st=_EntityManager:GetEntity(idArr[1])
st:SetSortingLayer(SortingLayers.ITGrid2)
else
layer=SortingLayers.ITBuilding
end
_MapManager.SetSortingLayer(data.entityId,layer)

hudControl:setHUDShow(data.un_build_id,true)
buildingEffectControl:playEffectByEID(data.un_build_id,data.build_id,buildEffectType.ePlace)




local blist=buildingEffectControl:getPlayBenefitBuildingList(sfId,bdId)
isometricMapSystem:setBuildingLinkRoad(sfId,bdId)

isometricMapSystem:setBenefitBuffBuildingById(sfId,bdId)
buildingEffectControl:playBenefitBuildingEffect(sfId,blist)
buildingEffectControl:refreshBuildingBuffEffect(sfId,bdId)

end

function isometricMapSystem:cancelDesignPickUp()
local building=isometricMapSystem:getPreviewBuilding()
if not building then
return
end
local guid=building.guid
local bdData=building.bdData

local designData=zongmenModel:getDesignBuildingData(bdData.un_build_id)
if designData then
bdData=designData
else

local designBD=zongmenModel:getDesignBuilding(bdData.un_build_id)
if designBD then
bdData=designBD
end
end

_MapManager.SetPosition(guid,_MapManager.ToVector3Int(bdData.x,bdData.y,0))

_MapManager.PlaceToMap(guid,conditionConfig.designPlace)
local layer
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
if cfg.etype==2 then

layer=SortingLayers.ITBuilding
local idArr=_MapManager.GetLayoutBuildingMembersGUID(guid,1)
local st=_EntityManager:GetEntity(idArr[1])
st:SetSortingLayer(SortingLayers.ITGrid2)
else
layer=SortingLayers.ITBuilding
end
_MapManager.SetSortingLayer(guid,layer)

buildingEffectControl:playEffectByEID(guid,building.cfg.id,buildEffectType.ePlace)

if building.hudId then
hudControl:removeHUD(building.hudId)
else
logErr(FMT.fmt('[isometricMapSystem][cancelPickUp]hudId为nil，建筑ID：{0} 实体ID：{1}',bdData.un_build_id,bdData.entityId))
end

hudControl:setHUDShow(bdData.un_build_id,true)

if zongmenModel:getMountainId()~=mapIdType.zhufeng_design then
return
end
isometricMapSystem:clearStatus()
end


function isometricMapSystem:onDesignStore(sfId,bdId)
if not zongmenModel.data.designStorageData then
zongmenModel.data.designStorageData={}
end
local isStorage
local data=zongmenModel:getDesignBuildingData(bdId)
if not data then
data=zongmenModel:getDesignBuilding(bdId)
end
if not data then
return
end

if not isStorage then
zongmenModel:saveDesignBuildingData(sfId,bdId,nil)
zongmenModel:setDesignStorageData(sfId,bdId)
else
zongmenModel:saveDesignBuildingData(sfId,bdId,nil)
zongmenModel:delDesignBuildingMapData(bdId)
end

if data.entityId then
if _MapManager.IsPlace(data.entityId)then
_MapManager.PickUpFromMap(data.entityId)
end
_MapManager.RemoveTilemapObject(data.entityId)
hudControl:clearHUDByEntityID(data.entityId)
end

isometricMapSystem:clearStatus(true)

hudControl:setHUDShow(data.un_build_id,true)
end




function zongmenModel:setDesignAllBuildingStorage()
local sfId=mapIdType.zhufeng
local mounttainData=zongmenModel:getMountainData(sfId)

local buildingDatas=mounttainData.buildingDatas


for i,v in pairs(buildingDatas)do
local bdCfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.build_id)
if bdCfg.is_move~=0 and not isometricMapSystem:getRepairDataByEID(v.entityId)and v.flag==0 then

isometricMapSystem:onDesignStore(sfId,v.un_build_id)

end
end

if zongmenModel.data.designData then
for i,v in pairs(zongmenModel.data.designData)do
local oriData=zongmenModel:getStorageBuilding(i)
if oriData then
isometricMapSystem:onDesignStore(sfId,i)
end
end
end

UIManager:invokeUIMethod("UILayoutEditWin","refreshSortCount")
end


function zongmenModel:resetDesignMap(clearData)


isometricMapSystem:clearStatus(true)

if clearData then
zongmenModel.data.designData={}
zongmenModel.data.designStorageData={}
end


for i,v in pairs(zongmenModel.data.designBuildingMapData)do
if _MapManager.IsPlace(v.entityId)then
_MapManager.PickUpFromMap(v.entityId)
end
_MapManager.RemoveTilemapObject(v.entityId)
hudControl:clearHUDByEntityID(v.entityId)
end

isometricMapSystem:clearDesignRoadData()
isometricMapSystem:useZMDesignRoadData()
isometricMapSystem:drawDesignRoad()

isometricMapSystem:createDesignBuilding()

end



function zongmenModel:getDesignStorageData()
return zongmenModel.data.designStorageData or{}
end


function zongmenModel:setDesignStorageData(sfId,ubdId)
local mdata=zongmenModel:getMountainData(sfId)
if mdata then
if not zongmenModel.data.designStorageData then
zongmenModel.data.designStorageData={}
end

zongmenModel.data.designStorageData[ubdId]=mdata.buildingDatas[ubdId]

end
end

function zongmenModel:getDesignStorageBuildingData(ubdId)
if not zongmenModel.data.designStorageData then
return
end
return zongmenModel.data.designStorageData[ubdId]
end


function zongmenModel:delDesignStorageData(ubdId)
if not zongmenModel.data.designStorageData then
zongmenModel.data.designStorageData={}
end
zongmenModel.data.designStorageData[ubdId]=nil
end

function zongmenModel:getDesignBuildingMapData()
return zongmenModel.data.designBuildingMapData or{}
end

function zongmenModel:getDesignBuilding(ubdId)
if not zongmenModel.data.designBuildingMapData then zongmenModel.data.designBuildingMapData={}end
return zongmenModel.data.designBuildingMapData[ubdId]or{}
end




function zongmenModel:setDesignBuildingMapData(sfId,ubdId,bdData)
if not zongmenModel.data.designBuildingMapData then zongmenModel.data.designBuildingMapData={}end
if bdData then
zongmenModel.data.designBuildingMapData[ubdId]=bdData
else
local mdata=zongmenModel:getMountainData(sfId)
if mdata then
zongmenModel.data.designBuildingMapData[ubdId]=table.deepCopy(mdata.buildingDatas[ubdId])
end
end
end

function zongmenModel:setDesignEntityId(ubdId,entityId)
zongmenModel.data.designBuildingMapData=zongmenModel.data.designBuildingMapData or{}
if zongmenModel.data.designBuildingMapData[ubdId]then
zongmenModel.data.designBuildingMapData[ubdId].entityId=entityId
end
if zongmenModel.data.designData and zongmenModel.data.designData[ubdId]then
zongmenModel.data.designData[ubdId].entityId=entityId
end
end

function zongmenModel:delDesignBuildingMapData(ubdId)
if not zongmenModel.data.designBuildingMapData then
zongmenModel.data.designBuildingMapData={}
end
zongmenModel.data.designBuildingMapData[ubdId]=nil
end



function zongmenModel:saveDesignBuildingData(sfId,ubdId,buildingDatas)
if not zongmenModel.data.designData then
zongmenModel.data.designData={}
end
zongmenModel.data.designData[ubdId]=buildingDatas
end
function zongmenModel:getDesignBuildingData(ubdId)
if not zongmenModel.data.designData then
zongmenModel.data.designData={}
end
return zongmenModel.data.designData[ubdId]
end

function zongmenModel:getDesignBuildingDataByEntityId(entityId)
if not zongmenModel.data.designBuildingMapData then
return
end
for i,v in pairs(zongmenModel.data.designBuildingMapData)do
if v.entityId==entityId then
return v
end
end
end

function zongmenModel:checkDesignBuildingDataOverlapByBuildId(buildId,checkObj)
if not zongmenModel.data.designBuildingMapData then
return false
end
local rect=_MapManager.GetObjectRectInMap(checkObj)
if rect then
local sx=rect[1]
local sy=rect[2]
local ex=sx+rect[3]-1
local ey=sy+rect[4]-1
for i,v in pairs(zongmenModel.data.designBuildingMapData)do
if v.build_id==buildId and v.entityId and v.entityId~=checkObj then
local brect=_MapManager.GetObjectRectInMap(v.entityId)
if brect then
local bsx=brect[1]
local bsy=brect[2]
local bex=bsx+brect[3]-1
local bey=bsy+brect[4]-1
if isometricMapSystem:checkOverlap(sx,sy,ex,ey,bsx,bsy,bex,bey)then
return true
end
end
end
end
end
return false
end

function zongmenModel:selectDesignLayoutId(template_id)
zongmenModel.data.designLayoutId=template_id
end

function zongmenModel:getselectDesignLayoutId()
return zongmenModel.data.designLayoutId
end

function zongmenModel:initDesignRoadData(data)
self.data.designRoadData=data
end

function zongmenModel:setDesignRoadData(path)
if not self.data.designRoadData then
self.data.designRoadData={}
end
local designRoadData=self.data.designRoadData
for i,v in pairs(path)do
local key=FMT.fmt('{0}_{1}',v[1],v[2])
designRoadData[key]=v
end
end

function zongmenModel:delDesignRoadData(path)
if self.data.designRoadData then
local designRoadData=self.data.designRoadData
for i,v in pairs(path)do
local key=FMT.fmt('{0}_{1}',v[1],v[2])
designRoadData[key]=nil
end
end
end

function zongmenModel:getDesignRoadData()
return self.data.designRoadData
end

function zongmenModel:saveSelectDesignLayoutId()
if zongmenModel.data.designLayoutId then
userActorArraySetting.set(ACTOR_SETTING_TYPE.eZongMenDesign,'designLayoutId',zongmenModel.data.designLayoutId)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZongMenDesign)
end
end

function zongmenModel:loadSelectDesignLayoutId()




zongmenModel.data.designLayoutId=nil
end


function zongmenModel:saveDesignData()
if zongmenModel.data.designData then
local designData={}
for ubdId,v in pairs(zongmenModel.data.designData)do
table.insert(designData,{ubdId,v.x,v.y,v.orientation})
end
userActorArraySetting.set(ACTOR_SETTING_TYPE.eZongMenDesign,'designData',designData)
end

if zongmenModel.data.designStorageData then

local storageData={}
for ubdId,v in pairs(zongmenModel.data.designStorageData)do
table.insert(storageData,ubdId)
end

userActorArraySetting.set(ACTOR_SETTING_TYPE.eZongMenDesign,'storageData',storageData)

end

end

function zongmenModel:saveDesignRoadData()
if zongmenModel.data.designRoadData then
local designData={}
for k,v in pairs(zongmenModel.data.designRoadData)do
table.insert(designData,v)
end
userActorArraySetting.set(ACTOR_SETTING_TYPE.eZongMenDesign,'roadData',designData)
end
end

function zongmenModel:flushSaveDesignData()
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZongMenDesign)
end


function zongmenModel:getJingGuanStorageCount()
local lookUp={}
local num=0
if zongmenModel.data.designStorageData then
for i,data in pairs(zongmenModel.data.designStorageData)do
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
if cfg.func_type==1 then
lookUp[data.build_id]=true
end
end
end

local mapId=zongmenModel:getMountainId()
local datas={}
if mapId==mapIdType.xianmeng then
datas=xianmengModel:getStorageDatas()
else
datas=zongmenModel:getAllstorageBuilding()
end
for k,v in pairs(datas)do
if not zongmenModel:getDesignBuildingData(v.un_build_id)then
lookUp[v.build_id]=true
end
end
for k,v in pairs(lookUp)do
num=num+1
end
return num
end

function zongmenModel:saveBuildTempData(building)
local haveDesignData=zongmenModel.data.designData and next(zongmenModel.data.designData)~=nil
if haveDesignData or(zongmenModel.data.designStorageData and next(zongmenModel.data.designStorageData)~=nil)then


local sfId=zongmenModel:getMountainId()
zongmenModel:setDesignStorageData(sfId,building.un_build_id)
zongmenModel:saveDesignData()
zongmenModel:flushSaveDesignData()
end
end


function zongmenModel:isCanStorage(cfg,bdData,wraning)




local maxNum=zongmenModel:getStorageMaxNum()
local sCount=zongmenModel:getJingGuanStorageCount()
if sCount>=maxNum then
if wraning then
UIManager.error('储存空间不足，请摆放景观建筑')
end
return false
end
if cfg.win_type==8 then
if not UIShouLanModel:isCanStorage(bdData.un_build_id)then
if wraning then
UIManager.info('需清空兽栏')
end
return false
end
end
return true
end

function zongmenModel:applyLayout()

zongmenModel.data.sendsGongMen=nil

local strageData={}
if zongmenModel.data.designStorageData then
for i,data in pairs(zongmenModel.data.designStorageData)do
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
if cfg.func_type~=1 or cfg.is_collect==0 then





UIManager.error('请先将已收起的全部建筑进行摆放')






local win=UIManager:findActiveWindow("UILayoutEditWin")
if win then
local idx=win:getSortCount()
if idx then
if idx==1 then
weakGuideController:beginGuide(3571)
elseif idx==2 then
weakGuideController:beginGuide(3572)
elseif idx==3 then
weakGuideController:beginGuide(3573)
end
end
end

return
else
table.insert(strageData,i)
end
end

local maxNum=zongmenModel:getStorageMaxNum()
local sCount=zongmenModel:getJingGuanStorageCount()
if sCount>maxNum then
UIManager.error('储存空间不足，请摆放景观建筑')
return false
end
end
zongmenModel.data.designStorageData=zongmenModel.data.designStorageData or{}
local sfId=mapIdType.zhufeng


local designData={}
local rebuildData={}
local roadData={}
local fugaiData={}
local buildRoadData={}

local needRandomSundriseList={}
local needRandomEventList={}

local layoutRoad={}
local designRoadData=zongmenModel:getDesignRoadData()
if designRoadData then
layoutRoad=table.deepCopy(designRoadData)
end
local gongMenId=ims_design_layout.gongMenId
local gongMenData=ims_design_layout:getGongMenData()
local roadDatas=zongmenModel:getMountainRoadDatas(sfId)


if zongmenModel.data.designData then

local sundriseData=isometricMapSystem:getAllSundriesDataByType(sfId,sundriseType.eStillEnemy)
local eventData=emergenciesControl:getEventMonsterDatas()or{}

for ubdId,v in pairs(zongmenModel.data.designData)do

local entityId=v.entityId
if entityId and not zongmenModel.data.designStorageData[ubdId]then
local sdata
if sfId==mapIdType.xianmeng then
sdata=xianmengModel:getStorageData(ubdId)
else
sdata=zongmenModel:getStorageBuilding(ubdId)
end
if sdata then
table.insert(rebuildData,{ubdId,v.x,v.y,v.orientation,v.modelIndex or 1})
else
if zongmenModel:getBuildingData(ubdId)then
table.insert(designData,{ubdId,v.x,v.y,v.orientation,v.modelIndex or 1})
end
end

local rect=_MapManager.GetObjectRectInMap(entityId)
if rect then
local sx=rect[1]
local sy=rect[2]
local ex=sx+rect[3]-1
local ey=sy+rect[4]-1


for k,vv in pairs(sundriseData)do
if isometricMapSystem:checkOverlap(sx,sy,ex,ey,vv.x,vv.y,vv.rx,vv.ry)then
local posType=sundriseCreateControl:getSundriesPosType(vv.serverGuid)

if posType==sundrisePosType.eRandom then
table.insert(needRandomSundriseList,vv.serverGuid)
else
table.insert(fugaiData,ubdId)
end
end
end

for k,vv in pairs(eventData)do
if isometricMapSystem:checkOverlap(sx,sy,ex,ey,vv.x,vv.y,vv.x,vv.y)then
table.insert(needRandomEventList,k)
end
end
if v.build_id~=gongMenId then
if layoutRoad then
for k,vv in pairs(layoutRoad)do
if isometricMapSystem:checkOverlap(sx,sy,ex,ey,vv[1],vv[2],vv[1],vv[2])then
layoutRoad[k]=nil
end
end
end
end
end
end
end
end

if zongmenModel.data.designBuildingMapData then
for i,v in pairs(zongmenModel.data.designBuildingMapData)do
local rect=_MapManager.GetObjectRectInMap(v.entityId)
if rect then
local sx=rect[1]
local sy=rect[2]
local ex=sx+rect[3]-1
local ey=sy+rect[4]-1

if v.build_id~=gongMenId then
if layoutRoad then
for k,vv in pairs(layoutRoad)do
if isometricMapSystem:checkOverlap(sx,sy,ex,ey,vv[1],vv[2],vv[1],vv[2])then
layoutRoad[k]=nil
end
end
end
end

for k,vv in pairs(gongMenData)do
local cfg=cfgHelper.get(cfg_monijybuildconfig_get,gongMenId)
local bx=cfg.buid_size[1]
local by=cfg.buid_size[2]
local cx=bx
local cy=by
local flip=vv[3]==1
if flip then
cx=by
cy=bx
end
if isometricMapSystem:checkOverlap(sx,sy,ex,ey,vv[1],vv[2],cx+vv[1]-1,cy+vv[2]-1)then

gongMenData[k]=nil
end
end
end

end
end

local repairDatas=isometricMapSystem:getRepairDatas(mapIdType.zhufeng_design)
if repairDatas then
for index,repairData in ipairs(repairDatas)do
local rect=_MapManager.GetObjectRectInMap(repairData.guid)
if rect then
local sx=rect[1]
local sy=rect[2]
local ex=sx+rect[3]-1
local ey=sy+rect[4]-1

if layoutRoad then
for k,vv in pairs(layoutRoad)do
if isometricMapSystem:checkOverlap(sx,sy,ex,ey,vv[1],vv[2],vv[1],vv[2])then
layoutRoad[k]=nil
end
end
end
end
end
end

if layoutRoad then

local l={}

for k,v in pairs(roadDatas)do
if layoutRoad[k]and v.style==layoutRoad[k][4]and v.type==layoutRoad[k][3]then
layoutRoad[k]=nil
else
local key=FMT.fmt("{0}_{1}_{2}",v.x,v.style,v.type)
l[key]=l[key]or{}

local haveTop=false

for i,v2 in ipairs(l[key])do
if v2.list then
for i,v3 in ipairs(v2.list)do
if v3.y==v.y-1 then
haveTop=true
table.insert(v2.list,v)
break
end
end
end
end
if not haveTop then
table.insert(l[key],{list={v},x=v.x,y=v.y})
end
end
end

if next(l)then
for k,kv in pairs(l)do
for i,v in pairs(kv)do
if v.list then



table.insert(roadData,{v.x,v.y,1,#v.list-1})
end
end
end
end
end


if#fugaiData>0 then
UIManager.error("建筑摆放出现重合，请重新摆放应用布局")
for i,ubdId in ipairs(fugaiData)do
isometricMapSystem:onDesignStore(sfId,ubdId)
end
UIManager:callWindowFunc("UILayoutEditWin","refreshSortCount")
return
end



local roadMoney={}
if layoutRoad then
for k,v in pairs(layoutRoad)do
table.insert(buildRoadData,{v[1],v[2],v[3],v[4]})
local rcfg=cfgHelper.get1(cfg_roadstyleconfig_get,v[3])
if gongMenData[k]and rcfg.func~=1 then
local cfg=cfgHelper.get(cfg_monijybuildconfig_get,gongMenId)
local bx=cfg.buid_size[1]
local by=cfg.buid_size[2]
local cx=bx
local cy=by
local flip=gongMenData[k][3]==1
if flip then
cx=by
cy=bx
end
if isometricMapSystem:checkOverlap(v[1],v[2],v[1],v[2],gongMenData[k][1],gongMenData[k][2],cx+gongMenData[k][1]-1,cy+gongMenData[k][2]-1)then

gongMenData[k]=nil


end
end

local road_price=rcfg.cost and rcfg.cost[1]
if road_price then
roadMoney[road_price[1]]=(roadMoney[road_price[1]]or 0)+road_price[2]
end
end
end
local bSends={}
if next(gongMenData)then
local lcfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,gongMenId,1)

local mdata=isometricMapSystem:getModelByStatus(gongMenId,1,0,planStatus.eDefault)
for k,v in pairs(gongMenData)do
if lcfg.uplevel_cost and lcfg.uplevel_cost[1]then
roadMoney[lcfg.uplevel_cost[1][1]]=(roadMoney[lcfg.uplevel_cost[1][1]]or 0)+lcfg.uplevel_cost[1][2]
end
table.insert(bSends,{sfId,gongMenId,v[1],v[2],v[3],1,0,int64.zero})
end

end


if#designData==0 and#rebuildData==0 and#strageData==0 and#buildRoadData==0 and#roadData==0 then
isometricMapSystem.leaveDesignCall=function()
UILayoutControl:closeUI(true,false)
end
ims_design_layout:saveMyMapData(zongmenModel.data.designData,zongmenModel.data.designStorageData,zongmenModel.data.designRoadData)
zongmenModel.data.designData={}
zongmenModel.data.designStorageData={}
zongmenModel.data.designRoadData=nil
zongmenModel.data.designSundriesData={}
userActorArraySetting.set(ACTOR_SETTING_TYPE.eZongMenDesign,'designData',{})
userActorArraySetting.set(ACTOR_SETTING_TYPE.eZongMenDesign,'storageData',{})
userActorArraySetting.set(ACTOR_SETTING_TYPE.eZongMenDesign,'roadData',nil)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZongMenDesign)
isometricMapSystem:endDesign()
UIManager.info("布局应用成功")
return
end

if next(roadMoney)then
local moneyStr=''
local moneyList={}
for i,v in pairs(roadMoney)do
local iconName=iconHelper.getIconName(i)
local iconStr=chatEmotHelper.getIconEmotMesg(iconName,32)
moneyStr=FMT.fmt("{0}{1}{2}",moneyStr,iconStr,v)
moneyList[#moneyList+1]={i,v}
end
local ret,moneyType=moneyModel.checkEnoughMoneyX(moneyList)
if not ret then
moneyStr=FMT.cfmt(FONT_COLOR.eRedColor,moneyStr)
end
local str=FMT.fmt("将消耗{0}，是否保存应用此次修改的布局？",moneyStr)
local showdata=
{
type='UIDialougeWithIcon',
title='提示',
content=str,
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
local ret,moneyType=moneyModel.checkEnoughMoneyX(moneyList)
if ret then
zongmenModel.needRandomSundriseList=needRandomSundriseList
zongmenModel.needRandomEventList=needRandomEventList
socketManager:send_3_58(mapIdType.zhufeng,#designData,designData,#strageData,strageData,#roadData,roadData,#rebuildData,rebuildData,#buildRoadData,buildRoadData)
if next(gongMenData)then
local sendsGongMen={}
table.insert(sendsGongMen,{1,#bSends,bSends})


zongmenModel.data.sendsGongMen=sendsGongMen
end
else
local moneyName=moneyModel.getMoneyName(moneyType)
local err=FMT.fmt('{0}不足',moneyName)
UIManager.error(err)
end

end,
showclosebtn=true,
}
local comfirmDialogIcon=UIDialogManager.newDialog(showdata)
comfirmDialogIcon:show()
else

local showdata=
{
type='UIDialouge',
title='提示',
content='是否保存应用此次修改的布局？',
canceltext='取消',
oktext='确定',
allowclickBG=true,
okcallback=function(...)
zongmenModel.needRandomSundriseList=needRandomSundriseList
zongmenModel.needRandomEventList=needRandomEventList
socketManager:send_3_58(mapIdType.zhufeng,#designData,designData,#strageData,strageData,#roadData,roadData,#rebuildData,rebuildData,#buildRoadData,buildRoadData)
end,

showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()

end
end

function zongmenControl:setSundriseMonPos(needRandomSundriseList)
if needRandomSundriseList and next(needRandomSundriseList)~=nil then
for i,rand_item_id in ipairs(needRandomSundriseList)do
local areaId,rpos=sundriseCreateControl:getAPosCanPlace(mapIdType.zhufeng_design)
if areaId then
local posList=_MapManager.Vector3IntToArray(rpos)
local newPos={posList[1],posList[2]}
sundriseCreateControl:setSundriesSavePos(rand_item_id,areaId,newPos)
sundriseCreateControl:setSundriesHandleDataPos(rand_item_id,areaId,newPos)
sundriseCreateControl:refreshSundriesPos(rand_item_id)
end
end
sundriseCreateControl:saveData()
end
end

function zongmenControl:setEventMonPos(needRandomEventList)
if needRandomEventList and next(needRandomEventList)~=nil then
for i,entityId in ipairs(needRandomEventList)do
local areaId,rpos=sundriseCreateControl:getAPosCanPlace(mapIdType.zhufeng_design)
if areaId then
local posList=_MapManager.Vector3IntToArray(rpos)
emergenciesControl:setMonsterNesPos(entityId,posList[1],posList[2])
emergenciesControl:refreshMonsterPos(entityId)
end
end
end
end

local errType=
{
mapOpen=2,
buildingNotExist=3,
buildingNotBuild=4,
buildingNotConfig=5,
buildingCantMove=6,
buildingGridDelFail=7,
buildingCantStorage=8,
buildingNotOpen=9,
storagebuildingWork=10,
storageNotPass=11,
storageMax=12,
movePosErr=13,
}

local errFunc=
{
[errType.mapOpen]={errTips="山峰未开启",},
[errType.buildingNotExist]={errDialog="建筑不存在 ubid:{0}",},
[errType.buildingNotBuild]={errDialog="建筑未创建 ubid:{0}",},
[errType.buildingCantMove]={errDialog="建筑配置不存在 ubid:{0}",},
[errType.buildingGridDelFail]={errDialog="建筑不可移动 ubid:{0}",},
[errType.buildingCantStorage]={errDialog="建筑格子剔除失败 ubid:{0}",},
[errType.buildingNotOpen]={errDialog="建筑不可收纳 ubid:{0}",},
[errType.storagebuildingWork]={errDialog="收纳建筑生产中 ubid:{0}",},
[errType.storageNotPass]={errDialog="收纳建筑校验不通过 ubid:{0}",},
[errType.storageMax]={errTips="收纳容量不足",},
[errType.movePosErr]={errDialog="移动建筑新坐标存在问题 ubid:{0}",storageBuilding=true},
}

function zongmenControl.recv_3_58(a)
local sfId,len,lay_list,collect_len,collect_list,pos_len,roadposlist,rebuildLen,rebuildData=a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9]
local new_pos_len,newRoadPosList=a[10],a[11]

local err_build,err_res=a[12],a[13]or 1

if err_res>1 then
local errF=errFunc[err_res]
if errF then
if errF.errTips then
UIManager.error(errF.errTips)
end
if errF.errDialog then
loggerUtil.logErrFMT(errF.errDialog,err_build)
end
if errF.storageBuilding then
isometricMapSystem:onDesignStore(sfId,err_build)
UIManager:callWindowFunc("UILayoutEditWin","refreshSortCount")
end
end
return
end

zongmenControl:setSundriseMonPos(zongmenModel.needRandomSundriseList)
zongmenControl:setEventMonPos(zongmenModel.needRandomEventList)
zongmenModel.needRandomSundriseList=nil
zongmenModel.needRandomEventList=nil



if pos_len>0 or new_pos_len>0 then
if pos_len>0 then
local mdata=zongmenModel:getMountainData(sfId)
if mdata then
local roadDatas=mdata.roadDatas

if api_Available_SetCellCoverTypeByPosList()then
if roadDatas then
local posArr={}
for i,v in pairs(roadDatas)do
table.insert(posArr,v.x)
table.insert(posArr,v.y)
table.insert(posArr,0)
end
_MapManager.SetCellCoverTypeByPosList(sfId,posArr,0)
end
end

for i,v in ipairs(roadposlist)do
local x=v.param_1
local y=v.param_2
local key=FMT.fmt('{0}_{1}',x,y)
roadDatas[key]=nil
for i=1,v.param_4 do
if v.param_3==0 then
key=FMT.fmt('{0}_{1}',x-i,y)
roadDatas[key]=nil
elseif v.param_3==1 then
key=FMT.fmt('{0}_{1}',x,y+i)
roadDatas[key]=nil
end
end
end
end
end
if new_pos_len>0 then
zongmenModel:addMountainRoadDatas(sfId,newRoadPosList)
isometricMapSystem:receiveSundriesByPosList(sfId,newRoadPosList)
end

_MapManager.Erase(sfId,mapLayer.Road1)
_MapManager.Erase(sfId,mapLayer.Data)
end

timeEventController.delayDo(0.5,function()
if collect_len>0 then
for i,bdId in ipairs(collect_list)do
zongmenControl.recv_storage(sfId,bdId)
end
end
end)

timeEventController.delayDo(1,function()

if len>0 then
local moveList={}
for i,v in ipairs(lay_list)do

local data=zongmenModel:getBuildingData(v.un_build_id)
if data then

if data.entityId then
isometricMapSystem:receiveSundriesByEntityArea(data.entityId)

_MapManager.PickUpFromMap(data.entityId)
_MapManager.SetObjectPlaceCheckID(data.entityId,6)
end
data.x=v.new_pos_x
data.y=v.new_pos_y
data.orientation=v.orientation
zongmenModel:setBuildingData(sfId,v.un_build_id,data)


table.insert(moveList,{v.un_build_id,data.entityId})
end
end
for i,v in ipairs(moveList)do
isometricMapSystem:onApplyDesignMove(sfId,v[1])
if v[2]then
isometricMapSystem:receiveSundriesByEntityArea(v[2])
end
end
for i,v in ipairs(moveList)do
if v[2]then
_MapManager.SetObjectPlaceCheckID(v[2],conditionConfig.place)
end
end
end

end)

timeEventController.delayDo(1.5,function()
local roadDatas=zongmenModel:getMountainRoadDatas(sfId)
if roadDatas then
isometricMapSystem:drawRoad(sfId,roadDatas)
end
isometricMapSystem:handleApplyRoad()
isometricMapSystem:setLinkRoadData(sfId)

if zongmenModel.data.sendsGongMen then
for i,v in ipairs(zongmenModel.data.sendsGongMen[1][3])do
local pos={v[3],v[4],0}
local flip=v[5]
isometricMapSystem:addFastBuildData(objectType.ePlaceObject,946,flip,pos,conditionConfig.place)
end
socketManager:send_3_24(#zongmenModel.data.sendsGongMen,zongmenModel.data.sendsGongMen)
end
end)

ims_design_layout:saveMyMapData(zongmenModel.data.designData,zongmenModel.data.designStorageData,zongmenModel.data.designRoadData)

zongmenModel.data.designData={}
zongmenModel.data.designStorageData={}
zongmenModel.data.designRoadData=nil
zongmenModel.data.designSundriesData={}
userActorArraySetting.set(ACTOR_SETTING_TYPE.eZongMenDesign,'designData',{})
userActorArraySetting.set(ACTOR_SETTING_TYPE.eZongMenDesign,'storageData',{})
userActorArraySetting.set(ACTOR_SETTING_TYPE.eZongMenDesign,'roadData',nil)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZongMenDesign)



isometricMapSystem.leaveDesignCall=function()
UILayoutControl:closeUI(true,false)
end
isometricMapSystem:endDesign()

UIManager.info("布局应用成功")


end

function zongmenControl.recv_3_59(sfId,len,patchInfo)
if len>0 then
for i,v in ipairs(patchInfo)do
local storageBuilding=zongmenModel:getStorageBuilding(v.un_build_id)
local data=table.deepCopy(storageBuilding)
data.x=v.new_pos_x
data.y=v.new_pos_y
data.orientation=v.orientation

zongmenModel:setBuildingData(sfId,v.un_build_id,v)


local mdata=zongmenModel:getMountainData(sfId)
if mdata then
local building=zongmenModel.data.storageDatas[v.un_build_id]
zongmenModel.data.storageDatas[v.un_build_id]=nil
if building then
zongmenModel:refreshSpecialBuilding(building.build_id)
end
end

local bdata=zongmenModel:getBuildingData(v.un_build_id)
local guid=isometricMapSystem:createABuildingToMap(sfId,bdata,nil,true)
isometricMapSystem:addNameHud(guid,bdata.build_id)
isometricMapSystem:addQiYuHud(guid,bdata.build_id)
zongmenModel:setBuildingEntityId(sfId,v.un_build_id,guid)
local entityId=guid
data.entityId=entityId
isometricMapSystem:receiveSundriesByEntityArea(guid)
end
end
end

function isometricMapSystem:ChangeDesignTips(okcallback)
local check=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eLayoutEditorNotYetApply)
if not check then

local haveDesignData=zongmenModel.data.designData and next(zongmenModel.data.designData)~=nil
if haveDesignData or(zongmenModel.data.designStorageData and next(zongmenModel.data.designStorageData)~=nil)then
local content='尚未进行<color=#ed7d31>应用布局 </color>,宗门布局不会改变,\n确定退出设计模式吗?\n<size=20>(当前布局已记录，可随时返回设计模式继续修改)</size>'
local func=function()
self.leaveDesignCall=okcallback
self:endDesign()
end
UIDialogManager.getConfirmDialog3(nil,content,func,REPEAT_TYPE.eLayoutEditorNotYetApply,nil,nil)
else
self.leaveDesignCall=okcallback
self:endDesign()
end
else
self.leaveDesignCall=okcallback
self:endDesign()
end

end
