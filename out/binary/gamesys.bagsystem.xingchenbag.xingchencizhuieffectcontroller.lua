





xingChenCiZhuiEffectController=gameState.addListener({})

function xingChenCiZhuiEffectController:onAppStart()

end

function xingChenCiZhuiEffectController:onEnterState()
self.data={}
end

function xingChenCiZhuiEffectController:onLeaveState()
self.data={}
end

function xingChenCiZhuiEffectController:onPlayerCreate(...)

end

function xingChenCiZhuiEffectController:onLostConnection()

end


function xingChenCiZhuiEffectController:getXingChenJunZhenVal(guid)
local list={}
local effectlist=xingChenHelper.getAllCiZhuiList(guid,"jz_effects")
for i,v in ipairs(effectlist)do
list[v[1]]=(list[v[1]]or 0)+v[2]
end
local equip=equipsHelper.getEquip(guid)
if equip.itemData.rare_id~=0 then
local cfg=cfgHelper.get(cfg_starsrareconfig_get,equip.itemData.fin_rare_id)
if cfg and cfg.jz_effects then
local effects=cfg.jz_effects
for i,v in ipairs(effects)do
list[v[1]]=(list[v[1]]or 0)+v[2]
end
end
end
return list
end


function xingChenCiZhuiEffectController:getEquippedXingChenJunZhenVal(jzAttrType)
if xingChenBagModel:getStarJunZhenEffectDirty()then
if jzAttrType then
return self.data.jzData[jzAttrType]
else
return self.data.jzData
end
else
local list={}
local slotList=xingChenBagModel:getPosData()
for _t,slot in pairs(slotList)do
local effectlist=xingChenHelper.getAllCiZhuiList(slot.itemguid,"jz_effects")
for i,v in ipairs(effectlist)do
list[v[1]]=(list[v[1]]or 0)+v[2]
end
if slot.itemData.fin_rare_id~=0 then
local cfg=cfgHelper.get(cfg_starsrareconfig_get,slot.itemData.fin_rare_id)
if cfg and cfg.jz_effects then
local effects=cfg.jz_effects
for i,v in ipairs(effects)do
list[v[1]]=(list[v[1]]or 0)+v[2]
end
end
end
end
self.data.jzData=list
xingChenBagModel:setStarJunZhenEffectDirty()
if jzAttrType then
return list[jzAttrType]
else
return list
end
end
end


function xingChenCiZhuiEffectController:getAttachJZAttr()
local list={}
local lookupList={}
local config=cfg_starsaffixconfig()
for i,v in pairs(config)do
if v.jz_effects then
for __,v2 in ipairs(v.jz_effects)do
local attrId=v2[1]
if not lookupList[attrId]then
lookupList[attrId]=true
list[#list+1]=attrId
end
end
end
end
local config=cfg_starsrareconfig()
for i,v in pairs(config)do
if v.jz_effects then
for __,v2 in ipairs(v.jz_effects)do
local attrId=v2[1]
if not lookupList[attrId]then
lookupList[attrId]=true
list[#list+1]=attrId
end
end
end
end
return list
end