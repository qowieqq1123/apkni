
function xianmengController:onEnterState_ai(isReconnect)
if isReconnect then
return
end
self.npcIdIndex=0
self.diziAIBTList={}
self.diziAISTList={}
self.diziInMapData={}
end

function xianmengController:onLeaveState_ai(isReconnect)
if isReconnect then
return
end
self.diziAIBTList=nil
self.diziAISTList=nil
self.diziInMapData=nil
end

function xianmengController:onEnterHome_ai()

end

function xianmengController:onLeaveHome_ai(clear)
if clear then
for dzId,bt in pairs(self.diziAIBTList)do
aiManager:removeDiscipleAI(dzId)
end
end
self.diziAIBTList={}
end

function xianmengController:getDiZiSTID(dzId)
return self.diziAISTList[dzId]
end

function xianmengController:getDiZiInMapId(dzId)
return self.diziInMapData[dzId]
end

function xianmengController:loadMapAI()
local mapId=mapIdType.xianmeng
local randomLib=cfgHelper.get2(cfg_guildbaseconfig_get,1,'npc_randomlib')

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
local num=xianmengModel:getXMMemberNum()
num=math.min(num,10)
num=math.max(num,3)
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
local bt=aiManager:addDiscipleAI(dzId,guid,eAIDZType.eXianMeng)
self.diziAIBTList[dzId]=bt
self.diziAISTList[dzId]=guid
self.diziInMapData[dzId]=mapId
end
end

function xianmengController:getVisitDZGUID()
self.npcIdIndex=self.npcIdIndex+1
return FMT.fmt('xianmeng_dz_{0}',self.npcIdIndex)
end

function xianmengController:createVisitRole(mapId,npcid,pos)
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