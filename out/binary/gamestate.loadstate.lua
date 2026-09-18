






loadState={name='loadState'}

local _msg_handle=CS.MessageInterface
local _msg_type=GlobalEventType

local _GameConfigLoader=CS.GameConfigLoader
local _PreloadGameConfig=_GameConfigLoader.PreloadGameConfig
local _AppConfig_GetString=CS.AppDataModel.AppConfig_GetString
local _AppConfig_GetBool=CS.AppDataModel.AppConfig_GetBool



local _langScriptAuto=require'data.lang.langScriptAuto'


UIWindowRequireConfig={}
refSrcConfig={}

function langScriptAuto(key)
return _langScriptAuto[key]
end

local _langScript=nil
function langScript(key,default)
local str=_langScript[key]
if not str then
logWarn(string.format("can't find key:%s in langScript",key))
return default or""
end
return str
end



local function onCSharpLoadFinish()

loadState:loadScripts()
end

function loadState:reloadTolua()
if deviceHelper.getAPILevel()>=51 then
CS.ResourceHelper.ReloadBaseBundle(function()

if strict_if_strict then
strict_if_strict(false)
end

reload'tolua.launcher.deviceHelper'

if strict_if_strict then
strict_if_strict(true)
end

loadState:loadScripts()
end)

else
loadState:loadScripts()
end
end


function loadState:enter()

















_msg_handle.AddEventListener(_msg_type.APPLICATION_EVT_CS_INITLOAD_FINISH,onCSharpLoadFinish)
end


function loadState:leave()
_msg_handle.RemoveEventListener(_msg_type.APPLICATION_EVT_CS_INITLOAD_FINISH,onCSharpLoadFinish)
end


local function loadingUIConfig()
require'lua.gui.uiwindowconfig'
require'lua.gui.uiwindowconfig_auto'


require'lua.gui.uiwidgetconfig_auto'
require'lua.gui.uiwindowrequieconfig_auto'

for k,v in pairs(UIWindowRequireConfig_auto)do
local parent=v.parent
if UIWindowRequireConfig[parent]==nil then UIWindowRequireConfig[parent]={}end
local requireconfig=UIWindowRequireConfig[parent]
requireconfig[#requireconfig+1]=v
end

require'lua.gamecore.ui.__init'
end


local function loadCommonConfig()
require'data.lang.lang'
require'data.lang.langScript'

require'lua.gamecore.base.__init'

require'lua.gamestate.__init'
require'lua.reconnectState.__init'
require'lua.gui.windows.CreateRole.__init'

appLifecycleMgr:init()
require"lua.gamecore.base.shushuPortHelper"
require'lua.gamecore.assetLoad.__init'
require'lua.gamecore.audio.__init'
require'lua.gamecore.initPro.__init'
require'lua.gamecore.scene.__init'
require'lua.network.__init'
require'lua.gamecore.input.__init'
require'lua.gamecore.uibase.__init'
require'data.config.configloader_custom'
require'data.config.configloader_init'


require'lua.gamecore.inject.__init'

require'lua.permission.__init'
require'lua.platformSDK.platformSDK'
require'lua.gamecore.http.__init'
require'lua.gameState.login.__init'
require'lua.gamecore.resolution.resolutionUtility'

require'lua.gamecore.player.__init'
require'lua.gamecore.GameUtility.__init'
require'lua.gamecore.behavior.__init'
require'lua.gamecore.skill.__init'
require'lua.gamesys.monster.__init'
require'lua.gamecore.dataCenter.__init'

require'lua.gui.windows.Disciple.__init'

require'lua.gamesys.__init'

require'lua.gamesys.home.__init'
require'lua.gamesys.MysterySystem.__init'

require'lua.gamesys.wudaotang.__init'
require'lua.gamesys.gubao.__init'
require'lua.gamesys.systemZongMen.__init'
require'lua.gamesys.shuwudian.__init'
require'lua.gamesys.welfareSystem.__init'
require'lua.gamesys.activities.__init'
require'lua.gamesys.limitActivities.__init'
require'lua.gameSys.firstRechargeSystem.__init'
require("lua.gameSys.firstRechargeNewSystem.__init")
require'lua.gameSys.sevenDayGoalSystem.__init'
require'lua.gameSys.auctionSystem.__init'
require'lua.gameSys.wanBaoShangHuiSystem.__init'
require'lua.gameSys.wanBaoXunBaoDuiSystem.__init'
require'lua.gamesys.shareImageSystem.__init'
require'lua.gamesys.buildSkinSystem.__init'
require'lua.gameSys.shequSystem.__init'
require'lua.gameSys.superZuShiSystem.__init'
require'lua.gameSys.prosperitySystem.__init'
require'lua.gameSys.xunBaoShiLianSystem.__init'
require'lua.gamesys.xianyuanxunfangSystem.__init'


require'lua.gamesys.serverSaveSystem.__init'

require'lua.gamecore.systemTips.__init'
require'lua.gamesys.tips.__init'
require'lua.gameSys.pfwindowsctrl.__init'


require'lua.gui.windows.GongFa.__init'
require'lua.gui.windows.fair.__init'
require'lua.gui.windows.school.__init'
require'lua.gui.windows.QianJiGe.__init'
require'lua.gui.windows.feishengtai.__init'
require'lua.gui.windows.SectPalace.__init'
require'lua.gui.windows.shop.__init'
require'lua.gui.windows.layout.__init'
require'lua.gui.windows.setting.__init'
require'lua.gui.windows.littlegame.__init'
require'lua.gui.windows.prison.__init'
require'lua.gui.windows.fulu.__init'
require'lua.gui.windows.recruit.__init'
require'lua.gui.windows.bag.__init'
require'lua.gui.windows.emergencies.__init'
require'lua.gui.windows.dailyPaper.__init'
require'lua.gui.windows.feeding.__init'
require'lua.gui.windows.catshop.__init'
require'lua.gui.windows.huanjing.__init'
require'lua.gui.windows.xuanshang.__init'
require'lua.gui.windows.xianshu.__init'
require'lua.gui.windows.chuangongge.__init'
require'lua.gui.windows.xianfawendao.__init'
require'lua.gui.windows.aquarium.__init'
require'lua.gui.windows.goodreviews.__init'
require'lua.gui.windows.yufulingzhen.__init'
require'lua.gui.windows.lzpz.__init'
require'lua.gui.windows.lingshanzhengduo.__init'

require'lua.gamesys.disciple.__init'
require"lua.gui.windows.funcShop.funcShopSystem.__init"

require("lua.gameSys.LunHuiDianSystem.__init")
require("lua.gameSys.bubbleShooter.__init")

require'lua.gameSys.MiniGanmeSystem.__init'
require'lua.gameSys.CommonSystem.__init'
end


local function loadConfigAfterUIManager()
require'lua.gamesys.common.tempDataControl'
end

local function loadDeviceLayoutConfig()
local uiFitConfig=require'data/config/uifitconfig'
local platform=LuaApplication.GetApplicationPlatform()
platform=tostring(platform)

local fitConfigPath=nil
local fitDevice=""
local matchFitConfig=nil
local bangFactor=nil

if platform==GameConfig.ApplicationPlatform.WindowsEditor or platform==GameConfig.ApplicationPlatform.OSXEditor then
platform=_AppConfig_GetString("uiFitPlatform","")
fitDevice=_AppConfig_GetString("uiFitDevice","")
end

if platform==GameConfig.ApplicationPlatform.IPhonePlayer then
if fitDevice==""then
fitDevice=CS.GameInterface.GetDeviceModel()
end

elseif platform==GameConfig.ApplicationPlatform.Android then
if fitDevice==""then
fitDevice=CS.GameInterface.GetDeviceModel()
end
end

if uiFitConfig~=nil then
local fitSort=function(fit1,fit2)
return fit1.matchType>fit2.matchType
end

table.sort(uiFitConfig,fitSort)
for i,v in ipairs(uiFitConfig)do
if v.matchType==1 then
if v.matchDeviceModel==fitDevice then
matchFitConfig=v.fitConfig
bangFactor=v.bangOffsetFactor
break
end
else
if string.find(fitDevice,v.matchDeviceModel)~=nil then
matchFitConfig=v.fitConfig
bangFactor=v.bangOffsetFactor
break
end
end
end
end

if matchFitConfig~=nil then
fitConfigPath=string.format("ui/sharedres/uidevicelayoutfor%s.ab",string.lower(matchFitConfig))
_GameConfigLoader.PreloadDeviceLayoutConfig(fitConfigPath,matchFitConfig,bangFactor[1],bangFactor[2])
end
end


function loadState:finish()
loginModel:requestPHPCfg_Pre()
webGLHelper:showMiniGame()
resolutionUtility.init()
rawDataReplace.init()
appLifecycleMgr:onAppStart()
pfCommonHelper.efunTrackEventPoint(pfCommonHelper.efunTrackEventName.LaunchApp)
houtaiModel:tishen_LoginAgreementData()
LuaApplication.changeState(loginState)
end


function loadState:loadScripts()
_langScript=require'data.lang.langScript'

if strict_if_strict then
strict_if_strict(false)
end
require"lua.common.__init"
require'lua.API_LEVEL'

if strict_if_strict then
strict_if_strict(true)
end
appUtils.init()

loadCommonConfig()
loadingUIConfig()
loadConfigAfterUIManager()

userGlobalSetting.init()
notifySystem:init()
autoLoginHelper:init()
if deviceHelper.isRunWebGL()then
webGLHelper:init()
end
webGLHelper:initMG()

appLifecycleMgr:onAppStart()

LuaApplication.startGCTimer()
require'lua.gui.__init'
appLifecycleMgr:onAppStart()
_PreloadGameConfig()

loadState:finish()
loginHelper.overrideLogPointLogStr()
end