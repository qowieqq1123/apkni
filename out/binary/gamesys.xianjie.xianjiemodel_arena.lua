
function xianjieModel:initAllArenaDatas()
xianjieModel:clearData_allArena()
self.allArenaDatas={}
self.allArenaCreateEntFlag={}
end

function xianjieModel:clearData_allArena()
if self.allArenaDatas and next(self.allArenaDatas)then
for i,data in pairs(self.allArenaDatas)do
xianjieController:removeXJClass(data)
end
self.allArenaDatas=nil
self.allArenaCreateEntFlag=nil
end
end

function xianjieModel:clearData_arena_byArenaId(arenaId)
if self.allArenaDatas and self.allArenaDatas[arenaId]then
local data=self.allArenaDatas[arenaId]
xianjieController:removeXJClass(data)
self.allArenaDatas[arenaId]=nil
self.allArenaCreateEntFlag[arenaId]=nil
end
end

function xianjieModel:createArenaData(arenaId)
if not self.allArenaDatas then
self:initAllArenaDatas()
end

if not self.allArenaDatas[arenaId]and initProControl:isDoneKF()and xianjieModel:checkInit()then
self.allArenaDatas[arenaId]=xianjieController:createXJClass(xjDataType.eArena,{arenaId=arenaId})
return true
end
end

function xianjieModel:getArenaDataByArenaId(arenaId)
if not self.allArenaDatas then
return nil
end

return self.allArenaDatas[arenaId]
end

function xianjieModel:getArenaDataList()
return self.allArenaDatas
end

function xianjieModel:checkClientBdIsArenaByGuid(guid)
local guidNum=mathHelper.int64_to_number(guid)
local arenaIdList={
[xjClientBuildType.flcbLeiTai1]=true,
[xjClientBuildType.flcbLeiTai2]=true,
[xjClientBuildType.flcbLeiTai3]=true,
[xjClientBuildType.flcbLeiTai4]=true,
[xjClientBuildType.flcbLeiTai5]=true,
[xjClientBuildType.flcbLeiTai6]=true,
[xjClientBuildType.flcbLeiTai7]=true,
[xjClientBuildType.flcbLeiTai8]=true,
[xjClientBuildType.flcbMoGong1]=true,
}
if arenaIdList[guidNum]then
return true
end
return false
end

function xianjieModel:checkClientBdIsArenaByBuildId(buildId)
local arenaIdList={
[xjClientBuildType.flcbLeiTai1]=true,
[xjClientBuildType.flcbLeiTai2]=true,
[xjClientBuildType.flcbLeiTai3]=true,
[xjClientBuildType.flcbLeiTai4]=true,
[xjClientBuildType.flcbLeiTai5]=true,
[xjClientBuildType.flcbLeiTai6]=true,
[xjClientBuildType.flcbLeiTai7]=true,
[xjClientBuildType.flcbLeiTai8]=true,
[xjClientBuildType.flcbMoGong1]=true,
}
if arenaIdList[buildId]then
return true
end
return false
end

function xianjieModel:createAllArenaEntities(needRefreshAOI)
local lp=self.allArenaDatas
if lp then
for arenaId,data in pairs(lp)do
if not self.allArenaCreateEntFlag[arenaId]then
local ret=data:createEntity(needRefreshAOI)
if ret then
self.allArenaCreateEntFlag[arenaId]=true
end
end
end
end
end

function xianjieModel:removeAllArenaEntities()
local lp=self.allArenaDatas
if lp then
for arenaId,data in pairs(lp)do
if self.allArenaCreateEntFlag[arenaId]then
data:removeEntity()
self.allArenaCreateEntFlag[arenaId]=nil
end
end
end
end


function xianjieModel:clearData_arenaZJTeam()
if self.arenaZJTeamDatas and next(self.arenaZJTeamDatas)then
for i,v in pairs(self.arenaZJTeamDatas)do
local teamHandleId=v.teamHandleId
xianjieController:removeXJTeamHandle(teamHandleId)
end
end

self.arenaZJTeamDatas=nil
end

function xianjieModel:initArenaZJTeamDatas(isInit_allXianJie)
if isInit_allXianJie then
xianjieModel:clearData_arenaZJTeam()
self.arenaZJTeamDatas={}
else
if not self.arenaZJTeamDatas then
self.arenaZJTeamDatas={}
end
end
end

function xianjieModel:refreshArenaZJTeamData(v,isInit)
local guid_str=tostring(v.guid)
local teamType=xjTeamHandleType.eArenaZhuJun
if not self.arenaZJTeamDatas then

return
end

if isInit then

self.arenaZJTeamDatas[guid_str]={data=v}
local teamHandleID=xianjieController:addXJTeamHandle(teamType,{guid=v.guid,guid_str=guid_str})
self.arenaZJTeamDatas[guid_str].teamHandleId=teamHandleID
else
local teamData=self.arenaZJTeamDatas[guid_str]
if teamData==nil then

self.arenaZJTeamDatas[guid_str]={data=v}
local teamHandleID=xianjieController:addXJTeamHandle(teamType,{guid=v.guid,guid_str=guid_str})
self.arenaZJTeamDatas[guid_str].teamHandleId=teamHandleID
else


self.arenaZJTeamDatas[guid_str].data=v
end
end
end

function xianjieModel:removeArenaZJTeamData(guid,arenaId)
if self.arenaZJTeamDatas==nil then



return
end
local guid_str=tostring(guid)
local teamData=self.arenaZJTeamDatas[guid_str]
if teamData~=nil then
local teamHandleID=teamData.teamHandleId
local boatid=teamData.data.boatid
xianjieController:removeXJTeamHandle(teamHandleID)
self.arenaZJTeamDatas[guid_str]=nil
xianjieModel:removeBaseWaiPaiData(xjWaiPiaBaseType.eArena,guid,teamHandleID,boatid,true)
else



end
end

function xianjieModel:getArenaZJTeamData(guid)
if self.arenaZJTeamDatas then
local guid_str=tostring(guid)
return self.arenaZJTeamDatas[guid_str]
end
end


function xianjieModel:isArenaAtk(guid)
if xianjieModel:checkClientBdIsArenaByGuid(guid)then
local isSelfXianYu=false

local arenaId=mathHelper.int64_to_number(guid)
local arenaData=xianJieArenaActModel:getArenaBuildData(arenaId)or{}
if arenaData then
local occupyServerId=arenaData.occupyServerId
local occupySceneIdx=arenaData.sceneidx
local hasOccupy=occupySceneIdx and occupySceneIdx~=0 or nil
if hasOccupy then
local cross_sid=loginModel:getCrossServerId()
isSelfXianYu=occupyServerId==cross_sid
end
end
return not isSelfXianYu
end
return false
end



function xianjieModel:checkArenaOccupyCamp(guid)
local campIndex=0

local arenaId=mathHelper.int64_to_number(guid)
local arenaData=xianJieArenaActModel:getArenaBuildData(arenaId)or{}
if arenaData then
local occupyServerId=arenaData.occupyServerId
local occupySceneIdx=arenaData.sceneidx
local hasOccupy=occupySceneIdx and occupySceneIdx~=0 or nil
if hasOccupy then
local cross_sid=loginModel:getCrossServerId()
if occupyServerId==cross_sid then

campIndex=1
else

campIndex=2
end
end
end
return campIndex
end

