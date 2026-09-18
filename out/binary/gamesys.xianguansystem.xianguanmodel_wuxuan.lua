local _activityData=nil
local _registerData=nil
local _matchData=nil
local _playerData=nil
local _roundLookup={}
local _roundSince={}
local _shareTime=nil
local _pfOpen=false

function xianguanModel:initWuXuanConfig()
local battle_conf=cfgHelper.get2(cfg_officerelectionbasic2config_get,1,"battle_conf")
local count=#battle_conf
local since=0
for round=1,count do
local battleNum=math.pow(2,count-round)
_roundSince[round]=since
since=since+battleNum
for index=1,battleNum do
table.insert(_roundLookup,{round,index})
end
end
end

function xianguanModel:onProtocalReqKF_WuXuan()
local cross=cfgHelper.get2(cfg_officerelectionbasic2config_get,1,"cross")
if cross then
local crossId=loginModel:getCrossServerId()or 0
local state=cross[crossId]
_pfOpen=state~=nil and state==1
else
_pfOpen=true
end
end

function xianguanModel:convertWuXuanBattleIdx2RoundIdx(battleIdx)
return unpack(_roundLookup[battleIdx])
end

function xianguanModel:convertWuXuanRoundIdx2BattleIdx(round,index)
return _roundSince[round]+index
end

function xianguanModel:clearWuXuanData()
_activityData=nil
_registerData=nil
_matchData=nil
_playerData=nil
_shareTime=nil
end

function xianguanModel:checkInitWuXuanData()
return _playerData~=nil and _activityData~=nil and _registerData~=nil and _matchData~=nil
end

function xianguanModel:initWuXuanActivityData(lastTime,groupList)
groupList=groupList or{}

self:setWuXuanActivityTime(lastTime)

self:setWuXuanRegisterData(groupList)

self:setWuXuanMatchData(groupList)
end

function xianguanModel:setWuXuanActivityTime(lastTime)
_activityData={}
_activityData.lastTime=lastTime
_activityData.thisWeek=timeHelper.checkInSameWeek4(lastTime)
if _activityData.thisWeek then
_activityData.nextTime=nil

local config=cfgHelper.get1(cfg_officerelectionbasic2config_get,1)
_activityData.weekBTime=timeHelper.getWeekZeroTime(lastTime)
_activityData.weekETime=_activityData.weekBTime+86400*7

local registerConfig=config.sign_up_conf
_activityData.registerBTime=_activityData.weekBTime+(registerConfig[1]-1)*86400+registerConfig[2]*3600+registerConfig[3]*60
_activityData.registerETime=_activityData.weekBTime+(registerConfig[1]-1)*86400+registerConfig[4]*3600+registerConfig[5]*60

local prepareConfig=config.prepare_conf
_activityData.prepareBTime=_activityData.weekBTime+(prepareConfig[1]-1)*86400+prepareConfig[2]*3600+prepareConfig[3]*60
_activityData.prepareETime=_activityData.weekBTime+(prepareConfig[1]-1)*86400+prepareConfig[4]*3600+prepareConfig[5]*60

local matchConfig=config.battle_conf
local round=#matchConfig
_activityData.matchTime={}
for i,v in ipairs(matchConfig)do
local matchTime={}
matchTime.beginTime=_activityData.weekBTime+(v[1]-1)*86400+v[2]*3600+v[3]*60
matchTime.endTime=_activityData.weekBTime+(v[1]-1)*86400+v[4]*3600+v[5]*60
_activityData.matchTime[i]=matchTime
end
_activityData.matchBTime=_activityData.matchTime[1].beginTime
_activityData.matchETime=_activityData.matchTime[round].endTime

local resultConfig=config.calc_conf
_activityData.resultTime=_activityData.weekBTime+(resultConfig[1]-1)*86400+resultConfig[2]*3600+resultConfig[3]*60

self:refreshWuXuanActivitySegmentData()

limitActivitiesModel:addClientAct(LIMIT_ACT_TYPE.eXianGuanWuXuan,_activityData.registerBTime,_activityData.matchETime)
else
_activityData.nextTime=self:getWuXuanNextTime()

local beginTime=timeHelper.getWeekZeroTime(lastTime)
local nowTime=timeHelper.getServerShortTime()
local endTime=timeHelper.getWeekZeroTime(nowTime)
limitActivitiesModel:addClientAct(LIMIT_ACT_TYPE.eXianGuanWuXuan,beginTime,endTime)
end


end

function xianguanModel:refreshWuXuanActivitySegmentData(nowTime)
nowTime=nowTime or timeHelper.getServerShortTime()
local segmentData=_activityData.segmentData or{}
if nowTime<_activityData.registerBTime then
segmentData.status=XianGuanWuXuanSegment.eNone
segmentData.beginTime=_activityData.weekBTime
segmentData.endTime=_activityData.registerBTime
elseif _activityData.registerBTime<=nowTime and nowTime<_activityData.registerETime then
segmentData.status=XianGuanWuXuanSegment.eRegister
segmentData.beginTime=_activityData.registerBTime
segmentData.endTime=_activityData.registerETime
elseif _activityData.registerETime<=nowTime and nowTime<_activityData.prepareBTime then
segmentData.status=XianGuanWuXuanSegment.eBlank
segmentData.beginTime=_activityData.registerETime
segmentData.endTime=_activityData.prepareBTime
elseif _activityData.prepareBTime<=nowTime and nowTime<_activityData.prepareETime then
segmentData.status=XianGuanWuXuanSegment.eReady
segmentData.beginTime=_activityData.prepareBTime
segmentData.endTime=_activityData.prepareETime
elseif _activityData.prepareETime<=nowTime and nowTime<_activityData.matchBTime then
segmentData.status=XianGuanWuXuanSegment.eBlank
segmentData.beginTime=_activityData.prepareETime
segmentData.endTime=_activityData.matchBTime
elseif _activityData.matchBTime<=nowTime and nowTime<_activityData.matchETime then
segmentData.status=XianGuanWuXuanSegment.eMatch
segmentData.beginTime=_activityData.matchBTime
segmentData.endTime=_activityData.matchETime
else
segmentData.status=XianGuanWuXuanSegment.eFinish
segmentData.beginTime=_activityData.matchETime
segmentData.endTime=_activityData.weekETime
end
_activityData.segmentData=segmentData
end

function xianguanModel:checkWuXuanActivityTime(nowTime)
if _activityData and _activityData.thisWeek then
nowTime=nowTime or timeHelper.getServerShortTime()
return _activityData.registerBTime<=nowTime and nowTime<_activityData.weekETime
end
return false
end

function xianguanModel:getWuXuanActivityData()
return _activityData
end

function xianguanModel:checkWuXuanWeek()
if self:checkWuXuanPlatformOpen()then
return _activityData and _activityData.thisWeek or false
end
return false
end

function xianguanModel:getWuXuanNextTime()
local lastTime=_activityData.lastTime
local nowTime=timeHelper.getServerShortTime()
local config=cfgHelper.get1(cfg_officerelectionbasic2config_get,1)
if lastTime>nowTime then
return timeHelper.getWeekZeroTime(lastTime)
elseif lastTime==0 then
return self:getWuXuanFirstWeekTime()
else
local deltaTime=nowTime-lastTime
local intervalWeek=config.rest_week
local intervalSec=(intervalWeek+1)*86400*7
local addTime=math.ceil(deltaTime/intervalSec)*intervalSec
return timeHelper.getWeekZeroTime(lastTime+addTime)
end
end

function xianguanModel:getWuXuanFirstWeekTime()
local config=cfgHelper.get1(cfg_officerelectionbasic2config_get,1)
local xianJieOpenTime=JiuChongTianJieEnterModel:getTianJieFirstFinishSec()
if xianJieOpenTime>0 then
local registerConfig=config.sign_up_conf
local weekDelta=(registerConfig[1]-1)*86400+registerConfig[2]*3600+registerConfig[3]*60

local fairyland_after_open=config.fairyland_after_open
local firstTime=xianJieOpenTime+fairyland_after_open*86400
local firstZero=timeHelper.getWeekZeroTime(firstTime)
if(firstTime-firstZero)>weekDelta then
firstTime=firstTime+86400*7
end
return timeHelper.getWeekZeroTime(firstTime)
end
end

function xianguanModel:getWuXuanNextOpenTime()
if _activityData and _activityData.nextTime then
local registerConfig=cfgHelper.get2(cfg_officerelectionbasic2config_get,1,"sign_up_conf")
return _activityData.nextTime+(registerConfig[1]-1)*86400+registerConfig[2]*3600+registerConfig[3]*60
end
end

function xianguanModel:getWuXuanActivitySegmentData()
if _activityData then
return _activityData.segmentData
end
end

function xianguanModel:getWuXuanActivitySegment()
local segmentData=self:getWuXuanActivitySegmentData()
if segmentData then
return segmentData.status,segmentData.beginTime,segmentData.endTime
end
return XianGuanWuXuanSegment.eNone
end

function xianguanModel:setWuXuanRegisterData(groupList)
_registerData={}
for i,v in ipairs(groupList)do
local job=v.xianguan_id
local list=v.attend_list or{}
_registerData[job]=list
end
end

function xianguanModel:updateWuXuanRegisterData(job,attend_list)
_registerData[job]=attend_list or{}
end

function xianguanModel:getWuXuanRegisterData()
return _registerData
end

function xianguanModel:getWuXuanRegisterJobData(job)
local data=self:getWuXuanRegisterData()
if data then
return data[job]or{}
end
end

function xianguanModel:getWuXuanRegisterSingleData(job,index)
local data=self:getWuXuanRegisterJobData(job)
if data then
return data[index]
end
end

function xianguanModel:setWuXuanMatchData(groupList)
_matchData={}
for i,v in ipairs(groupList)do
local job=v.xianguan_id
local list={}
list[1]=v.match_16_list
list[2]=v.match_8_list
list[3]=v.match_4_list
list[4]=v.match_2_list
list[5]={v.match_info}
_matchData[job]=list


local registerPlayerList=self:getWuXuanRegisterJobData(job)
local registerPlayerLen=#registerPlayerList
if registerPlayerLen<=4 and registerPlayerLen>0 then
self:supplementWuXuanMatchData(list,5,1,1)

v.match_16_list=list[1]
v.match_8_list=list[2]
v.match_4_list=list[3]
v.match_2_list=list[4]
end
end
end

function xianguanModel:supplementWuXuanMatchData(list,index,group,side)

local mlist=list
local matchDataList=mlist[index]or{}
mlist[index]=matchDataList

local matchIndex=(group-1)*2+side
if matchDataList[matchIndex]==nil then
matchDataList[matchIndex]={
['actor2_idx']=0,
['win_actor_idx']=0,
['actor1_idx']=0,
['fight_log_id']="",
['will_fight']=false,
}
end
local matchData=matchDataList[matchIndex]

if index==1 then

if(matchData.actor1_idx==0 and matchData.actor2_idx~=0)or(matchData.actor1_idx~=0 and matchData.actor2_idx==0)then
matchData.win_actor_idx=matchData.actor1_idx==0 and matchData.actor2_idx or matchData.actor1_idx
end

return matchData
end

if matchData.win_actor_idx==0 then
local side1Data=self:supplementWuXuanMatchData(mlist,index-1,matchIndex,1)
local side2Data=self:supplementWuXuanMatchData(mlist,index-1,matchIndex,2)
if side1Data.actor1_idx~=nil and side1Data.actor2_idx~=0 then
side1Data.will_fight=true
end

if side2Data.actor1_idx~=nil and side2Data.actor2_idx~=0 then
side2Data.will_fight=true
end

if side1Data then
matchData.actor1_idx=side1Data.win_actor_idx
end

if side2Data then
matchData.actor2_idx=side2Data.win_actor_idx
end

if side2Data and side2Data.win_actor_idx~=0 and(matchData.actor1_idx==0 and not side1Data.will_fight)then
matchData.win_actor_idx=side2Data.win_actor_idx
end

if side1Data and side1Data.win_actor_idx~=0 and(matchData.actor2_idx==0 and not side2Data.will_fight)then
matchData.win_actor_idx=side1Data.win_actor_idx
end
end
return matchData
end

function xianguanModel:updateWuXuanMatchData(battleList)
if battleList then
for i,v in ipairs(battleList)do
local matchList=_matchData[v.xianguan_id]
matchList[v.group_type]=v.match_list

if#_roundSince>v.group_type then
local nextList=matchList[v.group_type+1]
if nextList==nil then
nextList={}
matchList[v.group_type+1]=nextList
end
local nextCount=#v.match_list/2
for j=1,nextCount do
local nextData=nextList[j]
if nextData==nil then
nextData={}
nextList[j]=nextData
end
if nextData.win_actor_idx==nil or nextData.win_actor_idx==0 then
local since=(j-1)*2
local actor1=v.match_list[since+1]
local actor2=v.match_list[since+2]
nextData.actor1_idx=actor1.win_actor_idx or 0
nextData.actor2_idx=actor2.win_actor_idx or 0
nextData.win_actor_idx=0
nextData.fight_log_id=""
end


local registerPlayerList=self:getWuXuanRegisterJobData(v.xianguan_id)
local registerPlayerLen=#registerPlayerList
if registerPlayerLen<=4 and registerPlayerLen>0 then
self:supplementWuXuanMatchData(matchList,5,1,1)

v.match_16_list=matchList[1]
v.match_8_list=matchList[2]
v.match_4_list=matchList[3]
v.match_2_list=matchList[4]
end
end
end
end
end
end

function xianguanModel:getWuXuanMatchData()
return _matchData
end

function xianguanModel:getWuXuanMatchJobData(job)
local data=self:getWuXuanMatchData()
if data then
return data[job]or{}
end
end

function xianguanModel:getWuXuanMatchRoundData(job,round)
local data=self:getWuXuanMatchJobData(job)
if data then
return data[round]
end
end

function xianguanModel:getWuXuanMatchSingleData(job,round,index)
local data=self:getWuXuanMatchRoundData(job,round)
if data then
return data[index]
end
end

function xianguanModel:initWuXuanPlayerData(job,declaration,disciples,free_flag,inspire_job,inspire_actor,last_share_time,registerStamp)
_playerData={}
_playerData.job=job
_playerData.declaration=declaration
_playerData.discipleList=disciples
_playerData.free_flag=free_flag
_playerData.inspire_job=inspire_job
_playerData.inspire_actor=inspire_actor




_playerData.registerStamp=registerStamp

xianguanModel:markWuXuanShareTime(last_share_time)
end

function xianguanModel:getWuXuanPlayerData()
return _playerData
end

function xianguanModel:getWuXuanPlayerJob()
local data=self:getWuXuanPlayerData()
if data then
return data.job
end
end

function xianguanModel:getWuXuanPlayerDeclaration()
local data=self:getWuXuanPlayerData()
if data then
return data.declaration
end
end

function xianguanModel:getWuXuanPlayerFreeFlag()
local data=self:getWuXuanPlayerData()
if data then
return data.free_flag
end
end

function xianguanModel:getWuXuanPlayerDiscipleList()
local data=self:getWuXuanPlayerData()
if data then
return data.discipleList
end
end

function xianguanModel:getWuXuanPlayerInspire()
local data=self:getWuXuanPlayerData()
if data then
return data.inspire_job,data.inspire_actor
end
end









function xianguanModel:checkWuXuanRegisterTime()
local data=self:getWuXuanPlayerData()
if data then
local nowTime=timeHelper.getServerShortTime()
local cd=cfgHelper.get2(cfg_officerelectionbasic2config_get,1,"cooldown_sec")
local least=nowTime-(_playerData.registerStamp+cd)
return least>=0,-least
end
return false
end

function xianguanModel:setWuXuanPlayerData1(job,declaration,disciples)
_playerData.job=job
_playerData.declaration=declaration
_playerData.discipleList=disciples
end

function xianguanModel:setWuXuanPlayerData2(declaration)
_playerData.declaration=declaration
end

function xianguanModel:setWuXuanPlayerData3(disciples)
_playerData.discipleList=disciples
end

function xianguanModel:setWuXuanPlayerData4(inspire_job,inspire_actor)
_playerData.inspire_job=inspire_job
_playerData.inspire_actor=inspire_actor
end

function xianguanModel:setWuXuanPlayerData5(free_flag)
_playerData.free_flag=free_flag
end

function xianguanModel:setWuXuanPlayerData6(registerStamp)
_playerData.registerStamp=registerStamp
end









function xianguanModel:getWuXuanReddot()
if not systemModel.isOpen(SYSTEM_DEFINE.eXianGongEnter)then return false end
local segment=xianguanModel:getWuXuanActivitySegment()
return self:getWuXuanSegmentFreeReward(segment)
end

function xianguanModel:getWuXuanSegmentFreeReward(segment)
if _playerData and _activityData and _activityData.thisWeek then
local config=cfgHelper.get1(cfg_officerelectionbasic2config_get,1)
local flag=mathHelper.getBitValue(_playerData.free_flag,segment)
if config.free_gift[segment]~=nil and not flag then
return true
end
end
return false
end

function xianguanModel:getWuXuanFreeReward()
if _playerData and _activityData and _activityData.thisWeek then
local config=cfgHelper.get1(cfg_officerelectionbasic2config_get,1)
local segmentData=_activityData.segmentData
for i,v in ipairs(config.free_gift)do
local flag=mathHelper.getBitValue(_playerData.free_flag,i)
if not flag and segmentData.status==i then
return true
end
end
end
return false
end

function xianguanModel:checkWuXuanShareTime(nowTime)
local nowTime=nowTime or timeHelper.getServerShortTime()
return nowTime>=(_shareTime or 0)
end

function xianguanModel:markWuXuanShareTime(time)
time=time or timeHelper.getServerShortTime()
_shareTime=time+cfgHelper.get2(cfg_officerelectionbasic2config_get,1,"ttchat_time")
end

function xianguanModel:getWuXuanShareLeftTime(nowTime)
local nowTime=nowTime or timeHelper.getServerShortTime()
return _shareTime-nowTime
end

function xianguanModel:clearWuXuanShareTime()
_shareTime=nil
end

function xianguanModel:checkWuXuanPlatformOpen()
return _pfOpen
end

function xianguanModel:checkWuXuanEnterOpen()
return systemModel.isOpen(SYSTEM_DEFINE.eXianGongEnter)and self:checkWuXuanPlatformOpen()
end

function xianguanModel:getCurRound_WuXuan()
local activityData=xianguanModel:getWuXuanActivityData()
local roundIdx=-1
local segmentData=activityData.segmentData
if segmentData then
local segment=segmentData.status
if segment==XianGuanWuXuanSegment.eReady or segment==XianGuanWuXuanSegment.eRegister then
roundIdx=0
elseif segment==XianGuanWuXuanSegment.eMatch then
roundIdx=0
local nowTime=timeHelper.getServerShortTime()
for i,v in ipairs(activityData.matchTime)do
if nowTime>v.beginTime and nowTime<v.endTime then
roundIdx=i
elseif nowTime>=v.endTime then
roundIdx=i+1
else
break
end
end
end
end
return roundIdx
end



function xianguanModel:isOpenPredict(job)
local players=xianguanModel:getWuXuanRegisterJobData(job)
local playerLen=#players
local match_conf=cfgHelper.get2(cfg_officerelectionbasic2config_get,1,"battle_conf")
local curRoundIdx=xianguanModel:getCurRound_WuXuan()

return playerLen<=4 or curRoundIdx==#match_conf or curRoundIdx==-1
end

function xianguanModel:getWuXuanFinalRegisterSingleData(job,index,sgroupIndex,matchSide)
local match_conf=cfgHelper.get2(cfg_officerelectionbasic2config_get,1,"battle_conf")
local curRoundIdx=xianguanModel:getCurRound_WuXuan()


if curRoundIdx==#match_conf or curRoundIdx==-1 then
return xianguanModel:getWuXuanRegisterSingleData(job,index)
end

local players=xianguanModel:getWuXuanRegisterJobData(job)
local playerLen=table.numsEx(players)
if playerLen>4 then
return
end
local group=(sgroupIndex-1)*2+matchSide

local playerData,index
local lastGroupLen=4
for groupIndex=1,lastGroupLen do
local matchIndex=(group-1)*lastGroupLen+groupIndex
local matchData=xianguanModel:getWuXuanMatchSingleData(job,1,matchIndex)

for side=1,2 do
local fieldName=FMT.fmt("actor{0}_idx",side)
local playerIndex=matchData and matchData[fieldName]or 0
local data=xianguanModel:getWuXuanRegisterSingleData(job,playerIndex)
if data~=nil then
playerData=data
index=playerIndex
break
end
end
end

return playerData,index
end
