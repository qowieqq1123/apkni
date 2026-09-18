






local _MODULENAME="WDCQController"

WDCQCTabEnum={
eGroup=1,
eStage=2,
}

WDCQCGroupEnum={
eFangXiu=1,
eDiXian=2,
eTianZun=3,
eDiJun=4,
eXianHuan=5,
}

WDCQCGroupEnumList={
WDCQCGroupEnum.eFangXiu,
WDCQCGroupEnum.eDiXian,
WDCQCGroupEnum.eTianZun,
WDCQCGroupEnum.eDiJun,
WDCQCGroupEnum.eXianHuan,
}

WDCQCGroupNmae={
[WDCQCGroupEnum.eFangXiu]="凡修组",
[WDCQCGroupEnum.eDiXian]="地仙组",
[WDCQCGroupEnum.eTianZun]="天尊组",
[WDCQCGroupEnum.eDiJun]="帝君组",
[WDCQCGroupEnum.eXianHuan]="仙皇组",
}



WDCQCGameStageEnum={
eNone=0,
eSixteen=1,
eEighth=2,
eFourth=3,
eSemi=4,
eThird=5,
eChampion=6,
eGameFinish=7,
}

WDCQCGameStageEnumList={
WDCQCGameStageEnum.eSixteen,
WDCQCGameStageEnum.eEighth,
WDCQCGameStageEnum.eFourth,
WDCQCGameStageEnum.eSemi,
WDCQCGameStageEnum.eThird,
WDCQCGameStageEnum.eChampion,
}

WDCQCGameStageNmae={
[WDCQCGameStageEnum.eSixteen]="16强赛",
[WDCQCGameStageEnum.eEighth]="8强赛",
[WDCQCGameStageEnum.eFourth]="4强赛",
[WDCQCGameStageEnum.eSemi]="半决赛",
[WDCQCGameStageEnum.eThird]="季军赛",
[WDCQCGameStageEnum.eChampion]="冠军赛",
}

WDCQCMatchStageEnum={
eNone=0,
ePreTheGame=1,
eTimeDown=2,
eInTheGame=3,
eEndTheGame=4,
}

WDCQCPreGameStageEnum={
eNone=0,
eSelectDz=1,
eForbiddenDz=2,
eAdjustTeam=3,
}

WDCQCAdjustTeamStageEnum={
eOne=1,
eTwo=2,
eThree=3,
eFour=4,
eFive=5,
}

WDCQCAdjustTeamPosEnum={
eNone=0,
eLeft=1,
eRight=2,
eAll=3,
}

WDCQPlayerIndexEnum={
eNone=0,
eLeft=1,
eRight=2,
}

WDCQCAdjustTeamCtrlTemp={
[WDCQCAdjustTeamStageEnum.eOne]={WDCQCAdjustTeamPosEnum.eLeft,1},
[WDCQCAdjustTeamStageEnum.eTwo]={WDCQCAdjustTeamPosEnum.eRight,1},
[WDCQCAdjustTeamStageEnum.eThree]={WDCQCAdjustTeamPosEnum.eRight,2},
[WDCQCAdjustTeamStageEnum.eFour]={WDCQCAdjustTeamPosEnum.eLeft,2},
[WDCQCAdjustTeamStageEnum.eFive]={WDCQCAdjustTeamPosEnum.eAll,3},
}
WDCQCTeamAdjustStageTemp={
{
[WDCQCAdjustTeamPosEnum.eLeft]=WDCQCAdjustTeamStageEnum.eOne,
[WDCQCAdjustTeamPosEnum.eRight]=WDCQCAdjustTeamStageEnum.eTwo,
},
{
[WDCQCAdjustTeamPosEnum.eLeft]=WDCQCAdjustTeamStageEnum.eFour,
[WDCQCAdjustTeamPosEnum.eRight]=WDCQCAdjustTeamStageEnum.eThree,
},
{
[WDCQCAdjustTeamPosEnum.eLeft]=WDCQCAdjustTeamStageEnum.eFive,
[WDCQCAdjustTeamPosEnum.eRight]=WDCQCAdjustTeamStageEnum.eFive,
},
}


WDCQCMatchTriggerEnum={
ePreGame_StartSelectDz=0,
ePreGame_EndSelectDz=1,
ePreGame_StartBanDz=2,
ePreGame_EndBanDz=3,
ePreGame_StartAdjustTeam_1=4,
ePreGame_EndAdjustTeam_1=5,
ePreGame_StartAdjustTeam_2=6,
ePreGame_EndAdjustTeam_2=7,
ePreGame_StartAdjustTeam_3=8,
ePreGame_EndAdjustTeam_3=9,
ePreGame_StartAdjustTeam_4=10,
ePreGame_EndAdjustTeam_4=11,
ePreGame_StartAdjustTeam_5=12,
ePreGame_EndAdjustTeam_5=13,
eGameStart=14,
eGameEnd=15,
}

WDCQCRankEnum={
eNone=0,
eChampion=1,
eSecond=2,
eThird=3,
eFinnal4=4,
eFinnal8=5,
eFinnal16=6,
eFinnal32=7,
}

WDCQCRankNmae={
[WDCQCRankEnum.eNone]="未参赛",
[WDCQCRankEnum.eChampion]="冠军",
[WDCQCRankEnum.eSecond]="亚军",
[WDCQCRankEnum.eThird]="季军",
[WDCQCRankEnum.eFinnal4]="4强",
[WDCQCRankEnum.eFinnal8]="8强",
[WDCQCRankEnum.eFinnal16]="16强",
[WDCQCRankEnum.eFinnal32]="32强",
}

WDCQCStageStateEnum={
eStart=0,
eEnd=1,
}

local _RankCompareIndex={
[WDCQCGameStageEnum.eSixteen]={6,7},
[WDCQCGameStageEnum.eEighth]={5,6},
[WDCQCGameStageEnum.eFourth]={4,5},
[WDCQCGameStageEnum.eSemi]={3,4},
[WDCQCGameStageEnum.eThird]={3,4},
[WDCQCGameStageEnum.eChampion]={1,2},
}














































































































gameState.addListener(def_table(_MODULENAME))
WDCQController.name=_MODULENAME
WDCQController.data={}
local _this=WDCQController

function WDCQController:onAppStart()

WDCQModel:onAppStart()


socketManager:register_receiver(38,1,WDCQController.recv_38_1)
socketManager:register_receiver(38,2,WDCQController.recv_38_2)
socketManager:register_receiver(38,3,WDCQController.recv_38_3)
socketManager:register_receiver(38,4,WDCQController.recv_38_4)
socketManager:register_receiver(38,5,WDCQController.recv_38_5)
socketManager:register_receiver(38,6,WDCQController.recv_38_6)
socketManager:register_receiver(38,7,WDCQController.recv_38_7)
socketManager:register_receiver(38,8,WDCQController.recv_38_8)
socketManager:register_receiver(38,9,WDCQController.recv_38_9)
socketManager:register_receiver(38,10,WDCQController.recv_38_10)
socketManager:register_receiver(38,11,WDCQController.recv_38_11)
socketManager:register_receiver(38,12,WDCQController.recv_38_12)

notifySystem:listenNotify(notifyConfig.on_system_open,self.onSystemOpen)
end


function WDCQController:onEnterState(isReconnect)
self.fightlogData={}
self.reqFlagList={}
self.triggerKeyFlagList={}
self.endFlagList={}
self.fightLogIdLookup={}















WDCQModel:onEnterState()
WDCQController:onEnterState_Msg(isReconnect)
timeEventController.addNormalTimerHandler(1,'WDCQController',self)

reddotClassManager.register_event(REDDIT_TYPE.eWenDingCangQiong,self.reddotChange)
end


function WDCQController:onProtocolReq()
WDCQModel:onProtocolReq()
WDCQController:onProtocolReq_Msg()
self.protocolInitDone=true

end


function WDCQController:onLeaveState(isReconnect)
self.protocolInitDone=false
_this.recvFlag_38_1=false
WDCQController:removeEnter()
timeEventController.removeNormalTimerHandler(1,'WDCQController',self)
WDCQModel:onLeaveState(isReconnect)
WDCQController:onLeaveState_Msg(isReconnect)
WDCQController:onLeaveState_ActEnter(isReconnect)

self.data={}
self.lookUpList=nil
self.fightLogIdLookup=nil
self.guessFlag=nil
self.targetGuessRound=nil

reddotClassManager.unregister_event(REDDIT_TYPE.eWenDingCangQiong,self.reddotChange)
timeEventController.removeTimingHandler(WDCQController.addGuessTimerAndRefreshFlag)
end


function WDCQController:onLostConnection()
self.protocolInitDone=false
end


function WDCQController:onReConnection(isInitPro)

end

function WDCQController.onBigCrossActListRecv(len,actList)






end




function WDCQController.req_38_1()
socketManager:send_38_1()
end



function WDCQController.req_38_2(actor_id,type)
socketManager:send_38_2(actor_id,type or 2)
end










function WDCQController.req_38_3(big_group_id,match_type_id,rival_idx,len,list,baohulen,baohulist)
socketManager:send_38_3(big_group_id,match_type_id,rival_idx,len,list,baohulen,baohulist)

end





function WDCQController.req_38_4(big_group_id,match_type_id,rival_idx,actor_id,len,list)
socketManager:send_38_4(big_group_id,match_type_id,rival_idx,actor_id,len,list)

end








function WDCQController.req_38_5(big_group_id,match_type_id,rival_idx,len,list)
socketManager:send_38_5(big_group_id,match_type_id,rival_idx,len,list)
end







function WDCQController.req_38_6(big_group_id,match_type_id,rival_idx,len,list)
socketManager:send_38_6(big_group_id,match_type_id,rival_idx,len,list)

end



function WDCQController.req_38_7(assist)
socketManager:send_38_7(assist or 0)
end


function WDCQController.req_38_8(big_groub_idx,match_type_idx,idx)
socketManager:send_38_8(big_groub_idx,match_type_idx,idx)
end




function WDCQController.req_38_9(big_groub_idx,rank_id)
socketManager:send_38_9(big_groub_idx,rank_id)
end


function WDCQController.req_38_10()
socketManager:send_38_10()
end







function WDCQController.req_38_11(big_group_id,match_type_id,rival_idx,actor_id,money_cnt)
socketManager:send_38_11(big_group_id,match_type_id,rival_idx,actor_id,money_cnt)
end



function WDCQController.req_38_12()
socketManager:send_38_12()
end















































function WDCQController.recv_38_1(begintime,big_groub_len,bigGroubList,minsrvdays)





local data=WDCQModel:getData()
data.minsrvdays=minsrvdays or 0




data.startTime=begintime

_this.recvFlag_38_1=true


WDCQModel:initLookUpConfig()
WDCQController:addGuessTimerAndRefreshFlag()

WDCQController:clearListenerMsg()

data.groubList={}
data.groupLen=big_groub_len

data.rankList={}
data.actorRankLookup={}

data.groupStagelookUp={}
for i,groupEnum in ipairs(WDCQCGroupEnumList)do
local grouptemp={}
grouptemp.stageList={}
grouptemp.hasData=false
for ii,stageEnum in ipairs(WDCQCGameStageEnumList)do
local stageTemp={}
stageTemp.macthlen=0
stageTemp.macthList={}
grouptemp.stageList[stageEnum]=stageTemp
end
grouptemp.stageLen=#WDCQCGameStageEnumList
data.groubList[groupEnum]=grouptemp

end

if big_groub_len>0 then
for i,v in ipairs(bigGroubList)do
local groupId=v.big_group_id




local grouptemp=data.groubList[groupId]
grouptemp.hasData=true
local stageList=grouptemp.stageList
stageList[WDCQCGameStageEnum.eSixteen].macthlen=v.match_32_len
stageList[WDCQCGameStageEnum.eSixteen].macthList=v.match32list
stageList[WDCQCGameStageEnum.eEighth].macthlen=v.match_16_len
stageList[WDCQCGameStageEnum.eEighth].macthList=v.match16list
stageList[WDCQCGameStageEnum.eFourth].macthlen=v.match_8_len
stageList[WDCQCGameStageEnum.eFourth].macthList=v.match8list
stageList[WDCQCGameStageEnum.eSemi].macthlen=v.match_4_len
stageList[WDCQCGameStageEnum.eSemi].macthList=v.match4list
stageList[WDCQCGameStageEnum.eThird].macthlen=1
stageList[WDCQCGameStageEnum.eThird].macthList={v.match3Info}
stageList[WDCQCGameStageEnum.eChampion].macthlen=1
stageList[WDCQCGameStageEnum.eChampion].macthList={v.match1Info}

local groupStage
if not WDCQController.checkInTheGame()then
groupStage=WDCQCGameStageEnum.eNone
elseif WDCQController.checkGroupFinishStage(groupId)then
groupStage=WDCQCGameStageEnum.eGameFinish
end
if not groupStage then
for ii,stageEnum in ipairs(WDCQCGameStageEnumList)do
if stageList[stageEnum].macthlen>0 then
for i,v in ipairs(stageList[stageEnum].macthList)do
if(not mathHelper.compareInt64(v.actor_id_1,Int64_0))or(not mathHelper.compareInt64(v.actor_id_2,Int64_0))then
groupStage=stageEnum
break
end
end
end
end





















if groupStage==WDCQCGameStageEnum.eSemi or groupStage==WDCQCGameStageEnum.eChampion then
local groupCfgtemp=WDCQModel:getGroupLookUpCfg(groupId)
local curTime=timeHelper.getServerShortTime()
if groupCfgtemp[WDCQCGameStageEnum.eSemi].stageSettleMentTime<=curTime and curTime<groupCfgtemp[WDCQCGameStageEnum.eThird].stageSettleMentTime then

groupStage=WDCQCGameStageEnum.eThird
end
end
end
data.groupStagelookUp[groupId]=groupStage
end

for groupId,grouptemp in pairs(data.groubList)do
local stageList=grouptemp.stageList
data.rankList[groupId]={}
local rankList=data.rankList[groupId]
if grouptemp.hasData then
for rindex,rtype in ipairs(WDCQCGameStageEnumList)do
local stageInfo=stageList[rtype]
if stageInfo.macthlen>0 then
rankList[_RankCompareIndex[rtype][2]]={}
for mindex,matchData in ipairs(stageInfo.macthList)do

WDCQController.dealMatchRankData(data,rankList,groupId,matchData,rtype,mindex)

WDCQController:refreshFightLogIdLookup(groupId,rtype,mindex,matchData)
end
for mindex,matchData in ipairs(stageInfo.macthList)do
if not mathHelper.compareInt64(matchData.actor_id_1,Int64_0)or not mathHelper.compareInt64(matchData.actor_id_2,Int64_0)then

break
end
end
else
break
end
end
end
end
end

local gameStartTime=userActorArraySetting.get(ACTOR_SETTING_TYPE.eWenDingCangQiong,"gameStartTime",0)

if WDCQController.checkInTheGame()then
if gameStartTime==0 then
WDCQController.newGameOpen()
local startTime=WDCQController.getGameStartTime()
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eWenDingCangQiong,"gameStartTime",startTime,0)
end
else

if gameStartTime~=0 then
WDCQController.GameFinish()
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eWenDingCangQiong,"gameStartTime",0,0)
end
end











for i,groupEnum in ipairs(WDCQCGroupEnumList)do
local newStage=data.groupStagelookUp[groupEnum]
if newStage then
WDCQController.stageFinish(groupEnum,newStage)
end
end

WDCQController.refreshFunc()

WDCQController:checkAutoBook()
WDCQModel:loadFightRecord()

WDCQController:freshEnter()


WDCQController:freshClientAct()

WDCQController:checkListenerMsgTrigger()

WDCQController:onInvitWDCQ()
end

















function WDCQController.recv_38_2(args)
local actor_id=args[1]
local opType=args[2]
local select_dizi_len=args[3]
local selectDiziList=args[4]
otherPlayerModel.detailDisciple_dzAttrList_int_to_int64(selectDiziList)
local ban_dizi_len=args[5]
local banDiziList=args[6]
local team_list_len=args[7]
local teamList=args[8]
local protect_dizi_len=args[9]
local protectList=args[10]
local quiz_money_cnt=args[11]
local data=WDCQModel:getData()
local actorData={}
if deviceHelper.isRunEditor()then
local gameInfo=WDCQController.getActorGameInfo(actor_id)
if gameInfo then
local groupId=gameInfo.groupId
local stageId=gameInfo.stageId
local idx=gameInfo.idx
local posEnum=gameInfo.posEnum
local playerData=WDCQController.getPlayerData(groupId,stageId,idx,posEnum)

end
end










actorData.selectDzList=selectDiziList or{}
local banDiziListTemp=banDiziList or{}










actorData.banDzList=banDiziListTemp
local teamListTemp={{0,0,0,0,0},{0,0,0,0,0},{0,0,0,0,0}}

if team_list_len>0 then

for teamIndex=1,3 do
for posIndex=1,5 do
local index=(teamIndex-1)*5+posIndex
local dzguid=teamList[index]
if dzguid and dzguid~=0 then
for i,v in ipairs(actorData.selectDzList)do
if mathHelper.compareInt64(dzguid,v.discipleguid)then
teamListTemp[teamIndex][posIndex]=v
break
end
end
end
end
end
end
actorData.teamList=teamListTemp













actorData.baohuDzList=protectList or{}
actorData.moneyCnt=quiz_money_cnt or 0
if not data.actorDataList then
data.actorDataList={}
end
data.actorDataList[tostring(actor_id)]=actorData
if opType==2 then
UIManager:invokeUIMethod("UIWDCQMainWin","refreshPrepareBtn",true,actor_id)
UIManager:invokeUIMethod("UIWDCQPreGameWin","DataRecv_38_2",actor_id)
UIManager:invokeUIMethod("UIWDCQGuessWin","DataRecv_38_2",actor_id)
WDCQController:checkActorId(actor_id)
elseif opType==1 then
WDCQController:showWDCQZRInfo(actor_id)
end
if mathHelper.compareInt64(playerModel:getActorID(),actor_id)then
WDCQController.addGuessTimerAndRefreshFlag()
end
end









function WDCQController.recv_38_3(args)
local big_group_id,match_type_id,rival_idx,len,list,baohulen,baohulist=args[1],args[2],args[3],args[4],args[5],args[6],args[7]
local actor_id=playerModel:getActorID()
















if baohulen>0 then
UIManager.info("已确定弟子")
end

reddotControl.on_change_catch_type(CATCH_TYPE.eWenDingCangQiong)
UIManager:closeWindow("UIWDCQPreGameWin")
end





function WDCQController.recv_38_4(args)
local big_group_id,match_type_id,rival_idx,actor_id,len,list=args[1],args[2],args[3],args[4],args[5],args[6]


WDCQController.refreshActorData(actor_id,2,list)
UIManager:invokeUIMethod("UIWDCQMainWin","refreshPrepareBtn",true)
UIManager.info("已确定禁用弟子")
reddotControl.on_change_catch_type(CATCH_TYPE.eWenDingCangQiong)
UIManager:closeWindow("UIWDCQPreGameWin")
end







function WDCQController.recv_38_5(big_group_id,match_type_id,rival_idx,len,list)
local actor_id=playerModel:getActorID()

WDCQController.refreshActorData(actor_id,3,list)
UIManager.info("保存成功")
reddotControl.on_change_catch_type(CATCH_TYPE.eWenDingCangQiong)
end







function WDCQController.recv_38_6(big_group_id,match_type_id,rival_idx,len,list)
local actor_id=playerModel:getActorID()
WDCQController.refreshActorData(actor_id,4,list)
UIManager.info("保护弟子确定成功")
end



function WDCQController.recv_38_7(big_groub_idx)
local data=WDCQModel:getData()
data.dian_zan_cnt=data.dian_zan_cnt+1

UIManager:invokeUIMethod("UILDRongYuTongWin","onRecv")

WDCQController:freshRongYuBangActEnter()
end






function WDCQController.recv_38_8(big_groub_idx,match_type_idx,idx,info)
local oldresult=WDCQController.checkHasWinActorId(big_groub_idx,match_type_idx,idx)
WDCQController:refreshFightLogIdLookup(big_groub_idx,match_type_idx,idx,info)
WDCQModel:setData_MacthInfo(big_groub_idx,match_type_idx,idx,info)
local newresult=WDCQController.checkHasWinActorId(big_groub_idx,match_type_idx,idx)
if oldresult~=newresult then
WDCQController.MacthInfoChange(big_groub_idx,match_type_idx,idx,info)
end
UIManager:invokeUIMethod("UIWDCQMainWin","refreshMacthItem",big_groub_idx,match_type_idx,idx)
UIManager:invokeUIMethod("UIWDCQGuessWin","DataRecv_38_8",big_groub_idx,match_type_idx,idx)




local data=WDCQModel:getData()
local groupId=big_groub_idx
local stageId=match_type_idx
local rankList=data.rankList[groupId]
local matchData=info

WDCQController.dealMatchRankData(data,rankList,groupId,matchData,stageId,idx)
end




function WDCQController.recv_38_9(big_groub_idx,rank_id)
WDCQController.changeQuFuRoleInfoRewardFlag(big_groub_idx)


UIManager:invokeUIMethod("UIWDCQ_SubActServerRewardWin","freshReceive",big_groub_idx,rank_id)


reddotControl.on_change_catch_type(CATCH_TYPE.eWDCQQFAct)

WDCQController:freshQuFuActEnter()
end


function WDCQController.recv_38_10()
UIManager:invokeUIMethod("UIWDCQPreGameWin","DataRecv_38_10")
end







function WDCQController.recv_38_11(big_group_id,match_type_id,rival_idx,actor_id,money_cnt)
local macthInfo=WDCQController.getMacthInfo(big_group_id,match_type_id,rival_idx)
if macthInfo then
if mathHelper.compareInt64(actor_id,macthInfo.actor_id_1)then
macthInfo.surport_actor_cnt_1=macthInfo.surport_actor_cnt_1+1
elseif mathHelper.compareInt64(actor_id,macthInfo.actor_id_2)then
macthInfo.surport_actor_cnt_2=macthInfo.surport_actor_cnt_2+1
end

local oldmoney=WDCQController.getMoneyCnt(playerModel:getActorID())
local changeMoney=0

if mathHelper.compareInt64(Int64_0,macthInfo.suport_actor_id)then
changeMoney=mathHelper.int64_to_number(money_cnt)
else
if mathHelper.compareInt64(macthInfo.suport_actor_id,macthInfo.actor_id_1)then
macthInfo.surport_actor_cnt_1=macthInfo.surport_actor_cnt_1-1
elseif mathHelper.compareInt64(macthInfo.suport_actor_id,macthInfo.actor_id_2)then
macthInfo.surport_actor_cnt_2=macthInfo.surport_actor_cnt_2-1
end
changeMoney=mathHelper.int64_to_number(money_cnt)-mathHelper.int64_to_number(macthInfo.self_money_cnt)
end

macthInfo.suport_actor_id=actor_id
macthInfo.self_money_cnt=money_cnt
local newMoney=oldmoney-changeMoney
if newMoney<0 then
newMoney=0
end

WDCQController.refreshActorData(playerModel:getActorID(),5,newMoney)
UIManager:invokeUIMethod("UIWDCQMainWin","refreshMacthItem",big_group_id,match_type_id,rival_idx)
UIManager:invokeUIMethod("UIWDCQGuessWin","refreshPlayerInfo")
UIManager:invokeUIMethod("UIWDCQGuessWin","refreshGuessContent")
end
UIManager.info("下注成功")
WDCQController.addGuessTimerAndRefreshFlag()
end







function WDCQController.recv_38_12(args)

local qufu_act_end_time=args[1]
local zan_end_time=args[2]
local dian_zan_cnt=args[3]
local rewardInfoLen=args[4]
local rewardInfoList=args[5]
local rankInfoLen=args[6]
local rankInfoList=args[7]
local rankIconInfoLen=args[8]
local rankIconInfoList=args[9]

local data=WDCQModel:getData()
data.qufu_act_end_time=qufu_act_end_time
data.zan_end_time=zan_end_time
data.rewardInfoLen=rewardInfoLen
data.rewardInfoList=rewardInfoList
data.dian_zan_cnt=dian_zan_cnt
data.recvPlayerInfo=true
data.rankInfoLen=rankInfoLen
data.rankInfoList={}
data.rankIconInfoLen=rankIconInfoLen
data.rankIconInfoList={}

if rewardInfoLen>0 then
local groupTemp={}
for index,rewardInfo in ipairs(data.rewardInfoList)do
local temp={}

temp.actorid=rewardInfo.param_1
temp.groupId=rewardInfo.param_2
temp.rank=rewardInfo.param_3
temp.isReceive=rewardInfo.param_4


if rewardInfo.param_3==1 then
data.isShowQFZY=true
if data.zyRoleInfo then
if temp.groupId>data.zyRoleInfo.groupId then
data.zyRoleInfo=temp
end
else
data.zyRoleInfo=temp

end
end

if groupTemp[temp.groupId]==nil then
groupTemp[temp.groupId]={}
end

groupTemp[temp.groupId][temp.rank]=temp
end

data.rewardInfoList=groupTemp
end

if rankInfoLen>0 then
for index,rankInfo in ipairs(rankInfoList)do
local acotrId=rankInfo.param_1
local group=rankInfo.param_2
local rank=rankInfo.param_3
if data.rankInfoList[group]==nil then
data.rankInfoList[group]={}
end
data.rankInfoList[group][rank]=acotrId
end
end

if rankIconInfoLen>0 then
for index,rankIconInfo in ipairs(rankIconInfoList)do
local actorId=rankIconInfo.actor_id
data.rankIconInfoList[tostring(actorId)]=rankIconInfo
end
end

WDCQController:freshQuFuActEnter()
WDCQController:freshRongYuBangActEnter()

UIManager:invokeUIMethod("UIWDCQ_SubActServerRewardWin","freshReceive")


reddotControl.on_change_catch_type(CATCH_TYPE.eWDCQQFAct)






end







function WDCQController.checkUnlock()
if WDCQController.checkSysOpen()then
return true
end
local isCan,errArgs=systemConfig.isEnoughConfigOpenCnd(SYSTEM_DEFINE.eWenDingCangQiong)
if not isCan then
local typo=errArgs[1]
local val=errArgs[2]
local val2=errArgs[3]

local str=""
if typo==SYSTEM_OPEN_TYPE.eOpenServerTime then
local needday=val
local currtime=gameUtilityModel.getServerShortTime()
local stamp=timeHelper.getOpenServerShortTime()
local dtime=math.floor(stamp/86400)*86400+86400*(needday-1)-currtime
if dtime>0 then
return false,1,'{0}后可开启',dtime
end

elseif typo==SYSTEM_OPEN_TYPE.eZongmemLevelChanged then
local level=val
str=FMT.fmt('达到{0}级可参与',level)
else
str=systemModel.getOpenTips(SYSTEM_DEFINE.eWenDingCangQiong)
end
return false,0,str
end
return true
end

function WDCQController.checkUnlockEx(warning)
local check,ctype,txt,cd=WDCQController.checkUnlock()
if not check and warning then
if ctype==1 then
UIManager.error(FMT.fmt(txt,timeHelper.formatSimpleTime(cd,true)))
else
UIManager.error(txt)
end
end
return check
end


function WDCQController.checkSysOpen()
return WDCQController:checkInit38_1()
end



function WDCQController.checkInTheGame()
local startTime=WDCQModel:getData_startTime()
return startTime~=0




end

function WDCQController.checkInTheGame2()
local currtime=gameUtilityModel.getServerShortTime()
local startTime=WDCQController.getGameStartTime()
local endTime=WDCQController.getGameEnterEndTime()
return startTime<=currtime and currtime<endTime
end


function WDCQController.checkSysReddotEx()
return WDCQController.checkSysReddot()or XiWeiSaiController.checkSysReddot()
end


function WDCQController.checkSysReddot()
if not WDCQController.checkSysOpen()or not WDCQController.checkInTheGame()then
return false
end
local selfActorId=playerModel:getActorID()
local gameInfo=WDCQController.getActorGameInfo(selfActorId)
if not gameInfo then
return false
end
local otherActorId=gameInfo.rivalActorId
local selfGroupId=gameInfo.groupId
local selfStageId=gameInfo.stageId
local idx=gameInfo.idx
local posEnum=gameInfo.posEnum
local hasRival=WDCQController.checkMacthRival(selfGroupId,selfStageId,idx)
if not hasRival then
return false
end
local macthStage,preStage,adjustStage=WDCQController.getMacthStage(selfGroupId,selfStageId,idx)
if macthStage~=WDCQCMatchStageEnum.ePreTheGame then
return false
end
local flag=WDCQController.checkPreStageFlag(selfActorId,preStage,adjustStage,otherActorId,posEnum)
return not flag
end

function WDCQController.checkHonorReddot()

if WDCQController.checkHonorHasChapion()then
if WDCQController.getHonorDianZanNum()>0 then
return true
end
end
return false
end


function WDCQController.getGameStartTime()
local begin_time=cfgHelper.get2(cfg_wendingcangqiongconfig_get,1,'begin_time')
local startTimeStamp=WDCQController.changeCfgTime(begin_time[1],begin_time[2],begin_time[3])
return startTimeStamp
end


function WDCQController.getNextGameStartTime()
local begin_time=cfgHelper.get2(cfg_wendingcangqiongconfig_get,1,'begin_time')

local startTimeStamp=WDCQController.changeCfgTime(begin_time[1],begin_time[2],begin_time[3],true)
return startTimeStamp
end



function WDCQController.getGameEndTime()
local end_time=cfgHelper.get2(cfg_wendingcangqiongconfig_get,1,'end_time')
local endTimeStamp=WDCQController.changeCfgTime(end_time[1],end_time[2],end_time[3])
return endTimeStamp
end

function WDCQController.getGameEnterEndTime()
local end_time=cfgHelper.get2(cfg_wendingcangqiongconfig_get,1,'enter_end_time')
local endTimeStamp=WDCQController.changeCfgTime(end_time[1],end_time[2],end_time[3])
return endTimeStamp
end



function WDCQController.changeCfgTime(N,hour,min,nextFlag)
local startTime=WDCQModel:getData_startTime()
if nextFlag then
local nextTime=XiWeiSaiModel:getConfig_nextEndTime()
if nextTime then
local zerolongStamp=timeHelper.getServerZeroStamp(timeHelper.convertLongStamp(nextTime))
local zeroShortStamp=timeHelper.convertShortStamp(zerolongStamp)
startTime=zeroShortStamp
else

end
else
if startTime==0 then

local xfwdEndTime=XiWeiSaiModel:getConfig_endTime()
if xfwdEndTime then
local zerolongStamp=timeHelper.getServerZeroStamp(timeHelper.convertLongStamp(xfwdEndTime))
local zeroShortStamp=timeHelper.convertShortStamp(zerolongStamp)
startTime=zeroShortStamp
else

end
end
end
local targetTime=startTime+N*86400+hour*3600+min*60
return targetTime
end

function WDCQController.checkGroupStageFinish(group,stage)
if WDCQController.checkInTheGame()then
local info=WDCQModel:getGroupLookUpCfg(group)
local curTime=timeHelper.getServerShortTime()
return curTime>=info[stage].stageSettleMentTime
end


return true
end




function WDCQController.getTabList()
local tempTabList={}
local groupList={}
groupList.tabEnum=WDCQCTabEnum.eGroup
groupList.name="组别"
groupList.reddot=function()
return false
end
groupList.child={}
local stageList={}
stageList.tabEnum=WDCQCTabEnum.eStage
stageList.name="组别"
stageList.reddot=function(selectGroup)
return WDCQController:checkGroupReddot(selectGroup)
end
stageList.child={}

local groupTemp
for i,v in ipairs(WDCQCGroupEnumList)do
groupTemp=WDCQModel:getData_GroupTemp(v)
if groupTemp and groupTemp.hasData then
local childTemp={}
childTemp.subTabEnum=v
childTemp.name=WDCQCGroupNmae[v]
local min=cfgHelper.get2(cfg_xianfawendaolevelconfig_get,v,'min')
min=UIXianFaWenDaoControl:getPlatFormIdCfg(min)
local max=cfgHelper.get2(cfg_xianfawendaolevelconfig_get,v,'max')
max=UIXianFaWenDaoControl:getPlatFormIdCfg(max)
local tipsStr=FMT.fmt("（宗门{0}-{1}）",min,max)
childTemp.tips=tipsStr
childTemp.reddot=function()
return false
end
table.insert(groupList.child,childTemp)
end
end
if#groupList.child>0 then



else
local childTemp={}
childTemp.subTabEnum=WDCQCGroupEnum.eFangXiu
childTemp.name=WDCQCGroupNmae[WDCQCGroupEnum.eFangXiu]
local min=cfgHelper.get2(cfg_xianfawendaolevelconfig_get,WDCQCGroupEnum.eFangXiu,'min')
min=UIXianFaWenDaoControl:getPlatFormIdCfg(min)
local max=cfgHelper.get2(cfg_xianfawendaolevelconfig_get,WDCQCGroupEnum.eFangXiu,'max')
max=UIXianFaWenDaoControl:getPlatFormIdCfg(max)
local tipsStr=FMT.fmt("（宗门{0}-{1}）",min,max)
childTemp.tips=tipsStr
childTemp.reddot=function()
return false
end
table.insert(groupList.child,childTemp)
end

for i,v in ipairs(WDCQCGameStageEnumList)do
local childTemp={}
childTemp.subTabEnum=v
childTemp.name=WDCQCGameStageNmae[v]
childTemp.reddot=function(selectGroup,subTabEnum)
return WDCQController:checkStageReddot(selectGroup,subTabEnum)
end
table.insert(stageList.child,childTemp)
end



table.insert(tempTabList,groupList)
table.insert(tempTabList,stageList)
return tempTabList
end




function WDCQController.getGuessMoneyType()
local quiz_money_conf=cfgHelper.get2(cfg_wendingcangqiongconfig_get,1,'quiz_money_conf')
return quiz_money_conf[1][1]
end

function WDCQController.getGuessMaxCnt(group,stage)
local matchCfg=cfgHelper.get2(cfg_wendingcangqiongmatchconfig_get,group,stage)
local quiz_conf=matchCfg.quiz_conf
return quiz_conf[3]
end

function WDCQController.getSelfSelcetDZMaxCnt()
local cfg=cfg_wendingcangqiongconfig_get(1)
return cfg.select_dizi_cnt
end

function WDCQController.getBanDZMaxCnt()
local cfg=cfg_wendingcangqiongconfig_get(1)
local data=WDCQModel:getData()
local minsrvdays=data.minsrvdays or 0
local ban_dizi_cnt_conf=cfg.ban_dizi_cnt_conf
local cnt=0
for i,v in ipairs(ban_dizi_cnt_conf)do
if v[1]<=minsrvdays and minsrvdays<v[2]then
cnt=v[3]
end
end
return cnt
end

function WDCQController.getBaohuDZMaxCnt()
local cfg=cfg_wendingcangqiongconfig_get(1)
return cfg.protect_dizi_cnt
end

function WDCQController.getAdjustTeamIndex(adjustStage)
return WDCQCAdjustTeamCtrlTemp[adjustStage][2]
end

function WDCQController.checkAdjustTeamPos(adjustStage,posEnum)
local ctrlPos=WDCQCAdjustTeamCtrlTemp[adjustStage][1]
if ctrlPos==WDCQCAdjustTeamPosEnum.eAll then
return true
end
if ctrlPos==WDCQCAdjustTeamPosEnum.eNone then
return false
end
return ctrlPos==posEnum
end

function WDCQController.checkTeamAdjustLock(teamIndex,posEnum,curAdjustStage)
local cfgTemp=WDCQCTeamAdjustStageTemp[teamIndex]
local teamAdjustStage=cfgTemp[posEnum]
return curAdjustStage>teamAdjustStage
end

function WDCQController.getActorCurRank(actorId)
local gameInfo=WDCQController.getActorGameInfo(actorId)
if not gameInfo then
return WDCQCRankEnum.eNone
end
local rankIdx
local groupId=gameInfo.groupId
local stageId=gameInfo.stageId
local idx=gameInfo.idx
local posEnum=gameInfo.posEnum
local playerData=WDCQController.getPlayerData(groupId,stageId,idx,posEnum)
local winFlag=playerData.winFlag
if stageId==WDCQCGameStageEnum.eSixteen then
rankIdx=WDCQCRankEnum.eFinnal32
elseif stageId==WDCQCGameStageEnum.eEighth then
rankIdx=WDCQCRankEnum.eFinnal16
elseif stageId==WDCQCGameStageEnum.eFourth then
rankIdx=WDCQCRankEnum.eFinnal8
elseif stageId==WDCQCGameStageEnum.eSemi then
rankIdx=WDCQCRankEnum.eFinnal4
elseif stageId==WDCQCGameStageEnum.eThird then
rankIdx=WDCQCRankEnum.eFinnal4
if WDCQController.checkGroupStageFinish(groupId,stageId)then
rankIdx=winFlag and WDCQCRankEnum.eThird or WDCQCRankEnum.eFinnal4
end
elseif stageId==WDCQCGameStageEnum.eChampion then
rankIdx=WDCQCRankEnum.eFinnal4
if WDCQController.checkGroupStageFinish(groupId,stageId)then
rankIdx=winFlag and WDCQCRankEnum.eChampion or WDCQCRankEnum.eSecond
end
end
return rankIdx
end

function WDCQController.getRankRewards(actorId)
local gameInfo=WDCQController.getActorGameInfo(actorId)
if not gameInfo then
return
end
local rankIdx=WDCQController.getActorCurRank(actorId)
local groupId=gameInfo.groupId
local groupcfg=cfg_wendingcangqiongrankconfig_get(groupId)
local rankCfg=groupcfg[rankIdx]
local head_portrait=rankCfg.head_portrait
if head_portrait then
local rewards2=table.weakCopy(rankCfg.rewards)
for k,itemid in ipairs(head_portrait)do
rewards2[#rewards2+1]={itemid,1}
end
return rewards2
else
return rankCfg.rewards
end
end




function WDCQController.getActorGameInfo(actorId,isNeedResult)
local groupEnum,stageEnum
local gameInfo
for i,v in ipairs(WDCQCGroupEnumList)do
groupEnum=v
for i2,v2 in ipairs(WDCQCGameStageEnumList)do
stageEnum=v2
local macthList=WDCQModel:getData_MacthList(groupEnum,stageEnum)
if macthList then
for i3,v3 in ipairs(macthList)do
local isPass=true
if isNeedResult then
isPass=not mathHelper.compareInt64(v3.win_actor_id,Int64_0)
end

if(mathHelper.compareInt64(v3.actor_id_1,actorId)or mathHelper.compareInt64(v3.actor_id_2,actorId))and isPass then
gameInfo={}
gameInfo.groupId=groupEnum
gameInfo.stageId=stageEnum
gameInfo.subGoupId=math.ceil(i3/4)
gameInfo.idx=i3
gameInfo.posEnum=mathHelper.compareInt64(v3.actor_id_1,actorId)and WDCQPlayerIndexEnum.eLeft or WDCQPlayerIndexEnum.eRight
gameInfo.winFlag=mathHelper.compareInt64(v3.win_actor_id,actorId)
if gameInfo.posEnum==WDCQPlayerIndexEnum.eLeft and not mathHelper.compareInt64(v3.actor_id_2,0)then
gameInfo.rivalActorId=v3.actor_id_2
elseif gameInfo.posEnum==WDCQPlayerIndexEnum.eRight and not mathHelper.compareInt64(v3.actor_id_1,0)then
gameInfo.rivalActorId=v3.actor_id_1
end
end
end
end
end
end
return gameInfo
end


function WDCQController.getMacthInfo(groupId,stageId,idx)
local macthList=WDCQModel:getData_MacthList(groupId,stageId)
return macthList and macthList[idx]or nil
end





























function WDCQController.checkMacthPlayer(groupId,stageId,idx)
local macthList=WDCQModel:getData_MacthList(groupId,stageId)
local macthInfo=macthList and macthList[idx]or nil
if not macthInfo or(mathHelper.compareInt64(macthInfo.actor_id_1,0)and mathHelper.compareInt64(macthInfo.actor_id_2,0))then
return false
end
return true
end


function WDCQController.checkMacthRival(groupId,stageId,idx)
local macthList=WDCQModel:getData_MacthList(groupId,stageId)
local macthInfo=macthList and macthList[idx]or nil
if not macthInfo or mathHelper.compareInt64(macthInfo.actor_id_1,0)or mathHelper.compareInt64(macthInfo.actor_id_2,0)then
return false
end
return true
end

function WDCQController.getMacthStage(groupId,stageId,idx)

local macthList=WDCQModel:getData_MacthList(groupId,stageId)
local macthInfo=macthList and macthList[idx]or nil
if not macthInfo or(mathHelper.compareInt64(macthInfo.actor_id_1,0)and mathHelper.compareInt64(macthInfo.actor_id_2,0))then
return WDCQCMatchStageEnum.eNone
end
if not WDCQController.checkInTheGame()then
return WDCQCMatchStageEnum.eEndTheGame
end
local curTime=timeHelper.getServerShortTime()



local roundCfgTemp=WDCQController.getRoundCfg(groupId,stageId,idx)
if curTime<roundCfgTemp.selectDzStartTime then
return WDCQCMatchStageEnum.ePreTheGame,WDCQCPreGameStageEnum.eNone
end
if roundCfgTemp.selectDzStartTime<=curTime and curTime<roundCfgTemp.selectDzEndTime then
return WDCQCMatchStageEnum.ePreTheGame,WDCQCPreGameStageEnum.eSelectDz
end
if roundCfgTemp.banDzStartTime<=curTime and curTime<roundCfgTemp.banDzEndTime then
return WDCQCMatchStageEnum.ePreTheGame,WDCQCPreGameStageEnum.eForbiddenDz
end



for i,v in ipairs(roundCfgTemp.teamUpTime)do
if v.teamUpStartTime<=curTime and curTime<v.teamUpEndTime then
return WDCQCMatchStageEnum.ePreTheGame,WDCQCPreGameStageEnum.eAdjustTeam,i
end
end
if roundCfgTemp.preEndTime<=curTime and curTime<roundCfgTemp.startTime then
return WDCQCMatchStageEnum.eTimeDown
end
if roundCfgTemp.startTime<=curTime and curTime<roundCfgTemp.endTime then
return WDCQCMatchStageEnum.eInTheGame
end
if roundCfgTemp.endTime<=curTime then
return WDCQCMatchStageEnum.eEndTheGame
end
end






















function WDCQController.getRoundCfg(groupId,stageId,idx)
local groupCfgtemp=WDCQModel:getGroupLookUpCfg(groupId)
local stageCfgTemp=groupCfgtemp[stageId]
local roundCfgList=stageCfgTemp.roundCfgList
local roundCfgTemp=roundCfgList[idx]
return roundCfgTemp
end

function WDCQController.getRoundListCfg(groupId,stageId)
local groupCfgtemp=WDCQModel:getGroupLookUpCfg(groupId)
local stageCfgTemp=groupCfgtemp[stageId]
local roundCfgList=stageCfgTemp.roundCfgList
return roundCfgList
end

function WDCQController.getStageCfgTemp(groupId,stageId)
local groupCfgtemp=WDCQModel:getGroupLookUpCfg(groupId)
local stageCfgTemp=groupCfgtemp[stageId]
return stageCfgTemp
end
































function WDCQController.getPlayerData(groupId,stageId,idx,playerIndex)
local macthList=WDCQModel:getData_MacthList(groupId,stageId)
local macthInfo=macthList and macthList[idx]or nil

if not macthInfo then
return nil
end
return WDCQController.getPlayerData2(groupId,stageId,macthInfo,playerIndex)
end

function WDCQController.getPlayerData2(groupId,stageId,macthInfo,playerIndex)
local player1Flag=playerIndex==WDCQPlayerIndexEnum.eLeft
local playerData={}
playerData.actorId=player1Flag and macthInfo.actor_id_1 or macthInfo.actor_id_2
if mathHelper.int64_to_number(playerData.actorId)<=0 then
return nil
end
playerData.serverId=player1Flag and macthInfo.server_id_1 or macthInfo.server_id_2
playerData.surportCount=player1Flag and macthInfo.surport_actor_cnt_1 or macthInfo.surport_actor_cnt_2
playerData.winFlag=not mathHelper.compareInt64(macthInfo.win_actor_id,Int64_0)and mathHelper.compareInt64(playerData.actorId,macthInfo.win_actor_id)
playerData.surportFlag=mathHelper.compareInt64(playerData.actorId,macthInfo.suport_actor_id)
playerData.name=player1Flag and macthInfo.name_1 or macthInfo.name_2
playerData.iconInfo=player1Flag and macthInfo.iconInfo1 or macthInfo.iconInfo2
playerData.sex=player1Flag and macthInfo.sex_1 or macthInfo.sex_2
playerData.groupId=groupId
playerData.stageId=stageId
return playerData
end

function WDCQController.getWinnerData(groupId,stageId,idx)
local p1Data=WDCQController.getPlayerData(groupId,stageId,idx,1)
local p2Data=WDCQController.getPlayerData(groupId,stageId,idx,2)

if p1Data and p2Data then
if p1Data.winFlag then
return p1Data
else
return p2Data
end
end

return nil
end

function WDCQController.getChampionPlayerData(groupId)
return WDCQController.getWinnerData(groupId,WDCQCGameStageEnum.eChampion,1)
end

function WDCQController.checkHasWinActorId(groupId,stageId,idx)
local widActorId=WDCQController.getWinActorId(groupId,stageId,idx)
if widActorId and not mathHelper.compareInt64(widActorId,Int64_0)then
return true
end
return false
end


function WDCQController.getWinActorId(groupId,stageId,idx)
local macthList=WDCQModel:getData_MacthList(groupId,stageId)
local macthInfo=macthList and macthList[idx]or nil
if macthInfo then
return macthInfo.win_actor_id
end
end


function WDCQController.getSuportActorId(groupId,stageId,idx)
local macthList=WDCQModel:getData_MacthList(groupId,stageId)
local macthInfo=macthList and macthList[idx]or nil
if macthInfo then
return macthInfo.suport_actor_id
end
end


function WDCQController.getSuportMoneyCnt(groupId,stageId,idx)
local macthList=WDCQModel:getData_MacthList(groupId,stageId)
local macthInfo=macthList and macthList[idx]or nil
if macthInfo then
return mathHelper.int64_to_number(macthInfo.self_money_cnt)
end
end


function WDCQController.checkGuessSecFlag(groupId,stageId,idx)
local suportActorId=WDCQController.getSuportActorId(groupId,stageId,idx)
local widActorId=WDCQController.getWinActorId(groupId,stageId,idx)
if suportActorId and not mathHelper.compareInt64(suportActorId,Int64_0)and widActorId and not mathHelper.compareInt64(widActorId,Int64_0)then
return mathHelper.compareInt64(suportActorId,widActorId)
end
return false
end


function WDCQController.checkGuessFlag(groupId,stageId,idx)
local self_money_cnt=WDCQController.getSuportMoneyCnt(groupId,stageId,idx)
return self_money_cnt and self_money_cnt>0 or false
end


function WDCQController.getHotCount(groupId,stageId,idx)
local hotCount=0
local playerData1=WDCQController.getPlayerData(groupId,stageId,idx,1)
hotCount=hotCount+(playerData1 and playerData1.surportCount or 0)
local playerData2=WDCQController.getPlayerData(groupId,stageId,idx,2)
hotCount=hotCount+(playerData2 and playerData2.surportCount or 0)
return hotCount
end


function WDCQController.getRoundList(groupId,stageId,idx)
local macthList=WDCQModel:getData_MacthList(groupId,stageId)
local macthInfo=macthList and macthList[idx]or nil
local roundList
if macthInfo then
roundList=macthInfo.roundList
end
return roundList
end

















function WDCQController.checkRoundHasFight(groupId,stageId,idx)
local roundList=WDCQController.getRoundList(groupId,stageId,idx)
if roundList then
for i,v in ipairs(roundList)do
if tostring(v.fight_log_id)~='0'and tostring(v.fight_log_id)~=''then
return true
end
end
return false
end
return false
end







function WDCQController.getGroupStage(groupEnum)
local check=WDCQController.checkInTheGame()
if not check then
return WDCQCGameStageEnum.eNone
end
local groupCfgtemp=WDCQModel:getGroupLookUpCfg(groupEnum)
local curTime=timeHelper.getServerShortTime()
local stage=WDCQCGameStageEnum.eGameFinish
for i,stageEnum in ipairs(WDCQCGameStageEnumList)do
local stageCfgTemp=groupCfgtemp[stageEnum]
local lastStageCfgTemp=groupCfgtemp[WDCQCGameStageEnumList[i-1]]
local stageEndTime=stageCfgTemp.stageSettleMentTime
local lastStageEndTime=lastStageCfgTemp and lastStageCfgTemp.stageSettleMentTime or 0
if lastStageEndTime<=curTime and curTime<stageEndTime then
stage=stageEnum
end
end
return stage
end

function WDCQController.checkGroupFinishStage(groupEnum)
local groupCfgtemp=WDCQModel:getGroupLookUpCfg(groupEnum)
local curTime=timeHelper.getServerShortTime()
local stageCfgTemp=groupCfgtemp[WDCQCGameStageEnum.eChampion]
return curTime>stageCfgTemp.stageSettleMentTime
end


function WDCQController.getServerGroupStage(groupEnum)
local data=WDCQModel:getData()
return data.groupStagelookUp and data.groupStagelookUp[groupEnum]or WDCQCGameStageEnum.eNone
end

function WDCQController.getGroupStageTimeTips(groupEnum)
local groupStage=WDCQController.getGroupStage(groupEnum)
local tips
if groupStage and groupStage~=WDCQCGameStageEnum.eNone and groupStage~=WDCQCGameStageEnum.eGameFinish then
local groupCfgtemp=WDCQModel:getGroupLookUpCfg(groupEnum)
local stageCfgTemp=groupCfgtemp[groupStage]
local curTime=timeHelper.getServerShortTime()
local stageEndTime=stageCfgTemp.stageEndTime
local stageStartTime=stageCfgTemp.stageStartTime
if curTime<stageStartTime then
local curDay=timeHelper.getServerOpenDay_Time(timeHelper.convertLongStamp(curTime))
local startDay=timeHelper.getServerOpenDay_Time(timeHelper.convertLongStamp(stageStartTime))
local syear,smonth,sday,shour,smin,ssec=timeHelper.getServerStampData(timeHelper.convertLongStamp(stageStartTime))
local left=startDay-curDay
if left==0 then
tips=FMT.fmt("{0}点进行{1}",shour,WDCQCGameStageNmae[groupStage])
elseif left==1 then
tips=FMT.fmt("明日{0}点进行{1}",shour,WDCQCGameStageNmae[groupStage])
elseif left==2 then
tips=FMT.fmt("后天{0}点进行{1}",shour,WDCQCGameStageNmae[groupStage])
else
tips=FMT.fmt("{0}月{1}日{2}点进行{3}",smonth,sday,shour,WDCQCGameStageNmae[groupStage])
end
elseif stageStartTime<=curTime and curTime<stageEndTime then
tips="比赛进行中"
end
end
return tips
end


function WDCQController.checkActorOut(actorId)

local gameInfo=WDCQController.getActorGameInfo(actorId)
if not gameInfo then
return true
end
local groupId=gameInfo.groupId
local stageId=gameInfo.stageId
local idx=gameInfo.idx
local posEnum=gameInfo.posEnum
local playerData=WDCQController.getPlayerData(groupId,stageId,idx,posEnum)
return not playerData.winFlag
end


function WDCQController.getActorRankName(actorId)
local rankIdx=WDCQController.getActorCurRank(actorId)
return WDCQCRankNmae[rankIdx]
end

function WDCQController.getGroupIconName(idx)
return cfgHelper.get3(cfg_wendingcangqiongconfig_get,1,'group_name_image',idx)
end

function WDCQController.getStageIconName(group,idx)
return cfgHelper.get3(cfg_wendingcangqiongmatchconfig_get,group,idx,'name_image')
end

function WDCQController:getUnlockGroupCfgList()
if self.data.unlockGroupCfgList then return self.data.unlockGroupCfgList end

local maxLv=zongmenModel:getZongMenLimitLv()
local allGroupCfgList=cfg_xianfawendaolevelconfig()

local tempList={}
for index,cfg in ipairs(allGroupCfgList)do
local min=UIXianFaWenDaoControl:getPlatFormIdCfg(cfg.min)
if maxLv>=min then
tempList[#tempList+1]=cfg
end
end

self.data.unlockGroupCfgList=tempList

return self.data.unlockGroupCfgList
end

function WDCQController.getJCInfoList()
local tempList={}
local totalNum=0

tempList.sucessList={}
tempList.failList={}

local groupTemp
for i,v in ipairs(WDCQCGroupEnumList)do
groupTemp=WDCQModel:getData_GroupTemp(v)
if groupTemp and groupTemp.hasData then
for stageIndex,stageData in pairs(groupTemp.stageList)do
if stageData.macthlen>0 then
for matchIndex,matchData in pairs(stageData.macthList)do
local self_money_cnt=tonumber(tostring(matchData.self_money_cnt))
if self_money_cnt>0 and(not mathHelper.compareInt64(matchData.win_actor_id,Int64_0))then
local result,num=WDCQController.getGuessResult(matchData)
local temp={matchData,result,num,stageIndex,v}
if result then
tempList.sucessList[#tempList.sucessList+1]=temp
else
tempList.failList[#tempList.failList+1]=temp
end

totalNum=totalNum+num
end
end
end
end
end
end

return tempList,totalNum
end

function WDCQController.getStageJCInfoList(stage)
local tempList={}
local totalNum=0

tempList.sucessList={}
tempList.failList={}

local groupTemp
for i,v in ipairs(WDCQCGroupEnumList)do
groupTemp=WDCQModel:getData_GroupTemp(v)
if groupTemp and groupTemp.hasData then
if groupTemp.stageList[stage].macthlen>0 then
for matchIndex,matchData in pairs(groupTemp.stageList[stage].macthList)do
local self_money_cnt=tonumber(tostring(matchData.self_money_cnt))
if self_money_cnt>0 and(not mathHelper.compareInt64(matchData.win_actor_id,Int64_0))then
local result,num=WDCQController.getGuessResult(matchData)
local temp={matchData,result,num,stage,v,matchIndex}
if result then
tempList.sucessList[#tempList.sucessList+1]=temp
else
tempList.failList[#tempList.failList+1]=temp
end
totalNum=totalNum+num
end
end
end
end
end

return tempList,totalNum
end


function WDCQController.getGuessResult(matchData)
local result=mathHelper.compareInt64(matchData.suport_actor_id,matchData.win_actor_id)
local rule=cfgHelper.get2(cfg_wendingcangqiongconfig_get,1,'quiz_money_trans')
local num=0
local base=tonumber(tostring(matchData.self_money_cnt))
if result then




num=base*2

num=Mathf.Floor(num)
else

num=-base/2

num=Mathf.Ceil(num)
end

return result,num
end


function WDCQController.getTestMatcgData()
local temp={}


temp.actor_id_1=playerModel:getActorID()
temp.actor_id_2=playerModel:getActorID()


temp.server_id_1=loginModel.server_id
temp.server_id_2=loginModel.server_id


temp.name_1="玩家1"
temp.name_2="玩家2"


local iconInfo={
['piList']={
[1]=1,
[2]=7,
[3]=4,
[4]=1,
[5]=4,
[6]=12,
[7]=16,
[8]=1,
[9]=1,
[10]=1,
[11]=1,
[12]=1,
[13]=1,
[14]=1,
}
,
['actoricon']=65537,
['pilistlen']=14,
}

temp.iconInfo1=iconInfo
temp.iconInfo2=iconInfo

temp.win_actor_id=playerModel:getActorID()
temp.self_money_cnt=Mathf.Random(1000,2000)
temp.suport_actor_id=playerModel:getActorID()

return temp
end

function WDCQController.getTestActorData()
local playerData={}
playerData.actorId=playerModel:getActorID()

playerData.serverId=loginModel.server_id
playerData.surportCount=1
playerData.winFlag=true
playerData.surportFlag=playerData.actorId
playerData.name=playerModel:getActorName()
playerData.iconInfo=playerModel:getActorIconInfo()
playerData.sex=playerModel:getActorSex()

return playerData
end

















function WDCQController.checkActorData(actorId)
local actorData=WDCQModel:getData_ActorData(actorId)
if not actorData then
return false
end
return true
end





function WDCQController.refreshActorData(actorId,type,args)
local actorData=WDCQModel:getData_ActorData(actorId)
if not actorData then
local data=WDCQModel:getData()
if not data.actorDataList then
data.actorDataList={}
end
actorData={
selectDzList={},
banDzList={},
teamList={
{0,0,0,0,0},
{0,0,0,0,0},
{0,0,0,0,0}
},
moneyCnt=0,
}
data.actorDataList[tostring(actorId)]=actorData
end

if type==1 then
actorData.selectDzList=args





elseif type==2 then
actorData.banDzList=args or{}
elseif type==3 then





for teamIndex=1,3 do
for posIndex=1,5 do
local index=(teamIndex-1)*5+posIndex
local dzguid=args[index]
if dzguid then
if dzguid==0 then
actorData.teamList[teamIndex][posIndex]=0

else
for i,v in ipairs(actorData.selectDzList)do
if mathHelper.compareInt64(dzguid,v.discipleguid)then
actorData.teamList[teamIndex][posIndex]=v

break
end
end
end
end
end
end

elseif type==4 then
actorData.baohuDzList=args or{}







elseif type==5 then
actorData.moneyCnt=args or 0
end
end


function WDCQController.checkActorSZDZ(actorId)
local actorData=WDCQModel:getData_ActorData(actorId)
if not actorData then
return false
end
for i,v in ipairs(actorData.teamList)do
for i2,v2 in ipairs(v)do
if v2~=0 then
return true
end
end
end
return false
end


function WDCQController.getSelfSelcetDZGuidList()
local actorId=playerModel:getActorID()
local list=WDCQController.getSelectDZList(actorId)
local selcetDZList={}
if list and#list>0 then
for i,v in ipairs(list)do
table.insert(selcetDZList,tostring(v.discipleguid))
end
return selcetDZList
end

selcetDZList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eWenDingCangQiong,"WDCQ_SelectDzList",{})
return selcetDZList
end


function WDCQController.getSelfBoahuDZGuidList()
local actorId=playerModel:getActorID()
local baohulist=WDCQController.getBaohuDZList(actorId)
local baohuDZList={}
if baohulist and#baohulist>0 then
for i,v in ipairs(baohulist)do
table.insert(baohuDZList,tostring(v))
end
return baohuDZList
end
baohuDZList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eWenDingCangQiong,"WDCQ_baohuDzList",{})
return baohuDZList
end


function WDCQController.getSelfLocalTeamGuidList()
local localTeamtemp={
{0,0,0,0,0},
{0,0,0,0,0},
{0,0,0,0,0}
}
localTeamtemp=userActorArraySetting.get(ACTOR_SETTING_TYPE.eWenDingCangQiong,"WDCQ_TeamDzList",localTeamtemp)
return localTeamtemp
end



function WDCQController.getSelectDZList(actorId)
local actorData=WDCQModel:getData_ActorData(actorId)
if actorData then
return actorData.selectDzList
end
return





















end


function WDCQController.getBanDZList(actorId)
local actorData=WDCQModel:getData_ActorData(actorId)
if actorData then
return actorData.banDzList
end
return
end


function WDCQController.checkBanDZFlag(actorId,dzguid)
local banDZList=WDCQController.getBanDZList(actorId)
if not banDZList then
return false
end
for i,v in ipairs(banDZList)do
if mathHelper.compareInt64(v,dzguid)then
return true
end
end
return false
end


function WDCQController.getTeamDZList(actorId)
local actorData=WDCQModel:getData_ActorData(actorId)
if actorData then
return actorData.teamList
end
return
end


function WDCQController.getTeamDZList_TeamIndex(actorId,teamIndex)
local teamDZList=WDCQController.getTeamDZList(actorId)
if teamDZList then
return teamDZList[teamIndex]
end
return
end


function WDCQController.checkTeamDZ(actorId,teamIndex)
local teamDzList=WDCQController.getTeamDZList_TeamIndex(actorId,teamIndex)
if teamDzList then
for i,v in ipairs(teamDzList)do
if v and v~=0 then
return true
end
end
end
return false
end


function WDCQController.getBaohuDZList(actorId)
local actorData=WDCQModel:getData_ActorData(actorId)
if actorData then
return actorData.baohuDzList
end
return
end

function WDCQController.checkPreStageFlag(actorId,preStage,adjustStage,otherActorId,posEnum)

if not WDCQController.checkActorData(actorId)then
return false,""
end
if preStage==WDCQCPreGameStageEnum.eSelectDz then
local list=WDCQController.getSelectDZList(actorId)
if list and#list>0 then
local baohuDzList=WDCQController.getBaohuDZList(actorId)
if not baohuDzList or#baohuDzList<=0 then
return false,FMT.fmt("请选择<color=#efb150>保护位弟子</color>")
end
return true
else
return false,FMT.fmt("请选择<color=#efb150>对战弟子</color>")
end
elseif preStage==WDCQCPreGameStageEnum.eForbiddenDz and otherActorId then
local list=WDCQController.getBanDZList(otherActorId)
if list and#list>0 then
return true
else
return false,FMT.fmt("请选择<color=#efb150>禁用弟子</color>")
end
elseif preStage==WDCQCPreGameStageEnum.eAdjustTeam then
local adjustTeamIdnex=WDCQController.getAdjustTeamIndex(adjustStage)
if WDCQController.checkTeamDZ(actorId,adjustTeamIdnex)then
if posEnum then
if WDCQController.checkAdjustTeamPos(adjustStage,posEnum)then
return false,FMT.fmt("请调整<color=#efb150>对战队伍</color>")
else
return true
end
else
return true
end
else
return false,FMT.fmt("请调整<color=#efb150>对战队伍</color>")
end
end
return false,""
end

function WDCQController.getMoneyCnt(actorId)
local actorData=WDCQModel:getData_ActorData(actorId)
if actorData then
return actorData.moneyCnt
end
return 0
end















function WDCQController:onNormalUpdate(delay)
if XiWeiSaiController.checkSysOpen()and not self.reqFlagList["enter_req38_1"]then
self.reqFlagList["enter_req38_1"]=true
WDCQController.req_38_1()
return
end
if not self.protocolInitDone or not _this.recvFlag_38_1 then
return
end

WDCQController:reqActorGameInfo()

WDCQController:checkSynData()
local curTime=timeHelper.getServerShortTime()
local startTime=WDCQController.getGameStartTime()
local endTime=WDCQController.getGameEndTime()
local nextStartTime=WDCQController.getNextGameStartTime()
local req38_1=false

if startTime+3<=curTime and not self.reqFlagList["startTime"]then

self.reqFlagList["startTime"]=true
req38_1=true
end

if endTime+3<=curTime and not self.reqFlagList["endTime"]then

self.reqFlagList["endTime"]=true
req38_1=true
end

if nextStartTime+3<=curTime and not self.reqFlagList["nextstartTime"]then

self.reqFlagList["nextstartTime"]=true
req38_1=true
end

if not WDCQController.checkInTheGame()then
if req38_1 then
WDCQController.req_38_1()
end
return
end

local groupEnum,stageEnum,idx,roundListCfg,roundCfg,stageCfgTemp

local groupList=WDCQController:getUnlockGroupCfgList()

local isFlushActorSetting=false

for i,groupCfg in ipairs(groupList)do
groupEnum=groupCfg.id

local sverStage=WDCQController.getServerGroupStage(groupEnum)

if sverStage~=WDCQCGameStageEnum.eNone and sverStage~=WDCQCGameStageEnum.eGameFinish then

stageCfgTemp=WDCQController.getStageCfgTemp(groupEnum,sverStage)
if stageCfgTemp and next(stageCfgTemp)then

if curTime>=stageCfgTemp.stageSettleMentTime then

local cfgStage=WDCQController.getGroupStage(groupEnum)

if sverStage and cfgStage
and cfgStage>sverStage
and not self.reqFlagList[stageCfgTemp.req_38_1_Key]then


self.reqFlagList[stageCfgTemp.req_38_1_Key]=true

req38_1=true
end
end

roundListCfg=WDCQController.getRoundListCfg(groupEnum,sverStage)
if roundListCfg and next(roundListCfg)then
for i,v in ipairs(roundListCfg)do
idx=i
roundCfg=v
if not WDCQController.checkHasWinActorId(groupEnum,sverStage,idx)
and curTime>=roundCfg.startTime
and WDCQController.checkMacthPlayer(groupEnum,sverStage,idx)
and not self.reqFlagList[roundCfg.req_38_8_Key]then

self.reqFlagList[roundCfg.req_38_8_Key]=true

local req_38_8_ListFlag=userActorArraySetting.get(ACTOR_SETTING_TYPE.eWenDingCangQiong,"req_38_8_ListFlag",{})
if not req_38_8_ListFlag[roundCfg.req_38_8_Key]then
WDCQController.req_38_8(groupEnum,sverStage,idx)
req_38_8_ListFlag[roundCfg.req_38_8_Key]=true
userActorArraySetting.set(ACTOR_SETTING_TYPE.eWenDingCangQiong,"req_38_8_ListFlag",req_38_8_ListFlag)
isFlushActorSetting=true
end
end
end
end
if stageCfgTemp.horseList then
for i,v in ipairs(stageCfgTemp.horseList)do
if v.triggerTime<=curTime and curTime<v.maxTriggerTime and not self.triggerKeyFlagList[v.triggerKey]then
self.triggerKeyFlagList[v.triggerKey]=true
UIManager.topHourceLamp(FMT.cfmt(FONT_COLOR.eNomalBlackColor,v.langCfg))
end
end
end
if stageCfgTemp.chatList then
for i,v in ipairs(stageCfgTemp.chatList)do
if v.triggerTime<=curTime and curTime<v.maxTriggerTime and not self.triggerKeyFlagList[v.triggerKey]then
self.triggerKeyFlagList[v.triggerKey]=true

chatControl.reqSystemMesg(CHAT_MSG_TYPE.eNoFitler,{CHAT_CHANNNEL.eSystem},v.langCfg)
end
end
end
end
end


end

if req38_1 then
WDCQController.req_38_1()
end

if isFlushActorSetting then
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eWenDingCangQiong)
end




WDCQController.checkShowEndMsg()

WDCQController:checkListenerMsgTrigger()
end


function WDCQController.stageFinish(groupEnum,stageEnum)
local clinetStage=WDCQController.getGroupStage(groupEnum)
if stageEnum~=clinetStage then
logErr(FMT.fmt("根据38_1的数据算出的问鼎苍穹阶段前后端不一致 组别-->{0},服务器阶段-->{1},客户端阶段-->{2}",groupEnum,stageEnum,clinetStage))
end
end

function WDCQController.postRoundStateEx(groupEnum,stageEnum,idx,roundCfg,curTime)














end

function WDCQController.postRoundState(groupEnum,stageEnum,idx,roundCfg,curTime)
local triggerList
if curTime==roundCfg.selectDzStartTime then
if not triggerList then
triggerList={}
end
triggerList[#triggerList+1]=WDCQCMatchTriggerEnum.ePreGame_StartSelectDz
end
if curTime==roundCfg.selectDzEndTime then
if not triggerList then
triggerList={}
end
triggerList[#triggerList+1]=WDCQCMatchTriggerEnum.ePreGame_EndSelectDz
end

if curTime==roundCfg.banDzStartTime then
if not triggerList then
triggerList={}
end
triggerList[#triggerList+1]=WDCQCMatchTriggerEnum.ePreGame_StartBanDz
end
if curTime==roundCfg.banDzEndTime then
if not triggerList then
triggerList={}
end
triggerList[#triggerList+1]=WDCQCMatchTriggerEnum.ePreGame_EndBanDz
end

local teamUpTime=roundCfg.teamUpTime
if curTime==teamUpTime[1].teamUpStartTime then
if not triggerList then
triggerList={}
end
triggerList[#triggerList+1]=WDCQCMatchTriggerEnum.ePreGame_StartAdjustTeam_1
end
if curTime==teamUpTime[1].teamUpEndTime then
if not triggerList then
triggerList={}
end
triggerList[#triggerList+1]=WDCQCMatchTriggerEnum.ePreGame_EndAdjustTeam_1
end
if curTime==teamUpTime[2].teamUpStartTime then
if not triggerList then
triggerList={}
end
triggerList[#triggerList+1]=WDCQCMatchTriggerEnum.ePreGame_StartAdjustTeam_2
end
if curTime==teamUpTime[2].teamUpEndTime then
if not triggerList then
triggerList={}
end
triggerList[#triggerList+1]=WDCQCMatchTriggerEnum.ePreGame_EndAdjustTeam_2
end
if curTime==teamUpTime[3].teamUpStartTime then
if not triggerList then
triggerList={}
end
triggerList[#triggerList+1]=WDCQCMatchTriggerEnum.ePreGame_StartAdjustTeam_3
end
if curTime==teamUpTime[3].teamUpEndTime then
if not triggerList then
triggerList={}
end
triggerList[#triggerList+1]=WDCQCMatchTriggerEnum.ePreGame_EndAdjustTeam_3
end
if curTime==teamUpTime[4].teamUpStartTime then
if not triggerList then
triggerList={}
end
triggerList[#triggerList+1]=WDCQCMatchTriggerEnum.ePreGame_StartAdjustTeam_4
end
if curTime==teamUpTime[4].teamUpEndTime then
if not triggerList then
triggerList={}
end
triggerList[#triggerList+1]=WDCQCMatchTriggerEnum.ePreGame_EndAdjustTeam_4
end
if curTime==teamUpTime[5].teamUpStartTime then
if not triggerList then
triggerList={}
end
triggerList[#triggerList+1]=WDCQCMatchTriggerEnum.ePreGame_StartAdjustTeam_5
end
if curTime==teamUpTime[5].teamUpEndTime then
if not triggerList then
triggerList={}
end
triggerList[#triggerList+1]=WDCQCMatchTriggerEnum.ePreGame_EndAdjustTeam_5
end

if curTime==roundCfg.startTime then
if not triggerList then
triggerList={}
end
triggerList[#triggerList+1]=WDCQCMatchTriggerEnum.eGameStart
end
if curTime==roundCfg.endTime then
if not triggerList then
triggerList={}
end
triggerList[#triggerList+1]=WDCQCMatchTriggerEnum.eGameEnd
end
if triggerList then
for i,v in ipairs(triggerList)do

end
end
end


function WDCQController.newGameOpen()

WDCQController.req_38_2(playerModel:getActorID())
wdcqLiveBroadcastRoomController:onSeasonBegin()

WDCQController.clearMsgLocalFlag_SeasonStart()

userActorArraySetting.flush(ACTOR_SETTING_TYPE.eWenDingCangQiong)
end

function WDCQController.GameFinish()

WDCQModel:clearBookWin()
WDCQModel:resetBookData()
WDCQModel:saveBookData()

wdcqLiveBroadcastRoomController:onSeasonEnd()

local localCfg=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eWenDingCangQiong,{})
localCfg.banshowFlagList=nil
localCfg.showGuessFlagList=nil
localCfg.danshowFlagList=nil
localCfg.req_38_8_ListFlag=nil
userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eWenDingCangQiong,localCfg)

userActorArraySetting.flush(ACTOR_SETTING_TYPE.eWenDingCangQiong)
end

function WDCQController.refreshFunc()

WDCQController.freshScheduleEnd()

WDCQController.checkShowEndMsg()

UIManager:invokeUIMethod("UIWDCQMainWin","DataRecv")

end

function WDCQController.checkShowGuessResult(groupId)
local stage=WDCQController.getServerGroupStage(groupId)

if stage==WDCQCGameStageEnum.eNone or stage==WDCQCGameStageEnum.eSixteen then
return
end
local preStage=stage-1
local showGuessFlagList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eWenDingCangQiong,"showGuessFlagList",{})

if showGuessFlagList[preStage]then
return
end
local jcDataList,totalNum=WDCQController.getStageJCInfoList(preStage)
local winListLen=#jcDataList.sucessList
local failListLen=#jcDataList.failList
if winListLen<=0 and failListLen<=0 then

return
end

showGuessFlagList[preStage]=true
userActorArraySetting.set(ACTOR_SETTING_TYPE.eWenDingCangQiong,"showGuessFlagList",showGuessFlagList)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eWenDingCangQiong)
UIManager:showWindow("UIWDCQGuessResultWin",{stage=preStage})

end

function WDCQController.freshScheduleEnd()
local data=WDCQModel:getData()
local zanEndTime=data.zan_end_time or 0
local qufuActEndTime=data.qufu_act_end_time or 0
local curTime=timeHelper.getServerShortTime()
if curTime>zanEndTime and curTime>qufuActEndTime then
WDCQController.req_38_12()
end
end


function WDCQController.MacthInfoChange(big_groub_idx,match_type_idx,idx,info)

end

function WDCQController:initlookUp()
self.lookUpList={}
local groupEnum,stageEnum,idx,roundListCfg,roundCfg,stageCfgTemp
for i,v in ipairs(WDCQCGroupEnumList)do
groupEnum=v
self.lookUpList[groupEnum]={}
local grouplookUp=self.lookUpList[groupEnum]
grouplookUp.stage=WDCQController.getGroupStage(groupEnum)
grouplookUp.stageList={}
for i2,v2 in ipairs(WDCQCGameStageEnumList)do
stageEnum=v2
grouplookUp.stageList[stageEnum]={}
local stagelookupTemp=grouplookUp.stageList[stageEnum]
roundListCfg=WDCQController.getRoundListCfg(groupEnum,stageEnum)
if roundListCfg and next(roundListCfg)then
for i,v in ipairs(roundListCfg)do
idx=i
local _,__=WDCQController.getMacthStage(groupEnum,stageEnum,idx)
stagelookupTemp[idx]={_,__}
end
end
end
end
end

function WDCQController:getlookUpMatchStage(groupEnum,stage,idx)
if self.lookUpList and self.lookUpList[groupEnum]then
local stageList=self.lookUpList[groupEnum].stageList
if stageList and stageList[stage]then
return stageList[stage][idx]
end
end
end

function WDCQController:setlookUpMatchStage(groupEnum,stage,idx,newStage)
if self.lookUpList and self.lookUpList[groupEnum]then
local stageList=self.lookUpList[groupEnum].stageList
if stageList and stageList[stage]then
stageList[stage][idx]=newStage
end
end
end


function WDCQController.groupStageChange(groupEnum,oldStage,newStage)

WDCQController.stageFinish(groupEnum,oldStage)
end

function WDCQController.getChampionGroupCfgList()
local unlockList=WDCQController:getUnlockGroupCfgList()
local temp={}
for index,cfg in ipairs(unlockList)do
local championRoleInfo=WDCQModel:getRankRoleInfo(cfg.id,1)
if championRoleInfo and next(championRoleInfo)then
temp[#temp+1]=cfg
end
end

return temp
end


function WDCQController.writeTestFile(filename,data,way)
if filename then
local way=way or'w+'
local fullpath=""..'/'..filename
local f=io.open(fullpath,way)
f:write(data)
f:close()
end
end












function WDCQController:Req_FightReplay(groupId,stageId,idx,showBattle,callBack,fightCloseCallBack,autoCloseFlag)
local macthList=WDCQModel:getData_MacthList(groupId,stageId)
local macthInfo=macthList and macthList[idx]or nil
if not macthInfo or not macthInfo.roundList then

if callBack then
callBack()
end
return
end











local logList
local needReqList={}
local roundList=macthInfo.roundList
for i,v in ipairs(roundList)do
if tostring(v.fight_log_id)~='0'and tostring(v.fight_log_id)~=''then
if not logList then
logList={}
end
table.insert(logList,v.fight_log_id)
if not self.fightlogData[v.fight_log_id]then
table.insert(needReqList,v.fight_log_id)
end
end
end
if not logList then

if callBack then
callBack()
end
return
end

WDCQModel:markFightRecord(groupId,stageId,idx)


local recvCallBack=function(params)
WDCQController:recvFightReplayCall(params)
local tempList={}
for i,v in ipairs(logList)do
if self.fightlogData[v]then
table.insert(tempList,self.fightlogData[v])
end
end
if callBack then
callBack(tempList,params.extraArgs)
end
end
local args={}
args.eReplayType=eRePlayerType.wendingcangqiong
args.showBattle=showBattle
args.callBack=recvCallBack
args.player1={macthInfo.name_1,macthInfo.iconInfo1}
args.player2={macthInfo.name_2,macthInfo.iconInfo2}
args.logIdList=logList
args.fightCloseCallBack=function(battle)
loadingControl.openCloud(function()
fightCloseCallBack()
if battle then
fightController:closeBattle(battle)
end
end,nil,not autoCloseFlag)
end
args.battleType=eBattleType.wengdingcangqiong
fightModel:setSendExtraArgs(eBattleType.wengdingcangqiong,args)
if showBattle then
fightController:send_log_list(logList,args,true,true,1)
return
end
if#needReqList>0 then
fightController:send_log_list(needReqList,args,true,true,1)
else








local tempList={}
for i,v in ipairs(logList)do
if self.fightlogData[v]then
table.insert(tempList,self.fightlogData[v])
end
end
if callBack then
callBack(tempList,args)
end
end

end

function WDCQController:recvFightReplayCall(params)
if params and params.logStrList and params.logIdList then
local logStrList=params.logStrList
local logIdList=params.logIdList
for i,fightLog in ipairs(logStrList)do
if not self.fightlogData[logIdList[i]]then
local fightInfo=fightModel:getJsonReport(fightLog)
local stageInfo=fightInfo[fightReportTag.stage]
local aInfo=fightInfo[fightReportTag.attack]
local dInfo=fightInfo[fightReportTag.defend]
local result=fightInfo[fightReportTag.result]
local aresult=fightInfo[fightReportTag.attackResult]
local dresult=fightInfo[fightReportTag.defendResult]


local aInfoImage=WDCQController.getImageList(aInfo,aresult)
local dInfoImage=WDCQController.getImageList(dInfo,dresult)
aInfoImage.result=result==1
dInfoImage.result=result~=1

self.fightlogData[logIdList[i]]={logId=logIdList[i],aInfoImage=aInfoImage,dInfoImage=dInfoImage,stageInfo=stageInfo}
end
end
else

end
end

function WDCQController.getImageList(info,resultAttr)
local infoList={}
if info then
for i,v in ipairs(info)do
if v.id~=-1 then
local resultHp=0
local resultProp=resultAttr[i].prop
if resultProp then
for _,prop in ipairs(resultProp)do
if prop[1]==entityAttr.hp then
resultHp=prop[2]
break
end
end
end

local headFlag=v[fightEntityTag.typo]
if headFlag==0 then
local baseInfo=v[fightEntityTag.baseInfo]

local jobInfo=baseInfo[fightBaseInfoTag.jobData]
local modelData=baseInfo[fightBaseInfoTag.model]
local weaponItemID=baseInfo[fightBaseInfoTag.weapon]or 0
local weaponID=0
if weaponItemID>0 then
local equipCfg=itemsConfig.getConfig(weaponItemID)
if equipCfg~=nil then
weaponID=equipCfg.imageID or 0
end
end
local tmlv=baseInfo[fightBaseInfoTag.tmlv]or-1

local clothingId=baseInfo[fightBaseInfoTag.clothingId]
local clothingStar=baseInfo[fightBaseInfoTag.clothingStar]

local xianmo_voc
if baseInfo[fightBaseInfoTag.hide_xm]~=1 then
xianmo_voc=baseInfo[fightBaseInfoTag.xm_voc]
end

local args={
tmLv=tmlv,
clothingId=clothingId,
clothingStar=clothingStar,
xianmo_voc=xianmo_voc,
}
local image,outSideImage=UIDiscipleModel.getDiscipleFightModelInfo(jobInfo,modelData,weaponID,1.0,args)
table.insert(infoList,{typo=headFlag,image=image,resultHp=resultHp,pos=i,xianmo_voc=xianmo_voc})
else
table.insert(infoList,{typo=headFlag,resultHp=resultHp})
end
end
end
end
return infoList
end

function WDCQController:checkInit38_1()
return self.recvFlag_38_1
end

function WDCQController.getPlayerIndex(groupId,stageId,idx,actorId)
if mathHelper.compareInt64(actorId,Int64_0)then
return WDCQPlayerIndexEnum.eNone
end
local macthList=WDCQModel:getData_MacthList(groupId,stageId)
local macthInfo=macthList and macthList[idx]or nil
if not macthInfo then
return WDCQPlayerIndexEnum.eNone
end
if mathHelper.compareInt64(actorId,macthInfo.actor_id_1)then
return WDCQPlayerIndexEnum.eLeft
end
if mathHelper.compareInt64(actorId,macthInfo.actor_id_2)then
return WDCQPlayerIndexEnum.eRight
end
return WDCQPlayerIndexEnum.eNone
end


function WDCQController.showActorInfo(groupId,stageId,idx,playerIndex)
if stageId<=WDCQCGameStageEnum.eFourth then

return
end
if WDCQPlayerIndexEnum.eNone==playerIndex then

return
end
local playerData=WDCQController.getPlayerData(groupId,stageId,idx,playerIndex)
if not playerData then

return
end
local actorid=playerData.actorId
if mathHelper.compareInt64(actorid,Int64_0)then

return
end
local serverid=playerData.serverId
local lookType=DOUFATAI_LOOK_TYPE.eWDCQ_OtherTeam
if mathHelper.compareInt64(actorid,playerModel:getActorID())then
lookType=DOUFATAI_LOOK_TYPE.eWDCQ_SelfTeam
end
local callback=function(teamDzList)
local rdata={
teamList=teamDzList,
winName="UICommonLookRival_select3TeamWin",
winArgs={
teamCount=3,
},
lookType=lookType,
}
UIManager:showWindow("UICommonLookRivalWin",rdata)
end

local args={}
args.serverid=serverid
args.group=groupId
args.stage=stageId
args.idx=idx
args.actType=bigCrossActType.eWDCQ
otherPlayerModel:reqActorDefTeams(otherPlayerInfoType.eWenDingCangQiong,actorid,args,callback,true,true)
end


function WDCQController.showWinActorInfo(groupId,stageId,idx)
local winActorId=WDCQController.getWinActorId(groupId,stageId,idx)
if not winActorId then

return
end
local index=WDCQController.getPlayerIndex(groupId,stageId,idx,winActorId)
WDCQController.showActorInfo(groupId,stageId,idx,index)
end

function WDCQController.checkHonorHasChapion()
local list=WDCQController.getChampionGroupCfgList()
return#list>0
end

function WDCQController.getHonorDianZanNum()
local data=WDCQModel:getData()
local dznum=cfgHelper.get2(cfg_wendingcangqiongconfig_get,1,'daily_like_max')
return dznum-(data.dian_zan_cnt or 0)
end

function WDCQController.dealMatchRankData(data,rankList,groupId,matchData,stage,mindex)
local isEnd=not mathHelper.compareInt64(matchData.win_actor_id,Int64_0)
local isSKip=mathHelper.compareInt64(Int64_0,matchData.actor_id_1)or mathHelper.compareInt64(Int64_0,matchData.actor_id_2)

if isEnd then
local winTo1=mathHelper.compareInt64(matchData.win_actor_id,matchData.actor_id_1)
local isAllFillRank=WDCQCGameStageEnumList[stage+1]==nil or stage==WDCQCGameStageEnum.eThird
local winActor=winTo1 and matchData.actor_id_1 or matchData.actor_id_2
local failActor=winTo1 and matchData.actor_id_2 or matchData.actor_id_1

local winFlag=winTo1 and 1 or 2
local failFlag=winTo1 and 2 or 1
local winActorData=WDCQController.getPlayerData2(groupId,stage,matchData,winFlag)

if isAllFillRank then
rankList[_RankCompareIndex[stage][1]]={winActorData}
data.actorRankLookup[tostring(winActor)]={groupId,_RankCompareIndex[stage][1],winActorData,true,stage,mindex,isSKip}
else
table.insert(rankList[_RankCompareIndex[stage][2]],winActorData)
data.actorRankLookup[tostring(winActor)]={groupId,_RankCompareIndex[stage][1],winActorData,false,stage,mindex,isSKip}
end

if not mathHelper.compareInt64(failActor,Int64_0)then
local failActorData=WDCQController.getPlayerData2(groupId,stage,matchData,failFlag)
table.insert(rankList[_RankCompareIndex[stage][2]],failActorData)
local isFinal=stage~=WDCQCGameStageEnum.eSemi
data.actorRankLookup[tostring(failActor)]={groupId,_RankCompareIndex[stage][2],failActorData,isFinal,stage,mindex,isSKip}
end
else
if not mathHelper.compareInt64(matchData.actor_id_1,Int64_0)then
local actorData1=WDCQController.getPlayerData2(groupId,stage,matchData,1)
data.actorRankLookup[tostring(matchData.actor_id_1)]={groupId,_RankCompareIndex[stage][2],actorData1,false,stage,mindex,isSKip}
end

if not mathHelper.compareInt64(matchData.actor_id_2,Int64_0)then
local actorData2=WDCQController.getPlayerData2(groupId,stage,matchData,2)
data.actorRankLookup[tostring(matchData.actor_id_2)]={groupId,_RankCompareIndex[stage][2],actorData2,false,stage,mindex,isSKip}
end
end

local selfActorId=playerModel:getActorID()
local isSelf=mathHelper.compareInt64(selfActorId,matchData.actor_id_1)or mathHelper.compareInt64(selfActorId,matchData.actor_id_2)
if isSelf then
WDCQController:addListenerMsg(groupId,stage,mindex,isSKip)
end
end

function WDCQController.checkChampionStageEnd(group)
local curTime=timeHelper.getServerShortTime()
local roundCfgList=WDCQController.getRoundListCfg(group,WDCQCGameStageEnum.eChampion)
local roundCfg=roundCfgList[1]

return curTime>=roundCfg.endTime+5
end

function WDCQController.checkGameEndTime()
local curTime=timeHelper.getServerShortTime()
local endTime=WDCQController.getGameEndTime()

return curTime>=endTime
end

function WDCQController.checkSysDz(guid)
if not WDCQController.checkSysOpen()then
return false
end
if not WDCQController.checkInTheGame()then
return false
end
local actorId=playerModel:getActorID()
local selfSelectDZList=WDCQController.getSelectDZList(actorId)
if not selfSelectDZList or#selfSelectDZList<=0 then
return false
end
for i,v in ipairs(selfSelectDZList)do







if guid==v.discipleguid then
return true
end
end
return false
end

function WDCQController.checkHasEntryGroup(group)
local data=WDCQModel:getData()

if data.actorRankLookup then
for actorIdStr,info in pairs(data.actorRankLookup)do
if group==info[1]then
return true
end
end
end

return false
end

function WDCQController.onSystemOpen(sysid)
if sysid==SYSTEM_DEFINE.eWenDingCangQiong then




end
end

function WDCQController:checkSynData()
if not WDCQController.checkSysOpen()or not WDCQController.checkInTheGame()then
return
end
local selfActorId=playerModel:getActorID()
local gameInfo=WDCQController.getActorGameInfo(selfActorId)
if not gameInfo then
return
end
local selfGroupId=gameInfo.groupId
local selfStageId=gameInfo.stageId
local idx=gameInfo.idx
local posEnum=gameInfo.posEnum
local curTime=timeHelper.getServerShortTime()
local roundCfg=WDCQController.getRoundCfg(selfGroupId,selfStageId,idx)

if roundCfg then
if curTime==roundCfg.selectDzEndTime then
if WDCQController.checkNeedSynData()then

WDCQController.req_38_10()
return
end
end
end

local lastReq=self.reqFlagList["req38_10"]
if lastReq and(curTime-lastReq)<300 then
return
end

self.reqFlagList["req38_10"]=curTime

local macthStage,preStage,adjustStage=WDCQController.getMacthStage(selfGroupId,selfStageId,idx)
if macthStage==WDCQCMatchStageEnum.ePreTheGame and preStage==WDCQCPreGameStageEnum.eSelectDz then
if WDCQController.checkNeedSynData()then

WDCQController.req_38_10()
end
end

end

function WDCQController.checkNeedSynData()
local selcetDZList=WDCQController.getSelectDZList(playerModel:getActorID())
if selcetDZList and#selcetDZList>0 then
for i,v in ipairs(selcetDZList)do
local fight=UIDiscipleModel:getDiscipleFightValue(v.discipleguid)
if fight and not mathHelper.compareInt64(v.fightvalue,fight)then
return true
end
end
end
return false
end

function WDCQController:reqActorGameInfo()
if not WDCQController.checkSysOpen()or not WDCQController.checkInTheGame()then
return
end
local selfActorId=playerModel:getActorID()
local gameInfo=WDCQController.getActorGameInfo(selfActorId)
if not gameInfo then
return
end
local otherActorId=gameInfo.rivalActorId
local selfGroupId=gameInfo.groupId
local selfStageId=gameInfo.stageId
local idx=gameInfo.idx
local posEnum=gameInfo.posEnum
local hasRival=WDCQController.checkMacthRival(selfGroupId,selfStageId,idx)
if not hasRival then
return
end
local macthStage,preStage,adjustStage=WDCQController.getMacthStage(selfGroupId,selfStageId,idx)
if macthStage==WDCQCMatchStageEnum.ePreTheGame then
local actorId
if preStage==WDCQCPreGameStageEnum.eForbiddenDz and otherActorId and not self.reqFlagList["eForbiddenDz"]then
actorId=otherActorId

self.reqFlagList["eForbiddenDz"]=true
elseif preStage==WDCQCPreGameStageEnum.eAdjustTeam then
local reqadjustStageKey=adjustStage*100
if not self.reqFlagList[reqadjustStageKey]then

actorId=selfActorId
self.reqFlagList[reqadjustStageKey]=true
end
elseif preStage==WDCQCPreGameStageEnum.eSelectDz and not self.reqFlagList["eSelectDz"]then

actorId=selfActorId
self.reqFlagList["eSelectDz"]=true
end
if actorId then
WDCQController.req_38_2(actorId)
end
end
end


function WDCQController:checkActorId(actor_id)
if not WDCQController.checkSysOpen()or not WDCQController.checkInTheGame()then
return
end
local selfActorId=playerModel:getActorID()
local gameInfo=WDCQController.getActorGameInfo(selfActorId)
if not gameInfo then
return
end
local otherActorId=gameInfo.rivalActorId
if mathHelper.compareInt64(otherActorId,actor_id)or mathHelper.compareInt64(selfActorId,actor_id)then

reddotControl.on_change_catch_type(CATCH_TYPE.eWenDingCangQiong)
end

end

function WDCQController:checkAllGroupReddot()







return false
end

function WDCQController:checkGroupReddot(group)







return false
end

function WDCQController:checkStageReddot(group,stage)












return false
end

function WDCQController:checkMatchReddot(group,stage,idx)
return false
end


function WDCQController:reqShowWDCQZRInfo(actorId)
local teamList=WDCQController.getTeamDZList(actorId)
if not teamList then
WDCQController.req_38_2(actorId,1)
return
end
WDCQController:showWDCQZRInfo(actorId)
end

function WDCQController:showWDCQZRInfo(actorId)
local teamList=WDCQController.getTeamDZList(actorId)
if not teamList then
return
end
local isSelf=mathHelper.compareInt64(actorId,playerModel:getActorID())
local showCnt=3
if not isSelf then
local gameInfo=WDCQController.getActorGameInfo(actorId)
if not gameInfo then

return
end

local groupId=gameInfo.groupId
local stageId=gameInfo.stageId
local idx=gameInfo.idx
local posEnum=gameInfo.posEnum
local macthStage,preStage,adjustStage=WDCQController.getMacthStage(groupId,stageId,idx)
if macthStage==WDCQCMatchStageEnum.eNone then

return
end
if macthStage==WDCQCMatchStageEnum.ePreTheGame and preStage<WDCQCPreGameStageEnum.eAdjustTeam then

return
end
if macthStage==WDCQCMatchStageEnum.ePreTheGame and preStage==WDCQCPreGameStageEnum.eAdjustTeam then
showCnt=0
for i=1,3 do
local lockFlag=WDCQController.checkTeamAdjustLock(i,posEnum,adjustStage)
if lockFlag then
showCnt=showCnt+1
end
end
end
end

local temp={}
local show=false
for i=1,3 do
for ii,v in ipairs(teamList[i])do
if v~=0 and i<=showCnt then
show=true
local detailDisciple=table.deepCopy(v)
detailDisciple.flag=1
table.insert(temp,detailDisciple)
else
table.insert(temp,{flag=0})
end
end
end
if not show then

return
end

otherPlayerModel:setActorDefTeamsDetail(otherPlayerInfoType.eWenDingCangQiong,actorId,temp)

local lookType=isSelf and DOUFATAI_LOOK_TYPE.eWDCQ_SelfTeam or DOUFATAI_LOOK_TYPE.eWDCQ_OtherTeam

local teams,otherArgs=otherPlayerModel:getActorDefTeams(otherPlayerInfoType.eWenDingCangQiong,actorId)
local rdata={
teamList=teams,
winName="UICommonLookRival_select3TeamWin",
winArgs={
teamCount=3,
},
lookType=lookType,
}
UIManager:showWindow("UICommonLookRivalWin",rdata)
end

function WDCQController:refreshFightLogIdLookup(groupId,rtype,mindex,wdcqRivalInfo)
if not self.fightLogIdLookup then
self.fightLogIdLookup={}
end
if wdcqRivalInfo and wdcqRivalInfo.round_len>0 then
for i,v in ipairs(wdcqRivalInfo.roundList)do
if v.fight_log_id and tostring(v.fight_log_id)~="0"and tostring(v.fight_log_id)~=""then
local teamp={}
teamp.teamIndex=math.ceil(i/3)
teamp.fightIndex=i%3==0 and 3 or i%3
teamp.win_actor_id=v.win_actor_id
teamp.aFight=v.fight_1 or 0
teamp.dFight=v.fight_2 or 0
self.fightLogIdLookup[v.fight_log_id]=teamp
end
end
end
end

function WDCQController:getFightLogIdLookupInfo(fightLogId)
if not self.fightLogIdLookup then
self.fightLogIdLookup={}
end
return self.fightLogIdLookup[fightLogId]
end


function WDCQController:checkInTheGameEx()
return WDCQController.checkInTheGame()or XiWeiSaiController.checkIntheGame()
end



function WDCQController.reddotChange()
if WDCQController.checkSysReddot()then
mainTipsController:onActive(mainTipsType.eLimitAct_WDCQ)
end
end

function WDCQController.addGuessTimerAndRefreshFlag()
WDCQController:refreshGuessFlag()
WDCQController:addGuessFlagChangeTimer()
end

function WDCQController:addGuessFlagChangeTimer()
timeEventController.removeTimingHandler(WDCQController.addGuessTimerAndRefreshFlag)
if not WDCQController.checkSysOpen()or not WDCQController.checkInTheGame()then
return
end
local curTime=timeHelper.getServerShortTime()
local groupEnum,stageEnum,idx,roundListCfg,roundCfg,stageCfgTemp,breakFlag
local num=xiaodaotongModel:getSetup_sliderCnt(XDT_TIPS_TYPE.eWDCQguess)or 0
local beforetime=num*3600
for i,v in ipairs(WDCQCGroupEnumList)do
groupEnum=v
for i2,v2 in ipairs(WDCQCGameStageEnumList)do
stageEnum=v2
roundListCfg=WDCQController.getRoundListCfg(groupEnum,stageEnum)
if roundListCfg and next(roundListCfg)then
for i,v in ipairs(roundListCfg)do
idx=i
local strattiptime=v.startTime-beforetime
if curTime<strattiptime then
timeEventController.addTimingHandler(strattiptime,1,WDCQController.addGuessTimerAndRefreshFlag)
return
elseif curTime<v.startTime then
timeEventController.addTimingHandler(v.startTime,1,WDCQController.addGuessTimerAndRefreshFlag)
return
end
end
end
end
end
end

function WDCQController:checkGuessFlagChange(oldFlag)
if oldFlag~=self.guessFlag then
xiaodaotongModel:refreshTipsList(false)
end
end


function WDCQController:refreshGuessFlag()
local oldFlag=self.guessFlag
self.guessFlag=false






if not WDCQController.checkSysOpen()or not WDCQController.checkInTheGame()then

WDCQController:checkGuessFlagChange(oldFlag)
return
end
local actor_id=playerModel:getActorID()
local actorData=WDCQModel:getData_ActorData(actor_id)
if not actorData then
WDCQController.req_38_2(actor_id)
return
end
local selfCnt=actorData.moneyCnt
if selfCnt<=0 then

WDCQController:checkGuessFlagChange(oldFlag)
return
end
local curTime=timeHelper.getServerShortTime()
local num=xiaodaotongModel:getSetup_sliderCnt(XDT_TIPS_TYPE.eWDCQguess)or 0
local beforetime=num*3600
local groupEnum,stageEnum,idx,roundListCfg,roundCfg,stageCfgTemp
for i,v in ipairs(WDCQCGroupEnumList)do
if self.guessFlag then
break
end
groupEnum=v
for i2,v2 in ipairs(WDCQCGameStageEnumList)do
if self.guessFlag then
break
end
stageEnum=v2
roundListCfg=WDCQController.getRoundListCfg(groupEnum,stageEnum)
if roundListCfg and next(roundListCfg)then
for i,v in ipairs(roundListCfg)do
idx=i


if(v.startTime-beforetime)<=curTime and curTime<v.startTime then






self.guessFlag=true
self.targetGuessRound={groupEnum,stageEnum,idx}
break
end

end
end
end
end

WDCQController:checkGuessFlagChange(oldFlag)
end


function WDCQController:checkGuessState(isRefresh)
if isRefresh then
WDCQController:refreshGuessFlag()
end
return self.guessFlag,self.targetGuessRound
end
