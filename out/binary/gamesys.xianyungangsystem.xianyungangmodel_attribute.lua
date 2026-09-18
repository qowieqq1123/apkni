
function XianYunGangModel:getYunZhouComponentsSuitAttr(boatid)
local attrLookup={}
local suitData=XianYunGangModel:getYunZhouComponentsSuitData(boatid)
for suitid,v in pairs(suitData)do
local color=v.lv
local num=v.num
local suitAttrList=cfgHelper.get3(cfg_boatequipsuitconfig_get,suitid,color,"attrlist")
for i=num,1,-1 do
local attrs=suitAttrList[i]
if attrs then
for _,attr in ipairs(attrs)do
local attrType,attrValue=unpack(attr)
attrLookup[attrType]=(attrLookup[attrType]or 0)+attrValue
end
break
end
end
end
return attrLookup
end


function XianYunGangModel:getYunZhouComponentsBaseAttr(boatid)
local attrLookup={}
local equipData=XianYunGangModel:getYunZhouComponentsData(boatid)or{}
for _,v in ipairs(equipData)do
local itemid=v.itemid
local itemData=v.itemData
local level=itemData and(itemData.jinglianlv or 0)or 0
local baseAttrsLookup=yunZhouEquipsConfig.getStrengthenBaseAttrs(itemid,level)
attrLookup=attrListHelper.concatLookup(attrLookup,baseAttrsLookup)
end
return attrLookup
end


function XianYunGangModel:getYunZhouComponentsAttrsLookup(boatid)
local attrLookup={}
local baseLookup=XianYunGangModel:getYunZhouComponentsBaseAttr(boatid)
attrLookup=attrListHelper.concatLookup(attrLookup,baseLookup)
local suitLookup=XianYunGangModel:getYunZhouComponentsSuitAttr(boatid)
attrLookup=attrListHelper.concatLookup(attrLookup,suitLookup)
return attrLookup
end


function XianYunGangModel:getYunZhouJunZhenAttrsLookup(boatid)
local attrList={}
if boatid then

local shipData=cfgHelper.get1(cfg_fairylandboatconfig_get,boatid)
for i,v in ipairs(shipData.attr)do
attrList[v[1]]=v[2]
end

local yunZhouComponentsAttrsLookup=XianYunGangModel:getYunZhouComponentsAttrsLookup(boatid)
attrList=attrListHelper.concatLookup(attrList,yunZhouComponentsAttrsLookup)
end
return attrList
end