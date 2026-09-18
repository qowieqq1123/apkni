







function xianjieModel:clearData_resource()
local lp=self.allResourceDatas
if lp then
for infoguid_str,resourceData in pairs(lp)do
xianjieController:removeXJClass(resourceData)
end
self.allResourceDatas=nil
end
end

function xianjieModel:initAllResourceDatas()
xianjieModel:clearData_resource()
self.allResourceDatas={}
end

function xianjieModel:refreshResourceData(v,isInit)









local infoguid_str=tostring(v.infoguid)
if isInit then
if v.infoid~=0 then
v.infoguid_str=infoguid_str
local resourceData=xianjieController:createXJClass(xjDataType.eResource,v)
self.allResourceDatas[infoguid_str]=resourceData
xianjieModel:setGuid2EntityType(v.infoguid,v.entitytype,v.sceneidx)
else



end
else
if v.infoid~=0 then
local resourceData_=self.allResourceDatas[infoguid_str]
if resourceData_==nil then
v.infoguid_str=infoguid_str
local resourceData=xianjieController:createXJClass(xjDataType.eResource,v)
self.allResourceDatas[infoguid_str]=resourceData
xianjieModel:setGuid2EntityType(v.infoguid,v.entitytype,v.sceneidx)
resourceData:createEntity(true)
notifySystem:postNotify(notifyConfig.onXianJieResourceChange,CHANGE_TYPE.eAdd,resourceData.infoguid)
else
resourceData_:refreshData(v)
resourceData_:refreshEntity()
notifySystem:postNotify(notifyConfig.onXianJieResourceChange,CHANGE_TYPE.eChanged,resourceData_.infoguid)
end
else
local resourceData=self.allResourceDatas[infoguid_str]
if resourceData~=nil then
local infoguid=resourceData.infoguid
local sceneidx=resourceData.sceneidx
xianjieController:removeXJClass(resourceData)
self.allResourceDatas[infoguid_str]=nil
xianjieModel:setGuid2EntityType(v.infoguid,nil,sceneidx)
notifySystem:postNotify(notifyConfig.onXianJieResourceChange,CHANGE_TYPE.eDelete,infoguid)
else



end
end
end
end

function xianjieModel:getResourceData(infoguid)
if self.allResourceDatas then
local infoguid_str=tostring(infoguid)
return self.allResourceDatas[infoguid_str]
end
end

function xianjieModel:createAllResourceEnities(needRefreshAOI)
local lp=self.allResourceDatas
if lp then
for infoguid_str,resourceData in pairs(lp)do
resourceData:createEntity(needRefreshAOI)
end
end
end

function xianjieModel:removeAllResourceEnities()
local lp=self.allResourceDatas
if lp then
for infoguid_str,resourceData in pairs(lp)do
resourceData:removeEntity()
end
end
end
