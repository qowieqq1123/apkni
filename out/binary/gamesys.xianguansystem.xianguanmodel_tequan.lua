





















function xianguanModel:onEnterState_TeQuan(isReconnect)
self.data.originalTeQuanServerDataListLen=0
self.data.originalTeQuanServerDataList={}
self.data.tqDataList_key={}
self.data.tqDataList_group={}

self.data.selfTeQuanInfoLookup={}
self.data.xianguanBroadcast=1
end

function xianguanModel:onLeaveState_TeQuan(isReconnect)
xianguanModel:removeAllTeQuan()
end

function xianguanModel:onProtocalReqKF_TeQuan()
self:dealOriginalServerData()
end


function xianguanModel:resetServerData()
self.data.originalTeQuanServerDataListLen=0
self.data.originalTeQuanServerDataList={}
self.data.tqDataList_group={}

self.data.selfTeQuanInfoLookup={}
end

function xianguanModel:setOriginalServerData(len,list)
self:resetServerData()
self.data.originalTeQuanServerDataListLen=len
self.data.originalTeQuanServerDataList=list

local crossServerId=loginModel:getCrossServerId()
if crossServerId~=nil and crossServerId~=0 then
xianguanModel:dealOriginalServerData()
end
end

function xianguanModel:dealOriginalServerData()
if self.data.originalTeQuanServerDataListLen==0 then return end
xianguanModel:removeAllTeQuan()
xianguanController:initPassiveTeQuanObj()

for index=1,self.data.originalTeQuanServerDataListLen do
local data=self.data.originalTeQuanServerDataList[index]
if xianguanHelper.checkTeQuanPlatformLimit(data.tqid)then
data=table.deepCopy(data)
self:mapServerData(data)

local key=xianguanConfig.getTeQuanFindKey(data.xgid,data.tqid)
xianguanModel:addSelfTequan(key,data)
xianguanModel.freshLookUp_TqInfo(data)
end
end
end

function xianguanModel:setXianGuanBroadcastOpen(broadcast)

self.data.xianguanBroadcast=broadcast
end

function xianguanModel:getXianGuanBroadcastOpen()

return self.data.xianguanBroadcast
end

function xianguanModel:mapServerData(data)


local key=xianguanConfig.getTeQuanFindKey(data.xgid,data.tqid)
self.data.tqDataList_key[key]=data

local group=xianguanConfig.getTeQuanCfg(data.tqid,'group')
local tqDataList=self.data.tqDataList_group[group]or{}
local groupPriority=xianguanConfig.getTeQuanCfg(data.tqid,'groupPriority')
tqDataList[#tqDataList+1]={data,groupPriority}

if#tqDataList>0 then
table.sort(tqDataList,function(a,b)
return a[2]>b[2]
end)
end
end

function xianguanModel:addTeQuanData(data)
local key=xianguanConfig.getTeQuanFindKey(data.xgid,data.tqid)
self:mapServerData(data)
xianguanModel:addSelfTequan(key,data)
end

function xianguanModel:removeTeQuanData(data)

end

function xianguanModel:updateTeQuanData(data)
local key=xianguanConfig.getTeQuanFindKey(data.xgid,data.tqid)
xianguanModel:mapServerData(data)
xianguanModel:updateSelfTequan(key,data)
xianguanModel.freshLookUp_TqInfo(data)
end


function xianguanModel:getTeQuanDataByKey(key)
return self.data.tqDataList_key[key]
end

function xianguanModel:getTeQuanDataByIds(xgId,tqId)
local key=xianguanConfig.getTeQuanFindKey(xgId,tqId)
return xianguanModel:getTeQuanDataByKey(key)
end

function xianguanModel:getTeQuanDataByIds2(tqId)
local xgIds=xianguanModel:getPrivilegeJobs(tqId)
if xgIds~=nil then
for _,xgId in ipairs(xgIds)do
local key=xianguanConfig.getTeQuanFindKey(xgId,tqId)
if xianguanModel:getTeQuanDataByKey(key)~=nil then
return true
end
end
end
return false
end

function xianguanModel:getTeQuanDataList_key()
return self.data.tqDataList_key
end


function xianguanModel:getTeQuanDataList_group(group)
return self.data.tqDataList_group[group]
end

function xianguanModel:getTeQuanDataByGroup(group)
local list=xianguanModel:getTeQuanDataList_group(group)

return list and list[1]
end


function xianguanModel:addSelfTequan(key,tequanInfo,noUpdate)
if self.data.selfTeQuanInfoLookup[key]then
if not noUpdate then
self.data.selfTeQuanInfoLookup[key]:updateInfo(tequanInfo)
end
else
local group=cfgHelper.get2(cfg_xianguanprivilegeconfig_get,tequanInfo.tqid,'group')
self.data.selfTeQuanInfoLookup[key]=new_xgTeQuanInfo(group,tequanInfo)
end
end

function xianguanModel:removeSelfTequan(key)
if self.data.selfTeQuanInfoLookup[key]then


local obj=self.data.selfTeQuanInfoLookup[key]
obj.isRelease=true
else
logErr("试图删除一个自身没有的特权",key)
end
end

function xianguanModel:updateSelfTequan(key,tequanInfo)

if tequanInfo~=nil then
if self.data.selfTeQuanInfoLookup[key]then
self.data.selfTeQuanInfoLookup[key]:updateInfo(tequanInfo)
else
logErr("试图更新一个自身没有的特权",key)
end
else
loggerUtil.logErrFMT("更新一个nil信息")
end
end

function xianguanModel:getSelfTequanObj(key)
return self.data.selfTeQuanInfoLookup and self.data.selfTeQuanInfoLookup[key]
end

function xianguanModel:removeAllTeQuan()
if self.data.selfTeQuanInfoLookup then
for id,obj in pairs(self.data.selfTeQuanInfoLookup)do
remove_xgTeQuanInfo(obj)
end
end
self.data.selfTeQuanInfoLookup={}
self.data.tqDataList_key={}
end

function xianguanModel:getSelfTqQuanObjLookUp()
return self.data.selfTeQuanInfoLookup
end


function xianguanModel:callTeQuanObjFunc(xgid,tqid,funcName,args)
local key=xianguanConfig.getTeQuanFindKey(xgid,tqid)
local obj=xianguanModel:getSelfTequanObj(key)
if obj and obj.isRelease then



end
if obj then
if obj[funcName]then
return obj[funcName](obj,args)
end
else
logErr("不存在对应特权实例",xgid,tqid,funcName)
end
end







function xianguanModel:getPublishWantedData(key)
local list={}
local monList={}
local data=xianguanModel:getTeQuanDataByKey(key)

if data and data.list then
for k,v in ipairs(data.list)do
local infoGuid=v.param_1
local zydata=xianjieModel:getMonsterData(infoGuid)
if zydata then
monList[tostring(infoGuid)]=true
table.insert(list,v)
end
end
end
return list,monList
end

function xianguanModel:getPublishWantedReddot()

if not xianguanController:checkSelfHasTeQuanByType(XIANGUAN_PRIVILEGE_ENUM.eZhenYuXunShou,XIANGUAN_TYPE_ENUM.eZhenYuXianGuan)then
return false
end

local key
local gzId
local isZYXS
local tqId=XIANGUAN_PRIVILEGE_ENUM.eZhenYuXunShou

isZYXS,gzId=xianguanController:checkSelfHasJobByType(XIANGUAN_TYPE_ENUM.eZhenYuXianGuan)
if isZYXS then
key=xianguanConfig.getTeQuanFindKey(gzId,tqId)
local data=xianguanModel:getPublishWantedData(key)
local cd=xianguanHelper.checkTeQuanCD(gzId,tqId,false)
local usetimes=xianguanHelper.checkTeQuanTimes(gzId,tqId,false)

if data and#data>0 then
if cd and usetimes then
return true
end
end
end

return false
end



function xianguanModel:getSelecttask()
local jobflag,xgid=xianguanController:checkSelfHasJobByType(10)
if not jobflag then
return
end


local tqId=10
local key=xianguanConfig.getTeQuanFindKey(xgid,tqId)
local state=xianguanHelper.checkTeQuanUseCondition(xgid,tqId,false)
if state then
return true
end
local data=xianguanModel:getTeQuanDataByKey(key)
if data and data.list then
return true,data.list
end
return false
end
