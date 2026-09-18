






local _MODULENAME="courtroomController"




gameState.addListener(def_table(_MODULENAME))
courtroomController.name=_MODULENAME


courtroomController.data={}



function courtroomController:onAppStart()

courtroomModel:onAppStart()


socketManager:register_receiver(3,176,courtroomController.recv_3_176)














end


function courtroomController:onEnterState()
courtroomModel:onEnterState()
notifySystem:listenNotify(notifyConfig.onDisciplePosChange,self.on_pos_change)
notifySystem:listenNotify(notifyConfig.onDiscipleRemove,self.on_disciple_remove)
end


function courtroomController:onServerDataInitFinish()
courtroomModel:onServerDataInitFinish()
end


function courtroomController:onLeaveState()
courtroomModel:onLeaveState()
notifySystem:removelistener(notifyConfig.onDisciplePosChange,self.on_pos_change)
notifySystem:removelistener(notifyConfig.onDiscipleRemove,self.on_disciple_remove)

self.data={}
end


function courtroomController:onLostConnection()

end

function courtroomController.on_pos_change(guid,old,pos)
local selectedGuid=courtroomModel:getSelectGuid()or""
if pos==eZongMenPostType.eZhangMen and tostring(selectedGuid)==tostring(guid)then

courtroomModel:setSelectGuid()
end
end

function courtroomController.on_disciple_remove(type,guid)
local select=courtroomModel:getSelectGuid()
if select and tostring(select)==tostring(guid)then
courtroomModel:setSelectGuid(nil)
end
end









function courtroomController.recv_3_176(guid,spetype,speid,res,randtalentid)
if res==0 then

UIManager:invokeUIMethod('UICourtroomGameWin','onForgetFinish')
courtroomModel:setSelectGuid()
elseif res==1 then
UIManager.error('无戒律长老')
elseif res==2 then
UIManager.error('戒律长老境界不足')
elseif res==3 then
UIManager.error('消耗不足')
end
end

function courtroomController.req_3_176(guid,spetype,speid)
socketManager:send_3_176(guid,spetype,speid)
end







function courtroomController:testSaveConfig(id)
if deviceHelper.isRunEditor()then
UIManager:invokeUIMethod('UICourtroomGameWin','testSaveId',id)
end
end

function courtroomController:testReadConfig(id)
if deviceHelper.isRunEditor()then
UIManager:invokeUIMethod('UICourtroomGameWin','loadId',id)
end
end


