






local _MODULENAME="xianguanModel"


def_table(_MODULENAME)
xianguanModel.name=_MODULENAME
xianguanModel.data={}

xianguanModel.groupInterval=100


function xianguanModel:onAppStart()

end


function xianguanModel:onEnterState(isReconnect)
local lookup={}
local jobCfgs=cfg_xianguanconfig()
for jIndex,jobCfg in pairs(jobCfgs)do
for i,v in ipairs(jobCfg.privilegeList)do
local temp=lookup[v]or{}
table.insert(temp,jobCfg.id)
lookup[v]=temp
end
end
self.data.privilegeLookup=lookup

self.data.selfJobInfoList={}
self.data.jobInfoLookup={}
self.data.selfGroupJobInfoList={}
self.data.selfTeQuanLookup={}
self.data.serverOriginalDataLen=0
self.data.serverOriginalData={}

self.data.isReceiveServerData=false
self.data.isFinishDealServerData=false
end


function xianguanModel:onProtocolReq()
xianguanModel:loadJingXuanClientData()
end

function xianguanModel:onProtocolReqKF()
xianguanModel:initData()
xianguanModel:dealServerData()
end


function xianguanModel:onLeaveState(isReconnect)

self.data={}

xianguanModel:clearMsgJingXuanResultType()
end

function xianguanModel:initNewSession()
self.data.selfJobInfoList={}
self.data.selfGroupJobInfoList={}
self.data.jobInfoLookup={}
self.data.selfTeQuanLookup={}
self.data.serverOriginalDataLen=0
self.data.serverOriginalData={}
end

function xianguanModel:initData()
local jobCfgs=cfg_xianguanconfig()
for jIndex,jobCfg in pairs(jobCfgs)do
local jobTemp={}

jobTemp.groupId=Mathf.Floor(jobCfg.id/100)
jobTemp.jobId=jobCfg.id
jobTemp.tqLen=#(jobCfg.privilegeList or{})

jobTemp.voluntaryTqList={}
jobTemp.leftTime=0

local privilegeList=xianguanConfig.getLimitCrossTeQuanIdsByJobId(jobCfg.id)
for tIndex,tqId in ipairs(privilegeList)do
if xianguanConfig.checkIsActiveTeQuan(tqId)then
jobTemp.voluntaryTqList[#jobTemp.voluntaryTqList+1]={tqId,jobTemp.jobId}
end
end

if self.data.jobInfoLookup[jobTemp.groupId]==nil then
self.data.jobInfoLookup[jobTemp.groupId]={}
end

self.data.jobInfoLookup[jobTemp.groupId][jobTemp.jobId]=jobTemp
end
end

function xianguanModel:setInitServerData(xgDataLen,xgDataList,session)
xianguanModel:resetCenterLookup()
self:initNewSession()
xgDataList=xgDataList or{}
session=session or 1

self.data.serverOriginalDataLen=xgDataLen
self.data.serverOriginalData=xgDataList
self.data.curSession=session

local crossServerId=loginModel:getCrossServerId()
if crossServerId~=nil and crossServerId~=0 then
xianguanModel:initData()
xianguanModel:dealServerData()
end

self.data.isReceiveServerData=true
end

function xianguanModel:dealServerData()
if self.data.serverOriginalDataLen==0 then return end

local selfActorId=playerModel:getActorID()

for index,xgData in ipairs(self.data.serverOriginalData)do
local jobId=xgData.xianguan_id
local groupId=Mathf.Floor(jobId/100)

local jobInfo=self.data.jobInfoLookup[groupId][jobId]
if jobInfo==nil then
logErr("err xianguan id :",xgData.xianguan_id)
end

jobInfo.serverid=xgData.server_id
jobInfo.actorid=xgData.actor_id
jobInfo.actorname=xgData.actorname
jobInfo.iconInfo=xgData.icon
jobInfo.sex=xgData.sex
jobInfo.level=xgData.level
jobInfo.leftTime=xgData.time_sec

local isSelf=mathHelper.compareInt64(selfActorId,jobInfo.actorid)

if isSelf then
self.data.selfGroupJobInfoList[jobInfo.groupId]=jobInfo
self.data.selfJobInfoList[jobId]=jobInfo

local privilegeList=xianguanConfig.getLimitCrossTeQuanIdsByJobId(jobId)
for _,tqid in ipairs(privilegeList)do
if self.data.selfTeQuanLookup[tqid]==nil then
self.data.selfTeQuanLookup[tqid]={jobId}
else
local list=self.data.selfTeQuanLookup[tqid]
list[#list+1]=jobId
end
end
end

xianguanModel.freshLookUp_XgInfo(jobInfo)
end

local group,info=next(self.data.selfGroupJobInfoList)
if group and info then
notifySystem:postNotify(notifyConfig.onChangeXianGuanJob,info)
end

self.data.isFinishDealServerData=true
xianguanModel:freshActivityTime_WuXuan_BW()
xianguanModel:freshActivityTime_WenXuan_BW()
end

function xianguanModel:getFinishDealServerData()
return self.data.isFinishDealServerData
end

function xianguanModel:getJobGroupList(groupId)
return self.data.jobInfoLookup[groupId]or{}
end

function xianguanModel:getGroupIdByJob(jobId)
return Mathf.Floor(jobId/self.groupInterval)
end

function xianguanModel:getGroupJobInfo(groupId,jobId)
return self.data.jobInfoLookup[groupId][jobId]
end

function xianguanModel:getSelfGroupJobInfo(groupId)
return self.data.selfGroupJobInfoList[groupId]or{}
end

function xianguanModel:getSelfGroupJobInfoList()
return self.data.selfGroupJobInfoList or{}
end

function xianguanModel:getSelfJobInfoByJobId(jobId)
return self.data.selfJobInfoList[jobId]
end

function xianguanModel:getSelfJobList()
return self.data.selfJobInfoList
end

function xianguanModel:getSelfTeQuanLookUp()
return self.data.selfTeQuanLookup
end

function xianguanModel:getSelfTeQuanOfJobList(tqId)
return self.data.selfTeQuanLookup[tqId]
end

function xianguanModel:getFirstStart()
if self.data and self.data.curSession then
return self.data.curSession==1
end
return false
end

function xianguanModel:changeJobActorDataInfo(jobId,serverid,actorid,actorname,sex,level,iconInfo,leftTime)
local groupId=Mathf.Floor(jobId/100)
if self.data.jobInfoLookup[groupId]==nil then
logErr("仙官 无效分组",jobId,groupId)
return
end
local jobInfo=self.data.jobInfoLookup[groupId][jobId]

jobInfo.serverid=serverid
jobInfo.actorid=actorid
jobInfo.actorname=actorname
jobInfo.iconInfo=iconInfo
jobInfo.leftTime=leftTime or 0

local selfActorId=playerModel:getActorID()

if mathHelper.compareInt64(selfActorId,jobInfo.actorid)then
self.data.selfJobInfoList[jobInfo.groupId]=jobInfo
end

notifySystem:postNotify(notifyConfig.onChangeXianGuanJob,self.data.selfJobInfoList[jobInfo.groupId])
end

function xianguanModel:getReceiveServerDataState()
return self.data.isReceiveServerData
end

function xianguanModel:fingXianMengOtherActorXianGuan(jobId)
local groupId=xianguanModel:getGroupIdByJob(jobId)
local jobInfo=xianguanModel:getGroupJobInfo(groupId,jobId)
local actorid

if jobInfo then
actorid=jobInfo.actorid
end

if not actorid then
return
end

local memberData=xianmengModel:getXMMemberList()
if memberData then
for i,v in ipairs(memberData)do
if mathHelper.compareInt64(v.actorid,actorid)then
return actorid
end
end
end
end

function xianguanModel:getPrivilegeJobs(privilegeID)
return self.data.privilegeLookup[privilegeID]
end

function xianguanModel:getJobInfoByJobId(jobId)
if self.data.jobInfoLookup==nil or next(self.data.jobInfoLookup)==nil then return end
local group=self:getGroupIdByJob(jobId)
if group==nil then return end
return self.data.jobInfoLookup[group][jobId]
end

function xianguanModel:getJobInfoListByJobType(type)
local cfgList=xianguanConfig.getJobCfgListByType(type)
local temp={}
for index,cfg in ipairs(cfgList)do
local jobInfo=self:getJobInfoByJobId(cfg.id)
if jobInfo.actorid~=nil then
temp[#temp+1]=jobInfo
end
end
return temp
end

