














gameCounterType={

eGuangGaoNum=1,
eLoginDayNum=2,
eLiLianBossNum=3,
eWorldMonsterNum=4,
eWorldMiJingNum=5,
eDailyTaskNum=6,
eYinXianTaiZhaoMuNum=7,
eFangShiBuyNum=8,
eProductionFreeSpeedupNum=9,
eLingPaiCostNum=12,
eDouFaTaiNum=13,
eXianMengDiGongXDLNum=14,
eFinishingNum=15,
eShareDiscipleRoleInfoNum=16,
eXFWDFightNum=17,
eShareQieChuoInfoNum=18,
eLingXuWenJianShareNum=19,
eTianDaoShuResetNum=20,
eZhengZhanShanHaiDailyShareNum=21,
eZuShiCoupleNum=22,
eDiscipleCoupleNum=23,
eGongFaResetNum=24,
eYifanglingtianGainNum=25,
eAirGameNum=26,
eTianMoJieBehelp=27,
eTianMoJieKillMonsterNum=28,
eXianjiePointShareNum=29,
eCuiTiReset=30,
eXJCJXYTeamActity=31,
eShareLingShouRoleInfoNum=32,
eGreenDanYaoNum=101,
eBlueDanYaoNum=102,
ePurpleDanYaoNum=103,
eOrangeDanYaoNum=104,
eRedDanYaoNum=105,
eGreenFaBaoNum=111,
eBlueFaBaoNum=112,
ePurpleFaBaoNum=113,
eOrangeFaBaoNum=114,
eRedFaBaoNum=115,
eGreenFuBaoNum=121,
eBlueFuBaoNum=122,
ePurpleFuBaoNum=123,
eOrangeFuBaoNum=124,
eRedFuBaoNum=125,
eGreenXuanShangNum=131,
eBlueXuanShangNum=132,
ePurpleXuanShangNum=133,
eOrangeXuanShangNum=134,
eRedXuanShangNum=135,
eLimitActTYSCNum=141,
eLimitActTYCYNum=142,
eLimitActXXXNum=160,
eYYHYMoneyCardDailyRewardNum=161,
eZGGDMoneyCardDailyRewardNum=162,
eXXXMoneyCardDailyRewardNum=170,
eLingTianProduceGreenNum=171,
eLingTianProduceBlueNum=172,
eLingTianProducePurpleNum=173,
eLingTianProduceOrangeNum=174,
eLingTianProduceRedNum=175,
eLinChangProduceGreenNum=176,
eLinChangProduceBlueNum=177,
eLinChangProducePurpleNum=178,
eLinChangProduceOrangeNum=179,
eLinChangProduceRedNum=180,
eKuangChangProduceGreenNum=181,
eKuangChangProduceBlueNum=182,
eKuangChangProducePurpleNum=183,
eKuangChangProduceOrangeNum=184,
eKuangChangProduceRedNum=185,
eLianQiGeProduceGreenNum=186,
eLianQiGeProduceBlueNum=187,
eLianQiGeProducePurpleNum=188,
eLianQiGeProduceOrangeNum=189,
eLianQiGeProduceRedNum=190,


eSuoYaoTaFloorNum=-1,
eHouShanShiLianNum=-2,
eXunBaoShiLianGuanQiaNum=-3,
eGreenGongFaNum=-101,
eBlueGongFaNum=-102,
ePurpleGongFaNum=-103,
eOrangeGongFaNum=-104,
eRedGongFaNum=-105,
eXianXiuDZNum=-110,
eMoXiuDzNum=-111,
}

gameClientCounterChangeType={
eSuoYaoTaFloorChange=1,
eGongFaActive=2,
eHouShanShiLianChange=3,
eXunBaoShiLianChange=4,

eXianMoDzChange=5,
}


local taskCheckChangeType={
[gameCounterType.eXFWDFightNum]=true,
[gameCounterType.eTianMoJieBehelp]=true,
[gameCounterType.eTianMoJieKillMonsterNum]=true,
}


local clientCounterLookup={
[gameCounterType.eSuoYaoTaFloorNum]={
changes={gameClientCounterChangeType.eSuoYaoTaFloorChange},
getNum=function()
if shiLianTaModel:isInit()then
local layer=shiLianTaModel:getClearLayer()
return layer
end
end,
},
[gameCounterType.eHouShanShiLianNum]={
changes={gameClientCounterChangeType.eHouShanShiLianChange},
getNum=function()
local currLevel=UIHuanJingControl:getCurrentLevel()
return currLevel
end,
},
[gameCounterType.eXunBaoShiLianGuanQiaNum]={
changes={gameClientCounterChangeType.eXunBaoShiLianChange},
getNum=function()
local currLevel=xunBaoShiLianModel:getCurrentLevelAllNum()
return currLevel
end,
},
[gameCounterType.eGreenGongFaNum]={
changes={gameClientCounterChangeType.eGongFaActive},
getNum=function()
return UIGongFaModel:getAllActiveCountByColor(eQualityColor.eGreen,true)
end,
},
[gameCounterType.eBlueGongFaNum]={
changes={gameClientCounterChangeType.eGongFaActive},
getNum=function()
return UIGongFaModel:getAllActiveCountByColor(eQualityColor.eBlue,true)
end,
},
[gameCounterType.ePurpleGongFaNum]={
changes={gameClientCounterChangeType.eGongFaActive},
getNum=function()
return UIGongFaModel:getAllActiveCountByColor(eQualityColor.ePurple,true)
end,
},
[gameCounterType.eOrangeGongFaNum]={
changes={gameClientCounterChangeType.eGongFaActive},
getNum=function()
return UIGongFaModel:getAllActiveCountByColor(eQualityColor.eOrange,true)
end,
},
[gameCounterType.eRedGongFaNum]={
changes={gameClientCounterChangeType.eGongFaActive},
getNum=function()
return UIGongFaModel:getAllActiveCountByColor(eQualityColor.eRed,true)
end,
},







[gameCounterType.eXianXiuDZNum]={
changes={gameClientCounterChangeType.eXianMoDzChange},
getNum=function()
local xianxiunum=UIDiscipleModel:getXianMoDiscipleCount()
return xianxiunum
end,
},
[gameCounterType.eMoXiuDzNum]={
changes={gameClientCounterChangeType.eXianMoDzChange},
getNum=function()
local xianxiunum,MoXiuNum=UIDiscipleModel:getXianMoDiscipleCount()
return MoXiuNum
end,
},
}

local data
local client_data

function gameUtilityModel:disposeClientCounterTypeEvent(changeType)
if not gameUtilityModel.checkInit_counter()then
return
end
for accutype,check in pairs(clientCounterLookup)do
local changes=check.changes
if changes then
local pass=false
for i,cType in ipairs(changes)do
if cType==changeType then
pass=true
break
end
end
if pass then

client_data[accutype]=nil
notifySystem:postNotify(notifyConfig.onGameCounterChange,accutype)
end
end
end
end

function gameUtilityModel.initData_counter(data_)
local lookup={}
if data_ then
for i,v in ipairs(data_)do
lookup[v.param_1]=v.param_2
end
end
data=lookup
client_data={}
taskController.onAccumulatedNumChange()
end

function gameUtilityModel.checkInit_counter()
return data~=nil
end

function gameUtilityModel.clear_counter()
data=nil
client_data=nil
end

function gameUtilityModel.clear_counter_client()
client_data={}
end

function gameUtilityModel:setData_counter(accutype,cnt)
if not gameUtilityModel.checkInit_counter()then
return
end
data[accutype]=cnt
notifySystem:postNotify(notifyConfig.onGameCounterChange,accutype)
if taskCheckChangeType[accutype]then
taskController.onAccumulatedNumChange()
end
end

function gameUtilityModel:getData_counter(accutype)
if not gameUtilityModel.checkInit_counter()then
return 0
end
local v
if accutype>0 then
v=data[accutype]
else
v=gameUtilityModel:getData_counter_client(accutype)
end
return v or 0
end

function gameUtilityModel:getData_counter_client(accutype)
if not gameUtilityModel.checkInit_counter()then
return 0
end
if not initProControl.isDone()then
return 0
end
local v=client_data[accutype]
if v==nil then
local check=clientCounterLookup[accutype]
if check then
v=check.getNum()
client_data[accutype]=v
end
end
return v or 0
end

function gameUtilityModel:getData_counterEx(accutypeList)
local c=0
for i,v in ipairs(accutypeList)do
c=c+gameUtilityModel:getData_counter(v)
end
return c
end