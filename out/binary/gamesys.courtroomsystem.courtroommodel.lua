






local _MODULENAME="courtroomModel"




def_table(_MODULENAME)
courtroomModel.name=_MODULENAME


courtroomModel.data={}

local _lineMapConfig=nil

local path='/data/pointLineMapConfig/lineMapConfig'
local readPath='data/pointLineMapConfig/lineMapConfig'


function courtroomModel:onAppStart()
_lineMapConfig=nil
end


function courtroomModel:onEnterState()
self.data={}
self.data.recordSpeList={}
end


function courtroomModel:onLeaveState()

self.data={}
end


function courtroomModel:onServerDataInitFinish()

end





function courtroomModel.FileExport(id,posList,lineList)
if deviceHelper.isRunEditor()then

local outPath=CS.GamePath.writablePath..path..'.lua'


local ot={}
local f=io.open(outPath,'r')
if f then
local content=f:read('*all')
f:close()
ot=loadstring(content)()
end

if(not posList)or(not lineList)then
ot[id]=nil
else
ot[id]={posList=posList,lineList=lineList}
end

local string_content={}
string_content[#string_content+1]='\nlocal lineMapConfig'..' =\n{\n'

for mapid,v in pairs(ot)do
if type(v)=='table'then
string_content[#string_content+1]='	['..mapid..'] = \n{'..'\n'
string_content[#string_content+1]='		["posList"] = \n{'..'\n'
for i,v2 in ipairs(v.posList)do
string_content[#string_content+1]='			['..i..'] = {'..table.concat(v2,",")..'},'..'\n'
end
string_content[#string_content+1]='		},\n'
string_content[#string_content+1]='		["lineList"] = \n{'..'\n'
for i,v2 in ipairs(v.lineList)do
string_content[#string_content+1]='			['..i..'] = {'..table.concat(v2,",")..'},'..'\n'
end
string_content[#string_content+1]='		},\n'
string_content[#string_content+1]='	},\n'
end
end

string_content[#string_content+1]='}\nreturn lineMapConfig'

local f=io.open(outPath,'wb+')

f:write(table.concat(string_content,''))
f:close()
UIManager.info('导出成功')
end
end

function courtroomModel.cfg_posConfig()
if _lineMapConfig then
return _lineMapConfig
end
_lineMapConfig=require(readPath)
return _lineMapConfig
end

function courtroomModel.cfg_posConfig_get(id)
if not _lineMapConfig then
courtroomModel.cfg_posConfig()
end
return _lineMapConfig[id]
end


function courtroomModel.getForgetConfig(tezhiType,tezhiId)
local config=cfg_lvfatangforgetconfig_get(tezhiType)
if config then
return config[tezhiId]
end
end


function courtroomModel.getFreePercent(zlGuid)
if not zlGuid then return 0 end
local netData=UIDiscipleModel:getDiscipleData(zlGuid)
local teZhiRate=dzSpecialityGrowEffectController:getLvFaTangCostRateLookup(netData)
local gubaoRate=gubaoModel:getGBSkil_StrangeForgetCostRate()
gubaoRate=-gubaoRate
local attrRate=0
local config=cfg_lvfatangconfig_get(1)
if config then
local attr=UIDiscipleModel:getDiscipleBaseAttr(zlGuid,config.attr6[1])
attrRate=attr*config.attr6[2]
if attrRate>config.attr6[3]then
attrRate=config.attr6[3]
end
attrRate=-attrRate
end

return teZhiRate+attrRate+gubaoRate
end


function courtroomModel.getFreePercent2(dzguid)
if not dzguid then return 0 end
local netData=UIDiscipleModel:getDiscipleData(dzguid)
local teZhiRate=dzSpecialityGrowEffectController:getLvFaTangCostRateLookup2(netData)
return teZhiRate
end



function courtroomModel.getZLTeZhi()
local config=cfg_lvfatangconfig_get(1)
if config then
return config.showspecialityid
end
end

function courtroomModel:getShowSpecialityList(dz_speciality)
local showSpeciality=courtroomModel.getZLTeZhi()
if not next(showSpeciality)then
return
end
local specialityList={}
if dz_speciality then
for i,v in ipairs(dz_speciality)do
for _,limit in ipairs(showSpeciality)do
if v.specialitytype==limit[1]and v.id==limit[2]then
table.insert(specialityList,v)
end
end
end
end
return specialityList
end


function courtroomModel:setSelectGuid(guid)
self.data.selectGuid=guid
end

function courtroomModel:getSelectGuid()
return self.data.selectGuid
end


function courtroomModel:setSelectSpe(speType,config)
self.data.selectSpe={speType,config}
end

function courtroomModel:getSelectSpe()
return self.data.selectSpe
end

function courtroomModel:recordGuid(guid)
self.data.recordGuid=guid
end

function courtroomModel:getRecordGuid()
return self.data.recordGuid
end

function courtroomModel:recordSpe(guid,speType,idx)
guid=tostring(guid)
self.data.recordSpeList[guid]={speType,idx}
end

function courtroomModel:getRecordSpe(guid)
guid=tostring(guid)
return self.data.recordSpeList[guid]or{}
end

function courtroomModel:initRecordSpe()
self.data.recordSpeList={}
end



