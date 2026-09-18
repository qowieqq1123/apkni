
function equipsModel:onDianHuaByEquip(equip,reveal_times)
equip.itemData.reveal_times=reveal_times
equipsHelper.setEquipAttrsDirty(equip,true)
end

function equipsModel:onDianHuaByDZ(dzguid,equipType,reveal_times)
local equip=equipsModel.getEquipByDizi(dzguid,equipType)
local itemguid=equip.itemguid
self:onDianHuaByEquip(equip,reveal_times)
equipsModel.equips[tostring(itemguid)]=equip
equipsModel.onChangeAttrsOnJinglianEquip(dzguid,itemguid)
end

function equipsModel:onUnDianHuaByEquip(equip)
equip.itemData.reveal_times=0
equipsHelper.setEquipAttrsDirty(equip,true)
end

function equipsModel:onUnDianHuaByDZ(dzguid,equipType)
local equip=equipsModel.getEquipByDizi(dzguid,equipType)
if equip==nil then return end
local itemguid=equip.itemguid
self:onUnDianHuaByEquip(equip)
equipsModel.equips[tostring(itemguid)]=equip
equipsModel.onChangeAttrsOnJinglianEquip(dzguid,itemguid)
end

function equipsModel:getDianHuaCntByDZ(dzguid,equipType)
local equip=equipsModel.getEquipByDizi(dzguid,equipType)
if equip==nil then return 0 end
return equipsModel:getDianHuaCnt(equip)
end

function equipsModel:getDianHuaCnt(equip)
if equip.itemData==nil then return 0 end
return equip.itemData.reveal_times or 0
end

function equipsModel:hasDianHuaCnt(equip)
return equipsModel:getDianHuaCnt(equip)>0
end