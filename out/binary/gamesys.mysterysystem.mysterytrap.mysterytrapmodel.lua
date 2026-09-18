




mysteryTrapModel={}

mysteryTrapModel.colorGrids={}


function mysteryTrapModel:initTrapData(trapList)
MysteryModel.currentFBData.trapList={}
if trapList then
for i,v in ipairs(trapList)do
MysteryModel.currentFBData.trapList[v.trapId]=v

local trapData=mysteryTrapModel:getTrapMapData(v.trapId)
local hudList=trapData.hudList
if hudList and v.rstIndex==0 then
for guid,vv in pairs(hudList)do
MysteryController.refreshUIHUD(guid,"refreshStep",trapData.waittime-v.fdStep)
end
end
mysteryTrapModel:init_grid_color(v.trapId)
end
end
end

function mysteryTrapModel:setTrapData(trapId,trap)
if not MysteryModel.currentFBData.trapList then MysteryModel.currentFBData.trapList={}end
MysteryModel.currentFBData.trapList[trapId]=trap

local trapData=mysteryTrapModel:getTrapMapData(trapId)
local hudList=trapData.hudList
if hudList and trap.rstIndex==0 then
for guid,v in pairs(hudList)do
MysteryController.refreshUIHUD(guid,"refreshStep",trapData.waittime-trap.fdStep)
end
end
end

function mysteryTrapModel:setTrapRstIndex(trapId,rstIndex)
if not MysteryModel.currentFBData.trapList then MysteryModel.currentFBData.trapList={}end
if MysteryModel.currentFBData.trapList[trapId]then
MysteryModel.currentFBData.trapList[trapId].rstIndex=rstIndex

if rstIndex>0 then
local trapMapData=mysteryTrapModel:getTrapMapData(trapId)

if trapMapData.waittime==0 then
MysteryModel.currentFBData.trapList[trapId].times=MysteryModel.currentFBData.trapList[trapId].times+1
end
MysteryModel.currentFBData.trapList[trapId].cdStep=0
MysteryModel.currentFBData.trapList[trapId].fdStep=0
end
else
MysteryModel.currentFBData.trapList[trapId]=
{
trapId=trapId,
times=0,
cdStep=0,
fdStep=0,
rstIndex=rstIndex,
}
if rstIndex>0 then
local trapMapData=mysteryTrapModel:getTrapMapData(trapId)
if trapMapData.waittime==0 then
MysteryModel.currentFBData.trapList[trapId].times=MysteryModel.currentFBData.trapList[trapId].times+1
end
end
end

mysteryTrapModel:init_grid_color(trapId)
end

function mysteryTrapModel:getTrapData(trapId)
if MysteryModel.currentFBData.trapList then
return MysteryModel.currentFBData.trapList[trapId]
end
end


function mysteryTrapModel:initTrapMapData(trapId)
if not MysteryModel.currentFBData.trapMapList then MysteryModel.currentFBData.trapMapList={}end
if not MysteryModel.currentFBData.mapTrap then MysteryModel.currentFBData.mapTrap={}end

local trapConfig=cfgHelper.get(cfg_secretscenetrapconfig_get,trapId)
local poslist=trapConfig.poslist
local room=trapConfig.room

local trapMapList={}

if not MysteryModel.currentFBData.mapTrap[room]then
MysteryModel.currentFBData.mapTrap[room]={}
end
local map=MysteryModel.currentFBData.mapTrap[room]
local posListVec={}
for i,v in ipairs(poslist)do
local key=table.concat(v,'-')
map[key]=trapId
posListVec[i]=Vector3(v[1],v[2],0)
end
trapMapList.trapId=trapId
trapMapList.poslist=posListVec
trapMapList.mapData=map
trapMapList.room=room
trapMapList.times=trapConfig.times or 1000000
trapMapList.waittime=trapConfig.waittime or 0
trapMapList.coldtime=trapConfig.coldtime or 0

local warringMap=trapConfig.showwarring
if warringMap then
mysteryTrapModel:init_grid_color(trapId)

end

if trapMapList.waittime>0 then
local hudList={}
for i,pos in ipairs(posListVec)do
local data=mysteryTrapModel:getTrapData(trapId)or{rstIndex=0}
local hud=MysteryController.addUIHUD(eMysteryHUDType.eTrapCount,{pos=pos,roomId=room,step=(data.fdStep~=nil and data.rstIndex~=1)and(trapMapList.waittime-data.fdStep)or 0})
hudList[hud]=1
end
trapMapList.hudList=hudList
end

MysteryModel.currentFBData.trapMapList[trapId]=trapMapList
end


function mysteryTrapModel:getMapTrapByPos(room,pos)
local key=table.concat({pos.x,pos.y},'-')
if MysteryModel.currentFBData.mapTrap[room]then
return MysteryModel.currentFBData.mapTrap[room][key]
end
end

function mysteryTrapModel:getTrapMapData(trapId)
if MysteryModel.currentFBData.trapMapList then
return MysteryModel.currentFBData.trapMapList[trapId]
end
end

function mysteryTrapModel:getAllTrapMapData()
return MysteryModel.currentFBData.trapMapList
end

function mysteryTrapModel:get_start_color()
return Color.New(0,0,0,1)
end

function mysteryTrapModel:get_end_color()
return Color.StrToColor(tostring(660000))
end

function mysteryTrapModel:set_color_grid_entity(trapId,lerpVal)
self.colorGrids[trapId]=lerpVal
end

function mysteryTrapModel:get_grid_color(trapId)
return self.colorGrids[trapId]
end

function mysteryTrapModel:get_grid_color_list()
return self.colorGrids
end

function mysteryTrapModel:init_grid_color(trapId)
local data=self:getTrapData(trapId)
local showColor=false
if data then
local rstIndex=data.rstIndex
local trapConfig=cfgHelper.get(cfg_secretscenetrapconfig_get,trapId)
if rstIndex==0 and trapConfig.showwarring then
showColor=true
if trapConfig.times and data.times>trapConfig.times then
showColor=false
end
end
end

if showColor then
local mapData=mysteryTrapModel:getTrapMapData(trapId)

if mapData then
mysteryTrapModel:update_color_grid_pos_list(trapId,mapData.room,mapData.poslist)
end

mysteryTrap:start_color_change()
else
local mapData=mysteryTrapModel:getTrapMapData(trapId)
if mapData then
mysteryTrapModel:clear_color_grid_pos_list(trapId,mapData.room,mapData.poslist)
mysteryTrapModel:set_color_grid_entity(trapId,nil)
end
end
end

function mysteryTrapModel:update_color_grid_pos_list(trapId,roomId,colorPosList)
self:clear_color_grid_pos_list(trapId,roomId,colorPosList)
self:set_color_grid_entity(trapId,0)
end

function mysteryTrapModel:clear_color_grid_pos_list(trapId,roomId,colorPosList)
if colorPosList then
for i,pos in ipairs(colorPosList)do
MysteryModel:remove_grid_color_entity(roomId,pos)
local groundLayer=mysteryRoomModel:get_GroundLayer(roomId)
_HexMapManager.SetTileAddColor(pos,Color.New(0,0,0,1),groundLayer)
end
end
end
