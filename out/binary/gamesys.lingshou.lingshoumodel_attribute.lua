








lingshouAttributeType={
eBase=1,
eJingJie=2,
eQianLi=3,
eXueMai=4,
eDJob=5,
eTrait=6,
eDzGongFa=7,
}
local attribute_refresh_funcs={

[lingshouAttributeType.eJingJie]={
refresh=function(lsData)
lingshouModel:calculationJJAttrLookup(lsData)
end,
dirty=function(lsData)

end,
},

[lingshouAttributeType.eQianLi]={
refresh=function(lsData)
lingshouModel:calculationQLAttrLookup(lsData)
end,
dirty=function(lsData)

end,
},

[lingshouAttributeType.eXueMai]={
refresh=function(lsData)
lingshouModel:calculationXMAttrLookup(lsData)
end,
dirty=function(lsData)

end,
},

[lingshouAttributeType.eDJob]={
refresh=function(lsData)
lingshouModel:calculationDJobAttrLookup(lsData)
end,
refresh_otherDz=function(lsData,netData)
lingshouModel:calculationDJobAttrLookup_otherDZ(lsData,netData)
end,
dirty=function(lsData)

end,
},

[lingshouAttributeType.eTrait]={
refresh=function(lsData)
lingshouModel:calculationTraitAttrLookup(lsData)
end,
dirty=function(lsData)

end,
},

[lingshouAttributeType.eDzGongFa]={
refresh=function(lsData)
lingshouModel:calculationDzGongFaAttrLookup(lsData)
end,
refresh_otherDz=function(lsData,netData)
lingshouModel:calculationDzGongFaAttrLookup_otherDz(lsData,netData)
end,
dirty=function(lsData)

end,
},
}




function lingshouModel:getAllAttrList(lsData,is_ex)
if lsData.allAttrList==nil or lsData.allAttrListDirty then
local allAttrList={}
local allAttrListEx={}
local allAttrRateList={}

local allAttrLookup=lsData.allAttrLookup
for k,v in pairs(allAttrLookup)do
for k1,v1 in pairs(v)do
allAttrList[k1]=allAttrList[k1]or 0
allAttrList[k1]=allAttrList[k1]+v1
end
end

local allAttrRateLookup=lsData.allAttrRateLookup
for k,v in pairs(allAttrRateLookup)do
for k1,v1 in pairs(v)do
allAttrRateList[k1]=allAttrRateList[k1]or 0
allAttrRateList[k1]=allAttrRateList[k1]+v1
end
end

for type,val in pairs(allAttrList)do
if not attrListHelper.isMod(type)then

local rate=allAttrRateList[type]or 0
local fval=mathHelper.safe_floor(val*(1+rate/100))
allAttrList[type]=fval

allAttrListEx[type]=allAttrList[type]
end
end



lsData.allAttrList=allAttrList
lsData.allAttrRateList=allAttrRateList
lsData.allAttrListEx=allAttrListEx
lsData.allAttrListDirty=false







end
if is_ex==true then
return lsData.allAttrListEx
else
return lsData.allAttrList
end
end

function lingshouModel:initAttrLookup(lsData)
if lsData.allAttrLookup==nil then
lingshouModel:calculationAllAttrLookup(lsData)
for k,v in pairsBySortKey(attribute_refresh_funcs)do
v.refresh(lsData)
end
end
end

function lingshouModel:initAttrLookup_otherDz(lsData,dzData,isReset)
if lsData.allAttrLookup==nil or isReset then
lingshouModel:calculationAllAttrLookup(lsData)
for k,v in pairsBySortKey(attribute_refresh_funcs)do
if v.refresh_otherDz then
v.refresh_otherDz(lsData,dzData)
else
v.refresh(lsData)
end
end
end
end

function lingshouModel:getAllAttrLookup(guid)
local lsData=lingshouModel:getLingShouData(guid)
lingshouModel:getAllAttrList(lsData)
return lsData.allAttrLookup
end


function lingshouModel:getAllAttrLookupX(guid,attrType)
return lingshouModel:getAllAttrLookup(guid)[attrType]
end

function lingshouModel:calculationAllAttrLookup(lsData)
if lsData.allAttrLookup==nil then

local allAttrLookup={}

local baseLookup={}
allAttrLookup[lingshouAttributeType.eBase]=baseLookup
local lsID=lsData.id
local lscfg=cfgHelper.get1(cfg_lingshouconfig_get,lsID)
for i,v in ipairs(lscfg.attrs)do
baseLookup[v[1]]=v[2]
end

lsData.allAttrLookup=allAttrLookup
lsData.allAttrRateLookup={}
end
return lsData.allAttrLookup
end

function lingshouModel:calculationJJAttrLookup(lsData)
local allAttrLookup=lsData.allAttrLookup
local allAttrRateLookup=lsData.allAttrRateLookup

local jjLookup={}
allAttrLookup[lingshouAttributeType.eJingJie]=jjLookup
local rateLookup={}
allAttrRateLookup[lingshouAttributeType.eJingJie]=rateLookup

local attrs=lingshouModel.getJJAttrList(lsData.jj_lvl,lsData.cfg.race)
if attrs then
for i,v in ipairs(attrs)do
jjLookup[v[1]]=v[2]
end
end

local rate=0
local attrsBase=cfgHelper.getdef(cfg_attributesconfig,'attrsBase')
for index,type in ipairs(attrsBase)do
rateLookup[type]=rate
end
end

function lingshouModel:calculationQLAttrLookup(lsData)
local allAttrLookup=lsData.allAttrLookup
local allAttrRateLookup=lsData.allAttrRateLookup

local qlLookup={}
allAttrLookup[lingshouAttributeType.eQianLi]=qlLookup
local rateLookup={}
allAttrRateLookup[lingshouAttributeType.eQianLi]=rateLookup

local ql=lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.QIANLI)
local qlcfg=cfgHelper.get(cfg_lingshouqianliconfig_get,ql)
if qlcfg and qlcfg.attrs then
for i,v in ipairs(qlcfg.attrs)do
qlLookup[v[1]]=v[2]
end
end

local rate=lingshouModel.getQianLiToJJAttrRate(lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.QIANLI))
local attrsBase=cfgHelper.getdef(cfg_attributesconfig,'attrsBase')
for index,type in ipairs(attrsBase)do
rateLookup[type]=rate
end
end

function lingshouModel:calculationXMAttrLookup(lsData)
local allAttrLookup=lsData.allAttrLookup
local allAttrRateLookup=lsData.allAttrRateLookup

local xmLookup={}
allAttrLookup[lingshouAttributeType.eXueMai]=xmLookup
local rateLookup={}
allAttrRateLookup[lingshouAttributeType.eXueMai]=rateLookup

local point=lsData.xuemai_dianshu
local xmcfg=lingshouModel:getLevelConfig3Ex_XueMai(lsData,lsData.xuemai_val)
if xmcfg and xmcfg.attrs[point]then
for i,v in ipairs(xmcfg.attrs[point])do
xmLookup[v[1]]=v[2]
end
end

local rate=xmcfg.percent[lsData.xuemai_dianshu]
local attrsBase=cfgHelper.getdef(cfg_attributesconfig,'attrsBase')
for index,type in ipairs(attrsBase)do
rateLookup[type]=rate
end
end

function lingshouModel:calculationDJobAttrLookup(lsData)
local allAttrLookup=lsData.allAttrLookup
local allAttrRateLookup=lsData.allAttrRateLookup

local xmLookup={}
allAttrLookup[lingshouAttributeType.eDJob]=xmLookup
local rateLookup={}
allAttrRateLookup[lingshouAttributeType.eDJob]=rateLookup

local dzGuid=lingshouModel:getDiziguidByLsGuid(lsData.guid)
if dzGuid==nil then return end
local jobLevel=UIDiscipleModel:getDiscipleJobLevel(dzGuid,DISCIPLE_PROSKILL_TYPE.eSiYang)
local rate=cfgHelper.get(cfg_discipleproskillconfig_get,DISCIPLE_PROSKILL_TYPE.eSiYang,'yushou_attr_per',jobLevel)
local attrsBase=cfgHelper.getdef(cfg_attributesconfig,'attrsBase')
for index,type in ipairs(attrsBase)do
rateLookup[type]=rate
end
end

function lingshouModel:calculationDJobAttrLookup_otherDZ(lsData,netData)
local allAttrLookup=lsData.allAttrLookup
local allAttrRateLookup=lsData.allAttrRateLookup

local xmLookup={}
allAttrLookup[lingshouAttributeType.eDJob]=xmLookup
local rateLookup={}
allAttrRateLookup[lingshouAttributeType.eDJob]=rateLookup

local jobLevel=UIDiscipleModel:getDiscipleJobLevelEx(netData,DISCIPLE_PROSKILL_TYPE.eSiYang)
local rate=cfgHelper.get(cfg_discipleproskillconfig_get,DISCIPLE_PROSKILL_TYPE.eSiYang,'yushou_attr_per',jobLevel)
local attrsBase=cfgHelper.getdef(cfg_attributesconfig,'attrsBase')
for index,type in ipairs(attrsBase)do
rateLookup[type]=rate
end
end


function lingshouModel:calculationTraitAttrLookup(lsData)
local allAttrLookup=lsData.allAttrLookup
local allAttrRateLookup=lsData.allAttrRateLookup

local tLookup={}
allAttrLookup[lingshouAttributeType.eTrait]=tLookup
local rateLookup={}
allAttrRateLookup[lingshouAttributeType.eTrait]=rateLookup

local attrsBase=cfgHelper.getdef(cfg_attributesconfig,'attrsBase')
for index,type in ipairs(attrsBase)do
local rate=lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.BASE_ATTR_TRAIT_ADD_PERVENT_JX,type)
rateLookup[type]=rate
end
end

function lingshouModel:calculationDzGongFaAttrLookup(lsData)
local allAttrLookup=lsData.allAttrLookup
local allAttrRateLookup=lsData.allAttrRateLookup

local tLookup={}
allAttrLookup[lingshouAttributeType.eDzGongFa]=tLookup
local rateLookup={}
allAttrRateLookup[lingshouAttributeType.eDzGongFa]=rateLookup

local dzGuid=lingshouModel:getDiziguidByLsGuid(lsData.guid)
if dzGuid==nil then return end
local skillList=UIDiscipleModel:getDiscipleUsingGFSkillList2(dzGuid)
for index,skillInfo in ipairs(skillList)do
local gfID=skillInfo[1]
local skillID=skillInfo[2]
local idx=skillInfo[3]
local lingshou_attr_per_conf=cfgHelper.get(cfg_disciplegongfaconfig_get,gfID,'lingshou_attr_per_conf')

if lingshou_attr_per_conf and lingshou_attr_per_conf[skillID]then
local gflv=UIDiscipleModel:getDiscipleGFLevel(dzGuid,gfID)
local levels=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'level')
local level=levels[gflv]
local lv=level[idx]
if lv>0 then
lv=UIDiscipleModel:getSkillLv(dzGuid,skillID,lv)
local attrs=lingshou_attr_per_conf[skillID][lv]
if attrs then
for _,data in ipairs(attrs)do
local type=data[1]
local rate=data[2]

rateLookup[type]=rateLookup[type]or 0
rateLookup[type]=rateLookup[type]+rate
end
end
end
end
end
end

function lingshouModel:calculationDzGongFaAttrLookup_otherDz(lsData,netData)
local allAttrLookup=lsData.allAttrLookup
local allAttrRateLookup=lsData.allAttrRateLookup

local tLookup={}
allAttrLookup[lingshouAttributeType.eDzGongFa]=tLookup
local rateLookup={}
allAttrRateLookup[lingshouAttributeType.eDzGongFa]=rateLookup

local skillList=UIDiscipleModel:getDiscipleUsingGFSkillList2Ex(netData)
for index,skillInfo in ipairs(skillList)do
local gfID=skillInfo[1]
local skillID=skillInfo[2]
local idx=skillInfo[3]
local lingshou_attr_per_conf=cfgHelper.get(cfg_disciplegongfaconfig_get,gfID,'lingshou_attr_per_conf')

if lingshou_attr_per_conf and lingshou_attr_per_conf[skillID]then
local gflv=UIDiscipleModel:getDiscipleGFLevelEx(netData,gfID)
local levels=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'level')
local level=levels[gflv]
local lv=level[idx]
if lv>0 then
lv=UIDiscipleModel:getSkillLv(netData.guid,skillID,lv)
local attrs=lingshou_attr_per_conf[skillID][lv]
if attrs then
for _,data in ipairs(attrs)do
local type=data[1]
local rate=data[2]

rateLookup[type]=rateLookup[type]or 0
rateLookup[type]=rateLookup[type]+rate
end
end
end
end
end
end



function lingshouModel:setAttrListDirty(lsData,attrType,showFightTips)
local guid=lsData.guid
local func=attribute_refresh_funcs[attrType]
if func then
func.refresh(lsData)
func.dirty(lsData)
end
lsData.allAttrListDirty=true
lingshouModel:setFightDirty(guid,showFightTips)

if lingshouModel:isMyActorLS(guid)then
notifySystem:postNotify(notifyConfig.onLingShouAttrChange,guid,attrType)
end
end

function lingshouModel:setAttrListDirtyX(guid,attrType,showFightTips)
local lsData=lingshouModel:getLingShouData(guid)
lingshouModel:setAttrListDirty(lsData,attrType,showFightTips)

local dzGuid=lingshouModel:getDiziguidByLsGuid(guid)
if dzGuid then
if attrType==lingshouAttributeType.eDzGongFa then
UIDiscipleModel:setSkillLvPlusLookupDirty(dzGuid,false)
lingshouModel:setAttrListDirty(lsData,attrType,false)
end
UIDiscipleModel:setDiscipleAttrListDirtyX(dzGuid,DISCIPLE_ATTRIBUTE_TYPE.eEquip,false)
end
end

function lingshouModel:setAttrListDirtyXByDzGuid(dzGuid,attrType,showFightTips)
local lsGuid=lingshouModel:getLingShouByDizi(dzGuid)
if lsGuid==nil then return end

local lsData=lingshouModel:getLingShouData(lsGuid)
lingshouModel:setAttrListDirty(lsData,attrType,showFightTips)

if attrType==lingshouAttributeType.eDzGongFa then
UIDiscipleModel:setSkillLvPlusLookupDirty(dzGuid,false)
lingshouModel:setAttrListDirtyX(lsData.guid,lingshouAttributeType.eDzGongFa,false)
end
UIDiscipleModel:setDiscipleAttrListDirtyX(dzGuid,DISCIPLE_ATTRIBUTE_TYPE.eEquip,false)
end

function lingshouModel:setAttrListDirtyXByDzGuid2(dzGuid,attrType,showFightTips)
local lsGuid=lingshouModel:getLingShouByDizi(dzGuid)
if lsGuid==nil then return end
local lsData=lingshouModel:getLingShouData(lsGuid)
lingshouModel:setAttrListDirty(lsData,attrType,showFightTips)
end

function lingshouModel:setAttrListDirty2(lsData,attrTypeList,showFightTips)
local guid=lsData.guid
for index,attrType in ipairs(attrTypeList)do
local func=attribute_refresh_funcs[attrType]
if func then
func.refresh(lsData)
func.dirty(lsData)
end

if lingshouModel:isMyActorLS(guid)then
notifySystem:postNotify(notifyConfig.onLingShouAttrChange,guid,attrType)
end
end

lsData.allAttrListDirty=true
lingshouModel:setFightDirty(guid,showFightTips)
end


function lingshouModel:setAttrListDirtyX2(guid,attrTypeList,showFightTips)
local lsData=lingshouModel:getLingShouData(guid)
lingshouModel:setAttrListDirty2(lsData,attrTypeList,showFightTips)

local dzGuid=lingshouModel:getDiziguidByLsGuid(guid)
if dzGuid then
if table.findValue(attrTypeList,lingshouAttributeType.eDzGongFa)then
UIDiscipleModel:setSkillLvPlusLookupDirty(dzGuid,false)
lingshouModel:setAttrListDirtyX(lsData.guid,lingshouAttributeType.eDzGongFa,false)
end
UIDiscipleModel:setDiscipleAttrListDirtyX(dzGuid,DISCIPLE_ATTRIBUTE_TYPE.eEquip,false)
end
end


function lingshouModel:setAttrListDirtyX3(dzGuid,guid,attrTypeList,showFightTips)
local lsData=lingshouModel:getLingShouData(guid)
lingshouModel:setAttrListDirty2(lsData,attrTypeList,showFightTips)

if dzGuid then
if table.findValue(attrTypeList,lingshouAttributeType.eDzGongFa)then
UIDiscipleModel:setSkillLvPlusLookupDirty(dzGuid,false)
lingshouModel:setAttrListDirtyX(lsData.guid,lingshouAttributeType.eDzGongFa,false)
end
UIDiscipleModel:setDiscipleAttrListDirtyX(dzGuid,DISCIPLE_ATTRIBUTE_TYPE.eEquip,false)
end
end



function lingshouModel:getAttrByType(guid,ty,isex)
local lsData=lingshouModel:getLingShouData(guid)
local temp=lingshouModel:getAllAttrList(lsData,isex)
return temp[ty]or 0
end

function lingshouModel:getAttrListByType(guid,typelist,isex,zero_hide)
local lsData=lingshouModel:getLingShouData(guid)
return lingshouModel:getAttrListByTypeEx(lsData,typelist,isex,zero_hide)
end

function lingshouModel:getAttrListByTypeEx(lsData,typelist,isex,zeroCheckType)
local list={}
if not lsData then
return list
end
local temp=lingshouModel:getAllAttrList(lsData,isex)
for i,v in ipairs(typelist)do
local n=temp[v]or 0
local zeroCheck=false
if zeroCheckType==1 then

local cfg=helper.getAttributeCfg(v)
if cfg.zero_hide then
zeroCheck=true
end
elseif zeroCheckType==2 then

zeroCheck=true
end
if zeroCheck then
if n>0 then
table_insert(list,{v,n})
end
else
table_insert(list,{v,n})
end
end
return list
end

function lingshouModel:getAllAttrListSort(guid,isex)
local result={}
local cfgs=cfg_attributesconfig()
local lsData=lingshouModel:getLingShouData(guid)
local temp=lingshouModel:getAllAttrList(lsData,isex)
for k,v in pairs(cfgs)do
if v.id~=nil then
local a=temp[v.id]or 0
if v.zero_hide then
if a>0 then
table_insert(result,{v.id,a})
end
else
table_insert(result,{v.id,a})
end
end
end
UIDiscipleModel.sortAttrList(result)
return result
end

function lingshouModel:getFightValue(guid)
local lsData=lingshouModel:getLingShouData(guid)
return lingshouModel.getFightValueEx(lsData)
end

function lingshouModel.getFightValueEx(lsData)
if lsData.fightValue==nil then
lingshouModel:calculationFight(lsData)
end
return lsData.fightValue
end

function lingshouModel:setFightDirty(guid,showFightTips)
local lsData=lingshouModel:getLingShouData(guid)
lingshouModel:setFightDirtyEx(lsData,showFightTips)
end
function lingshouModel:calculationFight(lsData)
local attrlist=lingshouModel:getAllAttrList(lsData)
lsData.fightValue=cfgHelper.getFight(attrlist)
end
function lingshouModel:setFightDirtyEx(lsData,showFightTips)
local lastVal=lingshouModel.getFightValueEx(lsData)
lingshouModel:calculationFight(lsData)
local val=lingshouModel.getFightValueEx(lsData)
local isChanged=lastVal~=val
local guid=lsData.guid
if isChanged and lingshouModel:isMyActorLS(guid)then

lingshouModel:resetFightLingShouGuidList()

if showFightTips then
notifySystem:postNotify(notifyConfig.onLingShouFightChanged,guid,lastVal,val)
end
end
end

function lingshouModel:getCharacterAttrs(qianli)
local effectRates={}
local qlcfg=cfgHelper.get(cfg_lingshouqianliconfig_get,qianli)
if qlcfg.effect then
for i,v in ipairs(qlcfg.effect)do
if v[1]==2 then
effectRates[v[2]]=v[3]/100
end
end
end
return effectRates
end

function lingshouModel:getLingShouAttrsLookup(dzguid)
local ls_guid=UIDiscipleModel:getDZLingShou(dzguid)
local attrs
if ls_guid then
local lsData=lingshouModel:getLingShouData(ls_guid)

if lsData~=nil then
attrs=lingshouModel:getAllAttrList(lsData)
end
end

if not attrs then
attrs={}
end
return attrs
end


function lingshouModel:test_print_attr_caculete_part(lsGuidStr)
local lsGuid=int64.new(lsGuidStr)
local lsData=lingshouModel:getLingShouData2(lsGuid)
lingshouModel:initAttrLookup(lsData)


logErr('lingshou attr print start >>>>>>>>>>>>>',tostring(lsData.guid))
logErr('lingshou attr list :',serializeHelper.serialize(lsData.allAttrList))
logErr('lingshou attr list lookup:',serializeHelper.serialize(lsData.allAttrLookup))
logErr('lingshou attr rate list lookup:',serializeHelper.serialize(lsData.allAttrRateLookup))
logErr('lingshou attr print end >>>>>>>>>>>>>')
end
