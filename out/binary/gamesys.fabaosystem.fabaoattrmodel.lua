










function fabaoModel.initAttrsData()
fabaoModel.equipsAttrsLookup={}
fabaoModel.equipsTotalAttrsLookup={}
end



function fabaoModel.onChangeAttrsOnFabao(diziguid,itemguid,showFightTips)
local dizihandle=tostring(diziguid)
if fabaoModel.equipsAttrsLookup[dizihandle]==nil then fabaoModel.equipsAttrsLookup[dizihandle]={}end
if fabaoModel.equipsTotalAttrsLookup[dizihandle]==nil then fabaoModel.equipsTotalAttrsLookup[dizihandle]={}end


local diziEquipAttrsLookup=fabaoModel.equipsAttrsLookup[dizihandle]
local itemhandle=tostring(itemguid)
local oldAttrsLookup=diziEquipAttrsLookup[itemhandle]
local newAttrsLookup=fabaoHelper.getFabaoAttrsLookupByItemguid(itemguid,true)
local changeAttrsLookup=attrListHelper.getChangeLookup(oldAttrsLookup,newAttrsLookup)
diziEquipAttrsLookup[itemhandle]=newAttrsLookup
equipsHelper.printAttrListChange(oldAttrsLookup,newAttrsLookup,'单件装备：')


local oldTotalAttrLookup=fabaoModel.equipsTotalAttrsLookup[dizihandle]
fabaoModel.equipsTotalAttrsLookup[dizihandle]=attrListHelper.concatLookup(oldTotalAttrLookup,changeAttrsLookup)
equipsHelper.printAttrListChange(oldTotalAttrLookup,fabaoModel.equipsTotalAttrsLookup[dizihandle],'所有装备：')

UIDiscipleModel:setDiscipleAttrListDirtyX(diziguid,DISCIPLE_ATTRIBUTE_TYPE.eEquip,showFightTips)
end





function fabaoModel.getFabaoAttrsLookup(diziguid)
local dizihandle=tostring(diziguid)
if fabaoModel.equipsTotalAttrsLookup[dizihandle]==nil then
fabaoModel.equipsTotalAttrsLookup[dizihandle]={}
return{}
end
return fabaoModel.equipsTotalAttrsLookup[dizihandle]or{}
end
