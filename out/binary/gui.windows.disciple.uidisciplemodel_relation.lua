








DISCIPLE_RELATION_TYPE={
eFriend=1,
eShiTu=2,
eDaoLv=3,
eFamily=4,
}

DISCIPLE_FRIEND_RELATION_TYEP=
{
eQinmi=2,
eFriend=1,
eLengmo=0,
eYanwu=-1,
eChoushi=-2,
}

local _relationLookup={}


local _blackRelationtLookup={}

function UIDiscipleModel:initRelation()
_relationLookup={}
_blackRelationtLookup={}
end

function UIDiscipleModel:onInitRelation()
local discipleNetData=UIDiscipleModel:getAllDiscipleDataX()
if discipleNetData==nil then return end
for _,v in pairs(discipleNetData)do
local diziguid1=v.netData.net.discipleguid
local relationList=v.netData.net.relationList
if relationList then
for _,v2 in ipairs(relationList)do
local relationtype=v2.relationtype
local valueList=v2.valueList or{}
for _,v3 in ipairs(valueList)do
local diziguid2=v3.param_1
local hasDZ=UIDiscipleModel:getDiscipleData(diziguid2)~=nil
if hasDZ then
local relationVal=v3.param_2
if tostring(diziguid1)==tostring(diziguid2)then
loggerUtil.logErrFMT("协议下发关系数据有问题 自己是自己的恩怨对象")
end
UIDiscipleModel:setRelation(diziguid1,diziguid2,relationtype,relationVal)
end
end
end
end
end
end

function UIDiscipleModel:onUpdateRelation(discipleguid,relationtype,len,valueList)
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end
local hasDiZi=function(diziguid)
for i,v in ipairs(valueList)do
if tostring(v.param_1)==tostring(diziguid)then
return true
end
end
end

if netData.relationList==nil then netData.relationList={}end
local relationList=netData.relationList
local relationInfo=nil
for i,v in ipairs(relationList)do
if v.relationtype==relationtype then
relationInfo=v
if v.len>0 then
local _valueList=v.valueList
for i=v.len,1,-1 do
if hasDiZi(_valueList[i].param_1)then
table.remove(_valueList,i)
v.len=v.len-1
end
end
end
break
end
end
if relationInfo then
if relationInfo.valueList==nil then relationInfo.valueList={}end
local _valueList=relationInfo.valueList
for i,v in ipairs(valueList)do
_valueList[#_valueList+1]=v
end
relationInfo.len=#_valueList
relationInfo.valueList=_valueList
else
relationInfo={
relationtype=relationtype,
len=len,
valueList=valueList
}
relationList[#relationList+1]=relationInfo
end

if#relationList>1 then
table.sort(relationList,function(a,b)
return a.relationtype<b.relationtype
end)
end
netData.relationlistlen=#relationList

local valueList=valueList or{}
for _,v in ipairs(valueList)do
local diziguid2=v.param_1
local relationVal=v.param_2
if relationVal~=0 then
UIDiscipleModel:setRelation(discipleguid,diziguid2,relationtype,relationVal)
else
UIDiscipleModel:removeRelation(discipleguid,diziguid2,relationtype)
end
end
end

function UIDiscipleModel.deleDiziReleation(diziguid)
local diziguid1Str=tostring(diziguid)
local lookup=_relationLookup[diziguid1Str]
if lookup and lookup.relation then
local relation=lookup.relation
for _,diziguid2 in ipairs(relation)do
UIDiscipleModel:clearRelation(diziguid2,diziguid)
UIDiscipleModel:removeBlackReleation(diziguid,diziguid2)
end
_relationLookup[diziguid1Str]=nil
end


local blackRelationtLookup=_blackRelationtLookup[diziguid1Str]
if blackRelationtLookup then
for diziguid2,flag in pairs(blackRelationtLookup)do
UIDiscipleModel:clearRelation(diziguid2,diziguid)
UIDiscipleModel:removeBlackReleation(diziguid,diziguid2)
end
_blackRelationtLookup[diziguid1Str]=nil
end
end


function UIDiscipleModel:setRelation(diziguid1,diziguid2,relationtype,relationVal)
local diziguid1Str=tostring(diziguid1)
local diziguid2Str=tostring(diziguid2)
if diziguid1Str==diziguid2Str then return end
if _relationLookup[diziguid1Str]==nil then _relationLookup[diziguid1Str]={}end
local lookup=_relationLookup[diziguid1Str]
if lookup.relation==nil then lookup.relation={}end
if lookup.object==nil then lookup.object={}end
if lookup.relationList==nil then lookup.relationList={}end
if lookup.relationList[relationtype]==nil then lookup.relationList[relationtype]={}end

local relation=lookup.relation
local object=lookup.object
local relationList=lookup.relationList[relationtype]

if object[diziguid2Str]==nil then
relation[#relation+1]=diziguid2
object[diziguid2Str]={}
else
end
object[diziguid2Str][relationtype]=relationVal

local flag=false
for i,v in ipairs(relationList)do
if tostring(v[1])==diziguid2Str then
v[2]=relationVal
flag=true
break
end
end
if not flag then
relationList[#relationList+1]={diziguid2,relationVal}
end

UIDiscipleModel:addBlackReleation(diziguid1,diziguid2)
end


function UIDiscipleModel:removeRelation(diziguid1,diziguid2,relationtype)
local diziguid1Str=tostring(diziguid1)
local diziguid2Str=tostring(diziguid2)
if _relationLookup[diziguid1Str]==nil then return end
local lookup=_relationLookup[diziguid1Str]

if lookup.relation==nil then return end
if lookup.object==nil or lookup.object[diziguid2Str]==nil or lookup.object[diziguid2Str][relationtype]==nil then return end
if lookup.relationList==nil then return end
if lookup.relationList[relationtype]==nil then return end

local relation=lookup.relation
local object=lookup.object
local objectLookup=object[diziguid2Str]
local relationList=lookup.relationList[relationtype]

objectLookup[relationtype]=nil

local flag=0
for _,_ in pairs(objectLookup)do
flag=flag+1
end
if flag==0 then
for i,v in ipairs(relation)do
if tostring(v)==diziguid2Str then
table.remove(relation,i)
break
end
end
end

for i,v in ipairs(relationList)do
if tostring(v[1])==diziguid2Str then
table.remove(relationList,i)
break
end
end
end


function UIDiscipleModel:clearRelation(diziguid1,diziguid2)
local diziguid1Str=tostring(diziguid1)
local diziguid2Str=tostring(diziguid2)

if _relationLookup[diziguid1Str]==nil then _relationLookup[diziguid1Str]={}end
local lookup=_relationLookup[diziguid1Str]

if lookup.relation==nil then return end
if lookup.object==nil then return end
if lookup.relationList==nil then return end

local relation=lookup.relation
local object=lookup.object

object[diziguid2Str]=nil

for i,v in ipairs(relation)do
if tostring(v)==diziguid2Str then
table.remove(relation,i)
break
end
end

for relationtype,v in pairs(lookup.relationList)do
for i,vv in ipairs(v)do
if tostring(vv[1])==diziguid2Str then
table.remove(v,i)
break
end
end
end
end

function UIDiscipleModel:addBlackReleation(diziguid1,diziguid2)
local diziguid1Str=tostring(diziguid1)
local diziguid2Str=tostring(diziguid2)
if _blackRelationtLookup[diziguid1Str]==nil then _blackRelationtLookup[diziguid1Str]={}end
if _blackRelationtLookup[diziguid2Str]==nil then _blackRelationtLookup[diziguid2Str]={}end
local dizi1Lookup=_blackRelationtLookup[diziguid1Str]
local dizi2Lookup=_blackRelationtLookup[diziguid2Str]
if dizi1Lookup[diziguid2Str]and dizi2Lookup[diziguid1Str]then return end
dizi1Lookup[diziguid2Str]=true
dizi2Lookup[diziguid1Str]=true
end

function UIDiscipleModel:removeBlackReleation(diziguid1,diziguid2)
local diziguid1Str=tostring(diziguid1)
local diziguid2Str=tostring(diziguid2)
_blackRelationtLookup[diziguid1Str][diziguid2Str]=nil
_blackRelationtLookup[diziguid2Str][diziguid1Str]=nil
end

function UIDiscipleModel:getRelationValueList(diziguid,relationtype)
local diziguid1Str=tostring(diziguid)
if _relationLookup[diziguid1Str]==nil then return end
local lookup=_relationLookup[diziguid1Str]
if lookup.relationList==nil then return end
return lookup.relationList[relationtype]
end


function UIDiscipleModel:getRelationDiscipleList(diziguid,relationtype,childTypes,isSort)
if relationtype==DISCIPLE_RELATION_TYPE.eFriend then
return UIDiscipleModel:getFriendRelationDiscipleList(diziguid,childTypes,isSort)
end
end

function UIDiscipleModel:getFriendRelationChildType(val)
if val==nil then return end
local personal=cfg_disciplerelationconfig_get(1).personal
for i,v in ipairs(personal)do
local info=personal[i]
local min=info[1]
local max=info[2]
if min<=val and max>=val then
return info[3],info[4]
end
end
end

function UIDiscipleModel:getFriendRelationDiscipleList(diziguid,childTypes,isSort)
local temp={}
local check=function(typo)
for i,v in ipairs(childTypes)do
if v==typo then return true end
end
return false
end
local list=UIDiscipleModel:getRelationValueList(diziguid,DISCIPLE_RELATION_TYPE.eFriend)
if list then
for i,v in ipairs(list)do
local val=v[2]
local chType=UIDiscipleModel:getFriendRelationChildType(val)
if check(chType)then
temp[#temp+1]={v[1],val}
end
end
end
if isSort and#temp>0 then
table.sort(temp,function(a,b)
return a[2]>b[2]
end)
end
return temp
end


function UIDiscipleModel:hasRelation(diziguid1,diziguid2,relations)
local diziguid1Str=tostring(diziguid1)
local diziguid2Str=tostring(diziguid2)

if _relationLookup[diziguid1Str]==nil then return false end
local lookup=_relationLookup[diziguid1Str]

if lookup.relation==nil then return false end
if lookup.object==nil then return false end
if lookup.object[diziguid2Str]==nil then return false end

local relation=lookup.relation
local objectLookup=lookup.object[diziguid2Str]

for i,relationtype in pairs(relations)do
if objectLookup[relationtype]~=nil then return true end
end
return false
end

function UIDiscipleModel:getReleationValue(diziguid1,diziguid2,relationtype)
local diziguid1Str=tostring(diziguid1)
local diziguid2Str=tostring(diziguid2)
local lookup=_relationLookup[diziguid1Str]or{}
local object=lookup.object or{}
local relations=object[diziguid2Str]or{}
local releationValue=relations[relationtype]
if releationValue then return releationValue end
if relationtype==DISCIPLE_RELATION_TYPE.eFriend then
return 0
end
end

function UIDiscipleModel:getRelationChildType(relationtype,val)
if relationtype==DISCIPLE_RELATION_TYPE.eFriend then
return UIDiscipleModel:getFriendRelationChildType(val)
end
end


function UIDiscipleModel:getRelationName(relationtype,val)
if relationtype==DISCIPLE_RELATION_TYPE.eFriend then
local childType,name=UIDiscipleModel:getFriendRelationChildType(val)
return name
end
return''
end

