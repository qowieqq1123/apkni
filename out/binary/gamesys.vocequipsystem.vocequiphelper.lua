vocEquipHelper={}

local voc_items_lookup={}
local _filterTable={}


function vocEquipHelper.canDressByLimit(itemid,voc,warning)
local itemCfg=itemsConfig.getConfig(itemid)

if voc==itemCfg.type1 then
return true
end
if warning then
UIManager.error('职业不匹配，无法穿戴')
end

return false
end


function vocEquipHelper.isCanDressEx(diziguid,itemguid,warning)
if vocEquipModel:isEquipedOnAnyDizi(itemguid)then
return
end
local equip=vocEquipHelper.getEquip(itemguid)





local itemid=equip.itemid
local voc=UIDiscipleModel:getDiscipleJob(diziguid)
if not vocEquipHelper.canDressByLimit(itemid,voc,warning)then
return false
end

local needJingJieLv=equipsHelper.getDressJingjielv(itemid)
local jingJieLv=UIDiscipleModel:getDiscipleJJLevel(diziguid)
if needJingJieLv>jingJieLv then
if warning then

UIManager.error('弟子境界等级不足')
end
return false
end

return true
end

function vocEquipHelper.isCanDress(diziguid,itemid,warning)
local voc=UIDiscipleModel:getDiscipleJob(diziguid)
return vocEquipHelper.canDressByLimit(itemid,voc,warning)
end

function vocEquipHelper.getEquip(itemguid)
return bagModel.getItem(itemguid)or
vocEquipModel:getEquip(itemguid)
end

function vocEquipHelper.isMaxLevel(equip)
local itemid=equip.itemid
local maxLv=vocEquipHelper.getStrengthenMaxLvByItemid(itemid)
local enhancelv=equip and equip.itemData and equip.itemData.enhancelv or 0
return enhancelv>=maxLv
end

function vocEquipHelper.isMaxLevelByGUID(itemguid)
local equip=vocEquipHelper.getEquip(itemguid)
return vocEquipHelper.isMaxLevel(equip)
end

function vocEquipHelper.sortVocEquip(list,sortOrder,hidequiped,itemId,diziguid)
local sortTag={}

local fightFunc=function(equip)
return vocEquipModel:isEquipedOnAnyDizi(equip.itemguid)and 1 or 0
end
local sortFightIndex,fightlen=itemsSortHelper.getFightSort(list,fightFunc)

local sortFunc=function(item,i)
local itemguid=item.itemguid
local itemid=item.itemid

local itemid_idx=itemid/100000
local fight=fightFunc(item)
local fightIdx=sortFightIndex[fight]

local enhancelv=item and item.itemData and item.itemData.enhancelv or 0
return enhancelv*10000*fightlen+
fightIdx*100000+
i+
itemid_idx
end

local sortList={}
if hidequiped then
local equipedClothing=vocEquipModel:getEquipByDizi(diziguid)
local equipedguid=equipedClothing and equipedClothing.itemguid
local idx=1
for i,v in ipairs(list)do
if(not vocEquipModel:isEquipedOnAnyDizi(v.itemguid))or equipedguid==v.itemguid then
if(not itemId)or(itemId==v.itemid)then
sortTag[tostring(v.itemguid)]=sortFunc(v,idx)
table.insert(sortList,v)
idx=idx+1
end
end
end
else
for i,v in ipairs(list)do
if(not itemId)or(itemId==v.itemid)then
sortTag[tostring(v.itemguid)]=sortFunc(v,i)
table.insert(sortList,v)
end
end

end



local isDown=sortOrder==eSortOrder.eDown
if isDown then
table.sort(sortList,function(a,b)
return sortTag[tostring(a.itemguid)]>sortTag[tostring(b.itemguid)]
end)
else
table.sort(sortList,function(a,b)
return sortTag[tostring(a.itemguid)]<sortTag[tostring(b.itemguid)]
end)
end
return sortList
end


function vocEquipHelper.checkLevelUpReddot(itemguid)
if not itemguid then
return false
end

return vocEquipHelper.isCanLevelUp(itemguid)
end


function vocEquipHelper.isCanLevelUp(itemguid)












return false
end

function vocEquipHelper:get_voc_items(voc)
if voc_items_lookup==nil then
voc_items_lookup={}
end
local vocEquipItemid=voc_items_lookup[voc]
if vocEquipItemid==nil then
local cfgs=cfg_lookupvocequipconfig()
if cfgs then
for color,v in pairs(cfgs)do
for stage,vv in pairs(v)do
for type1,vvv in pairs(vv)do
local itemVoc=type1
local itemId=vvv[1]
if not voc_items_lookup[itemVoc]then
voc_items_lookup[itemVoc]=itemId
end
end
end
end
end
vocEquipItemid=voc_items_lookup[voc]
end
return vocEquipItemid
end

function vocEquipHelper.getVocEquipSort(guid)
local sort=0
if vocEquipModel:getEquipByDizi(guid)then
sort=100000
else
local voc=UIDiscipleModel:getDiscipleJob(guid)
local vocItemList=vocEquipHelper:get_voc_items(voc)or{}

local haveItem=false
local filter={}
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eVocEquip
filter[ITEM_FILTER_TYPE.eItemType1]={ITEM_FILTER_COMPARE.eEquals,{voc}}
filter[ITEM_FILTER_TYPE.eCheckHide]={ITEM_FILTER_COMPARE.eNot,{true}}
local len=bagControl.getBagItemsCnt(BAG_TYPE.eEquipBag,filter)
if len>0 then
haveItem=true
end
if haveItem then
sort=1000+#vocItemList
else
sort=#vocItemList
end


end
return sort
end


function vocEquipHelper.canEquipByVoc(itemid,voc,warning)
if not itemsConfig.isVocEquip(itemid)then return true end
local itemConfig=itemsConfig.getConfig(itemid)
local type1=itemConfig.type1
if voc==type1 then
return true
end

if warning then
UIManager.error('职业不匹配，无法穿戴')
end
return false
end

function vocEquipHelper.getEquipVocId(itemid)
local itemConfig=itemsConfig.getConfig(itemid)
local voc=itemConfig.type1
return voc
end


function vocEquipHelper.getVocEquipGongMingGBIdList(itemid)
local itemConfig=itemsConfig.getConfig(itemid)
local gubao=itemConfig.gubao
return gubao
end


function vocEquipHelper.getVocEquipGongMingLvCndDescList(itemid)
local maxLv=vocEquipHelper.getVocEquipGongMingMaxLv(itemid)
local list={
[1]="全部共鸣古宝已激活",
[2]="全部共鸣古宝达3星",
[3]="全部共鸣古宝达5星",
[4]="全部共鸣古宝已觉醒",
}

local descList={}
for level=1,maxLv do
local desc=list[level]
if desc then
descList[level]=desc
else



end
end

return list
end

function vocEquipHelper.getVocEquipGongMingMaxLv(itemid)
local allAttrsList=vocEquipHelper.getVocEquipGongMingAllAttrsList(itemid)
local maxLv=#allAttrsList
return maxLv
end
