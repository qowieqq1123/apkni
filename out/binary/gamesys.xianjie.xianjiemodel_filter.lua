































function xianjieModel:getFilterHUD2Cfg()
return xianjieController:getFilterEntity2DCfg()
end

function xianjieModel:getFilterHUD2Record(init)
local record=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eXJFilter,{})
local filterRecord=record.fliterHUD2StrListEx

if filterRecord==nil or init then

if not filterRecord then
filterRecord={}
end
record.fliterHUD2StrListEx=filterRecord
local cfg=cfg_fairylandentityicontypeconfig2()
local typeconfig=cfg_fairylandentityicontypeconfig()
for k,v in pairs(cfg)do
local show=xianjieController:checkFilterShowCdn(v.showCdn)
if show then
local typeCfg=typeconfig[v.type]
local key1=typeCfg.type1
if not filterRecord[key1]then
filterRecord[key1]={}
end
local key2=typeCfg.type2
if not filterRecord[key1][key2]then
filterRecord[key1][key2]={}
end
local key3=v.type3

if filterRecord[key1][key2][key3]==nil then
filterRecord[key1][key2][key3]=true
end
end
end
userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eXJFilter,record)
end
return filterRecord
end

function xianjieModel:checkFilterHUD2Record(entityType,xjicontype)
if xjicontype==nil then return true end
local cfg=cfg_fairylandentityicontypeconfig2_get(xjicontype)
if cfg==nil then return true end
local typeconfig=cfg_fairylandentityicontypeconfig()
local typeCfg=typeconfig[cfg.type]
local type1=typeCfg.type1
local type2=typeCfg.type2
local type3=cfg.type3
local filterRecord=xianjieModel:getFilterHUD2Record()
if filterRecord[type1]==nil then return true end
if filterRecord[type1][type2]==nil then return true end
return filterRecord[type1][type2][type3]
end

function xianjieModel:changeFilterHUD2(type1,type2,type3)
type2=type2 or"1"
type3=type3 or"1"
local lp=xianjieModel:getFilterHUD2Cfg()
local d=lp[type1][type2][type3]
local id=d.id

local list=xianjieController:findAOIEnity()
local entkey,ent,check
for i=1,list.Count do
entkey=list[i-1]
ent=xianjieController:getEntity(entkey)
if ent and ent.xjicontype==id then
ent:changeLOD()
end
end
end

function xianjieModel:changeFilterHUD2Ex(type1,type2,type3)


local lp=xianjieModel:getFilterHUD2Cfg()

local idLookup={}
local t1=lp[type1]
for _type2,v in pairs(t1)do
if type2 then
if _type2==type2 then
for _type3,vv in pairs(v)do
if type(vv)=="table"then
if type3 then
if _type3==type3 then
idLookup[vv.id]=true
end
else
idLookup[vv.id]=true
end
end
end
end
else
for _type3,vv in pairs(v)do
if type(vv)=="table"then
if type3 then
if _type3==type3 then
idLookup[vv.id]=true
end
else
idLookup[vv.id]=true
end
end
end
end
end

local list=xianjieController:findAOIEnity()
local entkey,ent,check
for i=1,list.Count do
entkey=list[i-1]
ent=xianjieController:getEntity(entkey)
if ent and idLookup[ent.xjicontype]then
ent:changeLOD()
end
end
end
