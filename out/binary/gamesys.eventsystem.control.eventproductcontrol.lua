





eventProductControl=gameState.addListener({})
eventProductControl.mainType=EVENT_TYPE.eNomal
eventProductControl.subType=EVENT_NORMAL_SUB_TYPE.eDiziProduct


function eventProductControl:onAppStart()
notifySystem:listenNotify(notifyConfig.building_event,self.onBuildEvent)
end

function eventProductControl:onEnterState()
end

function eventProductControl:onLeaveState()
end

function eventProductControl:onProtocolReq()

eventOptionControl.checkDoingOptionEventMiJingTypeFinishState()
end



function eventProductControl.onBuildEvent(eventType,sfId,buildguid,arg3,arg4)
if eventType==buildingEvent.planStart then
local diziguid=arg3
local plantId=arg4
eventProductControl:triggerEvent(sfId,buildguid,diziguid,plantId)
elseif eventType==buildingEvent.speedUpComplete then
eventProductControl:onVerifyEvent(sfId,buildguid)
elseif eventType==buildingEvent.planCancel then
eventProductControl:onCancelEvent(sfId,buildguid)
elseif eventType==buildingEvent.planStatusChange then
eventProductControl:onLockEvent(sfId,buildguid)
end
end


function eventProductControl:onBuySuccess(diziguid,sfId,buildguid)
eventProductControl:triggerEvent(sfId,buildguid,diziguid)
end

function eventProductControl:triggerEvent(sfId,buildguid,diziguid,plantId)
local triggerArray=eventProductControl:createTriggerInfoList(sfId,buildguid,diziguid,plantId)
if triggerArray then
eventTriggerContorl:enQueueList(triggerArray)
end
end

function eventProductControl:onVerifyEvent(sfId,buildguid)
self:freshEvent(sfId,buildguid)
end


function eventProductControl:onCancelEvent(sfId,buildguid)
local func=function(mainType,subType,paramList)
if self.mainType==mainType and self.subType==subType then
if tostring(sfId)==tostring(paramList[1])and tostring(buildguid)==tostring(paramList[2])then
return true
end
end
return false
end
eventTriggerContorl.cancelTriggerByFunction(func)
end


function eventProductControl:onLockEvent(sfId,buildguid)
self:freshEvent(sfId,buildguid)
end

function eventProductControl:createTriggerInfoList(sfId,buildguid,diziguid,plantId)
local buildData=zongmenModel:getBuildingData(buildguid)
if buildData==nil then return false end
local buildid=buildData.build_id
local isShop=UIShopModel:isShop(buildid)
local mainType=EVENT_TYPE.eNomal
local subType=EVENT_NORMAL_SUB_TYPE.eDiziProduct
local level=buildData.level
local list=eventConfig.getProduceEventConfigIdList(buildid)or{}
if isShop then
local paramList=eventProductControl:creatParamList(sfId,buildguid,diziguid)
local triggerId=list[level][1]
local info=eventTriggerModel.creatClientTriggerData(mainType,subType,triggerId,paramList,0,timeHelper.getServerLongTime(),true)
return{info}
else
if plantId==nil then
logErr('没有传递种植方案，不触发生产事件')
return
end
if diziguid==nil then

return
end
local plantCfg=zongmenModel:getBuildingAllPlant(buildid,level)[plantId]
local groupDuration=plantCfg[1]
local group=plantCfg.groups[1]
for planidx,idList in pairs(list)do
if planidx==plantId then
local id=idList[1]
local randomNum=eventConfig.getProduceEventConfig(id).num
local num=randomNum and math.random(unpack(randomNum))or 1
if num>=group then num=group end
local groupRandom=self:getGroupRandom(group,num)
local array={}
for i=1,num do
local groupIdx=groupRandom[i]
local randomTime=math.random(math.floor(groupDuration/2)+1,groupDuration)
local duration=groupDuration*(groupIdx-1)+randomTime
local paramList=eventProductControl:creatParamList(sfId,buildguid,diziguid,groupIdx,randomTime,plantId)

array[#array+1]=eventTriggerModel.creatClientTriggerData(mainType,subType,id,paramList,duration,nil,true)
end
return array
end
end
end
end

function eventProductControl:freshAllEvent(sfId)
local datas=zongmenModel:getAllBuildingData(sfId)
for k,v in pairs(datas)do
local buildguid=v.un_build_id
eventProductControl:freshEvent(sfId,buildguid,false)
end
eventTriggerContorl:sort()
end

function eventProductControl:freshEvent(sfId,buildguid,fresh)
local triggers=self:findTriggerList(sfId,buildguid)
local len=#triggers
local remove={}
for i,v in ipairs(triggers)do
if self:verifyData(v)==false then
remove[#remove+1]=v
end
end
local len1=#remove
eventTriggerContorl.cancelTriggerList(remove)

if len>len1 and fresh~=false then
eventTriggerContorl:sort()
end
end

function eventProductControl:lockEvent(sfId,buildguid,flag)
local func=function(mainType,subType,paramList)
if self.mainType==mainType and self.subType==subType then
if tostring(sfId)==tostring(paramList[1])and tostring(buildguid)==tostring(paramList[2])then
return true
end
end
return false
end
eventTriggerContorl.lockEventByFunction(func,flag)
end


function eventProductControl:creatParamList(sfId,buildguid,diziguid,...)
return{sfId,buildguid,diziguid,...}
end

function eventProductControl:getGroupRandom(group,eventLen)
local multi=2
local startGroup=math.floor(group/multi)+1
local endGroup=group
while startGroup>group or(endGroup-startGroup)<eventLen do
multi=multi+1
startGroup=math.floor(group/multi)+1
end
local temp={}
local lookup={}
while eventLen>0 do
local groupIdx=math.random(startGroup,endGroup)
if not lookup[groupIdx]then
lookup[groupIdx]=true
eventLen=eventLen-1
temp[#temp+1]=groupIdx
end
end
return temp
end

function eventProductControl:verifyData(info)
local paramList=info[5]
local sfId=tonumber(tostring(paramList[1]))
local buildguid=tonumber(tostring(paramList[2]))
local diziguid=paramList[3]
local buildData=zongmenModel:getBuildingData(buildguid)
if buildData==nil then return end
local buildid=buildData.build_id
local isShop=UIShopModel:isShop(buildid)
if isShop then return end

if buildData.plant_id<=0 then return end
local isPause=buildData.pcreateopentime==0
if isPause then
local guid=info[6]
self:lockEvent(sfId,buildguid,true)
eventTriggerContorl.setEventLock(guid)

return

end

local paramList=info[5]
local sfId=paramList[1]
local diziguid=paramList[3]
local groupIdx=paramList[4]
local duration=paramList[5]
local plantId=paramList[6]
if groupIdx==nil or duration==nil then return false end
local cddata=buildingCDControl:getCDData(buildingCDType.plan,buildguid,true)
if cddata==nil then return end
local currStep=cddata.currStep
groupIdx=tonumber(tostring(groupIdx))
duration=tonumber(tostring(duration))
plantId=tonumber(tostring(plantId))
if groupIdx<currStep then
info[6]=timeHelper.getServerShortTime()-1

return
end

local level=buildData.level
local plantCfg=zongmenModel:getBuildingAllPlant(buildid,level)[plantId]
if plantCfg==nil then return false end
local groupDuration=plantCfg[1]
local group=plantCfg.groups[1]
local stepDTime=cddata.stepDTime
local stamp=timeHelper.getServerShortTime()
local stepStartStamp=stamp-stepDTime
local stepDiv=groupIdx-currStep
local leftTime=stepDiv*groupDuration+duration
info[6]=stepStartStamp+leftTime

end

function eventProductControl:findTriggerList(sfId,buildguid)
local func=function(mainType,subType,paramList)
if self.mainType==mainType and self.subType==subType then
if tostring(sfId)==tostring(paramList[1])and tostring(buildguid)==tostring(paramList[2])then
return true
end
end
return false
end
return eventTriggerContorl.findTriggerInfoList(func)
end


function eventProductControl:handleParamListToTxt(paramList)
if paramList==nil then
logErr('生产事件没有找到任何参数')
return
end
local temp={}
local sfId=paramList[1]
local buildguid=paramList[2]
local diziguid=paramList[3]




local diziInfo=UIDiscipleModel:getDiscipleData(diziguid)
local name=diziInfo.disciplename
temp.dizi1={diziguid=diziguid,diziname=name}
return temp
end

function eventProductControl:getDiziID(paramList)
return paramList and paramList[3]
end

function eventProductControl:checkRewardParams(eventInfo,buildguid)
local paramList=eventInfo.paramList
return tostring(paramList[2])==tostring(buildguid)
end


function eventProductControl:checkParamsOnReq(paramList)
local sfId=tonumber(tostring(paramList[1]))
local buildguid=tonumber(tostring(paramList[2]))
local lastdiziguid=paramList[3]
local buildData=zongmenModel:getBuildingData(buildguid)
if buildData==nil then return false end
local _diziguid=buildData.dizi_id
local diziguidStr=tostring(_diziguid)
if diziguidStr=='0'or _diziguid==nil then return false end
if diziguidStr~=tostring(lastdiziguid)then
paramList[3]=int64.new(diziguidStr)
end
return true
end


function eventProductControl:verifyLocalDataOnRead(info)
return eventProductControl:verifyData(info)
end


