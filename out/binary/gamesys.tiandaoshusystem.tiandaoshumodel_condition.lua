tiandaoshuModel.eFruitCondition={
eXianMengLevel=1,
eZongMengLevel=2,
eCurrentVocCount=3,
eCurrentVocComplete=4,
eZheXianLing=5,
}

local _condition_handle={
[tiandaoshuModel.eFruitCondition.eXianMengLevel]={
check=function(voc,value1,value2)
local level=xianmengModel:getXMLevel()
return level>=value1
end,
info=function(value1,value2)
return FMT.fmt("仙盟等级达到{0}级",value1)
end,
warning=function(value1,value2)
return FMT.fmt("仙盟等级不足{0}级",value1)
end,
progress=function(voc,value1,value2)
local level=xianmengModel:getXMLevel()
return FMT.fmt("仙盟等级：{0}/{1}",level,value1)
end,
unlock=function(voc,value1,value2)
return FMT.fmt("仙盟达{0}级解锁",value1)
end,
},
[tiandaoshuModel.eFruitCondition.eZongMengLevel]={
check=function(voc,value1,value2)
local level=zongmenModel:getLevel()
return level>=value1
end,
info=function(value1,value2)
return FMT.fmt("宗门等级达到{0}级",value1)
end,
warning=function(value1,value2)
return FMT.fmt("宗门等级不足{0}个",value1)
end,
progress=function(voc,value1,value2)
local level=zongmenModel:getLevel()
return FMT.fmt("宗门等级：{0}/{1}",level,value1)
end,
unlock=function(voc,value1,value2)
return FMT.fmt("宗门达{0}级解锁",value1)
end,
},
[tiandaoshuModel.eFruitCondition.eCurrentVocCount]={
check=function(voc,value1,value2)
local level=tiandaoshuModel:getVocCount(voc)
return level>=value1
end,
info=function(value1,value2)
return FMT.fmt("领悟道果达到{0}个",value1)
end,
warning=function(value1,value2)
return FMT.fmt("领悟道果不足{0}个",value1)
end,
progress=function(voc,value1,value2)
local level=tiandaoshuModel:getVocCount(voc)
return FMT.fmt("领悟道果：{0}/{1}",level,value1)
end,
unlock=function(voc,value1,value2)
local level=tiandaoshuModel:getVocCount(voc)
return FMT.fmt("再领悟{0}次道果",value1-level)
end,
},
[tiandaoshuModel.eFruitCondition.eCurrentVocComplete]={
check=function(voc,value1,value2)
local level=tiandaoshuModel:getVocComplete(voc)
return level>=value1
end,
info=function(value1,value2)
return FMT.fmt("完成道果达到{0}个",value1)
end,
warning=function(value1,value2)
return FMT.fmt("完成道果不足{0}个",value1)
end,
progress=function(voc,value1,value2)
local level=tiandaoshuModel:getVocComplete(voc)
return FMT.fmt("完成道果：{0}/{1}",level,value1)
end,
unlock=function(voc,value1,value2)
local level=tiandaoshuModel:getVocComplete(voc)
return FMT.fmt("再领悟{0}个道果",value1-level)
end,
},
[tiandaoshuModel.eFruitCondition.eZheXianLing]={
check=function(voc,value1,value2)
return zheXianLingModel:checkFinish(value1,value2 or 0)
end,
info=function(value1,value2)
if value2 and value2>0 then
return FMT.fmt("完成谪仙令{0}卷·第{1}章",value1,value2)
else
return FMT.fmt("完成谪仙令{0}卷",value1)
end
end,
warning=function(value1,value2)
if value2 and value2>0 then
return FMT.fmt("未完成谪仙令{0}卷·第{1}章",value1,value2)
else
return FMT.fmt("未完成谪仙令{0}卷",value1)
end
end,
progress=function(voc,value1,value2)
if value2 and value2>0 then
return FMT.fmt("完成谪仙令{0}卷·第{1}章",value1,value2)
else
return FMT.fmt("完成谪仙令{0}卷",value1)
end
end,
unlock=function(voc,value1,value2)
if value2 and value2>0 then
return FMT.fmt("谪仙令第{0}章{1}节",value1,value2)
else
return FMT.fmt("谪仙令第{0}章",value1)
end
end,
},
}

function tiandaoshuModel:checkConditions(voc,conditions)
if conditions then
for i,v in ipairs(conditions)do
local type=v[1]
local value1=v[2]
local value2=v[3]
local handle=_condition_handle[type]
if not handle.check(voc,value1,value2)then
return false
end
end
end
return true
end

function tiandaoshuModel:containConditionType(conditions,conditionType)
if conditions and#conditions>0 then
for i,v in ipairs(conditions)do
if v[1]==conditionType then
return true
end
end
end
return false
end

function tiandaoshuModel:getConditionStr(conditions,space)
local str=nil
local spaceStr=space or" "
if conditions then
for i,v in ipairs(conditions)do
local type=v[1]
local value1=v[2]
local value2=v[3]
local handle=_condition_handle[type]
local result=handle.info(value1,value2)
if str==nil then
str=result
else
str=FMT.fmt("{0}{1}{2}",str,spaceStr,result)
end
end
end
return str or""
end

function tiandaoshuModel:getConditionWarning(type,value1,value2)
local handle=_condition_handle[type]
return handle.warning(value1,value2)
end

function tiandaoshuModel:getFirstConditionTips(conditions,voc)
if conditions and#conditions>0 then
local cnt=#conditions
for i=1,cnt do
local v=conditions[i]
local type=v[1]
local value1=v[2]
local value2=v[3]
local handle=_condition_handle[type]
local check=handle.check(voc,value1,value2)
if not check or i==cnt then
return handle.progress(voc,value1,value2)
end
end
end
end

function tiandaoshuModel:getFirstConditionTips2(conditions,voc)
if conditions and#conditions>0 then
local cnt=#conditions
for i=1,cnt do
local v=conditions[i]
local type=v[1]
local value1=v[2]
local value2=v[3]
local handle=_condition_handle[type]
local check=handle.check(voc,value1,value2)
if not check or i==cnt then
return handle.unlock(voc,value1,value2)
end
end
end
end


function tiandaoshuModel:checkUnsealEnough(voc,stage,fruit)
local fruitCfg=tiandaoshuConfig:getFruitConfig(voc,stage,fruitId)
if fruitCfg.unseal then
for i,v in ipairs(fruitCfg.unseal)do
local have=itemsModel.getCount(v[1])
if have<v[2]then
return false
end
end
end
return true
end