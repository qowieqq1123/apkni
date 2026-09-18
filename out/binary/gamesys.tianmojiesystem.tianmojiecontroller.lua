






local _MODULENAME="tianMoJieController"

gameState.addListener(def_table(_MODULENAME))
tianMoJieController.name=_MODULENAME

local _jctjSubSys=JIUCHONGTIANJIE_SUB_SYS_TYPE.eTianMoJie


function tianMoJieController:onAppStart()

tianMoJieModel:onAppStart()

socketManager:register_receiver(34,121,self.recv_34_121)
socketManager:register_receiver(34,122,self.recv_34_122)
socketManager:register_receiver(34,124,self.recv_34_124)
socketManager:register_receiver(34,125,self.recv_34_125)
socketManager:register_receiver(34,126,self.recv_34_126)
socketManager:register_receiver(34,127,self.recv_34_127)
socketManager:register_receiver(34,128,self.recv_34_128)

notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
notifySystem:listenNotify(notifyConfig.home_event,self.onHomeEvent)
notifySystem:listenNotify(notifyConfig.onEnterOtherHome,self.onEnterOtherHome)
notifySystem:listenNotify(notifyConfig.onExitOtherHome,self.onExitOtherHome)
notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
notifySystem:listenNotify(notifyConfig.onMountainChange,self.onMountainChange)
end


function tianMoJieController:onEnterState(isReconnect)
tianMoJieModel:onEnterState()
end


function tianMoJieController:onProtocolReq()
tianMoJieModel:onProtocolReq()
end


function tianMoJieController:onLeaveState(isReconnect)
self:resetEntityData()
self.deadData=nil
tianMoJieModel:onLeaveState(isReconnect)
end


function tianMoJieController:onLostConnection()

end


function tianMoJieController:onReConnection(isInitPro)

end



function tianMoJieController:send_34_121()
if self:checkSysOpen()then
socketManager:send_34_121()
end
end



function tianMoJieController:send_34_122(actorid)
if not systemConfig.isShield(SYSTEM_DEFINE.eTianMoJie)then
socketManager:send_34_122(actorid)
end
end


function tianMoJieController:send_34_123()
if self:checkSysOpen()then
socketManager:send_34_123()
end
end



function tianMoJieController:send_34_124(stage)
if self:checkSysOpen()then
socketManager:send_34_124(stage)
end
end




function tianMoJieController:send_34_125(actorid,monsterGuid)
if not systemConfig.isShield(SYSTEM_DEFINE.eTianMoJie)then
socketManager:send_34_125(actorid,monsterGuid)
end
end


function tianMoJieController:send_34_126()
if self:checkSysOpen()then
socketManager:send_34_126()
end
end



function tianMoJieController.recv_34_121(args)
local score=args[1]
local flag=args[2]
local daily=args[3]
local guidlistlen=args[4]
local guidList=args[5]
local sec=args[6]

local stageCfg=cfg_tianmojiestageconfig()
flag=mathHelper.cntbit(flag,0,#stageCfg)
tianMoJieModel:setData(score,flag,daily,sec)

local todayZeroLong=timeHelper.getTodayZeroStamp()
local endTime=timeHelper.convertShortStamp(todayZeroLong+86400)
UIDiscipleController:resetDiscipleSignType(guidList or{},dzSignType.eTianMoJie,endTime)

notifySystem:postNotify(notifyConfig.onTianMoJieScoreChange)
end





function tianMoJieController.recv_34_122(actorid,score,tmlistlen,tmList)
local stage=tianMoJieModel:calculateStage(score)
tianMoJieModel:setMonstersByActor(actorid,tmList or{},stage)

tianMoJieController:refreshEntitysByActor(actorid)
local isSelf=playerModel:checkActorId(actorid)
if isSelf and mainControl:isSceneLoaded(eSceneType.eZongmen)and mountainControl:isLoaded(mapIdType.zhufeng)and zongmenModel:getMountainId()==mapIdType.zhufeng and fullScreenUI.isActiveBaseFull()then
if tmlistlen>0 and not UIManager:isActive("UITianMoJieEventWin")then
UIManager:showWindow("UITianMoJieEventWin")
elseif tmlistlen<=0 and UIManager:isActive("UITianMoJieEventWin")then
UIManager:closeWindow("UITianMoJieEventWin")
end
end



notifySystem:postNotify(notifyConfig.onTianMoJieMonsterChange,actorid)

end



function tianMoJieController.recv_34_124(flag)
local oFlag=tianMoJieModel:getFlag()
tianMoJieModel:setFlag(flag)

local prizelist={}
for stage=oFlag+1,flag do
local rewards=cfgHelper.get2(cfg_tianmojiestageconfig_get,stage,"reward")
for i,v in ipairs(rewards)do
showPrizeControl.insertTemp(prizelist,nil,v[1],v[2],true)
end
end
if#prizelist>0 then
showPrizeControl.showWindow(prizelist)
end
end






function tianMoJieController.recv_34_125(actorid,tmguid,helplistlen,helpList)
tianMoJieModel:setMonsterAssists(actorid,tmguid,helpList)
end




function tianMoJieController.recv_34_126(recordlistlen,recordList)
tianMoJieModel:setPlayerAssists(recordList)
end




function tianMoJieController.recv_34_127(tmguid,percent)
tianMoJieModel:updateMonsterPercent(tmguid,percent)
tianMoJieController:refreshEntityBlood(mapIdType.zhufeng,tmguid)

local actorid=playerModel:getActorID()
if percent<=0 then


notifySystem:postNotify(notifyConfig.onTianMoJieMonsterChange,actorid)
notifySystem:postNotify(notifyConfig.onTianMoJieScoreChange)
else
notifySystem:postNotify(notifyConfig.onTianMoJieMonsterHPChange,actorid,tmguid)
end
end



function tianMoJieController.recv_34_128(sec)
tianMoJieModel.setSec(sec)
end



function tianMoJieController.onShowPrize(prizeType,prizelist,effectData)
if prizeType==ePrizeType.eTianMoJie then
local fightData=tianMoJieModel:popFightData()
if fightData then
fightData.data.prizeList=prizelist
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.tianmojie,fightData.result,fightData.log,fightData.data)
end
end
end

function tianMoJieController.onNewDay()
UIDiscipleController:clearDiscipleSignType(dzSignType.eTianMoJie)
tianMoJieModel:clearDaily()
end

function tianMoJieController.onMountainChange(ofs,nfs)
if nfs==mapIdType.zhufeng then
local actorId=playerModel:getActorID()
tianMoJieController:refreshEntitysByActor(actorId)
end
end

function tianMoJieController.onHomeEvent(etype)
if etype==homeEvent.eEnterHome then
tianMoJieController:refreshEntitys(mapIdType.zhufeng,playerModel:getActorID())
tianMoJieController:locatePreSaveMonster(mapIdType.zhufeng,true)
elseif etype==homeEvent.eLeaveHome then
tianMoJieController:clearEntityBySF(mapIdType.zhufeng)
tianMoJieModel:clearDumpDataByActor()
end
end

function tianMoJieController.onEnterOtherHome()
local actorId=visitControl:getCurrentActor()
tianMoJieController:refreshEntitys(mapIdType.zhufeng_hy,actorId)

if tianMoJieModel:checkVisitorLocate(actorId)then
tianMoJieModel:clearVisitorLocate()
tianMoJieController:locateMinHPMonster(mapIdType.zhufeng_hy)
end
end

function tianMoJieController.onExitOtherHome(actorId)
tianMoJieController:clearEntityBySF(mapIdType.zhufeng_hy)
tianMoJieModel:clearDumpDataByActor(actorId)
end

function tianMoJieController:checkSysOpen()
local sysCfg=cfgHelper.get1(cfg_jctjsubsysconfig_get,_jctjSubSys)
return systemModel.isOpen(sysCfg.sysid)
end

function tianMoJieController:onFightMonster(result,data)
tianMoJieModel:updateMonsterPercent(data.tmguid,data.newpercent,data.actorid)

if not playerModel:checkActorId(data.actorid)then
tianMoJieModel:addDaily()
tianMoJieController:refreshEntityBlood(mapIdType.zhufeng_hy,data.tmguid)

if data.newpercent<=0 then

self:send_34_122(data.actorid)
else
notifySystem:postNotify(notifyConfig.onTianMoJieMonsterHPChange,data.actorid,data.tmguid)
end
else
tianMoJieController:refreshEntityBlood(mapIdType.zhufeng,data.tmguid)

if data.newpercent<=0 then
local actorid=data.actorid
local monsters=tianMoJieModel:getMonstersByActor(actorid)


notifySystem:postNotify(notifyConfig.onTianMoJieMonsterChange,data.actorid)
notifySystem:postNotify(notifyConfig.onTianMoJieScoreChange)
else
notifySystem:postNotify(notifyConfig.onTianMoJieMonsterHPChange,data.actorid,data.tmguid)
end
end
end