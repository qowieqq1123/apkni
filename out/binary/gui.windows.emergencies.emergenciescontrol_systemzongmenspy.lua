local _rsObj={}

local RecordSystemZMSerial

function emergenciesControl:refreshEvent_SystemZongMenSpy()
local eventData=emergenciesModel:getEventData()or{}
local eventId=emergenciesModel:getCurrentEventId()

self:stopAllCreateTimer_ZongMenSpy()
for i,v in ipairs(eventData)do
local cur=v.param_1
local npcId=v.param_2
RecordSystemZMSerial=v.param_3
if cur==0 then
local func=function()
self:createAdventureNpc_ZongMenSpy(eventId,npcId,RecordSystemZMSerial,i)
self.JXSJtimer[i]=nil
end
emergenciesControl:startCreateTimer_ZongMenSpy(i,func)
end
end
end


function emergenciesControl:clear_SystemZongMenSpy(result,isLeaveHome)
emergenciesControl:removeZongMenSpy()
end


function emergenciesControl:getEventCount_SystemZongMenSpy()
local eventData=emergenciesModel:getEventData()or{}
local max=#eventData

local cur=emergenciesModel:ZongMenSpyEventDataCurCount()
return cur,max
end

function emergenciesControl:stopAllCreateTimer_ZongMenSpy()
if self.JXSJtimer==nil then return end
for k,v in pairs(self.JXSJtimer)do
v:cancel()
end
self.JXSJtimer={}
end


function emergenciesControl:startCreateTimer_ZongMenSpy(idx,func)
emergenciesControl:stopCreateTimer_ZongMenSpy(idx)
if self.JXSJtimer==nil then self.JXSJtimer={}end
self.JXSJtimer[idx]=timer.new()
self.JXSJtimer[idx]:start(0.1,func,1)
end

function emergenciesControl:stopCreateTimer_ZongMenSpy(idx)
if self.JXSJtimer==nil then return end
if self.JXSJtimer[idx]==nil then return end
self.JXSJtimer[idx]:calcel()
self.JXSJtimer[idx]=nil
end


function emergenciesControl:createAdventureNpc_ZongMenSpy(event,npcId,systemZMId,index)
local sundriesModel=npcId
local sundriesCfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,sundriesModel)
local mapId=mapIdType.zhufeng
local body=sundriesCfg.model[1]
local slots=sundriesCfg.model[2]or{}

local scale=sundriesCfg.modeloffset[3]
local cfgId=sundriseCreateControl:getPlaceConfig(sundriesModel)
local list=_MapManager.GetMapAreaPosByConfig(mapIdType.zhufeng,-2,cfgId)
local pos=_MapManager.ToVector3Int(0,0,0)

if list.Count>0 then
local r=math.random(1,list.Count)
pos=list[r-1]
end

local guid=isometricMapSystem:createRoleEntity(objectType.eZongMenSpy,mapId,0,body,slots,SortingLayers.ITBuilding,scale,pos)
local bt=behaviorManager:addBehaviorTree('ai_zongMenSpy',{stId=guid},true,{stateId=0,dataIndex=index,})

_rsObj[index]={
index=index,
obj=guid,
bt=bt,
cur=0,
}
end


function emergenciesControl:removeZongMenSpyByIndex(index)
emergenciesControl:stopCreateTimer_ZongMenSpy(index)
if _rsObj[index]then
if _rsObj[index].bt then
behaviorManager:removeBehaviorTree(_rsObj[index].bt)
end
_MapManager.RemoveTilemapObject(_rsObj[index].obj)
_rsObj[index]=nil
end
end

function emergenciesControl:removeZongMenSpy()
emergenciesControl:stopAllCreateTimer_ZongMenSpy()
for k,v in pairs(_rsObj)do
if v then
if v.bt then
behaviorManager:removeBehaviorTree(v.bt)
end
_MapManager.RemoveTilemapObject(v.obj)
v=nil
end
end
_rsObj={}
end

function emergenciesControl:onClickEventWin_SystemZongMenSpy(event)

local args={
info=ruleTipsImageGroup.eSystemZongMenSpy
}
UIManager:showWindow("UIRuleTipsImageWin",args)
end


function emergenciesControl:onClickZongMenSpy(guid)
local entity=emergenciesControl:findZongMenSpyObj(guid)
if entity then
local stateId=entity.bt:getSharedVar("stateId")
if stateId==0 then
entity.bt:setSharedVar("stateId",1)
entity.bt:broke()
entity.bt:reset()

timeEventController.delayDo(1.9,function()
emergenciesControl:reqClickZongMenSpy(entity.index)
end)
return true
end
end
return false
end



function emergenciesControl:showZongMenSpyDeadSpeak(dataIndex)
local entity=_rsObj[dataIndex]
if not entity then
return
end
local eventId=entity.eventId or emergenciesModel:getCurrentEventId()
local eventCfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,eventId)
local speakList=eventCfg.event_conf.ghostDeadSpeak
if not speakList or not next(speakList)then
return
end
local speakContent=self:getZongMenSpyDeadSpeakContent(dataIndex)
local headPos={0.25,0.51}
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


function emergenciesControl:getZongMenSpyDeadSpeakContent(dataIndex)
local entity=_rsObj[dataIndex]
if not entity then
return
end
local eventId=entity.eventId or emergenciesModel:getCurrentEventId()
local eventCfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,eventId)
local speakList=eventCfg.event_conf.ghostDeadSpeak
if not speakList or not next(speakList)then
return
end
if not speakList or not next(speakList)then
logErr(FMT.fmt("突发事件id{0}对应的配置中 找不到ghostDeadSpeak配置，请确认配置与程序逻辑是否正确",eventId))
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

function emergenciesControl:removeZongMenSpyHUD(dataIndex)
local entity=_rsObj[dataIndex]
if entity then
if entity.hud then
hudControl:removeHUD(entity.hud)
end
end
end

function emergenciesControl:findZongMenSpyObj(guid)
for i,v in pairs(_rsObj)do
if v.obj==guid then
return v
end
end
end


function emergenciesControl:getSystemZongMenSpyName()
if RecordSystemZMSerial then
return systemZongMenModel.getSystemZongMenName(RecordSystemZMSerial)
end
end


