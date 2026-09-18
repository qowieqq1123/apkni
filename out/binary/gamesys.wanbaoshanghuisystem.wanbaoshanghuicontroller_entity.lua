






local cmdTypeBtName={
[1]='ai_catwoker_range_move',
[2]='ai_catwoker_putgoods_shanghui',
[3]='ai_catwoker_putgoods_pos',
[4]='ai_catwoker_relax',
}
local speakType={
[1]='catWorkerSpeakPG_start',
[2]='catWorkerSpeakPG_midway',
[3]='catWorkerSpeakPG_end',
[4]='catWorkerSpeak_walk',
}

function wanBaoShangHuiController:onAppStart_entity()

end

function wanBaoShangHuiController:onEnterState_entity()
end

function wanBaoShangHuiController:onLeaveState_entity()
end

function wanBaoShangHuiController:createCatWorker()
local useIndex
if#self.data.canUseCreatePosList>1 then

useIndex=math.random(1,#self.data.canUseCreatePosList)
elseif#self.data.canUseCreatePosList==1 then

useIndex=1
else




return
end

local createPosIndex=self.data.canUseCreatePosList[useIndex]

table.remove(self.data.canUseCreatePosList,useIndex)
wanBaoShangHuiController:createCatWorkerEntity(createPosIndex)
end

function wanBaoShangHuiController:createCatWorkerEntity(posIndex)
local posParam=cfgHelper.get1(cfg_wanbaoshanghuiposconfig_get,posIndex)
local pos
if posParam then
pos=_MapManager.ToVector3Int(posParam.pos[1],posParam.pos[2],0)
else



return
end

local cfg=cfgHelper.get1(cfg_wanbaoshanghuibaseconfig_get,1)
local allModel=cfg.catWorkerModel
local minCreateModelIndexList={}
local minCreateCount
for i=1,#allModel do
local count=self.data.createCWModelCount_lookup[i]or 0
if not minCreateCount or count<minCreateCount then
minCreateCount=count
minCreateModelIndexList={}
minCreateModelIndexList[1]=i
elseif count==minCreateCount then
minCreateModelIndexList[#minCreateModelIndexList+1]=i
end
end

local useModelIndex
if#minCreateModelIndexList>1 then

local randomIndex=math.random(1,#minCreateModelIndexList)
useModelIndex=minCreateModelIndexList[randomIndex]
else

useModelIndex=minCreateModelIndexList[1]
end

local modelParam=allModel[useModelIndex]
local body=modelParam[1]
local cfgScale=modelParam[2]or 1
local modelScale=isometricMapSystem:getModelScale(body)
local scale=cfgScale*modelScale
local slots={}
local orientation=posParam.orientation

local hideColor=Color.New(1,1,1,0)
local guid=isometricMapSystem:createRoleEntity(objectType.eCatWorker,mapIdType.zhufeng,0,body,slots,SortingLayers.ITBuilding,scale,pos)
_MapManager.SetFadeToColor(guid,hideColor,0,nil)
_MapManager.ShowShadow(guid,true)
local btData={
guid=guid,
targetPos={posParam.pos[1],posParam.pos[2]},
posIndex=posIndex,
orientation=orientation,
fadeTime=0.5,
controllerName='wanBaoShangHuiController'
}
self.data.createCWCount=self.data.createCWCount+1
if not self.data.createCWModelCount_lookup[useModelIndex]then
self.data.createCWModelCount_lookup[useModelIndex]=0
end
self.data.createCWModelCount_lookup[useModelIndex]=self.data.createCWModelCount_lookup[useModelIndex]+1
local bt=behaviorManager:addBehaviorTree('ai_catwoker_create',{stId=guid},true,btData)
if not self.data.entityList then
self.data.entityList={}
end
self.data.entityList[guid]={
guid=guid,
bt=bt,
useModelIndex=useModelIndex,
createPosIndex=posIndex,
finishCmdCount=0,
controllerName='wanBaoShangHuiController'
}
end


function wanBaoShangHuiController:clearCatWorkerAllEntity()
if not self.data.entityList then
return
end

for guid,_ in pairs(self.data.entityList)do
wanBaoShangHuiController:clearCatWorkerEntityByGuid(guid)
end
end

function wanBaoShangHuiController:clearCatWorkerEntityByGuid(guid)
if not self.data.entityList then
return
end

local entity=self.data.entityList[guid]
if not entity then
return
end

if entity.bt then
behaviorManager:removeBehaviorTree(entity.bt)
entity.bt=nil
end

if entity.hud then
hudControl:removeHUD(entity.hud)
end

if entity.guid then
_MapManager.RemoveTilemapObject(entity.guid)
end

self.data.createCWCount=self.data.createCWCount-1
self.data.createCWModelCount_lookup[entity.useModelIndex]=self.data.createCWModelCount_lookup[entity.useModelIndex]-1
self.data.entityList[guid]=nil
end


function wanBaoShangHuiController:startCreateCatWorkerTimer()
wanBaoShangHuiController:clearCreateCatWorkerTimer()
wanBaoShangHuiController:initCreateCatWorkerData()
local fun=function()
if not isometricMapSystem:isInNormalMode()then

return
end

local nowTime=gameUtilityModel.getServerShortTime()
if self.data.checkTime<=nowTime then

if self.data.createCWCount<self.data.maxCreateCWCount and#self.data.canUseCreatePosList>1 then
local createCountOnce=1
if self.data.maxCreateCWCount-self.data.createCWCount>=2 then

createCountOnce=math.random(1,2)
end

for i=1,createCountOnce do
wanBaoShangHuiController:createCatWorker()
end


if self.data.createCWCount<self.data.maxCreateCWCount then

local createCWTime=math.random(self.data.createCWTimeRange[1],self.data.createCWTimeRange[2])
self.data.checkTime=nowTime+createCWTime
else

self.data.checkTime=nowTime+self.data.maxCheckTime
end
else

self.data.checkTime=nowTime+self.data.maxCheckTime
end
end
end

self.createCWTimer=timer.new()
self.createCWTimer:start(1,fun)
end

function wanBaoShangHuiController:initCreateCatWorkerData()
self.data.checkTime=0
self.data.createCWCount=0
local baseCfg=cfgHelper.get1(cfg_wanbaoshanghuibaseconfig_get,1)
self.data.maxCreateCWCount=baseCfg.catWorkerCount
self.data.maxCheckTime=baseCfg.catWorkerCheckTime
self.data.createCWTimeRange=baseCfg.catWorkerCreateTime
self.data.cwWaitTimeRange=baseCfg.catWorkerWaitTime
self.data.cwSpeakRate=baseCfg.catWorkerSpeakRate

self.data.canUseCreatePosList={}
for i=1,#baseCfg.catWorkerCreatePos do
local posIndex=baseCfg.catWorkerCreatePos[i]
self.data.canUseCreatePosList[#self.data.canUseCreatePosList+1]=posIndex
end

self.data.createCWModelCount_lookup={}

local cmdCfg=cfg_wanbaoshanghuibehaviorconfig()
self.cmdPool={}
for i=1,#cmdCfg do
self.cmdPool[#self.cmdPool+1]=cmdCfg[i].id
end
end



function wanBaoShangHuiController:clearCreateCatWorkerTimer()
if self.createCWTimer then
self.createCWTimer:cancel()
self.createCWTimer=nil
end
end


function wanBaoShangHuiController:stopCreateCatWorker()
wanBaoShangHuiController:clearCreateCatWorkerTimer()
wanBaoShangHuiController:clearCatWorkerAllEntity()
end



function wanBaoShangHuiController:changeEntityOrientation(entityGuid,orientation,pos)
if not entityGuid or not orientation or not pos then

return
end

local mapId=mapIdType.zhufeng
local targetPos
if orientation==0 then

targetPos=_MapManager.ToVector3Int(pos[1]-1,pos[2],0)
else

targetPos=_MapManager.ToVector3Int(pos[1]+1,pos[2],0)
end

_MapManager.TowardToPosition(mapId,entityGuid,targetPos)
end


function wanBaoShangHuiController:finishCreateEntity(entityGuid,posIndex)
self.data.canUseCreatePosList[#self.data.canUseCreatePosList+1]=posIndex
end


function wanBaoShangHuiController:finishBehaviorCMD(entityGuid)
if not self.data or not self.data.entityList then
return
end
local entity=self.data.entityList[entityGuid]
if not entity then
return
end


if entity.bt then
behaviorManager:removeBehaviorTree(entity.bt)
entity.bt=nil
end

if entity.cmdId then

self.cmdPool[#self.cmdPool+1]=entity.cmdId
entity.cmdId=nil
end

if entity.finishCmdCount then
entity.finishCmdCount=entity.finishCmdCount+1
end


local btData={
guid=entity.guid,
minWaitTime=self.data.cwWaitTimeRange[1],
maxWaitTime=self.data.cwWaitTimeRange[2],
controllerName='wanBaoShangHuiController'
}
local bt=behaviorManager:addBehaviorTree('ai_catwoker_wait',{stId=entity.guid},true,btData)
entity.bt=bt
end


function wanBaoShangHuiController:getNextBehaviorCMD(entityGuid)
local entity=self.data.entityList[entityGuid]
if not entity then
return
end


if entity.bt then
behaviorManager:removeBehaviorTree(entity.bt)
entity.bt=nil
end

local cmdCount=#self.cmdPool
local cmdIndex
if cmdCount>1 then

cmdIndex=math.random(1,cmdCount)
elseif cmdCount==1 then

cmdIndex=1
else




return
end
local cmdId=self.cmdPool[cmdIndex]
table.remove(self.cmdPool,cmdIndex)


local cmdCfg=cfgHelper.get1(cfg_wanbaoshanghuibehaviorconfig_get,cmdId)
local cmdType=cmdCfg.behaviorType
local cmdName=cmdTypeBtName[cmdType]
if not cmdName then



return
end

local pos={}
local orientation={}


for i=1,2 do
local posList=cmdCfg[FMT.fmt('posList{0}',i)]
if posList and next(posList)then
local posCount=#posList
local posIndex
if posCount>1 then

local randomIndex=math.random(1,posCount)
posIndex=posList[randomIndex]
else

posIndex=posList[1]
end

local posParam=cfgHelper.get1(cfg_wanbaoshanghuiposconfig_get,posIndex)
if posParam then
pos[i]={posParam.pos[1],posParam.pos[2]}
orientation[i]=posParam.orientation
end
end
end

local btData={
guid=entity.guid,
targetPos1=pos[1],
targetPos2=pos[2],
orientation1=orientation[1],
orientation2=orientation[2],
speakRate=self.data.cwSpeakRate,
controllerName='wanBaoShangHuiController'
}

local bt=behaviorManager:addBehaviorTree(cmdName,{stId=entity.guid},true,btData)
entity.bt=bt
entity.cmdId=cmdId
end


function wanBaoShangHuiController:finishBehaviorCMDAndRemoveEntity(entityGuid)
local entity=self.data.entityList[entityGuid]
if not entity then
return
end

if entity.cmdId then

self.cmdPool[#self.cmdPool+1]=entity.cmdId
entity.cmdId=nil
end


wanBaoShangHuiController:clearCatWorkerEntityByGuid(entityGuid)
end


function wanBaoShangHuiController:getSpeakContentByType(entityGuid,type,tkey)
local entity=self.data.entityList[entityGuid]
if not entity then
return
end

local typeCfgName=speakType[type]
if not typeCfgName then



return
end

local speakCfg=cfgHelper.get2(cfg_wanbaoshanghuibaseconfig_get,1,typeCfgName)
if not speakCfg or not next(speakCfg)then



return
end

local speakList=speakCfg[entity.useModelIndex]
local count=#speakList
local speakContent
if count>1 then

local randomIndex=math.random(1,count)
speakContent=speakList[randomIndex]
else

speakContent=speakList[1]
end

entity.bt:setSharedVar(tkey,speakContent)
end


function wanBaoShangHuiController:getBackShangHuiRelaxPos(entityGuid)
local entity=self.data.entityList[entityGuid]
if not entity then
return
end

local posList=cfgHelper.get2(cfg_wanbaoshanghuibaseconfig_get,1,"catWorkerCreatePos")
local posIndex
local count=#posList
if entity.finishCmdCount>0 then

local randomIndex=math.random(1,count)
posIndex=posList[randomIndex]
else

for i=1,count do
if posList[i]~=entity.createPosIndex then
posIndex=posList[i]
break
end
end
end

local posParam=cfgHelper.get1(cfg_wanbaoshanghuiposconfig_get,posIndex)
local pos
local orientation
if posParam then
pos={posParam.pos[1],posParam.pos[2]}
orientation=posParam.orientation
end

entity.bt:setSharedVar("targetPos1",pos)
entity.bt:setSharedVar("orientation1",orientation)
end


function wanBaoShangHuiController:finishAllCatWorkerCMD()
if not self.data.entityList then
return
end

for guid,entity in pairs(self.data.entityList)do
wanBaoShangHuiController:finishBehaviorCMD(guid)






end
end
