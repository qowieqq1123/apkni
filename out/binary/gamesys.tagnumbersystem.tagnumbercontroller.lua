






local _MODULENAME="tagNumberController"

gameState.addListener(def_table(_MODULENAME))
tagNumberController.name=_MODULENAME



local _class_list={}


local _catch_list={}


local _listen_event={}


local _number_cache={}


local _dirty_queue={}

local _interval_num=10


function tagNumberController:onAppStart()
notifySystem:listenNotify(notifyConfig.onTaskChange,self.onTaskChange)
end


function tagNumberController:onEnterState(isReconnect)

end


function tagNumberController:onProtocolReq()

end


function tagNumberController:onLeaveState(isReconnect)
_listen_event={}
_number_cache={}
_dirty_queue={}
self:stopQuickTimer()
end


function tagNumberController:onLostConnection()

end


function tagNumberController:onReConnection(isInitPro)

end



function tagNumberController:startQuickTimer()
if#_dirty_queue>0 and not self.timerRunning then
timeEventController.addQuickTimerHandler(_MODULENAME,self)
self.timerRunning=true
end
end

function tagNumberController:onQuickUpdate(quickTimerDelay)
local num=math.min(#_dirty_queue,_interval_num)
for i=1,num do
local handleTpye=table.remove(_dirty_queue,1)
local class=_class_list[handleTpye]
local events=_listen_event[handleTpye]
if class and events then
local cache=_number_cache[handleTpye]
local current=class.refresh()
if cache~=current then
for idx,func in ipairs(events)do
func(handleTpye,current,cache)
end
end
end
end
self:stopQuickTimer()
end

function tagNumberController:stopQuickTimer()
if#_dirty_queue<=0 and self.timerRunning then
timeEventController.removeQuickTimerHandler(_MODULENAME,self)
self.timerRunning=false
end
end

function tagNumberController:register_class(class)
if class==nil then return end
local handleTpye=class.handle_type
if _class_list[handleTpye]then return end
_class_list[handleTpye]=class
for index,catchType in ipairs(class.catch_list)do
local temp=_catch_list[catchType]
if temp==nil then
temp={}
end
if not table.containsValue(temp,handleTpye)then
table.insert(temp,handleTpye)
end
_catch_list[catchType]=temp
end
end

function tagNumberController:listen_callback(handleTpye,func)
local temp=_listen_event[handleTpye]
if temp==nil then
temp={}
end
if not table.containsValue(temp,func)then
table.insert(temp,func)
end
_listen_event[handleTpye]=temp
end

function tagNumberController:unlisten_callback(handleTpye,func)
local temp=_listen_event[handleTpye]
if temp==nil then return end
local index=table.findValue(temp,func)
if index then
table.remove(temp,index)
end
end

function tagNumberController:on_catch_type(catchType)
local temp=_catch_list[catchType]
if temp==nil then return end
for index,handleTpye in ipairs(temp)do
local class=_class_list[handleTpye]
local events=_listen_event[handleTpye]
if class and events then
if not table.containsValue(_dirty_queue,handleTpye)then
table.insert(_dirty_queue,handleTpye)
end
end
end
self:startQuickTimer()
end

function tagNumberController:getTagNumber(handleTpye)
local class=_class_list[handleTpye]
if class==nil then return end
local current=class.refresh()
_number_cache[handleTpye]=current
return current
end

function tagNumberController.onTaskChange(taskid,taskstate)
if taskstate==taskModel.taskAcceptState then
local cfg=taskModel:getTaskConfig(taskid)
if cfg.showInMenu~=false and cfg.tasklineid~=taskModel.lineMain then
tagNumberController:on_catch_type(TagNumberCatchType.eBatchTaskAccept,taskid)
end
elseif taskstate==taskModel.taskFinishState then
local cfg=taskModel:getTaskConfig(taskid)
if cfg.showInMenu~=false and cfg.tasklineid~=taskModel.lineMain then
tagNumberController:on_catch_type(TagNumberCatchType.eBatchTaskFinish,taskid)
end
end
end


