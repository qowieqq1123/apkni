local _feed=nil
local _stay=nil
local _radius=nil
local _boxes={}
local _scale={1,1.15,1.3,1.45}

function emergenciesModel:setEventHandData_RuiShouLinMen(eventId,time,cfg,eventData)
if cfg.event_type==emergenciesType.eRuiShouLinMen then
_stay=nil
if eventData then

local feed=eventData[1].param_1
local max=0
for i,v in ipairs(cfg.event_conf.stage)do
max=math.max(max,v[1])
end
if feed>=max then
_stay=time+cfg.event_conf.stay
end
_radius=cfg.event_conf.r[2]
end
end
end

function emergenciesModel:getStayRS()
return _stay
end

function emergenciesModel:cleanStayRS()
_stay=nil
end

function emergenciesModel:setFeedRS(cur,max)
_feed={cur,max}
end

function emergenciesModel:setCurrentFeedRS(cur)
_feed[1]=cur
end

function emergenciesModel:haveFeedRS()
return _feed~=nil
end

function emergenciesModel:getFeedRS()
return _feed[1],_feed[2]
end

function emergenciesModel:findFeedSegment(stageCfg)
local index=0
for i=#stageCfg,1,-1 do
local v=stageCfg[i]
if not self:haveFeedRS()or _feed[1]>=v[1]then
index=i
break
end
end
return index
end

function emergenciesModel:isFullRS()
return _feed[1]>=_feed[2]
end

function emergenciesModel:getFeedLeast()
return _feed[2]-_feed[1]
end

function emergenciesModel:setRadiusRS(r)
_radius=r
end

function emergenciesModel:getRadiusRS()
return _radius
end

function emergenciesModel:addRSLMBoxes(guids)
_boxes=table.concatTableX(_boxes,guids)
end

function emergenciesModel:cleanRSLMBoxes()
_boxes={}
end

function emergenciesModel:copyRSLMBoxes()
return table.weakCopy(_boxes)
end

function emergenciesModel:showRSLMBoxesEffect(eventId,boxes)
local temp=boxes or _boxes
local eventCfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,eventId)
local effectCfg=eventCfg.event_conf.effect
if effectCfg then
for i,v in ipairs(temp)do
local data=isometricMapSystem:getSundriesDataByServerGuid(v)
if data then
local effectId=effectCfg[data.id]
if effectId then
_MapManager.PlayEffect(data.guid,effectId,Vector3.zero,true,true)
end
end
end
end
if not boxes then
self:cleanRSLMBoxes()
end
end

function emergenciesModel:checkRSLMBoxes()
for i,v in ipairs(_boxes)do
local data=isometricMapSystem:getSundriesDataByServerGuid(v)
if data==nil then
return false
end
end
return true
end

function emergenciesModel:getRSLMModelScale(index)
return _scale[index+1]
end