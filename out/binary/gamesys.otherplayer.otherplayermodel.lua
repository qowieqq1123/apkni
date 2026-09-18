







otherPlayerModel={}

local actorDataLookup
local dzDataLookup

function otherPlayerModel:InitData()
actorDataLookup={}
dzDataLookup={}
self.defTeamsLookup={}
self.xianjieInfoLookup={}
end

function otherPlayerModel:clearData()
actorDataLookup=nil
dzDataLookup=nil
self.defTeamsLookup=nil
self.xianjieInfoLookup=nil
end

function otherPlayerModel:addActorData(actorData)
if actorData==nil then return end


local dzList=actorData.dzList
actorData.dzList=nil
local dzDataSet={}
actorData.dzDataSet=dzDataSet

local viewDatas={}
if dzList~=nil then
for i,vData in ipairs(dzList)do
local guidStr=vData.discipleguidStr
if guidStr==nil then
guidStr=tostring(vData.discipleguid)
vData.discipleguidStr=guidStr
end

vData.fightValNum=mathHelper.int64_to_number(vData.fightVal)
vData.fightValNum_get=function(self_)




return self_.fightValNum

end

vData.clothingId=vData.dressid
vData.idx=i
viewDatas[guidStr]=vData
end
end
dzDataSet.viewDatas=viewDatas
dzDataSet.datas=nil

actorData.time=gameUtilityModel.getServerShortTime()


local actorId=actorData.actorId
if actorData.actorIdStr==nil then
actorData.actorIdStr=tostring(actorId)
end
local actorIdStr=actorData.actorIdStr
local isNew=true
local old_dzDataList=nil
if actorDataLookup[actorIdStr]~=nil then
isNew=false
old_dzDataList=actorDataLookup[actorIdStr].dzDataSet.datas
end
actorDataLookup[actorIdStr]=actorData


if old_dzDataList~=nil then
for k,dzData in pairs(old_dzDataList)do
local baseData=dzData.base
local guid=baseData.discipleguid
if not UIDiscipleModel:isMyActorDZ(guid)then
local fightEquipList=baseData.fightEquipList or{}
for i,v in ipairs(fightEquipList)do
watchModel.removeItem(v.itemguid)
end
local fabaoList=baseData.fabaoList or{}
for i,v in ipairs(fabaoList)do
watchModel.removeItem(v.itemguid)
end
local daobingList=baseData.daobingList or{}
for i,v in ipairs(daobingList)do
watchModel.removeItem(v.itemguid)
end
local vocequipList=baseData.vocequipList or{}
for i,v in ipairs(vocequipList)do
watchModel.removeItem(v.itemguid)
end
UIFuLuFangModel:removeLookup(guid)
end
end
old_dzDataList=nil
end

return isNew
end

function otherPlayerModel:getActorData(actorId)
local actorIdStr=tostring(actorId)
return actorDataLookup[actorIdStr]
end








function otherPlayerModel:addDZData(actorId,dzData,bindActor,isSave)
if dzData==nil then return end
if bindActor==nil then
bindActor=true
end
if isSave==nil then
isSave=true
end

UIDiscipleController.changeDiscipleNetData(dzData.base)
dzData.actorId=actorId
local baseData=dzData.base
local discipleguidStr=tostring(baseData.discipleguid)
dzData.discipleguidStr=discipleguidStr

local fightValNum=mathHelper.int64_to_number(baseData.fightvalue)






dzData.fightValNum=fightValNum
dzData.fightValNum_get=function(self_)
local disguid=self_.base.discipleguid
if self_.ismy and UIDiscipleModel:isMyActorDZ(disguid)then
return UIDiscipleModel:getDiscipleFightValue(disguid)
else
return self_.fightValNum
end
end

local post=UIDiscipleModel:getDisciplePostEX(baseData)
dzData.color=UIDiscipleModel:getDiscipleBaseAttrSum2ColorEx(post,baseData.attrList)

if dzData.lingshouList~=nil then
for i,lsData in ipairs(dzData.lingshouList)do
lingshouController.changeLSNetData(lsData)
lingshouModel:initAttrLookup_otherDz(lsData,dzData.base)
end
end

local vocEquipItem
if dzData.equipLookup==nil then
local equipLookup={}
local fightEquipList=baseData.fightEquipList or{}
for i,v in ipairs(fightEquipList)do
local itemid=v.itemid
local itemconfig=itemsConfig.getConfig(itemid)
local equipType=itemconfig.type1
equipLookup[equipType]=v
end
local fabaoList=baseData.fabaoList or{}
equipLookup[EQUIP_TYPE.eFabao]=fabaoList[1]

local daobingList=baseData.daobingList or{}
equipLookup[EQUIP_TYPE.eDaoBing]=daobingList[1]

local clothingList=baseData.dressList or{}
equipLookup[EQUIP_TYPE.eShiZhuang]=clothingList[1]

local vocequipList=baseData.vocequipList or{}
equipLookup[EQUIP_TYPE.eVocEquip]=vocequipList[1]
vocEquipItem=vocequipList[1]

dzData.equipLookup=equipLookup
end

if bindActor then
local actorData=otherPlayerModel:getActorData(actorId)
if actorData~=nil then
local datas=actorData.dzDataSet.datas
if datas==nil then
datas={}
actorData.dzDataSet.datas=datas
end
datas[discipleguidStr]=dzData
end
end

if dzData.specialityList then
UIDiscipleModel.refreshDiscipleSpecialityLookup(dzData)
end

if isSave then
dzDataLookup[discipleguidStr]=dzData
end

local isSelfDZ=playerModel:checkActorId(actorId)and UIDiscipleModel:isMyActorDZ(baseData.discipleguid)

if not isSelfDZ then
local fightEquipList=baseData.fightEquipList or{}
for i,v in ipairs(fightEquipList)do
watchModel.setItem(v)
end
local fabaoList=baseData.fabaoList or{}
for i,v in ipairs(fabaoList)do
watchModel.setItem(v)
end
local daobingList=baseData.daobingList or{}
for i,v in ipairs(daobingList)do
watchModel.setItem(v)
end

local vocequipList=baseData.vocequipList or{}
for i,v in ipairs(vocequipList)do
watchModel.setItem(v)
end

local shizhuangItem=dzData.equipLookup[EQUIP_TYPE.eShiZhuang]
if shizhuangItem then
watchModel.setItem(shizhuangItem)
end

UIFuLuFangModel:addFuBaoData(baseData)
end


local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(baseData)
local skills=cfgHelper.get3(cfg_disciplevocationconfig_get,imageInfo.job,'skills',baseData.vocsgidx)

if not isSelfDZ then
local temp0={}
local temp1={}
local temp2={}
if dzData.tdsskilllistlen>0 then
for i,v in ipairs(dzData.tdsskillList)do
local type=v.param_1
local value=v.param_2
local skillIdx=tiandaoshuModel:convertSkillType(type)
local skillId=skills[skillIdx]
temp1[skillId]=value
temp0[skillId]=(temp0[skillId]or 0)+value
end
end
if vocEquipItem then
temp2=vocEquipModel:getVocEquipAddDiscipleSkillLevelList(baseData,vocEquipItem)
for skillId,lv in pairs(temp2)do
temp0[skillId]=(temp0[skillId]or 0)+lv
end
end

dzData.skillLvPlusLookupExtra={}
dzData.skillLvPlusLookupExtra["tiandaoshu"]=temp1
dzData.skillLvPlusLookupExtra["vocequip"]=temp2
dzData.skillLvPlusLookup=temp0

else
local temp={}
local temp1={}
local tdsAdds=tiandaoshuModel:getVocSkillList(imageInfo.job)
if next(tdsAdds)then
for i,v in pairs(tdsAdds)do
local skillIdx=tiandaoshuModel:convertSkillType(i)
local skillId=skills[skillIdx]
temp[skillId]=v
end
end
if vocEquipItem then
temp1=vocEquipModel:getVocEquipAddDiscipleSkillLevelList(baseData,vocEquipItem)
end
dzData.skillLvPlusLookupExtra={}
dzData.skillLvPlusLookupExtra["tiandaoshu"]=temp
dzData.skillLvPlusLookupExtra["vocequip"]=temp1
end

return dzData
end

function otherPlayerModel:removeDZData(disguid)
local discipleguidStr=tostring(disguid)
local dzData=dzDataLookup[discipleguidStr]
if dzData then

if not UIDiscipleModel:isMyActorDZ(disguid)then
local baseData=dzData.base
local fightEquipList=baseData.fightEquipList or{}
for i,v in ipairs(fightEquipList)do
watchModel.removeItem(v.itemguid)
end
local fabaoList=baseData.fabaoList or{}
for i,v in ipairs(fabaoList)do
watchModel.removeItem(v.itemguid)
end
local daobingList=baseData.daobingList or{}
for i,v in ipairs(daobingList)do
watchModel.removeItem(v.itemguid)
end
local vocequipList=baseData.vocequipList or{}
for i,v in ipairs(vocequipList)do
watchModel.removeItem(v.itemguid)
end
local shizhuangItem=dzData.equipLookup[EQUIP_TYPE.eShiZhuang]
if shizhuangItem then
watchModel.removeItem(shizhuangItem.itemguid)
end
UIFuLuFangModel:removeLookup(disguid)
end
dzDataLookup[discipleguidStr]=nil
end
end

function otherPlayerModel:getDZData(disguid)
local discipleguidStr=tostring(disguid)
return dzDataLookup[discipleguidStr]
end

function otherPlayerModel:getDZBaseData(disguid)
local discipleguidStr=tostring(disguid)
local dzData=dzDataLookup[discipleguidStr]
if dzData then
return dzData.base
end
end

function otherPlayerModel:getDZBaseDataByStr(strGuid)
local discipleguidStr=strGuid
local dzData=dzDataLookup[discipleguidStr]
if dzData then
return dzData.base
end
end

function otherPlayerModel:getDZLingShouData(disguid)
local discipleguidStr=tostring(disguid)
local dzData=dzDataLookup[discipleguidStr]
if dzData then
local lingshouList=dzData.lingshouList
if lingshouList~=nil and#lingshouList>0 then
local lsData=lingshouList[1]
if lsData then
lsData.isOther=true
end
return lsData
end
end
return nil
end

function otherPlayerModel:getDZEquipData(disguid,equipType)
local discipleguidStr=tostring(disguid)
local dzData=dzDataLookup[discipleguidStr]
if dzData then
local equipLookup=dzData.equipLookup
if equipLookup~=nil then
return equipLookup[equipType]
end
end
return nil
end

function otherPlayerModel:getgetDZEquipDataEx(dzData,equipType)
local equipLookup=dzData.equipLookup
if equipLookup~=nil then
return equipLookup[equipType]
end
return nil
end


function otherPlayerModel.getEquipSuit(diziguid,suitid)
local discipleguidStr=tostring(diziguid)
local dzData=dzDataLookup[discipleguidStr]
local temp={}
if dzData then
local equipLookup=dzData.equipLookup
if equipLookup~=nil then
for equipType,equip in pairs(equipLookup)do
local itemData=equip.itemData or{}
if itemData.suitid==suitid then
temp[#temp+1]=equip.itemguid
end
end
end

end
return temp
end

function otherPlayerModel:getDZLingShouData2(dzData)
if dzData then
local lingshouList=dzData.lingshouList
if lingshouList~=nil and#lingshouList>0 then
return lingshouList[1]
end
end
return nil
end

function otherPlayerModel:getSkillLvPlusLookup(diziguid)
local discipleguidStr=tostring(diziguid)
local dzData=dzDataLookup[discipleguidStr]
if dzData then

return dzData.skillLvPlusLookup
end
return nil
end

function otherPlayerModel:getSkillLvPlusLookupExtra(diziguid,extraStr)
local discipleguidStr=tostring(diziguid)
local dzData=dzDataLookup[discipleguidStr]
if dzData then
if extraStr then
return dzData.skillLvPlusLookupExtra[extraStr]
else
return dzData.skillLvPlusLookupExtra
end
end
return nil
end


function otherPlayerModel.discipleStruct_to_discipleStruct3(netData)
local guid=netData.discipleguid
local dzData={}

local baseData={}
dzData.base=baseData


local fightValNum=UIDiscipleModel:getDiscipleFightValue(guid)

baseData.discipleguid=guid
baseData.disciplename=netData.disciplename
baseData.discipledata=netData.discipledata
baseData.discipleimage=netData.discipleimage
baseData.pos=netData.pos
baseData.fightvalue=fightValNum
baseData.jingjielv=netData.jingjielv
baseData.liantilv=netData.liantilv
baseData.fightequiplistlen=netData.fightequiplistlen
baseData.fightEquipList=table.deepCopy(netData.fightEquipList)
baseData.livingequiplistlen=netData.livingequiplistlen
baseData.livingEquipList=table.deepCopy(netData.livingEquipList)
baseData.attrList=table.deepCopy(netData.attrList)
baseData.specialitylistlen=netData.specialitylistlen
baseData.specialityList=table.deepCopy(netData.specialityList)
baseData.proskilllistlen=netData.proskilllistlen
baseData.proskillList=table.deepCopy(netData.proskillList_)
baseData.gongfalistlen=netData.gongfalistlen
baseData.gongfaList=table.deepCopy(netData.gongfaList)
baseData.gongfaidList=table.deepCopy(netData.gongfaidList)
baseData.fabaolistlen=netData.fabaolistlen
baseData.fabaoList=table.deepCopy(netData.fabaoList)
baseData.daobinglistlen=netData.daobinglistlen
baseData.daobingList=table.deepCopy(netData.daobingList)
baseData.vocequiplistlen=netData.vocequiplistlen
baseData.vocequipList=table.deepCopy(netData.vocequipList)
baseData.lingshou_guid=netData.lingshou_guid
baseData.vocsgidx=netData.vocsgidx
baseData.tmlv=netData.tmlv
baseData.tmlistlen=netData.tmlistlen
baseData.tmList=table.deepCopy(netData.tmList)
baseData.tmcflistlen=netData.tmcflistlen
baseData.tmcfList=table.deepCopy(netData.tmcfList)
baseData.id=netData.id
baseData.varysrid=netData.varysrid
baseData.disguise=netData.disguise

baseData.ismy=true


local t_attrList=UIDiscipleModel:getDiscipleMultipleAttrList(guid)
local attrList={}
for i,v in ipairs(t_attrList)do
table.insert(attrList,{param_1=v[1],param_2=v[2]})
end


table.insert(attrList,{param_1=eAttributeTypeEx.eFight,param_2=fightValNum})

dzData.attrList=attrList
dzData.attrListLen=#attrList


if baseData.lingshou_guid then
local ls_res_data=lingshouModel:getLingShouData_res(baseData.lingshou_guid)
if ls_res_data then
local list={}
list[1]=ls_res_data
dzData.lingshouList=list
dzData.lingshouListLen=#list
end
end

return dzData
end

function otherPlayerModel.discipleStruct_to_discipleStruct3_list(guid_list)
local list={}
for i,guid in ipairs(guid_list)do
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData then
local dzData=otherPlayerModel.discipleStruct_to_discipleStruct3(netData)
table.insert(list,dzData)
end
end
return list
end


function otherPlayerModel.detailDisciple_to_discipleStruct3(baseData)
local dzData={}
dzData.base=baseData
baseData.flag=nil
dzData.attrListLen=baseData.dzAttrListLen
dzData.attrList=baseData.dzAttrList
dzData.lingshouListLen=baseData.lingshouListLen
dzData.lingshouList=baseData.lingshouList
dzData.tdsskilllistlen=baseData.tdsskilllistlen
dzData.tdsskillList=baseData.tdsskillList
baseData.dzAttrListLen=nil
baseData.dzAttrList=nil
baseData.lingshouListLen=nil
baseData.lingshouList=nil
baseData.tdsskilllistlen=nil
baseData.tdsskillList=nil
return dzData
end

function otherPlayerModel.detailDisciple_to_discipleStruct3_noClear(baseData)
local dzData={}
dzData.base=baseData
baseData.flag=nil
dzData.attrListLen=baseData.dzAttrListLen
dzData.attrList=baseData.dzAttrList
dzData.lingshouListLen=baseData.lingshouListLen
dzData.lingshouList=baseData.lingshouList
dzData.tdsskilllistlen=baseData.tdsskilllistlen
dzData.tdsskillList=baseData.tdsskillList


local vocEquipItem
if dzData.equipLookup==nil then
local equipLookup={}
local fightEquipList=baseData.fightEquipList or{}
for i,v in ipairs(fightEquipList)do
local itemid=v.itemid
local itemconfig=itemsConfig.getConfig(itemid)
local equipType=itemconfig.type1
equipLookup[equipType]=v
end
local fabaoList=baseData.fabaoList or{}
equipLookup[EQUIP_TYPE.eFabao]=fabaoList[1]

local daobingList=baseData.daobingList or{}
equipLookup[EQUIP_TYPE.eDaoBing]=daobingList[1]

local clothingList=baseData.dressList or{}
equipLookup[EQUIP_TYPE.eShiZhuang]=clothingList[1]

local vocequipList=baseData.vocequipList or{}
equipLookup[EQUIP_TYPE.eVocEquip]=vocequipList[1]
vocEquipItem=vocequipList[1]

dzData.equipLookup=equipLookup
end


if dzData.specialityList then
UIDiscipleModel.refreshDiscipleSpecialityLookup(dzData)
end

local isSelfDZ=false





























local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(baseData)
local skills=cfgHelper.get3(cfg_disciplevocationconfig_get,imageInfo.job,'skills',baseData.vocsgidx)

if not isSelfDZ then
local temp0={}
local temp1={}
local temp2={}
if dzData.tdsskilllistlen>0 then
for i,v in ipairs(dzData.tdsskillList)do
local type=v.param_1
local value=v.param_2
local skillIdx=tiandaoshuModel:convertSkillType(type)
local skillId=skills[skillIdx]
temp1[skillId]=value
temp0[skillId]=(temp0[skillId]or 0)+value
end
end
if vocEquipItem then
temp2=vocEquipModel:getVocEquipAddDiscipleSkillLevelList(baseData,vocEquipItem)
for skillId,lv in pairs(temp2)do
temp0[skillId]=(temp0[skillId]or 0)+lv
end
end

dzData.skillLvPlusLookupExtra={}
dzData.skillLvPlusLookupExtra["tiandaoshu"]=temp1
dzData.skillLvPlusLookupExtra["vocequip"]=temp2
dzData.skillLvPlusLookup=temp0

else
local temp={}
local temp1={}
local tdsAdds=tiandaoshuModel:getVocSkillList(imageInfo.job)
if next(tdsAdds)then
for i,v in pairs(tdsAdds)do
local skillIdx=tiandaoshuModel:convertSkillType(i)
local skillId=skills[skillIdx]
temp[skillId]=v
end
end
if vocEquipItem then
temp1=vocEquipModel:getVocEquipAddDiscipleSkillLevelList(baseData,vocEquipItem)
end
dzData.skillLvPlusLookupExtra={}
dzData.skillLvPlusLookupExtra["tiandaoshu"]=temp
dzData.skillLvPlusLookupExtra["vocequip"]=temp1
end

local discipleguidStr=tostring(baseData.discipleguid)
dzDataLookup[discipleguidStr]=dzData

return dzData
end

function otherPlayerModel.detailDisciple_dzAttrList_int_to_int64(dzAttrList)
if dzAttrList~=nil then
for i,v in ipairs(dzAttrList)do
otherPlayerModel.detailDisciple_dzAttr_int_to_int64(v)
end
end
end

function otherPlayerModel.detailDisciple_dzAttr_int_to_int64(dzAttr)
if dzAttr.param_2~=nil then
dzAttr.param_2=tonumber(tostring(dzAttr.param_2))
end
end