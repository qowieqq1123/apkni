attrListHelper={}




function attrListHelper.isMod(attrid)
local cfg=cfg_attributesconfig_get(attrid)
return cfg.ifMod
end


function attrListHelper.transformFromNamedList(paramList)
if paramList==nil then return end
local temp={}
for i,v in ipairs(paramList)do
temp[#temp+1]={v.param_1,v.param_2,v.param_3}
end
return temp
end



function attrListHelper.transformToNamedList(list)
if list==nil then return end
local temp={}
for _,v in ipairs(list)do
temp[#temp+1]={param_1=v[1],param_2=v[2]}
end
return temp
end

function attrListHelper.tramsformToLookup(list)
local temp={}
if list then
for _,v in ipairs(list)do
temp[v[1]]=(temp[v[1]]or 0)+v[2]
end
end
return temp
end



function attrListHelper.transformToList(lookup,sortList)
local temp={}
if lookup==nil then return end
if sortList then
local insertTemp={}
for i,v in ipairs(sortList)do
local attrType=v[1]
local val=lookup[attrType]
insertTemp[attrType]=true
temp[#temp+1]={attrType,val}
end

for attrType,val in pairs(lookup)do
if insertTemp[attrType]==nil then
temp[#temp+1]={attrType,val}
end
end
else
for attrType,val in pairs(lookup)do
temp[#temp+1]={attrType,val}
end
end
return temp
end

function attrListHelper.concatLookup(lookup1,lookup2)
local temp={}
if lookup1 then
for i,v in pairs(lookup1)do
if v then
temp[i]=(temp[i]or 0)+v
end
end
end

if lookup2 then
for i,v in pairs(lookup2)do
if v then
temp[i]=(temp[i]or 0)+v
end
end
end
return temp
end

function attrListHelper.concatList(list1,list2)
local temp={}
local insert=function(list)
for _,v1 in ipairs(temp)do
if v1[1]==list[1]then
v1[2]=v1[2]+list[2]
return
end
end
temp[#temp+1]={list[1],list[2]}
end

if list1 then
for _,v in pairs(list1)do
insert(v)
end
end

if list2 then
for _,v in pairs(list2)do
insert(v)
end
end
return temp
end

function attrListHelper.concatRangList(list1,list2)
local temp={}
local insert=function(list)
for _,v1 in ipairs(temp)do
if v1[1]==list[1]then
v1[2]=v1[2]+list[2]
if list.range then
if v1.range==nil then v1.range={}end
local range=v1.range
range[1]=range[1]+list.range[1]
range[2]=range[2]+list.range[2]
end
return
end
end
local range
if list.range then
range={list.range[1],list.range[2]}
end
temp[#temp+1]={list[1],list[2],range=range}
end

if list1 then
for _,v in pairs(list1)do
insert(v)
end
end

if list2 then
for _,v in pairs(list2)do
insert(v)
end
end
return temp
end

function attrListHelper.getChangeLookup(lookup1,lookup2)
if lookup1==nil then lookup1={}end
if lookup2==nil then lookup2={}end
local old={}
for attrType,attrValue in pairs(lookup1)do
old[attrType]=-attrValue
end

local temp={}
for attrType,attrValue in pairs(lookup2)do
local val=attrValue+(old[attrType]or 0)
temp[attrType]=val
end

for attrType,attrValue in pairs(old)do
if temp[attrType]==nil then
temp[attrType]=attrValue
end
end
return temp
end

function attrListHelper.getNewLookup(oldlookup,newlookup)
if oldlookup==nil then oldlookup={}end
if newlookup==nil then newlookup={}end

local temp={}

for attrType,attrValue in pairs(newlookup)do
if oldlookup[attrType]==nil then
temp[attrType]=true
end
end

return temp
end

function attrListHelper.getDiffLookup(oldlookup,newlookup)
if oldlookup==nil then oldlookup={}end
if newlookup==nil then newlookup={}end

local temp={}

for attrType,attrValue in pairs(newlookup)do
if oldlookup[attrType]==nil then
temp[attrType]=0
elseif oldlookup[attrType]~=attrValue then
temp[attrType]=attrValue-oldlookup[attrType]
end
end

return temp
end

function attrListHelper.getLookupOnPercent(lookup,precent,toInt)
if toInt==nil then toInt=true end
local temp={}
if lookup then
for i,v in pairs(lookup)do
if v then
local val=v*(1+precent/100)
if toInt then
val=mathHelper.floor(val)
end
temp[i]=val
end
end
end
return temp
end

function attrListHelper.getAddLookupOnPercent(lookup,precent,toInt)
if precent==0 then return{}end
if toInt==nil then toInt=true end
local temp={}
if lookup then
for i,v in pairs(lookup)do
if v then
local val=v*(precent/100)
if toInt then
val=mathHelper.floor(val)
end
temp[i]=val
end
end
end
return temp
end


function attrListHelper.getAddListOnPercent(list,precent,toInt)
if toInt==nil then toInt=true end
local temp={}
if list then
for i,v in pairs(list)do
local val=v[2]*(precent/100)
if toInt then
val=mathHelper.floor(val)
end
temp[#temp+1]={v[1],val}
end
end
return temp
end


function attrListHelper.getAddListOnPercentLookup(list,precentlookup,toInt)
if toInt==nil then toInt=true end
local temp={}
if list then
for i,v in pairs(list)do
local precent=precentlookup[v[1]]or 0
local val=v[2]*(precent/100)
if toInt then
val=mathHelper.floor(val)
end
temp[#temp+1]={v[1],val}
end
end
return temp
end

function attrListHelper.getAddLookupOnPercentLookup(lookup,precentlookup,toInt)
if toInt==nil then toInt=true end
if precentlookup==nil then return lookup end
local temp={}
if lookup then
for attrid,v in pairs(lookup)do
local cfg=cfg_attributesconfig_get(attrid)
local isMod=cfg.ifMod
local precent=precentlookup[attrid]or 0
if v then
if not isMod then
local val=v*(precent/100)
if toInt then
val=mathHelper.floor(val)
end
temp[attrid]=val
else
temp[attrid]=precent
end
end
end
end
return temp
end

function attrListHelper.sortByList(attrList)
if attrList and#attrList>1 then
local list={}
for k,v in pairs(attrList)do
list[#list+1]={v[1],v[2]}
end
table.sort(list,function(a,b)
return cfg_attributesconfig_get(a[1]).priority<cfg_attributesconfig_get(b[1]).priority
end)
return list
end
return attrList
end

function attrListHelper.sortByLookup(attrLookup)
if attrLookup==nil then return end
local list={}
for k,v in pairs(attrLookup)do
list[#list+1]={k,v}
end
if#list>1 then
table.sort(list,function(a,b)
return cfg_attributesconfig_get(a[1]).priority<cfg_attributesconfig_get(b[1]).priority
end)
end
return list
end