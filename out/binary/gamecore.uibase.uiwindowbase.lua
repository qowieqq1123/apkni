






UIWindowBase=notifyListener.create(simple_class(UIWidget))

function UIWindowBase:__init(name,view,winlua,events,onStartCallback)
notifyListener.__init_notifyListener(self)
self.isVisible=true
self.__register=nil
self.__registerOgi=nil

self.__registerReddot=nil
self.__registerReddotOgi=nil

self.__protocolregister=nil
self.__protocolregisterOgi=nil

self.btlookup={}
end

function UIWindowBase:onHide_before()

end

function UIWindowBase:onHide()

end

function UIWindowBase:__delete(flag)
end

function UIWindowBase:close()
self:stopAllNotify()

if self.needClearCDUpdateFunc then
self.needClearCDUpdateFunc=nil
buildingCDControl:clearCDUpdateFunc(self.__name)
end

for _,bt in pairs(self.btlookup)do
behaviorManager:removeBehaviorTree(bt)
end
self.btlookup={}

self.winlua:Close()

self:closeAllWindow()
self:deleteSelf()
end

function UIWindowBase:stopAllNotify()
if self.__register then
for id,v in pairs(self.__register)do
for _,func in ipairs(v)do
notifySystem:removelistener(id,func)
end
end
end
self.__register=nil
self.__registerOgi=nil

if self.__protocolregister then
for sid,v in pairs(self.__protocolregister)do
for pid,func in ipairs(v)do
socketManager:removeNotify(sid,pid,func)
end
end
end
self.__protocolregister=nil
self.__protocolregisterOgi=nil

self:stopAllReddotNotify()
end

function UIWindowBase:stopAllReddotNotify()
if self.__registerReddot then
for k,v in pairs(self.__registerReddot)do
for _,func in ipairs(v)do
reddotClassManager.unregister_event(k,func)
end
end
end
self.__registerReddot=nil
self.__registerReddotOgi=nil
end

function UIWindowBase:show()

if self.isVisible then
self.winlua:Show()
else
self:setVisible(true)
end
end

function UIWindowBase:onShow()

end

function UIWindowBase:closeSelf()
if not self.__deleted__ then

self:closeAllWindow()
UIManager:closeWindow(self.__name)
end
end



function UIWindowBase:showWindow(name,...)
if self.__childWindow==nil then self.__childWindow={}end
self.__childWindow[name]=true
UIManager:showWindowImp(name,...)
end

function UIWindowBase:closeWindow(name)
UIManager:closeWindowImp(name)
if self.__childWindow~=nil then
self.__childWindow[name]=nil
end
end

function UIWindowBase:hideWindow(name)
UIManager:hideWindowImp(name)
if self.__childWindow~=nil then
self.__childWindow[name]=false
end
end

function UIWindowBase:hideAllWindow()
if self.__childWindow==nil then self.__childWindow={}end
for name,vis in pairs(self.__childWindow)do
UIManager:hideWindowImp(name)
self.__childWindow[name]=false
end
end

function UIWindowBase:closeAllWindow()
if self.__childWindow==nil then self.__childWindow={}end
for name,vis in pairs(self.__childWindow)do
UIManager:closeWindowImp(name)
end
self.__childWindow={}
end










function UIWindowBase:setVisible(flag)
if self.isVisible==flag then
return
end
self.isVisible=flag
self.winlua:SetVisible(flag)







end


function UIWindowBase:setTimer(delay,count,func)

if self._timer_lookup==nil then
self._timer_lookup={}
end
if not self.winlua then
return-1
end
local newfunc=function(...)
if not self or self.isClose then return end
func(...)
end

if count<0 then

end

local id=self.winlua:StartTimer(delay,count,newfunc)
self._timer_lookup[newfunc]=id
return id
end

function UIWindowBase:stopTimerByID(id)
if self.winlua and id>0 then
self.winlua:StopTimer(id)
end
end

function UIWindowBase:stopAllTimer()
if self._timer_lookup==nil then
self._timer_lookup={}
end
for func,v in pairs(self._timer_lookup)do
self._timer_lookup[func]=nil
if self.winlua then
self.winlua:StopTimer(v)
end
end
end


function UIWindowBase:delayDo(delay,func)
return self:setTimer(delay,1,func)
end

function UIWindowBase:stopTimerByName(tname)
local id=self[tname]
if id~=nil then
self:stopTimerByID(id)
self[tname]=nil
end
end

function UIWindowBase:pauseAllTimers()
if not UIManager:isCanPauseTimer(self.__name)then return end
if self.__isPause then return end
self.__isPause=true
self.winlua:PauseAllTimer()
end

function UIWindowBase:continueAllTimers()
if not UIManager:isCanPauseTimer(self.__name)then return end
if not self.__isPause then return end
self.__isPause=nil
self.winlua:ContinueAllTimer()
end


function UIWindowBase:bindComponents()

end

function UIWindowBase:setParentCanvas(canvasIdx)
if canvasIdx then
UIManager:setCanvas(self.gameObject,canvasIdx)
self.canvasIdx=canvasIdx
end
end

function UIWindowBase:setAsLastSibling()
self.gameObject.transform:SetAsLastSibling()
end

function UIWindowBase:setAsFirstSibling()
self.gameObject.transform:SetAsFirstSibling()
end


function UIWindowBase:onReConnection()

end

function UIWindowBase:onReConnectionEx()
self:continueAllTimers()
self:onReConnection()
end


function UIWindowBase:onLostConnection()

end

function UIWindowBase:onLostConnectionEx()
self:pauseAllTimers()
self:onLostConnection()
end

function UIWindowBase:addProNotify(sid,pid,func)
if self.__protocolregister==nil then self.__protocolregister={}end
if self.__protocolregister[sid]==nil then self.__protocolregister[sid]={}end
if self.__protocolregister[sid][pid]==nil then self.__protocolregister[sid][pid]={}end
if self.__protocolregisterOgi==nil then self.__protocolregisterOgi={}end
if self.__protocolregisterOgi[sid]==nil then self.__protocolregisterOgi[sid]={}end
if self.__protocolregisterOgi[sid][pid]==nil then self.__protocolregisterOgi[sid][pid]={}end
local t1=self.__protocolregisterOgi[sid][pid]
if t1[func]==true then return end
t1[func]=true

local t=self.__protocolregister[sid][pid]
local newfunc=function(...)
if not self or self.isClose or self.__isPause then return end
func(...)
end
t[#t+1]=newfunc
socketManager:addNotify(sid,pid,newfunc)
end

function UIWindowBase:addNotify(id,func)
if self.__register==nil then self.__register={}end
if self.__register[id]==nil then self.__register[id]={}end
if self.__registerOgi==nil then self.__registerOgi={}end
if self.__registerOgi[id]==nil then self.__registerOgi[id]={}end
local t1=self.__registerOgi[id]
if t1[func]==true then return end
t1[func]=true

local t=self.__register[id]
local newfunc=function(...)
if not self or self.isClose or self.__isPause then return end
func(...)
end
t[#t+1]=newfunc
notifySystem:listenNotify(id,newfunc)
end

function UIWindowBase:addReddotNotify(id,func)
if self.__registerReddot==nil then self.__registerReddot={}end
if self.__registerReddot[id]==nil then self.__registerReddot[id]={}end
if self.__registerReddotOgi==nil then self.__registerReddotOgi={}end
if self.__registerReddotOgi[id]==nil then self.__registerReddotOgi[id]={}end
local t1=self.__registerReddotOgi[id]
if t1[func]==true then return end
t1[func]=true

local t=self.__registerReddot[id]
local newfunc=function(...)
if not self or self.isClose or self.__isPause then return end
func(...)
end
t[#t+1]=newfunc
reddotClassManager.register_event(id,newfunc)
end

function UIWindowBase:addCDUpdateFunc(key,func)
buildingCDControl:addCDUpdateFunc(self.__name,key,func)
self.needClearCDUpdateFunc=true
end

function UIWindowBase:removeCDUpdateFunc(key)
buildingCDControl:removeCDUpdateFunc(self.__name,key)
end

function UIWindowBase:addBehaviorTree(...)
local bt=behaviorManager:addBehaviorTree(...)
local uid=bt.uid
self.btlookup[uid]=bt
end

function UIWindowBase:removeBehaviorTree(bt)
if bt==nil then return end
behaviorManager:removeBehaviorTree(bt)
self.btlookup[bt.uid]=nil
end


function UIWindowBase:printWinArgs(winName)
local args=UIManager:getArgs(winName)
if args then
if args.act_id and args.sub_act_type and args.sub_act_id then
logErr("活动信息：活动id，子活动类型，子活动id",args.act_id,args.sub_act_type,args.sub_act_id)
local actCfg=activitiesModel:getSubActivityConfig(args.sub_act_type,args.sub_act_id)or defaultT
logErr("活动配置：",serializeHelper.serialize(actCfg))
local actInfo=activitiesModel:getSubActInfo(args.act_id,args.sub_act_type,args.sub_act_id)or defaultT
logErr("活动数据：")
for key,val in pairs(actInfo)do
if type(val)~='function'and type(val)~='table'then
logErr(key,serializeHelper.serialize(val))
end
end
return
end
end

logErr("此界面暂无参数打印",winName)
end
