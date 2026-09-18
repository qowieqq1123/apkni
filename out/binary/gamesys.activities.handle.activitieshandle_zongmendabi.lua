







local _LuaHelper=CS.LuaHelper

activitiesHandle_zongmendabi=new_activitiesHandle('activitiesHandle_zongmendabi',activitiesHandle)









local showRewards
local battleRecv

function activitiesHandle_zongmendabi:onEnterState()
notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
end

function activitiesHandle_zongmendabi:onLeaveState()
notifySystem:removelistener(notifyConfig.onShowPrize,self.onShowPrize)
showRewards=nil
battleRecv=nil
end

function activitiesHandle_zongmendabi.onShowPrize(prizeType,prizelist,effectData)
if prizeType==ePrizeType.eZongMenDaBi then
showRewards=prizelist
local log=battleRecv[2]
local batteData=battleRecv[3]
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.zongmendabi,batteData.fight_result,log,batteData)
end
end

function activitiesHandle_zongmendabi:get_showRewards()
return showRewards
end

function activitiesHandle_zongmendabi:onBattleResult(result,log,data)
battleRecv={result,log,data}
end


function activitiesHandle_zongmendabi.recv_249_36(args)

























local subType=SUB_ACTIVITY_TYPE.eSectCompetition
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.item_pool_num=args[3]
data.zone_type=args[4]
data.giftLst=args[6]
if data.giftLst then
for i,v in ipairs(data.giftLst)do
watchModel.setItem(v)
end
end
local guidList=args[8]
if guidList==nil then
guidList={}
for i=1,10 do
table.insert(guidList,int64.new('0'))
end
end
data.guidList=guidList
data.is_enter=args[9]
data.recv_lv=args[10]
data.score=args[11]
data.use_times=args[12]
data.refresh_times=args[16]
activitiesHandle_zongmendabi.refreshBatteNum(data)

local sectTaskLookup={}
local sectTaskList=args[14]
if sectTaskList then
for i,v in ipairs(sectTaskList)do
sectTaskLookup[v.task_id]=v
end
end
data.sectTaskLookup=sectTaskLookup
data.my_rank=args[15]
activitiesModel:setSubActInfoData(actID,subType,subid,data)

local sub_actInfo=activitiesModel:getSubActInfo(actID,subType,subid)
sub_actInfo:initMySaveTeam()

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_zongmendabi.recv_249_37(actid,act2id,item_pool_num,record_len,recordList)









local subType=SUB_ACTIVITY_TYPE.eSectCompetition
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.item_pool_num=item_pool_num
local old_recordList=data.recordList
data.recordList=recordList or{}
data.recordList_time=gameUtilityModel.getServerShortTime()
data.lock_recordList=nil
local notes={}
local lp={}
if old_recordList then
for i,v in ipairs(old_recordList)do
lp[v.guid]=v
end
end
for i,v in ipairs(data.recordList)do
if lp[v.guid]==nil then
table.insert(notes,v)
end
end
if#notes>1 then
table.sort(notes,function(a,b)
return a.guid<b.guid
end)
end
if#notes>0 then
UIManager:invokeUIMethod('UISubAct_zongmendabi_reward_win','rec_notes',notes)
end
activitiesModel:setSubActInfoData(actID,subType,subid,data)
end


function activitiesHandle_zongmendabi.recv_249_38(actid,act2id,rank_len,rankList,my_rank)













local subType=SUB_ACTIVITY_TYPE.eSectCompetition
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.top3RankList=rankList or{}
data.top3RankList_time=gameUtilityModel.getServerShortTime()
data.my_rank=my_rank
activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:invokeUIMethod('UISubAct_zongmendabi_info_win','recv_rankTopThree')

UIManager:invokeUIMethod('UISubAct_zongmendabi_rank_win','refreshSelfRankItem')
end


function activitiesHandle_zongmendabi.recv_249_39(actId,subId,zone_type,rank_len,rankList)













local subType=SUB_ACTIVITY_TYPE.eSectCompetition
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if data==nil then return end

if not data.rankList then
data.rankList={}
end
if rank_len and rank_len>0 then

local trueRankList={}
for i,v in ipairs(rankList)do
local score=v.score
if activitiesHandle_zongmendabi.canInRank(subId,score)then

table.insert(trueRankList,v)
else

break
end
end

data.rankList[zone_type]=trueRankList
end

activitiesModel:setSubActInfoData(actId,subType,subId,data)


UIManager:invokeUIMethod('UISubAct_zongmendabi_rank_win','refreshRankPanel',zone_type)
end


function activitiesHandle_zongmendabi.recv_249_40(actid,act2id)



local subType=SUB_ACTIVITY_TYPE.eSectCompetition
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.is_enter=1
activitiesModel:setSubActInfoData(actID,subType,subid,data)

local sub_actInfo=activitiesModel:getSubActInfo(actID,subType,subid)
local idx=sub_actInfo:getOpenDayIndex()
if idx==1 then

UIManager.info('报名成功')
UIManager:invokeUIMethod('UISubAct_zongmendabi_enter_win','rec_baoming')
notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eZongMenDaBi_baoming)
else

notifySystem:postNotify(notifyConfig.onActivityTabChange,actID,subType,subid)
end
end


function activitiesHandle_zongmendabi.recv_249_41(actid,act2id)



local subType=SUB_ACTIVITY_TYPE.eSectCompetition
local actID=actid
local subid=act2id
local sub_actInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if sub_actInfo==nil then return end

sub_actInfo:setDefTeams()

UIManager.info('防守阵容设置成功')
UIManager:invokeUIMethod('UISubAct_zongmendabi_enter_win','rec_changeDef')
end


function activitiesHandle_zongmendabi.recv_249_42(actid,act2id,len,matchList)















local subType=SUB_ACTIVITY_TYPE.eSectCompetition
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end
local sub_actInfo=activitiesModel:getSubActInfo(actID,subType,subid)

matchList=matchList or{}
if#matchList>0 then
local change=false
for i,v in ipairs(matchList)do

local actor_id=v.actor_id
local actor_id_n=mathHelper.int64_to_number(actor_id)
if actor_id_n<0 then
actor_id_n=-actor_id_n
local temp=mathHelper.number_to_int64(actor_id_n)
local robotID=_LuaHelper.SplitInt32(temp,"0xFFFFFFF",0)
local robbotType=_LuaHelper.SplitInt32(temp,"0xFFFFFFFF",32)

if robbotType>=1 then
v.robotID=robotID
local robotcfg=cfgHelper.get1(cfg_robotmonsterconfig_get,robotID)
if robotcfg then
v.sect_name=robotcfg.zm_name
local headImage=robotcfg.headImage
v.iconInfo.actoricon=mathHelper.concatToInt32(headImage[2],headImage[1])
local recordData,change_=sub_actInfo:getRobotScore(v.idx)
v.pk_score=recordData[1]or recordData['1']
local fights={}
local f_list=recordData[2]or recordData['2']
for i,v in ipairs(f_list)do
fights[i]=v
end
v.fight_value=recordData[3]or recordData['3']
v.fights=fights
if change_ then
change=true
end
else



end
else



local recordData,change_=sub_actInfo:getRobotScore(v.idx)
v.pk_score=recordData[1]or recordData['1']

if change_ then
change=true
end
end
end
end
if change then
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZongMenDaBi)
end
end
data.matchList=matchList
data.matchList_time=gameUtilityModel.getServerShortTime()
activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:invokeUIMethod('UISubAct_zongmendabi_battle_win','rec_matchList')
end


function activitiesHandle_zongmendabi.recv_249_49(actid,act2id,recv_lv)




local subType=SUB_ACTIVITY_TYPE.eSectCompetition
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

data.recv_lv=recv_lv
activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:invokeUIMethod('UISubAct_zongmendabi_info_win','recv_scoreReward')
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eZongMenDaBi_info)
end


function activitiesHandle_zongmendabi.recv_249_50(actid,act2id,task_id,score)





local subType=SUB_ACTIVITY_TYPE.eSectCompetition
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

local sectTaskLookup=data.sectTaskLookup
if sectTaskLookup==nil then return end
local task=sectTaskLookup[task_id]
if task==nil then return end


task.task_state=3
data.score=score
activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:invokeUIMethod('UISubAct_zongmendabi_target_win','recv_getReward',task_id)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eZongMenDaBi_target)
end


function activitiesHandle_zongmendabi.recv_249_51(actid,act2id,len,sectTaskList)





local subType=SUB_ACTIVITY_TYPE.eSectCompetition
local actID=actid
local subid=act2id
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end

local sectTaskLookup=data.sectTaskLookup
if sectTaskLookup==nil then
sectTaskLookup={}
data.sectTaskLookup=sectTaskLookup
end
if sectTaskList then
for i,v in ipairs(sectTaskList)do
sectTaskLookup[v.task_id]=v
end
end
activitiesModel:setSubActInfoData(actID,subType,subid,data)

UIManager:invokeUIMethod('UISubAct_zongmendabi_target_win','recv_refresh')
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
notifySystem:postNotify(notifyConfig.onActTabReddotChange,SUBACT_DEFINETAB_TYPE.eZongMenDaBi_target)
end

function activitiesHandle_zongmendabi.getRaceLevelName(subid,lv)
local rank_type_name=activitiesModel:getSubActivityConfig(SUB_ACTIVITY_TYPE.eSectCompetition,subid,'rank_type_name')
return rank_type_name[lv]
end

function activitiesHandle_zongmendabi.getZMRewardLevel(subid,score)
local scorereward=activitiesModel:getSubActivityConfig(SUB_ACTIVITY_TYPE.eSectCompetition,subid,'scorereward')
local lv=0
local isfull=false
for i,v in ipairs(scorereward)do
if score>=v[2]then
lv=i
end
end
if lv>=#scorereward then
isfull=true
end
local cur,max
if isfull then
cur=1
max=1
else
local d=scorereward[lv+1]
cur=score-d[1]
max=d[2]-d[1]
end
return lv,cur,max,isfull
end

function activitiesHandle_zongmendabi.getZMLevelByScore(subid,score)
local scorereward=activitiesModel:getSubActivityConfig(SUB_ACTIVITY_TYPE.eSectCompetition,subid,'scorereward')
local max=#scorereward
for i=max,1,-1 do
local v=scorereward[i]
if score>=v[1]and score<v[2]then
return i
end
end
return max+1
end

function activitiesHandle_zongmendabi.getZMLevelReward(subid,lv)
local scorereward=activitiesModel:getSubActivityConfig(SUB_ACTIVITY_TYPE.eSectCompetition,subid,'scorereward')
local d=scorereward[lv]
if d then
local dropid=d[3]
local rewards=zongmenControl:getRewardConfigData(dropid,zongmenModel:getLevel())or{}
return rewards
end
return nil
end

function activitiesHandle_zongmendabi.getZMLevelInfo(subid,lv)
local scores=activitiesModel:getSubActivityConfig(SUB_ACTIVITY_TYPE.eSectCompetition,subid,'scores')
local f=scores[lv]
if f==nil then
f=scores[#scores]
end
local duanweiName=f[1]
local duanweiIcon=f[2]
local rewardName=f[3]
local duanweiName2=f[4]
return duanweiName,duanweiIcon,rewardName,duanweiName2
end


function activitiesHandle_zongmendabi.canInRank(subid,score)
local rank_zmlv=activitiesModel:getSubActivityConfig(SUB_ACTIVITY_TYPE.eSectCompetition,subid,'rank_zmlv')
if rank_zmlv~=nil then
local zmlv=activitiesHandle_zongmendabi.getZMLevelByScore(subid,score)
return zmlv>=rank_zmlv
end
return true
end

function activitiesHandle_zongmendabi.setupDefTeams(actID,subType,subid,tab_idx,teamIndex)
local sub_actInfo=activitiesModel:getSubActInfo(actID,subType,subid)
local sub_actcfg=activitiesModel:getSubActivityConfig(subType,subid)
local multipleTeams={}
for teamIdx=1,2 do
local defTeam=sub_actInfo:getDefTeamFive(teamIdx)
multipleTeams[teamIdx]={}
for posIdx,dis_guid in ipairs(defTeam)do
if mathHelper.validInt64(dis_guid)then
multipleTeams[teamIdx][tostring(dis_guid)]={posIdx,eTeamEntityType.dizi,dis_guid}
end
end
end
local dzCountLimit=sub_actcfg.deflist[2]
local singleFightDescStr=FMT.fmt('每个队伍最多可上阵{0}名弟子',dzCountLimit)
local winArgs=
{
enterTxt="宗门大比",
skipShouYuanCheck=true,
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
monsterFight=nil,
sureBodyid=2068,
sureBodyAnim=eAnimationID.dog_idle_1,
dzCountLimit=dzCountLimit,
singleFightDescStr=singleFightDescStr,
notNeedDealOverTime=true,
editorTeam=false,
needSaveTeam=false,
showZhenFa=false,
showDefTeamTips=true,
mapId=818002,
defaultSelectTeamIndex=teamIndex,
multipleTeams=multipleTeams,
cancelCallBack=function()
activitiesController:jump(actID,subType,subid,{tab_idx=tab_idx})
end,
enterCallBack=function(teamList,zfId)
local guidList={}
for teamIdx,v in ipairs(teamList)do
for posIdx,vv in ipairs(v[2])do
local dis_guid=vv[2]
table.insert(guidList,dis_guid)
end
end
local sub_actInfo_=activitiesModel:getSubActInfo(actID,subType,subid)
if sub_actInfo_ then
sub_actInfo_:setDefTeams_temp(guidList)
end
local args={4}
for i,dis_guid in ipairs(guidList)do
table.insert(args,tostring(dis_guid))
end
local json_str=jsonHelper.encode(args)
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
activitiesController:jump(actID,subType,subid,{tab_idx=tab_idx})
end,
}
fightController.showPrepareWin(fightPreSelectModel.fightType.zongmendabi,winArgs)
end

function activitiesHandle_zongmendabi.showOtherPlayerRivalInfo(subid,teamDzList)
local subType=SUB_ACTIVITY_TYPE.eSectCompetition
local sub_actcfg=activitiesModel:getSubActivityConfig(subType,subid)

local teamCount=sub_actcfg.deflist[1]

local data={
teamList=teamDzList,
winName="UICommonLookRival_selectTeamWin",
winArgs={
teamCount=teamCount,
},
lookType=DOUFATAI_LOOK_TYPE.eZongMenDaBiWatchOtherTeam,
}
UIManager:showWindow("UICommonLookRivalWin",data)
end

function activitiesHandle_zongmendabi:checkInDefTeam(dis_guid)
local subType=SUB_ACTIVITY_TYPE.eSectCompetition
local sub_actList=activitiesModel:getActSubList_subType_doing(subType)
if#sub_actList>0 then
for i,sub_actInfo in ipairs(sub_actList)do
if sub_actInfo:checkInDefTeam(dis_guid)then
return true
end
end
end
return false
end

function activitiesHandle_zongmendabi.refreshBatteNum(data)
if data.refresh_times then
local refresh_time_l=gameUtilityModel.serverShortTimeToLong(data.refresh_times)
if not timeHelper.checkInSameDay(refresh_time_l,gameUtilityModel.getServerLongTime())then
data.use_times=0
data.refresh_times=gameUtilityModel.getServerShortTime()
end
end
end

function activitiesHandle_zongmendabi:setSkipFightState(skip)
self.skipFightState=skip
end

function activitiesHandle_zongmendabi:isSkipFight()
return self.skipFightState==true
end
