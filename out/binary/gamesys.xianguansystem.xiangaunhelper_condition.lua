





XianGuanUseConditionEnum={
eUseTimes=-1,
eUseCD=-2,
eWait=-3,
eNormal=0,
eChongJianXianYu=1,
}

local XianGuanUseConditionCND={
[XianGuanUseConditionEnum.eUseTimes]={
checkCND=function(condition,xgid,tqid)
return not xianguanModel:callTeQuanObjFunc(xgid,tqid,'checkUseTimes')
end,
getWarningDesc=function(xgid,tqid)
return"使用次数已用完"
end
},
[XianGuanUseConditionEnum.eUseCD]={
checkCND=function(condition,xgid,tqid)
return not xianguanModel:callTeQuanObjFunc(xgid,tqid,'checkInCd')
end,
getWarningDesc=function(xgid,tqid)
if xianguanModel:getTeQuanDataByIds(xgid,tqid)~=nil then
local left=xianguanModel:callTeQuanObjFunc(xgid,tqid,'getCdLeft')
local desc=FMT.fmt("{0}后可使用",timeHelper.format_time_stamp4(left))
return desc
end
return""
end
},
[XianGuanUseConditionEnum.eWait]={
checkCND=function(condition,xgid,tqid)
return not xianguanModel:callTeQuanObjFunc(xgid,tqid,'checkInWait')
end,
getWarningDesc=function(xgid,tqid)
if xianguanModel:getTeQuanDataByIds(xgid,tqid)~=nil then
return xianguanModel:callTeQuanObjFunc(xgid,tqid,'getWaitDesc')
end
return""
end
},
[XianGuanUseConditionEnum.eChongJianXianYu]={
checkCND=function(condition,xgid,tqid)
return seasonController:checkSeasonHandleStageAllEnd(0)
end,
getWarningDesc=function(xgid,tqid)
return"完成【重建仙域】后方可使用"
end
},
}

xianguanHelper={}

function xianguanHelper.checkSpecialUseCondition(xgid,tqid,warning)

local conditions=xianguanConfig.getTeQuanCfg(tqid,'conditions')
if conditions then
for index,condition in ipairs(conditions)do
if not xianguanHelper.checkSingleCondition(condition,xgid,tqid,warning)then
return false,condition[1]
end
end
end
return true
end


function xianguanHelper.checkTeQuanUseCondition(xgid,tqid,warning)

local speState,noPassId=xianguanHelper.checkSpecialUseCondition(xgid,tqid,warning)
if not speState then
return speState,noPassId
end

if not XianGuanUseConditionCND[XianGuanUseConditionEnum.eWait].checkCND(nil,xgid,tqid)then
if warning then
UIManager.error(xianguanHelper.getConditionWarningDesc(XianGuanUseConditionEnum.eUseTimes,xgid,tqid))
end
return false,XianGuanUseConditionEnum.eWait
end



if not XianGuanUseConditionCND[XianGuanUseConditionEnum.eUseTimes].checkCND(nil,xgid,tqid)then
if warning then
UIManager.error(xianguanHelper.getConditionWarningDesc(XianGuanUseConditionEnum.eUseTimes,xgid,tqid))
end
return false,XianGuanUseConditionEnum.eUseTimes
end

if not XianGuanUseConditionCND[XianGuanUseConditionEnum.eUseCD].checkCND(nil,xgid,tqid)then
if warning then
UIManager.error(xianguanHelper.getConditionWarningDesc(XianGuanUseConditionEnum.eUseCD,xgid,tqid))
end
return false,XianGuanUseConditionEnum.eUseCD
end

return true,XianGuanUseConditionEnum.eNormal
end

function xianguanHelper.getConditionWarningDesc(conditionEnum,xgid,tqid)
local condtionFuncs=XianGuanUseConditionCND[conditionEnum]
if condtionFuncs then
if condtionFuncs.getWarningDesc then
return condtionFuncs.getWarningDesc(xgid,tqid)
end
end
return""
end

function xianguanHelper.getConditionWarningDescByIds(conditionEnum,xgid,tqid)
local key=xianguanConfig.getTeQuanFindKey(xgid,tqid)
local tqData=xianguanModel:getTeQuanDataByKey(key)
return xianguanHelper.getConditionWarningDesc(conditionEnum,tqData)
end

function xianguanHelper.checkSingleCondition(condition,xgid,tqid,warning)
local enum=condition[1]
local condtionFuncs=XianGuanUseConditionCND[enum]
if condtionFuncs then
if condtionFuncs.checkCND then
if not condtionFuncs.checkCND(condition,xgid,tqid)then
if warning then
UIManager.error(xianguanHelper.getConditionWarningDesc(enum))
end
return false
end
end
end
return true
end

local _timesCondition={XianGuanUseConditionEnum.eUseTimes}
function xianguanHelper.checkTeQuanTimes(xgid,tqid,warning)
return xianguanHelper.checkSingleCondition(_timesCondition,xgid,tqid,warning)
end

local _cdCondition={XianGuanUseConditionEnum.eUseCD}
function xianguanHelper.checkTeQuanCD(xgid,tqid,warning)
return xianguanHelper.checkSingleCondition(_cdCondition,xgid,tqid,warning)
end


function xianguanHelper.checkHasConditionType(tqId,conditionEnum)
local conditions=xianguanConfig.getTeQuanCfg(tqId,'conditions')
if conditions then
for index,condition in ipairs(conditions)do
if condition[1]==conditionEnum then
return true
end
end
end
return false
end


function xianguanHelper.checkTeQuanPlatformLimit(tqId)
local cross=xianguanConfig.getTeQuanCfg(tqId,'cross')

if cross==nil then return true end

local crossId=loginModel:getCrossServerId()or 0

if crossId==0 then

return false
end

if cross then
local state=cross[crossId]
return state~=nil and state==1
end
return true
end

function xianguanHelper.checkClientCommonPlatformLimit()
local cross=cfgHelper.get2(cfg_xianguanbaseconfig_get,1,'cross')
if cross==nil then return true end

local crossId=loginModel:getCrossServerId()or 0

if crossId==0 then

return false
end

if cross then
local state=cross[crossId]
return state~=nil and state==1
end
return true
end