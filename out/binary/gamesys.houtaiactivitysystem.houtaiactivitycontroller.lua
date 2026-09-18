






local _MODULENAME="houtaiActivityController"
local WEB_ACTIVITY_READ_KEY="WebActivityHasRead"

gameState.addListener(def_table(_MODULENAME))
houtaiActivityController.name=_MODULENAME
houtaiActivityController.data={}
houtaiActivityController.enterGuid=nil
houtaiActivityController._lastShouldShow=nil

function houtaiActivityController:onAppStart()

houtaiActivityModel:onAppStart()








end


function houtaiActivityController:onEnterState(isReconnect)
houtaiActivityModel:onEnterState()
timeEventController.addNormalTimerHandler(1,houtaiActivityController.name,self)
end


function houtaiActivityController:freshEnter()
local webData=houtaiModel:getWangYeTiaoZhuanData()or{}


local shouldShow=houtaiModel:isOpenWangYeTiaoZhuan()
if shouldShow then
if not self.enterGuid then
self.enterGuid=enterManager:freshEnter({
id=1,
enterIconType=ENTER_ICON_TYPE.eNomal,
enterType=ENTER_TYPE.eWangYeTiaoZhuan,
getReddotFun=function()
return not houtaiActivityModel:isWebActivityRead()
end,
})
else
self.enterGuid=enterManager:freshEnter({
id=1,
enterIconType=ENTER_ICON_TYPE.eNomal,
enterType=ENTER_TYPE.eWangYeTiaoZhuan,
getReddotFun=function()
return not houtaiActivityModel:isWebActivityRead()
end,
})
enterManager:freshFunc("freshReddot",ENTER_TYPE.eWangYeTiaoZhuan,1,ENTER_ICON_TYPE.eNomal)
end
else
if self.enterGuid then
if userActorSetting then
userActorSetting.set(WEB_ACTIVITY_READ_KEY,"0")
userActorSetting.flush()
end
enterManager:removeEnter(self.enterGuid)
self.enterGuid=nil
end
end
end

function RefreshWangYeTiaoZhuanEnter()

end

function houtaiActivityController:onNormalUpdate(delay)

local shouldShow=houtaiModel:isOpenWangYeTiaoZhuan()
if self._lastShouldShow==nil or self._lastShouldShow~=shouldShow then
self._lastShouldShow=shouldShow
self:freshEnter()
end
end


function houtaiActivityController:onProtocolReq()
houtaiActivityModel:onProtocolReq()
self:freshEnter()
end


function houtaiActivityController:onLeaveState(isReconnect)
houtaiActivityModel:onLeaveState(isReconnect)
self.data={}
houtaiActivityController._lastShouldShow=nil
timeEventController.removeNormalTimerHandler(1,houtaiActivityController.name)
end


function houtaiActivityController:onLostConnection()

end


function houtaiActivityController:onReConnection(isInitPro)

end






