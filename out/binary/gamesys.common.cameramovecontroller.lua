







local _MODULENAME="cameraMoveController"
gameState.addListener(def_table(_MODULENAME))
cameraMoveController.name=_MODULENAME


cameraMoveTargetType={
eZongmeng_sundrise=1,
eZongmeng_build=2,
eWorld_mijing=3,
eZongmeng_pos=4,
eWorld_pos=5,
eZongmeng_build2=6,
eZongmeng_build3=7,
eZongmeng_build4=8,
eZongmeng_build5=9,
eZongmeng_build6=10,
eZongmeng_build7=11,
eZongmeng_build8=12,
eWorld_fishman=13,
eZongmeng_build9=14,
eZongmeng_build10=15,
eZongmeng_build11=16,
eZongmeng_build12=17,
eXianJie_pos=18,
eXianbao_build=19,
eLingShouDao_build=20,
eLingShouDao_build2=21,
}

local findIndex=0
local getFindIndx=function()
findIndex=findIndex+1
return findIndex
end

cameraMoveFindTargetType={
efind_zm_sundrise=getFindIndx(),
efind_zm_build=getFindIndx(),
efind_w_mijing=getFindIndx(),
efind_zm_pos=getFindIndx(),
efind_w_pos=getFindIndx(),
efind_zm_build3=getFindIndx(),
efind_zm_build4=getFindIndx(),
efind_zm_build5=getFindIndx(),
efind_zm_build6=getFindIndx(),
efind_zm_build7=getFindIndx(),
efind_zm_build8=getFindIndx(),
efind_w_fishman=getFindIndx(),
efind_zm_build9=getFindIndx(),
efind_zm_build10=getFindIndx(),
efind_zm_build11=getFindIndx(),
efind_zm_build12=getFindIndx(),
efind_xj_pos=getFindIndx(),
efind_xb_build=getFindIndx(),
efind_lsd_build=getFindIndx(),
}

local cameraMoveTargetFuncIdx={

[cameraMoveTargetType.eZongmeng_sundrise]=cameraMoveFindTargetType.efind_zm_sundrise,

[cameraMoveTargetType.eZongmeng_build]=cameraMoveFindTargetType.efind_zm_build,

[cameraMoveTargetType.eWorld_mijing]=cameraMoveFindTargetType.efind_w_mijing,

[cameraMoveTargetType.eZongmeng_pos]=cameraMoveFindTargetType.efind_zm_pos,

[cameraMoveTargetType.eWorld_pos]=cameraMoveFindTargetType.efind_w_pos,

[cameraMoveTargetType.eXianJie_pos]=cameraMoveFindTargetType.efind_xj_pos,

[cameraMoveTargetType.eZongmeng_build2]=cameraMoveFindTargetType.efind_zm_build,

[cameraMoveTargetType.eZongmeng_build3]=cameraMoveFindTargetType.efind_zm_build3,

[cameraMoveTargetType.eZongmeng_build4]=cameraMoveFindTargetType.efind_zm_build4,

[cameraMoveTargetType.eZongmeng_build5]=cameraMoveFindTargetType.efind_zm_build5,

[cameraMoveTargetType.eZongmeng_build6]=cameraMoveFindTargetType.efind_zm_build6,

[cameraMoveTargetType.eZongmeng_build7]=cameraMoveFindTargetType.efind_zm_build7,

[cameraMoveTargetType.eZongmeng_build8]=cameraMoveFindTargetType.efind_zm_build8,

[cameraMoveTargetType.eWorld_fishman]=cameraMoveFindTargetType.efind_w_fishman,

[cameraMoveTargetType.eZongmeng_build9]=cameraMoveFindTargetType.efind_zm_build9,

[cameraMoveTargetType.eZongmeng_build10]=cameraMoveFindTargetType.efind_zm_build10,

[cameraMoveTargetType.eZongmeng_build11]=cameraMoveFindTargetType.efind_zm_build11,

[cameraMoveTargetType.eZongmeng_build12]=cameraMoveFindTargetType.efind_zm_build12,

[cameraMoveTargetType.eXianbao_build]=cameraMoveFindTargetType.efind_xb_build,

[cameraMoveTargetType.eLingShouDao_build]=cameraMoveFindTargetType.efind_lsd_build,

[cameraMoveTargetType.eLingShouDao_build2]=cameraMoveFindTargetType.efind_lsd_build,
}

local cameraMoveTargetFunc={

[cameraMoveFindTargetType.efind_zm_sundrise]=function(targetType,backParams,param1,param2)
local mapId=zongmenModel:getMountainId()
local sundrise=isometricMapSystem:findUnlockSundriesByID(mapId,param1)
if sundrise~=nil then
local pos=_MapManager.GetObjectAreaC(sundrise.guid)
return pos
end
backParams.tipstxt=FMT.fmt('找不到宗门随机物{0}',param1)
return nil
end,

[cameraMoveFindTargetType.efind_zm_build]=function(targetType,backParams,param1,param2)

local sfId=mapIdType.zhufeng
local buildInfoList={}
local temp=nil
if targetType==cameraMoveTargetType.eZongmeng_build then
temp=zongmenModel:getBuildingDataByBdId(sfId,param1)
else
temp=zongmenModel:getBuildingDataByBdType(sfId,param1)
end
if temp~=nil and#temp>0 then
for i,data in ipairs(temp)do
local config=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
local isLinkRoad=true
if config.is_connect_road==1 and not data.isLinkRoad then
isLinkRoad=false
end
if isLinkRoad then
if data.flag==0 then
table.insert(buildInfoList,data)
end
end
end
end
if#buildInfoList>0 then
local buildInfo
if param2==1 then

table.sort(buildInfoList,function(a,b)
return a.level<b.level
end)
buildInfo=buildInfoList[1]
elseif param2==2 then

table.sort(buildInfoList,function(a,b)
return a.level>b.level
end)
buildInfo=buildInfoList[1]
elseif param2==3 then

for i,v in ipairs(buildInfoList)do
if tostring(v.dizi_id)=='0'then
buildInfo=v
break
end
end
if buildInfo==nil then
buildInfo=buildInfoList[1]
end
elseif param2==4 then

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,param1)
local pro_skill_id=cfg.pro_skill_id
if pro_skill_id then
local max_pro_skill_lv=-1
for i,v in ipairs(buildInfoList)do
if tostring(v.dizi_id)~='0'then
local level=UIDiscipleModel:getDiscipleJobLevel(v.dizi_id,pro_skill_id)
if max_pro_skill_lv<level then
buildInfo=v
max_pro_skill_lv=level
end
end
end
end
if buildInfo==nil then
buildInfo=buildInfoList[1]
end
else

buildInfo=buildInfoList[1]
end

backParams.un_build_id=buildInfo.un_build_id
local pos=_MapManager.GetObjectAreaC(buildInfo.entityId)
return pos
end
backParams.errortxt=cameraMoveController.logNoBuilding()
backParams.tipstxt=FMT.fmt('找不到宗门建筑物{0}',param1)
return nil
end,

[cameraMoveFindTargetType.efind_w_mijing]=function(targetType,backParams,param1,param2)
local key=worldModel:convertUnitKey({worldModel.UNITTYPE.MYSTERY,param1})
local data=nil
if key~=nil then
data=worldController:getUnit(key)
end
if data~=nil then
local p=data.Position
local pos=Vector3(p.x,p.y,p.z)
return pos
end
backParams.tipstxt=FMT.fmt('找不到大世界秘境{0}',param1)
return nil
end,

[cameraMoveFindTargetType.efind_w_fishman]=function(targetType,backParams,param1,param2)
local npcdatas=YiYuHuiYouModel:getNPCIdlist()
if npcdatas and#npcdatas>0 then
local worldid=backParams.screenParams[2]
for i,npcdata in ipairs(npcdatas)do
if npcdata.world==worldid then
local unitKey=YiYuHuiYouModel:convertUnitKey(npcdata.guid)
local data=worldController:getUnit(unitKey)
if data then
local p=data.Position
local pos=Vector3(p.x,p.y,p.z)
return pos
end
end
end
end
backParams.tipstxt='大世界没有钓鱼佬'
return nil
end,

[cameraMoveFindTargetType.efind_zm_pos]=function(targetType,backParams,param1,param2)
local temppos=_MapManager.ToVector3Int(param1[1],param1[2],0)
local mapId=zongmenModel:getMountainId()
local pos=_MapManager.GetCellCenterWorld(mapId,temppos,mapLayer.Data)
return pos
end,

[cameraMoveFindTargetType.efind_w_pos]=function(targetType,backParams,param1,param2)
local pos=Vector3(param1[1],param1[2],param1[3])
return pos
end,

[cameraMoveFindTargetType.efind_xj_pos]=function(targetType,backParams,param1,param2)
local pos=Vector3(param1[1],param1[2],param1[3])
return pos
end,

[cameraMoveFindTargetType.efind_zm_build3]=function(targetType,backParams,param1,param2)

local sfId=mapIdType.zhufeng
local buildInfoList={}
local buildInfoList2={}
local temp=zongmenModel:getBuildingDataByBdType(sfId,param1)
if temp~=nil and#temp>0 then
for i,data in ipairs(temp)do
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
local isLinkRoad=true
if cfg.is_connect_road==1 and not data.isLinkRoad then
isLinkRoad=false
end
if isLinkRoad and data.flag==0 then

local cd=buildingCDControl:checkCD(cfg,data)

if cd then
table.insert(buildInfoList2,data)
else
table.insert(buildInfoList,data)
end
end
end
end
local buildInfo=nil
if#buildInfoList>0 then

buildInfo=buildInfoList[1]
elseif#buildInfoList2>0 then

buildInfo=buildInfoList2[1]
end
if buildInfo~=nil then

backParams.un_build_id=buildInfo.un_build_id

local pos=_MapManager.GetObjectAreaC(buildInfo.entityId)
return pos
end
backParams.errortxt=cameraMoveController.logNoBuilding()
backParams.tipstxt=FMT.fmt('找不到宗门建筑物{0}',param1)
return nil
end,

[cameraMoveFindTargetType.efind_zm_build4]=function(targetType,backParams,param1,param2)

local sfId=mapIdType.zhufeng
local buildInfoList={}
local temp=zongmenModel:getBuildingDataByBdType(sfId,param1)
if temp~=nil and#temp>0 then
for i,data in ipairs(temp)do
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
local isLinkRoad=true
if cfg.is_connect_road==1 and not data.isLinkRoad then
isLinkRoad=false
end
if isLinkRoad and data.flag==0 then

local cd=buildingCDControl:checkCD(cfg,data)

if cd then
table.insert(buildInfoList,data)
end
end
end
end
if#buildInfoList>0 then
local buildInfo

buildInfo=buildInfoList[1]

backParams.un_build_id=buildInfo.un_build_id
local pos=_MapManager.GetObjectAreaC(buildInfo.entityId)
return pos
end
backParams.errortxt=cameraMoveController.logNoBuilding()
backParams.tipstxt=FMT.fmt('找不到宗门建筑物{0}',param1)
return nil
end,

[cameraMoveFindTargetType.efind_zm_build5]=function(targetType,backParams,param1,param2)
local buildInfoList={}
local temp=isometricMapSystem:getAllRepairData()
if temp~=nil then
for k,data in pairs(temp)do
if data.type==param1 then
if zongmenModel:isAreaUnlock(data.areaId)then
table.insert(buildInfoList,data)
end
end
end
end
if#buildInfoList>0 then
local buildInfo

buildInfo=buildInfoList[1]

backParams.un_build_id=buildInfo.id
local pos=_MapManager.GetObjectAreaC(buildInfo.guid)
return pos
end
backParams.errortxt=cameraMoveController.logNoBuilding()
backParams.tipstxt=FMT.fmt('找不到宗门建筑物{0}',param1)
return nil
end,

[cameraMoveFindTargetType.efind_zm_build6]=function(targetType,backParams,param1,param2)
local temp=isometricMapSystem:getAllRepairData()
if temp~=nil then
local buildInfoList={}
for k,data in pairs(temp)do
if data.type==param1 then
if zongmenModel:isAreaUnlock(data.areaId)then
table.insert(buildInfoList,data)
end
end
end
if#buildInfoList>0 then
local buildInfo

buildInfo=buildInfoList[1]

backParams.un_build_id=buildInfo.id
local pos=_MapManager.GetObjectAreaC(buildInfo.guid)
return pos
end
end


local sfId=mapIdType.zhufeng
local temp2=zongmenModel:getBuildingDataByBdType(sfId,param1)
if temp2~=nil and#temp2>0 then
local buildInfo

buildInfo=temp2[1]

backParams.un_build_id=buildInfo.un_build_id
local pos=_MapManager.GetObjectAreaC(buildInfo.entityId)
return pos
end

backParams.errortxt=cameraMoveController.logNoBuilding()
backParams.tipstxt=FMT.fmt('找不到宗门建筑物{0}',param1)
return nil
end,

[cameraMoveFindTargetType.efind_zm_build7]=function(targetType,backParams,param1,param2)

local sfId=mapIdType.zhufeng
local temp2=zongmenModel:getBuildingDataByBdType(sfId,param1)
if temp2~=nil and#temp2>0 then
local buildInfoList={}
for i,bdData in ipairs(temp2)do
local ftype=zongmenModel:getBDFlagType(bdData.flag)
if ftype==bdFlagType.build or ftype==bdFlagType.sectionBuildStart or ftype==bdFlagType.sectionBuildComplete then
table.insert(buildInfoList,bdData)
end
end
if#buildInfoList>0 then
local buildInfo

buildInfo=buildInfoList[1]

backParams.un_build_id=buildInfo.un_build_id
local pos=_MapManager.GetObjectAreaC(buildInfo.entityId)
return pos
end
end
if temp2~=nil and#temp2>0 then
local buildInfo

buildInfo=temp2[1]

backParams.un_build_id=buildInfo.un_build_id
local pos=_MapManager.GetObjectAreaC(buildInfo.entityId)
return pos
end

backParams.errortxt=cameraMoveController.logNoBuilding()
backParams.tipstxt=FMT.fmt('找不到宗门建筑物{0}',param1)
return nil
end,

[cameraMoveFindTargetType.efind_zm_build8]=function(targetType,backParams,param1,param2)

local sfId=mapIdType.zhufeng
local temp2=zongmenModel:getBuildingDataByBdType(sfId,param1)
if temp2~=nil and#temp2>0 then
local buildInfoList={}
for i,bdData in ipairs(temp2)do
local ftype=zongmenModel:getBDFlagType(bdData.flag)
if ftype==bdFlagType.build or ftype==bdFlagType.sectionBuildStart or ftype==bdFlagType.sectionBuildComplete then
table.insert(buildInfoList,bdData)
end
end
if#buildInfoList>0 then
local buildInfo

buildInfo=buildInfoList[1]

backParams.un_build_id=buildInfo.un_build_id
backParams.guid=buildInfo.entityId
local pos=_MapManager.GetObjectAreaC(buildInfo.entityId)
return pos
end
end

local temp=isometricMapSystem:getAllRepairData()
if temp~=nil then
local buildInfoList={}
for k,data in pairs(temp)do
if data.type==param1 then
table.insert(buildInfoList,data)
end
end
if#buildInfoList>0 then
local buildInfo

buildInfo=buildInfoList[1]

backParams.un_build_id=buildInfo.id
backParams.guid=buildInfo.guid
local pos=_MapManager.GetObjectAreaC(buildInfo.guid)
return pos
end
end

backParams.errortxt=cameraMoveController.logNoBuilding()
backParams.tipstxt=FMT.fmt('找不到宗门建筑物{0}',param1)
return nil
end,

[cameraMoveFindTargetType.efind_zm_build9]=function(targetType,backParams,param1,param2)

local sfId=mapIdType.zhufeng
local buildInfoList={}
local temp=zongmenModel:getBuildingDataByBdType(sfId,param1)
if temp~=nil and#temp>0 then
for i,data in ipairs(temp)do
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
local isLinkRoad=true
if cfg.is_connect_road==1 and not data.isLinkRoad then
isLinkRoad=false
end
if isLinkRoad and data.flag==0 then
local hasDZ=zongmenModel:checkBuildHasManager(cfg,data)
if not hasDZ then
table.insert(buildInfoList,data)
end
end
end
end
local num=#buildInfoList
if num>0 then
local buildInfo

if num>1 then
table.sort(buildInfoList,function(a,b)
return a.level>b.level
end)
end

buildInfo=buildInfoList[1]

backParams.un_build_id=buildInfo.un_build_id
local pos=_MapManager.GetObjectAreaC(buildInfo.entityId)
return pos
end
backParams.errortxt=cameraMoveController.logNoBuilding()
backParams.tipstxt=FMT.fmt('找不到宗门建筑物{0}',param1)
return nil
end,

[cameraMoveFindTargetType.efind_zm_build10]=function(targetType,backParams,param1,param2)

local sfId=mapIdType.zhufeng
local buildInfoList={}
local temp=zongmenModel:getBuildingDataByBdType(sfId,param1)
if temp~=nil and#temp>0 then
for i,data in ipairs(temp)do
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
local isLinkRoad=true
if cfg.is_connect_road==1 and not data.isLinkRoad then
isLinkRoad=false
end
if isLinkRoad and data.flag==0 then

local hasDZ=zongmenModel:checkBuildHasManager(cfg,data)
if hasDZ then
local cd=buildingCDControl:checkCD(cfg,data)

if cd==nil then
table.insert(buildInfoList,data)
end
end
end
end
end
local num=#buildInfoList
if num>0 then
local buildInfo

if num>1 then
table.sort(buildInfoList,function(a,b)
return a.level>b.level
end)
end

buildInfo=buildInfoList[1]

backParams.un_build_id=buildInfo.un_build_id
local pos=_MapManager.GetObjectAreaC(buildInfo.entityId)
return pos
end
backParams.errortxt=cameraMoveController.logNoBuilding()
backParams.tipstxt=FMT.fmt('找不到宗门建筑物{0}',param1)
return nil
end,

[cameraMoveFindTargetType.efind_zm_build11]=function(targetType,backParams,param1,param2)

local sfId=mapIdType.zhufeng
local buildInfoList={}
local temp=zongmenModel:getBuildingDataByBdType(sfId,param1)
if temp~=nil and#temp>0 then
for i,data in ipairs(temp)do
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
local isLinkRoad=true
if cfg.is_connect_road==1 and not data.isLinkRoad then
isLinkRoad=false
end
if isLinkRoad and data.flag==0 then

local hasDZ=zongmenModel:checkBuildHasManager(cfg,data)
if hasDZ then
local cd=buildingCDControl:checkCD(cfg,data)

if cd~=nil and cd>0 then
table.insert(buildInfoList,data)
end
end
end
end
end
local num=#buildInfoList
if num>0 then
local buildInfo

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,param1)
local pro_skill_id=cfg.pro_skill_id
if pro_skill_id then
local max_pro_skill_lv=-1
for i,v in ipairs(buildInfoList)do
if tostring(v.dizi_id)~='0'then
local level=UIDiscipleModel:getDiscipleJobLevel(v.dizi_id,pro_skill_id)
if max_pro_skill_lv<level then
buildInfo=v
max_pro_skill_lv=level
end
end
end
end
if buildInfo==nil then
buildInfo=buildInfoList[1]
end

backParams.un_build_id=buildInfo.un_build_id
local pos=_MapManager.GetObjectAreaC(buildInfo.entityId)
return pos
end
backParams.errortxt=cameraMoveController.logNoBuilding()
backParams.tipstxt=FMT.fmt('找不到宗门建筑物{0}',param1)
return nil
end,

[cameraMoveFindTargetType.efind_zm_build12]=function(targetType,backParams,param1,param2)

local sfId=mapIdType.zhufeng
local buildInfoList={}
local temp=zongmenModel:getBuildingDataByBdType(sfId,param1)
if temp~=nil and#temp>0 then
for i,data in ipairs(temp)do
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
local isLinkRoad=true
if cfg.is_connect_road==1 and not data.isLinkRoad then
isLinkRoad=false
end
if isLinkRoad and data.flag==0 then

local hasDZ=zongmenModel:checkBuildHasManager(cfg,data)
if hasDZ then
local cd=buildingCDControl:checkCD(cfg,data)

if cd~=nil and cd<=0 then
table.insert(buildInfoList,data)
end
end
end
end
end
local num=#buildInfoList
if num>0 then
local buildInfo

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,param1)
local pro_skill_id=cfg.pro_skill_id
if pro_skill_id then
local max_pro_skill_lv=-1
for i,v in ipairs(buildInfoList)do
if tostring(v.dizi_id)~='0'then
local level=UIDiscipleModel:getDiscipleJobLevel(v.dizi_id,pro_skill_id)
if max_pro_skill_lv<level then
buildInfo=v
max_pro_skill_lv=level
end
end
end
end
if buildInfo==nil then
buildInfo=buildInfoList[1]
end

backParams.un_build_id=buildInfo.un_build_id
local pos=_MapManager.GetObjectAreaC(buildInfo.entityId)
return pos
end
backParams.errortxt=cameraMoveController.logNoBuilding()
backParams.tipstxt=FMT.fmt('找不到宗门建筑物{0}',param1)
return nil
end,

[cameraMoveFindTargetType.efind_xb_build]=function(targetType,backParams,param1,param2)

local sfId=mapIdType.fort
local buildInfoList={}
local temp=nil
if targetType==cameraMoveTargetType.eXianbao_build then
temp=zongmenModel:getBuildingDataByBdId(sfId,param1)
else
temp=zongmenModel:getBuildingDataByBdType(sfId,param1)
end
if temp~=nil and#temp>0 then
for i,data in ipairs(temp)do
local config=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
local isLinkRoad=true
if config.is_connect_road==1 and not data.isLinkRoad then
isLinkRoad=false
end
if isLinkRoad then
if data.flag==0 then
table.insert(buildInfoList,data)
end
end
end
end
if#buildInfoList>0 then
local buildInfo
if param2==1 then

table.sort(buildInfoList,function(a,b)
return a.level<b.level
end)
buildInfo=buildInfoList[1]
elseif param2==2 then

table.sort(buildInfoList,function(a,b)
return a.level>b.level
end)
buildInfo=buildInfoList[1]
elseif param2==3 then

for i,v in ipairs(buildInfoList)do
if tostring(v.dizi_id)=='0'then
buildInfo=v
break
end
end
if buildInfo==nil then
buildInfo=buildInfoList[1]
end
elseif param2==4 then

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,param1)
local pro_skill_id=cfg.pro_skill_id
if pro_skill_id then
local max_pro_skill_lv=-1
for i,v in ipairs(buildInfoList)do
if tostring(v.dizi_id)~='0'then
local level=UIDiscipleModel:getDiscipleJobLevel(v.dizi_id,pro_skill_id)
if max_pro_skill_lv<level then
buildInfo=v
max_pro_skill_lv=level
end
end
end
end
if buildInfo==nil then
buildInfo=buildInfoList[1]
end
else

buildInfo=buildInfoList[1]
end

backParams.un_build_id=buildInfo.un_build_id
local pos=_MapManager.GetObjectAreaC(buildInfo.entityId)
return pos
end
backParams.errortxt=cameraMoveController.logNoBuilding()
backParams.tipstxt=FMT.fmt('找不到仙堡建筑物{0}',param1)
return nil
end,

[cameraMoveFindTargetType.efind_lsd_build]=function(targetType,backParams,param1,param2)

local sfId=mapIdType.lingshoudao
local buildInfoList={}
local temp=nil
if targetType==cameraMoveTargetType.eLingShouDao_build then
temp=zongmenModel:getBuildingDataByBdId(sfId,param1)
else
temp=zongmenModel:getBuildingDataByBdType(sfId,param1)
end
if temp~=nil and#temp>0 then
for i,data in ipairs(temp)do
local config=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
local isLinkRoad=true
if config.is_connect_road==1 and not data.isLinkRoad then
isLinkRoad=false
end
if isLinkRoad then
if data.flag==0 then
table.insert(buildInfoList,data)
end
end
end
end
if#buildInfoList>0 then
local buildInfo
if param2==1 then

table.sort(buildInfoList,function(a,b)
return a.level<b.level
end)
buildInfo=buildInfoList[1]
elseif param2==2 then

table.sort(buildInfoList,function(a,b)
return a.level>b.level
end)
buildInfo=buildInfoList[1]
elseif param2==3 then

for i,v in ipairs(buildInfoList)do
if tostring(v.dizi_id)=='0'then
buildInfo=v
break
end
end
if buildInfo==nil then
buildInfo=buildInfoList[1]
end
elseif param2==4 then

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,param1)
local pro_skill_id=cfg.pro_skill_id
if pro_skill_id then
local max_pro_skill_lv=-1
for i,v in ipairs(buildInfoList)do
if tostring(v.dizi_id)~='0'then
local level=UIDiscipleModel:getDiscipleJobLevel(v.dizi_id,pro_skill_id)
if max_pro_skill_lv<level then
buildInfo=v
max_pro_skill_lv=level
end
end
end
end
if buildInfo==nil then
buildInfo=buildInfoList[1]
end
else

buildInfo=buildInfoList[1]
end

backParams.un_build_id=buildInfo.un_build_id
local pos=_MapManager.GetObjectAreaC(buildInfo.entityId)
return pos
end
backParams.errortxt=cameraMoveController.logNoBuilding()
backParams.tipstxt=FMT.fmt('找不到灵兽峰建筑物{0}',param1)
return nil
end,
}


local changeSceneFuncs={

[cameraMoveTargetType.eWorld_fishman]=function(screenParams)
local npcdatas=YiYuHuiYouModel:getNPCIdlist()
if npcdatas and#npcdatas>0 then
for i,npcdata in ipairs(npcdatas)do
local worldid=npcdata.world
local isOpenArea=worldBlockModel:checkWorldEnterLimit(worldid)
if isOpenArea then
return{screenParams[1],worldid}
end
end
end
return nil
end,
}

local _index

function cameraMoveController:onAppStart()
notifySystem:listenNotify(notifyConfig.enterWorld,self.enterWorldCompleted)
notifySystem:listenNotify(notifyConfig.onEnterHomeFinish,self.onEnterHomeFinish)
notifySystem:listenNotify(notifyConfig.enterXianJie,self.enterXianJie)
end
function cameraMoveController:onEnterState()
_index=0
end
function cameraMoveController:onLeaveState()
end
function cameraMoveController:onPlayerCreate(...)
end
function cameraMoveController:onLostConnection()
end
function cameraMoveController.enterWorldCompleted(type,world)
if cameraMoveController.loading~=true then return end
if type~=eWorldEnterPhase.Completed then return end
local screenType=cameraMoveController.screenParams[1]
if screenType==eSceneType.eWorld then
cameraMoveController:loadingFinish()
end
end

function cameraMoveController.onEnterHomeFinish()
if cameraMoveController.loading~=true then return end
local screenType=cameraMoveController.screenParams[1]
if screenType==eSceneType.eZongmen then
cameraMoveController:loadingFinish()
end
end

function cameraMoveController.enterXianJie(type)
if cameraMoveController.loading~=true then return end
local screenType=cameraMoveController.screenParams[1]
if screenType==eSceneType.eXianJie then
cameraMoveController:loadingFinish()
end
end


function cameraMoveController:Begin(screenParams,targetParams,callBack)
if cameraMoveController:isDoing()then
return false
end
self.screenParams=screenParams
self.targetParams=targetParams
self.callBack=callBack

self:doLoading()
return true
end

function cameraMoveController:doLoading()
self.loading=true
self.markTime=nil
_index=_index+1
self.index=_index
local change=false
local flag=true
if self.screenParams~=nil then

local screenParams_=self.screenParams
if self.targetParams~=nil then
local targetType=self.targetParams[1]
local changeFunc=changeSceneFuncs[targetType]
if changeFunc then
screenParams_=changeFunc(self.screenParams)
if screenParams_~=nil then
self.screenParams=screenParams_
end
end
end

if screenParams_~=nil then
local screenType=screenParams_[1]
local param1=screenParams_[2]
local cur=mainControl:getSceneType()
if cur~=screenType then
if screenType==eSceneType.eZongmen then


if mountainControl:isOpen(param1,true)then
flag=mainControl:enterHome({param1})
if flag then
change=true
end
else
flag=false
end
elseif screenType==eSceneType.eWorld then


local isOpenArea,warning=worldBlockModel:checkWorldEnterLimit(param1)
if isOpenArea then
flag=mainControl:enterWorld({param1})
if flag then
change=true
end
else
flag=false
UIManager.info(warning)
end
elseif screenType==eSceneType.eXianJie then









if param1>=0 then
if xianjieController:isSceneOpen(param1,true)then
flag=xianjieController:enterXianJie(param1)
if flag then
change=true
end
else
flag=false
end
elseif param1==-1 then
if xianjieController:checkXianYuOpen(true)then
flag=xianjieController:jumpXianJie(nil)
if flag then
change=true
end
else
flag=false
end
elseif param1==-2 then
local sceneType=xianjieModel:getCurrentMoJieSceneType()
if sceneType then
if xianjieController:isSceneOpen(sceneType,true)then
flag=xianjieController:enterXianJie(sceneType)
if flag then
change=true
end
else
flag=false
end
else
if xianjieController:checkXianYuOpen(true)then
flag=xianjieController:jumpXianJie(nil)
if flag then
change=true
end
else
flag=false
end
end
end
end
else
if screenType==eSceneType.eWorld and not worldModel:isSameWorld(param1)then
local isOpenArea,warning=worldBlockModel:checkWorldEnterLimit(param1)
if isOpenArea then
flag=worldController:enterWorld(param1,nil)
if flag then
change=true
end
else
flag=false
UIManager.info(warning)
end
elseif screenType==eSceneType.eZongmen and zongmenModel:getMountainId()~=param1 then
if mountainControl:isOpen(param1,true)then
local func=function()
cameraMoveController:loadingFinish()
end
flag=mountainControl:loadAndswitchMapEx(param1,true,func)
if flag then
change=true
end
else
flag=false
end
elseif screenType==eSceneType.eXianJie then
local sType
if param1>0 then
sType=param1
elseif param1==-1 then
local sceneidx_=xianjieModel:getXianYuSceneIndex()
sType=xianjieModel:sceneIndex2SceneType(sceneidx_)
elseif param1==-2 then
sType=xianjieModel:getCurrentMoJieSceneType()
end
if not xianjieModel:checkSceneType(sType)then
if xianjieController:isSceneOpen(sType,true)then
flag=xianjieController:enterXianJie(sType)
if flag then
change=true
end
else
flag=false
end
end
end
end
else
flag=false
end
end
if not flag then
cameraMoveController:doCallBack(false)
elseif not change then
self:loadingFinish()
end
end

function cameraMoveController:loadingFinish()
if self.loading~=true then return end

if self.targetParams==nil then
self:doCallBack(true,nil)
return
end

local targetType=self.targetParams[1]
local param1=self.targetParams[2]
local param2=self.targetParams[3]
local cur=mainControl:getSceneType()
local backParams={screenType=cur,targetType=targetType,screenParams=self.screenParams}
local funcidx=cameraMoveTargetFuncIdx[targetType]
local checkfunc=cameraMoveTargetFunc[funcidx]
local pos=checkfunc(targetType,backParams,param1,param2)
if pos==nil then
if backParams.tipstxt then
logErr(backParams.tipstxt)
end
if backParams.errortxt then
UIManager.error(backParams.errortxt)
end
self:doCallBack(false,nil)
return
end
local idx=self.index
local cb=function()
if self.index~=idx then return end
self:doCallBack(true,pos,backParams)
end
local ismark=true
if cur==eSceneType.eZongmen then

isometricMapSystem:moveCameraToPosition(pos,true,cb)
elseif cur==eSceneType.eWorld then

worldController:lookAtPosition(pos,nil,false,cb)
elseif cur==eSceneType.eXianJie then
local lookpos=xianjieController:worldGridPos2WorldPos4(pos.x,pos.y)

xianjieController:lookAtPosition(lookpos,nil,nil,cb)
else
ismark=false
end
if ismark then
self.markTime=Time.realtimeSinceStartup
end
end

function cameraMoveController.logNoBuilding()
return'此类建筑在升级中或道路未连接'
end

function cameraMoveController:doCallBack(flag,pos,params)
if self.callBack then
self.callBack(flag,pos,params)
end
self.loading=false
self.markTime=nil
self.screenParams=nil
self.targetParams=nil
self.callBack=nil
end

function cameraMoveController:isDoing()
if self.loading==true then

if self.markTime~=nil and Time.realtimeSinceStartup-self.markTime>=15 then
return false
end
return true
end
return false
end