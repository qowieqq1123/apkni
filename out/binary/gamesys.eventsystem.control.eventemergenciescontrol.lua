





eventEmergenciesControl=gameState.addListener({})
eventEmergenciesControl.mainType=EVENT_TYPE.eNomal
eventEmergenciesControl.subType=EVENT_NORMAL_SUB_TYPE.eEmergencies
local _storekey='event_emergencies'

function eventEmergenciesControl:onAppStart()
socketManager:register_receiver(11,25,function(...)self:onInitData(...)end)
end

function eventEmergenciesControl:onEnterState(isReconnect)
self:init()
self:readLocalData()
timeEventController.addNormalTimerHandler(1,'eventEmergenciesControl',self)
end

function eventEmergenciesControl:onLeaveState(isReconnect)
self:init()
timeEventController.removeNormalTimerHandler(1,'eventEmergenciesControl')
end

function eventEmergenciesControl:onProtocolReq(isReconnect)
self.protocolReq=true
end

function eventEmergenciesControl:onNormalUpdate()
if not self.protocolReq then return end
if self.serverLookup==nil then return end
for id,v in pairs(self.serverLookup)do
eventEmergenciesControl:triggerEvent(id)
end
end

function eventEmergenciesControl:init()
self.protocolReq=false
self.serverLookup=nil
self.nextStamp=nil
self.readDzList=nil
self.localDzList=nil
self.localDzLookup=nil
self.dzList=nil
self.dzLookup=nil
self.localChanged=false
end


function eventEmergenciesControl:triggerEvent(id)
local stamp=timeHelper.getServerShortTime()
local nextStamp=self.nextStamp[id]
if nextStamp==nil then return end
if stamp<nextStamp then return end
local serverLookup=self.serverLookup[id]
if serverLookup==nil then return end
if stamp>=serverLookup.param_3 then
self.serverLookup[id]=nil
self.nextStamp[id]=nil
return
end
while nextStamp and stamp>=nextStamp do
local list=self:getDZList(id)
local len=0
if list==nil or#list<=0 then
self:initDZList(id)
list=self:getDZList(id)
if list==nil or#list<=0 then break end
end
len=#list

local idx=math.random(1,len)
local dzguid=self:dequeueDZ(id,idx,true)
if dzguid==nil then break end
local triggerArray=self:createTriggerInfo(id,dzguid,timeHelper.convertLongStamp(nextStamp))
if triggerArray then
eventTriggerContorl:enQueue(triggerArray)
nextStamp=self:setNextStamp(id)
self.nextStamp[id]=nextStamp
end
end
end


function eventEmergenciesControl:createTriggerInfo(id,dzguid,timeStamp)
if dzguid==nil then
self:log('触发弟子guid为空')
return
end
if self:getDZ(dzguid)==nil then
self:delDZ(id,dzguid)
self:log('弟子已变更为不能触发状态，更换其他弟子触发')
return
end

local mainType=self.mainType
local subType=self.subType
local triggerId=id
local paramList=self:creatParamList(dzguid,id)
local dzname=UIDiscipleModel:getDiscipleName(dzguid)
self:log('弟子{0}触发突发事件，触发时间：{1}',dzname,timeHelper.getFormatByStamp(timeStamp))
return eventTriggerModel.creatClientTriggerData(mainType,subType,triggerId,paramList,nil,timeStamp)
end

function eventEmergenciesControl:creatParamList(dzguid,id)
return{dzguid,id}
end


function eventEmergenciesControl:handleParamListToTxt(paramList)
if paramList==nil then
logErr('修炼事件没有找到任何参数')
return
end
local temp={}
local diziguid=paramList[1]
local diziInfo=self:getDZ(diziguid)
if not diziInfo then

return
end
local name=diziInfo.disciplename
temp.dizi1={diziguid=diziguid,diziname=name}
return temp
end


function eventEmergenciesControl:getDiziID(paramList)
return paramList and paramList[1]or nil
end

function eventEmergenciesControl:getSpace()
return eventConfig.getCommonConfig().tufaconf[1]
end

function eventEmergenciesControl:setNextStamp(id)
local nextStamp=self.nextStamp[id]
if nextStamp==nil then return end
local data=self.serverLookup[id]
local maxStamp=data.param_3
local stamp=timeHelper.getServerShortTime()
if stamp>=maxStamp then return end
local space=eventEmergenciesControl:getSpace()
nextStamp=nextStamp+space
if nextStamp>=maxStamp then return end
data.param_2=nextStamp
self:log('下次触发时间:{0}',timeHelper.getFormatByStamp(nextStamp))
return nextStamp
end




function eventEmergenciesControl:onInitData(len,array)
if len==0 then
self:init()
self:clearLocalFile()
return
end
self.serverLookup={}
self.nextStamp={}
local stamp=timeHelper.getServerShortTime()
for i,v in ipairs(array)do
local id=v.param_1
local nextStamp=v.param_2
local maxStamp=v.param_3
if maxStamp>stamp then
self.serverLookup[id]=v
self.nextStamp[id]=nextStamp
end
end
end


function eventEmergenciesControl:showInJianwenChannel(timeStamp,paramList)
return true
end

function eventEmergenciesControl:hasDZInCache(id)
local list=self:getDZList(id)
if list==nil then return false end
return#list>0
end

function eventEmergenciesControl:getDZList(id)
if self.dzList==nil then return end
return self.dzList[id]
end

function eventEmergenciesControl:getDZ(dzguid)
local dzInfo=UIDiscipleModel:getDiscipleData(dzguid)
if dzInfo==nil or
UIDiscipleModel:checkDiscipleState2(dzguid,DISCIPLE_STATE_TYPE.eChuiWei)or
UIDiscipleModel:checkDiscipleState2(dzguid,DISCIPLE_STATE_TYPE.eQianRu)or
UIDiscipleModel:checkDiscipleState2(dzguid,DISCIPLE_STATE_TYPE.edsDispatch)or
UIDiscipleModel:checkDiscipleState2(dzguid,DISCIPLE_STATE_TYPE.eBeiBu)then
return
end
return dzInfo
end

function eventEmergenciesControl:addDZ(id,dzguid)
local dzInfo=self:getDZ(dzguid)
if not dzInfo then return false end


if self.dzLookup==nil then self.dzLookup={}end
if self.dzList==nil then self.dzList={}end
if self.dzLookup[id]==nil then self.dzLookup[id]={}end
if self.dzList[id]==nil then self.dzList[id]={}end

local dzLookup=self.dzLookup[id]
local dzList=self.dzList[id]
local dzguidStr=tostring(dzguid)
if dzLookup[dzguidStr]then return end
dzList[#dzList+1]=dzguid
dzLookup[dzguidStr]=true

self:log('轮询列表增加弟子:{0}',UIDiscipleModel:getDiscipleName(dzguid))


self:addLocalData(id,dzguid)

return true
end

function eventEmergenciesControl:dequeueDZ(id,idx,remove)
if self.dzLookup==nil then self.dzLookup={}end
if self.dzList==nil then self.dzList={}end
if self.dzLookup[id]==nil then self.dzLookup[id]={}end
if self.dzList[id]==nil then self.dzList[id]={}end

local dzLookup=self.dzLookup[id]
local dzList=self.dzList[id]
local dzguid=dzList[idx]
if dzguid==nil then return end

if remove then
local dzguidStr=tostring(dzguid)
dzLookup[dzguidStr]=nil
table.remove(dzList,idx)
self:removeLocalData(id,dzguid)
end
if not UIDiscipleModel:isZMDisciple(dzguid)then return end
self:log('筛选出触发事件弟子:{0} 序号：{1}',tostring(UIDiscipleModel:getDiscipleName(dzguid)),idx)
return dzguid
end

function eventEmergenciesControl:delDZ(id,dzguid)
if self.dzLookup==nil then self.dzLookup={}end
if self.dzList==nil then self.dzList={}end
if self.dzLookup[id]==nil then self.dzLookup[id]={}end
if self.dzList[id]==nil then self.dzList[id]={}end

local dzLookup=self.dzLookup[id]
local dzList=self.dzList[id]

local dzguidStr=tostring(dzguid)
if not dzLookup[dzguidStr]then return end
dzLookup[dzguidStr]=nil
for i,v in ipairs(dzList)do
if dzguidStr==tostring(v)then
table.remove(dzList,i)
break
end
end
self:removeLocalData(dzguid)
self:log('删除弟子:{0}  列表弟子数量：{1}',tostring(UIDiscipleModel:getDiscipleName(dzguid)))
end

function eventEmergenciesControl:initDZList(id)
if self:hasDZInCache(id)then return end

local dzlist=UIDiscipleModel:getAllDiscipleDataX()
local hasdz=dzlist~=nil
if not hasdz then return end

if self.readDzList and self.readDzList[id]then
local readDzList=self.readDzList[id]
for k,dzguidStr in pairs(readDzList)do
local dzguid=int64.new(dzguidStr)
self:addDZ(id,dzguid)
end
self.readDzList[id]=nil
else
for k,v in pairs(dzlist)do
local dzguid=v.netData.net.discipleguid
self:addDZ(id,dzguid)
end
end
self:freshLocalFile(true)
end




function eventEmergenciesControl:addLocalData(id,dzguid)
if self.localDzList==nil then self.localDzList={}end
if self.localDzLookup==nil then self.localDzLookup={}end
if self.localDzList[id]==nil then self.localDzList[id]={}end
if self.localDzLookup[id]==nil then self.localDzLookup[id]={}end

local list=self.localDzList[id]
local lookup=self.localDzLookup[id]
local dzguidStr=tostring(dzguid)
if lookup[dzguidStr]then return end
lookup[dzguidStr]=true
list[#list+1]=dzguidStr
self.localChanged=true
end

function eventEmergenciesControl:removeLocalData(id,dzguid)
if self.localDzList==nil then self.localDzList={}end
if self.localDzLookup==nil then self.localDzLookup={}end
if self.localDzList[id]==nil then self.localDzList[id]={}end
if self.localDzLookup[id]==nil then self.localDzLookup[id]={}end

local localDzList=self.localDzList[id]
local localDzLookup=self.localDzLookup[id]
local dzguidStr=tostring(dzguid)
if localDzLookup[dzguidStr]==nil then return end
localDzLookup[dzguidStr]=nil
for i,v in ipairs(localDzList)do
if v==dzguidStr then
table.remove(localDzList,i)
break
end
end
self.localChanged=true
self:freshLocalFile(true)
end

function eventEmergenciesControl:readLocalData()
self.readDzList={}

local readDzList=self.readDzList

local array=eventControl.getLocalVal(_storekey)or{}

for id,list in ipairs(array)do
if readDzList[id]==nil then readDzList[id]={}end
local dzlist=readDzList[id]
for i,v in ipairs(list)do
dzlist[#dzlist+1]=v
end
end
end

function eventEmergenciesControl:freshLocalFile(canDelay)
if not self.localChanged then return end
self.localChanged=false
eventControl.freshLocalVal(_storekey,self.localDzList,canDelay)
end

function eventEmergenciesControl:clearLocalFile()
eventControl.freshLocalVal(_storekey,nil,true)
end


function eventEmergenciesControl:log(content,...)
loggerUtil:printFMT('突发事件',content,...)
end

