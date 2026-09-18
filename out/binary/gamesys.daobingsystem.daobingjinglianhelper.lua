




function daobingHelper.getJinglianPrecent(itemid,jllv)
local itemConfig=itemsConfig.getConfig(itemid)
local baseAttrsLookup=daobingHelper.getBaseAttrLookup(itemConfig)
local jinglian=itemConfig.jinglian[jllv]
return jinglian[3]or 0
end

function daobingHelper.getJinglianBaseAttrs(itemid,jllv)
local itemConfig=itemsConfig.getConfig(itemid)
local jinglian=itemConfig.jinglian[jllv]
return jinglian[2]
end


function daobingHelper.getJinglianAddPercentBaseAttrs(itemid,starlv,jllv)
local itemConfig=itemsConfig.getConfig(itemid)
local baseAttrsLookup=daobingHelper.getBaseAttrLookup(itemConfig)
local jinglian=itemConfig.jinglian[jllv]
local jinglianAttr=jinglian[2]
local percent=jinglian[3]or 0

local starAttr=daobingHelper.getStarBaseAttrs(itemid,starlv)
local starAttrLookup=attrListHelper.tramsformToLookup(starAttr)

local jlAttrLookup=attrListHelper.tramsformToLookup(jinglianAttr)

local baseLookup=attrListHelper.concatLookup(baseAttrsLookup,jlAttrLookup)
baseLookup=attrListHelper.concatLookup(baseLookup,starAttrLookup)

local addBaseAttrsLookup=attrListHelper.getAddLookupOnPercent(baseLookup,percent,true)
return addBaseAttrsLookup
end


function daobingHelper.getJinglianAddBaseAttrs(itemid,starlv,jllv)
local itemConfig=itemsConfig.getConfig(itemid)
local baseAttrsLookup=daobingHelper.getBaseAttrLookup(itemConfig)
local jinglian=itemConfig.jinglian[jllv]
local jinglianAttr=jinglian[2]
local percent=jinglian[3]or 0

local starAttr=daobingHelper.getStarBaseAttrs(itemid,starlv)
local starAttrLookup=attrListHelper.tramsformToLookup(starAttr)

local jlAttrLookup=attrListHelper.tramsformToLookup(jinglianAttr)

local baseLookup=attrListHelper.concatLookup(baseAttrsLookup,jlAttrLookup)
baseLookup=attrListHelper.concatLookup(baseLookup,starAttrLookup)

local addBaseAttrsLookup=attrListHelper.getAddLookupOnPercent(baseLookup,percent,true)
local lookup=attrListHelper.concatLookup(addBaseAttrsLookup,jlAttrLookup)
return lookup
end

function daobingHelper.getNextTuPoLv(itemguid)
local equip=equipsHelper.getEquip(itemguid)
local itemid=equip.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local jinglian=daobingHelper.getJlAttrs(itemCfg)
local jllv=daobingModel:getJilianLv(itemguid)
local precent=jinglian[jllv][3]
while true do
jllv=jllv+1
local jinglianTable=jinglian[jllv]
if jinglianTable==nil then return end
local p=jinglianTable[3]
if p>precent then return jllv end
end
end





function daobingHelper.isCanJinglian(itemguid,isFast)
local equip=equipsHelper.getEquip(itemguid)
if equip==nil then return false end
local jllv=equip.itemData and equip.itemData.jinglianlv or 0
local itemid=equip.itemid
local starlv=daobingModel:getStarLv(itemguid)
local maxlv=daobingConfig.getCurrentJinglianMaxLv(itemid,starlv)
if jllv>=maxlv then return false end
local itemCfg=itemsConfig.getConfig(itemid)
local jinglian=daobingHelper.getJlAttrs(itemCfg)
local nexttplv=daobingHelper.getNextTuPoLv(itemguid)
local isTPlv=nexttplv==(jllv+1)
local maxjllv=(isFast and not isTPlv)and nexttplv-1 or jllv+1
local allCost={}
for lv=jllv,maxjllv-1 do
local jinglianTable=jinglian[lv]
local cost=jinglianTable[1]
if cost==nil then break end
for i,v in ipairs(cost)do
local needid=v[1]
local neednum=v[2]
allCost[needid]=allCost[needid]or 0
allCost[needid]=allCost[needid]+neednum
end
end
local jinglianTable=jinglian[jllv]
local cost=jinglianTable[1]
if cost==nil then return true end
for i,v in ipairs(cost)do
local needid=v[1]
local neednum=isFast and allCost[needid]or v[2]
local has=itemsModel.getCount(needid)
if neednum>has then
return false,{needid,neednum}
end
end
return true
end

function daobingHelper.isCanJinglianLv(itemguid)
local starlv=daobingModel:getStarLv(itemguid)
local jllv=daobingModel:getJilianLv(itemguid)
local needStar=daobingConfig.getMinStarLvByJlLv(jllv)
return starlv>=needStar,needStar
end












