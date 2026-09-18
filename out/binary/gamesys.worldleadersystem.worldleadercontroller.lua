






local _MODULENAME="worldLeaderController"




gameState.addListener(def_table(_MODULENAME))
worldLeaderController.name=_MODULENAME


worldLeaderController.data={}
worldLeaderController.actId=LIMIT_ACT_TYPE.eShiJieShouLing
worldLeaderController.fast=false

function worldLeaderController:onAppStart()

worldLeaderModel:onAppStart()








socketManager:register_receiver(248,31,self.recv_248_31)
socketManager:register_receiver(248,32,self.recv_248_32)

socketManager:register_receiver(248,34,self.recv_248_34)

worldController:registerSceneState(1,1,self.onEnterWorldSceneEvent)
worldController:registerSceneState(2,1,self.onExitWorldSceneEvent)
notifySystem:listenNotify(notifyConfig.onClickObjectInWorld,self.onClickUnitEvent)
notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
notifySystem:listenNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
notifySystem:listenNotify(notifyConfig.onLimitActOpen,self.onLimitActOpen)
end


function worldLeaderController:onEnterState(isReconnect)
worldLeaderModel:onEnterState()
end


function worldLeaderController:onProtocolReq()
if limitActivitiesModel:checkActOpen(self.actId)and(limitActivitiesModel:checkActPreview(self.actId)or limitActivitiesModel:checkActDoing(self.actId))then
if not worldLeaderModel.init then
worldLeaderController:send_248_31()
end
end
end


function worldLeaderController:onLeaveState(isReconnect)
worldLeaderModel:onLeaveState(isReconnect)
self.onExitWorldSceneEvent()

self.data={}
if not isReconnect then
self.fast=false
end
end


function worldLeaderController:onLostConnection()

end


function worldLeaderController:onReConnection(isInitPro)

end



function worldLeaderController:send_248_31()














socketManager:send_248_31()
end

function worldLeaderController:send_248_32(stageIdx)
socketManager:send_248_32(stageIdx)
end

function worldLeaderController:send_248_33()
if bagControl.checkShowFullEquipBagTips('无法继续挑战')then
return
end
socketManager:send_248_33()
end

function worldLeaderController:send_248_34(num)
socketManager:send_248_34(num or 1)
end

function worldLeaderController.recv_248_31(args)
local check=worldLeaderModel.init
worldLeaderModel:setData(args[1],args[2],args[3],args[4],args[5],args[6])
UIManager:invokeUIMethod("UIWorldBigBossActivityRankWin","resetView")
if not check and worldController:isInWorld()then
worldLeaderController.onEnterWorldSceneEvent()
mainTipsController:onActive(mainTipsType.eLimitAct_SJSL)
end
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eShiJieShouLing)
notifySystem:postNotify(notifyConfig.onWorldLeadLastHurtChange,args[3],args[4])
end

function worldLeaderController.recv_248_32(stageIdx,len,list,rank)
worldLeaderModel:pushRank(stageIdx,list,rank)
UIManager:invokeUIMethod("UIWorldBigBossActivityRankWin","refreshRankList",stageIdx)
end

function worldLeaderController.recv_248_33(lastDamage,totalDamage,challengeTimes)
local check=worldLeaderModel:setLastDamage(lastDamage)
worldLeaderModel:setTotalDamage(totalDamage)
worldLeaderModel:setChallengeTimes(challengeTimes)
UIManager:invokeUIMethod("UIWorldBigBossActivityRankWin","refreshTimes")
UIManager:invokeUIMethod("UIWorldBigBossActivityChallengeWIn","refreshChallenge")
notifySystem:postNotify(notifyConfig.onWorldLeadLastHurtChange,lastDamage,totalDamage)
end

function worldLeaderController.recv_248_34(buyNum)
worldLeaderModel:setBuyTimes(buyNum)
UIManager.info("成功购买挑战次数")
UIManager:invokeUIMethod("UIWorldBigBossActivityRankWin","refreshTimes")
UIManager:invokeUIMethod("UIWorldBigBossActivityChallengeWIn","refreshTimes")
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eShiJieShouLing)
end

















function worldLeaderController:fightPrepare()
local monsterIdx=worldLeaderModel:getMonsterIdx()
local stageIdx=worldLeaderModel:getStageIdx()
local team_cnt=cfgHelper.get2(cfg_worldbosslevelconfig_get,stageIdx,"team_cnt")
local cfg=cfgHelper.get3(cfg_worldbossconfig_get,1,"monster",monsterIdx)
local monsterId=cfg[1][stageIdx]
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterId)
if team_cnt<=1 then
local args={
dontCloseStage=false,
enterTxt=limitActivitiesModel:getActConfig(LIMIT_ACT_TYPE.eShiJieShouLing,"name"),
groupId=monsterId,
monsterList=monsterCfg.monList,
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
isHomeBattle=false,
enterCallBack=function(selectList,zfId)


fightLaunchController:sendFight(eBattleLaunch.worldLeader,selectList,monsterCfg.mapId or 0,zfId)
end,
cancelCallBack=function()
UIFullWorldBigBossController:showChallengeWin()
end,
}
fightController.showPrepareWin(eFightPreSelectType.worldLeader,args,function()
UIFullFightPrepareControl:showWindow("UIFightPrepareWorldBigBossSkillWin",{id=monsterId,tips="首领特性"})
end)
else
local teamData=fightPreSelectModel:getMulTeamSaveData(eFightPreSelectType.worldLeader2,team_cnt)
local multipleMonsterList={}
for i=1,team_cnt do
table.insert(multipleMonsterList,monsterCfg.monList)
end
local args={
dontCloseStage=false,
enterTxt=limitActivitiesModel:getActConfig(LIMIT_ACT_TYPE.eShiJieShouLing,"name"),
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
isHomeBattle=false,
multipleMonsterList=multipleMonsterList,
groupId=monsterId,
multipleTeams=teamData,
enterCallBack=function(teamList,zfId)

fightLaunchController:sendFightEx(eBattleLaunch.worldLeader,teamList)
end,
cancelCallBack=function()
UIFullWorldBigBossController:showChallengeWin()
end,
}
fightController.showPrepareWin(fightPreSelectModel.fightType.worldLeader2,args,function()
UIFullFightPrepareControl:showWindow("UIFightPrepareWorldBigBossSkillWin2",{id=monsterId,tips="首领特性"})
end)
end
end

function worldLeaderController:onEnterWorld()
local world=cfgHelper.get2(cfg_worldbossconfig_get,1,"world")
if worldModel:isSameWorld(world)and worldLeaderModel.init then
worldLeaderController:showBossUnit()
worldLeaderController:showDiscipleUnits()
worldLeaderController:startAI()
end
end

function worldLeaderController:doExitWorld()
if worldController:isInWorld()then
worldLeaderController:hideBossUnit()
worldLeaderController:hideDiscipleUnits()
worldLeaderController:stopAI()
end
end

function worldLeaderController.onEnterWorldSceneEvent()
if worldLeaderModel.init and limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eShiJieShouLing)and limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eShiJieShouLing)then
worldLeaderController:onEnterWorld()
end
end

function worldLeaderController.onExitWorldSceneEvent()
worldLeaderController:doExitWorld()
end

function worldLeaderController.onClickUnitEvent(args)
if(args and args[1]==eWorldUnitTpye.WORLDLEADER)then
if args[2]==0 then
if limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eShiJieShouLing)then
if limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eShiJieShouLing)then
UIFullWorldBigBossController:showChallengeWin()
else

end
else

end
end
end
end

function worldLeaderController.onShowPrize(prizeType,rewards,effectData)
if prizeType==ePrizeType.eWorldLeaderFight then
local effectType=effectData.effecttype
local lastDamage=effectData.lastdamage
local totalDamage=effectData.totaldamage
local challengeTimes=effectData.challengetimes
worldLeaderController.recv_248_33(lastDamage,totalDamage,challengeTimes)

local fightData=worldLeaderModel:popFightData()
if fightData then
local result=fightData[1]
local log=fightData[2]
local otherData=fightData[3]
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.worldLeader,result,log,rewards,lastDamage,totalDamage)
else
logErr("世界首领战斗没有存入战报数据")
end
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eShiJieShouLing)
elseif prizeType==ePrizeType.eWorldLeaderSweep then
local effectType=effectData.effecttype
local lastDamage=effectData.lastdamage
local totalDamage=effectData.totaldamage
local challengeTimes=effectData.challengetimes
worldLeaderController.recv_248_33(lastDamage,totalDamage,challengeTimes)
local winArgs={
extraWin="UIWorldBattleVictoryWin",
extraParams={
items=rewards,
title=nil,
tips=FMT.fmt("本次战斗造成伤害量：<color=#39ba28>{0}</color>",mathHelper.formatNumber4(tonumber(tostring(lastDamage)),2)),
},
isHideFightBtn=true,
callback=function()
UIManager:closeWindow("UICommonVictoryWin")
end,
}
UIManager:showWindow("UICommonVictoryWin",winArgs)



reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eShiJieShouLing)
end
end

function worldLeaderController.onLimitActStateChange(actId,actState)
if actId==LIMIT_ACT_TYPE.eShiJieShouLing and limitActivitiesModel:checkActOpen(actId)then
worldLeaderController.fast=false
if actState==limitActivitiesModel.actPreviewState then
worldLeaderController:send_248_31()
elseif actState==limitActivitiesModel.actDoingState then
if worldController:isInWorld()then
worldLeaderController:onEnterWorld()
end
else
if worldController:isInWorld()then
worldLeaderController:doExitWorld()
worldLeaderController:hideBossUnit()
worldLeaderController:hideDiscipleUnits()
end
if fullScreenUI.checkFull(UIFullWorldBigBossController)then
UIFullWorldBigBossController:closeUI()
end
end
end
end

function worldLeaderController.onLimitActOpen(actId,flag)
if actId==LIMIT_ACT_TYPE.eShiJieShouLing then
if flag==1 then
local actInfo=limitActivitiesModel:getActInfo(actId)
if actInfo.state==limitActivitiesModel.actDoingState or actInfo.state==actInfo.actPreviewState then
worldLeaderController:send_248_31()
if actInfo.state==limitActivitiesModel.actDoingState then
if worldController:isInWorld()then
worldLeaderController:onEnterWorld()
end
end
end
else
if worldController:isInWorld()then
worldLeaderController:doExitWorld()
worldLeaderController:hideBossUnit()
worldLeaderController:hideDiscipleUnits()
end
if fullScreenUI.checkFull(UIFullWorldBigBossController)then
UIFullWorldBigBossController:closeUI()
end
end
end
end

function worldLeaderController:showBuyDialogue()
local curr=worldLeaderModel:getBuyTimes()
local cfg=cfgHelper.get2(cfg_worldbossconfig_get,1,"buy")
local max=#cfg
if curr>=max then
UIManager.error("购买次数已用完")
return
end
local least=max-curr
local refresh=function(num)
local temp={}
for i=1,num do
local v=cfg[curr+i]
temp[v[1]]=(temp[v[1]]or 0)+v[2]
end
local costStr=nil
for itemId,itemNum in pairs(temp)do
local have=itemsModel.getCount(itemId)
local colorStr=have>=itemNum and"549327FF"or"FF0000FF"
local iconStr=iconHelper.getIconName(itemId)
local singleStr=FMT.fmt("quad-icon={2}-quad<color=#{0}> {1}</color>",colorStr,itemNum,iconStr)
if costStr then
costStr=FMT.fmt("{0}, {1}",costStr,singleStr)
else
costStr=singleStr
end
end
local contentStr=FMT.fmt("是否确定花费{0}购买挑战次数",costStr)
return contentStr
end
local show_data={
type='UIDialougeBuyCount',
title='提示',
refreshcallback=refresh,
max=least,
tips=FMT.fmt("（剩余购买次数：{0}）",least),
oktext='购买',
canceltext='取消',
okcallback=function(num)
local temp={}
for i=1,num do
local v=cfg[curr+i]
temp[v[1]]=(temp[v[1]]or 0)+v[2]
end
local list={}
for itemId,itemNum in pairs(temp)do
table.insert(list,{itemId,itemNum})
end
moneySystem:countAndExchangeEx(list,{[2]=3},function()
worldLeaderController:send_248_34(num)
end,WARNING_TYPE.eWarning)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end


function worldLeaderController:tycyAutoFight(orderID)
if not limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eShiJieShouLing)then
worldLeaderController:showAutoError(orderID,"太岳除妖未开始")
return
end

local args={orderID=orderID}
local detailFunc=function()
local detailId=XIAOZHUSHUDETAIL_ENUM.xzs_sub_tycy_challenge
xiaoZhuShouModel:resetWaitReward(detailId)
xiaoZhuShouModel:addDetailData(detailId,args)
end

local setupData=xiaoZhuShouModel:getSetupData(orderID)
local curr=worldLeaderModel:getChallengeTimes()
local buy=worldLeaderModel:getBuyTimes()

local free=cfgHelper.get2(cfg_worldbossconfig_get,1,"free")
if curr>=buy+free then
local autoBuyTimes=setupData[xzsDataKey.tycyAutoBuyTimes]==1
if autoBuyTimes then
local buyTimesMax=setupData[xzsDataKey.tycyBuyTimes]
local buyCfg=cfgHelper.get2(cfg_worldbossconfig_get,1,"buy")
if buy<buyTimesMax then
local buyTimes=buy+1
local costItemCfg=buyCfg[buyTimes]
local costItem=costItemCfg[1]
local costNum=costItemCfg[2]
if itemsModel.checkItemEnough(costItem,costNum)then
args.buyNum=buyTimes
socketManager:addNotify(248,34,detailFunc,1)
worldLeaderController:send_248_34(1)
else

worldLeaderController:showAutoError(orderID,"购买挑战次数所需货币不足，已停止自动挑战")
end
else

worldLeaderController:showAutoError(orderID,"挑战次数不足，已停止自动挑战")
end
else

worldLeaderController:showAutoError(orderID,"挑战次数不足，已停止自动挑战")
end
else
detailFunc()
end
end

function worldLeaderController:showAutoError(orderID,errorLog)
local detailCfg=cfg_xiaozhushoudetailconfig_get(XIAOZHUSHUDETAIL_ENUM.xzs_sub_tycy_challenge)
local args={
orderID=orderID,
state=-1,
title=detailCfg.name,
icon=detailCfg.icon,
error=errorLog,
completeFunc=function()
xiaoZhuShouController:setIdleState()
end,
}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_ss,args)
end

function worldLeaderController:tycySkipFight(func)
local time=timeHelper.getServerShortTime()
local last=self.lastSendSkip
if last and time-last<=3 then
return time-last
end

local monsterIdx=worldLeaderModel:getMonsterIdx()
local stageIdx=worldLeaderModel:getStageIdx()
local team_cnt=cfgHelper.get2(cfg_worldbosslevelconfig_get,stageIdx,"team_cnt")
local cfg=cfgHelper.get3(cfg_worldbossconfig_get,1,"monster",monsterIdx)
local monsterId=cfg[1][stageIdx]
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterId)
if team_cnt<=1 then
local teamList=fightPreSelectModel:getTeamData(eFightPreSelectType.worldLeader)
local team={}
for i=1,fightPreSelectModel.maxPosNum do
team[i]={0,int64.zero}
end
if not teamList then
local discipleList=discipleLookup:getSortDiscipleList(eDiscipleSortType.eFightSort,nil,eSortOrder.eDown)
for i,v in ipairs(discipleList)do
local netData=v.netData
local discipleguid=netData.net.discipleguid
team[i]={eTeamEntityType.dizi,discipleguid}
if i>=fightPreSelectModel.maxPosNum then
break
end
end
else
for i=1,fightPreSelectModel.maxPosNum do
if teamList[i]then
team[i]={eTeamEntityType.dizi,teamList[i]}
end
end
end
fightModel:setSendExtraArgs(eBattleType.worldLeader,{quickCallback=func})
fightLaunchController:sendFight(eBattleLaunch.worldLeader,team,monsterCfg.mapId,0,{1})
else
local teamData=fightPreSelectModel:getMulTeamSaveData(eFightPreSelectType.worldLeader2,team_cnt)
local hasTeamEmpty=false
for i,v in ipairs(teamData)do
if next(v)==nil then
hasTeamEmpty=true
break
end
end
if hasTeamEmpty then
local discipleList=discipleLookup:getSortDiscipleList(eDiscipleSortType.eFightSort,nil,eSortOrder.eDown)
local maxTeamCount={}
teamData={}
for teamIdx=1,team_cnt do
teamData[teamIdx]={}
maxTeamCount[teamIdx]=5
end

local curTeamIndex=1
local curTeamNum=0
for i,v in ipairs(discipleList)do
local netData=v.netData
local discipleguid=netData.net.discipleguid
local discipleguidStr=netData.net.discipleguidStr
curTeamNum=curTeamNum+1
teamData[curTeamIndex][discipleguidStr]={curTeamNum,eTeamEntityType.dizi,discipleguid}
if curTeamNum>=maxTeamCount[curTeamIndex]then
curTeamIndex=curTeamIndex+1
curTeamNum=0
end
if curTeamIndex>team_cnt then
break
end
end

end
teamData=fightPreSelectModel:getSendData(teamData,monsterCfg.mapId,0)
fightModel:setSendExtraArgs(eBattleType.worldLeader,{quickCallback=func})
fightLaunchController:sendFightEx(eBattleLaunch.worldLeader,teamData,{1})
end

self.lastSendSkip=time
return 0
end
