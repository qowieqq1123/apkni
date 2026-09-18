





local _wenxuanData=nil
local _wenxuanActivityData=nil
local _wenXuanRefreshTime=nil
local _wenXuanSendRecordTimes=nil
local _wenXuanRecordRankChanges=nil
local _wenxuanRecordInterval=60
local _wenxuanRefreshInterval=10
local _pfOpen=false

function xianguanModel:onProtocalReqKF_WenXuan()
local cross=cfgHelper.get2(cfg_officerelectionbasic1config_get,1,"cross")
if cross then
local crossId=loginModel:getCrossServerId()or 0
local state=cross[crossId]
_pfOpen=state~=nil and state==1
else
_pfOpen=true
end
end

function xianguanModel:clearWenXuanData()
_wenxuanData=nil
_wenxuanActivityData=nil
_wenXuanRefreshTime=nil
_wenXuanSendRecordTimes=nil
_wenXuanRecordRankChanges=nil
end

function xianguanModel:checkInitWenXuanData()
return _wenxuanData~=nil and _wenxuanActivityData~=nil
end

function xianguanModel:setGetWenXuanRecordTime(officer_id,sec)
if not _wenXuanSendRecordTimes then
_wenXuanSendRecordTimes={}
end
_wenXuanSendRecordTimes[officer_id]=sec or timeHelper.getServerShortTime()
end

function xianguanModel:getIsSendWenXuanRecord(officer_id)
if not _wenXuanSendRecordTimes or not _wenXuanSendRecordTimes[officer_id]then
return true
end
local currTime=timeHelper.getServerShortTime()
return currTime>_wenXuanSendRecordTimes[officer_id]+_wenxuanRecordInterval
end

function xianguanModel:setGetWenXuanRefreshTime(sec)
_wenXuanRefreshTime=sec or timeHelper.getServerShortTime()
end

function xianguanModel:getIsSendWenXuanRefresh()
if not _wenXuanRefreshTime then
return true
end
local currTime=timeHelper.getServerShortTime()
local endTime=_wenXuanRefreshTime+_wenxuanRefreshInterval
return currTime>endTime,endTime-currTime
end

function xianguanModel:refreshWenXuanData()
if not _wenxuanActivityData then
return
end

local registerBTime=_wenxuanActivityData.registerBTime or 0
local open_sec=registerBTime
if open_sec==0 or not timeHelper.checkInSameWeek4(open_sec)then
local conf=cfgHelper.get1(cfg_officerelectionbasic1config_get,1)
local rest_week=conf.rest_week+1
local open_week=conf.open_week
local fairyland_after_open=conf.fairyland_after_open
if open_sec==0 then

local xianJieOpenTime=JiuChongTianJieEnterModel:getTianJieFirstFinishSec()
if xianJieOpenTime>0 then
local firstTime=xianJieOpenTime+fairyland_after_open*86400
local weekBTime=timeHelper.getWeekZeroTime(firstTime)
open_sec=weekBTime+(open_week-1)*86400

local curTime=timeHelper.getServerShortTime()
local curWeekBTime=timeHelper.getWeekZeroTime(curTime)
local curBeginTime=curWeekBTime+(open_week-1)*86400

if curBeginTime<firstTime then
curBeginTime=curBeginTime+7*86400
end

if open_sec<curBeginTime then
open_sec=curBeginTime
end
end
else
local thisWeek=timeHelper.checkInSameWeek4(open_sec)
if not thisWeek then

local weekBTime=timeHelper.getWeekZeroTime(open_sec)
open_sec=weekBTime+rest_week*7*86400+(open_week-1)*86400
end
end
_wenxuanData={}
_wenxuanData.free_bits=0
_wenxuanData.last_cooldown=0
_wenxuanData.attend_officer_id=0
_wenxuanData.use_vote_agree_num=0
_wenxuanData.use_vote_against_num=0
_wenxuanData.open_sec=open_sec
xianguanModel:markWenXuanShareTime(0)
end

if _wenxuanData then
xianguanModel:setWenXuanActivityTime(_wenxuanData.open_sec or 0)
end

UIManager:invokeUIMethod("UIXianGuanMainWin","refreshButton")
UIManager:invokeUIMethod("UIXianGuanCampaignMainWin","refreshAll",1)
end

function xianguanModel:setWenXuanData(args)
_wenxuanData={}
_wenxuanData.free_bits=args[1]
_wenxuanData.last_cooldown=args[2]
local open_sec=args[3]
_wenxuanData.attend_officer_id=args[4]
_wenxuanData.use_vote_agree_num=args[5]
_wenxuanData.use_vote_against_num=args[6]
xianguanModel:markWenXuanShareTime(args[7])

local conf=cfgHelper.get1(cfg_officerelectionbasic1config_get,1)
local rest_week=conf.rest_week+1
local open_week=conf.open_week
local fairyland_after_open=conf.fairyland_after_open
if open_sec==0 then

local xianJieOpenTime=JiuChongTianJieEnterModel:getTianJieFirstFinishSec()
if xianJieOpenTime>0 then
local firstTime=xianJieOpenTime+fairyland_after_open*86400
local weekBTime=timeHelper.getWeekZeroTime(firstTime)
open_sec=weekBTime+(open_week-1)*86400

local curTime=timeHelper.getServerShortTime()
local curWeekBTime=timeHelper.getWeekZeroTime(curTime)
local curBeginTime=curWeekBTime+(open_week-1)*86400

if curBeginTime<firstTime then
curBeginTime=curBeginTime+7*86400
end

if open_sec<curBeginTime then
open_sec=curBeginTime
end
end
else
local currTime=timeHelper.getServerShortTime()
local thisWeek=timeHelper.checkInSameWeek4(open_sec)
if not thisWeek and open_sec<currTime then

local weekBTime=timeHelper.getWeekZeroTime(open_sec)
open_sec=weekBTime+rest_week*7*86400+(open_week-1)*86400
end
end

_wenxuanData.open_sec=open_sec
self:setWenXuanActivityTime(_wenxuanData.open_sec)
self:setActivityTime_WenXuan_BW(args[3])
end

function xianguanModel:getWenXuanFirstWeekTime()
local conf=cfgHelper.get1(cfg_officerelectionbasic1config_get,1)
local xianJieOpenTime=JiuChongTianJieEnterModel:getTianJieFirstFinishSec()
if xianJieOpenTime>0 then
local open_week=conf.open_week
local fairyland_after_open=conf.fairyland_after_open
local weekDelta=(open_week-1)*86400
local firstTime=xianJieOpenTime+fairyland_after_open*86400
local firstZero=timeHelper.getWeekZeroTime(firstTime)
if(firstTime-firstZero)>weekDelta then
firstTime=firstTime+86400*7
end
return timeHelper.getWeekZeroTime(firstTime)
end
end

function xianguanModel:setWenXuanOfficerId(officer_id,last_cooldown)
if not _wenxuanData then
_wenxuanData={}
end
_wenxuanData.attend_officer_id=officer_id
_wenxuanData.last_cooldown=last_cooldown
end

function xianguanModel:setWenXuanDelOfficerId(last_cooldown)
if not _wenxuanData then
_wenxuanData={}
end
local officer_id=_wenxuanData.attend_officer_id

_wenxuanData.attend_officer_id=0
_wenxuanData.last_cooldown=last_cooldown

local selfActorId=playerModel:getActorID()
if self.wenxuanElectionRecordList and self.wenxuanElectionRecordList[officer_id]then
for i,v in ipairs(self.wenxuanElectionRecordList[officer_id])do
if mathHelper.compareInt64(selfActorId,v.actor_id)then
table.remove(self.wenxuanElectionRecordList[officer_id],i)
break
end
end
end

xianguanModel:setWenXuanElectionRecordRankLookup(officer_id)
end

function xianguanModel:setWenXuanFreeBits(free_bits)
if not _wenxuanData then
_wenxuanData={}
end
_wenxuanData.free_bits=free_bits
end

function xianguanModel:setWenXuanElectionRecordList(officer_id,record_len,electionRecordList)
if not self.wenxuanElectionRecordList then
self.wenxuanElectionRecordList={}
end

self.wenxuanElectionRecordList[officer_id]={}
if record_len>0 then
for i=1,record_len do
local record=electionRecordList[i]
record.weight1=record.agree_num-record.against_num
record.weight2=record.agree_num+record.against_num

table.insert(self.wenxuanElectionRecordList[officer_id],record)
end
end

xianguanModel:setWenXuanElectionRecordRankLookup(officer_id)
end

function xianguanModel:setWenXuanElectionRecordRankLookup(officer_id)
if _wenXuanRecordRankChanges and _wenXuanRecordRankChanges[officer_id]then
_wenXuanRecordRankChanges[officer_id]=nil
end
if not self.wenxuanElectionRecordRankLookup then
self.wenxuanElectionRecordRankLookup={}
end
if not self.wenxuanElectionRecordLookupByRank then
self.wenxuanElectionRecordLookupByRank={}
end

if not self.wenxuanElectionRecordList or not self.wenxuanElectionRecordList[officer_id]then
self.wenxuanElectionRecordRankLookup[officer_id]={}
self.wenxuanElectionRecordLookupByRank[officer_id]={}
return
end

table.sort(self.wenxuanElectionRecordList[officer_id],function(a,b)
if a.weight1==b.weight1 then
if a.weight2==b.weight2 then
return a.sec<b.sec
end
return a.weight2>b.weight2
end
return a.weight1>b.weight1
end)

self.wenxuanElectionRecordRankLookup[officer_id]={}
self.wenxuanElectionRecordLookupByRank[officer_id]={}
for i,v in ipairs(self.wenxuanElectionRecordList[officer_id])do
self.wenxuanElectionRecordRankLookup[officer_id][tostring(v.actor_id)]=i
table.insert(self.wenxuanElectionRecordLookupByRank[officer_id],tostring(v.actor_id))
end
end

function xianguanModel:setWenXuanDeclarationIdx(declaration_idx)
local officer_id=xianguanModel:getWenXuanPlayerJob()
if not self.wenxuanElectionRecordList or not self.wenxuanElectionRecordList[officer_id]then
return
end
local selfActorId=playerModel:getActorID()
for i,v in ipairs(self.wenxuanElectionRecordList[officer_id])do
local isSelf=mathHelper.compareInt64(selfActorId,v.actor_id)
if isSelf then
self.wenxuanElectionRecordList[officer_id][i].declaration_idx=declaration_idx
break
end
end
end

function xianguanModel:setWenXuanVote(actor_id,vote,free_num,item_num,args)
if vote==1 then
_wenxuanData.use_vote_agree_num=_wenxuanData.use_vote_agree_num+free_num
else
_wenxuanData.use_vote_against_num=_wenxuanData.use_vote_against_num+free_num
end

local officer_id=args.officerId
if not self.wenxuanElectionRecordList or not self.wenxuanElectionRecordList[officer_id]then
return
end
for i,v in ipairs(self.wenxuanElectionRecordList[officer_id])do
if mathHelper.compareInt64(actor_id,v.actor_id)then
local agree_num=v.agree_num
local against_num=v.against_num
if vote==1 then
agree_num=agree_num+free_num+item_num
else
against_num=against_num+free_num+item_num
end
self.wenxuanElectionRecordList[officer_id][i].agree_num=agree_num
self.wenxuanElectionRecordList[officer_id][i].against_num=against_num
self.wenxuanElectionRecordList[officer_id][i].weight1=agree_num-against_num
self.wenxuanElectionRecordList[officer_id][i].weight2=agree_num+against_num
break
end
end

if not _wenXuanRecordRankChanges then
_wenXuanRecordRankChanges={}
end
_wenXuanRecordRankChanges[officer_id]=true
end

function xianguanModel:getWenXuanData()
return _wenxuanData
end

function xianguanModel:getWenXuanPlayerJob()
if _wenxuanData then
return _wenxuanData.attend_officer_id or 0
end
return nil
end

function xianguanModel:getWenXuanLastCooldown()
if _wenxuanData then
return _wenxuanData.last_cooldown
end
return nil
end

function xianguanModel:getWenXuanRecordList(officer_id)
if _wenXuanRecordRankChanges and _wenXuanRecordRankChanges[officer_id]then
xianguanModel:setWenXuanElectionRecordRankLookup(officer_id)
end
if not self.wenxuanElectionRecordList then
return nil
end
return self.wenxuanElectionRecordList[officer_id]
end

function xianguanModel:getWenXuanRecordData(officer_id,rank)
if _wenXuanRecordRankChanges and _wenXuanRecordRankChanges[officer_id]then
xianguanModel:setWenXuanElectionRecordRankLookup(officer_id)
end
if not self.wenxuanElectionRecordList then
return nil
end
return self.wenxuanElectionRecordList[officer_id][rank]
end

function xianguanModel:getWenXuanElectionRecordRankList(officer_id)
if _wenXuanRecordRankChanges and _wenXuanRecordRankChanges[officer_id]then
xianguanModel:setWenXuanElectionRecordRankLookup(officer_id)
end
if not self.wenxuanElectionRecordRankLookup then
return{}
end
return self.wenxuanElectionRecordLookupByRank[officer_id]or{}
end

function xianguanModel:getWenXuanElectionRecordRankByActorId(officer_id,actorId)
if not self.wenxuanElectionRecordRankLookup or not self.wenxuanElectionRecordRankLookup[officer_id]then
return nil
end
return self.wenxuanElectionRecordRankLookup[officer_id][tostring(actorId)]or nil
end

function xianguanModel:getWenXuanFreeBits()
if not _wenxuanData then
return 0
end
return _wenxuanData.free_bits
end

function xianguanModel:getWenXuanReddot()
if not systemModel.isOpen(SYSTEM_DEFINE.eXianGongEnter)then return false end
return self:getWenXuanFreeReward()
end

function xianguanModel:getWenXuanFreeReward()
if _wenxuanData and _wenxuanActivityData and _wenxuanActivityData.thisWeek then
local free_gift=cfgHelper.get2(cfg_officerelectionbasic1config_get,1,"free_gift")
local segmentData=_wenxuanActivityData.segmentData
for i,v in ipairs(free_gift)do
local flag=mathHelper.getBitValue(_wenxuanData.free_bits,i)
if not flag and segmentData.status==i then
return true
end
end
end
return false
end



function xianguanModel:setWenXuanActivityTime(lastTime)
_wenxuanActivityData={}
_wenxuanActivityData.openTime=lastTime
_wenxuanActivityData.thisWeek=timeHelper.checkInSameWeek4(lastTime)
local conf=cfgHelper.get1(cfg_officerelectionbasic1config_get,1)
local open_week=conf.open_week
local stage_conf=conf.stage_conf
local rest_week=conf.rest_week+1


if _wenxuanActivityData.thisWeek then
local weekBTime=timeHelper.getWeekZeroTime(lastTime)
local beginTime=weekBTime+(open_week-1)*86400
local voteBTime=beginTime+stage_conf[1]
local endTime=voteBTime+stage_conf[2]

_wenxuanActivityData.weekBTime=weekBTime
_wenxuanActivityData.weekETime=weekBTime+86400*7

_wenxuanActivityData.registerBTime=beginTime
_wenxuanActivityData.registerETime=voteBTime

_wenxuanActivityData.voteBTime=voteBTime
_wenxuanActivityData.voteETime=endTime

_wenxuanActivityData.resultTime=endTime

self:refreshWenXuanActivitySegmentData()

limitActivitiesModel:addClientAct(LIMIT_ACT_TYPE.eXianGuanWenXuan,_wenxuanActivityData.registerBTime,_wenxuanActivityData.voteETime)
else
local beginTime
if lastTime==0 then

local xianJieOpenTime=JiuChongTianJieEnterModel:getTianJieFirstFinishSec()
if xianJieOpenTime>0 then
local fairyland_after_open=conf.fairyland_after_open
local firstTime=xianJieOpenTime+fairyland_after_open*86400
local weekBTime=timeHelper.getWeekZeroTime(firstTime)
beginTime=weekBTime+(open_week-1)*86400
end
else

local weekBTime=timeHelper.getWeekZeroTime(lastTime)
beginTime=weekBTime+rest_week*7*86400+(open_week-1)*86400
end
if beginTime~=nil then
local endTime=beginTime+stage_conf[1]+stage_conf[2]
limitActivitiesModel:addClientAct(LIMIT_ACT_TYPE.eXianGuanWenXuan,beginTime,endTime)
end
end


end

function xianguanModel:refreshWenXuanActivitySegmentData(nowTime)
nowTime=nowTime or timeHelper.getServerShortTime()
local segmentData=_wenxuanActivityData.segmentData or{}
if nowTime<_wenxuanActivityData.registerBTime then
segmentData.status=XianGuanWenXuanSegment.eNone
segmentData.beginTime=_wenxuanActivityData.weekBTime
segmentData.endTime=_wenxuanActivityData.registerBTime
elseif _wenxuanActivityData.registerBTime<=nowTime and nowTime<_wenxuanActivityData.registerETime then
segmentData.status=XianGuanWenXuanSegment.eRegister
segmentData.beginTime=_wenxuanActivityData.registerBTime
segmentData.endTime=_wenxuanActivityData.registerETime
elseif _wenxuanActivityData.voteBTime<=nowTime and nowTime<_wenxuanActivityData.voteETime then
segmentData.status=XianGuanWenXuanSegment.eVote
segmentData.beginTime=_wenxuanActivityData.voteBTime
segmentData.endTime=_wenxuanActivityData.voteETime
else
segmentData.status=XianGuanWenXuanSegment.eFinish
segmentData.beginTime=_wenxuanActivityData.voteETime
segmentData.endTime=_wenxuanActivityData.weekETime
end
_wenxuanActivityData.segmentData=segmentData
end

function xianguanModel:checkWenXuanActivityTime(nowTime)
if _wenxuanActivityData then
nowTime=nowTime or timeHelper.getServerShortTime()
return _wenxuanActivityData.thisWeek and _wenxuanActivityData.registerBTime<=nowTime and nowTime<_wenxuanActivityData.voteETime
end
return false
end
function xianguanModel:getWenXuanActivityData()
return _wenxuanActivityData
end

function xianguanModel:checkWenXuanWeek()
if self:checkWenXuanPlatformOpen()then
return _wenxuanActivityData and _wenxuanActivityData.thisWeek or false
end
return false
end

function xianguanModel:getWenXuanNextOpenTime()
local xianJieOpenTime=JiuChongTianJieEnterModel:getTianJieFirstFinishSec()
if xianJieOpenTime==0 or not _wenxuanData then
return nil
end
local nowTime=timeHelper.getServerShortTime()
if _wenxuanData.open_sec>nowTime then
return _wenxuanData.open_sec
else

local conf=cfgHelper.get1(cfg_officerelectionbasic1config_get,1)
local rest_week=conf.rest_week+1
local open_week=conf.open_week
local weekBTime=timeHelper.getWeekZeroTime(_wenxuanData.open_sec)
return weekBTime+rest_week*7*86400+(open_week-1)*86400
end
end

function xianguanModel:getWenXuanActivitySegmentData()
if _wenxuanActivityData then
return _wenxuanActivityData.segmentData
end
end

function xianguanModel:getWenXuanActivitySegment()
local segmentData=self:getWenXuanActivitySegmentData()
if segmentData then
return segmentData.status,segmentData.beginTime,segmentData.endTime
end
return XianGuanWenXuanSegment.eNone
end

function xianguanModel:checkWenXuanPlatformOpen()
return _pfOpen
end

function xianguanModel:checkWenXuanEnterOpen()
return systemModel.isOpen(SYSTEM_DEFINE.eXianGongEnter)and self:checkWenXuanPlatformOpen()
end

function xianguanModel:checkWenXuanShareTime(nowTime)
if not _wenxuanData then
return false
end
local nowTime=nowTime or timeHelper.getServerShortTime()
return nowTime>=(_wenxuanData.chat_sec or 0)
end

function xianguanModel:getWenXuanShareLeftTime(nowTime)
if not _wenxuanData then
return 0
end
local nowTime=nowTime or timeHelper.getServerShortTime()
return _wenxuanData.chat_sec-nowTime
end

function xianguanModel:markWenXuanShareTime(chat_sec)
_wenxuanData.chat_sec=chat_sec+cfgHelper.get2(cfg_officerelectionbasic1config_get,1,"ttchat_time")
end
