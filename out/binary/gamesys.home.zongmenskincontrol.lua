
zongmenSkinControl=gameState.addListener({})

function zongmenSkinControl:onEnterState(isReconnect)
if isReconnect then
return
end
self.activeData={}
self.decorateData={}
end

function zongmenSkinControl:onLeaveState(isReconnect)
if isReconnect then
return
end
end

function zongmenSkinControl:onEnterHome()

end

function zongmenSkinControl:onLeaveHome()

self:clearDecrate()
end

function zongmenSkinControl:onNormalUpdate(delay)

end

function zongmenSkinControl:init()
local currTime=gameUtilityModel.getServerLongTime()
self.activeData={}
local cfgs=cfg_buildingtimelimitskinconfig()
for i,v in ipairs(cfgs)do
local tlist=v.time
for ii,vv in ipairs(tlist)do
local td=vv[1]
local t1=timeHelper.getSeconds(td[1],td[2],td[3],td[4],td[5],td[6])
if currTime>=t1 then
td=vv[2]
local t2=timeHelper.getSeconds(td[1],td[2],td[3],td[4],td[5],td[6])
if currTime<t2 then
self.activeData[v.id]={cfg=v,beginTime=t1,endTime=t2}
break
end
end
end
end

cfgs=cfg_zongmentimelimitdecorateconfig()
self.decorateData={}
for i,v in ipairs(cfgs)do
local tlist=v.time
for ii,vv in ipairs(tlist)do
local td=vv[1]
local t1=timeHelper.getSeconds(td[1],td[2],td[3],td[4],td[5],td[6])
if currTime>=t1 then
td=vv[2]
local t2=timeHelper.getSeconds(td[1],td[2],td[3],td[4],td[5],td[6])
if currTime<t2 then
self:createDecrate(v.models)
break
end
end
end
end
end

function zongmenSkinControl:createDecrate(models)
for i,v in ipairs(models)do
local st=isometricMapSystem:createModelEntity(v)
self.decorateData[st.GUID]=st
end
end

function zongmenSkinControl:clearDecrate()
for k,v in pairs(self.decorateData)do
_EntityManager:RemoveEntity(k)
end
end

function zongmenSkinControl:getNormalBDTimeLimitSkin(bdId,level)
for k,v in pairs(self.activeData)do
local model=v.cfg.skin1[bdId]
if model then
return model[level]
end
end
end

function zongmenSkinControl:getSpecialBDTimeLimitSkin(bdId,level)
for k,v in pairs(self.activeData)do
local model=v.cfg.skin2[bdId]
if model then
return model[level]
end
end
end