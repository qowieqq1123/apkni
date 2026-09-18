




function ClothingModel:initAttrsData()
self.equipsAttrsLookup={}
self.equipsTotalAttrsLookup={}
self.equipsDiziAttrsLookup={}
self.equipsTotalDiziAttrsLookup={}
self.equipsCollectAttrsLookup={}
self.equipsTotalCollectAttrsLookup={}
end



function ClothingModel:onChangeAttrsOnEquip(diziguid,itemguid,showFightTips)
local dizihandle=tostring(diziguid)
if self.equipsAttrsLookup[dizihandle]==nil then self.equipsAttrsLookup[dizihandle]={}end
if self.equipsTotalAttrsLookup[dizihandle]==nil then self.equipsTotalAttrsLookup[dizihandle]={}end
if self.equipsDiziAttrsLookup[dizihandle]==nil then self.equipsDiziAttrsLookup[dizihandle]={}end
if self.equipsTotalDiziAttrsLookup[dizihandle]==nil then self.equipsTotalDiziAttrsLookup[dizihandle]={}end


local diziEquipAttrsLookup=self.equipsAttrsLookup[dizihandle]
local itemhandle=tostring(itemguid)
local oldAttrsLookup=diziEquipAttrsLookup[itemhandle]
local newAttrsLookup,diziAttrsLookup=ClothingHelper.getEquipAttrsLookupByItemguid(itemguid,true)
local changeAttrsLookup=attrListHelper.getChangeLookup(oldAttrsLookup,newAttrsLookup)

diziEquipAttrsLookup[itemhandle]=newAttrsLookup

local diziEquipDiziAttrsLookup=self.equipsDiziAttrsLookup[dizihandle]
local oldDiziAttrsLookup=diziEquipDiziAttrsLookup[itemhandle]
local changeDiziAttrsLookup=attrListHelper.getChangeLookup(oldDiziAttrsLookup,diziAttrsLookup)
diziEquipDiziAttrsLookup[itemhandle]=diziAttrsLookup

equipsHelper.printAttrListChange(oldAttrsLookup,newAttrsLookup,'单件时装：')


local oldTotalAttrLookup=self.equipsTotalAttrsLookup[dizihandle]
self.equipsTotalAttrsLookup[dizihandle]=attrListHelper.concatLookup(oldTotalAttrLookup,changeAttrsLookup)

equipsHelper.printAttrListChange(oldTotalAttrLookup,self.equipsTotalAttrsLookup[dizihandle],'所有时装：')

local oldTotalDiziAttrLookup=self.equipsTotalDiziAttrsLookup[dizihandle]
self.equipsTotalDiziAttrsLookup[dizihandle]=attrListHelper.concatLookup(oldTotalDiziAttrLookup,changeDiziAttrsLookup)

UIDiscipleModel:setDiscipleAttrListDirtyX(diziguid,DISCIPLE_ATTRIBUTE_TYPE.eEquip,showFightTips)

local netData=UIDiscipleModel:getDiscipleData(diziguid)
if netData==nil then return end
local clothing_equip=ClothingModel:getEquipByDizi(diziguid)
if clothing_equip then
netData.dressList={clothing_equip}
else
netData.dressList=nil
end
UIDiscipleModel.calculationDiscipleImageBase(netData)

UIDiscipleModel:setDiscipleImageDirty(netData)
end

function ClothingModel:onChangeCollectStarOnStarUp(type2,newStar,showFightTips)
local lookup=UIDiscipleModel:getAllDiscipleDataX()

if lookup then
for k,v in pairs(lookup)do
local netData=v.netData.net
local dzguid=netData.discipleguid

ClothingModel:onChangeDiziCollectStarOnStarUp(dzguid,type2,newStar,showFightTips)
end
end
end

function ClothingModel:onChangeDiziCollectStarOnStarUp(dzguid,type2,newStar,showFightTips)

local cfg=cfgHelper.get(cfg_discipledresstypeconfig_get,type2)

local voc=cfg.voc

local needId=cfg.disciple

local diziid=UIDiscipleModel:getDiscipleID(dzguid)

local dizihandle=tostring(dzguid)
if self.equipsTotalCollectAttrsLookup[dizihandle]==nil then self.equipsTotalCollectAttrsLookup[dizihandle]={}end

self.equipsTotalCollectAttrsLookup[dizihandle][type2]={}

local isEnough=false

if voc==UIDiscipleModel:getDiscipleJob(dzguid)then
isEnough=true
local newAtttrsLookup=ClothingHelper.getCollectAttrLookupByType2(type2,newStar)

self.equipsTotalCollectAttrsLookup[dizihandle][type2]=attrListHelper.concatLookup(self.equipsTotalCollectAttrsLookup[dizihandle][type2],newAtttrsLookup)
end

if needId and diziid==needId then
isEnough=true
local newAtttrsLookup=ClothingHelper.getCollectDiziAttrLookupByType2(type2)
self.equipsTotalCollectAttrsLookup[dizihandle][type2]=attrListHelper.concatLookup(self.equipsTotalCollectAttrsLookup[dizihandle][type2],newAtttrsLookup)

end

if isEnough then
UIDiscipleModel:setDiscipleAttrListDirtyX(dzguid,DISCIPLE_ATTRIBUTE_TYPE.eEquip,showFightTips)
end
end

function ClothingModel:refreshSpDiscipleClothingCollectAttrs(dzguid)
local collectData=ClothingModel:getClothingCollectData()
if collectData then
local dzguidStr=tostring(dzguid)
self.equipsTotalCollectAttrsLookup[dzguidStr]={}
local dzId=UIDiscipleModel:getDiscipleID(dzguid)
local dzVoc=UIDiscipleModel:getDiscipleJob(dzguid)
for type2,newStar in pairs(collectData)do
self.equipsTotalCollectAttrsLookup[dzguidStr][type2]={}
local cfg=cfgHelper.get(cfg_discipledresstypeconfig_get,type2)
local voc=cfg.voc
local needId=cfg.disciple
if voc==dzVoc then
local newAtttrsLookup=ClothingHelper.getCollectAttrLookupByType2(type2,newStar)
self.equipsTotalCollectAttrsLookup[dzguidStr][type2]=attrListHelper.concatLookup(self.equipsTotalCollectAttrsLookup[dzguidStr][type2],newAtttrsLookup)
end

if needId and dzId==needId then
local newAtttrsLookup=ClothingHelper.getCollectDiziAttrLookupByType2(type2)
self.equipsTotalCollectAttrsLookup[dzguidStr][type2]=attrListHelper.concatLookup(self.equipsTotalCollectAttrsLookup[dzguidStr][type2],newAtttrsLookup)
end
end
UIDiscipleModel:setDiscipleAttrListDirtyX(dzguid,DISCIPLE_ATTRIBUTE_TYPE.eEquip)
end
end




function ClothingModel:getClothingAttrsLookup(diziguid)
local dizihandle=tostring(diziguid)
if self.equipsTotalAttrsLookup[dizihandle]==nil then
self.equipsTotalAttrsLookup[dizihandle]={}
return{}
end
return self.equipsTotalAttrsLookup[dizihandle]or{}
end


function ClothingModel:getClothingDiziAttrsLookup(diziguid)
local dizihandle=tostring(diziguid)
if self.equipsTotalDiziAttrsLookup[dizihandle]==nil then
self.equipsTotalDiziAttrsLookup[dizihandle]={}
return{}
end
return self.equipsTotalDiziAttrsLookup[dizihandle]or{}
end

function ClothingModel:getClothingCollectAttrsLookup(diziguid)
local dizihandle=tostring(diziguid)
if self.equipsTotalCollectAttrsLookup[dizihandle]==nil then
self.equipsTotalCollectAttrsLookup[dizihandle]={}
return{}
end
local lookUp={}
for type2,v in pairs(self.equipsTotalCollectAttrsLookup[dizihandle])do
lookUp=attrListHelper.concatLookup(lookUp,v)
end
return lookUp
end
