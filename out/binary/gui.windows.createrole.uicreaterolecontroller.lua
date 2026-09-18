







UICreateRoleController=gameState.addListener({})


eCreareRoleCode=
{
OK=0,
SQL_ERROR=-1,
USER_NOT_LOGGED_IN=-2,
GAME_SERVICE_NOT_READY=-3,
CHARACTER_SAVE_EXCEPTION=-4,
CLIENT_CHARACTER_SELECTION_ERROR=-5,
DUPLICATE_CHARACTER_NAME=-6,
CHARACTER_NOT_FOUND=-7,
INVALID_GENDER=-8,
RANDOM_NAME_EXHAUSTED=-9,
INVALID_CHARACTER_FACTION=-10,
INVALID_CHARACTER_CLASS=-11,
INVALID_NAME=-12,
NAME_REQUIRES_CHINESE=-13,
LOGGED_IN_OTHER_SERVER=-14,
MAX_CHARACTER_LIMIT_EXCEEDED=-15,
NAME_TOO_SHORT=-16,
NAME_TOO_LONG=-17,
CHARACTER_BANNED=-18,
ACCOUNT_LOGIN_LIMIT_EXCEEDED=-19
}


function UICreateRoleController:onAppStart()
socketManager:register_receiver(255,4,UICreateRoleController.do_protocol_255_4)
socketManager:register_receiver(255,2,UICreateRoleController.do_protocol_255_2)
socketManager:register_receiver(254,16,UICreateRoleController.do_protocol_254_16)
socketManager:register_receiver(254,17,UICreateRoleController.do_protocol_254_17)
end

function UICreateRoleController:onEnterState()

end

function UICreateRoleController:onLeaveState()
UICreateRoleController.autoSwitchServer=false
end


function UICreateRoleController:requreRoleList(_server_id)







socketManager:send_255_4(_server_id)
end

function UICreateRoleController:requreRandomName(sexID)
socketManager:send_254_16(sexID)
end


function UICreateRoleController:requireCreateRole(data)
local info=
{
name=data.name,
sex=data.sexID,
icon=data.sexID,
level=1,
fight=0,
}
UICreateRoleModel:setCacheRoleData(info)
socketManager:send_255_2(data.name,data.sexID,data.icon,data.pf,data.serverid)

end


function UICreateRoleController:requireChangeDefaultRoleName(name,sexID)
UICreateRoleModel:setCacheRoleDataEx(name,sexID)
socketManager:send_254_17(name,sexID)
end



function UICreateRoleController:requreEnterGame(_role,_time,isReconneting)
local udid=appUtils.getSimIMEI()
socketManager:send_255_5(_role,_time,loginModel:getPfid(),udid,isReconneting)
end


function UICreateRoleController:startGame()
local info=UICreateRoleModel:getRoleInfo()
local roleid=info.id
local roleid_int32=tonumber(tostring(info.id))
local time_str=uint64.new(os.time())
userActorSetting.init(tostring(roleid))
userActorSetting.flushVal('actorid',roleid_int32,0)
userActorArraySetting.init(tostring(roleid))
UICreateRoleController:requreEnterGame(roleid,time_str,0)

fightReport.initReportName()
end

function UICreateRoleController:backToLogin()
UICreateRoleController.autoSwitchServer=false
UICreateRoleController:stopBeginVideo()
if LuaApplication.state==loginState then
socketManager:Disconnect()
loginControl:showLoginWin()
reconnectState:stop()
else
LuaApplication.changeState(loginState)
end
end

function UICreateRoleController:createRole(sexID,name)
local data={}
data.name=name
data.sexID=sexID
data.icon=0
data.pf=loginModel:getPfid()
data.serverid=loginModel.server_id or 0
self:requireCreateRole(data)
end

function UICreateRoleController:createTempRole()
UICreateRoleController:createRole(0,"")
end

function UICreateRoleController:playBeginVideo()


if UICreateRoleController.autoSwitchServer or webGLHelper:isRunWebGL()or webGLHelper:isRunDouYinNative()or verifyManager:SkipUIGameBeginVideoWin()then
UICreateRoleController.autoSwitchServer=false
UICreateRoleController:createTempRole()
else
logPoint.UploadLog(logPoint.logExtType.openVideo)
UIManager:callWindowFunc('UIGameBeginVideoWin','play')
end
end

function UICreateRoleController:showBeginVideo()

UIManager:showWindow('UIGameBeginVideoWin')
end

function UICreateRoleController:closeBeginVideo()
UIManager:closeWindow('UIGameBeginVideoWin')
end

function UICreateRoleController:stopBeginVideo()
UIManager:callWindowFunc('UIGameBeginVideoWin','stopPlay')
end

function UICreateRoleController:closeUICreateRoleView()
UIManager:closeWindow('UICreateRoleWin')
end

function UICreateRoleController:showUICreateRoleView()
UIManager:showWindow('UICreateRoleWin')
end


function UICreateRoleController.do_protocol_255_4(account_id,role_num,roleArray)




local info=nil
if role_num>=0 then
UICreateRoleModel:InitData(roleArray or{})

info=UICreateRoleModel:getRoleInfo()
local hasRole=UICreateRoleModel:HasRole()
if hasRole then
if UICreateRoleModel:checkZhuXiao()then
loginControl:showZhuXiaoDialogue()
elseif reconnectState.isReconneting then
reconnectState:reconnectSuccess()
return
else
if logPoint.record then
logPoint.record('hasRole',true)
end
userGlobalSetting.set('hasRole',true)
UICreateRoleController:startGame()
UIManager.info("正在前往三千世界")
end

else
UICreateRoleController:playBeginVideo()
end
else
local s=UICreateRoleModel.getCreateRoleError(role_num)
if s~=nil then
UIManager.info(s)
end
end
loginControl:reportEnterServer(info)
end



function UICreateRoleController.do_protocol_255_2(role_id,result_code,createtime)

UICreateRoleController.autoSwitchServer=false
if result_code==eCreareRoleCode.OK then
local roleInfo=UICreateRoleModel:onCreateRole(role_id,createtime)
if roleInfo and roleInfo.name==''then
gameUtilityControl.setPlayerCreateTime(createtime)
UICreateRoleController:startGame()
if pfwindowslController:Report_255_2_PF()then
loginControl:reportCreateRole(roleInfo)
end
webGLHelper:reportByCreateRole()
logPoint.UploadLog(logPoint.logType.createRole_clickCreatRole)
if logPoint.record then
logPoint.record('hasRole',true)
end
else


end

else

if result_code==eCreareRoleCode.ACCOUNT_LOGIN_LIMIT_EXCEEDED then
UICreateRoleController.autoSwitchServerEnterGame()
else

local showdata=
{
type='UIDialougeHighest',
title="提示",
content=FMT.fmt('服务器创角异常[{0}],请返回登录界面',result_code),
oktext="返回登录",
allowclickBG='false',
okcallback=function(...)
UICreateRoleController:backToLogin()
end,

showclosebtn=false,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end
pfCommonHelper.CreateRoleError()
end

end





function UICreateRoleController.autoSwitchServerEnterGame()
UICreateRoleController.autoSwitchServer=true
local serverId=loginModel.server_id

if socketManager.connecting then
socketManager:Disconnect()
end




platformSDK.printSDK(FMT.fmt('自动切换服务器{0}',serverId))
local askSwitchServerCall=function(ok)

if not ok then
UICreateRoleController:backToLogin()
end
end

local showdata=
{
type='UIDialougeHighest',
title='提示',
content='服务器爆满，是否切换成其他服务器',
oktext='确定',
canceltext='返回登录',
allowclickBG='false',
okcallback=function(...)
platformSDK.printSDK(FMT.fmt('切换服务器',serverId))
loginControl:askSwitchCurServer(serverId,askSwitchServerCall,false,"重试失败，返回登录界面")
end,
cancelcallback=function(...)
platformSDK.printSDK(FMT.fmt('返回登录界面',serverId))
UICreateRoleController.autoSwitchServer=false
UICreateRoleController:backToLogin()
end,
showclosebtn=false,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end



function UICreateRoleController.do_protocol_254_16(result_code,_name)
if result_code==0 then
UIManager:invokeUIMethod('UICreateRoleWin','updateRandomName',_name)
else

end
end


function UICreateRoleController.do_protocol_254_17(result_code)
if result_code==0 then
local name,sex=UICreateRoleModel:onChangedRole()

playerModel:setActorName(name)
playerModel:setActorSex(sex)
UIManager:invokeUIMethod("UICreateRoleWin","checkClose")

notifySystem:postNotify(notifyConfig.onActorNameChange)
pfCommonHelper.changeRoleNamePoint()
pfCommonHelper.createRole(name)
else
local s=UICreateRoleModel.getCreateRoleError(result_code)
if s~=nil then
UIManager.info(s)
end
end
end

