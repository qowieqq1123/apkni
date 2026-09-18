







local mark_orthographic_size=nil
local mark_cameraPos=nil

function xianzhanController:onRoomClick(roomId)
local data=xianzhanModel:getRoomDataByRoomId(roomId)
if data==nil then return end
local unLock=data.unlockStatus==1
local isReBuilding=xianzhanModel:isBuildingModel()
if isReBuilding then
if xianzhanController:isInBuilding(roomId)then
UIManager.info('该房间正在改造中')
return
end
if data.customerId>0 then
if data.ybFlag==0 then
UIManager.info('该房间已被访客预定')
else
UIManager.info('此房间有客人居住')
end
return
end

if unLock then
local roomType=data.zhuangxiuTypeId
local rebuildRoomType=xianzhanModel:getRebbuildRoomType()
if rebuildRoomType==nil then
return
end
if rebuildRoomType==roomType then
UIManager.info('已经是该类型房间')
return
end
if not xianzhanModel:isZXUnLock(rebuildRoomType)then
UIManager.error('该改建类型未解锁')
local flag,lockItemId,need=xianzhanModel:checkUnLockCond(rebuildRoomType)
if not flag and gainControl:showGainWin(lockItemId,need)then return end
itemsComponentHelper.onItemClickEx(lockItemId,-1,-1,nil)
return
end

local rbcfg=cfgHelper.get1(cfg_xianzhanzhuangxiuconfig_get,rebuildRoomType)
if not xianzhanModel.checkRebuildCondition(rbcfg,true,true)then
return
end


local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXianZhanGaiJianTips)
if not flag then
local show_data=
{
title='提示',
buildname=rbcfg.name,
costid=rbcfg.useItems[1][1],
needCnt=rbcfg.useItems[1][2],
thisroomId=roomId,
thisrebuildRoomType=rebuildRoomType,
}
UIManager:showWindow('UIDialougeXianZhantips',show_data)
else
xianzhanController:req_room_rebuild(roomId,rebuildRoomType)
end
else
UIManager.info('该房间需解锁')
end
else
if unLock then

if data.customerId>0 then
local entity=xianzhanController:getFangKeEntity(roomId)
if data.ybFlag==0 then
UIManager.info('宾客正在门口等待')
xianzhanController:moveCameraToYB()
elseif entity~=nil and entity.doingyb==true then
UIManager.info('等待访客到达房间')
else
xianzhanController:moveCameraToRoom(roomId)
end
else
UIManager.info('暂无访客')
end
else

UIManager:showWindow('UIXianZhanUnLockWin',{roomId=roomId,showMoney=true})
end
end
end

function xianzhanController:moveCameraToRoom(roomId)
mark_orthographic_size=_MapManager.GetCameraOrthographicSize()
local cameraPos=_MapManager.GetCameraPosition()
mark_cameraPos=cameraPos
local sfcfg=cfgHelper.get1(cfg_monijysfconfig_get,mapIdType.xianzhan)

local def_orthographic_size=sfcfg.def_orthographic_size
if webGLHelper:isRunMiniGame()then
def_orthographic_size=sfcfg.def_orthographic_size_webgl
end
local entity=xianzhanController:getFangKeEntity(roomId)
local guid=entity.guid
local temp_pos=_MapManager.GetTilemapObjectPosition(guid)
local enity_pos=_MapManager.GetCellCenterWorld(mapIdType.xianzhan,temp_pos,mapLayer.Data)
local movepos=Vector3(enity_pos.x,enity_pos.y,cameraPos.z)
local min=def_orthographic_size[2]-1
isometricMapSystem:setchangeCameraOrthoSize_min(min)
isometricMapSystem:setCameraOrthoSize(min,0.3,nil,nil)
local func=function()
xianzhanController:showInteractWin({roomId})
end
isometricMapSystem:moveCameraToPosition(movepos,true,func,0.3)
end

function xianzhanController:resetCameraToRoom(roomId)
if mark_cameraPos~=nil then
local sfcfg=cfgHelper.get1(cfg_monijysfconfig_get,mapIdType.xianzhan)
local def_orthographic_size=sfcfg.def_orthographic_size
if webGLHelper:isRunMiniGame()then
def_orthographic_size=sfcfg.def_orthographic_size_webgl
end
local min=def_orthographic_size[2]
local func=function()
isometricMapSystem:setchangeCameraOrthoSize_min(min)
end
isometricMapSystem:setCameraOrthoSize(mark_orthographic_size,0.3,func,nil)
isometricMapSystem:moveCameraToPosition(mark_cameraPos,true,nil,0.3)

mark_cameraPos=nil
mark_orthographic_size=nil
end
end

function xianzhanController:onShopClick()
if xianzhanModel:isBuildingModel()then return end
UIManager:showWindow('UIXianZhanShopWin')
end

function xianzhanController:onCommonShopClick()
if xianzhanModel:isBuildingModel()then return end
funcShopController:openShopWin({shopId=eFuncShopType.eXianZhan_DaoJu})
end