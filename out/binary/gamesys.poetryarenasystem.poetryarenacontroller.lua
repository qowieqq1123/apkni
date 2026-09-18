






local _MODULENAME="poetryArenaController"

gameState.addListener(def_table(_MODULENAME))
poetryArenaController.name=_MODULENAME

poetryArenaController.cdTimer={}

function poetryArenaController:onAppStart()

poetryArenaModel:onAppStart()


socketManager:register_receiver(248,41,self.recv_248_41)
socketManager:register_receiver(248,42,self.recv_248_42)
socketManager:register_receiver(248,43,self.recv_248_43)
socketManager:register_receiver(248,44,self.recv_248_44)
socketManager:register_receiver(248,45,self.recv_248_45)

notifySystem:listenNotify(notifyConfig.onClickObjectInWorld,self.onClickEntity)
notifySystem:listenNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
notifySystem:listenNotify(notifyConfig.onLimitActOpen,self.onLimitActOpen)
notifySystem:listenNotify(notifyConfig.onWorldBlockDataInited,self.onWorldBlockDataInited)
notifySystem:listenNotify(notifyConfig.onWorldBlockDataChanged,self.onWorldBlockDataChanged)
notifySystem:listenNotify(notifyConfig.onWorldPositionReRandom,self.onWorldPositionReRandom)

worldController:registerSceneState(1,1,function()
self:onWorldEnter(worldModel.world)
end)
end


function poetryArenaController:onEnterState(isReconnect)
poetryArenaModel:onEnterState()
end


function poetryArenaController:onProtocolReq()
local list=poetryArenaModel:getCorrectSend()
for i,v in ipairs(list)do
local arenaCfg=cfgHelper.get1(cfg_wendouleitaiconfig_get,v[5])
if v[2]>arenaCfg.tmNum then
poetryArenaController.send_248_45(v[1])
else
poetryArenaController.send_248_42(v[1],v[2],v[3],v[4])
end
end
poetryArenaModel:clearCorrectSend()
end


function poetryArenaController:onLeaveState(isReconnect)
poetryArenaModel:onLeaveState(isReconnect)


self:clearWaitStart()
if not isReconnect then
timeEventController.removeNormalTimerHandler(1,self.name)
self.updating=false
end
end


function poetryArenaController:onLostConnection()

end


function poetryArenaController:onReConnection(isInitPro)

end



function poetryArenaController.send_248_41()
socketManager:send_248_41()
end


function poetryArenaController.send_248_42(guid,tIndex,conghui,startTime,disciple)
local arena=poetryArenaModel:getArenaData(guid)
if conghui<=0 then
conghui=UIDiscipleModel:getDiscipleBaseAttr(disciple or arena.disciple,DISCIPLE_BASE_ATTR_TYPE.eCongHui)
arena.conghui=conghui
arena.duration=poetryArenaModel.calculateDuation(conghui)
end
arena.started=true
if arena.question and arena.question.index~=tIndex then
arena.question.intoNext=true
end
socketManager:send_248_42(guid,tIndex,conghui,startTime)
end


function poetryArenaController.send_248_43(guid,tIndex,answer,startTime)
socketManager:send_248_43(guid,tIndex,answer,timeHelper.getServerShortTime())
end


function poetryArenaController.send_248_44(guid,disciple)
socketManager:send_248_44(guid,disciple)
end


function poetryArenaController.send_248_45(guid)
socketManager:send_248_45(guid)
end




function poetryArenaController.recv_248_41(len,list)

if worldController:isInWorld()then
poetryArenaController:deleteWorldEntity(worldModel.world)
end

poetryArenaModel:setArenaList(list)

if initProControl.isDone()then
local list=poetryArenaModel:getCorrectSend()
for i,v in ipairs(list)do
poetryArenaController.send_248_42(v[1],v[2],v[3],v[4])
end
poetryArenaModel:clearCorrectSend()
end

poetryArenaController:checkStartUpdate()

if worldController:isInWorld()then
poetryArenaController:onWorldEnter(worldModel.world)
end

UIManager:invokeUIMethod("UIPoetryArenaWin","refreshView")
UIManager:callWindowFunc("UIWeekUnitListWin","refreshList",LIMIT_ACT_TYPE.eWenDouLeiTai)
UIManager:invokeUIMethod('UILimitActStorageWin','refreshCondShow',LIMIT_ACT_TYPE.eWenDouLeiTai)
end




function poetryArenaController.recv_248_42(guid,data)

poetryArenaModel:setArenaQuestion(guid,data,true)

poetryArenaController:checkStartUpdate(guid)

UIManager:invokeUIMethod("UIPoetryArenaWin","onEnterQuestion",guid)
if data.tmIndex<=1 then
UIManager:callWindowFunc("UIWeekUnitListWin","refreshItem",LIMIT_ACT_TYPE.eWenDouLeiTai,guid)
end
end





function poetryArenaController.recv_248_43(guid,data,rightNum)

poetryArenaModel:setArenaQuestion(guid,data,false)
poetryArenaModel:setArenaRight(guid,rightNum)

poetryArenaController:checkDeleteArena(guid)

poetryArenaController:checkStopUpdate()

UIManager:invokeUIMethod("UIPoetryArenaWin","onSelectQuestion",guid)
local arena=poetryArenaModel:getArenaData(guid)
if not arena.valid then
UIManager:callWindowFunc("UIWeekUnitListWin","refreshList",LIMIT_ACT_TYPE.eWenDouLeiTai)
UIManager:invokeUIMethod('UILimitActStorageWin','refreshCondShow',LIMIT_ACT_TYPE.eWenDouLeiTai)
end
end




function poetryArenaController.recv_248_44(guid,disciple)
poetryArenaModel:setArenaDisciple(guid,disciple)

UIManager:invokeUIMethod("UIPoetryArenaWin","onRefreshDisciple",guid)
end




function poetryArenaController.recv_248_45(guid,percent)
poetryArenaModel:setArenaPercent(guid,percent)
poetryArenaController:checkDeleteArena(guid)

UIManager:invokeUIMethod("UIPoetryArenaWin","onFinishQuestion",guid)
end


function poetryArenaController:onNormalUpdate()
local arenas=poetryArenaModel:getAllArenas()
local baseCfg=cfgHelper.get1(cfg_wendouleitaibaseconfig_get,1)
local wait=baseCfg.nextWait
local now=timeHelper.getServerShortTime()
for i,v in pairs(arenas)do
if v.valid and v.question then
local totalNum=cfgHelper.get2(cfg_wendouleitaiconfig_get,v.id,"tmNum")
local question=v.question
local select=question.select
local index=question.index
local answer=question.answer
local sTime=question.startTime
local duration=v.duration
local interval=now-sTime

if index==totalNum then
local overTime=interval>=duration and select==nil
if answer>0 or overTime then
if v.percent==nil then
poetryArenaController.send_248_45(v.guid)
end

v.valid=false
poetryArenaController:checkDeleteArena(v.guid)


UIManager:callWindowFunc("UIWeekUnitListWin","refreshList",LIMIT_ACT_TYPE.eWenDouLeiTai)
UIManager:invokeUIMethod('UILimitActStorageWin','refreshCondShow',LIMIT_ACT_TYPE.eWenDouLeiTai)
end
else

local checkTime=answer==0 and(duration+wait)or wait
if interval>=checkTime and(select==nil or answer>0)then

if not v.question.intoNext then
self.send_248_42(v.guid,v.question.index+1,v.conghui,sTime+checkTime)
end
end
end
end
end

self:checkStopUpdate()
end

function poetryArenaController:checkStartUpdate(guid)
if not self.updating then
local check=false
if guid then
local arenaData=poetryArenaModel:getArenaData(guid)
if arenaData.valid and arenaData.question then
check=true
end
else
local arenas=poetryArenaModel:getAllArenas()
for i,v in pairs(arenas)do
if v.valid and v.question then
check=true
break
end
end
end
if check then
timeEventController.addNormalTimerHandler(1,self.name,self)
self.updating=true
end
end
end

function poetryArenaController:checkStopUpdate()
if self.updating then
local check=true
local arenas=poetryArenaModel:getAllArenas()
for i,v in pairs(arenas)do
if v.valid and v.question then
check=false
break
end
end

if check then

timeEventController.removeNormalTimerHandler(1,self.name)
self.updating=false
end
end
end

function poetryArenaController:countDownStart(pGuid,pDisciple,pConghui)
local guid=pGuid
local disciple=pDisciple
local conghui=pConghui
local effect=cfgHelper.get3(cfg_wendouleitaibaseconfig_get,1,"effect0",1)
local delay=cfgHelper.get2(cfg_effectconfig_get,effect,"lifetime")or 1000
delay=delay/1000
local t=timer.new()
t:start(delay,function()
UIManager:invokeUIMethod("UIPoetryArenaWin","fadeQuestion",guid)
poetryArenaController.send_248_44(guid,disciple)
poetryArenaController.send_248_42(guid,1,conghui,timeHelper.getServerShortTime(),disciple)
end,1)
table.insert(self.cdTimer,t)
end

function poetryArenaController:clearWaitStart()
for i,v in ipairs(self.cdTimer)do
v:cancel()
end
self.cdTimer={}
end
