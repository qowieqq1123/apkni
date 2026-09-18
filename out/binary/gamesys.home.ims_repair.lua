
function isometricMapSystem:showRepairBuilding(sfId)
local cfg=cfgHelper.get1(cfg_monijysfconfig_get,sfId)
local rplist=cfg.repair_build_list
if rplist==nil then return end
for k,v in pairs(rplist)do
local bdId=k
for ii,vv in ipairs(v)do
local key=vv
local areaId=self:getPosIndexArea(key)
if self:isCanShowArea(areaId)then

local status=zongmenModel:getRepairStatus(sfId,key)
if status and status==repairStatus.eNotRepaired then
self:createRepairBuilding(sfId,bdId,key)
end
end
end
end
end

function isometricMapSystem:autoRepair(sfId,areaId)
for k,v in pairs(self.repairDatas)do
if v.areaId==areaId then
local isAuto=cfgHelper.get2(cfg_monijybuildconfig_get,v.id,'auto_repair')
if isAuto then
zongmenControl:reqBuild(sfId,v.id,v.x,v.y,v.orientation)
end
end
end
end

function isometricMapSystem:getRepairDatas(mapId)
local list={}
for k,v in pairs(self.repairDatas)do
if v.mapId==mapId then
table.insert(list,v)
end
end
return list
end

function isometricMapSystem:getRepairDataByPosIdx(mapId,pos_idx)
for k,v in pairs(self.repairDatas)do
if v.mapId==mapId and v.pos_idx==pos_idx then
return v
end
end
end

function isometricMapSystem:getRepairData(mapId,x,y)
for k,v in pairs(self.repairDatas)do
if v.mapId==mapId and v.x==x and v.y==y then
return v
end
end
end

function isometricMapSystem:getRepairDataByID(mapId,id)
for k,v in pairs(self.repairDatas)do
if(v.mapId==mapId or mapId<0)and v.id==id then
return v
end
end
end

function isometricMapSystem:getUnlockRepairDataByID(mapId,id)
for k,v in pairs(self.repairDatas)do
if(v.mapId==mapId or mapId<0)and v.id==id and zongmenModel:isAreaUnlock(v.areaId)then
return v
end
end
end

function isometricMapSystem:getAllUnlockRepairDataByID(id)
local mountainCfg=cfg_monijysfconfig()
for _,v in ipairs(mountainCfg)do
local d=isometricMapSystem:getUnlockRepairDataByID(v.id,id)
if d then
return d
end
end
end

function isometricMapSystem:getRepairDataByEID(entityId)
return self.repairDatas[entityId]
end


function isometricMapSystem:getAnyRepairData(id,areaIdList)
local checkAreaId=function(areaId)
if areaIdList==nil or#areaIdList==0 then return true end
for i,v in ipairs(areaIdList)do
if v==areaId then
return true
end
end
return false
end
for k,v in pairs(self.repairDatas)do
if v.id==id and checkAreaId(v.areaId)and zongmenModel:isAreaUnlock(v.areaId)then
return v
end
end
end

function isometricMapSystem:getAllRepairData()
return self.repairDatas
end

function isometricMapSystem:removeRepairData(sfId,entityId)
local data=self.repairDatas[entityId]
hudControl:removeProgressData(data.rpId)
self.repairDatas[entityId]=nil
end

function isometricMapSystem:playRepairAddModelAnim(guid,modelId,animName)
local add_list=self:getAppendModel(guid)
if not add_list then
return
end
local tId
for k,v in pairs(add_list)do
if v==modelId then
tId=k
end
end
if not tId then
return
end
_MapManager.RunAnimator(tId,eAnimationID[animName])
end

function isometricMapSystem:isRepairBuilding(guid)
local repairData=self.repairDatas[guid]
if repairData then
return true
end
local bdData=zongmenModel:findBuildingByEntityId(guid)
if bdData then
local ftype=zongmenModel:getBDFlagType(bdData.flag)
if ftype==bdFlagType.sectionBuildStart or ftype==bdFlagType.sectionBuildComplete then
return true
end
end
return false
end

function isometricMapSystem:getPosIndexArea(index)
if not self.posIndexAreaData then
self.posIndexAreaData={}
end
if not self.posIndexAreaData[index]then
local cfg=cfgHelper.get1(cfg_monijyposidxconfig_get,index)
local vp=_MapManager.ToVector3Int(cfg.pos[1],cfg.pos[2],0)
local areaId=_MapManager.GetAreaID(cfg.mapId,vp)
self.posIndexAreaData[index]=areaId
end
return self.posIndexAreaData[index]
end

function isometricMapSystem:createRepairBuilding(sfId,bdId,posIndex)
local bdcfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdId)
local pcfg=cfgHelper.get1(cfg_monijyposidxconfig_get,posIndex)
local x=pcfg.pos[1]
local y=pcfg.pos[2]
local orientation=pcfg.orientation or 0
local pos=_MapManager.ToVector3Int(x,y,0)
local bx=bdcfg.buid_size[1]
local by=bdcfg.buid_size[2]
local offset=self:countOffset(bx,by)
local mdata=self:getModelByStatus(bdId,1,-1)
local model=mdata.model
local scale=mdata.scale





local flip=orientation==1
local guid=isometricMapSystem:createBuildingEntity(objectType.ePlaceObject,sfId,bdId,model,nil,SortingLayers.ITBuilding,true,
flip,scale,pos,offset,0)
isometricMapSystem:addNameHud(guid,bdcfg.id)
isometricMapSystem:addQiYuHud(guid,bdcfg.id)
if bdcfg.showShadow then
_MapManager.ShowShadow(guid,true)
end

local lock=false
if bdcfg.sp_model then
local st=self:showSpecialModel(guid,bdcfg,0,true)
if not st then
lock=true
end
end






if mdata.offset then
_MapManager.SetOffset(guid,Vector3.New(mdata.offset[1],mdata.offset[2],0))
end

if sfId==mapIdType.xianmeng then
if not zongmenControl:checkMinNeedLevel(bdcfg,sfId)then
_MapManager.SetFadeToColor(guid,Color.New(0.65,0.65,0.65,1),0,nil)
end
end

local rpId=FMT.fmt('{0}_{1}_{2}',bdId,x,y)


local bdData={
build_id=bdId,
un_build_id=rpId,
entityId=guid,
orientation=orientation,
level=0,
x=x,
y=y,
flag=-1,
}

self:createAppendModel(bdData)

local areaId=_MapManager.GetAreaIDByObject(guid)
self.repairDatas[guid]={id=bdId,
type=bdcfg.build_type,
x=x,
y=y,
guid=guid,
model=model,
scale=scale,
areaId=areaId,
rpId=rpId,
orientation=orientation,
mapId=sfId,
lock=lock,
bdData=bdData,
pos_idx=posIndex
}
self:setLockPlaceObject(guid,true)


hudControl:addProgressData(sfId,rpId,true,bdData)
end

function isometricMapSystem:canBuildRepair(data)
local cfg=cfg_monijybuildconfig_get(data.id)
if isometricMapSystem:checkRepairBuildOpen(data,cfg)then
local check1=isometricMapSystem:checkRepairLevel(data.id,data.mapId)
local check2=isometricMapSystem:checkRepairTask(data.id,data.mapId)
if check1 and check2 then
if isometricMapSystem:checkRepairCost(cfg)then
return true
end
end
end
return false
end

function isometricMapSystem:readyBuildRepair(data)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.id)
if isometricMapSystem:checkRepairBuildOpen(data,cfg)then
local check1=isometricMapSystem:checkRepairLevel(data.id,data.mapId)
local check2=isometricMapSystem:checkRepairTask(data.id,data.mapId)
if check1 and check2 then
if not isometricMapSystem:checkRepairCost(cfg)then
return true
end
end
end
return false
end

function isometricMapSystem:checkRepairBuildOpen(data,cfg)
if cfg.repair_tips then
local tipsData=nil
for i,v in ipairs(cfg.repair_tips)do
local pass=isometricMapSystem:checkRepairTips(v)
if not pass then
tipsData=v
break
end
end
return tipsData==nil,tipsData
else
local checkUnlock=isometricMapSystem:isInUnlockArea(data.guid)
return checkUnlock
end
end

function isometricMapSystem:checkRepairTips(tipsdata)
local ctype=tipsdata.ctype
if ctype==1 then
local areaId=tipsdata.cargs[1]

local isUnlock=zongmenModel:isAreaUnlock(areaId)
return isUnlock
elseif ctype==2 then
local isOpen=systemModel.isOpen(tipsdata.cargs[1])
return isOpen
elseif ctype==3 then
local isOpen=taskModel:checkTaskFinish(tipsdata.cargs[1])
return isOpen
elseif ctype==4 then
local day=timeHelper.getServerOpenDay()
return day>=tipsdata.cargs[1]
elseif ctype==5 then
local count=gameUtilityModel:getData_counter(gameCounterType.eFinishingNum)
return count>=tipsdata.cargs[1]
elseif ctype==6 then
local level=yandaotaiModel:getTechnologyListLevel(tipsdata.cargs[1])or 0
return level>=tipsdata.cargs[2]
elseif ctype==7 then
local defaultVersionId=pfwindowslController:getGameVersion()
if defaultVersionId==tipsdata.cargs[1]then
local isOpen=systemModel.isOpen(tipsdata.cargs[2])
return isOpen
end
return true
end
return false
end

function isometricMapSystem:checkRepairCostEx(buildid,idx,wraning)
local cfg=cfg_monijybuildconfig_get(buildid)
return isometricMapSystem:checkRepairCost(cfg,idx,wraning)
end

function isometricMapSystem:checkRepairCost(cfg,idx,wraning)
idx=idx or 1
local repair_cost=cfg.repair_cost or{}
local costData=repair_cost[idx]or{}
for i,v in ipairs(costData)do
local id=v[1]
local need=v[2]
if moneyConfig.isMoney(id)then
local have=moneyModel.getMoney(id)
if have<need then
if wraning then
UIManager.error(FMT.fmt('{0}不足',moneyModel.getMoneyName(id)))
gainControl:showGainWin(id)
end
return false,id
end
else
local have=bagModel.getItemCountById(id)
if have<need then
if wraning then
UIManager.error(FMT.fmt('{0}不足',itemsConfig.getItemName(id)))
gainControl:showGainWin(id)
end
return false,id
end
end
end
return true
end

function isometricMapSystem:checkRepairLevel(buildid,mapId,wraning)
local sfId=mapId
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildid)
if cfg.guildlvl_limit then
local isXM=sfId==mapIdType.xianmeng
local level=zongmenModel:getLevel()
if isXM then
local xmLv=xianmengModel:getXMLevel()
level=xmLv or-1
end
for i,v in ipairs(cfg.guildlvl_limit)do
if v.param[sfId]then
if level>=v[1]then
return true
else
if wraning then
if isXM then
UIManager.error(FMT.fmt('需要仙盟达到{0}级',v[1]))
else
UIManager.error(FMT.fmt('需要宗门达到{0}级',v[1]))
end
end
return false,v[1]
end
end
end
end
return true
end

function isometricMapSystem:checkRepairTask(buildid,mapId,wraning)
local sfId=mapId
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildid)
if cfg.task_add_buildcnt then
for k,v in pairs(tcfg.task_add_buildcnt)do
local c=v[sfId]or 0
if c>0 then
if not taskModel:checkTaskFinish(k)then
if wraning then
local name=taskModel:getTaskConfig(k).name
UIManager.error(FMT.fmt('完成任务{0}解锁',name))
end
return false,k
end
end
end
end
return true
end
