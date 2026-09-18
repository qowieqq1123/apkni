





function xingChenHelper.getBagRongHeItem()
local filter={}
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eXingChen

filter[ITEM_FILTER_TYPE.eXingChenRongHe]={ITEM_FILTER_COMPARE.eEquals,{1}}

local sortList=bagControl.getBagItemsByFilter(BAG_TYPE.eXingChen,filter,false)

return sortList[1]
end

function xingChenHelper.getEquipRongHeItem()
local posData=xingChenBagModel:getPosData()
for idx,item in pairs(posData)do
if item.itemData.minor_stars_guid~=int64.zero then
return item
end
end
end

function xingChenHelper.onXingChenRongHe(main_stars_guid,minor_stars_guid,is_use,is_replace,affix_len,affixList,after_star)
local equip=equipsHelper.getEquip(main_stars_guid)
if not equip then return end
equip.itemData.minor_stars_guid=minor_stars_guid
equip.itemData.len2=affix_len
equip.itemData.fusionList=nil
equip.itemData.fusion_affix_id=is_replace
equip.itemData.star=after_star

xingChenBagModel:setRongHeItem(main_stars_guid,1)
xingChenBagModel:setRongHeItem(minor_stars_guid,2)

xingChenBagModel:setRongHeAffixList(affixList)

xingChenHelper.updateStarZhenXiId(equip)

notifySystem:postNotify(notifyConfig.onXCEquipChange,itemsConfig.getConfig(equip.itemid).type1,equip)
end

function xingChenHelper.onXingChenRongHeEnd(mainguid,rare_id)
local equip=equipsHelper.getEquip(mainguid)
xingChenBagModel:setRongHeItem(mainguid)
xingChenBagModel:setRongHeItem(equip.itemData.minor_stars_guid)
equip.itemData.minor_stars_guid=int64.zero
equip.itemData.len=equip.itemData.len2
local sendList=xingChenBagModel:getRongHeAffixList()
if sendList then
equip.itemData.affixList=xingChenBagModel:getRongHeAffixList()
else
equip.itemData.affixList=xingChenHelper.changeRongHeList(equip)
end
equip.itemData.len2=0
equip.itemData.fusionList=nil
equip.itemData.fusion_affix_id=0
equip.itemData.fin_rare_id=rare_id

xingChenBagModel:setRongHeAffixList()

xingChenHelper.updateStarZhenXiId(equip)
end

function xingChenHelper.onXingChenFenLiEnd(mainguid)
local equip=equipsHelper.getEquip(mainguid)
xingChenBagModel:setRongHeItem(mainguid)
xingChenBagModel:setRongHeItem(equip.itemData.minor_stars_guid)
equip.itemData.minor_stars_guid=int64.zero
equip.itemData.len2=0
equip.itemData.fusionList=nil
equip.itemData.fusion_affix_id=0

xingChenBagModel:setRongHeAffixList()

xingChenHelper.updateStarZhenXiId(equip)
end

function xingChenHelper.changeRongHeList(equip)
local final={}
local affixLookup={}
for i,v in ipairs(equip.itemData.affixList)do
if equip.itemData.fusion_affix_id~=v then
table.insert(final,v)
affixLookup[v]=1
end
end
if equip.itemData.fusionList then
for i,v in ipairs(equip.itemData.fusionList)do
if not affixLookup[v]then
table.insert(final,v)
end
end
end
return final
end