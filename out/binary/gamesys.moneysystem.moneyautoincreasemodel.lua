







moneyAutoIncreaseModel={}

local autoList=nil
local checkList=nil
local checkMax={
[eMoneyType.mtLingPai]={
SLG_SYSTEM_TYPE.eZongMen,
function()
return moneyModel.getMoneyMax(eMoneyType.mtLingPai)
end,
0,
},
[eMoneyType.mtXuKongLing]={
nil,
function()
return moneyModel.getMoneyMax(eMoneyType.mtXuKongLing)
end,
0,
},
[eMoneyType.mtLunHuiDian]={
SLG_SYSTEM_TYPE.eLunHuiDian,
function()
return moneyModel.getMoneyMax(eMoneyType.mtLunHuiDian)
end,
0,
},
[eMoneyType.mtXianLing]={
SLG_SYSTEM_TYPE.eTianShuDian,
function()
return moneyModel.getMoneyMax(eMoneyType.mtXianLing)
end,
0,
},
}

function moneyAutoIncreaseModel:initConfig()
checkList={}
local moneyCfg=cfg_moneyconfig()
for i,v in pairs(moneyCfg)do
if v.autoincr then
table.insert(checkList,v.id)
end
end
end

function moneyAutoIncreaseModel:initData(list)
autoList={}
if list==nil then return end
for i,v in ipairs(list)do
autoList[v.param_1]=v.param_2
end
end

function moneyAutoIncreaseModel:initMax(buildID)
for i,v in pairs(checkMax)do
if buildID==nil or buildID==v[1]then
v[3]=v[2]()or 0
end
end
end


function moneyAutoIncreaseModel:clearData()
autoList=nil
checkList={}
end

function moneyAutoIncreaseModel:getCheckTime(moneytype)
return autoList[moneytype]
end

function moneyAutoIncreaseModel:setCheckTime(moneytype,checkTime)
if autoList then
autoList[moneytype]=checkTime
end
end

function moneyAutoIncreaseModel:getCheckList()
return checkList
end


function moneyAutoIncreaseModel:isNotMax(moneytype)
local money=moneyModel.getMoney(moneytype)or 0
if checkMax[moneytype]and money>=checkMax[moneytype][3]then return false end
if checkMax[moneytype]then
if money>=checkMax[moneytype][3]then
return false
end
else
local autoCfg=cfgHelper.get2(cfg_moneyconfig_get,moneytype,'autoincr')
if autoCfg[5]and money>=autoCfg[5]then return false end
end
return true
end













function moneyAutoIncreaseModel:checkConditionImp(moneytype)
local autoCfg=cfgHelper.get2(cfg_moneyconfig_get,moneytype,'autoincr')
if autoCfg==nil then return false end
local buildID=autoCfg[3]
if buildID~=0 then
if not zongmenModel:haveBuildByBuildIdEx(buildID)then
return false
end
end

local checkTime=moneyAutoIncreaseModel:getCheckTime(moneytype)
if checkTime==nil or checkTime==0 then return false end
local curTime=gameUtilityModel.getServerShortTime()
local lerpTime=curTime-checkTime
local transTime=self:getTransRestoreTime(autoCfg,moneytype)
if lerpTime>transTime then return true end
return false
end

function moneyAutoIncreaseModel:checkBuilding(moneytype)
local autoCfg=cfgHelper.get2(cfg_moneyconfig_get,moneytype,'autoincr')
if autoCfg==nil then return false end
local buildID=autoCfg[3]
if buildID~=0 then
if not zongmenModel:haveBuildByBuildIdEx(buildID)then
return false,buildID
end
end
return true
end

function moneyAutoIncreaseModel:getTransRestoreTime(autoCfg,moneytype)
local state,val=homeBuffControl.checkInfuenceAutoInvreaseByBuff(moneytype)
return autoCfg[1]/(val*0.01)
end

function moneyAutoIncreaseModel:getLeastTime(moneytype)
local autoCfg=cfgHelper.get2(cfg_moneyconfig_get,moneytype,'autoincr')
local checkTime=moneyAutoIncreaseModel:getCheckTime(moneytype)or 0

local curTime=gameUtilityModel.getServerShortTime()
local lerpTime=curTime-checkTime
local transTime=self:getTransRestoreTime(autoCfg,moneytype)
return transTime-lerpTime
end

function moneyAutoIncreaseModel:getLeastTimeToFull(moneytype,ccdNum)
ccdNum=ccdNum or self:ccdNum(moneytype)
local autoCfg=cfgHelper.get2(cfg_moneyconfig_get,moneytype,'autoincr')
local checkTime=moneyAutoIncreaseModel:getCheckTime(moneytype)or 0
local curTime=gameUtilityModel.getServerShortTime()
local lerpTime=curTime-checkTime
local maxNum=moneyModel.getMoneyMax(moneytype)
local curNum=moneyModel.getMoney(moneytype)
local nextNum=math.max(maxNum-curNum-ccdNum,0)
local checkNum=math.ceil(nextNum/ccdNum)
local transTime=self:getTransRestoreTime(autoCfg,moneytype)
return transTime*checkNum+(transTime-lerpTime)
end

function moneyAutoIncreaseModel:ccdNum(moneytype)

local autoCfg=cfgHelper.get2(cfg_moneyconfig_get,moneytype,'autoincr')
local num=0
if autoCfg~=nil then
local isopen=false
local buildID=autoCfg[3]
if buildID==0 then
isopen=true
else

if zongmenModel:haveBuildByBuildIdEx(buildID)then
isopen=true
end
end
if isopen then
num=num+autoCfg[2]
local netData=nil
local params=autoCfg[4]
if params then
local typo=params[1]
if typo==1 then
local dis_list=UIDiscipleModel:getDiscipleByZongMenPost(params[2])
if dis_list and#dis_list>0 then
local dis_netData=dis_list[1]
num=num+(params[3][dis_netData.jingjielv]or 0)
num=num+(params[4][dis_netData.liantilv]or 0)
netData=dis_netData
end
end
end


local rate=moneyAutoIncreaseModel:calculationExtraAddtion(moneytype,netData)
num=num*(1+rate)
end
end
return num
end


function moneyAutoIncreaseModel:calculationExtraAddtion(moneytype,netData)
local rate=0

local gbRate=gubaoModel:getGBSkil_MoneyAutoUpRate(0,moneytype)
gbRate=gbRate/100

local buildingBuffRate=zongmenModel:getBenefitBuildingBuffAddition(false,BENEFIT_BUFF_EFFECT_TYPE.eMoneyAutoAdd,moneytype)
buildingBuffRate=buildingBuffRate/100

local dzRate=0
if netData~=nil then
dzRate=dzSpecialityGrowEffectController:getMoneyAutoChangeRate(netData,moneytype)/100
end


local moneyRate=0
if moneytype==eMoneyType.mtLunHuiDian then
local num=moneyModel.getMoney(eMoneyType.mtHunPo)
local config=cfg_lunhuidianconfig_get(1)
local addConfig=config.samsara_add_rate

if addConfig then
for k,v in ipairs(addConfig)do
if num>=v[1]then
moneyRate=v[2]/100
end
end
end
end

rate=rate+gbRate+buildingBuffRate+dzRate+moneyRate
return rate
end

