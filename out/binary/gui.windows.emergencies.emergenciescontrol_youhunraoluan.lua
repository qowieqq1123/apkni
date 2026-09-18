local _ghostObj={}
local _ghostMax=0
local isShowClickTips=false
local _cameraShakeTweener=nil

function emergenciesControl:refreshEvent_YouHunRaoLuan()
local eventData=emergenciesModel:getEventData()or{}
local eventId=emergenciesModel:getCurrentEventId()
emergenciesModel:setGhostData(eventId,eventData)

emergenciesModel:initGhostCreateAreaList()

emergenciesModel:initGhostFirstSelectPosList()
for i=1,#eventData do
if not emergenciesModel:isDead_Ghost(i)then
self:createGhost(i,eventId)
end
end
end

function emergenciesControl:clear_YouHunRaoLuan()
for i,v in pairs(_ghostObj)do
local stateId=v.bt:getSharedVar("stateId")
if stateId~=1 then
emergenciesControl:removeGhost(i)
end
end
_ghostMax=0
end

function emergenciesControl:getEventCount_YouHunRaoLuan()
local eventId=emergenciesModel:getCurrentEventId()
local eventCfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,eventId)
local event_conf=eventCfg.event_conf
local max=event_conf.ghost[1]

local cur=emergenciesModel:countGhostSurvive()
return cur,max
end

function emergenciesControl:onClickEventWin_YouHunRaoLuan(event)























local args={
info=ruleTipsImageGroup.eYouHunRaoLuan
}
UIManager:showWindow("UIRuleTipsImageWin",args)
end


function emergenciesControl:createGhost(dataIndex,eId)
local eventId=eId or emergenciesModel:getCurrentEventId()
local eventCfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,eventId)
local mapId=mapIdType.zhufeng
local sundriesModel=eventCfg.event_conf.sundriesId
local sundriesCfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,sundriesModel)
local body=sundriesCfg.model[1]
local slots=sundriesCfg.model[2]or{}
local scale=isometricMapSystem:getModelScale(body)
local isSmall=true




local pos=emergenciesModel:getGhostCreatePos()
local guid=isometricMapSystem:createRoleEntity(objectType.eMovementSundrise,mapId,0,body,slots,SortingLayers.ITBuilding,scale,pos,nil,isSmall)
local btData={
stateId=0,
dataIndex=dataIndex,
deadSpeakStr='',
}
local bt=behaviorManager:addBehaviorTree('ai_ghost',{stId=guid},true,btData)
local index=_ghostMax+1
for i=1,_ghostMax do
if _ghostObj[i]==nil then
index=i
break
end
end
local entity={
index=index,
dataIndex=dataIndex,
obj=guid,
bt=bt,
eventId=eventId,
modelId=body,
}
_ghostObj[dataIndex]=entity
_ghostMax=math.max(_ghostMax,index)
end

function emergenciesControl:getGhost(dataIndex)
return _ghostObj[dataIndex]
end

function emergenciesControl:removeGhostHUD(dataIndex)
local entity=_ghostObj[dataIndex]
if entity then
if entity.hud then
hudControl:removeHUD(entity.hud)
end
end
end

function emergenciesControl:removeGhost(dataIndex)
local entity=_ghostObj[dataIndex]
if entity then
if entity.bt then
behaviorManager:removeBehaviorTree(entity.bt)
end
if entity.hud then
hudControl:removeHUD(entity.hud)
end







_MapManager.RemoveTilemapObject(entity.obj)
_ghostObj[dataIndex]=nil
end
end

function emergenciesControl:killGhost(dataIndex)
local entity=_ghostObj[dataIndex]
if entity then


local stateId=entity.bt:getSharedVar("stateId")
entity.bt:setSharedVar("stateId",1)
entity.bt:broke()
entity.bt:reset()






self:createImprisonGhostModel(dataIndex)
end
end

function emergenciesControl:createImprisonGhostModel(dataIndex)
local entity=_ghostObj[dataIndex]
if entity then





























local effectId=10338

local offset={0,0,0}
_MapManager.PlayEffect(entity.obj,effectId,Vector3.New(offset[1],offset[2],offset[3]),true,true)

timeEventController.delayDo(1,function()
local cameraTrans=_MapManager.GetCameraTransform()
local duration=0.3
emergenciesControl:stopCameraShakeTweener_youhunraoluan()
_cameraShakeTweener=_DOTweenProxy.DOShakeRotation(cameraTrans,duration,1,15,0,false)
end)
end
end

function emergenciesControl:stopCameraShakeTweener_youhunraoluan()
if _cameraShakeTweener then
_cameraShakeTweener:Kill()
_cameraShakeTweener=nil
end
end

function emergenciesControl:refreshGhostHUD(dataIndex)
local entity=_ghostObj[dataIndex]
if entity then
local hud=hudControl:getHUDWidget(entity.hud)
local items=hud:GetChildLayoutGroupGridList(0)







end
end

function emergenciesControl:findGhost(guid)
for i,v in pairs(_ghostObj)do
if mathHelper.compareInt64(v.obj,guid)then
return v
end
end
end





function emergenciesControl:onClickGhost(guid)
local obj=emergenciesControl:findGhost(guid)
if not obj then
return false
end







local stateId=obj.bt:getSharedVar("stateId")
if stateId==0 then

obj.bt:setSharedVar("stateId",-1)
obj.bt:broke()
obj.bt:reset()

local dataIndex=obj.dataIndex

self:killGhost(dataIndex)


timeEventController.delayDo(1.9,function()
emergenciesControl:reqClickGhost(dataIndex)
end)
end

return
end

function emergenciesControl:checkIsGhost(guid)
local obj=emergenciesControl:findGhost(guid)
if obj then
return true
end

return false
end


function emergenciesControl:showGhostDeadSpeak(dataIndex)
local entity=_ghostObj[dataIndex]
if not entity then
return
end
local speakContent=self:getGhostDeadSpeakContent(dataIndex)
local modelId=entity.modelId
local headPos=cfgHelper.get2(cfg_dbbodyconfig_get,modelId,'headPos')or{0,0}
local offset=Vector3.New(headPos[1],headPos[2],0)
hudControl:addHUD(INSTANCE_TYPE.eGhostSpeakHUD,entity.obj,offset,true,true,function(id)
if entity then
entity.hud=id
local isFlip=_MapManager.IsFlip(entity.obj)
local widget=hudControl:getHUDWidget(id)
widget:SetChildText(0,chatEmotHelper.decodeEmot(speakContent))
local skin=2
local abName,skinName=discipleStateManager:getSpeakSkinInfoById(skin)
widget:SetChildCSImageSprite(1,abName,skinName)
widget:SetChildScale(1,Vector3.New(isFlip and 1 or-1,1,1))
local originalPos=widget:GetChildAnchoredPosition(2)
local pivot=Vector2.New(isFlip and 1 or 0,0)
widget:SetChildPivot(2,pivot)
widget:SetChildAnchoredPos(2,isFlip and-originalPos.x or originalPos.x,originalPos.y)
end
end)
end


function emergenciesControl:getGhostDeadSpeakContent(dataIndex)
local entity=_ghostObj[dataIndex]
if not entity then
return
end

local eventId=entity.eventId or emergenciesModel:getCurrentEventId()
local eventCfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,eventId)
local speakList=eventCfg.event_conf.ghostDeadSpeak
if not speakList or not next(speakList)then
logErr(FMT.fmt("突发事件id{0}对应的配置中 找不到ghostDeadSpeak配置（鬼魂死亡说话），请确认配置与程序逻辑是否正确",eventId))
return
end

local count=#speakList
local speakContent
if count>1 then

local randomIndex=math.random(1,count)
speakContent=speakList[randomIndex]
else

speakContent=speakList[1]
end


return speakContent
end


function emergenciesControl:test_showClickTips()
isShowClickTips=not isShowClickTips
end
