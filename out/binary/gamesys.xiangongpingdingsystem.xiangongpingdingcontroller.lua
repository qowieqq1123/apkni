






local _MODULENAME="xiangongpingdingController"

gameState.addListener(def_table(_MODULENAME))
xiangongpingdingController.name=_MODULENAME
xiangongpingdingController.data={}
local _EntityManager=CS.EntityManager.Instance

function xiangongpingdingController:onAppStart()

xiangongpingdingModel:onAppStart()


socketManager:register_receiver(6,9,xiangongpingdingController.recv_6_9)
socketManager:register_receiver(6,8,xiangongpingdingController.recv_6_8)
socketManager:register_receiver(6,7,xiangongpingdingController.recv_6_7)
socketManager:register_receiver(6,6,xiangongpingdingController.recv_6_6)
socketManager:register_receiver(6,5,xiangongpingdingController.recv_6_5)
socketManager:register_receiver(6,4,xiangongpingdingController.recv_6_4)
socketManager:register_receiver(6,56,xiangongpingdingController.recv_6_56)
























notifySystem:listenNotify(notifyConfig.building_event,self.onBuildingEvent)
notifySystem:listenNotify(notifyConfig.home_event,self.onHomeEvent)
notifySystem:listenNotify(notifyConfig.onTaskChange,self.onTaskChange)
notifySystem:listenNotify(notifyConfig.on_system_open,self.onSystemOpen)
end


function xiangongpingdingController:onEnterState(isReconnect)
xiangongpingdingModel:onEnterState(isReconnect)
timeEventController.addNormalTimerHandler(1,'xiangongpingdingController',xiangongpingdingController)
end


function xiangongpingdingController:onProtocolReq(isReconnect)
xiangongpingdingModel:onProtocolReq(isReconnect)
xiangongpingdingController:freshState()
end


function xiangongpingdingController:onLeaveState(isReconnect)
xiangongpingdingModel:onLeaveState(isReconnect)
xiangongpingdingController:removeRole()
timeEventController.removeNormalTimerHandler(1,'xiangongpingdingController')

self.data={}
self.entityInfo=nil
end


function xiangongpingdingController:onLostConnection()

end


function xiangongpingdingController:onReConnection(isInitPro)

end

function xiangongpingdingController:onNormalUpdate()
if xiangongpingdingModel:isFinish()then
local isPrize=xiangongpingdingModel:isPrize()
xiangongpingdingModel:freshCurPingDingState()
local isEnd=xiangongpingdingModel:isEnd()
if isEnd then
xiangongpingdingController.recv_6_7(1)
end





end
end




function xiangongpingdingController.recv_6_9(rwJinDu)
xiangongpingdingModel:onFreshProgress(rwJinDu)
xiangongpingdingController:printLog(FMT.fmt('领取累计积分进度：{0}',rwJinDu))
UIManager:callWindowFunc('UIXianGongPingDingMainWin','freshInfo')
UIManager:callWindowFunc('UIXianGongPingDingWin','freshInfo')
end

function xiangongpingdingController.recv_6_56(rwJinDu)
xiangongpingdingModel:onFreshProgress(rwJinDu)
xiangongpingdingController:printLog(FMT.fmt('领取累计积分进度：{0}',rwJinDu))
UIManager:callWindowFunc('UIXianGongPingDingMainWin','freshInfo')
UIManager:callWindowFunc('UIXianGongPingDingWin','freshInfo')
end




function xiangongpingdingController.recv_6_8(len,hisList)
xiangongpingdingModel:onRetPingDing(hisList)
UIManager:callWindowFunc('UIXianGongPingDingWin','freshInfo')
xiangongpingdingController:printLog('历史评级返回')
end



function xiangongpingdingController.recv_6_7(rwFlag)
xiangongpingdingModel:onRewards(rwFlag)
xiangongpingdingController:printLog('奖励领取返回')
UIManager:callWindowFunc('UIXianGongPingDingMainWin','freshInfo')
if xiangongpingdingModel:isPrize()then
xiangongpingdingController:removeRole()
end
UIManager:invokeUIMethod('UIBuildingMsgWin','showMsgSpe',4,xiangongpingdingModel:isPingDingChanged())
end






function xiangongpingdingController.recv_6_6(pingJi,ljpingfen,rank,rankNum)
xiangongpingdingModel:onTask(pingJi,ljpingfen,rank,rankNum)
xiangongpingdingController:printLog('评定任务返回')
UIManager:callWindowFunc('UIXianGongPingDingMainWin','onPingDing')
end



function xiangongpingdingController.recv_6_5(endTime)
xiangongpingdingModel:onStartTask(endTime)
xiangongpingdingController:freshState()
xiangongpingdingController:printLog('开始评定任务返回')
UIManager:callWindowFunc('UIXianGongPingDingMainWin','freshInfo')
end










function xiangongpingdingController.recv_6_4(argtable)
local oldqs=xiangongpingdingModel:getQiShu()
xiangongpingdingModel:onInit(argtable)
xiangongpingdingController:freshState()
local newqs=xiangongpingdingModel:getQiShu()
if oldqs~=newqs then
xiangongpingdingModel:clearHisList()
end
UIManager:callWindowFunc('UIXianGongPingDingMainWin','freshInfo')




end



function xiangongpingdingController:send_6_4()
socketManager:send_6_4()
end

function xiangongpingdingController:send_6_5()
socketManager:send_6_5()
end

function xiangongpingdingController:send_6_6()
socketManager:send_6_6()
end

function xiangongpingdingController:send_6_7()
socketManager:send_6_7()
end

function xiangongpingdingController:send_6_8()
socketManager:send_6_8()
end

function xiangongpingdingController:send_6_9()
socketManager:send_6_9()
end

function xiangongpingdingController:send_6_56()
socketManager:send_6_56()
end



function xiangongpingdingController.onHomeEvent(etype,args1,args2)
if etype==homeEvent.eEnterHome then
xiangongpingdingController:freshState()
elseif etype==homeEvent.eLeaveHome then
xiangongpingdingController:removeRole()
end
end

function xiangongpingdingController.onTaskChange(taskid,state)
if not initProControl.isDone()then return end

if cfg_xiangongpingdingtaskconfig_get(taskid,false)then
local state=xiangongpingdingModel:getCurPingDingState()
if state==XIANGONG_TASK_TYPE.eDoing and
xiangongpingdingModel:isFinishTaskById(taskid)and
xiangongpingdingModel:isFinishAllTask()then
xiangongpingdingController:printLog(FMT.fmt('所有任务完成!当前任务状态改变：{0}',taskid))
xiangongpingdingController:onEndPingDing(true)
end
end
end

function xiangongpingdingController.onSystemOpen(sysid)
if sysid==SYSTEM_DEFINE.eXGPD then
xiangongpingdingController:freshState()
end
end

function xiangongpingdingController:getEntityGUID()
local entityInfo=self.entityInfo
if entityInfo==nil then return end
return entityInfo.guid
end

function xiangongpingdingController:createRole()
if not xiangongpingdingModel:isOpenSys()then return end
if not isometricMapSystem:IsInHome()then return end
if xiangongpingdingModel:getQiShu()<=0 then return end
if xiangongpingdingModel:isEnd()then return end
if xiangongpingdingModel:isPrize()then return end
if self.entityInfo then return end

local state=xiangongpingdingModel:getCurPingDingState()
local isReady=state==XIANGONG_TASK_TYPE.eReady
local isFinish=state==XIANGONG_TASK_TYPE.eFinish
local isDoing=state==XIANGONG_TASK_TYPE.eDoing
xiangongpingdingController:printLog(FMT.fmt('创建仙宫使者!当前状态：{0}',state))


local modelArgs=cfgHelper.get2(cfg_xiangongpingdingbaseconfig_get,1,'modelArgs')
local posArgs=cfgHelper.get2(cfg_xiangongpingdingbaseconfig_get,1,'pos')
local modelId=modelArgs[1]
local scale=modelArgs[2]
local offset=modelArgs[3]or{0,0}
local vector3pos=Vector3Int(posArgs[1],posArgs[2],0)
if isDoing then
vector3pos=xiangongpingdingController:getRandomPos()
end
local guid=isometricMapSystem:createRoleEntity(objectType.eRole,mapIdType.zhufeng,0,modelId,{},SortingLayers.ITBuilding,scale,vector3pos,offset)
_MapManager.ShowShadow(guid,true)
self.entityInfo={guid=guid}
return true
end

function xiangongpingdingController:freshRolePos()
if self.entityInfo==nil then return end
if xiangongpingdingModel:isReady()or xiangongpingdingModel:isFinish()then
local posArgs=cfgHelper.get2(cfg_xiangongpingdingbaseconfig_get,1,'pos')
local pos=Vector3Int(posArgs[1],posArgs[2],0)
_MapManager.SetPosition(self.entityInfo.guid,pos)
end
end

function xiangongpingdingController:getRandomPos()
local temp=cfgHelper.get2(cfg_xiangongpingdingbaseconfig_get,1,"randPos")
local list={}
for i,v in ipairs(temp)do
local cell=_MapManager.ToVector3Int(v[1],v[2],0)
local area=_MapManager.GetAreaID(mapIdType.zhufeng,cell)
if _MapManager.IsAreaUnlock(mapIdType.zhufeng,area)then
table.insert(list,cell)
end
end
return list[math.random(1,#list)]
end

function xiangongpingdingController:onReadyPingDing()
xiangongpingdingController:printLog('onReadyPingDing')
xiangongpingdingController:stopDoingTimer()
xiangongpingdingModel:freshCurPingDingState()
xiangongpingdingController:freshRolePos()
xiangongpingdingController:freshBT()
xiangongpingdingController:freshHUD()
UIManager:invokeUIMethod('UIBuildingMsgWin','showMsgSpe',4,xiangongpingdingModel:isPingDingChanged())
end

function xiangongpingdingController:onDoingPingDing()
xiangongpingdingController:printLog('onDoingPingDing')
xiangongpingdingModel:freshCurPingDingState()
xiangongpingdingController:startDoingTimer()
xiangongpingdingController:freshBT()
xiangongpingdingController:freshHUD()
UIManager:invokeUIMethod('UIBuildingMsgWin','showMsgSpe',4,xiangongpingdingModel:isPingDingChanged())
end

function xiangongpingdingController:onEndPingDing()
xiangongpingdingController:printLog('onEndPingDing')
xiangongpingdingController:stopDoingTimer()
xiangongpingdingModel:freshCurTotalPingFen()
xiangongpingdingController:freshRolePos()
xiangongpingdingController:freshBT()
xiangongpingdingController:freshHUD()
if xiangongpingdingModel:checkReqPingJi()then
xiangongpingdingController:send_6_6()
end
UIManager:invokeUIMethod('UIBuildingMsgWin','showMsgSpe',4,xiangongpingdingModel:isPingDingChanged())
end

function xiangongpingdingController:removeRole()
local entityInfo=self.entityInfo
if entityInfo==nil then return end

if entityInfo.hud then
hudControl:removeHUD(entityInfo.hud)
end

if entityInfo.bt then
behaviorManager:removeBehaviorTree(entityInfo.bt)
end

if entityInfo.guid then
_MapManager.RemoveTilemapObject(entityInfo.guid)
end

self.entityInfo=nil
end

function xiangongpingdingController:changeRoleShow(isShow)
local entityInfo=self.entityInfo
if entityInfo==nil then return end
if entityInfo.hud then
local hudId=entityInfo.hud
local hudWidget=hudControl:getHUDWidget(hudId)
hudWidget:SetChildActive(0,isShow)
end

if entityInfo.guid then
local guid=entityInfo.guid
local dzEntity=_EntityManager:GetEntity(guid)
dzEntity:SetVisible(isShow)
end
end

function xiangongpingdingController:freshBT()
if xiangongpingdingModel:isEnd()then return end
local state=xiangongpingdingModel:getCurPingDingState()
local isDoing=state==XIANGONG_TASK_TYPE.eDoing
if self.entityInfo==nil then return end
local entityInfo=self.entityInfo
local bt=entityInfo.bt
if not isDoing then
if bt then
behaviorManager:removeBehaviorTree(entityInfo.bt)
entityInfo.bt=nil
end
return
end
local guid=entityInfo.guid
if bt==nil then
xiangongpingdingController:printLog('addBehaviorTree')
local data={
moveCheckId=21,
pathCheckId=-1,
}
bt=behaviorManager:addBehaviorTree(btType.ai_xgtb_range_move,{stId=guid},true,data)
entityInfo.bt=bt
end
end

function xiangongpingdingController:freshHUD()
if xiangongpingdingModel:isEnd()then return end
local state=xiangongpingdingModel:getCurPingDingState()
local isReady=state==XIANGONG_TASK_TYPE.eReady
local isFinish=state==XIANGONG_TASK_TYPE.eFinish
local isDoing=state==XIANGONG_TASK_TYPE.eDoing
if self.entityInfo==nil then return end

local entityInfo=self.entityInfo
local guid=entityInfo.guid
if isFinish then
local hud=entityInfo.hud
local hudType=entityInfo.hudType
if hud and hudType==INSTANCE_TYPE.eDiscipleState then return end
if hud then
hudControl:removeHUD(hud)
end
hudType=INSTANCE_TYPE.eDiscipleState
local offset=_MapManager.GetObjectHeadOffset(guid)
entityInfo.hud=hudControl:addHUD(hudType,guid,offset,true,true,function(id)
if entityInfo.hud==id then
local widget=hudControl:getHUDWidget(id)
widget:SetChildCSImageSprite(0,globalABLookup.hud_atlas,'icon_fangshigx')
widget:SetChildButtonClick(1,function()
xiangongpingdingController:clickRole()
end)
widget:SetChildActive(1,true)
else
hudControl:removeHUD(id)
end
end)
entityInfo.hudType=hudType
xiangongpingdingController:printLog('刷新未开始HUD')
elseif isReady or isDoing then
local hud=entityInfo.hud
local hudType=entityInfo.hudType
if hud and hudType==INSTANCE_TYPE.eDogTipsHUD then return end
if hud then
hudControl:removeHUD(hud)
end
local offset=_MapManager.GetObjectHeadOffset(guid)
hudType=INSTANCE_TYPE.eDogTipsHUD
entityInfo.hud=hudControl:addHUD(hudType,guid,offset,true,true,function(id)
if entityInfo.hud==id then
local widget=hudControl:getHUDWidget(id)
widget:SetChildButtonClick(1,function()
xiangongpingdingController:clickRole()
end,true)
else
hudControl:removeHUD(id)
end
end)
entityInfo.hudType=hudType
xiangongpingdingController:printLog('刷新完成HUD')
end
end

function xiangongpingdingController:jump(warn)
if not xiangongpingdingModel:isOpenSys()then
if warn then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eXGPD)
UIManager.error(tips)
end
return false
end
xiangongpingdingController:clickRole()
return true
end

function xiangongpingdingController:OpenHisWin(warn)
if not xiangongpingdingModel:isOpenSys()then
if warn then
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eXGPD)
UIManager.error(tips)
end
return false
end
UIManager:showWindow('UIXianGongPingDingWin')
return true
end

function xiangongpingdingController:moveCameraToEntity()
if self.entityInfo then
isometricMapSystem:moveCameraToObjectEx(self.entityInfo.guid,true)
end
end

function xiangongpingdingController:clickRole()
local state=xiangongpingdingModel:getCurPingDingState()
if xiangongpingdingModel:isDoing()or xiangongpingdingModel:isEnd()then
xiangongpingdingController:printLog('进行中，直接打开界面')
UIFullXianGongPingDingControl:showXGPDWindow()
else
if not xiangongpingdingController:playCurStory()then
UIFullXianGongPingDingControl:showXGPDWindow()
end
end
end

function xiangongpingdingController:playCurStory(showCall)
if xiangongpingdingModel:isEnd()then return false end
local state=xiangongpingdingModel:getCurPingDingState()
local qishu=xiangongpingdingModel:getQiShu()
local str=FMT.fmt('xgpd_splot_{0}_{1}',qishu,state)
local isPlay=userActorSetting.get(str,false)
if isPlay then
return false
else
local groupid
if xiangongpingdingModel:isReady()then
local plotTable=cfgHelper.get2(cfg_xiangongpingdingbaseconfig_get,1,'plotReady')
local plot=plotTable.plot
groupid=plot[qishu]
if groupid==nil then
local random=plotTable.random
groupid=random[math.random(1,#random)]
end
elseif xiangongpingdingModel:isFinish()and xiangongpingdingModel:isPrize()then
local plotTable=cfgHelper.get2(cfg_xiangongpingdingbaseconfig_get,1,'plotFinish')
local plot=plotTable.plot
groupid=plot[qishu]
if groupid==nil then
local random=plotTable.random
groupid=random[math.random(1,#random)]
end
end
if groupid==nil then return false end
userActorSetting.flushVal(str,true)
xiangongpingdingController:printLog('开始剧情动画')
xiangongpingdingController:playStory(groupid,showCall)
return true
end
end

function xiangongpingdingController:onTouchRole(guid)
local entityInfo=self.entityInfo
if entityInfo==nil then return end
if entityInfo.guid~=guid then return end
xiangongpingdingController:clickRole()
end

function xiangongpingdingController:playStory(groupid,showCall)
local func=function(flag)
xiangongpingdingController:printLog('剧情动画播放完毕，打开界面')
UIFullXianGongPingDingControl:showXGPDWindow()
end
if showCall==false then
func=nil
end
gameplotController:showPlotBoard({groupid=groupid,isFullOpen=true,callback=func})
end

function xiangongpingdingController:startDoingTimer()
if self.doTimer then return end
self.doTimer=timer.new()
local tick=function()
if xiangongpingdingModel:isEndPingDingTime()then
xiangongpingdingController:printLog('倒计时完毕，评定完成')
xiangongpingdingController:onEndPingDing(true)
end
end
self.doTimer:start(1,tick)
end

function xiangongpingdingController:stopDoingTimer()
if not self.doTimer then return end
self.doTimer:cancel()
self.doTimer=nil
end

function xiangongpingdingController:freshState()
if not initProControl.isDone()then return end
if not xiangongpingdingModel:isOpenSys()then return end
if not isometricMapSystem:IsInHome()then return end
if xiangongpingdingModel:getQiShu()<=0 then return end

xiangongpingdingModel:freshCurTotalPingFen()
xiangongpingdingController:createRole()
if xiangongpingdingModel:isReady()then
xiangongpingdingController:onReadyPingDing()
elseif xiangongpingdingModel:isDoing()then
xiangongpingdingController:onDoingPingDing()
elseif xiangongpingdingModel:isFinish()then
xiangongpingdingController:onEndPingDing()
end
end



















function xiangongpingdingController:printLog(msg)

end