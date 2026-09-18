








wanBaoShangHuiController=gameState.addListener({})


wanBaoShangHuiController.data={}

function wanBaoShangHuiController:onAppStart()

wanBaoShangHuiModel:onAppStart()



socketManager:register_receiver(3,252,self.recv_3_252)
socketManager:register_receiver(3,253,self.recv_3_253)
socketManager:register_receiver(3,254,self.recv_3_254)






wanBaoShangHuiController:onAppStart_entity()
end


function wanBaoShangHuiController:onEnterState(isReconnect)
wanBaoShangHuiModel:onEnterState()
notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
notifySystem:listenNotify(notifyConfig.onBehaviorTreeError,self.onBehaviorTreeError)
wanBaoShangHuiController:onEnterState_entity()
self.isEnterHome=false
end


function wanBaoShangHuiController:onProtocolReq(isReconnect)

if isReconnect then
if mainControl:isInScene(eSceneType.eZongmen)then
wanBaoShangHuiController:onEnterHome()
end
end
end


function wanBaoShangHuiController:onLeaveState(isReconnect)
wanBaoShangHuiModel:onLeaveState(isReconnect)
notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
notifySystem:removelistener(notifyConfig.onNewDay,self.onNewDay)
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
notifySystem:removelistener(notifyConfig.onBehaviorTreeError,self.onBehaviorTreeError)
wanBaoShangHuiController:onLeaveState_entity()

self.data={}
end


function wanBaoShangHuiController:onLostConnection()
wanBaoShangHuiController:stopCreateCatWorker()
end


function wanBaoShangHuiController:onReConnection(isInitPro)

end

function wanBaoShangHuiController:onEnterHome()
self.isEnterHome=true

if wanBaoShangHuiController:checkWBSHBuild()then

if wanBaoShangHuiController:checkWBSHFinishBuild()then

wanBaoShangHuiController:startCreateCatWorkerTimer()
end
return
else

local isOpen=systemModel.isOpen(SYSTEM_DEFINE.eWanBaoShangHuiOpen)
if isOpen then
local args={type=SLG_SYSTEM_TYPE.eWanBaoShangHui}
local data,mountid,buildid=zongmenControl:getBuilding(args,true)
if data then

wanBaoShangHuiModel:setWBSHIsBuild(true)

return
else
local pass,tips=zongmenControl:checkBuildingPassRepairCondition(buildid)
if not pass then

return
end
end


wanBaoShangHuiModel:setWBSHIsNotNeedHide(true)
wanBaoShangHuiController.repairWanBaoShangHui()
end
end
end

function wanBaoShangHuiController:onLeaveHome()
self.isEnterHome=false

wanBaoShangHuiController:stopCreateCatWorker()
end




function wanBaoShangHuiController:reqWBSHAnswerQuestion(qid,index)
socketManager:send_3_253(qid,index)
end


function wanBaoShangHuiController:reqWBSHGetQuestionReward()
socketManager:send_3_254()
end



function wanBaoShangHuiController.recv_3_252(qid,flag)
wanBaoShangHuiModel:setWBSHAnsweredQuestionIndex(qid)
wanBaoShangHuiModel:setWBSHGetQuestionRewardFlag(flag)

UIManager:callWindowFunc("UIWanBaoShangHui_questionWin","refresh")
end


function wanBaoShangHuiController.recv_3_253(qid,idx)
wanBaoShangHuiModel:setWBSHAnsweredQuestionIndex(qid)

UIManager:callWindowFunc("UIWanBaoShangHui_questionWin","answeredQuestionRecv",qid,idx)
end


function wanBaoShangHuiController.recv_3_254()
wanBaoShangHuiModel:setWBSHGetQuestionRewardFlag(1)

UIManager:callWindowFunc("UIWanBaoShangHui_questionWin","refresh")

wanBaoShangHuiController:refreshBuildHud()
end





function wanBaoShangHuiController.repairWanBaoShangHui()
local mapId=mapIdType.zhufeng
local bdId=SLG_SYSTEM_TYPE.eWanBaoShangHui
local repairData=isometricMapSystem:getRepairDataByID(mapId,bdId)
if not repairData then

local mapCfg=cfgHelper.get1(cfg_monijysfconfig_get,mapId)
local posList=mapCfg.repair_build_list and mapCfg.repair_build_list[SLG_SYSTEM_TYPE.eWanBaoShangHui]
if not posList then
logErr("主峰内未找到可修复的万宝商会建筑 请检查山峰配置表repair_build_list字段中是否已配置万宝商会")
return
end
for _,posIndex in ipairs(posList)do
isometricMapSystem:createRepairBuilding(mapId,bdId,posIndex)
end
end

repairData=isometricMapSystem:getRepairDataByID(mapId,bdId)
if repairData then

zongmenControl:reqBuild(mapId,repairData.id,repairData.x,repairData.y,repairData.orientation)
end
end

function wanBaoShangHuiController:refreshBuildHud()
local sfId=mapIdType.zhufeng
local bdData=zongmenModel:findBuildingDataByType(sfId,SLG_SYSTEM_TYPE.eWanBaoShangHui)
if bdData then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end



function wanBaoShangHuiController:resetWBSHQuestionData()
wanBaoShangHuiModel:setWBSHAnsweredQuestionIndex(0)
wanBaoShangHuiModel:setWBSHGetQuestionRewardFlag(0)

UIManager:callWindowFunc("UIWanBaoShangHui_questionWin","initWin")


wanBaoShangHuiController:refreshBuildHud()
end







function wanBaoShangHuiController.on_home_event(etype)
if etype==homeEvent.eEnterHome then
wanBaoShangHuiController:onEnterHome()
elseif etype==homeEvent.eLeaveHome then
wanBaoShangHuiController:onLeaveHome()
end
end


function wanBaoShangHuiController.onNewDay()

local isOpen=systemModel.isOpen(SYSTEM_DEFINE.eWanBaoShangHuiOpen)
if isOpen then
local args={type=SLG_SYSTEM_TYPE.eWanBaoShangHui}
local data,mountid,buildid=zongmenControl:getBuilding(args,true)
if data then

wanBaoShangHuiModel:setWBSHIsBuild(true)
local isRepairing=data.flag==1
if isRepairing then

wanBaoShangHuiController:resetWBSHQuestionData()
end
end
end
end

function wanBaoShangHuiController.on_building_event(etype,sfId,ubdId,args)
if etype==buildingEvent.buildComplete then
local bdData=zongmenModel:getBuildingData(ubdId)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local buildType=cfg.build_type
if buildType==SLG_SYSTEM_TYPE.eWanBaoShangHui then
wanBaoShangHuiModel:setWBSHIsBuild(true)
wanBaoShangHuiModel:setWBSHIsFinishBuild(true)


wanBaoShangHuiController:startCreateCatWorkerTimer()
end
elseif etype==buildingEvent.buildStart then
local bdData=zongmenModel:getBuildingData(ubdId)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local buildType=cfg.build_type
if buildType==SLG_SYSTEM_TYPE.eWanBaoShangHui and not wanBaoShangHuiModel:getWBSHIsNotNeedHide()then

isometricMapSystem:changeBuildingModelVisible(bdData,false)
end
end
end

function wanBaoShangHuiController.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eWanBaoShangHuiOpen and wanBaoShangHuiController.isEnterHome==true then

wanBaoShangHuiController.repairWanBaoShangHui()
end
end

function wanBaoShangHuiController.onBehaviorTreeError(uid,filename)
if filename==btType.story_21_WanBaoShangHui_1 then
local bdData=zongmenModel:findBuildingDataByID(1,SLG_SYSTEM_TYPE.eWanBaoShangHui)
if bdData then
isometricMapSystem:changeBuildingModelVisible(bdData,true)
end
end
end


function wanBaoShangHuiController:checkWBSHFinishBuild()
local isFinish=wanBaoShangHuiModel:getWBSHIsFinishBuild()
if isFinish~=nil then
return isFinish
else
isFinish=false
end

local isOpen=systemModel.isOpen(SYSTEM_DEFINE.eWanBaoShangHuiOpen)
if isOpen then
local args={type=SLG_SYSTEM_TYPE.eWanBaoShangHui}
local data,mountid,buildid=zongmenControl:getBuilding(args)
if data then
isFinish=true
end
end


wanBaoShangHuiModel:setWBSHIsFinishBuild(isFinish)
return isFinish
end


function wanBaoShangHuiController:checkWBSHBuild()
local isBuild=wanBaoShangHuiModel:getWBSHIsBuild()
if isBuild~=nil then
return isBuild
else
isBuild=false
end

local isOpen=systemModel.isOpen(SYSTEM_DEFINE.eWanBaoShangHuiOpen)
if isOpen then
local args={type=SLG_SYSTEM_TYPE.eWanBaoShangHui}
local data,mountid,buildid=zongmenControl:getBuilding(args,true)
if data then
isBuild=true
end
end

wanBaoShangHuiModel:setWBSHIsBuild(isBuild)
return isBuild
end