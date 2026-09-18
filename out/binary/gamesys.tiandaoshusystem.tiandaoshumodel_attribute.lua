local _skillIndexConvert={
[0]=2,
[1]=3,
[2]=1,
}

function tiandaoshuModel:convertSkillType(sType)
return _skillIndexConvert[sType]
end

function tiandaoshuModel:getFruitAttrDesc(voc,attrList,percent,skills,space)
local spaceStr=space or","
local attrStr=nil

for actID,list in pairs(attrList)do
if actID==0 then
for i,v in ipairs(list)do
local str=helper.getAttributeStr(v[1],v[2],2,"<color=#FD8950>{1}</color>{0}")
if attrStr then
attrStr=FMT.fmt("{0}{1}{2}",attrStr,spaceStr,str)
else
attrStr=str
end
end
else
local actName=limitActivitiesModel:getActConfig(actID,"name")
local actStr="<color=#FD8950>{1}</color>"..actName.."{0}"
for i,v in ipairs(list)do
local str=helper.getAttributeStr(v[1],v[2],2,actStr)
if attrStr then
attrStr=FMT.fmt("{0}{1}{2}",attrStr,spaceStr,str)
else
attrStr=str
end
end
end
end

for i,v in pairs(percent)do
local str=FMT.fmt("<color=#FD8950>{0}%</color>天道{1}",v,helper.getAttributeName(i))
if attrStr then
attrStr=FMT.fmt("{0}{1}{2}",attrStr,spaceStr,str)
else
attrStr=str
end
end

for i=0,2 do
local v=skills[i]
if v and v>0 then
local skillList=cfgHelper.get3(cfg_disciplevocationconfig_get,voc,'skills',1)
local skillId=skillList[self:convertSkillType(i)]
local skillname=cfgHelper.get2(cfg_skillconfig_get,skillId,"name")
local str=FMT.fmt("{1} 技能等级<color=#FD8950>+{0}</color>",v,skillname)
if attrStr then
attrStr=FMT.fmt("{0}{1}{2}",attrStr,spaceStr,str)
else
attrStr=str
end
end
end

local vocName=UIDiscipleModel:getJobName(voc)
return FMT.fmt("为{0}弟子增加{1}",vocName,attrStr)
end

function tiandaoshuModel:getVocAttrList(voc)
local status={self.eFruitStatus.eNormal,self.eFruitStatus.eCountDown,self.eFruitStatus.eCompleted}
local fruits=tiandaoshuModel:findFruitsEx_VocStatus(voc,status)
local values={}
local percents={}
local acts={}
for index,fruitData in ipairs(fruits)do
local count=fruitData.count
if count>0 then
local fruitCfg=tiandaoshuConfig:getFruitConfig(fruitData.voc,fruitData.stage,fruitData.id)
for actId,attrList in pairs(fruitCfg.attr)do
if not values[actId]then
values[actId]={}
table.insert(acts,actId)
end
local temp=values[actId]
for attrIdx,attrCfg in ipairs(attrList)do
local attrId=attrCfg[1]
local attrValue=attrCfg[2]
temp[attrId]=(temp[attrId]or 0)+attrValue*count
end
end

for attrId,percent in pairs(fruitCfg.percent or{})do
percents[attrId]=(percents[attrId]or 0)+percent*count
end
end
end
table.sort(acts)
return values,percents,acts
end

function tiandaoshuModel:getVocSkillList(voc)
local status={self.eFruitStatus.eNormal,self.eFruitStatus.eCountDown,self.eFruitStatus.eCompleted}
local fruits=tiandaoshuModel:findFruitsEx_VocStatus(voc,status)
local skills={}
local indexs={}
for index,fruitData in ipairs(fruits)do
local count=fruitData.count
if count>0 then
local fruitCfg=tiandaoshuConfig:getFruitConfig(fruitData.voc,fruitData.stage,fruitData.id)
for sType,addVal in pairs(fruitCfg.skill)do
if addVal>0 then
if skills[sType]==nil then
table.insert(indexs,sType)
end
skills[sType]=(skills[sType]or 0)+addVal*count
end
end
end
end
table.sort(indexs)
return skills,indexs
end

function tiandaoshuModel:dirtyVocDiscipleAttribute(voc)
local disciples=UIDiscipleModel:findDisciplesByJob(voc)
for index,discipleInfo in ipairs(disciples)do
local netData=UIDiscipleModel:getDiscipleDataByStr(discipleInfo.discipleguidStr)
UIDiscipleModel:setDiscipleAttrListDirty(netData,DISCIPLE_ATTRIBUTE_TYPE.eTianDaoShu,false)
end
end

function tiandaoshuModel:dirtyAllDiscipleAttribute()
local disciples=UIDiscipleModel:getAllDiscipleData()
for index,disciple in pairs(disciples)do
local netData=disciple.netData.net
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(netData.discipleguid)
if self:isVocActive(imageInfo.job)then
UIDiscipleModel:setDiscipleAttrListDirty(netData,DISCIPLE_ATTRIBUTE_TYPE.eTianDaoShu,false)
end
end
end

function tiandaoshuModel:dirtyVocDiscipleSkill(voc)
local disciples=UIDiscipleModel:findDisciplesByJob(voc)
for index,discipleInfo in ipairs(disciples)do
UIDiscipleModel:setSkillLvPlusLookupDirty(discipleInfo.discipleguid,false)
end
end

function tiandaoshuModel:refreshVocDiscipleSkillAttribute(voc)
local disciples=UIDiscipleModel:findDisciplesByJob(voc)
for index,discipleInfo in ipairs(disciples)do
UIDiscipleModel:refreshJobSkillLookup(discipleInfo.discipleguid)
end
end

function tiandaoshuModel:dirtyAllDiscipleSkill()
local disciples=UIDiscipleModel:getAllDiscipleData()
for index,disciple in pairs(disciples)do
local netData=disciple.netData.net
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(netData.discipleguid)
if self:isVocActive(imageInfo.job)then
UIDiscipleModel:setSkillLvPlusLookupDirty(netData.discipleguid,false)
end
end
end

function tiandaoshuModel:findSkillExtraLevel(discipleguid,skillId)
local voc=UIDiscipleModel:getDiscipleJob(discipleguid)
local tdsAdds=tiandaoshuModel:getVocSkillList(voc)
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
local skills=UIDiscipleModel:getDiscipleJobSkilIDlList(netData)
for i,v in ipairs(skills)do
if v==skillId then
local index=table.findValue(_skillIndexConvert,i)
local value=tdsAdds[index]
return value or 0
end
end
return 0
end