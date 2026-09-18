




moneyConfig={}

local _money_exchange_config=
{
[eMoneyType.mtLingYu]={eMoneyType.mtXianYu}
}

local _lookup={}

for _,v in pairs(eMoneyType)do
_lookup[v]=true
end

function moneyConfig.isMoney(moneyType)
return _lookup[moneyType]==true
end

function moneyConfig.getExchangeTypeList(moneyType)
return _money_exchange_config[moneyType]
end