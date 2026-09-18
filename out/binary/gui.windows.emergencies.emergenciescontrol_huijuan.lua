local _rsObj={}

emergenciesControl_HuiJuan={}

function emergenciesControl_HuiJuan:createNPC(subid,isGot,endTime)
if _rsObj[subid]then

return
end

local subConfig=cfg_longhuhuijuanconfig_get(subid)
local npcId=subConfig.npcId or 4001

local now=timeHelper.getServerShortTime()

if now>=endTime then
return
end


if isGot==1 then
return
end

local sundriesModel=npcId
local sundriesCfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,sundriesModel)
local mapId=mapIdType.zhufeng
local body=sundriesCfg.model[1]
local slots=sundriesCfg.model[2]or{}
local pos
local scale=sundriesCfg.modeloffset[3]
local cfgId=sundriseCreateControl:getPlaceConfig(sundriesModel)

local cpos=cfgHelper.get2(cfg_monijyrandomitemconfig_get,sundriesModel,'createPos')
if cpos then
pos=_MapManager.ToVector3Int(cpos[1],cpos[2],0)
else
local list=_MapManager.GetMapAreaPosByConfig(mapIdType.zhufeng,-2,cfgId)
pos=_MapManager.ToVector3Int(0,0,0)

if list.Count>0 then
local r=math.random(1,list.Count)
pos=list[r-1]
end
end


local guid=isometricMapSystem:createRoleEntity(objectType.eYiShiLaiKe,mapId,0,body,slots,SortingLayers.ITBuilding,scale,pos)
local bt=behaviorManager:addBehaviorTree('ai_zmvistor_lhhj',{stId=guid},true,{stateId=0})
local offset=_MapManager.GetObjectHeadOffset(guid)
local hud=hudControl:addHUD(INSTANCE_TYPE.eDiscipleState,guid,offset,true,true,function(id)
local widget=hudControl:getHUDWidget(id)
widget:SetChildCSImageSprite(0,globalABLookup.hud_atlas,'icon_fangshigx')
widget:SetChildButtonClick(1,function()
if bt then
bt:reset()
bt:setSharedVar("stateId",1)
end
storyAICommonManager:setBehaviorName("ai_zmvistor_lhhj")
storyAICommonManager:setBehaviorFunctionEndCallBack(function()
local now=timeHelper.getServerShortTime()
if _rsObj[subid]and now<_rsObj[subid].endTime then
socketManager:send_22_10()
else
UIManager.error("已过期")
end
emergenciesControl_HuiJuan:removeHuiJuan(subid)
end)
end)
widget:SetChildActive(1,true)
end)



_rsObj[subid]={
obj=guid,
hud=hud,
bt=bt,
endTime=endTime,
}
end


function emergenciesControl_HuiJuan:removeHuiJuan(subid)
local v=_rsObj[subid]
if v then
if v.bt then
behaviorManager:removeBehaviorTree(v.bt)
end
_MapManager.RemoveTilemapObject(v.obj)
v=nil
end
end

function emergenciesControl_HuiJuan:exeNPCClick(subid,lookAt)
local npc=_rsObj[subid]
if npc then
local cb=function()
local bt=npc.bt
if bt then
bt:reset()
bt:setSharedVar("stateId",1)
end
storyAICommonManager:setBehaviorName("ai_zmvistor_lhhj")
storyAICommonManager:setBehaviorFunctionEndCallBack(function()
local now=timeHelper.getServerShortTime()
if _rsObj[subid]and now<_rsObj[subid].endTime then
socketManager:send_22_10()
else
UIManager.error("已过期")
end
emergenciesControl_HuiJuan:removeHuiJuan(subid)
end)
end

if lookAt then
isometricMapSystem:moveCameraToObject(npc.obj,true,function()
cb()
end,0.5,nil)
else
cb()
end


end
end

function emergenciesControl_HuiJuan:clearHuiJuan()
if _rsObj then
for i,v in pairs(_rsObj)do
if v.bt then
behaviorManager:removeBehaviorTree(v.bt)
end
end
end
_rsObj={}
end

function emergenciesControl_HuiJuan:initNPC()
if self.NPCData then
for i,v in pairs(self.NPCData)do
emergenciesControl_HuiJuan:createNPC(i,v.isGot,v.endTime)
end
end
end

function emergenciesControl_HuiJuan:removeAllNPC()
for i,v in pairs(_rsObj)do
if v.bt then
behaviorManager:removeBehaviorTree(v.bt)
end
_MapManager.RemoveTilemapObject(v.obj)
end
_rsObj={}
end

function emergenciesControl_HuiJuan:setNPCData(subid,isGot,endTime)
self.NPCData=self.NPCData or{}
self.NPCData[subid]={isGot=isGot,endTime=endTime}
end

function emergenciesControl_HuiJuan:updateNPCEndTime(subid,endTime)
self.NPCData=self.NPCData or{}
if self.NPCData[subid]then
self.NPCData[subid].endTime=endTime
end
end

function emergenciesControl_HuiJuan:removeNPCData(subid)
self.NPCData=self.NPCData or{}
self.NPCData[subid]=nil
end


function emergenciesControl_HuiJuan:getNPCData(subid)
if self.NPCData then
return self.NPCData[subid]
end
end

function emergenciesControl_HuiJuan:getAllNPCData()
return self.NPCData
end

function emergenciesControl_HuiJuan:print()
for i,v in pairs(_rsObj)do

end

end
