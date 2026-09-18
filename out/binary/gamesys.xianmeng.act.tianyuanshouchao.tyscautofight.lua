




local fightNum=0

function xianmengController:tyscAutoFight(orderID,challengeType)
if not xianmengModel:hasXM()then
xiaoZhuShouController:setIdleState()
return
end
if not limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eTianYuanShouChao)then
xiaoZhuShouController:setIdleState()
return
end
if not limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eTianYuanShouChao)then
xianmengController:showAutoError(orderID,"天渊兽潮未开始")
return
end

fightNum=0

local autoYaoShou=challengeType==1
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local args={orderID=orderID,challengeType=challengeType}
local detailFunc=function()
local detailId=XIAOZHUSHUDETAIL_ENUM.xzs_sub_tysc_challenge
xiaoZhuShouModel:resetWaitReward(detailId)
xiaoZhuShouModel:addDetailData(detailId,args)
end

if autoYaoShou then
local monsterChallengeNum=xianmengModel:getChallengeNum1_TYSC()
if monsterChallengeNum<=0 then
local autoBuyTimesYS=setupData[xzsDataKey.tyscAutoBuyTimesYS]==1
if autoBuyTimesYS then
local monsterBuyNum=xianmengModel:getChallengeBuyNum1_TYSC()
local buyTimesYS=setupData[xzsDataKey.tyscBuyTimesYS]
if monsterBuyNum<buyTimesYS then
local buyTimes=monsterBuyNum+1
local shouchaoNum=cfgHelper.get2(cfg_skyshouchaobaseconfig_get,1,'shouchaoNum')
local costItem=shouchaoNum[3]
local costNum=shouchaoNum[4][buyTimes]
if itemsModel.checkItemEnough(costItem,costNum)then
args.buyNum=buyTimes
socketManager:addNotify(248,14,detailFunc,1)
xianmengController:send_248_14(1)
else

xianmengController:showAutoError(orderID,"购买兽潮挑战次数所需货币不足，已停止自动挑战")
end
else

xianmengController:showAutoError(orderID,"兽潮挑战次数不足，已停止自动挑战")
end
else

xianmengController:showAutoError(orderID,"兽潮挑战次数不足，已停止自动挑战")
end
else
detailFunc()
end
else
local monsterList=xianmengModel:getMonsterList_TYSC(MONSTER_TYPE.eShouLing)
local autoBuyTimesSL=setupData[xzsDataKey.tyscAutoBuyTimesSL]==1
local hasBoss=false
for m_id,monster in pairs(monsterList)do
hasBoss=true
local guid=monster.guid
local bossChallengeNum=xianmengModel:getChallengeNum2_TYSC(guid)
if bossChallengeNum<=0 then
if autoBuyTimesSL then
local bossBuyNum=xianmengModel:getChallengeBuyNum2_TYSC(guid)
local buyTimesSL=setupData[xzsDataKey.tyscBuyTimesSL]
if bossBuyNum<buyTimesSL then
local buyTimes=bossBuyNum+1
local shoulingNum=cfgHelper.get2(cfg_skyshouchaobaseconfig_get,1,'shoulingNum')
local costItem=shoulingNum[3]
local costNum=shoulingNum[4][buyTimes]
if itemsModel.checkItemEnough(costItem,costNum)then
args.m_id=m_id
args.buyNum=buyTimes
socketManager:addNotify(248,15,detailFunc,1)
xianmengController:send_248_15(guid,1)
return
else

end
else

end
end
else
args.m_id=m_id
detailFunc()
return
end
end
if hasBoss then
xianmengController:showAutoError(orderID,"首领挑战次数不足，已停止自动挑战")
else
xianmengController:showAutoError(orderID,"首领暂未出现，已停止自动挑战")
end
end
end

function xianmengController:showAutoError(orderID,errorLog)
local detailCfg=cfg_xiaozhushoudetailconfig_get(XIAOZHUSHUDETAIL_ENUM.xzs_sub_tysc_challenge)
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

function xianmengController:tyscSkipFight(monType,m_id,func)
local time=timeHelper.getServerShortTime()
local last=self.lastSendSkip
if last and time-last<=3 then
return time-last
end
local zfId=fightPreSelectModel:getZhenFaData(fightPreSelectModel.fightType.tianyuanshouchao)
local teamList=fightPreSelectModel:getTeamData(fightPreSelectModel.fightType.tianyuanshouchao)

local guid
local monsterGroupId
if monType~=MONSTER_TYPE.eShouLing then
local monsterList=xianmengModel:getMonsterList_TYSC(monType)
if not monsterList or not next(monsterList)then
return 3
end
local m_id,monster_=next(monsterList)
guid=monster_.guid
monsterGroupId=monster_.monsterGroupId
else
local monster_=xianmengModel:getMonsterByIndex_TYSC(monType,m_id)
guid=monster_.guid
monsterGroupId=monster_.monsterGroupId
end
local mapId=cfgHelper.get2(cfg_monstergroup_get,monsterGroupId,"mapId")
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

local args={quickCallback=func}
fightModel:setSendExtraArgs(eBattleType.tianyuanshouchao,args)

fightLaunchController:sendFight(eBattleLaunch.tianyuanshouchao,team,mapId,zfId,{monType,monsterGroupId,guid,1})
self.lastSendSkip=time
return 0
end
