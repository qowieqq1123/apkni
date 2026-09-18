














DISCIPLE_ATTRIBUTE_TYPE={
eBase=1,
eJob=2,
eJingJie=3,
eLianTi=4,
eGongFa=5,
eEquip=6,
eSpecial=7,
eInjury=8,
eSkill=9,
eTianMing=10,
eTianMingCiFu=11,
eQiZhen=12,
eTianDaoShu=13,
eCuiTi=14,
eYuFu=15,
eMount=16,
eVaryLingGen=17,
eXianMoDaoHeng=18,
eLittleWorld=19,
eWanLingTa=20,
eDaoYan=21,

}

local disciple_attribute_refresh_funcs={

[DISCIPLE_ATTRIBUTE_TYPE.eJob]={
refresh=function(guid)
UIDiscipleModel:calculationDiscipleJobAttrLookup(guid)
end,
dirty=function(guid)

end,
},

[DISCIPLE_ATTRIBUTE_TYPE.eJingJie]={
refresh=function(guid)
UIDiscipleModel:calculationDiscipleJJAttrLookup(guid)
end,
dirty=function(guid)
UIDiscipleModel:refreshJobSkillLookup(guid)
UIDiscipleModel:calculationDiscipleSkillAttrLookup(guid)
end,
},

[DISCIPLE_ATTRIBUTE_TYPE.eLianTi]={
refresh=function(guid)
UIDiscipleModel:calculationDiscipleLTAttrLookup(guid)
end,
dirty=function(guid)

end,
},

[DISCIPLE_ATTRIBUTE_TYPE.eGongFa]={
refresh=function(guid)
UIDiscipleModel:calculationDiscipleGFAttrLookup(guid)
end,
dirty=function(guid)
UIDiscipleModel:refreshGongFaSkillLookup(guid)
UIDiscipleModel:calculationDiscipleSkillAttrLookup(guid)
end,
},

[DISCIPLE_ATTRIBUTE_TYPE.eEquip]={
refresh=function(guid)
UIDiscipleModel:calculationDiscipleEquipsAttrLookup(guid)
end,
dirty=function(guid)
UIDiscipleModel:refreshEquipSkillLookup(guid)
UIDiscipleModel:calculationDiscipleSkillAttrLookup(guid)
end,
},

[DISCIPLE_ATTRIBUTE_TYPE.eSpecial]={
refresh=function(guid)
UIDiscipleModel:calculationDiscipleSpecialAttrLookup(guid)
end,
dirty=function(guid)
UIDiscipleModel:refreshSpecialSkillLookup(guid)
UIDiscipleModel:calculationDiscipleSkillAttrLookup(guid)
UIDiscipleModel:calculationDiscipleInjuryAttrLookup(guid)
end,
},

[DISCIPLE_ATTRIBUTE_TYPE.eInjury]={
refresh=function(guid)
UIDiscipleModel:calculationDiscipleInjuryAttrLookup(guid)
end,
dirty=function(guid)

end,
},

[DISCIPLE_ATTRIBUTE_TYPE.eSkill]={
refresh=function(guid)
UIDiscipleModel:calculationDiscipleSkillAttrLookup(guid)
end,
dirty=function(guid)

end,
},

[DISCIPLE_ATTRIBUTE_TYPE.eTianMing]={
refresh=function(guid)
UIDiscipleModel:calculationDiscipleTianMingAttrLookup(guid)
end,
dirty=function(guid)
UIDiscipleModel:calculationDiscipleJJAttrLookup(guid)
UIDiscipleModel:calculationDiscipleSkillAttrLookup(guid)
end,
},

[DISCIPLE_ATTRIBUTE_TYPE.eTianMingCiFu]={
refresh=function(guid)
UIDiscipleModel:calculationDiscipleTianMingCiFuAttrLookup(guid)
end,
dirty=function(guid)

end,
},

[DISCIPLE_ATTRIBUTE_TYPE.eQiZhen]={
refresh=function(guid)
UIDiscipleModel:calculationDiscipleQiZhenAttrLookup(guid)
end,
dirty=function(guid)
UIDiscipleModel:calculationDiscipleLTAttrLookup(guid)
end,
},

[DISCIPLE_ATTRIBUTE_TYPE.eTianDaoShu]={
refresh=function(guid)
UIDiscipleModel:calculationDiscipleTianDaoShuAttrLookup(guid)
end,
dirty=function(guid)

end,
},

[DISCIPLE_ATTRIBUTE_TYPE.eCuiTi]={
refresh=function(guid)
UIDiscipleModel:calculationDiscipleCuiTiAttrLookup(guid)
end,
dirty=function(guid)
UIDiscipleModel:calculationDiscipleLTAttrLookup(guid)
end,
},

[DISCIPLE_ATTRIBUTE_TYPE.eYuFu]={
refresh=function(guid)
UIDiscipleModel:calculationDiscipleYuFuAttrLookup(guid)
end,
dirty=function(guid)

end,
},

[DISCIPLE_ATTRIBUTE_TYPE.eMount]={
refresh=function(guid)
UIDiscipleModel:calculationDiscipleMountAttrLookup(guid)
end,
dirty=function(guid)

end,
},

[DISCIPLE_ATTRIBUTE_TYPE.eVaryLingGen]={
refresh=function(guid)
UIDiscipleModel:calculationDiscipleLingGenAttrLookup(guid)
end,
dirty=function(guid)
UIDiscipleModel:refreshVaryLingGenSkillLookup(guid)
UIDiscipleModel:calculationDiscipleSpecialAttrLookup(guid)
end,
},

[DISCIPLE_ATTRIBUTE_TYPE.eLittleWorld]={
refresh=function(guid)
LittleWorldModel:calculationDiscipleAttrLookup(guid)
end,
dirty=function(guid)
UIDiscipleModel:calculationDiscipleJJAttrLookup(guid)
end,
},

[DISCIPLE_ATTRIBUTE_TYPE.eXianMoDaoHeng]={
refresh=function(guid)
UIDiscipleModel:calculationDiscipleXianMoDaoHengAttrLookup(guid)
end,
dirty=function(guid)
UIDiscipleModel:calculationDiscipleSkillAttrLookup(guid)
UIDiscipleModel:calculationDiscipleJJAttrLookup(guid)
UIDiscipleModel:calculationDiscipleLTAttrLookup(guid)
end,
},

[DISCIPLE_ATTRIBUTE_TYPE.eWanLingTa]={
refresh=function(guid)
UIDiscipleModel:calculationDiscipleWanLingTaAttrLookup(guid)
end,
dirty=function(guid)
UIDiscipleModel:calculationDiscipleEquipsAttrLookup(guid)
UIDiscipleModel:calculationDiscipleXianMoDaoHengAttrLookup(guid)
UIDiscipleModel:calculationDiscipleJJAttrLookup(guid)
UIDiscipleModel:calculationDiscipleLTAttrLookup(guid)
end,
},

[DISCIPLE_ATTRIBUTE_TYPE.eDaoYan]={
refresh=function(guid)
UIDiscipleModel:calculationDiscipleDaoYanAttrLookup(guid)
end,
dirty=function(guid)

end,
},
}


discipleExtraAttributeType=
{
eGuBao=1,
eGuBaoSkill=2,
eBenefitBuilding=3,
eYueLongChi=4,
eDaZhen=5,
eXianBao=6,
eDuJieZhiBao=7,
ePlayerSuit=8,
eSettingType=9,
eWanLingTa=10,
eBaoShuZhuLing=11,
eYanDaoTai=12,
eYunZhouZhenTu=13,
eLingShouTraitEffect=14,
eLingShouPassiveSkill=15,
eLingShouBase=16,
}
local attr_extral_refresh_funcs={
[discipleExtraAttributeType.eGuBao]=function(lookup,guid)
UIDiscipleModel:calculationGuBaoAttrLookup(lookup)
end,
[discipleExtraAttributeType.eGuBaoSkill]=function(lookup,guid)
UIDiscipleModel:calculationGuBaoSkilAttrLookup(lookup,guid)
end,
[discipleExtraAttributeType.eBenefitBuilding]=function(lookup,guid)
UIDiscipleModel:calculationBenefitBuildingAttrLookup(lookup,guid)
end,
[discipleExtraAttributeType.eYueLongChi]=function(lookup,guid)
UIDiscipleModel:calculationYueLongChiAttrLookup(lookup,guid)
end,
[discipleExtraAttributeType.eDaZhen]=function(lookup,guid)
UIDiscipleModel:calculationDiscipleDaZhenAttrLookup(lookup,guid)
end,
[discipleExtraAttributeType.eXianBao]=function(lookup,guid)
UIDiscipleModel:calculationXianBaoAttrLookup(lookup,guid)
end,
[discipleExtraAttributeType.eDuJieZhiBao]=function(lookup,guid)
UIDiscipleModel:calculationDuJieZhiBaoAttrLookup(lookup,guid)
end,
[discipleExtraAttributeType.ePlayerSuit]=function(lookup,guid)
UIDiscipleModel:calculationPlayerSuitAttrLookup(lookup,guid)
end,
[discipleExtraAttributeType.eSettingType]=function(lookup,guid)
UIDiscipleModel:calculationSettingTypeAttrLookup(lookup,guid)
end,
[discipleExtraAttributeType.eWanLingTa]=function(lookup,guid)
UIDiscipleModel:calculationWanLingTaAttrLookup(lookup,guid)
end,
[discipleExtraAttributeType.eBaoShuZhuLing]=function(lookup,guid)
UIDiscipleModel:calculationBaoShuZhuLingAttrLookup(lookup)
end,
[discipleExtraAttributeType.eYanDaoTai]=function(lookup,guid)
UIDiscipleModel:calculationYanDaoTaiAttrLookup(lookup,guid)
end,
[discipleExtraAttributeType.eYunZhouZhenTu]=function(lookup,guid)
UIDiscipleModel:calculationYunZhouZhenTuAttrLookup(lookup,guid)
end,
[discipleExtraAttributeType.eLingShouTraitEffect]=function(lookup,guid)
UIDiscipleModel:calculationLingShouTraitEffectAttrLookup(lookup,guid)
end,
[discipleExtraAttributeType.eLingShouPassiveSkill]=function(lookup,guid)
UIDiscipleModel:calculationLingShouPassiveSkillAttrLookup(lookup,guid)
end,



}



function UIDiscipleModel:getDiscipleAttrList(guid,is_ex)
local netData=UIDiscipleModel:getDiscipleData(guid)
return self:getDiscipleAttrListEx(netData,is_ex)
end

function UIDiscipleModel:getDiscipleAttrListEx(netData,is_ex)
if netData.discipleAttrList==nil or netData.discipleAttrListDirty then
local discipleAttrList={}
local discipleAttrListEx={}
local discipleAttrLookup=netData.discipleAttrLookup
if discipleAttrLookup==nil then


self:calculationDiscipleAttrLookupEx(netData)
discipleAttrLookup=netData.discipleAttrLookup
end
for k,v in pairs(discipleAttrLookup)do
for k1,v1 in pairs(v)do
discipleAttrList[k1]=discipleAttrList[k1]or 0
discipleAttrList[k1]=discipleAttrList[k1]+v1
discipleAttrListEx[k1]=discipleAttrList[k1]
end
end
for k,v in pairs(discipleAttrListEx)do
local ptc=helper.getAttrRelationShip(k)
if ptc~=nil and discipleAttrListEx[ptc]~=nil then
discipleAttrListEx[k]=math.floor(discipleAttrListEx[k]*(1+discipleAttrListEx[ptc])+0.00001)
end
end
netData.discipleAttrList=discipleAttrList
netData.discipleAttrListEx=discipleAttrListEx
netData.discipleAttrListDirty=false







end
if is_ex==true then
return netData.discipleAttrListEx
else
return netData.discipleAttrList
end
end

function UIDiscipleModel:initDiscipleAttrLookup(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData.discipleAttrLookup==nil then
UIDiscipleModel:calculationDiscipleAttrLookup(guid)
for k,v in pairsBySortKey(disciple_attribute_refresh_funcs)do
v.refresh(guid)
end

end
end

function UIDiscipleModel:getDiscipleAttrLookup(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
UIDiscipleModel:getDiscipleAttrList(guid)
return netData.discipleAttrLookup
end


function UIDiscipleModel:getDiscipleAttrLookupX(guid,attrType)
return UIDiscipleModel:getDiscipleAttrLookup(guid)[attrType]
end

function UIDiscipleModel:calculationDiscipleAttrLookup(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return self:calculationDiscipleAttrLookupEx(netData)
end

function UIDiscipleModel:calculationDiscipleAttrLookupEx(netData)
if netData.discipleAttrLookup==nil then

local discipleAttrLookup={}

local baseLookup={}
discipleAttrLookup[DISCIPLE_ATTRIBUTE_TYPE.eBase]=baseLookup
local globalconfig=cfg_globalconfig_get(1)
for i,v in ipairs(globalconfig.baseattr)do
baseLookup[v[1]]=baseLookup[v[1]]or 0
baseLookup[v[1]]=baseLookup[v[1]]+v[2]
end

netData.discipleAttrLookup=discipleAttrLookup
end
return netData
end

function UIDiscipleModel:calculationDiscipleJobAttrLookup(guid)

local netData=UIDiscipleModel:getDiscipleData(guid)
local discipleAttrLookup=netData.discipleAttrLookup
local attrs={}
local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(netData)
local job=imageInfo.job
local disciplevocationconfig=cfg_disciplevocationconfig_get(job)
for i,v in ipairs(disciplevocationconfig.attr)do
attrs[v[1]]=attrs[v[1]]or 0
attrs[v[1]]=attrs[v[1]]+v[2]
end


local gb_add_lp=gubaoModel:getGBSkil_job_attrLookup(job)
for attrType,v in pairs(gb_add_lp)do
attrs[attrType]=attrs[attrType]or 0
attrs[attrType]=attrs[attrType]+v
end

discipleAttrLookup[DISCIPLE_ATTRIBUTE_TYPE.eJob]=attrs
end

function UIDiscipleModel:getDiscipleJJAttrRate(guid)
local baseAttrExListX=UIDiscipleModel:getDiscipleBaseAttrExListX(guid,DISCIPLE_BASE_ATTR_TYPE.eQianLi)

local rate=1+baseAttrExListX[1]/100

rate=rate+UIDiscipleModel:getTianMingJJRate(guid)

rate=rate+gubaoModel:getGBSkil_ProskillToJJAttrRate(guid)/100

rate=rate+UIDiscipleModel:getXianMoJJRate(guid)

rate=rate+vocEquipModel:getVocEquipJJRate(guid)

return rate
end

function UIDiscipleModel:calculationDiscipleJJAttrLookup(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local discipleAttrLookup=netData.discipleAttrLookup

local jjLookup=UIDiscipleModel:calculationDiscipleJJAttrLookupEx(guid,true)
discipleAttrLookup[DISCIPLE_ATTRIBUTE_TYPE.eJingJie]=jjLookup
end

function UIDiscipleModel:calculationDiscipleJJAttrLookupEx(guid,check_ex_rate,jjlv,point)
local netData=UIDiscipleModel:getDiscipleData(guid)
local jjLookup={}
local ex_rate
if check_ex_rate~=false then
ex_rate=UIDiscipleModel:getDiscipleJJAttrRate(guid)
else
ex_rate=1
end

local jjLookup={}
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(guid)
local job=imageInfo.job
if jjlv==nil or point==nil then
jjlv,point=UIDiscipleModel:getDiscipleJJLevelAndPoint(guid)
end
local jjcfg=cfg_disciplejingjieconfig_get(jjlv)
if jjcfg.attr[job]then
local expattrLookup={}
if jjcfg.expattr then
local expattr=jjcfg.expattr[job]
if expattr then
for i,v in ipairs(expattr)do
expattrLookup[v[1]]=v[2]
end
end
end
local add
local ex_rate_
local addrate_lp
local addrate_xc={}
local addrate_xmt
if check_ex_rate~=false then
addrate_lp=gubaoModel:getGBSkil_job_jj_attrRateLookup(job)
local addjobrate_xc=xingChenCiZhuiEffectController:getEquippedXingChenGrowVal(xingChenGrowEffectChangeType.eDiziVocJingJieRate)
if next(addjobrate_xc)then
addrate_xc=addjobrate_xc[job]or{}
end
addrate_xmt=wanLingTaModel:getWanLingTaDiscipleJingJieSpeAttrsLookup(guid)
else
addrate_lp={}
addrate_xmt={}
end
for i,v in ipairs(jjcfg.attr[job])do
jjLookup[v[1]]=jjLookup[v[1]]or 0
add=expattrLookup[v[1]]or 0
ex_rate_=ex_rate



local x=addrate_lp[v[1]]or 0
local xc=(addrate_xc[v[1]]or 0)/100
local xmtAdd=(addrate_xmt[v[1]]or 0)/100
ex_rate_=ex_rate_+x+xc+xmtAdd
jjLookup[v[1]]=jjLookup[v[1]]+math.floor(v[2]*ex_rate_+0.00001)+math.floor(add*point*ex_rate_+0.00001)
end
end
return jjLookup
end

function UIDiscipleModel:getDiscipleLTAttrRate(guid)
local rate=1

local baseAttrExListX=UIDiscipleModel:getDiscipleBaseAttrExListX(guid,DISCIPLE_BASE_ATTR_TYPE.eQianLi)
rate=rate+baseAttrExListX[2]/100

rate=rate+UIDiscipleModel:getDZQiZhan2LianTianRate(guid)/100

rate=rate+UIDiscipleModel:getDZCuiTi2LianTianRate(guid)/100

rate=rate+gubaoModel:getGBSkil_ProskillToLTAttrRate(guid)/100

rate=rate+UIDiscipleModel:getXianMoLTRate(guid)

rate=rate+vocEquipModel:getVocEquipLTRate(guid)
return rate
end

function UIDiscipleModel:calculationDiscipleLTAttrLookup(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local discipleAttrLookup=netData.discipleAttrLookup
local ltLookup=UIDiscipleModel:calculationDiscipleLTAttrLookupEx(guid,true)
discipleAttrLookup[DISCIPLE_ATTRIBUTE_TYPE.eLianTi]=ltLookup
end

function UIDiscipleModel:calculationDiscipleLTAttrLookupEx(guid,check_ex_rate,level,exp)
local netData=UIDiscipleModel:getDiscipleData(guid)
local ex_rate
if check_ex_rate~=false then
ex_rate=UIDiscipleModel:getDiscipleLTAttrRate(guid)
else
ex_rate=1
end

local imageInfo=UIDiscipleModel:getDiscipleImageInfo(guid)
local job=imageInfo.job
local liantilv=level or netData.liantilv



local disciplelianticonfig=cfg_disciplelianticonfig_get(liantilv)

local liantiexp=exp or netData.liantiexp
local ll_expattr=cfgHelper.getdef1(cfg_disciplelianticonfig,'expattr')
local ll_exp_precent=0
if disciplelianticonfig.exp>0 then
ll_exp_precent=liantiexp/disciplelianticonfig.exp
end
if ll_exp_precent>1 then
ll_exp_precent=1
end
local ll_rate=math.floor(ll_exp_precent*100/ll_expattr)





local ltLookup=UIDiscipleModel:calculationDiscipleLTAttr(job,liantilv,ll_rate,ex_rate,check_ex_rate,guid)
return ltLookup
end

function UIDiscipleModel:calculationDiscipleLTAttr(job,liantilv,exp_rate,ex_rate,check_ex_rate,guid)
local result={}
local ex_rate_
local addrate_lp
local addrate_xmt
if check_ex_rate~=false then
addrate_lp=gubaoModel:getGBSkil_job_lt_attrRateLookup(job)
addrate_xmt=wanLingTaModel:getWanLingTaDiscipleLianTiSpeAttrsLookup(job)
else
addrate_lp={}
addrate_xmt={}
end




local disciplelianticonfig=cfg_disciplelianticonfig_get(liantilv)
if disciplelianticonfig.attr[job]then
for i,v in ipairs(disciplelianticonfig.attr[job])do
ex_rate_=ex_rate

local x=addrate_lp[v[1]]or 0
local xmtAdd=(addrate_xmt[v[1]]or 0)/100
ex_rate_=ex_rate_+x+xmtAdd
result[v[1]]=result[v[1]]or 0
result[v[1]]=result[v[1]]+math.floor(v[2]*ex_rate_+0.00001)
end
end

if disciplelianticonfig.expattr[job]then
for i,v in ipairs(disciplelianticonfig.expattr[job])do
ex_rate_=ex_rate

local x=addrate_lp[v[1]]or 0
local xmtAdd=(addrate_xmt[v[1]]or 0)/100
ex_rate_=ex_rate_+x+xmtAdd
result[v[1]]=result[v[1]]or 0
result[v[1]]=result[v[1]]+math.floor(v[2]*exp_rate*ex_rate_+0.00001)
end
end
return result
end

function UIDiscipleModel:calculationDiscipleGFAttrLookup(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local discipleAttrLookup=netData.discipleAttrLookup
local attrs=UIGongFaModel:calculationGFAttrLookup(guid)
discipleAttrLookup[DISCIPLE_ATTRIBUTE_TYPE.eGongFa]=attrs
end

function UIDiscipleModel:calculationDiscipleEquipsAttrLookup(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local dzname=UIDiscipleModel:getDiscipleName(guid)
local discipleAttrLookup=netData.discipleAttrLookup
local equipAttrs=equipsModel.getEquipAttrsLookup(guid)
equipsHelper.printAttrListChange(nil,equipAttrs,FMT.fmt('打印x{0}的装备：',dzname))

local vocEquipAddAttrsRate=vocEquipModel:getVocEquipAddEquipAttrsRate(guid)
local vocEquipAddRateAttr={}
if vocEquipAddAttrsRate and vocEquipAddAttrsRate~=0 then
for attrId,attrValue in pairs(equipAttrs)do
local addValue=math.floor(vocEquipAddAttrsRate*attrValue)
if addValue~=0 then
vocEquipAddRateAttr[attrId]=addValue
end
end
end

local fabaoAttrs=fabaoModel.getFabaoAttrsLookup(guid)
local daobingAttrs=daobingModel:getDaoBingAttrsLookup(guid)
local clothingAttrs=ClothingModel:getClothingAttrsLookup(guid)
local clothingCollectAttrs=ClothingModel:getClothingCollectAttrsLookup(guid)
local vocEquipAttrs=vocEquipModel:getVocEquipAttrsLookup(guid)
local extraDiziAddAttr=fabaoCizuiHelper.getDiziAddAttrLookup(guid)
local lingshouAddAttr=lingshouModel:getLingShouAttrsLookup(guid)
local attrs=attrListHelper.concatLookup(equipAttrs,fabaoAttrs)
attrs=attrListHelper.concatLookup(daobingAttrs,attrs)
attrs=attrListHelper.concatLookup(clothingAttrs,attrs)
attrs=attrListHelper.concatLookup(extraDiziAddAttr,attrs)
attrs=attrListHelper.concatLookup(clothingCollectAttrs,attrs)
attrs=attrListHelper.concatLookup(vocEquipAttrs,attrs)
attrs=attrListHelper.concatLookup(vocEquipAddRateAttr,attrs)
attrs=attrListHelper.concatLookup(lingshouAddAttr,attrs)

equipsHelper.printAttrListChange(nil,attrListHelper.concatLookup(extraDiziAddAttr,fabaoAttrs),FMT.fmt('打印x{0}的法宝：',dzname))
equipsHelper.printAttrListChange(nil,daobingAttrs,FMT.fmt('打印x{0}的道兵：',dzname))

equipsHelper.printAttrListChange(nil,clothingAttrs,FMT.fmt('打印x{0}的时装：',dzname))
equipsHelper.printAttrListChange(nil,vocEquipAttrs,FMT.fmt('打印x{0}的职业装备：',dzname))
equipsHelper.printAttrListChange(nil,vocEquipAddRateAttr,FMT.fmt('打印x{0}的职业装备加成装备属性：',dzname))
equipsHelper.printAttrListChange(nil,lingshouAddAttr,FMT.fmt('打印x{0}的灵兽：',dzname))
discipleAttrLookup[DISCIPLE_ATTRIBUTE_TYPE.eEquip]=attrs
end

function UIDiscipleModel:calculationDiscipleSpecialAttrLookup(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local discipleAttrLookup=netData.discipleAttrLookup
local attrs=dzSpecialityGrowEffectController:getBaseAttrLookup(netData)
discipleAttrLookup[DISCIPLE_ATTRIBUTE_TYPE.eSpecial]=attrs
end

function UIDiscipleModel:calculationDiscipleInjuryAttrLookup(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local discipleAttrLookup=netData.discipleAttrLookup
local attrs={}
local injury=netData.injury
local ratelist=eInjuryType:getAttrRate(injury)
if ratelist and#ratelist>0 then
if not dzSpecialitySpecialEffectController:getInjurpNotDownAttr(netData)then
for i,v in ipairs(ratelist)do
attrs[v[1]]=v[2]
end
end
end
discipleAttrLookup[DISCIPLE_ATTRIBUTE_TYPE.eInjury]=attrs
end

function UIDiscipleModel:calculationDiscipleSkillAttrLookup(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local discipleAttrLookup=netData.discipleAttrLookup
local attrs={}
local skillLookup=UIDiscipleModel:getAllSkillLookup(guid)
for typo,lookup in pairs(skillLookup)do
for skillId,skillLv in pairs(lookup)do

if skillLv>0 then
local skill_lv=UIDiscipleModel:getSkillLv(guid,skillId,skillLv)
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
if skillCfg.attr~=nil then
local attr=skillCfg.attr[skill_lv]
if attr then
for i1,v1 in ipairs(attr)do
attrs[v1[1]]=attrs[v1[1]]or 0
attrs[v1[1]]=attrs[v1[1]]+v1[2]
end
else



end
end
end
end
end
discipleAttrLookup[DISCIPLE_ATTRIBUTE_TYPE.eSkill]=attrs
end

function UIDiscipleModel:calculationDiscipleTianMingAttrLookup(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local discipleAttrLookup=netData.discipleAttrLookup
local attrs={}
local tmlv=netData.tmlv
if tmlv>=0 then
if netData.tmList then
for tmIndex,tmID in ipairs(netData.tmList)do
local isActive=UIDiscipleModel:checkTianMingFloorActive(tmlv,tmIndex)
if isActive then
local tmcfg=cfgHelper.get1(cfg_discipletianmingconfig_get,tmID)

if tmcfg.attr then
for i1,v1 in ipairs(tmcfg.attr)do
attrs[v1[1]]=attrs[v1[1]]or 0
attrs[v1[1]]=attrs[v1[1]]+v1[2]
end
end

local skillId=tmcfg.skill
if skillId then
local skill_lv=1
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
if skillCfg.attr~=nil then
local attr=skillCfg.attr[skill_lv]
if attr then
for i1,v1 in ipairs(attr)do
attrs[v1[1]]=attrs[v1[1]]or 0
attrs[v1[1]]=attrs[v1[1]]+v1[2]
end
else



end
end
end
end
end
end

local lvcfg=cfgHelper.get1(cfg_discipletianminglevelconfig_get,tmlv)
if lvcfg then
local job=UIDiscipleModel:getDiscipleJob(guid)
local lv_attrs=lvcfg.attr[job]
if lv_attrs~=nil and#lv_attrs>0 then
for i1,v1 in ipairs(lv_attrs)do
attrs[v1[1]]=attrs[v1[1]]or 0
attrs[v1[1]]=attrs[v1[1]]+v1[2]
end
end
end
end
discipleAttrLookup[DISCIPLE_ATTRIBUTE_TYPE.eTianMing]=attrs
end

function UIDiscipleModel:calculationDiscipleTianMingCiFuAttrLookup(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local discipleAttrLookup=netData.discipleAttrLookup
local attrs={}
local tmcfList=netData.tmcfList
if tmcfList~=nil then
for groupIdx,cifuID in ipairs(tmcfList)do
if cifuID>0 then
local isOpen=UIDiscipleModel:checkTiamMingCiFuPosOpenEx(netData,groupIdx)
if isOpen then
local cifucfg=cfgHelper.get1(cfg_discipletmcfconfig_get,cifuID)
if cifucfg then
for i1,v1 in ipairs(cifucfg.attr)do
attrs[v1[1]]=attrs[v1[1]]or 0
attrs[v1[1]]=attrs[v1[1]]+v1[2]
end
end
end
end
end
end
discipleAttrLookup[DISCIPLE_ATTRIBUTE_TYPE.eTianMingCiFu]=attrs
end

function UIDiscipleModel:calculationDiscipleDaoYanAttrLookup(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local discipleAttrLookup=netData.discipleAttrLookup
local attrs={}

local dylv=netData.daoyan_lv or 0

if netData.daoyan_unlock==0 then
dylv=0
end

if UIDiscipleModel:isDaoYanDZ(guid)and dylv>0 then
local attrList=UIDiscipleModel:getDaoYanAttrByGuid(guid,dylv)
if attrList then

for i,v in ipairs(attrList)do
attrs[v[1]]=attrs[v[1]]or 0
attrs[v[1]]=attrs[v[1]]+v[2]
end
end
local skillList=UIDiscipleModel:getDaoYanSkillByGuid(guid)
if skillList then
for i,v in ipairs(skillList)do
if dylv>=v[2]then
local skill_lv=1
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,v[1])
if skillCfg.attr~=nil then
local attr=skillCfg.attr[skill_lv]
if attr then
for i1,v1 in ipairs(attr)do
attrs[v1[1]]=attrs[v1[1]]or 0
attrs[v1[1]]=attrs[v1[1]]+v1[2]
end
else



end
end

end
end
end
end
discipleAttrLookup[DISCIPLE_ATTRIBUTE_TYPE.eDaoYan]=attrs
end

function UIDiscipleModel:calculationDiscipleQiZhenAttrLookup(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local discipleAttrLookup=netData.discipleAttrLookup
local attrs={}
local qzList=netData.qzList
if qzList~=nil then
for i,v in ipairs(qzList)do
local itemid=v.param_1
local itemnum=v.param_2
local cfg=cfgHelper.get1(cfg_discipleqizhenconfig_get,itemid)
if cfg and cfg.attr then
for i1,v1 in ipairs(cfg.attr)do
attrs[v1[1]]=attrs[v1[1]]or 0
attrs[v1[1]]=attrs[v1[1]]+v1[2]*itemnum
end
end
end
end
discipleAttrLookup[DISCIPLE_ATTRIBUTE_TYPE.eQiZhen]=attrs
end

function UIDiscipleModel:calculationDiscipleCuiTiAttrLookup(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local discipleAttrLookup=netData.discipleAttrLookup
local attrs={}
local qzctlv=netData.qzctlv
local qzcfg=cfgHelper.get1(cfg_discipleqizhencuiticonfig_get,qzctlv)
if qzcfg and qzcfg.attr then
for i1,v1 in ipairs(qzcfg.attr)do
attrs[v1[1]]=attrs[v1[1]]or 0
attrs[v1[1]]=attrs[v1[1]]+v1[2]
end
end
discipleAttrLookup[DISCIPLE_ATTRIBUTE_TYPE.eCuiTi]=attrs
end

function UIDiscipleModel:calculationDiscipleYuFuAttrLookup(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local discipleAttrLookup=netData.discipleAttrLookup
local attrs={}
local llist=netData.livingEquipList
if llist then
for i,v in ipairs(llist)do
for k,vv in pairs(v.prePartInfo.itemData.fixAttrLst)do
local val=attrs[vv.param_1]or 0
attrs[vv.param_1]=val+vv.param_2
end
if systemModel.isOpen(SYSTEM_DEFINE.eYuFuLingZhen)then
local itemData=v.prePartInfo
local attrList=UIYuFuLingZhenControl:countTotalAttr(itemData.itemguid)
for k,v in pairs(attrList)do
local val=attrs[k]or 0
attrs[k]=val+v
end

end
end
end


discipleAttrLookup[DISCIPLE_ATTRIBUTE_TYPE.eYuFu]=attrs
end

function UIDiscipleModel:calculationDiscipleMountAttrLookup(dzguid)
local netData=UIDiscipleModel:getDiscipleData(dzguid)
local discipleAttrLookup=netData.discipleAttrLookup
local attrs=mountModel:getAttrsLookup(dzguid)
discipleAttrLookup[DISCIPLE_ATTRIBUTE_TYPE.eMount]=attrs
end

function UIDiscipleModel:calculationDiscipleTianDaoShuAttrLookup(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local discipleAttrLookup=netData.discipleAttrLookup
local voc=UIDiscipleModel:getDiscipleJob(guid)
local commonLookup,percentLookup,actList=tiandaoshuModel:getVocAttrList(voc)
local attrs={}
local lookup=commonLookup[0]or{}
for attrId,attrValue in pairs(lookup)do
attrs[attrId]=(attrs[attrId]or 0)+attrValue
end
for attrId,percent in pairs(percentLookup)do
if attrs[attrId]then
attrs[attrId]=math.floor(attrs[attrId]*(100+percent)/100+0.00001)
end
end
discipleAttrLookup[DISCIPLE_ATTRIBUTE_TYPE.eTianDaoShu]=attrs
end

function UIDiscipleModel:calculationDiscipleLingGenAttrLookup(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local discipleAttrLookup=netData.discipleAttrLookup
local lglist,lglist_lookup,lglen=UIDiscipleModel:getDiscipleRealLevelLinggenData(guid)
local varySrid=UIDiscipleModel:getDiscipleVarysrid(guid)
local job=UIDiscipleModel:getDiscipleJob(guid)
local attrs={}


for k,v in pairs(lglist)do
local attrsData=cfgHelper.get4(cfg_disciplespiritrootlevelconfig_get,lglen,v.type,v.lv,'attr')

for _,attr in pairs(attrsData or{})do
if attrs[attr[1]]then
attrs[attr[1]]=attrs[attr[1]]+attr[2]
else
attrs[attr[1]]=attr[2]
end
end
end


if varySrid>0 and UIDiscipleModel:checkDiscipleAssertVary(guid)then
local varyLgData=lglist_lookup[varySrid]
local varyAttr=cfgHelper.get3(cfg_disciplespiritrootvaryconfig_get,lglen,varyLgData.type,'attr')
for k,attr in pairs(varyAttr or{})do
if attrs[attr[1]]then
attrs[attr[1]]=attrs[attr[1]]+attr[2]
else
attrs[attr[1]]=attr[2]
end
end
end


local hoardDatas=UIDiscipleModel:getDiscipleHoardEx(guid)
for index=1,5 do
local pdata=hoardDatas[index]
if pdata.activelistlen>0 then
local hdata=pdata.activeList[1]
if hdata.len1>0 then
for k,v in pairs(hdata.list1)do
if attrs[v.param_1]then
attrs[v.param_1]=attrs[v.param_1]+v.param_2
else
attrs[v.param_1]=v.param_2
end
end
end

if hdata.len2>0 then
for k,v in pairs(hdata.list2)do
if attrs[v.param_1]then
attrs[v.param_1]=attrs[v.param_1]+v.param_2
else
attrs[v.param_1]=v.param_2
end
end
end
end
end

if varySrid>0 and UIDiscipleModel:checkDiscipleAssertVary(guid)then
local pdata=hoardDatas[-varySrid]
if pdata.activelistlen>0 then
local hdata=pdata.activeList[1]
if hdata.len1>0 then
for k,v in pairs(hdata.list1)do
if attrs[v.param_1]then
attrs[v.param_1]=attrs[v.param_1]+v.param_2
else
attrs[v.param_1]=v.param_2
end
end
end

if hdata.len2>0 then
for k,v in pairs(hdata.list2)do
if attrs[v.param_1]then
attrs[v.param_1]=attrs[v.param_1]+v.param_2
else
attrs[v.param_1]=v.param_2
end
end
end
end
end



discipleAttrLookup[DISCIPLE_ATTRIBUTE_TYPE.eVaryLingGen]=attrs
end

function UIDiscipleModel:calculationDiscipleXianMoDaoHengAttrLookup(dzguid)
local netData=UIDiscipleModel:getDiscipleData(dzguid)
local discipleAttrLookup=netData.discipleAttrLookup
local attrs=UIDiscipleModel:getXianMoDaoHengAttrsLookup(dzguid)
discipleAttrLookup[DISCIPLE_ATTRIBUTE_TYPE.eXianMoDaoHeng]=attrs
end

function UIDiscipleModel:calculationDiscipleWanLingTaAttrLookup(dzguid)
local netData=UIDiscipleModel:getDiscipleData(dzguid)
local discipleAttrLookup=netData.discipleAttrLookup
local attrs=wanLingTaModel:getWanLingTaDiscipleSpeAttrsLookup(dzguid)
discipleAttrLookup[DISCIPLE_ATTRIBUTE_TYPE.eWanLingTa]=attrs
end



function UIDiscipleModel:setAllDiscipleAttrListDirty(attrTypes,showFightTips)
local discipleNetData=UIDiscipleModel:getAllDiscipleData()
if discipleNetData then
if showFightTips==nil then
showFightTips=false
end
for k,v in pairs(discipleNetData)do
local netData=v.netData.net
UIDiscipleModel:setDiscipleAttrListDirty2(netData,attrTypes,showFightTips)
end
end
end



function UIDiscipleModel:setDiscipleAttrListDirty(netData,attrType,showFightTips)
if not UIDiscipleController:checkInit()then
return
end
if showFightTips==nil then showFightTips=false end
if attrType~=nil then
local func=disciple_attribute_refresh_funcs[attrType]
if func then
func.refresh(netData.discipleguid)
func.dirty(netData.discipleguid)
end
end
netData.discipleAttrListDirty=true
UIDiscipleModel:setDiscipleCalculationFightDirty(netData,attrType,showFightTips)
if attrType~=nil then
notifySystem:postNotify(notifyConfig.onDiscipleAttrChange,netData.discipleguid,attrType)
end
end

function UIDiscipleModel:setDiscipleAttrListDirtyX(guid,attrType,showFightTips)
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData~=nil then
UIDiscipleModel:setDiscipleAttrListDirty(netData,attrType,showFightTips)
end
end
function UIDiscipleModel:setDiscipleAttrListDirty2(netData,attrTypes,showFightTips)
if not UIDiscipleController:checkInit()then
return
end
if showFightTips==nil then showFightTips=false end
if attrTypes~=nil then
for i,attrType in ipairs(attrTypes)do
local func=disciple_attribute_refresh_funcs[attrType]
if func then
func.refresh(netData.discipleguid)
func.dirty(netData.discipleguid)
end
end
end
netData.discipleAttrListDirty=true
UIDiscipleModel:setDiscipleCalculationFightDirty2(netData,attrTypes,showFightTips)
if attrTypes~=nil then
for i,attrType in ipairs(attrTypes)do
notifySystem:postNotify(notifyConfig.onDiscipleAttrChange,netData.discipleguid,attrType)
end
end
end



function UIDiscipleModel:getDiscipleAttrByType(guid,ty,isex)
local temp=UIDiscipleModel:getDiscipleAttrList(guid,isex)
return temp[ty]or 0
end

function UIDiscipleModel:getDiscipleAttrListByType(guid,typelist,isex)
local temp=UIDiscipleModel:getDiscipleAttrList(guid,isex)
local list={}
for i,v in ipairs(typelist)do
local n=temp[v]or 0
table_insert(list,{v,n})
end
return list
end

function UIDiscipleModel:getDiscipleAllAttrList(guid,isex)
local result={}
local cfgs=cfg_attributesconfig()
local temp=UIDiscipleModel:getDiscipleAttrList(guid,isex)
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




function UIDiscipleModel:getExtraAttrLookup(guid,is_ex)
local lookup={}
for k,v in pairsBySortKey(attr_extral_refresh_funcs)do
v(lookup,guid)
end
if is_ex then
helper.getAttrRelationShipChange(lookup)
end
return lookup
end

function UIDiscipleModel:calculationGuBaoAttrLookup(lookup)
local gbAttrLookup=gubaoModel:getAllAttrLookup()
for k,v in pairs(gbAttrLookup)do
lookup[k]=lookup[k]or 0
lookup[k]=lookup[k]+v
end
end

function UIDiscipleModel:calculationGuBaoSkilAttrLookup(lookup,guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local jjlv=netData.jingjielv
local ltlv=netData.liantilv
local temp

temp=gubaoModel:getGBSkil_JingJieAttr(jjlv)
for k,v in pairs(temp)do
lookup[k]=lookup[k]or 0
lookup[k]=lookup[k]+v
end

temp=gubaoModel:getGBSkil_LianTiAttr(ltlv)
for k,v in pairs(temp)do
lookup[k]=lookup[k]or 0
lookup[k]=lookup[k]+v
end

temp=gubaoModel:getGBSkil_allCounterEffectAttr()
for k,v in pairs(temp)do
lookup[k]=lookup[k]or 0
lookup[k]=lookup[k]+v
end

if DiscipleCoupleModel:getIsCouple(guid)then
temp=gubaoModel:getGBSkil_DaoLvAttr()
for k,v in pairs(temp)do
lookup[k]=lookup[k]or 0
lookup[k]=lookup[k]+v
end
end


if gubaoModel:CheckFeiShengOfDizi(guid)then
temp=gubaoModel:getXJFeiShengAttr()
for k,v in pairs(temp)do
lookup[k]=lookup[k]or 0
lookup[k]=lookup[k]+v
end
end
local voc=UIDiscipleModel:getDiscipleXianMoVoc(guid)

if voc==1 then
temp=gubaoModel:getXianXiuDZAddAttr()
for k,v in pairs(temp)do
lookup[k]=lookup[k]or 0
lookup[k]=lookup[k]+v
end
end

if voc==2 then
temp=gubaoModel:getMoXiuDZAddAttr()
for k,v in pairs(temp)do
lookup[k]=lookup[k]or 0
lookup[k]=lookup[k]+v
end
end

end


function UIDiscipleModel:calculationBenefitBuildingAttrLookup(lookup)
local buildingAttrLookup=zongmenModel:getBenefitBuildingBuffAttrAddition_Lookup()
for k,v in pairs(buildingAttrLookup)do
lookup[k]=lookup[k]or 0
lookup[k]=lookup[k]+v
end
end


function UIDiscipleModel:calculationYueLongChiAttrLookup(lookup)
local attrLookup=UIAquariumControl:getYueLongChiAttrAddition_Lookup()
for k,v in pairs(attrLookup)do
lookup[k]=lookup[k]or 0
lookup[k]=lookup[k]+v
end
end


function UIDiscipleModel:calculationDiscipleDaZhenAttrLookup(lookup)
local attrLookup=shanMenDaZhenModel:getDaZhenAttrAddList()or{}
for k,v in pairs(attrLookup)do
lookup[k]=lookup[k]or 0
lookup[k]=lookup[k]+v
end
end


function UIDiscipleModel:calculationXianBaoAttrLookup(lookup)
local attrLookup=xianbaoModel:getAddAttrList()or{}
for k,v in pairs(attrLookup)do
lookup[k]=lookup[k]or 0
lookup[k]=lookup[k]+v
end
end


function UIDiscipleModel:calculationDuJieZhiBaoAttrLookup(lookup)
local attrLookup=DuJieZhiBaoController:getDJZBAttrAddList()or{}
for k,v in pairs(attrLookup)do
lookup[k]=lookup[k]or 0
lookup[k]=lookup[k]+v
end
end


function UIDiscipleModel:calculationPlayerSuitAttrLookup(lookup)
local attrLookup=playerImageModel:getAddAttrList()
if attrLookup then
for k,v in pairs(attrLookup)do
lookup[k]=lookup[k]or 0
lookup[k]=lookup[k]+v
end
end
end


function UIDiscipleModel:calculationSettingTypeAttrLookup(lookup)
local attrLookup=UISettingModel:getAddAttrList()
if attrLookup then
for k,v in pairs(attrLookup)do
lookup[k]=lookup[k]or 0
lookup[k]=lookup[k]+v
end
end
end


function UIDiscipleModel:calculationWanLingTaAttrLookup(lookup)
local attrLookup=wanLingTaModel:getWanLingTaAttrsLookup()
if attrLookup then
for k,v in pairs(attrLookup)do
lookup[k]=lookup[k]or 0
lookup[k]=lookup[k]+v
end
end
end


function UIDiscipleModel:calculationBaoShuZhuLingAttrLookup(lookup)
local attrLookup=gubaoModel:getBaoShuZhuLingAttrsLookup()
if attrLookup then
for k,v in pairs(attrLookup)do
lookup[k]=lookup[k]or 0
lookup[k]=lookup[k]+v
end
end
end


function UIDiscipleModel:calculationYanDaoTaiAttrLookup(lookup,guid)
local attrLookup=yandaotaiModel:getAddrateDatasByEffectId(7)or{}

if attrLookup[0]then
for k,v in pairs(attrLookup[0])do
lookup[k]=lookup[k]or 0
lookup[k]=lookup[k]+v
end
end
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData then
local xm_voc=netData.xianmo_voc or 0
if xm_voc>0 and attrLookup[xm_voc]then
for k,v in pairs(attrLookup[xm_voc])do
lookup[k]=lookup[k]or 0
lookup[k]=lookup[k]+v
end
end
end
end


function UIDiscipleModel:calculationYunZhouZhenTuAttrLookup(lookup)
local attrLookup=YunZhouZhenTuModel:getYZZTAttrAddList()or{}
for k,v in pairs(attrLookup)do
lookup[k]=lookup[k]or 0
lookup[k]=lookup[k]+v
end
end


function UIDiscipleModel:calculationLingShouTraitEffectAttrLookup(lookup,guid)
local list=lingshouModel:getDiscipleTraitEffectLookup(guid,lingshouTraitEffectEnum.DISCIPLE_ATTR_ADD)
if list==nil or next(list)==nil then return end

for index,args in pairs(list)do
local attrType=args[2]
local attrVal=args[3]

lookup[attrType]=lookup[attrType]or 0
lookup[attrType]=lookup[attrType]+attrVal
end
end


function UIDiscipleModel:calculationLingShouPassiveSkillAttrLookup(lookup,guid)
local lsGuid=lingshouModel:getLingShouByDizi(guid)
if lsGuid==nil then return end

local lsData=lingshouModel:getLingShouData2(lsGuid)
if lsData==nil then return end

for index,skillid in ipairs(lsData.cfg.passive_skill)do
local passiveSkillLevel=lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.PASSIVE_SKILL_LEVEL)

if passiveSkillLevel>0 then
local attrsT=cfgHelper.get(cfg_skillconfig_get,skillid,'attr')
local attrs=attrsT[passiveSkillLevel]
if attrs then
for _,attr in ipairs(attrs)do
local attrType=attr[1]
local attrVal=attr[2]

lookup[attrType]=lookup[attrType]or 0
lookup[attrType]=lookup[attrType]+attrVal
end
end
end
end
end


function UIDiscipleModel:calculationLingShouBaseAttrLookup(lookup,guid)
local lsGuid=lingshouModel:getLingShouByDizi(guid)
if lsGuid==nil then return end

local lsData=lingshouModel:getLingShouData2(lsGuid)
if lsData==nil then return end

local attrs=lingshouModel:getAllAttrList(lsData,true)

for attrType,attrVal in pairs(attrs)do
lookup[attrType]=lookup[attrType]or 0
lookup[attrType]=lookup[attrType]+attrVal
end
end




function UIDiscipleModel:getDiscipleMultipleAttrLookup(guid,is_ex)
local lookup={}

local dis_lookup=UIDiscipleModel:getDiscipleAttrList(guid)



for k,v in pairs(dis_lookup)do
lookup[k]=lookup[k]or 0
lookup[k]=lookup[k]+v
end

local extra_lookup=UIDiscipleModel:getExtraAttrLookup(guid)
for k,v in pairs(extra_lookup)do
lookup[k]=lookup[k]or 0
lookup[k]=lookup[k]+v
end
if is_ex then
helper.getAttrRelationShipChange(lookup)
end
return lookup
end

function UIDiscipleModel:getDiscipleMultipleAttrList(guid,isex)
local result={}
local cfgs=cfg_attributesconfig()
local temp=UIDiscipleModel:getDiscipleMultipleAttrLookup(guid,isex)
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

function UIDiscipleModel:getDiscipleMultipleAttrListByType(guid,typelist,isex,zero_hide)
local temp=UIDiscipleModel:getDiscipleMultipleAttrLookup(guid,isex)
local list={}
for i,v in ipairs(typelist)do
local n=temp[v]or 0
local zeroCheck=false
if zero_hide==true then
local cfg=helper.getAttributeCfg(v)
if cfg.zero_hide then
zeroCheck=true
end
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



function UIDiscipleModel.getAttrListByType(attrlookup,typelist,is_ex,zero_hide)
local temp=table.deepCopy(attrlookup)
if is_ex then
helper.getAttrRelationShipChange(temp)
end
local list={}
for i,v in ipairs(typelist)do
local n=temp[v]or 0
local zeroCheck=false
if zero_hide==true then
local cfg=helper.getAttributeCfg(v)
if cfg.zero_hide then
zeroCheck=true
end
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

function UIDiscipleModel.getAttrListByType2(atrrlist,typelist,is_ex,zero_hide)
local attrlookup=UIDiscipleModel.getAttrListLookup(atrrlist)
return UIDiscipleModel.getAttrListByType(attrlookup,typelist,is_ex,zero_hide)
end

function UIDiscipleModel.getAttrListLookup(atrrlist)
local attrlookup={}
for i,v in ipairs(atrrlist)do
local attrType=v.param_1
local attrValue=v.param_2
local cfg=cfgHelper.get1(cfg_attributesconfig_get,attrType)
if cfg then
attrlookup[attrType]=attrValue
end
end
return attrlookup
end

function UIDiscipleModel:getSixAttrTotalVal(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)

local totalVal=0

for i,v in ipairs(netData.attrList)do
local a=v==0 and 1 or v
totalVal=totalVal+a
end

return totalVal
end




function UIDiscipleModel:testFunc_printDiscipleLTBaseAttr(discipleGuidStr)
local netData=UIDiscipleModel:getDiscipleData(discipleGuidStr)

local imageInfo=UIDiscipleModel:getDiscipleImageInfo(discipleGuidStr)
local job=imageInfo.job
local liantilv=netData.liantilv

local result={}
local result_broke={}
local result_exp={}




local disciplelianticonfig=cfg_disciplelianticonfig_get(liantilv)
if disciplelianticonfig.attr[job]then
for i,v in ipairs(disciplelianticonfig.attr[job])do
result[v[1]]=result[v[1]]or 0
result[v[1]]=result[v[1]]+v[2]

result_broke[v[1]]=result_broke[v[1]]or 0
result_broke[v[1]]=result_broke[v[1]]+v[2]
end
end

if disciplelianticonfig.expattr[job]then
for i,v in ipairs(disciplelianticonfig.expattr[job])do
result[v[1]]=result[v[1]]or 0
result[v[1]]=result[v[1]]+v[2]

result_exp[v[1]]=result_exp[v[1]]or 0
result_exp[v[1]]=result_exp[v[1]]+v[2]
end
end



end
