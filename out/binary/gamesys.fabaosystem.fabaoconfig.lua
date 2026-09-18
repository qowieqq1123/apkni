




fabaoConfig={}


FABAO_TYPE=
{
eXiantian=0,
eHoutian=1,
eRandom=2,
eBenMing=3,
}


FABAO_LIANZHI_METRAILAS_FUNC_TYPE=
{
eShuChu=1,
eFangHu=2,
eFuZhu=3,
eZhiLiao=4,
}

FABAO_LIANZHI_METRAILAS_FUNC_TYPE_Name=
{
[FABAO_LIANZHI_METRAILAS_FUNC_TYPE.eShuChu]='输出',
[FABAO_LIANZHI_METRAILAS_FUNC_TYPE.eFangHu]='防御',
[FABAO_LIANZHI_METRAILAS_FUNC_TYPE.eFuZhu]='辅助',
[FABAO_LIANZHI_METRAILAS_FUNC_TYPE.eZhiLiao]='治疗',
}

FABAO_LIANZHI_TYPE=
{
eNomal=1,
eMake=2,
ePrize=3,
}

FABAO_CIZHUI_EFFECT_TYPE=
{
eAddAttr=1,
eAddFabaoAttr=2,
eAddJobActiveSkillLv=3,
eAddFabaoUseJingjieLv=4,
eAddPassiveSkill=5,
}

local _bmQualityColorBg=
{
[eQualityColor.ePurple]='image_benmingfbpz_1',
[eQualityColor.eOrange]='image_benmingfbpz_2',
[eQualityColor.eRed]='image_benmingfbpz_3',
}
fabaoConfig.bmQualityBg=_bmQualityColorBg

local _elementConfig=nil
local _maxStage=5
local _minTuPoLv=nil
local _jinghuaIds=nil
local _jinglianTuPoList=nil

function fabaoConfig.maxStage()
return _maxStage
end

function fabaoConfig.isXiantianFabao(itemid)
local itemConfig=itemsConfig.getConfig(itemid)
return itemConfig.type1==FABAO_TYPE.eXiantian
end

function fabaoConfig.isHoutianFabao(itemid)
local itemConfig=itemsConfig.getConfig(itemid)
return itemConfig.type1==FABAO_TYPE.eHoutian
end

function fabaoConfig.isBenMingFabao(itemid)
local itemConfig=itemsConfig.getConfig(itemid)
return itemConfig.type1==FABAO_TYPE.eBenMing
end

function fabaoConfig.isRandomFabao(itemid)
local itemConfig=itemsConfig.getConfig(itemid)
return itemConfig.type1==FABAO_TYPE.eRandom
end



function fabaoConfig.getShentongConfig(shentongid)
return cfg_skillconfig_get(shentongid)
end

function fabaoConfig.getCommonConfig()
return cfg_disciplefabaoconfig_get(1)
end

function fabaoConfig.getFabaoMaxEquipStage()
return EQUIP_STAGE_MAX
end

function fabaoConfig.getFabaoStageByEquipStage(stage)
return fabaoConfig.getCommonConfig().stage[stage]
end


function fabaoConfig.getDressJingjielv(stage)
return fabaoConfig.getCommonConfig().jingjie[stage]
end

function fabaoConfig.getDressState(jjlv)
local stage=0
local jingjie=fabaoConfig.getCommonConfig().jingjie
for i,v in ipairs(jingjie)do
if jjlv>=v then
stage=i
end
end
return stage
end

function fabaoConfig.getDressJingjieConfig()
return fabaoConfig.getCommonConfig().jingjie
end

function fabaoConfig.getCiZhuiConfig(id)
return cfg_disciplefabaoczconfig_get(id)
end

function fabaoConfig.getCostByLianzhi(stage)
local consume=fabaoConfig.getCommonConfig().lianzhi
return consume[stage]
end


function fabaoConfig.getGuiYuanConfig()
return fabaoConfig.getCommonConfig().guiyuan
end

function fabaoConfig.getElementConfig(id)
return cfg_elementtypeconfig_get(id)
end

function fabaoConfig.getElementTypeByAttrid(attrid)
if _elementConfig==nil then
_elementConfig={}
local configs=cfg_elementtypeconfig()
for i,v in ipairs(configs)do
_elementConfig[v.attrid]=v.id
end
end
return _elementConfig[attrid]
end

function fabaoConfig.getCreateTime(stage)
local lianzhitime=fabaoConfig.getCommonConfig().lianzhitime
return lianzhitime[stage]or lianzhitime[0]
end




function fabaoConfig.getLianhuaConfig(stage)
return cfg_disciplefabaolianhuaconfig_get(stage)
end


function fabaoConfig.getLianhuaMaxNum(stage)
local config=fabaoConfig.getLianhuaConfig(stage)
if config then return config.limit end
loggerUtil.logErrFMT('没有找到阶数为{0}的法宝炼化配置',stage)
return 0
end


function fabaoConfig.getLianhuaUpTimesMaxNum(stage)
local lianhuaConfig=fabaoConfig.getLianhuaConfig(stage)
if lianhuaConfig then
return#lianhuaConfig.times
end
loggerUtil.logErrFMT('没有找到阶数为{0}的法宝炼化配置',stage)
return 0
end


function fabaoConfig.getLianhuaUpItemid()
return fabaoConfig.getCommonConfig().lianhuaup
end


function fabaoConfig.getCostByLianhua(stage)
local consume=fabaoConfig.getCommonConfig().lianhua
return consume[stage]
end


function fabaoConfig.getLianhuaUpTimesCost(stage,lv,nextLv)
local lianhuaConfig=fabaoConfig.getLianhuaConfig(stage)
if lianhuaConfig then
local times=lianhuaConfig.times
local curval=0
if lv>0 then
curval=times[lv]
end
local nextVal=times[nextLv]
return nextVal-curval
end
loggerUtil.logErrFMT('没有找到阶数为{0}的法宝炼化配置',stage)
return 0
end





function fabaoConfig.getJilianConfig(lv)
return cfg_disciplefabaojilianconfig_get(lv)
end

function fabaoConfig.getJilianConstConfig()
return cfg_disciplefabaojilianconfig().const_def
end


function fabaoConfig.getJilianExp(level,stage,color)
local jingliaConfig=fabaoConfig.getJilianConfig(level)or{}
local exp=jingliaConfig.exp
local ret=0





if exp[stage]then
ret=exp[stage][color]or 0
end
return ret
end


function fabaoConfig.getJilianMaxLv(stage)
local const_def=fabaoConfig.getJilianConstConfig()
return const_def.stagelv[stage]or 0
end


function fabaoConfig.getJilianCost()
local const_def=fabaoConfig.getJilianConstConfig()
return const_def.consume
end

function fabaoConfig.getJilianItemList()
local const_def=fabaoConfig.getJilianConstConfig()
return const_def.itemexp
end

function fabaoConfig.getdefaultJinglianItem()
local const_def=fabaoConfig.getJilianConstConfig()
return const_def.itemdefault
end

function fabaoConfig.getJilianCostMoney(revise,addexp)
return math.ceil(addexp/revise)
end

function fabaoConfig.getJilianLeftExpRatio()
local const_def=fabaoConfig.getJilianConstConfig()
return const_def.leftexp
end

function fabaoConfig.getJilianResetCost()
local const_def=fabaoConfig.getJilianConstConfig()
return const_def.jlczconsume
end


function fabaoConfig.isJilianItem(itemid)
local const_def=fabaoConfig.getJilianConstConfig()
if itemsConfig.isItem(itemid)then
return const_def.itemexp[itemid]
elseif itemsConfig.isFabao(itemid)then
local fabaoexp=const_def.fabaoexp or{}
local itemConfig=itemsConfig.getConfig(itemid)
local stage=itemConfig.stage
local color=itemConfig.color
local fabaoexpStage1=fabaoexp[stage]or{}
local stageExp=fabaoexpStage1[color]
return stageExp
end
return false
end

function fabaoConfig.getJilianTuPoCost(lv,itemid)
local jlcfg=fabaoConfig.getJilianConfig(lv)
if jlcfg.tupo then
local cfg=itemsConfig.getConfig(itemid)
local color=cfg.color
local stage=cfg.stage
if jlcfg.tupo[color]==nil then
loggerUtil.logErrFMT('法宝精炼突破消耗配置：等级{0}缺少品质{1}配置',lv,color)
return
end
local colorTable=jlcfg.tupo[color]
if colorTable[stage]==nil then
loggerUtil.logErrFMT('法宝精炼突破消耗配置：等级{0}品质{1}缺少品阶{2}配置',lv,color,stage)
return
end
return colorTable[stage]
end
end

function fabaoConfig.isJilianTuPoLv(lv,itemid)
return fabaoConfig.getJilianTuPoCost(lv,itemid)~=nil
end

function fabaoConfig.getMinTuPoLv()
if _minTuPoLv==nil then
for i,v in pairs(cfg_disciplefabaojilianconfig())do
if v.tupo and(_minTuPoLv==nil or v.id<=_minTuPoLv)then
_minTuPoLv=v.id
end
end
end
return _minTuPoLv or 0
end

function fabaoConfig.getJlTuPoList()
if _jinglianTuPoList==nil then
_jinglianTuPoList={}
for i,v in ipairs(cfg_disciplefabaojilianconfig())do
if v.tupo then
_jinglianTuPoList[#_jinglianTuPoList+1]=v.id
end
end
end
return _jinglianTuPoList
end


function fabaoConfig.getFanZhuLxItems(itemguid,lxlv)
local bmfabaoCfg=cfgHelper.get(cfg_bagualuaconfig_get,1,"bmfabao")
local items={}

local lxCount=fabaoModel.getFabaoLingXingExp(itemguid)
for i=0,lxlv-1 do
local cfg=fabaoConfig.getLxConfig(i)
lxCount=cfg.exp+lxCount

if cfg.tupo then
for j,item in ipairs(cfg.tupo)do
if not items[item[1]]then
items[item[1]]=item[2]
else
items[item[1]]=items[item[1]]+item[2]
end
end
end
end


local isActive=false
local monthInvestorCfg=cfg_yuekaconfig()
if monthInvestorCfg[2]then
local highMonthCfg=monthInvestorCfg[2]
isActive=rechargeModel:checkCardActive(highMonthCfg.id)
end

local list={}
for i,v in pairs(items)do
local num=1
if not isActive and bmfabaoCfg[2][i]then
num=bmfabaoCfg[2][i]
end
local count=math.floor(v*num)
if count>0 then
table.insert(list,{i,count})
end
end

local num=isActive and 1 or bmfabaoCfg[1][1]
lxCount=lxCount*num
for i,v in ipairs(bmfabaoCfg[1][2])do
local itemCount=math.floor(lxCount/v[1])
lxCount=lxCount-itemCount*v[1]
if itemCount>0 then
table.insert(list,{v[2],itemCount})
end
end
return list
end

function fabaoConfig.getNextJlTuPolv(lv)
local list=fabaoConfig.getJlTuPoList()
for i,v in ipairs(list)do
if lv<=v then
return v
end
end
end


local _lxbonusLvList
local _lxbonusEffectLvList
local _lxbonuslvLook
local _lxtupolvlist
function fabaoConfig.getlxConstConfig()
return cfg_disciplefabaolingxingconfig().const_def
end

function fabaoConfig.getLxConfig(lxlv,show)
return cfg_disciplefabaolingxingconfig_get(lxlv,show)
end


function fabaoConfig.getNeedLxExpByLx(lxlv)
return fabaoConfig.getLxConfig(lxlv).exp
end


function fabaoConfig.getNeedJingjielvByLx(lxlv)
return fabaoConfig.getLxConfig(lxlv).jingjie or 0
end


function fabaoConfig.isLxTuPoLv(lxlv)
return fabaoConfig.getLxConfig(lxlv).exp==0
end


function fabaoConfig.isLxMaxLv(lxlv)
return fabaoConfig.getLxConfig(lxlv+1,false)==nil
end

function fabaoConfig.getStoreLxExp(lxlv)
local cfg=cfg_disciplefabaolingxingconfig_get(lxlv)
local exp=cfg.exp
if exp==0 then return 0 end
local max=0
local tplv=fabaoConfig.getCurrentLxTuPoLv(lxlv)
if tplv then
for i=lxlv,tplv do
max=max+cfg_disciplefabaolingxingconfig_get(i).exp
end
end
return max
end

function fabaoConfig.getTuPoLxCost(lxlv)
return fabaoConfig.getLxConfig(lxlv).tupo
end

local _initlx=function()
if _lxbonusLvList==nil then
_lxbonusLvList={}
_lxbonuslvLook={}
_lxtupolvlist={}
_lxbonusEffectLvList={}
local effectlookup={}
local add=function(lv,bonus)
if bonus==nil then return end
for i,v in ipairs(bonus)do
local last=effectlookup[i]or 0
if v>last then
if _lxbonusEffectLvList[i]==nil then _lxbonusEffectLvList[i]={}end
local effectlist=_lxbonusEffectLvList[i]
effectlist[#effectlist+1]=lv
effectlookup[i]=v
_lxbonusLvList[#_lxbonusLvList+1]=lv
_lxbonuslvLook[lv]={i,v}
end
end
end

local cfgs=cfg_disciplefabaolingxingconfig()
add(0,cfgs[0].bonus)
for i,v in ipairs(cfgs)do
add(v.id,v.bonus)
if v.exp==0 then
_lxtupolvlist[#_lxtupolvlist+1]=v.id
end
end
end
end

function fabaoConfig.getLxEffectList()
_initlx()
return _lxbonusLvList,_lxbonuslvLook,_lxbonusEffectLvList
end


function fabaoConfig.getCurrentLxTuPoLv(lxlv)
_initlx()
for i,v in ipairs(_lxtupolvlist)do
if lxlv<=v then
return v
end
end
end

function fabaoConfig.getLastEffectLv(effectType,lv)
_initlx()
local t=_lxbonusEffectLvList[effectType]or{}
local last
for i,v in ipairs(t)do
if v==lv then
return last
else
last=v
end
end
end

function fabaoConfig.getTuPoAttrLookup(jllv)
local jlCfg=fabaoConfig.getJilianConfig(jllv)
return jlCfg.tpattr
end

function fabaoConfig.initJinghuaIds()
if _jinghuaIds==nil then
_jinghuaIds={}
local cfgs=cfg_disciplefabaoconfig_get(1).jinghuacolorfix
for itemid,_ in pairs(cfgs)do
_jinghuaIds[#_jinghuaIds+1]=itemid
end
end
end

function fabaoConfig.getJingHuaCfg()
local cfgs=cfg_disciplefabaoconfig_get(1).jinghuacolorfix
fabaoConfig.initJinghuaIds()
return cfgs
end

function fabaoConfig.getJingHuaIds()
fabaoConfig.initJinghuaIds()
return _jinghuaIds
end

function fabaoConfig.isJingHua(itemid)
local cfg=fabaoConfig.getJingHuaCfg()
return cfg[itemid]~=nil
end

function fabaoConfig.getMaxBetterReddotLv()
return fabaoConfig.getCommonConfig().betterreddotlv or 10000
end
