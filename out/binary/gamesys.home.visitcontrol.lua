

visitControl=gameState.addListener(fullScreenUI.create())

local _openWinFunc={
[SLG_SYSTEM_TYPE.eGuanJun1]=function(args)
UIManager:showWindow("UILDDiaoXiangShowWin",args.data)
end,
[SLG_SYSTEM_TYPE.eGuanJun2]=function(args)
UIManager:showWindow("UILDDiaoXiangShowWin",args.data)
end,
[SLG_SYSTEM_TYPE.eGuanJun3]=function(args)
UIManager:showWindow("UILDDiaoXiangShowWin",args.data)
end,
}

function visitControl:onAppStart()
socketManager:register_receiver(254,52,self.recv_254_52)

self.visitMapIds={[1]=5}
self.dataMapIds={[5]=1}
end

function visitControl:onEnterState(isReconnect)
if isReconnect then
return
end

self.data={}
self.data.mountainData={}
self.lastRecvTime=0

self.npcIdIndex=0
self.diziAIBTList={}
self.diziAISTList={}
self.diziInMapData={}

self.modelList={}

self.repairDatas={}

self.planStateRecord={}

notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
end

function visitControl:onLeaveState(isReconnect)
if isReconnect then
return
end

self.data=nil
self.waitEntermap=nil
self.modelList=nil
self.diziAIBTList=nil
self.diziAISTList=nil
self.diziInMapData=nil

self.planStateRecord=nil

notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
end

function visitControl.on_home_event(etype)
if etype==homeEvent.eEnterHome then
visitControl:onEnterHome()
elseif etype==homeEvent.eLeaveHome then
visitControl:onLeaveHome()
end
end

function visitControl:onEnterHome()

end

function visitControl:onLeaveHome()
self:clearMap(true)
end

function visitControl:getVisitDZGUID()
self.npcIdIndex=self.npcIdIndex+1
return FMT.fmt('visit_dz_{0}',self.npcIdIndex)
end

function visitControl:getDataMapId(vmapId)
return self.dataMapIds[vmapId]
end

function visitControl:getVisitMapId(mapId)
return self.visitMapIds[mapId]
end

function visitControl:getBirthPointList(vmapId)
local aicfg=cfgHelper.get1(cfg_discipleaiconfig_get,1)
local birthPoints={}
local mapId=self:getDataMapId(vmapId)
for i,v in ipairs(aicfg.birthPoint[mapId])do
local pos=_MapManager.ToVector3Int(v[1],v[2],0)
local areaId=_MapManager.GetAreaID(vmapId,pos)
if _MapManager.IsAreaUnlock(vmapId,areaId)then
table.insert(birthPoints,v)
end
end
return birthPoints
end

function visitControl:getVisitDiZiSTID(dzId)
return self.diziAISTList[dzId]
end

function visitControl:getVisitDiZiInMapId(dzId)
return self.diziInMapData[dzId]
end

function visitControl:enterGroundModel()
for k,v in pairs(self.repairDatas)do
local skinId=v.build_appearance_id or 0
local mdata=isometricMapSystem:getModelByStatus(v.id,1,-1,nil,nil,nil,nil,skinId)
isometricMapSystem:changeBody(v.guid,mdata.model,mdata.slots,mdata.scale)
_MapManager.SetSortingLayer(v.guid,mdata.layer)
end
visitControl:changeBuildingModelInMap(mapIdType.zhufeng_hy)
end

function visitControl:leaveGroundModel()
for k,v in pairs(self.repairDatas)do
isometricMapSystem:changeBody(v.guid,v.model,nil,v.scale)
end
visitControl:changeBuildingModelInMap(mapIdType.zhufeng_hy)
end

function visitControl:changeBuildingModelInMap(mapId)
local buildingDatas=self:getAllBuildingData(mapId)
for k,v in pairs(buildingDatas)do
isometricMapSystem:changeModel(v)
end
end



function visitControl:setDatas(datas)
local actorData={}
actorData.actorId=datas[1]
actorData.actorName=datas[3]
actorData.actorIcon=datas[4]
actorData.zmLevel=datas[5]
actorData.zmName=datas[6]
actorData.zmFValue=datas[7]
actorData.createTime=datas[8]
actorData.cefengopen=datas[13]
self.data.actorData=actorData
for i,v in ipairs(datas[10])do
visitControl:setMountainDatas(v)
end
end

function visitControl:getActorData()
return self.data.actorData
end

function visitControl:setMountainDatas(datas)
local mdata={}
local mapId=datas.sf_id
local vmapId=self:getVisitMapId(mapId)
mdata.id=mapId
mdata.areaDatas={}
if datas.open_area_list_len>0 then
for i,v in ipairs(datas.areaList)do
mdata.areaDatas[v.area_id]=v
end
end
mdata.buildingDatas={}
if datas.open_build_list_len>0 then
for i,v in ipairs(datas.buildList)do
local cfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,v.build_id,v.level)
if cfg.produce_plans then
local len=#cfg.produce_plans
v.plant_id=math.random(1,len)
else
v.plant_id=0
end
if v.plant_id>0 then
local state=self.planStateRecord[v.un_build_id]
if not state then
state=math.random(planStatus.eStart,planStatus.eComplete)
self.planStateRecord[v.un_build_id]=state
end
v.planStatus=state
else
v.planStatus=planStatus.eDefault
end

mdata.buildingDatas[v.un_build_id]=v
end
end
mdata.repairDatas={}
local cfg=cfgHelper.get1(cfg_monijysfconfig_get,mdata.id)
local rplist=cfg.repair_build_list or{}
for k,v in pairs(rplist)do
for ii,vv in ipairs(v)do
local pcfg=cfgHelper.get1(cfg_monijyposidxconfig_get,vv)
mdata.repairDatas[vv]={state=repairStatus.eNotRepaired,x=pcfg.pos[1],y=pcfg.pos[2]}
end
end
if datas.repair_build_len>0 then
for i,v in ipairs(datas.repairbuildList)do
for ii,vv in ipairs(v.coodList)do
local sd=mdata.repairDatas[vv.param_1]or{}
sd.state=repairStatus.eUnderRepair
sd.guid=vv.param_2
mdata.repairDatas[vv.param_1]=sd
end
end
end
if datas.statuelistlen>0 then
mdata.statueList={}
for i,v in ipairs(datas.statueList)do
local statue={}
statue.un_build_id=v.param_1
statue.jieShu=v.param_2
statue.rank=v.param_3
mdata.statueList[v.param_1]=statue
end
end

local roadDatas={}
if datas.road_len>0 then
for i,v in ipairs(datas.roadlist)do
local key=FMT.fmt('{0}_{1}',v.param_1,v.param_2)
roadDatas[key]={x=v.param_1,y=v.param_2,style=v.param_4,type=v.param_3}
end
end
mdata.roadDatas=roadDatas

local skyBuildingDatas={}
if datas.sky_build_len>0 then
for i,v in ipairs(datas.skybuildlist)do
skyBuildingDatas[v.param_1]={
un_build_id=v.param_1,
build_id=v.param_2,
orientation=v.param_3,
x=v.param_4,
y=v.param_5
}
end
end
mdata.skyBuildingDatas=skyBuildingDatas

self.data.mountainData[vmapId]=mdata
end

function visitControl:getCurrentActor()
local data=self:getActorData()
return data and data.actorId or 0
end

function visitControl:isCanShowNewArea()
local data=self:getActorData()
return data and data.cefengopen==1
end

function visitControl:isCurrentActor(actorId)
return tostring(self:getCurrentActor())==tostring(actorId)
end

function visitControl:getMountainData(sfId)
return self.data.mountainData[sfId]
end

function visitControl:getRoadDatas(sfId)
local mdata=self:getMountainData(sfId)
return mdata and mdata.roadDatas
end

function visitControl:getAllAreaData(sfId)
local mdata=self:getMountainData(sfId)
return mdata and mdata.areaDatas
end

function visitControl:getAllBuildingData(sfId)
local mdata=self:getMountainData(sfId)
return mdata and mdata.buildingDatas or{}
end

function visitControl:getAllSkyBuildingData(sfId)
local mdata=self:getMountainData(sfId)
return mdata and mdata.skyBuildingDatas or{}
end

function visitControl:getBuildingData(sfId,guid)
local mdata=self:getMountainData(sfId)
if mdata then
return mdata.buildingDatas and mdata.buildingDatas[guid]
end
end

function visitControl:getBuildingDataByentityId(sfId,entityId)
local mdata=self:getMountainData(sfId)
if mdata and mdata.buildingDatas then
for guid,v in pairs(mdata.buildingDatas)do
if entityId==v.entityId then
return v
end
end
end
end

function visitControl:getRepairStatus(sfId,key)
local mdata=self:getMountainData(sfId)
if mdata then
local sd=mdata.repairDatas[key]
if sd then
return sd.state
end
end
end

function visitControl:setRepairStatus(sfId,status,key)
local mdata=self:getMountainData(sfId)
if mdata then
local sd=mdata.repairDatas[key]
sd.state=status
end
end

function visitControl:getRepairStatusById(sfId,guid)
local mdata=self:getMountainData(sfId)
if mdata then
for k,v in pairs(mdata.repairDatas)do
if v.guid==guid then
return self:getRepairStatus(sfId,k)
end
end
end
end

function visitControl:setRepairStatusById(sfId,status,guid)
local mdata=self:getMountainData(sfId)
if mdata then
for k,v in pairs(mdata.repairDatas)do
if v.guid==guid then
self:setRepairStatus(sfId,status,k)
end
end
end
end

function visitControl:getStatueData(sfId,guid)
local mdata=self:getMountainData(sfId)
if mdata.statueList then
return mdata.statueList[guid]
end
end

local _visitCallBack=nil
function visitControl:reqVisitData(serverid,actorId,callback)
if callback then
_visitCallBack=callback
end
if serverid==nil or playerModel:checkServerId(serverid)then
socketManager:send_254_52(actorId)
else
socketManager:send_254_81(serverid,actorId)
end
end

function visitControl.recv_254_52(datas)
local errId=datas[2]
if errId>0 then
if errId==1 then
UIManager.error('玩家不存在')
end
if errId==3 then
UIManager.error('玩家离线超过7天')
end
return
end
if _visitCallBack then
_visitCallBack()
_visitCallBack=nil
end
visitControl:setDatas(datas)

visitControl:afterRecvData()
end



function visitControl:afterRecvData()
self.lastRecvTime=gameUtilityModel.getServerShortTime()
if self.waitEntermap then
self.waitEntermap=false
self:enterVisitMap()
end
end

function visitControl:openVisitWin()
UIManager:showWindow('UIVisitWin')
end

function visitControl:closeVisitWin()
UIManager:closeWindow('UIVisitWin')
end

function visitControl:IsCanReqData(actorId)

local time=gameUtilityModel.getServerShortTime()
if time-self.lastRecvTime>60 then
return true
end

if not visitControl:isCurrentActor(actorId)then
return true
end

return false
end

function visitControl:reqEnterVisitMap(serverid,actorId,callback)

if visitControl:IsCanReqData(actorId)then
mountainControl:removeMap(mapIdType.zhufeng_hy)
self:reqVisitData(serverid,actorId,callback)
self.waitEntermap=true
else
self:enterVisitMap()
end


local xmMember=xianmengModel:getXMMemberData(actorId)
if xmMember then
tianMoJieController:send_34_122(actorId)
end
end

function visitControl:clearMap(isLeaveHome)
if not isLeaveHome then
for k,v in pairs(self.diziAIBTList)do
aiManager:removeDiscipleAI(k)
end
end
self.diziAIBTList={}

for k,v in pairs(self.data.mountainData)do
for kk,vv in pairs(v.buildingDatas)do
_MapManager.RemoveTilemapObject(vv.entityId)
end
for kk,vv in pairs(v.skyBuildingDatas)do
_MapManager.RemoveTilemapObject(vv.entityId)
end
end

for k,v in pairs(self.modelList)do
_EntityManager:RemoveEntity(v)
end
self.modelList={}
end

function visitControl:removeBuildingBehavior(mapId)
local buildingDatas=self:getAllSkyBuildingData(mapId)
for k,v in pairs(buildingDatas)do
if v.stand_bt then
behaviorManager:removeBehaviorTree(v.stand_bt)
v.stand_bt=nil
end
end
end

function visitControl:enterVisitMap()
local sfId=zongmenModel:getMountainId()
if sfId and sfId~=mapIdType.zhufeng_hy then
self.oSf=zongmenModel:getMountainId()
end
mountainControl:loadAndswitchMapEx(mapIdType.zhufeng_hy,true,function()
notifySystem:postNotify(notifyConfig.onEnterOtherHome,self:getCurrentActor())
end)
end

function visitControl:leaveVisitMap()
notifySystem:postNotify(notifyConfig.onExitOtherHome,self:getCurrentActor())

mountainControl:loadAndswitchMapEx(self.oSf or mapIdType.zhufeng,true,function()

end)
self.oSf=nil
end

function visitControl:loadAndSetMountain(mapId)
local areaDatas=self:getAllAreaData(mapId)
for k,v in pairs(areaDatas)do
_MapManager.SetAreaUnlockStatus(mapId,k,true)
end

self:createBuilding(mapId)
self:createSkyBuilding(mapId)

self:createRepairBuilding(mapId)

isometricMapSystem:setNewAreaShow(mapId)

isometricMapSystem:drawArea(mapId,-1,nil,nil,nil)






local check=self:isCanShowNewArea(mapId)
local cfgs=cfg_monijyareaconfig()
for k,v in pairs(cfgs)do
if v.sf_id==mapIdType.zhufeng and(not isometricMapSystem:isNewMapArea(k)or check)and not zongmenModel:isAreaUnlockInMap(mapId,k)then
_MapManager.LoadSundriseByArea(mapId,k,function(mId,areaId,cfgId,flip,pos)
isometricMapSystem:createSundries({id=cfgId,flip=flip,pos=pos,areaId=areaId,mapId=mapId})
end)
end
end








isometricMapSystem:loadLockAreaRoad(mapId)

isometricMapSystem:setAreaCellBrightness(mapId,-1,true)

local roadDatas=visitControl:getRoadDatas(mapId)
isometricMapSystem:drawRoad(mapId,roadDatas)

self:loadVisitMapAI(mapId)
end

function visitControl:createRepairBuilding(mapId)
local bcfg=cfgHelper.get1(cfg_monijybasicconfig_get,1)
local cv=bcfg.lock_area_brightness
local color=Color.New(cv,cv,cv,1)

local cfg=cfgHelper.get1(cfg_monijysfconfig_get,mapId)
local rplist=cfg.repair_build_list or{}
for k,v in pairs(rplist)do
local bdId=k
local bdcfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdId)
for ii,vv in ipairs(v)do
local areaId=isometricMapSystem:getPosIndexArea(vv)
if isometricMapSystem:isCanShowArea(areaId,mapId)then
local key=vv
local pcfg=cfgHelper.get1(cfg_monijyposidxconfig_get,key)
local x=pcfg.pos[1]
local y=pcfg.pos[2]
local orientation=pcfg.orientation or 0
local status=self:getRepairStatus(mapId,key)
if status and status==repairStatus.eNotRepaired then
local pos=_MapManager.ToVector3Int(x,y,0)
local bx=bdcfg.buid_size[1]
local by=bdcfg.buid_size[2]
local offset=isometricMapSystem:countOffset(bx,by)
local ground_model=bdcfg.ground_model
local model=bdcfg.repair_model[1]
local scale=isometricMapSystem:getModelScale(model)
local flip=orientation==1
local show_mode=isometricMapSystem:isInGroundModel()and ground_model or model
local guid=isometricMapSystem:createBuildingEntity(objectType.ePlaceObject,mapId,bdId,show_mode,nil,SortingLayers.ITBuilding,true,
flip,scale,pos,offset,0)

if bdcfg.sp_model then
local modelId,spLevel=isometricMapSystem:getSpecialModelID(bdcfg,0,true)
if modelId then
local st=isometricMapSystem:createModelEntity(modelId)
st:SetPosition(Vector3.New(10000,0,0))
self.modelList[guid]=st.GUID
end
end


local bdData={
build_id=bdId,

entityId=guid,


x=x,
y=y,

}

self.repairDatas[guid]={id=bdId,
type=bdcfg.build_type,
x=x,
y=y,
guid=guid,
model=model,
scale=scale,


orientation=orientation,
mapId=mapId,

bdData=bdData,
}

visitControl:createAppendModel(bdData)

if not zongmenModel:isAreaUnlockInMap(mapId,areaId)then
_MapManager.SetFadeToColor(guid,color,0,nil)
end
end
end
end
end
end

function visitControl:createBuilding(sfId)
local buildingDatas=self:getAllBuildingData(sfId)
for k,v in pairs(buildingDatas)do
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.build_id)
local mdata=isometricMapSystem:getModelByData(v)
local bx=cfg.buid_size[1]
local by=cfg.buid_size[2]
local offset=isometricMapSystem:countOffset(bx,by)
local pos=_MapManager.ToVector3Int(v.x,v.y,0)
local guid=isometricMapSystem:createBuildingEntity(objectType.ePlaceObject,sfId,v.build_id,mdata.model,mdata.slots,mdata.layer,true,
v.orientation~=0,mdata.scale,pos,offset)

v.entityId=guid



if cfg.sp_model then

if v.flag>0 and v.flag~=2 and v.level==1 then
self:showSpecialModel(guid,cfg,0,true,v.flag)
else
self:showSpecialModel(guid,cfg,v.level,false)
end
end






if cfg.showShadow then
_MapManager.ShowShadow(guid,true)
end

local status=self:getRepairStatusById(sfId,v.un_build_id)
if status and status~=repairStatus.eNotRepaired then
if v.flag==0 then
self:setRepairStatusById(sfId,repairStatus.eRepaired,v.un_build_id)
end
end









if v.plant_id>0 then
buildingEffectControl:playEffectByEID(guid,v.build_id,buildEffectType.eProduce,nil,nil,nil,v.build_appearance_id)
end
end
end

function visitControl:createSkyBuilding(mapId)
local buildingDatas=self:getAllSkyBuildingData(mapId)
for k,v in pairs(buildingDatas)do
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.build_id)
if cfg==nil then
loggerUtil.logErrFMT("没有建筑配置 id:{0}",v.build_id)
end
local bx=cfg.buid_size[1]
local by=cfg.buid_size[2]
local offset=isometricMapSystem:countOffset(bx,by)
local pos=_MapManager.ToVector3Int(v.x,v.y,0)
local model=cfg.model[1]
local scale=isometricMapSystem:getModelScale(model)
local guid=isometricMapSystem:createBuildingEntity(objectType.eSkyPlaceObject,mapId,v.build_id,model,nil,SortingLayers.ITSkyBD,true,
v.orientation~=0,scale,pos,offset,conditionConfig.skyPlace)
v.entityId=guid

_MapManager.SetPlaceObjectCover(guid,false)

v.stand_bt=isometricMapSystem:createBehaviorBT(mapId,guid,cfg.stand_behavior)
end
zongmenModel:setSkyBuildingClickEnable(mapId,false)
end

function visitControl:showSpecialModel(guid,cfg,level,repair,stageflag)
local modelId,spLevel=isometricMapSystem:getSpecialModelID(cfg,level,repair,stageflag)
if modelId then
local st=isometricMapSystem:createModelEntity(modelId)
st:SetPosition(Vector3.New(10000,0,0))
self.modelList[guid]=st.GUID
if cfg.sp_level_up then
local sdata=cfg.sp_level_up[spLevel]
if sdata.scenery then
local mapId=_MapManager.GetObjectMapID(guid)
for i,v in ipairs(sdata.scenery)do
surfaceControl:setSurfacePartActive(v,mapId,true)
end
end
end
end
end

function visitControl:createAppendModel(bdData)
local add_model=cfgHelper.get2(cfg_monijybuildconfig_get,bdData.build_id,'add_model')
if not add_model then
return
end
local bdpos=_MapManager.ToVector3Int(bdData.x,bdData.y,0)
local mapId=_MapManager.GetObjectMapID(bdData.entityId)
for i,v in ipairs(add_model)do
local scale=isometricMapSystem:getModelScale(v.model)
local offset=Vector3.New(v.offset[1],v.offset[2],0)
local guid=_MapManager.CreateTilemapObject(objectType.eDefault,v.model,nil,SortingLayers.ITBuilding,scale,mapId,bdpos,offset)
_MapManager.RunAnimator(guid,eAnimationID.stand)
end
end

function visitControl:createVisitRole(mapId,npcid,pos)
local guid
local image=npcModel:getImageInfoOutSide(npcid,2)
if image then
local bodyid=image.body
local componets=image.componets
local scale=isometricMapSystem:getModelScale(bodyid)
guid=isometricMapSystem:createRoleEntity(objectType.eVisitRole,mapId,0,bodyid,componets,SortingLayers.ITBuilding,scale,pos)
_MapManager.ShowShadow(guid,true)
else
logErr(FMT.fmt("没有找到npcid:{0}的配置",npcid))
end
return guid
end

function visitControl:loadVisitMapAI(mapId)
local randomLib=cfgHelper.get2(cfg_visitmapdiscipleconfig_get,mapId,'randomlib')
local zmLevel=zongmenModel:getLevel()
local data
for i,v in ipairs(randomLib)do
if zmLevel>=v[1]and zmLevel<=v[2]then
data=v
break
end
end
if not data then
UIManager.error('没有对应等级的弟子抽取库，宗门等级：',zmLevel)
return
end

local list={}
for i,v in ipairs(data.fixed)do
list[i]=v
end

local rlist={}
for i,v in ipairs(data.random[2])do
rlist[i]=v
end

local len=#rlist
for i,v in ipairs(rlist)do
local p=math.random(1,len)
local pv=rlist[p]
rlist[p]=rlist[i]
rlist[i]=pv
end

for i=1,data.random[1]do
table.insert(list,rlist[i])
end

local birthPoints=visitControl:getBirthPointList(mapId)
local bplen=#birthPoints

for i,v in ipairs(list)do
local bp=birthPoints[math.random(1,bplen)]
local spos=_MapManager.ToVector3Int(bp[1],bp[2],0)

local guid=self:createVisitRole(mapId,v,spos)
local dzId=self:getVisitDZGUID()
local bt=aiManager:addDiscipleAI(dzId,guid,eAIDZType.eVisitDiZi)
self.diziAIBTList[dzId]=bt
self.diziAISTList[dzId]=guid
self.diziInMapData[dzId]=mapId
end
end

function visitControl:onTouchUp(guid)
local objType=_MapManager.GetObjectType(guid)

if objType==objectType.eTianMoJieMonster then
tianMoJieController:checkEntityClick(guid)
return
end

if objType==objectType.eZMVisitor then
UIFullZongMenVisitorControl:showMainWindow()
else
local sfId=zongmenModel:getMountainId()
local building=visitControl:getBuildingDataByentityId(sfId,guid)

if building then
visitControl:openBuildingWin(building)
end
end
end

function visitControl:onTouchUpList(screenPoint,guidList)













local guid=guidList[1]or-1
return self:onTouchUp(guid)
end

function visitControl:openBuildingWin(data,args)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
local func=_openWinFunc[cfg.id]
args=args or{}
if func then
data.isVisit=true
func({data=data,args=args})
return true
else
return false
end
end