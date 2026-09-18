function systemZongMenController:createEntity(data)
local serial=data.serial
local unitKey=systemZongMenModel:convertUnitKey(serial)
local position=data.position
local luaData={eWorldUnitTpye.SYSTEMZM,serial}
local modelId=systemZongMenModel:getModelRes(data.worldId,data.level,data.id)
if data.flag==systemZongMenFightFlagType.eExpel then
local ruinModel=cfgHelper.get2(cfg_syssectbaseconfig_get,1,"ruinModel")
modelId=ruinModel[data.worldId]or ruinModel[0]
end
local modelSetting=worldModel:getModelSettings(modelId,eWorldUnitTpye.SYSTEMZM)
local hudId=systemZongMenModel:getHUDRes(data.id,data.worldId)
local hudSettings=worldModel:getHUDSetting(hudId)
worldController:pushUnit(unitKey,position,luaData,modelSetting,hudSettings,nil,true)
worldController:setUnitFlipX(unitKey,data.flip or false)
local cfg=cfgHelper.get1(cfg_syssectconfig_get,data.id)
if cfg.anim then
worldController:setAnimation(unitKey,cfg.anim)
end
end

function systemZongMenController:createWorldEntity(world)
local cfg=cfgHelper.get1(cfg_worldblockconfig_get,world)
for block,blockCfg in pairs(cfg)do
if worldBlockModel:checkBlockState(world,block,eWorldBlockState.OPEN)then
self:createBlockEntity(world,block)
end
end
end

function systemZongMenController:createBlockEntity(world,block)
local infos=systemZongMenModel:findInfoDataByBlock(world,block)
for i,v in ipairs(infos)do
self:createEntity(v)
end
end

function systemZongMenController:updateEntityModel(serial,old_lv,level)
if not worldController:isInWorld()then return end
local unitKey=systemZongMenModel:convertUnitKey(serial)
local data=systemZongMenModel:getInfoData(serial)
if worldController:haveUnit(unitKey)and data then
if data.flag~=systemZongMenFightFlagType.eExpel then
local oModel=systemZongMenModel:getModelRes(data.worldId,old_lv,data.id)
local nModel=systemZongMenModel:getModelRes(data.worldId,level,data.id)
if oModel~=nModel then
local modelSetting=worldModel:getModelSettings(nModel,eWorldUnitTpye.SYSTEMZM)
worldController:changeUnitModel(unitKey,modelSetting)
end
end
end
end

function systemZongMenController:updateEntityModelByFightFlag(serial,oldFlag,fightFlag)
if not worldController:isInWorld()then return end
local unitKey=systemZongMenModel:convertUnitKey(serial)
local infoData=systemZongMenModel:getInfoData(serial)
if worldController:haveUnit(unitKey)and infoData then
local modelId=nil
if fightFlag==systemZongMenFightFlagType.eExpel then
local ruinModel=cfgHelper.get2(cfg_syssectbaseconfig_get,1,"ruinModel")
modelId=ruinModel[infoData.worldId]or ruinModel[0]
elseif oldFlag==systemZongMenFightFlagType.eExpel then
modelId=systemZongMenModel:getModelRes(infoData.worldId,infoData.level,infoData.id)
end
if modelId then
local modelSetting=worldModel:getModelSettings(modelId,eWorldUnitTpye.SYSTEMZM)
worldController:changeUnitModel(unitKey,modelSetting)
end
end
end

function systemZongMenController:deleteEntity(serial)
local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.SYSTEMZM,tostring(serial)})
worldController:popUnit(unitKey)
end

function systemZongMenController:deleteWorldEntity(world)
local list=systemZongMenModel:findInfoDataByWorld(world)
for i,v in ipairs(list)do
self:deleteEntity(v.serial)
end
end

function systemZongMenController.onClickEntity(args)
if not args then return end
if args[1]==eWorldUnitTpye.SYSTEMZM then
if systemModel.isOpen(SYSTEM_DEFINE.eXiTongZongMen)then
local serial=args[2]
local dataInfo=systemZongMenModel:getInfoData(serial)
if dataInfo and systemZongMenModel:checkVisitPrivilege(dataInfo.id,true)then

local data=systemZongMenModel:getWaitNotifyResult(serial)
if data and data.teamIndex>0 then
systemZongMenController:playFightBattleImp(data,true)
return
end

local unitKey=systemZongMenModel:convertUnitKey(serial)
local callback=nil

if dataInfo.flag==systemZongMenFightFlagType.eSurrender then
callback=function()
systemZongMenController:req_detailInfo(systemZongMenDetailDataPart.eDZList,serial)
UIFullSystemZongMenControl:showWindow("UISystemZongMenSurrenderWin",{serial=serial})
end

elseif dataInfo.flag==systemZongMenFightFlagType.eExpel then
callback=function()
UIManager:showWindow("UISystemZongMenJoinWin",{serial=serial})
end
else
callback=function()
UIFullSystemZongMenControl:showMainWindow({serial=serial})
end
end

worldController:lookAtUnit(unitKey,nil,false,callback)
end
else
local desc=systemModel.getOpenTips(SYSTEM_DEFINE.eXiTongZongMen,'（','）')
local serial=args[2]
local dataInfo=systemZongMenModel:getInfoData(serial)
local cfg=cfgHelper.get1(cfg_syssectconfig_get,dataInfo.id)
local args={
showblack=true,
blackAlpha=1,
isFullOpen=false,
talk=FMT.fmt('　　{0}<color=#ff6600>{1}</color>',cfg.lockFuncTips,desc)
}
UIFullStoryBoardControl:showPlotBoardWindow5(args,false)
end
elseif args[1]==eWorldUnitTpye.SYSTEMZM_OUTGOER then
if systemModel.isOpen(SYSTEM_DEFINE.eSystemZongMenOutgoer)then
local guid=args[2]
local cameraPos=worldController:getCameraPosition()
systemZongMenController:enterOutgoerScene(guid,cameraPos.y)
else
local guid=args[2]
local unitKey=systemZongMenModel:convertOutgoerUnitKey(guid)
worldController:lookAtUnit(unitKey,nil,false,function()
local desc=systemModel.getOpenTips(SYSTEM_DEFINE.eSystemZongMenOutgoer,'（','）')
local lockFuncTips=cfgHelper.get2(cfg_syssectbaseconfig_get,1,"outgoerLockTips")

local args={
showblack=true,
blackAlpha=1,
isFullOpen=false,
talk=FMT.fmt('　　{0}<color=#ff6600>{1}</color>',lockFuncTips,desc)
}
UIFullStoryBoardControl:showPlotBoardWindow5(args,false)
end)
end
end
end

function systemZongMenController.onWorldBlockDataInited(reset)
systemZongMenModel:initPosLibrary()
systemZongMenModel:initOutgoerLibrary()
if initProControl.isDone()and worldController:isInWorld()then
local world=worldModel.world
systemZongMenController:deleteWorldEntity(world)
systemZongMenController:createWorldEntity(world)
systemZongMenController:deleteWorldOutgoerEntity(world)
systemZongMenController:createWorldOutgoerEntity(world)
end
end

function systemZongMenController.onWorldBlockDataChanged(world,block,state)
if state==eWorldBlockState.OPEN then
systemZongMenModel:addPosLibrary(world,block)
systemZongMenModel:addOutgoerLibrary(world,block)
end
end

function systemZongMenController.onWorldBlockStateChanged(world,block,state)
if state==eWorldBlockState.OPEN then

systemZongMenController:createBlockEntity(world,block)
systemZongMenController:createWorldOutgoerEntity(world,block)
end
end

function systemZongMenController.onWorldPositionReRandom(rData,aData)
if rData.unitType==eWorldUnitTpye.SYSTEMZM then
systemZongMenController:reRandomPositionZongMen(rData)
elseif rData.unitType==eWorldUnitTpye.SYSTEMZM_OUTGOER then
systemZongMenController:reRandomPositionOutgoer(rData)
end
end

function systemZongMenController:reRandomPositionOutgoer(rData)
local data=systemZongMenModel:getOutgoerData(rData.sub)
if data==nil then
loggerUtil.logErrFMT("无效系统宗门数据被替换:{0}, {1}",initProControl.isDone(),serializeHelper.serialize(rData))
worldPositionLibrary:eraseData(rData.guid,rData.sub)
return
end

local library=systemZongMenModel:getOutgoerLibrary(data.world)
local check=false
local temp=nil
if#library>0 then
check,temp=worldPositionLibrary:extract(library)
end
if check then
local posData=temp[1]
local x=posData.x
local z=posData.z
local flip=posData.flip
local position,block=worldPositionConfig:getPosition(posData.world,{posData.x,posData.z})
data.position=position
data.block=block
data.flip=flip
worldPositionLibrary:markData(data.world,x,z,flip,eWorldUnitTpye.SYSTEMZM_OUTGOER,data.guid,rData.sub)
else
loggerUtil.logErrFMT("系统宗门坐标随机库重新抽取失败,GUID:{0}",tostring(data.serial))
data.position=Vector3.zero
data.block=nil
data.flip=false
worldPositionLibrary:eraseData(data.guid,rData.sub)
end

cfg=cfg_syssectsystaskposconfig()
for sysid,temp in pairs(cfg)do
if temp[data.id]then
loggerUtil.logErrFMT("固定系统宗门位置被顶替：{0}， {1}",serializeHelper.serialize(rData),serializeHelper.serialize(aData))
return
end
end

local unitKey=systemZongMenModel:convertOutgoerUnitKey(rData.sub)
if worldController:isInWorld()and worldModel:isSameWorld(data.world)then
if check then
worldController:setUnitFlipX(unitKey,data.flip)
worldController:setUnitPosition(unitKey,data.position)
else
worldController:popUnit(unitKey)
end
end
end

function systemZongMenController:reRandomPositionZongMen(rData)
local data=systemZongMenModel:getInfoData(rData.key)

if data==nil then
loggerUtil.logErrFMT("无效系统宗门数据被替换:{0}, {1}",initProControl.isDone(),serializeHelper.serialize(rData))
worldPositionLibrary:eraseData(rData.guid,rData.sub)
return
end

local cfg=cfg_syssecttaskposconfig()
if cfg[data.worldId]and cfg[data.worldId][data.blockId]and cfg[data.worldId][data.blockId][data.id]then
loggerUtil.logErrFMT("固定系统宗门位置被顶替：{0}， {1}",serializeHelper.serialize(rData),serializeHelper.serialize(aData))
return
end

local library=cfgHelper.get3(cfg_syssectposlibconfig_get,data.worldId,data.blockId,"poslist")
local check,temp=worldPositionLibrary:extract(library)
if check and#temp>0 then
local posData=temp[1]
local x=posData.x
local z=posData.z
local flip=posData.flip
local position,block=worldPositionConfig:getPosition(posData.world,{posData.x,posData.z})
data.position=position
data.flip=flip
worldPositionLibrary:eraseData(data.guid)
worldPositionLibrary:markData(data.worldId,x,z,data.flip,eWorldUnitTpye.SYSTEMZM,data.guid)

else
data.position=Vector3.zero
data.flip=false
worldPositionLibrary:eraseData(data.guid)
end
local unitKey=systemZongMenModel:convertUnitKey(data.serial)
worldTaskModel:changeTaskTargetDestination(unitKey)
if worldController:isInWorld()and worldModel:isSameWorld(data.worldId)then
worldController:setUnitFlipX(unitKey,data.flip)
worldController:setUnitPosition(unitKey,data.position)
end
end