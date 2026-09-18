







local allAttrLookup=nil
local allDirty=false

function gubaoModel:clearAllAttr()
allAttrLookup=nil
allDirty=false
gubaoModel:clearAllSkillEffect()
end

function gubaoModel:getAllAttrLookup(is_ex)
if allAttrLookup==nil or allDirty then
allAttrLookup={}
local allgubao=gubaoModel:getGuGaoArray()
if allgubao~=nil then
local suitlookup1={}
local suitlookup2={}
local suitlookup3={}


for k,v in pairs(allgubao)do

local lookup=gubaoModel:getAttrLookup(v.gubaoid)
for k2,v2 in pairs(lookup)do
allAttrLookup[k2]=allAttrLookup[k2]or 0
allAttrLookup[k2]=allAttrLookup[k2]+v2
end

local suitlist=gubaoLookup:getSuitList(v.gubaoid)
if suitlist~=nil and#suitlist>0 then
for i2,v2 in ipairs(suitlist)do

if gubaoModel:checkSuitActive1(v2)then
suitlookup1[v2]=true
end

if gubaoModel:checkSuitActive2(v2)then
suitlookup2[v2]=true
end

if gubaoModel:checkSuitActive3(v2)then
suitlookup3[v2]=true
end
end
end









end


local colorCollect=gubaoModel:getColorCollect()
if colorCollect then
local ratelp={}
for color,num in pairs(colorCollect)do
local d=gubaoLookup:getColorCollectCfg(color,num)
if d then
local attr=d.cfg.attr
if attr then
for i2,v2 in ipairs(attr)do
allAttrLookup[v2[1]]=allAttrLookup[v2[1]]or 0
allAttrLookup[v2[1]]=allAttrLookup[v2[1]]+v2[2]
end
end
local bonus=d.cfg.bonus
if bonus then
for k2,v2 in pairs(bonus)do
ratelp[k2]=ratelp[k2]or 0
ratelp[k2]=ratelp[k2]+v2
end
end
end
end
if next(ratelp)then
for k,v in pairs(ratelp)do
if allAttrLookup[k]~=nil then
allAttrLookup[k]=math.floor(allAttrLookup[k]*(1+v/100)+0.00001)
end
end
end
end

for k,v in pairs(suitlookup1)do
if v==true then
local suitcfg=cfgHelper.get(cfg_gubaosuitconfig_get,k)
gubaoModel:calculationSkillAttr(allAttrLookup,suitcfg.skill0)
end
end

for k,v in pairs(suitlookup2)do
if v==true then
local suitcfg=cfgHelper.get(cfg_gubaosuitconfig_get,k)
gubaoModel:calculationSkillAttr(allAttrLookup,suitcfg.skill3)
end
end

for k,v in pairs(suitlookup3)do
if v==true then
local suitcfg=cfgHelper.get(cfg_gubaosuitconfig_get,k)
gubaoModel:calculationSkillAttr(allAttrLookup,suitcfg.skill_1)
end
end

if is_ex then
helper.getAttrRelationShipChange(allAttrLookup)
end
allDirty=false
end
end
local temp=table.deepCopy(allAttrLookup)
return temp
end

function gubaoModel:getBaseAttrList(gbid,is_ex)
local list={}
local lookup=gubaoModel:getAttrLookup(gbid,is_ex)
local baseAttr=cfgHelper.get2(cfg_gubaoconfig_get,gbid,'attr')
for i,v in ipairs(baseAttr)do
list[i]={v[1],lookup[v[1]]}
end
return list
end

function gubaoModel:getBaseAttrListEx(gbid,lianhualv,starlv,awakelv,is_ex,exskilllv)
local list={}
local lookup={}
gubaoModel:calculationAttrLookup(lookup,gbid,lianhualv,starlv,awakelv,exskilllv)
if is_ex then
helper.getAttrRelationShipChange(lookup)
end
local baseAttr=cfgHelper.get2(cfg_gubaoconfig_get,gbid,'attr')
for i,v in ipairs(baseAttr)do
list[i]={v[1],lookup[v[1]]}
end
return list
end


function gubaoModel:getAttrLookup(gbid,is_ex)
local gbData=gubaoModel:getDataByID(gbid)
if gbData.attrLookup==nil or gbData.attrDirty then
local attrLookup={}
gubaoModel:calculationAttrLookup(attrLookup,gbid,gbData.gubaolhlv,gbData.gubaostar,gbData.gubaojxlv,gbData.gubaoskilllv)
local attrLookupEx={}
gbData.attrLookup=attrLookup
for k,v in pairs(attrLookup)do
attrLookupEx[k]=v
end
helper.getAttrRelationShipChange(attrLookupEx)
gbData.attrLookupEx=attrLookupEx
gbData.attrDirty=false






end
if is_ex==true then
return gbData.attrLookupEx
else
return gbData.attrLookup
end
end

function gubaoModel:calculationAttrLookup(lookup,gbid,lianhualv,starlv,awakelv,exlv)
if lookup==nil then return end

local baseAttr=cfgHelper.get2(cfg_gubaoconfig_get,gbid,'attr')
for i,v in ipairs(baseAttr)do
lookup[v[1]]=lookup[v[1]]or 0
lookup[v[1]]=lookup[v[1]]+v[2]
end

local starRate=cfgHelper.get4(cfg_gubaoconfig_get,gbid,'star',starlv,1)
local awakeRate=0
local awakecfg=cfgHelper.get2(cfg_gubaoconfig_get,gbid,'awake')
if awakecfg then
awakeRate=awakecfg[awakelv][1]
end
local rate=starRate+awakeRate
rate=rate/100

local wltAttr=wanLingTaModel:getWanLingTaGuBaoSpeAttrsLookup()
for i,v in ipairs(baseAttr)do
local wltRate=(wltAttr[v[1]]or 0)/100
lookup[v[1]]=math.floor(lookup[v[1]]*(1+rate+wltRate))
end

local lianhuaAttr=cfgHelper.get4(cfg_gubaoconfig_get,gbid,'lianhua',lianhualv,2)
for i,v in ipairs(lianhuaAttr)do
lookup[v[1]]=lookup[v[1]]or 0
local wltRate=(wltAttr[v[1]]or 0)/100
lookup[v[1]]=lookup[v[1]]+math.floor(v[2]*(1+wltRate))
end

local bonusAttr=gubaoModel:getGuBaoBonusAttrsLookup()
for i,v in ipairs(baseAttr)do
local bonusRate=(bonusAttr[v[1]]or 0)/100
lookup[v[1]]=math.floor(lookup[v[1]]*(1+bonusRate))
end

local skilllv=gubaoModel:getSkillLvEx(gbid,starlv,awakelv,exlv)
local skilldata=cfgHelper.get3(cfg_gubaoconfig_get,gbid,'skill',skilllv)
gubaoModel:calculationSkillAttr(lookup,skilldata)
end

function gubaoModel:setAttrAllDirty()
allDirty=true
end

function gubaoModel:setGuBaoAllDirty()
allDirty=true
local allgubao=gubaoModel:getGuGaoArray()
if allgubao~=nil then
for _,gbData in pairs(allgubao)do
gbData.attrDirty=true
end
end
end

function gubaoModel:setAttrDirty(gbid,changeDZAttr)
local gbData=gubaoModel:getDataByID(gbid)
if gbData then
gbData.attrDirty=true
allDirty=true
gubaoModel:clearAllSkillEffect()
end

if changeDZAttr then
local attrTypes={DISCIPLE_ATTRIBUTE_TYPE.eJob,DISCIPLE_ATTRIBUTE_TYPE.eJingJie,
DISCIPLE_ATTRIBUTE_TYPE.eLianTi,DISCIPLE_ATTRIBUTE_TYPE.eXianMoDaoHeng}
UIDiscipleModel:setAllDiscipleAttrListDirty(attrTypes)
else
UIDiscipleModel:setAllDiscipleAttrListDirty()
end
end

function gubaoModel:setAttrDirty2()
allDirty=true

UIDiscipleModel:setAllDiscipleAttrListDirty()
end

function gubaoModel:calculationSkillAttr(lookup,skilldata)
if skilldata==nil then return end
local idx=0
local paramData=nil

idx=idx+1
paramData=skilldata[idx]
if paramData~=nil and#paramData>0 then
for i,attr in ipairs(paramData)do
lookup[attr[1]]=lookup[attr[1]]or 0
lookup[attr[1]]=lookup[attr[1]]+attr[2]
end
end














end

function gubaoModel:getMaxAttrLookup(gbid)
local lookup={}
local cfg=cfg_gubaoconfig_get(gbid)
local lianhualv=#cfg.lianhua
local starlv=#cfg.star
local awakelv=#cfg.awake
local exlv=#(cfg.level or{})
gubaoModel:calculationAttrLookup(lookup,gbid,lianhualv,starlv,awakelv,exlv)
return lookup
end

function gubaoModel:getMinAttrLookup(gbid)
local lookup={}
local cfg=cfg_gubaoconfig_get(gbid)
local lianhualv=0
local starlv=0
local awakelv=0
local exlv=cfg.level and 1 or 0
gubaoModel:calculationAttrLookup(lookup,gbid,lianhualv,starlv,awakelv,exlv)
return lookup
end

function gubaoModel:getBaoShuZhuLingAttrsLookup()
local lookup={}
local level=gubaoModel:getBSZLData()
if level and level>0 then
local cfg=cfg_baoshuzhulinglevelconfig_get(level)
for i,v in ipairs(cfg.attrs)do
local attrKey,attrVal=unpack(v)
lookup[attrKey]=attrVal
end
end
return lookup
end

function gubaoModel:getGuBaoBonusAttrsLookup()
local lookup={}
local level=gubaoModel:getBSZLData()
if level and level>0 then
local cfg=cfg_baoshuzhulinglevelconfig_get(level)
lookup=cfg.gubao_bonus
end
return lookup
end

