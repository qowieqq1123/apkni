chuanSongZhenModel.transportConditionEnum={
eZongMenLevel=1,
eZheXianLing=2,
eZongMenXianTu=3,
}

local _transportCondition={
[chuanSongZhenModel.transportConditionEnum.eZongMenLevel]=function(param)
local level=zongmenModel:getLevel()or 0
return level>=param[2]
end,
[chuanSongZhenModel.transportConditionEnum.eZheXianLing]=function(param)
return zheXianLingModel:checkFinish(param[2],param[3]or 0)
end,
[chuanSongZhenModel.transportConditionEnum.eZongMenXianTu]=function(param)
return xiantuchengjiuModel:checkOpen(eXianTuChengJiuTabType.ZongMenXianTu,param[2])
end,
}

local _transportConditionStr={
[chuanSongZhenModel.transportConditionEnum.eZongMenLevel]=function(param)
return FMT.fmt("宗门等级达到{0}级",param[2])
end,
[chuanSongZhenModel.transportConditionEnum.eZheXianLing]=function(param)
local bookStr=mathHelper.numberToChinese(param[2])
local desc=FMT.fmt('谪仙令第{0}卷',bookStr)
if param[2]then
desc=FMT.fmt('{0}第{1}章',desc,param[3])
end
return desc
end,
[chuanSongZhenModel.transportConditionEnum.eZongMenXianTu]=function(param)
local name=cfgHelper.get2(cfg_sectxiantuconfig_get,param[2],"name")
return FMT.fmt("宗门仙途达到{0}",name)
end,
}

function chuanSongZhenModel:checkTransportConditions(conditions)
if conditions then
for i,v in ipairs(conditions)do
if not self:checkTransportCondition(v)then
return false
end
end
end
return true
end

function chuanSongZhenModel:checkTransportCondition(condition)
local type=condition[1]
local handle=_transportCondition[type]
if handle then
local check=handle(condition)
if not check then
return false
end
end
return true
end

function chuanSongZhenModel:getTransportConditionStr(condition)
local type=condition[1]
local handle=_transportConditionStr[type]
if handle then
return handle(condition)
end
return""
end