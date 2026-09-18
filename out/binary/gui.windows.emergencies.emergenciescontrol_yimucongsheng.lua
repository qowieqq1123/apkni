local _clObj={}

function emergenciesControl:refreshEvent_YiMuCongSheng()
local eventData=emergenciesModel:getEventData()or{}
local eventId=emergenciesModel:getCurrentEventId()
emergenciesModel:setCaoLingData(eventId,eventData)
for i=1,#eventData do
if not emergenciesModel:isDead_CaoLing(i)then
self:createCaoLing(i,eventId)
end
end
emergenciesModel:refreshEvent_YiMuCongSheng()
emergenciesControl:playAllCreeper()

if next(_clObj)==nil then
UIManager:invokeUIMethod('UIMain','setEventTips',"清除杂草后草灵会出现")
end
end

function emergenciesControl:clear_YiMuCongSheng(result,isLeaveHome)
for i,v in pairs(_clObj)do
emergenciesControl:removeCaoLing(i)
end

if isLeaveHome or result==0 then
local datas=emergenciesModel:getAllCreeper()
for i,v in pairs(datas)do
local bdData=zongmenModel:getBuildingData(i)
self:endCreeper(bdData)
end
emergenciesModel:clearAllCreeper()
self.needCreateCaoLingIdxList=nil
end

UIManager:invokeUIMethod('UIMain','setEventTips')
end

function emergenciesControl:getEventCount_YiMuCongSheng()
local eventId=emergenciesModel:getCurrentEventId()
local eventCfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,eventId)
local event_conf=eventCfg.event_conf
local max=event_conf.plant[3]
local cur=emergenciesModel:countCaoLingDead()
return max-cur,max
end

function emergenciesControl:moveCameraToEventPos_YiMuCongSheng(event)
self:showRuleTips()




















end

function emergenciesControl:createCaoLing(index,eId)
local eventId=eId or emergenciesModel:getCurrentEventId()
local eventCfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,eventId)
local sundriesModel=eventCfg.event_conf.plant[4]
local sundriesCfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,sundriesModel)
local mapId=mapIdType.zhufeng
local body=sundriesCfg.model[1]
local slots=sundriesCfg.model[2]or{}
local scale=isometricMapSystem:getModelScale(body)










local pos=emergenciesModel:getCaoLingCreatePos()

local guid=isometricMapSystem:createRoleEntity(objectType.eMovementSundrise,mapId,0,body,slots,SortingLayers.ITBuilding,scale,pos)
local btData={
stId=guid,
stateId=0,
pathCheckId=7,
index=index,
}
local bt=behaviorManager:addBehaviorTree('ai_caoling',{stId=guid},true,btData)
local offset=_MapManager.GetObjectHeadOffset(guid)
local hud=hudControl:addHUD(INSTANCE_TYPE.eCaoLing,guid,offset,true,true,function(id)
local widget=hudControl:getHUDWidget(id)
local least=emergenciesModel:getLeastClick(index)
widget:SetChildLayoutGroupCreateItems(0,eventCfg.event_conf.plant[2],function(index)
local item=widget:GetChildLayoutGroupGridItem(0,index-1)
item:SetChildActive(-1,false)
end)
widget:SetChildButtonClick(1,function()
self:onClickCaoLing(guid)
end)
end)
local entity={
sundrie=sundriesModel,
index=index,
obj=guid,
hud=hud,
bt=bt,
}

if next(_clObj)==nil then
UIManager:invokeUIMethod('UIMain','setEventTips',"草灵已出现，尽快寻找并驱赶")
end

_clObj[index]=entity
end

function emergenciesControl:waitCreateCaoLing(idx)
if not self.needCreateCaoLingIdxList then
self.needCreateCaoLingIdxList={}
end
self.needCreateCaoLingIdxList[#self.needCreateCaoLingIdxList+1]=idx
end

function emergenciesControl:getCaoLing(index)
return _clObj[index]
end

function emergenciesControl:getAllCaoLing()
return _clObj
end

function emergenciesControl:removeCaoLing(index)
local entity=_clObj[index]
if entity then
if entity.bt then
behaviorManager:removeBehaviorTree(entity.bt)
end
if entity.hud then
hudControl:removeHUD(entity.hud)
end
_MapManager.RemoveTilemapObject(entity.obj)
_clObj[index]=nil

if next(_clObj)==nil then
UIManager:invokeUIMethod('UIMain','setEventTips',"清除杂草后草灵会出现")
end
end
end

function emergenciesControl:deadCaoLing(index)
local entity=_clObj[index]
if entity then
local bt=entity.bt
local stateId=bt:getSharedVar("stateId")
if stateId==1 then
bt:setSharedVar("stateId",3)
elseif stateId<=2 then
self:removeCaoLing(index)
end
end
end

function emergenciesControl:escapeCaoLing(index)
local entity=_clObj[index]
if entity then
local bt=entity.bt
local stateId=bt:getSharedVar("stateId")
bt:setSharedVar("stateId",2)
if stateId==0 then
bt:broke()
bt:reset()
end
end
end

function emergenciesControl:teleportCaoLing(index)
local entity=_clObj[index]
if entity then










local pos=emergenciesModel:getCaoLingCreatePos()
_MapManager.SetPosition(entity.obj,pos)
end
end

function emergenciesControl:refreshCaoLingHUD(idx)
local entity=_clObj[idx]
if entity then
local hud=hudControl:getHUDWidget(entity.hud)
local items=hud:GetChildLayoutGroupGridList(0)
local least=emergenciesModel:getLeastClick(idx)
for i=1,items.Count do
local item=items[i-1]
item:SetChildActive(-1,i<=least)
end
end
end

function emergenciesControl:findCaoLingObj(guid)
for i,v in pairs(_clObj)do
if v.obj==guid then
return v
end
end
end

function emergenciesControl:onClickCaoLing(guid)
local entity=emergenciesControl:findCaoLingObj(guid)
if entity then
local stateId=entity.bt:getSharedVar("stateId")
if stateId==0 then
emergenciesControl:reqClickCaoLing(entity.index)

entity.bt:setSharedVar("stateId",1)
entity.bt:broke()
entity.bt:reset()

emergenciesModel:clickCaoLing(entity.index)







end
return true
end
return false
end

function emergenciesControl:checkIsCaoLing(guid)
local entity=emergenciesControl:findCaoLingObj(guid)
if entity then
return true
end
return false
end

function emergenciesControl:startCreeper(bdData)
if emergenciesModel:isCreeper(bdData.un_build_id)then
buildingCDControl:addCDData(buildingCDType.chanrao,bdData)

if not isometricMapSystem:isInGroundModel()then
local eventId=emergenciesModel:getCurrentEventId()

if eventId>0 then
local eventCfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,eventId)
if eventCfg.event_type~=emergenciesType.eYiMuCongSheng then

eventId=emergenciesModel:getOldEventIdByType(emergenciesType.eYiMuCongSheng)
end
end

if eventId>0 then
local eventCfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,eventId)
local changeModel=eventCfg.event_conf.twine_model
if changeModel and changeModel[bdData.build_id]then
isometricMapSystem:changeBody(bdData.entityId,changeModel[bdData.build_id],{})
end
end
end

hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end

function emergenciesControl:endCreeper(bdData)
buildingCDControl:removeCDData(buildingCDType.chanrao,bdData.un_build_id)

isometricMapSystem:changeModel(bdData)

hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end

function emergenciesControl:playAllCreeper()
local datas=emergenciesModel:getAllCreeper()
for i,v in pairs(datas)do
local bdData=zongmenModel:getBuildingData(i)
self:startCreeper(bdData)
end
end

function emergenciesControl:stopAllCreeper()
local datas=emergenciesModel:getAllCreeper()
for i,v in pairs(datas)do
local bdData=zongmenModel:getBuildingData(i)
self:endCreeper(bdData)
end
end

function emergenciesControl:onBuildComplete_YiMuCongSheng(ubdId)
local bdData=zongmenModel:getBuildingData(ubdId)
local event=emergenciesModel:getCurrentEventId()
local isOver=emergenciesModel:hasHandleData()
local isInEvent_YMCS=false
if event>0 then
local eventCfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,event)
if eventCfg.event_type==emergenciesType.eYiMuCongSheng then
isInEvent_YMCS=true
end
end
if not isInEvent_YMCS and isOver then


event=emergenciesModel:getOldEventIdByType(emergenciesType.eYiMuCongSheng)
end
if event>0 then
local eventCfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,event)
if eventCfg and eventCfg.event_type==emergenciesType.eYiMuCongSheng then
if table.containsValue(eventCfg.event_conf.twine_builds,bdData.build_id)then
local endTime=emergenciesModel:getEndTime()
if isOver then
local deadCnt=emergenciesModel:countCaoLingDead()
if deadCnt>=eventCfg.event_conf.plant[3]then
return
end
endTime=endTime+eventCfg.event_conf.reduce_sec
end
emergenciesModel:addCreeper(ubdId,endTime)
emergenciesControl:startCreeper(bdData)
end
end
end
end

function emergenciesControl:onBuildRemove_YiMuCongSheng(ubdId)

local sfId=zongmenModel:getBuildingLocationMapId(ubdId)
local bdData=nil
if sfId==mapIdType.xianmeng then
bdData=xianmengModel:getStorageData(ubdId)
else
bdData=zongmenModel:getStorageBuilding(ubdId)
end
emergenciesModel:clearCreeper(ubdId)
if bdData then
self:endCreeper(bdData)
end
end

function emergenciesControl:animationCaoLingHUD(index,duration1,duration2,duration3,duration4)
local entity=_clObj[index]
if entity then
local widget=hudControl:getHUDWidget(entity.hud)
if widget==nil then return end

local least=emergenciesModel:getLeastClick(index)
local itemList=widget:GetChildLayoutGroupGridList(0)
for i=1,itemList.Count do
local item=itemList[i-1]
if i<=least+1 then
item:SetChildActive(-1,true)
item:SetChildColor(-1,Color.New(1,1,1,0))
item:SetChildScale(-1,Vector3.one)
local sequenceProxy=Lua.SequenceProxy.New()
sequenceProxy:Append(item:SetChildDOGraphicColor(-1,Color.white,duration1))
if i<=least then
sequenceProxy:AppendInterval(duration2)
sequenceProxy:Append(item:SetChildDOScale(-1,2,duration3))
sequenceProxy:Append(item:SetChildDOScale(-1,0,duration4))
else
sequenceProxy:Append(item:SetChildDOScale(-1,0,duration2))
sequenceProxy:AppendInterval(duration3+duration4)
end
sequenceProxy:AppendCallback(function()
item:SetChildActive(-1,false)
end)
else
item:SetChildActive(-1,false)
end
end
end
end

function emergenciesControl:showCaoLingTips()
local args={
delay=3,
str="草灵已出现，尽快寻找并驱赶",
image={"ui/windows/emergencies/sharedtextures/emergencies.ab","icon_shijiantft_0001"},
}
UIManager:showWindow("UIEmergenciesCommonTips1",args)
end

function emergenciesControl:showCaoLingTips2()
if mainControl:isSceneType(eSceneType.eZongmen)and zongmenControl:isMountid(mapIdType.zhufeng)and mainViewsControl.isOpen()then
local args={
delay=3,
str="调皮的草灵钻到其他位置，师尊赶紧寻找吧",
image={"ui/windows/emergencies/sharedtextures/emergencies.ab","icon_shijiantft_0001"},
}
UIManager:showWindow("UIEmergenciesCommonTips1",args)
end
end

function emergenciesControl:showRuleTips()
local args={
info=ruleTipsImageGroup.eYiMuCongSheng
}
UIManager:showWindow("UIRuleTipsImageWin",args)
end