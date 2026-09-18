






local _MODULENAME="YuLingZhaiModel"


def_table(_MODULENAME)
YuLingZhaiModel.name=_MODULENAME
YuLingZhaiModel.data={}


YLZ_HEAL_TYPE=
{
eFree=1,
eFast=2,
}


Extra_Speed_TYPE=
{
yandaotai=1,
homebuff=2,
}



function YuLingZhaiModel:onAppStart()

end


function YuLingZhaiModel:onEnterState(isReconnect)
local cfg=cfg_fairylandsoldierconfig()
local hurtMoney={}
for i,c in pairs(cfg)do
hurtMoney[c.money[3]]=1
end
self.hurtMoney=hurtMoney
self.healType=nil
end


function YuLingZhaiModel:onProtocolReq()

end


function YuLingZhaiModel:onLeaveState(isReconnect)

self.data={}
self.healType=nil
end

function YuLingZhaiModel:isMoneyHurtType(moneyType)
return self.hurtMoney[moneyType]
end


function YuLingZhaiModel:getBuildingData(sfId)
local datas=zongmenModel:getBuildingDataByBdType(sfId or zongmenModel:getMountainId(),SLG_SYSTEM_TYPE.eYuLingZhai)
if#datas>0 then
return datas[1]
end
end

function YuLingZhaiModel:setBuildingLv(buildingLv)
self.data.buildingLv=buildingLv
end

function YuLingZhaiModel:getBuildingLv()
if self.data.buildingLv then
return self.data.buildingLv
end
local data=YuLingZhaiModel:getBuildingData(mapIdType.fort)
if data then
return data.level
end
return 1
end

function YuLingZhaiModel:getBuildingLv2()
local data=YuLingZhaiModel:getBuildingData(mapIdType.fort)
if data then
return data.level
end
if self.data.buildingLv then
return self.data.buildingLv
end
return 1
end


function YuLingZhaiModel:setHealData(soldier)
local healData={}
if soldier then
for i,v in ipairs(soldier)do
healData[v.param_1]=v.param_2
end
end
self.data.healData=healData
end

function YuLingZhaiModel:getHealData()
return self.data.healData
end

function YuLingZhaiModel:getSoldierHurtList(checkZero)
local list={}
for id,n in pairs(YuLingZhaiModel:getHealData()or{})do
if not checkZero or n>0 then
list[id]=n
end
end
return list
end


function YuLingZhaiModel:getSoldierAllHurtNum()
local num=0
for id,n in pairs(YuLingZhaiModel:getHealData()or{})do
num=num+n
end
return num
end



function YuLingZhaiModel:getSoldierMax()

local lv=YuLingZhaiModel:getBuildingLv2()
return self:getSoldierMaxEx(lv)
end

function YuLingZhaiModel:getSoldierMaxEx(bdLv)

local buildMax=cfgHelper.get(cfg_yulingzhaiconfig_get,bdLv,"recover_max")

local yandaotaiMaxAdd=YuLingZhaiModel:getMaxAddPercent()
if not yandaotaiMaxAdd or yandaotaiMaxAdd==0 then
local dytAdd=yandaotaiModel:getAddrateDatasByEffectId(3)or{0,0}
yandaotaiMaxAdd=dytAdd[1]or 0
end

local gubaoAddNum=gubaoModel:getYLZMaxHurtNumAddValue()
local gubaoAddRate=gubaoModel:getYLZMaxHurtePercentAddValue()

local maxSoldier=buildMax*(1+gubaoAddRate/100)+yandaotaiMaxAdd+gubaoAddNum
return maxSoldier
end

function YuLingZhaiModel:setHealType(hType)
self.healType=hType
end

function YuLingZhaiModel:getHealType()
return self.healType
end

function YuLingZhaiModel:setHealStartTime(startTime)
self.data.startTime=startTime
end

function YuLingZhaiModel:getHealStartTime()
return self.data.startTime or 0
end

function YuLingZhaiModel:setServerAccTime(accTime)
self.data.accTime=accTime
end

function YuLingZhaiModel:addServerAccTime(accTime)


end

function YuLingZhaiModel:getServerAccTime()
return self.data.accTime or 0
end


function YuLingZhaiModel:getLeftTime(subAccTime)
local healType=self:getHealType()

local healData=self:getHealData()
if not healData then
return-1
end

if healType==YLZ_HEAL_TYPE.eFree then
return self:calcSoldierAccTime(healType,healData,subAccTime)
elseif healType==YLZ_HEAL_TYPE.eFast then
return self:calcSoldierAccTime(healType,healData,subAccTime)
end

return-1
end

function YuLingZhaiModel:getEndStamp()
return self:getHealStartTime()+self:getLeftTime(true)
end


function YuLingZhaiModel:setSpeedAddPercent(speedAddPercent)
self.data.speedAddPercent=speedAddPercent
end




function YuLingZhaiModel:getSpeedAddPercent()
return self.data.speedAddPercent
end

function YuLingZhaiModel:setMaxAddPercent(addPercent)
self.data.maxAddPercent=addPercent
end

function YuLingZhaiModel:getMaxAddPercent()
return self.data.maxAddPercent or 0
end

function YuLingZhaiModel:calcSoldierAccTime(healType,selectList,subAccTime)

local speedAdd=YuLingZhaiModel:getHealSpeedAdd(healType)
local allHp=0

for id,n in pairs(selectList)do
local hp=xianjieModel:getSoldierAttr(id,xjSoldierAttr.hp)
allHp=allHp+hp*n
end
if subAccTime then
return math.ceil(allHp/speedAdd)-YuLingZhaiModel:getServerAccTime()
else
return math.ceil(allHp/speedAdd)
end
end

function YuLingZhaiModel:getHealSpeedAdd(healType)
local lv=YuLingZhaiModel:getBuildingLv()
local bdConfig=cfgHelper.get(cfg_yulingzhaiconfig_get,lv)
local recover_speed=bdConfig.recover_speed
local speedAdd=recover_speed[healType]

local speedPercent=bdConfig.init_speed






local value2=DianFengLevelModel:getDFXianBaoBuildPercent(2)or 0
if value2 and value2>0 then
speedPercent=speedPercent+value2/100
end

local exSpeed=0
if healType==YLZ_HEAL_TYPE.eFast then
if YuLingZhaiModel:getHealType()==healType then
exSpeed=YuLingZhaiModel:getSpeedAddPercent()/10000
else
exSpeed=YuLingZhaiModel:getExtraSpeedAdd()
end
end

speedAdd=speedAdd*(1+speedPercent/100+exSpeed)
return speedAdd
end


function YuLingZhaiModel:getExtraSpeedAdd()
local speedAdd=0
local value=xianjieModel:getJZAttrLookup(eAttributeType.eZL_Speed)
if value and value>0 then
speedAdd=value/10000
end
return speedAdd
end



function YuLingZhaiModel:getSoldierHeal()
local startTime=self:getHealStartTime()
if startTime==0 then
return
end
local healType=self:getHealType()
local now=timeHelper.getServerShortTime()
local subTime=YuLingZhaiModel:getServerAccTime()
local speedAdd=YuLingZhaiModel:getHealSpeedAdd(healType)
return(now+subTime-startTime)*speedAdd
end


function YuLingZhaiModel:isFreeHealCanGet()
if YuLingZhaiModel:isHealFinish()then
return true
end
local num=YuLingZhaiModel:getFreeHealNum()
local cfgnum=cfgHelper.getdef1(cfg_yulingzhaiconfig,'in_adv_recover_hp')

return num>=cfgnum
end

function YuLingZhaiModel:getFreeHealNum(sortList)
local heal=YuLingZhaiModel:getSoldierHeal()

if not sortList then
sortList={}
local hurtList=YuLingZhaiModel:getHealData()or{}
for id,v in pairs(hurtList)do
if v>0 then
table.insert(sortList,{id,v})
end
end
table.sort(sortList,function(a,b)return a[1]>b[1]end)
end
local num=0
for i,v in ipairs(sortList)do
local hp=xianjieModel:getSoldierAttr(v[1],xjSoldierAttr.hp)
if heal-hp*v[2]<0 then
num=num+math.floor(heal/hp)
break
end
heal=heal-hp*v[2]
num=v[2]+num
end
return num
end


function YuLingZhaiModel:isHealFinish()
local startStamp=YuLingZhaiModel:getHealStartTime()
if startStamp==0 then
return
end
local useTime=YuLingZhaiModel:getLeftTime(true)
local endStamp=startStamp+useTime
local now=timeHelper.getServerShortTime()

return endStamp-now<=0
end

function YuLingZhaiModel:calcSoldierCost(selectList)
local lv=YuLingZhaiModel:getBuildingLv()
local bdConfig=cfgHelper.get(cfg_yulingzhaiconfig_get,lv)
local fast_recover=bdConfig.fast_recover

local costList={}
for id,n in pairs(selectList)do
local cost=fast_recover[id]or{}
for i,v in ipairs(cost)do
if v[2]*n>0 then
costList[v[1]]=(costList[v[1]]or 0)+v[2]*n
end
end
end

local list={}
for i,v in pairs(costList)do
table.insert(list,{i,v})
end
return list
end


function YuLingZhaiModel:checkHasQiuZhu()
local canQiuZhu=xianjieModel:getIsCanQiuzhu(speedUpMode.eAskHelp,7)
if not canQiuZhu then
return false
end
local state=YuLingZhaiModel:getHealType()
if state==YLZ_HEAL_TYPE.eFast then
local endStamp=YuLingZhaiModel:getEndStamp()
local now=timeHelper.getServerShortTime()
local left=endStamp-now
if left>0 then
return true
end
end
return false
end


function YuLingZhaiModel:getEffectXGTeQuanActor()
local myActorId=playerModel:getActorID()
local jobConfig=cfgHelper.get(cfg_yulingzhaibaseconfig_get,1,"xgBuffAdd")
local j,t
local job,tq,isMySelf
local actorList={}
for i,v in ipairs(jobConfig)do
j,t=v[1],v[2]
local groupId=xianguanModel:getGroupIdByJob(j)
local jobInfo=xianguanModel:getGroupJobInfo(groupId,j)
if jobInfo then
if mathHelper.compareInt64(myActorId,jobInfo.actorid)then
isMySelf=1
table.insert(actorList,myActorId)
job=j
tq=t
else
local actorid=xianguanModel:fingXianMengOtherActorXianGuan(j)
if actorid then
table.insert(actorList,actorid)
if not job then
job=j
tq=t
end
end
end
end
end
return actorList,job,tq,isMySelf
end


function YuLingZhaiModel:getHealXGTeQuanActor()
local myActorId=playerModel:getActorID()
local jobConfig=cfgHelper.get(cfg_yulingzhaibaseconfig_get,1,"xgAllHealBtn")
local j,t
for i,v in ipairs(jobConfig)do
j,t=v[1],v[2]
local groupId=xianguanModel:getGroupIdByJob(j)
local jobInfo=xianguanModel:getGroupJobInfo(groupId,j)
if jobInfo then
if mathHelper.compareInt64(myActorId,jobInfo.actorid)then
return myActorId,j,t
end
end
end
end