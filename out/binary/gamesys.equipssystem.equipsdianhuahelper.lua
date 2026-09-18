function equipsHelper.getDianHuaCnt(itemguid)
local equip=equipsHelper.getEquip(itemguid)
if equip==nil then return 0 end
return equipsModel:getDianHuaCnt(equip)
end

function equipsHelper.hasDianHuaCnt(itemguid)
return equipsHelper.getDianHuaCnt(itemguid)>0
end

function equipsHelper.isCanDianHua(itemguid)
if not systemModel.isOpen(SYSTEM_DEFINE.eEquipReveal)then return false end
local equip=equipsHelper.getEquip(itemguid)
if equip==nil then return false end
if equipsHelper.hasDianHuaCnt(itemguid)then return false end
local cfg=cfgHelper.getdef(cfg_equiprevealconfig)
local minStage=cfg.min_equip_stage
local minColor=cfg.min_equip_color
local itemCfg=itemsConfig.getConfig(equip.itemid)
if itemCfg.stage<minStage then return false end
if itemCfg.color<minColor then return false end
return true
end

function equipsHelper.isCanResetDianHua(itemguid)
if not systemModel.isOpen(SYSTEM_DEFINE.eEquipReveal)then return false end
if not equipsHelper.hasDianHuaCnt(itemguid)then return false end
return true
end