






appLifecycleMgr={}
local _ApplicationLifecycleList={}
local _ApplicationLifecycle_boot_list={}

function appLifecycle(o)

o=o or{}



_ApplicationLifecycleList[#_ApplicationLifecycleList+1]=o
_ApplicationLifecycle_boot_list[#_ApplicationLifecycle_boot_list+1]=o
return o
end

function appLifecycleMgr:init()
LuaApplication.register(appLifecycleMgr)
end

function appLifecycleMgr:onAppStart()

for i,v in ipairs(_ApplicationLifecycle_boot_list)do
local fn=v.onAppStart
if fn~=nil then

fn(v)
else



end
end
_ApplicationLifecycle_boot_list={}
end

function appLifecycleMgr:onAppPause()

for i,v in ipairs(_ApplicationLifecycleList)do
local fn=v.onAppPause
if fn~=nil then

fn(v)
end
end
end

function appLifecycleMgr:onAppResume()

for i,v in ipairs(_ApplicationLifecycleList)do
local fn=v.onAppResume
if fn~=nil then

fn(v)
end
end
end

function appLifecycleMgr:onAppQuit()

local c=#_ApplicationLifecycleList
for i=c,1,-1 do
local v=_ApplicationLifecycleList[i]
local fn=v.onAppQuit
if fn~=nil then

fn(v)
else



end
end
end


