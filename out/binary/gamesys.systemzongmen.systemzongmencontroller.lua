







local _MODULENAME="systemZongMenController"
gameState.addListener(def_table(_MODULENAME))
systemZongMenController.name=_MODULENAME



function systemZongMenController:onAppStart()
systemZongMenModel:initConfig()
self:registerProtocol()

notifySystem:listenNotify(notifyConfig.onWorldBlockDataInited,self.onWorldBlockDataInited)
notifySystem:listenNotify(notifyConfig.onWorldBlockDataChanged,self.onWorldBlockDataChanged)
notifySystem:listenNotify(notifyConfig.onWorldBlockStateChanged,self.onWorldBlockStateChanged)
notifySystem:listenNotify(notifyConfig.onClickObjectInWorld,self.onClickEntity)
notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
notifySystem:listenNotify(notifyConfig.onShowDiscipleChanged,self.onShowDiscipleChanged)
notifySystem:listenNotify(notifyConfig.onDiscipleRemove,self.onDiscipleRemove)
notifySystem:listenNotify(notifyConfig.onWorldPositionReRandom,self.onWorldPositionReRandom)
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)

worldController:registerSceneState(1,1,function()
local world=worldModel.world
self:createWorldEntity(world)
self:createWorldOutgoerEntity(world)
end)
end

function systemZongMenController:onEnterState(isReconnect)
if not isReconnect then
systemZongMenModel:initData()

systemZongMenModel:loadFightRecordList()
end

end

function systemZongMenController:onLeaveState(isReconnect)
if not isReconnect then
self:endResult()
self:closeOutgoerScene()
systemZongMenModel:clearData()
systemZongMenModel:clearFightFlagLookup()
systemZongMenModel:clearBattleWaitResult()
systemZongMenModel:clearOutgoerData()
systemZongMenModel:clearAllLetter()
systemZongMenModel:clearTempRewards()
end

systemZongMenModel:clearDefenseInfo()
systemZongMenModel:clearAttackInfo()
systemZongMenModel:clearWaitNotifyResult()
self:clearAgainSend_26_33()

self:stopZongMenSceneSpeakTimer()

timeEventController.removeNormalTimerHandler(1,self.name)
self.updating=false
end

function systemZongMenController:onPlayerCreate(...)
end

function systemZongMenController:onProtocolReq(isReconnect)
local infoList=systemZongMenModel:getInfoList()
for i,v in ipairs(infoList)do
systemZongMenModel:checkTaskInit(v)
end

if not isReconnect then
systemZongMenModel:loadRelationLetter()
end


if not self:checkUpdateStop()then
self:startUpdateHandle()
else
self:stopUpdateHandle()
end
end

function systemZongMenController:onLostConnection()

end

function systemZongMenController:onNormalUpdate()
local nowTime=timeHelper.getServerShortTime()


self:onLXShowTick(nowTime)
self:onBattleSendTick(nowTime)
self:onBattleResultDelayTick(nowTime)
self:updateAgainSend_26_33(nowTime)

if self:checkUpdateStop()then
timeEventController.removeNormalTimerHandler(1,self.name)
self.updating=false
end
end

function systemZongMenController:checkUpdateStop()
return not systemZongMenModel:checkAttackWaitShow()and not systemZongMenModel:haveBattleWaitResultNeedSend()and not systemZongMenModel:haveWaitNotifyResult()and not self:hasAgainSend_26_33()
end

function systemZongMenController:startUpdateHandle()
if not self.updating then
timeEventController.addNormalTimerHandler(1,self.name,self)
self.updating=true
end
end

function systemZongMenController:stopUpdateHandle()
if self.updating and self:checkUpdateStop()then
timeEventController.removeNormalTimerHandler(1,self.name)
self.updating=false
end
end

function systemZongMenController.onDiscipleRemove(reason,discipleGuid)
local infoData=systemZongMenModel:findInfoDataByDisciple(discipleGuid)
if infoData then
systemZongMenController:req_infiltrated(infoData.serial,int64.zero)
end
end

function systemZongMenController.onNewDay5am(islogin)
if not islogin then
systemZongMenModel:setGlobalNum(systemZongMenFuncType.eTaYin,0)
systemZongMenModel:setGlobalNum(systemZongMenFuncType.eZaoYao,0)
notifySystem:postNotify(notifyConfig.onSystemZMFunctionNumChange,systemZongMenFuncType.eTaYin)
notifySystem:postNotify(notifyConfig.onSystemZMFunctionNumChange,systemZongMenFuncType.eZaoYao)
systemZongMenController:onFightNewDay5amHandle()
systemZongMenModel:clearDefenseInfo()
end
end

function systemZongMenController.sortGongFaList(a,b)
local aColor=cfgHelper.get2(cfg_disciplegongfaconfig_get,a,'color')
local bColor=cfgHelper.get2(cfg_disciplegongfaconfig_get,b,'color')
if aColor~=bColor then
return aColor>bColor
else
return a<b
end
end

function systemZongMenController.on_home_event(eType)
if eType==homeEvent.eEnterHome then



if systemZongMenModel:isExistFightFlag(systemZongMenFightFlagType.eAttacking)then
systemZongMenController:createZongMenSceneEntity()
end
elseif eType==homeEvent.eLeaveHome then

systemZongMenController:deleteZongMenSceneEntity()
end
end

function systemZongMenController.onNewDay()
systemZongMenModel:clearAllLetter()

notifySystem:postNotify(notifyConfig.onSystemZMLetterChange,false)
end

function systemZongMenController:showMoneyNotify(zmName,type,value)
local typeName=systemZongMenInfoMoneyName[type]
if value>0 then
UIManager.info(FMT.fmt("宗门<{0}>{1}<color=#18ae08> +{2}</color>",zmName,typeName,value))
elseif value<0 then
UIManager.info(FMT.fmt("宗门<{0}>{1}<color=#d01d1d> {2}</color>",zmName,typeName,value))
end
end

function systemZongMenController:showOutgoerLoyaltyNotify(disciplename,value)
if value>0 then
UIManager.info(FMT.fmt("{0}忠诚度<color=#d01d1d> +{1}</color>",disciplename,value))
elseif value<0 then
UIManager.info(FMT.fmt("{0}忠诚度<color=#18ae08> {1}</color>",disciplename,value))
end
end

function systemZongMenController:quickReqRewardVassal(is_assistant)
local infoList=systemZongMenModel:getInfoList()
local serialList={}
for i,v in ipairs(infoList)do
if v.sg_reward_num>0 then
table.insert(serialList,v.serial)
end
end
local len=#serialList
if len>0 then
systemZongMenController:req_reward_vassal(len,serialList,is_assistant or 0)
end
end
