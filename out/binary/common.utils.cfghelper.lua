





























cfgHelper={}

local lookup={}
local queryPath={}
local queryPath_index=1
local function report_error()



end

local function debug_key_path(key)
if appUtils.enableProfiler then return end
queryPath[queryPath_index]=tostring(key)
queryPath_index=queryPath_index+1
end

function cfgHelper.get(f,k1,k2,k3,k4,k5)













local data=f(k1)
if k2==nil then return data end








data=data[k2]
if k3==nil then return data end








data=data[k3]
if k4==nil then return data end








data=data[k4]
if k5==nil then return data end







return data[k5]
end


function cfgHelper.get1(f,v1)








return cfgHelper.get(f,v1)
end
function cfgHelper.get2(f,v1,v2)
return cfgHelper.get(f,v1,v2)
end
function cfgHelper.get3(f,v1,v2,v3)


















return cfgHelper.get(f,v1,v2,v3)
end
function cfgHelper.get4(f,v1,v2,v3,v4)























return cfgHelper.get(f,v1,v2,v3,v4)
end
function cfgHelper.get5(f,v1,v2,v3,v4,v5)




























return cfgHelper.get(f,v1,v2,v3,v4,v5)
end


function cfgHelper.getdef(f,k1,k2,k3,k4,k5)
local a=f()
local def=a.const_def








if def==nil then



return nil
end

if k1==nil then return def end







local data=def[k1]
if k2==nil then return data end









data=data[k2]
if k3==nil then return data end








data=data[k3]
if k4==nil then return data end








data=data[k4]
if k5==nil then return data end







return data[k5]
end

function cfgHelper.getdef1(f,v1)








return cfgHelper.getdef(f,v1)
end
function cfgHelper.getdef2(f,v1,v2)













return cfgHelper.getdef(f,v1,v2)
end

function cfgHelper.getdef3(f,v1,v2,v3)


















return cfgHelper.getdef(f,v1,v2,v3)
end

function cfgHelper.getglobal(...)
return cfgHelper.get(cfg_globalconfig_get,1,...)
end

function cfgHelper.getglobal1(v1)








return cfgHelper.getglobal(v1)
end
function cfgHelper.getglobal2(v1,v2)













return cfgHelper.getglobal(v1,v2)
end
function cfgHelper.getglobal3(v1,v2,v3)


















return cfgHelper.getglobal(v1,v2,v3)
end

function cfgHelper.getlang(key)
local a=cfg_lang_get(key)





return a
end

function cfgHelper.checkEmptyError(num)
logErr(FMT.fmt('传入的第{0}个参数为nil，请检查参数合法性',num+1))
end

function cfgHelper.getcfgName(f)
local name=nil
local g=_G





for k,v in pairs(g)do
if v==f then
name=k
break
end
end
return name
end

function cfgHelper.getcfgName2(f)
local name=cfgHelper.getcfgName3(f)
if name~=nil then
name=string.replace(name,'cfg_','')
name=string.replace(name,'_get','')
end
return name
end

local tableMapName=nil
function cfgHelper.getcfgName3(f)
if tableMapName==nil then
tableMapName={}
local g=_G
for k,v in pairs(g)do
tableMapName[v]=k
end








end
return tableMapName[f]
end

function cfgHelper.refreshMapName(name,func)
if tableMapName==nil then
tableMapName={}
local g=_G
for k,v in pairs(g)do
tableMapName[v]=k
end

if private_G then
g=private_G()
for k,v in pairs(g)do
tableMapName[v]=k
end
end
end
tableMapName[func]=name
end

function cfgHelper.logError(num,f,args)
if f==nil then return end
local f_name=cfgHelper.getcfgName2(f)
if f_name==nil then return end
local str=FMT.fmt('配置表:{0}',f_name)
local c=#args
if num==0 then
str=FMT.fmt('缺少{0}',str)
elseif num==1 then
str=FMT.fmt('{0},缺少id:{1}',str,args[1]or'nil')
else
str=FMT.fmt('{0},id:{1}',str,args[1]or'nil')
for i=2,num do
if i==num then
str=FMT.fmt('{0},缺少字段:{1}',str,args[i]or'nil')
else
str=FMT.fmt('{0},字段:{1}',str,args[i]or'nil')
end
end
end
logErr(str)
end

function cfgHelper.logErrorDef(num,f,args)
if f==nil then return end
local f_name=cfgHelper.getcfgName2(f)
if f_name==nil then return end
local str=FMT.fmt('配置表:{0}',f_name)
local c=#args
if num==0 then
str=FMT.fmt('{0},缺少const_def字段',str)
else
str=FMT.fmt('{0},const_def字段',str)
for i=1,num do
if i==num then
str=FMT.fmt('{0},缺少字段:{1}',str,args[i]or'nil')
else
str=FMT.fmt('{0},字段:{1}',str,args[i]or'nil')
end
end
end
logErr(str)
end

function cfgHelper.createConfigLoader(path,dataSet)
return function(id)
local data=dataSet[id]
if not data then
local subTable=require(path)
for k,v in pairs(subTable)do
dataSet[v.id]=v
end
data=dataSet[id]
end
return data
end
end

function cfgHelper.createSplitConfigLoader(path,dataSet,splitter)
return function(id)
local data=dataSet[id]
if not data then
local subTable=require(string_format(path,math_floor(id/splitter)))
for k,v in pairs(subTable)do
dataSet[v.id]=v
end
data=dataSet[id]
end
return data
end
end

local cfgFunctionLookup={}
function cfgHelper.getCofingFunction(name)
local func=cfgFunctionLookup[name]
if func==nil then

local fname=string.format('cfg_%s',name)
func=_G[fname]
cfgFunctionLookup[name]=func
end





return func
end

local cfgGetFunctionLookup={}
function cfgHelper.getCofingGetFunction(name)
local func=cfgGetFunctionLookup[name]
if func==nil then

local fname=string.format('cfg_%s_get',name)
func=_G[fname]
cfgGetFunctionLookup[name]=func
end





return func
end

function cfgHelper.getFight(attrlookup)
local fight=0
if attrlookup then
for k,v in pairs(attrlookup)do
local cfg=cfgHelper.get1(cfg_attributesconfig_get,k)
if not cfg then logErr(FMT.fmt('属性评分表，缺失属性类型:{0}',k))end
fight=fight+cfg.unitVal*v
end
fight=math.floor(fight)
end
return fight
end

function cfgHelper.getFightEx(attrList)
local fight=0
if attrList then
for i,v in ipairs(attrList)do
local cfg=cfgHelper.get1(cfg_attributesconfig_get,v[1])
if not cfg then logErr(FMT.fmt('属性评分表，缺失属性类型:{0}',v[1]))end
fight=fight+cfg.unitVal*v[2]
end
fight=math.floor(fight)
end
return fight
end

function cfgHelper.getSSlawRule(id,...)
if id>10000 then

local lib=cfgHelper.get(cfg_sslawruleteamconfig_get,id)
if lib then
local first=lib.list[1]
return cfgHelper.get(cfg_sslawruleconfig_get,first,...)
end
else
return cfgHelper.get(cfg_sslawruleconfig_get,id,...)
end
end
