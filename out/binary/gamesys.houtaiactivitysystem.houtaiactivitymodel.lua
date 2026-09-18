






local _MODULENAME="houtaiActivityModel"
local _readFlagKey="WangYeTiaoZhuanHasRead"

def_table(_MODULENAME)
houtaiActivityModel.name=_MODULENAME
houtaiActivityModel.data={
jump_url="",
begin_time=nil,
end_time=nil,
begin_time_str=nil,
end_time_str=nil,
hasRead=false,
}

local WEB_ACTIVITY_READ_KEY="WebActivityHasRead"

function houtaiActivityModel:isWebActivityRead()
if not userActorSetting or not userActorSetting.get then
return false
end
local ok,v=pcall(userActorSetting.get,WEB_ACTIVITY_READ_KEY,"0")
if not ok then
return false
end
return tostring(v)=="1"
end

function houtaiActivityModel:setWebActivityRead()
if userActorSetting then
userActorSetting.set(WEB_ACTIVITY_READ_KEY,"1")
userActorSetting.flush()
end
self.data.hasRead=true
end


function houtaiActivityModel:onAppStart()
end


function houtaiActivityModel:onEnterState(isReconnect)
self.data=self.data or{}
self.data.hasRead=self:isWebActivityRead()
end


function houtaiActivityModel:onProtocolReq()

end


function houtaiActivityModel:onLeaveState(isReconnect)
self.data.jump_url=""
self.data.begin_time=nil
self.data.end_time=nil
self.data.begin_time_str=nil
self.data.end_time_str=nil
end



