





local eventGuid=0
local hongChenJieObject={}

local getEventGuid=function()
eventGuid=eventGuid+1
return eventGuid
end

local getlevelDesc=function(_this,val,isAdd)
local str
local jjname=_this:getJingJieName(val)
if isAdd then
str=FMT.fmt('境界提升至{0}',jjname)
str=toColorString(FONT_COLOR.eGreenColor,str)
else
str=FMT.fmt('境界倒退至{0}',jjname)
str=toColorString(FONT_COLOR.eRedColor,str)
end
return str
end

local getAttrDesc=function(type,val,dotype,color)
local typeName=HongChenJieDiscipleAttrNameList[type]
local valStr=FMT.fmt("{0}{1}",dotype,val)
local str=FMT.fmt("{0}{1}",typeName,valStr)
str=toColorString(color,str)
return str
end

local getAttrPercentDesc=function(type,val,dotype,color)
local typeName=HongChenJieDiscipleAttrNameList[type]
local valStr=FMT.fmt("{0}{1}",dotype,val)
local str=FMT.fmt("{0}{1}%",typeName,valStr)
str=toColorString(color,str)
return str
end

local freshEffectFunc=function(_this,effectList,data,eventInfo,isNoUpdateAttr)
if effectList~=nil and#effectList>0 then
local effectDescList={}
local effectDataList={}
for k,effectData in ipairs(effectList)do
local etype=effectData[1]
local effect_str
local effect_data
local type
local val

if etype==HONGCHENJIE_Event_Effect_TYPE.AddJingJie then

val=effectData[2]
if not isNoUpdateAttr then
_this.data.gameData.level=_this.data.gameData.level+val
end
effect_str=getlevelDesc(_this,_this.data.gameData.level,val>0)
elseif etype==HONGCHENJIE_Event_Effect_TYPE.AddAttribute then
type=effectData[2]
if data.effect_list_len>0 then
val=data.effect_list[k]
else
logErr(FMT.fmt("事件id {0} 需要作用列表 但是没有",eventInfo.eventId))
end
elseif etype==HONGCHENJIE_Event_Effect_TYPE.ReduceAttribute then
type=effectData[2]
if data.effect_list_len>0 then
val=data.effect_list[k]
val=-val
else
logErr(FMT.fmt("事件id {0} 需要作用列表 但是没有",eventInfo.eventId))
end
elseif etype==HONGCHENJIE_Event_Effect_TYPE.ReducePercentAttribute then
type=effectData[2]
local _val=effectData[3]
local typeVal=_this:getSingleInfo(type)
local reduceVal=Mathf.Floor(typeVal*_val*0.01+0.00000001)
val=-reduceVal
elseif etype==HONGCHENJIE_Event_Effect_TYPE.GameEnd then
eventInfo.isEnd=true
elseif etype==HONGCHENJIE_Event_Effect_TYPE.ChangeName then
local name=effectData[2]
_this:setIdentityName(name)
end


if val~=nil and type~=nil then
if not isNoUpdateAttr then

_this:setSingleInfo(type,val)
end
effect_data={type,val}
else

end

if effect_str~=nil then
table.insert(effectDescList,effect_str)
end

if effect_data~=nil then
table.insert(effectDataList,effect_data)
end
end
local effect_str
if#effectDescList>0 then
effect_str=""
for k,str in pairs(effectDescList)do
if k>1 then
effect_str=FMT.fmt("{0}\t\t{1}",effect_str,str)
else
effect_str=FMT.fmt("{0}{1}",effect_str,str)
end
end
end


eventInfo.effectDescList=effectDescList
eventInfo.effectDataList=effectDataList

return effect_str
end
end

local freshChoiceEffectFunc=function(_this,choiceCfg,data,eventInfo,isNoUpdateAttr)
local result=choiceCfg and choiceCfg.result or{}
local effectList=result and result[data.result_idx+1]or{}
return freshEffectFunc(_this,effectList,data,eventInfo,isNoUpdateAttr)
end


function hongChenJieObject:__init(gameInfo)
self:resetData(gameInfo,true)
self:init(gameInfo)
end

function hongChenJieObject:__delete()
self.data=nil

self.id=nil
self.disciple=nil
self.totalYear=nil
self.attrLookUp=nil

self.events=nil
self.eventInfoList=nil
self.eventPrefabNameList=nil
self.eventGuidList=nil


end

function hongChenJieObject:init(gameInfo)
self.data=gameInfo
self.id=gameInfo.id

self.data.isCanClickNextEvent=true

self:initDisciple()
self:initName()
self:initInfoList()
self:initEventList()
self:initRankingRewardSelfFinishStateLookup()
self:initRankingList()
self:initTaskRewardList()
self:setLessShouYuanState(true)
end

function hongChenJieObject:updateInfo(gameInfo)
self:resetData(gameInfo,true)
self:init(gameInfo)
end


function hongChenJieObject:resetData(gameInfo,isInit)
if self.data then
table.clear(self.data)
end

self.totalYear=0
self.attrLookUp={}

self.events={}
self.eventInfoList={}
self.eventPrefabNameList={}
self.eventGuidList={}
end

function hongChenJieObject:showDisposeDzWin()
local disciple=self:getSelectDisciple()
local needLevel=hongChenJieConfig.getBaseInfo(self.id,'need_level')
local _this=self

local args={
openType=dzSelectWinOpenType.eHongChenJie,
selectdzguid=disciple,
dzFilterTypeList={{1,{needLevel}}},
dzShowTypeList={{1}},
sortPlanId=1,
canvasIdx=8,
filterTipDesc='提示：弟子境界需为渡劫圆满才可踏入红尘',
emptyTipDesc='当前暂无渡劫圆满弟子',
isNotShowSearchBox=true,
isShowFireBtn=false,

workCallBack=function(data)
_this:setSelectDisciple(data.discipleguid)
UIManager:invokeUIMethod('UIHongChenJieMainWin','onShowArgRecv',{id=_this.id,discipleGuidStr=data.discipleguidStr})
end,
fireCallBack=function()
_this:setSelectDisciple(nil)
UIManager:invokeUIMethod('UIHongChenJieMainWin','onShowArgRecv',{id=_this.id})
end
}
discipleSelectController:openDiscipleSelect(args)
end


function hongChenJieObject:addEventData(eventData)
self:initEvent(eventData,true)
end

function hongChenJieObject:setGameData(gameData)
self.data.gameData=gameData
self:setOldMoneyNum()

self:initName()
self:setLessShouYuanState(true)
self:initInfoList()
if gameData.event_list_len>0 then
self.data.gameData.level=0
self:initEventList()
end
end


function hongChenJieObject:resetGameData()

self.data.gameData=nil
self.totalYear=nil



self:initEventList()
self:setOldMoneyNum()
end

function hongChenJieObject:endGameData()

local level=self:getJingJie()
self.data.maxLevel=Mathf.Max(level,self.data.maxLevel)
self.data.maxYear=Mathf.Max(self.totalYear,self.data.maxYear)

self:resetGameData()
end


function hongChenJieObject:initEventList()
self.events={}
self.eventInfoList={}
self.eventPrefabNameList={}
self.eventGuidList={}
self.totalYear=0
self.labelList={}

if self.data.gameData and self.data.gameData.event_list then
local isNew=self.data.gameData.event_list_len==1
for k,eventData in ipairs(self.data.gameData.event_list)do
self:initEvent(eventData,isNew,true)
end
end
end

function hongChenJieObject:initEvent(eventData,isNew,isNoUpdateAttr)
local _this=self

local eventId=eventData.event_id
local eventCfg=cfgHelper.get1(cfg_hongchenjieeventconfig_get,eventId)

if not eventCfg then
logErr(FMT.fmt("初始化 错误的事件id  id ：： {0}",eventId))
end

local eventInfo={}
eventInfo.data=eventData
eventInfo.id=self.id
eventInfo.eventId=eventId
eventInfo.eventCfg=eventCfg
eventInfo.eventGuid=getEventGuid()

local eventResult

local isSkip=false

if#eventCfg.choice==1 then
eventInfo.eventType=HONGCHENJIE_EVENT_TYPE.Base
eventInfo.eventPrefabType=HONGCHENJIE_COM_TYPE.Base
local effectList=eventCfg.result
if#effectList>0 then
eventInfo.effectStr=freshEffectFunc(_this,effectList,eventData,eventInfo,isNoUpdateAttr)
else
local resultChoiceCfg=eventCfg.choice[eventData.choice_idx]
eventInfo.effectStr=freshChoiceEffectFunc(_this,resultChoiceCfg,eventData,eventInfo,isNoUpdateAttr)
end
if eventCfg.year>0 then
self.totalYear=self.totalYear+eventCfg.year
if not isNoUpdateAttr then
self:setSingleInfo(HongChenJieDiscipleAttrTypeEnum.ShouYuan,-eventCfg.year)
end
end

self:setSummaryLabelList(eventInfo)
else
local eventLen=#self.eventInfoList
if eventLen>0 then
local lastEventData=self.eventInfoList[eventLen]
if lastEventData.eventId==eventInfo.eventId and isNew then
isSkip=true
if eventData.choice_idx==0 then
logErr(FMT.fmt("出现连续相同的决策事件{0}",eventData.event_id))
return
end
end
end

if eventCfg.iamge~=nil then

eventInfo.eventType=HONGCHENJIE_EVENT_TYPE.BigDisicion
eventInfo.eventPrefabType=HONGCHENJIE_COM_TYPE.Disicion
else

eventInfo.eventType=HONGCHENJIE_EVENT_TYPE.SmallDisicion
eventInfo.eventPrefabType=HONGCHENJIE_COM_TYPE.Disicion
end
if eventData.choice_idx and eventData.choice_idx>0 then

if eventCfg.result_text then
if eventCfg.result_text[eventData.choice_idx]~=nil then
if eventCfg.result_text[eventData.choice_idx][eventData.result_idx]~=nil and
eventCfg.result_text[eventData.choice_idx][eventData.result_idx]~=" "then


eventResult={}
eventResult.data=eventData
eventResult.id=self.id
eventResult.eventGuid=getEventGuid()
eventResult.eventId=eventId
eventResult.eventCfg=eventCfg
eventResult.eventType=HONGCHENJIE_EVENT_TYPE.Result
eventResult.eventPrefabType=HONGCHENJIE_COM_TYPE.Result

local resultChoiceCfg=eventCfg.choice[eventData.choice_idx]
eventResult.effectStr=freshChoiceEffectFunc(_this,resultChoiceCfg,eventData,eventResult,isNoUpdateAttr)
else
logErr(FMT.fmt("事件id：{0} 结果文本缺失,选项idx :{1},结果idx:{2}",eventId,eventData.choice_idx,eventData.result_idx))
end
else


end
end

self:checkAutoReqNextEvent(eventCfg,eventData)
end
if not isSkip then
if eventCfg.year>0 then
self.totalYear=self.totalYear+eventCfg.year
if not isNoUpdateAttr then
self:setSingleInfo(HongChenJieDiscipleAttrTypeEnum.ShouYuan,-eventCfg.year)
end
end
end
end

if eventCfg.year>0 then
eventInfo.year=self.totalYear
end
if not isSkip then
table.insert(self.eventInfoList,eventInfo)
table.insert(self.eventPrefabNameList,HONGCHENJIE_COM_TYPE_NAME[eventInfo.eventPrefabType])
table.insert(self.eventGuidList,eventInfo.eventGuid)

table.insert(self.events,eventData)

if isNew then
eventInfo.isPlayAnim=true
if eventInfo.eventType~=HONGCHENJIE_EVENT_TYPE.BigDisicion then
self:postNewEventInfo(eventInfo)
end

if eventInfo.eventType==HONGCHENJIE_EVENT_TYPE.BigDisicion then
UIFullHongChenJieControl:showWindow('UIHongChenJieBigDecisionWin',{id=self.id,eventInfo=eventInfo})
end
else
if eventInfo.eventType==HONGCHENJIE_EVENT_TYPE.BigDisicion then
self:setReconnectJCState(true)
end
end
else
self.events[#self.events]=eventData
self.eventInfoList[#self.eventInfoList]=eventInfo


if isNew then
if eventInfo.eventType==HONGCHENJIE_EVENT_TYPE.BigDisicion then
self:postNewEventInfo(eventInfo)
end
notifySystem:postNotify(notifyConfig.onHongChenJieFreshEvent,self.id,eventInfo)
end
end
if eventResult then
self:setSummaryLabelList(eventResult)

table.insert(self.eventInfoList,eventResult)
table.insert(self.eventPrefabNameList,HONGCHENJIE_COM_TYPE_NAME[eventResult.eventPrefabType])
table.insert(self.eventGuidList,eventResult.eventGuid)

if isNew then
eventResult.isPlayAnim=true
self:postNewEventInfo(eventResult)
end
end

end

function hongChenJieObject:postNewEventInfo(eventInfo)
notifySystem:postNotify(notifyConfig.onHongChenJieAddNewEvent,self.id,eventInfo,eventInfo.eventPrefabType,eventInfo.eventGuid)

if self:checkGameEnd()then
notifySystem:postNotify(notifyConfig.onHongChenJieGameOver,self.id)
else
if self:checkLessShouYuanTipVal()and self:getLessShouYuanState()then
self:setLessShouYuanState(false)
notifySystem:postNotify(notifyConfig.onHongChenJieGameHPLess,self.id)
end
end
end

function hongChenJieObject:getEventInfoList()
return self.eventInfoList
end

function hongChenJieObject:getEventPrefabNameList()
return self.eventPrefabNameList
end

function hongChenJieObject:getEventGuidList()
return self.eventGuidList
end


function hongChenJieObject:initRankingRewardSelfFinishStateLookup()
self.rankingRewardSelfFinishStateLookup={}
if self.data.rewardSelfFinishListLen>0 then
for k,v in ipairs(self.data.rewardSelfFinishList)do
local id=v.param_1
local count=v.param_2
local state=v.param_3
self.rankingRewardSelfFinishStateLookup[id]={id=id,count=count,state=state}
end
end
end

function hongChenJieObject:initRankingList()
self.rankingLookup={}
self.rankGroupList={}
self.rankingDataList={}
self.data.rankList=self.data.rankList or{}

if#self.data.rankList>0 then
local temp={}
for k,v in pairs(self.data.rankList)do
temp[v.id]=v
end
self.data.rankList=temp
end

local allRankingCfg=cfgHelper.get1(cfg_hongchenjietargetconfig_get,self.id)
for k,rankingCfg in ipairs(allRankingCfg)do
if not rankingCfg.is_hide then
local temp={}
local idx=rankingCfg.idx
local group=rankingCfg.group
temp.id=rankingCfg.idx
temp.cfg=rankingCfg
temp.stState=false
temp.count=0
temp.sortWidget=idx+group*100
temp.data=self.data.rankList[idx]or{}
temp.isFinish=false
temp.isCanReward=false
self.rankingLookup[idx]=temp
table.insert(self.rankingDataList,temp)

if not self.rankGroupList[group]then
local groupTemp={}
groupTemp.list={}
groupTemp.id=group
groupTemp.tid=1

self.rankGroupList[group]=groupTemp
end

table.insert(self.rankGroupList[group].list,temp)

if self.rankingRewardSelfFinishStateLookup[idx]==nil then
self.rankingRewardSelfFinishStateLookup[idx]={id=idx,count=0,state=0}
temp.reachFlag=0
end
end
end

for k,groupData in pairs(self.rankGroupList)do
if#groupData.list>1 then
table.sort(groupData.list,function(a,b)
return a.id<b.id
end)
end
end


self:dealRankingList(true)
end

function hongChenJieObject:updateRankingList(list)
self.data.rankList=list
end

function hongChenJieObject:updateRankingItem(item)
local id=item.id
if self.rankingLookup[id]then
local rankingData=self.rankingLookup[id]
local citem=rankingData.data
citem.actor_id=item.actor_id
citem.name=item.name
citem.guild_name=item.guild_name
citem.iconInfo=item.iconInfo
citem.server_id=item.server_id

self:updateRankingDataById(id)
else
logErr(FMT.fmt("错误的榜单id=={0}",id))
end
end

function hongChenJieObject:updateRankingListAchiveFlag(len,list)
for index=1,len do
local data=list[index]
local id=data.param_1
self.rankingRewardSelfFinishStateLookup[id].count=data.param_2
self.rankingRewardSelfFinishStateLookup[id].state=data.param_3
self:updateRankingDataById(id)
end
end

function hongChenJieObject:dealRankingList(isNoFresh,isFullChange)
for k,rankingData in ipairs(self.rankingDataList)do
local id=rankingData.id
self:updateRankingDataById(id,isFullChange)
end

for k,groupData in pairs(self.rankGroupList)do
for index,rankingData in ipairs(groupData.list)do
if rankingData.isCanReward then
groupData.tid=index
break
end

if not rankingData.isFinish then
groupData.tid=index
break
end

groupData.tid=index
end
end


table.sort(self.rankingDataList,function(a,b)
if a.sortWidget==b.sortWidget then
if a.cfg.group==b.cfg.group then
return a.cfg.idx<b.cfg.idx
else
return a.cfg.group<b.cfg.group
end
else
return a.sortWidget>b.sortWidget
end
end)

if not isNoFresh then

notifySystem:postNotify(notifyConfig.onHongChenJieRankingFresh,self.id)
end
end

function hongChenJieObject:updateRankingDataById(id,isFullChange)
if self.rankingLookup[id]then
local temp=self.rankingLookup[id]
temp.reachFlag=self.rankingRewardSelfFinishStateLookup[id].state
temp.count=self.rankingRewardSelfFinishStateLookup[id].count
local sortWidget=100-temp.id
temp.stState=temp.data.actor_id~=nil and not(self:checkOtherFinishState(id))

temp.isFinish=self:checkOtherFinishState(id)and self:checkSelfFinishState(id)
temp.isCanReward=temp.reachFlag==1 or temp.stState

if isFullChange then
if not temp.isFinish and temp.isCanReward then
return
end
end

if temp.isCanReward then
sortWidget=sortWidget+10000

end

if(temp.reachFlag==2 and(not temp.stState))or temp.isFinish then
sortWidget=-temp.id
end

temp.sortWidget=sortWidget
end
end

function hongChenJieObject:getRankingDataList()
local temp={}

for index,groupData in pairs(self.rankGroupList)do
for li=1,groupData.tid do
temp[#temp+1]=groupData.list[li]
end
end


table.sort(temp,function(a,b)
return a.sortWidget>b.sortWidget
end)

return temp
end

function hongChenJieObject:getRankingDataByIdx(idx)
return self.rankingDataList[idx]
end

function hongChenJieObject:getRankingDataById(id)
return self.rankingLookup[id]
end


function hongChenJieObject:initTaskRewardList()
self.taskRewardDataList={}

local allCfg=hongChenJieConfig.getBaseInfo(self.id,'reward')

for index,cfg in ipairs(allCfg)do
local temp={}

temp.cfg=cfg
temp.id=index
temp.sortTag=index

table.insert(self.taskRewardDataList,temp)
end
end

function hongChenJieObject:getTaskRewardDataList()
local moneyType=hongChenJieConfig.getBaseInfo(self.id,'money_type')
local moneyNum=itemsModel.getCount(moneyType)
for index,taskRewardData in ipairs(self.taskRewardDataList)do

local needVal=taskRewardData.cfg[1]
taskRewardData.sortTag=1000-taskRewardData.id
taskRewardData.rewardState=self:checkReachTaskState(taskRewardData.id)
taskRewardData.isCanReward=moneyNum>=needVal
if taskRewardData.isCanReward and(not taskRewardData.rewardState)then
taskRewardData.sortTag=taskRewardData.sortTag+1000
end

if taskRewardData.rewardState then
taskRewardData.sortTag=-taskRewardData.sortTag
end
end

table.sort(self.taskRewardDataList,function(a,b)return a.sortTag>b.sortTag end)

return self.taskRewardDataList
end



function hongChenJieObject:initDisciple()
local localSaveDisciple=hongChenJieModel:getGameDispatchDisciple(self.id)
if localSaveDisciple then
self.disciple=localSaveDisciple
else
if mathHelper.compareInt64(self.data.discipleGuid,Int64_0)then
self.disciple=nil
else
self.disciple=self.data.discipleGuid
end
end

end
function hongChenJieObject:setSelectDisciple(guid)
self.disciple=guid
hongChenJieModel:saveGameDispatchDisciple(self.id,guid)
end
function hongChenJieObject:getSelectDisciple()
return self.disciple
end
function hongChenJieObject:setDataDiscipleGuid(guid)
self.data.discipleGuid=guid
end



function hongChenJieObject:setRewardSelfFinishFlag(id)
if self.rankingRewardSelfFinishStateLookup then
self.rankingRewardSelfFinishStateLookup[id].state=2
self:dealRankingList(false,true)
end
end
function hongChenJieObject:getRewardSelfFinishFlag()
return self.data.rewardSelfFinishList
end


function hongChenJieObject:setRewardOtherFinishFlag(id)
if self.data then
if not self.data.rewardOtherFinishList then
self.data.rewardOtherFinishList={}
end
table.insert(self.data.rewardOtherFinishList,id)
self:dealRankingList(false,true)
end
end
function hongChenJieObject:getRewardFinishFlag()
return self.data.rewardOtherFinishList
end



function hongChenJieObject:setTimes(times)
self.data.times=times
end
function hongChenJieObject:getTimes()
return self.data.times
end





function hongChenJieObject:setBuyTimes(times)
self.data.buyTimes=times
end
function hongChenJieObject:getBuyTimes()
return self.data.buyTimes
end


function hongChenJieObject:getResidueTimes()
local freeCount=hongChenJieConfig.getBaseInfo(self.id,'free_num')
return self.data.buyTimes+freeCount-self.data.times
end


function hongChenJieObject:setMaxYear(year)
self.data.maxYear=year
end
function hongChenJieObject:getMaxYear()
return self.data.maxYear
end


function hongChenJieObject:setMaxLevel(level)
self.data.maxLevel=level
end
function hongChenJieObject:getMaxLevel()
return self.data.maxLevel
end


function hongChenJieObject:setIdentity(identityId)
if self.data.gameData then
self.data.gameData.identity=identityId


self.data.gameData.event_list_len=0
self.data.gameData.event_list={}
self:initEventList()
end
end
function hongChenJieObject:getIdentity()
if self.data.gameData then
return self.data.gameData.identity
end
end



function hongChenJieObject:getGameInfo()
if next(self.data.gameData)then
return self.data.gameData
end
end


function hongChenJieObject:setIdentityList(list)
self.data.identityList=list
end
function hongChenJieObject:getIdentityList()
return self.data.identityList
end
function hongChenJieObject:resetIdentityList()
self.data.identityList={0,0,0}
end


function hongChenJieObject:initName()
if self.data.gameData.name==nil and self.data.gameData.identity>0 then
local identity=self.data.gameData.identity
local sex=self.data.gameData.sex
local idx=self.data.gameData.name_idx
local name=cfgHelper.get4(cfg_hongchenjieidentityconfig_get,identity,'name_lib',idx,sex)
self.data.gameData.name=name
end
end
function hongChenJieObject:updateIdentityName(idx)
self.data.gameData.name_idx=idx
self.data.gameData.name=nil
self:initName()
end
function hongChenJieObject:setIdentityName(nameStr)
self.data.gameData.name=nameStr
end
function hongChenJieObject:getIdentityName()
return self.data.gameData.name
end


function hongChenJieObject:initInfoList()

if self.data.gameData then
if self.data.gameData.attrlist then
self.attrLookUp=self.data.gameData.attrlist
end
end
end
function hongChenJieObject:setInfoList(list)
self.data.gameData.attrlist=list
end
function hongChenJieObject:changeInfoList(list)
for k,v in pairs(list)do
local type=v[1]
local val=v[2]
self:setSingleInfo(type,val)
end
end
function hongChenJieObject:setSingleInfo(type,val)
if val~=nil then
local lastVal=self.attrLookUp[type]
self.attrLookUp[type]=Mathf.Max(self.attrLookUp[type]+val,0)

if type<=HongChenJieDiscipleAttrTypeEnum.JiYuan then
local newVal=self.attrLookUp[type]
UIManager:invokeUIMethod('UIHongChenJieGameWin','playAttrChangeAnimation',type,lastVal,newVal)
end

if type==HongChenJieDiscipleAttrTypeEnum.ShouYuan then
if(not self:checkLessShouYuanTipVal())and not self:getLessShouYuanState()then

self:checkLessShouYuanTipVal(true)
end
end
end
end
function hongChenJieObject:getInfoList()
return self.data.gameData.attrlist
end
function hongChenJieObject:getSingleInfo(type)
return self.attrLookUp[type]
end


function hongChenJieObject:getRaceName()
local identity=self.data.gameData.identity
return cfgHelper.get2(cfg_hongchenjieidentityconfig_get,identity,'race_name')
end


function hongChenJieObject:getSex()
local identity=self.data.gameData.identity
local sex=self.data.gameData.sex
return cfgHelper.get3(cfg_hongchenjieidentityconfig_get,identity,'sex_list',sex)
end


function hongChenJieObject:getJingJie()
return self.data.gameData.level
end
function hongChenJieObject:getJingJieName(level,jjType)
local identity=self:getIdentity()
if identity and identity>0 and jjType==nil then
jjType=cfgHelper.get(cfg_hongchenjieidentityconfig_get,identity,'jjType')
end
if jjType==nil then
logErr(FMT.fmt("hongchenjie error jjname,args: identity--{0},level--{1},jjType{2}",identity,level,jjType))
end

jjType=jjType or 1

local jjname_lists=hongChenJieConfig.getBaseInfo(self.id,'jjname_list')
local jjname_suffixs=hongChenJieConfig.getBaseInfo(self.id,'jjname_suffix')

local jjname_list=jjname_lists[jjType]
local jjname_suffix=jjname_suffixs[jjType]

local stageLen=#jjname_suffix

if level==0 then
return jjname_list[level]
else
local jj=Mathf.Floor(level/stageLen)
jj=Mathf.Min(#jjname_list,jj)
local suffix=level%stageLen
local str

if suffix==0 then
str=FMT.fmt("{0}{1}",jjname_list[jj],jjname_suffix[stageLen])
else
str=FMT.fmt("{0}{1}",jjname_list[jj+1],jjname_suffix[suffix])
end
return str
end
end


function hongChenJieObject:getGameTotalYear()
return self.totalYear
end


function hongChenJieObject:setOldMoneyNum()
local moneyType=hongChenJieConfig.getBaseInfo(self.id,'money_type')
self.oldMoneyNum=itemsModel.getCount(moneyType)
end
function hongChenJieObject:getOldMoneyNum()
return self.oldMoneyNum or 0
end


function hongChenJieObject:getLabelList()
return self.labelList
end


function hongChenJieObject:setTaskRewardFlag(indexFlag)
self.data.taskRewardFlag=indexFlag
end

function hongChenJieObject:getCurGWIndex()
local allCfg=hongChenJieConfig.getBaseInfo(self.id,'reward')
local money_type=hongChenJieConfig.getBaseInfo(self.id,'money_type')
local val=itemsModel.getCount(money_type)
local index=0
for k,cfg in ipairs(allCfg)do
if val>=cfg[1]then
index=k
else
break
end
end
return index
end


function hongChenJieObject:getProgress()
local money_type=hongChenJieConfig.getBaseInfo(self.id,'money_type')
local money_max=hongChenJieConfig.getBaseInfo(self.id,'money_max')
return itemsModel.getCount(money_type),money_max
end


function hongChenJieObject:getReddot()
if not systemModel.isOpen(SYSTEM_DEFINE.eHongChenJie)then return false end

local reddot=self:reddotRankingReward()

return reddot
end

function hongChenJieObject:getSystemFinishState()
local money_type=hongChenJieConfig.getBaseInfo(self.id,'money_type')
local money_max=hongChenJieConfig.getBaseInfo(self.id,'money_max')
return itemsModel.getCount(money_type)>=money_max
end

function hongChenJieObject:getRefreshedTimes()
return self.data.refreshTime or 0
end

function hongChenJieObject:setRefreshedTimes(times)
self.data.refreshTime=times
end

function hongChenJieObject:setRefreshFreeStamp(stamp)
self.data.freeTimesRefreshTimeStamp=stamp
end


function hongChenJieObject:setCanClickNextEventState(state)
self.data.isCanClickNextEvent=state
end

function hongChenJieObject:getCanClickNextEventState(state)
return self.data.isCanClickNextEvent
end

function hongChenJieObject:setReconnectJCState(state)
self.data.hasReconnectJcEvent=state
end

function hongChenJieObject:getReconnectJCState()
return self.data.hasReconnectJcEvent
end

function hongChenJieObject:getIdentityLessShouYuanTipVal()
local identityId=self:getIdentity()
return cfgHelper.get2(cfg_hongchenjieidentityconfig_get,identityId,'lessShouYuanTipVal')
end

function hongChenJieObject:setLessShouYuanState(state)
self.data.gameData.isTriggerLessShouYuan=state
end
function hongChenJieObject:getLessShouYuanState()
return self.data.gameData.isTriggerLessShouYuan
end

function hongChenJieObject:setSummaryLabelList(eventInfo)
local data=eventInfo.data
local eventCfg=eventInfo.eventCfg
if data.choice_idx>0 and data.result_idx>0 then
local temp={}
temp.year=self.totalYear
if eventCfg.label then
local labelChoice=eventCfg.label[data.choice_idx]
if labelChoice and labelChoice[data.result_idx]and labelChoice[data.result_idx]~=''then
temp.type=1
temp.label=labelChoice[data.result_idx]
else


end
end

if eventCfg.label_verdict then
local verdictChoice=eventCfg.label_verdict[data.choice_idx]
if verdictChoice and verdictChoice[data.result_idx]and verdictChoice[data.result_idx]~=''then
temp.type=2
temp.verdict=verdictChoice[data.result_idx]
else


end
end

if temp.type then
table.insert(self.labelList,temp)
end
end
end

function hongChenJieObject:getResidueBuyTimes()
local todayBuyCount=self:getBuyTimes()
local buyCountCost=hongChenJieConfig.getBaseInfo(self.id,'consume')
local todayMaxBuyCount=#buyCountCost
local max=todayMaxBuyCount-todayBuyCount
return max
end


function hongChenJieObject:reddotGWReward()
local curGWIndex=self:getCurGWIndex()
return curGWIndex>self.data.taskRewardFlag
end

function hongChenJieObject:reddotRankingReward()
local isHasReddot=false
for k,groupData in pairs(self.rankGroupList)do
local tid=groupData.tid
local rankingData=groupData.list[tid]

if self:checkCanReceiveOtherReward(rankingData.id)then
isHasReddot=true
break
end

if self:checkCanReceiveSelfReward(rankingData.id)then
isHasReddot=true
break
end
end
return isHasReddot
end


function hongChenJieObject:checkRankingSelfNotFinish()
for k,groupData in pairs(self.rankGroupList)do
local tid=groupData.tid
local rankingData=groupData.list[tid]

if not self:checkSelfFinishState(rankingData.id)then
return true
end
end
return false
end


function hongChenJieObject:checkArchive()
local state=false
if self.data.gameData then

state=state or self.data.gameData.event_list_len>0
end




return state
end


function hongChenJieObject:checkStartCount()
return self:getResidueTimes()>0
end


function hongChenJieObject:checkSelectIdentityProgress()
return self.data.identityList[1]~=0
end

function hongChenJieObject:checkCanReceiveOtherReward(idx)
local rankData=self.rankingLookup[idx]
return rankData.data.actor_id~=nil and(not self:checkOtherFinishState(idx))
end

function hongChenJieObject:checkCanReceiveSelfReward(idx)
local rankData=self.rankingLookup[idx]
return self.rankingRewardSelfFinishStateLookup[idx].state==1
end

function hongChenJieObject:checkSelfFinishState(idx)
return self.rankingRewardSelfFinishStateLookup[idx].state>1
end

function hongChenJieObject:checkOtherFinishState(idx)
return table.findValue(self.data.rewardOtherFinishList or{},idx)~=nil
end

function hongChenJieObject:checkReachTaskState(idx)
return self.data.taskRewardFlag>=idx
end

function hongChenJieObject:checkGameEnd()
local lastEventInfo=self.eventInfoList[#self.eventInfoList]
local endFlag=false
local eventEnd=false
if lastEventInfo then
endFlag=lastEventInfo.eventCfg.end_flag~=nil and lastEventInfo.eventCfg.end_flag==1
eventEnd=lastEventInfo.isEnd
end
local noSelectIdentity=self.data.identityList[1]==0
local state=noSelectIdentity and(endFlag or eventEnd)

return state or false
end

function hongChenJieObject:checkIdle()


local eventListState=self.eventInfoList and#self.eventInfoList==0
local identityState=self.data.identityList[1]==0

return eventListState and identityState
end

function hongChenJieObject:checkAutoReqNextEvent(eventCfg,eventData)
local effect=eventCfg.choice[eventData.choice_idx].result[eventData.result_idx+1]


for index,data in ipairs(effect)do
if data[1]==HONGCHENJIE_Event_Effect_TYPE.NextEvent and data[3]==1 then
hongChenJieController:reqGameEventNext(self.id)
end
end
end

function hongChenJieObject:checkIdentityRefreshedTimes()
local identityRefreshCost=hongChenJieConfig.getBaseInfo(self.id,'identity_refresh')
local refreshCounted=self:getRefreshedTimes()
return#identityRefreshCost>refreshCounted
end

function hongChenJieObject:checkIsGaming()
return self:checkArchive()or self:checkSelectIdentityProgress()
end

function hongChenJieObject:checkCanReqNextEvent()
local lastEventInfo=self.eventInfoList[#self.eventInfoList]
local state=true

local typeState=lastEventInfo.data.result_idx>0
state=state and typeState

local gameState=not self:checkGameEnd()
state=state and gameState

state=state and self.data.isCanClickNextEvent



return state
end

function hongChenJieObject:checkSameSelectDz()
return mathHelper.compareInt64(self.disciple,self.data.discipleGuid)
end

function hongChenJieObject:checkLessShouYuanTipVal()
local lessShouYuanTipVal=self:getIdentityLessShouYuanTipVal()
local shouYuanVal=self:getSingleInfo(HongChenJieDiscipleAttrTypeEnum.ShouYuan)
return lessShouYuanTipVal>=shouYuanVal
end

function hongChenJieObject:checkEndEventIsDecisionEvent()
if self.eventInfoList then
local endEvent=self.eventInfoList[#self.eventInfoList]
return(endEvent.eventType==HONGCHENJIE_EVENT_TYPE.SmallDisicion or endEvent.eventType==HONGCHENJIE_EVENT_TYPE.BigDisicion)
end
end

function hongChenJieObject:checkIsCanBuyTimes()
local max=self:getResidueBuyTimes()
return max>0
end


function hongChenJieObject:updateFreeTimes()
local stamp=self.data.freeTimesRefreshTimeStamp
if not timeHelper.isTodayShort(stamp)then
self.data.times=0
self.data.freeTimesRefreshTimeStamp=timeHelper.getServerShortTime()
self:setBuyTimes(0)
UIManager:invokeUIMethod('UIHongChenJieMainWin','refreshAll')
end
end






function new_hongChenJieGameInfo(gameInfo)
local newT={}
local mT={
__index=hongChenJieObject,
}
setmetatable(newT,mT)
newT:__init(gameInfo)
return newT
end










