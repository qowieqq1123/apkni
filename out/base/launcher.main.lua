

local _require=require
local _s_lower=string.lower
local _s_gsub=string.gsub
require=function(name)
return _require(_s_lower(_s_gsub(name,'/','.')))
end

require'tolua.launcher.enum'

_WXInterface=CS.WXInterface

_mono_debug_table={}


inputSystem={}
invokeSystem={}
newbieManager={}
socketManagerLogFilter={}

LuaApplication={
pre_state=nil,
state=nil,
current_level='loading',
LEVEL_DISABLE_REENTER=
{
loading=true
},
LEVELS=
{
main=0,
firstInstall=1,
loading=2,
login=3,
game=4,
home=5,
loadscene=6
},
}


local _error=error
function error(msg)

_error(msg or'')
end
require'tolua.base.logger'






local enableLuaProfiler=CS.AppDataModel.GetOptionBool('option.LuaConst.enableProfiler')
if enableLuaProfiler then

local platformStr=CS.GameInterface.GetRuntimePlatformStr()
local platform=CS.AppDataModel.AppConfig_GetString('platformSDK','platformSDK_None')

if platform=='platformSDK_None'or
platformStr=='WindowsEditor'or
platformStr=='OSXEditor'then
local profiler=require'tolua.UnityEngine.profiler'
profiler:start()
end







end








local versioninfo=require'tolua.version'






















Int64_0=int64.new(0)
GameObject=UnityEngine.GameObject
Vector3=UnityEngine.Vector3
Vector2=UnityEngine.Vector2
Mathf=UnityEngine.Mathf
PrimitiveType=UnityEngine.PrimitiveType
Time=UnityEngine.Time
os_clock=os.clock
os.clock=nil



local _Application=UnityEngine.Application
Application=nil
UnityEngine.Application=nil
local _Screen=UnityEngine.Screen
local ApplicationInterface=CS.ApplicationInterface

local _msg_handle=CS.MessageInterface
local _msg_type=GlobalEventType
local GC_STEP_DELAY=30
local _app_event={}
local onDownloadGroupProgressCallback=nil
local onPerformanceLevelChangeCallback=nil









function LuaApplication.start()


math.randomseed(os.time())
require'tolua.launcher.simple_class'

require'tolua.launcher.androidTool'
require'tolua.launcher.deviceHelper'
if deviceHelper.isRunWebGL()then
require'tolua.platformCode.platformCode_WebGL'
end
require'tolua.launcher.updateState.__init'
require'tolua.util.__init'
require'tolua.launcher.logPoint'
require'tolua.launcher.gameInfo'
require'tolua.launcher.platformLogPoint.__init'

logPoint.checkHasRole()





















_msg_handle.AddEventListener(_msg_type.ONLEVEL_WAS_LOADED,LuaApplication.OnLevelWasLoaded)
LuaApplication.changeState(updateState)
ApplicationInterface.SetEventHandleTable('LuaApplication');
logPoint.UploadLogAppStart()

local isFirstInstall=CS.AppDataModel.GetOpenAppCount();
if isFirstInstall==1 then

end

local stats=GameObject.Find("Stats Monitor")
if stats then
stats:SetActive(false)
end
end

function LuaApplication.changeState(state,mode,...)
assert(state)
LuaApplication._changeState(state,mode,...)
end

function LuaApplication._changeState(state,mode,...)

local oldstate=LuaApplication.state
if oldstate==state then return end
LuaApplication.pre_state=oldstate
LuaApplication.state=state

if oldstate then
oldstate:leave(state)
LuaApplication.gc_collect()
end
if state then
state:enter(mode,...)
end
end

function LuaApplication.RefreshGameState()
local curState=LuaApplication.state
if curState then
curState:leave()
LuaApplication.gc_collect()
curState:enter()
end
end

function LuaApplication.OnLevelWasLoaded(args)

local level=args[1]
local name=LuaApplication.state.name
LuaApplication.gc_collect()
if LuaApplication.state and LuaApplication.state.OnLevelWasLoaded then
LuaApplication.state.OnLevelWasLoaded(level)
end
end

function LuaApplication.GetApplication()
return _Application
end



function LuaApplication.LoadLevel(levelname)
if LuaApplication.current_level==levelname and LuaApplication.LEVEL_DISABLE_REENTER[levelname]then

end

LuaApplication.current_level=levelname
LuaApplication.gc_collect()
_msg_handle.SendMessageDelay(_msg_type.LOAD_LEVEL,levelname);
end


function LuaApplication.reload_lua_script()
reload("common/reload_lua_script")
end

function LuaApplication.register(appevent)







_app_event[#_app_event+1]=appevent
end


function LuaApplication.gc_collect()
collectgarbage("collect")

end

function LuaApplication.gc_step()

collectgarbage("step")

end

function LuaApplication.startGCTimer(...)

if LuaApplication.gc_timer~=nil then
return
end
LuaApplication.gc_timer=timer.new()
LuaApplication.gc_timer:start(GC_STEP_DELAY,LuaApplication.gc_collect)
end

local function test(...)

local i=0
local p=''
for i=1,1000,1 do
local a='a'..'b'..'c'
p=a
p=CS.GamePath.writablePath

end

end


function Main()

































LuaApplication.versioninfo=versioninfo
LuaApplication.SetRightBottomText(versioninfo)



end

function LuaApplication.SetRightBottomText(text)

local o=GameObject.Find('GUI_ROOT');
local textComp=CS.UIHelper.FindText(o,'Canvas_SysTip/VersionText')
if textComp then
textComp.text=text
end
end




function LuaApplication.onAppStart(...)

LuaApplication.start()
end

function LuaApplication.onAppPause()


for i,v in ipairs(_app_event)do
v:onAppPause()
end
LuaApplication.gc_collect()
end

function LuaApplication.onAppResume()


for i,v in ipairs(_app_event)do
v:onAppResume()
end
end

function LuaApplication.onQuitApplication()

LuaApplication._changeState(nil)

for i,v in ipairs(_app_event)do

v:onAppQuit()
end















end

function LuaApplication.onDownloadGroupProgress(groupID,bytesDownloaded)

if onDownloadGroupProgressCallback then
onDownloadGroupProgressCallback(groupID,bytesDownloaded)
end
end



function LuaApplication.SetOnDownloadGroupProgress(callback)

onDownloadGroupProgressCallback=callback
end



function LuaApplication.onPerformanceLevelChange(fps)
if onPerformanceLevelChangeCallback then
onPerformanceLevelChangeCallback(fps)
end
end

function LuaApplication.SetOnPerformanceLevelChange(callback)
onPerformanceLevelChangeCallback=callback
end



function LuaApplication.QuitGame()
_Application.Quit();
end


function LuaApplication.GetNetworkReachability()
return _Application.internetReachability;
end


function LuaApplication.GetApplicationPlatform()
return _Application.platform
end


function LuaApplication.GetDeviceWidthHeigth()
return _Screen.width,_Screen.height
end

local _GetVersionJsonByKey=CS.AppDataModel.GetVersionJsonByKey;
local _API_LEVEL='API_LEVEL';

function LuaApplication.GetAPILevel()
return _GetVersionJsonByKey(_API_LEVEL,0);
end








