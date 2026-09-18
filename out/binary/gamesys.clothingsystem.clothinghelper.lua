ClothingHelper={}

local voc_items_lookup={}
local _filterTable={}


function ClothingHelper.canDressByLimit(itemid,diziId,voc,warning)
local itemCfg=itemsConfig.getConfig(itemid)

if itemCfg.disciple then
if diziId==itemCfg.disciple then
return true
end
if warning then
UIManager.error('角色不匹配，无法穿戴')
end
else
if voc==itemCfg.type1 then
return true
end
if warning then
UIManager.error('职业不匹配，无法穿戴')
end
end

return false
end


function ClothingHelper.isCanDressEx(diziguid,itemguid,warning)
local voc=UIDiscipleModel:getDiscipleJob(diziguid)
local diziId=UIDiscipleModel:getDiscipleID(diziguid)
if ClothingModel:isEquipedOnAnyDizi(itemguid)then

return
end
local equip=ClothingHelper.getEquip(itemguid)





local itemid=equip.itemid
return ClothingHelper.canDressByLimit(itemid,diziId,voc,warning)
end

function ClothingHelper.isCanDress(diziguid,itemid,warning)
local voc=UIDiscipleModel:getDiscipleJob(diziguid)
local diziId=UIDiscipleModel:getDiscipleID(diziguid)
return ClothingHelper.canDressByLimit(itemid,diziId,voc,warning)
end

function ClothingHelper.getEquip(itemguid)
return bagModel.getItem(itemguid)or
ClothingModel:getEquip(itemguid)or
watchModel.getItem(itemguid)
end

function ClothingHelper.isMaxStar(equip)
local itemid=equip.itemid
local maxStar=ClothingConfig.getStarMaxLv(itemid)
local starlv=ClothingModel:getStarLvByEquip(equip)
return starlv>=maxStar
end

function ClothingHelper.isMaxStarByGUID(itemguid)
local equip=ClothingHelper.getEquip(itemguid)
return ClothingHelper.isMaxStar(equip)
end

function ClothingHelper.sortClothing(list,sortOrder,hidequiped,itemId,diziguid)
local sortTag={}

local fightFunc=function(equip)
return ClothingModel:isEquipedOnAnyDizi(equip.itemguid)and 1 or 0
end
local sortFightIndex,fightlen=itemsSortHelper.getFightSort(list,fightFunc)

local sortFunc=function(item,i)
local itemguid=item.itemguid
local itemid=item.itemid

local itemid_idx=itemid/100000
local fight=fightFunc(item)
local fightIdx=sortFightIndex[fight]

local starlv=ClothingModel:getStarLv(itemguid)
return starlv*10000*fightlen+
fightIdx*100000+
i+
itemid_idx
end

local sortList={}
if hidequiped then
local equipedClothing=ClothingModel:getEquipByDizi(diziguid)
local equipedguid=equipedClothing and equipedClothing.itemguid
local idx=1
for i,v in ipairs(list)do
if(not ClothingModel:isEquipedOnAnyDizi(v.itemguid))or equipedguid==v.itemguid then
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


function ClothingHelper.checkStarReddot(itemguid)
if not itemguid then
return false
end

return ClothingHelper.isCanStar(itemguid)
end


function ClothingHelper.isCanStar(itemguid,checkBenTi)
local equip=equipsHelper.getEquip(itemguid)
if equip==nil then return false end
local itemid=equip.itemid
local lv=equip.itemData and equip.itemData.star or 0
local maxlv=ClothingConfig.getStarMaxLv(itemid)
if lv>=maxlv then return false end
local itemCfg=itemsConfig.getConfig(itemid)

if itemCfg.item then

local item=itemCfg.item
local has=itemsModel.getCount(item[1])
if has>=item[2]then
return true
end
end

if checkBenTi then

local bentinum=ClothingConfig.getCostBenTiNum(lv)
table.clear(_filterTable)
_filterTable[ITEM_FILTER_TYPE.eItemguid]={ITEM_FILTER_COMPARE.eNot,itemguid}
_filterTable[ITEM_FILTER_TYPE.eItemid]=itemid
_filterTable[ITEM_FILTER_TYPE.eJinglianLv]=0
_filterTable[ITEM_FILTER_TYPE.eStarLv]=0
local len=bagControl.getBagItemsCnt(BAG_TYPE.eClothing,_filterTable)
if len<bentinum then return false end
end

local star=ClothingHelper.getStarAttrs(itemCfg)
local starTable=star[lv]
if starTable==nil then return false end
local cost=starTable[1]
if cost==nil then return true end
for i,v in ipairs(cost)do
local needid=v[1]
local neednum=v[2]
local has=itemsModel.getCount(needid)
if neednum>has then
return false,v
end
end

return true
end

function ClothingHelper.isCanSpeStar(itemguid)
local equip=equipsHelper.getEquip(itemguid)
if equip==nil then return false end
return ClothingHelper.isCanSpeStarEx(equip)
end


function ClothingHelper.isCanSpeStarEx(equip)
local itemid=equip.itemid
local lv=equip.itemData and equip.itemData.star or 0
local maxlv=ClothingConfig.getStarMaxLv(itemid)
if lv>=maxlv then return false end
local itemCfg=itemsConfig.getConfig(itemid)
if itemCfg.item then

local item=itemCfg.item
local has=itemsModel.getCount(item[1])
if has>=item[2]then
return true
end
end
return false
end

function ClothingHelper.isCanSpeStarDizi(diziguid)
return ClothingHelper.isCanSpeStar(diziguid)
end

function ClothingHelper.isCanAnySpeStar()
local all=ClothingModel:getAnyDiziEquip()
for k,switchList in pairs(all)do
for switchidx,equip in pairs(switchList)do
if ClothingHelper.isCanSpeStarEx(equip)then
return true
end
end
end
return false
end

function ClothingHelper:get_voc_items(voc)
if voc_items_lookup==nil then
voc_items_lookup={}
end
local res=voc_items_lookup[voc]
if res==nil then
res={}
voc_items_lookup[voc]=res
local itemlist=cfgHelper.get1(cfg_items_dress_type1_lookup_get,voc)
if itemlist then
for i,itemID in ipairs(itemlist)do
local cfg=itemsConfig.getConfig(itemID)
if cfg then
table_insert(res,cfg)
else
logErr(FMT.fmt('找不到时装{0}配置',itemID))
end
end
end
end
return res
end

function ClothingHelper.findDizi(itemid,warring,checkNotDress)
local itemCfg=itemsConfig.getConfig(itemid)

if itemCfg.disciple then
local all=UIDiscipleModel:getAllDiscipleDataX()
for k,v in pairs(all)do
if UIDiscipleModel:getDiscipleIDEx(v.netData.net)==itemCfg.disciple then
if not checkNotDress or(checkNotDress and not ClothingModel:getEquipByDizi(v.netData.net.discipleguid))then
return v.netData.net.discipleguid
end
end
end
if warring then
local name=cfgHelper.get(cfg_discipleconfig_get,itemCfg.disciple,"name")
UIManager.error(FMT.fmt("尚未拥有{0}",name))
end
else
local discipleList=discipleLookup:getSortDiscipleList(eDiscipleSortType.eFightSort,{[2]={itemCfg.type1}},eSortOrder.eDown)or{}
if next(discipleList)then
if not checkNotDress then
local netData=discipleList[1].netData
return netData.net.discipleguid
else
for i,v in ipairs(discipleList)do
if not ClothingModel:getEquipByDizi(v.netData.net.discipleguid)then
return v.netData.net.discipleguid
end
end
end
end
if warring then
local name=cfgHelper.get(cfg_disciplevocationconfig_get,itemCfg.type1,"name")
UIManager.error(FMT.fmt("尚未拥有{0}弟子",name))
end
end

end

function ClothingHelper.getClothingSort(guid)
local sort=0
if ClothingModel:getEquipByDizi(guid)then
sort=100000
else
local voc=UIDiscipleModel:getDiscipleJob(guid)
local vocItemList=ClothingHelper:get_voc_items(voc)or{}

local haveItem=false
local filter={}
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eClothing
filter[ITEM_FILTER_TYPE.eItemType1]={ITEM_FILTER_COMPARE.eEquals,{voc}}
filter[ITEM_FILTER_TYPE.eCheckHide]={ITEM_FILTER_COMPARE.eNot,{true}}
local len=bagControl.getBagItemsCnt(BAG_TYPE.eClothing,filter)
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


function ClothingHelper.checkDiziConfig(diziId)
local imagelib=cfgHelper.get(cfg_discipleconfig_get,diziId,"imagelib")
if imagelib then
local bodyId=imagelib[3]
local bodyCfg=cfgHelper.get(cfg_disciplebodyimageconfig_get,bodyId)
return bodyCfg.clothing_out_side~=nil
end
return true
end

function ClothingHelper.getDiziNoConfigList()
local list={}
local disciples=UIDiscipleModel:getAllDiscipleData()
if disciples then
for i,v in pairs(disciples)do
if not ClothingHelper.checkDiziConfig(v.netData.net.id)then
list[v.netData.net.discipleguidStr]=1
end
end
end
return list
end


function ClothingHelper.checkClothAcitveAndFullStar(clothItemid,upStarItemid)
local isActive,isFullStar=false,false
local maxlv=ClothingConfig.getStarMaxLv(clothItemid)

local equips=ClothingModel:getAllEquipByItemid(clothItemid)
for i,v in ipairs(equips)do
isActive=true
local itemData=v.itemData
if itemData then
local star=itemData.star or 0
if star>=maxlv then
return true,true
end
end
end

local filter={}
filter[ITEM_FILTER_TYPE.eItemid]=clothItemid
local bagList=bagControl.getBagItemsByFilter(BAG_TYPE.eClothing,filter,false)
for i,v in ipairs(bagList)do
isActive=true
local itemData=v.itemData
if itemData then
local star=itemData.star or 0
if star>=maxlv then
return true,true
end
end
end

if isActive and upStarItemid then
if bagModel.getItemCountById(upStarItemid)>0 then
isFullStar=true
end
end
return isActive,isFullStar
end
