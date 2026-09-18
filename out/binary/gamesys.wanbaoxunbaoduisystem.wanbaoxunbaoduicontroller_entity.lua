






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

function wanBaoXunBaoDuiController:onAppStart_entity()

end

function wanBaoXunBaoDuiController:onEnterState_entity()

end

function wanBaoXunBaoDuiController:onLeaveState_entity()
end

function wanBaoXunBaoDuiController:createCatWorker()
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
wanBaoXunBaoDuiController:createCatWorkerEntity(createPosIndex)
end

function wanBaoXunBaoDuiController:createCatWorkerEntity(posIndex)
local posParam=cfgHelper.get1(cfg_wanbaoxunbaoduiposconfig_get,posIndex)
local pos
if posParam then
pos=_MapManager.ToVector3Int(posParam.pos[1],posParam.pos[2],0)
else



return
end

local cfg=cfgHelper.get1(cfg_wanbaoxunbaoduibaseconfig_get,1)
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
controllerName='wanBaoXunBaoDuiController'
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
controllerName='wanBaoXunBaoDuiController'
}
end


function wanBaoXunBaoDuiController:clearCatWorkerAllEntity()
if not self.data.entityList then
return
end

for guid,_ in pairs(self.data.entityList)do
wanBaoXunBaoDuiController:clearCatWorkerEntityByGuid(guid)
end
end

function wanBaoXunBaoDuiController:clearCatWorkerEntityByGuid(guid)
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


function wanBaoXunBaoDuiController:startCreateCatWorkerTimer()


wanBaoXunBaoDuiController:clearCreateCatWorkerTimer()
wanBaoXunBaoDuiController:initCreateCatWorkerData()
local fun=function()
if not isometricMapSystem:isInNormalMode()then

return
end
local nowTime=gameUtilityModel.getServerShortTime()
if self.data.checkTime<=nowTime then

if self.data.createCWCount<self.data.maxCreateCWCount then
wanBaoXunBaoDuiController:createCatWorker()


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

function wanBaoXunBaoDuiController:initCreateCatWorkerData()
self.data.checkTime=0
self.data.createCWCount=0
local baseCfg=cfgHelper.get1(cfg_wanbaoxunbaoduibaseconfig_get,1)
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

local cmdCfg=cfg_wanbaoxunbaoduibehaviorconfig()
self.cmdPool={}
for i=1,#cmdCfg do
self.cmdPool[#self.cmdPool+1]=cmdCfg[i].id
end
end



function wanBaoXunBaoDuiController:clearCreateCatWorkerTimer()
if self.createCWTimer then
self.createCWTimer:cancel()
self.createCWTimer=nil
end
end


function wanBaoXunBaoDuiController:stopCreateCatWorker()
wanBaoXunBaoDuiController:clearCreateCatWorkerTimer()
wanBaoXunBaoDuiController:clearCatWorkerAllEntity()
end



function wanBaoXunBaoDuiController:changeEntityOrientation(entityGuid,orientation,pos)
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


function wanBaoXunBaoDuiController:finishCreateEntity(entityGuid,posIndex)
self.data.canUseCreatePosList[#self.data.canUseCreatePosList+1]=posIndex
end


function wanBaoXunBaoDuiController:finishBehaviorCMD(entityGuid)
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
controllerName='wanBaoXunBaoDuiController'
}
local bt=behaviorManager:addBehaviorTree('ai_catwoker_wait',{stId=entity.guid},true,btData)
entity.bt=bt
end


function wanBaoXunBaoDuiController:getNextBehaviorCMD(entityGuid)
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


local cmdCfg=cfgHelper.get1(cfg_wanbaoxunbaoduibehaviorconfig_get,cmdId)
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

local posParam=cfgHelper.get1(cfg_wanbaoxunbaoduiposconfig_get,posIndex)
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
controllerName='wanBaoXunBaoDuiController'
}

local bt=behaviorManager:addBehaviorTree(cmdName,{stId=entity.guid},true,btData)
entity.bt=bt
entity.cmdId=cmdId
end


function wanBaoXunBaoDuiController:finishBehaviorCMDAndRemoveEntity(entityGuid)
local entity=self.data.entityList[entityGuid]
if not entity then
return
end

if entity.cmdId then

self.cmdPool[#self.cmdPool+1]=entity.cmdId
entity.cmdId=nil
end


wanBaoXunBaoDuiController:clearCatWorkerEntityByGuid(entityGuid)
end


function wanBaoXunBaoDuiController:getSpeakContentByType(entityGuid,type,tkey)
local entity=self.data.entityList[entityGuid]
if not entity then
return
end

local typeCfgName=speakType[type]
if not typeCfgName then



return
end

local speakCfg=cfgHelper.get2(cfg_wanbaoxunbaoduibaseconfig_get,1,typeCfgName)
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


function wanBaoXunBaoDuiController:getBackShangHuiRelaxPos(entityGuid)
local entity=self.data.entityList[entityGuid]
if not entity then
return
end

local posList=cfgHelper.get2(cfg_wanbaoxunbaoduibaseconfig_get,1,"catWorkerCreatePos")
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

local posParam=cfgHelper.get1(cfg_wanbaoxunbaoduiposconfig_get,posIndex)
local pos
local orientation
if posParam then
pos={posParam.pos[1],posParam.pos[2]}
orientation=posParam.orientation
end

entity.bt:setSharedVar("targetPos1",pos)
entity.bt:setSharedVar("orientation1",orientation)
end



function wanBaoXunBaoDuiController:initChannelEntity()

local args={type=SLG_SYSTEM_TYPE.eTanXianDui}
local data,mountid,buildid=zongmenControl:getBuilding(args,false)
if data and data.flag==0 then
local channelDatas=wanBaoXunBaoDuiModel:getChannelDatas()

self.shipEntityList={}

self.delayList={}

for k,channelData in pairs(channelDatas)do
if channelData.open_state then

wanBaoXunBaoDuiController:createShip(channelData)
end
end
end
end

function wanBaoXunBaoDuiController:freshShipState(channel_id,isreturn)
local channelData=wanBaoXunBaoDuiModel:getChannelDataById(channel_id)

local temp=self.shipEntityList[channelData.channel_Id]

if temp then
wanBaoXunBaoDuiController:removeShipEntity(channel_id,temp.guid)
end

self.delayList[channel_id]=nil
wanBaoXunBaoDuiController:createShip(channelData,isreturn)
end


function wanBaoXunBaoDuiController:createShip(channel_data,isreturn)
if not mainControl:isInScene(eSceneType.eZongmen)then return end
if channel_data.open_state then
local cfg=cfgHelper.get1(cfg_wanbaoxunbaoduishipbehaviorconfig_get,channel_data.channel_Id)
local shipmodelidList=cfg.shipmodelidList

local pos
local mainModelId
local mainComponents={}
local subModelId
local scale=cfg.scale
local animatid=eAnimationID.stand

if channel_data.channel_state==WBXBD_Channel_STATE.idle then
mainModelId=shipmodelidList[1]
elseif channel_data.channel_state==WBXBD_Channel_STATE.preparing then
if channel_data.employeeLen>0 then
local _,catguid=next(channel_data.employeeList)
local catdata=wanBaoXunBaoDuiModel:getCatData(catguid)
mainModelId,mainComponents=wanbaoXunBaoDuiHelper:getCatModelParam(catdata,2)
subModelId=shipmodelidList[1]
else
mainModelId=shipmodelidList[1]
end
elseif channel_data.channel_state==WBXBD_Channel_STATE.doing then
if isreturn~=nil then
if channel_data.employeeLen>0 then
local _,catguid=next(channel_data.employeeList)
local catdata=wanBaoXunBaoDuiModel:getCatData(catguid)
mainModelId,mainComponents=wanbaoXunBaoDuiHelper:getCatModelParam(catdata,2)
subModelId=shipmodelidList[1]
else
mainModelId=shipmodelidList[1]
end
end
elseif channel_data.channel_state==WBXBD_Channel_STATE.done or channel_data.channel_state==WBXBD_Channel_STATE.finish then
local _,catguid=next(channel_data.employeeList)
local catdata=wanBaoXunBaoDuiModel:getCatData(catguid)
mainModelId,mainComponents=wanbaoXunBaoDuiHelper:getCatModelParam(catdata,2)
subModelId=shipmodelidList[2]
elseif channel_data.channel_state==WBXBD_Channel_STATE.early_return then





subModelId=shipmodelidList[3]
local _,catguid=next(channel_data.employeeList)
local catdata=wanBaoXunBaoDuiModel:getCatData(catguid)
mainModelId,mainComponents=wanbaoXunBaoDuiHelper:getCatModelParam(catdata,2)
end

if isreturn then
pos=cfg.pos2
else
pos=cfg.pos1
end

if pos then
pos=_MapManager.ToVector3Int(pos[1],pos[2],0)
end

if mainModelId then
local hideColor=Color.New(1,1,1,0)
local showColor=Color.New(1,1,1,1)
local guid=isometricMapSystem:createRoleEntity(objectType.eTanXianDuiShip,mapIdType.zhufeng,0,mainModelId,mainComponents,SortingLayers.ITBuilding,scale,pos)
local entity=_EntityManager:GetEntity(guid)

if subModelId then
entity:Mount(subModelId,{},'mao',scale,Vector3.New(0,0,10),nil)
end

entity:SetFlipX(cfg.flipX==-1)

_MapManager.RunAnimator(guid,animatid)
_MapManager.SetFadeToColor(guid,hideColor,0,nil)
_MapManager.SetFadeToColor(guid,showColor,0.2,nil)

_MapManager.ShowShadow(guid,true)

local temp={
guid=guid,
pos=pos,
}
self.shipEntityList[channel_data.channel_Id]=temp

end
end
end

function wanBaoXunBaoDuiController:removeShipEntity(channel_id,guid)
_MapManager.RemoveTilemapObject(guid)
self.shipEntityList[channel_id]=nil
end

function wanBaoXunBaoDuiController:clearAllShip()
wanBaoXunBaoDuiController:clearShipEntity()
wanBaoXunBaoDuiController:clearDelayList()
end

function wanBaoXunBaoDuiController:clearShipEntity()
for k,data in pairs(self.shipEntityList or{})do
_MapManager.RemoveTilemapObject(data.guid)
end
self.shipEntityList={}
end

function wanBaoXunBaoDuiController:clearDelayList()
self.delayList={}
end

function wanBaoXunBaoDuiController:delayFresh()
for channel_id,state in pairs(self.delayList or{})do
if state then
if state==1 then
wanBaoXunBaoDuiController:doShipGo(channel_id)
elseif state==2 then
wanBaoXunBaoDuiController:doShipReturn(channel_id)
elseif state==3 then
wanBaoXunBaoDuiController:freshShipState(channel_id)
end
end
end
end

function wanBaoXunBaoDuiController:setDelayList(channel_id,state)
self.delayList[channel_id]=state
end

function wanBaoXunBaoDuiController:getDelayList(channel_id)
return self.delayList[channel_id]or-1
end

function wanBaoXunBaoDuiController:doShipGo(channel_id)
if not mainControl:isInScene(eSceneType.eZongmen)then return end

local pos=cfgHelper.get2(cfg_wanbaoxunbaoduishipbehaviorconfig_get,channel_id,'pos2')

wanBaoXunBaoDuiController:freshShipState(channel_id,false)
local temp=self.shipEntityList[channel_id]

local callback=function()

local hideColor=Color.New(1,1,1,0)
_MapManager.SetFadeToColor(temp.guid,hideColor,1,function()
wanBaoXunBaoDuiController:removeShipEntity(channel_id,temp.guid)
end)
end
local stepCB=function()end
local speed=cfgHelper.get2(cfg_wanbaoxunbaoduishipbehaviorconfig_get,channel_id,'speed')

if pos then
pos=_MapManager.ToVector3Int(pos[1],pos[2],0)
end

_MapManager.MoveToPosition(temp.guid,pos,callback,stepCB,speed,-1)
end

function wanBaoXunBaoDuiController:doShipReturn(channel_id)
if not mainControl:isInScene(eSceneType.eZongmen)then return end

local pos=cfgHelper.get2(cfg_wanbaoxunbaoduishipbehaviorconfig_get,channel_id,'pos1')

wanBaoXunBaoDuiController:freshShipState(channel_id,true)

local temp=self.shipEntityList[channel_id]
if pos then
pos=_MapManager.ToVector3Int(pos[1],pos[2],0)
end

local callback=function()end
local stepCB=function()end
local speed=cfgHelper.get2(cfg_wanbaoxunbaoduishipbehaviorconfig_get,channel_id,'speed')

_MapManager.MoveToPosition(temp.guid,pos,callback,stepCB,speed,-1)
end


function wanBaoXunBaoDuiController.onWanBaoXunBaoDuiGoAdventure(channel_id)
wanBaoXunBaoDuiController:setDelayList(channel_id,1)
end


function wanBaoXunBaoDuiController.onWanBaoXunBaoDuiAdventureReturn(channel_data)
if not isometricMapSystem:IsInHome()then

return
end

local channelid=channel_data.channel_Id

if wanBaoXunBaoDuiController:getDelayList(channelid)==1 then
wanBaoXunBaoDuiController:setDelayList(channelid,2)
else

if fullScreenUI.checkFull(UIFullWanBaoXunBaoDuiController)then
wanBaoXunBaoDuiController:setDelayList(channelid,2)
else

wanBaoXunBaoDuiController:doShipReturn(channelid)
end
end
end

function wanBaoXunBaoDuiController.onCloseUI(winName)
if winName=='UIWanBaoXunBaoDui_MenuWin'then

wanBaoXunBaoDuiController:delayFresh()
end
end

function wanBaoXunBaoDuiController:finishAllCatWorkerCMD()
if not self.data.entityList then
return
end

for guid,entity in pairs(self.data.entityList)do
wanBaoXunBaoDuiController:finishBehaviorCMD(guid)






end
end

function wanBaoXunBaoDuiController:testFindPath()
local bpos=_MapManager.ToVector3Int(-52,-40,0)
local epos=_MapManager.ToVector3Int(-47,-41,0)
local path=_MapManager.FindPath(1,bpos,epos,5)

end

