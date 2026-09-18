





xianzhiConfig={}

function xianzhiConfig.getBaseInfo(name)
return cfgHelper.get2(cfg_xianzhibaseconfig_get,1,name)
end

function xianzhiConfig.getXianZhiXianBaoModelInfo()
local gbid=xianzhiConfig.getBaseInfo('gbid')
local gblv=gubaoModel:getSkillLv(gbid)
local gbCfg=itemsConfig.getConfig(gbid,ITEM_CONFIG_TYPE.eGuBao)
local pram=gbCfg.relevantPram.pram
local gbMultipleInfo=pram.gbMultipleInfo
local teffectid=pram.effectid
local gbName=gbCfg.name
if gbMultipleInfo then
for clv,info in pairs(gbMultipleInfo)do
if gblv>=clv then
teffectid=info[2]
gbName=info[1]
else
break
end
end
end
return teffectid,gbName
end

function xianzhiConfig.getWagesItemsList()
local xzid=xianzhiModel:getRewardXzId()
local wagesList={}
if xzid then
local rate=1+xianzhiController.getGBSKil_XianZhiWagesRate()/100
local fenglu=cfgHelper.get2(cfg_xianzhiconfig_get,xzid,'fenglu')
local moneyUpRate=gubaoModel:getGBSkil_MoneyUpRate(0,eMoneyType.mtXianFeng)
local gubaoRate=(1+moneyUpRate/100)

for index,info in ipairs(fenglu)do
local val=info[2]*rate*gubaoRate
val=Mathf.Floor(val)
wagesList[#wagesList+1]={info[1],val}
end
end
return wagesList
end

function xianzhiConfig.checkIsXianZhiGb(gbid)
local xzgbid=cfgHelper.get2(cfg_xianzhibaseconfig_get,1,'gbid')
return xzgbid==gbid
end

function xianzhiConfig.checkShowSkillEffectDesc(oldLv,curLv)
local xianzhiCfgs=cfg_xianzhiconfig()

return xianzhiCfgs[oldLv].flPercent~=xianzhiCfgs[curLv].flPercent
end

function xianzhiConfig.getXianZhiGuBaoEffectDesc()
local rate=xianzhiController.getGBSKil_XianZhiWagesRate()
return FMT.fmt("仙职每日俸禄+{0}%",rate)
end
