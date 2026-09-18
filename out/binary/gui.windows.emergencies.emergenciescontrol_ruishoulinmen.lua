local _rsObj=nil

function emergenciesControl:refreshEvent_RuiShouLinMen()
local eventData=emergenciesModel:getEventData()or{}
local eventId=emergenciesModel:getCurrentEventId()
local eventCfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,eventId)
local cur=eventData[1].param_1
local max=0
for i,v in ipairs(eventCfg.event_conf.stage)do
max=math.max(max,v[1])
end
emergenciesModel:setFeedRS(cur,max)
emergenciesModel:setRadiusRS(eventCfg.event_conf.r[2])
self:createRuiShou(eventId)
end

function emergenciesControl:clear_RuiShouLinMen(result,isLeaveHome)

UIManager:closeWindow("UIRuiShouLinMenSelectWin")
if isLeaveHome or result==1 then
self:removeRuiShou()
if fullScreenUI.checkFull(UIFullRuiShouLinMenControl)then
UIFullRuiShouLinMenControl:closeUI(true)
end
else
if fullScreenUI.checkFull(UIFullRuiShouLinMenControl)then
UIFullRuiShouLinMenControl:closeUI(true)
end
end
emergenciesModel:cleanRSLMBoxes()
end

function emergenciesControl:getEventCount_RuiShouLinMen()
return
end

function emergenciesControl:moveCameraToEventPos_RuiShouLinMen(event)
if _rsObj then
isometricMapSystem:moveCameraToObjectEx(_rsObj.obj,true)
end
end

function emergenciesControl:createRuiShou(event,force)
if not _rsObj then
local eventId=event or emergenciesModel:getCurrentEventId()
local eventCfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,eventId)
local isFull=force~=nil
if force==nil then
isFull=emergenciesModel:isFullRS()
end
local sundriesModel=eventCfg.event_conf.ruishou
sundriesModel=isFull and sundriesModel[2]or sundriesModel[1]
local sundriesCfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,sundriesModel)
local mapId=mapIdType.zhufeng
local body=sundriesCfg.model[1]
local slots=sundriesCfg.model[2]or{}
local scale=isometricMapSystem:getModelScale(body)
if not isFull then
local seg=emergenciesModel:findFeedSegment(eventCfg.event_conf.stage)
scale=scale*emergenciesModel:getRSLMModelScale(seg)
end
local cfgId=sundriseCreateControl:getPlaceConfig(sundriesModel)
local list=_MapManager.GetMapAreaPosByConfig(mapIdType.zhufeng,-2,cfgId)
local pos=_MapManager.ToVector3Int(0,0,0)
if list.Count>0 then
local r=math.random(1,list.Count)
pos=list[r-1]
end

local guid=isometricMapSystem:createRoleEntity(objectType.eMovementSundrise,mapId,0,body,slots,SortingLayers.ITBuilding,scale,pos)
local bt=nil
if not isFull then
local btData={
pathCheckId=7,
event=eventId,
speak=""
}
bt=behaviorManager:addBehaviorTree('ai_ruishou',{stId=guid},true,btData)
else
_MapManager.RunAnimator(guid,eAnimationID.stand)
bt=behaviorManager:addBehaviorTree('ai_ruishou2',{stId=guid},true,{})
end
_rsObj={
obj=guid,
bt=bt,
}

else
self:changeRuiShouModel(event)
end
end

function emergenciesControl:getRuiShou()
return _rsObj
end

function emergenciesControl:removeRuiShou()
if _rsObj then
if _rsObj.bt then
behaviorManager:removeBehaviorTree(_rsObj.bt)
end
_MapManager.RemoveTilemapObject(_rsObj.obj)
_rsObj=nil
end
end

function emergenciesControl:onClickRuiShou(guid)
if _rsObj and guid==_rsObj.obj then
UIFullRuiShouLinMenControl:showMainWindow()
return true
end
return false
end

function emergenciesControl:checkIsRuiShou(guid)
if _rsObj and guid==_rsObj.obj then
return true
end
return false
end

function emergenciesControl:changeRuiShouModel(event)

if _rsObj then
local eventId=event or emergenciesModel:getCurrentEventId()
local eventCfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,eventId)
local isFull=emergenciesModel:isFullRS()
local sundries=isFull and eventCfg.event_conf.ruishou[2]or eventCfg.event_conf.ruishou[1]
local sundriesCfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,sundries)
local body=sundriesCfg.model[1]
local slots=sundriesCfg.model[2]or{}
local scale=isometricMapSystem:getModelScale(body)
if not isFull then
local seg=emergenciesModel:findFeedSegment(eventCfg.event_conf.stage)
scale=scale*emergenciesModel:getRSLMModelScale(seg)
end
isometricMapSystem:changeBody(_rsObj.obj,body,slots,scale)
if isFull then
if _rsObj.bt then
if _rsObj.bt.file~="ai_ruishou2"then
behaviorManager:removeBehaviorTree(_rsObj.bt)
_rsObj.bt=behaviorManager:addBehaviorTree('ai_ruishou2',{stId=_rsObj.obj},true,{})
_MapManager.RunAnimator(_rsObj.obj,eAnimationID.stand)
end
else
_rsObj.bt=behaviorManager:addBehaviorTree('ai_ruishou2',{stId=_rsObj.obj},true,{})
_MapManager.RunAnimator(_rsObj.obj,eAnimationID.stand)
end
end
end
end

function emergenciesControl:startRuiShouStay()

local eventId=emergenciesModel:getOldEventIdByType(emergenciesType.eRuiShouLinMen)
if eventId>0 then
local cfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,eventId)
if cfg.event_type==emergenciesType.eRuiShouLinMen then
local stay=emergenciesModel:getStayRS()
local curTime=timeHelper.getServerShortTime()
if stay and stay>curTime then
if not _rsObj then
self:createRuiShou(eventId,true)
end
self.updatePost=true
end
end
end
end

function emergenciesControl:updateRuiShouStay()

local eventId=emergenciesModel:getOldEventIdByType(emergenciesType.eRuiShouLinMen)
if eventId>0 then
local cfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,eventId)
if cfg.event_type==emergenciesType.eRuiShouLinMen then
local stay=emergenciesModel:getStayRS()
if stay then
local curTime=timeHelper.getServerShortTime()
if curTime>stay then
self:removeRuiShou()
emergenciesModel:cleanStayRS()
self.updatePost=false
end
else
self:removeRuiShou()
self.updatePost=false
end
end
end
end

function emergenciesControl:selectRuiShouSpeak(bt)
local eventId=bt:getSharedVar("event")
local cfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,eventId)
local speaks=cfg.event_conf.speak
local str=speaks[math.random(1,#speaks)]
bt:setSharedVar("speak",str)
end

function emergenciesControl:waitSundriseClose()
local listen=timer.new()
listen:start(0.2,function()
if emergenciesModel:checkRSLMBoxes()then
listen:cancel()
UIManager:invokeUIMethod("UIRuiShouLinMenWin","onCloseBtn")
end
end,0)
end