






local _MODULENAME="buildlightController"

gameState.addListener(def_table(_MODULENAME))
buildlightController.name=_MODULENAME
buildlightController.data={}


local buildLightIsEnable=false
local buildLightIsPause=false

local Day_Special=100
local BuildLight_WorldID=
{
TaiYueShanMai=1,
TianYunZhou=2,
NanJiang=3,
TianShan=4,
}
local isxianjie=false

function buildlightController:onAppStart()
buildlightModel:onAppStart()
worldController:registerSceneState(worldModel.ON_SCENE_STATE.ENTER,1,function()
buildlightController:onEnterWorld()
end)
worldController:registerSceneState(worldModel.ON_SCENE_STATE.EXIT,1,function()
buildlightController:onExitWorld()
end)
end


function buildlightController:onEnterState(isReconnect)
buildlightModel:onEnterState()
notifySystem:listenNotify(notifyConfig.onMountainChange,self.onMountainChange)
notifySystem:listenNotify(notifyConfig.on_mystery_enter,self.on_mystery_enter)
notifySystem:listenNotify(notifyConfig.on_mystery_quit_finish,self.on_mystery_quit_finish)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
notifySystem:listenNotify(notifyConfig.enterXianJie,self.enterXianJie)
notifySystem:listenNotify(notifyConfig.leaveXianJie,self.leaveXianJie)
self.data.Daystate=BUILD_LIGHT_TYPE.DAY
self:setNature(true)

self.data.NatureDayState=nil
self.data.sceneType=BUILD_LIGHT_Scene_TYPE.eZongMen

self.cfgtimes=cfg_guildworldbuildlightconfig_get(1).times
self.normaltimeday=self.cfgtimes[1]
self.normaltimedusk=self.cfgtimes[2]
self.normaltimenight=self.cfgtimes[3]
self.normaltimedawn=self.cfgtimes[4]
end


function buildlightController:onProtocolReq()
buildlightModel:onProtocolReq()
local ret=systemModel.isOpen(SYSTEM_DEFINE.eBuildLight)

if ret then
local initdata=userActorSetting.get("buildlight_Daystate",1)
if initdata then
local olddaystate=initdata
if type(olddaystate)~="number"then
olddaystate=BUILD_LIGHT_TYPE.DAY
end
buildlightController:setTiemState(olddaystate)
end
buildlightController:setBLState(true)

buildlightController:cleartimedata()
local setup,cfg=guildOrderModel:getSetupData(GUILD_ORDER_TYPE.eZongMenGenTi)
local _daystate=setup.daystate
local _SetupOpen=guildOrderModel:isOrderSetupOpen(GUILD_ORDER_TYPE.eZongMenGenTi)

if _SetupOpen then
if _daystate then
buildlightController:setNature(false)
if _daystate[1]==1 then
buildlightController:setTiemState(BUILD_LIGHT_TYPE.DAY)
elseif _daystate[2]==1 then
buildlightController:setTiemState(BUILD_LIGHT_TYPE.DUSK)
elseif _daystate[3]==1 then
buildlightController:setTiemState(BUILD_LIGHT_TYPE.NIGHT)
elseif _daystate[4]==1 then
buildlightController:setTiemState(BUILD_LIGHT_TYPE.DAWN)
end
buildlightController:ChangeBuildLight()
end
else
buildlightController:setNature(true)
end
buildlightController:startZhouYeState()
else
buildlightController:setBLState(false)
end
end


function buildlightController:onLeaveState(isReconnect)
buildlightModel:onLeaveState(isReconnect)
buildlightController:setFirstLodingBLFlag(false)
local lastdaystate=BUILD_LIGHT_TYPE.DAY
if self.data.Daystate then
lastdaystate=self.data.Daystate
end
userActorSetting.set("buildlight_Daystate",lastdaystate)
notifySystem:removelistener(notifyConfig.onMountainChange,self.onMountainChange)
notifySystem:removelistener(notifyConfig.on_mystery_enter,self.on_mystery_enter)
notifySystem:removelistener(notifyConfig.on_mystery_quit_finish,self.on_mystery_quit_finish)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
if self.buildlightTimer then
self.buildlightTimer:cancel()
self.buildlightTimer=nil
end

self.data={}
isxianjie=false
end


function buildlightController:onLostConnection()

end


function buildlightController:onReConnection(isInitPro)

end

function buildlightController:onNormalUpdate()

end


function buildlightController.on_system_open(sysId)

if sysId==SYSTEM_DEFINE.eBuildLight then
local ret=systemModel.isOpen(SYSTEM_DEFINE.eBuildLight)
if ret then
local initdata=userActorSetting.get("buildlight_Daystate",1)
if initdata then
local olddaystate=initdata
if type(olddaystate)~="number"then
olddaystate=BUILD_LIGHT_TYPE.DAY
end
buildlightController:setTiemState(olddaystate)
end
buildlightController:setBLState(true)

buildlightController:cleartimedata()
local setup,cfg=guildOrderModel:getSetupData(GUILD_ORDER_TYPE.eZongMenGenTi)
local _daystate=setup.daystate
local _SetupOpen=guildOrderModel:isOrderSetupOpen(GUILD_ORDER_TYPE.eZongMenGenTi)

if _SetupOpen then
if _daystate then
buildlightController:setNature(false)
if _daystate[1]==1 then
buildlightController:setTiemState(BUILD_LIGHT_TYPE.DAY)
elseif _daystate[2]==1 then
buildlightController:setTiemState(BUILD_LIGHT_TYPE.DUSK)
elseif _daystate[3]==1 then
buildlightController:setTiemState(BUILD_LIGHT_TYPE.NIGHT)
elseif _daystate[4]==1 then
buildlightController:setTiemState(BUILD_LIGHT_TYPE.DAWN)
end
buildlightController:ChangeBuildLight()
end
else
buildlightController:setNature(true)
end
buildlightController:startZhouYeState()
else
buildlightController:setBLState(false)
end
end
end


function buildlightController:startZhouYeState()
if self.buildlightTimer then
self.buildlightTimer:cancel()
self.buildlightTimer=nil
end
local func=function()

if self.data.isnaturechange then
if self.data.Daystate==BUILD_LIGHT_TYPE.DAY then
if not self.timeday or self.timeday==0 then
self.timeday=0
self.day_time_temp=0
self:ChangeBuildLight()
self.day_time_temp=self.normaltimeday+timeHelper.getServerShortTime()
end
self.timeday=self.timeday or 0
self.timeday=timeHelper.getServerShortTime()

if self.timeday>=self.day_time_temp then

self:setTiemState(BUILD_LIGHT_TYPE.DUSK)
self.timeday=0
self.day_time_temp=0
end
end

if self.data.Daystate==BUILD_LIGHT_TYPE.DUSK then
if not self.timedusk or self.timedusk==0 then
self.timedusk=0
self.dusk_time_temp=0
self:ChangeBuildLight()
self.dusk_time_temp=self.normaltimedusk+timeHelper.getServerShortTime()
end
self.timedusk=self.timedusk or 0
self.timedusk=timeHelper.getServerShortTime()

if self.timedusk>=self.dusk_time_temp then

self:setTiemState(BUILD_LIGHT_TYPE.NIGHT)
self.timedusk=0
self.dusk_time_temp=0
end
end

if self.data.Daystate==BUILD_LIGHT_TYPE.NIGHT then
if not self.timenight or self.timenight==0 then
self.timenight=0
self.night_time_temp=0
self:ChangeBuildLight()
self.night_time_temp=self.normaltimenight+timeHelper.getServerShortTime()
end
self.timenight=self.timenight or 0
self.timenight=timeHelper.getServerShortTime()

if self.timenight>=self.night_time_temp then

self:setTiemState(BUILD_LIGHT_TYPE.DAWN)
self.timenight=0
self.night_time_temp=0
end
end

if self.data.Daystate==BUILD_LIGHT_TYPE.DAWN then
if not self.timedawn or self.timedawn==0 then
self.timedawn=0
self.dawn_time_temp=0
self:ChangeBuildLight()
self.dawn_time_temp=self.normaltimedawn+timeHelper.getServerShortTime()
end
self.timedawn=self.timedawn or 0
self.timedawn=timeHelper.getServerShortTime()

if self.timedawn>=self.dawn_time_temp then

self:setTiemState(BUILD_LIGHT_TYPE.DAY)
self.timedawn=0
self.dawn_time_temp=0
end
end
end
end
self.buildlightTimer=timer.new()
self.buildlightTimer:start(1,func)
end


function buildlightController:setFirstLodingBLFlag(flag)
buildlightController.firstloding=flag
end
function buildlightController:getFirstLodingBLFlag()
return buildlightController.firstloding or nil
end


function buildlightController:firstRefreshBLState()

end


function buildlightController:cleartimedata()
self.timeday=0
self.day_time_temp=0
self.timenight=0
self.dusk_time_temp=0
self.timedusk=0
self.night_time_temp=0
self.timedawn=0
self.dawn_time_temp=0
end


function buildlightController:getTiemState()
return self.data.Daystate
end
function buildlightController:setTiemState(flag)
if flag then
self.data.Daystate=flag
end
end


function buildlightController:getTiemSpecialState()
return self.data.specialDaystate
end
function buildlightController:setTiemSpecialState(flag)
if flag then
self.data.specialDaystate=flag
end
end


function buildlightController:getNatureDayState()
return self.data.NatureDayState
end
function buildlightController:setNatureDayState(flag)
if flag then
self.data.NatureDayState=flag
end
end


function buildlightController:getNature()
return self.data.isnaturechange
end
function buildlightController:setNature(isopen)
self.data.isnaturechange=isopen
end


function buildlightController:getSceneState()
return self.data.sceneType
end
function buildlightController:setSceneState(flag)
if flag then
self.data.sceneType=flag
end
end


function buildlightController:ChangeBuildLight()
local daystate=self:getTiemState()
if not daystate then return end
local scenetype=self:getSceneState()
if not scenetype then return end
if daystate==Day_Special then
local specialdaystatt=buildlightController:getTiemSpecialState()
if specialdaystatt then
luaBuildLightMap:setLightScene(scenetype,specialdaystatt)
end
else
luaBuildLightMap:setLightScene(scenetype,daystate)
end
end

function buildlightController:SetBuildLight(SceneType)
self:setSceneState(SceneType)
self:ChangeBuildLight()
end


function buildlightController.onMountainChange(old_sfId,sfId)

local ret=systemModel.isOpen(SYSTEM_DEFINE.eBuildLight)
if ret then
if old_sfId==sfId then return end
if sfId==mapIdType.zhufeng then
buildlightController:SetBuildLight(BUILD_LIGHT_Scene_TYPE.eZongMen)
elseif sfId==mapIdType.xianzhan then
buildlightController:SetBuildLight(BUILD_LIGHT_Scene_TYPE.eXianZhan)
elseif sfId==mapIdType.xianmeng then
buildlightController:SetBuildLight(BUILD_LIGHT_Scene_TYPE.eXianMen)
elseif sfId==mapIdType.fort then
buildlightController:setBLState(false)

elseif sfId==mapIdType.lingshoudao then
buildlightController:SetBuildLight(BUILD_LIGHT_Scene_TYPE.eLingShouDao)
end
if old_sfId==mapIdType.fort then
if not isxianjie then
buildlightController:setBLState(true)
end
end
end
end

function buildlightController.on_mystery_enter()
local ret=systemModel.isOpen(SYSTEM_DEFINE.eBuildLight)
if ret then
local delayClose=function(...)
buildlightController.delaymystery_enterTimer=nil
buildlightController:setBLState(false)
end
buildlightController.delaymystery_enterTimer=timer.new()
buildlightController.delaymystery_enterTimer:start(0.8,delayClose,1)
end
end

function buildlightController.on_mystery_quit_finish()
local ret=systemModel.isOpen(SYSTEM_DEFINE.eBuildLight)
if ret then
local flag2=MysteryModel:is_in_mystery()
local isinxj=mainControl:isInScene(eSceneType.eXianJie)
if flag2 or isinxj then
else
buildlightController:setBLState(true)
end
end
end

function buildlightController:onEnterWorld()
local ret=systemModel.isOpen(SYSTEM_DEFINE.eBuildLight)
if ret then
local world=worldModel.world

if world==BuildLight_WorldID.TaiYueShanMai then
buildlightController:SetBuildLight(BUILD_LIGHT_Scene_TYPE.eDSJ_TaiYueShanMai)
elseif world==BuildLight_WorldID.TianYunZhou then
buildlightController:SetBuildLight(BUILD_LIGHT_Scene_TYPE.eDSJ_TianYunZhou)
elseif world==BuildLight_WorldID.NanJiang then
buildlightController:SetBuildLight(BUILD_LIGHT_Scene_TYPE.eDSJ_NanJiang)
elseif world==BuildLight_WorldID.TianShan then
buildlightController:SetBuildLight(BUILD_LIGHT_Scene_TYPE.eDSJ_TianShan)
end
end
end

function buildlightController:onExitWorld()
local ret=systemModel.isOpen(SYSTEM_DEFINE.eBuildLight)
if ret then
local oldid=zongmenModel:getMountainId()

if oldid==mapIdType.zhufeng then
buildlightController:SetBuildLight(BUILD_LIGHT_Scene_TYPE.eZongMen)
elseif oldid==mapIdType.xianzhan then
buildlightController:SetBuildLight(BUILD_LIGHT_Scene_TYPE.eXianZhan)
elseif oldid==mapIdType.xianmeng then
buildlightController:SetBuildLight(BUILD_LIGHT_Scene_TYPE.eXianMen)
end
end
end

function buildlightController.enterXianJie()

local ret=systemModel.isOpen(SYSTEM_DEFINE.eBuildLight)
if ret then
isxianjie=true
buildlightController:setBLState(false)
end
end

function buildlightController.leaveXianJie()

local ret=systemModel.isOpen(SYSTEM_DEFINE.eBuildLight)
if ret then
isxianjie=false
buildlightController:setBLState(true)
end
end



function buildlightController:setBLState(enable)
local ret=systemModel.isOpen(SYSTEM_DEFINE.eBuildLight)

if ret then
buildLightIsEnable=enable
if not buildLightIsPause then
luaBuildLightMap:enableLight(enable)
end
else
if enable==false then
luaBuildLightMap:enableLight(false)
end
end
end

function buildlightController:pause()
local ret=systemModel.isOpen(SYSTEM_DEFINE.eBuildLight)
if ret then
buildLightIsPause=true
luaBuildLightMap:enableLight(false)
end
end

function buildlightController:resume()

local ret=systemModel.isOpen(SYSTEM_DEFINE.eBuildLight)
if ret then
buildLightIsPause=false
luaBuildLightMap:enableLight(buildLightIsEnable)
end
end


function buildlightController:getIsNightState()
local state=self:getTiemState()
return state==BUILD_LIGHT_TYPE.NIGHT
end

function buildlightController:getIsNightStatetest()
local ret=systemModel.isOpen(SYSTEM_DEFINE.eBuildLight)


end




function buildlightController:SetAnimationBuildTimeState(isCloud,isEnd,timeState,sceneType,closeWin)
local _closeWin=closeWin
if isCloud then
local func=function()
if _closeWin then
baseFullScreenUI:closeAllActiveWindow()
end
end
loadingControl.openCloud(func,nil,true)
end
if not isEnd then
if timeState then
if type(timeState)~='number'then
timeState=BUILD_LIGHT_TYPE.DAY
end
self:setTiemState(timeState)
self:ChangeBuildLight()
self:setNature(false)
end
else

local ret=systemModel.isOpen(SYSTEM_DEFINE.eBuildLight)
if ret then
local setup,cfg=guildOrderModel:getSetupData(GUILD_ORDER_TYPE.eZongMenGenTi)
local _daystate=setup.daystate
local _SetupOpen=guildOrderModel:isOrderSetupOpen(GUILD_ORDER_TYPE.eZongMenGenTi)
if _SetupOpen then
if _daystate then
self:setNature(false)
if _daystate[1]==1 then
self:setTiemState(BUILD_LIGHT_TYPE.DAY)
elseif _daystate[2]==1 then
self:setTiemState(BUILD_LIGHT_TYPE.DUSK)
elseif _daystate[3]==1 then
self:setTiemState(BUILD_LIGHT_TYPE.NIGHT)
elseif _daystate[4]==1 then
self:setTiemState(BUILD_LIGHT_TYPE.DAWN)
end
self:ChangeBuildLight()
end
else
self:setNature(true)
end
else

self:setTiemState(BUILD_LIGHT_TYPE.DAY)
self:setBLState(false)
self:setNature(true)
end
end
end



function buildlightController:SetBuildBrightness(start,sceneLightIntensity,sceneEvnLightColor,transitionTime)
if start then
luaBuildLightMap:setCustomState("",sceneLightIntensity,sceneEvnLightColor,transitionTime)
else
local ret=systemModel.isOpen(SYSTEM_DEFINE.eBuildLight)
if ret then
local setup,cfg=guildOrderModel:getSetupData(GUILD_ORDER_TYPE.eZongMenGenTi)
local _daystate=setup.daystate
local _SetupOpen=guildOrderModel:isOrderSetupOpen(GUILD_ORDER_TYPE.eZongMenGenTi)
if _SetupOpen then
if _daystate then
self:setNature(false)
if _daystate[1]==1 then
self:setTiemState(BUILD_LIGHT_TYPE.DAY)
elseif _daystate[2]==1 then
self:setTiemState(BUILD_LIGHT_TYPE.DUSK)
elseif _daystate[3]==1 then
self:setTiemState(BUILD_LIGHT_TYPE.NIGHT)
elseif _daystate[4]==1 then
self:setTiemState(BUILD_LIGHT_TYPE.DAWN)
end
self:ChangeBuildLight()
end
else
self:setNature(true)
end
else

self:setTiemState(BUILD_LIGHT_TYPE.DAY)
self:setBLState(false)
self:setNature(true)
end
end
end
