






function equipsHelper.isCanShowChongZhu(itemguid,warn)
if not systemModel.isOpen(SYSTEM_DEFINE.eChongZhu)then
if warn then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eChongZhu)
UIManager.error(tips)
end
return false
end
local equip=equipsHelper.getEquip(itemguid)
if not equip then
return false
end
local itemConfig=itemsConfig.getConfig(equip.itemid)
if not itemConfig.chongzhu then
return false
end

return true
end


function equipsHelper.isCanChongZhu(itemguid,warn)
local ret,errType,errArgs=equipsHelper.isCanShowChongZhu(itemguid,warn)
if not ret then
return ret,errType,errArgs
end



return true
end