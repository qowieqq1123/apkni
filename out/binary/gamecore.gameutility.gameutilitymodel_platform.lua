
local _plotBatchConfig=nil
local _plotBatchMergeConfig={}
local _plotBatchMergeEnum={}
local _plotBatchMergeField={}
local _plotBatchLuaFunction={}
local _serverPlatform=nil
local _serverPlatform_kf=nil

function gameUtilityModel.setServerPlatform(platform)
_serverPlatform=platform

local defaultIndex=nil
local hitIndex=nil
local config=cfg_jqverconfig()
local openServerTime=gameUtilityModel.getOpenServerShortTime()

for i,v in ipairs(config)do
if v.pflist==nil or v.openTime==nil then
defaultIndex=i
elseif table.containsValue(v.pflist,_serverPlatform)then
local startTime=timeHelper.convertShortStamp(timeHelper.getDateStamp(v.openTime[1]))
local endTime=v.openTime[2]
if type(endTime)=="string"then
endTime=timeHelper.convertShortStamp(timeHelper.getDateStamp(endTime))
if openServerTime>=startTime and openServerTime<=endTime then
hitIndex=i
end
else
if openServerTime>=startTime then
hitIndex=i
end
end
end
end

_plotBatchConfig=config[hitIndex or defaultIndex]
if strict_if_strict then
strict_if_strict(false)
end

for i,v in ipairs(_plotBatchConfig.config)do
local type=v[1]
local cfgName=v[2]
local cfgBatch=v[3]
if(type==0 or type==1)and cfgName~=cfgBatch then
local temp={}
temp.cfgFuncName=FMT.fmt('cfg_{0}',cfgName)
temp.cfgGetFuncName=FMT.fmt('cfg_{0}_get',cfgName)
temp.oCfgFunc=_G[temp.cfgFuncName]
temp.oCfgGetFunc=_G[temp.cfgGetFuncName]
temp.nCfg=nil
temp.initCfg=function()
local config={}
if temp.oCfgFunc then
local mCfg=require(FMT.fmt("data/config/{0}",cfgName))
for i,v in pairs(mCfg)do
config[i]=v
end
end

local sCfg=require(FMT.fmt("data/config/{0}",cfgBatch))
for i,v in pairs(sCfg)do
config[i]=v
end
return config
end
temp.nCfgFunc=function()
if temp.nCfg then return temp.nCfg end
temp.nCfg=temp.initCfg()
return temp.nCfg
end
temp.nCfgGetFunc=function(k,show_msg)
if temp.nCfg==nil then
temp.nCfg=temp.initCfg()
end



return temp.nCfg[k]
end
_G[temp.cfgFuncName]=temp.nCfgFunc
_G[temp.cfgGetFuncName]=temp.nCfgGetFunc
cfgHelper.refreshMapName(temp.cfgFuncName,temp.nCfgFunc)
cfgHelper.refreshMapName(temp.cfgGetFuncName,temp.nCfgGetFunc)
_plotBatchMergeConfig[cfgName]=temp
end
end

for i,v in ipairs(_plotBatchConfig.enum)do
local enumName=v[1]
local enumBatch=v[2]
if enumName~=enumBatch then
local temp={}
temp.enumName=enumName
temp.oEnumTable=_G[temp.enumName]
local batchTable=_G[enumBatch]
local enumTable={}
for i,v in pairs(temp.oEnumTable)do
enumTable[i]=v
end
for i,v in pairs(batchTable)do
enumTable[i]=v
end
temp.nEnumTable=enumTable
_G[temp.enumName]=temp.nEnumTable

_plotBatchMergeEnum[enumName]=temp
end
end

for i,v in ipairs(_plotBatchConfig.field)do
local cfgInfo=v[1]
local nValue=v[2]
local cfgName=cfgInfo[1]
local infoCnt=#cfgInfo
local cfg=cfgHelper.getCofingFunction(cfgName)
local temp=cfg()
for j=2,infoCnt-1 do
local fieldName=cfgInfo[j]
temp=temp[fieldName]
end
local lastField=cfgInfo[infoCnt]
local oValue=temp[lastField]
temp[lastField]=nValue
table.insert(_plotBatchMergeField,{cfgInfo,oValue})
end

if _plotBatchConfig.luafunc then
table.clear(_plotBatchLuaFunction)
for i,v in ipairs(_plotBatchConfig.luafunc)do
local funcCfg=v.cfg
local attrs=v.attrs
local newValue=v.value
local cfgName=funcCfg[1]
local funcName=funcCfg[2]
local func=_G[cfgName][funcName]
if func~=nil then
local cfg=func()
local len=#attrs
local oldValue=cfg
for i=1,len do
oldValue=oldValue[attrs[i]]
end

if oldValue~=newValue then
local t=cfg
for i=1,len do
if i==len then
t[attrs[i]]=newValue
else
t=t[attrs[i]]
end
end

table.insert(_plotBatchLuaFunction,{v,oldValue})
end
end
end
end
if strict_if_strict then
strict_if_strict(true)
end
notifySystem:postNotify(notifyConfig.onServerPlatformInited)
end

function gameUtilityModel.getServerPlatform()
return _serverPlatform
end

function gameUtilityModel.setServerPlatform_kf(platform)
_serverPlatform_kf=platform
end

function gameUtilityModel.getServerPlatform_kf()
return _serverPlatform_kf
end

function gameUtilityModel.clearPlotBatchConfig()
_plotBatchConfig=nil
if strict_if_strict then
strict_if_strict(false)
end
for cfgName,temp in pairs(_plotBatchMergeConfig)do
_G[temp.cfgFuncName]=temp.oCfgFunc
_G[temp.cfgGetFuncName]=temp.oCfgGetFunc
cfgHelper.refreshMapName(nil,temp.nCfgFunc)
cfgHelper.refreshMapName(nil,temp.nCfgGetFunc)
end
table.clear(_plotBatchMergeConfig)
for enumName,temp in pairs(_plotBatchMergeEnum)do
_G[temp.enumName]=temp.oEnumTable

end
table.clear(_plotBatchMergeEnum)
for i,v in ipairs(_plotBatchMergeField)do
local cfgInfo=v[1]
local oValue=v[2]
local cfgName=cfgInfo[1]
local infoCnt=#cfgInfo
local cfg=cfgHelper.getCofingFunction(cfgName)
local temp=cfg()
for j=2,infoCnt-1 do
local fieldName=cfgInfo[j]
temp=temp[fieldName]
end
local lastField=cfgInfo[infoCnt]
temp[lastField]=oValue
end
table.clear(_plotBatchMergeField)

for i,args in ipairs(_plotBatchLuaFunction)do
local v=args[1]
local funcCfg=v.cfg
local attrs=v.attrs
local oldalue=args[2]
local cfgName=funcCfg[1]
local funcName=funcCfg[2]
local func=_G[cfgName][funcName]
if func then
local cfg=func()
local len=#attrs
local curValue=cfg
for i=1,len do
curValue=curValue[attrs[i]]
end
if curValue~=oldalue then
local t=cfg
for i=1,len do
if i==len then
t[attrs[i]]=oldalue
else
t=t[attrs[i]]
end
end
end
end
end
table.clear(_plotBatchLuaFunction)

if strict_if_strict then
strict_if_strict(true)
end
end

function gameUtilityModel.getPlotBatchConfig()
if _plotBatchConfig then
return _plotBatchConfig
else
loggerUtil.logErrFMT("剧情分支未完成初始化")
end
end

function gameUtilityModel.checkPlotBatchWarning(str)
if not _plotBatchConfig then
loggerUtil.logErrFMT(str)
end
end
