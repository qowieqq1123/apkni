




function vocEquipModel:initAttrsData()
self.equipsAttrsLookup={}
self.equipsTotalAttrsLookup={}
end



function vocEquipModel:onChangeAttrsOnEquip(diziguid,itemguid,showFightTips)
local dizihandle=tostring(diziguid)
if self.equipsAttrsLookup[dizihandle]==nil then self.equipsAttrsLookup[dizihandle]={}end



local diziEquipAttrsLookup=self.equipsAttrsLookup[dizihandle]
local oldAttrsLookup=diziEquipAttrsLookup
local newAttrsLookup=vocEquipHelper.getVocEquipAllAttrsLookupByItemguid(itemguid,true)

self.equipsAttrsLookup[dizihandle]=newAttrsLookup
equipsHelper.printAttrListChange(oldAttrsLookup,newAttrsLookup,'单件职业装备：')

if UIDiscipleModel:isMyActorDZ(diziguid)then
UIDiscipleModel:setDiscipleAttrListDirtyX(diziguid,DISCIPLE_ATTRIBUTE_TYPE.eEquip,showFightTips)
UIDiscipleModel:setDiscipleAttrListDirtyX(diziguid,DISCIPLE_ATTRIBUTE_TYPE.eJingJie,showFightTips)
UIDiscipleModel:setDiscipleAttrListDirtyX(diziguid,DISCIPLE_ATTRIBUTE_TYPE.eLianTi,showFightTips)
UIDiscipleModel:setSkillLvPlusLookupDirty(diziguid)
end











end


function vocEquipModel:onChangeAttrsOnGuBao(gbId)
local itemguidList=vocEquipModel:getGongMingGbLookupByGbId(gbId)or{}
if itemguidList and next(itemguidList)then
for itemguid_str,v in pairs(itemguidList)do
local itemguid=int64.new(itemguid_str)
local equip=vocEquipModel:getEquip(itemguid)
if equip then
local diziguid=vocEquipModel:getDiziguidByItemguid(itemguid)
if diziguid then
vocEquipHelper.setEquipAttrsDirty(equip,true)
vocEquipModel:onChangeAttrsOnEquip(diziguid,itemguid)
end
else
vocEquipModel:clearGongMingGbLookupWithVocEquipItemGuid(gbId,itemguid)
end
end
end
end




function vocEquipModel:getVocEquipAttrsLookup(diziguid)
local dizihandle=tostring(diziguid)
if self.equipsAttrsLookup[dizihandle]==nil then
self.equipsAttrsLookup[dizihandle]={}
return{}
end
return self.equipsAttrsLookup[dizihandle]or{}
end



function vocEquipModel:getVocEquipJJRate(guid)
local rate=0
local equip=vocEquipModel:getEquipByDizi(guid)
if equip then
local itemid=equip.itemid
local vocId=vocEquipHelper.getEquipVocId(itemid)

local enhancelv,enhanceexp=vocEquipModel.getVocEquipStrengthenLevel(equip)


local addPercent=0
local cfg=vocEquipHelper.getStrengthenConfig(vocId,enhancelv)
if cfg and cfg.jingjie then
addPercent=cfg.jingjie
rate=rate+(addPercent/100.0)
end
end
return rate
end


function vocEquipModel:getVocEquipLTRate(guid)
local rate=0
local equip=vocEquipModel:getEquipByDizi(guid)
if equip then
local itemid=equip.itemid
local vocId=vocEquipHelper.getEquipVocId(itemid)

local enhancelv,enhanceexp=vocEquipModel.getVocEquipStrengthenLevel(equip)


local addPercent=0
local cfg=vocEquipHelper.getStrengthenConfig(vocId,enhancelv)
if cfg and cfg.lianti then
addPercent=cfg.lianti
rate=rate+(addPercent/100.0)
end
end
return rate
end


function vocEquipModel:getVocEquipAddEquipAttrsRate(guid)
local rate=0
local equip=vocEquipModel:getEquipByDizi(guid)
if equip then
local itemid=equip.itemid
local vocId=vocEquipHelper.getEquipVocId(itemid)

local enhancelv,enhanceexp=vocEquipModel.getVocEquipStrengthenLevel(equip)


local addPercent=0
local cfg=vocEquipHelper.getStrengthenConfig(vocId,enhancelv)
if cfg and cfg.equip then
addPercent=cfg.equip
rate=rate+(addPercent/100.0)
end
end
return rate
end


function vocEquipModel:getVocEquipAddDiscipleSkillLevelListEx(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local equip=vocEquipModel:getEquipByDizi(guid)
local skillAddLevelList_lookup=vocEquipModel:getVocEquipAddDiscipleSkillLevelList(netData,equip)
return skillAddLevelList_lookup
end


function vocEquipModel:getVocEquipAddDiscipleSkillLevelList(netData,equip)
local jobSkillList=UIDiscipleModel:getDiscipleJobSkilIDlList(netData)
local skillAddLevelList_lookup={}
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
if skillAddLevelList_lookup[skillId]==nil then
skillAddLevelList_lookup[skillId]=addLv
else
skillAddLevelList_lookup[skillId]=skillAddLevelList_lookup[skillId]+addLv
end
end
end
end
end
return skillAddLevelList_lookup
end