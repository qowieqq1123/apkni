











function equipsModel.initAttrsData()
equipsModel.equipsAttrsLookup={}
equipsModel.equipsTotalAttrsLookup={}
equipsModel.equipSuitAttrLookup={}
end






function equipsModel.onChangeAttrsOnJinglianEquip(diziguid,itemguid,isInit)
local dizihandle=tostring(diziguid)
if equipsModel.equipsAttrsLookup[dizihandle]==nil then equipsModel.equipsAttrsLookup[dizihandle]={}end
if equipsModel.equipsTotalAttrsLookup[dizihandle]==nil then equipsModel.equipsTotalAttrsLookup[dizihandle]={}end


local diziEquipAttrsLookup=equipsModel.equipsAttrsLookup[dizihandle]
local itemhandle=tostring(itemguid)
local oldAttrsLookup=diziEquipAttrsLookup[itemhandle]
local newAttrsLookup=equipsHelper.getEquipAttrsLookupByItemguid(itemguid,true)
local changeAttrsLookup=attrListHelper.getChangeLookup(oldAttrsLookup,newAttrsLookup)
diziEquipAttrsLookup[itemhandle]=newAttrsLookup
equipsHelper.printAttrListChange(oldAttrsLookup,newAttrsLookup,'单件装备：')


local oldTotalAttrLookup=equipsModel.equipsTotalAttrsLookup[dizihandle]
equipsModel.equipsTotalAttrsLookup[dizihandle]=attrListHelper.concatLookup(oldTotalAttrLookup,changeAttrsLookup)
equipsHelper.printAttrListChange(oldTotalAttrLookup,equipsModel.equipsTotalAttrsLookup[dizihandle],'所有装备：')


equipsModel.onSuitAttrChange(diziguid)
if UIDiscipleModel:isMyActorDZ(diziguid)then
UIDiscipleModel:setDiscipleAttrListDirtyX(diziguid,DISCIPLE_ATTRIBUTE_TYPE.eEquip,not isInit)
end
end


function equipsModel.onSuitAttrChange(diziguid)
local dizihandle=tostring(diziguid)
local attrList=equipsHelper.getAllSuitAttr(diziguid)
local newAttrsLookup=attrListHelper.tramsformToLookup(attrList)
local oldAttrsLookup=equipsModel.equipSuitAttrLookup[dizihandle]
equipsModel.equipSuitAttrLookup[dizihandle]=newAttrsLookup

equipsHelper.printAttrListChange(oldAttrsLookup,newAttrsLookup,'套装：')
end




function equipsModel.getEquipAttrsLookup(diziguid)
local equipAttrs=equipsModel.getEquipTotalSingleAttrsLookup(diziguid)
local suitAttrs=equipsModel.getSuitAttrsLookup(diziguid)
return attrListHelper.concatLookup(equipAttrs,suitAttrs)
end


function equipsModel.getEquipTotalSingleAttrsLookup(diziguid)
local dizihandle=tostring(diziguid)
if equipsModel.equipsTotalAttrsLookup[dizihandle]==nil then
equipsModel.equipsTotalAttrsLookup[dizihandle]={}
return{}
end
return equipsModel.equipsTotalAttrsLookup[dizihandle]or{}
end

function equipsModel.getSuitAttrsLookup(diziguid)
local dizihandle=tostring(diziguid)
if equipsModel.equipSuitAttrLookup[dizihandle]==nil then
equipsModel.equipSuitAttrLookup[dizihandle]={}
return{}
end
return equipsModel.equipSuitAttrLookup[dizihandle]or{}
end


function equipsModel.getEquipsLookupAttrsBydiziguid(diziguid,itemguid)
local dizihandle=tostring(diziguid)
if equipsModel.equipsAttrsLookup[dizihandle]==nil then equipsModel.equipsAttrsLookup[dizihandle]={}end
local attrList=equipsModel.equipsAttrsLookup[dizihandle]
local itemhandle=tostring(itemguid)
return attrList[itemhandle]or{}
end


function equipsModel.onChangeAttrsOnJinglianEquipbyFulu(diziguid,isInit)
for equipType=1,4 do
local equip=equipsModel.getEquipByDizi(diziguid,equipType)
if equip then
local itemguid=equip.itemguid
local dizihandle=tostring(diziguid)
if equipsModel.equipsAttrsLookup[dizihandle]==nil then equipsModel.equipsAttrsLookup[dizihandle]={}end
if equipsModel.equipsTotalAttrsLookup[dizihandle]==nil then equipsModel.equipsTotalAttrsLookup[dizihandle]={}end


local diziEquipAttrsLookup=equipsModel.equipsAttrsLookup[dizihandle]
local itemhandle=tostring(itemguid)
local oldAttrsLookup=diziEquipAttrsLookup[itemhandle]
local newAttrsLookup=equipsHelper.getEquipAttrsLookupByItemguid(itemguid,true)
local changeAttrsLookup=attrListHelper.getChangeLookup(oldAttrsLookup,newAttrsLookup)
diziEquipAttrsLookup[itemhandle]=newAttrsLookup
equipsHelper.printAttrListChange(oldAttrsLookup,newAttrsLookup,'单件装备：')


local oldTotalAttrLookup=equipsModel.equipsTotalAttrsLookup[dizihandle]
equipsModel.equipsTotalAttrsLookup[dizihandle]=attrListHelper.concatLookup(oldTotalAttrLookup,changeAttrsLookup)
equipsHelper.printAttrListChange(oldTotalAttrLookup,equipsModel.equipsTotalAttrsLookup[dizihandle],'所有装备：')


equipsModel.onSuitAttrChange(diziguid)
if UIDiscipleModel:isMyActorDZ(diziguid)then
UIDiscipleModel:setDiscipleAttrListDirtyX(diziguid,DISCIPLE_ATTRIBUTE_TYPE.eEquip,not isInit)
end
end
end
end


function equipsModel.onChangeAttrsOnChangeVocEquip(diziguid,itemguid,isInit)
local dizihandle=tostring(diziguid)
if equipsModel.equipsAttrsLookup[dizihandle]==nil then equipsModel.equipsAttrsLookup[dizihandle]={}end
if equipsModel.equipsTotalAttrsLookup[dizihandle]==nil then equipsModel.equipsTotalAttrsLookup[dizihandle]={}end


local diziEquipAttrsLookup=equipsModel.equipsAttrsLookup[dizihandle]
local itemhandle=tostring(itemguid)
local oldAttrsLookup=diziEquipAttrsLookup[itemhandle]
local newAttrsLookup=equipsHelper.getEquipAttrsLookupByItemguid(itemguid,true)
local changeAttrsLookup=attrListHelper.getChangeLookup(oldAttrsLookup,newAttrsLookup)
diziEquipAttrsLookup[itemhandle]=newAttrsLookup
equipsHelper.printAttrListChange(oldAttrsLookup,newAttrsLookup,'单件装备：')


local oldTotalAttrLookup=equipsModel.equipsTotalAttrsLookup[dizihandle]
equipsModel.equipsTotalAttrsLookup[dizihandle]=attrListHelper.concatLookup(oldTotalAttrLookup,changeAttrsLookup)
equipsHelper.printAttrListChange(oldTotalAttrLookup,equipsModel.equipsTotalAttrsLookup[dizihandle],'所有装备：')


equipsModel.onSuitAttrChange(diziguid)
if UIDiscipleModel:isMyActorDZ(diziguid)then
UIDiscipleModel:setDiscipleAttrListDirtyX(diziguid,DISCIPLE_ATTRIBUTE_TYPE.eEquip,not isInit)
end
end