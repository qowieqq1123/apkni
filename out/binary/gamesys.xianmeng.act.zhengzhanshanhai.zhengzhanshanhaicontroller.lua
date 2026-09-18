








local _MODULENAME="zhengzhanshanhaiController"
gameState.addListener(def_table(_MODULENAME))
zhengzhanshanhaiController.name=_MODULENAME

local nexRaceData=nil
local enterMark=nil
local openQingBaoMark=nil
local openQingBaoMark_xm=nil
local openXMJiJieMark=nil
local openCollectMark=nil
local listenMark=nil

function zhengzhanshanhaiController:clearListenMark()
listenMark=nil

zhengzhanshanhaiModel:timeOutMapData()
zhengzhanshanhaiModel:timeOutPvPOrder()
zhengzhanshanhaiModel:timeOutPvETeams()
zhengzhanshanhaiModel:timeOutPvPTargets()
end

function zhengzhanshanhaiController:onAppStart()

zhengzhanshanhaiController:onAppStart_initial()
zhengzhanshanhaiController:onAppStart_season()

zhengzhanshanhaiController:onAppStart_log()
zhengzhanshanhaiController:onAppStart_pvp()
zhengzhanshanhaiController:onAppStart_weekTask()
zhengzhanshanhaiController:onAppStart_zhanling()
zhengzhanshanhaiController:onAppStart_yubeidui()
zhengzhanshanhaiController:onAppStart_Rank()
end

function zhengzhanshanhaiController:onEnterState(isReconnet)
zhengzhanshanhaiModel:initDefaultData()
zhengzhanshanhaiController:onEnterState_log(isReconnet)
zhengzhanshanhaiController:onEnterState_pvp(isReconnet)
zhengzhanshanhaiController:onEnterState_zhanling(isReconnet)
zhengzhanshanhaiController:onEnterState_yubeidui(isReconnet)
zhengzhanshanhaiController:onEnterState_Rank(isReconnet)
zhengzhanshanhaiController:onEnterState_season(isReconnet)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.isRefreshScroll)
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:listenNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
end

function zhengzhanshanhaiController.onNewDay5am(islogin)
if not islogin then
for i=1,5 do
zhengzhanshanhaiModel:setTreasureBoxData_initial(i,0,true)
zhengzhanshanhaiModel:setTreasureBoxData_season(i,0,true)
end
UIManager:invokeUIMethod('UIXM_ZZSH_TreasureBoxWin','refresh')

end
end

function zhengzhanshanhaiController.onLimitActStateChange(actID,state,isNew)
if actID~=LIMIT_ACT_TYPE.eZhengZhanShanHai then return end
if state==limitActivitiesModel.actPreviewState then


elseif state==limitActivitiesModel.actDoingState then


if not isNew then

end
elseif state==limitActivitiesModel.actIdleState then


elseif state==limitActivitiesModel.actFinishState then




end
end

function zhengzhanshanhaiController.isRefreshScroll(moneytype,lastVal,val)
local isRefresh=false
local tab={eMoneyType.mtBaoXia1,eMoneyType.mtBaoXia2,eMoneyType.mtBaoXia3,eMoneyType.mtBaoXia4,eMoneyType.mtBaoXia5}
local boxKeyList_lookup=zhengzhanshanhaiModel:getBXKeyLookupList()











if boxKeyList_lookup[moneytype]then
isRefresh=true
UIManager:invokeUIMethod('UIXM_ZZSH_TreasureBoxWin','refreshScroll')
end

if isRefresh then
notifySystem:postNotify(notifyConfig.onBaoXiaReddotChange)
end
end

function zhengzhanshanhaiController:onLeaveState(isReconnet)
zhengzhanshanhaiController:onLeaveState_log(isReconnet)
zhengzhanshanhaiController:onLeaveState_pvp(isReconnet)
zhengzhanshanhaiController:onLeaveState_zhanling(isReconnet)
zhengzhanshanhaiController:onLeaveState_yubeidui(isReconnet)
zhengzhanshanhaiController:onLeaveState_Rank(isReconnet)
zhengzhanshanhaiController:onLeaveState_season(isReconnet)
zhengzhanshanhaiModel:clearData()
nexRaceData=nil
enterMark=nil
openQingBaoMark=nil
openQingBaoMark_xm=nil
openXMJiJieMark=nil
openCollectMark=nil
listenMark=nil
self.fightReady=nil

notifySystem:removelistener(notifyConfig.on_money_changed,self.isRefreshScroll)
notifySystem:removelistener(notifyConfig.onBaoXiaReddotChange,self.fresh)
notifySystem:removelistener(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:removelistener(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
end

function zhengzhanshanhaiController:onProtocolReq(isReconnet)
zhengzhanshanhaiController:onProtocolReq_zhanling(isReconnet)
end

function zhengzhanshanhaiController:onProtocolReqKF(isReconnet)
zhengzhanshanhaiController:onProtocolReq_log(isReconnet)
end

function zhengzhanshanhaiController:onProtocolReqLargeZZSHKF(isReconnet)

zhengzhanshanhaiModel:set_sendtime(0)
zhengzhanshanhaiController:onProtocolReq_log(isReconnet)
end

function zhengzhanshanhaiController:onLostConnection()

end

function zhengzhanshanhaiController:activeActivity(isChangeSeason)
if not isChangeSeason and not zhengzhanshanhaiModel:checkInit()then
return
end

local actID=LIMIT_ACT_TYPE.eZhengZhanShanHai
local actcfg=limitActivitiesModel:getActConfig(actID)
if limitActivitiesModel.checkActForbidden(actcfg)then
return
end

local s_t,e_t,raceIndex=zhengzhanshanhaiController:calculateTime()
limitActivitiesModel:addClientAct_lt(LIMIT_ACT_TYPE.eZhengZhanShanHai,s_t,e_t)
zhengzhanshanhaiModel:setRaceIndex(raceIndex)

local s_t_,e_t_,raceIndex_=zhengzhanshanhaiController:calculateTime(e_t+1)
nexRaceData={s_t_,e_t_,raceIndex_}
end

function zhengzhanshanhaiController:calculateTime(curTime)
curTime=curTime or gameUtilityModel.getServerLongTime()
local cfg=zhengzhanshanhaiController:getZZSHCfg()
local f_o_time
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
local startTime,endTime,settleTime=zhengzhanshanhaiModel:getSeasonTime()
if shSeasonId==-1 then
f_o_time=timeHelper.dataToTimeStam(cfg.start)
else
f_o_time=startTime
end
local o_y,o_m,o_d=timeHelper.getDateNumber(f_o_time)
local f_o_time_=timeHelper.timeServer(o_y,o_m,o_d,0,0,0)
f_o_time=f_o_time_+cfg.week[1][1]
local f_e_time
if not endTime then
f_e_time=f_o_time_+cfg.battle*7*86400
else
f_e_time=endTime
end


local s_t,e_t,raceIndex
if shSeasonId==-1 then
if curTime<=f_e_time then
raceIndex=1
s_t=f_o_time
e_t=f_e_time
else
local lerp=curTime-f_e_time
local round_time=(cfg.battle+cfg.truce)*7*86400
local round=math.floor(lerp/round_time)
raceIndex=1+round+1
local o_t=f_e_time+round*round_time
s_t=o_t+cfg.truce*7*86400
e_t=s_t+cfg.battle*7*86400
end
else
if curTime<=f_e_time then
s_t=f_o_time
e_t=f_e_time
raceIndex=shSeasonId
else
local nextSeasonId=shSeasonId+1
local next_startTime,next_endTime,next_settleTime=zhengzhanshanhaiModel:getSeasonTimeBySHSeasonId(nextSeasonId)
s_t=next_startTime
e_t=next_endTime
raceIndex=nextSeasonId
end
end

return s_t,e_t,raceIndex
end

function zhengzhanshanhaiController:activeActivity2()
if not zhengzhanshanhaiModel:checkInit()then
return
end

local actID=LIMIT_ACT_TYPE.eZhengZhanShanHai
local actcfg=limitActivitiesModel:getActConfig(actID)
if limitActivitiesModel.checkActForbidden(actcfg)then
return
end

local s_t,e_t,raceIndex=zhengzhanshanhaiModel:getRaceData()
if s_t then
limitActivitiesModel:addClientAct_lt(LIMIT_ACT_TYPE.eZhengZhanShanHai,s_t,e_t)
zhengzhanshanhaiModel:setRaceIndex(raceIndex)

local s_t_,e_t_,raceIndex_=zhengzhanshanhaiModel:getRaceData(e_t+1)
if s_t_ then
nexRaceData={s_t_,e_t_,raceIndex_}
end
end
end

function zhengzhanshanhaiController:getNextRaceData()
return nexRaceData
end

function zhengzhanshanhaiController:setEnterMark(flag)
enterMark=flag
end

function zhengzhanshanhaiController:checkEnterMark()
return enterMark==true
end

function zhengzhanshanhaiController:setOpenQingBaoMark(guid,baodiflag)
if guid then
openQingBaoMark={guid,baodiflag}
else
openQingBaoMark=nil
end
end

function zhengzhanshanhaiController:getOpenQingBaoMark()
return openQingBaoMark
end

function zhengzhanshanhaiController:openQingBaoDetail(guid,flag)
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData then
if qbData.infotype==zhengzhanshanhaiModel.qbType.eMonster then
if UIManager:isActive('UIXM_ZZSH_monsterInfoWin')then
if UIManager:invokeUIMethod('UIXM_ZZSH_monsterInfoWin','containQBGuid',guid)then
UIManager:invokeUIMethod('UIXM_ZZSH_monsterInfoWin','refreshView',guid)
else
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','move2GridPos',qbData.x,qbData.y,0,false,1,function(view)
UIManager:invokeUIMethod('UIXM_ZZSH_monsterInfoWin','refreshView',guid)
end)
end
else
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','move2GridPos',qbData.x,qbData.y,0,false,1,function(view)
UIManager:showWindow('UIXM_ZZSH_monsterInfoWin',{qbGuid=guid,view=view})
end)
end
else
if UIManager:isActive('UIXM_ZZSH_resourceInfoWin')then
if UIManager:invokeUIMethod('UIXM_ZZSH_resourceInfoWin','containQBGuid',guid)then
UIManager:invokeUIMethod('UIXM_ZZSH_resourceInfoWin','refreshView',guid)
else
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','move2GridPos',qbData.x,qbData.y,0,false,1,function(view)
UIManager:invokeUIMethod('UIXM_ZZSH_resourceInfoWin','refreshView',guid)
end)
end
else
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','move2GridPos',qbData.x,qbData.y,0,false,1,function(view)
UIManager:showWindow('UIXM_ZZSH_resourceInfoWin',{qbGuid=guid,view=view,baodiflag=flag})
end)
end
end
end
end

function zhengzhanshanhaiController:setOpenQingBaoMark_xm(guid)
openQingBaoMark_xm=guid
end

function zhengzhanshanhaiController:getOpenQingBaoMark_xm()
return openQingBaoMark_xm
end

function zhengzhanshanhaiController:openQingBaoDetail_xm(guid)
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData then
if UIManager:isActive('UIXM_ZZSH_MapWin')then
if qbData.infotype==zhengzhanshanhaiModel.qbType.eMonster then
local teamData=zhengzhanshanhaiModel:getMyPvETeam(guid,qbData.infotype)
if teamData then

UIManager:showWindow('UIXM_ZZSH_monsterMyTeamWin',{qbGuid=guid})
end
else

end
end
end
end

function zhengzhanshanhaiController:setOpenCollectMark(flag)
openCollectMark=flag
end

function zhengzhanshanhaiController:getOpenCollectMark()
return openCollectMark
end

function zhengzhanshanhaiController:setOpenXMJiJieMark(flag)
openXMJiJieMark=flag
end

function zhengzhanshanhaiController:getOpenXMJiJieMark()
return openXMJiJieMark
end

function zhengzhanshanhaiController:openXMJiJie()
if UIManager:isActive('UIXM_ZZSH_MapWin')then
local page=1

if zhengzhanshanhaiModel:getPvEJiJieDatasNum()==0 and zhengzhanshanhaiModel:getPvEBaodiDatasNum()>0 then
page=2
else
page=1
end
UIManager:showWindow('UIXM_ZZSH_noteWin',{page=page})



end
end

function zhengzhanshanhaiController:finishFightOpen(args)
limitActivitiesController:jump(LIMIT_ACT_TYPE.eZhengZhanShanHai,args)
end

function zhengzhanshanhaiController:initBattleDZ(d)
d.checkState=function(guid,isWarning)

return zhengzhanshanhaiModel:checkDZFree(guid,isWarning)
end
d.getStateIcon=function(guid)
local infotype=zhengzhanshanhaiModel:checkDZInMyWaiPai(guid)
if infotype then
if infotype==zhengzhanshanhaiModel.qbType.eMonster then
return'image_jijieizhong',globalABLookup.globa4
else
return'image_caijizhong',globalABLookup.globa4
end
end
return nil,nil
end
d.checkMask=function(guid)
local infotype=zhengzhanshanhaiModel:checkDZInMyWaiPai(guid)
if infotype then
return true
end
return false
end
end

function zhengzhanshanhaiController:showMonsterReward(guid)
local args={}
args.titleName='奖励详情'
args.pos=2
args.extraWin='UIXM_ZZSH_monsterRewardShowWin'
args.extraParams={qbGuid=guid}
UIManager:showWindow('UICommonPageWin',args)
end

function zhengzhanshanhaiController:checkInMap()
return UIManager:isActive('UIXM_ZZSH_MapWin')
end

function zhengzhanshanhaiController:openXMDetailInfoWin(guildid)
local isNeedReqXmDetail=true
local xmData=zhengzhanshanhaiModel:getXMData(guildid)
if xmData and xmData.cross_id then
isNeedReqXmDetail=false
end

if isNeedReqXmDetail then
xianmengController:reqXMDetailData(guildid)
end
UIManager:showWindow('UIXM_ZZSH_xmWin',{guildid=guildid})
end

function zhengzhanshanhaiController:setFigthReady(flag)
self.fightReady=flag
end

function zhengzhanshanhaiController:checkFigthReady()
return self.fightReady==true
end




function zhengzhanshanhaiController:reqInfo1()

end


function zhengzhanshanhaiController:reqInfo2()
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
return zhengzhanshanhaiController:reqInfo2_season()
else
return zhengzhanshanhaiController:reqInfo2_initial()
end
end


function zhengzhanshanhaiController:reqSetTeam(guidList)

local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
return zhengzhanshanhaiController:reqSetTeam_season(guidList)
else
return zhengzhanshanhaiController:reqSetTeam_initial(guidList)
end
end


function zhengzhanshanhaiController:reqMapListen(falg)


local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
return zhengzhanshanhaiController:reqMapListen_season(falg)
else
return zhengzhanshanhaiController:reqMapListen_initial(falg)
end
end


function zhengzhanshanhaiController:reqJoin()
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
return zhengzhanshanhaiController:reqJoin_season()
else
return zhengzhanshanhaiController:reqJoin_initial()
end
end


function zhengzhanshanhaiController:reqMove(x,y)


local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
return zhengzhanshanhaiController:reqMove_season(x,y)
else
return zhengzhanshanhaiController:reqMove_initial(x,y)
end
end


function zhengzhanshanhaiController:reqSearch()
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
return zhengzhanshanhaiController:reqSearch_season()
else
return zhengzhanshanhaiController:reqSearch_initial()
end
end


function zhengzhanshanhaiController:reqXMJiJie()
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
return zhengzhanshanhaiController:reqXMJiJie_season()
else
return zhengzhanshanhaiController:reqXMJiJie_initial()
end
end


function zhengzhanshanhaiController:reqSHBaodi()
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
return zhengzhanshanhaiController:reqSHBaodi_season()
else
return zhengzhanshanhaiController:reqSHBaodi_initial()
end
end


function zhengzhanshanhaiController:reqOpenBaoXia(len,list,flag,isSeason,prizeType)
if isSeason then
return zhengzhanshanhaiController:reqOpenBaoXia_season(len,list,flag,prizeType)
else
return zhengzhanshanhaiController:reqOpenBaoXia_initial(len,list,flag,prizeType)
end
end


function zhengzhanshanhaiController:reqMonsterDetail(guid)

local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
return zhengzhanshanhaiController:reqMonsterDetail_season(guid)
else
return zhengzhanshanhaiController:reqMonsterDetail_initial(guid)
end
end


function zhengzhanshanhaiController:reqResourceDetail(guid)

local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
return zhengzhanshanhaiController:reqResourceDetail_season(guid)
else
return zhengzhanshanhaiController:reqResourceDetail_initial(guid)
end
end


function zhengzhanshanhaiController:reqMonsterJiJie(guid,setoutnum,dzlist)






local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
return zhengzhanshanhaiController:reqMonsterJiJie_season(guid,setoutnum,dzlist)
else
return zhengzhanshanhaiController:reqMonsterJiJie_initial(guid,setoutnum,dzlist)
end
end


function zhengzhanshanhaiController:reqMonsterJion(guid,dzlist)



local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
return zhengzhanshanhaiController:reqMonsterJion_season(guid,dzlist)
else
return zhengzhanshanhaiController:reqMonsterJion_initial(guid,dzlist)
end
end


function zhengzhanshanhaiController:reqMonsterGo(guid)

local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
return zhengzhanshanhaiController:reqMonsterGo_season(guid)
else
return zhengzhanshanhaiController:reqMonsterGo_initial(guid)
end
end


function zhengzhanshanhaiController:reqMonsterChange(guid,setoutnum)




local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
return zhengzhanshanhaiController:reqMonsterChange_season(guid,setoutnum)
else
return zhengzhanshanhaiController:reqMonsterChange_initial(guid,setoutnum)
end
end


function zhengzhanshanhaiController:reqMonsterJiJieKickout(guid,taractorid)


local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
return zhengzhanshanhaiController:reqMonsterJiJieKickout_season(guid,taractorid)
else
return zhengzhanshanhaiController:reqMonsterJiJieKickout_initial(guid,taractorid)
end
end


function zhengzhanshanhaiController:reqMonsterXMDetail(guid)

local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
return zhengzhanshanhaiController:reqMonsterXMDetail_season(guid)
else
return zhengzhanshanhaiController:reqMonsterXMDetail_initial(guid)
end
end


function zhengzhanshanhaiController:reqMonsterZhaoJi(guid)

local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
return zhengzhanshanhaiController:reqMonsterZhaoJi_season(guid)
else
return zhengzhanshanhaiController:reqMonsterZhaoJi_initial(guid)
end
end


function zhengzhanshanhaiController:reqResourceCollect(guid,dzlist)



local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
return zhengzhanshanhaiController:reqResourceCollect_season(guid,dzlist)
else
return zhengzhanshanhaiController:reqResourceCollect_initial(guid,dzlist)
end
end


function zhengzhanshanhaiController:reqPvETeamBack(guid)

local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
return zhengzhanshanhaiController:reqPvETeamBack_season(guid)
else
return zhengzhanshanhaiController:reqPvETeamBack_initial(guid)
end
end


function zhengzhanshanhaiController:reqMonsterJiJieDel(guid)

local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
return zhengzhanshanhaiController:reqMonsterJiJieDel_season(guid)
else
return zhengzhanshanhaiController:reqMonsterJiJieDel_initial(guid)
end
end


function zhengzhanshanhaiController:reqZCMomentRankData()
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
return zhengzhanshanhaiController:reqZCMomentRankData_season()
else
return zhengzhanshanhaiController:reqZCMomentRankData_initial()
end
end


function zhengzhanshanhaiController:reqXMMomentRankData()
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
return zhengzhanshanhaiController:reqXMMomentRankData_season()
else
return zhengzhanshanhaiController:reqXMMomentRankData_initial()
end
end


function zhengzhanshanhaiController:reqBZMomentRankData()
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
return zhengzhanshanhaiController:reqBZMomentRankData_season()
else
return zhengzhanshanhaiController:reqBZMomentRankData_initial()
end
end


function zhengzhanshanhaiController:reqRaceXMRankData()
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
return zhengzhanshanhaiController:reqRaceXMRankData_season()
else
return zhengzhanshanhaiController:reqRaceXMRankData_initial()
end
end


function zhengzhanshanhaiController:reqlocalXMData()
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
return zhengzhanshanhaiController:reqlocalXMData_season()
else
return zhengzhanshanhaiController:reqlocalXMData_initial()
end
end


function zhengzhanshanhaiController:reqHisData()
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
return zhengzhanshanhaiController:reqHisData_season()
else
return zhengzhanshanhaiController:reqHisData_initial()
end
end





function zhengzhanshanhaiController.recv_getData(args,isSeason)










isSeason=isSeason or false
local isSetSettleTime=false
if isSeason then
local firstSeason_beginTime=args[7]
if firstSeason_beginTime==0 then

return
end

local serverIdLen=args[8]
local serverIdList=args[9]

zhengzhanshanhaiModel:setFirstSeasonBeginTime(firstSeason_beginTime)
zhengzhanshanhaiModel:setServerIdList(serverIdLen,serverIdList)

zhengzhanshanhaiModel:setSHSeasonId_DirtyMark()


zhengzhanshanhaiController.req_getZZSHZhanLingData()
else
local initialSeason_settleTime=args[7]
if initialSeason_settleTime~=0 then

zhengzhanshanhaiModel:setInitialSeasonSettleTime(initialSeason_settleTime)
isSetSettleTime=true
end
end

local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isSeason==isInSeason then

if args[6]then
zhengzhanshanhaiModel:Set_181_timedata(args[6])
end

local isInit=zhengzhanshanhaiModel:initData(args[2],args[3],nil)
if isInit then

end
zhengzhanshanhaiModel:setLDDailyReward(1,true)
end

if isSeason and not zhengzhanshanhaiModel:checkTreasureBoxDataIsInit_season()then

zhengzhanshanhaiModel:setTempTreasureBoxData_season(args[4],args[5])
end


if args[4]>0 then
for i=1,args[4]do
if isSeason then
zhengzhanshanhaiModel:setTreasureBoxData_season(args[5][i].param_1,args[5][i].param_2,true)
else

zhengzhanshanhaiModel:setTreasureBoxData_initial(args[5][i].param_1,args[5][i].param_2,true)
end
end
end

if isSeason or isSetSettleTime then

zhengzhanshanhaiController:refreshSeasonNextStateStamp()
end

end


function zhengzhanshanhaiController.recv_teamChange(guidlistlen,guidList)



UIManager.info('队伍修改成功')
if guidList then
zhengzhanshanhaiModel:setDefTeams(guidList)
end
end


function zhengzhanshanhaiController.recv_changeListenMark(flag)

if flag==1 then
listenMark=true
else
zhengzhanshanhaiController:clearListenMark()
end
end


function zhengzhanshanhaiController.recv_randomPos(x,y)



if not zhengzhanshanhaiModel:checkJoin()then
zhengzhanshanhaiModel:setJoin()
if UIManager:isActive('UIXM_ZZSH_MapWin')then
UIManager.info('报名成功')
zhengzhanshanhaiController:setEnterMark(true)
zhengzhanshanhaiController:reqMapListen(1)
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.begin_ZZSH_PVE)
end
end
end


function zhengzhanshanhaiController.recv_movePos(x,y)



UIManager.info('移动成功')
zhengzhanshanhaiModel:setMyXMGridPos(x,y)
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','rec_movePos')
UIManager:invokeUIMethod('UIXM_ZZSH_signWin','rec_movePos')
end




function zhengzhanshanhaiController.recv_getInfo(args,isSeason)





















zhengzhanshanhaiModel:initBaseData(args[1],args[2],args[5])
zhengzhanshanhaiModel:setPvEMoveTime(args[10])
zhengzhanshanhaiModel:initPvEWaiPaiDatas(args[3],args[4])
zhengzhanshanhaiModel:initPvEJoinDatas(args[6],args[7])
zhengzhanshanhaiModel:setJoinFightFlag(args[8])
zhengzhanshanhaiModel:setPvPAutoReverFlag(args[9])
if isSeason then
zhengzhanshanhaiModel:initTreasureBoxData_season()
zhengzhanshanhaiModel:checkTempTreasureBoxData_season()
end

local YbdData={args[11],args[12],args[13],args[14],args[15]}
zhengzhanshanhaiModel:initShanHaiYbdData(YbdData)

UIManager:invokeUIMethod('UIXM_ZZSH_PvEMainWin','rec_myWaiPiaList')
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','refreshFightModelBtn')

if isSeason then
zhengzhanshanhaiController:checkNeedResetActivity()
end
end


function zhengzhanshanhaiController.recv_getPrepareFightData(args)






























zhengzhanshanhaiModel:initMapData(args)
if zhengzhanshanhaiController:checkEnterMark()then
zhengzhanshanhaiController:setEnterMark(nil)

UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','onCreateXianMeng')
end
end


function zhengzhanshanhaiController.recv_getPVEData(len,targetList)











zhengzhanshanhaiModel:initPvETeams(len,targetList)
end


function zhengzhanshanhaiController.recv_releasePvEWaiPaiQingBaoTeam(guid,reason)



zhengzhanshanhaiModel:delPvEWaiPaiData(guid)
if UIManager:invokeUIMethod('UIXM_ZZSH_monsterMyTeamWin','containQBGuid',guid)==true then
UIManager:closeWindow('UIXM_ZZSH_monsterMyTeamWin')
end
if reason==1 then
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData~=nil and qbData.ojbID then

zhengzhanshanhaiModel:invokeFunc(qbData.ojbID,'activeFightEffect')
end
end
end


function zhengzhanshanhaiController.recv_getYiShouJiJieList(len,list)







zhengzhanshanhaiModel:initPvEJiJieDatas(len,list)
if zhengzhanshanhaiController:getOpenXMJiJieMark()then
zhengzhanshanhaiController:setOpenXMJiJieMark(nil)
zhengzhanshanhaiController:openXMJiJie()
end
end


function zhengzhanshanhaiController.recv_getPvEResourceDatas(len,list)
zhengzhanshanhaiModel:initPvEResourceDatas(len,list)
end


function zhengzhanshanhaiController.recv_openTreasureBox(len,list,isSeason)
for i=1,len do
local idx=list[i].param_1
local recv=list[i].param_2
if isSeason then
zhengzhanshanhaiModel:setTreasureBoxData_season(idx,recv)
else
zhengzhanshanhaiModel:setTreasureBoxData_initial(idx,recv)
end
end
UIManager:invokeUIMethod('UIXM_ZZSH_TreasureBoxWin','refresh')
UIManager:invokeUIMethod("UIXM_ZZSH_endTipsWin","refresh")
notifySystem:postNotify(notifyConfig.onBaoXiaReddotChange)
end





function zhengzhanshanhaiController.recv_getYiShouDetailData(args)




















local guid=args[1]
local lp={}
if args[3]>0 then
for i,v in ipairs(args[4])do
v.key=v.guildid
local xmData=zhengzhanshanhaiModel:getXMData(v.guildid)
v.guildname=xmData and xmData.guildname or''
v.key_str=tostring(v.guildid)
v.ismy=xianmengModel:isMyXM(v.guildid)
v.fight_num=mathHelper.int64_to_number(v.fight)
lp[v.key_str]=v
end
end
local lp2={}
if args[5]>0 then
for i,v in ipairs(args[6])do
local xmData=zhengzhanshanhaiModel:getXMData(v.guildid)
v.guildname=xmData and xmData.guildname or''
lp2[#lp2+1]=v
end
if args[5]>1 then
table.sort(lp2,function(a,b)
if a.damage~=b.damage then
return a.damage>b.damage
else
return a.guildid<b.guildid
end
end)
end
end
local detail={
percent=args[2],
teamNum=args[3],
allTeam=lp,
rankNum=args[5],
ranklist=lp2,
}
zhengzhanshanhaiModel:insertQingBaoDetail(guid,detail)
local qbMark=zhengzhanshanhaiController:getOpenQingBaoMark()
if qbMark~=nil then
zhengzhanshanhaiController:setOpenQingBaoMark(nil)
if qbMark[1]==guid then
zhengzhanshanhaiController:openQingBaoDetail(guid,qbMark[2])
end
end
UIManager:invokeUIMethod('UIXM_ZZSH_monsterInfoWin','refreshView',guid)
UIManager:invokeUIMethod('UIXM_ZZSH_selfPVETeamWin','rcv_qbDetail',guid)
UIManager:invokeUIMethod('UIXM_ZZSH_posInfoWin','rcv_qbDetail',guid)
end


function zhengzhanshanhaiController.recv_getBaoDiDetailData(args)

















local list={}
local myTeam=nil
local collectNum=0
if args[5]>0 then
for i,v in ipairs(args[6])do
v.key=v.actorid
v.key_str=tostring(v.actorid)
local isMy=playerModel:checkActorId(v.actorid)
v.isMy=isMy
v.isMyXM=xianmengModel:checkActorInXM(v.actorid)
local xmData=zhengzhanshanhaiModel:getXMData(v.guildid)
v.guildicon=xmData.guildicon
v.guildname=xmData.guildname
local fight_num=0
if v.disciplelistlen>0 then
for i,vv in ipairs(v.discipleList)do
if vv.flag>0 then
fight_num=fight_num+mathHelper.int64_to_number(vv.fightvalue)
end
end
end
v.fight_num=fight_num
table.insert(list,v)
if isMy then
myTeam=v
end
if v.sec>0 then
collectNum=collectNum+1
end
end
end
local guid=args[1]
local detail={
guildid=args[2],
guildname=args[3],
resource=args[4],
teamNum=args[5],
myTeam=myTeam,
collectNum=collectNum,
allTeam=list,
checkXM=function(self_)
if not mathHelper.validInt64(self_.guildid)or tostring(self_.guildid)=='-1'then
return 0
elseif xianmengModel:isMyXM(self_.guildid)then
return 1
else
return 2
end
end,
getLerpRes=function(self_)
local cost=0
if self_.teamNum>0 then
for i,v in ipairs(self_.allTeam)do
if v.sec>0 then
local cur=gameUtilityModel.getServerShortTime()
local l=cur-v.sec
if l<0 then l=0 end
local num=math.min(math.floor(l*v.speed),v.max)
cost=cost+num
end
end
end
local lerp=self_.resource-cost
if lerp<0 then lerp=0 end
return lerp
end,
}
zhengzhanshanhaiModel:insertQingBaoDetail(guid,detail)
local qbMark=zhengzhanshanhaiController:getOpenQingBaoMark()
if qbMark~=nil then
zhengzhanshanhaiController:setOpenQingBaoMark(nil)
if qbMark[1]==guid then
zhengzhanshanhaiController:openQingBaoDetail(guid,qbMark[2])
end
end
UIManager:invokeUIMethod('UIXM_ZZSH_resourceInfoWin','refreshView',guid)
UIManager:invokeUIMethod('UIXM_ZZSH_selfPVETeamWin','rcv_qbDetail',guid)
UIManager:invokeUIMethod('UIXM_ZZSH_posInfoWin','rcv_qbDetail',guid)
end






function zhengzhanshanhaiController.recv_initiatePvEWaiPai_JiJie(guid,setoutnum,len,list,ret)
















if ret==0 then
UIManager.info('发起集结成功')

zhengzhanshanhaiModel:addPvEWaiPaiData(guid,list)










else
local err
if ret==1 then
err='消耗不足'
elseif ret==2 then
err='异兽不存在'
elseif ret==3 then
err='已有未出发的集结'
elseif ret==4 then
err='已有已出发的集结'
elseif ret==5 then
err='弟子已占用'
elseif ret==6 then
err='外派队伍超限'
elseif ret==7 then
err='今日已集结过'
end
if err then
UIManager.error(err)
end
end
end


function zhengzhanshanhaiController.recv_joinPvEWaiPai_JiJie(guid,len,list,ret)














if ret==0 then
UIManager.info('参与集结成功')

zhengzhanshanhaiModel:addPvEWaiPaiData(guid,list)

zhengzhanshanhaiController:reqMonsterDetail(guid)
zhengzhanshanhaiController:reqMonsterXMDetail(guid)
else
local err
if ret==1 then
err='消耗不足'
elseif ret==2 then
err='异兽不存在'
elseif ret==3 then
err='暂无集结'
elseif ret==4 then
err='集结已满员'
elseif ret==5 then
err='集结已出发'
elseif ret==6 then
err='弟子已占用'
elseif ret==7 then
err='外派队伍超限'
elseif ret==8 then
err='今日已集结过'
end
if err then
UIManager.error(err)
end
end
end


function zhengzhanshanhaiController.recv_getPvEJoinMsg(guid)


zhengzhanshanhaiModel:setPvEJoin(guid)
end


function zhengzhanshanhaiController.recv_startPvEWaiPai_JiJie(guid,ret)








if ret==0 then
UIManager.info('队伍出击成功')
else
local err
if ret==1 then
err='异兽不存在'
elseif ret==2 then
err='集结不存在'
elseif ret==3 then
err='集结已出发'
elseif ret==4 then
err='集结不够人'
end
if err then
UIManager.error(err)
end
end

if UIManager:isActive('UIXM_ZZSH_monsterInfoWin')then
zhengzhanshanhaiController:reqMonsterDetail(guid)
end
if UIManager:isActive('UIXM_ZZSH_monsterMyTeamWin')then
zhengzhanshanhaiController:reqMonsterXMDetail(guid)
end
end


function zhengzhanshanhaiController.recv_changePvEWaiPai_JiJie(guid,setoutnum,actorid)









local actorid_n=mathHelper.int64_to_number(actorid)
if actorid_n>0 then
if playerModel:checkActorId(actorid)then
UIManager.info('修改集结成功')
end
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData then
local detail_xm=qbData:getDetail_xm()
if detail_xm then
detail_xm.setoutnum=setoutnum
UIManager:invokeUIMethod('UIXM_ZZSH_monsterMyTeamWin','rec_changeJiJie',guid)
end
zhengzhanshanhaiModel:recv_changePVEJiJie(guid,setoutnum)
UIManager:invokeUIMethod('UIXM_ZZSH_monsterAllMyTeamWin','rec_changeJiJie',guid)
zhengzhanshanhaiModel:refreshQingBaoDetail(guid,setoutnum)
end
else
local err
if actorid_n==-1 then
err='异兽不存在'
elseif actorid_n==-2 then
err='集结不存在'
elseif actorid_n==-3 then
err='队伍集结中时才可变更勾选'
end
if err then
UIManager.error(err)
end
end
end


function zhengzhanshanhaiController.recv_kickOutPvEWaiPai_JiJie(guid,taractorid,actorid)








local actorid_n=mathHelper.int64_to_number(actorid)
if actorid_n>0 then
if playerModel:checkActorId(taractorid)then

if playerModel:checkActorId(actorid)then

UIManager.info('退出集结队伍成功')
else

UIManager.info('你已被队长踢出集结队伍')
end
else

if playerModel:checkActorId(actorid)then

UIManager.info('成功把盟员踢出集结队伍')
end
end



zhengzhanshanhaiModel:setQingBaoDetailDirty(guid)



else
local err
if actorid_n==-1 then
err='异兽不存在'
elseif actorid_n==-2 then
err='集结不存在'
elseif actorid_n==-3 then
err='集结已出发'
elseif actorid_n==-4 then
err='踢出对象不存在'
end
if err then
UIManager.error(err)
end
end
end


function zhengzhanshanhaiController.recv_getPvEJiJieDetailData(guid,len,list,setoutnum)


















local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData==nil then



return
end
local teamData=zhengzhanshanhaiModel:getMyPvETeam(guid,qbData.infotype)
if teamData==nil then



return
end

local lp={}
local teamNum=len
local hasMy=false

local isCreater=false
if len>0 then
for i,v in ipairs(list)do
v.isCreate=i==1
local isMy=playerModel:checkActorId(v.actorid)
if isMy then
hasMy=true
if v.isCreate then
isCreater=true
end
end
v.isMy=isMy

v.key=v.actorid
v.key_str=tostring(v.key)
local fight_num=0
if v.disciplelistlen>0 then
for i,vv in ipairs(v.discipleList)do
if vv.flag>0 then
fight_num=fight_num+mathHelper.int64_to_number(vv.fightvalue)
end
end
end
v.fight_num=fight_num
lp[v.key_str]=v
end
end
local detail={
teamNum=teamNum,
hasMy=hasMy,
isCreater=isCreater,
allTeam=lp,
setoutnum=setoutnum,
}
zhengzhanshanhaiModel:insertQingBaoDetail_xm(guid,detail)
local checkOpen=false
local qbMark=zhengzhanshanhaiController:getOpenQingBaoMark_xm()
if qbMark~=nil then
zhengzhanshanhaiController:setOpenQingBaoMark_xm(nil)
if qbMark==guid then
checkOpen=true
zhengzhanshanhaiController:openQingBaoDetail_xm(guid)
end
end
if not checkOpen then
UIManager:invokeUIMethod('UIXM_ZZSH_monsterMyTeamWin','refreshView',guid)
end

if isCreater then
UIManager:invokeUIMethod("UIXMZZSH_YuBeiDuiMainWin","refreshtemnum")

local playkey=zhengzhanshanhaiModel:getkitoutplayerid()
if playkey then
zhengzhanshanhaiModel:setybd_playerflag(playkey,false)
zhengzhanshanhaiModel:setkitoutplayerid(nil)
end
end
end


function zhengzhanshanhaiController.recv_zhaoji(guid,ret)








if ret==0 then
UIManager.info('已向仙盟成员发送召集信息')
zhengzhanshanhaiModel:rec_zhaoji()
else
local err
if ret==1 then
err='异兽不存在'
elseif ret==2 then
err='集结不存在'
elseif ret==3 then
err='集结已出发'
elseif ret==4 then
err='仅队长可以召集'
end
if err then
UIManager.error(err)
end
end
end


function zhengzhanshanhaiController.recv_delPvEWaiPai_JiJie(guid,ret)






if ret==0 then
UIManager.info('队伍解散成功')
zhengzhanshanhaiModel:delMapData(guid)
UIManager:invokeUIMethod('UIXM_ZZSH_monsterAllMyTeamWin','morenPaiXu')
else
local err
if ret==1 then
err='异兽不存在'
elseif ret==2 then
err='集结不存在'
end
if err then
UIManager.error(err)
end
end
end





function zhengzhanshanhaiController.recv_caiJiPvEWaiPai_BaoDi(args)













local ret=args[6]
if ret==0 then
UIManager.info('宝地采集队伍开始出发')
zhengzhanshanhaiModel:addPvEWaiPaiData(args[1],args[3],args[4],args[5])







else
local err
if ret==1 then
err='消耗不足'
elseif ret==2 then
err='宝地不存在'
elseif ret==3 then
err='弟子已占用'
elseif ret==4 then
err='已有采集'
elseif ret==5 then
err='外派队伍超限'
end
if err then
UIManager.error(err)
end
end

end




function zhengzhanshanhaiController.recv_retractPvEWaiPaiTeam(guid,ret)






if ret==0 then
UIManager.info('弟子队伍撤回成功')
zhengzhanshanhaiModel:delPvEWaiPaiData(guid)
else
local err
if ret==1 then
err='队伍不存在'
elseif ret==2 then
err='情报不存在'
end
if err then
UIManager.error(err)
end
end
end


function zhengzhanshanhaiController.recv_refreshYiShouSearch(searchtimes,actorid)








zhengzhanshanhaiModel:setSearchUsed(searchtimes)
local actorid_n=mathHelper.int64_to_number(actorid)
if actorid_n<=0 then
local err
if actorid_n==-1 then
err='搜寻次数不足'
elseif actorid_n==-2 or actorid_n==-3 then
err='附近太过拥挤而无异兽和宝地可搜寻，搜寻失败！'
elseif actorid_n==-4 then
err='搜寻消耗不足'
end
if err then
UIManager.error(err)
end
return
end
if playerModel:checkActorId(actorid)then
UIManager.info('搜寻成功')
UIManager:invokeUIMethod('UIXM_ZZSH_entitySelectWin','rec_search')
end
end



function zhengzhanshanhaiController.recv_getZCMomentumData(attacklistlen,attacklist,defendlistlen,defendlist)
zhengzhanshanhaiModel:SetZCMomentumData(attacklistlen,attacklist,defendlistlen,defendlist)
UIManager:invokeUIMethod('UIXM_ZZSH_RankListWin','refreshRight')
end


function zhengzhanshanhaiController.recv_getXMMomentumData(attacklistlen,XMattacklist)
zhengzhanshanhaiModel:SetXMMomentumData(attacklistlen,XMattacklist)
UIManager:invokeUIMethod('UIXM_ZZSH_RankListWin','refreshRight')
end


function zhengzhanshanhaiController.recv_getBZMomentumData(attacklistlen,BZattacklist)
zhengzhanshanhaiModel:SetBZMomentumData(attacklistlen,BZattacklist)
UIManager:invokeUIMethod('UIXM_ZZSH_RankListWin','refreshRight')
end



function zhengzhanshanhaiController.recv_getXMRankList(XMRanklen,RaceXMRankList)
zhengzhanshanhaiModel:SetXMRankList(XMRanklen,RaceXMRankList)
UIManager:invokeUIMethod('UIXM_ZZSH_XMRankListWin','refreshRight')
end


function zhengzhanshanhaiController.recv_getLocalXMDataList(localXMDataLen,localXMDataList)
zhengzhanshanhaiModel:SetLocalXMDataList(localXMDataLen,localXMDataList)
UIManager:invokeUIMethod('UIXM_ZZSH_localXmDataWin','refreshRight')
end


function zhengzhanshanhaiController.recv_getHisList(hisListLen,hisList)
zhengzhanshanhaiModel:SetHisList(hisListLen,hisList)
UIManager:invokeUIMethod('UIXM_ZZSH_XMRankListWin','refreshRight')
end

function zhengzhanshanhaiController:openUIXM_ZZSH_localXmDataWin()
UIManager:showWindowImp("UIXM_ZZSH_localXmDataWin")
end


function zhengzhanshanhaiController:getListenMark()
return listenMark
end

function zhengzhanshanhaiController:setListenMark(mark)
listenMark=mark
end


function zhengzhanshanhaiController:checkAndCloseListen(winName)
local checkWinList={
["UIXM_ZZSH_MapWin"]=true,
["UILingShanZhengDuoWin"]=true,
}

for checkWinName,_ in pairs(checkWinList)do
if checkWinName~=winName then
local win=UIManager:findActiveWindow(checkWinName)
local ret=win~=nil
if ret then
return
end
end
end


zhengzhanshanhaiController:reqMapListen(0)
end



function zhengzhanshanhaiController:getZZSHCfg(...)
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then

return cfgHelper.get(cfg_zhengzhanshanhaiconfig_get,1,...)
else

return cfgHelper.get(cfg_zhengzhanshanhainewconfig_get,shSeasonId,...)
end
end


function zhengzhanshanhaiController:getZZSHCfg_domain()
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
local cfg
if shSeasonId==-1 then

local raceIndex=zhengzhanshanhaiModel:getRaceIndex()
cfg=cfgHelper.get1(cfg_zhengzhanshanhaidomainconfig_get,raceIndex)
if cfg==nil then
cfg=cfgHelper.get1(cfg_zhengzhanshanhaidomainconfig_get,1)
end
else

cfg=cfgHelper.get1(cfg_zhengzhanshanhaidomainnewconfig_get,shSeasonId)
if cfg==nil then
cfg=cfgHelper.get1(cfg_zhengzhanshanhaidomainnewconfig_get,1)
end
end

return cfg
end


function zhengzhanshanhaiController:getZZSHCfg_weekTask(...)
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then

return cfgHelper.get(cfg_zhengzhanshanhaiweektaskconfig_get,...)
else

local shSeasonLv=zhengzhanshanhaiModel:getSeasonLv()
local allCfg=cfgHelper.get(cfg_zhengzhanshanhaiweektasknewconfig_get,shSeasonLv)
if not allCfg then
logErr(FMT.fmt("找不到征战山海赛季等级为{0}对应的周常任务配置 请检查配置是否正确",shSeasonLv))
shSeasonLv=1
end

return cfgHelper.get(cfg_zhengzhanshanhaiweektasknewconfig_get,shSeasonLv,...)
end
end


function zhengzhanshanhaiController:getZZSHCfg_weekTaskAllCfg()
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then

return cfg_zhengzhanshanhaiweektaskconfig()
else

local shSeasonLv=zhengzhanshanhaiModel:getSeasonLv()
local allCfg=cfgHelper.get(cfg_zhengzhanshanhaiweektasknewconfig_get,shSeasonLv)
if not allCfg then
logErr(FMT.fmt("找不到征战山海赛季等级为{0}对应的周常任务配置 请检查配置是否正确",shSeasonLv))
shSeasonLv=1
end

return cfgHelper.get(cfg_zhengzhanshanhaiweektasknewconfig_get,shSeasonLv)
end
end

function zhengzhanshanhaiController:getZZSHCfg_weekTask_const_def()
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then

return cfgHelper.getdef(cfg_zhengzhanshanhaiweektaskconfig)
else

return cfgHelper.getdef(cfg_zhengzhanshanhaiweektasknewconfig)
end
end

function zhengzhanshanhaiController:getZZSHCfg_log(...)
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then

return cfgHelper.get(cfg_zhengzhanshanhailogconfig_get,...)
else

return cfgHelper.get(cfg_zhengzhanshanhailognewconfig_get,...)
end
end

function zhengzhanshanhaiController:getZZSHCfg_YBD(...)
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then

return cfgHelper.get(cfg_zhengzhanshanhaiyubeiduiconfig_get,...)
else

return cfgHelper.get(cfg_zhengzhanshanhaiyubeiduinewconfig_get,...)
end
end

function zhengzhanshanhaiController:getZZSHCfg_yishou(...)
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then

return cfgHelper.get(cfg_zhengzhanshanhaiyishouconfig_get,...)
else

return cfgHelper.get(cfg_zhengzhanshanhaiyishounewconfig_get,...)
end
end

function zhengzhanshanhaiController:getZZSHCfg_yishou_getdef(...)
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then

return cfgHelper.getdef(cfg_zhengzhanshanhaiyishouconfig,...)
else

return cfgHelper.getdef(cfg_zhengzhanshanhaiyishounewconfig,...)
end
end

function zhengzhanshanhaiController:getZZSHCfg_baodi(...)
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then

return cfgHelper.get(cfg_zhengzhanshanhaibaodiconfig_get,...)
else

return cfgHelper.get(cfg_zhengzhanshanhaibaodinewconfig_get,...)
end
end

function zhengzhanshanhaiController:getZZSHCfg_search(...)
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then

return cfgHelper.get(cfg_zhengzhanshanhaisearchconfig_get,...)
else

local cfg=cfgHelper.get(cfg_zhengzhanshanhaisearchnewconfig_get,shSeasonId,...)
if cfg==nil then
logErr(FMT.fmt("找不到征战山海赛季id为{0}对应的搜寻配置 请检查配置是否正确",shSeasonId))
cfg=cfgHelper.get1(cfg_zhengzhanshanhaisearchnewconfig_get,1,...)
end
return cfg
end
end

function zhengzhanshanhaiController:getZZSHCfg_search_getdef(...)
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then

return cfgHelper.getdef(cfg_zhengzhanshanhaisearchconfig,...)
else

return cfgHelper.getdef(cfg_zhengzhanshanhaisearchnewconfig,...)
end
end

function zhengzhanshanhaiController:getZZSHCfg_box(...)
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then

return cfgHelper.get(cfg_zhengzhanshanhaiboxconfig_get,...)
else

local shSeasonLv=zhengzhanshanhaiModel:getSeasonLv()or 1
return cfgHelper.get(cfg_zhengzhanshanhaiboxnewconfig_get,shSeasonLv,...)
end
end


