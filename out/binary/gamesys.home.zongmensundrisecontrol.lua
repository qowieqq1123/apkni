







local _MODULENAME="zongmenSundriseControl"
gameState.addListener(def_table(_MODULENAME))
zongmenSundriseControl.name=_MODULENAME

zongmenSundriseHudType={
eLimitTime=1,
}

local hudFuncLookup={
[zongmenSundriseHudType.eLimitTime]={
init=function(self,hudID,guid)
self:updata(hudID,guid)
end,
updata=function(self,hudID,guid)
local widget=hudControl:getHUDWidget(hudID)
local data=isometricMapSystem:findUnlockSundriesByGuid(guid)
local end_times=zongmenSundriseTempDataModel.getCDLastTime(data.end_times)
if end_times<0 then
zongmenControl.recv_3_13(data.mapId,1,{data.serverGuid})
return
end
local timeStr=timeHelper.format_time_stamp3(end_times)
widget:SetChildText(1,timeStr)
end,
},
}

local sundriseLookup=nil

function zongmenSundriseControl:onAppStart()

end

function zongmenSundriseControl:onEnterState()
sundriseLookup={}
zongmenSundriseTempDataModel:initData()

notifySystem:listenNotify(notifyConfig.create_sundrise,zongmenSundriseControl.create_sundrise)
notifySystem:listenNotify(notifyConfig.updata_sundrise,zongmenSundriseControl.updata_sundrise)
notifySystem:listenNotify(notifyConfig.remove_sundrise,zongmenSundriseControl.remove_sundrise)
end

function zongmenSundriseControl:onLeaveState()
sundriseLookup=nil
zongmenSundriseTempDataModel:clearData()

notifySystem:removelistener(notifyConfig.create_sundrise,zongmenSundriseControl.create_sundrise)
notifySystem:listenNotify(notifyConfig.updata_sundrise,zongmenSundriseControl.updata_sundrise)
notifySystem:removelistener(notifyConfig.remove_sundrise,zongmenSundriseControl.remove_sundrise)
end

function zongmenSundriseControl:onPlayerCreate(...)

end

function zongmenSundriseControl:onLostConnection()

end

function zongmenSundriseControl:onNormalUpdate()
local cdDatas=zongmenSundriseTempDataModel:getAllCDDatas()
for guid,data in pairs(cdDatas)do
if data.isInit==true then
local lookup=zongmenSundriseControl.getHudFunc(zongmenSundriseHudType.eLimitTime)
lookup:updata(data.hudID,guid)
end
end
end



function zongmenSundriseControl.getHudFunc(hudType)
return hudFuncLookup[hudType]
end



function zongmenSundriseControl.create_sundrise(id,guid,stype)
if stype==sundriseType.eMovementEnemy or stype==sundriseType.eStillEnemy then
if isometricMapSystem:isInUnlockArea(guid)then
zongmenSundriseControl:addSundrise(guid)

local num=zongmenSundriseTempDataModel:getCDDatasNum()
local data=isometricMapSystem:findUnlockSundriesByGuid(guid)
local end_times=data.end_times
if end_times>0 and zongmenSundriseTempDataModel.getCDLastTime(end_times)>0 then
zongmenSundriseTempDataModel:addCDData(guid,end_times)
end
local curnum=zongmenSundriseTempDataModel:getCDDatasNum()
if num<=0 and curnum>0 then
timeEventController.addNormalTimerHandler(1,zongmenSundriseControl.name,zongmenSundriseControl)
end
end
end
end

function zongmenSundriseControl.updata_sundrise(id,guid,stype)
if sundriseLookup[guid]~=nil then
sundriseLookup[guid]=nil
zongmenSundriseControl:refreshSundrise(guid)

local data=isometricMapSystem:findUnlockSundriesByGuid(guid)
local end_times=data.end_times
if end_times>0 and zongmenSundriseTempDataModel.getCDLastTime(end_times)>0 then
zongmenSundriseTempDataModel:refreshCDData(guid,end_times)
end
end
end

function zongmenSundriseControl.remove_sundrise(guid)
if sundriseLookup[guid]~=nil then
zongmenSundriseControl:removeSundrise(guid)

zongmenSundriseTempDataModel:removeCDData(guid)
local num=zongmenSundriseTempDataModel:getCDDatasNum()
if num<=0 then
timeEventController.removeNormalTimerHandler(1,zongmenSundriseControl.name)
end
end
end



function zongmenSundriseControl:addSundrise(guid)
sundriseLookup[guid]=true
end

function zongmenSundriseControl:refreshSundrise(guid)

end

function zongmenSundriseControl:removeSundrise(guid)
sundriseLookup[guid]=nil
end