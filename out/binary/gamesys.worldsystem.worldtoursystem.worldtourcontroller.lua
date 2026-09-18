






local _MODULENAME="worldTourController"




gameState.addListener(def_table(_MODULENAME))
worldTourController.name=_MODULENAME
worldTourController.data={}
local _this=worldTourController
local _ticks={}
local _tickTimer=nil

function worldTourController:onAppStart()

worldTourModel:onAppStart()













end


function worldTourController:onEnterState()
worldTourModel:onEnterState()
end


function worldTourController:onServerDataInitFinish()
worldTourModel:onServerDataInitFinish()
end


function worldTourController:onLeaveState()
worldTourModel:onLeaveState()

self.data={}
_ticks={}
_tickTimer=nil
end


function worldTourController:onLostConnection()
self:checkEndTick()
end

function worldTourController:onReConnection()
self:checkStartTick()
end


function worldTourController:send_5_71(tourID,disciple)
if worldTourModel:containData(tourID)then
logErr("游历点{0}已派遣，不能添加",tourID)
end
socketManager:send_5_71(tourID,disciple)
local dzList={disciple}
for i=1,4 do
table.insert(dzList,int64.zero)
end
worldTaskController:startMission(worldModel.UNITTYPE.TOURPOINT,int64.zero,tourID,dzList,0)
end

function worldTourController:send_5_72(tourIDs)





socketManager:send_5_72(#tourIDs,tourIDs)
for idx,tourID in ipairs(tourIDs)do
local unitKey=worldTourModel:getUnitKey(tourID)
local taskKey=worldTaskModel:findTaskKey_ByTarget(unitKey)
if taskKey then
worldTaskController:returnMission(taskKey)

end
end
end

function worldTourController.recv_5_71(tourID,disciple,tourData)
if tourData then
worldTourModel:addData(tourData)
_this:checkAddTicks({tourData})
UIManager.info(FMT.fmt("{0}开始游历",UIDiscipleModel:getDiscipleName(disciple)))
notifySystem:postNotify(notifyConfig.onTourCountChange,true,{tourID})
end
end

function worldTourController.recv_5_72(len,tourDatas)
if len and len>0 then
local results={}
local tourIDs={}
for i,v in ipairs(tourDatas)do
local tourID=v.param_1
local totalTime=v.param_2
local disciple=worldTourModel:getDisciple(tourID)
local rewards=worldTourModel:calculateReward(tourID,totalTime)
table.insert(results,{tourID,disciple,rewards})
table.insert(tourIDs,tourID)
worldTourModel:removeData(tourID)





end
_this:checkDeleteTicks(tourIDs)
notifySystem:postNotify(notifyConfig.onTourCountChange,false,tourIDs)

UIManager:showWindow("UIWorldTourRewardDialog",results)
end


end




















function worldTourController:onNormalUpdate(delta)
local nowTime=timeHelper.getServerShortTime()
local finishs={}
for i,v in pairs(_ticks)do
if nowTime>=v then
table.insert(finishs,i)
end
end
if#finishs>0 then
for i,v in ipairs(finishs)do
self:removeTickData(v)
end
notifySystem:postNotify(notifyConfig.onTourCompeleted,finishs)
end
self:checkEndTick()
end

function worldTourController:startTick()
timeEventController.addNormalTimerHandler(1,_MODULENAME,self)
_tickTimer=1
end

function worldTourController:endTick()
timeEventController.removeNormalTimerHandler(1,_MODULENAME)
_tickTimer=nil
end

function worldTourController:checkStartTick()
if _tickTimer==nil and next(_ticks)~=nil then
self:startTick()
end
end

function worldTourController:checkEndTick()
if next(_ticks)==nil then
self:endTick()
end
end

function worldTourController:addTickData(tourID,endTime)
_ticks[tourID]=math.max(_ticks[tourID]or 0,endTime)
end

function worldTourController:removeTickData(tourID)
_ticks[tourID]=nil
end

function worldTourController:checkAddTicks(tourDatas)
local nowTime=timeHelper.getServerShortTime()
local list=tourDatas or{}
for i,v in ipairs(list)do
if nowTime<v.endtime then
self:addTickData(v.travelpointid,v.endtime)
end
end
self:checkStartTick()
end

function worldTourController:checkDeleteTicks(tourIDs)
for i,v in ipairs(tourIDs)do
self:removeTickData(v)
end
self:checkEndTick()
end










