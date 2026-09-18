local _rsObj={}

function emergenciesControl:refreshEvent_YiShiLaiKe()
local eventData=emergenciesModel:getEventData()or{}
local eventId=emergenciesModel:getCurrentEventId()

self:stopAllCreateTimer()
for i,v in ipairs(eventData)do
local cur=v.param_1
local eventGroupId=v.param_2
local npcId=v.param_3

if cur==0 then
local func=function()
self:createAdventureNpc(eventId,npcId,eventGroupId,i)
self.YSLKtimer[i]=nil
end
emergenciesControl:startCreateTimer(i,func)
end
end
end

function emergenciesControl:stopAllCreateTimer()
if self.YSLKtimer==nil then return end
for k,v in pairs(self.YSLKtimer)do
v:cancel()
end
self.YSLKtimer={}
end

function emergenciesControl:startCreateTimer(idx,func)
emergenciesControl:stopCreateTimer(idx)
if self.YSLKtimer==nil then self.YSLKtimer={}end
self.YSLKtimer[idx]=timer.new()
self.YSLKtimer[idx]:start(0.1,func,1)
end

function emergenciesControl:stopCreateTimer(idx)
if self.YSLKtimer==nil then return end
if self.YSLKtimer[idx]==nil then return end
self.YSLKtimer[idx]:calcel()
self.YSLKtimer[idx]=nil
end

function emergenciesControl:clear_YiShiLaiKe()
self:removeLaiKe()
emergenciesModel:closeAdventureEventWin()
end

function emergenciesControl:getEventCount_YiShiLaiKe()
local cur=0
local max=emergenciesModel:getMaxCount()
for k,v in pairs(_rsObj)do
if v.cur==0 then
cur=cur+1
end
end





return cur,max
end

function emergenciesControl:moveCameraToEventPos_YiShiLaiKe(event)
for k,v in pairs(_rsObj)do
if v.cur==0 then
isometricMapSystem:moveCameraToObjectEx(v.obj,true)
end
end
end

function emergenciesControl:createAdventureNpc(event,npcId,eventGroupId,index)
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

local guid=isometricMapSystem:createRoleEntity(objectType.eYiShiLaiKe,mapId,0,body,slots,SortingLayers.ITBuilding,scale,pos)
local bt=behaviorManager:addBehaviorTree('ai_zmvistor_range_move',{stId=guid},true,{})
local offset=_MapManager.GetObjectHeadOffset(guid)
local hud
hud=hudControl:addHUD(INSTANCE_TYPE.eDiscipleState,guid,offset,true,true,function(id)
if hud==id then

local widget=hudControl:getHUDWidget(id)
widget:SetChildCSImageSprite(0,globalABLookup.hud_atlas,'icon_yishilaike')
widget:SetChildButtonClick(1,function()
emergenciesModel:setClickNpcId(index)
self:checkIsHasAdventureData(index)
end)
widget:SetChildActive(1,true)
else

hudControl:removeHUD(id)
end
end)

_rsObj[index]={
obj=guid,
hud=hud,
bt=bt,
cur=0,
}
end

function emergenciesControl:setLaiKeByIndex(index,cur)
_rsObj[index].cur=cur
end

function emergenciesControl:removeLaiKeByIndex(index)
emergenciesControl:stopCreateTimer(index)
if _rsObj[index]then
if _rsObj[index].hud then
hudControl:removeHUD(_rsObj[index].hud)
end
if _rsObj[index].bt then
behaviorManager:removeBehaviorTree(_rsObj[index].bt)
end
_MapManager.RemoveTilemapObject(_rsObj[index].obj)
_rsObj[index]=nil
emergenciesModel:setClickNpcId(0)
end
end

function emergenciesControl:removeLaiKe()
emergenciesControl:stopAllCreateTimer()
for k,v in pairs(_rsObj)do
if v then
if v.hud then
hudControl:removeHUD(v.hud)
end
if v.bt then
behaviorManager:removeBehaviorTree(v.bt)
end
_MapManager.RemoveTilemapObject(v.obj)
v=nil
end
end
_rsObj={}
end

function emergenciesControl:checkIsHasAdventureData(npcId)
local eventGroupId
local signData={6,10}
local AdventureData=emergenciesModel:getAdventureId(npcId)

if AdventureData then
eventGroupId=AdventureData.event_group_id
MysteryEventSystem.event_start(SYSTEM_DEFINE.eTuFaEvent,eventGroupId,{},{MysteryEventSendType.eYSLK,10,npcId})
else
socketManager:send_8_15(npcId)
end
end