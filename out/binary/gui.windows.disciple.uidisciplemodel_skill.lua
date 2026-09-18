







discipleSkillType=
{
eJob=1,
eEquip=2,
eGongFa=3,
eSpecial=4,
eVaryLingGen=5,
eXianMo=6,
}

local refreshSkillFunctionsLookup=
{

[discipleSkillType.eJob]=function(guid)
UIDiscipleModel:refreshJobSkillLookup(guid)
end,

[discipleSkillType.eEquip]=function(guid)
UIDiscipleModel:refreshEquipSkillLookup(guid)
end,

[discipleSkillType.eGongFa]=function(guid)
UIDiscipleModel:refreshGongFaSkillLookup(guid)
end,

[discipleSkillType.eSpecial]=function(guid)
UIDiscipleModel:refreshSpecialSkillLookup(guid)
end,

[discipleSkillType.eVaryLingGen]=function(guid)
UIDiscipleModel:refreshVaryLingGenSkillLookup(guid)
end,

[discipleSkillType.eXianMo]=function(guid)
UIDiscipleModel:refreshXianMoSkillLookup(guid)
end,
}


















































function UIDiscipleModel:getAllSkillLookup(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local lookup=netData.allSkillLookup
if lookup==nil then
for k,func in pairs(refreshSkillFunctionsLookup)do
func(guid)
end
lookup=netData.allSkillLookup
end
return lookup
end

function UIDiscipleModel:getSkillLookup(guid,skillType)
local netData=UIDiscipleModel:getDiscipleData(guid)
local lookup=netData.allSkillLookup
local func=refreshSkillFunctionsLookup[skillType]
if func then
func(guid)
end
lookup=netData.allSkillLookup
if lookup then
return lookup[skillType]
end
end

function UIDiscipleModel:initAllSkillLookup(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local lookup=netData.allSkillLookup
if lookup==nil then
lookup={}
netData.allSkillLookup=lookup
end
return lookup
end

function UIDiscipleModel:refreshJobSkillLookup(guid)
local all=UIDiscipleModel:initAllSkillLookup(guid)
local sub={}
all[discipleSkillType.eJob]=sub

local skilllist=UIDiscipleModel:getDiscipleJobSkillList2(guid)
for idx,v in ipairs(skilllist)do
local skillId=v[1]
local skillLv=v[2]
sub[skillId]=skillLv
end


UIDiscipleModel:refreshAllSkillCoolDowmLookup(guid)
end

function UIDiscipleModel:refreshEquipSkillLookup(guid)
local all=UIDiscipleModel:initAllSkillLookup(guid)
local sub={}
all[discipleSkillType.eEquip]=sub


local equipSkills=equipsHelper.getSuitSkill(guid)
if equipSkills~=nil and#equipSkills>0 then
for idx,v in ipairs(equipSkills)do
local skillId=v[1]
local skillLv=v[2]
sub[skillId]=skillLv
end
end


local daobingSkills=daobingHelper.getDzUseSkills(guid)
if daobingSkills~=nil and#daobingSkills>0 then
for _,v in ipairs(daobingSkills)do
local skillId=v[1]
local skillLv=v[2]
sub[skillId]=skillLv
end
end


UIDiscipleModel:refreshAllSkillCoolDowmLookup(guid)
end

function UIDiscipleModel:refreshGongFaSkillLookup(guid)
local all=UIDiscipleModel:initAllSkillLookup(guid)
local sub={}
all[discipleSkillType.eGongFa]=sub


local usingSkills=UIDiscipleModel:getDiscipleUsingGFSkillList(guid)
for idx,v in ipairs(usingSkills)do
local skillId=v[1]
local skillLv=v[2]
sub[skillId]=skillLv
end

local studySkills=UIDiscipleModel:getDiscipleStudyGFSkillList(guid)
for idx,v in ipairs(studySkills)do
local skillId=v[1]
local skillLv=v[2]
sub[skillId]=skillLv
end

local gfskills=UIDiscipleModel:getDiscipleLingGenGFSkillAddList(guid)
for skillId,skillAddLv in pairs(gfskills)do
if sub[skillId]then
sub[skillId]=sub[skillId]+skillAddLv
else
sub[skillId]=skillAddLv
end
end


UIDiscipleModel:refreshAllSkillCoolDowmLookup(guid)
end

function UIDiscipleModel:refreshSpecialSkillLookup(guid)
local all=UIDiscipleModel:initAllSkillLookup(guid)
local sub={}
all[discipleSkillType.eSpecial]=sub
local netData=UIDiscipleModel:getAnyDiscipleDataByStr(tostring(guid))
local speSkills=dzSpecialityFightEffectController:getAddBDSkillLookup(netData)
if speSkills~=nil then
for skillId,skillLv in pairs(speSkills)do
sub[skillId]=skillLv
end
end


UIDiscipleModel:refreshAllSkillCoolDowmLookup(guid)
end

function UIDiscipleModel:refreshVaryLingGenSkillLookup(guid)
self:getSkillLookup(guid,discipleSkillType.eGongFa)
local all=UIDiscipleModel:initAllSkillLookup(guid)

local skilllist=UIDiscipleModel:getDiscipleLingGenSkillAddList(guid)

self:checkSkillAssert(skilllist,all)

all[discipleSkillType.eVaryLingGen]=skilllist


UIDiscipleModel:refreshAllSkillCoolDowmLookup(guid)
end

function UIDiscipleModel:refreshXianMoSkillLookup(guid)
local all=UIDiscipleModel:initAllSkillLookup(guid)
local sub={}
all[discipleSkillType.eXianMo]=sub

local xmSkills=UIDiscipleModel:getDiscipleXianMoSkillList(guid)
for _,v in ipairs(xmSkills)do
local skillId=v[1]
local skillLv=v[2]
if skillLv>0 then
sub[skillId]=skillLv
end
end


UIDiscipleModel:refreshAllSkillCoolDowmLookup(guid)
end


function UIDiscipleModel:refreshAllSkillCoolDowmLookup(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local coolDowmLookup={}
netData.allSkillCoolDownLookup=coolDowmLookup


local globalPlus=skillModel:getSkillCooldownPlusLookup()
if globalPlus then
for k,v in pairs(globalPlus)do
local skillId=k
local cooldown=v
if coolDowmLookup[skillId]==nil then
coolDowmLookup[skillId]=cooldown
else
coolDowmLookup[skillId]=coolDowmLookup[skillId]+cooldown
end
end
end

local skillLookup=UIDiscipleModel:getAllSkillLookup(guid)
for typo,lookup in pairs(skillLookup)do
for skillId,skillLv in pairs(lookup)do
if skillLv>0 then
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
if skillCfg.passive then
local passive_lv=skillCfg.passive[skillLv]
if passive_lv then
for i,v in ipairs(passive_lv)do
if v[1]==0 and v[2]==34 then
local c_skillId=v[3]
local c_coolDown=-v[4]
coolDowmLookup[c_skillId]=coolDowmLookup[c_skillId]or 0
coolDowmLookup[c_skillId]=coolDowmLookup[c_skillId]+c_coolDown
end
end
else



end
end
end
end
end
end

function UIDiscipleModel:getSkillCoolDown(guid,skillId,coolDown)
local cd=coolDown+UIDiscipleModel:getSkillCoolDownChange(guid,skillId)
if cd<0 then cd=0 end
return cd
end

function UIDiscipleModel:getSkillCoolDownChange(guid,skillId)
local lookup=UIDiscipleModel:getSkillCoolDownLookup(guid)
return lookup[skillId]or 0
end

function UIDiscipleModel:getSkillCoolDownLookup(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local lookup=netData.allSkillCoolDownLookup
if lookup==nil then
UIDiscipleModel:refreshAllSkillCoolDowmLookup(guid)
lookup=netData.allSkillCoolDownLookup
end
return lookup
end

function UIDiscipleModel:setSkillCoolDownPlusLookupDirty(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData==nil then return end
UIDiscipleModel:refreshAllSkillCoolDowmLookup(guid)
end





function UIDiscipleModel:getSkillLv(guid,skillId,skillLv)
return skillLv+UIDiscipleModel:getSkillLvPlus(guid,skillId)
end

function UIDiscipleModel:getSkillLvPlus(guid,skillId)
local lookup=UIDiscipleModel:getSkillLvPlusLookup(guid)
return lookup[skillId]or 0
end


function UIDiscipleModel:getSkillLvPlusLookup(guid)
if UIDiscipleModel:isMyActorDZ(guid)then
local netData=UIDiscipleModel:getDiscipleData(guid)
local lookup=netData.skillLvPlusLookup
if lookup==nil then
UIDiscipleModel:refreshSkillLvPlusLookup(guid)
lookup=netData.skillLvPlusLookup
end
return lookup
else
local lookup=otherPlayerModel:getSkillLvPlusLookup(guid)or{}
return lookup
end
end

function UIDiscipleModel:refreshSkillLvPlusLookup(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData==nil then return end
local lookup={}
netData.skillLvPlusLookup=lookup

local globalPlus=skillModel:getSkillLvPlusLookup()
if globalPlus then
for k,v in pairs(globalPlus)do
local skillId=k
local skillLv=v
if lookup[skillId]==nil then
lookup[skillId]=skillLv
else
lookup[skillId]=lookup[skillId]+skillLv
end
end
end
local skills=UIDiscipleModel:getDiscipleJobSkilIDlList(netData)

local lv_by_fb=equipsHelper.getFabaoEffect(guid,FABAO_CIZHUI_EFFECT_TYPE.eAddJobActiveSkillLv)
if lv_by_fb~=nil and lv_by_fb~=0 then

local skillId=skills[2]
if lookup[skillId]==nil then
lookup[skillId]=lv_by_fb
else
lookup[skillId]=lookup[skillId]+lv_by_fb
end
end

local voc=UIDiscipleModel:getDiscipleJob(guid)
local tdsAdds=tiandaoshuModel:getVocSkillList(voc)
if next(tdsAdds)then
if tdsAdds[0]then
local skillId=skills[2]
if lookup[skillId]==nil then
lookup[skillId]=tdsAdds[0]
else
lookup[skillId]=lookup[skillId]+tdsAdds[0]
end
end
if tdsAdds[1]then
local skillId=skills[3]
if lookup[skillId]==nil then
lookup[skillId]=tdsAdds[1]
else
lookup[skillId]=lookup[skillId]+tdsAdds[1]
end
end
if tdsAdds[2]then
local skillId=skills[1]
if lookup[skillId]==nil then
lookup[skillId]=tdsAdds[1]
else
lookup[skillId]=lookup[skillId]+tdsAdds[1]
end
end
end















local jobSkillList=UIDiscipleModel:getDiscipleJobSkilIDlList(netData)
local transIndex={[0]=2,[1]=3,[2]=1}
local lgJobSkillList,extraSkillList,gongfaSkillList=UIDiscipleModel:getDiscipleLingGenSkillLevelAddList(guid)
for k,add in pairs(lgJobSkillList)do
if jobSkillList[k]then
local transid=transIndex[k]
local skillId=jobSkillList[transid]
if lookup[skillId]==nil then
lookup[skillId]=add
else
lookup[skillId]=lookup[skillId]+add
end
end
end




for skillId,add in pairs(extraSkillList)do
if lookup[skillId]==nil then
lookup[skillId]=add
else
lookup[skillId]=lookup[skillId]+add
end
end

for skillId,add in pairs(gongfaSkillList)do
if lookup[skillId]==nil then
lookup[skillId]=add
else
lookup[skillId]=lookup[skillId]+add
end
end


local netData=UIDiscipleModel:getDiscipleData(guid)
local llist=netData.livingEquipList
if llist then
for i,v in ipairs(llist)do
if systemModel.isOpen(SYSTEM_DEFINE.eYuFuLingZhen)then
local itemData=v.prePartInfo
if itemData.itemData and itemData.itemData.lzItem then
if itemData.itemData.lzItem.kongList then
for i2,v2 in ipairs(itemData.itemData.lzItem.kongList)do
if v2.randAttrIdList then
local level=UIYuFuLingZhenControl:getItemLevel(v2.itemId)
for i,attrId in ipairs(v2.randAttrIdList)do
local attrCfg=cfgHelper.get1(cfg_yufuzhenturandattrconfig_get,attrId)
local vocId=attrCfg.vocId
local vocSkillAdd=attrCfg.vocSkillAdd
local unlockLv=attrCfg.xcLevel or 1

if level>=unlockLv and vocSkillAdd then
local job=UIDiscipleModel:getDiscipleJob(guid)

if vocId==job then
if vocSkillAdd[0]then
local skillId=skills[2]
if lookup[skillId]==nil then
lookup[skillId]=vocSkillAdd[0]
else
lookup[skillId]=lookup[skillId]+vocSkillAdd[0]
end

end
if vocSkillAdd[1]then
local skillId=skills[3]
if lookup[skillId]==nil then
lookup[skillId]=vocSkillAdd[1]
else
lookup[skillId]=lookup[skillId]+vocSkillAdd[1]
end

end
end
end

end
end

end
end
end

end
end
end



local discipleguid=netData.discipleguid
local equip=vocEquipModel:getEquipByDizi(discipleguid)
if equip then
local itemguid=equip.itemguid
local itemid=equip.itemid
local enhancelv=equip.itemData and equip.itemData.enhancelv or 0
local vocId=vocEquipHelper.getEquipVocId(itemid)
local cfg=cfgHelper.get(cfg_disciplevocequipenhanceconfig_get,vocId,enhancelv)

local vocSkillAddList=cfg and cfg.vocskill
if vocSkillAddList and next(vocSkillAddList)then
for idx,addLv in pairs(vocSkillAddList)do
local skillIdx=idx+2
if jobSkillList[skillIdx]then
local skillId=jobSkillList[skillIdx]
if lookup[skillId]==nil then
lookup[skillId]=addLv
else
lookup[skillId]=lookup[skillId]+addLv
end
end
end
end
end


local lsTLookup=lingshouModel:getTraitAddSkillLookUp(guid)
if lsTLookup then
for skillId,addLv in pairs(lsTLookup)do
lookup[skillId]=lookup[skillId]or 0
lookup[skillId]=lookup[skillId]+addLv
end
lingshouModel:setAttrListDirtyXByDzGuid2(guid,lingshouAttributeType.eDzGongFa,false)
end
end

function UIDiscipleModel:setSkillLvPlusLookupDirty(guid,showFightTips)
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData==nil then return end
UIDiscipleModel:refreshSkillLvPlusLookup(guid)
UIDiscipleModel:setDiscipleAttrListDirtyX(guid,DISCIPLE_ATTRIBUTE_TYPE.eSkill,showFightTips)
end





function UIDiscipleModel:getSkillReplace(netData,skillId,jobid)
if netData~=nil then
local lookup=UIDiscipleModel:getSkillReplaceLookup(netData,jobid)
local c_skillId=lookup[skillId]

c_skillId=UIDiscipleModel:getDaoReplaceSkillId(c_skillId,skillId,netData)
if c_skillId then



return c_skillId
end
end
return skillId
end

function UIDiscipleModel:getSkillReplaceBack(netData,skillId,jobid)
if netData~=nil then
local lookup=UIDiscipleModel:getSkillReplaceLookup(netData,jobid)
for k,v in pairs(lookup)do
if skillId==v then
return k
end
end
end
return skillId
end

function UIDiscipleModel:getSkillReplaceLookup(netData,jobid)
local lookup=netData.skillReplaceLookup
if lookup==nil then
UIDiscipleModel:refreshSkillReplaceLookup(netData)
lookup=netData.skillReplaceLookup
end
return lookup
end

function UIDiscipleModel:refreshSkillReplaceLookup(netData,jobid)
if netData==nil then return end
if jobid==nil then
local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(netData)
jobid=imageInfo.job
end
local lookup={}
netData.skillReplaceLookup=lookup

local tmReplaceList=UIDiscipleModel:getTianMingEffectByType(netData,eDZTianMingEffectType.eSkillReplace,jobid)
if tmReplaceList and#tmReplaceList>0 then
for i,v in ipairs(tmReplaceList)do
lookup[v[2]]=v[3]
end
end
end

function UIDiscipleModel:setSkillReplaceLookupDirty(netData,jobid)
UIDiscipleModel:refreshSkillReplaceLookup(netData,jobid)
end



function UIDiscipleModel:checkSkillAssert(skill_list,all)
local temp={}
for skilltype,skilllist in pairs(all)do
for skillid,skilllv in pairs(skilllist)do
table.insert(temp,skillid)
end
end

for skillid,skilllv in pairs(skill_list)do
local passiveConds=cfgHelper.get2(cfg_skillconfig_get,skillid,'passiveConds')or{}
for index,id in ipairs(passiveConds)do
if id>0 then
if not table.containsValue(temp,id)then
skill_list[skillid]=nil
break
end
end
end
end
end






function UIDiscipleModel:getDaoReplaceSkillId(c_skillId,skillId,netData)
if not systemModel.isOpen(SYSTEM_DEFINE.eDaoBing)then
return c_skillId or skillId
end
local equip=equipsHelper.getEquipByDizi(netData.discipleguid,EQUIP_TYPE.eDaoBing)
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
if itemsConfig.isDaoBing(itemid)then
local itemConfig=itemsConfig.getConfig(itemid)
local skill=itemConfig.skill or{}
local curId=c_skillId or skillId
if skill[curId]then

end
return skill[curId]or curId
end
else

if not UIDiscipleModel:isMyActorDZ(netData.discipleguid)then
if netData.daobingList and netData.daobingList[1]then
local itemStruct=netData.daobingList[1]
local itemid=itemStruct.itemid
if itemsConfig.isDaoBing(itemid)then
local itemConfig=itemsConfig.getConfig(itemid)
local skill=itemConfig.skill or{}
local curId=c_skillId or skillId
if skill[curId]then

end
return skill[curId]or curId
end
end
end
end
return c_skillId or skillId
end
