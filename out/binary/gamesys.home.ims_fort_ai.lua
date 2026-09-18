
ims_fort_ai={}

function ims_fort_ai:onEnterState_ai(isReconnect)
if isReconnect then
return
end
self.npcIdIndex=0
self.diziAIBTList={}
self.diziAISTList={}
self.diziInMapData={}
end

function ims_fort_ai:onLeaveState_ai(isReconnect)
if isReconnect then
return
end
self.diziAIBTList=nil
self.diziAISTList=nil
self.diziInMapData=nil
end

function ims_fort_ai:onEnterHome_ai()

end

function ims_fort_ai:onLeaveHome_ai(clear)
if clear then
for dzId,bt in pairs(self.diziAIBTList)do
aiManager:removeDiscipleAI(dzId)
end
end
self.diziAIBTList={}
end

function ims_fort_ai:getDiZiSTID(dzId)
return self.diziAISTList[dzId]
end

function ims_fort_ai:getDiZiInMapId(dzId)
return self.diziInMapData[dzId]
end

function ims_fort_ai:loadMapAI()
local mapId=mapIdType.fort

local config=cfg_fairylandbaseconfig_get(1)

local randomLib=config.fort_npc_randomlib

local numT=config.fort_npc_random_num or{10,15}

local rlist={}
for i,v in ipairs(randomLib)do
rlist[i]=v
end

local len=#rlist
for i,v in ipairs(rlist)do
local p=math.random(1,len)
local pv=rlist[p]
rlist[p]=rlist[i]
rlist[i]=pv
end

local list={}
local num=math.random(numT[1],numT[2])

for i=1,num do
table.insert(list,rlist[i])
end

local birthPoints=aiManager:getBirthPointList(mapId)
local bplen=#birthPoints

for i,v in ipairs(list)do
local bp=birthPoints[math.random(1,bplen)]
local spos=_MapManager.ToVector3Int(bp[1],bp[2],0)

local guid=self:createVisitRole(mapId,v,spos)
local dzId=self:getVisitDZGUID()
local bt=aiManager:addDiscipleAI(dzId,guid,eAIDZType.eFort)
self.diziAIBTList[dzId]=bt
self.diziAISTList[dzId]=guid
self.diziInMapData[dzId]=mapId
end
end

function ims_fort_ai:getVisitDZGUID()
self.npcIdIndex=self.npcIdIndex+1
return FMT.fmt('fort_dz_{0}',self.npcIdIndex)
end

function ims_fort_ai:createVisitRole(mapId,npcid,pos)
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