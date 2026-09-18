







local _MODULENAME="limitActivitiesController"
gameState.addListener(def_table(_MODULENAME))
limitActivitiesController.name=_MODULENAME
local _temp={}
local _pushNum=5

function limitActivitiesController:onAppStart()
socketManager:register_receiver(248,1,limitActivitiesController.recv_248_1)
end

function limitActivitiesController:onEnterState(isReconnet)
if not isReconnet then
notifySystem:listenNotify(notifyConfig.onLimitActOpen,self.onLimitActOpen)
notifySystem:listenNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
notifySystem:listenNotify(notifyConfig.onReddotCatchTypeChange,self.onReddotCatchTypeChange)



notifySystem:listenNotify(notifyConfig.building_event,self.building_event)
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
notifySystem:listenNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
notifySystem:listenNotify(notifyConfig.onSeasonStageDataChange,self.onSeasonStageDataChange)
notifySystem:listenNotify(notifyConfig.onJoinXianYuFlagChange,self.onJoinXianYuFlagChange)

notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)

self.isShowActList=true
self.previewList={}
end
end

function limitActivitiesController:onLeaveState(isReconnet)
if not isReconnet then
notifySystem:removelistener(notifyConfig.onLimitActOpen,self.onLimitActOpen)
notifySystem:removelistener(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
notifySystem:removelistener(notifyConfig.onReddotCatchTypeChange,self.onReddotCatchTypeChange)



notifySystem:removelistener(notifyConfig.building_event,self.building_event)
notifySystem:removelistener(notifyConfig.onNewDay,self.onNewDay)
notifySystem:removelistener(notifyConfig.onSeasonChange,self.onSeasonChange)
notifySystem:removelistener(notifyConfig.onSeasonStageDataChange,self.onSeasonStageDataChange)
notifySystem:removelistener(notifyConfig.onJoinXianYuFlagChange,self.onJoinXianYuFlagChange)

notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)

limitActivitiesModel:clearData()
self.previewList=nil
end
_temp={}
end

function limitActivitiesController:onPlayerCreate(...)

end


function limitActivitiesController:onProtocolReq(isReconnet)
if verifyManager:isHideLimitActivities()then
return
end
limitActivitiesController:doInit(sendMessageServerType.eNone,isReconnet)
end


function limitActivitiesController:onProtocolReqKF(isReconnet)
if verifyManager:isHideLimitActivities()then
return
end
limitActivitiesController:doInit(sendMessageServerType.eKuafu,isReconnet)


xianmengController:init_TYSC()

lingxuwenjianController:activeActivity()

xianmengdigongController:initAct()

auctionController:checkAuctionEnter()

zhengzhanshanhaiModel:clearMapBasConfig()
zhengzhanshanhaiController:activeActivity()
end


function limitActivitiesController:onProtocolReqLargeXJKF(isReconnet)
if verifyManager:isHideLimitActivities()then
return
end
limitActivitiesController:doInit(sendMessageServerType.eXJKuafu,isReconnet)
seasonController:refreshLimitActCondition()
end

function limitActivitiesController:onProtocolReqLargeZZSHKF(isReconnet)
if verifyManager:isHideLimitActivities()then
return
end

zhengzhanshanhaiModel:clearMapBasConfig()
zhengzhanshanhaiController:activeActivity()
end

function limitActivitiesController:doInit(serverType,isReconnet)

limitActivitiesModel:initActInfoList(serverType)
if serverType==sendMessageServerType.eNone then
timeEventController.addQuickTimerHandler(limitActivitiesController.name,limitActivitiesController)
end
if isReconnet then
limitActivitiesModel:onReconnet(serverType)
end
limitActivitiesController:refreshAllActEnter()
end

function limitActivitiesController:onOpenView(isReconnect)
if mainControl:isInScene(eSceneType.eZongmen)then
local all=limitActivitiesModel:getAllActivities()
for i,actInfo in ipairs(all)do
local actID=actInfo:getActID()
local isMark=limitActivitiesController:getActPreviewMark(actID)
if not isMark then
if actInfo:checkOpen()and(actInfo:checkIdle()or actInfo:checkPreview())and actInfo:checkInStartTimeDay()then
if self.previewList[actID]==nil then
local actCfg=limitActivitiesModel:getActConfig(actID)
if actCfg.prewin then
msgWinControl:addMsgWin(msgWinType.eLimitActPreview,{actID=actID})
else
limitActivitiesController:markActPreview(actID)
end
end
end
end
end
end
end

function limitActivitiesController:onLostConnection()

end

function limitActivitiesController:getIsShowActList()
return self.isShowActList
end

function limitActivitiesController:setIsShowActList(flag)
self.isShowActList=flag
end

function limitActivitiesController.onReddotCatchTypeChange(catchType,...)
limitActivitiesModel:disposeActReddotChange(catchType,...)
end


function limitActivitiesController.building_event(eventType,param1,param2,param3)
if eventType==buildingEvent.zongmenLevelUp and param3~=param1 then

limitActivitiesModel:disposeActConditionChange(1)
end
end


function limitActivitiesController.onNewDay()
limitActivitiesModel:disposeActConditionChange(2)
end


function limitActivitiesController.onSeasonChange()
limitActivitiesModel:disposeActConditionChange(3)
end


function limitActivitiesController.onSeasonStageDataChange(season_id,chapter_idx)
limitActivitiesModel:disposeActConditionChange(3)
end


function limitActivitiesController.onJoinXianYuFlagChange()
limitActivitiesModel:disposeActConditionChange(3)
end









function limitActivitiesController:onQuickUpdate()

if#_temp>0 then
local len=_pushNum
while#_temp>0 and len>0 do
local actInfo=_remove(_temp,1)
if actInfo.actID then
actInfo:update()
end
len=len-1
end
else
local all=limitActivitiesModel:getAllActivities()

for _,actInfo in pairs(all)do
_temp[#_temp+1]=actInfo
end

local len=#_temp
if len>0 then
_pushNum=math.ceil(len/5)
end
end
end


function limitActivitiesController:onStartAllXMAct()
local all=limitActivitiesModel:getAllActivities()
for actID,actInfo in pairs(all)do
if limitActivitiesModel:isXMAct(actID)then
xpcall(function()
actInfo:onStart()
end,function(err)
loggerUtil.logErrFMT('onStartAllXMAct err!{0}',err)
end)
end
end
end

function limitActivitiesController.onLimitActStateChange(actID,state)
if state==limitActivitiesModel.actPreviewState then


elseif state==limitActivitiesModel.actDoingState then

if not limitActivitiesModel:isClientAct(actID)then
limitActivitiesModel:setActMark_done(actID)
end

local preview_typo=limitActivitiesModel:checkIsDoingPreview(actID)
if preview_typo and limitActivitiesModel:checkActOpen(actID)then
mainTipsController:onActive(preview_typo)
end

limitActivitiesController:refreshActEnter(actID,true)
elseif state==limitActivitiesModel.actIdleState then

elseif state==limitActivitiesModel.actFinishState then



limitActivitiesController:refreshActEnter(actID,false)
end
end

function limitActivitiesController.onLimitActOpen(actID,flag)
if flag then
local preview_typo=limitActivitiesModel:checkIsDoingPreview(actID)
if preview_typo and limitActivitiesModel:checkActOpen(actID)and limitActivitiesModel:checkActDoing(actID)then
mainTipsController:onActive(preview_typo)
end
end
end





function limitActivitiesController:refreshAllActEnter()
local all=limitActivitiesModel:getAllActivities()
for act_id,actInfo in pairs(all)do
xpcall(function()
actInfo:refreshEnter(true)
end,function(err)
loggerUtil.logErrFMT('limitActivities refreshAllActEnter err!{0}',err)
end)
end
end

function limitActivitiesController:refreshActEnter(actID,flag)
local actInfo=limitActivitiesModel:getActInfo(actID)
if actInfo then
actInfo:refreshEnter(flag)
end
end






function limitActivitiesController:jump(actID,extraParams)
local actInfo=limitActivitiesModel:getActInfo(actID)
if actInfo==nil then
if limitActivitiesModel:isClientAct(actID)then
UIManager.error('活动未开始')
end
return false
end

if not limitActivitiesController:checkJump(actInfo,actID)then
return false
end

if MysteryModel:is_in_mystery()then
UIManager.error("秘境内无法跳转")
return false
end

if fightModel:haveBattleShow()then
UIManager.error("战斗中无法跳转")
return false
end

actInfo:jump(extraParams)
return true
end

function limitActivitiesController:checkJump(actInfo,actID)
if actInfo==nil then
actInfo=limitActivitiesModel:getActInfo(actID)
end
if actInfo==nil then
return false
end


if limitActivitiesModel:isXMAct(actID)and limitActivitiesModel:isXMActJumpCheck(actID)then
if not xianmengModel:hasXM()then
local tips_str=cfgHelper.getlang("haveNotXianMengTips")
UIManager.error(tips_str)
return false
end
end


if not actInfo:checkOpen(true)then
return false
end


if not actInfo:checkJump_time(true)then
return false
end


if not actInfo:checkJump_data(true)then
return false
end

return true
end





function limitActivitiesController:markActPreview(actID)
local datas=userActorSetting.get('limitActPreviewMark',{})
local actID_str=tostring(actID)
datas[actID_str]=gameUtilityModel.getServerLongTime()
userActorSetting.set('limitActPreviewMark',datas)
userActorSetting.flush()
end

function limitActivitiesController:getActPreviewMark(actID)
local datas=userActorSetting.get('limitActPreviewMark',{})
local actID_str=tostring(actID)
local time=datas[actID_str]
local flag=false
if time~=nil and timeHelper.isTodayStamp(time)then
flag=true
end
return flag
end






function limitActivitiesController:send_248_1()
if verifyManager:isHideLimitActivities()then
return
end
socketManager:send_248_1()
end






function limitActivitiesController.recv_248_1(len,actList,crossFlag)
if verifyManager:isHideLimitActivities()then
return
end




local isclear=crossFlag==0
limitActivitiesModel:initActMark(actList,isclear)
end



function limitActivitiesController.on_system_open(sysid)
if verifyManager:isHideLimitActivities()then
return
end
local openList
local closeList
if not limitActivitiesController.openCndLookup then
limitActivitiesController.openCndLookup={openList={},closeList={}}
openList=limitActivitiesController.openCndLookup.openList
closeList=limitActivitiesController.openCndLookup.closeList
local cfgs=cfg_xianshihuodongconfig()
for i,actcfg in ipairs(cfgs)do
if not limitActivitiesModel.checkActForbidden(actcfg)then
local openCnd=actcfg.openCnd
if actcfg.openCnd then
local type=openCnd[1]
local value=openCnd[2]
if type==1 then
if not openList[value]then
openList[value]={}
end
table.insert(openList[value],actcfg.id)
elseif type==2 then
if not closeList[value]then
closeList[value]={}
end
table.insert(closeList[value],actcfg.id)
end
end
end
end
end

openList=limitActivitiesController.openCndLookup.openList
closeList=limitActivitiesController.openCndLookup.closeList

if openList and openList[sysid]then
for i,actId in ipairs(openList[sysid])do

limitActivitiesModel:addAct(actId)
end
end
if closeList and closeList[sysid]then
for i,actId in ipairs(closeList[sysid])do

limitActivitiesModel:removeActInfo(actId)
end
end
end
