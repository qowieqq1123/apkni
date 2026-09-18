






local _MODULENAME="XianJieFuMoController"

gameState.addListener(def_table(_MODULENAME))
XianJieFuMoController.name=_MODULENAME
XianJieFuMoController.data={}
XianJieFuMoController.fast=false
XJFMRankType={
eGeRen=1,
eXianMeng=2,
}

function XianJieFuMoController:onAppStart()

XianJieFuMoModel:onAppStart()

socketManager:register_receiver(248,103,XianJieFuMoController.recv_248_103)
socketManager:register_receiver(248,104,XianJieFuMoController.recv_248_104)
socketManager:register_receiver(248,105,XianJieFuMoController.recv_248_105)
socketManager:register_receiver(248,106,XianJieFuMoController.recv_248_106)
socketManager:register_receiver(248,108,XianJieFuMoController.recv_248_108)

end


function XianJieFuMoController:onEnterState(isReconnect)
XianJieFuMoModel:onEnterState()
notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)

notifySystem:listenNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
notifySystem:listenNotify(notifyConfig.onLimitActOpen,self.onLimitActOpen)
notifySystem:listenNotify(notifyConfig.enterXianJie,self.onEnterXianJie)
notifySystem:listenNotify(notifyConfig.leaveXianJie,self.onLeaveXianJie)
timeEventController.addNormalTimerHandler(1,'XianJieFuMoController',self)
end


function XianJieFuMoController:onProtocolReq()
XianJieFuMoModel:onProtocolReq()
if limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eXianJieFuMo)and(limitActivitiesModel:checkActPreview(LIMIT_ACT_TYPE.eXianJieFuMo)or limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eXianJieFuMo))then
if not XianJieFuMoModel.init then
XianJieFuMoController.req_248_103()
end
end
end


function XianJieFuMoController:onLeaveState(isReconnect)
XianJieFuMoModel:onLeaveState(isReconnect)
notifySystem:removelistener(notifyConfig.onShowPrize,self.onShowPrize)

notifySystem:removelistener(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
notifySystem:removelistener(notifyConfig.onLimitActOpen,self.onLimitActOpen)
notifySystem:removelistener(notifyConfig.enterXianJie,self.onEnterXianJie)
notifySystem:removelistener(notifyConfig.leaveXianJie,self.onLeaveXianJie)
timeEventController.removeNormalTimerHandler(1,'XianJieFuMoController',self)

self.data={}
if not isReconnect then
self.fast=false
end
self.main=nil
self.reqRank=nil
self.triggerStopFight=nil
XianJieFuMoController:doExitCfgScene()
end


function XianJieFuMoController:onLostConnection()

end


function XianJieFuMoController:onReConnection(isInitPro)

end




function XianJieFuMoController.req_248_103()

socketManager:send_248_103()
end


function XianJieFuMoController.req_248_104(recv_idx,is_assistant)
socketManager:send_248_104(recv_idx,is_assistant or 0)

end


function XianJieFuMoController.req_248_105(rankTierId)
socketManager:send_248_105(rankTierId)








end


function XianJieFuMoController.req_248_106()
socketManager:send_248_106()








end


function XianJieFuMoController.req_248_107()
if bagControl.checkShowFullEquipBagTips('无法继续挑战')then
return
end

socketManager:send_248_107()
end



function XianJieFuMoController.req_248_108(times)
socketManager:send_248_108(times)
end

function XianJieFuMoController.req_RankList(type,rankTierId)
if type==XJFMRankType.eGeRen then
XianJieFuMoController.req_248_105(rankTierId)
elseif type==XJFMRankType.eXianMeng then
XianJieFuMoController.req_248_106()
end
end



function XianJieFuMoController.recv_248_103(args)
local idx=args[1]
local lvIdx=args[2]
local maxdamage=args[3]
local totaldamage=args[4]
local challengetimes=args[5]
local buytimes=args[6]
local recv_idx=args[7]


local data=XianJieFuMoModel:getData()
data.monIdx=idx
data.lvIdx=lvIdx
data.maxdamage=mathHelper.int64_to_number(maxdamage)
data.totaldamage=mathHelper.int64_to_number(totaldamage)
data.challengedCnt=challengetimes
data.buyedCnt=buytimes
data.recvIdx=recv_idx

local check=XianJieFuMoModel.init
XianJieFuMoModel.init=true

reddotControl.on_change_catch_type(CATCH_TYPE.eXJFM_Target)
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eXianJieFuMo)
UIManager:invokeUIMethod("UIXJFMReward_TargetWin","updateView")
UIManager:invokeUIMethod("UIXianJIeFuMoMainWin","updateView")

if not check then
if XianJieFuMoController:checkInCfgSceneType()then
XianJieFuMoController:onEnterCfgScene()
end
mainTipsController:onActive(mainTipsType.eLimitAct_XJFM)
end
notifySystem:postNotify(notifyConfig.onWorldLeadLastHurtChange)
end



function XianJieFuMoController.recv_248_104(recv_idx,is_assistant)
local data=XianJieFuMoModel:getData()
data.recvIdx=recv_idx
reddotControl.on_change_catch_type(CATCH_TYPE.eXJFM_Target)
UIManager:invokeUIMethod("UIXJFMReward_TargetWin","updateView")
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eXianJieFuMo)
end









function XianJieFuMoController.recv_248_105(lvIdx,len,list,rankidx)
local data=XianJieFuMoModel:getData()
local temp={}
temp.lvIdx=lvIdx
temp.len=len
temp.rankIdx=rankidx
temp.list={}
if len>0 then
for i,v in ipairs(list)do
local rankInfo={}
rankInfo.rank=i
rankInfo.name=v.actor_name
rankInfo.damage=mathHelper.int64_to_number(v.damage)
rankInfo.guild_name=v.guild_name
rankInfo.server_id=v.server_id
table.insert(temp.list,rankInfo)
end
end
if not data.rankList then
data.rankList={}
end
data.rankList[XJFMRankType.eGeRen]=temp
UIManager:invokeUIMethod("UIXianJIeFuMoMainWin","refreshRankList")
XianJieFuMoController:recvRankInfo(XJFMRankType.eGeRen)
end









function XianJieFuMoController.recv_248_106(len,list,rankidx,guild_damage)
local data=XianJieFuMoModel:getData()
local temp={}
temp.len=len
temp.rankIdx=rankidx
temp.list={}
if len>0 then
for i,v in ipairs(list)do
local rankInfo={}
rankInfo.rank=i
rankInfo.name=v.guild_name
rankInfo.damage=mathHelper.int64_to_number(v.damage)
rankInfo.server_id=v.server_id
table.insert(temp.list,rankInfo)
end
end
if not data.rankList then
data.rankList={}
end
data.rankList[XJFMRankType.eXianMeng]=temp
data.xmTotaldamage=mathHelper.int64_to_number(guild_damage)
UIManager:invokeUIMethod("UIXianJIeFuMoMainWin","refreshRankList")
XianJieFuMoController:recvRankInfo(XJFMRankType.eXianMeng)
end


function XianJieFuMoController.recv_248_107(lastdamage,totaldamage,challengetimes)
local data=XianJieFuMoModel:getData()

local lastdamage=mathHelper.int64_to_number(lastdamage)
data.lastdamage=lastdamage
if lastdamage>data.maxdamage then
data.maxdamage=lastdamage
end
data.totaldamage=mathHelper.int64_to_number(totaldamage)
data.challengedCnt=challengetimes

reddotControl.on_change_catch_type(CATCH_TYPE.eXJFM_Target)
UIManager:invokeUIMethod("UIXJFMReward_TargetWin","updateView")
UIManager:invokeUIMethod("UIXianJIeFuMoMainWin","refreshTimes")
UIManager:invokeUIMethod("UIXJFMChallengeWIn","refreshTimes")
UIManager:invokeUIMethod("UIXJFMChallengeWIn","refreshChallenge")
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eXianJieFuMo)
notifySystem:postNotify(notifyConfig.onWorldLeadLastHurtChange)
end



function XianJieFuMoController.recv_248_108(buytimes)
local data=XianJieFuMoModel:getData()
data.buyedCnt=buytimes
UIManager:invokeUIMethod("UIXianJIeFuMoMainWin","refreshTimes")
UIManager:invokeUIMethod("UIXJFMChallengeWIn","refreshTimes")
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eXianJieFuMo)
end




function XianJieFuMoController:showBuyDialogue()
if XianJieFuMoController.checkStopFight()then
UIManager.error("首领已击败，无需再进行挑战")
return
end
local curr=XianJieFuMoModel:getBuyedCnt()
local cfg=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"buy")
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
local singleStr=FMT.fmt("quad-icon={2}-quad<color=#{0}>{1}</color>",colorStr,itemNum,iconStr)
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
if XianJieFuMoController.checkStopFight()then
UIManager.error("首领已击败，无需再进行挑战")
return
end
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
XianJieFuMoController.req_248_108(num)
end,WARNING_TYPE.eWarning)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end


function XianJieFuMoController:checkTargetReddot()
if not XianJieFuMoModel.init then
return false
end
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJieFuMo)then
return false
end
if not limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eXianJieFuMo)then
return false
end
local infos=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"target_reward")
local recvIndex=XianJieFuMoModel:getRecvIdx()
if recvIndex>=#infos then
return false
end

local curdamage=XianJieFuMoModel:getTotaldamage()
for i,v in ipairs(infos)do
if recvIndex<i and curdamage>=v[1]then
return true
end
end
return false
end


function XianJieFuMoController:fightPrepare()
local monsterIdx=XianJieFuMoModel:getMonsterIdx()
local baseCfg=cfgHelper.get1(cfg_fairylandbossconfig_get,1)
local mcfg=baseCfg.monster[monsterIdx]
local lvIdx=XianJieFuMoModel:getData().lvIdx
local monsterId=mcfg[1][lvIdx]
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterId)
local team_cnt=baseCfg.team_cnt

if team_cnt<=1 then
local args={
dontCloseStage=false,
enterTxt=limitActivitiesModel:getActConfig(LIMIT_ACT_TYPE.eXianJieFuMo,"name"),
groupId=monsterId,
monsterList=monsterCfg.monList,
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
isHomeBattle=false,
enterCallBack=function(selectList,zfId)


fightLaunchController:sendFight(eBattleLaunch.xianjieFuMo,selectList,monsterCfg.mapId or 0,zfId)
end,
cancelCallBack=function()
UIFullXianJieFuMoController:showChallengeWin()
end,
}
fightController.showPrepareWin(eFightPreSelectType.xianjiefumo,args,function()
UIFullFightPrepareControl:showWindow("UIFightPrepareWorldBigBossSkillWin",{id=monsterId,tips="首领特性"})
end)
else
local teamData=fightPreSelectModel:getMulTeamSaveData(eFightPreSelectType.xianjiefumo2,team_cnt)
local multipleMonsterList={}
for i=1,team_cnt do
table.insert(multipleMonsterList,monsterCfg.monList)
end
local args={
dontCloseStage=false,
enterTxt=limitActivitiesModel:getActConfig(LIMIT_ACT_TYPE.eXianJieFuMo,"name"),
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
isHomeBattle=false,
multipleMonsterList=multipleMonsterList,
groupId=monsterId,
multipleTeams=teamData,
enterCallBack=function(teamList,zfId)

fightLaunchController:sendFightEx(eBattleLaunch.xianjieFuMo,teamList)
end,
cancelCallBack=function()
UIFullXianJieFuMoController:showChallengeWin()
end,
}
fightController.showPrepareWin(fightPreSelectModel.fightType.xianjiefumo2,args,function()
UIFullFightPrepareControl:showWindow("UIFightPrepareWorldBigBossSkillWin2",{id=monsterId,tips="首领特性"})
end)
end
end

function XianJieFuMoController.onShowPrize(prizeType,rewards,effectData)
if prizeType==ePrizeType.eXJFMFight then
local effectType=effectData.effecttype
local lastdamage=effectData.lastdamage
local totaldamage=effectData.totaldamage
local challengetimes=effectData.challengetimes
XianJieFuMoController.recv_248_107(lastdamage,totaldamage,challengetimes)










reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eXianJieFuMo)
elseif prizeType==ePrizeType.eXJFMSaoDang then
local effectType=effectData.effecttype
local lastdamage=effectData.lastdamage
local totaldamage=effectData.totaldamage
local challengetimes=effectData.challengetimes
XianJieFuMoController.recv_248_107(lastdamage,totaldamage,challengetimes)
local winArgs={
extraWin="UIWorldBattleVictoryWin",
extraParams={
items=rewards,
title=nil,
tips=FMT.fmt("本次战斗造成伤害量：<color=#39ba28>{0}</color>",mathHelper.formatNumber4(mathHelper.int64_to_number(lastdamage),2)),
},
isHideFightBtn=true,
callback=function()
UIManager:closeWindow("UICommonVictoryWin")
end,
}
UIManager:showWindow("UICommonVictoryWin",winArgs)
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eXianJieFuMo)
end
end

function XianJieFuMoController:reqRankInfo(args)
self.main=args
self.reqRank={}
local lvIdx=XianJieFuMoModel:getData().lvIdx
XianJieFuMoController.req_248_105(lvIdx)
self.reqRank[XJFMRankType.eGeRen]=true
XianJieFuMoController.req_248_106()
self.reqRank[XJFMRankType.eXianMeng]=true
end

function XianJieFuMoController:recvRankInfo(type)
if not self.reqRank then
return
end
self.reqRank[type]=nil
if next(self.reqRank)then
return
end
UIFullXianJieFuMoController:showMainWindow(self.main)
self.main=nil
self.reqRank=nil
end







function XianJieFuMoController.getStopFightTime()
local todayZeroTime=timeHelper.getTodayZeroStamp()
local stopFightTime=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"stopFightTime")
local time=todayZeroTime+stopFightTime[1]*3600+stopFightTime[2]*60
return time
end

function XianJieFuMoController.checkStopFight()
local stopFightTime=XianJieFuMoController.getStopFightTime()
local curTime=timeHelper.getServerLongTime()
return curTime>=stopFightTime
end

function XianJieFuMoController:onNormalUpdate(delay)
if self.triggerStopFight then
return
end
if not XianJieFuMoModel.init then
return
end
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJieFuMo)then
return
end
if limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eXianJieFuMo)then
if XianJieFuMoController.checkStopFight()then
self.triggerStopFight=true
self:triggerStopFightTime()
end
end
end

function XianJieFuMoController:triggerStopFightTime()
UIManager:invokeUIMethod("UIXianJIeFuMoMainWin","refreshBossTimes")
reddotControl.on_change_catch_type(CATCH_TYPE.eLimitActChange,LIMIT_ACT_TYPE.eXianJieFuMo)
XianJieFuMoController:doExitCfgScene()
end

function XianJieFuMoController.onLimitActStateChange(actId,actState)
if actId==LIMIT_ACT_TYPE.eXianJieFuMo and limitActivitiesModel:checkActOpen(actId)then
XianJieFuMoController.fast=false
if actState==limitActivitiesModel.actPreviewState then
XianJieFuMoController.req_248_103()
elseif actState==limitActivitiesModel.actDoingState then
XianJieFuMoController.req_248_103()
if XianJieFuMoController:checkInCfgSceneType()then
XianJieFuMoController:onEnterCfgScene()
end
else
if XianJieFuMoController:checkInCfgSceneType()then
XianJieFuMoController:doExitCfgScene()
end
if fullScreenUI.checkFull(UIFullXianJieFuMoController)then
UIFullXianJieFuMoController:closeUI()
end
end
end
end

function XianJieFuMoController.onLimitActOpen(actId,flag)
if actId==LIMIT_ACT_TYPE.eXianJieFuMo then
if flag==1 then
local actInfo=limitActivitiesModel:getActInfo(actId)
if actInfo.state==limitActivitiesModel.actDoingState or actInfo.state==actInfo.actPreviewState then
XianJieFuMoController.req_248_103()
if actInfo.state==limitActivitiesModel.actDoingState then
if XianJieFuMoController:checkInCfgSceneType()then
XianJieFuMoController:onEnterCfgScene()
end
end
end
else
if XianJieFuMoController:checkInCfgSceneType()then
XianJieFuMoController:doExitCfgScene()
end
if fullScreenUI.checkFull(UIFullXianJieFuMoController)then
UIFullXianJieFuMoController:closeUI()
end
end
end
end

function XianJieFuMoController.onEnterXianJie(sceneType)
local cfgsceneType=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"sceneType")
if cfgsceneType==sceneType then
XianJieFuMoController:onEnterCfgScene()
end
end

function XianJieFuMoController.onLeaveXianJie(sceneType)
local cfgsceneType=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"sceneType")
if cfgsceneType==sceneType then
XianJieFuMoController:doExitCfgScene()
end
end


function XianJieFuMoController:checkInCfgSceneType()
local sceneType=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"sceneType")
return xianjieModel:checkSceneType(sceneType)
end

function XianJieFuMoController:onEnterCfgScene()
if not XianJieFuMoModel.init then
return
end
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJieFuMo)then
return
end
if limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eXianJieFuMo)then
if not XianJieFuMoController.checkStopFight()then
self:createBossData(true)
end
end
end

function XianJieFuMoController:doExitCfgScene()
self:removeBossData()
end



function XianJieFuMoController:createBossData(needRefreshAOI)
XianJieFuMoController:removeBossData()
local _bossdata={}
local sceneType=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"sceneType")
local pos=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"pos")
local size=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"size")
_bossdata.scene=xianjieModel:getSceneIndex(sceneType)
_bossdata.size=size
_bossdata.pos=pos
if not self.bossdata then
self.bossdata=xianjieController:createXJClass(xjDataType.eXJFMBoss,_bossdata)
end
if self.bossdata then
self.bossdata:removeEntity()
self.bossdata:createEntity(needRefreshAOI)
end
end

function XianJieFuMoController:removeBossData()
if self.bossdata then
xianjieController:removeXJClass(self.bossdata)
self.bossdata=nil
end
end

function XianJieFuMoController:getBossData()
return self.bossdata
end

function XianJieFuMoController:testInvoke(funcName,...)
return self.bossdata:InvokeEnityFunc(funcName,...)
end


function XianJieFuMoController:createAniDz(body,pos,size,targetPos,showHud,needRefreshAOI,moveSpeed)
return self.bossdata:createAniDz(body,pos,size,targetPos,showHud,needRefreshAOI,moveSpeed)
end

function XianJieFuMoController:removeAllAniDz()
return self.bossdata:removeAllAniDz()
end



function XianJieFuMoController:jumpBossPos(cb)
if self.bossdata then
xianjieController:jumpGrid(self.bossdata.sceneidx,self.bossdata.gridX_c,self.bossdata.gridZ_c,cb,true)
end
end


function XianJieFuMoController:getReddot(countMaxBuy)
if not XianJieFuMoModel.init then
return
end
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJieFuMo)then
return false
end
if not limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eXianJieFuMo)then
return false
end
if XianJieFuMoController:checkTargetReddot()then
return true
end
if not XianJieFuMoController.checkStopFight()then
local cur=XianJieFuMoModel:getChallengedCnt()
local buy=XianJieFuMoModel:getBuyedCnt()
local cfg=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"buy")
local maxBuy=#cfg
if cur and buy then
local free=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"free")
if countMaxBuy then
return cur<(maxBuy+free)
else
return cur<(buy+free)
end
end
end
return false
end

function XianJieFuMoController:getFightReddot()
if not XianJieFuMoModel.init then
return
end
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJieFuMo)then
return false
end
if not limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eXianJieFuMo)then
return false
end
if not XianJieFuMoController.checkStopFight()then
local cur=XianJieFuMoModel:getChallengedCnt()
local buy=XianJieFuMoModel:getBuyedCnt()
if cur and buy then
local free=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"free")
return cur<(buy+free)
end
end
return false
end


function XianJieFuMoController:twxmAutoFight(orderID)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJieFuMo)then
XianJieFuMoController:showAutoError(orderID,"天外降魔未开始")
return
end
if not limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eXianJieFuMo)then
XianJieFuMoController:showAutoError(orderID,"天外降魔未开始")
return
end
if not XianJieFuMoModel.init then
XianJieFuMoController:showAutoError(orderID,"天外降魔未开始")
return
end
if XianJieFuMoController.checkStopFight()then
XianJieFuMoController:showAutoError(orderID,"首领已击败，无法挑战")
return
end

local args={orderID=orderID}
local detailFunc=function()
local detailId=XIAOZHUSHUDETAIL_ENUM.xzs_sub_twxm_challenge
xiaoZhuShouModel:resetWaitReward(detailId)
xiaoZhuShouModel:addDetailData(detailId,args)
end

local setupData=xiaoZhuShouModel:getSetupData(orderID)
local curr=XianJieFuMoModel:getChallengedCnt()
local buy=XianJieFuMoModel:getBuyedCnt()

local free=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"free")
if curr>=buy+free then
local autoBuyTimes=setupData[xzsDataKey.twxmAutoBuyTimes]==1
if autoBuyTimes then
local buyTimesMax=setupData[xzsDataKey.twxmBuyTimes]
local buyCfg=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"buy")
if buy<buyTimesMax then
local buyTimes=buy+1
local costItemCfg=buyCfg[buyTimes]
local costItem=costItemCfg[1]
local costNum=costItemCfg[2]
if itemsModel.checkItemEnough(costItem,costNum)then
args.buyNum=buyTimes
socketManager:addNotify(248,108,detailFunc,1)
XianJieFuMoController.req_248_108(1)
else

XianJieFuMoController:showAutoError(orderID,"购买挑战次数所需货币不足，已停止自动挑战")
end
else

XianJieFuMoController:showAutoError(orderID,"挑战次数不足，已停止自动挑战")
end
else

XianJieFuMoController:showAutoError(orderID,"挑战次数不足，已停止自动挑战")
end
else
detailFunc()
end
end

function XianJieFuMoController:showAutoError(orderID,errorLog)
local detailCfg=cfg_xiaozhushoudetailconfig_get(XIAOZHUSHUDETAIL_ENUM.xzs_sub_twxm_challenge)
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

function XianJieFuMoController:twxmSkipFight(func)
local time=timeHelper.getServerShortTime()
local last=self.lastSendSkip
if last and time-last<=3 then
return time-last
end

local monsterIdx=XianJieFuMoModel:getMonsterIdx()
local monsterLvIdx=XianJieFuMoModel:getMonsterLvIdx()
local baseCfg=cfgHelper.get1(cfg_fairylandbossconfig_get,1)
local mcfg=baseCfg.monster[monsterIdx]
local monsterId=mcfg[1][monsterLvIdx]
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterId)
local team_cnt=baseCfg.team_cnt

local teamData=fightPreSelectModel:getMulTeamSaveData(eFightPreSelectType.xianjiefumo2,team_cnt)
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
fightModel:setSendExtraArgs(eBattleType.xianjiefumo,{quickCallback=func})
fightLaunchController:sendFightEx(eBattleLaunch.xianjieFuMo,teamData,{1})
self.lastSendSkip=time
return 0
end
