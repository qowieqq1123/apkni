function xianjieModel:initAllMGZDClientBuildDatas()
xianjieModel:clearData_allMGZDClientBuild()
self.allMGZDClientBuildDatas={}
self.allMGZDClientBuildCreateEntFlag={}
end

function xianjieModel:clearData_allMGZDClientBuild()
if self.allMGZDClientBuildDatas==nil then return end
if next(self.allMGZDClientBuildDatas)==nil then return end

for i,data in pairs(self.allMGZDClientBuildDatas)do
xianjieController:removeXJClass(data)
end
self.allMGZDClientBuildDatas=nil
self.allMGZDClientBuildCreateEntFlag=nil
end

function xianjieModel:clearData_MGZDClientBuild_byId(id)
if self.allMGZDClientBuildDatas==nil then return end
if self.allMGZDClientBuildDatas[id]==nil then return end
local data=self.allMGZDClientBuildDatas[id]
xianjieController:removeXJClass(data)
self.allMGZDClientBuildDatas[id]=nil
self.allMGZDClientBuildCreateEntFlag[id]=nil
end

function xianjieModel:createMGZDClientBuildData(buildID,dataType)
if not self.allMGZDClientBuildDatas then
self:initAllMGZDClientBuildDatas()
end

if not self.allMGZDClientBuildDatas[buildID]and initProControl:isDoneKF()and xianjieModel:checkInit()then
local data=xianjieController:createXJClass(dataType,{buildID=buildID})
self.allMGZDClientBuildDatas[buildID]=data
xianjieModel:createMGZDBuildEntities(buildID,data)
end
end

function xianjieModel:getMGZDBuildDataByBuildID(buildID)
if not self.allMGZDClientBuildDatas then
return nil
end

return self.allMGZDClientBuildDatas[buildID]
end

function xianjieModel:getMGZDBuildDataList()
return self.allMGZDClientBuildDatas
end


function xianjieModel:clearData_MGZDBuildServerDataList()
self.mgzdBuildServerDataList=nil
end

function xianjieModel:initMGZDBuildServerDataList()
xianjieModel:clearData_MGZDBuildServerDataList()
self.mgzdBuildServerDataList={}
end

function xianjieModel:setMGZDBuildServerDataList(len,buildDataList)
if self.mgzdBuildServerDataList==nil then
xianjieModel:initMGZDBuildServerDataList()
end
if len<=0 then return end
for index,buildData in ipairs(buildDataList)do
xianjieModel:setMGZDBuildServerData(buildData)
end
end

function xianjieModel:setMGZDBuildServerData(buildData)
if self.mgzdBuildServerDataList==nil then
xianjieModel:initMGZDBuildServerDataList()
end
local buildID=buildData.cb_type
if buildData then
buildData.xmGuidStr=tostring(buildData.xmGuid)
end
self.mgzdBuildServerDataList[buildID]=buildData
end

function xianjieModel:getMGZDBuildServerData(buildID)
if self.mgzdBuildServerDataList==nil then return nil end
return self.mgzdBuildServerDataList[buildID]
end


function xianjieModel:createAllMGZDBuildEntities(needRefreshAOI)
local lp=self.allMGZDClientBuildDatas
if lp then
for clientBuildID,data in pairs(lp)do
if not self.allMGZDClientBuildCreateEntFlag[clientBuildID]then
local ret=data:createEntity(needRefreshAOI)
if ret then
self.allMGZDClientBuildCreateEntFlag[clientBuildID]=true
end
end
end
end
end

function xianjieModel:createMGZDBuildEntities(clientBuildID,data,needRefreshAOI)
if not self.allMGZDClientBuildCreateEntFlag[clientBuildID]then
local ret=data:createEntity(needRefreshAOI)
if ret then
self.allMGZDClientBuildCreateEntFlag[clientBuildID]=true
end
end
end

function xianjieModel:removeAllMGZDBuildEntities()
local lp=self.allMGZDClientBuildDatas
if lp then
for clientBuildID,data in pairs(lp)do
if self.allMGZDClientBuildCreateEntFlag[clientBuildID]then
data:removeEntity()
self.allMGZDClientBuildCreateEntFlag[clientBuildID]=nil
end
end
end
end


function xianjieModel:checkClientBdIsMGZDBuildByGuid(guid)
local guidNum=mathHelper.int64_to_number(guid)

return xianjieModel:checkClientBdIssMGZDBuildByBuildId(guidNum)
end

function xianjieModel:checkClientBdIssMGZDBuildByBuildId(buildID)
local mgzdClientBuildIdx=xianjieModel:getMGZDBuildCfgByBuildID(buildID,'clientParam','mgzdClientBuildIdx')
if mgzdClientBuildIdx then
return true
end

return false
end

function xianjieModel:getMGZDBuildCfgByBuildID(buildId,...)
local result=cfgHelper.get(cfg_fairylandclientbuildconfig_get,buildId,...)

return result
end

function xianjieModel:getMGZDBuildClientParamByBuildID(buildId,key)
local clientParam=xianjieModel:getMGZDBuildCfgByBuildID(buildId,'clientParam')
if clientParam==nil then return nil end

if key==nil then return clientParam end

return clientParam[key]
end

function xianjieModel:getMGZDBuffBuildCfg(buildID,...)
local result=cfgHelper.get(cfg_mogongyibanjianzhugeconfig_get,buildID,...)

return result
end


function xianjieModel:initMGZDBuildZJTeamDatas()
xianjieModel:clearData_MGZDBuildZJTeam()
self.MGZDBuildZJTeamDatas={}
end

function xianjieModel:clearData_MGZDBuildZJTeam()
if self.MGZDBuildZJTeamDatas and next(self.MGZDBuildZJTeamDatas)then
for i,v in pairs(self.MGZDBuildZJTeamDatas)do
local teamHandleId=v.teamHandleId
xianjieController:removeXJTeamHandle(teamHandleId)
end
end

self.MGZDBuildZJTeamDatas=nil
end

function xianjieModel:refreshMGZDBuildZJTeamData(v,isInit)
local guid_str=tostring(v.guid)
local teamType=xjTeamHandleType.eMoGongBuffZhuJunTeam
if not self.MGZDBuildZJTeamDatas then

return
end

if isInit then

self.MGZDBuildZJTeamDatas[guid_str]={data=v}
local teamHandleID=xianjieController:addXJTeamHandle(teamType,{guid=v.guid,guid_str=guid_str})
self.MGZDBuildZJTeamDatas[guid_str].teamHandleId=teamHandleID
else
local teamData=self.MGZDBuildZJTeamDatas[guid_str]
if teamData==nil then

self.MGZDBuildZJTeamDatas[guid_str]={data=v}
local teamHandleID=xianjieController:addXJTeamHandle(teamType,{guid=v.guid,guid_str=guid_str})
self.MGZDBuildZJTeamDatas[guid_str].teamHandleId=teamHandleID
else


self.MGZDBuildZJTeamDatas[guid_str].data=v
end
end
end

function xianjieModel:removeMGZDBuildZJTeamData(guid,occupyType)
if self.MGZDBuildZJTeamDatas==nil then return end
local guid_str=tostring(guid)
local teamData=self.MGZDBuildZJTeamDatas[guid_str]
if teamData~=nil then
local teamHandleID=teamData.teamHandleId
local boatid=teamData.data.boatid
xianjieController:removeXJTeamHandle(teamHandleID)
self.MGZDBuildZJTeamDatas[guid_str]=nil
xianjieModel:removeBaseWaiPaiData(occupyType,guid,teamHandleID,boatid,true)
else



end
end

function xianjieModel:getMGZDBuildZJTeamData(guid)
if self.MGZDBuildZJTeamDatas then
local guid_str=tostring(guid)
return self.MGZDBuildZJTeamDatas[guid_str]
end
end
