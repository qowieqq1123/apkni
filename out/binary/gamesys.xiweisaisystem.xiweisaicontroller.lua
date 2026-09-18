






local _MODULENAME="XiWeiSaiController"

gameState.addListener(def_table(_MODULENAME))
XiWeiSaiController.name=_MODULENAME
XiWeiSaiController.data={}
local _this=XiWeiSaiController
XWSStateEnum={
ePreGame=1,
eInGame=2,
eAfterGame=3,
}

XWSSubStateEnum={
eNone=0,
eFight=1,
eJieSuan=2,
}


function XiWeiSaiController:onAppStart()

XiWeiSaiModel:onAppStart()


socketManager:register_receiver(38,41,XiWeiSaiController.recv_38_41)
socketManager:register_receiver(38,42,XiWeiSaiController.recv_38_42)
socketManager:register_receiver(38,43,XiWeiSaiController.recv_38_43)
socketManager:register_receiver(38,44,XiWeiSaiController.recv_38_44)
socketManager:register_receiver(38,45,XiWeiSaiController.recv_38_45)



end


function XiWeiSaiController:onEnterState(isReconnect)
self.reqFlagList={}
XiWeiSaiModel:onEnterState()
timeEventController.addNormalTimerHandler(1,'XiWeiSaiController',self)
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
end


function XiWeiSaiController:onProtocolReq()
XiWeiSaiModel:onProtocolReq()

end


function XiWeiSaiController:onLeaveState(isReconnect)
XiWeiSaiModel:onLeaveState(isReconnect)
timeEventController.removeNormalTimerHandler(1,'XiWeiSaiController',self)
notifySystem:removelistener(notifyConfig.onNewDay,self.onNewDay)

self.data={}
_this.recvFlag_38_45=false
end


function XiWeiSaiController:onLostConnection()

end


function XiWeiSaiController:onReConnection(isInitPro)

end




function XiWeiSaiController.req_38_41()
socketManager:send_38_41()
end


function XiWeiSaiController.req_38_42()
socketManager:send_38_42()
end




function XiWeiSaiController.req_38_43(len,teamList,fight)
socketManager:send_38_43(len,teamList,fight)

end


function XiWeiSaiController.req_38_45()
socketManager:send_38_45()
end































function XiWeiSaiController.recv_38_41(args)
local begin_time=args[1]
local fight_cnt=args[2]
local attend_cnt=args[3]
local xfwd_stage=args[4]
local pos_id=args[5]
local group_len=args[6]
local groupList=args[7]
local team_len=args[8]
local teamList=args[9]
local data=XiWeiSaiModel:getData()
data.startTime=begin_time
data.fightCnt=fight_cnt
data.attendCnt=attend_cnt
data.xfwdStage=xfwd_stage
data.teamList=teamList
data.pos_id=pos_id








data.grouplookUpList={}
if group_len>0 then
for i,v in ipairs(groupList)do
local wdqchxGroupInfo=v
local groubId=wdqchxGroupInfo.big_groub_id
local pos_len=wdqchxGroupInfo.pos_len
data.group=groubId
data.grouplookUpList[groubId]={}
if pos_len>0 then
for i2,v2 in ipairs(wdqchxGroupInfo.posList)do
local wdqchxPosInfo=v2
local pos=wdqchxPosInfo.pos_id
data.grouplookUpList[groubId][pos]=wdqchxPosInfo
end
end
end
else

end



UIManager:invokeUIMethod("UIWDCQHaiXuanWin","refreshAll")
reddotControl.on_change_catch_type(CATCH_TYPE.eWenDingCangQiong)
end



















function XiWeiSaiController.recv_38_42(log_len,logList)
local data=XiWeiSaiModel:getData()
data.logList=nil
if log_len>0 then
table.sort(logList,function(a,b)
return a.log_times>b.log_times
end)
data.logList=logList
end

UIManager:invokeUIMethod("UIWDCQHaiXuanWin","Data_Recv_38_42")
end




function XiWeiSaiController.recv_38_43(len,teamList)
local data=XiWeiSaiModel:getData()
data.teamList=teamList







UIManager.info('保存成功')
end













function XiWeiSaiController.recv_38_44(ret_code)
UIManager.info('席位更新，请刷新后挑战')
end

function XiWeiSaiController.recv_38_45(args)
local begin_time=args[1]
local fight_cnt=args[2]
local attend_cnt=args[3]
local xfwd_stage=args[4]
local pos_id=args[5]
local team_len=args[6]
local teamList=args[7]
local big_group_id=args[8]
local data=XiWeiSaiModel:getData()
data.startTime=begin_time
data.fightCnt=fight_cnt
data.attendCnt=attend_cnt
data.xfwdStage=xfwd_stage
data.pos_id=pos_id
data.teamList=teamList
data.group=big_group_id
_this.recvFlag_38_45=true
WDCQModel:initLookUpConfig()
WDCQController:addGuessTimerAndRefreshFlag()
XiWeiSaiController:checkGameDoFunc()
WDCQController:freshEnter()
reddotControl.on_change_catch_type(CATCH_TYPE.eWenDingCangQiong)
end




function XiWeiSaiController.checkSysOpen()
return _this.recvFlag_38_45
end

function XiWeiSaiController:onNormalUpdate(delay)
if not XiWeiSaiController.checkSysOpen()then
return
end
local curTime=timeHelper.getServerShortTime()
local startTime=XiWeiSaiModel:getConfig_startTime()
local endTime=XiWeiSaiModel:getConfig_endTime()
local req38_45=false

if startTime+3<=curTime and not self.reqFlagList["startTime"]then

self.reqFlagList["startTime"]=true
req38_45=true
end

if endTime+3<=curTime and not self.reqFlagList["endTime"]then

self.reqFlagList["endTime"]=true
req38_45=true
end
if req38_45 then
XiWeiSaiController.req_38_45()
end
local stopFight=XiWeiSaiModel:getConfig_stopFightTime()

if stopFight<=curTime and not self.reqFlagList["stopFight"]then

self.reqFlagList["stopFight"]=true
reddotControl.on_change_catch_type(CATCH_TYPE.eWenDingCangQiong)
end
end

function XiWeiSaiController.onNewDay()
local data=XiWeiSaiModel:getData()
data.fightCnt=0
UIManager:invokeUIMethod("UIWDCQHaiXuanWin","refreshChallengeCnt")
end

function XiWeiSaiController:checkGameDoFunc()
local gameStartFlag=XiWeiSaiController:getGameStartFlag()

if XiWeiSaiController.checkIntheGame()then
if not gameStartFlag then
XiWeiSaiController:newGameOpen()
XiWeiSaiController:saveGameStartFlag(true)
end
else

if gameStartFlag then
XiWeiSaiController:GameFinish()
XiWeiSaiController:saveGameStartFlag(false)
end
end

if not self.reqFlagList["loginFlag"]and XiWeiSaiController.checkShowTipsWin()then
self.reqFlagList["loginFlag"]=true
local args={}
args.endTime=XiWeiSaiModel:getConfig_stopFightTime()
args.leftCnt=XiWeiSaiController.getLeftChallengeCnt()

msgWinControl:addMsgWin(msgWinType.eXWSTips,args,nil,true)
end
end

function XiWeiSaiController:newGameOpen()

end

function XiWeiSaiController:GameFinish()

WDCQController.req_38_1()

local rank=XiWeiSaiController.getPlayerRank()
if rank then
local group=XiWeiSaiModel:getData_group()
msgWinControl:addMsgWin(msgWinType.eXWSRank,{group=group,pos=rank},nil,true)
if rank<=32 then
msgWinControl:addMsgWin(msgWinType.eWDCQYQCS,{group=group,rank=rank},nil,true)
end
end

end



function XiWeiSaiController.changeCfgTime(N,hour,min,nextFlag)
local startTime=XiWeiSaiModel:getData_startTime()
if nextFlag then
local _,nextTime=UIXianFaWenDaoControl:getNextSessionTime()
if nextTime then
local zerolongStamp=timeHelper.getServerZeroStamp(timeHelper.convertLongStamp(nextTime))
local zeroShortStamp=timeHelper.convertShortStamp(zerolongStamp)
startTime=zeroShortStamp
else

end
else
if startTime==0 then

if WDCQController.checkInTheGame()then
local wdcqstartTime=WDCQModel:getData_startTime()
local xwsend_time=cfgHelper.get2(cfg_wendingcangqionghaixuanconfig_get,1,'end_time')
startTime=wdcqstartTime-xwsend_time[1]*86400
else
local xfwdEndTime=UIXianFaWenDaoControl:getSessionEndTime()
if xfwdEndTime then
local zerolongStamp=timeHelper.getServerZeroStamp(timeHelper.convertLongStamp(xfwdEndTime))
local zeroShortStamp=timeHelper.convertShortStamp(zerolongStamp)
startTime=zeroShortStamp
else

end
end

end
end
local targetTime=startTime+N*86400+hour*3600+min*60
return targetTime
end


function XiWeiSaiController.getGameState()
if XiWeiSaiController.checkIntheGame()then
local curTime=timeHelper.getServerShortTime()
local stopFightTime=XiWeiSaiModel:getConfig_stopFightTime()
if curTime<stopFightTime then
return XWSStateEnum.eInGame,XWSSubStateEnum.eFight
else
return XWSStateEnum.eInGame,XWSSubStateEnum.eJieSuan
end
end


if WDCQController.checkInTheGame()then
return XWSStateEnum.eAfterGame,XWSSubStateEnum.eNone
end

local curTime=timeHelper.getServerShortTime()
local startTime=XiWeiSaiModel:getConfig_startTime()
local endTime=XiWeiSaiModel:getConfig_endTime()
if curTime<startTime then
return XWSStateEnum.ePreGame,XWSSubStateEnum.eNone
elseif startTime<=curTime and curTime<endTime then
local stopFightTime=XiWeiSaiModel:getConfig_stopFightTime()
if curTime<stopFightTime then
return XWSStateEnum.eInGame,XWSSubStateEnum.eFight
else
return XWSStateEnum.eInGame,XWSSubStateEnum.eJieSuan
end
else
return XWSStateEnum.eAfterGame,XWSSubStateEnum.eNone
end
end


function XiWeiSaiController.getLeftChallengeCnt()
local allFighCnt=cfgHelper.get2(cfg_wendingcangqionghaixuanconfig_get,1,'daily_fight_cnt')
local fightCnt=XiWeiSaiModel:getData_fightCnt()

return allFighCnt-fightCnt
end


function XiWeiSaiController.getPlayerRank()












local pos=XiWeiSaiModel:getData_pos()
if pos==0 then
return
end
return pos
end

function XiWeiSaiController.getPosCfg(group,posid)
local cfg=cfg_wendingcangqionghaixuanposconfig()
local groupCfg=cfg[group]
local posCfg=groupCfg[posid]
return posCfg
end

function XiWeiSaiController.getPosInfo(group,pos)
local posData=XiWeiSaiModel:getData_groupPos(group,pos)
local posCfg=XiWeiSaiController.getPosCfg(group,pos)
if not posCfg then

return
end
local mon_group_conf=posCfg.mon_group_conf
if not posData and not mon_group_conf then
return
end
local info={}
info.group=group
info.pos=pos
info.chanllgeFlag=XiWeiSaiController.checkPosCanchallenge(pos)
if posData and mathHelper.validInt64(posData.actor_id)then
info.isRobot=false
info.fight=mathHelper.int64_to_number(posData.fight)
info.name=posData.actor_name
local serverName=loginModel:getServerName(posData.server_id)
info.serverNmae=serverName
info.iconInfo=posData.iconInfo
local win_times=posData.win_times
local protect_sec=XiWeiSaiModel:getConfig_protect_sec()
info.protect_sec=protect_sec
info.win_times=win_times
info.isSelfPos=XiWeiSaiController.getPlayerRank()==pos
info.actorId=posData.actor_id
info.serverId=posData.server_id
else
info.isRobot=true
info.fight=posCfg.mon_fight
local monGounpId=mon_group_conf[1]
local mcfg=cfgHelper.get1(cfg_monstergroup_get,monGounpId)
info.name=mcfg.name
info.iconInfo={actoricon=0}
info.serverNmae=loginModel:getMyServerName()
end
return info
end

function XiWeiSaiController.getMaxRank()
return 64
end


function XiWeiSaiController.getDefendTeamData()
local team=XiWeiSaiModel:getData_teamList()
if not team then
team=UIXianFaWenDaoControl:getTeam()
end
local teamData={{},{},{}}
for i,v in ipairs(team or{})do
local dzId=tostring(v)
if dzId~='0'then
local tId=math.floor((i-1)/5)+1
local pId=(i-1)%5+1
local tdata=teamData[tId]
tdata[dzId]={pId,1,v}
end
end
return teamData
end


function XiWeiSaiController.getDefendTeamDataEx()
local team=XiWeiSaiModel:getData_teamList()
if not team then
team=UIXianFaWenDaoControl:getTeam()
end
local teamData={{},{},{}}
for i,v in ipairs(team or{})do
local dzId=tostring(v)
if dzId~='0'then
local tId=math.floor((i-1)/5)+1
local pId=(i-1)%5+1
local tdata=teamData[tId]
tdata[pId]={pId,1,v}
end
end
return teamData
end


function XiWeiSaiController.getFightTeamData()
local team=XiWeiSaiController:getFightTeam()
if team then
local teamData={{},{},{}}
for i,v in ipairs(team)do
if v~='0'then
local dzId=int64.new(v)
local dzData=UIDiscipleModel:getDiscipleData(dzId)
if dzData then
local tId=math.floor((i-1)/5)+1
local pId=(i-1)%5+1
local tdata=teamData[tId]
tdata[dzId]={pId,1,dzId}
end
end
end
return teamData
end
end


function XiWeiSaiController.getFightTeamDataEx()
local team=XiWeiSaiController:getFightTeam()
if team then
local teamData={{},{},{}}
for i,v in ipairs(team)do
if v~='0'then
local dzId=int64.new(v)
local dzData=UIDiscipleModel:getDiscipleData(dzId)
if dzData then
local tId=math.floor((i-1)/5)+1
local pId=(i-1)%5+1
local tdata=teamData[tId]
tdata[pId]={pId,1,dzId}
end
end
end
return teamData
end
end

function XiWeiSaiController:getFightResultData(data)
local rewards,rankInfo,tips

local sendExtraArgs=fightModel:getSendExtraArgs(eBattleType.wdcqxiweisai)
local group=data.big_group_id
local posid=data.pos_id
local posCfg=XiWeiSaiController.getPosCfg(group,posid)
local oldPos=sendExtraArgs and sendExtraArgs.oldPos or XiWeiSaiController.getPlayerRank()
local result=data.result
if result then
rewards=posCfg.win_rewards
rankInfo={}
if oldPos then
if(oldPos-posid)>0 then
rankInfo.rank=FMT.fmt('<color=#7D3B17>席位：{0}</color>',posid)
local rankIcon={}
rankIcon.abName=globalABLookup.global
rankIcon.assetName='icon_jiantou_1'
rankInfo.rankIcon=rankIcon
rankInfo.rankNum=FMT.fmt('<color=green>{0}</color>',oldPos-posid)
else
rankInfo.rank=FMT.fmt('<color=#7D3B17>席位：{0}</color>',oldPos)
end
else
rankInfo.rank=FMT.fmt('<color=#7D3B17>席位：{0}</color>',posid)
end
else
rewards=posCfg.fail_rewards
if oldPos then
rankInfo={rank=FMT.fmt('<color=#7D3B17>席位：{0}</color>',oldPos)}
end
end
return rewards,rankInfo,tips
end

function XiWeiSaiController.getDefendTeamFight()
local teamList=XiWeiSaiController.getDefendTeamData()
local fight=0
for i,v in ipairs(teamList)do
for dzId,vv in pairs(v)do
fight=fight+UIDiscipleModel:getDiscipleFightValue(dzId)
end
end
return fight
end





function XiWeiSaiController.checkIntheGame()
local startTime=XiWeiSaiModel:getData_startTime()
return startTime~=0
end


function XiWeiSaiController.checkInFightTime()
if not XiWeiSaiController.checkIntheGame()then
return false
end
local curTime=timeHelper.getServerShortTime()
local stopFightTime=XiWeiSaiModel:getConfig_stopFightTime()
if curTime<stopFightTime then
return true
end
return false
end


function XiWeiSaiController.checkInJieSuanTime()
if not XiWeiSaiController.checkIntheGame()then
return false
end
local curTime=timeHelper.getServerShortTime()
local stopFightTime=XiWeiSaiModel:getConfig_stopFightTime()
local endTime=XiWeiSaiModel:getConfig_endTime()
if stopFightTime<=curTime and curTime<=endTime then
return true
end
return false
end


function XiWeiSaiController.checkGamePlayerFlag()
local xfwdStage=XiWeiSaiModel:getData_xfwdStage()
local cfgxfwdstage=cfgHelper.get2(cfg_wendingcangqionghaixuanconfig_get,1,'wfwd_stage')
return xfwdStage>=cfgxfwdstage
end


function XiWeiSaiController.checkChallengeCnt()
local leftChallengeCnt=XiWeiSaiController.getLeftChallengeCnt()
return leftChallengeCnt>0
end


function XiWeiSaiController.checkPosCanchallenge(pos)
local maxRank=XiWeiSaiController.getMaxRank()
local selfRank=XiWeiSaiController.getPlayerRank()or maxRank+1
if selfRank==pos then
return false
end
if pos>selfRank then
return true
end
local pre_rank=cfgHelper.get2(cfg_wendingcangqionghaixuanconfig_get,1,'pre_rank')
for i=1,pre_rank do
local targetpos=selfRank-i
if targetpos==pos then
return true
end
end
return false,pre_rank
end

function XiWeiSaiController.checkTeamSame(selectDzList)
local teamList=XiWeiSaiModel:getData_teamList()
if not teamList or not selectDzList then
return false
end
for i,v in ipairs(teamList)do
if not mathHelper.compareInt64(v,selectDzList[i])then
return false
end
end
return true
end

function XiWeiSaiController.checkSysDz(guid)
if not XiWeiSaiController.checkSysOpen()then
return false
end
if not XiWeiSaiController.checkIntheGame()then
return false
end
if not XiWeiSaiController.checkGamePlayerFlag()then
return false
end
local team=XiWeiSaiModel:getData_teamList()



if team then
for i,v in ipairs(team or{})do







if guid==v then
return true
end
end
end
return false
end

function XiWeiSaiController.checkShowTipsWin()

if not XiWeiSaiController.checkSysOpen()then
return false
end
if not XiWeiSaiController.checkIntheGame()then
return false
end
if not XiWeiSaiController.checkGamePlayerFlag()then
return false
end
if XiWeiSaiController.getLeftChallengeCnt()<=0 then
return false
end
if not XiWeiSaiController.checkInFightTime()then
return false
end

if not XiWeiSaiController:getShowTipsWinFlag()then
return false
end

local curTime=timeHelper.getServerShortTime()
local endTime=XiWeiSaiModel:getConfig_endTime()
local left=endTime-curTime
if left>0 and left<86400 then
return true
end
end

function XiWeiSaiController.checkSysReddot()

if not XiWeiSaiController.checkSysOpen()then
return false
end
if not XiWeiSaiController.checkIntheGame()then
return false
end
if not XiWeiSaiController.checkGamePlayerFlag()then
return false
end
if XiWeiSaiController.getLeftChallengeCnt()<=0 then
return false
end
if not XiWeiSaiController.checkInFightTime()then
return false
end
return true
end





function XiWeiSaiController:setSkipFightState(skip)
self.skipFightState=skip
end

function XiWeiSaiController:isSkipFight()
return self.skipFightState==true
end

function XiWeiSaiController.onCompleteBattle(result,sdata)
local data=XiWeiSaiModel:getData()
data.fightCnt=data.fightCnt and data.fightCnt+1 or 1
reddotControl.on_change_catch_type(CATCH_TYPE.eWenDingCangQiong)



if result==1 then
local group=sdata.big_group_id
local newPos=sdata.pos_id
if data.grouplookUpList and data.grouplookUpList[group]then
local groupdata=data.grouplookUpList[group]
local oldPos=XiWeiSaiController.getPlayerRank()
if oldPos and oldPos<=newPos then
return
end

if oldPos then
local olddata=groupdata[oldPos]
local newData=groupdata[newPos]

if newData then

newData.pos_id=oldPos

end
olddata.pos_id=newPos
olddata.win_times=timeHelper.getServerShortTime()
groupdata[oldPos]=newData
groupdata[newPos]=olddata
else
local wdqchxPosInfo={
pos_id=newPos,
actor_id=playerModel:getActorID(),
actor_name=playerModel:getActorName(),
server_id=playerModel:getActorServerID(),
fight=XiWeiSaiController.getDefendTeamFight(),
win_times=timeHelper.getServerShortTime(),
iconInfo=playerModel:getActorIconInfo(),
}
groupdata[newPos]=wdqchxPosInfo
end
local data=XiWeiSaiModel:getData()
data.pos_id=newPos
end
end
end





function XiWeiSaiController:saveGameStartFlag(flag)
self:saveData('GameStartFlag',flag)
end

function XiWeiSaiController:getGameStartFlag()
local flag=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXiWeiSai,'GameStartFlag',false)
return flag
end

function XiWeiSaiController:saveFightTeam(team)
self:saveData('FIGHT_TEAM_DATA',team)
end

function XiWeiSaiController:getFightTeam()
local team=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXiWeiSai,'FIGHT_TEAM_DATA',nil)
return team
end

function XiWeiSaiController:saveChangeWinShowTime(ison)
local time=0
if ison then
time=timeHelper.getServerShortTime()
end
self:saveData('ChangeWinShowTime',time)
end


function XiWeiSaiController:getShowChangeWinFlag()
local time=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXiWeiSai,'ChangeWinShowTime',0)
if time==0 then
return true
end
return not timeHelper.isTodayShort(time)
end

function XiWeiSaiController:saveTipsWinShowTime(ison)
local time=0
if ison then
time=timeHelper.getServerShortTime()
end
self:saveData('TipsWinShowTime',time)
end


function XiWeiSaiController:getShowTipsWinFlag()
local time=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXiWeiSai,'TipsWinShowTime',0)
if time==0 then
return true
end
return not timeHelper.isTodayShort(time)
end


function XiWeiSaiController:saveChangeWinShowLogTime(logTime)
self:saveData('ChangeWinShowLogTime',logTime)
end

function XiWeiSaiController:getChangeWinShowLogTime()
local time=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXiWeiSai,'ChangeWinShowLogTime',nil)
return time
end

function XiWeiSaiController:saveData(key,value)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eXiWeiSai,key,value)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXiWeiSai)
end







