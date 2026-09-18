





lingshouModel.lsTraitEffectLookup={}
lingshouModel.lsTraitEffectResultLookup={}


function lingshouModel:onEnterState_traiteffect()


end

function lingshouModel:onLeaveState_traiteffect()
self.lsTraitEffectLookup={}
self.lsTraitEffectResultLookup={}
end


lingshouTraitEffectEnum={
LINGSHOU_DATA_ADD=1,
LINGSHOU_ATTR_PERCENT_ADD=2,
LINGSHOU_SKILL_LEVEL_ADD=3,
DISCIPLE_SIX_ATTR_ADD=4,
DISCIPLE_GONGFA_LEVEL_ADD=5,
DISCIPLE_ATTR_ADD=6,

LINGSHOU_MOOD_PERCENT_CHANGE=101,
LINGSHOU_MOOD_MAXVAL_ADD=102,
LINGSHOU_XIUWEI_GET_RATE_ADD=103,
LINGSHOU_SHENGCHAN_TIME_PERCENT_CHANGE=104,
LINGSHOU_VOLUME_CHANGE=105,
LINGSHOU_FANYAN_MAXVAL_ADD=106,
LINGSHOU_FANYAN_INITIAL_OVERRIDE=107,
LINGSHOU_FANYAN_MOOD_REDUCE=108,
LINGSHOU_FANYAN_MOOD_PERCENT_REDUCE=109,
LINGSHOU_FANYAN_SPEED_CHANGE=110,
LINGSHOU_FANYAN_COST_CHANGE=111,
LINGSHOU_FANYAN_SINGLE_BIANYI_RATE_ADD=112,
LINGSHOU_FANYAN_SINGLE_GET_CHILD_RATE=113,
LINGSHOU_LIVE_NO_OTHER_RACE=114,
LINGSHOU_LIVE_WITH_OTHER_RACE_EFFECT=115,
LINGSHOU_STABLE_EXTRA_REWARD=116,
DISCIPLE_JOB_EXP_GET_PERCENT_ADD=117,
LINGSHOU_USE_QIANLI_ELIXIR_MAXVAL_ADD=118,
LINGSHOU_STABLE_MAINTENANCE_COST_CHANGE=119,

}


lingshouTraitEffectStatisticsEnum={
TYPE=1,
VALUE=2,
None=3,
TYPE2=4,
}


















local _lingshouTraitEffectStatisticsFunction={
[lingshouTraitEffectStatisticsEnum.TYPE]={
apply=function(self,lsData,wordID,effectArgs)
local type=effectArgs[1]
local addAttrType=effectArgs[2]
local addVal=effectArgs[3]

local lookup
if lsData.isOther then
table.checkCreateSubTable(lsData.lsTraitEffectResultLookup,{type})
lookup=lsData.lsTraitEffectResultLookup[type]
else
table.checkCreateSubTable(self.lsTraitEffectResultLookup,{lsData.guid_str,type})
lookup=self.lsTraitEffectResultLookup[lsData.guid_str][type]
end

lookup[addAttrType]=lookup[addAttrType]or 0
lookup[addAttrType]=lookup[addAttrType]+addVal


end,
remove=function(self,lsData,wordID,effectArgs)
local type=effectArgs[1]
local addAttrType=effectArgs[2]
local addVal=effectArgs[3]

local lookup
if lsData.isOther then
lookup=lsData.lsTraitEffectResultLookup[type]
else
lookup=self.lsTraitEffectResultLookup[lsData.guid_str][type]
end
lookup[addAttrType]=lookup[addAttrType]-addVal
end,
get=function(self,lsData,effectType,type)
local lookup
if lsData.isOther then
lookup=lsData.lsTraitEffectResultLookup[effectType]
else
lookup=self.lsTraitEffectResultLookup[lsData.guid_str][effectType]
end

return lookup and lookup[type]or 0
end,
},
[lingshouTraitEffectStatisticsEnum.VALUE]={
apply=function(self,lsData,wordID,effectArgs)
local type=effectArgs[1]
local temp=1
local addVal=effectArgs[2]

local lookup
if lsData.isOther then
table.checkCreateSubTable(lsData.lsTraitEffectResultLookup,{type})
lookup=lsData.lsTraitEffectResultLookup[type]
else
table.checkCreateSubTable(self.lsTraitEffectResultLookup,{lsData.guid_str,type})
lookup=self.lsTraitEffectResultLookup[lsData.guid_str][type]
end

lookup[temp]=lookup[temp]or 0
lookup[temp]=lookup[temp]+addVal
end,
remove=function(self,lsData,wordID,effectArgs)
local type=effectArgs[1]
local temp=1
local addVal=effectArgs[2]

local lookup
if lsData.isOther then
lookup=lsData.lsTraitEffectResultLookup[type]
else
lookup=self.lsTraitEffectResultLookup[lsData.guid_str][type]
end

lookup[temp]=lookup[temp]-addVal
end,
get=function(self,lsData,effectType)
local lookup
if lsData.isOther then
lookup=lsData.lsTraitEffectResultLookup[effectType]
else
lookup=self.lsTraitEffectResultLookup[lsData.guid_str][effectType]
end

return lookup and lookup[1]or 0
end,
},
[lingshouTraitEffectStatisticsEnum.None]={
apply=function(self,lsData,wordID,effectArgs)

end,
remove=function(self,lsData,wordID,effectArgs)

end,
get=function(self,lsData,effectType)
local lookup
if lsData.isOther then
lookup=lsData.lsTraitEffectLookup[effectType]or defaultT
else
lookup=self.lsTraitEffectLookup[lsData.guid_str][effectType]or defaultT
end
return lookup
end,
},
[lingshouTraitEffectStatisticsEnum.TYPE2]={
apply=function(self,lsData,wordID,effectArgs)
local type=effectArgs[1]
local attrType1=effectArgs[2]
local attrType2=effectArgs[3]
local addVal=effectArgs[4]

local lookup
if lsData.isOther then
table.checkCreateSubTable(lsData.lsTraitEffectResultLookup,{type,attrType1})
lookup=lsData.lsTraitEffectResultLookup[type][attrType1]
else
table.checkCreateSubTable(self.lsTraitEffectResultLookup,{lsData.guid_str,type,attrType1})
lookup=self.lsTraitEffectResultLookup[lsData.guid_str][type][attrType1]
end

lookup[attrType2]=lookup[attrType2]or 0
lookup[attrType2]=lookup[attrType2]+addVal
end,
remove=function(self,lsData,wordID,effectArgs)
local type=effectArgs[1]
local attrType1=effectArgs[2]
local attrType2=effectArgs[3]
local addVal=effectArgs[4]

local lookup
if lsData.isOther then
lookup=lsData.lsTraitEffectResultLookup[type][attrType1]
else
lookup=self.lsTraitEffectResultLookup[lsData.guid_str][type][attrType1]
end
lookup[attrType2]=lookup[attrType2]-addVal
end,
get=function(self,lsData,effectType,type1,type2)
local lookup
if lsData.isOther then
lookup=lsData.lsTraitEffectResultLookup[effectType]
else
lookup=self.lsTraitEffectResultLookup[lsData.guid_str][effectType]
end

return lookup and lookup[type1]and lookup[type1][type2]or 0
end,
},
}


local _lingshouTraitEffectTypeRefStatics={


[lingshouTraitEffectEnum.LINGSHOU_DATA_ADD]=lingshouTraitEffectStatisticsEnum.TYPE,

[lingshouTraitEffectEnum.LINGSHOU_ATTR_PERCENT_ADD]=lingshouTraitEffectStatisticsEnum.TYPE,

[lingshouTraitEffectEnum.LINGSHOU_SKILL_LEVEL_ADD]=lingshouTraitEffectStatisticsEnum.TYPE,

[lingshouTraitEffectEnum.DISCIPLE_SIX_ATTR_ADD]=lingshouTraitEffectStatisticsEnum.TYPE,

[lingshouTraitEffectEnum.DISCIPLE_GONGFA_LEVEL_ADD]=lingshouTraitEffectStatisticsEnum.TYPE2,

[lingshouTraitEffectEnum.DISCIPLE_ATTR_ADD]=lingshouTraitEffectStatisticsEnum.TYPE,



[lingshouTraitEffectEnum.LINGSHOU_MOOD_PERCENT_CHANGE]=lingshouTraitEffectStatisticsEnum.VALUE,

[lingshouTraitEffectEnum.LINGSHOU_MOOD_MAXVAL_ADD]=lingshouTraitEffectStatisticsEnum.VALUE,

[lingshouTraitEffectEnum.LINGSHOU_XIUWEI_GET_RATE_ADD]=lingshouTraitEffectStatisticsEnum.TYPE,

[lingshouTraitEffectEnum.LINGSHOU_SHENGCHAN_TIME_PERCENT_CHANGE]=lingshouTraitEffectStatisticsEnum.VALUE,

[lingshouTraitEffectEnum.LINGSHOU_VOLUME_CHANGE]=lingshouTraitEffectStatisticsEnum.VALUE,

[lingshouTraitEffectEnum.LINGSHOU_FANYAN_MAXVAL_ADD]=lingshouTraitEffectStatisticsEnum.VALUE,

[lingshouTraitEffectEnum.LINGSHOU_FANYAN_INITIAL_OVERRIDE]=lingshouTraitEffectStatisticsEnum.VALUE,

[lingshouTraitEffectEnum.LINGSHOU_FANYAN_MOOD_REDUCE]=lingshouTraitEffectStatisticsEnum.VALUE,

[lingshouTraitEffectEnum.LINGSHOU_FANYAN_MOOD_PERCENT_REDUCE]=lingshouTraitEffectStatisticsEnum.VALUE,

[lingshouTraitEffectEnum.LINGSHOU_FANYAN_SPEED_CHANGE]=lingshouTraitEffectStatisticsEnum.VALUE,

[lingshouTraitEffectEnum.LINGSHOU_FANYAN_COST_CHANGE]=lingshouTraitEffectStatisticsEnum.TYPE,

[lingshouTraitEffectEnum.LINGSHOU_FANYAN_SINGLE_BIANYI_RATE_ADD]=lingshouTraitEffectStatisticsEnum.VALUE,

[lingshouTraitEffectEnum.LINGSHOU_FANYAN_SINGLE_GET_CHILD_RATE]=lingshouTraitEffectStatisticsEnum.None,

[lingshouTraitEffectEnum.LINGSHOU_LIVE_NO_OTHER_RACE]=lingshouTraitEffectStatisticsEnum.None,

[lingshouTraitEffectEnum.LINGSHOU_LIVE_WITH_OTHER_RACE_EFFECT]=lingshouTraitEffectStatisticsEnum.None,

[lingshouTraitEffectEnum.LINGSHOU_STABLE_EXTRA_REWARD]=lingshouTraitEffectStatisticsEnum.None,

[lingshouTraitEffectEnum.DISCIPLE_JOB_EXP_GET_PERCENT_ADD]=lingshouTraitEffectStatisticsEnum.TYPE,

[lingshouTraitEffectEnum.LINGSHOU_USE_QIANLI_ELIXIR_MAXVAL_ADD]=lingshouTraitEffectStatisticsEnum.TYPE,

[lingshouTraitEffectEnum.LINGSHOU_STABLE_MAINTENANCE_COST_CHANGE]=lingshouTraitEffectStatisticsEnum.VALUE,
}

local _lingshouTraitEffectTypeRefStatics_dirty={
[lingshouTraitEffectEnum.DISCIPLE_GONGFA_LEVEL_ADD]=function(dzGuid)
UIDiscipleModel:setDiscipleAttrListDirtyX(dzGuid,DISCIPLE_ATTRIBUTE_TYPE.eGongFa,false)
UIDiscipleModel:setSkillLvPlusLookupDirty(dzGuid,false)
end,
}

local _getTraitEffectFunction=function(type,funcName)
local stype=_lingshouTraitEffectTypeRefStatics[type]
local funcs=_lingshouTraitEffectStatisticsFunction[stype]
if funcs then
return funcs[funcName]
else
logErr("缺少 特质类型的处理方法组",type)
end
end


function lingshouModel:applyLingShouAllWord(lsData)
if lsData.word_len<=0 then return end
for index=1,lsData.word_len do
local wordID=lsData.wordList[index]
self:applyLingShouSingleWord(lsData,wordID)
end
end


function lingshouModel:applyLingShouAllWord_other(lsData)
if lsData.word_len<=0 then return end
lsData.lsTraitEffectLookup={}
lsData.lsTraitEffectResultLookup={}
for index=1,lsData.word_len do
local wordID=lsData.wordList[index]
self:applyLingShouSingleWord_other(lsData,wordID,lsData.lsTraitEffectLookup)
end
end

function lingshouModel:applyLingShouAllWordEx(lsGuid)
local lsData=lingshouModel:getLingShouData2(lsGuid)
if lsData then
lingshouModel:applyLingShouAllWord(lsData)
end
end


function lingshouModel:applyLingShouSingleWord(lsData,wordID)
local cfg=cfgHelper.get(cfg_lingshouwordconfig_get,wordID)
if cfg then
if cfg.effect then
local lookup=self.lsTraitEffectLookup[lsData.guid_str]or{}
if lookup[wordID]~=nil then

return
end
self.lsTraitEffectLookup[lsData.guid_str]=lookup
for eIndex,effectArgs in ipairs(cfg.effect)do
local type=effectArgs[1]

local applayFunc=_getTraitEffectFunction(type,'apply')
if applayFunc==nil then
return
end
xpcall(function()
table.checkCreateSubTable(lookup,{wordID,type})
table.insert(lookup[wordID][type],effectArgs)
applayFunc(self,lsData,wordID,effectArgs)
end,function(err)
logErr(err)
end)
end
end
else
logErr("缺少灵兽词条配置",wordID)
end
end

function lingshouModel:applyLingShouSingleWordEx(lsGuid)
local lsData=lingshouModel:getLingShouData2(lsGuid)
if lsData then
lingshouModel:applyLingShouSingleWord(lsData)
end
end


function lingshouModel:applyLingShouSingleWord_other(lsData,wordID,traitEffLookup)
local cfg=cfgHelper.get(cfg_lingshouwordconfig_get,wordID)
if cfg then
if cfg.effect then
local lookup=traitEffLookup
if lookup[wordID]~=nil then

return
end
for eIndex,effectArgs in ipairs(cfg.effect)do
local type=effectArgs[1]

local applayFunc=_getTraitEffectFunction(type,'apply')
if applayFunc==nil then
return
end
xpcall(function()
table.checkCreateSubTable(lookup,{wordID,type})
table.insert(lookup[wordID][type],effectArgs)
applayFunc(self,lsData,wordID,effectArgs)
end,function(err)
logErr(err)
end)
end
end
else
logErr("缺少灵兽词条配置",wordID)
end
end

function lingshouModel:getLingShouTraitEffect(lsData,effectType,...)
local lookup
if lsData.isOther then
lookup=lsData.lsTraitEffectResultLookup
else
lookup=self.lsTraitEffectResultLookup[lsData.guid_str]
end
if lookup==nil then
return
end


local getFunc=_getTraitEffectFunction(effectType,'get')
local result
local args={...}
xpcall(function()
result=getFunc(self,lsData,effectType,unpack(args))
end,function(err)
logErr(err)
end)

return result
end

function lingshouModel:getLingShouTraitEffectEx(lsGuid,effectType,...)
local lsData=lingshouModel:getLingShouData2(lsGuid)
if lsData then
return lingshouModel:getLingShouTraitEffect(lsData,effectType,...)
end
end

function lingshouModel:checkLingShouHasTraitTypeEx(lsGuid,effectType)
local lsData=lingshouModel:getLingShouData2(lsGuid)
if lsData then
local list=lingshouModel:getLingShouTraitEffectLookupEx(tostring(lsGuid),effectType)
return next(list)~=nil,table.getKeyValue(list,1,1)
end
end

function lingshouModel:getDiscipleTraitEffect(dzGuid,effectType,...)
local lsGuid=lingshouModel:getLingShouByDizi(dzGuid)
if lsGuid==nil then
local dirtyFunc=_lingshouTraitEffectTypeRefStatics_dirty(effectType)
if dirtyFunc then
dirtyFunc(dzGuid)
end
return
end
return lingshouModel:getLingShouTraitEffectEx(lsGuid,effectType,...)
end

function lingshouModel:getLingShouTraitEffectLookup(lsGuidStr,effectType)

local list=table.getKeyValue(self.lsTraitEffectLookup,lsGuidStr)

local elist={}
if list then
for wordID,typeList in pairs(list)do
if typeList[effectType]then
elist=table.concatTableX(elist,typeList[effectType])
end
end
end

return elist
end

function lingshouModel:getLingShouTraitEffectLookupEx(lsGuidStr,effectType)

local list=table.getKeyValue(self.lsTraitEffectLookup,lsGuidStr)

local wlist={}

if list then
for wordID,typeList in pairs(list)do
if typeList[effectType]then
table.insert(wlist,{wordID,typeList[effectType]})
end
end
end

return wlist
end

function lingshouModel:getDiscipleTraitEffectLookup(dzGuid,effectType,...)
local lsGuid=lingshouModel:getLingShouByDizi(dzGuid)
if lsGuid==nil then return end

return lingshouModel:getLingShouTraitEffectLookup(tostring(lsGuid),effectType,...)
end

function lingshouModel:getDiscipleTraitEffectLookupIndexTotal(lsGuid,effectType,sindex)
local list=lingshouModel:getLingShouTraitEffectLookup(tostring(lsGuid),effectType)

local val=0

if list and next(list)~=nil then
for index,args in ipairs(list)do
val=val+args[sindex]
end
end

return val
end


function lingshouModel:removeLingShouAllWord(lsData)
if lsData.word_len<=0 then return end
for index=1,lsData.word_len do
local wordID=lsData.worldList[index]
self:removeLingShouSingleWord(lsData,wordID)
end
self.lsTraitEffectLookup[lsData.guid_str]=nil
end

function lingshouModel:removeLingShouAllWoldEx(lsGuid)
local lsData=lingshouModel:getLingShouData2(lsGuid)
if lsData then
lingshouModel:removeLingShouAllWord(lsData)
end
end


function lingshouModel:removeLingShouSingleWord(lsData,wordID)
if table.findValue(lsData.worldList,wordID)==nil then
logErr("移除一个未拥有的词条")
return
end

local cfg=cfgHelper.get(cfg_lingshouwordconfig_get,wordID)
if cfg then
if cfg.effect then
for eIndex,effectArgs in ipairs(cfg.effect)do
local type=effectArgs[1]
local removeFunc=_getTraitEffectFunction(type,'remove')
xpcall(function()
lookup[type][wordID]=nil
removeFunc(self,lsData,wordID,effectArgs)
end,function(err)
logErr(err)
end)
end
end
else
logErr("缺少灵兽词条配置-remove",wordID)
end
end

function lingshouModel:removeLingShouSingleWordEx(lsGuid,wordID)
local lsData=lingshouModel:getLingShouData2(lsGuid)
if lsData then
lingshouModel:removeLingShouSingleWord(lsData)
end
end



