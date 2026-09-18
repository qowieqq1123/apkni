





eventYouLiControl=gameState.addListener({})
eventYouLiControl.name="eventYouLiControl"
eventYouLiControl.mainType=EVENT_TYPE.eNomal
eventYouLiControl.subType=EVENT_NORMAL_SUB_TYPE.eDiziYouli
eventYouLiControl.data={}



function eventYouLiControl:onAppStart()
socketManager:register_receiver(11,24,self.recv_11_24)

end

function eventYouLiControl:onEnterState()
if next(self.data)then
timeEventController.addNormalTimerHandler(1,eventYouLiControl.name,eventYouLiControl)
end
end

function eventYouLiControl:onLeaveState(isReconnet)
if not isReconnet then
self.data={}
end
timeEventController.removeNormalTimerHandler(1,eventYouLiControl.name)
end

function eventYouLiControl:onProtocolReq()

if next(self.data)then
local cur=timeHelper.getServerShortTime()
local temp={}
for world,time in pairs(self.data)do
if time<=cur then
table.insert(temp,world)
end
end
for i,v in ipairs(temp)do
self.data[v]=cur+i
end
timeEventController.addNormalTimerHandler(1,self.name,self)
else
timeEventController.removeNormalTimerHandler(1,self.name)
end
end

function eventYouLiControl:onSystemInit()
if systemModel.isOpen(SYSTEM_DEFINE.eTravel)then
self.systemOpen=true
end
end

function eventYouLiControl.onSystemOpen(sysid)
if sysid==SYSTEM_DEFINE.eTravel then
self.systemOpen=true
end
end

function eventYouLiControl.recv_11_24(len,travelList)
eventYouLiControl.data={}
if len>0 then
for i,v in ipairs(travelList)do
eventYouLiControl.data[v.param_1]=v.param_2
end
end

if initProControl.isDone()then
eventYouLiControl:onProtocolReq()
end
end

function eventYouLiControl:triggerEvent(world,timeStamp)

local duration=chuanSongZhenModel:getMaxDuration(world)
local limit=cfgHelper.getdef(cfg_worldtravelconfig,"maxstore")

if duration<=limit then
local disciple=chuanSongZhenModel:extractDisciple(world)

if disciple then
local triggerArray=self:createTriggerInfo(world,disciple,timeStamp)
if triggerArray then



eventTriggerContorl:enQueue(triggerArray)
end
else



end
else

end

self:deleteTime(world)
end

function eventYouLiControl:triggerEventImp(world,disciple,timeStamp)
local triggerArray=self:createTriggerInfo(world,disciple,timeStamp)

if triggerArray then
eventTriggerContorl:enQueue(triggerArray)
end
end

function eventYouLiControl:createTriggerInfo(world,discipleguid,timeStamp)
local mainType=self.mainType
local subType=self.subType
local triggerId=world
local paramList=self:creatParamList(discipleguid)
timeStamp=timeHelper.getServerLongTime()
return eventTriggerModel.creatClientTriggerData(mainType,subType,triggerId,paramList,nil,timeStamp)
end

function eventYouLiControl:onNormalUpdate(delay)
if not systemModel.isOpen(SYSTEM_DEFINE.eTravel)then return end
local current=timeHelper.getServerShortTime()
for i,v in pairs(self.data)do
if current>=v then
self:triggerEvent(i,v)




end
end
end

function eventYouLiControl:addTime(world,timeStamp)
self.data[world]=timeStamp
if next(self.data)then
timeEventController.addNormalTimerHandler(1,self.name,self)
else
timeEventController.removeNormalTimerHandler(1,self.name)
end
end

function eventYouLiControl:deleteTime(world)
self.data[world]=nil
if next(self.data)then
timeEventController.addNormalTimerHandler(1,self.name,self)
else
timeEventController.removeNormalTimerHandler(1,self.name)
end
end

function eventYouLiControl:creatParamList(diziguid)
return{diziguid}
end

function eventxiulianControl:getDiziID(paramList)
return paramList and paramList[1]
end

function eventYouLiControl:handleParamListToTxt(paramList)
if paramList==nil then
return
end
local temp={}
local diziguid=paramList[1]
local diziInfo=UIDiscipleModel:getDiscipleData(diziguid)
if not diziInfo then
return
end
local name=diziInfo.disciplename
temp.dizi1={diziguid=diziguid,diziname=name}
return temp
end
