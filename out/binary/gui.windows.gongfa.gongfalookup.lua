







gongfaLookup={}

local table_insert=table.insert
local table_sort=table.sort

local hide_gongfa_lookup=nil
local all_gongfaconfig=nil
local element_gongfa_lookup=nil
local faction_gongfa_lookup=nil
local effect_gongfa_lookup=nil
local skill_gongfa_lookup=nil

local pieces_gongfa_lookup=nil
local pieces_gongfa_lookup_index=nil
local gongfa_pieces_lookup=nil
local gfConditonFilterType=
{
eGFEffect1=1,
eGFEffect2=2,
eGFEffect3=3,
eGFFaction=4,
}

local gfConditonFilterType2=
{
eGFElement=1,
eGFEffect1=2,
eGFEffect2=3,
eGFEffect3=4,
eGFFaction=5,
}

local gfConditonFilterTypeName=
{
[gfConditonFilterType.eGFEffect1]='强化效果',
[gfConditonFilterType.eGFEffect2]='弱化效果',
[gfConditonFilterType.eGFEffect3]='其它效果',
[gfConditonFilterType.eGFFaction]='功法派系',
}

local gfConditonFilterTypeName2=
{
[gfConditonFilterType2.eGFElement]='功法系别',
[gfConditonFilterType2.eGFEffect1]='强化效果',
[gfConditonFilterType2.eGFEffect2]='弱化效果',
[gfConditonFilterType2.eGFEffect3]='其它效果',
[gfConditonFilterType2.eGFFaction]='功法派系',
}

function gongfaLookup:initalize()
if not initProControl.isDoneKF()or
not initProControl.isDone()then return end
gongfaLookup:initAllGongFaConfig()
end

function gongfaLookup:initLookup()
if element_gongfa_lookup==nil then
element_gongfa_lookup={}
faction_gongfa_lookup={}
effect_gongfa_lookup={}
skill_gongfa_lookup={}
pieces_gongfa_lookup={}
pieces_gongfa_lookup_index={}
gongfa_pieces_lookup={}
all_gongfaconfig={}
hide_gongfa_lookup={}
local configs=cfg_disciplegongfaconfig()
for k,v in pairs(configs)do
if v.id~=nil and not v.isHide then
table.insert(all_gongfaconfig,v)
elseif v.id~=nil then
hide_gongfa_lookup[v.id]=true
end
end

for k,v in pairs(all_gongfaconfig)do
if v.id~=nil and not v.isHide then

for i1,v1 in ipairs(v.element)do
if element_gongfa_lookup[v1]==nil then
element_gongfa_lookup[v1]={}
end
element_gongfa_lookup[v1][v.id]=true
end

local faction=v.faction or 0
if faction_gongfa_lookup[faction]==nil then
faction_gongfa_lookup[faction]={}
end
faction_gongfa_lookup[faction][v.id]=true

for i1,v1 in ipairs(v.effects)do
if effect_gongfa_lookup[v1]==nil then
effect_gongfa_lookup[v1]={}
end
effect_gongfa_lookup[v1][v.id]=true
end

for i1,v1 in ipairs(v.skill)do
skill_gongfa_lookup[v1]=v.id
end

if v.piece then

gongfa_pieces_lookup[v.id]={}
for i1,v1 in ipairs(v.piece)do
pieces_gongfa_lookup_index[v1[1]]={v.id,i1}
gongfa_pieces_lookup[v.id][#gongfa_pieces_lookup[v.id]+1]=v1[1]
end
end

if v.study then
local studyCostCfg=v.study[0][1]
local studyCostItemCfg=studyCostCfg[1]
local studyCostItemList=studyCostItemCfg[1]or{}
for i1,v1 in ipairs(studyCostItemList)do
pieces_gongfa_lookup[v1]=v.id
end
end
end
end
end
end

function gongfaLookup:initAllGongFaConfig()
all_gongfaconfig={}
hide_gongfa_lookup={}
local configs=cfg_disciplegongfaconfig()
for k,v in pairs(configs)do
if v.id~=nil and not v.isHide and gongfaLookup:checkServerLimitOpen(v.serverlimit)then
table.insert(all_gongfaconfig,v)
elseif v.id~=nil then
hide_gongfa_lookup[v.id]=true
end
end
end

function gongfaLookup:clearLookup()
element_gongfa_lookup=nil
faction_gongfa_lookup=nil
effect_gongfa_lookup=nil
skill_gongfa_lookup=nil
pieces_gongfa_lookup=nil
pieces_gongfa_lookup_index=nil
gongfa_pieces_lookup=nil
end


function gongfaLookup:checkServerLimitOpen(serverlimit)
if serverlimit==nil then return true end

local type=serverlimit.type
local pfCfg=serverlimit.pf
local pfid=loginModel:getPfid()
local bigServerId=loginModel.cross_sid
local serverid=playerModel:getActorServerID()

if type==1 then
if pfCfg==nil then return true end

for k,v in pairs(pfCfg)do
if pfid==k or k==-1 then
if v==-1 then return true end
local rangeServer=v[-1]
if rangeServer==nil and#v==0 then return false end
for _,vv in ipairs(v)do
if serverid==vv then

return true
end
end
if rangeServer then
for i,vv in ipairs(rangeServer)do
if serverid>=vv[1]and serverid<=vv[2]then

return true
end
end
end
end
end
return false
elseif type==2 then
if pfCfg==nil then return false end

for k,v in pairs(pfCfg)do
if pfid==k or k==-1 then
if v==-1 then return false end
local rangeServer=v[-1]
if rangeServer==nil and#v==0 then return true end
for _,vv in ipairs(v)do
if serverid==vv then

return false
end
end
if rangeServer then
for i,vv in ipairs(rangeServer)do
if serverid>=vv[1]and serverid<=vv[2]then

return false
end
end
end
end
end
return true
elseif type==3 then
if pfCfg==nil then return true end

for k,v in pairs(pfCfg)do
if pfid==k or k==-1 then
if v==-1 then return true end
local rangeServer=v[-1]
if rangeServer==nil and#v==0 then return false end
for _,vv in ipairs(v)do
if bigServerId==vv then

return true
end
end
if rangeServer then
for i,vv in ipairs(rangeServer)do
if bigServerId>=vv[1]and bigServerId<=vv[2]then

return true
end
end
end
end
end
return false
elseif type==4 then
if pfCfg==nil then return false end

for k,v in pairs(pfCfg)do
if pfid==k or k==-1 then
if v==-1 then return false end
local rangeServer=v[-1]
if rangeServer==nil and#v==0 then return true end
for _,vv in ipairs(v)do
if bigServerId==vv then

return false
end
end
if rangeServer then
for i,vv in ipairs(rangeServer)do
if bigServerId>=vv[1]and bigServerId<=vv[2]then

return false
end
end
end
end
end
return true
else
loggerUtil.debugErrFMT('功法serverlimit尚未支持类型：{0}',type)
end
return false
end

function gongfaLookup:isHideGongFa(gfID)
return hide_gongfa_lookup[gfID]==true
end
function gongfaLookup:isGongFaSkill(skilID)
return gongfaLookup:getGongFaIDBySkill(skilID)~=nil
end

function gongfaLookup:getGongFaIDBySkill(skilID)
return skill_gongfa_lookup[skilID]
end

function gongfaLookup:checkGongFaHasElement(elementType,gfID)
if element_gongfa_lookup[elementType]~=nil then
return element_gongfa_lookup[elementType][gfID]~=nil
end
return false
end

function gongfaLookup:checkGongFaHasFaction(factionType,gfID)
if faction_gongfa_lookup[factionType]~=nil then
return faction_gongfa_lookup[factionType][gfID]~=nil
end
return false
end

function gongfaLookup:checkGongFaHasEffect(effectType,gfID)
if effect_gongfa_lookup[effectType]~=nil then
return effect_gongfa_lookup[effectType][gfID]~=nil
end
return false
end

function gongfaLookup:checkGongfaPiece(itemid)
return pieces_gongfa_lookup[itemid]
end

function gongfaLookup:checkGongfaPieceindex(itemid)
return pieces_gongfa_lookup_index[itemid]
end


function gongfaLookup:checkpiecesgongfa(GFid)
return gongfa_pieces_lookup[GFid]
end


function gongfaLookup:getAllActiveGongFaList()
local result={}
for k,v in pairs(all_gongfaconfig)do
local gfID=v.id
if UIGongFaModel:isGongFaActive(gfID)then
result[#result+1]=v
end
end
return result
end

function gongfaLookup:getAllActiveGongFaList2()
local result={}
for k,v in pairs(all_gongfaconfig)do
local gfID=v.id
if UIGongFaModel:isGongFaActive(gfID)then
result[#result+1]={cfg=v}
end
end
return result
end


function gongfaLookup:getAllActiveNotLearnGongFaList(dis_guid)
local result={}
for k,v in pairs(all_gongfaconfig)do
local gfID=v.id
if UIGongFaModel:isGongFaActive(gfID)then
if UIDiscipleModel:getDiscipleGFData(dis_guid,gfID)==nil then
result[#result+1]={cfg=v}
end
end
end
return result
end


function gongfaLookup:checkCanLearnGongFaReddot(dis_guid)

if zongmenModel:findBuildingDataByType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eCangJingGe)==nil then

return false
end


local moneyType=eMoneyType.mtChuanDao

local hasmoney=moneyModel.getMoney(moneyType)

for k,v in pairs(all_gongfaconfig)do
local gfID=v.id
if UIGongFaModel:isGongFaActive(gfID)and UIDiscipleModel:getDiscipleGFData(dis_guid,gfID)==nil then

local needmoney=UIGongFaModel:getGFConsume(dis_guid,gfID)
if hasmoney>=needmoney then

return true
end
end
end
return false
end

function gongfaLookup:getAllGongFaList()
local result={}
for k,v in pairs(all_gongfaconfig)do
if UIGongFaModel:isGongFaActive(v.id)then
result[#result+1]=v
else

local glid,main=liandonModel:CheckGongFa_Guanlian(v.id)
if glid then
local hasCanActivePage=UIGongFaModel:hasCanActivePage(v.id)
local canActiveGLFG=liandonModel:JudeGuanLianGFCanActive(v.id)

if not liandonModel:JudeGuanLianGFisActive(v.id)then
if main==1 then

if not canActiveGLFG and not hasCanActivePage then
result[#result+1]=v
elseif not canActiveGLFG and hasCanActivePage then

result[#result+1]=v
elseif canActiveGLFG and hasCanActivePage then

result[#result+1]=v
end
elseif main==2 then

if not canActiveGLFG and hasCanActivePage then
result[#result+1]=v
end
end
end
else
result[#result+1]=v
end
end
end
return result
end



function gongfaLookup:getSortGongFaList(list,sortType,sortCondition,sortCondition2,sortOrder)
local result={}
for i,v in ipairs(list)do
local gfID=v.id
local add=true

if sortCondition2~=nil then

local element=sortCondition2
if element>0 then
local addx=false
if gongfaLookup:checkGongFaHasElement(element,gfID)then
addx=true
end
add=add and addx
end
end
if sortCondition~=nil then

local effect_add=false
local has_effect=false
for i1=gfConditonFilterType.eGFEffect1,gfConditonFilterType.eGFEffect3 do
if sortCondition[i1]~=nil and#sortCondition[i1]>0 then
has_effect=true
for i2,v2 in ipairs(sortCondition[i1])do
if gongfaLookup:checkGongFaHasEffect(v2,gfID)then
effect_add=true
break
end
end
end
end
if has_effect then
add=add and effect_add
end

local fType=gfConditonFilterType.eGFFaction
if sortCondition[fType]~=nil and#sortCondition[fType]>0 then
local addx=false
for i1,v1 in ipairs(sortCondition[fType])do
if gongfaLookup:checkGongFaHasFaction(v1,gfID)then
addx=true
break
end
end
add=add and addx
end
end

if add then
result[#result+1]=v
end
end
if#result>0 then
if sortType~=nil then
sortOrder=sortOrder or eSortOrder.eDown
if sortType==0 then

table_sort(result,function(a,b)
local va=0
local vb=0
return gongfaLookup:commonSortGongFa(va,vb,a,b,sortOrder)
end)
else

table_sort(result,function(a,b)
local element=sortType
local va=gongfaLookup:checkGongFaHasElement(element,a.id)==true and 1 or 0
local vb=gongfaLookup:checkGongFaHasElement(element,b.id)==true and 1 or 0
return gongfaLookup:commonSortGongFa(va,vb,a,b,sortOrder)
end)
end
end
end
return result
end

function gongfaLookup:commonSortGongFa(va,vb,a,b,sortOrder)
local acan=UIGongFaModel:hasCanActivePage(a.id)==true and 1 or 0
local bcan=UIGongFaModel:hasCanActivePage(b.id)==true and 1 or 0
if acan==bcan then
local a_canstudy=UIGongFaModel:checkStudyReddot(a.id)==true and 1 or 0
local b_canstudy=UIGongFaModel:checkStudyReddot(b.id)==true and 1 or 0
if a_canstudy==b_canstudy then
local aactive=UIGongFaModel:isGongFaActive(a.id)==true and 1 or 0
local bactive=UIGongFaModel:isGongFaActive(b.id)==true and 1 or 0
if aactive==bactive then
if aactive==1 then
if va==vb then
local ca=a.color
local cb=b.color
if ca==cb then
return helper.sortOrderComparis(a.id,b.id,sortOrder)
else
return helper.sortOrderComparis(ca,cb,sortOrder)
end
else
return helper.sortOrderComparis(va,vb,sortOrder)
end
else
local ca=a.color
local cb=b.color
if ca==cb then
return helper.sortOrderComparis(a.id,b.id,sortOrder)
else
return helper.sortOrderComparis(ca,cb,sortOrder)
end
end
else
return aactive>bactive
end
else
return a_canstudy>b_canstudy
end
else
return acan>bcan
end
end

function gongfaLookup:getSortGongFaList2(list,sortType,sortCondition,sortOrder,dis_guid)
local result={}
for i,v in ipairs(list)do
local cfg=v.cfg
local gfID=cfg.id
local add=true
if sortCondition~=nil then
local fType

fType=gfConditonFilterType2.eGFElement
if sortCondition[fType]~=nil and#sortCondition[fType]>0 then
local addx=false
for i1,v1 in ipairs(sortCondition[fType])do
if gongfaLookup:checkGongFaHasElement(v1,gfID)then
addx=true
break
end
end
add=add and addx
end

for i1=gfConditonFilterType2.eGFEffect1,gfConditonFilterType2.eGFEffect3 do
if sortCondition[i1]~=nil and#sortCondition[i1]>0 then
local addx=false
for i2,v2 in ipairs(sortCondition[i1])do
if gongfaLookup:checkGongFaHasEffect(v2,gfID)then
addx=true
break
end
end
add=add and addx
end
end

fType=gfConditonFilterType2.eGFFaction
if sortCondition[fType]~=nil and#sortCondition[fType]>0 then
local addx=false
for i1,v1 in ipairs(sortCondition[fType])do
if gongfaLookup:checkGongFaHasFaction(v1,gfID)then
addx=true
break
end
end
add=add and addx
end
end

sortType=sortType or 1
local fix=UIGongFaModel:checkGongFaFixDisciple(gfID,dis_guid)
local isTuijian=0
local addx=true
if sortType==2 then

addx=false
if fix then
addx=true
isTuijian=1
end
elseif sortType==3 then

addx=false
if not fix then
addx=true
end
else

if fix then
isTuijian=1
end
end
add=add and addx

if add then
v.isTuijian=isTuijian
result[#result+1]=v
end
end
if#result>0 then
if sortType~=nil then
sortOrder=sortOrder or eSortOrder.eDown
table_sort(result,function(a,b)
if a.isTuijian==b.isTuijian then
return helper.sortOrderComparis(a.isTuijian2,b.isTuijian2,sortOrder)
else
return a.isTuijian>b.isTuijian
end
end)
end
end
return result
end

function gongfaLookup:getConditonFilter()
local fType
local filterName={}
local filterFlag={}

fType=gfConditonFilterType.eGFEffect1-1
for i=gfConditonFilterType.eGFEffect1,gfConditonFilterType.eGFEffect3 do
filterName[i]={}
filterName[i][1]=gfConditonFilterTypeName[i]
filterName[i][2]={}
filterFlag[i]={}
end
local gongfaeffecttypeconfigs=cfg_gongfaeffecttypeconfig()
for i,v in ipairs(gongfaeffecttypeconfigs)do
local kind=v.kind+fType
table.insert(filterName[kind][2],{name=v.name,typeid=v.typeid,icon=UIGongFaModel.getGFEffectIconName(v.icon)})
table.insert(filterFlag[kind],false)
end

fType=gfConditonFilterType.eGFFaction
filterName[fType]={}
filterName[fType][1]=gfConditonFilterTypeName[fType]
filterName[fType][2]={}
filterFlag[fType]={}
local factiontypeconfigs=cfg_factiontypeconfig()
for i,v in ipairs(factiontypeconfigs)do
table.insert(filterName[fType][2],{name=v.name,typeid=v.id})
table.insert(filterFlag[fType],false)
end

return filterName,filterFlag
end

function gongfaLookup:getConditonFilter2()
local fType
local filterName={}
local filterFlag={}

fType=gfConditonFilterType2.eGFElement
filterName[fType]={}
filterName[fType][1]=gfConditonFilterTypeName2[fType]
filterName[fType][2]={}
filterFlag[fType]={}
local elementtypes=ELEMENT_TYPE:getFive()
for i,v in ipairs(elementtypes)do
local icon
if v==0 then
icon=ELEMENT_TYPE.getIconEx(v)
else
icon=ELEMENT_TYPE.getIcon(v)
end
table.insert(filterName[fType][2],{name=ELEMENT_TYPE.getName(v),typeid=v,icon=icon,abname=globalABLookup.global})
table.insert(filterFlag[fType],false)
end

fType=gfConditonFilterType2.eGFEffect1-1
for i=gfConditonFilterType2.eGFEffect1,gfConditonFilterType2.eGFEffect3 do
filterName[i]={}
filterName[i][1]=gfConditonFilterTypeName2[i]
filterName[i][2]={}
filterFlag[i]={}
end
local gongfaeffecttypeconfigs=cfg_gongfaeffecttypeconfig()
for i,v in ipairs(gongfaeffecttypeconfigs)do
local kind=v.kind+fType
table.insert(filterName[kind][2],{name=v.name,typeid=v.typeid,icon=UIGongFaModel.getGFEffectIconName(v.icon)})
table.insert(filterFlag[kind],false)
end

fType=gfConditonFilterType2.eGFFaction
filterName[fType]={}
filterName[fType][1]=gfConditonFilterTypeName2[fType]
filterName[fType][2]={}
filterFlag[fType]={}
local factiontypeconfigs=cfg_factiontypeconfig()
for i,v in ipairs(factiontypeconfigs)do
table.insert(filterName[fType][2],{name=v.name,typeid=v.id})
table.insert(filterFlag[fType],false)
end

return filterName,filterFlag
end
