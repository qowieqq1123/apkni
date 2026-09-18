





local compaignTypeIconNameList={
"image_xianguanzjm_5",
"image_xianguanzjm_6",
"image_xianguanzjm_9"
}


local _jobListConfigLookup={}
local _jobTypeListConfigLookup={}

local _campaignConfigLookup={}
local _campaignJobListConfigLookup={}

XianGuanCampaignConditionType={
eXianZhiId=1
}


XianGuanCampaignType={
eWenXuan=1,
eWuXuan=2,
}


XianGuanWuXuanSegment={
eNone=0,
eRegister=1,
eReady=2,
eMatch=3,
eFinish=4,
eBlank=5,
eBwWait=6,
}


XianGuanWenXuanSegment={
eNone=0,
eRegister=1,
eVote=2,
eFinish=3,
eBwWait=4,
}

XianGuanJingXuanShareState={
eNormal=0,
eDone=1,

}

local JobCheckConditionFunc={
[XianGuanCampaignConditionType.eXianZhiId]=function(args)
local xzid=args[2]

local curXzid=xianzhiModel:getXianZhiId()
return curXzid>=xzid
end,
}

xianguanConfig={}

xianguanConfig.resetTimesType={
eDay=1,
eDayFive=2,
eWeek=3,
eWeekFive=4,

}

function xianguanConfig.initConfig()
local jobCfgs=cfg_xianguanconfig()

_jobListConfigLookup={}
_jobTypeListConfigLookup={}


_campaignConfigLookup={}
_campaignJobListConfigLookup={}

for index,cfg in pairs(jobCfgs)do
local group=Mathf.Floor(cfg.id/100)
local id=cfg.id%100
if _jobListConfigLookup[group]==nil then
_jobListConfigLookup[group]={}
end
_jobListConfigLookup[group][id]=cfg

if _jobTypeListConfigLookup[cfg.type]==nil then
_jobTypeListConfigLookup[cfg.type]={cfg}
else
local list=_jobTypeListConfigLookup[cfg.type]
list[#list+1]=cfg
end

if group==1 then
local stage=cfg.stage
local campaignType=cfg.campaignType

if _campaignConfigLookup[campaignType]==nil then
_campaignConfigLookup[campaignType]={}
end
if _campaignConfigLookup[campaignType][0]==nil then
_campaignConfigLookup[campaignType][0]={}
end
if _campaignConfigLookup[campaignType][stage]==nil then
_campaignConfigLookup[campaignType][stage]={}
end
table.insert(_campaignConfigLookup[campaignType][0],cfg)
table.insert(_campaignConfigLookup[campaignType][stage],cfg)

if _campaignJobListConfigLookup[campaignType]==nil then
_campaignJobListConfigLookup[campaignType]={}
end
table.insert(_campaignJobListConfigLookup[campaignType],cfg)
end
end
for campaignType,v in pairs(_campaignConfigLookup)do
for stage,_ in pairs(v)do
table.sort(_campaignConfigLookup[campaignType][stage],function(a,b)
return a.jobLevel>b.jobLevel
end)
end
end
for campaignType,v in pairs(_campaignJobListConfigLookup)do
table.sort(_campaignJobListConfigLookup[campaignType],function(a,b)
return a.jobLevel<b.jobLevel
end)
end
end

function xianguanConfig.getGroupMaxNum(groupId)
local list=xianguanConfig.getJobListConfig(groupId)
return#list
end

function xianguanConfig.getJobListConfig(groupId)
return _jobListConfigLookup[groupId]
end

function xianguanConfig.getJobConfigByLookUp(groupId,id)
return _jobListConfigLookup[groupId][id]
end


function xianguanConfig.getCampaignListConfig(campaignType,stage)
stage=stage or 0
return _campaignConfigLookup[campaignType][stage]
end


function xianguanConfig.getCampaignJobListConfig(campaignType)
return _campaignJobListConfigLookup[campaignType]
end

function xianguanConfig.getJobIconName(icon)
return string.format("icon_xiangongtequan_%d",icon)
end

function xianguanConfig.getTeQuanIconName(icon)
return string.format("icon_xgtq_%d",icon)
end

function xianguanConfig.getTabNameIconName(icon)
return string.format("image_xianguanzjm_wz%d",icon)
end

function xianguanConfig.getTabIconIconName(icon)
return string.format("icon_xianguanzjm_%d",icon*2-1),string.format("icon_xianguanzjm_%d",icon*2)
end

function xianguanConfig.getJobNamebgIconName(icon)
return string.format("image_xianguanzjm_db%d",icon)
end

function xianguanConfig.getT(icon)

end

function xianguanConfig.getCompaignTypeIconName(icon)
return compaignTypeIconNameList[icon]
end


function xianguanConfig.getListContentTotalHeight(groupId)
return cfgHelper.get2(cfg_xianguangroupconfig_get,groupId,'jobListHeight')
end

function xianguanConfig.getToListHeightList(groupId)
local jobCfgList=xianguanConfig.getJobListConfig(groupId)

local temp={}

for index,jobCfg in ipairs(jobCfgList)do
if temp[jobCfg.stage]==nil then
temp[jobCfg.stage]=jobCfg.position[2]
else
if jobCfg.position[2]>temp[jobCfg.stage]then
temp[jobCfg.stage]=jobCfg.position[2]
end
end
end

temp=table.reverse(temp)

return temp
end

function xianguanConfig.getJobConfig(groupId,jobId,...)
return cfgHelper.get(cfg_xianguanconfig_get,jobId,...)
end

function xianguanConfig.getJobConfig2(jobId,...)
return cfgHelper.get(cfg_xianguanconfig_get,jobId,...)
end

function xianguanConfig.getJobCondition(groupId,jobId,isJingXuan)
if not isJingXuan and xianguanModel:getFirstStart()then
return"求贤若渴，无要求"
end

local jobCfg=xianguanConfig.getJobConfig(groupId,jobId)

local conditonStrList={}
for index,condition in ipairs(jobCfg.campaignCondition)do
local type=condition[1]
if type==XianGuanCampaignConditionType.eXianZhiId then
local xzId=condition[2]
local xzCfg=cfgHelper.get1(cfg_xianzhiconfig_get,xzId)
local xzStr=FMT.fmt("仙职{0}重天",mathHelper.numberToChinese(xzCfg.jctian))
conditonStrList[#conditonStrList+1]=xzStr
end
end

local conditionTotalStr
if#conditonStrList>1 then
conditionTotalStr=table.concat(conditonStrList,"+")
else
conditionTotalStr=conditonStrList[1]
end

return conditionTotalStr
end

function xianguanConfig.checkCanJob(groupId,jobId)
local jobCfg=xianguanConfig.getJobConfig(groupId,jobId)

local state=true
for index,condition in ipairs(jobCfg.campaignCondition)do
local type=condition[1]
if JobCheckConditionFunc[type]then
local cstate=JobCheckConditionFunc[type](condition)
state=state and cstate
end
end
return state
end

function xianguanConfig.getTeQuanEffectDurationStr(privilegeId)
local duration=cfgHelper.get2(cfg_xianguanprivilegeconfig_get,privilegeId,"duration")

if duration then
if duration==0 then
return"立即触发"
else
return timeHelper.format_time_stamp4(duration)
end
else
return"立即触发"
end
end

function xianguanConfig.getJobSortWidget(groupId,jobId)
local jobLevel=xianguanConfig.getJobConfig(groupId,jobId,'jobLevel')
return jobLevel
end

function xianguanConfig.checkIsActiveTeQuan(tqId)
local cfg=cfgHelper.get1(cfg_xianguanprivilegeconfig_get,tqId)
if cfg then
return cfg.type>0
else
logErr("试图获取不存在的特权",tqId)
end
return false
end

function xianguanConfig.getTeQuanCfg(tqId,...)
return cfgHelper.get(cfg_xianguanprivilegeconfig_get,tqId,...)
end

function xianguanConfig.getTeQuanFindKey(xgid,tqid)
return string.format("%s_%s",xgid,tqid)
end

function xianguanConfig.getJobCfgListByType(xgType)
local list=_jobTypeListConfigLookup[xgType]
return list or{}
end

function xianguanConfig.commonJump(xgid,tqid)
local type=xianguanConfig.getTeQuanCfg(tqid,"type")
local baseData={
xgid=xgid,
tqid=tqid,
type=type,
}
local useJump=xianguanConfig.getTeQuanCfg(tqid,"useJump")

if useJump then
local args=table.weakCopy(useJump.args or{})
args.baseData=baseData
return jumpManager:jump({id=useJump.id,args=args})
else



return false
end
end

function xianguanConfig.commonLogJump(xgid,tqid,logData)
local type=xianguanConfig.getTeQuanCfg(tqid,"type")
local baseData={
xgid=xgid,
tqid=tqid,
type=type,
}
local useJump=xianguanConfig.getTeQuanCfg(tqid,"logJump")

if useJump then
local args=table.weakCopy(useJump.args or{})
args.baseData=baseData
args.logData=logData
return jumpManager:jump({id=useJump.id,args=args})
else



return false
end
end

function xianguanConfig.getResetCD(tqid)
local resetType=xianguanConfig.getTeQuanCfg(tqid,'reset')

if resetType==xianguanConfig.resetTimesType.eDay then
return timeHelper.getServerTodayLeft()
elseif resetType==xianguanConfig.resetTimesType.eDayFive then
return timeHelper.getServerNewDayFiveLeftTime()
elseif resetType==xianguanConfig.resetTimesType.eWeek then
return timeHelper.getWeekTimeLeftStampEx(1,0,0,0)
elseif resetType==xianguanConfig.resetTimesType.eWeekFive then
return timeHelper.getWeekTimeLeftStampEx(1,5,0,0)
end
end


function xianguanConfig.getLimitCrossTeQuanIdsByJobId(jobId)
local privilegeList=xianguanConfig.getJobConfig2(jobId,"privilegeList")
local ids={}

for index,pid in ipairs(privilegeList)do
if pid~=XIANGUAN_PRIVILEGE_ENUM.eExpectation then
if xianguanHelper.checkTeQuanPlatformLimit(pid)then
ids[#ids+1]=pid
end
else
if(not xianguanHelper.checkTeQuanPlatformLimit(pid))or xianguanConfig.checkHasExpectationPrivilege(jobId,pid)then
ids[#ids+1]=pid
end
end
end

return ids
end

function xianguanConfig.checkHasExpectationPrivilege(jobId,tqId)
if tqId~=XIANGUAN_PRIVILEGE_ENUM.eExpectation then return false end
local privilegeList=cfgHelper.get2(cfg_xianguanbaseconfig_get,1,'expectation_privilege_lsit')
return table.findValue(privilegeList,jobId)
end

function xianguanConfig.checkJobCfgHasTeQuan(jobId,tqId)
local privilegeList=xianguanConfig.getJobConfig2(jobId,'privilegeList')
if privilegeList then
return table.findValue(privilegeList,tqId)~=nil
end
return false
end

function xianguanConfig.getJobGroupId(jobId)
return mathHelper.safe_floor(jobId/100)
end
