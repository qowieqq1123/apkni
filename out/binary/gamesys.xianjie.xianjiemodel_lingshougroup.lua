





function xianjieModel:initAllXJLingShouGroupDatas()
self:clearAllXJLingShouGroupDatas()
self.lingShouGroupDatas={}
self.lingShouGroupDatas_expire={}
end

function xianjieModel:clearAllXJLingShouGroupDatas()
if self.lingShouGroupDatas then
for infoGuidStr,lsData in pairs(self.lingShouGroupDatas)do
xianjieController:removeXJClass(lsData)
end
end

if self.lingShouGroupDatas_expire then
for infoGuidStr,lsData in pairs(self.lingShouGroupDatas_expire)do
xianjieController:removeXJClass(lsData)
end
end

self.lingShouGroupDatas=nil
self.lingShouGroupDatas_expire=nil
end

function xianjieModel:removeXJLingShouGroupData(lsData)
local infoguid=lsData.infoguid
local sceneidx=lsData.sceneidx

lsData:removeEntity(true)
self.lingShouGroupDatas[lsData.infoGuidStr]=nil
self.lingShouGroupDatas_expire[lsData.infoGuidStr]=nil
xianjieController:removeXJClass(lsData)


xianjieModel:clearJiJieDirtyDataByGuid(infoguid,sceneidx)
xianjieModel:setGuid2EntityType(infoguid,nil,sceneidx)
notifySystem:postNotify(notifyConfig.onXianJieLingShouGroupDataChange,CHANGE_TYPE.eDelete,infoguid)
end

function xianjieModel:refreshXJLingShouGroupData(data,isInit)










local infoguid_str=tostring(data.infoguid)
local nowtime=timeHelper.getServerShortTime()
local isExpire=data.infoid~=0 and data.expiresec and data.expiresec>0 and nowtime>=data.expiresec

data.isExpire=isExpire
data.infoGuidStr=infoguid_str
if isInit then

if data.infoid~=0 then
data.infoguid_str=infoguid_str
local lsData=xianjieController:createXJClass(xjDataType.eLingshouGroup,data)
xianjieModel:setXJLingShouGroupData(infoguid_str,lsData)
xianjieModel:setGuid2EntityType(data.infoguid,data.entitytype,data.sceneidx)

notifySystem:postNotify(notifyConfig.onXianJieLingShouGroupDataChange,CHANGE_TYPE.eInit,data.infoguid)
end
else
if data.infoid~=0 then
local lsData=self:getXJLingShouGroupDataEx(infoguid_str)
if lsData then

lsData:refreshData(data)

notifySystem:postNotify(notifyConfig.onXianJieLingShouGroupDataChange,CHANGE_TYPE.eChanged,data.infoguid)
else

data.infoguid_str=infoguid_str
local lsData=xianjieController:createXJClass(xjDataType.eLingshouGroup,data)
xianjieModel:setXJLingShouGroupData(infoguid_str,lsData)



xianjieModel:setGuid2EntityType(data.infoguid,data.entitytype,data.sceneidx)

notifySystem:postNotify(notifyConfig.onXianJieLingShouGroupDataChange,CHANGE_TYPE.eAdd,data.infoguid)
end
else

local lsData=self:getXJLingShouGroupDataEx(infoguid_str)
if lsData~=nil then
self:removeXJLingShouGroupData(lsData)
else



end
end
end
end

function xianjieModel:getXJLingShouGroupDatas()
return self.lingShouGroupDatas
end

function xianjieModel:setXJLingShouGroupData(infoguid_str,lsData)
local list=lsData.isExpire and self.lingShouGroupDatas_expire or self.lingShouGroupDatas
if list then
list[infoguid_str]=lsData
end
end

function xianjieModel:getXJLingShouGroupData(infoguid)
if self.lingShouGroupDatas then
local infoguid_str=tostring(infoguid)
return self.lingShouGroupDatas[infoguid_str]or self.lingShouGroupDatas_expire[infoguid_str]
end
end

function xianjieModel:getXJLingShouGroupData_exExpire(infoguid)
if self.lingShouGroupDatas then
local infoguid_str=tostring(infoguid)
return self.lingShouGroupDatas[infoguid_str]
end
end

function xianjieModel:getXJLingShouGroupDataEx(infoguid_str)
if self.lingShouGroupDatas then
return self.lingShouGroupDatas[infoguid_str]or self.lingShouGroupDatas_expire[infoguid_str]
end
end

function xianjieModel:createXJLingShouGroupEnities(needRefreshAOI)
local lp=self.lingShouGroupDatas
if lp then
for infoguid_str,lsData in pairs(lp)do
lsData:createEntity(needRefreshAOI)
end
end
end

function xianjieModel:removeXJLingShouGroupEnities()
local lp=self.lingShouGroupDatas
if lp then
for infoguid_str,lsData in pairs(lp)do
if lsData.removeEntity then
lsData:removeEntity()
else
logErr("存在被重置的实体数据",infoguid_str)
end
end
end
end

function xianjieModel:changeLingshouGroupSave(lsData)
self.lingShouGroupDatas[lsData.infoGuidStr]=nil
self.lingShouGroupDatas_expire[lsData.infoGuidStr]=lsData

local sceneidx=xianjieModel:getSceneIndex()

if sceneidx==lsData.sceneidx then
local infoguid=lsData.infoguid
local sceneidx=lsData.sceneidx

lsData:removeEntity(true)


xianjieModel:clearJiJieDirtyDataByGuid(infoguid,sceneidx)
xianjieModel:setGuid2EntityType(infoguid,nil,sceneidx)
notifySystem:postNotify(notifyConfig.onXianJieLingShouGroupDataChange,CHANGE_TYPE.eDelete,infoguid)
end
end



function xianjieModel:findXJLingShouGroupByDistance(raduis)
local zmpos,sceneidx=xianjieModel:getZongMenWorldPos()
local list={}
if xianjieModel:checkSceneIndex(sceneidx)then
raduis=raduis or 100
local raduis_=raduis*xianjieController:getMapGridSize()

local pos=Vector2(zmpos.x,zmpos.z)
local size=Vector2(raduis_*2,raduis_*2)
local keys=xianjieController:findEnitys(pos,size)
for i=0,keys.Count-1 do
local ent=xianjieController:getEntity(keys[i])
if ent and ent.entityType==XJ_ENTITY_TYPE.eLingShouGroup then
table.insert(list,ent.infoguid)
end
end
end
return list
end


function xianjieModel:initXJLingShouGroupTeamDatas()
xianjieModel:clearData_XJLingShouGroupTeam()
self.XJLingShouGroupTeamDatas={}
end

function xianjieModel:clearData_XJLingShouGroupTeam()
if self.XJLingShouGroupTeamDatas and next(self.XJLingShouGroupTeamDatas)then
for i,v in pairs(self.XJLingShouGroupTeamDatas)do
local teamHandleId=v.teamHandleId
xianjieController:removeXJTeamHandle(teamHandleId)
end
end

self.XJLingShouGroupTeamDatas=nil
end

function xianjieModel:refreshXJLingShouGroupTeamData(v,isInit)
local guid_str=tostring(v.guid)
local teamType=xjTeamHandleType.eLingShouGroupAttack
if not self.XJLingShouGroupTeamDatas then

return
end

if isInit then

self.XJLingShouGroupTeamDatas[guid_str]={data=v}
local teamHandleID=xianjieController:addXJTeamHandle(teamType,{guid=v.guid,marchguid_str=guid_str})
self.XJLingShouGroupTeamDatas[guid_str].teamHandleId=teamHandleID
else
local teamData=self.XJLingShouGroupTeamDatas[guid_str]
if teamData==nil then

self.XJLingShouGroupTeamDatas[guid_str]={data=v}
local teamHandleID=xianjieController:addXJTeamHandle(teamType,{guid=v.guid,marchguid_str=guid_str})
self.XJLingShouGroupTeamDatas[guid_str].teamHandleId=teamHandleID
else


self.XJLingShouGroupTeamDatas[guid_str].data=v
end
end
end

function xianjieModel:removeXJLingShouGroupTeamData(guid,occupyType)
if self.XJLingShouGroupTeamDatas==nil then return end
local guid_str=tostring(guid)
local teamData=self.XJLingShouGroupTeamDatas[guid_str]
if teamData~=nil then
local teamHandleID=teamData.teamHandleId
local boatid=teamData.data.boatid
xianjieController:removeXJTeamHandle(teamHandleID)
self.XJLingShouGroupTeamDatas[guid_str]=nil
xianjieModel:removeBaseWaiPaiData(occupyType,guid,teamHandleID,boatid,true)
else



end
end

function xianjieModel:getXJLingShouGroupTeamData(guid)
if self.XJLingShouGroupTeamDatas then
local guid_str=tostring(guid)
return self.XJLingShouGroupTeamDatas[guid_str]
end
end
