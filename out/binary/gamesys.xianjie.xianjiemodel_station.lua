







function xianjieModel:clearData_station()
local lp=self.allStationDatas
if lp then
for guid_str,stationData in pairs(lp)do
xianjieController:removeXJClass(stationData)
end
self.allStationDatas=nil
end
end

function xianjieModel:initAllStationDatas(isInit_allXianJie)
xianjieModel:clearData_station()
xianjieModel:initSelfStationTeamDatas(isInit_allXianJie)
self.allStationDatas={}
end

function xianjieModel:refreshStationData(v,isInit)








local guid_str=tostring(v.guid)
local actorid_str=tostring(v.actorid)
if isInit then
if actorid_str~='0'then
v.guid_str=guid_str
local stationData=xianjieController:createXJClass(xjDataType.eStation,v)
self.allStationDatas[guid_str]=stationData
xianjieModel:setGuid2EntityType(v.guid,v.entitytype,v.sceneidx)
else



end
else
if actorid_str~='0'then
local stationData_=self.allStationDatas[guid_str]
if stationData_==nil then
v.guid_str=guid_str
local stationData=xianjieController:createXJClass(xjDataType.eStation,v)
self.allStationDatas[guid_str]=stationData
xianjieModel:setGuid2EntityType(v.guid,v.entitytype,v.sceneidx)
stationData:createEntity(true)
notifySystem:postNotify(notifyConfig.onXianJieStationChange,CHANGE_TYPE.eAdd,stationData.guid)
else
stationData_:refreshData(v)
stationData_:refreshEntity()
notifySystem:postNotify(notifyConfig.onXianJieStationChange,CHANGE_TYPE.eChanged,stationData_.guid)
end
else
local stationData=self.allStationDatas[guid_str]
if stationData~=nil then
local isMyWaiPai=stationData.isMyWaiPai
local guid=stationData.guid
local sceneidx=stationData.sceneidx
xianjieController:removeXJClass(stationData)
self.allStationDatas[guid_str]=nil
xianjieModel:setGuid2EntityType(v.guid,nil,sceneidx)

if isMyWaiPai then
xianjieModel:removeBaseWaiPaiData(xjWaiPiaBaseType.eStation,v.guid)
end
notifySystem:postNotify(notifyConfig.onXianJieStationChange,CHANGE_TYPE.eDelete,guid)
else



end
end
end
end

function xianjieModel:getStationData(guid)
if self.allStationDatas then
local guid_str=tostring(guid)
return self.allStationDatas[guid_str]
end
end

function xianjieModel:getStationDataEx(guid_str)
if self.allStationDatas then
return self.allStationDatas[guid_str]
end
end

function xianjieModel:createAllStationEnities(needRefreshAOI)
local lp=self.allStationDatas
if lp then
for guid_str,stationData in pairs(lp)do
stationData:createEntity(needRefreshAOI)
end
end
end

function xianjieModel:removeAllStationEnities()
local lp=self.allStationDatas
if lp then
for guid_str,stationData in pairs(lp)do
stationData:removeEntity()
end
end
end

function xianjieModel:getStationDataNotEmpty()
local lp=self.selfStationTeamDatas
if lp and next(lp)then
return true
end
return false
end


function xianjieModel:clearData_selfStationTeam()
if self.selfStationTeamDatas and next(self.selfStationTeamDatas)then
for i,v in pairs(self.selfStationTeamDatas)do
local teamHandleId=v.teamHandleId
xianjieController:removeXJTeamHandle(teamHandleId)
end
end

self.selfStationTeamDatas=nil
end

function xianjieModel:initSelfStationTeamDatas(isInit_allXianJie)
if isInit_allXianJie then
xianjieModel:clearData_selfStationTeam()
self.selfStationTeamDatas={}
else
if not self.selfStationTeamDatas then
self.selfStationTeamDatas={}
end
end
end

function xianjieModel:refreshSelfStationTeamData(v,isInit)
local guid_str=tostring(v.guid)
local teamType=xjTeamHandleType.eStationTeam
if not self.selfStationTeamDatas then

return
end

local sceneidx=v.sceneidx
if isInit then

self.selfStationTeamDatas[guid_str]={data=v,sceneidx=sceneidx}
local teamHandleID=xianjieController:addXJTeamHandle(teamType,{guid=v.guid,guid_str=guid_str})
self.selfStationTeamDatas[guid_str].teamHandleId=teamHandleID
else
local teamData=self.selfStationTeamDatas[guid_str]
if teamData==nil then

self.selfStationTeamDatas[guid_str]={data=v,sceneidx=sceneidx}
local teamHandleID=xianjieController:addXJTeamHandle(teamType,{guid=v.guid,guid_str=guid_str})
self.selfStationTeamDatas[guid_str].teamHandleId=teamHandleID
else


self.selfStationTeamDatas[guid_str].data=v
self.selfStationTeamDatas[guid_str].sceneidx=sceneidx
end
end
end

function xianjieModel:removeSelfStationTeamData(guid)
local guid_str=tostring(guid)
local teamData=self.selfStationTeamDatas[guid_str]
if teamData~=nil then
local teamHandleID=teamData.teamHandleId
local boatid=teamData.data.boatid
xianjieController:removeXJTeamHandle(teamHandleID)
self.selfStationTeamDatas[guid_str]=nil
xianjieModel:removeBaseWaiPaiData(xjWaiPiaBaseType.eStation,guid,teamHandleID,boatid,true)
else



end
end

function xianjieModel:getSelfStationTeamData(guid)
if self.selfStationTeamDatas then
local guid_str=tostring(guid)
return self.selfStationTeamDatas[guid_str]
end
end

