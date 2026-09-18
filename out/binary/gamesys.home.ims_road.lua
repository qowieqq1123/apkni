
local _road_style={
{1,2,3},
{1,2,3},
{1,2,3},
}

function isometricMapSystem:initRoadData()
self.curr_road_type=1
self.curr_road_layer=mapLayer.Road1
self.curr_road_cfg=findPathConfig.drawRoad
self.curr_move_check=conditionConfig.drawRoad
end

function isometricMapSystem:loadLockAreaRoad(sfId)
local cfg=cfgHelper.get1(cfg_monijysfconfig_get,sfId)
if cfg.unlock_road then
local rdlist={}
local count=1
for k,v in pairs(cfg.unlock_road)do
if not zongmenModel:isAreaUnlockInMap(sfId,k)and self:isCanShowArea(k,sfId)then
for ii,vv in ipairs(v)do
if vv[1]==vv[3]then
local add=vv[2]<vv[4]and 1 or-1
for i=vv[2],vv[4],add do
rdlist[count]=vv[1]
count=count+1
rdlist[count]=i
count=count+1
rdlist[count]=0
count=count+1
rdlist[count]=vv[5]or self.curr_road_type
count=count+1
rdlist[count]=1
count=count+1
end
elseif vv[2]==vv[4]then
local add=vv[1]<vv[3]and 1 or-1
for i=vv[1],vv[3],add do
rdlist[count]=i
count=count+1
rdlist[count]=vv[2]
count=count+1
rdlist[count]=0
count=count+1
rdlist[count]=vv[5]or self.curr_road_type
count=count+1
rdlist[count]=1
count=count+1
end
end
end
end
end
_MapManager.DrawRoadByData(sfId,rdlist,mapLayer.Road1)
end
end

function isometricMapSystem:setCurrentRoadType(rtype)
self.curr_road_type=rtype
local cfg=cfgHelper.get1(cfg_roadstyleconfig_get,rtype)
self.curr_road_layer=mapLayer[cfg.layer]
self.curr_road_cfg=findPathConfig[cfg.fpId]
self.curr_move_check=self.curr_road_cfg==findPathConfig.drawRoad and conditionConfig.drawRoad or conditionConfig.drawWall
end

function isometricMapSystem:drawPath()
local mapId=zongmenModel:getMountainId()
isometricMapSystem:enableFindPathLimit(false)
local path=_MapManager.FindPath(mapId,self.beginPos,self.endPos,self.curr_road_cfg)
isometricMapSystem:enableFindPathLimit(true)
if path then
_MapManager.Erase(mapId,mapLayer.DrawRoad1)
_MapManager.Erase(mapId,mapLayer.DrawRoad2)
local isCreateRoad=self.editorMode==editorMode.eCreateRoad
local tile=isCreateRoad and TILE_TYPE.eCreateRoad or TILE_TYPE.eDeleteRoad
local cfg=cfgHelper.get1(cfg_roadstyleconfig_get,self.curr_road_type)
local cost=cfg.cost
if isCreateRoad and cost then
local fpath=_MapManager.FilterPosByCoverType(mapId,path,{0,1})
local count=fpath.Count
UIManager:invokeUIMethod('UILayoutWin','SetEndMarkPos',self.endPos,count)
UIManager:invokeUIMethod('UILayoutEditWin','SetEndMarkPos',self.endPos,count)
local price=cost[1]
local total=price[2]*count
local have=moneyModel.getMoney(price[1])
UIManager:invokeUIMethod('UILayoutWin','setCostTips',{price[1],total})




local dtile=have>=total and tile or TILE_TYPE.eDeleteRoad
_MapManager.Paint(mapId,path,dtile,mapLayer.DrawRoad1)
else
UIManager:invokeUIMethod('UILayoutWin','SetEndMarkPos',self.endPos,0)
UIManager:invokeUIMethod('UILayoutEditWin','SetEndMarkPos',self.endPos,0)
_MapManager.Paint(mapId,path,tile,mapLayer.DrawRoad1)
end
_MapManager.ClearMapCellStyle(mapLayer.DrawRoad2)
self:setRoadStyle(path,mapLayer.DrawRoad2)
_MapManager.DrawRoadByPath(mapId,path,self.curr_road_type,mapLayer.DrawRoad2,false,false)
self.path=path

UIManager:invokeUIMethod('UILayoutEditWin','setRoadPath',path)
end
end

function isometricMapSystem:setRoadStyle(path,layer)
local datas=self:splitPath(path)
if datas then
for i,v in pairs(datas)do
local styleList={}
local vl=#v-1
for i=1,vl do
local p1=v[i]
local p2=v[i+1]
local d1=math.abs(p2[1]-p1[1])
local d2=math.abs(p2[2]-p1[2])
local d=d1+d2
if d>=7 then
local c=math.floor(d/7)
for i=1,c do
local t=math.random(1,#_road_style)
local s=(t-1)*10
local os=(i-1)*7
if d1>0 then
local dir=p1[1]<p2[1]and 1 or-1
for i=1,#_road_style[t]do
local cl=#styleList
styleList[cl+1]=p1[1]+(i+1+os)*dir
styleList[cl+2]=p1[2]
styleList[cl+3]=0
styleList[cl+4]=s+i+1
end
else
local dir=p1[2]<p2[2]and 1 or-1
for i=1,#_road_style[t]do
local cl=#styleList
styleList[cl+1]=p1[1]
styleList[cl+2]=p1[2]+(i+1+os)*dir
styleList[cl+3]=0
styleList[cl+4]=s+i+1
end
end
end
end
end
_MapManager.SetMapCellStyle(layer,styleList)
end
end
end

function isometricMapSystem:splitPath(path)
if path then
local pdata=_MapManager.SplitPath(path)
local datas={}
local list={}
table.insert(datas,list)
local len=#pdata

for i=1,len,3 do
table.insert(list,{pdata[i],pdata[i+1]})
if i+3<len then
local d1=pdata[i+3]-pdata[i]
local d2=pdata[i+4]-pdata[i+1]
if d1~=0 and d2~=0 then
list={}
table.insert(datas,list)
end
end
end
return datas
end
end

function isometricMapSystem:applyRoad(continue)
if self.path then
self.continueDraw=continue
local id=zongmenModel:getMountainId()
if self.editorMode==editorMode.eCreateRoad then
local cfg=cfgHelper.get1(cfg_roadstyleconfig_get,self.curr_road_type)
local mapId=zongmenModel:getMountainId()
self.weedOutData=_MapManager.WeedOutPathCell(mapId,self.path,cfg.func)
local cost=cfg.cost
local fpath
if cost then
fpath=_MapManager.FilterPosByCoverType(mapId,self.path,{0,1})
else
fpath=self.path
end
local dArr=_MapManager.PathToArray(fpath)
local sList=_MapManager.GetMapCellStyle(mapLayer.DrawRoad2,fpath)
local tlist={}
local tlen=#dArr
local count=1
for i=1,tlen,3 do
table.insert(tlist,{dArr[i],dArr[i+1],self.curr_road_type,sList[count]})
count=count+1
end
zongmenControl:reqDrawRoad(id,#tlist,tlist)
elseif self.editorMode==editorMode.eDeleteRoad then
local datas=self:splitPath(self.path)
for i,v in pairs(datas)do
zongmenControl:reqDeleteRoad(id,#v,v)
end
end
end
end

function isometricMapSystem:handleApplyRoad()
if self.beginPos and self.endPos then
UIManager:callWindowFunc('UILayoutWin','showCreateRoadPay')
local mapId=zongmenModel:getMountainId()
local isErase=self.editorMode==editorMode.eDeleteRoad

if not isErase then
if self.curr_road_layer==mapLayer.Data then
_MapManager.Erase(mapId,self.path,mapLayer.Road1)
else
_MapManager.Erase(mapId,self.path,mapLayer.Data)
end
end
if not isErase then
_MapManager.CopyStyleDataTo(self.path,mapLayer.DrawRoad2,self.curr_road_layer)
end
_MapManager.DrawRoadByPath(mapId,self.path,self.curr_road_type,self.curr_road_layer,isErase,true)
_MapManager.Erase(mapId,mapLayer.DrawRoad1)
_MapManager.Erase(mapId,mapLayer.DrawRoad2)

local weedOutData=self.weedOutData
self.weedOutData=nil
if weedOutData then
local len=#weedOutData
for i=1,len,4 do
local pos={weedOutData[i],weedOutData[i+1],weedOutData[i+2]}
local flip=weedOutData[i+3]
self:addFastBuildData(objectType.ePlaceObject,946,flip,pos,conditionConfig.place)
end
self:reqFastBuild()
end
end
if self.continueDraw then
self.beginPos=self.endPos
self:drawPath()
UIManager:invokeUIMethod('UILayoutWin','ShowMarkPos',false,true)
UIManager:invokeUIMethod('UILayoutEditWin','ShowMarkPos',false,true)
else
self.beginPos=nil
self.endPos=nil
UIManager:invokeUIMethod('UILayoutWin','ShowMarkPos',false,false)
UIManager:invokeUIMethod('UILayoutEditWin','ShowMarkPos',false,false)
end
self.path=nil
end

function isometricMapSystem:drawRoad(mapId,data)
if not data or not next(data)then
return
end
local cfgs=cfg_roadstyleconfig()
local rdlists={}
for k,v in pairs(cfgs)do
rdlists[k]={}
end


for k,v in pairs(data)do
local rt=v.type or self.curr_road_type
local rdlist=rdlists[rt]
local count=#rdlist+1
rdlist[count]=v.x
count=count+1
rdlist[count]=v.y
count=count+1
rdlist[count]=0
count=count+1
rdlist[count]=rt
count=count+1
rdlist[count]=v.style
end
for k,v in pairs(rdlists)do
local cfg=cfgHelper.get1(cfg_roadstyleconfig_get,k)
_MapManager.DrawRoadByData(mapId,v,mapLayer[cfg.layer])
end
end

function isometricMapSystem:cancelRoad(resetMode)
if self.editorMode==editorMode.eCreateRoad or self.editorMode==editorMode.eDeleteRoad then
if self.beginPos and self.endPos then
local mapId=zongmenModel:getMountainId()
_MapManager.Erase(mapId,mapLayer.DrawRoad1)
_MapManager.Erase(mapId,mapLayer.DrawRoad2)
end
self.beginPos=nil
self.endPos=nil
self.path=nil
if resetMode then
self:setEditorMode(editorMode.eDefault)
end
end
end

function isometricMapSystem:setLinkRoadData(id)
local linkList={}
local linkData=_MapManager.GetObjectLinkWithRoad()
for i=0,linkData.Count-1 do
local guid=linkData[i]
linkList[guid]=true
end
self:resetUnlinkData()
local datas=zongmenModel:getAllBuildingData(id)
for k,v in pairs(datas)do
v.isLinkRoad=linkList[v.entityId]
self:recordUnlinkBuilding(v)
local linkSlot=self:getLinkSlotId(v.build_id,v.flag)
self:showLinkSlot(v.entityId,linkSlot)
end
self:conversionUnlinkData()
hudControl:refreshAllBuilding()
end

function isometricMapSystem:setBuildingLinkRoad(id,bdId)
local data=zongmenModel:getBuildingData(bdId)
data.isLinkRoad=_MapManager.IsLinkWithRoad(data.entityId)

local linkSlot=self:getLinkSlotId(data.build_id,data.flag)
self:showLinkSlot(data.entityId,linkSlot)

self:recordUnlinkBuilding(data)
self:conversionUnlinkData()
end

function isometricMapSystem:resetUnlinkData()
self.unlinkBuildings={}
self.unlickShowIndex=0
self.unlickShowCount=0
end

function isometricMapSystem:conversionUnlinkData()
self.unlinkBuildingsArr={}
for k,v in pairs(self.unlinkBuildings)do
table.insert(self.unlinkBuildingsArr,v)
end
self.unlickShowCount=#self.unlinkBuildingsArr

UIManager:invokeUIMethod('UIBuildingMsgWin','showMsg',zmMsgType.unlinkRoad,self.unlickShowCount>0)
end

function isometricMapSystem:hasUnlinkRoad()
return self.unlickShowCount>0
end

function isometricMapSystem:recordUnlinkBuilding(bdData)
if not bdData.isLinkRoad then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
if cfg.is_connect_road==1 then
self.unlinkBuildings[bdData.un_build_id]=bdData.entityId
return
end
else
self.unlinkBuildings[bdData.un_build_id]=nil
end
end

function isometricMapSystem:removeUnlinkRecord(ubdId)
self.unlinkBuildings[ubdId]=nil
end

function isometricMapSystem:ShowNextUnlinkEntity()
if self.unlickShowCount>0 then
local index=self.unlickShowIndex%self.unlickShowCount+1
self:moveCameraToObjectEx(self.unlinkBuildingsArr[index],true)
self.unlickShowIndex=self.unlickShowIndex+1
end
end