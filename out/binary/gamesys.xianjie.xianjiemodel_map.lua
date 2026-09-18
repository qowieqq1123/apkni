








xjMapGridStateType={

eCloudLock=2,
eCloudPlot=3,
eNPC=4,
eMonster=5,
eResource=6,
eStation=7,
eXianMeng=8,
eZongMen=9,
eYuanJun=10,
eCloudQiYu=11,
eResPoint=12,
eLeyLine=13,
eTransfer=14,
eXJFMBoss=15,
eArena=16,
eXJXingYu=17,
eMoGong=18,
eMoJiang=19,
eMoJiangRange=20,
eMoJingZhenJi_Origin=21,
eMoJieGate=22,
eMoJun=23,
eMoJunRange=24,
eCaravanEscortEnter=25,
eCaravanEscortHub=26,
eZhanHunGe=27,
eHuLingTa=28,
eZhenTai=29,
eMoGongRange=30,
eMoJingZhenJi_Normal=31,
eZhenTaiRange=32,
eLingShou=33,
eLingShouGroup=34,
}

function xianjieModel:initMapConfig()
local mapSizeLookup={}
local sceneidxcfgs=cfg_fairylandsceneidxconfig()
for sceneidx,sceneidxcfg in pairs(sceneidxcfgs)do






local mapSize,mapSize_w,mapOffset=xianjieController:calculateMapSize(sceneidxcfg)
local mapRadius=sceneidxcfg.mapRadius
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(0,0,mapSize[1],mapSize[2])
local mapCenterGrid={gridX_c,gridZ_c}
mapSizeLookup[sceneidx]={mapSize,mapSize_w,mapOffset,mapRadius,mapCenterGrid}
end
self.mapSizeLookup=mapSizeLookup
xianjieModel:initGridStateType()
end

function xianjieModel:clearMapConfig()
self.mapSizeLookup=nil
self.gridStateLookup=nil
self.gridLimitLookup=nil
self.gridZFLimitLookup=nil
xianjieModel:clearAllTransfer()
xianjieModel:clearMapConfig_leave()
end

function xianjieModel:clearMapConfig_leave()
self.mapGridDataLookup=nil
end

function xianjieModel:getMapSize(sceneidx)
local d=self.mapSizeLookup[sceneidx]

return d[1]
end

function xianjieModel:getMapSize2(sceneidx)
local d=self.mapSizeLookup[sceneidx]

return d[3]
end

function xianjieModel:getMapSize3(sceneidx)
local d=self.mapSizeLookup[sceneidx]

return d[2]
end

function xianjieModel:getMapSize4(sceneidx)
local d=self.mapSizeLookup[sceneidx]

return d[1],d[2],d[3]
end

function xianjieModel:getMapRadius(sceneidx)
local d=self.mapSizeLookup[sceneidx]
return d[4],d[5]
end



function xianjieModel:initTransferData()
local transferLookup={}
local xjsceneidx=xianjienSceneIndexType.eXianJie
transferLookup[xjsceneidx]={}
local sceneidxcfgs=cfg_fairylandsceneidxconfig()
for sceneidx,sceneidxcfg in pairs(sceneidxcfgs)do

if sceneidx~=xjsceneidx and sceneidxcfg.resPos~=nil then
transferLookup[sceneidx]={}
local resPos=sceneidxcfg.resPos
local tagPos=sceneidxcfg.tagPos
local data1={sceneidx=sceneidx,gridX=resPos[1],gridZ=resPos[2],gridWidth=1,gridHeight=1,tagPos={xjsceneidx,tagPos[1],tagPos[2]},}
data1.effectCfg=sceneidxcfg.resEffect
local transferData1=xianjieController:createXJClass(xjDataType.eTransfer,data1)
transferLookup[sceneidx][xjsceneidx]=transferData1
local data2={sceneidx=xjsceneidx,gridX=tagPos[1],gridZ=tagPos[2],gridWidth=1,gridHeight=1,tagPos={sceneidx,resPos[1],resPos[2]},}
data2.effectCfg=sceneidxcfg.tagEffect
local transferData2=xianjieController:createXJClass(xjDataType.eTransfer,data2)
transferLookup[xjsceneidx][sceneidx]=transferData2
end
end
self.transferLookup=transferLookup
end

function xianjieModel:getTransfer(s_sceneidx,e_sceneidx)
local lp=self.transferLookup
if lp and lp[s_sceneidx]then
return lp[s_sceneidx][e_sceneidx]
end
end

function xianjieModel:createAllTransferEntities(needRefreshAOI)
if self.transferLookup then
local sceneidx=xianjieModel:getSceneIndex()
local lp=self.transferLookup[sceneidx]
if lp then
local check
for e_sceneidx,transferData in pairs(lp)do
check=true
if xianjienSceneIndexType:isXianYu(e_sceneidx)and xianjieModel:getXianYuCrossServerId(e_sceneidx)==nil then
check=false
end
if check==true then
transferData:createEntity(needRefreshAOI)
end
end
end
end
end

function xianjieModel:removeAllTransferEntities()
if self.transferLookup then
local sceneidx=xianjieModel:getSceneIndex()
local lp=self.transferLookup[sceneidx]
if lp then
for e_sceneidx,transferData in pairs(lp)do
transferData:removeEntity()
end
end
end
end

function xianjieModel:clearAllTransfer()
if self.transferLookup then
for s_sceneidx,lp in pairs(self.transferLookup)do
for e_sceneidx,transferData in pairs(lp)do
xianjieController:removeXJClass(transferData)
end
end
self.transferLookup=nil
end
end





function xianjieModel:getAreaTransfersByScene(sceneidx)
local lp=self.areaTransferLookup
if lp==nil then
lp={}
self.areaTransferLookup=lp
end
local lp_=lp[sceneidx]
if lp_==nil then
local scenecfg=cfgHelper.get1(cfg_fairylandsceneidxconfig_get,sceneidx)
local gate=scenecfg.gate
if gate then
lp_={}
lp[sceneidx]=lp_
local area1
local area2=0
for _,g_id in ipairs(gate)do
local cfg=cfgHelper.get1(cfg_devildomscenegateconfig_get,g_id)

area1=cfg.area
if lp_[area1]==nil then lp_[area1]={}end
if lp_[area1][area2]==nil then lp_[area1][area2]={}end
lp_[area1][area2][g_id]={cfg.resPos,cfg.tagPos,g_id,g_id}
if lp_[area2]==nil then lp_[area2]={}end
if lp_[area2][area1]==nil then lp_[area2][area1]={}end
lp_[area2][area1][g_id]={cfg.tagPos,cfg.resPos,g_id,g_id}
end
end
end
return lp_
end

function xianjieModel:getAreaTransfers(rpos,epos,areaTransferSelects)
local sceneidx_=rpos.sceneidx
local lp=xianjieModel:getAreaTransfersByScene(sceneidx_)
local lp_
if lp~=nil and lp[rpos.areaID]~=nil then
lp_=lp[rpos.areaID][epos.areaID]
end
if lp_~=nil then
if areaTransferSelects~=nil then
for g_id,v in pairs(lp_)do
if areaTransferSelects[g_id]==true then
return v
end
end
else
local f,dis,s
for g_id,v in pairs(lp_)do
s=mathHelper.distance2(rpos.gridX,rpos.gridZ,v[1][1],v[1][2])
s=s+mathHelper.distance2(v[2][1],v[2][2],epos.gridX,epos.gridZ)
if dis==nil or s<dis then
f=v
dis=s
end
end
if f~=nil then
return f
end
end
end
return nil
end

function xianjieModel:checkAreaTransfers(sceneidx,r_gridX,r_gridZ,r_areaID,e_gridX,e_gridZ,e_areaID)
local sceneidx_=sceneidx
local lp=xianjieModel:getAreaTransfersByScene(sceneidx_)
local lp_
if lp~=nil and lp[r_areaID]~=nil then
lp_=lp[r_areaID][e_areaID]
end
if lp_~=nil then
local f,dis,s,canMove
local f_cannotMove,dis_cannotMove

for g_id,v in pairs(lp_)do
s=mathHelper.distance2(r_gridX,r_gridZ,v[1][1],v[1][2])
s=s+mathHelper.distance2(v[2][1],v[2][2],e_gridX,e_gridZ)


canMove=xianjieModel:checkMoJieGateIsSelfXMCanPass(g_id)
if canMove==true then
if dis==nil or s<dis then
f=v
dis=s
end
else
if dis_cannotMove==nil or s<dis_cannotMove then
f_cannotMove=v
dis_cannotMove=s
end
end
end
if f~=nil then
return true,f
else
return false,f_cannotMove
end
end
return true,nil
end





function xianjieModel:getMapGridData(sceneidx)
local sceneidx_=sceneidx or xianjieModel:getSceneIndex()
local cfg=cfgHelper.get1(cfg_fairylandsceneidxconfig_get,sceneidx_)
local fname=cfg.blockFileName
if fname then
if self.mapGridDataLookup==nil then
self.mapGridDataLookup={}
end
local data=self.mapGridDataLookup[fname]
if data==nil then
data=require(FMT.fmt('lua.gamesys.xianjie.map.{0}',fname))
self.mapGridDataLookup[fname]=data
end
return data
end
return nil
end


function xianjieModel:checkMapGridDataBlock(sceneidx,gridX,gridZ)
local data=xianjieModel:getMapGridData(sceneidx)
if data then
local range=data.mapRange
local pos=gridX*range.height+gridZ
local id=data.gridData[pos]or 0
local cfg=data.gridConfig[id]
if cfg then
return cfg.allowPlace==false
end
end
return false
end


function xianjieModel:checkMapGridDataAreaID(sceneidx,gridX,gridZ)
if xianjienSceneIndexType:isMoJie(sceneidx)or xianjienSceneIndexType:isMoGongZhengDuo(sceneidx)then
local data=xianjieModel:getMapGridData(sceneidx)
if data then
local range=data.mapRange
local pos=gridX*range.height+gridZ
local id=data.gridData[pos]or 0
local cfg=data.gridConfig[id]
if cfg then
local areaId=cfg.areaId or 0
if areaId<0 then
areaId=0
end
return areaId
end
end
end
return 0
end


function xianjieModel:checkMapGridDataAreaIDHuJian(sceneidx,gridX,gridZ)
if xianjienSceneIndexType:isMoJie(sceneidx)then
local data=xianjieModel:getMapGridData(sceneidx)
if data then
local range=data.mapRange
local pos=gridX*range.height+gridZ
local id=data.gridData[pos]or 0
local cfg=data.gridConfig[id]
if cfg then
local areaId=cfg.areaId or 0
return areaId
end
end
end
return 0
end

function xianjieModel:getMapGridDataAreaID(sceneidx,gridX,gridZ)
local data=xianjieModel:getMapGridData(sceneidx)
if data then
local range=data.mapRange
local pos=gridX*range.height+gridZ
local id=data.gridData[pos]or 0
local cfg=data.gridConfig[id]
if cfg then
local areaId=cfg.areaId or 0
return areaId
end
end
return 0
end


function xianjieModel:checkScopeGridsCanPlace(sceneidx,gridX,gridZ,width,height,warningTips)
local check=true
for i=0,width do
for j=0,height do
if xianjieModel:checkGridState2(sceneidx,gridX+i,gridZ+j)then
check=false
break
end
end
if check==false then
break
end
end
if not check then
if warningTips then
UIManager.error(warningTips)
end
end
return check
end



function xianjieModel:initGridStateType()
self.gridStateLookup={}
self.gridLimitLookup={}
self.gridZFLimitLookup={}

xianjieModel:initZFGridLimit()
end

function xianjieModel:setGridState(sceneidx,gridX,gridZ,sizeX,sizeZ,stateType,flag)
local lp=self.gridStateLookup
if lp==nil then return end
local d=lp[sceneidx]
if d==nil then
d={}
lp[sceneidx]=d
end
for gridX_=gridX,gridX+sizeX-1 do
local dd=d[gridX_]
if dd==nil then
dd={}
d[gridX_]=dd
end
for gridZ_=gridZ,gridZ+sizeZ-1 do
local v=dd[gridZ_]
if v==nil then
v=0
dd[gridZ_]=v
end
if flag then
dd[gridZ_]=bitHelper.set_1(v,stateType-1)
else
dd[gridZ_]=bitHelper.set_0(v,stateType-1)
end
end
end
end

function xianjieModel:getGridState(sceneidx,gridX,gridZ)
local lp=self.gridStateLookup
if lp==nil then
return
end
sceneidx=sceneidx or xianjieModel:getSceneIndex()
if lp[sceneidx]and lp[sceneidx][gridX]then
return lp[sceneidx][gridX][gridZ]or 0
end
return 0
end


function xianjieModel:checkGridState(sceneidx,gridX,gridZ,stateType)
local state=xianjieModel:getGridState(sceneidx,gridX,gridZ)

if state~=nil and state~=0 then
return bitHelper.get(state,stateType-1)
end
return false
end


function xianjieModel:checkGridState2(sceneidx,gridX,gridZ)
local state=xianjieModel:getGridState(sceneidx,gridX,gridZ)
if state~=nil and state~=0 then
return true
end
if xianjieModel:checkMapGridDataBlock(sceneidx,gridX,gridZ)then
return true
end
return false
end


function xianjieModel:checkGridState3(sceneidx,gridX,gridZ)
local state=xianjieModel:getGridState(sceneidx,gridX,gridZ)
if state~=nil and state~=0 then
if not xianjieModel:checkMapGridDataBlock(sceneidx,gridX,gridZ)then
return true
end
end
return false
end


function xianjieModel:getPointDistanc2ZongMen(_sceneidx,_gridX_c,_gridZ_c,sameScene)
local gridX_c,gridZ_c,sceneidx=xianjieModel:getZongMenWorldGridCenterPos()
if sameScene and sceneidx~=self.sceneidx then
return nil
end
local movePath=xianjieController:getMovePath(sceneidx,gridX_c,gridZ_c,_sceneidx,_gridX_c,_gridZ_c)
return xianjieController:getMovePathDistance(movePath)
end

function xianjieModel:getPoint2PointNeedTime(sceneidx_1,gridX_c_1,gridZ_c_1,sceneidx_2,gridX_c_2,gridZ_c_3,speed)
local movePath=xianjieController:getMovePath(sceneidx_1,gridX_c_1,gridZ_c_1,sceneidx_2,gridX_c_2,gridZ_c_3)
if speed==nil then
speed=xianjieModel:getCloudSearchSpeed()
end
local wayTime=xianjieController:getMovePathWayTime(movePath,speed)
return wayTime
end




function xianjieModel:findPointByDistance(sceneidx,gridX_c,gridZ_c,raduis,width,height,findOne)
local raduis=raduis or xianjieModel:getFindDistanceRaduis(2)
local interval=xianjieController:getMapGridSize()
local minX_c=gridX_c-raduis
local maxX_c=gridX_c+raduis
local minZ_c=gridZ_c-raduis
local maxZ_c=gridZ_c+raduis
local list={}
for x=minX_c,maxX_c,interval do
for z=minZ_c,maxZ_c,interval do
local distance=math.sqrt((x-gridX_c)^2+(z-gridZ_c)^2)
if distance<=raduis then
local gridX,gridZ=xianjieController:worldGridCenterPos2WorldGridPos(x,z,1,1)
if xianjieController:checkGridInMap(gridX,gridZ,sceneidx)then
local check=xianjieModel:checkScopeGridsCanPlace(sceneidx,gridX,gridZ,width,height)
if check then
if findOne then
return gridX,gridZ
else
table.insert(list,{gridX,gridZ})
end
end
end
end
end
end
return list
end


function xianjieModel:getFindDistanceRaduis(flag)
local raduis=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'pointraduis')
if raduis and raduis[flag]then
return raduis[flag]
end
return 10
end







function xianjieModel:getClientPositionAndSize(originX,originY,originWidth,originHeight,extandWidth,extandHeight)
return originX-extandWidth,originY-extandHeight,originWidth+extandWidth*2,originHeight+extandHeight*2
end

function xianjieModel:getClientPositionAndSizeEx(originX,originY,originWidth,originHeight,extandWidth,extandHeight)
local x,z,w,h=self:getClientPositionAndSize(originX,originY,originWidth,originHeight,extandWidth,extandHeight)
return Vector4.New(x,z,w,h)
end

function xianjieModel:getSelectCloudCfg()
if self.selectCloudColor==nil then
local selectColor=cfgHelper.get2(cfg_fairylandcloudbaseconfig_get,1,'selectColor')
self.selectCloudColor=Color.New(selectColor[1],selectColor[2],selectColor[3],selectColor[4])
end
return self.selectCloudColor,cfgHelper.get2(cfg_fairylandcloudbaseconfig_get,1,'selectSpeed')
end


function xianjieModel:initGridLimit()































local list={-1,-2,-3,-4,-5,-6,-7,-8}
local entityType=xjServerEnityType.eClientBuild
for k,arenaId in ipairs(list)do
local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,arenaId)
local param=cfg.param
if param then
local area=param.area
if area then
local typeCfg=cfgHelper.get1(cfg_fairylandentitytypeconfig_get,entityType)
local gridX,gridZ,gridWidth,gridHeight=xianjieModel:getClientPositionAndSize(cfg.x,cfg.y,typeCfg.size[1],typeCfg.size[2],area[1],area[2])
xianjieModel:setGridLimit(cfg.sceneidx,gridX,gridZ,gridWidth,gridHeight)
end
end
end
end
function xianjieModel:testttGridLimit(sceneidx,x,y,sizeX,sizeZ)
local entityType=xjServerEnityType.eClientBuild
local typeCfg=cfgHelper.get1(cfg_fairylandentitytypeconfig_get,entityType)
local gridX,gridZ,gridWidth,gridHeight=xianjieModel:getClientPositionAndSize(x,y,typeCfg.size[1],typeCfg.size[2],sizeX,sizeZ)
self:setGridLimit(sceneidx,gridX,gridZ,sizeX,sizeZ)
end
function xianjieModel:setGridLimit(sceneidx,gridX,gridZ,sizeX,sizeZ)
local lp=self.gridLimitLookup
if lp==nil then return end
local d=lp[sceneidx]
if d==nil then
d={}
lp[sceneidx]=d
end
for gridX_=gridX,gridX+sizeX-1 do
local dd=d[gridX_]
if dd==nil then
dd={}
d[gridX_]=dd
end
for gridZ_=gridZ,gridZ+sizeZ-1 do
local v=dd[gridZ_]
if v==nil then
v=0
dd[gridZ_]=v
end
dd[gridZ_]=1
end
end
end
function xianjieModel:getGridLimit(sceneidx,gridX,gridZ)
local lp=self.gridLimitLookup
if lp==nil then
return
end
sceneidx=sceneidx or xianjieModel:getSceneIndex()
if lp[sceneidx]and lp[sceneidx][gridX]then
return lp[sceneidx][gridX][gridZ]or 0
end
return 0
end

function xianjieModel:checkGridLimit(sceneidx,gridX,gridZ)
local state=xianjieModel:getGridLimit(sceneidx,gridX,gridZ)
if state~=nil and state~=0 then
return true
end
return false
end