

rawDataReplace={}

function rawDataReplace.init()
if api_Available_ReplaceEffect()then
local pfID=loginModel:getPfid()
local pfCfg=cfgHelper.get1(cfg_pfresreplacecfg_get,pfID)
if pfCfg~=nil then
local replaceCfg=cfgHelper.get1(cfg_rawdatarepalcecfg_get,pfCfg.resID)
if replaceCfg~=nil then
rawDataReplace.replaceSpineData(replaceCfg.spineBodys,replaceCfg.spineCmps)
rawDataReplace.replaceData(replaceCfg.icons,CS.GameInterface.ReplaceIcon)
rawDataReplace.replaceData(replaceCfg.effects,CS.GameInterface.ReplaceEffect)
rawDataReplace.replaceData(replaceCfg.sounds,CS.GameInterface.ReplaceSound)
end
end
end
end

function rawDataReplace.replaceData(rawDatas,func)
if#rawDatas>0 then
local dataList={}
for i,v in pairs(rawDatas)do
dataList[#dataList+1]=v[1]
dataList[#dataList+1]=v[2]
end
func(dataList)
end
end

function rawDataReplace.replaceSpineData(bodyDatas,cmpDatas)
if#bodyDatas>0 or#cmpDatas>0 then
local bodyList={}
for i,v in pairs(bodyDatas)do
bodyList[#bodyList+1]=v[1]
bodyList[#bodyList+1]=v[2]
end

local cmpList={}
for i,v in pairs(cmpDatas)do
cmpList[#cmpList+1]=v[1]
cmpList[#cmpList+1]=v[2]
end
CS.GameInterface.ReplaceSpine(bodyList,cmpList)
end
end