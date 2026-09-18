







local _MODULENAME="lingxuwenjianController"
gameState.addListener(def_table(_MODULENAME))
lingxuwenjianController.name=_MODULENAME

local teamCount=2
local enterArgs=nil
local openMemberListType=nil
local openMemberListParams=nil
local setupCnt=nil
local openWJTReplaySign=nil
local nexRaceData=nil
local markCloud=nil
local ZhenFaGuide={
[eLXWJ_ZhenFa_Enum.eLX]=3575,
[eLXWJ_ZhenFa_Enum.eXH]=3574,
[eLXWJ_ZhenFa_Enum.eYT]=3576,
}
local branchGuideId=500110

function lingxuwenjianController:onAppStart()
socketManager:register_receiver(20,151,lingxuwenjianController.recv_20_151)
socketManager:register_receiver(20,152,lingxuwenjianController.recv_20_152)
socketManager:register_receiver(20,153,lingxuwenjianController.recv_20_153)
socketManager:register_receiver(20,154,lingxuwenjianController.recv_20_154)
socketManager:register_receiver(20,155,lingxuwenjianController.recv_20_155)
socketManager:register_receiver(20,156,lingxuwenjianController.recv_20_156)
socketManager:register_receiver(20,157,lingxuwenjianController.recv_20_157)
socketManager:register_receiver(20,158,lingxuwenjianController.recv_20_158)
socketManager:register_receiver(20,159,lingxuwenjianController.recv_20_159)
socketManager:register_receiver(20,160,lingxuwenjianController.recv_20_160)
socketManager:register_receiver(20,161,lingxuwenjianController.recv_20_161)
socketManager:register_receiver(20,162,lingxuwenjianController.recv_20_162)
socketManager:register_receiver(20,164,lingxuwenjianController.recv_20_164)
socketManager:register_receiver(20,165,lingxuwenjianController.recv_20_165)
socketManager:register_receiver(20,166,lingxuwenjianController.recv_20_166)
socketManager:register_receiver(20,167,lingxuwenjianController.recv_20_167)
end

function lingxuwenjianController:onEnterState(isReconnet)
notifySystem:listenNotify(notifyConfig.onLimitActOpen,self.onLimitActOpen)
notifySystem:listenNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
notifySystem:listenNotify(notifyConfig.inNewbie,self.onInNewbie)
end

function lingxuwenjianController:onLeaveState(isReconnet)
lingxuwenjianModel:clearData()
notifySystem:removelistener(notifyConfig.onLimitActOpen,self.onLimitActOpen)
notifySystem:removelistener(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
notifySystem:removelistener(notifyConfig.onNewDay,self.onNewDay)
notifySystem:removelistener(notifyConfig.inNewbie,self.onInNewbie)

enterArgs=nil
openMemberListType=nil
openMemberListParams=nil
setupCnt=nil
openWJTReplaySign=nil
self.enterguid=nil
nexRaceData=nil
markCloud=nil
end

function lingxuwenjianController:onProtocolReq(isReconnet)
lingxuwenjianModel:checkRefreshRank1()
end

function lingxuwenjianController:onLostConnection()

end

function lingxuwenjianController:activeActivity()



local s_t,e_t,raceIndex=lingxuwenjianController:calculateTime()
limitActivitiesModel:addClientAct_lt(LIMIT_ACT_TYPE.eLingXuWenJian,s_t,e_t)
lingxuwenjianModel:setRaceIndex(raceIndex)
lingxuwenjianController:refreshRankEnter(true)

local s_t_,e_t_,raceIndex_=lingxuwenjianController:calculateTime(e_t+1)
nexRaceData={s_t_,e_t_,raceIndex_}
end

function lingxuwenjianController:calculateTime(curTime)
curTime=curTime or gameUtilityModel.getServerLongTime()
local cfg=cfgHelper.get1(cfg_lingxuwenjianconfig_get,1)
local openDay=cfg.open
local o_y,o_m,o_d=timeHelper.getDateNumber(gameUtilityModel.getOpenServerLongTime_kf())
local o_time=timeHelper.timeServer(o_y,o_m,o_d,0,0,0)
local f_o_time=o_time+(openDay-1)*86400
local o_time_w=timeHelper.getWeakDateEx2(f_o_time)
if o_time_w==0 then
o_time_w=7
end
f_o_time=f_o_time-(o_time_w-1)*86400
local f_e_time=f_o_time+cfg.battle*7*86400

local s_t,e_t,raceIndex
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
return s_t,e_t,raceIndex
end

function lingxuwenjianController:getNextRaceData()
return nexRaceData
end

function lingxuwenjianController:refreshRankEnter(flag)
local needClear=true
if flag then
local actInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eLingXuWenJian)
if actInfo then
if not actInfo:checkDoing()and actInfo:checkOpen()then
if self.enterguid==nil then
local enterIconType=ENTER_ICON_TYPE.eNomal
local guid=enterManager:freshEnter({id=1,enterIconType=enterIconType,enterType=ENTER_TYPE.eLXWJZhiZunBang,
params={},getReddotFun=function()
return lingxuwenjianModel:checkLikeRedot()
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


function lingxuwenjianController.onNewDay()
if lingxuwenjianController.enterguid~=nil then
lingxuwenjianModel:setLikeTimes(0)
UIManager:invokeUIMethod('UIXM_LXWJ_Enter_win','rec_like')
UIManager:invokeUIMethod('UIXM_LXWJ_zhizunbang_win','rec_like')
notifySystem:postNotify(notifyConfig.onLimitActReddotChange,LIMIT_ACT_TYPE.eLingXuWenJian)
end
end

function lingxuwenjianController.onLimitActOpen(actID,flag)
if actID~=LIMIT_ACT_TYPE.eLingXuWenJian then return end
if flag then
lingxuwenjianController:refreshRankEnter(true)
end
end

function lingxuwenjianController.onLimitActStateChange(actID,state,isNew)
if actID~=LIMIT_ACT_TYPE.eLingXuWenJian then return end
if state==limitActivitiesModel.actPreviewState then


elseif state==limitActivitiesModel.actDoingState then


if not isNew then
lingxuwenjianModel:resetData()
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eLingXuWenJian)
end
lingxuwenjianController:refreshRankEnter(false)
elseif state==limitActivitiesModel.actIdleState then


elseif state==limitActivitiesModel.actFinishState then
timeEventController.delayDo(2,function()
limitActivitiesModel:removeActInfo(LIMIT_ACT_TYPE.eLingXuWenJian)
lingxuwenjianController:activeActivity()
end)
end
end

function lingxuwenjianController:openScoreWin()
local needRefresh=lingxuwenjianModel:checkRefreshScoreNotes()
if not needRefresh then
UIManager:showWindow('UIXM_LXWJ_ScoreMainWin')
else
lingxuwenjianController:reqScoreRank()
end
end

function lingxuwenjianController:openMemberList(typo,params)
openMemberListType=typo
openMemberListParams=params or{}
local flag=lingxuwenjianModel:checkMemberList()
if flag then
lingxuwenjianController:reqMembers()
else
lingxuwenjianController:openMemberListEx()
end
end

function lingxuwenjianController:openMemberListEx()
if openMemberListType~=nil then
local params=table.deepCopy(openMemberListParams)or{}
local win=nil
if openMemberListType==1 then
win='UIXM_LXWJ_memberOneWin'
elseif openMemberListType==2 then
win='UIXM_LXWJ_memberTwoWin'
elseif openMemberListType==3 then
win='UIXM_LXWJ_memberThreeWin'
elseif openMemberListType==4 then
win='UIXM_LXWJ_memberFourWin'
end
if win~=nil then
local winParams={
titleName='成员列表',
extraWin=win,
extraParams=params,
}
UIManager:showWindow('UICommonDragonBoneWin',winParams)
end
openMemberListType=nil
openMemberListParams=nil
end
end

function lingxuwenjianController:openWJTReplay(lxwjkey)
local needRefresh=lingxuwenjianModel:checkReplayList(0,0,lxwjkey)
if not needRefresh then
lingxuwenjianController:openWJTReplayEx(lxwjkey)
else
openWJTReplaySign=lxwjkey
end
end

function lingxuwenjianController:openWJTReplayEx(lxwjkey)
local temp=lingxuwenjianModel:getReplayList(0,0,lxwjkey)or{}
if#temp>0 then
local data=temp[1]
if data~=nil and data.len>0 then
local isCrossServer=true
local args={}
local zyData=lingxuwenjianModel:getWJTData(0,lxwjkey)
local player1={zyData.actorid,zyData.actorname,zyData.iconInfo}
local zyData_=lingxuwenjianModel:getWJTData(1,lxwjkey)
local player2={zyData_.actorid,zyData_.actorname,zyData_.iconInfo}
local inSide=lingxuwenjianModel:getInWJTSide(data.actorid)
if inSide==1 then
args.player1=player1
args.player2=player2
else
args.player1=player2
args.player2=player1
end
args.data={src=0,lxwjtype=0,lxwjkey=lxwjkey,openReplay=lxwjkey,result=data.result}
args.showBattle=true

args.eReplayType=eRePlayerType.lingxuwenjian3
local args2={}
args2.player1={args.player1[2],args.player1[3]}
args2.player2={args.player2[2],args.player2[3]}
args2.hideFlag=true
args2.showWinTimes=true
fightModel:setSendExtraArgs(eBattleType.lingxuwenjian3,args2)
fightController:send_log_list(data.list,args,isCrossServer)
end
end
end

function lingxuwenjianController.setupDefTeams(typo,teamIndex,args)
teamIndex=teamIndex or 1
local jumpParam={}
if args then
jumpParam.openBattle=args.openBattle
jumpParam.openPos=args.openPos
end
local multipleTeams={}
for teamIdx=1,2 do
local defTeam=lingxuwenjianModel:getDefTeamFive(typo,teamIdx)
multipleTeams[teamIdx]={}
if defTeam then
for posIdx=1,5 do
local dis_guid=defTeam[posIdx]
if mathHelper.validInt64(dis_guid)then
multipleTeams[teamIdx][tostring(dis_guid)]={posIdx,eTeamEntityType.dizi,dis_guid}
end
end
end
end
local dzCountLimit=4
local mapId=cfgHelper.get2(cfg_lingxuwenjianconfig_get,1,'mapid')
local singleFightDescStr=FMT.fmt('每个队伍最多可上阵{0}名弟子',dzCountLimit)
local winArgs=
{
enterTxt="防守阵容",
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
mapId=mapId,
defaultSelectTeamIndex=teamIndex,
multipleTeams=multipleTeams,
cancelCallBack=function()
limitActivitiesController:jump(LIMIT_ACT_TYPE.eLingXuWenJian,jumpParam)
end,
enterCallBack=function(teamList,zfId)
local guidList={}
for teamIdx,v in ipairs(teamList)do
for posIdx,vv in ipairs(v[2])do
local dis_guid=vv[2]
table.insert(guidList,dis_guid)
end
end
local guidList_=lingxuwenjianModel:getDefTeam(typo)
local check=true
if guidList_~=nil then
check=false
for i,dis_guid in ipairs(guidList_)do
if not mathHelper.compareInt64(dis_guid,guidList[i])then
check=true
break
end
end
end
if check then
lingxuwenjianController:reqSetTeam(guidList,typo)
end
limitActivitiesController:jump(LIMIT_ACT_TYPE.eLingXuWenJian,jumpParam)
end,
}
fightController.showPrepareWin(fightPreSelectModel.fightType.lingxuwenjian,winArgs)
end

function lingxuwenjianController:enterBattleScene(args)
args=args or{}
local isEnter=false
if lingxuwenjianModel:getEnterBattle()and UIManager:findActiveWindow('UIXM_LXWJ_BattleWin')~=nil then
isEnter=true
end
if isEnter then
UIManager:showWindow('UIXM_LXWJ_BattleWin',args)
else
enterArgs=args

lingxuwenjianController:reqWJListen(1)
end
end

function lingxuwenjianController:openBattleWin(params)














local lxwjteamtype=params.lxwjteamtype
local posData=params.posData
local extraParams=params.extraParams
local callback=function(teamDzList,other)
local zyData
if posData[1]==0 then
zyData=lingxuwenjianModel:getMyPosData2(other.actorid)
else
zyData=lingxuwenjianModel:getEnemyPosData2(other.actorid)
end
if zyData==nil then
local tips
if lxwjteamtype==1 then
tips='该玩家已不在此阵眼'
else
tips='该玩家已不参与问剑对战'
end
UIManager.error(tips)
return
end
teamDzList=teamDzList or{}
local winParams={}
winParams.teamDzList=teamDzList
winParams.posData=posData
winParams.teamwinrate=other.teamwinrate
winParams.zyData=zyData
winParams.extraParams=extraParams
UIManager:showWindow('UIXM_LXWJ_posInfoWin',winParams)
end

local send_args={serverid=params.server_id,lxwjteamtype=lxwjteamtype}
otherPlayerModel:reqActorDefTeams(otherPlayerInfoType.eLingXuWenJianDef1,params.actorid,send_args,callback,false,true)
end


function lingxuwenjianController:showOtherPlayerRivalInfo(teamDzList)
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

function lingxuwenjianController:checkBattleCond(lxwjtype,lxwjkey,isWarning)
local zyData=lingxuwenjianModel:getEnemyPosData(lxwjtype,lxwjkey)
local raceState=lingxuwenjianModel:getLunState()

local checkTime=false
if raceState==eLXWJ_State.eFight then
local fightState=lingxuwenjianModel:getFightState()
if fightState==eLXWJ_Fight_State.eFight then
checkTime=true
end
end
if checkTime then
local result=lingxuwenjianModel:checkBattleResult()
if result==nil then
local blood=zyData.blood
local isLife=blood>0
if isLife then
return true
else
if isWarning then
UIManager.error('阵眼已被击破，祖师需重新选择目标')
end
end
else
if isWarning then
UIManager.error('胜负已分，无法攻击敌方阵眼')
end
end
else
if isWarning then
UIManager.error('本阶段无法攻击敌方阵眼')
end
end
return false
end

function lingxuwenjianController:onBattleBackError(data)

local tips=nil
local reason=data.ret
if reason==1 then
tips='胜负已分'
elseif reason==2 then
tips='阵眼已击破'
end
if tips~=nil then
UIManager.error(tips)
end
end

function lingxuwenjianController:onBattleBack(result,data)

data.result=result
lingxuwenjianModel:setAttackTimes()
if result==1 then
lingxuwenjianModel:refreshTimes(1)

lingxuwenjianModel:setWinSign(data.lxwjtype,data.lxwjkey)

end
lingxuwenjianModel:refreshTimes(2)

lingxuwenjianModel:setReplayList(1,data.lxwjtype,data.lxwjkey,nil)
end

function lingxuwenjianController:sendChatNotice(desc)
local str=desc
local s='<a;【点击立即前往】;1;0;2,0,4812,args = {};/>'
str=FMT.fmt('{0}{1}',str,s)
chatControl.onRecvSystemMesg(CHAT_MSG_TYPE.eNoFitler,chatConfig.getSystemPosValue({CHAT_CHANNNEL.eXianmeng}),str,"仙盟战公告",false,false)
UIManager.topHourceLamp(desc)
end

function lingxuwenjianController:jumpWJT()
if limitActivitiesController:checkJump(nil,LIMIT_ACT_TYPE.eLingXuWenJian)then
local openPos={0,0}
local jumpParam={openPos=openPos}
return limitActivitiesController:jump(LIMIT_ACT_TYPE.eLingXuWenJian,jumpParam)
end
return false
end

function lingxuwenjianController:setMarkCloud(flag)
markCloud=flag
end

function lingxuwenjianController:doCloseCloud()
if markCloud then
markCloud=nil
loadingControl.closeCloud()
end
end

function lingxuwenjianController.onInNewbie(newbieId,isBegin)
if newbieId==branchGuideId and not isBegin then
local func=function()
local win=UIManager:findActiveWindow("UICommonShowPrizeWin")
local cb=function()
lingxuwenjianController:doWeakGuide()
end
if win then
win:setAttachCB(cb)
else
lingxuwenjianController:doWeakGuide()
end
end
timeEventController.delayDo(0.5,func)
end
end

function lingxuwenjianController:doWeakGuide()
local isIn=newbieControl.isInNewbie()
if not isIn then
local zyData_my=lingxuwenjianModel:getMyPosData2(playerModel:getActorID())
local raceState=lingxuwenjianModel:getLunState()
if not zyData_my and raceState==eLXWJ_State.eStandby then
local curman1,maxman1=lingxuwenjianModel:getMyFaZhenManNum(eLXWJ_ZhenFa_Enum.eLX)
local curman2,maxman2=lingxuwenjianModel:getMyFaZhenManNum(eLXWJ_ZhenFa_Enum.eXH)
local curman3,maxman3=lingxuwenjianModel:getMyFaZhenManNum(eLXWJ_ZhenFa_Enum.eYT)
local isfullman1,isfullman2,isfullman3=curman1>=maxman1,curman2>=maxman2,curman3>=maxman3
if not(isfullman1 and isfullman2 and isfullman3)then
local id=not isfullman1 and eLXWJ_ZhenFa_Enum.eLX or(not isfullman2 and eLXWJ_ZhenFa_Enum.eXH or eYT)
if not isfullman1 and curman1>=curman2 and curman1>=curman3 then
id=eLXWJ_ZhenFa_Enum.eLX
elseif not isfullman2 and curman2>=curman1 and curman2>=curman3 then
id=eLXWJ_ZhenFa_Enum.eXH
elseif not isfullman3 and curman3>=curman1 and curman3>=curman2 then
id=eLXWJ_ZhenFa_Enum.eYT
end
weakGuideController:beginGuide(ZhenFaGuide[id])
end
end
end
end



function lingxuwenjianController:reqInfo1()
socketManager:send_20_151()
end


function lingxuwenjianController:reqInfo2()
socketManager:send_20_152()
end


function lingxuwenjianController:reqSetTeam(guidList,teamtype)



socketManager:send_20_153(#guidList,guidList,teamtype)
end


function lingxuwenjianController:reqRank1()
socketManager:send_20_154()
end


function lingxuwenjianController:reqRank2()
socketManager:send_20_155()
end


function lingxuwenjianController:reqSetup(list)





setupCnt=#list
socketManager:send_20_156(setupCnt,list)
end


function lingxuwenjianController:reqScoreRank()
socketManager:send_20_157()
end


function lingxuwenjianController:reqFightReport(target,lxwjtype,lxwjkey)



socketManager:send_20_158(target,lxwjtype,lxwjkey)
end


function lingxuwenjianController:reqNotes()
socketManager:send_20_159()
end


function lingxuwenjianController:reqWJListen(falg)

socketManager:send_20_160(falg)
end


function lingxuwenjianController:reqMembers()
socketManager:send_20_164()
end


function lingxuwenjianController:reqEnemyInfo()
socketManager:send_20_165()
end


function lingxuwenjianController:reqLike(rank,assist)

socketManager:send_20_166(rank,assist or 0)
end


function lingxuwenjianController:reqLikeList()
socketManager:send_20_167()
end






function lingxuwenjianController.recv_20_151(args)















lingxuwenjianModel:initData(args[2],args[4],args[5],args[9])
lingxuwenjianModel:setLikeTimes(args[6])
lingxuwenjianModel:initLikeTopThree(args[8])
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eLingXuWenJian)
end


function lingxuwenjianController.recv_20_152(args)















local timesList=args[2]
if args[1]<=0 then
timesList={0,0,0,0,0,0,0}
elseif timesList[7]==nil then
timesList[7]=0
end
lingxuwenjianModel:initTimesList(timesList)
lingxuwenjianModel:setRank(args[3])
lingxuwenjianModel:setScore(args[4])
lingxuwenjianModel:refreshRankTopThree(args[6])
UIManager:invokeUIMethod('UIXM_LXWJ_Enter_win','rec_baseData')
end


function lingxuwenjianController.recv_20_153(guidlistlen,guidList,teamtype)




local isBM_old=lingxuwenjianModel:isBaoMing()
lingxuwenjianModel:setDefTeam(teamtype,guidList)
local isBM=lingxuwenjianModel:isBaoMing()

if teamtype==1 then

lingxuwenjianModel:setMemberList(nil)
end
if isBM_old~=isBM then
UIManager:invokeUIMethod('UIXM_LXWJ_Enter_win','rec_baoming')
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eLingXuWenJian)
end
end


function lingxuwenjianController.recv_20_154(len,list,rank)










local top3={}
if len>0 then
for i=1,3 do
top3[i]=list[i]
end
end
lingxuwenjianModel:refreshRankTopThree(top3)
lingxuwenjianModel:setRanklist1(list)
lingxuwenjianModel:setRank(rank)
UIManager:invokeUIMethod('UIXM_LXWJ_Enter_win','rec_ranklist')
UIManager:invokeUIMethod('UIXM_LXWJ_Enter_win','rec_rank')
UIManager:invokeUIMethod('UIXM_LXWJ_RankOneWin','rec_ranklist')
end


function lingxuwenjianController.recv_20_155(len,list)








local temp={}
if len>0 then
for i,v in ipairs(list)do
if v.len>0 then
for i2,v2 in ipairs(v.list)do
v2.session=v.session
table.insert(temp,v2)
end
end
end
end
lingxuwenjianModel:setRanklist2(temp)
UIManager:invokeUIMethod('UIXM_LXWJ_RankTwoWin','rec_ranklist')
end


function lingxuwenjianController.recv_20_156(len,list)






if len>=setupCnt then
UIManager.info('设置成功')
UIManager:invokeUIMethod('UIXM_LXWJ_memberTwoWin','onClickClose')
UIManager:invokeUIMethod('UIXM_LXWJ_memberFourWin','onClickClose')
UIManager:closeWindow('UIXM_LXWJ_posInfoWin')
else

UIManager.error('有新的人员变更')
end
setupCnt=nil
end


function lingxuwenjianController.recv_20_157(args)





















local data={}
local ourList=args[2]or{}
lingxuwenjianModel:handleScoreNotesList(ourList,true)
local enemyList=args[4]or{}
lingxuwenjianModel:handleScoreNotesList(enemyList)
data.ourList=ourList
data.enemyList=enemyList
data.winguildid=args[5]
data.ourscore=args[6]
data.enemyscore=args[7]
data.enemyserverid=args[8]
data.enemyguildicon=args[9]
data.enemyname=args[10]

local isshow=false
if#ourList>0 and#enemyList>0 then
isshow=true
end
data.isshow=isshow
local result=nil
if isshow then
local winguildid_n=mathHelper.int64_to_number(data.winguildid)
if winguildid_n==0 then

result=3
elseif winguildid_n>0 then
if xianmengModel:isMyXM(data.winguildid)then

result=1
else

result=2
end
end
end
data.result=result

local reward=cfgHelper.get3(cfg_lingxuwenjianconfig_get,1,'score',6)
local leftScoreAdd=nil
local rightScoreAdd=nil
if result~=nil then
if result==1 then
leftScoreAdd=reward[1]
rightScoreAdd=reward[2]
elseif result==2 then
leftScoreAdd=reward[2]
rightScoreAdd=reward[1]
else
leftScoreAdd=reward[3]
rightScoreAdd=reward[3]
end
end
data.leftScoreAdd=leftScoreAdd
data.rightScoreAdd=rightScoreAdd
lingxuwenjianModel:setScoreNotesList(data)

UIManager:showWindow('UIXM_LXWJ_ScoreMainWin')
end


function lingxuwenjianController.recv_20_158(target,lxwjtype,lxwjkey,len,list)























if len>0 then
if lxwjtype>0 then

local xmName1,xmName2
for i,v in ipairs(list)do
local temp={}
if v.len>0 then
if xmName1==nil then
xmName1=xianmengModel:getXMName()
local enemyData=lingxuwenjianModel:getEnemyData()
xmName2=enemyData.enemyname
end
local def={}
local zyData
if target==0 then

zyData=lingxuwenjianModel:getMyPosData(v.lxwjtype,v.lxwjkey)
def.xmName=xmName1
else

zyData=lingxuwenjianModel:getEnemyPosData(v.lxwjtype,v.lxwjkey)
def.xmName=xmName2
end
def.actorid=zyData.actorid
def.iconInfo=zyData.iconInfo
def.actorname=zyData.actorname

for i=v.len,1,-1 do
local vv=v.list[i]
vv.def=def
local atk={}
atk.actorid=vv.actorid
atk.iconInfo=vv.iconInfo
atk.actorname=vv.actorname
if target==0 then
atk.xmName=xmName2
else
atk.xmName=xmName1
end
vv.atk=atk
table.insert(temp,vv)
end
end
lingxuwenjianModel:setReplayList(target,v.lxwjtype,v.lxwjkey,temp)
end
else

if lxwjkey>0 then

local temp={}
local v=list[1]

if v.len>0 and v.lxwjtype==0 then
temp[1]=v.list[1]
end
lingxuwenjianModel:setReplayList(target,lxwjtype,lxwjkey,temp)
if openWJTReplaySign then
lingxuwenjianController:openWJTReplayEx(openWJTReplaySign)
openWJTReplaySign=nil
end
else

local temp={}
for i,v in ipairs(list)do

if v.len>0 and v.lxwjtype==0 then
temp[v.lxwjkey]=v.list[1]
end
end
lingxuwenjianModel:setReplayList(target,lxwjtype,lxwjkey,temp)
end
end
end

UIManager:invokeUIMethod('UIXM_LXWJ_replayWin','rec_replay',target,lxwjtype,lxwjkey)
UIManager:invokeUIMethod('UIXM_LXWJ_wjBattleWin','rec_replay',target,lxwjtype,lxwjkey)
end


function lingxuwenjianController.recv_20_159(len,list)










local temp={}
if len>0 then
for i=len,1,-1 do
table.insert(temp,list[i])
end
end
lingxuwenjianModel:setNotesList(temp)
UIManager:invokeUIMethod('UIXM_LXWJ_notesWin','rec_noteslist')
end


function lingxuwenjianController.recv_20_160(flag)



end



function lingxuwenjianController.recv_20_161(args)
















if enterArgs~=nil then

lingxuwenjianModel:initPosData()
end

lingxuwenjianModel:setScore(args[3])
UIManager:invokeUIMethod('UIXM_LXWJ_Enter_win','rec_score')

local old_hasEnemy=lingxuwenjianModel:hasEnemy()
local changeEnemy=false
if args[4]~=nil and args[4]>0 then
local enemyData={}
enemyData.enemyserverid=args[4]
enemyData.enemyscore=args[5]
enemyData.enemyguildicon=args[6]
enemyData.enemyname=args[7]
changeEnemy=lingxuwenjianModel:setEnemyData(enemyData)
end

local changeList=nil
local changeList2=nil
if args[1]>0 then
for i,v in ipairs(args[2])do
if v.lxwjtype==0 then

if changeList2==nil then
changeList2={}
end
if changeList2[v.src]==nil then
changeList2[v.src]={}
end
changeList2[v.src][v.lxwjkey]=true

lingxuwenjianModel:setWJTData(v)
else
if changeList==nil then
changeList={}
end
if changeList[v.src]==nil then
changeList[v.src]={}
end
if changeList[v.src][v.lxwjtype]==nil then
changeList[v.src][v.lxwjtype]={}
end
changeList[v.src][v.lxwjtype][v.lxwjkey]=true
if v.src==0 then

lingxuwenjianModel:setMyPosData(v)
else

lingxuwenjianModel:setEnemyPosData(v)
end
end
end
end


local checkOpen=false
local hasEnemy=lingxuwenjianModel:hasEnemy()
local state=lingxuwenjianModel:getLunState()
if state==eLXWJ_State.eStandby or not hasEnemy then

if enterArgs~=nil then
checkOpen=true
UIManager:showWindow('UIXM_LXWJ_BattleWin',enterArgs)
enterArgs=nil
else

end
end
if not checkOpen then
if changeList then
for src,v in pairs(changeList)do
for lxwjtype,vv in pairs(v)do
if lxwjtype>0 then
UIManager:invokeUIMethod('UIXM_LXWJ_BattleWin','rec_fazhen',src,lxwjtype)
UIManager:invokeUIMethod('UIXM_LXWJ_zhenyanWin','rec_fazhen',src,lxwjtype)
for lxwjkey,vvv in pairs(vv)do
UIManager:invokeUIMethod('UIXM_LXWJ_zhenyanWin','rec_zhenyan',src,lxwjtype,lxwjkey)
end
end
end
end
UIManager:invokeUIMethod('UIXM_LXWJ_memberOneWin','rec_fazhenChange')
UIManager:invokeUIMethod('UIXM_LXWJ_memberTwoWin','rec_fazhenChange')
UIManager:invokeUIMethod('UIXM_LXWJ_memberThreeWin','rec_fazhenChange')
end
if changeList2 then
for src,v in pairs(changeList2)do
for lxwjkey,vv in pairs(v)do
UIManager:invokeUIMethod('UIXM_LXWJ_WenJianWin','rec_posChange',src,lxwjkey)
end
end
UIManager:invokeUIMethod('UIXM_LXWJ_memberFourWin','rec_change')
end
end



local raceState=lingxuwenjianModel:getLunState()
if raceState==eLXWJ_State.eFight and UIManager:isActive('UIXM_LXWJ_Enter_win')and((not old_hasEnemy and hasEnemy)or changeEnemy)then

local func=function()
local isIn=newbieControl.isInNewbie()
if not isIn then
local raceIndex=lingxuwenjianModel:getRaceIndex()
local lunIndex=lingxuwenjianModel:getRaceLunIndex()
if lingxuwenjianModel:checkFisrtBegin(raceIndex,lunIndex)then
UIManager:showWindow('UIXM_LXWJ_pipeiWin')
lingxuwenjianModel:markFisrtBegin(raceIndex,lunIndex)
end
end
end
timeEventController.delayDo(1,func)
UIManager:invokeUIMethod('UIXM_LXWJ_BattleWin','rec_enemy')
UIManager:invokeUIMethod('UIXM_LXWJ_stateWin','rec_enemy')
UIManager:invokeUIMethod('UIXM_LXWJ_WenJianWin','rec_enemy')
UIManager:invokeUIMethod('UIXM_LXWJ_zhenyanWin','rec_enemy')
end
end



function lingxuwenjianController.recv_20_162(args)


















local result_old=lingxuwenjianModel:checkBattleResult()

local myRaceScore=args[5]
local myRaceScore_old=lingxuwenjianModel:getMyRaceScore()or 0
lingxuwenjianModel:setMyRaceScore(myRaceScore)

local enemyRaceScore=args[6]
local enemyRaceScore_old=lingxuwenjianModel:getEnemyRaceScore()or 0
lingxuwenjianModel:setEnemyRaceScore(enemyRaceScore)
if myRaceScore~=myRaceScore_old or enemyRaceScore~=enemyRaceScore_old then
UIManager:invokeUIMethod('UIXM_LXWJ_stateWin','refreshInfo',true)
end

local changeList=nil
if args[1]>0 then
changeList={}
for i,v in ipairs(args[2])do
if changeList[v.src]==nil then
changeList[v.src]={}
end
if changeList[v.src][v.lxwjtype]==nil then
changeList[v.src][v.lxwjtype]={}
end
changeList[v.src][v.lxwjtype][v.lxwjkey]=true
if v.src==0 then

lingxuwenjianModel:setMyPosBlood(v)
else

lingxuwenjianModel:setEnemyPosBlood(v)
end
end
end

if args[3]>0 then
for i,v in ipairs(args[4])do
if v.lxwjtype==0 then
lingxuwenjianModel:setWJTResult(v)
UIManager:invokeUIMethod('UIXM_LXWJ_WenJianWin','rec_posResult',v.lxwjkey)
UIManager:invokeUIMethod('UIXM_LXWJ_wjBattleWin','rec_posResult',v.lxwjkey)
end
end
end

lingxuwenjianModel:initWinSign(args[8])

local result=lingxuwenjianModel:checkBattleResult()
local raceState=lingxuwenjianModel:getLunState()



if raceState==eLXWJ_State.eFight then
if result~=nil then
UIManager:invokeUIMethod('UIXM_LXWJ_BattleWin','rec_result')
UIManager:invokeUIMethod('UIXM_LXWJ_stateWin','rec_result')
UIManager:invokeUIMethod('UIXM_LXWJ_WenJianWin','rec_result')
end
end


if enterArgs~=nil then
UIManager:showWindow('UIXM_LXWJ_BattleWin',enterArgs)
enterArgs=nil
else
if changeList then
for src,v in pairs(changeList)do
for lxwjtype,vv in pairs(v)do
if lxwjtype>0 then
UIManager:invokeUIMethod('UIXM_LXWJ_BattleWin','rec_fazhen',src,lxwjtype)
UIManager:invokeUIMethod('UIXM_LXWJ_zhenyanWin','rec_fazhen',src,lxwjtype)
for lxwjkey,vvv in pairs(vv)do
UIManager:invokeUIMethod('UIXM_LXWJ_zhenyanWin','rec_zhenyan',src,lxwjtype,lxwjkey)
end
end
end
end
end
end




local checkOver=false
if UIManager:isActive('UIXM_LXWJ_Enter_win')then
if raceState==eLXWJ_State.eFinish then
checkOver=true
elseif raceState==eLXWJ_State.eFight then
if result_old==nil and result~=nil then
checkOver=true

UIManager:invokeUIMethod('UIXM_LXWJ_BattleWin','rec_over')
UIManager:invokeUIMethod('UIXM_LXWJ_WenJianWin','rec_over')
UIManager:invokeUIMethod('UIXM_LXWJ_zhenyanWin','rec_over')
UIManager:invokeUIMethod('UIXM_LXWJ_posInfoWin','rec_over')
end
end
end

if checkOver then

local func=function()
local isIn=newbieControl.isInNewbie()
if not isIn then
local raceIndex=lingxuwenjianModel:getRaceIndex()
local lunIndex=lingxuwenjianModel:getRaceLunIndex()
if lingxuwenjianModel:checkFisrtOver(raceIndex,lunIndex)then
UIManager:showWindow('UIXM_LXWJ_pipeiWin')
lingxuwenjianModel:markFisrtOver(raceIndex,lunIndex)
end
end
end
timeEventController.delayDo(1,func)
end
end


function lingxuwenjianController.recv_20_164(len,list)







list=list or{}
if len>0 then
for i,v in ipairs(list)do
local fightValNum=mathHelper.int64_to_number(v.fightvalue)
v.fightValNum=fightValNum
end
end
lingxuwenjianModel:setMemberList(list)
lingxuwenjianController:openMemberListEx()
end


function lingxuwenjianController.recv_20_165(leadername,rank,winrate,memberfight)





local info={}
info.leadername=leadername
info.rank=rank
info.winrate=winrate
info.memberfight=memberfight
info.memberfight_num=mathHelper.int64_to_number(memberfight)
lingxuwenjianModel:setEnemyXMInfo(info)
UIManager:invokeUIMethod('UIXM_LXWJ_XMInfoWin','rec_xmInfo')
end


function lingxuwenjianController.recv_20_166(rank)


lingxuwenjianModel:refreshLikeTimes()
lingxuwenjianModel:setLikeTopOne(rank)
UIManager:invokeUIMethod('UIXM_LXWJ_Enter_win','rec_like',rank)
UIManager:invokeUIMethod('UIXM_LXWJ_zhizunbang_win','rec_like',rank)
notifySystem:postNotify(notifyConfig.onLimitActReddotChange,LIMIT_ACT_TYPE.eLingXuWenJian)
end


function lingxuwenjianController.recv_20_167(len,list)


if len>0 then
lingxuwenjianModel:setLikeTopThree(list)
UIManager:invokeUIMethod('UIXM_LXWJ_zhizunbang_win','rec_like')
end
end



