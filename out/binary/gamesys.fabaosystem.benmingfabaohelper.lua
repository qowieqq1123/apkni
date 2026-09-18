benMingFaBaoHelper={}


local _lxeffectType=
{
addjllv=1,
addlianhuanum=2,
addBaseAttrPercent=3,
addmainfabaoshentonglv=4,
addsecfabaoshentonglv=5,
addthreefabaoshentonglv=6,
addlxAttrPrecent=7,
}
LINGXING_EFFECT_TYPE=_lxeffectType

local _effectName=
{
[_lxeffectType.addjllv]='精炼',
[_lxeffectType.addlianhuanum]='炼化',
[_lxeffectType.addBaseAttrPercent]='属性',
[_lxeffectType.addmainfabaoshentonglv]='神通',
[_lxeffectType.addsecfabaoshentonglv]='神通',
[_lxeffectType.addthreefabaoshentonglv]='神通',
[_lxeffectType.addlxAttrPrecent]='灵光',
}

local _effectDesc=
{
[_lxeffectType.addjllv]=function(equip,val)
return FMT.fmt('法宝精炼上限+{0}',val)
end,
[_lxeffectType.addlianhuanum]=function(equip,val)
return FMT.fmt('法宝炼化材料上限+{0}',val)
end,
[_lxeffectType.addBaseAttrPercent]=function(equip,val)
return FMT.fmt('法宝基础属性+{0}%',val)
end,
[_lxeffectType.addmainfabaoshentonglv]=function(equip,val)
local shengInfos=benMingFaBaoHelper.getShentongInfoList(equip)
local shengInfo=shengInfos[1]
local cfg=fabaoConfig.getShentongConfig(shengInfo[1])
return FMT.fmt('{0}等级+{1}',cfg.name,val)
end,
[_lxeffectType.addsecfabaoshentonglv]=function(equip,val)
local shengInfos=benMingFaBaoHelper.getShentongInfoList(equip)
local shengInfo=shengInfos[2]
local cfg=fabaoConfig.getShentongConfig(shengInfo[1])
return FMT.fmt('{0}等级+{1}',cfg.name,val)
end,
[_lxeffectType.addthreefabaoshentonglv]=function(equip,val)
local shengInfos=benMingFaBaoHelper.getShentongInfoList(equip)
local shengInfo=shengInfos[3]
local cfg=fabaoConfig.getShentongConfig(shengInfo[1])
return FMT.fmt('{0}等级+{1}',cfg.name,val)
end,
[_lxeffectType.addlxAttrPrecent]=function(equip,val)
return FMT.fmt('法宝灵性属性+{0}%',val)
end,
}


function benMingFaBaoHelper.getLxEffect(lxlv)
local lxcfg=fabaoConfig.getLxConfig(lxlv)
return lxcfg.bonus
end


function benMingFaBaoHelper.getLxEffectList(lxlv)
local lxcfg=fabaoConfig.getLxConfig(lxlv)
local bonus=lxcfg.bonus
local temp={}
for i,v in ipairs(bonus)do
if v>0 then
temp[#temp+1]={i,v}
end
end
return temp
end

function benMingFaBaoHelper.getEffectValue(lxlv,effectType)
return benMingFaBaoHelper.getLxEffect(lxlv)[effectType]
end

function benMingFaBaoHelper.getDiffDesc(equip,effectType,lastval,val)
local name=_effectName[effectType]
local add=lastval and(val-lastval)or val
local desc=_effectDesc[effectType](equip,add)
return name,desc
end
function benMingFaBaoHelper.getDesc(equip,lxlv,effectType)
local val=benMingFaBaoHelper.getLxEffect(lxlv)[effectType]
local name=_effectName[effectType]
local desc=_effectDesc[effectType](equip,val)
return name,desc
end

function benMingFaBaoHelper.getDescByType(itemguid,lxlv,effectType)
local equip=fabaoHelper.getFabao(itemguid)
return benMingFaBaoHelper.getDesc(equip,lxlv,effectType)
end


function benMingFaBaoHelper.getAddShentonglv(itemguid,idx)
local equip=fabaoHelper.getFabao(itemguid)
if not fabaoConfig.isBenMingFabao(equip.itemid)then return 0 end
local lxlv=fabaoModel.getLingXingLv(itemguid)
idx=idx or benMingFaBaoHelper.getNowMainIdx(equip)
local effectType=_lxeffectType.addmainfabaoshentonglv
if idx==2 then
effectType=_lxeffectType.addsecfabaoshentonglv
elseif idx==3 then
effectType=_lxeffectType.addthreefabaoshentonglv
end
return benMingFaBaoHelper.getLxEffect(lxlv)[effectType]or 0
end


function benMingFaBaoHelper.getAddJllv(itemguid)
local equip=fabaoHelper.getFabao(itemguid)
if not fabaoConfig.isBenMingFabao(equip.itemid)then return 0 end
local lxlv=fabaoModel.getLingXingLv(itemguid)
local effectType=_lxeffectType.addjllv
return benMingFaBaoHelper.getLxEffect(lxlv)[effectType]or 0
end


function benMingFaBaoHelper.getAddlhnum(itemguid)
local equip=fabaoHelper.getFabao(itemguid)
if not fabaoConfig.isBenMingFabao(equip.itemid)then return 0 end
local lxlv=fabaoModel.getLingXingLv(itemguid)
local effectType=_lxeffectType.addlianhuanum
return benMingFaBaoHelper.getLxEffect(lxlv)[effectType]or 0
end


function benMingFaBaoHelper.getAddBaseAttrPrecent(itemguid)
local equip=fabaoHelper.getFabao(itemguid)
if not fabaoConfig.isBenMingFabao(equip.itemid)then return 0 end
local lxlv=fabaoModel.getLingXingLv(itemguid)
local effectType=_lxeffectType.addBaseAttrPercent
return benMingFaBaoHelper.getLxEffect(lxlv)[effectType]or 0
end


function benMingFaBaoHelper.getAddLxAttrPrecent(itemguid)
local equip=fabaoHelper.getFabao(itemguid)
if not fabaoConfig.isBenMingFabao(equip.itemid)then return 0 end
local lxlv=fabaoModel.getLingXingLv(itemguid)
local effectType=_lxeffectType.addlxAttrPrecent
return benMingFaBaoHelper.getLxEffect(lxlv)[effectType]or 0
end




function benMingFaBaoHelper.getLingXingAttrsList(item)
local itemguid=item.itemguid
local equip=fabaoHelper.getFabao(itemguid)
if not fabaoConfig.isBenMingFabao(equip.itemid)then return nil end
if fabaoHelper.isDressed(itemguid)and not benMingFaBaoHelper.isDressSelf(equip)then return nil end
local mainid=fabaoHelper.getReallyMainId(equip)
local lxlv=fabaoModel.getLingXingLv(itemguid)
local attr=benMingFaBaoHelper.getLxAttr(mainid,lxlv)or{}
local lxpe=benMingFaBaoHelper.getAddLxAttrPrecent(itemguid)
local percent=lxpe
local baseList=attrListHelper.getAddListOnPercent(attr,percent,true)
return attrListHelper.concatList(baseList,attr)
end


function benMingFaBaoHelper.getLingXingBaseAttrs(item)
local itemguid=item.itemguid
local equip=fabaoHelper.getFabao(itemguid)
if not fabaoConfig.isBenMingFabao(equip.itemid)then return nil end
if fabaoHelper.isDressed(itemguid)and not benMingFaBaoHelper.isDressSelf(equip)then return nil end
local mainid=fabaoHelper.getReallyMainId(equip)
local lxlv=fabaoModel.getLingXingLv(itemguid)
local attr=benMingFaBaoHelper.getLxAttr(mainid,lxlv)
return attr
end


function benMingFaBaoHelper.setOwnerByEquip(equip,dzguid)
equip.itemData.discipleguid=dzguid
end

function benMingFaBaoHelper.getOwnerByEquip(equip)
return equip.itemData.discipleguid
end


function benMingFaBaoHelper.hasOwnerByEquip(equip)
local dzguid=benMingFaBaoHelper.getOwnerByEquip(equip)
if dzguid and dzguid~=0 then
local dzInfo=UIDiscipleModel:getMyDiscipleData(dzguid)
if dzInfo==nil then
return false
end
return true,dzguid
end
return false
end


function benMingFaBaoHelper.getOwner(itemguid)
local equip=fabaoHelper.getFabao(itemguid)
return benMingFaBaoHelper.getOwnerByEquip(equip)
end


function benMingFaBaoHelper.checkOwner(itemguid)
local equip=fabaoHelper.getFabao(itemguid)
local has=benMingFaBaoHelper.hasOwnerByEquip(equip)
return has
end


function benMingFaBaoHelper.hasOwner(itemguid)
local equip=fabaoHelper.getFabao(itemguid)
return benMingFaBaoHelper.hasOwnerByEquip(equip)
end


function benMingFaBaoHelper.isDressSelf(equip)
local itemguid=equip.itemguid
local hasOwner,ownerdz=benMingFaBaoHelper.hasOwnerByEquip(equip)
local dressdz=fabaoModel.getDiziguidStrByItemguid(itemguid)
return hasOwner and dressdz==tostring(ownerdz)or false
end



function benMingFaBaoHelper.getCiZhui(itemid)
local itemCfg=itemsConfig.getConfig(itemid)
return itemCfg.cz[1]
end



function benMingFaBaoHelper.getLxAttr(itemid,lxlv)
local lxcfg=fabaoConfig.getLxConfig(lxlv)
local itemCfg=itemsConfig.getConfig(itemid)
local type1=itemCfg.type1
local type2=itemCfg.type2
local typeEx=type1*65536+type2
local attr=lxcfg.attr[typeEx]
return attr
end


function benMingFaBaoHelper.getMaterialsInfoList(equip)
return equip.itemData.rawList
end


function benMingFaBaoHelper.getNowMainIdx(equip)
return equip.itemData.mainidx
end


function benMingFaBaoHelper.getShentongInfoList(equip)
local rawList=benMingFaBaoHelper.getMaterialsInfoList(equip)
local shentongInfos={}
for i,info in ipairs(rawList)do
local mainid=info.param_2
local id=itemsConfig.getConfig(mainid).shentong
shentongInfos[#shentongInfos+1]={id,info.param_1}
end
return shentongInfos
end


function benMingFaBaoHelper.getNowShentongInfo(equip)
local shentongInfos=benMingFaBaoHelper.getShentongInfoList(equip)
local idx=benMingFaBaoHelper.getNowMainIdx(equip)
return shentongInfos[idx]
end


function benMingFaBaoHelper.getDefaultName(itemid,mainfbtype)
local itemCfg=itemsConfig.getConfig(itemid)


local qianzhuiName=itemCfg.fabaoname[1]


local midName=itemCfg.fabaoname[2][mainfbtype]


local yptype=itemCfg.type1
local houzhuiName=cfg_fabaoyuanpeitypeconfig_get(yptype).name

local name=FMT.fmt('{0}{1}{2}',qianzhuiName,midName,houzhuiName)


return name
end

function benMingFaBaoHelper.hasFabaoTypeByEquip(equip,fbtype)
local fbtypeList=equip.itemData.fbtypeList
return benMingFaBaoHelper.hasFabaoType(fbtypeList,fbtype)
end

function benMingFaBaoHelper.hasFabaoType(fbtypeList,fbtype)
if fbtypeList==nil then return false end
for i,v in ipairs(fbtypeList)do
if v==fbtype then return true end
end
return false
end

function benMingFaBaoHelper.getStaticAttrs(itemid,ypitemid,transform)
local itemCfg=itemsConfig.getConfig(itemid)
local ypitemCfg=itemsConfig.getConfig(ypitemid)
local stage=itemCfg.stage
local color=itemCfg.color
local attrs=ypitemCfg.static[stage][color]
if transform then
return attrListHelper.transformToNamedList(attrs)
end
return attrs
end

function benMingFaBaoHelper.canlxUp(itemguid,warn)
local equip=fabaoModel.getFabao(itemguid)
if not equip then return false end
if not benMingFaBaoHelper.isDressSelf(equip)then return false end
local dzguid=benMingFaBaoHelper.getOwnerByEquip(equip)
local lxlv=fabaoModel.getLingXingLv(itemguid)
local jjlv=UIDiscipleModel:getDiscipleJJLevel(dzguid)
local needjjlv=fabaoConfig.getNeedJingjielvByLx(lxlv)
if needjjlv>jjlv then
if warn then
UIManager.error('主人境界等级不足')
end
return false
end

local cur=fabaoModel.getFabaoLingXingExp(itemguid)
local need=fabaoConfig.getNeedLxExpByLx(lxlv)
if cur<need then
if warn then
UIManager.error('灵性值不足')
end
return false
end

local cost=fabaoConfig.getTuPoLxCost(lxlv)
for i,v in ipairs(cost or{})do
local itemid=v[1]
local need=v[2]
if itemsModel.getCount(itemid)<need then
if warn then
local name=itemsModel.getName(itemid)
UIManager.error(FMT.fmt('{0}不足',name))
end
return false
end
end
return true
end

function benMingFaBaoHelper.isAbsorbExp(dzguid)
local equip=fabaoModel.getFabaoByDizi(dzguid)
if equip==nil then return false end
local yunyangSetting=fabaoModel.isYunYang(equip)
if not yunyangSetting then return false end
if dzguid==nil then return false end
local expRate=fabaoModel.getAbsorbExpRate(dzguid)
return expRate>0
end
