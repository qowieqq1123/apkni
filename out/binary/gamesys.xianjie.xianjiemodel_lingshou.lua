





function xianjieModel:initAllXJLingShouDatas()
self:clearAllXJLingShouDatas()
self.lingShouDatas={}
self.lingShouDatas_expire={}
end

function xianjieModel:clearAllXJLingShouDatas()
if self.lingShouDatas then
for infoGuidStr,lsData in pairs(self.lingShouDatas)do
xianjieController:removeXJClass(lsData)
end
end

if self.lingShouDatas_expire then
for infoGuidStr,lsData in pairs(self.lingShouDatas_expire)do
xianjieController:removeXJClass(lsData)
end
end

self.lingShouDatas=nil
self.lingShouDatas_expire=nil
end

function xianjieModel:removeXJLingShouData(lsData)
local infoguid=lsData.infoguid
local sceneidx=lsData.sceneidx

lsData:removeEntity(true)
self.lingShouDatas[lsData.infoGuidStr]=nil
self.lingShouDatas_expire[lsData.infoGuidStr]=nil
xianjieController:removeXJClass(lsData)



xianjieModel:clearJiJieDirtyDataByGuid(infoguid,sceneidx)
xianjieModel:setGuid2EntityType(infoguid,nil,sceneidx)
notifySystem:postNotify(notifyConfig.onXianJieLingShouDataChange,CHANGE_TYPE.eDelete,infoguid)
end

function xianjieModel:refreshXJLingShouData(data,isInit)










local infoguid_str=tostring(data.infoguid)
local nowtime=timeHelper.getServerShortTime()
local isExpire=data.infoid~=0 and data.expiresec and data.expiresec>0 and nowtime>=data.expiresec

data.isExpire=isExpire
data.infoGuidStr=infoguid_str
if isInit then

if data.infoid~=0 then
data.infoguid_str=infoguid_str
local lsData=xianjieController:createXJClass(xjDataType.eLingShou,data)
self:setXJLingShouData(infoguid_str,lsData)
xianjieModel:setGuid2EntityType(data.infoguid,data.entitytype,data.sceneidx)

notifySystem:postNotify(notifyConfig.onXianJieLingShouDataChange,CHANGE_TYPE.eInit,data.infoguid)
end
else
if data.infoid~=0 then
local lsData=self:getXJLingShouDataEx(infoguid_str)
if lsData then

lsData:refreshData(data)

notifySystem:postNotify(notifyConfig.onXianJieLingShouDataChange,CHANGE_TYPE.eChanged,data.infoguid)
else

data.infoguid_str=infoguid_str
local lsData=xianjieController:createXJClass(xjDataType.eLingShou,data)
self:setXJLingShouData(infoguid_str,lsData)



xianjieModel:setGuid2EntityType(data.infoguid,data.entitytype,data.sceneidx)
notifySystem:postNotify(notifyConfig.onXianJieLingShouDataChange,CHANGE_TYPE.eAdd,data.infoguid)
end
else

local lsData=self:getXJLingShouDataEx(infoguid_str)
if lsData~=nil then
xianjieModel:removeXJLingShouData(lsData)
else



end
end
end
end

function xianjieModel:getXJLingShouDatas()
return self.lingShouDatas
end

function xianjieModel:setXJLingShouData(infoguid_str,lsData)
if lsData.isExpire then
self.lingShouDatas_expire[infoguid_str]=lsData
else
self.lingShouDatas[infoguid_str]=lsData
end
end

function xianjieModel:getXJLingShouData(infoguid)
if self.lingShouDatas then
local infoguid_str=tostring(infoguid)
return self.lingShouDatas[infoguid_str]or self.lingShouDatas_expire[infoguid_str]
end
end

function xianjieModel:getXJLingShouData_exExpire(infoguid)
if self.lingShouDatas then
local infoguid_str=tostring(infoguid)
return self.lingShouDatas[infoguid_str]
end
end

function xianjieModel:getXJLingShouDataEx(infoguid_str)
if self.lingShouDatas then
return self.lingShouDatas[infoguid_str]
end
end

function xianjieModel:createXJLingShouEnities(needRefreshAOI)
local lp=self.lingShouDatas
if lp then
for infoguid_str,lsData in pairs(lp)do
lsData:createEntity(needRefreshAOI)
end
end
end

function xianjieModel:removeXJLingShouEnities()
local lp=self.lingShouDatas
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

function xianjieModel:changeLingshouSave(lsData)
self.lingShouDatas[lsData.infoGuidStr]=nil
self.lingShouDatas_expire[lsData.infoGuidStr]=lsData

local sceneidx=xianjieModel:getSceneIndex()

if sceneidx==lsData.sceneidx then
local infoguid=lsData.infoguid
local sceneidx=lsData.sceneidx

lsData:removeEntity(true)


xianjieModel:clearJiJieDirtyDataByGuid(infoguid,sceneidx)
xianjieModel:setGuid2EntityType(infoguid,nil,sceneidx)
notifySystem:postNotify(notifyConfig.onXianJieLingShouDataChange,CHANGE_TYPE.eDelete,infoguid)
end
end



function xianjieModel:findXJLingShouByDistance(raduis)
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
if ent and ent.entityType==XJ_ENTITY_TYPE.eLingShou then
table.insert(list,ent.infoguid)
end
end
end
return list
end



function xianjieModel:onEnterState_lingshou()
self.lsInitData={}
end

function xianjieModel:onLeaveState_lingshou()
self.lsInitData=nil
end

function xianjieModel:setInitData_LingShou(args)
self.lsInitData.lsShareGuid=args[1]
self.lsInitData.lsJoinRwCount=args[2]
self.lsInitData.lsKillRwCount=args[3]
local len=args[4]
self.lsInitData.scJoinRwList=args[5]or{}
local len2=args[6]
self.lsInitData.itemRandList=args[7]or{}

self.lsInitData.scJoinRwLookup={}
if len>0 then
for index=1,len do
local data=self.lsInitData.scJoinRwList[index]
self.lsInitData.scJoinRwLookup[tostring(data.param_1)]=data.param_2
end
end

self.lsInitData.itemRandLookup={}
if len2>0 then
for index=1,len2 do
local data=self.lsInitData.itemRandList[index]
self.lsInitData.itemRandLookup[data.param_1]=data.param_2
end
end
end

function xianjieModel:changeItemRand(itemID,count)
self.lsInitData.itemRandLookup[itemID]=count
end

function xianjieModel:getItemRandCount(itemID)
return self.lsInitData.itemRandLookup[itemID]or 0
end

function xianjieModel:changeShareLSGuid(shareLSGuid)
self.lsInitData.lsShareGuid=shareLSGuid
end

function xianjieModel:getShareLSGuid()
return self.lsInitData.lsShareGuid
end

function xianjieModel:changeLingShouRewardCount(lsJoinRwCount,lsKillRwCount)
self.lsInitData.lsJoinRwCount=lsJoinRwCount
self.lsInitData.lsKillRwCount=lsKillRwCount
end

function xianjieModel:getLingShouJoinRwCount()
return self.lsInitData.lsJoinRwCount
end

function xianjieModel:changeLingShouKillRwCount()
return self.lsInitData.lsKillRwCount
end

function xianjieModel:changeLingShouGroupRewardCount(lsgGuid,joinCount)
self.lsInitData.scJoinRwLookup[tostring(lsgGuid)]=joinCount
end

function xianjieModel:getLingShouGroupRewardCount(lsgGuid)
return self.lsInitData.scJoinRwLookup[tostring(lsgGuid)]
end
