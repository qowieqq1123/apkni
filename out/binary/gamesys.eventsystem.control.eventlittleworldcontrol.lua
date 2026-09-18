





eventLittleWorldControl=gameState.addListener({})
eventLittleWorldControl.mainType=EVENT_TYPE.eNomal
eventLittleWorldControl.subType=EVENT_NORMAL_SUB_TYPE.eLittleWorld













function eventLittleWorldControl:onAppStart()
self:init()
socketManager:register_receiver(11,27,function(...)self:onRecvNextStamp(...)end)
end

function eventLittleWorldControl:onEnterState()

end

function eventLittleWorldControl:onProtocolReq()

self:startTimer()
end


function eventLittleWorldControl:onLeaveState()
self:init()
end

function eventLittleWorldControl:init()
self:stopTimer()
self.logWait=false

self.listNum=0

self.lastReqStamp=0
self.nextStamp=0
self.initStamp=nil
self.isRecvStamp=false
self.firstCricleFinish=false
self.isChange=false
end





function eventLittleWorldControl:onRecvNextStamp(shortStamp)
local stamp=timeHelper.convertLongStamp(shortStamp)
self.nextStamp=stamp
if self.initStamp==nil then
self.initStamp=stamp
local curStamp=timeHelper.getServerLongTime()
local minStamp=curStamp-self:getNextSpaceTime()
if self.initStamp<minStamp then
self.initStamp=minStamp
self.nextStamp=minStamp
loggerUtil.logWarnFMT('小世界事件下发时间戳太小：{0}',timeHelper.getFormatByStamp(stamp))
end
end
self.isRecvStamp=true

end




function eventLittleWorldControl:startTimer()
if self.ticktimer then return end
self.ticktimer=timer.new()
self.ticktimer:start(0.04,function()
self:update()
end)
end

function eventLittleWorldControl:stopTimer()
if self.ticktimer then
self.ticktimer:cancel()
end
self.ticktimer=nil
end

function eventLittleWorldControl:update()
if not systemModel.isOpen(SYSTEM_DEFINE.eSmallWorld)then return end
if not self.isRecvStamp then return end
self:logWaitTime()
self:dequeue()
end



function eventLittleWorldControl:freshNextStamp(stamp)
local space=self:getNextSpaceTime()
if space==nil then return end
local nextStamp=stamp+space

self.nextStamp=nextStamp
end

function eventLittleWorldControl:getNextSpaceTime()
local conf=eventConfig.getCommonConfig().smallworldconf
local space=conf[1]
return space
end



function eventLittleWorldControl:dequeue()
if not self.isRecvStamp then return end
self:triggerEvent()
self.firstCricleFinish=true
end


function eventLittleWorldControl:triggerEvent()
local stamp=timeHelper.getServerLongTime()
local nextStamp=self.nextStamp

if stamp<nextStamp then return end
local space=self:getNextSpaceTime()
if space==nil then return end
local lv=cfgHelper.get(cfg_smallworldconfig_get,1,"need_small_lv")
if LittleWorldModel:getLittleWorldLevel()<lv then
return
end
while stamp>=nextStamp do
if self.firstCricleFinish then break end
local triggerArray=self:createTriggerInfo(nextStamp)
if triggerArray then
eventTriggerContorl:enQueue(triggerArray)
nextStamp=nextStamp+space
self.nextStamp=nextStamp
end
end
end

function eventLittleWorldControl:createTriggerInfo(timeStamp)


local paramList=self:creatParamList()
local mainType=self.mainType
local subType=self.subType

return eventTriggerModel.creatClientTriggerData(mainType,subType,1,paramList,nil,timeStamp)
end

function eventLittleWorldControl:handleParamListToTxt(paramList)
local temp={}
return temp
end

function eventLittleWorldControl:creatParamList()
local dis_list=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eZhangMen)
local discipleguid=0
if dis_list==nil or not next(dis_list)then
local plot1=UIDiscipleModel:getRandomDiscipleData()
discipleguid=plot1.discipleguid
else
discipleguid=dis_list[1].discipleguid
end
return{discipleguid}
end


function eventLittleWorldControl:showInJianwenChannel(timeStamp,paramList)
return timeStamp and self.initStamp and timeStamp>=self.initStamp or false
end

function eventLittleWorldControl:log(...)

end


function eventLittleWorldControl:logWaitTime()












end
