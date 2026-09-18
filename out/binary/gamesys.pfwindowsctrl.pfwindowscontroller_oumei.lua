local _AppConfig_GetString=CS.AppDataModel.AppConfig_GetString
local _httpGetRequest=CS.ResourceHelper.HttpGetRequest;
local _HttpPostJsonRequest=CS.ResourceHelper.HttpJsonPostRequest;
function pfwindowslController:onAppStart_oumei()

end

function pfwindowslController:onEnterState_oumei(isReconnect)

end


function pfwindowslController:onLeaveState_oumei(isReconnect)

end
local _cjson=require'cjson'


pfLocalZoneType=
{
EU=1,
NA=2,
}

local LocalZone

local _isMacPlayer=false

local ZoneName=
{
[pfLocalZoneType.EU]="EU",
[pfLocalZoneType.NA]="NA",
}


function pfwindowslController:getZoneNameCfg()
return ZoneName
end


local ZoneDesc=
{
[pfLocalZoneType.EU]="Selected region has high latency for your location. Still proceed with the change?\n\n Selected region time:%s",
[pfLocalZoneType.NA]="Selected region has high latency for your location. Still proceed with the change?\n\n Selected region time:%s",
}

function pfwindowslController:getZoneDescCfg()
return ZoneDesc
end


local ZoneTime=
{
[pfLocalZoneType.EU]="UTC+1",
[pfLocalZoneType.NA]="UTC-5",
}


function pfwindowslController:getZoneTimeCfg()
return ZoneTime
end


local switchZoneURL="https://gl-login.efunsea.com/activty/getContinentCode.shtml"




function pfwindowslController:checkBindAccountShow_oumei()
if self.data.isBindAccount then
return true
end
return false
end



function pfwindowslController:reqPhoneBind_OuMei()
platformSDK:reqPhoneBind()
end



function pfwindowslController:reqAccountBind_OuMei()
platformSDK:invoke("reqBindAccount")
end



local bindAccountGiftId=68

function pfwindowslController:getBindAccountGiftId_OM()
return bindAccountGiftId
end


function pfwindowslController:getEfunBindAccountState_OM()
if self.data.isBindAccount or self.data.isBindThirdPlatform then
return true
end
return false
end


function pfwindowslController:canReceiveBindPAccountGift_OM()
local pfOpen=pfwindowslController:checkPFWinState_ByCfg(pfwindowslController.winType.bindAccount)
local isBind=pfwindowslController:getEfunBindAccountState_OM()
return pfOpen and isBind and FreeGiftController.GetFreeGift(bindAccountGiftId)
end


function pfwindowslController:canVisiableBindAccount_OM()
if verifyManager:isOpen()then
return false
end
if pfCommonHelper:isRunPC()then
return false
end
local pfOpen=pfwindowslController:checkPFWinState_ByCfg(pfwindowslController.winType.bindAccount)

platformSDK.printSDK('[bindAccount] pfOpen  GetFreeGift',pfOpen,FreeGiftController.GetFreeGift(bindAccountGiftId))
return pfOpen and FreeGiftController.GetFreeGift(bindAccountGiftId)
end


local lastClickStamp

function pfwindowslController:checkBindAccountReddot_OM()
if not lastClickStamp then
lastClickStamp=userActorSetting.get("bindAccountClickTime",0)
end
local time=timeHelper.getServerLongTime()
local isSameDay=timeHelper.checkInSameDay(lastClickStamp,time)
return isSameDay
end



function pfwindowslController:receiveBindPhoneReward_OM()
platformSDK.printSDK('[bindAccount] enterManager:freshEnter',self.enterBindAccountGuid)
FreeGiftController.SendFreeGift(bindAccountGiftId,nil,function()
platformSDK.printSDK('[bindAccount] enterManager:freshEnterx',self.enterBindAccountGuid)
pfwindowslController:removeBindAccountEnter_OM()
end)
end

function pfwindowslController:checkBindAccountEnter_OM(needRemove)
platformSDK.printSDK('[bindAccount] checkBindPhoneEnter',self.enterBindAccountGuid)
if pfwindowslController:checkIsGameVersion_oumei()then
if verifyManager:isHideBindAccount()then
return
end
local isHasEnterGuidOriginal=self.enterBindAccountGuid~=nil
local isOpen=pfwindowslController:canVisiableBindAccount_OM()
local macPlayer=pfwindowslController.getMacPlayer()
local isShowEnter=false
if isOpen and macPlayer then

platformSDK.printSDK('[bindPhone] enterManager:freshEnter',self.enterBindAccountGuid)
self.enterBindAccountGuid=enterManager:freshEnter({id=1,enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eBindAccount,getReddotFun=function()
return pfwindowslController:checkBindAccountReddot_OM()
end})
isShowEnter=true
if isHasEnterGuidOriginal then

pfwindowslController:refreshBindAccountEnterReddot_OM()
end
end

if needRemove and not isShowEnter then
pfwindowslController:removeBindAccountEnter_OM()
end
end
end


function pfwindowslController:removeBindAccountEnter_OM()
if self.enterBindAccountGuid then

enterManager:freshFunc('onClose',ENTER_TYPE.eBindAccount)
platformSDK.printSDK('[bindAccount] enterManager:freshEnterxx',self.enterBindAccountGuid)
local ret=enterManager:removeEnter(self.enterBindAccountGuid)
self.enterBindAccountGuid=nil
if ret then

UIManager:callWindowFunc('UIMainEntryWin','freshInfo')
end
end
end


function pfwindowslController:refreshBindAccountEnterReddot_OM()
enterManager:freshFunc('freshReddot',ENTER_TYPE.eBindAccount)
end



function pfwindowslController:setBindAccount_OM(flag)
platformSDK.printSDK('[bindAccount] setBindAccount_OM',flag)
if flag then
self.data.isBindAccount=true
self.data.isBindThirdPlatform=true
pfwindowslController.setMacPlayer_OnBindAccount(false)
if pfwindowslController:canReceiveBindPAccountGift_OM()then
pfwindowslController:receiveBindPhoneReward_OM()
end

else

end
end


local TriggerAttLv=4

function pfwindowslController:TriggerAtt_OuMei()
if not pfwindowslController:checkIsGameVersion_oumei()then
return
end
local zmLv=zongmenModel:getLevel()or 1
if zmLv==TriggerAttLv and deviceHelper.isRunIOS()then
platformSDK:invoke("reqTriggerAtt","finishguide")
end
end



function pfwindowslController:checkHaoPingPopUP_OuMei_Role(dis_guid)
if not pfwindowslController:checkIsGameVersion_oumei()then

return
end
if verifyManager:isOpen()then
return
end

local haoPing=userActorSetting.get("haoPingYouLi",0)
if haoPing<3 then
haoPing=haoPing+1
if deviceHelper.isRunIOS()then
platformSDK:invoke("reqPingLun")
else
platformSDK:invoke("efunRequestReviewInApp")
end
userActorSetting.set("haoPingYouLi",haoPing)
end
end


function pfwindowslController:checkHaoPingPopUP_OuMei()
if verifyManager:isOpen()then
return
end
if deviceHelper.isRunIOS()then
platformSDK:invoke("reqPingLun")
else
platformSDK:invoke("efunRequestReviewInApp")
end
end



function pfwindowslController:getLocalZone()
return LocalZone
end


function pfwindowslController:setLocalZone(tempLocalZone)
LocalZone=tempLocalZone
userGlobalSetting.record('LocalZoneType',LocalZone,0)
end


function pfwindowslController:changeLocalZoneHandle(LocalZone)
local ZoneEnterInfo=pfwindowslController:getZoneEnterInfo()
local curZoneEnterInfo=ZoneEnterInfo[LocalZone]
platformSDK.printSDK("changeLocalZoneHandle,cd,",LocalZone)
if not curZoneEnterInfo then
UIManager.info("Zone Not Exist")
return
end
local infoURl=curZoneEnterInfo.infoUrl
local logUploadURL_Release=curZoneEnterInfo.logUploadURL_Release
local gameId=curZoneEnterInfo.gameId
pfwindowslController:reqInfo(infoURl,logUploadURL_Release,gameId)
end



function pfwindowslController:requestPHPCfg()
loginModel:setCurServer_id(0)
loginRoleControl.clearServerIdList()
loginModel:setRoleServerList(nil)
loginModel:replaceOrigonGameInfoArgs()
loginControl:requestLastServerList()
loginModel:applyZoneCache(true)
if not loginModel:hasServerZoneInfo()then
loginControl:requestZoneServerInfo()
end
loginModel:requestPHPCfg()
end



function pfwindowslController:reqInfo(infoURl,logUploadURL_Release,gameId)
local url=infoURl
local tag=deviceHelper.getRuntimePlatformTag()
local urlStr=url..'?channelid='..gameId..'&os='..tag
platformSDK.printSDK('Requesting entry info: ',urlStr)

local callback=nil
callback=function(message,err)
platformSDK.printSDK('Entry Info Callback: ',message,err)
if err==""or not err then
local json_table={}
local s,e=pcall(function()
json_table=_cjson.decode(message)
end)
if s then
if updateState.filterServer then
gameInfo:setPhpCfg(verifyData:getPFInfo())
else
gameInfo:setPhpCfg(json_table)
end

if self.initLocalZoneFinish then
local curZone=ZoneName[LocalZone]
UIManager.info(string.format("Switched to Region %s",curZone))
pfwindowslController:requestPHPCfg()
else
self.initLocalZoneFinish=true
if not loginModel.isLogin then
platformSDK:reqLogin()
end
end
else
platformSDK.printSDK('Failed to parse entry info: ',message)
UIUpdateDialog.ShowDialogBox('Note','Entry parsing failed; game cannot proceed',LuaApplication.QuitGame)
end
else
platformSDK.printSDK('Failed to request entry info: ',message,err)
UIUpdateDialog.ShowDialogBox('Note','Entry parsing failed; game cannot proceed',LuaApplication.QuitGame)
end
end
_httpGetRequest(urlStr,callback)
end


function pfwindowslController:initLocalZone()

pfwindowslController:onAppStart()
if pfwindowslController:checkIsGameVersion_oumei()then
if verifyManager:isOpen()then
LocalZone=pfLocalZoneType.EU
self.initLocalZoneFinish=true
return
end
if not deviceHelper.isRunNoneOrEditor()then
if not LocalZone then
LocalZone=userGlobalSetting.get('LocalZoneType',nil)
platformSDK.printSDK("initLocalZone,cd,",LocalZone)
end
self.initLocalZoneFinish=false
platformSDK.printSDK("initLocalZone,cdx,",LocalZone)
if not LocalZone then

pfwindowslController.reqZone_OM()
else
pfwindowslController:changeLocalZoneHandle(LocalZone)
end
platformSDK.printSDK("initLocalZone,cdxx,",LocalZone)
end
end
end

function pfwindowslController.reqZone_OM()
local requestHeader={
"Content-Type",
"application/json",
}
local jsonData={}
jsonData.gameCode="euzqzs"
local postData=_cjson.encode(jsonData)
platformSDK.printSDK("reqZone_OM,cd,",requestHeader,postData)
_HttpPostJsonRequest(switchZoneURL,requestHeader,postData,pfwindowslController.reqZoneCB_OM)
end

local ZoneMapping=
{
["Europe"]=pfLocalZoneType.EU,
["Americas"]=pfLocalZoneType.NA,
}

local playerFlag=
{
mac="mac",
}

function pfwindowslController.reqZoneCB_OM(content,err)
if err then
platformSDK.printSDK("reqZoneCB_OM,cd,err,",content,err)
return
end
local json=_cjson.decode(content)
platformSDK.printSDK("reqZoneCB,cd,",json)
if json.code=="e1000"then
local data=json.data
if data then
local serverContinent=data.serverContinent
platformSDK.printSDK("reqZoneCB,serverContinent,",serverContinent)
if serverContinent then
local zone=ZoneMapping[serverContinent]
pfwindowslController:setLocalZone(zone)
pfwindowslController:changeLocalZoneHandle(LocalZone)
end
end
end
platformSDK.printSDK("reqZoneCB,cd,",content,err)
end


function pfwindowslController.getMacPlayer()
return _isMacPlayer
end

function pfwindowslController.setMacPlayer(flag)
_isMacPlayer=flag==playerFlag.mac
platformSDK.printSDK("setMacPlayer,",_isMacPlayer,flag)
end

function pfwindowslController.setMacPlayer_OnBindAccount(flag)
_isMacPlayer=flag
platformSDK.printSDK("setMacPlayerFlag,",_isMacPlayer,flag)
end


local chapter_two=2


function pfwindowslController.checkBindAccountReddot(chapter_id)
if chapter_two==chapter_id then
local time=timeHelper.getServerLongTime()
lastClickStamp=time
userActorSetting.set("bindAccountClickTime",time)
userActorSetting.flush()

if self.enterBindAccountGuid~=nil then

pfwindowslController:refreshBindAccountEnterReddot_OM()
end
end
end




local JFSC_subLoginUrl=
{
[pfwindowslController.sdkPFVersion.game_fanti_GA]="&parentGameCode=twzqzs&gameCode={0}&userId={1}&sign={2}&timestamp={3}",
[pfwindowslController.sdkPFVersion.game_oumei]="&parentGameCode=euzqzs&gameCode={0}&userId={1}&sign={2}&timestamp={3}",
}

function pfwindowslController.getJFSC_subLoginUrl()
return JFSC_subLoginUrl
end


function pfwindowslController.getLoginParam()
local data=pfwindowsModel:getSdkLoginData()
if not data.userId then
UIManager.info("not logged in")
return
end
local GameVersion=pfwindowslController:getGameVersion()
local curSubUrl=JFSC_subLoginUrl[GameVersion]
if not curSubUrl then
return
end
local gamecode=pfwindowsModel:getGameCode()
local loginParam=FMT.fmt(curSubUrl,gamecode,data.userId,data.sign,data.timestamp)
return loginParam
end

