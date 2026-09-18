
zongmenEffectControl=gameState.addListener({})

function zongmenEffectControl:onEnterState(isReconnect)
if isReconnect then
return
end
self.activeData={}
self.bdEffectPlayData={}
end

function zongmenEffectControl:onLeaveState(isReconnect)
if isReconnect then
return
end
end

function zongmenEffectControl:onEnterHome()
self:init()
timeEventController.addNormalTimerHandler(1,'zongmenEffectControl',self)
end

function zongmenEffectControl:onLeaveHome()
timeEventController.removeNormalTimerHandler(1,'zongmenEffectControl')
self.activeData=nil
self.bdEffectPlayData={}
end

function zongmenEffectControl:getRandomCD(cd)
return math.random()*(cd[2]-cd[1])+cd[1]
end

function zongmenEffectControl:onNormalUpdate(delay)
local currTime=gameUtilityModel.getServerLongTime()
for k,v in pairs(self.activeData)do
if currTime>=v.endTime then
self.activeData[v.cfg.id]=nil
else
for ii,vv in ipairs(v.posData)do
if vv.isPLaying then
if currTime>=vv.endPlayTime then
_stopEffect(vv.effectId)
vv.isPLaying=false
vv.nextPlayTime=currTime+self:getRandomCD(vv.cd)
v.palyCount=v.palyCount-1
end
else
if currTime>=vv.nextPlayTime then
if v.palyCount<v.maxCount then
local effectList=v.cfg.effect_list
local state=buildlightController:getTiemState()
local ed=effectList[math.random(1,#effectList)]
if not ed.play_time or ed.play_time[state]then
local cpos=_MapManager.ToVector3Int(vv.pos[1],vv.pos[2],0)
local wpos=_MapManager.GetCellCenterWorld(mapIdType.zhufeng,cpos,mapLayer.Data)
local offset=ed.offset
if offset then
wpos.x=wpos.x+offset[1]
wpos.y=wpos.y+offset[2]
end
local id=_MapManager.PlayEffectByPos(wpos,ed[1])
vv.effectId=id
vv.isPLaying=true
vv.endPlayTime=currTime+ed[2]
v.palyCount=v.palyCount+1

else
vv.nextPlayTime=currTime+self:getRandomCD(vv.cd)
end
else
vv.nextPlayTime=currTime+self:getRandomCD(vv.cd)
end
end
end
end
end
end

for k,v in pairs(self.bdEffectPlayData)do
if v.isPLaying then
if currTime>=v.endPlayTime then
v.isPLaying=false
v.nextPlayTime=currTime+self:getRandomCD(v.palyArgs)
end
else
if currTime>=v.nextPlayTime then
local play_time=v.palyArgs.play_time
local state=buildlightController:getTiemState()
if not play_time or play_time[state]then
buildingEffectControl:playEffectByEID(v.bdData.entityId,v.cfg.id,buildEffectType.eRegular)
_MapManager.RunAnimator(v.bdData.entityId,v.palyArgs[4])
v.isPLaying=true
v.endPlayTime=currTime+v.palyArgs[3]
else
v.nextPlayTime=currTime+self:getRandomCD(v.palyArgs)
end
end
end
end
end

function zongmenEffectControl:init()
local currTime=gameUtilityModel.getServerLongTime()
self.activeData={}
local cfgs=cfg_zongmeneffectconfig()
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

for k,v in pairs(self.activeData)do
local posData={}
for ii,vv in ipairs(v.cfg.pos_list)do
local pd={}
pd.pos={vv[1],vv[2]}
pd.cd=vv[3]
pd.nextPlayTime=currTime+self:getRandomCD(pd.cd)
posData[#posData+1]=pd
end
v.posData=posData
v.maxCount=v.cfg.max
v.palyCount=0
end
end

function zongmenEffectControl:addBuildinfEffect(bdData,cfg)
if not cfg.effect then
return
end

local args=cfg.effectArgs and cfg.effectArgs[buildEffectType.eRegular]
if not args then
return
end

local currTime=gameUtilityModel.getServerLongTime()

local palyArgs=args.palyArgs
local data={
bdData=bdData,
cfg=cfg,
palyArgs=palyArgs,
nextPlayTime=currTime+self:getRandomCD(palyArgs),
}

self.bdEffectPlayData[bdData.un_build_id]=data
end

function zongmenEffectControl:removeBuildinfEffect(bdId)
self.bdEffectPlayData[bdId]=nil
end