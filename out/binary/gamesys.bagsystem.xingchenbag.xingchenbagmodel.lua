





xingChenBagModel=simple_class(baseBagModel)

xingChenBagModel.bagType=BAG_TYPE.eXingChen

function xingChenBagModel:onAppStart()


end

function xingChenBagModel:onEnterState()


self:init()
self.equips={}
self.equipsLookup={}
self.increaseStar={}
self.increaseExp={}

self.rongheGuid={}

self:setStarEffectDirty()
end

function xingChenBagModel:onLeaveState()
self:init()
self.equips={}
self.equipsLookup={}
self.increaseStar={}
self.increaseExp={}

self.rongheGuid={}
end


function xingChenBagModel:onAddItem(data,isInit)

xingChenHelper.updateStarZhenXiId(data)

self._base.onAddItem(self,data,isInit)

if data.itemData.minor_stars_guid~=int64.zero then
self.rongheGuid[tostring(data.itemguid)]=1
self.rongheGuid[tostring(data.itemData.minor_stars_guid)]=2
end

UIManager:invokeUIMethod("UIXJLittleWorldXingChenBagWin","addItem",data)
end

function xingChenBagModel:onDeleteItem(equip)
if equip and equip.itemData.minor_stars_guid~=int64.zero then
self.rongheGuid[tostring(equip.itemguid)]=nil
self.rongheGuid[tostring(equip.itemData.minor_stars_guid)]=nil
end

self._base.onDeleteItem(self,equip)

UIManager:invokeUIMethod("UIXJLittleWorldXingChenBagWin","clearItem",equip)
end

function xingChenBagModel:onChangeItem(data)
self._base.onChangeItem(self,data)
xingChenHelper.updateStarZhenXiId(data)
UIManager:invokeUIMethod("UIXJLittleWorldXingChenBagWin","addItem",data)
end

function xingChenBagModel:getPosData()
return self.equipsLookup
end

function xingChenBagModel:getEquipDataByPos(pos)
return self.equipsLookup[pos]
end


function xingChenBagModel:getEquip(itemguid)
return self.equips[tostring(itemguid)]
end

function xingChenBagModel:initEquipData(equipData)
if equipData then
for i,item in ipairs(equipData)do
local config=itemsConfig.getConfig(item.itemid)
local type1=config.type1
self.equipsLookup[type1]=item
self.equips[tostring(item.itemguid)]=item
if item.itemData.minor_stars_guid~=int64.zero then
self.rongheGuid[tostring(item.itemguid)]=1
self.rongheGuid[tostring(item.itemData.minor_stars_guid)]=2
end

xingChenHelper.updateStarZhenXiId(item)
end
end
self:setStarEffectDirty()

end

function xingChenBagModel:onDressEquip(pos,itemguid)
local item=bagModel.getItem(itemguid)

if item==nil then
loggerUtil.logErrFMT('背包不存在此装备',tostring(itemguid))
return
end
self:addEquip(pos,item,true)


UIManager:callWindowFunc("UIXJLittleWorldXingChenWin",pos,item)
end

function xingChenBagModel:addEquip(pos,item,showFightTips)
local litem=self.equipsLookup[pos]
if litem and tostring(litem.itemguid)==tostring(item.itemguid)then return end

if litem then
self.equips[tostring(litem.itemguid)]=nil
end

xingChenHelper.updateStarZhenXiId(item)

self.equipsLookup[pos]=item
self.equips[tostring(item.itemguid)]=item

if item.itemData.minor_stars_guid~=int64.zero then
self.rongheGuid[tostring(item.itemguid)]=1
self.rongheGuid[tostring(item.itemData.minor_stars_guid)]=2
end


self:setStarEffectDirty()
LittleWorldModel:dirtyAllDiscipleAttribute(showFightTips)

notifySystem:postNotify(notifyConfig.onXCEquipChange,pos,item)

UIManager:invokeUIMethod("UIXJLittleWorldXingChenBagWin","addItem",item)
end

function xingChenBagModel:onTakeOffEquip(pos)
self:deleteEquip(pos)

UIManager:callWindowFunc("UIXJLittleWorldXingChenWin",pos)
end


function xingChenBagModel:deleteEquip(pos)
local item=self.equipsLookup[pos]
if item==nil then return end

local itemguid=item.itemguid

UIManager:invokeUIMethod("UIXJLittleWorldXingChenBagWin","clearItem",item)

self.equipsLookup[pos]=nil
self.equips[tostring(itemguid)]=nil


self:setStarEffectDirty()
LittleWorldModel:dirtyAllDiscipleAttribute()

notifySystem:postNotify(notifyConfig.onXCEquipChange,pos,item)

return EQUIP_TYPE.eXingChen
end

function xingChenBagModel:initPos(posList)
if posList then
for i,v in ipairs(posList)do
xingChenBagModel:setOrbitLevel(v.param_1,v.param_2)
xingChenBagModel:setExp(v.param_1,v.param_3)
end
end
end



function xingChenBagModel:setOrbitLevel(pos,lv)
self.increaseStar[pos]=lv
end

function xingChenBagModel:setExp(pos,exp)
self.increaseExp[pos]=exp
end


function xingChenBagModel:getOrbitLevel(pos)
return self.increaseStar[pos]or 1
end

function xingChenBagModel:getExp(pos)
return self.increaseExp[pos]or 0
end

function xingChenBagModel:isRongHeItem(itemguid)
return self.rongheGuid[tostring(itemguid)]==1
end

function xingChenBagModel:isRongHeChildItem(itemguid)
return self.rongheGuid[tostring(itemguid)]==2
end

function xingChenBagModel:setRongHeItem(itemguid,flag)
self.rongheGuid[tostring(itemguid)]=flag
end

function xingChenBagModel:setStarEffectDirty()
self.starEffectDirty_Grow={}
self.starEffectDirty_Fight={}
self.starEffectDirty_JunZhen=nil
end

function xingChenBagModel:getStarGrowEffectDirty(effectType)
return self.starEffectDirty_Grow[effectType]
end

function xingChenBagModel:setStarGrowEffectDirty(effectType)
self.starEffectDirty_Grow[effectType]=true
end


function xingChenBagModel:getStarFightEffectDirty(effectType)
return self.starEffectDirty_Fight[effectType]
end

function xingChenBagModel:setStarFightEffectDirty(effectType)
self.starEffectDirty_Fight[effectType]=true
end

function xingChenBagModel:getStarJunZhenEffectDirty()
return self.starEffectDirty_JunZhen
end

function xingChenBagModel:setStarJunZhenEffectDirty()
self.starEffectDirty_JunZhen=true
end

function xingChenBagModel:setRongHeAffixList(rongHeAffixList)
self.rongHeAffixList=rongHeAffixList
end

function xingChenBagModel:getRongHeAffixList()
return self.rongHeAffixList
end


