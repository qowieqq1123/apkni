






local _MODULENAME="JuTianYiModel"


def_table(_MODULENAME)
JuTianYiModel.name=_MODULENAME

function JuTianYiModel:onAppStart()

end


function JuTianYiModel:onEnterState(isReconnect)

end


function JuTianYiModel:onProtocolReq()

end


function JuTianYiModel:onLeaveState(isReconnect)

self.moQiRate=nil
self.produceTimeStamp=nil
self.accelerateTime=nil
self.gnosisTimeStamp=nil
self.gnosisNum=nil
self.lastXianQi=nil
self.lastMoQi=nil
self.lastXianQiRate=nil
self.lastMoQiRate=nil
end


function JuTianYiModel:recordLastRate()
self.lastXianQiRate=JuTianYiModel:getIncreaseAddition(1)
self.lastMoQiRate=JuTianYiModel:getIncreaseAddition(2)
end
function JuTianYiModel:getLastRate()
return self.lastXianQiRate,self.lastMoQiRate
end
function JuTianYiModel:setMoQiRate(rate)
self.moQiRate=rate
end

function JuTianYiModel:setProduceTimeStamp(sec)
self.produceTimeStamp=sec
self.lastXianQi=JuTianYiModel:getMoneyIncrease(1)
self.lastMoQi=JuTianYiModel:getMoneyIncrease(2)
end

function JuTianYiModel:setItemAccelerateTime(sec)
self.accelerateTime=sec
self.lastXianQi=JuTianYiModel:getMoneyIncrease(1)
self.lastMoQi=JuTianYiModel:getMoneyIncrease(2)
end
function JuTianYiModel:getItemAccelerateTime()
return self.accelerateTime
end

function JuTianYiModel:setGnosisData(gnosis_sec,gnosis_cnt)
self.gnosisTimeStamp=gnosis_sec
self.gnosisNum=gnosis_cnt
end
function JuTianYiModel:getGnosisNum()
local num=self.gnosisNum or 0
if self.gnosisTimeStamp and self.gnosisTimeStamp>0 then
local gnosis_interval=cfgHelper.getdef(cfg_jutianyiconfig,'gnosis_interval')
local passTime=math.ceil(gameUtilityModel.getServerShortTime2()-self.gnosisTimeStamp)
local gnosisTimes=math.floor(passTime/(gnosis_interval*60*60))
num=num+gnosisTimes
end
local gnosis_max=cfgHelper.getdef(cfg_jutianyiconfig,'gnosis_max')
return math.min(num,gnosis_max)
end
function JuTianYiModel:getGnosisTimeStamp()
return self.gnosisTimeStamp
end

function JuTianYiModel:getMoQiRate()
if self.moQiRate then
return self.moQiRate
end
local init_rate_a=cfgHelper.getdef(cfg_jutianyiconfig,'init_rate_a')or 5
return init_rate_a
end

function JuTianYiModel:getXianQiRate()
if self.moQiRate then
return 10-self.moQiRate
end
local init_rate_b=cfgHelper.getdef(cfg_jutianyiconfig,'init_rate_b')or 5
return init_rate_b
end

function JuTianYiModel:postMoneyChange()
local rwlist={}

local curXQVal=0
local lastXQVal=0
if self.lastXianQi then
curXQVal=JuTianYiModel:getMoneyIncrease(1)
lastXQVal=self.lastXianQi
end
self.lastXianQi=JuTianYiModel:getMoneyIncrease(1)
if curXQVal>lastXQVal then
local changeVal=curXQVal-lastXQVal
local curMoney=moneyModel.getMoney(eMoneyType.mtXianQi)
local lastMoney=curMoney-changeVal

table.insert(rwlist,{eMoneyType.mtXianQi,changeVal})
notifySystem:postNotify(notifyConfig.on_money_changed,eMoneyType.mtXianQi,lastMoney,curMoney,true)
end

local curMQVal=0
local lastMQVal=0
if self.lastMoQi then
curMQVal=JuTianYiModel:getMoneyIncrease(2)
lastMQVal=self.lastMoQi
end
self.lastMoQi=JuTianYiModel:getMoneyIncrease(2)
if curMQVal>lastMQVal then
local changeVal=curMQVal-lastMQVal
local curMoney=moneyModel.getMoney(eMoneyType.mtMoQi)
local lastMoney=curMoney-changeVal

table.insert(rwlist,{eMoneyType.mtMoQi,changeVal})
notifySystem:postNotify(notifyConfig.on_money_changed,eMoneyType.mtMoQi,lastMoney,curMoney,true)
end

local bdData=JuTianYiController:getBuildingData()
local isInFort=zongmenControl:isMountid(mapIdType.fort)
if bdData~=nil and isInFort and#rwlist>0 then
zongmenControl:showPlanReward(mapIdType.fort,bdData.un_build_id,rwlist)
end
end


function JuTianYiModel:getMoneyIncrease(type)
local level=JuTianYiController:getBuildingLevel()
if not level then
return 0
end
local bdData=JuTianYiController:getBuildingData()
local dzId=bdData and bdData.dizi_id or 0
if tostring(dzId)=='0'then
return 0
end
local init_produce=cfgHelper.get2(cfg_jutianyiconfig_get,level,'init_produce')
if not init_produce then
return 0
end
local defCfg=cfgHelper.getdef(cfg_jutianyiconfig)
local incrRate=JuTianYiModel:getIncreaseAddition(type)
if not self.produceTimeStamp or(self.produceTimeStamp<=0)then
return 0
end


local passTime=(timeHelper.getServerShortTime()-self.produceTimeStamp)+(self.accelerateTime or 0)
local times=mathHelper.floor(passTime/defCfg.interval)*defCfg.coefficient_a
local rate=type==2 and JuTianYiModel:getMoQiRate()or(10-JuTianYiModel:getMoQiRate())
local result=mathHelper.floor(init_produce*(incrRate/100))*times*(rate/10)
result=mathHelper.floor(result)
return result
end

function JuTianYiModel:getIncreaseAddition(type)
local bdData=JuTianYiController:getBuildingData()


local lv_addition=0
if bdData then
local level=bdData.level
lv_addition=cfgHelper.get2(cfg_jutianyiconfig_get,level,'lv_addition')
end


local pro_skill_add=0
local dzId=bdData and bdData.dizi_id or 0
local haveDz=tostring(dzId)~='0'
local netData
if haveDz then
netData=UIDiscipleModel:getDiscipleData(dzId)
local bd_tybe_cfg=cfg_monijybuildconfig_get(SLG_SYSTEM_TYPE.eJuTianYi)
local skill_id=bd_tybe_cfg.pro_skill_id
if skill_id then
local skill_cfg=cfg_discipleproskillconfig_get(skill_id)
if netData then
local level=UIDiscipleModel:getDiscipleJobLevelEx(netData,skill_id)
local skill_effect=nil
if skill_cfg.jutianyi_effects then
pro_skill_add=skill_cfg.jutianyi_effects[level]or 0
end
end
end
end


local zmState_add=0
local incrMoneyState=homeBuffModel.getBuffAddValue(BUFF_EFFECT_TYPE.eMoneyProductChanged)
if incrMoneyState then
zmState_add=incrMoneyState[eMoneyType.mtXianQi]or 0
end


local sp_add=0
if haveDz then
sp_add=dzSpecialityGrowEffectController:getMoneyAutoChangeRate(netData,eMoneyType.mtXianQi)
end


local gubao_add=0
if type then
local moneyType=type==1 and eMoneyType.mtXianQi or eMoneyType.mtMoQi
gubao_add=gubaoModel:geteJuTianYiYield(moneyType)
end


local ydt_add=0
if type then
local ydt_addList=yandaotaiModel:getAddrateDatasByEffectId(2)or{}
ydt_add=ydt_addList[type]or 0
end


local scene_add=0
if type then
local scene_rate=homeBuffModel.getBuffAddValue(BUFF_EFFECT_TYPE.eJuTianYiRateAdd)or{}
local moneyType=type==1 and eMoneyType.mtXianQi or eMoneyType.mtMoQi
scene_add=scene_rate[moneyType]or 0
end


local xc_add=0
if type then
local addVal_rate=xingChenCiZhuiEffectController:getEquippedXingChenGrowVal(xingChenGrowEffectChangeType.eJuTianYiMoneyRate)
local moneyType=type==1 and eMoneyType.mtXianQi or eMoneyType.mtMoQi
xc_add=addVal_rate[moneyType]or 0
end

local add=lv_addition+pro_skill_add+zmState_add+sp_add+gubao_add+ydt_add+scene_add+xc_add

return add,lv_addition,pro_skill_add,zmState_add,sp_add,gubao_add,ydt_add,scene_add,xc_add
end