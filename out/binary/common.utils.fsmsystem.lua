







FSMSystem=simple_class()

function FSMSystem:__init()
self.state_dict={}
self.start_state=nil
self.cur_state=nil
self.next_frame_chg=false
self.target_state_id=-1
self.user_data=nil
self.is_stop=false;
end

function FSMSystem:GetCurState()
return self.cur_state
end

function FSMSystem:IsStop()
return self.is_stop
end

function FSMSystem:GetUserState()
return self.user_data
end

function FSMSystem:SetUserData(user_data)
self.user_data=user_data
end

function FSMSystem:SetNextFrameChg(value)
self.next_frame_chg=value
end

function FSMSystem:IsNextFrameChg()
return self.next_frame_chg
end

function FSMSystem:GetState(state_id)
return self.state_dict[state_id]
end

function FSMSystem:CreateState(state_id,state_name)
if self.state_dict[state_id]then
return
end

local handle_state=FSMState.New(self,state_id,state_name)
self.state_dict[state_id]=handle_state

if not self.start_state then
self.start_state=handle_state
end

return handle_state
end

function FSMSystem:RemoveState(state_id)
if not self.state_dict[state_id]then
return
end

local handle_state=self.state_dict[state_id]
self.state_dict[state_id]=nil

if self.start_state==handle_state then
self.start_state=nil
end

if self.cur_state==handle_state then
self.cur_state:DoQuitState()
self.cur_state=nil
end

end

function FSMSystem:Start(start_state_id)
self.is_stop=false

if start_state_id then
self.start_state=self.state_dict[start_state_id]or self.start_state
end

if self.start_state then
self.cur_state=self.start_state
self.start_state:DoStartState()
end
end

function FSMSystem:Stop()
self.is_stop=true

if self.cur_state then
self.cur_state:DoQuitState()
self.cur_state=nil
end
end

function FSMSystem:ChangeState(state_id,force)
if not self.cur_state then
return
end

if self.cur_state:GetStateID()==state_id then
return
end

if not self.state_dict[state_id]then
return
end

if not force and not self.cur_state:CanTrans(state_id)then
return
end

if self.next_frame_chg then
self.target_state_id=state_id
else
self.cur_state:DoQuitState()
self.cur_state=self.state_dict[state_id]
self.cur_state:DoStartState()
end
end

function FSMSystem:Update()
if self.is_stop then
return
end

if self.target_state_id~=-1 then
self.cur_state:DoQuitState()
self.cur_state=self.state_dict[self.target_state_id]
self.target_state_id=-1
self.cur_state:DoStartState()
end

if self.cur_state then
self.cur_state:DoUpdateState()
end
end
