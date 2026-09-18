







wudaotangModel={}

local _planid=nil
local _starttime=nil
local _wdtlist=nil
local _rewardlist=nil
local timerDelay=nil
local progressLookup=nil

function wudaotangModel:clearData()
_planid=nil
_starttime=nil
_wdtlist=nil
_rewardlist=nil
timerDelay=nil
progressLookup=nil
end

function wudaotangModel:clearPlan()
_planid=nil
_starttime=nil
_wdtlist=nil
_rewardlist=nil
progressLookup=nil
end

function wudaotangModel:recordReward(idx,data)
if _rewardlist==nil then _rewardlist={}end
_rewardlist[idx]=data
end

function wudaotangModel:getReward()
return _rewardlist
end

function wudaotangModel:initData(planid,starttime,wdtlist)
_planid=planid
_starttime=starttime
_wdtlist=wdtlist
progressLookup={}

progressLookup[0]=0
end

function wudaotangModel:getPlan()


return _planid or 0
end

function wudaotangModel:getStartTime()


return _starttime
end


function wudaotangModel:getPassTime()
return gameUtilityModel.getServerShortTime()-wudaotangModel:getStartTime()
end

function wudaotangModel:getDisDatas()


return _wdtlist
end

function wudaotangModel:getManCount()
if _wdtlist==nil then return 0 end
return#_wdtlist
end

function wudaotangModel:fightVictory(guid)
if _wdtlist then
for i,v in ipairs(_wdtlist)do
if mathHelper.compareInt64(v.guid,guid)then
v.endtime=gameUtilityModel.getServerShortTime()
break
end
end
end
end

function wudaotangModel:getDisDataByIndex(index)
local list=wudaotangModel:getDisDatas()
if list==nil then return nil end
return list[index]
end

function wudaotangModel:getDisDataByGuid(guid)
local list=wudaotangModel:getDisDatas()
if list==nil then return nil end
for i,v in ipairs(list)do
if mathHelper.compareInt64(v.guid,guid)then
return v
end
end
return nil
end

function wudaotangModel:hasPlan()
local planid=wudaotangModel:getPlan()
return planid>0
end

function wudaotangModel:isProduce()
local pass=wudaotangModel:getPassTime()
local delay=wudaotangModel:getTimerDelay()
return pass>=delay and pass%delay==0
end

function wudaotangModel:getCurPlanProgress(buildLv)
local planid=wudaotangModel:getPlan()
local max=wudaotangModel:getMaxPoint(planid,buildLv)
local cur=wudaotangModel:calculateCurPlanProgress()
return cur,max
end

function wudaotangModel:calculateCurPlanProgress()
local passTime=wudaotangModel:getPassTime()
local delay=wudaotangModel:getTimerDelay()
local multi=math.floor(passTime/delay)
passTime=multi*delay
local cur=progressLookup[passTime]
if cur==nil then
cur=0
local starttime=wudaotangModel:getStartTime()
local curTime=starttime+passTime
local wdtlist=wudaotangModel:getDisDatas()
for i,v in ipairs(wdtlist)do
local guid=v.guid
local speed=wudaotangModel:getDisciplePointSpeed(guid)
local flag,pTime=wudaotangModel:calculateDispatchAndFightTime(guid,v.sectList,starttime,curTime,v.begintime,v.endtime)
if not flag then

local f_s_time=v.begintime
local f_e_time=v.endtime

if f_s_time~=0 and f_e_time==0 then f_e_time=curTime end

local f_lerp=f_e_time-f_s_time
if f_lerp<0 then f_lerp=0 end
pTime=passTime-f_lerp
end
cur=cur+pTime*speed
end
progressLookup[passTime]=cur
end
return cur
end





function wudaotangModel:calculateDispatchAndFightTime(guid,dispatchList,s_time,e_time,f_s_time,f_e_time)
if dispatchList==nil then return false,nil end
if not wudaotangModel.checkDispatchListError(guid,dispatchList)then return false,nil end
local c=#dispatchList
if c<=0 then return false,nil end
local lerp=e_time-s_time

if f_s_time~=0 and f_e_time==0 then f_e_time=e_time end
local f_lerp=f_e_time-f_s_time
if f_lerp<0 then f_lerp=0 end
local d_lerp_sub=0
local f_i_lerp_sub=0
local cc=c/2
for i=1,cc do
local idx=i*2
local bTime=dispatchList[idx-1]
local eTime=dispatchList[idx]

if eTime==0 then eTime=e_time end
if eTime>=bTime then
local lerp1=mathHelper.twoLineIntersect(s_time,e_time,bTime,eTime)
if lerp1~=nil then
d_lerp_sub=d_lerp_sub+lerp1
end
if f_e_time>=f_s_time then
local lerp2=mathHelper.twoLineIntersect(bTime,eTime,f_s_time,f_e_time)
if lerp2~=nil then
f_i_lerp_sub=f_i_lerp_sub+lerp2
end
end
end
end
local cnt=lerp-d_lerp_sub-(f_lerp-f_i_lerp_sub)
return true,cnt
end

function wudaotangModel:checkNeedFight(data)
local curTime=gameUtilityModel.getServerShortTime()

if data.begintime>0 then

if curTime>=data.begintime then

if data.endtime==0 then
return true
end
end
end
return false
end

function wudaotangModel:getFightDisciples()
local list=wudaotangModel:getDisDatas()
if list==nil then return nil end
local result={}
for i,v in ipairs(list)do
if self:checkNeedFight(v)then
table.insert(result,v.guid)
end
end
return result
end

function wudaotangModel:checkFightDisciple(guidlist)
if guidlist==nil then return nil end
for k,v in pairs(guidlist)do
local data=self:getDisDataByGuid(v[2])
if data then
if self:checkNeedFight(data)then
return data.guid
end
end
end
return nil
end

function wudaotangModel:checkFightDiscipleEx(guid)
local data=self:getDisDataByGuid(guid)
if data then
if self:checkNeedFight(data)then
return true
end
end
return false
end

function wudaotangModel:getPlanNeedTime(planid,buildLv,dis_list)
local max=wudaotangModel:getMaxPoint(planid,buildLv)
local speed=0
local time=-1
if dis_list then
for i,v in ipairs(dis_list)do
speed=speed+wudaotangModel:getDisciplePointSpeed(v)
end
if speed>0 then
time=max/speed
end
end

return time
end

function wudaotangModel:checkHasReward(buildLv)
if not wudaotangModel:hasPlan()then return false end
local cur,max=wudaotangModel:getCurPlanProgress(buildLv)
return cur>=max
end

function wudaotangModel:checkHasRewardEx()
if not wudaotangModel:hasPlan()then return false end
local bdDatas=zongmenModel:getBuildingDataByBdId(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eWuDaoTang)
local bdData=bdDatas[1]
local cur,max=wudaotangModel:getCurPlanProgress(bdData.level)
return cur>=max
end

function wudaotangModel:getDisciplePointSpeed(guid)
local ratecfg=wudaotangModel:getPointRateCfg()
local attr6Type=wudaotangModel:getPointNeedAttr6Type()
local attr6Num=UIDiscipleModel:getDiscipleBaseAttr(guid,attr6Type)
local rate=ratecfg[2]/100
local speed=ratecfg[1]*(1+attr6Num*rate)

return speed
end

function wudaotangModel:getDisciplePointSpeedEx(guid)
local speed=wudaotangModel:getDisciplePointSpeed(guid)
if wudaotangModel:checkFightDiscipleEx(guid)then
speed=0
elseif UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.edsDispatch)then
speed=0
end
return speed
end

function wudaotangModel:checkPlanOpen(planid,buildLv)
local lockLv=wudaotangModel:getLocakBuildLv(planid)
return buildLv>=lockLv
end

function wudaotangModel:getDiscipleProskillExp(guid,proskilType)
local psLv=UIDiscipleModel:getDiscipleJobLevel(guid,proskilType)
return cfgHelper.get3(cfg_wudaotangconfig_get,1,'exreward',psLv)
end

function wudaotangModel:getwdSatet(bdData)
if bdData==nil then
bdData=wudaotangController:getBuildData()
if bdData==nil then
return-2
end
end
if not wudaotangModel:hasPlan()then
return-1
end
local buildLv=bdData.level
if wudaotangModel:checkHasReward(buildLv)then
return 1
else
for i,data in ipairs(_wdtlist)do
local guid=data.guid
local isDispatch=UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.edsDispatch)
if wudaotangModel:checkNeedFight(data)and not isDispatch then
return 2
end
end
end
return 0
end


function wudaotangModel:hasBuildEffect(bdData)
if not wudaotangModel:hasPlan()then
return false
end
local buildLv=bdData.level
if wudaotangModel:checkHasReward(buildLv)then
return true
else
for i,data in ipairs(_wdtlist)do
local guid=data.guid
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData~=nil then
local isDispatch=UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.edsDispatch)
if not wudaotangModel:checkNeedFight(data)and not isDispatch then
return true
end
end
end
end
return false
end

function wudaotangModel:onDispatchChange(guid,flag)
local data=wudaotangModel:getDisDataByGuid(guid)
if data==nil then return end
local sectList=data.sectList
if not wudaotangModel.checkDispatchListError(guid,sectList)then return end
if flag then

if sectList==nil then
sectList={}
data.sectList=sectList
end
local curtime=gameUtilityModel.getServerShortTime()

table.insert(sectList,curtime)
table.insert(sectList,0)
else

if sectList==nil or#sectList<=0 then
logErr(FMT.fmt('悟道堂弟子<{0}>的派遣时间表为空无法结束派遣',UIDiscipleModel:getDiscipleName(guid)))
return
end
local curtime=gameUtilityModel.getServerShortTime()

sectList[#sectList]=curtime
end
wudaotangController:refreshBuildEffct()
end

function wudaotangModel.checkDispatchListError(guid,dispatchList)
if dispatchList~=nil then
local c=#dispatchList
if c>0 then
if c%2~=0 then
logErr(FMT.fmt('悟道堂弟子<{0}>的派遣时间表不是偶数对形式',UIDiscipleModel:getDiscipleName(guid)))
return false
end
end
end
return true
end

function wudaotangModel:testPrint()
if _wdtlist==nil then return end
local plist={}
local pfunc=function(list,str)
table.insert(list,str)
end
pfunc(plist,'悟道堂打印测试>>>>>>>>>>>>>>>>>')
local planid=wudaotangModel:getPlan()
local ratecfg=wudaotangModel:getPointRateCfg()
local bdData=wudaotangController:getBuildData()
local attr6Type=wudaotangModel:getPointNeedAttr6Type()
pfunc(plist,FMT.fmt('方案id：{0}，基础速度：{1}点/秒',planid,ratecfg[2]/100))
local starttime=wudaotangModel:getStartTime()
local curTime=gameUtilityModel.getServerShortTime()
local lerpTime=curTime-starttime
pfunc(plist,FMT.fmt('开始时间：{0}，当前时间：{1}，总时长：{2}秒--{3}',starttime,curTime,lerpTime,timeHelper.format_time_stamp2(lerpTime)))
local cur,max=wudaotangModel:getCurPlanProgress(bdData.level)
pfunc(plist,FMT.fmt('<color=green>进度：{0}/{1}</color>',cur,max))

local allpoit=0
for i,v in ipairs(_wdtlist)do
local guid=v.guid
if i==1 then
pfunc(plist,'----------------------')
end
local attr6Num=UIDiscipleModel:getDiscipleBaseAttr(guid,attr6Type)
local speed=wudaotangModel:getDisciplePointSpeed(guid)
pfunc(plist,FMT.fmt('弟子：{0}，聪慧：{1}，悟道速度：{2}点/秒',UIDiscipleModel:getDiscipleName(guid),attr6Num,speed))
pfunc(plist,FMT.fmt('产生总悟道点：{0}点--{1}秒',speed*lerpTime,lerpTime))

local f_stime=v.begintime
local f_etime=v.endtime
if f_stime~=0 and f_etime==0 then f_etime=curTime end
local rmTime=f_etime-f_stime
if rmTime<0 then rmTime=0 end
pfunc(plist,FMT.fmt('入魔时间：{0}秒，结束时间：{1}秒，入魔时长：{2}秒--{3}',v.begintime,v.endtime,rmTime,timeHelper.format_time_stamp2(rmTime)))

local pqTime=0
local xxTime=0
if v.sectList~=nil and#v.sectList>0 then
local c=#v.sectList/2
for i=1,c do
local idx=i*2
local stime=v.sectList[idx-1]
local etime=v.sectList[idx]
if etime==0 then etime=curTime end
local pqlerp=etime-stime
if pqlerp<0 then pqlerp=0 end
if pqlerp>0 then
pqTime=pqTime+pqlerp
if f_etime>=f_stime then
local lerpxx=mathHelper.twoLineIntersect(stime,etime,f_stime,f_etime)
if lerpxx~=nil then
xxTime=xxTime+lerpxx
end
end
end

end
end
allpoit=allpoit+(lerpTime-pqTime-(rmTime-xxTime))*speed
pfunc(plist,FMT.fmt('派遣总时间：{0}秒--{1}',pqTime,timeHelper.format_time_stamp2(pqTime)))
pfunc(plist,FMT.fmt('入魔与派遣总交集时间：{0}秒',xxTime))
pfunc(plist,FMT.fmt('入魔消耗悟道点（剔除派遣交集）：{0}点--{1}秒',speed*(rmTime-xxTime),rmTime-xxTime))
pfunc(plist,FMT.fmt('派遣消耗悟道点：{0}点--{1}秒',speed*pqTime,pqTime))
pfunc(plist,FMT.fmt('<color=green>弟子最终产出悟道点：{0}点--{1}秒</color>',speed*(lerpTime-pqTime-(rmTime-xxTime)),lerpTime-pqTime-(rmTime-xxTime)))
pfunc(plist,'----------------------')
end
pfunc(plist,FMT.fmt('<color=green>所有弟子最终产出悟道点：{0}点</color>',allpoit))
pfunc(plist,'<color=red>注：所有弟子产出和进度有一点点误差是正常情况！</color>')
pfunc(plist,'>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>')

local str_=''
local sc=#plist
for i,v in ipairs(plist)do
if i==1 then
str_=str_..'\n'
end
str_=str_..v
if i~=sc then
str_=str_..'\n'
end
end
str_=FMT.fmt('<color=yellow>{0}</color>',str_)

end


function wudaotangModel:getMaxPoint(planid,buildLv)


return cfgHelper.get4(cfg_wudaotangplanconfig_get,planid,'need',buildLv,1)
end

function wudaotangModel:getCost(planid,buildLv)
local costlist=cfgHelper.get4(cfg_wudaotangplanconfig_get,planid,'need',buildLv,2)
return costlist[1]
end

function wudaotangModel:getLocakBuildLv(planid)
local need=cfgHelper.get2(cfg_wudaotangplanconfig_get,planid,'need')
for i,v in pairsBySortKey(need)do

return i
end
return 0
end

function wudaotangModel:getPointNeedAttr6Type()
return cfgHelper.get3(cfg_wudaotangconfig_get,1,'attr6',2)
end

function wudaotangModel:getPointNeedAttr6(planid)
local attrType=cfgHelper.get3(cfg_wudaotangconfig_get,1,'attr6',1)
local attrNum=cfgHelper.get2(cfg_wudaotangplanconfig_get,planid,'attr6')
return{attrType,attrNum}
end

function wudaotangModel:getPointRateCfg()
return cfgHelper.get2(cfg_wudaotangconfig_get,1,'point')
end

function wudaotangModel:getTimerDelay()
if timerDelay==nil then
timerDelay=cfgHelper.get2(cfg_wudaotangconfig_get,1,'interval')
end
return timerDelay
end

function wudaotangModel:getPlanIcon(planid)
local iconName=cfgHelper.get2(cfg_wudaotangplanconfig_get,planid,'icon')
return iconName
end

