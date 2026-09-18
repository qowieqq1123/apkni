







actPreviewModel={}

actPreviewModel.maxNum=3

local checkSpeTime=function(self_)
local isRefresh_=false
local cfg_=self_.cfg
if cfg_.relation[1]==2 then

local actType=cfg_.relation[2]
if actType==LIMIT_ACT_TYPE.eLingXuWenJian then

local actInfo=limitActivitiesModel:getActInfo(actType)
if actInfo~=nil then
local preID=cfg_.id
local o_time_=self_.o_time
local e_time_=self_.e_time
local c_time=gameUtilityModel.getServerLongTime()



if c_time>e_time_ then
local delay=actPreviewModel:getLocalData_delayTime(preID)
if delay then
self_.o_time=o_time_+delay
self_.e_time=e_time_+delay


end
elseif c_time<o_time_ then

self_.refreshTime=o_time_
else
local check=false
local _ver=pfwindowslController:getGameVersion()
local _pfId=gameUtilityModel.getServerPlatform()
local cfgTime=cfg_.time
local _verCfgTime=cfgTime[_ver]or cfgTime[pfwindowslController.sdkPFVersion.game_jianti]
local _pfCfgTime=_verCfgTime[_pfId]or _verCfgTime[-1]
local time_=_pfCfgTime
local l_day=time_[3]-time_[2]
local t=o_time_+l_day*86400
local raceState=lingxuwenjianModel:getLunState(t)
if raceState==eLXWJ_State.eStandby then
check=true
end
if not check then

local luntime=actInfo:getNextLunTime()
local delay=luntime[1]-self_.e_time
if delay>=0 then
self_.o_time=luntime[1]-2*86400
self_.e_time=luntime[1]+86400
local delay_=self_.o_time-o_time_
isRefresh_=actPreviewModel:recordLocalData_delayTime(preID,delay_)
end
end
end
end
end
elseif cfg_.relation[1]==4 then
isRefresh_=true
end
return isRefresh_
end

local checkOpen=function(self_)
local cfg_=self_.cfg


local pfId=loginModel:getPfid()
local crossId=loginModel:getCrossServerId()

if cfg_.include_platform_crossServer_id~=nil then
local crList=cfg_.include_platform_crossServer_id[pfId]
if crList then
if table.findValue(crList,crossId)==nil then
return false
end
else
return false
end
end

if cfg_.exclude_platform_crossServer_id~=nil then
local crList=cfg_.exclude_platform_crossServer_id[pfId]
if crList then
if next(crList)then
if table.findValue(crList,crossId)~=nil then
return false
end
else
return false
end
end
end

local lv=zongmenModel:getLevel()
if lv>=cfg_.zmlv then
local c_time=gameUtilityModel.getServerLongTime()
return c_time>=self_.o_time and c_time<=self_.e_time
end
return false
end

local checkReward=function(self_)
local cfg_=self_.cfg
if cfg_.daily then
local c_time=gameUtilityModel.getServerLongTime()
if c_time>=self_.r_o_time and c_time<=self_.r_e_time then
local time_=actPreviewModel:getRewardTime(self_.id)
if time_==-1 or not timeHelper.checkInSameDay(gameUtilityModel.serverShortTimeToLong(time_),c_time)then
return true
end
end
end
return false
end

local getOpenTime=function(self_)
local cfg_=self_.cfg
local curTime=gameUtilityModel.getServerLongTime()
local e_time=self_.e_time
local relation=cfg_.relation
local desc_fmt
if relation[1]==1 or relation[1]==2 or relation[1]==4 then
desc_fmt='活动将于{0}后开启'
elseif relation[1]==3 then
local sysid=relation[2]

desc_fmt='活动将于{0}后开启'

local condition=cfgHelper.get2(cfg_systemopenconfig_get,sysid,'openargs')
local e_day
for k,cgroup in pairs(condition[1])do
if cgroup[1]==3 then
e_day=cgroup[2]-1
break
end
end
if e_day then
local o_y,o_m,o_d=timeHelper.getDateNumber(gameUtilityModel.getOpenServerLongTime())
local o_time_=timeHelper.timeServer(o_y,o_m,o_d,0,0,0)
e_time=o_time_+e_day*86400
else
local name=systemConfig.getSystemName(sysid)
logErr(FMT.fmt("{0}系统，没有使用开服天数作为开启条件，不应有关联活动预告的配置",name))
end
end
if relation[1]==2 then

local actType=cfg_.relation[2]
local actInfo=limitActivitiesModel:getActInfo(actType)
if actInfo~=nil then
if actType==LIMIT_ACT_TYPE.eLingXuWenJian then

e_time=e_time-86400
desc_fmt='备战将于{0}后开启'
else
if actInfo:checkIdle()or actInfo:checkPreview()then

if e_time>actInfo.start_time_l then
e_time=actInfo.start_time_l
end
end
end
end
end

local t=e_time-curTime
local str
if relation[1]==1 or relation[1]==2 or relation[1]==4 or relation[1]==3 then
if t>0 then
str=FMT.fmt(desc_fmt,timeHelper.format_time_stamp3(t))
else
str=''
end
elseif relation[1]==3 then
str=desc_fmt or''
end
return t,str
end

local checkDoing=function(self_)
local relation=self_.cfg.relation
if relation[1]==1 then

local sub_actList=activitiesModel:getActSubList_subType_doing(relation[2])
if#sub_actList>0 then
for i,sub_actInfo in ipairs(sub_actList)do
if not sub_actInfo:isKuafuType()then
local str=sub_actInfo:getTimeDesc1()
str=FMT.fmt('活动时间:{0}',str)
return true,str
end
end
end
elseif relation[1]==2 then

local actType=relation[2]
local actInfo=limitActivitiesModel:getActInfo(actType)
if actInfo~=nil then
if actType==LIMIT_ACT_TYPE.eLingXuWenJian then
local curTime=gameUtilityModel.getServerLongTime()
local e_time=self_.e_time

e_time=e_time-86400
if curTime>=e_time then
local str=actInfo:getTimeDesc1()
str=FMT.fmt('活动时间:{0}',str)
return true,str
end
else
if actInfo:checkOpen()and actInfo:checkDoing()then
local str=actInfo:getTimeDesc1()
str=FMT.fmt('活动时间:{0}',str)
return true,str
end
end
end
elseif relation[1]==3 then

local sysid=relation[2]
if systemModel.isOpen(sysid)then
local str=''
if sysid==SYSTEM_DEFINE.eWishTree then
local s_time,e_time=qiYuanShuModel:getQiYuanTime()
local s_time_l=timeHelper.convertLongStamp(s_time)
local e_time_l=timeHelper.convertLongStamp(e_time)
str=activitiesModel.getTimeDesc1(s_time_l,e_time_l)
str=FMT.fmt('活动时间:{0}',str)
end
return true,str
end
end
return false,nil
end

function actPreviewModel:initData(list)
self.rewardTimeLookup={}
if list then
for i,v in ipairs(list)do
self.rewardTimeLookup[v.param_1]=v.param_2
end
end
end

function actPreviewModel:initPreviewData()
if self.previewLookup==nil then
self.previewLookup={}
local isRefresh=false
local cfgs=cfg_activityspreviewconfig()
for id,cfg in pairs(cfgs)do
local d={cfg=cfg,id=id}
local isRefresh_=actPreviewModel:handlePreviewData(d)
if isRefresh_ then
isRefresh=true
end
self.previewLookup[id]=d
end
if isRefresh then
actPreviewModel:savaLocalData()
end
end
end

function actPreviewModel:handlePreviewData(d)
local cfg=d.cfg
local _ver=pfwindowslController:getGameVersion()
local _pfId=gameUtilityModel.getServerPlatform()
local cfgTime=cfg.time
local _verCfgTime=cfgTime[_ver]or cfgTime[pfwindowslController.sdkPFVersion.game_jianti]
local _pfCfgTime=_verCfgTime[_pfId]or _verCfgTime[-1]
local time=_pfCfgTime
local o_time,e_time
if time[1]==1 then
local o_day=time[2]
local e_day=time[3]
local o_y,o_m,o_d=timeHelper.getDateNumber(gameUtilityModel.getOpenServerLongTime())
local o_time_=timeHelper.timeServer(o_y,o_m,o_d,0,0,0)
o_time=o_time_+(o_day-1)*86400
e_time=o_time_+e_day*86400
elseif time[1]==2 then
o_time=timeHelper.dataToTimeStam(time[2])
e_time=timeHelper.dataToTimeStam(time[3])
elseif time[1]==3 then
local o_day=time[2]
local e_day=time[3]
local o_y,o_m,o_d=timeHelper.getDateNumber(gameUtilityModel.getOpenServerLongTime())
local o_time_=timeHelper.timeServer(o_y,o_m,o_d,0,0,0)
local o_time_d=o_time_+(o_day-1)*86400
local e_time_d=o_time_+e_day*86400

o_time=timeHelper.dataToTimeStam(time[4])
e_time=timeHelper.dataToTimeStam(time[5])

o_time=Mathf.Max(o_time_d,o_time)
e_time=Mathf.Min(e_time_d,e_time)
elseif time[1]==4 then

o_time=timeHelper.dataToTimeStam(time[2])
local nowOpenDay=timeHelper.getServerOpenDay()
local nowTime=timeHelper.getServerLongTime()
local o_day=time[4]or 0
local final_e_time
if time[5]then
final_e_time=timeHelper.dataToTimeStam(time[5])
end
local timeParam=time[3]
local dayCount=timeParam[1]
local intervalWeek=timeParam[2]
local e_H=timeParam[3]or 0
local e_M=timeParam[4]or 0
local e_S=timeParam[5]or 0
local o_y,o_m,o_d=timeHelper.getDateNumber(o_time)
e_time=timeHelper.timeServer(o_y,o_m,o_d+dayCount-1,e_H,e_M,e_S)
if nowOpenDay>o_day and nowTime>e_time then

local deltaTime=nowTime-e_time
local duration=(intervalWeek+1)*86400*7
local weekCount=math.floor(deltaTime/duration)+1
o_time=o_time+duration*weekCount
e_time=e_time+duration*weekCount
end
if final_e_time and e_time>final_e_time then
e_time=final_e_time
end
end
d.r_o_time=o_time
d.r_e_time=e_time
d.o_time=o_time
d.e_time=e_time

d.checkSpeTime=checkSpeTime
d.checkOpen=checkOpen
d.checkReward=checkReward
d.getOpenTime=getOpenTime
d.checkDoing=checkDoing
local isRefresh=d:checkSpeTime()
return isRefresh
end

function actPreviewModel:clearData()
self.rewardTimeLookup=nil
self.previewLookup=nil
end

function actPreviewModel:setRewardTime(id,time)
if self.rewardTimeLookup then
self.rewardTimeLookup[id]=time
end
end

function actPreviewModel:getRewardTime(id)
if self.rewardTimeLookup then
return self.rewardTimeLookup[id]or-1
end
end

function actPreviewModel:getPreviewSortList()
actPreviewModel:initPreviewData()
local list={}
local isRefresh=false
for id,d in pairs(self.previewLookup)do
if d.refreshTime~=nil then
local c_time=gameUtilityModel.getServerLongTime()
if c_time>=d.refreshTime then
d.refreshTime=nil
local isRefresh_=d:checkSpeTime()
if isRefresh_ then
isRefresh=true
end
end
end
if d:checkOpen()then
table.insert(list,d)
end
end
if isRefresh then
actPreviewModel:savaLocalData()
end

local c=#list
if c>0 then
local hasReward=false

for i,d in ipairs(list)do
if d:checkReward()then
hasReward=true
break
end
end
local checkShow=hasReward
if not checkShow then
if not actPreviewModel:getActPreviewMark()then
checkShow=true
end
end
if checkShow then
if c>1 then
table.sort(list,function(a,b)
return a.cfg.sortWeight>b.cfg.sortWeight
end)
end
local list2={}
local cc=math.min(c,actPreviewModel.maxNum)
for i=1,cc do
list2[i]=list[i]
end
return list2
end
end
return nil
end

function actPreviewModel:markActPreview()
userActorSetting.set('actPreviewMark',gameUtilityModel.getServerLongTime())
userActorSetting.flush()
end

function actPreviewModel:getActPreviewMark()
local refreshTime=userActorSetting.get('actPreviewMark',nil)
local flag=false
if refreshTime~=nil and timeHelper.isTodayStamp(refreshTime)then
flag=true
end
return flag
end

function actPreviewModel:clearActPreviewMark()
userActorSetting.set('actPreviewMark',nil)
userActorSetting.flush()
end

function actPreviewModel:recordLocalData_delayTime(preID,time)
local isRefresh=false
local key=tostring(preID)
local lp=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eActPreview,nil)
if lp==nil then
isRefresh=true
lp={}
userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eActPreview,lp)
end
local data=lp[key]
if data==nil then
isRefresh=true
data={}
lp[key]=data
end
if data[1]~=time then
isRefresh=true
data[1]=time
end
return isRefresh
end

function actPreviewModel:getLocalData_delayTime(preID)
local lp=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eActPreview,nil)
if lp then
local key=tostring(preID)
local data=lp[key]
if data then
return data[1]
end
end
end

function actPreviewModel:savaLocalData()
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eActPreview)
end

function actPreviewModel:test()
actPreviewModel:recordLocalData_delayTime(9,nil)
actPreviewModel:savaLocalData()
end

function actPreviewModel:test2()
actPreviewModel:recordLocalData_delayTime(9,86400)
actPreviewModel:savaLocalData()
end