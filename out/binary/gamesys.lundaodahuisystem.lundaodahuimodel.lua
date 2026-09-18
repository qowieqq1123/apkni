






local _MODULENAME="lundaodahuiModel"




def_table(_MODULENAME)
lundaodahuiModel.name=_MODULENAME
lundaodahuiModel.data={}

eLDMatchType=
{
xuanBa=1,
top32=2,
top16=3,
top8=4,
banjuesai=5,
jijunsai=6,
juesai=7,
}

local fightMatchType=
{
[1]=eLDMatchType.top32,[2]=eLDMatchType.top32,[3]=eLDMatchType.top32,[4]=eLDMatchType.top32,
[9]=eLDMatchType.top32,[10]=eLDMatchType.top32,[11]=eLDMatchType.top32,[12]=eLDMatchType.top32,
[17]=eLDMatchType.top32,[18]=eLDMatchType.top32,[19]=eLDMatchType.top32,[20]=eLDMatchType.top32,
[25]=eLDMatchType.top32,[26]=eLDMatchType.top32,[27]=eLDMatchType.top32,[28]=eLDMatchType.top32,
[5]=eLDMatchType.top16,[6]=eLDMatchType.top16,[13]=eLDMatchType.top16,[14]=eLDMatchType.top16,
[21]=eLDMatchType.top16,[22]=eLDMatchType.top16,[29]=eLDMatchType.top16,[30]=eLDMatchType.top16,
[7]=eLDMatchType.top8,[15]=eLDMatchType.top8,[23]=eLDMatchType.top8,[31]=eLDMatchType.top8,
[8]=eLDMatchType.banjuesai,[16]=eLDMatchType.banjuesai,[24]=eLDMatchType.jijunsai,[32]=eLDMatchType.juesai,
}


local groupyingshe=
{
[5]={1,2},
[6]={3,4},
[7]={5,6},
[13]={9,10},
[14]={11,12},
[15]={13,14},
[21]={17,18},
[22]={19,20},
[23]={21,22},
[29]={25,26},
[30]={27,28},
[31]={29,30},
}



function lundaodahuiModel:onAppStart()

end


function lundaodahuiModel:onEnterState(isReconnect)
self.data.lookData={}
self.guessMsgList={}
self.guessMsgTimeList={}
self.data.jingCaiInfoStamp={}
self.data.jingCaiInfo={}
end


function lundaodahuiModel:onLeaveState(isReconnect)

self.data={}
self.data.jingCaiInfoStamp={}
self.data.jingCaiInfo={}
end

function lundaodahuiModel:onProtocolReq()

end


function lundaodahuiModel:setCurLookData(playerId,lookData)
self.data.lookData[tostring(playerId)]=lookData
end

function lundaodahuiModel:getCurLookData(playerId)
return self.data.lookData[tostring(playerId)]
end

function lundaodahuiModel:getFightMatchType(fightId)
return fightMatchType[fightId]
end

function lundaodahuiModel:getXiaoZuFight()
return{{1,2,3,4,5,6,7},{9,10,11,12,13,14,15},{17,18,19,20,21,22,23},{25,26,27,28,29,30,31},}
end
function lundaodahuiModel:getTop16Fight()
return{1,2,3,4,9,10,11,12,17,18,19,20,25,26,27,28}
end
function lundaodahuiModel:getTop8Fight()
return{5,6,13,14,21,22,29,30}
end
function lundaodahuiModel:getTop4Fight()
return{7,15,23,31}
end
function lundaodahuiModel:getBanJueSaiFight()
return{8,16}
end
function lundaodahuiModel:getJueSaiFight()
return{24,32}
end

function lundaodahuiModel:getFightIdByConfigId(id)
if id==2 then
return lundaodahuiModel:getTop16Fight()
elseif id==3 then
return lundaodahuiModel:getTop8Fight()
elseif id==4 then
return lundaodahuiModel:getTop4Fight()
elseif id==5 then
return lundaodahuiModel:getBanJueSaiFight()
elseif id==6 then
return{24}
elseif id==7 then
return{32}
end
end


function lundaodahuiModel:getDouFaTaiCount(nowTime)
local config=douFaTaiModel:getDouFaTaiBasicConfig()
local open_time=douFaTaiModel:get_doufatai_openTime()
local durationDays=config.duration_days
if open_time then
local stamp=timeHelper.timeServer(open_time[1],open_time[2],open_time[3],open_time[4],open_time[5],0)
local daystamp=timeHelper.timeServer(open_time[1],open_time[2],open_time[3],0,0,0)
if not nowTime then
nowTime=timeHelper.getServerLongTime()
end
if nowTime<stamp then
return
end
local durationZero=86400*durationDays
local deltaTime=(24-config.time)*3600
local truceDurationTime=config.xzTime
local doufataiOnceTime=durationZero+truceDurationTime-deltaTime
local lundaodahuiTime=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1,"actTime")
local addCount=0
if(nowTime-daystamp)%doufataiOnceTime>lundaodahuiTime then
addCount=1
end
return math.floor((nowTime-daystamp)/doufataiOnceTime)+addCount
end
end


function lundaodahuiModel:getDouFaTaiSettleTime(nowTime,last)
local config=douFaTaiModel:getDouFaTaiBasicConfig()
local open_time=douFaTaiModel:get_doufatai_openTime()
local durationDays=config.duration_days
if open_time then
local stamp=timeHelper.timeServer(open_time[1],open_time[2],open_time[3],open_time[4],open_time[5],0)
if not nowTime then
nowTime=timeHelper.getServerLongTime()
end
if nowTime<stamp then

return
end
local daystamp=timeHelper.timeServer(open_time[1],open_time[2],open_time[3],0,0,0)
local truceDurationTime=config.xzTime
local duration=86400*(durationDays-1)+config.time*3600
local durationZero=86400*durationDays
local deltaTime=(24-config.time)*3600
local doufataiOnceTime=durationZero+truceDurationTime-deltaTime
local count=math.floor((nowTime-daystamp)/doufataiOnceTime)
local addCount=0
if(nowTime-daystamp)%doufataiOnceTime>=duration then
addCount=1
end
if last then
if count-1<0 then
return
end
return((count-1)*doufataiOnceTime)+stamp+duration,count-1
end
return(count*doufataiOnceTime)+stamp+duration,count
end
end

function lundaodahuiModel:getLundaodahuiOpenDayZeroTime(notCheckOpen)


if self.data.startTime and self.data.startTime~=0 then

if not notCheckOpen then
local rCLimit=self:getRCLimit()
if self.data.startTime>=rCLimit and not lundaodahuiModel:checkLocalOpenDay()then
return 0
end
end

return self.data.startTime
end
end

function lundaodahuiModel:getLundaodahuiOpenDayRealZeroTime(notCheckOpen)

if self.data.startTime and self.data.startTime~=0 then
if not notCheckOpen then
local rCLimit=self:getRCLimit()
if self.data.startTime>=rCLimit and not lundaodahuiModel:checkLocalOpenDay()then
return 0
end
end
return timeHelper.getServerZeroStamp(self.data.startTime)
end
end


function lundaodahuiModel:getRCLimit()
local RCLimit=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1,"rcLimit")
return timeHelper.timeServer(RCLimit[1],RCLimit[2],RCLimit[3],RCLimit[4],RCLimit[5],RCLimit[6])
end

function lundaodahuiModel:getBuildingData()
if not self.bdData then
self.bdData=zongmenModel:findBuildingDataByID(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eDouFaTai)
end
return self.bdData
end

function lundaodahuiModel:checkUnlockEx(warning)
local check,ctype,txt,cd=self:checkUnlock()
if not check and warning then
if ctype==1 then
UIManager.error(FMT.fmt(txt,timeHelper.formatSimpleTime(cd,true)))
else
UIManager.error(txt)
end
end
return check
end

function lundaodahuiModel:checkUnlock(noBDCheck)
if(not self.data.startTime)then
return false,0,''
end




if not noBDCheck then
local bdData=self:getBuildingData()
if not bdData or(bdData.level==1 and bdData.flag~=0)then
return false,0,'请先修复斗法台'
end
end

if not systemModel.isOpen(SYSTEM_DEFINE.eBuildOpenDouFaTai)then
return false,0,'系统未开启'
end


local result=lundaodahuiModel:isOpened()
if not result then
local open_time=lundaodahuiModel:getLunDaoDaHuiTime()
local t=timeHelper.getServerLongTime()
if open_time and open_time-t>0 then
return false,1,'{0}后可参与',open_time-timeHelper.getServerLongTime()

end
end




if not lundaodahuiModel:checkLocalOpenDay()then
local rCLimit=self:getRCLimit()

if self.data.startTime>=rCLimit then
local config=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1)
local kfDays=config.kfDays
return false,1,'{0}后可参与',timeHelper.getServerOpenZeroLeftTime(kfDays)
else
local now=timeHelper.getServerLongTime()
local lundaodahuiTime=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1,"actTime")
if now>=self.data.startTime+lundaodahuiTime then
local config=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1)
local kfDays=config.kfDays
return false,1,'{0}后可参与',timeHelper.getServerOpenZeroLeftTime(kfDays)
end
end
end

return true
end



function lundaodahuiModel:checkXuanBaSaiState()
local openDayZeroTime=self:getLundaodahuiOpenDayRealZeroTime()
local bsTimeConf=cfgHelper.get(cfg_dftlundaodahuibisaiconfig_get,1,"bsTime")
local bsTime=bsTimeConf[2]
local nowTime=timeHelper.getServerLongTime()
local firstTime=openDayZeroTime+(bsTimeConf[1]-1)*86400+bsTime[1][1]*3600+bsTime[1][2]*60
local last=#bsTime
local lastTime=openDayZeroTime+(bsTimeConf[1]-1)*86400+bsTime[last][1]*3600+bsTime[last][2]*60
if nowTime<firstTime then
return 1,firstTime
elseif nowTime>=firstTime and nowTime<lastTime then
return 2,lastTime
elseif nowTime>=lastTime then
return 3
end
return 3
end


function lundaodahuiModel:checkShowXuanBaSaiCredentialsByRank(rank)

local isLDOpenDay=lundaodahuiModel:checkOpenDay()
if not isLDOpenDay then

return false
end

local isTruce=douFaTaiModel:checkIsTruce()
if isTruce then

if self.data.credentialsList_lookup then
if self.data.credentialsList_lookup[rank]then
return true
else
return false
end
else

lundaodahuiController.req_17_35()
end
end
local showCredentialsCount=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1,"showCredentialsCount")
if showCredentialsCount and rank<=showCredentialsCount then

return true
end

return false
end


function lundaodahuiModel:setCredentialsList(len,credentialsList)
self.data.credentialsList=credentialsList
self.data.credentialsList_lookup={}
if len>0 then

table.sort(self.data.credentialsList,function(a,b)
return a.dftRank<b.dftRank
end)


for i,v in ipairs(credentialsList)do
local rank=v.dftRank
self.data.credentialsList_lookup[rank]=v
end
end


local delayTime=2
self.setReqCredentialsFlagTimer=timer.new()
self.setReqCredentialsFlagTimer:start(delayTime,function()
lundaodahuiModel:setIsReqCredentialsList(nil)
end,1)
end


function lundaodahuiModel:setIsReqCredentialsList(flag)
self.data.isReqCredentialsList=flag
end


function lundaodahuiModel:getIsReqCredentialsList()
if self.data.isReqCredentialsList~=nil then
return self.data.isReqCredentialsList
end
return false
end


function lundaodahuiModel:getCredentialsList()
if self.data.credentialsList then
return self.data.credentialsList
elseif not self.data.isReqCredentialsList then

lundaodahuiController.req_17_35()
self.data.isReqCredentialsList=true
end
end

function lundaodahuiModel:checkLunDaoDaHuiEntry(notCheckOpen)
if(not notCheckOpen)and not lundaodahuiModel:checkOpenDay()then
return false
end
local now=timeHelper.getServerLongTime()
local openDayZeroTime=self:getLundaodahuiOpenDayZeroTime(notCheckOpen)

if openDayZeroTime then
local entryTime=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1,"actTime")
local endTime=openDayZeroTime+entryTime
return now>=openDayZeroTime and now<endTime
end
end

function lundaodahuiModel:getLunDaoDaHuiTime(isShort)
local now=timeHelper.getServerLongTime()
local openDayZeroTime=self:getLundaodahuiOpenDayZeroTime()
if openDayZeroTime then
local entryTime=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1,"actTime")
local endTime=openDayZeroTime+entryTime
if endTime<now then
local config=douFaTaiModel:getDouFaTaiBasicConfig()
local durationDays=config.duration_days
local truceTime=config.xzTime
openDayZeroTime=openDayZeroTime+durationDays*86400
endTime=openDayZeroTime+entryTime+truceTime
end
if isShort then
return timeHelper.convertShortStamp(openDayZeroTime),timeHelper.convertShortStamp(endTime)
else
return openDayZeroTime,endTime
end
end
end

function lundaodahuiModel:checkLunDaoDaHuiEntryOpen()
local now=timeHelper.getServerLongTime()
local openDayZeroTime=self:getLundaodahuiOpenDayZeroTime()
if openDayZeroTime then
if openDayZeroTime<now then
local config=douFaTaiModel:getDouFaTaiBasicConfig()
local durationDays=config.duration_days
local truceTime=config.xzTime
return now==openDayZeroTime+durationDays*86400+truceTime
else
return now==openDayZeroTime
end
end
end

function lundaodahuiModel:checkRongYuTangEntry()
if not lundaodahuiModel:checkOpenDay()then
return false
end
local now=timeHelper.getServerLongTime()
local openDayZeroTime=self:getLundaodahuiOpenDayZeroTime()
if openDayZeroTime then
local cfg=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1)
local endTime=openDayZeroTime+cfg.entryRYTOpenTime+cfg.entryRYTTime
return now>=openDayZeroTime+cfg.entryRYTOpenTime and now<endTime
end
end

function lundaodahuiModel:initMatchTime()
self.data.matchTimeList={}
local openDayZeroTime=self:getLundaodahuiOpenDayRealZeroTime()
if openDayZeroTime then
local cfg=cfg_dftlundaodahuibisaiconfig()
for i,v in ipairs(cfg)do
local bsTime=v.bsTime
if type(bsTime[2])=="table"then
self.data.matchTimeList[i]={}
for _,vv in ipairs(bsTime[2])do
table.insert(self.data.matchTimeList[i],openDayZeroTime+(bsTime[1]-1)*86400+vv[1]*3600+vv[2]*60)
end
else
self.data.matchTimeList[i]={openDayZeroTime+(bsTime[1]-1)*86400+bsTime[2]*3600+bsTime[3]*60}
end
end
end
end

function lundaodahuiModel:checkMatchTime()
if not self.data.matchTimeList then
return
end
local nowTime=timeHelper.getServerLongTime()
for i,v in ipairs(self.data.matchTimeList)do
for ii,vv in ipairs(v)do
if nowTime==vv then
return i,ii
end
end
end
end


function lundaodahuiModel:checkMatchTimeBefore15Min()
if not self.data.matchTimeList then
return
end
local nowTime=timeHelper.getServerLongTime()
local min15=60*15
for i,v in ipairs(self.data.matchTimeList)do
for ii,vv in ipairs(v)do
if vv-nowTime<=min15 and vv-nowTime>0 then
return i,ii
end
end
end
end

function lundaodahuiModel:getMatchTimeList()
return self.data.matchTimeList
end


function lundaodahuiModel:isPlayerInMatchMatchType()
local matchType=lundaodahuiModel:getCurMatchType()
local playerId=playerModel:getActorID()
if matchType then
if matchType==eLDMatchType.xuanBa then
return lundaodahuiModel:getPlayerGroup()~=0
elseif matchType==eLDMatchType.banjuesai then
local matchs=lundaodahuiModel:getBanJueSaiFight()
for i,v in ipairs(matchs)do
if lundaodahuiModel:isPlayerInMatch(playerId,v)then
return true
end
end
elseif matchType==eLDMatchType.jijunsai then
return lundaodahuiModel:isPlayerInMatch(playerId,24)
elseif matchType==eLDMatchType.juesai then
return lundaodahuiModel:isPlayerInMatch(playerId,32)
elseif matchType==eLDMatchType.top32 then
local matchs=lundaodahuiModel:getTop16Fight()
for i,v in ipairs(matchs)do
if lundaodahuiModel:isPlayerInMatch(playerId,v)then
return true
end
end
elseif matchType==eLDMatchType.top16 then
local matchs=lundaodahuiModel:getTop8Fight()
for i,v in ipairs(matchs)do
if lundaodahuiModel:isPlayerInMatch(playerId,v)then
return true
end
end
elseif matchType==eLDMatchType.top8 then
local matchs=lundaodahuiModel:getTop4Fight()
for i,v in ipairs(matchs)do
if lundaodahuiModel:isPlayerInMatch(playerId,v)then
return true
end
end
end
end
end

function lundaodahuiModel:checkPlayerInMatchMatchTypeAndGetParams()
local matchType=lundaodahuiModel:getCurMatchType()
local playerId=playerModel:getActorID()
if matchType then
if matchType==eLDMatchType.xuanBa then
return lundaodahuiModel:getPlayerGroup()~=0,matchType
elseif matchType==eLDMatchType.banjuesai then
local matchs=lundaodahuiModel:getBanJueSaiFight()
for i,v in ipairs(matchs)do
if lundaodahuiModel:isPlayerInMatch(playerId,v)then
return true,matchType,v
end
end
elseif matchType==eLDMatchType.jijunsai then
if lundaodahuiModel:isPlayerInMatch(playerId,24)then
return true,matchType,24
end
elseif matchType==eLDMatchType.juesai then
if lundaodahuiModel:isPlayerInMatch(playerId,32)then
return true,matchType,32
end
elseif matchType==eLDMatchType.top32 then
local matchs=lundaodahuiModel:getTop16Fight()
for i,v in ipairs(matchs)do
if lundaodahuiModel:isPlayerInMatch(playerId,v)then
return true,matchType,v
end
end
elseif matchType==eLDMatchType.top16 then
local matchs=lundaodahuiModel:getTop8Fight()
for i,v in ipairs(matchs)do
if lundaodahuiModel:isPlayerInMatch(playerId,v)then
return true,matchType,v
end
end
elseif matchType==eLDMatchType.top8 then
local matchs=lundaodahuiModel:getTop4Fight()
for i,v in ipairs(matchs)do
if lundaodahuiModel:isPlayerInMatch(playerId,v)then
return true,matchType,v
end
end
end
end
end

function lundaodahuiModel:isPlayerInMatch(playerId,fightId)
local dzInfo=lundaodahuiModel:getTTSGroupInfo(fightId)
local dzPlayer1,dzPlayer2
if dzInfo and dzInfo.dzPalyerList then
for i,v in ipairs(dzInfo.dzPalyerList)do
if playerId==v.playerId then
return true
end
end
end
end


function lundaodahuiModel:checkJueSaiMatchTime()
local match1=self:getMatchTime(eLDMatchType.jijunsai)

local match2=self:getMatchTime(eLDMatchType.juesai)

local nowTime=timeHelper.getServerLongTime()
return(match1 and nowTime==match1-600)or(match2 and nowTime==match2-600)or(match1 and nowTime==match1+5)or(match2 and nowTime==match2+5)
end

function lundaodahuiModel:checkJueSaiAfterMatchTime(matchType,getTime)
local match=self:getMatchTime(matchType)

local nowTime=timeHelper.getServerLongTime()
local guanjunDelay=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1,"guanjunDelay")

if not getTime then
return(match and nowTime<match+guanjunDelay and nowTime>=match)
else
if match then
return nowTime<match+guanjunDelay and nowTime>=match,match+guanjunDelay-nowTime
else
return false,0
end
end
end

function lundaodahuiModel:checkJueSaiTongJi()
local watchTimes=lundaodahuiModel:getWatchJueSaiTimes(eLDMatchType.jijunsai)
local hideResult=lundaodahuiModel:checkJueSaiAfterMatchTime(eLDMatchType.jijunsai)
if hideResult then
return true
end

watchTimes=lundaodahuiModel:getWatchJueSaiTimes(eLDMatchType.juesai)
hideResult=lundaodahuiModel:checkJueSaiAfterMatchTime(eLDMatchType.juesai)
if hideResult then
return true
end
end

function lundaodahuiModel:getWatchJueSaiTimes(matchType)
local watchJueSaiTimes=userActorArraySetting.get(ACTOR_SETTING_TYPE.eLunDaoDaHui,'watchJueSaiTimes1',{})
local jieShu=self:getJieShu()
local jieShuStr=tostring(jieShu)
local matchTypeStr=tostring(matchType)
if watchJueSaiTimes[jieShuStr]then
return watchJueSaiTimes[jieShuStr][matchTypeStr]or 0
else
return 0
end
end



function lundaodahuiModel:addWatchJueSaiTimes(matchType,save)
local watchJueSaiTimes=userActorArraySetting.get(ACTOR_SETTING_TYPE.eLunDaoDaHui,'watchJueSaiTimes1',{})
local jieShu=self:getJieShu()
if not jieShu then return end
local jieShuStr=tostring(jieShu)
if not watchJueSaiTimes[jieShuStr]then watchJueSaiTimes[jieShuStr]={}end
local matchTypeStr=tostring(matchType)
watchJueSaiTimes[jieShuStr][matchTypeStr]=(watchJueSaiTimes[jieShuStr][matchTypeStr]or 0)+1
userActorArraySetting.set(ACTOR_SETTING_TYPE.eLunDaoDaHui,'watchJueSaiTimes1',watchJueSaiTimes)
if save then
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eLunDaoDaHui)
end
end

function lundaodahuiModel:isShowGuanJunWin()
return self.data.guanJunWin
end

function lundaodahuiModel:setShowGuanJunWinFlag(flag)
self.data.guanJunWin=flag
end

function lundaodahuiModel:getMatchTime(matchType,xunbasaiIndex)
local data=self.data.matchTimeList
if data then
xunbasaiIndex=xunbasaiIndex or 1
return data[matchType]and data[matchType][xunbasaiIndex]
end
end


function lundaodahuiModel:getCurMatchType()
local openDayZeroTime=self:getLundaodahuiOpenDayZeroTime()
if not openDayZeroTime then
return
end
local nowTime=timeHelper.getServerLongTime()
if nowTime<openDayZeroTime then
return
end

local matchType
if self.data.matchTimeList then
for i,v in pairs(self.data.matchTimeList)do
for ii,vv in ipairs(v)do
if nowTime<vv then
matchType=i
return matchType
end
end
end
end
return matchType
end


function lundaodahuiModel:initMyData(jieShu,myRank,myRank2,startTime)
self.data.jieShu=jieShu
self.data.myRank=myRank
self.data.myRank2=myRank2
self.data.startTime=startTime
end

function lundaodahuiModel:initStartTimeData(startTime)
self.data.startTime=startTime
end

function lundaodahuiModel:initJieShuData(jieshu)
self.data.jieShu=jieshu
end

function lundaodahuiModel:checkOpenDay()
local config=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1)
local kfDays=config.kfDays
local cur=timeHelper.getServerLongTime()
local openTime=gameUtilityModel.getOpenServerLongTime_kf()
return math.ceil((cur-openTime)/86400)>=kfDays

end

function lundaodahuiModel:checkLocalOpenDay()
local config=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1)
local kfDays=config.kfDays
return timeHelper.getServerOpenDay()>=kfDays
end


function lundaodahuiModel:isOpened()
if self.data.isLunDaoEntryOpened then
return true
end



if not lundaodahuiModel:checkOpenDay()then
return false
end





local startTime=self:getLundaodahuiOpenDayZeroTime()
if startTime and startTime~=0 then

local time=timeHelper.getServerLongTime()
if time>=startTime then
self.data.isLunDaoEntryOpened=true
return true
end
end

local open_time=douFaTaiModel:get_doufatai_openTime()
if open_time then
local settle=douFaTaiModel:get_first_settle_time()
local nowTime=timeHelper.getServerLongTime()
local entryTime=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1,"actTime")
if nowTime>=settle+entryTime then
self.data.isLunDaoEntryOpened=true
return true
else
return false
end
end
return false
end

function lundaodahuiModel:get_first_open_time()
local open_time=douFaTaiModel:get_doufatai_openTime()
if open_time then
local config=douFaTaiModel:getDouFaTaiBasicConfig()

local openStamp=timeHelper.timeServer(open_time[1],open_time[2],open_time[3],open_time[4],open_time[5],0)
local durationDays=config.duration_days
local doufataiEndHour=config.time
local duration=86400*(durationDays-1)+doufataiEndHour*3600
local settle=openStamp+duration
local w=timeHelper.getWeakDateEx2(settle)
if w>0 and w<6 then
settle=settle+(6-w)*86400
elseif w==0 then
settle=settle+6*86400
end

local entryTime=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1,"actTime")

return settle+entryTime
end
end


function lundaodahuiModel:getMyRank()
return self.data.myRank
end


function lundaodahuiModel:getMyRank2()
return self.data.myRank2
end

function lundaodahuiModel:getJieShu()
if not self.data.jieShu then

return self:getDouFaTaiCount()
end
return self.data.jieShu
end


function lundaodahuiModel:setOldOpenPanelIndex(main,sub)
self.data.oldOpenPanelIndex={main,sub}
end


function lundaodahuiModel:getOldOpenPanelIndex()
local oldOpenPanelIndex=self.data.oldOpenPanelIndex
self.data.oldOpenPanelIndex=nil
return oldOpenPanelIndex
end

function lundaodahuiModel:setJcbNum(jcbNum)
self.data.jcbNum=jcbNum
end

function lundaodahuiModel:getJcbNum()
return self.data.jcbNum or 0
end



























function lundaodahuiModel:initXBSData(xbsList,myGroup)
self.data.xbsList={}
if xbsList then
local list={}
for i,v in pairs(xbsList)do
list[v.groupId]=v
end
self.data.xbsList=list
end
self:initXBSRankDataByXBSData(myGroup)
end


function lundaodahuiModel:initXBSRankDataByXBSData(myGroup)
local list={}
local playerGroupId=myGroup
local sId=playerModel:getActorServerID()
local playerId=tostring(playerModel:getActorID())
for groupId,v in pairs(self.data.xbsList)do
list[groupId]={}
if v.dzList then
for i,v2 in ipairs(v.dzList)do
if v2.dzPalyerList then
for _,v3 in ipairs(v2.dzPalyerList)do
table.insert(list[groupId],v3)
if not playerGroupId then
if v3.serverId==sId and tostring(v3.playerId)==playerId then
playerGroupId=groupId
end
end
end
end
end
end
if next(list[groupId])then
table.sort(list[groupId],function(a,b)return a.rank<b.rank end)
end
end
self.data.playerGroupId=playerGroupId
self.data.xbsMainPlayerList=list
end
function lundaodahuiModel:getXBSMainRankData(groupId)
self.data.xbsMainPlayerList=self.data.xbsMainPlayerList or{}
return self.data.xbsMainPlayerList[groupId]
end

function lundaodahuiModel:getPlayerGroup()
return self.data.playerGroupId
end

function lundaodahuiModel:setXBSGroupInfo(groupId,groupInfo)
self.data.xbsList[groupId]=groupInfo
end

function lundaodahuiModel:getXBSGroupInfo(groupId)
return self.data.xbsList[groupId]
end

function lundaodahuiModel:setMyTeam(teamList)
self.data.teamList=teamList
end

function lundaodahuiModel:getMyTeam()
return self.data.teamList
end

function lundaodahuiModel:isInTeam(guid)
local teamList=lundaodahuiModel:getMyTeam()or{}
if next(teamList)then
for i,v in ipairs(teamList)do







if v.unitId==guid then
return true
end
end
end
return false
end

function lundaodahuiModel:setXBSRankData(groupId,playerList)
self.data.xbsRankList=self.data.xbsRankList or{}

self.data.xbsRankList[groupId]=playerList
end

function lundaodahuiModel:getXBSRankData(groupId)
self.data.xbsRankList=self.data.xbsRankList or{}
return self.data.xbsRankList[groupId]
end

function lundaodahuiModel:getXBSGroupFilterGroup(groupNum)
local xbsList=self.data.xbsList
if xbsList then
local group={}
if groupNum then
local list={}
local index=0
for i,v in pairs(xbsList)do
index=index+1

if index%groupNum==1 then
if index~=1 then
table.insert(group,list)
end
list={}
end
table.insert(list,v)
end
if index%groupNum~=1 then
table.insert(group,list)
end
return group
else
return xbsList
end
end
return{}
end

function lundaodahuiModel:getRankDataByGroup(groupData)
if not groupData then
return
end
local rankData=self:getXBSRankData(groupData.groupId)
if not rankData then
return
end
return rankData
end


function lundaodahuiModel:initTTSGroupInfo(ttsList)




self.data.ttsFightIdList={}

if ttsList then
for i,v in pairs(ttsList)do

if v.dzList then
for i2,v2 in ipairs(v.dzList)do
self.data.ttsFightIdList[v2.fightId]=v2
end
end
end
end
end

function lundaodahuiModel:clearTTSGroupInfo()
self.data.ttsFightIdList={}
end


function lundaodahuiModel:getTTSGroupInfo(fightId)
return self.data.ttsFightIdList and self.data.ttsFightIdList[fightId]
end

function lundaodahuiModel:getTTSFightInfoByFightId(fightId)
return lundaodahuiModel:getTTSGroupInfo(fightId)
end

function lundaodahuiModel:setTTSGroupInfo(fightId,GroupInfo)
if self.data.ttsFightIdList then
self.data.ttsFightIdList[fightId]=GroupInfo
end
end

function lundaodahuiModel:addGuessMsg(guessMsg)
self.guessMsgTimeList=self.guessMsgTimeList or{}
if self.guessMsgTimeList[guessMsg.jcTime]then
return false
end
self.guessMsgTimeList[guessMsg.jcTime]=guessMsg

self.guessMsgList=self.guessMsgList or{}
if#self.guessMsgList>=10 then
table.remove(self.guessMsgList,1)
end
local mesg=FMT.fmt("<color=#7d3b17>{0}</color>参与竞猜，支持<color=#ca631d>{1}</color>",guessMsg.name1,guessMsg.name2)
local chatInfo=chatStruct.create(false,guessMsg.jcTime,CHAT_CHANNNEL.eKuafu,CHAT_MESSAGE_TYPE.ePublic,mesg,{actorName="<color=#c82c2c>[系统]</color>",name1=guessMsg.name1,name2=guessMsg.name2,fightId=guessMsg.stepId,jcTime=guessMsg.jcTime},-1,-100)
table.insert(self.guessMsgList,chatInfo)

return chatInfo
end

function lundaodahuiModel:getGuessMsgList()
self.guessMsgList=self.guessMsgList or{}
return self.guessMsgList
end

function lundaodahuiModel:getVictoryMsg()
local nowTime=timeHelper.getServerLongTime()
local jijunMatchTime=lundaodahuiModel:getMatchTime(eLDMatchType.jijunsai)
local juesaiMatchTime=lundaodahuiModel:getMatchTime(eLDMatchType.juesai)
if jijunMatchTime then
if nowTime>=jijunMatchTime and nowTime<=juesaiMatchTime then
local dzInfo=lundaodahuiModel:getTTSGroupInfo(24)
if dzInfo then
local vicPlayer=lundaodahuiModel:getVictoryPlayer(dzInfo)
if vicPlayer then
local mesg=FMT.fmt("恭喜<color=#ca631d>{0}</color>仙友在本届论道大会<color=#ca631d>季军赛</color>中克敌制胜，跻身三甲！",vicPlayer.name)
local chatInfo=chatStruct.create(false,timeHelper.convertShortStamp(jijunMatchTime),CHAT_CHANNNEL.eKuafu,CHAT_MESSAGE_TYPE.ePublic,mesg,{actorName="<color=#c82c2c>[系统]</color>"},-1,-100)
return chatInfo
end

end
elseif nowTime>=juesaiMatchTime and nowTime<=timeHelper.getServerZeroStamp(juesaiMatchTime)+86400 then
local guanjunsai=lundaodahuiModel:getTTSGroupInfo(32)
if guanjunsai then
local vicPlayer=lundaodahuiModel:getVictoryPlayer(guanjunsai)
if vicPlayer then
local mesg=FMT.fmt("恭喜<color=#ca631d>{0}</color>仙友在本届论道大会<color=#ca631d>冠军赛</color>中拔得头筹，登峰造极，天下第一！",vicPlayer.name)
local chatInfo=chatStruct.create(false,timeHelper.convertShortStamp(jijunMatchTime),CHAT_CHANNNEL.eKuafu,CHAT_MESSAGE_TYPE.ePublic,mesg,{actorName="<color=#c82c2c>[系统]</color>"},-1,-100)
return chatInfo
end
end
end
end

end

function lundaodahuiModel:getVictoryPlayer(dzInfo)
local listLen=dzInfo.listLen or 0
local dzPlayer1,dzPlayer2

if listLen==1 then
dzPlayer1=dzInfo.dzPalyerList[1]
if dzPlayer1.fightResult==1 then
return dzPlayer1
end
else
if listLen==2 then
dzPlayer1=dzInfo.dzPalyerList[1]
dzPlayer2=dzInfo.dzPalyerList[2]
if dzPlayer1.fightResult==1 then
return dzPlayer1
end
if dzPlayer2.fightResult==1 then
return dzPlayer2
end
end
end
end

function lundaodahuiModel:isPlayerVictory(fightId)
local dzInfo=lundaodahuiModel:getTTSGroupInfo(fightId)
if dzInfo then
local vicPlayer=lundaodahuiModel:getVictoryPlayer(dzInfo)
return vicPlayer~=nil and vicPlayer.playerId==playerModel:getActorID()
end
end

function lundaodahuiModel:getLosePlayer(dzInfo)
local listLen=dzInfo.listLen or 0
local dzPlayer1,dzPlayer2

if listLen==1 then
dzPlayer1=dzInfo.dzPalyerList[1]
if dzPlayer1.fightResult==2 then
return dzPlayer1
end
else
dzPlayer1=dzInfo.dzPalyerList[1]
dzPlayer2=dzInfo.dzPalyerList[2]
if dzPlayer1.fightResult==2 then
return dzPlayer1
end
if dzPlayer2.fightResult==2 then
return dzPlayer2
end
end
end

function lundaodahuiModel:isPlayerLose(fightId)
local dzInfo=lundaodahuiModel:getTTSGroupInfo(fightId)
if dzInfo then
local losePlayer=lundaodahuiModel:getLosePlayer(dzInfo)
return losePlayer~=nil and losePlayer.playerId==playerModel:getActorID()
end
end

function lundaodahuiModel:isPlayerFight(fightId)
local dzInfo=lundaodahuiModel:getTTSGroupInfo(fightId)
local actorId=playerModel:getActorID()
if dzInfo then
local listLen=dzInfo.listLen or 0
local dzPlayer1,dzPlayer2
if listLen==1 then
dzPlayer1=dzInfo.dzPalyerList[1]
return actorId==dzPlayer1.playerId
elseif listLen==2 then
dzPlayer1=dzInfo.dzPalyerList[1]
dzPlayer2=dzInfo.dzPalyerList[2]
return actorId==dzPlayer1.playerId or actorId==dzPlayer2.playerId
end
end
end




function lundaodahuiModel:setTTSTieLianFlag(configid)
self.data.tieLianFlag=configid
end

function lundaodahuiModel:getTTSTieLianFlag()
return self.data.tieLianFlag
end

function lundaodahuiModel:isTTSTieLianOpen(configid)
local fightList=self:getFightIdByConfigId(configid)
if fightList then
for i,fightId in ipairs(fightList)do
if lundaodahuiModel:isPlayerVictory(fightId)then
return fightId,1
else
if lundaodahuiModel:isPlayerLose(fightId)then
return fightId,2
end
end
end
end
end

function lundaodahuiModel:setZhiBoFlag(flag)
self.data.zhiboFlag=flag
end
function lundaodahuiModel:getZhiBoFlag()
return self.data.zhiboFlag
end

function lundaodahuiModel:setJingCaiInfoStamp(fightId)
local stamp=timeHelper.getServerShortTime()
self.data.jingCaiInfoStamp[fightId]=stamp
end

function lundaodahuiModel:getJingCaiInfoStamp(fightId)
return self.data.jingCaiInfoStamp[fightId]
end

function lundaodahuiModel:setJingCaiInfo(fightId,info)
self.data.jingCaiInfo[fightId]=info
end

function lundaodahuiModel:getJingCaiInfo(fightId)
return self.data.jingCaiInfo[fightId]
end



function lundaodahuiModel:setTop3Data(sjList)
self.data.top3Data=sjList
end

function lundaodahuiModel:getTop3Data()
return self.data.top3Data or{}
end

function lundaodahuiModel:setDzNum(num)
self.data.dzNum=num
end

function lundaodahuiModel:getDzNum()
return self.data.dzNum or 0
end

function lundaodahuiModel:setNewTop3Data(jieShu,sjList)
self.data.newTop3Data={jieShu=jieShu,sjList=sjList}
end

function lundaodahuiModel:setNewTop3DzNum(serverId,playerId,dzNum)
if self.data.newTop3Data and self.data.newTop3Data.sjList then
for i,v in ipairs(self.data.newTop3Data.sjList)do
if serverId==v.serverId and tostring(playerId)==tostring(v.playerId)then
v.dzNum=dzNum
return
end
end
end
end

function lundaodahuiModel:getNewTop3Data()
return self.data.newTop3Data
end

function lundaodahuiModel:getNewTop3DataNum()
local sjList=self.data.newTop3Data~=nil and self.data.newTop3Data.sjList or{}
return#sjList
end

function lundaodahuiModel:checkJingCaiShowTime1()
local match1=lundaodahuiModel:getMatchTime(eLDMatchType.jijunsai)
local nowTime=timeHelper.getServerLongTime()

return nowTime>=match1-600
end

function lundaodahuiModel:checkJingCaiShowTime2()
local match2=lundaodahuiModel:getMatchTime(eLDMatchType.juesai)
local nowTime=timeHelper.getServerLongTime()
return nowTime>=match2-600
end

function lundaodahuiModel:checkJingCai(fightId)
if self:getJcbNum()==0 then
return false
end
local groupInfo=lundaodahuiModel:getTTSGroupInfo(fightId)
if groupInfo then
local isShowJingCai=false
local xiazhu1=false
local xiazhu2=false
local dzPlayer1,dzPlayer2
local isShowJingCai
local dzInfo=groupInfo
local listLen=dzInfo.listLen
local winFlag1=false
local winFlag2=false
if listLen==0 then
isShowJingCai=false
elseif listLen==1 then
isShowJingCai=false
dzPlayer1=dzInfo.dzPalyerList[1]
else
isShowJingCai=true
dzPlayer1=dzInfo.dzPalyerList[1]
dzPlayer2=dzInfo.dzPalyerList[2]
end
if dzPlayer1 then
xiazhu1=dzPlayer1.xzFlag==1
winFlag1=dzPlayer1.fightResult==1
end
if dzPlayer2 then
xiazhu2=dzPlayer2.xzFlag==1
winFlag2=dzPlayer2.fightResult==1
end
local showTime=true
if fightId==24 then
showTime=lundaodahuiModel:checkJingCaiShowTime1()
elseif fightId==32 then
showTime=lundaodahuiModel:checkJingCaiShowTime2()
end
return isShowJingCai and(not xiazhu1 and not xiazhu2)and(not winFlag1 and not winFlag2)and showTime
end
end

function lundaodahuiModel:checkJingCaiAllReddot()
local fightList=lundaodahuiModel:getXiaoZuFight()
for _,group in ipairs(fightList)do
for _,id in ipairs(group)do
local check=lundaodahuiModel:checkJingCai(id)
if check then
return true
end
end
end
local fightList=lundaodahuiModel:getBanJueSaiFight()
for _,id in ipairs(fightList)do
local check=lundaodahuiModel:checkJingCai(id)
if check then
return true
end
end
local fightList=lundaodahuiModel:getJueSaiFight()
for _,id in ipairs(fightList)do
local check=lundaodahuiModel:checkJingCai(id)
if check then
return true
end
end
return false
end

function lundaodahuiModel:checkRongYuTangReddot()
return lundaodahuiModel:checkOpenDay()and self:getDzNum()>0 and(lundaodahuiModel:getNewTop3DataNum()>0 or lundaodahuiModel:getSJNum()>0)
end

function lundaodahuiModel:getSJNum()
return self.data.sjNum or 0
end

function lundaodahuiModel:checkLockTips(diziguid)
local isLDLock=UIDiscipleModel:checkDZClientState(diziguid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return true
end
end


function lundaodahuiModel:setTeamSetFlag(flag)
self.data.teamSetFlag=self.data.teamSetFlag or 1

self.data.teamSetFlag=flag
end

function lundaodahuiModel:getTeamSetFlag()
return self.data.teamSetFlag or 1
end



function lundaodahuiModel:test_clearShowInvitationData()
userActorArraySetting.set(ACTOR_SETTING_TYPE.eLunDaoDaHui,'invitationStartTime',nil)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eLunDaoDaHui)
end


function lundaodahuiModel:Getgroupyingshe(index)
return groupyingshe[index]
end
