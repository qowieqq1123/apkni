








function xianmengController:onAppStart_building()
socketManager:register_receiver(20,51,xianmengController.do_protocol_20_51)
socketManager:register_receiver(20,52,xianmengController.do_protocol_20_52)
socketManager:register_receiver(20,53,xianmengController.do_protocol_20_53)
socketManager:register_receiver(20,54,xianmengController.do_protocol_20_54)
socketManager:register_receiver(20,55,xianmengController.do_protocol_20_55)
socketManager:register_receiver(20,56,xianmengController.do_protocol_20_56)
socketManager:register_receiver(20,57,xianmengController.do_protocol_20_57)
socketManager:register_receiver(20,58,xianmengController.do_protocol_20_58)
socketManager:register_receiver(20,59,xianmengController.do_protocol_20_59)
socketManager:register_receiver(20,60,xianmengController.do_protocol_20_60)
socketManager:register_receiver(20,61,xianmengController.do_protocol_20_61)

end

function xianmengController:onLeaveState_building(isReconnet)
if not isReconnet then
xianmengModel:clearAllRepairCollect()
xianmengModel:clearMountainData()
self.autoBuild=nil
end
end


function xianmengController:reqXMMountData()
socketManager:send_20_51()
end


function xianmengController:reqXMBuildingStart(sfId,buildId,posx,posy,orientation,model_id)
socketManager:send_20_52(sfId,buildId,posx,posy,orientation,model_id)
end


function xianmengController:reqXMBuildingComplete(sfId,buildGuid)
socketManager:send_20_53(sfId,buildGuid)
end


function xianmengController:reqXMRepairCollect(sfId,buildId,pos_idx,times)
socketManager:send_20_54(sfId,buildId,pos_idx,times or 1)
end


function xianmengController:reqXMNormalCollect(sfId,buildGuid,times)
socketManager:send_20_55(sfId,buildGuid,times or 1)
end


function xianmengController:reqXMBuildingMove(sf_id,build_guid,pos_x,pos_y,orientation)

local guids=self:checkSwapBuild(sf_id,build_guid,pos_x,pos_y,orientation)
local checkSwap=#guids
if checkSwap==0 then
socketManager:send_20_56(sf_id,build_guid,pos_x,pos_y,orientation)
elseif checkSwap==1 then
xianmengController:reqXMBuildingSwap(sf_id,build_guid,guids[1],pos_x,pos_y,orientation)
else

end
end


function xianmengController:reqXMBuildingStore(sf_id,build_guid)
socketManager:send_20_57(sf_id,build_guid)
end


function xianmengController:reqXMBuildingPlace(sf_id,build_guid,pos_x,pos_y,orientation,model_id)
socketManager:send_20_58(sf_id,build_guid,pos_x,pos_y,orientation,model_id)
end


function xianmengController:reqXMBuildingSwap(sf_id,src_guid,tar_guid,pos_x,pos_y,orientation)
socketManager:send_20_59(sf_id,src_guid,tar_guid,pos_x,pos_y,orientation)
end

function xianmengController.do_protocol_20_51(sfItem)
local mapId=sfItem.sf_id>0 and sfItem.sf_id or mapIdType.xianmeng
xianmengModel:fakeMountainData(mapId,sfItem)

xianmengModel:setRepairCollect(sfItem.repairGatherList)
xianmengModel:setNormalCollect(sfItem.normalGatherList)
xianmengModel:setStorageData(sfItem.collectbuildList,true)
xianmengModel:setHeJu(sfItem.hejuList)
xianmengController:refreshAllHUD(mapId)
reddotControl.on_xianmeng_collectrepair_changed()
end

function xianmengController.do_protocol_20_52(sfId,buildInfo,actorId)
local data=xianmengModel:create_MonijyBuildStruct_By_MonijyBuildStruct3(buildInfo)
local ubdId=data.un_build_id
if xianmengModel:isHeJuBuild(data.build_id)then
xianmengModel:addHeJu(actorId,ubdId)
end

zongmenModel:setRepairStatusByPos(sfId,data.build_id,repairStatus.eUnderRepair,data.un_build_id,data.x,data.y)

zongmenControl.recv_3_43(sfId,ubdId,data)
zongmenControl.recv_3_31_imp(sfId,ubdId,timeHelper.getServerShortTime(),0,actorId)


if actorId==playerModel:getActorID()then
UIManager.info('建造成功')
end
end

function xianmengController.do_protocol_20_53(sfId,buildGuid)
local bdData=zongmenModel:getBuildingData(buildGuid)
zongmenControl.recv_3_32(sfId,buildGuid,bdData.opentime,0)
end

function xianmengController.do_protocol_20_54(argstable)
local sfId=argstable[1]
local build_id=argstable[2]
local pos_idx=argstable[3]
local collect_num=argstable[4]
local total=argstable[5]
local actor=argstable[6]
local isSelf=actor==playerModel:getActorID()
xianmengModel:modifyRepairCollectNum(build_id,pos_idx,total)
if isSelf then
xianmengModel:addRepairCollectDaily(pos_idx,collect_num)
end


AudioManager.playAudio(543)

UIManager:invokeUIMethod("UIXMRepairWin","afterCollect",pos_idx,isSelf)
local repairData=isometricMapSystem:getRepairDataByPosIdx(sfId,pos_idx)
if repairData then
hudControl:refreshBuildingStatusHUD(repairData.rpId)
end
reddotControl.on_xianmeng_collectrepair_changed()
end

function xianmengController.do_protocol_20_55(sfId,buildguid,collect_num,total,actor)
local isSelf=actor==playerModel:getActorID()
xianmengModel:modifyNormalCollectNum(buildguid,total)
if isSelf then
xianmengModel:addNormalCollectDaily(buildguid,collect_num)
end
end

function xianmengController.do_protocol_20_56(args)
local sf_id=args[1]
local build_guid=args[2]
local pos_x=args[3]
local pos_y=args[4]
local orientation=args[5]
local actor=args[6]
zongmenControl.recv_3_35_imp(sf_id,build_guid,pos_x,pos_y,orientation,actor)
end

function xianmengController.do_protocol_20_57(sf_id,un_build_id,actor)
local data=zongmenModel:getBuildingData(un_build_id)

zongmenModel:deleteBuilding(sf_id,un_build_id)
xianmengModel:addStorageData(data.un_build_id,data.build_id,data.level)

hudControl:removeProgressData(un_build_id)
isometricMapSystem:applyStorage(data,actor)
hudControl:clearHUDByEntityID(data.entityId)

isometricMapSystem:removeUnlinkRecord(un_build_id)
isometricMapSystem:conversionUnlinkData()


if actor==playerModel:getActorID()then
UIManager.info('建筑已成功收纳')
end

notifySystem:postNotify(notifyConfig.building_event,buildingEvent.storageBuilding,sf_id,un_build_id)
end

function xianmengController.do_protocol_20_58(sf_id,buildInfo,actor)
local bdData=xianmengModel:create_MonijyBuildStruct_By_MonijyBuildStruct3(buildInfo)
zongmenControl.recv_3_43(sf_id,buildInfo.buildguid,bdData)

xianmengModel:delStorageData(buildInfo.buildguid)

local building=isometricMapSystem:getPreviewBuilding()
if building==nil or building.id~=bdData.build_id or building.level~=bdData.level then
local entityId=isometricMapSystem:createABuildingToMap(sf_id,bdData)
zongmenModel:setBuildingEntityId(sf_id,bdData.un_build_id,entityId)
else
if actor~=playerModel:getActorID()then
UIManager.info('该建筑已被其他玩家收纳')
end
zongmenModel:setBuildingEntityId(sf_id,bdData.un_build_id,building.guid)
isometricMapSystem:applyBuild(buildInfo.buildguid)
end

isometricMapSystem:setBuildingLinkRoad(sf_id,bdData.un_build_id)
hudControl:addProgressData(sf_id,bdData.un_build_id,true)




notifySystem:postNotify(notifyConfig.building_event,buildingEvent.placeBuilding,sf_id,bdData.un_build_id)
end

function xianmengController.do_protocol_20_59(args)
local sfId=args[1]
local srcGuid=args[2]
local tarGuid=args[3]
local srcX=args[4]
local srcY=args[5]
local scrOrientation=args[6]
local actor=args[7]

local scrBuild=zongmenModel:getBuildingData(srcGuid)
local tarBuild=zongmenModel:getBuildingData(tarGuid)

local tarX=scrBuild.x
local tarY=scrBuild.y
local tarOrientation=tarBuild.orientation
_MapManager.PickUpFromMap(tarBuild.entityId)
_MapManager.SetPosition(tarBuild.entityId,_MapManager.ToVector3Int(tarX,tarY,0))

zongmenControl.recv_3_35(sfId,srcGuid,srcX,srcY,scrOrientation)
zongmenControl.recv_3_35(sfId,tarGuid,tarX,tarY,tarOrientation)
end

function xianmengController.do_protocol_20_60(sfId,len,list)
if sfId==mapIdType.xianmeng then
xianmengModel:setStorageData(list)
end
end

function xianmengController.do_protocol_20_61(sfId,build_guid)
local bdData=zongmenModel:getBuildingData(build_guid)
if xianmengModel:isHeJuBuild(bdData.build_id)then
xianmengModel:delHeJu(build_guid)
end
zongmenControl.recv_3_36(sfId,build_guid)
end

function xianmengController:checkHeJuAutoBuild()

if self.autoBuild==nil and xianmengModel:hasXM()and zongmenModel:getMountainData(mapIdType.xianmeng)~=nil and not xianmengModel:hasSelfHeJu()then
self.autoBuild=true
end
end

function xianmengController:doHeJuAutoBuild()
if self.autoBuild then
local id=cfgHelper.get2(cfg_guildbaseconfig_get,1,"hejubuildid")
local level=1
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,id)
local mdata=isometricMapSystem:getModelByStatus(id,level,0,planStatus.eDefault)
local bx=cfg.buid_size[1]
local by=cfg.buid_size[2]
local offset=isometricMapSystem:countOffset(bx,by)
local pCfgId=cfg.pCfgId or conditionConfig.showPlace
local mapId=zongmenModel:getMountainId()
local pos=_MapManager.ScreenPointToCell(mapId,Vector3.New(_Screen.width*0.5,_Screen.height*0.5,0),0,mapLayer.Data)
local entity=isometricMapSystem:createBuildingEntity(objectType.ePlaceObject,mapId,id,mdata.model,mdata.slots,SortingLayers.ITDrag,false,false,mdata.scale,pos,offset,pCfgId)
local needRoad=cfg.is_connect_road==1
local radius=100
isometricMapSystem:findAndMoveToPlacePos(entity,pos,needRoad,pCfgId,radius)
pos=_MapManager.GetTilemapObjectPosition(entity)
_MapManager.PickUpFromMap(entity)
_MapManager.RemoveTilemapObject(entity)
pos=_MapManager.Vector3IntToArray(pos)
xianmengController:reqXMBuildingStart(mapId,id,pos[1],pos[2],0,1)
self.autoBuild=false
return true
end
return false
end

function xianmengController:refreshAllHUD(mapId)
local buildingDatas=zongmenModel:getAllBuildingData()
for un_build_id,bdData in pairs(buildingDatas)do
hudControl:refreshBuildingStatusHUD(un_build_id)
end
local check=isometricMapSystem:getAllRepairData()
if check then
local repairDatas=isometricMapSystem:getRepairDatas(mapId)

for index,repairData in ipairs(repairDatas)do
hudControl:refreshBuildingStatusHUD(repairData.rpId)
local bdcfg=cfgHelper.get1(cfg_monijybuildconfig_get,repairData.id)
if zongmenControl:checkMinNeedLevel(bdcfg,mapId)then
_MapManager.SetFadeToColor(repairData.guid,Color.New(1,1,1,1),0,nil)
end
end
end
end








function xianmengController:clearMapEntitys()
xianmengController:onLeaveHome_ai(true)
local mapId=mapIdType.xianmeng
local buildingDatas=zongmenModel:getAllBuildingData(mapId)
for un_build_id,bdData in pairs(buildingDatas)do
hudControl:removeProgressData(un_build_id)
if bdData.entityId then
hudControl:clearHUDByEntityID(bdData.entityId)
_MapManager.RemoveTilemapObject(bdData.entityId)
end
isometricMapSystem:setBenefitBuffBuildingById(mapId,un_build_id,true)
buildingEffectControl:stopLoopEffect(mapId,un_build_id)
end
local repairDatas=isometricMapSystem:getRepairDatas(mapId)
for index,repairData in ipairs(repairDatas)do
if repairData.guid then
_MapManager.RemoveTilemapObject(repairData.guid)
hudControl:clearHUDByEntityID(repairData.guid)
isometricMapSystem:removeRepairData(mapId,repairData.guid)
end
end
tiandaoshuController:removeBuildingModel(mapId)
end

function xianmengController:clearMoniJYData(mapId)
xianmengController:onLeaveHome_ai(true)
local buildingDatas=zongmenModel:getAllBuildingData(mapId)
for un_build_id,bdData in pairs(buildingDatas)do
hudControl:removeProgressData(un_build_id)
if bdData.entityId then
hudControl:clearHUDByEntityID(bdData.entityId)
end
zongmenModel:deleteBuilding(mapId,un_build_id)
isometricMapSystem:applyDelete(bdData)
isometricMapSystem:setBenefitBuffBuildingById(mapId,un_build_id,true)
buildingEffectControl:stopLoopEffect(mapId,un_build_id)
end
local repairDatas=isometricMapSystem:getRepairDatas(mapId)
for index,repairData in ipairs(repairDatas)do
_MapManager.RemoveTilemapObject(repairData.guid)
hudControl:clearHUDByEntityID(repairData.guid)
isometricMapSystem:removeRepairData(mapId,repairData.guid)
end
xianmengModel:clearAllRepairCollect()
xianmengModel:clearMountainData()
end

function xianmengController:checkSwapBuild(sf_id,build_guid,pos_x,pos_y,orientation)
local bdDatas=zongmenModel:getAllBuildingData(sf_id)
local srcData=bdDatas[build_guid]
local sRect=_MapManager.GetObjectRectInMap(srcData.entityId)
local sx1=sRect[1]
local sy1=sRect[2]
local sx2=sx1+sRect[3]-1
local sy2=sy1+sRect[4]-1
local guids={}
for un_build_id,tarData in pairs(bdDatas)do
if un_build_id~=build_guid then
local tRect=_MapManager.GetObjectRectInMap(tarData.entityId)
local tx1=tRect[1]
local ty1=tRect[2]
local tx2=tx1+tRect[3]-1
local ty2=ty1+tRect[4]-1
if isometricMapSystem:checkOverlap(sx1,sy1,sx2,sy2,tx1,ty1,tx2,ty2)then
table.insert(guids,un_build_id)
end
end
end
return guids
end
