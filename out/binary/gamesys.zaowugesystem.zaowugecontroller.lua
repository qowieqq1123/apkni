






local _MODULENAME="zaoWuGeController"

gameState.addListener(def_table(_MODULENAME))
zaoWuGeController.name=_MODULENAME
zaoWuGeController.data={}

function zaoWuGeController:onAppStart()

zaoWuGeModel:onAppStart()

socketManager:register_receiver(6,181,self.recv_6_181)
socketManager:register_receiver(6,182,self.recv_6_182)
socketManager:register_receiver(6,183,self.recv_6_183)
socketManager:register_receiver(6,184,self.recv_6_184)
socketManager:register_receiver(6,188,self.recv_6_188)

end


function zaoWuGeController:onEnterState(isReconnect)
zaoWuGeModel:onEnterState()

notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
notifySystem:listenNotify(notifyConfig.building_event,self.building_event)
end


function zaoWuGeController:onProtocolReq()
zaoWuGeModel:onProtocolReq()


end


function zaoWuGeController:onLeaveState(isReconnect)
zaoWuGeModel:onLeaveState(isReconnect)

self:stopTimer()

self.data={}
notifySystem:removelistener(notifyConfig.onShowPrize,self.onShowPrize)
notifySystem:removelistener(notifyConfig.building_event,self.building_event)
end


function zaoWuGeController:onLostConnection()

end


function zaoWuGeController:onReConnection(isInitPro)

end




function zaoWuGeController:req_InitData()
socketManager:send_6_181()
end


function zaoWuGeController:req_StartBuild(id,num)
socketManager:send_6_182(id,num)
end


function zaoWuGeController:req_CancelBuild()
socketManager:send_6_183()
end


function zaoWuGeController:req_ReceiveBuild()
socketManager:send_6_184()
end


function zaoWuGeController:req_ArrangeDisciple(dzGuid)
socketManager:send_6_188(dzGuid)
end



function zaoWuGeController.recv_6_181(startTime,suitId,suitNum,rcnt,dzGuid)
zaoWuGeModel:initData()

zaoWuGeModel:setBuildingProgressInfo(startTime,suitId,suitNum,rcnt,dzGuid)

zaoWuGeController:checkStartTimer()

zaoWuGeController.init=true

zaoWuGeController.refreshHud()
end


function zaoWuGeController.recv_6_182(startTime,suitId,suitNum)

zaoWuGeModel:setStartBuild(startTime,suitId,suitNum)


UIManager:invokeUIMethod("UIZaoWuGeWin","refreshBuild")

zaoWuGeController.refreshHud()

zaoWuGeController:checkStartTimer()


end


function zaoWuGeController.recv_6_183()
zaoWuGeModel:setCancelBuild()


UIManager:invokeUIMethod("UIZaoWuGeWin","refreshBuild")

zaoWuGeController.refreshHud()


end


function zaoWuGeController.recv_6_184(startTime,rcnt)
zaoWuGeModel:setRecvBuilding(startTime,rcnt)


UIManager:invokeUIMethod("UIZaoWuGeWin","refreshBuild")

zaoWuGeController.refreshHud()



end

function zaoWuGeController.recv_6_188(dzGuid)
zaoWuGeModel:setBuildDisciple(dzGuid)
UIManager:invokeUIMethod('UIZaoWuGeWin','refreshSelectDz')
UIManager:invokeUIMethod('UIZaoWuGeWin','refreshAllPart')
end

function zaoWuGeController:checkStartTimer()
local progressInfo=zaoWuGeModel:getBuildingProgressInfo()

local singleBuildDuration=cfgHelper.get2(cfg_zaowugebaseconfig_get,1,'needTime')
local buildDuration=progressInfo.suitNum*singleBuildDuration

if progressInfo.startTime>0 then
local curTime=timeHelper.getServerShortTime()
local endTime=progressInfo.startTime+buildDuration
if endTime>curTime then
self:startTimer(progressInfo.startTime,endTime)
else
self:stopTimer()
end
else
self:stopTimer()
end
end

function zaoWuGeController:startTimer(startTime,endTime)
self:stopTimer()

local singleBuildDuration=cfgHelper.get2(cfg_zaowugebaseconfig_get,1,'needTime')
self.buildTimer=timer.new()
local curTime
local oldVal=0
local callback=function()
curTime=timeHelper.getServerShortTime()
local val=(curTime-startTime)%singleBuildDuration
if oldVal>val then
zaoWuGeController.refreshHud()
end
oldVal=val
if curTime>=endTime then

zaoWuGeController:stopTimer()
end
end
self.buildTimer:start(1,callback)
callback()
end

function zaoWuGeController:stopTimer()
if self.buildTimer then
self.buildTimer:Stop()
self.buildTimer=nil
end
end



function zaoWuGeController:checkInBuild()
local progressInfo=zaoWuGeModel:getBuildingProgressInfo()

if progressInfo.suitId==0 then
return false
end

if progressInfo.startTime>0 then
local singleBuildDuration=cfgHelper.get2(cfg_zaowugebaseconfig_get,1,'needTime')
local buildDuration=progressInfo.suitNum*singleBuildDuration
local curTime=timeHelper.getServerShortTime()
local endTime=progressInfo.startTime+buildDuration
return endTime>curTime
end

return false
end

function zaoWuGeController:checkCanReceiveItem()
local count=zaoWuGeModel:getBuildCount()
return count>0
end

function zaoWuGeController:checkCanShowHud()
return zaoWuGeController:checkCanReceiveItem()or zaoWuGeController:checkInBuild()
end

function zaoWuGeController:checkCanBuildCount(dzGuid,suitId)
local dzProSkillLevel=UIDiscipleModel:getDiscipleJobLevel(dzGuid,DISCIPLE_PROSKILL_TYPE.eZhenFa)
local dzPSkillCostCfg=cfgHelper.get2(cfg_zaowugezhenfalevelconfig_get,dzProSkillLevel)
local count
if dzPSkillCostCfg then
local costInfoList=dzPSkillCostCfg.useItems[suitId]

if costInfoList~=nil then
for index,cost in ipairs(costInfoList)do
local itemId=cost[1]
local itemCount=cost[2]

local hasCount=itemsModel.getCount(itemId)
local canBuildCount=Mathf.Floor(hasCount/itemCount)
if count==nil or count>canBuildCount then
count=canBuildCount
end
end
end
end
return count or 0
end

function zaoWuGeController:checkIsCanBuild(dzGuid,suitId,count)
local dzProSkillLevel=UIDiscipleModel:getDiscipleJobLevel(dzGuid,DISCIPLE_PROSKILL_TYPE.eZhenFa)
local dzPSkillCostCfg=cfgHelper.get2(cfg_zaowugezhenfalevelconfig_get,dzProSkillLevel)
if dzPSkillCostCfg then
local costInfoList=dzPSkillCostCfg.useItems[suitId]

if costInfoList~=nil then
for index,cost in ipairs(costInfoList)do
local itemId=cost[1]
local itemCount=cost[2]

local hasCount=itemsModel.getCount(itemId)

local needNum=itemCount*count
if needNum>hasCount then
return false,itemId,needNum
end
end
end
end
return true
end

function zaoWuGeController:checkCanBuildAnyOne()
local dzProSkillLevel=0
local dzPSkillCostCfg=cfgHelper.get2(cfg_zaowugezhenfalevelconfig_get,dzProSkillLevel)
if dzPSkillCostCfg then
local suitCfg=cfg_zaowugesuitconfig()
for i,v in ipairs(suitCfg)do
local suitId=v.suitId
local costInfoList=dzPSkillCostCfg.useItems[suitId]
if costInfoList~=nil then
local ok=true
for index,cost in ipairs(costInfoList)do
local itemId=cost[1]
local itemCount=cost[2]
local hasCount=itemsModel.getCount(itemId)
local needNum=itemCount
if needNum>hasCount then
ok=false
break
end
end
if ok then
return true
end
end
end
end
return false
end

function zaoWuGeController.refreshHud()

local bdDatas=zongmenModel:getBuildingDataByBdType(mapIdType.fort,SLG_SYSTEM_TYPE.eZaoWuGe)
if bdDatas then
for index,bdData in ipairs(bdDatas)do
buildingCDControl:addCDData(buildingCDType.zwgPlane,bdData)
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end

end


function zaoWuGeController.onShowPrize(prizeType,temp,effectData,temp2)
if prizeType==ePrizeType.eZaoWuGeBuilding then
UIManager:showWindow('UIZaoWuGeShowPrizeWin',{list=temp})
end
end

function zaoWuGeController:getBuildData()
local buildDataList=zongmenModel:getAllBuildingDataByBdId(mapIdType.fort,SLG_SYSTEM_TYPE.eZaoWuGe)or{}
return buildDataList[1]
end

function zaoWuGeController:changeBuildDiscipleState()
if not self.init then return end
local bdData=zaoWuGeController:getBuildData()
if zaoWuGeController:checkInBuild()then
isometricMapSystem:setBuildingPlanStatus(mapIdType.fort,bdData.un_build_id,planStatus.eStart)
zongmenControl:setDiscipleState(bdData,DISCIPLE_STATE_TYPE.ePlantCreate,true)
else
isometricMapSystem:setBuildingPlanStatus(mapIdType.fort,bdData.un_build_id,planStatus.eDefault)
zongmenControl:setDiscipleState(bdData,DISCIPLE_STATE_TYPE.eFree,true)
end
end


function zaoWuGeController.building_event(etype,sfId,ubdId,dzId,olddzId)
local bdData=zaoWuGeController:getBuildData()

if bdData and mathHelper.compareInt64(bdData.un_build_id,ubdId)then
if etype==buildingEvent.replaceDisciple then
if mathHelper.compareInt64(dzId,Int64_0)then

end
end
end
end



