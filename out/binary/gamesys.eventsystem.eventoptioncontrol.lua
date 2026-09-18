




eventOptionControl=gameState.addListener({})

local _tickTime=0.6
local _isInitEvent=false
local _isReqInit=false
local _defualtRefreshNewEventCd=15
local _nextRefreshEventTime=nil
local _saveCdType=nil

local _getNPCListFunc={
[EVENT_OPTION_NPC_TYPE.eJZZuZhang]=function(selectParam)
local list={}
local selectType=selectParam[1]
local familyList=worldXiuZhenJiaZuModel:getFamilyAreaList()
if selectType==1 then

local worldIdList=selectParam[2]
for _,worldId in ipairs(worldIdList)do
if familyList[worldId]and next(familyList[worldId])then
list=table.concatTable(familyList[worldId],list)
end
end
elseif selectType==2 then

list=worldXiuZhenJiaZuModel:getAllSelfFamilyData()
elseif selectType==3 then

for i,v in pairs(familyList)do
list=table.concatTable(v,list)
end
end
return list
end,
[EVENT_OPTION_NPC_TYPE.eSystemZMZhangMeng]=function(selectParam)
local list={}
local selectType=selectParam[1]
if selectType==1 then

local worldIdList=selectParam[2]
local worldIdList_loockup={}
for _,worldId in ipairs(worldIdList)do
worldIdList_loockup[worldId]=true
end

local zmList=systemZongMenModel:getInfoList()
for i,v in ipairs(zmList)do
local worldId=v.worldId
local blockId=v.blockId
if worldIdList_loockup[worldId]and worldBlockModel:checkBlockState(worldId,blockId,eWorldBlockState.OPEN)then
table.insert(list,v)
end
end
elseif selectType==2 then

local zmIdList=selectParam[2]
local zmIdList_lookup={}
for i,v in ipairs(zmIdList)do
zmIdList_lookup[v]=true
end

local zmInfoList=systemZongMenModel:getInfoList()
for i,v in ipairs(zmInfoList)do
local worldId=v.worldId
local blockId=v.blockId
local zmId=v.id
if zmIdList_lookup[zmId]and worldBlockModel:checkBlockState(worldId,blockId,eWorldBlockState.OPEN)then
table.insert(list,v)
end
end
end
return list
end,
[EVENT_OPTION_NPC_TYPE.eWorldNPC]=function(selectParam)

local list={}
for i,npcId in ipairs(selectParam)do
local npcCfg=cfgHelper.get1(cfg_npcconfig_get,npcId)
table.insert(list,npcCfg)
end

return list
end,
[EVENT_OPTION_NPC_TYPE.eMortalNPC]=function(selectParam)

local list={}
for i,npcId in ipairs(selectParam)do
local npcCfg=cfgHelper.get1(cfg_mortalnpcconfig_get,npcId)
table.insert(list,npcCfg)
end

return list
end,
[EVENT_OPTION_NPC_TYPE.eZMZhangMen]=function(selectParam)

local list={{id=1}}
return list
end,
}

local _getNPCDataFunc={
[EVENT_OPTION_NPC_TYPE.eJZZuZhang]=function(data)
local npcData={
guid=tostring(data.guid),
}
return npcData
end,
[EVENT_OPTION_NPC_TYPE.eSystemZMZhangMeng]=function(data)
local npcData={
serial=tostring(data.serial),
}
return npcData
end,
[EVENT_OPTION_NPC_TYPE.eWorldNPC]=function(data)

local npcData={
id=data.id,
}
return npcData
end,
[EVENT_OPTION_NPC_TYPE.eMortalNPC]=function(data)

local npcData={
id=data.id,
}
return npcData
end,
[EVENT_OPTION_NPC_TYPE.eZMZhangMen]=function(data)

local npcData={
id=data.id,
}
return npcData
end,
}

local _getNPCModelFunc={
[EVENT_OPTION_NPC_TYPE.eJZZuZhang]=function(npcData,isInSideModel)
local familyId=npcData.id
local zuZhangCfg=worldXiuZhenJiaZuModel:getElderConfig(familyId)
local model
if isInSideModel then

model=worldXiuZhenJiaZuModel:getZuZhangImageInfoInSide(zuZhangCfg.model)
else

local outSideModelParam=zuZhangCfg.model_outside
local result={}
result.body=outSideModelParam[1]
result.componets={}
for i=2,#outSideModelParam do
result.componets[#result.componets+1]=outSideModelParam[i]
end
model=result
end
return model
end,
[EVENT_OPTION_NPC_TYPE.eSystemZMZhangMeng]=function(npcData,isInSideModel)
local serial=int64.new(npcData.data.serial)
local detailInfo=systemZongMenModel:getDetailPartInfo(serial,systemZongMenDetailDataPart.eBase)
local model
if detailInfo then
local zmImage=UIDiscipleModel.calculationDiscipleImage(detailInfo.leader_data,detailInfo.leader_image)
if isInSideModel then

model=UIDiscipleModel:getDiscipleInsideModelInfoByData(zmImage)
else

model=UIDiscipleModel:getDiscipleOutsideModelInfoByData(zmImage)
end
end
return model
end,
[EVENT_OPTION_NPC_TYPE.eWorldNPC]=function(npcData,isInSideModel)
local npcId=npcData.id
local model
local imagecfg=npcModel:getNPCImageCfg(npcId)
if isInSideModel then

model=npcModel:getImageInfo(imagecfg.id)
else

model=npcModel:getImageInfoOutSide(imagecfg.id)
end

return model
end,
[EVENT_OPTION_NPC_TYPE.eMortalNPC]=function(npcData,isInSideModel)
local npcId=npcData.id
local model
local imagecfg=npcModel:getMortalNPCImageCfg(npcId)
if isInSideModel then

model=npcModel:getImageInfo(imagecfg.id)
else

model=npcModel:getImageInfoOutSide(imagecfg.id)
end

return model
end,
[EVENT_OPTION_NPC_TYPE.eZMZhangMen]=function(npcData,isInSideModel)
local model
local temp=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eZhangMen)
local discipleData=temp and temp[1]or UIDiscipleModel:findSrcTypeDisciple(discipleSrcType.ePlot1)
if isInSideModel then

model=UIDiscipleModel:getDiscipleInsideModelInfo(discipleData.discipleguid)
else

model=UIDiscipleModel:getDiscipleOutsideModelInfo(discipleData.discipleguid,false,1)
end

return model
end,
}

local _getNPCNameFunc={
[EVENT_OPTION_NPC_TYPE.eJZZuZhang]=function(npcData)
local familyGuid=int64.new(npcData.data.guid)
local name=worldXiuZhenJiaZuModel:getZuZhangName(familyGuid)
return name
end,
[EVENT_OPTION_NPC_TYPE.eSystemZMZhangMeng]=function(npcData)
local serial=int64.new(npcData.data.serial)
local detailInfo=systemZongMenModel:getDetailPartInfo(serial,systemZongMenDetailDataPart.eBase)
local name=detailInfo.leader_name
return name
end,
[EVENT_OPTION_NPC_TYPE.eWorldNPC]=function(npcData)
local npcId=npcData.id
local imagecfg=npcModel:getNPCImageCfg(npcId)
local name=npcModel:getName(imagecfg.id)
return name
end,
[EVENT_OPTION_NPC_TYPE.eMortalNPC]=function(npcData)
local npcId=npcData.id
local imagecfg=npcModel:getMortalNPCImageCfg(npcId)
local name=npcModel:getName(imagecfg.id)
return name
end,
[EVENT_OPTION_NPC_TYPE.eZMZhangMen]=function(npcData)
local temp=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eZhangMen)
local discipleData=temp and temp[1]or UIDiscipleModel:findSrcTypeDisciple(discipleSrcType.ePlot1)
local name=UIDiscipleModel:getDiscipleName(discipleData.discipleguid)
return name
end,
}

local _checkNPCFlyFunc={
[EVENT_OPTION_NPC_TYPE.eJZZuZhang]=function(npcData)
return true
end,
[EVENT_OPTION_NPC_TYPE.eSystemZMZhangMeng]=function(npcData)
return true
end,
[EVENT_OPTION_NPC_TYPE.eWorldNPC]=function(npcData)
local npcId=npcData.id
local npcCfg=cfgHelper.get1(cfg_npcconfig_get,npcId)
local isCanFly=npcCfg.mountId~=-1
return isCanFly
end,
[EVENT_OPTION_NPC_TYPE.eMortalNPC]=function(npcData)
return false
end,
[EVENT_OPTION_NPC_TYPE.eZMZhangMen]=function(npcData)
return true
end,
}

function eventOptionControl:onAppStart()

end

function eventOptionControl:onEnterState()
self.showDialogue=nil
_isInitEvent=false
_isReqInit=false
_nextRefreshEventTime=nil
self.onMysteryFinish_callback=function(...)self:onMysteryFinish(...)end
notifySystem:listenNotify(notifyConfig.on_mystery_finish,self.onMysteryFinish_callback)
end

function eventOptionControl:onLeaveState()
self:stopTimer()
self.showDialogue=nil
_isInitEvent=false
_isReqInit=false
_nextRefreshEventTime=nil
notifySystem:removelistener(notifyConfig.on_mystery_finish,self.onMysteryFinish_callback)
end

function eventOptionControl:onProtocolReq()

end

function eventOptionControl:onMysteryFinish(miJingId)

local eventList=eventOptionModel.getWaitFinishMiJingOptionEventList(miJingId,true)
if eventList and next(eventList)then
for i,eventInfo in ipairs(eventList)do

eventOptionModel.addFinishedMiJingOptionEvent(eventInfo)
end
end
end


function eventOptionControl:startTimer()
if self.ticktimer then return end
self.ticktimer=timer.new()
self.ticktimer:start(_tickTime,function()
self:update()
end)
end

function eventOptionControl:stopTimer()
if self.ticktimer then
self.ticktimer:cancel()
end
self.ticktimer=nil
end

function eventOptionControl:update()
local nowTime=gameUtilityModel.getServerShortTime()
if _nextRefreshEventTime and nowTime>=_nextRefreshEventTime then

eventOptionControl:checkWaitOptionEventList(true)
end

for _,subType in pairs(EVENT_OPTION_SUB_TYPE)do
eventControl.invokeEventControl(EVENT_TYPE.eDecision,subType,'update')
end
eventOptionControl:showEventDialogue()
end



function eventOptionControl.onInitOption(len,array)
eventOptionModel.initOption(len,array)
local mainType=EVENT_TYPE.eDecision
for _,subType in pairs(EVENT_OPTION_SUB_TYPE)do
eventControl.invokeEventControl(mainType,subType,'onInitOption')
end
eventOptionControl:startTimer()
eventOptionControl.freshDialogue()


eventOptionControl:checkOptionEventTriggerCount()
end


function eventOptionControl:onRecvOptionEventRet(eventguid,optionid,cndid,effectidx)
local eventInfo=eventLocalOptionModel.getEventData(eventguid)
if eventInfo==nil then return end
local mainType,subType=eventConfig.getEventTypeById(eventInfo.eventid)
eventControl.invokeEventControl(mainType,subType,'onRecvOptionEventRet',eventInfo,optionid,cndid,effectidx)
end


function eventOptionControl:onRecvEventPrize(eventguid)
local eventInfo=eventLocalOptionModel.getEventData(eventguid)
if eventInfo==nil then return end
local mainType,subType=eventConfig.getEventTypeById(eventInfo.eventid)
eventControl.invokeEventControl(mainType,subType,'onRecvEventPrize',eventguid)
end


function eventOptionControl:checkWaitOptionEventList(isUpdate)
local isInCd=eventOptionControl:checkIsInRefreshNewOptionEventCd()
local waitCount=eventOptionModel.checkWaitOptionEventCount()
local freeCount=shanmenModel:getOptionEventNpcHasFreePosCount()
local addNum=freeCount<waitCount and freeCount or waitCount
if not isInCd and addNum>0 then







local eventInfo=eventOptionModel.getWaitOptionEventInfo()


eventControl.enqueueRet("nil",0,eventInfo)

notifySystem:postNotify(notifyConfig.onShanMenVisitChange,SHANMEN_TYPE.eOptionEvent)
return true
elseif isUpdate and addNum<=0 then

eventOptionControl:clearRefreshNewOptionEventCd()
end

return false
end


function eventOptionControl:checkOptionEventTriggerCount()

local freeCount=shanmenModel:getOptionEventNpcHasFreePosCount()
if freeCount<=0 then

return
end


for i,v in pairs(EVENT_OPTION_SUB_TYPE)do
local subType=v
local num=eventOptionModel.getUnHandNumByOptionType(subType)
if num>0 then

return eventControl.invokeEventControl(EVENT_TYPE.eDecision,subType,'triggerEvent')
end
end
end


function eventOptionControl:setRefreshNewOptionEventCd(eventId)
local nowTime=gameUtilityModel.getServerShortTime()







local eventCfg=eventId and eventConfig.getEventConfig(eventId)or nil
local cdTime=eventCfg and eventCfg.endRefreshCdTime or _defualtRefreshNewEventCd
local newNextRefreshEventTime=nowTime+cdTime
if not _nextRefreshEventTime or newNextRefreshEventTime>_nextRefreshEventTime then

_nextRefreshEventTime=newNextRefreshEventTime
end
end


function eventOptionControl:clearRefreshNewOptionEventCd()
_nextRefreshEventTime=nil
end


function eventOptionControl:checkIsInRefreshNewOptionEventCd()
local nowTime=gameUtilityModel.getServerShortTime()
if _nextRefreshEventTime and nowTime<_nextRefreshEventTime then
return true
end

return false
end


function eventOptionControl.onFinish(eventInfo)
local mainType,subType=eventConfig.getEventTypeById(eventInfo.eventid)
eventOptionModel.getShowOptionEventResultFunc(true)
eventControl.invokeEventControl(mainType,subType,'onFinish',eventInfo)
end


function eventOptionControl.onTriggerFail(eventInfo)
local mainType,subType=eventConfig.getEventTypeById(eventInfo.eventid)
eventControl.invokeEventControl(mainType,subType,'onTriggerFail',eventInfo)
end

function eventOptionControl.addDiziIntoEventInfo(eventguid,diZiList,waitTime)
local eventInfo=eventLocalOptionModel.getEventData(eventguid)
if eventInfo==nil then return end
local mainType,subType=eventConfig.getEventTypeById(eventInfo.eventid)
eventControl.invokeEventControl(mainType,subType,'addDiziIntoEventInfo',eventInfo,diZiList,waitTime)
end


function eventOptionControl.initUnhandEventNum(subType)
local data=eventOptionModel.getOption()
if data[subType]==nil then data[subType]={}end
local info=data[subType]
if info.unHandNum==nil then info.unHandNum=0 end
local curNum=info.unHandNum

local storeMaxNum=eventConfig.getEventOptionStoreNum(subType)
if curNum>=storeMaxNum then return end
local maxNum=eventConfig.getEventOptionMaxNum(subType)
local alreadyNum=data[subType].alreadyNum or 0
if alreadyNum>=maxNum then
info.unHandNum=0

return
end
local costTime=data[subType].costTime or 0
local num=eventOptionControl.getUnhandNum(costTime,subType,alreadyNum,storeMaxNum,maxNum)
info.unHandNum=num

return num
end

function eventOptionControl.getUnhandNum(costTime,subType,alreadyNum,storeMaxNum,maxNum)
if not eventControl.invokeEventControl(EVENT_TYPE.eDecision,subType,'isOpenSystem')then return 0 end
local lastStamp=eventOptionControl.getLastStamp(subType)
local num=0
local leftTime=timeHelper.getServerLongTime()-costTime-lastStamp
for i=alreadyNum+1,maxNum do
local duration=eventConfig.getEventOptionDuration(subType,i)
if leftTime>=duration then
num=num+1
leftTime=leftTime-duration
if num>=storeMaxNum then
break
end
else
break
end
end
return num
end

function eventOptionControl.getLastStamp(subType)
local data=eventOptionModel.getOption()
if data==nil then return end
if data[subType]==nil or data[subType].shortStamp==nil then return end
local lastStamp=timeHelper.convertLongStamp(data[subType].shortStamp)




return lastStamp
end

function eventOptionControl.getResetTime()







end

function eventOptionControl.updateUnHandNum(subType)
local data=eventOptionModel.getOption()
if data==nil then return end
if not data.isInit then return end
if data[subType]==nil then return end
if data[subType].shortStamp==nil then return end
local costTime=data[subType].costTime or 0
local curNum=data[subType].unHandNum or 0
local storeMaxNum=eventConfig.getEventOptionStoreNum(subType)
if curNum>=storeMaxNum then return end
local maxNum=eventConfig.getEventOptionMaxNum(subType)
local alreadyNum=data[subType].alreadyNum or 0
if alreadyNum>=maxNum then
data[subType].unHandNum=0

return
end
local num=eventOptionControl.getUnhandNum(costTime,subType,alreadyNum,storeMaxNum,maxNum)
local div=num-curNum
if div<=0 then return end


data[subType].unHandNum=num
data.unHandNum=data.unHandNum+div
notifySystem:postNotify(notifyConfig.onEventChanged,EVENT_POST_CHANGED.eOptionNum,num,data[subType].unHandNum)
end





function eventOptionControl:showEventDialogue()


UIManager:invokeUIMethod('UIFuncStorageWin','refreshShiWuBtn')

end

function eventOptionControl.enoughOpenDialogueConditon()
return UIManager:findActiveWindow('UIEventDialogueWin')==nil and
mainViewsControl.isOpen()and
mainControl:isInScene(eSceneType.eZongmen)and
gameplotModel:isFinish()and
MysteryModel:get_cur_fbid()==nil
end


function eventOptionControl.needOption()
local option=eventOptionModel.getOption()
if option then

local waitChoiceNum=option.waitChoiceNum or 0
local doingNum=option.doingNum or 0
if(waitChoiceNum+doingNum)>0 then
return true
end
end
return false
end


function eventOptionControl.needOptionOnlyWaitChoice()
local option=eventOptionModel.getOption()
if option then

local waitChoiceNum=option.waitChoiceNum or 0
if waitChoiceNum>0 then
return true
end
end
return false
end

function eventOptionControl.canOpenDialogue()
return eventOptionControl.enoughOpenDialogueConditon()and
eventOptionControl.needOption()and
mainControl:isSceneType(eSceneType.eZongmen)and
zongmenControl:isMountid(mapIdType.zhufeng)
end


function eventOptionControl.getOptionShowInfo()
local state=EVENT_OPTION_STATE.eNone
local reddot=0
local time=0
local hasState=false
local eventInfo=eventOptionModel.getOneDoingOptionEvent()













if not hasState then
local option=eventOptionModel.getOption()
local num=option.waitChoiceNum or 0
if num>0 then
hasState=true
state=EVENT_OPTION_STATE.eWaitChoice
reddot=num
end
end

if not hasState then
local options=eventOptionModel.getDoingOptionsEx()
if options and#options>0 then
hasState=true
local eventInfo=options[1]
local eventid=eventInfo.eventid
local optionList=eventInfo.optionList
local optionid=optionList[1]
local isMiJingEvent=eventConfig.checkIsFinishMiJingEventOption(eventid,optionid)
if not isMiJingEvent then
state=EVENT_OPTION_STATE.eDoing
time=eventOptionModel.getLeftTime(eventInfo)
else
state=EVENT_OPTION_STATE.eWaitFinishMiJing
end
end
end


if eventInfo then
local eventid=eventInfo.eventid
local optionList=eventInfo.optionList
local optionid=optionList[1]
local isMiJingEvent=eventConfig.checkIsFinishMiJingEventOption(eventid,optionid)
if not isMiJingEvent then
local waitStamp=eventInfo.eventtime+eventInfo.waitTime
local stamp=timeHelper.getServerShortTime()
if stamp>=waitStamp then
state=EVENT_OPTION_STATE.eFinish
hasState=true
end
else
local finishedMiJingEvent=eventOptionModel.getFinishedMiJingOptionEvent(eventInfo.eventguid)
if finishedMiJingEvent then
state=EVENT_OPTION_STATE.eFinish
hasState=true
end
end
end

if not hasState then
hasState=true
state=EVENT_OPTION_STATE.eNone

end

if time==0 then
local options=eventOptionModel.getDoingOptionsEx()
if options then
for i,v in ipairs(options)do
local eventid=v.eventid
local optionList=v.optionList
local optionid=optionList[1]
local isMiJingEvent=eventConfig.checkIsFinishMiJingEventOption(eventid,optionid)
if not isMiJingEvent then
time=eventOptionModel.getLeftTime(v)
if time>0 then
break
end
end
end
end
end

return state,reddot,time
end


function eventOptionControl.getAnyZMZhanglao()
for i=eZongMenPostType.eZhangMen,eZongMenPostType.eZhenYu do
local list=UIDiscipleModel:getDiscipleByZongMenPost(i)
if list and#list>=1 then
return list[1].discipleguid
end
end
end

function eventOptionControl.isDecision(eventInfo)
return eventInfo and eventConfig.isDecision(tonumber(eventInfo.eventid))or false
end

function eventOptionControl.onInitEvents()
_isInitEvent=true

eventOptionControl.onInitOption()
end

function eventOptionControl.reqInit()
if _isInitEvent and not _isReqInit then
_isReqInit=true

end
end

function eventOptionControl.freshDialogue()
UIManager:callWindowFunc('UIFuncStorageWin','refreshShiWuBtn')
end

function eventOptionControl.log(content,...)

end


function eventOptionControl.getOptionNpcData(eventId,eventGuid)
local eventCfg=eventConfig.getEventConfig(eventId)
local npcData
local canSelectNpcList={}
local canSelectNpcList_lookup={}
local npcLib=eventCfg.imageLib
for _,condition in ipairs(npcLib)do
local npcType=condition[1]
local selectParam=condition[2]
if not canSelectNpcList_lookup[npcType]then
canSelectNpcList_lookup[npcType]={}
end

if npcType and _getNPCListFunc[npcType]then
local list=_getNPCListFunc[npcType](selectParam)
for i,v in ipairs(list)do
local id
if npcType==EVENT_OPTION_NPC_TYPE.eJZZuZhang then
id=v.familyId
else
id=v.id
end
if not canSelectNpcList_lookup[npcType][id]and not shanmenModel:checkOptionEventNpcHasSame(npcType,id)then

local inData=_getNPCDataFunc[npcType](v)
local data={data=inData,type=npcType,id=id,eventId=eventId,eventGuidStr=tostring(eventGuid)}
table.insert(canSelectNpcList,data)
canSelectNpcList_lookup[npcType][id]=true
end
end
end
end

local canSelectCount=#canSelectNpcList
if canSelectCount and canSelectCount>0 then
local randomIndex=math.random(1,canSelectCount)
npcData=canSelectNpcList[randomIndex]



if npcData.type==EVENT_OPTION_NPC_TYPE.eSystemZMZhangMeng then

local serial=int64.new(npcData.data.serial)

systemZongMenController:req_detailInfoBase(serial)
end
end

return npcData
end


function eventOptionControl.getOptionNpcModel(npcData,eventGuid,isInSideModel)
local npcType=npcData.type
if not eventGuid then
return nil
end
local eventGuidStr=tostring(eventGuid)
local changeModel=eventOptionControl.getOptionNpcChangeModel(npcData,eventGuid,isInSideModel)
if changeModel then
return changeModel
end

local localNpcData=eventLocalOptionModel.getOptionEventNpcData(eventGuidStr)
if localNpcData and(not npcType or npcType~=EVENT_OPTION_NPC_TYPE.eZMZhangMen)then
local model
if isInSideModel then
model=localNpcData.inSideModel
else
model=localNpcData.outSideModel
end

if model then
return model
end
end
if npcType and _getNPCModelFunc[npcType]then
local model=_getNPCModelFunc[npcType](npcData,isInSideModel)
if isInSideModel then
eventLocalOptionModel.setOptionEventNpcInSideModel(model,eventGuidStr)
else
eventLocalOptionModel.setOptionEventNpcOutSideModel(model,eventGuidStr)
end
return model
end

return nil
end


function eventOptionControl.getOptionNpcChangeModel(npcData,eventGuid,isInSideModel)
local eventGuidStr=tostring(eventGuid)
local changeNpcId=eventOptionControl.getOptionNpcChangeModelNpcId(npcData,eventGuid)
if not changeNpcId then
return
end

local model
if isInSideModel then

model=npcModel:getImageInfo(changeNpcId)
else

model=npcModel:getImageInfoOutSide(changeNpcId)
end

return model
end

function eventOptionControl.getOptionNpcChangeModelNpcId(npcData,eventGuid)

local eventGuidStr=tostring(eventGuid)
local isWatched=false
local localNpcData=eventLocalOptionModel.getOptionEventNpcData(eventGuidStr)
if localNpcData and localNpcData.isWatchedStartStory then
isWatched=localNpcData.isWatchedStartStory
end
if not isWatched then
return nil
end


local eventId=npcData.eventId
local eventCfg=eventConfig.getEventConfig(eventId)
local changeNpcId=eventCfg.changeNpcId
if not changeNpcId then
return nil
end

return changeNpcId
end



function eventOptionControl.getOptionNpcName(npcData,eventGuid)
local npcType=npcData.type
if not eventGuid then
return nil
end
local eventGuidStr=tostring(eventGuid)
local localNpcData=eventLocalOptionModel.getOptionEventNpcData(eventGuidStr)
if localNpcData and(not npcType or npcType~=EVENT_OPTION_NPC_TYPE.eZMZhangMen)then
local name=localNpcData.name
if name then
return name
end
end
if npcType and _getNPCNameFunc[npcType]then
local name=_getNPCNameFunc[npcType](npcData)
eventLocalOptionModel.setOptionEventNpcName(name,eventGuidStr)
return name
end

return nil
end


function eventOptionControl.getOptionDzGuid(eventguid)
local eventInfo=eventLocalOptionModel.getEventData(eventguid)
local paramList=eventInfo.paramList
local tempList={}
if paramList then
local diziLen=tonumber(tostring(paramList[3]or 0))
if diziLen>0 then
for i=1,diziLen do
local diziguid=int64.new(tostring(paramList[i+3]))


local netData=UIDiscipleModel:getDiscipleData(diziguid)
if netData then
tempList[#tempList+1]=diziguid
end
end
end
end

if not next(tempList)then
return nil
end

return tempList[1]
end


function eventOptionControl.checkOptionNpcIsCanFly(npcData)
local npcType=npcData.type
if npcType and _checkNPCFlyFunc[npcType]then
return _checkNPCFlyFunc[npcType](npcData)
end

return nil
end


function eventOptionControl.checkOptionEventHasSelectStory(eventInfo,optionid)
local eventId=eventInfo.eventid
local endStoryParam=eventConfig.getEventConfig(eventId).selectStoryId
if endStoryParam then
local storyId=endStoryParam[optionid]
return storyId
end
return nil
end


function eventOptionControl.checkOptionEventHasEndStory(eventInfo,optionid,cndid,effectidx,isBefore)
local eventId=eventInfo.eventid
local endStoryParam
if isBefore then

endStoryParam=eventConfig.getEventConfig(eventId).endStoryId_before
else

endStoryParam=eventConfig.getEventConfig(eventId).endStoryId_after
end
if endStoryParam then
local resultParam=endStoryParam[optionid]
if resultParam then
local cndParam=resultParam[cndid]
if cndParam then
if type(cndParam)=='table'then

local effectParam=cndParam[effectidx]
if effectParam then
local storyId=effectParam
return storyId
end
else

local storyId=cndParam
return storyId
end
end
end
end
return nil
end


function eventOptionControl.checkOptionEventHasPrize(eventId,optionid,cndid,effectidx)
local option=eventConfig.getEventConfig(eventId).option
if option then
local resultList=option[optionid]and option[optionid].result or nil
if resultList then
local cndList=resultList[cndid]and resultList[cndid][2]or nil
if cndList then
local effectList=cndList[effectidx]and cndList[effectidx][1]or nil
if effectList then
for i,effectParam in ipairs(effectList)do
if effectParam and next(effectParam)then
return true
end
end
end
end
end
end
return false
end


function eventOptionControl.checkDoingOptionEventMiJingTypeFinishState()

local eventList=eventOptionModel.getDoingOptions()
for _,v in ipairs(eventList)do

local eventid=v.eventid
local optionList=v.optionList
local optionid=optionList[1]
local miJingIdList=eventConfig.getEventOptionMiJingIdList(eventid,optionid)
if miJingIdList and next(miJingIdList)then

local miJingId=miJingIdList[1]
local posData=MysteryModel:get_mysteryFB_unit(miJingId)
eventOptionControl.addDiziIntoEventInfo(v.eventguid,nil,0)
local isFinish=posData==nil
if isFinish then

eventOptionModel.addFinishedMiJingOptionEvent(v)
else

eventOptionModel.addWaitFinishMiJingOptionEvent(v)
end
end
end
end
