







FSMState=simple_class()

function FSMState:__init(parent,state_id,state_name)
self.state_name=state_name
self.state_id=state_id
self.parent=parent

self.trans_list={}

self.EnterCallback=nil
self.UpdateCallback=nil
self.QuitCallback=nil

self.UserData=nil
end

function FSMState:GetStateName()
return self.state_name
end

function FSMState:GetStateID()
return self.state_id
end

function FSMState:AddTransLink(link_id)
table.insert(self.trans_list,link_id)
end

function FSMState:CanTrans(link_id)
for key,value in ipairs(self.trans_list)do
if link_id==value then
return true
end
end

return false
end

function FSMState:DoStartState()
if self.EnterCallback then
self.EnterCallback(self.state_id)
end
end

function FSMState:DoUpdateState()
if self.UpdateCallback then
self.UpdateCallback(self.state_id)
end
end

function FSMState:DoQuitState()
if self.QuitCallback then
self.QuitCallback(self.state_id)
end
end

