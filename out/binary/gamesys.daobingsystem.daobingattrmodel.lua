




function daobingModel:initAttrsData()
self.equipsAttrsLookup={}
self.equipsTotalAttrsLookup={}
end



function daobingModel:onChangeAttrsOnEquip(diziguid,itemguid,showFightTips)
local dizihandle=tostring(diziguid)
if self.equipsAttrsLookup[dizihandle]==nil then self.equipsAttrsLookup[dizihandle]={}end
if self.equipsTotalAttrsLookup[dizihandle]==nil then self.equipsTotalAttrsLookup[dizihandle]={}end


local diziEquipAttrsLookup=self.equipsAttrsLookup[dizihandle]
local itemhandle=tostring(itemguid)
local oldAttrsLookup=diziEquipAttrsLookup[itemhandle]
local newAttrsLookup=daobingHelper.getEquipAttrsLookupByItemguid(itemguid,true)
local changeAttrsLookup=attrListHelper.getChangeLookup(oldAttrsLookup,newAttrsLookup)
diziEquipAttrsLookup[itemhandle]=newAttrsLookup
equipsHelper.printAttrListChange(oldAttrsLookup,newAttrsLookup,'单件道兵：')


local oldTotalAttrLookup=self.equipsTotalAttrsLookup[dizihandle]
self.equipsTotalAttrsLookup[dizihandle]=attrListHelper.concatLookup(oldTotalAttrLookup,changeAttrsLookup)
equipsHelper.printAttrListChange(oldTotalAttrLookup,self.equipsTotalAttrsLookup[dizihandle],'所有道兵：')

UIDiscipleModel:setDiscipleAttrListDirtyX(diziguid,DISCIPLE_ATTRIBUTE_TYPE.eEquip,showFightTips)
end

function daobingModel:refreshAllDaoBingAttrsLookup()
for dizihandle,diziEquipAttrsLookup in pairs(self.equipsAttrsLookup)do
local diziguid=int64.new(dizihandle)
for itemhandle,lookup in pairs(diziEquipAttrsLookup)do
local itemguid=int64.new(itemhandle)
daobingModel:onChangeAttrsOnEquip(diziguid,itemguid)
end
end
end




function daobingModel:getDaoBingAttrsLookup(diziguid)
local dizihandle=tostring(diziguid)
if self.equipsTotalAttrsLookup[dizihandle]==nil then
self.equipsTotalAttrsLookup[dizihandle]={}
return{}
end
return self.equipsTotalAttrsLookup[dizihandle]or{}
end
