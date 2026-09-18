worldDispatchTask=simple_class()
worldDispatchTask.name="worldDispatchTask"






























function worldDispatchTask:start(time)


self.show=true

if worldModel:isSameWorld(self.world)and self.corners==nil then
self:path()

end

local progress,pass=self:check(time)

if progress.state~=self.progress_state then
self:jumpTo(progress,pass)













else
self.expression[self.progress_state]:start(pass)
end
end


function worldDispatchTask:back()
if self.progress_state>=eWorldTripProgress.Back then
return
end
local now=timeHelper.getServerShortTime()
local progress={
state=eWorldTripProgress.Back,
beginTime=now,
endTime=now+self.trip_duration,
}
self:jumpTo(progress,now,0)
end

function worldDispatchTask:jumpTo(progress,time,pass)
local firstState=self.progress_state

for i=self.progress_state+1,progress.state do
local oState=self.progress_state
local aim=i==progress.state
self.progress_state=i
self.progress_begin=aim and progress.beginTime or time
self.progress_end=aim and progress.endTime or time

self:onProgressChange(self.progress_state,oState)

self:inactive(oState)

local expression=self.expression and self.expression[self.progress_state]or nil
local duration=expression and expression:getDuration()or 0
local pass=aim and pass or duration
self:active(pass)

if self.progress_state<eWorldTripProgress.End then
self:save()
if firstState<eWorldTripProgress.Back and self.progress_state>=eWorldTripProgress.Back then

return
end
else
if firstState>=eWorldTripProgress.Back then
self:cancel()
return
else
loggerUtil.logErrFMT("非回程状态执行删除派遣！！")
end
end
end
end


function worldDispatchTask:quit()

self:inactive()
self.show=false
end


function worldDispatchTask:cancel()
self:inactive()
self.state=eWorldTripState.Pause
worldTaskController:send_5_84(self.id)
end


function worldDispatchTask:save()
self.state=eWorldTripState.Pause
worldTaskController:send_5_83(self)
end

function worldDispatchTask:correct()

end





function worldDispatchTask:check(time)
local fast=time-self.progress_begin
for i=self.progress_state,eWorldTripProgress.Back do
local expression=self.expression[i]
if expression then
local over,pass=expression:checkOver(fast)

if not over then
local duration=expression:getDuration()
local tBegin=time-pass
local tEnd=duration>=0 and(tBegin+duration)or 0
local progress={
state=i,
beginTime=tBegin,
endTime=tEnd,
}
return progress,pass
else
fast=pass
end
end
end

local progress={
state=eWorldTripProgress.End,
beginTime=time-fast,
endTime=0,
}
return progress,fast
end


function worldDispatchTask:express()
self.expression={}
end

function worldDispatchTask:onProgressChange(cState,oState)

end


function worldDispatchTask:path()
self.corners=worldDispatchFactory:getPathCorners(self.mode,self.destination,nil,self.world)
self.move_duration=worldDispatchFactory:getDuration(self.mode,self.corners,self.speed)
self.trip_duration=worldDispatchFactory:getTripDuration(self.mode,self.move_duration,#self.disciples)
end


function worldDispatchTask:init()
self.progress_state=eWorldTripProgress.Go
self.progress_begin=timeHelper.getServerShortTime()
self.progress_end=self.progress_begin
self:onProgressChange(self.progress_state)
end


function worldDispatchTask:update(time)

if self.progress_end>0 and self.progress_end>=self.progress_begin and time>=self.progress_end then
if self.expression then
local progress,pass=self:check(time)
if progress.state~=self.progress_state then

self:jumpTo(progress,time,pass)
end
end
end
end

function worldDispatchTask:active(fast)
if self.show and self.expression then
local expression=self.expression[self.progress_state]
if expression then
expression:start(fast)
end
end
end

function worldDispatchTask:inactive(state)
if self.show and self.expression then
local expression=self.expression[state or self.progress_state]
if expression then
expression:quit()
end
end
end



function worldDispatchTask:refreshDisclples()
self.disciples={}
for i,v in ipairs(self.team)do
if v>int64.zero and UIDiscipleModel:getDiscipleData(v)then
table.insert(self.disciples,v)
end
end
table.sort(self.disciples,function(a,b)
local fa=UIDiscipleModel:getDiscipleFightValue(a)
local fb=UIDiscipleModel:getDiscipleFightValue(b)
return fa>fb
end)
end


function worldDispatchTask:appendDisciples(disciples)
if#self.disciples+#disciples>worldTaskModel.maxDisciple then
loggerUtil.logErrFMT("派遣{0}（{1}）追加{2}个弟子失败(超出上)",self.id,#self.disciples,#disciples)
return false
end

for i,v in ipairs(disciples)do
if table.containsValueEx(self.disciples,v,function(value)return tostring(value)end)then
loggerUtil.logErrFMT("派遣{0}已存在弟子{1}",self.id,tostring(v))
break
end

local job=UIDiscipleModel:getDiscipleJob(v)
local jobCfg=cfgHelper.get1(cfg_disciplevocationconfig_get,job)
local pospriorty=jobCfg.pospriorty
if pospriorty then
for j,w in ipairs(pospriorty)do
if self.team[w]==int64.zero then
self.team[w]=v
break
end
end
else
for j,w in ipairs(self.team)do
if w==int64.zero then
self.team[j]=v
break
end
end
end
end

self:refreshDisclples()


self:onDiscipleChange(#disciples)

notifySystem:postNotify(notifyConfig.onMissionDiscipleChanged,self.id,#disciples)

self:save()

return true
end


function worldDispatchTask:subtractDisciples(disciples)
local check=false
for i,v in ipairs(disciples)do
for j,w in ipairs(self.team)do
if w==v then
self.team[j]=int64.zero
check=true
break
end
end
end

if check then
self:refreshDisclples()


notifySystem:postNotify(notifyConfig.onMissionDiscipleChanged,self.id,-#disciples)

if#self.disciples<=0 then
self:cancel()
else
self:save()
self:onDiscipleChange(-#disciples)
end
end

return check
end


function worldDispatchTask:changeTeamPos(teamList)
local list={}
local count=0
local team={}
for i,v in ipairs(teamList)do
if v[1]==fightPreSelectModel.teamEntityType.dizi and mathHelper.validInt64(v[2])then
list[tostring(v[2])]=i
count=count+1
team[i]=v[2]
else
team[i]=int64.zero
end
end
if count~=#self.disciples then
return loggerUtil.logErrFMT("派遣弟子阵容改变信息无效（弟子数量[{0},{1}]）",count,#self.disciples)
end
for i,v in ipairs(self.disciples)do
local key=tostring(v)
if list[key]==nil then
return loggerUtil.logErrFMT("派遣弟子阵容改变信息无效（不存在弟子[{0}]）",key)
end
end
self.team=team
end

function worldDispatchTask:changeTeamForce(team)
local old=#self.disciples
self.team=team
self:refreshDisclples()


self:onDiscipleChange(#self.disciples-old)
end

function worldDispatchTask:onDiscipleChange(change)
if self.show and self.expression then
local expression=self.expression[self.progress_state]
if expression then
expression:onDiscipleChange(change)
end
end
end


function worldDispatchTask:getBattleTeam()
local list={}
for i,v in ipairs(self.team)do
if v>int64.zero then
table.insert(list,{fightPreSelectModel.teamEntityType.dizi,v})
else
table.insert(list,{fightPreSelectModel.teamEntityType.empty,int64.zero})
end
end
return list
end


function worldDispatchTask:containDisciple(discipleguid)
for i,v in ipairs(self.disciples)do
if mathHelper.compareInt64(discipleguid,v)then
return true
end
end
return false
end


function worldDispatchTask:isSameTeam(team)
for i,v in ipairs(team)do
if not mathHelper.compareInt64(v,self.team[i])then
return false
end
end
return true
end


function worldDispatchTask:checkTeam(team)
if self:isSameTeam(team)then
return 0
end
local disciples={}
for i,v in ipairs(team)do
if mathHelper.validInt64(v)then
table.insert(disciples,v)
end
end
if#disciples~=#self.disciples then
return-1
end
for i,v in ipairs(disciples)do
if not self:containDisciple(v)then
return-2
end
end
return 1
end

function worldDispatchTask:callExpressFunc(funcName,...)
if self.expression then
local expression=self.expression[self.progress_state]
if expression then
local func=expression[funcName]
if func then
func(expression,...)
end
end
end
end
