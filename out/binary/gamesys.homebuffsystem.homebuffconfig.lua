




homeBuffConfig={}

BUFF_EFFECT_TYPE=
{
eFanganProductChanged=1,
eProductRewardChanged=2,
eZhuanyeExpChanged=3,
eDiziXiulianXiaolvChanged=4,
eDiziLiantiXiaolvChanged=5,
eDujieSuccessPrecentChanged=6,
eZongmenMinshengChanged=7,
eShopLingshiChanged=8,
eZiranProductChanged=9,
eShoolZhuanyeExpChanged=10,
eGetXiuweiXiaolvChanged=11,
eProductMonsterSpaceChanged=12,
eProductZongmenGrassSapceChanged=13,
eZongmenMonsterUpLevelChanged=14,
eDiziDuJieFloorChanged=16,
eProductWorldMonsterSpaceChanged=17,
eMoneyProductChanged=18,
eXianZhanShopItemRebateChanged=19,
eXianZhanFangKeRewardChanged=20,
eXianZhanKeShangCdChanged=21,
eZongmenMiJingDoubleChanged=22,
eDanXiangSiYi=23,
eLittleWorldData=24,
eLittleWorldPopAdd=25,
eJuTianYiRateAdd=26,
eYunJiaYingSpeed=27,
eYuLingZhaiSpeed=28,
eJunZhenAttr=29,
eMoneyBuff=30,
}


local _effectFunc=
{
[BUFF_EFFECT_TYPE.eFanganProductChanged]=function(...)
return homeBuffConfig.onFanganProduct(...)
end,

[BUFF_EFFECT_TYPE.eProductRewardChanged]=function(...)
return homeBuffConfig.onFanganProductReward(...)
end,

[BUFF_EFFECT_TYPE.eZhuanyeExpChanged]=function(...)
return homeBuffConfig.onZhuanyeExp(...)
end,

[BUFF_EFFECT_TYPE.eDiziXiulianXiaolvChanged]=function(...)
return homeBuffConfig.onDiziXiulianXiaolv(...)
end,

[BUFF_EFFECT_TYPE.eDiziLiantiXiaolvChanged]=function(...)
return homeBuffConfig.onDiziLiantiXiaolv(...)
end,

[BUFF_EFFECT_TYPE.eDujieSuccessPrecentChanged]=function(...)
return homeBuffConfig.onDujieSuccessPrecent(...)
end,

[BUFF_EFFECT_TYPE.eZongmenMinshengChanged]=function(...)
return homeBuffConfig.onZongmenMinsheng(...)
end,

[BUFF_EFFECT_TYPE.eShopLingshiChanged]=function(...)
return homeBuffConfig.onShopLingshi(...)
end,

[BUFF_EFFECT_TYPE.eZiranProductChanged]=function(...)
return homeBuffConfig.onZiranProduct(...)
end,

[BUFF_EFFECT_TYPE.eShoolZhuanyeExpChanged]=function(...)
return homeBuffConfig.onShoolZhuanyeExp(...)
end,

[BUFF_EFFECT_TYPE.eGetXiuweiXiaolvChanged]=function(...)
return homeBuffConfig.onGetXiuweiXiaolv(...)
end,

[BUFF_EFFECT_TYPE.eProductMonsterSpaceChanged]=function(...)
return homeBuffConfig.onProductMonsterSpace(...)
end,

[BUFF_EFFECT_TYPE.eProductZongmenGrassSapceChanged]=function(...)
return homeBuffConfig.onProductZongmenGrassSapce(...)
end,

[BUFF_EFFECT_TYPE.eZongmenMonsterUpLevelChanged]=function(...)
return homeBuffConfig.onZongmenMonsterUpLevel(...)
end,

[BUFF_EFFECT_TYPE.eDiziDuJieFloorChanged]=function(...)
return homeBuffConfig.onDiziDuJieFloorChanged(...)
end,

[BUFF_EFFECT_TYPE.eProductWorldMonsterSpaceChanged]=function(...)
return homeBuffConfig.oneProductWorldMonsterSpace(...)
end,

[BUFF_EFFECT_TYPE.eMoneyProductChanged]=function(...)
return homeBuffConfig.onMoneyProductChanged(...)
end,

[BUFF_EFFECT_TYPE.eXianZhanShopItemRebateChanged]=function(...)
return homeBuffConfig.onXianZhanShopItemRebateChanged(...)
end,

[BUFF_EFFECT_TYPE.eXianZhanFangKeRewardChanged]=function(...)
return homeBuffConfig.onXianZhanFangKeRewardChanged(...)
end,

[BUFF_EFFECT_TYPE.eXianZhanKeShangCdChanged]=function(...)
return homeBuffConfig.onXianZhanKeShangCdChanged(...)
end,

[BUFF_EFFECT_TYPE.eZongmenMiJingDoubleChanged]=function(...)
return homeBuffConfig.onZongmenMiJingDoubleChanged(...)
end,

[BUFF_EFFECT_TYPE.eDanXiangSiYi]=function(...)
return homeBuffConfig.onDanXiangSiYiChanged(...)
end,

[BUFF_EFFECT_TYPE.eLittleWorldData]=function(...)
return homeBuffConfig.onLittleWorldDataChanged(...)
end,

[BUFF_EFFECT_TYPE.eLittleWorldPopAdd]=function(...)
return homeBuffConfig.onLittleWorldPopAddChanged(...)
end,

[BUFF_EFFECT_TYPE.eJuTianYiRateAdd]=function(...)
return homeBuffConfig.onJuTianYiRateAddChanged(...)
end,

[BUFF_EFFECT_TYPE.eYunJiaYingSpeed]=function(...)
return homeBuffConfig.eYunJiaYingSpeedAddChanged(...)
end,

[BUFF_EFFECT_TYPE.eYuLingZhaiSpeed]=function(...)
return homeBuffConfig.onYuLingZhaiSpeedAddChanged(...)
end,

[BUFF_EFFECT_TYPE.eJunZhenAttr]=function(...)
return homeBuffConfig.onJunZhenAttrChanged(...)
end,

[BUFF_EFFECT_TYPE.eMoneyBuff]=function(...)
return homeBuffConfig.onMoneyBuffChanged(...)
end,

}




function homeBuffConfig.handleBuff(id,outParams,isAdd)
local multi=isAdd and 1 or-1
local config=cfg_guildstateconfig_get(id)
for _,effectid in ipairs(config.effects)do
homeBuffConfig.handleBuffEffect(effectid,multi,outParams)
end
end

function homeBuffConfig.handleBuffEffect(effectid,multi,outParams)
local config=cfg_guildstateeffectconfig_get(effectid)
local effectTye=config.effect_type
local func=_effectFunc[effectTye]
if func then
func(config,outParams,multi)
else
logErr(FMT.fmt('宗门buff效果类型{0}尚未支持',effectTye))
end
end

function homeBuffConfig.onFanganProduct(config,out,multi)
local effectTye=config.effect_type
local params=config.param
local buildTypeList=params[1]
local addVal=params[2]
if out[effectTye]==nil then out[effectTye]={}end
local valTable=out[effectTye]
for _,v in ipairs(buildTypeList)do
valTable[v]=(valTable[v]or 0)+multi*addVal
end
end


function homeBuffConfig.onFanganProductReward(config,out,multi)
local effectTye=config.effect_type
local params=config.param
if out[effectTye]==nil then out[effectTye]={}end
local valTable=out[effectTye]
for buildType,args in pairs(params)do
if valTable[buildType]==nil then valTable[buildType]={}end
local buildTable=valTable[buildType]
for index,addVal in ipairs(args)do
buildTable[index]=(buildTable[index]or 0)+multi*addVal
end
end
end


function homeBuffConfig.onZhuanyeExp(config,out,multi)
local effectTye=config.effect_type
local params=config.param
if out[effectTye]==nil then out[effectTye]={}end
local valTable=out[effectTye]
for zhuanyeid,addVal in pairs(params)do
valTable[zhuanyeid]=(valTable[zhuanyeid]or 0)+multi*addVal
end
end

function homeBuffConfig.onDiziXiulianXiaolv(config,out,multi)
local effectTye=config.effect_type
local params=config.param
if out[effectTye]==nil then out[effectTye]=0 end
local val=out[effectTye]
local addVal=params[1]
out[effectTye]=(val or 0)+multi*addVal
end

function homeBuffConfig.onDiziLiantiXiaolv(config,out,multi)
local effectTye=config.effect_type
local params=config.param
if out[effectTye]==nil then out[effectTye]=0 end
local val=out[effectTye]
local addVal=params[1]
out[effectTye]=(val or 0)+multi*addVal
end

function homeBuffConfig.onDujieSuccessPrecent(config,out,multi)
local effectTye=config.effect_type
local params=config.param
if out[effectTye]==nil then out[effectTye]=0 end
local val=out[effectTye]
local addVal=params[1]
out[effectTye]=(val or 0)+multi*addVal
end

function homeBuffConfig.onZongmenMinsheng(config,out,multi)
local effectTye=config.effect_type
local params=config.param
if out[effectTye]==nil then out[effectTye]=0 end
local val=out[effectTye]
local addVal=params[1]
out[effectTye]=(val or 0)+multi*addVal
end

function homeBuffConfig.onShopLingshi(config,out,multi)
local effectTye=config.effect_type
if out[effectTye]==nil then out[effectTye]={}end
local valTable=out[effectTye]
local params=config.param
local buildTypeList=params[1]
local addVal=params[2]
for _,v in ipairs(buildTypeList)do
valTable[v]=(valTable[v]or 0)+multi*addVal
end
end

function homeBuffConfig.onZiranProduct(config,out,multi)
local effectTye=config.effect_type
if out[effectTye]==nil then out[effectTye]={}end
local valTable=out[effectTye]
local params=config.param
local buildTypeList=params[1]
local addVal=params[2]
for _,v in ipairs(buildTypeList)do
valTable[v]=(valTable[v]or 0)+multi*addVal
end
end

function homeBuffConfig.onShoolZhuanyeExp(config,out,multi)
local effectTye=config.effect_type
local params=config.param
if out[effectTye]==nil then out[effectTye]=0 end
local val=out[effectTye]
local addVal=params[1]
out[effectTye]=(val or 0)+multi*addVal
end

function homeBuffConfig.onGetXiuweiXiaolv(config,out,multi)
local effectTye=config.effect_type
local params=config.param
if out[effectTye]==nil then out[effectTye]=0 end
local val=out[effectTye]
local addVal=params[1]
out[effectTye]=(val or 0)+multi*addVal
end

function homeBuffConfig.onProductMonsterSpace(config,out,multi)
local effectTye=config.effect_type
local params=config.param
if out[effectTye]==nil then out[effectTye]=0 end
local val=out[effectTye]
local addVal=params[1]
out[effectTye]=(val or 0)+multi*addVal
end

function homeBuffConfig.onProductZongmenGrassSapce(config,out,multi)
local effectTye=config.effect_type
local params=config.param
if out[effectTye]==nil then out[effectTye]=0 end
local val=out[effectTye]
local addVal=params[1]
out[effectTye]=(val or 0)+multi*addVal
end

function homeBuffConfig.onZongmenMonsterUpLevel(config,out,multi)
local effectTye=config.effect_type
local params=config.param
if out[effectTye]==nil then out[effectTye]=0 end
local val=out[effectTye]
local addVal=params[1]
out[effectTye]=(val or 0)+multi*addVal
end

function homeBuffConfig.onDiziDuJieFloorChanged(config,out,multi)
local effectTye=config.effect_type
local params=config.param
if out[effectTye]==nil then out[effectTye]={}end
if multi>0 then
table.insert(out[effectTye],config.id)
else
table.removeValue(out[effectTye],config.id)
end
end


function homeBuffConfig.oneProductWorldMonsterSpace(config,out,multi)
local effectTye=config.effect_type
local params=config.param
if out[effectTye]==nil then out[effectTye]=0 end
local val=out[effectTye]
local addVal=params[1]
out[effectTye]=(val or 0)+multi*addVal
end

function homeBuffConfig.onMoneyProductChanged(config,out,multi)
local effectTye=config.effect_type
if out[effectTye]==nil then out[effectTye]={}end
local valTable=out[effectTye]
local params=config.param
local moneyTypeList=params[1]
local addVal=params[2]
for _,v in ipairs(moneyTypeList)do
valTable[v]=(valTable[v]or 0)+multi*addVal
end
end

function homeBuffConfig.onXianZhanShopItemRebateChanged(config,out,multi)
local effectTye=config.effect_type
local params=config.param
if out[effectTye]==nil then out[effectTye]=0 end
local val=out[effectTye]
local addVal=params[1]
out[effectTye]=(val or 0)+multi*addVal
end

function homeBuffConfig.onXianZhanFangKeRewardChanged(config,out,multi)
local effectTye=config.effect_type
local params=config.param
if out[effectTye]==nil then out[effectTye]=0 end
local val=out[effectTye]
local addVal=params[1]
out[effectTye]=(val or 0)+multi*addVal
end

function homeBuffConfig.onXianZhanKeShangCdChanged(config,out,multi)
local effectTye=config.effect_type
local params=config.param
if out[effectTye]==nil then out[effectTye]=0 end
local val=out[effectTye]
local addVal=params[1]
out[effectTye]=(val or 0)+multi*addVal
end

function homeBuffConfig.onZongmenMiJingDoubleChanged(config,out,multi)
local effectTye=config.effect_type
local params=config.param
if out[effectTye]==nil then out[effectTye]=0 end
local val=out[effectTye]
local addVal=params[1]
out[effectTye]=(val or 0)+multi*addVal
end

function homeBuffConfig.onDanXiangSiYiChanged(config,out,multi)
local effectTye=config.effect_type
local params=config.param
if out[effectTye]==nil then out[effectTye]=0 end
local val=out[effectTye]
local addVal=params[1]
out[effectTye]=(val or 0)+multi*addVal
end

function homeBuffConfig.onLittleWorldPopAddChanged(config,out,multi)
local effectTye=config.effect_type
local params=config.param
if out[effectTye]==nil then out[effectTye]=0 end
local val=out[effectTye]
local addVal=params[1]
out[effectTye]=(val or 0)+multi*addVal
end

function homeBuffConfig.onLittleWorldDataChanged(config,out,multi)
local effectTye=config.effect_type
local params=config.param
if out[effectTye]==nil then out[effectTye]={}end
local valTable=out[effectTye]
for attr,addVal in pairs(params)do
valTable[attr]=(valTable[attr]or 0)+multi*addVal
end
end

function homeBuffConfig.onJuTianYiRateAddChanged(config,out,multi)
local effectTye=config.effect_type
local params=config.param
if out[effectTye]==nil then out[effectTye]={}end
local valTable=out[effectTye]
for _,moneyType in ipairs(params[1])do
valTable[moneyType]=(valTable[moneyType]or 0)+multi*params[2]
end
end

function homeBuffConfig.eYunJiaYingSpeedAddChanged(config,out,multi)
local effectTye=config.effect_type
local params=config.param
if out[effectTye]==nil then out[effectTye]=0 end
local val=out[effectTye]
local addVal=params[1]
out[effectTye]=(val or 0)+multi*addVal
end


function homeBuffConfig.onYuLingZhaiSpeedAddChanged(config,out,multi)
local effectTye=config.effect_type
local params=config.param
if out[effectTye]==nil then out[effectTye]=0 end
local val=out[effectTye]
local addVal=params[1]
out[effectTye]=(val or 0)+multi*addVal
end


function homeBuffConfig.onJunZhenAttrChanged(config,out,multi)
local effectTye=config.effect_type
local params=config.param
if out[effectTye]==nil then out[effectTye]={}end
local valTable=out[effectTye]
for attr,addVal in pairs(params)do
valTable[attr]=(valTable[attr]or 0)+multi*addVal
end
end


function homeBuffConfig.onMoneyBuffChanged(config,out,multi)
local effectTye=config.effect_type
local params=config.param
if out[effectTye]==nil then out[effectTye]={}end
local valTable=out[effectTye]
for attr,addVal in pairs(params)do
valTable[attr]=(valTable[attr]or 0)+multi*addVal
end
end