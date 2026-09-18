







local limitActObject={}



function limitActObject:__init(actcfg,sTime,eTime)
self.actID=actcfg.id
self.actcfg=actcfg
self.sTime=sTime
self.eTime=eTime
self.delayTimers={}
self:init(sTime,eTime)

self:onInit()
self:refreshState()
end




function limitActObject:resetData(sTime,eTime)
self.sTime=sTime
self.eTime=eTime
self:clearAllDelayTimer()
self:init()
end

function limitActObject:isClientAct()
return self.sTime~=nil and self.eTime~=nil
end

function limitActObject:init()
self:initTimeOffset()
if self:isClientAct()then

self:calculationTimeClient()
else
self:calculationTime()
end

if not self:checkDoing()then
self:refreshEnter(false)
end
end


function limitActObject:initTimeOffset()

self.end_time_offset=0
end

function limitActObject:calculationTimeClient()
self.start_time=self.sTime
self.end_time=self.eTime+self.end_time_offset
local pretime=self.actcfg.pretime or 0
self.pre_time=self.start_time-pretime
self.start_time_l=gameUtilityModel.serverShortTimeToLong(self.start_time)
self.end_time_l=gameUtilityModel.serverShortTimeToLong(self.end_time)
self.pre_time_l=gameUtilityModel.serverShortTimeToLong(self.pre_time)
end

function limitActObject:calculationTime()
local cur_stamp=timeHelper.getServerLongTime()
local y,m,d=timeHelper.getServerData()
local wday=tonumber(timeHelper.dateServer("%w"))

local status=self.actcfg.status
local num=#status






local step=3
local group=num/step
local iseveryday=false
local p_f,f,n_f,idx,data,p_data,l_data
local groupTimeList={}
local isInCurWeek
for g=1,group do
idx=g*step-1
data=status[idx]
p_data=status[idx-1]
l_data=status[idx+1]
iseveryday=data.week==-1
if iseveryday then
local p_t=timeHelper.timeServer(y,m,d,p_data.hour,p_data.min,0)
local t=timeHelper.timeServer(y,m,d,data.hour,data.min,0)
local l_t=timeHelper.timeServer(y,m,d,l_data.hour,l_data.min,0)
l_t=l_t+self.end_time_offset
groupTimeList[g]={p_t,t,l_t}
else
if isInCurWeek==nil then
if wday>=data.week then

isInCurWeek=true
else

isInCurWeek=false
end
end
local lerpDay
if isInCurWeek then

lerpDay=-(wday-data.week)
else

lerpDay=-(wday+7-data.week)
end
local t=timeHelper.timeServer(y,m,d,data.hour,data.min,0)
t=t+timeSecLook:getDaySec(lerpDay)
local y_,m_,d_=timeHelper.getServerStampData(t)
local wday_=data.week

local p_lerpDay=wday_-p_data.week
if p_lerpDay<0 then
p_lerpDay=-p_lerpDay-7
end
local p_t=timeHelper.timeServer(y_,m_,d_,p_data.hour,p_data.min,0)
p_t=p_t+timeSecLook:getDaySec(p_lerpDay)

local l_lerpDay=l_data.week-wday_
if l_lerpDay<0 then
l_lerpDay=l_lerpDay+7
end
local l_t=timeHelper.timeServer(y_,m_,d_,l_data.hour,l_data.min,0)
l_t=l_t+timeSecLook:getDaySec(l_lerpDay)
l_t=l_t+self.end_time_offset

groupTimeList[g]={p_t,t,l_t}
end
end
local roundDay
if iseveryday then
roundDay=1
else
roundDay=7
end
local roundSec=timeSecLook:getDaySec(roundDay)
local temp1=table.deepCopy(groupTimeList[#groupTimeList])
local temp2=table.deepCopy(groupTimeList[1])

temp1[1]=temp1[1]-roundSec
temp1[2]=temp1[2]-roundSec
temp1[3]=temp1[3]-roundSec
table.insert(groupTimeList,1,temp1)

temp2[1]=temp2[1]+roundSec
temp2[2]=temp2[2]+roundSec
temp2[3]=temp2[3]+roundSec
table.insert(groupTimeList,temp2)


local speopen=self.actcfg.speopen
if speopen then
if speopen[1]==1 then

local openDay=speopen[2]
local o_y,o_m,o_d=timeHelper.getDateNumber(gameUtilityModel.getOpenServerLongTime())
local o_time=timeHelper.timeServer(o_y,o_m,o_d,0,0,0)
local spe_o_time=o_time+(openDay-1)*86400
local spe_temp={}
spe_temp[1]=spe_o_time+speopen[3][1]*3600+speopen[3][2]*60
spe_temp[2]=spe_o_time+speopen[4][1]*3600+speopen[4][2]*60
spe_temp[3]=spe_o_time+speopen[5][1]*3600+speopen[5][2]*60
local check=true

for g,v in ipairs(groupTimeList)do
local lerp=mathHelper.twoLineIntersect(v[2],v[3],spe_temp[2],spe_temp[3])
if lerp~=nil then
check=false
end
end

if check then
for i=1,#groupTimeList do
local v=groupTimeList[i]
if spe_temp[3]<v[2]then

if i>1 then
table.insert(groupTimeList,i,spe_temp)
end
break
end
end
end
elseif speopen[1]==2 then

local openDay_start=speopen[2]
local openDay_end=speopen[3]
local o_y,o_m,o_d=timeHelper.getDateNumber(gameUtilityModel.getOpenServerLongTime())
local o_time=timeHelper.timeServer(o_y,o_m,o_d,0,0,0)
for openDay=openDay_start,openDay_end do
local spe_o_time=o_time+(openDay-1)*86400
local spe_temp={}
spe_temp[1]=spe_o_time+speopen[4][1]*3600+speopen[4][2]*60
spe_temp[2]=spe_o_time+speopen[5][1]*3600+speopen[5][2]*60
spe_temp[3]=spe_o_time+speopen[6][1]*3600+speopen[6][2]*60
local check=true

for g,v in ipairs(groupTimeList)do
local lerp=mathHelper.twoLineIntersect(v[2],v[3],spe_temp[2],spe_temp[3])
if lerp~=nil then
check=false
end
end

if check then
for i=1,#groupTimeList do
local v=groupTimeList[i]
if spe_temp[3]<v[2]then

if i>1 then
table.insert(groupTimeList,i,spe_temp)
end
break
end
end
end
end
end
end

local c=#groupTimeList
for g=1,c do
local v=groupTimeList[g]
if cur_stamp<v[3]then
f=v
p_f=groupTimeList[g-1]
if g>=c then
n_f=f
else
n_f=groupTimeList[g+1]
end
break
end
end









local isDone=limitActivitiesModel:getActMark_done(self.actID)
if p_f and not isDone then
p_f=nil
end

if f then
self.pre_time_l=f[1]
self.start_time_l=f[2]
self.end_time_l=f[3]
self.pre_time=gameUtilityModel.serverLongTimeToShort(f[1])
self.start_time=gameUtilityModel.serverLongTimeToShort(f[2])
self.end_time=gameUtilityModel.serverLongTimeToShort(f[3])
else
logErr(FMT.fmt('无法算出活动时间，活动id：{0}，请检查代码及配置',self.actID))
return
end

if p_f then
self.pre_pre_time_l=p_f[1]
self.pre_start_time_l=p_f[2]
self.pre_end_time_l=p_f[3]
self.pre_pre_time=gameUtilityModel.serverLongTimeToShort(p_f[1])
self.pre_start_time=gameUtilityModel.serverLongTimeToShort(p_f[2])
self.pre_end_time=gameUtilityModel.serverLongTimeToShort(p_f[3])
end
if n_f then
self.n_pre_time_l=n_f[1]
self.n_start_time_l=n_f[2]
self.n_end_time_l=n_f[3]
self.n_pre_time=gameUtilityModel.serverLongTimeToShort(n_f[1])
self.n_start_time=gameUtilityModel.serverLongTimeToShort(n_f[2])
self.n_end_time=gameUtilityModel.serverLongTimeToShort(n_f[3])
end

if not isDone then
local firstPreTime=self.actcfg.firstPreTime
if firstPreTime then
self.pre_time_l=self.start_time_l-firstPreTime
self.pre_time=gameUtilityModel.serverLongTimeToShort(self.pre_time_l)
end
end
end


function limitActObject:checkInStartTimeDay()
local y,m,d=timeHelper.getServerData()
local y2,m2,d2=timeHelper.getServerStampData(self.start_time_l)
return y==y2 and m==m2 and d==d2
end

function limitActObject:checkTimeInDoing(time_l)
return time_l>=self.start_time_l and time_l<self.end_time_l
end

function limitActObject:getStartTimeDesc1()
local h=timeHelper.dateServerStamp('%H',self.start_time_l)
local m=timeHelper.dateServerStamp('%M',self.start_time_l)
return FMT.fmt('{0}:{1}',h,m)
end

function limitActObject:getTimeDesc1()
return activitiesModel.getTimeDesc1(self.start_time_l,self.end_time_l)
end


function limitActObject:printInfo()
logErr(FMT.fmt('活动id：{0}，名称：{1}',self.actID,self.actcfg.name))
logErr(FMT.fmt('预告时间：{0}',timeHelper.getFormatByStamp(self.pre_time_l)))
logErr(FMT.fmt('开始时间：{0}',timeHelper.getFormatByStamp(self.start_time_l)))
logErr(FMT.fmt('结束时间：{0}',timeHelper.getFormatByStamp(self.end_time_l)))
end

function limitActObject:onInit()

end

function limitActObject:__delete()
self.actID=nil
self.actcfg=nil
self.sTime=nil
self.eTime=nil

self.pre_time=nil
self.start_time=nil
self.end_time=nil
self.pre_time_l=nil
self.start_time_l=nil
self.end_time_l=nil

self.pre_pre_time=nil
self.pre_start_time=nil
self.pre_end_time=nil
self.pre_pre_time_l=nil
self.pre_start_time_l=nil
self.pre_end_time_l=nil

self.n_pre_time_l=nil
self.n_start_time_l=nil
self.n_end_time_l=nil
self.n_pre_time=nil
self.n_start_time=nil
self.n_end_time=nil

self.end_time_offset=nil

self.state=nil
self.reddotFlag=nil

self.updateErr=nil

self:clearAllDelayTimer()

if self.listenner~=nil then
for notify_id,func in pairs(self.listenner)do
notifySystem:removelistener(notify_id,func)
end
self.listenner=nil
end
self:refreshEnter(false)

self:onDelete()
end

function limitActObject:onDelete()

end

function limitActObject:getActID()
return self.actID
end

function limitActObject:getActType()
return self.actID
end

function limitActObject:listenNotify(notify_id,func)
if self.listenner==nil then
self.listenner={}
end
if self.listenner[notify_id]==nil then
self.listenner[notify_id]=func
notifySystem:listenNotify(notify_id,func)
else



end
end


function limitActObject:getPreviewLeftTime()
if self:checkPreview()then
local cur=gameUtilityModel.getServerShortTime()
return self.start_time-cur
end
return 0
end


function limitActObject:getStartLeftTime()
local cur=gameUtilityModel.getServerShortTime()
local lerp=self.start_time-cur
if lerp>0 then
return lerp
else
return 0
end
end


function limitActObject:getEndLeftTime()
if self:checkDoing()then
local cur=gameUtilityModel.getServerShortTime()
return self.end_time-cur
end
return 0
end



function limitActObject:onReady(isNew)
self.isopen=self:checkCondition()
self:onStart(isNew,nil)
end

function limitActObject:onReconnect()
self.isopen=self:checkCondition()
self:onStart(nil,true)
end


function limitActObject:onStart(isNew,isReconnect)

end


function limitActObject:refreshEnter(flag)
local needClear=true
if flag then
local actcfg=self:getActConfig()
if actcfg.iconType~=nil then
if self:checkDoing()and self:checkOpen()then
if self.enterguid==nil or not enterManager:hasInfo(self.enterguid)then
local actID=self.actID
local enterIconType
if actcfg.iconType==1 then
enterIconType=ENTER_ICON_TYPE.eNomal
else
enterIconType=ENTER_ICON_TYPE.eBig
end
local guid=enterManager:freshEnter({id=actID,enterIconType=enterIconType,enterType=ENTER_TYPE.eLimitAct,
params={actID=actID},getReddotFun=function()
return limitActivitiesModel:getActReddot(actID)
end})
self.enterguid=guid





end
needClear=false
end
end
end
if needClear then
if self.enterguid~=nil then
enterManager:removeEnter(self.enterguid)
self.enterguid=nil
end
end
end

function limitActObject:refreshEnterEx(funcName,args)
if self.enterguid~=nil then
enterManager:freshFuncByGUID(self.enterguid,funcName,args)
end
end


function limitActObject:update()
local old_state=self.state
self:refreshState()
local state=self.state
if old_state~=nil and old_state~=state then
if state==limitActivitiesModel.actPreviewState then

notifySystem:postNotify(notifyConfig.onLimitActStateChange,self.actID,limitActivitiesModel.actPreviewState)
elseif state==limitActivitiesModel.actDoingState then

notifySystem:postNotify(notifyConfig.onLimitActStateChange,self.actID,limitActivitiesModel.actDoingState)
elseif state==limitActivitiesModel.actFinishState then

local actID=self.actID
local isClient=self:isClientAct()
self:onFinish()
notifySystem:postNotify(notifyConfig.onLimitActStateChange,actID,limitActivitiesModel.actFinishState)
if not isClient then

self:resetData()
end
elseif state==limitActivitiesModel.actIdleState then

notifySystem:postNotify(notifyConfig.onLimitActStateChange,self.actID,limitActivitiesModel.actIdleState)
end
end

xpcall(function()
if self.updateErr then return end
self:onUpdate()
end,function(err)
self.updateErr=true
loggerUtil.logErrFMT('limitActObject err!{0}',err)
end)
end

function limitActObject:onUpdate()

end

function limitActObject:onFinish()

end

function limitActObject:refreshState()
self.state=self:getState()
end

function limitActObject:getState()
local cur=gameUtilityModel.getServerShortTime()

if cur>=self.start_time and cur<self.end_time then
return limitActivitiesModel.actDoingState
elseif cur>=self.pre_time and cur<self.start_time then
return limitActivitiesModel.actPreviewState
elseif cur>=self.end_time then
return limitActivitiesModel.actFinishState
else
return limitActivitiesModel.actIdleState
end
end

function limitActObject:getStateEx()
return self.state
end

function limitActObject:checkIdle()
return self.state==limitActivitiesModel.actIdleState
end

function limitActObject:checkPreview()
return self.state==limitActivitiesModel.actPreviewState
end

function limitActObject:checkDoing()
return self.state==limitActivitiesModel.actDoingState
end

function limitActObject:checkFinish()
return self.state==limitActivitiesModel.actFinishState
end

function limitActObject:refreshReddot()
local old=self.reddotFlag
self.reddotFlag=self:checkReddot()
if old~=self.reddotFlag then
notifySystem:postNotify(notifyConfig.onLimitActReddotChange,self.actID)
end
end

function limitActObject:getRoddot()
local reddotFlag=self.reddotFlag
if reddotFlag==nil then
reddotFlag=self:checkReddot()
self.reddotFlag=reddotFlag
end
return reddotFlag
end


function limitActObject:checkReddot()

return false
end

function limitActObject:checkOpen(isWarning)
if isWarning then
self.isopen=self:checkCondition(true)
end
return self.isopen
end

function limitActObject:refreshCondition()
local old_isopen=self.isopen
self.isopen=self:checkCondition()



if old_isopen~=nil and self.isopen~=old_isopen then
self:refreshEnter(true)

if self.isopen==false then
local old=self:getRoddot()
if old~=false then
self.reddotFlag=false
notifySystem:postNotify(notifyConfig.onLimitActReddotChange,self.actID)
end
end

local flag=self.isopen==true and 1 or 2
notifySystem:postNotify(notifyConfig.onLimitActOpen,self.actID,flag)
end
end

function limitActObject:getDayConditionStrFMT()
return'{0}天后可参与'
end

function limitActObject:checkCondition(isWarning,isIgnoreCustomCnd)
local actcfg=self.actcfg
local kfDay=limitActivitiesModel.getDayConditionCfg(actcfg)
if kfDay~=nil then

local openday=timeHelper.getServerOpenDay()
if openday<kfDay then
local fmt_str=self:getDayConditionStrFMT()
local tips_str=FMT.fmt(fmt_str,kfDay-openday)
if isWarning then
UIManager.error(tips_str)
end
return false,tips_str
end
end
local zmLevel=limitActivitiesModel.getZMLevelConditionCfg(actcfg)
if zmLevel~=nil then

local lv=zongmenModel:getLevel()
if lv<zmLevel then
local tips_str=FMT.fmt('宗门达到{0}级可参与',zmLevel)
if isWarning then
UIManager.error(tips_str)
end
return false,tips_str
end
end











local xychapterid=actcfg.xychapterid
if xychapterid~=nil then











local isStart=seasonController:checkSeasonStageBegined(0,xychapterid)
if not isStart then
local tips_str=FMT.fmt('重建仙域开启第{0}章后可参与',xychapterid)
if isWarning then
UIManager.error(tips_str)
end
return false,tips_str
end
end


local mojieStage=actcfg.mojieCnd
if mojieStage~=nil then
local isOpenMoJie=xianjieModel:checkCurrentMoJieEnterTime()
if not isOpenMoJie then return false,"魔界未开启"end

local enterData=xianjieModel:getMoJieEnterData()
if enterData==nil then
return false,'魔界赛季未开启'
end

local cnd=mojieStage[enterData.sId]or mojieStage[0]
if cnd then
local stageIdx=cnd[1]
local stageType=cnd[2]
local stageDay=cnd[3]

local csid=xianjieModel:getMoJieEnterConfig('csid')
local seasonHandle=seasonModel:getHandle(csid)
if seasonHandle==nil then
return false,'魔界赛季未开启'
end


local stageHandle=seasonHandle:getStage(stageIdx)
if stageHandle==nil then
return false,'阶段未开启'
end

local nowTime=timeHelper.getServerShortTime()

local intervalTime=stageDay*timeSecLook.eOneDaySec

local timerKey=string.format("%d_%d_%d_%d",seasonHandle.id,stageIdx,stageType,stageDay)
self:stopDelayTimer(timerKey)
if stageType==0 then
local errrStr=FMT.fmt("阶段{0}还未开启",stageIdx)
local begineTime=stageHandle.beginTime
if nowTime<begineTime then
return false,errrStr
else
if not stageHandle:checkOpen()then
return false,errrStr
end
local begineZeroTime=timeHelper.getServerZeroShortStamp(begineTime)
local startTime=begineZeroTime+intervalTime
if startTime>nowTime then

local left=startTime-nowTime
self.delayTimers[timerKey]=timeEventController.delayDo(left,function()

self:refreshCondition()
end)
return false,errrStr
end
end
elseif stageType==1 then
local errStr=FMT.fmt("阶段{0}还未结束",stageIdx)
local endTime=stageHandle.endTime
if nowTime<endTime then
return false,errStr
else
if not stageHandle:checkOpen()then
return false,FMT.fmt("阶段{0}还未开启",stageIdx)
end
local endZeroTime=timeHelper.getServerZeroShortStamp(endTime)
local startTime=endZeroTime+intervalTime
if startTime>nowTime then

local left=startTime-nowTime
self.delayTimers[timerKey]=timeEventController.delayDo(left,function()

self:refreshCondition()
end)
return false,errStr
end
end
end
end
end

if not isIgnoreCustomCnd then
local check,str=self:checkCustomCondition(isWarning)
if not check then
return false,str
end
end

return true
end


function limitActObject:checkCustomCondition(isWarning)
return true
end

function limitActObject:checkDayCondition()
local kfDay=limitActivitiesModel.getDayConditionCfg(self.actcfg)
if kfDay~=nil then

local openday=timeHelper.getServerOpenDay()
if openday<kfDay then
return false,kfDay-openday
end
end
return true,nil
end



function limitActObject:checkJump_time(isWarning)
if self:checkIdle()or self:checkPreview()then
if isWarning then
UIManager.error('活动未开始')
end
return false
elseif self:checkFinish()then
if isWarning then
UIManager.error('活动已结束')
end
return false
end
return true
end



function limitActObject:checkJump_data(isWarning)
return true
end

function limitActObject:jump()

end

function limitActObject:getActConfig()
return self.actcfg
end

function limitActObject:getActServerType()
return limitActivitiesModel:getActServerType(self.actcfg)
end

function limitActObject:checkHideInWin()
return self.actcfg.hideInWin
end

function limitActObject:getUIEnterBigLimitActivityBottomText()

return nil
end

function limitActObject:stopDelayTimer(timerKey)
if self.delayTimers[timerKey]then
self.delayTimers[timerKey]:cancel()
self.delayTimers[timerKey]=nil
end
end

function limitActObject:clearAllDelayTimer()
if not next(self.delayTimers)then return end

for key,timer in pairs(self.delayTimers)do
timer:cancel()
end
self.delayTimers={}
end



local num=20
local pool={}
local fileLookup={}

function new_limitActInfo(actcfg,sTime,eTime)
local newT
if#pool>0 then
newT=table.remove(pool)
else
newT={}
local mT={
__index=limitActObject,
}
setmetatable(newT,mT)
end
local actType=actcfg.id
local childname=limitActInfoConfig[actType]
if childname then
local child=fileLookup[actType]
local filename=FMT.fmt('lua.gamesys.limitActivities.child.{0}',childname)
if child==nil then
child=require(filename)
fileLookup[actType]=child
end
if child==nil then



return
end
for k,v in pairs(child)do
newT[k]=v
end
end
newT:__init(actcfg,sTime,eTime)
return newT
end

function release_limitActInfo(actInfo)
if actInfo==nil then return end
actInfo:__delete()
local temp={}

for k,v in pairs(actInfo)do
temp[k]=true
end
for k,v in pairs(temp)do
actInfo[k]=nil
end
if#pool>=num then
return
end
table.insert(pool,actInfo)
end
