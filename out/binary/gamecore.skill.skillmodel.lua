







skillModel={}

local table_insert=table.insert
local table_sort=table.sort
local string_format=string.format



















eSkillTipsType=
{
eDZSkill=1,
eDZGFSkill=2,
eDZSTSkill=3,
eLSSkill=4,
eLSTalentSkill=5,
}

local skillLvPlusLookup=nil
local skillCooldownPlusLookup=nil


local _skillconfig={}

cfg_skillconfig_get=function(k,show_msg)
local cfg=_skillconfig[k]
if cfg==nil then
local subCfg=require(FMT.fmt("data/config/skillconfig_{0}",math.floor(k/100)))
if subCfg~=nil then
for i,v in pairs(subCfg)do
_skillconfig[i]=v
end
end
cfg=_skillconfig[k]
end
return cfg
end

function skillModel:getSkillLvStr(skilllv)
if skilllv<=0 then
return'未解锁'
else
return FMT.fmt('{0}级',skilllv)
end
end

function skillModel:getSkillDesc(skillid,skilllv)
local skillconfig=cfgHelper.get1(cfg_skillconfig_get,skillid)







local desc=skillconfig.desc
local descParams=skillconfig.descParams
if desc==nil then
return'没有找到技能配置'
end
if descParams==nil or#descParams<=0 then
return desc
end
if skilllv>#descParams then
skilllv=#descParams
end
if skilllv==0 then
skilllv=1
end
return FMT.fmt(desc,unpack(descParams[skilllv]))
end

function skillModel:getSkillDescEx(skillid,skilllv)
local skillconfig=cfgHelper.get1(cfg_skillconfig_get,skillid)







local descEx=skillconfig.descEx
local descExParams=skillconfig.descExParams or{}
if descEx==nil or#descEx<=0 then
return nil
end



local maxlv=#descExParams
if skilllv>maxlv then
skilllv=maxlv
end
if skilllv==0 then
skilllv=1
end
local list={}
local lv_params=descExParams[skilllv]or{}
for idx,data in ipairs(descEx)do
local params=lv_params[idx]
if params==nil or#params<=0 then
table.insert(list,data[1])
else
table.insert(list,FMT.fmt(data[1],unpack(params)))
end
end
return list
end

function skillModel:getSkillupgradeDesc(skillid,skilllv)
local skillconfig=cfgHelper.get1(cfg_skillconfig_get,skillid)
local desc=skillconfig.upgradeDesc
local descParams=skillconfig.descParams
if desc==nil then
return'没有找到技能配置'
end
if descParams==nil then
return desc
end
if skilllv>#descParams then
skilllv=#descParams
end
if skilllv==0 then
skilllv=1
end
return FMT.fmt(desc,unpack(descParams[skilllv]))
end

function skillModel:getSkillCooldownTime(skillid,skilllv)
local skillconfig=cfgHelper.get1(cfg_skillconfig_get,skillid)
local cooldownlist=skillconfig.cooldownTime
if cooldownlist==nil then
return 0
end
if skilllv>=#cooldownlist then
skilllv=#cooldownlist
end
if skilllv==0 then
skilllv=1
end
return cooldownlist[skilllv]
end

function skillModel.isSkillBD(skillType)
return skillType==1 or skillType==2
end

function skillModel.getSkillNaneChange(skillCfg)
if skillCfg and skillCfg.lddzid then
local dzid=skillCfg.lddzid[1]
if dzid and UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(dzid)then
local skillid=skillCfg.lddzid[2]
skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillid)
end
end
if skillCfg then
return skillCfg.name
else
return''
end
end

function skillModel.getSkillIconChange(skillCfg,dzData)
if dzData and dzData.id and dzData.disguise and skillCfg.icon2 then
if dzData.disguise>0 and dzData.id~=dzData.disguise then
return skillCfg.icon2
end
end
return skillCfg.icon
end



function skillModel:getSkillLv(skillId,skillLv)
return skillLv+skillModel:getSkillLvPlus(skillId)
end

function skillModel:getSkillLvPlus(skillId)
local lookup=skillModel:getSkillLvPlusLookup()
return lookup[skillId]or 0
end

function skillModel:clearSkillLvPlusLookup()
skillLvPlusLookup=nil
end

function skillModel:getSkillLvPlusLookup()
local lookup=skillLvPlusLookup
if lookup==nil then
skillModel:refreshSkillLvPlusLookup()
lookup=skillLvPlusLookup
end
return lookup
end

function skillModel:refreshSkillLvPlusLookup()
local lookup={}
skillLvPlusLookup=lookup

local gfPlus=UIDiscipleModel:getGFStudySkillLvPlus()
if gfPlus then
for k,v in pairs(gfPlus)do
local skillId=k
local skillLv=v
if lookup[skillId]==nil then
lookup[skillId]=skillLv
else
lookup[skillId]=lookup[skillId]+skillLv
end
end
end
end

function skillModel:setSkillLvPlusLookupDirty(params)
skillModel:refreshSkillLvPlusLookup()
if params~=nil then
if params.dis_guid~=nil then
UIDiscipleModel:setSkillLvPlusLookupDirty(params.dis_guid)
end
end
end





function skillModel:getSkillCooldown(skillId,cooldown)
return skillLv+skillModel:getSkillLvPlus(skillId)
end

function skillModel:getSkillCooldownPlus(skillId)
local lookup=skillModel:getSkillCooldownPlusLookup()
return lookup[skillId]or 0
end

function skillModel:clearSkillCooldownPlusLookup()
skillCooldownPlusLookup=nil
end

function skillModel:getSkillCooldownPlusLookup()
local lookup=skillCooldownPlusLookup
if lookup==nil then
skillModel:refreshSkillCooldownPlusLookup()
lookup=skillCooldownPlusLookup
end
return lookup
end

function skillModel:refreshSkillCooldownPlusLookup()
local lookup={}
skillCooldownPlusLookup=lookup


end

function skillModel:setSkillCooldownPlusLookupDirty(params)
skillModel:refreshSkillCooldownPlusLookup()
if params~=nil then
if params.dis_guid~=nil then
UIDiscipleModel:setSkillCoolDownPlusLookupDirty(params.dis_guid)
end
end
end




function skillModel:getSkillGiveStateList(skillid,skilllv)
local skillconfig=cfgHelper.get1(cfg_skillconfig_get,skillid)







local descEx=skillconfig.descEx
local descExParams=skillconfig.descExParams or{}
if descEx==nil or#descEx<=0 then
return nil
end

local maxlv=#descExParams
if skilllv>maxlv then
skilllv=maxlv
end
if skilllv==0 then
skilllv=1
end
local list={}
local lv_params=descExParams[skilllv]or{}
for idx,data in ipairs(descEx)do
local temp={}
local topStr=string.match(data[1],"【(.-)】")
if pfwindowslController:checkIsGameVersion_oumei()then
topStr=string.match(data[1],"%[(.-)%]")
end
if topStr then
temp.stateName=topStr
temp.stateIconId=data[2]
temp.stateType=data[3]
temp.gongFaTypeIcon=data[4]


local line=FMT.fmt('【{0}】',topStr)
if pfwindowslController:checkIsGameVersion_oumei()then
line=FMT.fmt("%[{0}%]",topStr)
end
local _,el=string.find(data[1],line)
temp.desc=string.sub(data[1],el+1)
local nameColor=data[3]==1 and"#5ac0e2"or"#f36666"
temp.stateName=FMT.fmt("<color={0}>{1}</color>",nameColor,temp.stateName)

local params=lv_params[idx]
if params~=nil and#params>0 and temp.desc then
temp.desc=FMT.fmt(temp.desc,unpack(params))
end
table.insert(list,temp)
end
end
return list
end

function skillModel:getSkillHoardDescEx(guid,gfid,skillId,skillLv,ignore)
local hoardDatas=UIDiscipleModel:getDiscipleHoard(guid)
local limit=cfgHelper.get2(cfg_disciplespiritrootbaseconfig_get,1,'limit')
local totallv=UIDiscipleModel:getDiscipleTotalLinggenLevel(guid)
local list={}
local descFunc=function(data)
if data.activelistlen>0 then
local hoardCfg=cfgHelper.get1(cfg_disciplespiritroothoardconfig_get,data.activeList[1].hoardid)
if hoardCfg.gongfaid==gfid and hoardCfg.gongfa~=nil and hoardCfg.gongfa[skillId]then
local descEx
local descExParams
local lv
descEx=hoardCfg.gf_desc
descExParams=hoardCfg.gf_descParams or{}
if(hoardCfg.gongfa and hoardCfg.gongfa[skillId])then
lv=1
elseif hoardCfg.skillid~=nil then
lv=data.activeList[1].skilllv
end
local lv_params=descExParams[lv]or{}
if descEx and lv_params then
for idx,desc in ipairs(descEx)do
local params=lv_params[idx]
if params==nil or#params<=0 then
table.insert(list,toColorString(FONT_COLOR.eGreenTxtColor,desc[1]))
else
table.insert(list,toColorString(FONT_COLOR.eGreenTxtColor,FMT.fmt(desc[1],unpack(params))))
end
end
end
end
end
end
for index=1,5 do
if totallv>=limit[index]then
local data=hoardDatas[index]
descFunc(data)
end
end
local varySrid=UIDiscipleModel:getDiscipleVarysrid(guid)
if varySrid>0 then
local data=hoardDatas[-varySrid]
descFunc(data)
end
return list
end

function skillModel:getLingShouTraitEffectAdd(guid,gfID,skillID)
local lsGuid=lingshouModel:getLingShouByDizi(guid)
if lsGuid==nil then return defaultT end
local lsData=lingshouModel:getLingShouData2(lsGuid)
if lsData==nil then return defaultT end
local faction=cfgHelper.get(cfg_disciplegongfaconfig_get,gfID,'faction')
local skillType=cfgHelper.get(cfg_skillconfig_get,skillID,'skillType')
local name=cfgHelper.get(cfg_skillconfig_get,skillID,'name')

local list=lingshouModel:getLingShouTraitEffectLookupEx(lsData.guid_str,lingshouTraitEffectEnum.DISCIPLE_GONGFA_LEVEL_ADD)

local descList={}

for index,data in ipairs(list)do
local wordid=data[1]
local wname=cfgHelper.get(cfg_lingshouwordconfig_get,wordid,'name')
for _,args in ipairs(data[2])do
if args[2]==faction and args[3]==skillType then
local desc=FMT.fmt("灵宠·{0}：{1}技能等级+{2}",wname,name,args[4])
descList[#descList+1]=toColorString(FONT_COLOR.eGreenTxtColor,desc)
end
end
end

return descList
end