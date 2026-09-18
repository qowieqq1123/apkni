daobingHelper={}


function daobingHelper.isUnlock(diziguid)
local tmlv=UIDiscipleModel:getTianMingLevel(diziguid)
return tmlv>=daobingConfig.getUnlocklv()
end

function daobingHelper.isDZCanDress(diziguid,warning)
if not daobingHelper.isUnlock(diziguid)then
if warning then
UIManager.error('弟子天命等级不足')
end
return false
end
return true
end


function daobingHelper.canDressByVoc(itemid,voc,warning)
local itemCfg=itemsConfig.getConfig(itemid)
local type2=itemCfg.type2
local voclist=equipsHelper.getLimitVoc(type2)
if voclist==nil then return true end
for i,v in ipairs(voclist)do
if v==voc then
return true
end
end
if warning then
UIManager.error('职业不匹配，无法穿戴')
end
return false
end


function daobingHelper.isCanDress(diziguid,itemguid,warning)
if not daobingHelper.isDZCanDress(diziguid,warning)then return false end
local voc=UIDiscipleModel:getDiscipleJob(diziguid)
local equip=daobingHelper.getEquip(itemguid)
local itemid=equip.itemid
return daobingHelper.canDressByVoc(itemid,voc,warning)
end

function daobingHelper.getEquip(itemguid)
return bagModel.getItem(itemguid)or
daobingModel:getEquip(itemguid)
end

function daobingHelper.isMaxStar(equip)
local itemid=equip.itemid
local maxStar=daobingConfig.getStarMaxLv(itemid)
local starlv=daobingModel:getStarLvByEquip(equip)
return starlv>=maxStar
end

function daobingHelper.isMaxStarByGUID(itemguid)
local equip=daobingHelper.getEquip(itemguid)
return daobingHelper.isMaxStar(equip)
end


function daobingHelper.isCanCombine(itemid)
local itemCfg=itemsConfig.getConfig(itemid)
local piece=itemCfg.piece
local need=piece[2]
local itemcount=itemsModel.getCount(itemid)
return itemcount>=need,piece[1]
end

function daobingHelper.isCanAnyCombine()
local itemids=daobingBagModel:getSuiPianitemids()
for itemid,_ in pairs(itemids)do
local ret=daobingHelper.isCanCombine(itemid)
if ret then return true end
end
return false
end

function daobingHelper.sortDaoBing(list,sortType,sortOrder)
local sortTag={}

local fightFunc=function(equip)
return daobingHelper.getEquipFightX(equip.itemid,equip.itemguid)
end
local sortFightIndex,fightlen=itemsSortHelper.getFightSort(list,fightFunc)

local sortFunc=function(item,i)
local itemguid=item.itemguid
local itemid=item.itemid
local cfg=itemsConfig.getConfig(itemid)
local itemid_idx=itemid/100000
local fight=fightFunc(item)
local fightIdx=sortFightIndex[fight]
if sortType==2 then
return cfg.color*10000*fightlen+
fightIdx*1000+
i+
itemid_idx
elseif sortType==3 then
local starlv=daobingModel:getStarLv(itemguid)
return starlv*10000*fightlen+
fightIdx*1000+
i+
itemid_idx
elseif sortType==4 then
local lv=daobingModel:getJilianLv(itemguid)
return lv*10000*fightlen+
fightIdx*1000+
i+
itemid_idx
elseif sortType==1 then
return fightIdx*1000+
i+
itemid_idx
end
end

for i,v in ipairs(list)do
sortTag[tostring(v.itemguid)]=sortFunc(v,i)
end

local isDown=sortOrder==eSortOrder.eDown
if isDown then
table.sort(list,function(a,b)
return sortTag[tostring(a.itemguid)]>sortTag[tostring(b.itemguid)]
end)
else
table.sort(list,function(a,b)
return sortTag[tostring(a.itemguid)]<sortTag[tostring(b.itemguid)]
end)
end
return list
end


function daobingHelper.checkDaoBingReddot(itemguid)
if not itemguid then
return false
end

return daobingHelper.isCanJinglian(itemguid)or daobingHelper.isCanStar(itemguid,true)
end