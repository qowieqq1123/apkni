







DISCIPLE_BASE_ATTR_TYPE=
{
eZiZhi=1,
eGenGu=2,
eCongHui=3,
eQianLi=4,
eMeiLi=5,
eJiYuan=6,
}



function UIDiscipleModel:getDiscipleBaseAttr(guid,baseAttrType)
local netData=UIDiscipleModel:getDiscipleData(guid)
return netData.attrList[baseAttrType]
end


function UIDiscipleModel:getDiscipleSixAttrSum(netData)
local num=UIDiscipleModel:getDiscipleBaseAttrSumEx(netData.attrList)
return num
end



function UIDiscipleModel:getBaseAttrBaseByType(guid,baseAttrType)
local netData=UIDiscipleModel:getDiscipleData(guid)
local attrListBase=UIDiscipleModel:getBaseAttrBaseEx(netData)
return attrListBase[baseAttrType]
end

function UIDiscipleModel:getBaseAttrBaseSum(netData)
local attrListBase=UIDiscipleModel:getBaseAttrBaseEx(netData)
local num=UIDiscipleModel:getDiscipleBaseAttrSumEx(attrListBase)
return num
end

function UIDiscipleModel:getFixAttrBase(netData)
local fix_attrList=table.deepCopy(netData.notfix_attrList)
local discipleattrrange=cfgHelper.getglobal1('discipleattrrange')
local range

local post=UIDiscipleModel:getDisciplePostEX(netData)
local posteffect={}
local effects_myself=cfgHelper.get2(cfg_guildposconfig_get,post,'effects_myself')
if effects_myself then
for i,v in ipairs(effects_myself)do
if v.type==1 then
posteffect=v.param
break
end
end
end
range=discipleattrrange[2]
for attrType,v in pairs(posteffect)do
local n=v
local r=range[attrType]
if n<r[1]then
n=r[1]
elseif n>r[2]then
n=r[2]
end
n=-n
fix_attrList[attrType]=fix_attrList[attrType]+n
end

range=discipleattrrange[3]
local spelookup=dzSpecialityGrowEffectController:getSixAttrValueLookup(netData)
for attrType,v in pairs(spelookup)do
if v~=0 then
local n=v
local r=range[attrType]
if n<r[1]then
n=r[1]
elseif n>r[2]then
n=r[2]
end
n=-n
fix_attrList[attrType]=fix_attrList[attrType]+n
end
end

range=discipleattrrange[4]
for k,attrType in pairs(DISCIPLE_BASE_ATTR_TYPE)do
local n=UIFuLuFangModel.getFuBaoEffectEx(netData,FUBAO_EFFECT_TYPE.eSixAttr,attrType)
if n~=0 then
local r=range[attrType]
if n<r[1]then
n=r[1]
elseif n>r[2]then
n=r[2]
end
n=-n
fix_attrList[attrType]=fix_attrList[attrType]+n
end
end


local clothing=ClothingModel:getEquipByDizi(netData.discipleguid)
if clothing then
local clothingId=clothing.itemid
local clothingStar=clothing.itemData and clothing.itemData.star or 0
local baseAttrs,diziAttrs=ClothingHelper.getEquipBaseAttrsLookupByItemid(clothingId,clothingStar)
if diziAttrs then
for attrType,v in pairs(diziAttrs)do
if v~=0 then
fix_attrList[attrType]=fix_attrList[attrType]-v
end
end
end
end


local ls_guid=UIDiscipleModel:getDZLingShou(netData.discipleguid)
if ls_guid then
local lsData=lingshouModel:getLingShouData(ls_guid)
if lsData then
for k,attrType in pairs(DISCIPLE_BASE_ATTR_TYPE)do
local v=lingshouModel:getLingShouTraitEffect(lsData,lingshouTraitEffectEnum.DISCIPLE_SIX_ATTR_ADD,attrType)or 0
if v~=0 then
fix_attrList[attrType]=fix_attrList[attrType]-v
end
end
end
end

return fix_attrList
end

function UIDiscipleModel:getFixAttrBase2(netData)
local fix_attrList=table.deepCopy(netData.notfix_attrList)
local discipleattrrange=cfgHelper.getglobal1('discipleattrrange')
local range

local post=UIDiscipleModel:getDisciplePostEX(netData)
local posteffect={}
local effects_myself=cfgHelper.get2(cfg_guildposconfig_get,post,'effects_myself')
if effects_myself then
for i,v in ipairs(effects_myself)do
if v.type==1 then
posteffect=v.param
break
end
end
end
range=discipleattrrange[2]
for attrType,v in pairs(posteffect)do
local n=v
local r=range[attrType]
if n<r[1]then
n=r[1]
elseif n>r[2]then
n=r[2]
end
n=-n
fix_attrList[attrType]=fix_attrList[attrType]+n
end

range=discipleattrrange[4]
for k,attrType in pairs(DISCIPLE_BASE_ATTR_TYPE)do
local n=UIFuLuFangModel.getFuBaoEffectEx(netData,FUBAO_EFFECT_TYPE.eSixAttr,attrType)
if n~=0 then
local r=range[attrType]
if n<r[1]then
n=r[1]
elseif n>r[2]then
n=r[2]
end
n=-n
fix_attrList[attrType]=fix_attrList[attrType]+n
end
end


local clothing=ClothingModel:getEquipByDizi(netData.discipleguid)
if clothing then
local clothingId=clothing.itemid
local clothingStar=clothing.itemData and clothing.itemData.star or 0
local baseAttrs,diziAttrs=ClothingHelper.getEquipBaseAttrsLookupByItemid(clothingId,clothingStar)
if diziAttrs then
for attrType,v in pairs(diziAttrs)do
if v~=0 then
fix_attrList[attrType]=fix_attrList[attrType]-v
end
end
end
end


local ls_guid=UIDiscipleModel:getDZLingShou(netData.discipleguid)
if ls_guid then
local lsData=lingshouModel:getLingShouData(ls_guid)
if lsData then
for k,attrType in pairs(DISCIPLE_BASE_ATTR_TYPE)do
local v=lingshouModel:getLingShouTraitEffect(lsData,lingshouTraitEffectEnum.DISCIPLE_SIX_ATTR_ADD,attrType)or 0
if v~=0 then
fix_attrList[attrType]=fix_attrList[attrType]-v
end
end
end
end

return fix_attrList
end

function UIDiscipleModel:getFixAttrBaseSum(netData)
local fix_attrList=UIDiscipleModel:getFixAttrBase(netData)
local sum=0
for attrType,v in ipairs(fix_attrList)do
sum=sum+v
end
return sum
end

function UIDiscipleModel:getBaseAttrBase(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getBaseAttrBaseEx(netData)
end

function UIDiscipleModel:setBaseAttrBaseDirty(netData)
netData.attrListBaseDirty=true
end

function UIDiscipleModel:getDiscipleBaseAttrSum2Color(netData)
local attrListBase=UIDiscipleModel:getBaseAttrBaseEx(netData)
return UIDiscipleModel:getDiscipleBaseAttrSum2ColorEx2(attrListBase)
end

function UIDiscipleModel:getDiscipleBaseAttrSum2Color2(netData)
local attrListBase=UIDiscipleModel:getFixAttrBase2(netData)
return UIDiscipleModel:getDiscipleBaseAttrSum2ColorEx2(attrListBase)
end

function UIDiscipleModel:getBaseAttrBaseEx(netData)
if netData.attrListBase==nil or netData.attrListBaseDirty==true then
netData.attrListBaseDirty=nil
local post=UIDiscipleModel:getDisciplePostEX(netData)
netData.attrListBase=UIDiscipleModel.calculationBaseAttrBase(post,netData.attrList)
end
return netData.attrListBase
end

function UIDiscipleModel.calculationBaseAttrBase(post,attrList)
local attrList_=table.deepCopy(attrList)
local posteffect={}
local effects_myself=cfgHelper.get2(cfg_guildposconfig_get,post,'effects_myself')
if effects_myself then
for i,v in ipairs(effects_myself)do
if v.type==1 then
posteffect=v.param
break
end
end
end
for i,v in ipairs(attrList_)do
local n=v
if posteffect[i]~=nil then
n=n-posteffect[i]
if n<0 then
n=v
end
end
attrList_[i]=n
end
return attrList_
end




function UIDiscipleModel:getDiscipleBaseAttrSum2ColorEx(post,attrList)
local attrListBase=UIDiscipleModel.calculationBaseAttrBase(post,attrList)
return UIDiscipleModel:getDiscipleBaseAttrSum2ColorEx2(attrListBase)
end

function UIDiscipleModel:getDiscipleBaseAttrSum2ColorEx2(attrListBase)
local num=UIDiscipleModel:getDiscipleBaseAttrSumEx(attrListBase)

local color=self:getDiscipleBaseAttrSum2ColorEx3(num)
return color
end

function UIDiscipleModel:getDiscipleBaseAttrSum2ColorEx3(num)
local color=nil
local discipleattrcolor=cfgHelper.getglobal1('discipleattrcolor')
for i,v in ipairs(discipleattrcolor)do
if num>=v[1]and num<=v[2]then
color=v[3]
break
end
end
return color
end

function UIDiscipleModel:getDiscipleBaseAttrSumEx(baseAttrs)
local num=0
for i,v in ipairs(baseAttrs)do
num=num+v
end
if num==0 then num=1 end
return num
end

function UIDiscipleModel:getDiscipleBaseAttrDesc(baseAttrType,val,fmt_str)
fmt_str=fmt_str or'{0}:{1}'
local name=UIDiscipleModel:getDiscipleBaseAttrName(baseAttrType)
return FMT.fmt(fmt_str,name,val)
end

function UIDiscipleModel:getDiscipleBaseAttrName(baseAttrType)
return cfgHelper.getglobal3('discipleattr',baseAttrType,'name')
end


function UIDiscipleModel:getDiscipleBaseAttrExList(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getDiscipleBaseAttrExListByData(netData)
end

function UIDiscipleModel:getDiscipleBaseAttrExListByData(netData)
if netData.baseAttrExList==nil or netData.baseAttrExDirty then

local baseAttrExList={}
local discipleattrex=cfg_globalconfig_get(1).discipleattrex

for i,v in ipairs(netData.attrList)do
baseAttrExList[i]={}
for i1,v1 in ipairs(discipleattrex[i])do
baseAttrExList[i][i1]=v1*v
end
end
netData.baseAttrExList=baseAttrExList
netData.baseAttrExDirty=false
end
return netData.baseAttrExList
end


function UIDiscipleModel:getDiscipleBaseAttrExListX(guid,attrType)
local baseAttrExList=UIDiscipleModel:getDiscipleBaseAttrExList(guid)
return baseAttrExList[attrType]
end


function UIDiscipleModel:getDiscipleBaseAttrExListXXByData(netData,attrType,idx)
local baseAttrExListX=UIDiscipleModel:getDiscipleBaseAttrExListByData(netData)
return baseAttrExListX[attrType][idx]
end


function UIDiscipleModel:getDiscipleBaseAttrExListXX(guid,attrType,idx)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getDiscipleBaseAttrExListXXByData(netData,attrType,idx)
end


function UIDiscipleModel:setDiscipleBaseAttrExDirty(netData)
netData.baseAttrExDirty=true
end


function UIDiscipleModel:setDiscipleBaseAttrExDirtyX(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
UIDiscipleModel:setDiscipleBaseAttrExDirty(netData)
end


function UIDiscipleModel:getBaseAttrAdd(sum,target,attr)
local ratio=attr/sum
return math.floor(ratio*(target-sum))
end

function UIDiscipleModel:canAddBaseAttrToTarget(sum,target,attrList)
for i,v in pairs(DISCIPLE_BASE_ATTR_TYPE)do
if attrList[v]then
local add=self:getBaseAttrAdd(sum,target,attrList[v])
if add>0 then
return true
end
end
end
return false
end