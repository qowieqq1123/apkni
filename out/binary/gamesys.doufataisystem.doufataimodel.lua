






local _MODULENAME="douFaTaiModel"




def_table(_MODULENAME)
douFaTaiModel.name=_MODULENAME


douFaTaiModel.data={}


DOUFATAI_LOOK_TYPE=
{
eBeatBack=1,
eRank=2,
ePiPeiActor=3,
eChallenge=4,
eSelf=5,
eMain=6,
eRecord=7,
eLunDaoTeam=8,
eZongMenDaBiWatchOtherTeam=9,
eXianFaWenDao=10,
eZhengZhanShanHaiPvP=11,
eWDCQ_SelfTeam=12,
eWDCQ_OtherTeam=13,
eXianGuanWuXuan=14,
eXingYu_SelfTeam=15,
eXingYu_OtherTeam=16,
}

DOUFATAI_ROBOTTYPE=
{
oldRobot=1,
robot=2,
clonePlayer=3,
player=4,
clonePlayer2=5,
}

DOUFATAI_ROBOTTYPE_FUNC=
{
[DOUFATAI_ROBOTTYPE.oldRobot]=
{
getConfig=function(actorId)
return cfg_doufataimatchmonconfig_get(actorId)
end
},
[DOUFATAI_ROBOTTYPE.robot]=
{
getConfig=function(actorId)
return cfgHelper.get1(cfg_robotmonsterconfig_get,actorId)
end
},
[DOUFATAI_ROBOTTYPE.clonePlayer]=
{
getConfig=function(actorId)
return cfgHelper.get1(cfg_robotmonsterconfig_get,actorId)
end
},
[DOUFATAI_ROBOTTYPE.clonePlayer2]=
{
getConfig=function(actorId)
return cfgHelper.get1(cfg_robotmonsterconfig_get,actorId)
end
},
}


function douFaTaiModel:onAppStart()

end


function douFaTaiModel:onEnterState()
self:loadOldRank()
self:loadDaliyRwardFlag()
end


function douFaTaiModel:onLeaveState()

self.data={}
self:saveOldRank()
self:saveDailyRewardFlag()
end


function douFaTaiModel:onServerDataInitFinish()

end

function douFaTaiModel:getDouFaTaiBasicConfig()
return cfgHelper.get1(cfg_doufataibasicconfig_get,1)
end

function douFaTaiModel:getWenDaoIconName()
local config=self:getDouFaTaiBasicConfig()
return config.wendao_icon
end

function douFaTaiModel:getDuanWeiName(score)
local config=self:getDouFaTaiBasicConfig()
local dwList=config.duanwei
for i,v in ipairs(dwList)do
if score>=v[1]and score<=v[2]then
return v[3],v[4]
end
end
end


function douFaTaiModel:init_doufatai_data(data)
local args=
{
settleTime=data[1],
freeCnt=data[2],
wendao=data[3],
rank=data[4],
rewardFlag=data[5],
challengeTalk=data[6],
defenseLen=data[7],
defenseList=data[8],


tzNum=data[9],
honorToday=data[11],
lastSelfRank=data[12],
}

if systemModel.isOpen(SYSTEM_DEFINE.eBuildOpenDouFaTai)then
if data[7]==0 or self:checkTeamEmpty(data[8])then
local fightTeam,sendTeam=self:init_defenseList()
if next(fightTeam)then
args.defenseLen=#fightTeam
args.defenseList=fightTeam
douFaTaiController:req_edit_defense(args.challengeTalk or'',args.defenseLen,sendTeam)
end
end
end

self.data.doufataiData=args

if data[4]==0 then
douFaTaiModel:changeOldRank(0)
end


douFaTaiModel:set_doufatai_truceStartTime()
end

function douFaTaiModel:get_doufatai_settleTime()
if not self.data.doufataiData then
return
end
return self.data.doufataiData.settleTime
end

function douFaTaiModel:set_honorToday(honorToday)
if not self.data.doufataiData then
return
end
self.data.doufataiData.honorToday=honorToday
end
function douFaTaiModel:get_honorToday()
if not self.data.doufataiData then
return
end
return self.data.doufataiData.honorToday
end
function douFaTaiModel:set_tempHonorToday(honorToday)
self.data.tempHonorToday=honorToday
end

function douFaTaiModel:get_tempHonorToday()
return self.data.tempHonorToday
end
function douFaTaiModel:checkTeamEmpty(data)
if data then
local isEmpty=true
for i,v in ipairs(data)do
if v.unitType~=0 then
isEmpty=false
break
end
end
return isEmpty
end
return true
end

function douFaTaiModel:init_defenseList()

local datas=UIDiscipleModel:getAllDiscipleData()
local list={}

for k,v in pairs(datas)do
local guid=v.netData.net.discipleguid
local shouyuan=UIDiscipleModel:getDiscipleShouYuan(guid)
if shouyuan~=0 then
table.insert(list,v)
end
end
table.sort(list,function(a,b)
local guida=a.netData.net.discipleguid
local guidb=b.netData.net.discipleguid
return UIDiscipleModel:getDiscipleFightValue(guida)>UIDiscipleModel:getDiscipleFightValue(guidb)
end)
local fightTeam,sendTeam={},{}



for i=1,5 do
if list[i]then
local posIndex
local diziData=list[i]
local jobId=UIDiscipleModel:getDiscipleJob(diziData.netData.net.discipleguid)
local pospriorty=UIDiscipleModel.getJobPosPriorty(jobId)

if pospriorty then
for ii,listPos in ipairs(pospriorty)do
if not fightTeam[listPos]then
posIndex=listPos
break
end
end
else
for ii=1,5 do
if not fightTeam[ii]then
posIndex=ii
break
end
end
end

fightTeam[posIndex]={unitType=eTeamEntityType.dizi,unitId=diziData.netData.net.discipleguid}
sendTeam[posIndex]={eTeamEntityType.dizi,diziData.netData.net.discipleguid}


else
local posIndex
for ii=1,5 do
if not fightTeam[ii]then
posIndex=ii
end
end
fightTeam[posIndex]={unitType=0,unitId=int64.zero}
sendTeam[posIndex]={0,int64.zero}
end
end


return fightTeam,sendTeam
end


function douFaTaiModel:get_doufatai_tzNum()
return self.data.doufataiData.tzNum or 0
end

function douFaTaiModel:set_doufatai_tzNum(tzNum)
self.data.doufataiData.tzNum=tzNum
end

function douFaTaiModel:set_doufatai_wendao(wendao)
self.data.doufataiData.wendao=wendao
end

function douFaTaiModel:get_doufatai_wendao()
if self.data.doufataiData then
return self.data.doufataiData.wendao or 0
end
end

function douFaTaiModel:get_doufatai_data()
return self.data.doufataiData
end

function douFaTaiModel:get_doufatai_freenum()
local config=douFaTaiModel:getDouFaTaiBasicConfig()
local totalFree=config.challenge_free
local data=douFaTaiModel:get_doufatai_data()
local useFree=data.freeCnt
return totalFree-useFree
end

function douFaTaiModel:update_doufatai_freenum()
local data=douFaTaiModel:get_doufatai_data()
local useFree=data.freeCnt
local config=douFaTaiModel:getDouFaTaiBasicConfig()
local totalFree=config.challenge_free
if totalFree-useFree>0 then
data.freeCnt=data.freeCnt+1
end
end

function douFaTaiModel:set_doufatai_openTime()
local long=gameUtilityModel.getOpenServerLongTime_kf()
if long and long>0 then
local y,M,d,h,m=timeHelper.getServerStampData(long)
self.data.doufataiopenTime={y,M,d,h,m}
end
end

function douFaTaiModel:get_doufatai_openTime()
if not self.data.doufataiopenTime then
douFaTaiModel:set_doufatai_openTime()
end
return self.data.doufataiopenTime
end

function douFaTaiModel:set_reward_flag(id)

self.data.doufataiData.rewardFlag=id
end

function douFaTaiModel:setSelfDefenseList(title,len,dzList)
self.data.doufataiData.challengeTalk=title
if len>0 then
self.data.doufataiData.defenseList=dzList
end
end

function douFaTaiModel:get_doufatai_settle_time()
return self.data.doufataiData.settleTime
end

function douFaTaiModel:init_doufatai_data_5am()
if self.data.doufataiData then
self.data.doufataiData.freeCnt=0
self.data.doufataiData.honorToday=0
end
end


function douFaTaiModel:checkFreeCount()
local data=self:get_doufatai_data()
if data then
local config=self:getDouFaTaiBasicConfig()
local totalFree=config.challenge_free

local useFree=data.freeCnt
return useFree<totalFree
end
return false
end

function douFaTaiModel:getSelfChallengeSentence()
local data=self:get_doufatai_data()
return data.challengeTalk
end

function douFaTaiModel:setLastData(data)
self.data.lastData=data
end

function douFaTaiModel:getLastData()
return self.data.lastData
end


function douFaTaiModel:checkIsTruce()

local truceStartTime=douFaTaiModel:get_doufatai_truceStartTime()
if not truceStartTime then
return false
end
local config=douFaTaiModel:getDouFaTaiBasicConfig()
local truceDurationTime=config.xzTime
local truceEndTime=truceStartTime+truceDurationTime

local nowTime=timeHelper.getServerShortTime()
if nowTime>=truceStartTime and nowTime<truceEndTime then
return true
end

return false
end

function douFaTaiModel:set_doufatai_truceStartTime()

local nowTime=timeHelper.getServerLongTime()
local open_time=douFaTaiModel:get_doufatai_openTime()
if not open_time then
return
end
local stamp=timeHelper.timeServer(open_time[1],open_time[2],open_time[3],open_time[4],open_time[5],0)
if nowTime<stamp then

self.data.doufataiTruceStartTime=douFaTaiModel:get_doufatai_settleTime()
return
end

local nowShortTime=timeHelper.getServerShortTime()
local thisSettleTime=douFaTaiModel:get_doufatai_settleTime()
if nowShortTime>=thisSettleTime then

self.data.doufataiTruceStartTime=thisSettleTime
return
end
local config=douFaTaiModel:getDouFaTaiBasicConfig()
local durationDays=config.duration_days
local duration=86400*durationDays
local startTime=thisSettleTime-duration
local isFirst=false
if lundaodahuiModel:getJieShu()<=1 and not lundaodahuiModel:isOpened()then

isFirst=true
end
if isFirst then

self.data.doufataiTruceStartTime=timeHelper.convertShortStamp(douFaTaiModel:get_first_settle_time())
return
end

self.data.doufataiTruceStartTime=startTime
end

function douFaTaiModel:get_first_settle_time()
local open_time=douFaTaiModel:get_doufatai_openTime()
local config=douFaTaiModel:getDouFaTaiBasicConfig()

local openStamp=timeHelper.timeServer(open_time[1],open_time[2],open_time[3],0,0,0)
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
return settle
end

function douFaTaiModel:get_doufatai_truceStartTime()
if not self.data.doufataiTruceStartTime then
douFaTaiModel:set_doufatai_truceStartTime()
end
return self.data.doufataiTruceStartTime
end


function douFaTaiModel:get_doufatai_truceEndTime()
local truceStartTime=douFaTaiModel:get_doufatai_truceStartTime()
if not truceStartTime then
return
end
local config=douFaTaiModel:getDouFaTaiBasicConfig()
local truceDurationTime=config.xzTime
local truceEndTime=truceStartTime+truceDurationTime
return truceEndTime
end









function douFaTaiModel:init_rank_data(len,rankList)
local list={}
if len>0 then
for i,v in ipairs(rankList)do

local data=
{
actorId=v.actor_id,
name=v.actor_name,


zmName=v.zhongmen_name,
wendao=tonumber(v.wendao),
discipledata=v.discipledata,
discipleimage=v.discipleimage,
fight=tonumber(tostring(v.total_fight)),
sentence=v.sentence,
zmLevel=v.zmLevel,
iconInfo=v.iconInfo,
}
table.insert(list,data)
end
end
self.data.rankData=list
end

function douFaTaiModel:get_rank_data()
return self.data.rankData
end

function douFaTaiModel:getRankActorInfo(actor_id)
local list=self:get_rank_data()
for i,v in ipairs(list)do
if tostring(v.actorId)==tostring(actor_id)then
return v
end
end
end


function douFaTaiModel:getRankRewardConfig(rank)
local rankConfig=cfg_doufatairankrewardconfig()
for _,v in ipairs(rankConfig)do
local range=v.rank_range
if rank>=range[1]and rank<=range[2]then
return v
end
end
end


function douFaTaiModel:init_record_data(len,logList)

self.data.recordData={}


self.data.recordDataLookup={}


if len>0 then
for i,v in ipairs(logList)do
if not self.data.recordDataLookup[v.log_times]then

local data=
{
logTime=v.log_times,
actorId=v.actor_id,
name=v.actor_name,
wendao=v.wendao_change,


battleFlag=v.can_battle,
sentence=v.sentence,
zongmenName=v.guild_name,
logGuid=v.fightLogId,
iconInfo=v.iconInfo,
}
table.insert(self.data.recordData,data)
self.data.recordDataLookup[v.log_times]=data
end
end
end
table.sort(self.data.recordData,function(a,b)return a.logTime>b.logTime end)
end

function douFaTaiModel:get_record_data()
return self.data.recordData or{}
end

function douFaTaiModel:getRecordActorInfo(actor_id)
local list=self:get_record_data()
for i,v in ipairs(list)do
if tostring(v.actorId)==tostring(actor_id)then
return v
end
end
end


function douFaTaiModel:setPiPeiActorList(len,selectList,cd)
local list={}
local myFight=playerModel:getActorFightValue()
if len>0 then
for i,v in ipairs(selectList)do
local robotType=v.robotType
local wd=v.wendao

local actorId=v.robotId
local actor_id_num=tonumber(tostring(actorId))
local name=v.name
local fight
if robotType==DOUFATAI_ROBOTTYPE.oldRobot then
local config=DOUFATAI_ROBOTTYPE_FUNC[robotType].getConfig(actor_id_num)
if config then
wd=config.wendao
end
fight=tonumber(tostring(v.total_fight))
elseif robotType==DOUFATAI_ROBOTTYPE.robot or robotType==DOUFATAI_ROBOTTYPE.clonePlayer2 then
local config=DOUFATAI_ROBOTTYPE_FUNC[robotType].getConfig(actor_id_num)
if config and config.name then
local nameIndex=config.name
local ncfg=cfgHelper.get1(cfg_robotmonsternameconfig_get,nameIndex)
name=ncfg.name_list[math.random(1,#ncfg.name_list)]
end
if config.fightShowVal then
fight=math.floor(myFight*(1+(math.random(config.fightShowVal[1]*100,config.fightShowVal[2]*100)/10000)))
else
fight=tonumber(tostring(v.total_fight))
end
elseif robotType==DOUFATAI_ROBOTTYPE.clonePlayer then
local ncfg=cfgHelper.get1(cfg_robotmonsternameconfig_get,1)
name=ncfg.name_list[math.random(1,#ncfg.name_list)]




fight=tonumber(tostring(v.total_fight))

else
fight=tonumber(tostring(v.total_fight))
end
local challenge=
{
robotType=v.robotType,

actorId=actorId,

actorIdNum=v.actor_id_num,
sentence=v.sentence,
fight=fight,
wendao=wd,
name=name,
head=v.head_id,
kuang=v.head_frame_id,
index=i,
discipledata=v.discipledata,
discipleimage=v.discipleimage,
iconInfo=v.iconInfo,
}
table.insert(list,challenge)
end
end
table.sort(list,function(a,b)return a.wendao>b.wendao end)
self.data.challengeList=list
self.data.pipeicd=cd
end

function douFaTaiModel:getPiPeiActorList()
return self.data.challengeList or{}
end

function douFaTaiModel:getPiPeiCDTime()
return self.data.pipeicd
end


function douFaTaiModel:getChallengeActorIndex(actor_id)
local list=self:getPiPeiActorList()
for i,v in ipairs(list)do
if tostring(v.actorId)==tostring(actor_id)then
return v.index,v
end
end
return 1
end

function douFaTaiModel:setPiPeiActorSpeak(index,speakStr)
local speakList=self.data.randPiPeiSpeak
if speakList==nil then
speakList={}
self.data.randPiPeiSpeak=speakList
end
speakList[index]=speakStr
end

function douFaTaiModel:getPiPeiActoreSpeak(index)
if self.data.randPiPeiSpeak then
return self.data.randPiPeiSpeak[index]
end
end

function douFaTaiModel:clearTempSpeak()
self.data.randPiPeiSpeak=nil
end

function douFaTaiModel:getSelfFight()
local data=self:get_doufatai_data()
local selectFight=0
local defenseLen=data.defenseLen
local netData
if defenseLen>0 then
for i,v in ipairs(data.defenseList)do
if v.unitId>int64.zero then
netData=UIDiscipleModel:getDiscipleData(v.unitId)
if netData then
selectFight=selectFight+UIDiscipleModel:getDiscipleFightValue(v.unitId)
end
end
end
end
return selectFight
end



function douFaTaiModel:getDouFaTaiMonsterConfig(actorId)
return cfg_doufataimatchmonconfig_get(actorId)
end


function douFaTaiModel:getOldRobotMonstersList(actorId)
local config=self:getDouFaTaiMonsterConfig(actorId)
if config then
local groupid=config.g_mon_id
local cfg=cfg_monstergroup_get(groupid)
return cfg.monList
end
end

function douFaTaiModel:getDouFaTaiActorInfo(data)
local head
local kuang
local wendao
local name=''
local playerHeadInfo
local actorId=tonumber(tostring(data.actorId))
local robotType=data.robotType or DOUFATAI_ROBOTTYPE.player
if robotType==DOUFATAI_ROBOTTYPE.player or robotType==DOUFATAI_ROBOTTYPE.clonePlayer then
wendao=data.wendao
name=playerModel:getOtherActorName(data.name)
playerHeadInfo=data.iconInfo
elseif robotType==DOUFATAI_ROBOTTYPE.oldRobot then
local cfg=DOUFATAI_ROBOTTYPE_FUNC[robotType].getConfig(actorId)
head=cfg.head
kuang=cfg.kuang
wendao=cfg.wendao
name=cfg.name
elseif robotType==DOUFATAI_ROBOTTYPE.robot or robotType==DOUFATAI_ROBOTTYPE.clonePlayer2 then
local cfg=DOUFATAI_ROBOTTYPE_FUNC[robotType].getConfig(actorId)
name=data.name
wendao=data.wendao
head=cfg.headImage[1]
kuang=cfg.headImage[2]
end
return head,kuang,name,wendao,playerHeadInfo
end


function douFaTaiModel:checkRewardIsGot(index,flag)
local check=mathHelper.getBitValue(flag,index-1)
return check
end


function douFaTaiModel:setCurLookType(typo)
self.data.lookType=typo
end

function douFaTaiModel:getCurLookType()
return self.data.lookType
end


function douFaTaiModel:checkDiscipleInDefense(guid)
local data=self:get_doufatai_data()
if data then
local defenseLen=data.defenseLen
if defenseLen>0 then
for i,v in ipairs(data.defenseList)do
if v.unitId==guid then
return true
end
end
end
end
return false
end


function douFaTaiModel:checkRewardReddot()
local data=douFaTaiModel:get_doufatai_data()
if data then
local allConfig=cfg_doufataivaluerewardconfig()
for i,v in ipairs(allConfig)do
local isGot=douFaTaiModel:checkRewardIsGot(v.id,data.rewardFlag)
local canReward=data.wendao>=v.weidao
if canReward and not isGot then
return true
end
end
end
return false
end


function douFaTaiModel:checkChangeDailyRewardFlag(oldRank,newRank)
douFaTaiModel:changeOldRank(oldRank)
local oldConfig=douFaTaiModel:getRankRewardConfig(oldRank)or{}
local config=douFaTaiModel:getRankRewardConfig(newRank)or{}
local isChanged=oldConfig.id~=config.id
if isChanged then
douFaTaiModel:changeDilyRewardFlag(true)
end
end

function douFaTaiModel:checkDailyRewardChange(rank)
local oldRank=self:getOldRank()
local oldConfig=douFaTaiModel:getRankRewardConfig(oldRank)or{}
local config=douFaTaiModel:getRankRewardConfig(rank)or{}
local isChanged=oldConfig.id~=config.id
return isChanged
end


function douFaTaiModel:loadOldRank()
self.oldRank=userActorSetting.get('doufataioldrank',0)
end

function douFaTaiModel:getOldRank()
return self.oldRank
end

function douFaTaiModel:changeOldRank(value)
self.oldRank=value
end

function douFaTaiModel:saveOldRank()
userActorSetting.flushVal('doufataioldrank',self.oldRank,0)
end


function douFaTaiModel:loadDaliyRwardFlag()
self.dailyFlag=userActorSetting.get('doufataiolddailyflag',false)
end

function douFaTaiModel:getDailyRewardFlag()
return self.dailyFlag
end

function douFaTaiModel:changeDilyRewardFlag(value)
self.dailyFlag=value
end

function douFaTaiModel:saveDailyRewardFlag()
userActorSetting.flushVal('doufataiolddailyflag',self.dailyFlag,false)
end

function douFaTaiModel:setTemporaryData(guidList,speakStr)
self.tempGuidList=guidList
self.tempSpeakStr=speakStr
end

function douFaTaiModel:getTemporaryData()
return self.tempGuidList,self.tempSpeakStr
end

function douFaTaiModel:isInFight()
return self.data.fighting
end

function douFaTaiModel:setOtherDefense(teamType,actor_id,sentence,monsterFight,teamList)
self.data.otherDefenseList=self.data.otherDefenseList or{}
self.data.otherDefenseList[FMT.fmt("{0}_{1}",teamType,tostring(actor_id))]={teamList,sentence,monsterFight}
timeEventController.delayDo(60,function()
if self.data.otherDefenseList then
self.data.otherDefenseList[FMT.fmt("{0}_{1}",teamType,tostring(actor_id))]=nil
end
end)
end

function douFaTaiModel:getOtherDefense(teamType,actor_id)
if self.data.otherDefenseList then
return self.data.otherDefenseList[FMT.fmt("{0}_{1}",teamType,tostring(actor_id))]
end
end


