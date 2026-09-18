







gonggaoModel={}

local _gglist=nil
local _info={}
local _contentVersion=0
local _saveData=nil
local _initSaveData=false


function gonggaoModel.getSaveData()
if _saveData==nil then
local e,s=pcall(function()_saveData=jsonHelper.readFile('gonggaoInfo.json',nil)end)
if not e then

_saveData=nil
end
end

return _saveData
end


function gonggaoModel.saveData(version)
local saveData={}
saveData.info=_info
saveData.ggList=_gglist
saveData.version=version
jsonHelper.writeFile('gonggaoInfo.json',saveData)
end


function gonggaoModel.setData(list,version)
_gglist=list
_contentVersion=version

if _info.noticenum==version then
gonggaoModel.saveData(version)
else
jsonHelper.writeFile('gonggaoInfo.json',{})
end
end

function gonggaoModel.checkDataVersion(version)
return _contentVersion==version
end

function gonggaoModel.getDataByIndex(index)
local gglist=gonggaoModel.getData()
return gglist[index]
end

function gonggaoModel.getDataX()
return _gglist
end

function gonggaoModel.getData()
return _gglist or{}
end


function gonggaoModel.setInfo(info)
_info=info
end

function gonggaoModel.getOpenType()
return _info.eject
end



function gonggaoModel.getVersion(curServerTimestamp)


if not _initSaveData then
_initSaveData=true
local saveData=gonggaoModel.getSaveData()
if saveData~=nil and saveData.info~=nil and saveData.ggList~=nil and saveData.version~=nil then

if curServerTimestamp~=nil then

_info=saveData.info
_gglist=saveData.ggList
_contentVersion=saveData.version or 0

local temp={}
for i,v in ipairs(_gglist)do
if v.begin_time~=nil and v.end_time~=nil then
local startTime=tonumber(v.begin_time)
local endTime=tonumber(v.end_time)
if startTime<=curServerTimestamp and curServerTimestamp<=endTime then
temp[#temp+1]=v
end
end
end

_gglist=temp
end
end
end
return _info.noticenum
end


