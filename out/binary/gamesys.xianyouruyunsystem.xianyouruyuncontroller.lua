






local _MODULENAME="xianYouRuYunController"



xianYouRuYunController=gameState.addListener({})
xianYouRuYunController.data={}

function xianYouRuYunController:onAppStart()

xianYouRuYunModel:onAppStart()


socketManager:register_receiver(2,171,xianYouRuYunController.recv_2_171)
socketManager:register_receiver(2,172,xianYouRuYunController.recv_2_172)
socketManager:register_receiver(2,173,xianYouRuYunController.recv_2_173)














end


function xianYouRuYunController:onEnterState(isReconnect)
xianYouRuYunModel:onEnterState()
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
notifySystem:listenNotify(notifyConfig.onDiscipleCreate,self.on_change_catch_type)
notifySystem:listenNotify(notifyConfig.onDiscipleNewID,self.on_change_catch_type)
notifySystem:listenNotify(notifyConfig.onDiscipleTianMingLvChange,self.on_change_catch_type)
end


function xianYouRuYunController:onProtocolReq()
xianYouRuYunModel:onProtocolReq()
end


function xianYouRuYunController:onLeaveState(isReconnect)
xianYouRuYunModel:onLeaveState(isReconnect)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)

if self.enterGuid then
enterManager:removeEnter(self.enterGuid)
self.enterGuid=nil
end

self.data={}
end


function xianYouRuYunController:onLostConnection()

end


function xianYouRuYunController:onReConnection(isInitPro)

end






function xianYouRuYunController.recv_2_171(len,list)
xianYouRuYunModel:initTaskProgressDatas(len,list)
xianYouRuYunController.on_change_catch_type()
end



function xianYouRuYunController.recv_2_172(len,list)
if len>0 then
for k,taskid in ipairs(list)do
xianYouRuYunModel:setTaskIsRecv(taskid)
xianYouRuYunModel:refreshNewTask(taskid)
end
UIManager:invokeUIMethod('UiXianYouRuYun','refreshWin')
xianYouRuYunController.on_change_catch_type()
end
end



function xianYouRuYunController.recv_2_173(info)
xianYouRuYunController.on_change_catch_type()
end

function xianYouRuYunController:reqReceive()
local list=xianYouRuYunModel:getCanRecvTaskLists()

if list and next(list)then
socketManager:send_2_172(#list,list)
end
end




function xianYouRuYunController:checkEnter()
if not systemModel.isOpen(SYSTEM_DEFINE.eXianYouRuYun)then

return false
end
local isShowEnter=xianYouRuYunController:isEnterCanShow()


self:freshEnter(isShowEnter)


notifySystem:postNotify(notifyConfig.onXianYouRuYunOpenChange,isShowEnter)


xianYouRuYunController.on_change_catch_type()
end

function xianYouRuYunController:isEnterCanShow()
if not systemModel.isOpen(SYSTEM_DEFINE.eXianYouRuYun)then

return false
end
local isShowEnter=false



return isShowEnter
end

function xianYouRuYunController:freshEnter(flag)

if verifyManager:isHideBusinessActivity()then
return false
end
if activitiesController:isAddSysTab(SUB_ACTIVITY_TYPE.eXianYouRuYun_sys)then
flag=false
end
if flag then
if not self.enterGuid then
self.enterGuid=enterManager:freshEnter({id=1,enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eTianMingZengLi})
end
else
self:removeEnter()
end
end


function xianYouRuYunController:removeEnter()
if not self.enterGuid then return end
enterManager:freshFunc('onClose',ENTER_TYPE.eTianMingZengLi)
local ret=enterManager:removeEnter(self.enterGuid)
self.enterGuid=nil
if ret then
UIManager:callWindowFunc('UIMainEntryWin','freshInfo')
end
end


function xianYouRuYunController:on_change_catch_type()
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eXianYouRuYun_sys)
end

function xianYouRuYunController.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eXianYouRuYun then
xianYouRuYunController:checkEnter()
end
end