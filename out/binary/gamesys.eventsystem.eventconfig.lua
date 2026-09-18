




eventConfig={}

local _conf={}


EVENT_TYPE=
{
eNomal=1,
eDecision=2,
eFixedTime=3,
}


EVENT_OBJECT_TYPE=
{
eZongmeng=1,
eDizi=2,
}


EVENT_NORMAL_SUB_TYPE=
{
eZongmenPlayer=1,
eZongmenSystem=2,
eDiziXiulian=3,
eDiziYouli=4,
eDiziProduct=5,
eDiziRelation=6,
eDiziDead=7,
eEmergencies=8,
eChuWuDai=9,

eLittleWorld=10,
}


EVENT_OPTION_SUB_TYPE=
{
eZongmen=1,

eCondition=2,
}

EVENT_OPTION_SUB_NUM_LIST=
{
EVENT_OPTION_SUB_TYPE.eZongmen,

}


EVENT_OPTION_NPC_TYPE={
eJZZuZhang=1,
eSystemZMZhangMeng=2,
eWorldNPC=3,
eMortalNPC=4,
eZMZhangMen=5,
}


EVENT_TRIGGER_TYPE=
{
eCnd=1,
eTime=2,
}

EVENT_POST_CHANGED=
{
eOptionNum=1,
}

EVENT_OPTION_STATE=
{
eNone=-1,
eUnHand=0,
eWaitChoice=1,
eDoing=2,
eWaitFinishMiJing=3,
eFinish=4,
}

EVENT_STORE_TYPE=
{
eItem=1,

}


EVENT_STATE=
{
eFinish=0,
eWaitChoice=1,
eWaitReward=2,
eWaitNext=3,
}














EVENT_EXTRA_HANDLE_TYPE=
{
eItem=1,
}


EVENT_EFFECT_TYPE=
{
eDiziAddJingjieExp=1,
eDiziAddJingjieExp_Precent=2,
eDiziAddLiantiExp=3,
eDiziAddLiantiExp_Precent=4,
eDiziAddZhuanyeSkillExp=5,
eDiziAddZhuanyeSkillExp_Precent=6,
eAddPlantExtraPrize_Precent=7,
eAddPlantExtraPrize=8,
eDiziGetTezhi=9,
eDiziRemoveTezhi=10,
eNextEvent=11,
eDiziDujie_Precent=12,
eDizGongfaExp=13,
eDizGongfaExp_Precent=14,
eDiziFushang=15,
eDiziChangeAttr6=16,
eFriendRelationValueChanged=17,
eFriendRelationExValueChanged=18,
eAddZongmenExp=19,
eZongmenZhenXieChanged=20,
eGetPrize=21,
eGetHomeBuff=22,
eDZBagGetItem=23,
eDZBagMissItem=24,
eLittleWorldStability=26,
eLittleWorldPopulation=27,
}



local actionlist={}


local _actionSrcConfig={}

local _actionDirectory='lua.gamesys/eventSystem/action/'

function eventConfig.loadAction(name)
local src=FMT.fmt('{0}{1}',_actionDirectory,name)
refSrcConfig[name]=src
require(src)
end

function eventConfig.getAction(effectid)
local name=_actionSrcConfig[effectid]
if name then














if actionlist[name]==nil then
actionlist[name]=_G[name]
end
return actionlist[name]
end
end



function eventConfig.init()
_conf={}
end


function eventConfig.getProduceEventConfigIdList(buildid)
return cfg_lookupproduceeventconfig_get(buildid)
end


function eventConfig.getProduceEventConfig(id)
return cfg_produceeventconfig_get(id)
end

function eventConfig.getRelationId(childType1,childType2,sex1,sex2)
local relation1Cfgs=cfg_lookuprelationeventconfig_get(childType1)
if relation1Cfgs and relation1Cfgs[childType2]and
relation1Cfgs[childType2][sex1]and relation1Cfgs[childType2][sex1][sex2]then
return relation1Cfgs[childType2][sex1][sex2][1]
end
end


function eventConfig.getEventConfig(id)
return cfg_eventconfig_get(id)
end

function eventConfig.getEventTypeById(id)
local eventconfig=cfg_eventconfig_get(id)
return eventconfig.type1,eventconfig.type2
end


function eventConfig.getActionConfig(id)
return cfg_eventactionconfig_get(id)
end


function eventConfig.getContentConfig(id)
return cfg_eventcontentconfig_get(id)
end


function eventConfig.getEventOptionContentConfig(id)
return cfg_eventoptioncontentconfig_get(id)
end

function eventConfig.getCommonConfig()
return cfg_eventbaseconfig_get(1)
end


function eventConfig.getEventOptionConfig(id)
return cfg_eventoptionconfig_get(id)
end


function eventConfig.getEventOptionSelectContentConfig(id)
return cfg_eventoptionselectconfig_get(id)
end

function eventConfig.getEventOptionName(id)
local eventconfig=eventConfig.getEventConfig(id)
local optioncontent=eventconfig.optioncontent
if optioncontent then
return optioncontent[1]
end
end

function eventConfig.getTriggerConfig(mainType,subType,id)
if mainType==EVENT_TYPE.eNomal then
if subType==EVENT_NORMAL_SUB_TYPE.eDiziProduct then
return cfg_produceeventconfig_get(id)
end
end
end

function eventConfig.getTriggerCondition(mainType,subType,triggerid)
local config=eventConfig.getTriggerConfig(mainType,subType,triggerid)
if config then
return config.conditions
end
end

function eventConfig.getEventOptionCommonConfig()
return eventConfig.getCommonConfig().decisionconf
end

function eventConfig.getEventOptionStoreNum(subType)
if _conf.optionStoreMaxNum==nil then
_conf.optionStoreMaxNum={}
local conf=eventConfig.getEventOptionCommonConfig()
for i,v in ipairs(conf[1])do
_conf.optionStoreMaxNum[i]=v
end
end
return _conf.optionStoreMaxNum[subType]
end

function eventConfig.getEventOptionMaxNum(subType)
if _conf.optionMaxNum==nil then
_conf.optionMaxNum={}
local conf=eventConfig.getEventOptionCommonConfig()
for i,v in ipairs(conf[2])do
_conf.optionMaxNum[i]=#v
end
end
return _conf.optionMaxNum[subType]
end

function eventConfig.getEventOptionDurationTable(subType)
local conf=eventConfig.getEventOptionCommonConfig()
return conf[2][subType]
end

function eventConfig.getEventOptionDuration(subType,num)
local array=eventConfig.getEventOptionDurationTable(subType)
local len=#array
if num>len then return end
return array[num]
end

function eventConfig.getEventOptionResetTime()

end

function eventConfig.getEventOptionWaitTime(id,index)
local dispatch=eventConfig.getOptionDispatch(id,index)
return dispatch and dispatch[2]or 0
end

function eventConfig.getOptionDispatch(id,index)
local option=eventConfig.getEventConfig(id).option
if option then
if index then
return option[index]and option[index].dispatch or nil
else
return option[1].dispatch
end
end
end

function eventConfig.getOptionConsume(id,index)
local option=eventConfig.getEventConfig(id).option
if option then
if index then
return option[index]and option[index].consume or nil
else
return option[1].consume
end
end
end

function eventConfig.checkIsFinishMiJingEventOption(id,index)
local option=eventConfig.getEventConfig(id).option
if option then
local miJingList
if index then
miJingList=option[index]and option[index].mijing or nil
else
miJingList=option[1].mijing
end

if miJingList then
return true
end
end

return false
end

function eventConfig.getEventOptionMiJingIdList(id,index)
local option=eventConfig.getEventConfig(id).option
if option then
local miJingList
if index then
miJingList=option[index]and option[index].mijing or nil
else
miJingList=option[1]and option[1].mijing or nil
end

return miJingList
end

return nil
end

function eventConfig.isDecision(id)
local eventconfig=eventConfig.getEventConfig(id)
return eventconfig.type1==EVENT_TYPE.eDecision
end

function eventConfig.getMultiAction(eventconfig)
local temp={}
local addAction=function(actionTable)
if actionTable==nil then return end
for i,v in ipairs(actionTable)do
temp[#temp+1]=v
end
end
addAction(eventconfig.action)
local index=1
local str=FMT.fmt('action{0}',index)
while eventconfig[str]do
addAction(eventconfig[str])
index=index+1
str=FMT.fmt('action{0}',index)
end
return temp
end

