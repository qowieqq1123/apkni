local _posLibs={}

function systemZongMenModel:convertUnitKey(serial)
return worldModel:convertUnitKey({eWorldUnitTpye.SYSTEMZM,tostring(serial)})
end

function systemZongMenModel:initPosLibrary()
_posLibs={}
local cfg=cfg_syssectposlibconfig()
for world,v in pairs(cfg)do
for block,w in pairs(v)do
if worldBlockModel:checkBlockState(world,block,eWorldBlockState.OPEN)then
if not _posLibs[world]then
_posLibs[world]={}
end
_posLibs[world]=table.concatTable(_posLibs[world],w.poslist)
end
end
end
end

function systemZongMenModel:addPosLibrary(world,block)
if not _posLibs[world]then
_posLibs[world]={}
end
local cfg=cfgHelper.get1(cfg_syssectposlibconfig_get,world)
if cfg and cfg[block]then
cfg=cfg[block]
_posLibs[world]=table.concatTable(_posLibs[world],cfg.poslist)
end
end

function systemZongMenModel:getWorldLibrary(world)
return _posLibs[world]
end

function systemZongMenModel:findInfoDataByWorld(world)
local list={}
local temp=systemZongMenModel:getInfoList()
for i,v in ipairs(temp)do
if v.worldId==world then
table.insert(list,v)
end
end
return list
end

function systemZongMenModel:findInfoDataByBlock(world,block)
local list={}
local temp=systemZongMenModel:getInfoList()
for i,v in ipairs(temp)do
if v.worldId==world and v.blockId==block then
table.insert(list,v)
end
end
return list
end

function systemZongMenModel:findInfoDataByArea(area)
local list={}
local temp=systemZongMenModel:getInfoList()
for i,v in ipairs(temp)do
if v.areaId==area then
table.insert(list,v)
end
end
return list
end

function systemZongMenModel:placeInfoData(data)
local posData=worldPositionLibrary:getData(data.guid)
if posData then
data.flip=posData.flip
local position,block=worldPositionConfig:getPosition(posData.world,{posData.x,posData.z})
data.position=position

if position~=Vector3.zero and block==data.blockId and posData.world==data.worldId then
return
else
loggerUtil.logErrFMT("本地存在错误系统宗门旧坐标数据:{0}-{1},{2}-{3},({4},{5}),{6}",posData.world,data.worldId,block,data.blockId,posData.x,posData.z,tostring(data.guid))
worldPositionLibrary:eraseData(data.guid)
end
end

local cfg=cfg_syssecttaskposconfig()
if cfg[data.worldId]and cfg[data.worldId][data.blockId]and cfg[data.worldId][data.blockId][data.id]then
cfg=cfg[data.worldId][data.blockId][data.id]
local position=worldPositionConfig:getPosition(cfg.worldId,{cfg.pos[1],cfg.pos[2]})
data.position=position
data.flip=cfg.pos[3]==1
worldPositionLibrary:markData(cfg.worldId,cfg.pos[1],cfg.pos[2],data.flip,eWorldUnitTpye.SYSTEMZM,data.guid)
return
end
cfg=cfg_syssectsystaskposconfig()
for sysid,temp in pairs(cfg)do
if temp[data.id]then
local cfg=temp[data.id]

local position=worldPositionConfig:getPosition(cfg.worldId,{cfg.pos[1],cfg.pos[2]})
data.position=position
data.flip=cfg.pos[3]==1
worldPositionLibrary:markData(cfg.worldId,cfg.pos[1],cfg.pos[2],data.flip,eWorldUnitTpye.SYSTEMZM,data.guid)
return
end
end

local library=cfgHelper.get3(cfg_syssectposlibconfig_get,data.worldId,data.blockId,"poslist")
local check=false
local temp=nil
if library then
check,temp=worldPositionLibrary:extract(library)
end
if check then
posData=temp[1]
local x=posData.x
local z=posData.z
local flip=posData.flip
local position,block=worldPositionConfig:getPosition(posData.world,{posData.x,posData.z})
data.position=position
data.flip=flip
worldPositionLibrary:markData(data.worldId,x,z,flip,eWorldUnitTpye.SYSTEMZM,data.guid)
else
loggerUtil.logErrFMT("系统宗门坐标随机库抽取失败,GUID:{0}",tostring(data.serial))
data.position=Vector3.zero
data.flip=false
end
end

function systemZongMenModel:unplaceInfoData(guid)
worldPositionLibrary:eraseData(guid)
end

function systemZongMenModel:getModelRes(area,level,id)
local cfg=cfgHelper.get1(cfg_syssectconfig_get,id)
local modelRes=cfg.modelRes
if modelRes==nil then
cfg=cfgHelper.get1(cfg_syssectfigureconfig_get,area)
modelRes=cfg.modelRes
end
for i=#modelRes,1,-1 do
local v=modelRes[i]
if level>=v[1]then
return v[2]
end
end
end

function systemZongMenModel:getHUDRes(id,area)
local cfg=cfgHelper.get1(cfg_syssectconfig_get,id)
local hudRes=cfg.hudRes
if hudRes==nil then
local cfg=cfgHelper.get1(cfg_syssectfigureconfig_get,area)
hudRes=cfg.hudRes
end
return hudRes
end

function systemZongMenModel:getIconName(id,level)
local cfg=cfgHelper.get1(cfg_syssectconfig_get,id)
local info=cfg.icon
for i=#info,1,-1 do
local v=info[i]
if level>=v[1]then
return v[2]
end
end
end

function systemZongMenModel:getNameStr(id,nameIdx)
local cfg=cfgHelper.get1(cfg_syssectconfig_get,id)
local high8=bit.rshift(bit.band(nameIdx,0xff00),8)
local low8=bit.band(nameIdx,0x00ff)
local firstName=cfg.firstName[high8]
local secondName=cfg.secondName[low8]
if pfwindowslController:checkIsGameVersion_yuenan()or pfwindowslController:checkIsGameVersion_oumei()then
return FMT.fmt("{0} {1}",firstName,secondName)
else
return FMT.fmt("{0}{1}",firstName,secondName)
end
end


function systemZongMenModel.getSystemZongMenName(serial)
local infoData=systemZongMenModel:getInfoData(serial)
if infoData then
local name=systemZongMenModel:getNameStr(infoData.id,infoData.nameIdx)
return name
end
end