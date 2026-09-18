






local _MODULENAME="douFaTaiController"





gameState.addListener(def_table(_MODULENAME))




douFaTaiController.name=_MODULENAME


douFaTaiController.data={}

function douFaTaiController:onAppStart()
douFaTaiModel:onAppStart()

socketManager:register_receiver(17,1,douFaTaiController.recv_17_1)
socketManager:register_receiver(17,2,douFaTaiController.recv_17_2)
socketManager:register_receiver(17,3,douFaTaiController.recv_17_3)
socketManager:register_receiver(17,4,douFaTaiController.recv_17_4)
socketManager:register_receiver(17,6,douFaTaiController.recv_17_6)
socketManager:register_receiver(17,8,douFaTaiController.recv_17_8)

socketManager:register_receiver(17,10,douFaTaiController.recv_17_10)
socketManager:register_receiver(17,11,douFaTaiController.recv_17_11)
socketManager:register_receiver(17,12,douFaTaiController.recv_17_12)
socketManager:register_receiver(17,13,douFaTaiController.recv_17_13)
socketManager:register_receiver(17,14,douFaTaiController.recv_17_14)


notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)

notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
end


function douFaTaiController:onEnterState()
douFaTaiModel:onEnterState()
self.data={}
notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
end


function douFaTaiController:onServerDataInitFinish()
douFaTaiModel:onServerDataInitFinish()
end


function douFaTaiController:onLeaveState(isReconnect)
douFaTaiModel:onLeaveState()

if isReconnect then
if UIFullDouFaTaiControl.fightStage then
UIFullDouFaTaiControl.fightStage:close()
end
end


self.data={}
notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
end


function douFaTaiController:onLostConnection()

end

function douFaTaiController.onNewDay()
douFaTaiController:req_doufatai_data()
end


function douFaTaiController.onNewDay5am()
douFaTaiModel:init_doufatai_data_5am()
end

function douFaTaiController.on_home_event(etype)
if etype==homeEvent.eEnterHome then
local bdData=douFaTaiController:checkDouFaTaiBuild()
if bdData then
douFaTaiController:initReqDouFaTaiData()
end
end
end

function douFaTaiController.on_system_open(sysid)
if sysid==0 and systemModel.isOpen(SYSTEM_DEFINE.eBuildOpenDouFaTai)then
douFaTaiController:req_doufatai_data()
end
end

function douFaTaiController:checkDouFaTaiBuild()
local bdData=zongmenModel:findBuildingDataByType(zongmenModel:getMountainId(),SLG_SYSTEM_TYPE.eDouFaTai)
return bdData
end

function douFaTaiController.on_building_event(etype,sfId,ubdId,arg1,arg2,arg3)
if etype==buildingEvent.buildComplete then
local bdData=zongmenModel:getBuildingData(ubdId)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local buildType=cfg.build_type
if buildType==SLG_SYSTEM_TYPE.eDouFaTai then
douFaTaiController:initReqDouFaTaiData()
end
end
end



function douFaTaiController:initReqDouFaTaiData()
self:req_doufatai_data()
self:req_rank_data()
self:req_fight_record()

self:req_select_actor()

lundaodahuiController.req_17_20()
lundaodahuiController.req_17_28(0)
local shopId=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1,"shopId")
if shopId then
funcShopController.send_23_1(shopId)
end
end



function douFaTaiController:req_doufatai_data()
socketManager:send_17_1()

local config=douFaTaiModel:getDouFaTaiBasicConfig()
if config.shopId then
funcShopController.send_23_1(config.shopId)
end
end


function douFaTaiController:req_rank_data()
socketManager:send_17_2()
end


function douFaTaiController:req_actor_defense(actor_id,serverId,teamType,openWin,robotType)
local sendId=nil
if type(actor_id)=="number"then
sendId=int64.new(actor_id)
else
sendId=actor_id
end
if not serverId then
serverId=playerModel:getActorServerID()
end
teamType=teamType or 1

local defense=douFaTaiModel:getOtherDefense(teamType,actor_id)
if defense then
if openWin then
douFaTaiController.prePareFight(actor_id,defense[2],defense[3],defense[1],nil,robotType)
else
return defense
end
else
self.requestStamp173=self.requestStamp173 or{}
local requestStamp173=self.requestStamp173[actor_id]
local stamp=timeHelper.getServerShortTime()
if requestStamp173 and stamp<(requestStamp173+20)then return''end
self.requestStamp173[actor_id]=stamp
socketManager:send_17_3(sendId,serverId,teamType)
self.data.sendDefenseType=teamType
self.openWin17_3=openWin
end

end

function douFaTaiController:req_actor_defense_new(actor_id,robotType,openWin,checkNew,mustNew)
local sendId=nil
if type(actor_id)=="number"then
sendId=int64.new(actor_id)
else
sendId=actor_id
end
local callback
if openWin then
callback=function(teamDzList,args)

local sentence=args and args.sentence or''
local monsterFight=0
if not teamDzList then

return
end
for i,v in pairs(teamDzList)do
if v.base then
monsterFight=monsterFight+tonumber(tostring(v.base.fightvalue))
end
end
douFaTaiController.prePareFight(actor_id,sentence,monsterFight,teamDzList,nil,robotType)
end
end
otherPlayerModel:reqActorDefTeams(otherPlayerInfoType.eDouFaTaiDef2,sendId,{dftRobotType=robotType},callback,checkNew,mustNew)
end

function douFaTaiController:req_actor_detail_new(actor_id,robotType,lookType,openWin)
local sendId=nil
if type(actor_id)=="number"then
sendId=int64.new(actor_id)
else
sendId=actor_id
end
local actorInfo
if lookType==DOUFATAI_LOOK_TYPE.eRecord then
actorInfo=douFaTaiModel:getRecordActorInfo(actor_id)
elseif lookType==DOUFATAI_LOOK_TYPE.eRank or lookType==DOUFATAI_LOOK_TYPE.eMain then
actorInfo=douFaTaiModel:getRankActorInfo(actor_id)
end

local callback
if openWin then
callback=function(teamDzList,otherArgs)

douFaTaiModel:setCurLookType(lookType)

local sentence=otherArgs and otherArgs.sentence or''

if sentence==''then
local config=douFaTaiModel:getDouFaTaiBasicConfig()
local defaults=config.sentence
local rand=math.random(1,#defaults)
sentence=defaults[rand]
end
local otherHead,otherKuang,name,wendao,playerHeadInfo=douFaTaiModel:getDouFaTaiActorInfo(actorInfo)
UIManager:showWindow("UICommonLookRivalWin",{teamList=teamDzList,bgType=1,otherArgs={sentence=sentence,playerHeadInfo=playerHeadInfo,name=name}})
end
else
douFaTaiModel:setCurLookType(lookType)
end
otherPlayerController:reqCommonInfo(actor_id,otherPlayerInfoType.eDouFaTaiDef2,{dftRobotType=robotType},callback)
end


function douFaTaiController:req_fight_record()
socketManager:send_17_4()
end


function douFaTaiController:req_beat_back(actor_id,len,dzList)
socketManager:send_17_5(actor_id,len,dzList)
end


function douFaTaiController:req_rank_reward(is_assistant)
socketManager:send_17_6(is_assistant or 0)
end


function douFaTaiController:req_challenge_actor(index,len,dzList)
socketManager:send_17_7(index,len,dzList)
end


function douFaTaiController:req_select_actor()
socketManager:send_17_8()
douFaTaiController.isWaittingRefreshActor=true
end


function douFaTaiController:req_share_fight_log(actor_name,fightLog)
socketManager:send_17_10(actor_name,fightLog)
end


function douFaTaiController:req_edit_defense(title,len,dzList)
socketManager:send_17_11(title,len,dzList)
end


function douFaTaiController:req_replay(logGuid,record)
if self.data.replayRecord then
return
end
socketManager:send_17_12(logGuid)
self.data.replayRecord=record
end



function douFaTaiController.recv_17_1(array)
douFaTaiModel:init_doufatai_data(array)

UIManager:invokeUIMethod("UIDouFaTaiWin","updataView")
UIManager:invokeUIMethod("UIDouFaTaiWin","refreshTime")
UIManager:invokeUIMethod("UIFuncShopWin","updateView",true)
UIManager:invokeUIMethod("UILunDaoInvitationWin","refreshInvitationInfo",true)

lundaodahuiController.refreshDouFaTaiBaoXiang()

notifySystem:postNotify(notifyConfig.onDouFaTaiDataInit)
end


function douFaTaiController.recv_17_2(len,rankList)
douFaTaiModel:init_rank_data(len,rankList)
douFaTaiController:req_fight_record()
end

local recv_17_3_window=
{
"UILDJingCaiWin",
}

function douFaTaiController.recv_17_3(args)
local rank=args[1]
local actor_id=args[2]
local sentence=args[3]
local len=args[4]
local dzList=args[5]
local tLen=args[6]
local teamList=args[7]
if len>0 then
local monsterFight=0

for i,v in ipairs(dzList)do
monsterFight=monsterFight+tonumber(tostring(v.base.fightvalue))


otherPlayerModel:addDZData(actor_id,v)

end

douFaTaiModel:setOtherDefense(douFaTaiController.data.sendDefenseType or 1,actor_id,sentence,monsterFight,teamList)

if douFaTaiController.openWin17_3 then
douFaTaiController.prePareFight(actor_id,sentence,monsterFight,teamList)
douFaTaiController.openWin17_3=nil
end

for i,win in ipairs(recv_17_3_window)do
UIManager:invokeUIMethod(win,"recv_actor_defense",actor_id,{teamList,sentence,monsterFight})
end
end
end


function douFaTaiController.recv_17_4(len,logList)
douFaTaiModel:init_record_data(len,logList)
local win=UIManager:findActiveWindow('UIDouFaTaiRecordWin')
if win then
win:refreshPanel()
end
end


function douFaTaiController.recv_17_6(id)
douFaTaiModel:set_reward_flag(id)
UIManager:invokeUIMethod("UIDouFaTaiRewardWin","refreshItems")
UIManager:invokeUIMethod("UIDouFaTaiWin","refreshRewardReddot")

lundaodahuiController.refreshDouFaTaiBaoXiang()
end


function douFaTaiController.recv_17_8(len,selectList,cd)
douFaTaiController.isWaittingRefreshActor=nil
douFaTaiModel:setPiPeiActorList(len,selectList,cd)
UIManager:invokeUIMethod("UIDouFaTaiChallengeWin","setRereshTime")
UIManager:invokeUIMethod("UIDouFaTaiChallengeWin","onShowArgRecv")
end
































function douFaTaiController.recv_17_10(actor_name,fightLog)
UIManager.info('分享成功')
end


function douFaTaiController.recv_17_11(title,len,dzList)
douFaTaiModel:setSelfDefenseList(title,len,dzList)
if UIManager:isActive("UIDouFaTaiFightExtraWin")then
UIManager.info('保存成功')
fightController:closeSelectStage()
UIFullDouFaTaiControl:showDouFaTaiWindow()
UIManager:closeWindow('UIDouFaTaiFightExtraWin')
end
end


function douFaTaiController.recv_17_12(logGuid,fightLog)

local fightCompleteCallback=function(bId)

douFaTaiController.closeBattle(bId)
UIManager:closeWindow('UIDouFaTaiPlayBackWin')
end

local exitWatchCallback=function(bId)



end
local battleId=fightController:startBallte(fightLog,true,fightCompleteCallback,exitWatchCallback,{hideExitWatch=true,isRePlay=true,exchangeHp=true})

UIFullDouFaTaiControl:closeUI(false)

if douFaTaiController.data.replayRecord then

local Record=douFaTaiController.data.replayRecord
local selfKuang=UISettingModel:get_cur_head_kuang()
local selfHead=UISettingModel:get_cur_head()
local selfName=playerModel:getActorName()
local head,kuang,name,wendao=douFaTaiModel:getDouFaTaiActorInfo(Record)
local winArgs={selfName,selfHead,selfKuang,name,head,kuang}
local battle=fightModel:getBattle(battleId)
if battle then
local leftId=battle:getLeftActorId()
local rightId=battle:getRightActorId()
local actorId=playerModel:getActorID()
if rightId and tostring(tonumber(tostring(rightId)))==tostring(tonumber(tostring(actorId)))then
winArgs={name,head,kuang,selfName,selfHead,selfKuang,isExchange=true}
end
winArgs.leftId=leftId
winArgs.rightId=rightId
end
UIManager:showWindow('UIDouFaTaiPlayBackWin',winArgs)

douFaTaiController.data.replayRecord=nil
end
end

function douFaTaiController.recv_17_13(wendao)
douFaTaiModel:set_doufatai_wendao(wendao)
notifySystem:postNotify(notifyConfig.onDouFaTaiWenDaoChange,wendao)
end


function douFaTaiController:req_17_14(subType,robotType,actorId,assistant,completeCall)
socketManager:send_17_14(subType,robotType,actorId,assistant or 0)
self.completeNianYaCall=completeCall
end


function douFaTaiController.recv_17_14(args)
local subType,actorname,times,wendao,honor,daily_honor,newRank,rewards_len,rewardList,share_str,tzNum,robotType,robotId=unpack(args)
local doufataiData=douFaTaiModel:get_doufatai_data()
douFaTaiModel:setLastData(doufataiData)
douFaTaiModel:set_doufatai_tzNum(tzNum)
douFaTaiModel:update_doufatai_freenum()
douFaTaiModel:checkChangeDailyRewardFlag(doufataiData.rank,newRank)
douFaTaiModel:set_tempHonorToday(douFaTaiModel:get_honorToday())
douFaTaiModel:set_honorToday(daily_honor)



if douFaTaiController.completeNianYaCall then
douFaTaiController.completeNianYaCall()
douFaTaiController.completeNianYaCall=nil
end
end





function douFaTaiController.prePareFight(actor_id,sentence,monsterFight,teamList,monstersList,robotType)
local lookType=douFaTaiModel:getCurLookType()

local list={}
if teamList then
for i,v in pairs(teamList)do



if v.base then
local netData=v.base
netData.equipLookup=v.equipLookup
if v.equipLookup[EQUIP_TYPE.eWeapon]then
netData.discipleweapon=v.equipLookup[EQUIP_TYPE.eWeapon].itemid
end
list[i]={guid=v.base.discipleguid,typo=fightEntityType.diZi,netData=netData,data=v}
end
end

end
local cancelCallBack=function()
fightController:closeSelectStage()
UIManager:closeWindow('UIDouFaTaiFightExtraWin')
if lookType==DOUFATAI_LOOK_TYPE.eBeatBack or lookType==DOUFATAI_LOOK_TYPE.eRecord then
UIFullDouFaTaiControl:showDouFaTaiWindow({subwin=DOUFATAI_SUBWIN_TYPE.record})
elseif lookType==DOUFATAI_LOOK_TYPE.eChallenge or lookType==DOUFATAI_LOOK_TYPE.ePiPeiActor then
UIFullDouFaTaiControl:showChallengeWin()
elseif lookType==DOUFATAI_LOOK_TYPE.eRank then
UIFullDouFaTaiControl:showDouFaTaiWindow({subwin=DOUFATAI_SUBWIN_TYPE.rank})
elseif lookType==DOUFATAI_LOOK_TYPE.eMain then
UIFullDouFaTaiControl:showDouFaTaiWindow()
end
end
if lookType==DOUFATAI_LOOK_TYPE.eBeatBack or lookType==DOUFATAI_LOOK_TYPE.eChallenge then

local winArgs=
{
enterTxt="斗法台",
skipDiscipleStateCheck=true,
statePriorityCheck=false,
skipDiscipleInjuryCheck=true,
monsterFight=monsterFight,
cancelCallBack=cancelCallBack,
dontCloseStage=true,
skipShouYuanCheck=true,
otherArgs={actor_id,sentence,monsterFight,teamList,monstersList,robotType},
}

if robotType==DOUFATAI_ROBOTTYPE.player or robotType==DOUFATAI_ROBOTTYPE.clonePlayer then
winArgs.monsterListEx=list
else
winArgs.monsterList=monstersList
end

if lookType~=DOUFATAI_LOOK_TYPE.eChallenge then
local selfTeamList={}
local doufataiData=douFaTaiModel:get_doufatai_data()
local defenseList=doufataiData.defenseList
for i,v in ipairs(defenseList)do
selfTeamList[i]=v.unitId
end
winArgs.teamList=selfTeamList
end
local enterCallBack=function(guidList,zfId)
UIManager:closeWindow('UIDouFaTaiFightExtraWin')
if lookType==DOUFATAI_LOOK_TYPE.eBeatBack then
fightLaunchController:sendFight(eBattleLaunch.doufatai,guidList,818001,zfId,{2,robotType,actor_id})
else

fightLaunchController:sendFight(eBattleLaunch.doufatai,guidList,818001,zfId,{1,robotType,actor_id})
end
end
winArgs.enterCallBack=enterCallBack
UIFullDouFaTaiControl:closeUI(false)
fightController.showPrepareWin(fightPreSelectModel.fightType.doufatai,winArgs,function(...)
UIManager:showWindow('UIDouFaTaiFightExtraWin',{lookType,actor_id,sentence})
end)
elseif lookType==DOUFATAI_LOOK_TYPE.eLunDaoTeam then
UIFullLunDaoDaHuiControl:showLookRivalWin(actor_id,teamList)
else

UIFullDouFaTaiControl:showWindow('UIDouFaTaiLookRivalWin',{lookType=lookType,actor_id=actor_id,sentence=sentence,teamList=teamList})
end
end

function douFaTaiController:skipFight(actor_id,robotType,completeCall)

local time=timeHelper.getServerShortTime()
local last=self.lastSendSkip

if last and time-last<=3 then
return time-last
end

local guidList=fightPreSelectModel:getTeamData(eFightPreSelectType.doufatai)
local team={}
if guidList==nil or next(guidList)==nil then
local doufataiData=douFaTaiModel:get_doufatai_data()
local defenseList=doufataiData.defenseList
for i,v in ipairs(defenseList)do
if mathHelper.int64_to_number(v.unitId)==0 then
team[i]={0,int64.zero}
else
team[i]={1,v.unitId}
end
end
else

for i=1,fightPreSelectModel.maxPosNum do
if guidList[i]then
team[i]={1,guidList[i]}
else
team[i]={0,int64.zero}
end
end
end
douFaTaiModel:setCurLookType(DOUFATAI_LOOK_TYPE.eChallenge)
local zfId=fightPreSelectModel:getZhenFaData(eFightPreSelectType.doufatai)
fightPreSelectModel:setTeamData(eFightPreSelectType.doufatai,self:getDiziList(team),zfId)
fightModel:setSendExtraArgs(eBattleType.doufatai,{isSkip=true,quickCallback=completeCall})
fightLaunchController:sendFight(eBattleLaunch.doufatai,team,818001,zfId,{1,robotType,actor_id})
self.lastSendSkip=time
return 0
end

function douFaTaiController:getDiziList(guidList)
local list={}
for k,v in pairs(guidList)do
if v[1]==fightPreSelectModel.teamEntityType.dizi then
list[k]=v[2]
end
end
return list
end

function douFaTaiController:getLastSendSkipStamp()
return self.lastSendSkip
end

function douFaTaiController:getSelfDefenseAverageJJLevel()
local data=douFaTaiModel:get_doufatai_data()
local jjlevel=0
local dzLen=0
local defenseLen=data.defenseLen
if defenseLen>0 then
for i,v in ipairs(data.defenseList)do
local guid=v.unitId
if tostring(guid)~='0'then
local jjlv=UIDiscipleModel:getDiscipleJJLevel(guid)
jjlevel=jjlevel+jjlv
dzLen=dzLen+1
end
end
jjlevel=math.floor(jjlevel/dzLen)
end
return jjlevel
end

function douFaTaiController.closeBattle(bId)

if bId then
fightController:closeBattle(bId)
end
isometricMapSystem:leaveBattleMode()
local lookType=douFaTaiModel:getCurLookType()
if lookType==DOUFATAI_LOOK_TYPE.eBeatBack then
UIFullDouFaTaiControl:showDouFaTaiWindow({subwin=DOUFATAI_SUBWIN_TYPE.record})
else
UIFullDouFaTaiControl:showChallengeWin()
douFaTaiController:req_select_actor()
end
end