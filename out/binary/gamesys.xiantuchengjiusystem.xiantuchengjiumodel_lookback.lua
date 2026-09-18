
xiantuchengjiuModel.lookback={}

local _descDecode={
['XT_RV_TYPE_DISCIPLE_ID']=function(jsonData)
local cfg=cfgHelper.get1(cfg_discipleconfig_get,jsonData[2])
return gameUtilityModel.getGameYearPass(jsonData[1]),cfg.name,jsonData[3],jsonData[4],jsonData[5]
end,
['XT_RV_TYPE_MJ_ID']=function(jsonData)
local cfg=cfgHelper.get1(cfg_secretscenefubenconfig_get,jsonData[2])
return gameUtilityModel.getGameYearPass(jsonData[1]),cfg.name,jsonData[3],jsonData[4],jsonData[5]
end,
['XT_RV_TYPE_DISCIPLE_LT']=function(jsonData)
local ltName=UIDiscipleModel:getLTName(jsonData[2])
return gameUtilityModel.getGameYearPass(jsonData[1]),ltName,jsonData[3],jsonData[4],jsonData[5]
end,
['XT_RV_TYPE_HSJD']=function(jsonData)
local cfg=cfgHelper.get1(cfg_backmountainareaconfig_get,jsonData[2])
return gameUtilityModel.getGameYearPass(jsonData[1]),cfg.name,jsonData[3],jsonData[4],jsonData[5]
end,
['XT_RV_TYPE_ITEM_TYPE']=function(jsonData)
return gameUtilityModel.getGameYearPass(jsonData[1]),jsonData[2],itemsConfig.getItemName(jsonData[3]),jsonData[4],jsonData[5]
end,
['XT_RV_TYPE_COLOR_ITEM_TYPE_5']=function(jsonData)
return gameUtilityModel.getGameYearPass(jsonData[1]),jsonData[2],jsonData[3],itemsConfig.getItemName(jsonData[4]),jsonData[5]
end,
}

function xiantuchengjiuModel:updateLookBacks(data)
data=data or{}
self.lookback={}
self.lookbackLookup={}
for i,v in ipairs(data)do
local type=v.id
local len=v.len
if len>0 then
local list=v.list
local cfg=cfgHelper.get1(cfg_xiantureviewconfig_get,type)
for index,json in ipairs(list)do
local jsonData=jsonHelper.decode(json)
local descContent=cfg.descEx and cfg.descEx[jsonData[2]]or cfg.desc
local imageContent=cfg.imageEx and cfg.imageEx[jsonData[2]]or cfg.image
local showTypeContent=cfg.showTypeEx and cfg.showTypeEx[jsonData[2]]or cfg.showType
local param1,param2,param3,param4,param5
local speDecode=_descDecode[cfg.enum]
if speDecode then
param1,param2,param3,param4,param5=speDecode(jsonData)
else
param1,param2,param3,param4,param5=self:getNormalStrParam(jsonData)
end
local descStr=FMT.fmt(descContent,param1,param2,param3,param4,param5)
data={
id=cfg.id,
time=jsonData[1],
type=showTypeContent,
desc=descStr,
image=imageContent,
name=cfg.name or"",
args={param1,param2,param3,param4,param5},
}
table.insert(self.lookback,data)

if self.lookbackLookup[cfg.id]==nil then
self.lookbackLookup[cfg.id]={}
end
self.lookbackLookup[cfg.id][#self.lookbackLookup[cfg.id]+1]=data
end
end
end
table.sort(self.lookback,self.sortLookBacks)
end

function xiantuchengjiuModel:getNormalStrParam(jsonData)
return gameUtilityModel.getGameYearPass(jsonData[1]),jsonData[2],jsonData[3],jsonData[4],jsonData[5]
end

function xiantuchengjiuModel:cleanLookBacks()
self.lookback={}
self.lookbackLookup={}
end

function xiantuchengjiuModel:getLookBacks()
return self.lookback
end

function xiantuchengjiuModel:getLookBacksLookUp()
return self.lookbackLookup or{}
end

function xiantuchengjiuModel.sortLookBacks(a,b)
if a.time~=b.time then
return a.time<b.time
else
return a.id<b.id
end
end