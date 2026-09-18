







loginModel={}
local _appConfig_GetInt=CS.AppDataModel.AppConfig_GetInt
local _appConfig_GetString=CS.AppDataModel.AppConfig_GetString
require'lua.platformSDK.platformSDK'

loginModel.matchStr='%{(%Z*)%}%{(%Z*)%}%{(%Z*)%}%{(%Z*)%}%{(%Z*)%}'

function loginModel:init()

self.username=''
self.userid=-1
self.password=''

self.server_ip_string=''
self.sever_name=''
loginModel:setCurServer_id(0)
loginModel:setBeforeServer_id(nil)
self.server_ip=''
self.server_port=0
self.sever_statue=0

self.isLogin=false
self:resetLoginInfo()
self.otherLogin=false
self.isDelAccount=false
self.pfid=nil

platformSDK.printSDK('清空登陆数据')
end


function loginModel:setOtherLogin(flag)
self.otherLogin=flag
end

function loginModel:isOtherLogin()
return self.otherLogin or false
end

function loginModel:setUserId(userid)
self.userid=userid
userGlobalSetting.record('userid',userid,0)
end

function loginModel:setUserName(username)
self.username=username
userGlobalSetting.record('username',username,'')
end

function loginModel:setSelectServer_ip(server_ip_string)
self.server_ip_string=server_ip_string
userGlobalSetting.record('server_ip',server_ip_string,'')
end

function loginModel:setUserPassword(password)
self.password=password
userGlobalSetting.record('password',password,'')
end

function loginModel:checkSwitchCurrentPfid(pfid,callback)
if pfid and pfid~=''and pfid~=0 then
loginModel:saveOrigonPHP_Cfg()
self.pfid=tonumber(pfid)
gameInfo.getGameId=function()
return self.pfid or _appConfig_GetString('gameId','')
end
gameInfo.isInit=nil
gameInfo:init(callback)
else
if callback then
callback(false)
end
end
end


function loginModel:selectSever(name,sid,ip,port,statue)
self.sever_name=tostring(name or'')
loginModel:setCurServer_id(tonumber(sid or 0))
if deviceHelper.isRunEditor()then
local _,before_sid=string.match(self.sever_name,"(公共服)(%d+)")
loginModel:setBeforeServer_id(tonumber(before_sid)or tonumber(sid or 0))
else
loginModel:setBeforeServer_id(tonumber(sid or 0))
end
self.server_ip=tostring(ip or'')
self.server_port=tonumber(port or 0)
self.sever_statue=tonumber(statue or 0)
local server_ip_string=string.format('{%s}{%d}{%s}{%d}{%d}',self.sever_name,self.server_id,self.server_ip,self.server_port,self.sever_statue)
self:setSelectServer_ip(server_ip_string)

loginControl.logined=nil
end


function loginModel:onLogin(info,sdkParams,userid)
if deviceHelper.isRunNoneOrEditor()then return end
loginModel:init()
self.isLogin=true
loginModel:setUserId(tostring(userid))
CS.GameInterface.SetBuglyUserID(loginModel.userid)

loginModel:setLoginSDKInfo(info)
loginModel:setSDKParam(sdkParams)
local pfid=gameInfo:getGameId()
local newPfid=info.pfid and pfid~=info.pfid or false

local callback=function(flag)
if newPfid then
loggerUtil.logFMT('切换平台{0}到{1}',pfid,info.pfid)
end
loginModel:replaceOrigonGameInfoArgs()
logPoint.UploadLog(logPoint.logType.sdkLoginComplete)
loginControl:requestLastServerList()
loginModel:applyZoneCache(flag~=false)
if not loginModel:hasServerZoneInfo()then
loginControl:requestZoneServerInfo()
end
if not webGLHelper:is_MiniGame()then
platformSDK.printSDK("requestPHPCfg1")
loginModel:requestPHPCfg()
end
end
loginModel:checkSwitchCurrentPfid(info.pfid,callback)
end


function loginModel:saveOrigonPHP_Cfg()
if self.gamePhpCfg==nil then
self.gamePhpCfg=table.weakCopy(gameInfo.phpCfg)
end
end



function loginModel:replaceOrigonGameInfoArgs()
if self.gamePhpCfg==nil then return end
local gamePhpCfg=gameInfo.phpCfg
local lastGameInfo=self.gamePhpCfg
gamePhpCfg.cdnURL=lastGameInfo.cdnURL
gamePhpCfg.cdnVersionURL=lastGameInfo.cdnVersionURL
gamePhpCfg.cdnVersion=lastGameInfo.cdnVersion
end



function loginModel:requestPHPCfg(callBack)
platformSDK.printSDK("requestPHPCfg2")
houtaiController:requestOptions(callBack)
end



function loginModel:requestPHPCfg_Pre(callBack)
platformSDK.printSDK("requestPHPCfg2")
houtaiController:requestOptions_Pre(callBack)
end




function loginModel:onfreshLoginInfo(info,sdkParams,userid)
if deviceHelper.isRunNoneOrEditor()then return end
if not self.isLogin then return false end
loginModel:setLoginSDKInfo(info)
loginModel:setSDKParam(sdkParams)
loginModel:setUserId(tostring(userid))
end

function loginModel:logout(logoutSDK)
if logoutSDK==nil then logoutSDK=true end
loginModel:setOtherLogin(false)
if deviceHelper.isRunNoneOrEditor()or not logoutSDK then return end
loginModel:init()
end





function loginModel:getPfid()
if self.pfid then
return self.pfid
elseif appUtils.testPHP then
return tonumber(gameInfo:getPfid())or 0
elseif deviceHelper.isRunNoneOrEditor()then
local pfid=0



return pfid
else
return tonumber(gameInfo:getPfid())
end
end


function loginModel:getPfname()
if appUtils.testPHP then
return gameInfo:getPfname()
elseif deviceHelper.isRunNoneOrEditor()then
local pfname=''



return pfname
else
return gameInfo:getPfname()
end
end


function loginModel:getChannelID()
if appUtils.testPHP then
return gameInfo:getChannelID()
elseif deviceHelper.isRunNoneOrEditor()then
return''
else
return gameInfo:getChannelID()
end
end


function loginModel:getSpecialLoginWinParam()

local sStamp=nil

if not(deviceHelper.isRunNoneOrEditor()and not appUtils.testPHP)then
sStamp=gameInfo:getParams('timestamp')
end
if not sStamp then

platformSDK.printSDK('未获取到PHP下发的时间')
sStamp=os.time()
end

if sStamp and sStamp>0 then
local pfid=loginModel:getPfid()or 0
local specialParam=cfgHelper.get2(cfg_systemsetconfig_get,1,"specialLoginWinParam")
if specialParam and next(specialParam)then
for i,cfg in ipairs(specialParam)do
local startTimeStr=cfg.startTime
local endTimeStr=cfg.endTime
local startTimeStamp=timeHelper.dataToTimeStam(startTimeStr)
local endTimeStamp=timeHelper.dataToTimeStam(endTimeStr)
if sStamp>=startTimeStamp and sStamp<=endTimeStamp then

local isCanUsePF=false
if cfg.pfParam then
local limitType=cfg.pfParam.type
local limitList=cfg.pfParam.list
if limitType==1 then

if limitList[pfid]then
isCanUsePF=true
end
elseif limitType==2 then

if not limitList[pfid]then
isCanUsePF=true
end
end
else

isCanUsePF=true
end

if isCanUsePF then
return cfg
end
end
end
end
end
return nil
end



function loginModel:getPfDefaultLoginWinParam()
local pfid=loginModel:getPfid()or 0
local defaultParamList=cfgHelper.get2(cfg_systemsetconfig_get,1,"pfDefaultLoginWinParam")
if defaultParamList and next(defaultParamList)then
if defaultParamList[pfid]then
return defaultParamList[pfid]
end
end
return nil
end


local xqPfList={
[6789]=true,
[7382]=true,
[7581]=true,
[7590]=true,
[7964]=true,
[8048]=true,
[8051]=true,
[8199]=true,
}

function loginModel:checkIsXianQiang()
local pfid=loginModel:getPfid()or 0
return xqPfList[pfid]
end
