














local _MODULENAME="activitiesController"
gameState.addListener(def_table(_MODULENAME))
activitiesController.name=_MODULENAME


local notNeedSendSubActType={
[SUB_ACTIVITY_TYPE.eTuFaEventAct]=true,
[SUB_ACTIVITY_TYPE.eCangBaoGeOverView]=true,
[SUB_ACTIVITY_TYPE.eQieShiShenShou]=true,
[SUB_ACTIVITY_TYPE.eLongHuZhiBao]=true,
[SUB_ACTIVITY_TYPE.ePassPortAct3]=true,
[SUB_ACTIVITY_TYPE.ePassPortAct4]=true,
[SUB_ACTIVITY_TYPE.eZaiXuXianYuan]=true,
}


local DerailcheckOpenSubActType=
{
[SUB_ACTIVITY_TYPE.eLongHuMountain]=true,
[SUB_ACTIVITY_TYPE.eLongHuXiangYao]=true,
[SUB_ACTIVITY_TYPE.eTuFaEventAct]=true,
}

local originalBgmId
local activityBgmId
local _temp={}
local _pushNum=10

function activitiesController:onAppStart()
activitiesController:register_receiver()
socketManager:addNotify(14,1,function()
activitiesModel:disposeActConditionChange(3)
end)
activitiesController:onAppStart_sys()
end

function activitiesController:onEnterState()
originalBgmId=nil
activityBgmId={}
notifySystem:listenNotify(notifyConfig.onActivityStateChange,self.onActivityStateChange)
notifySystem:listenNotify(notifyConfig.onSubActivityStateChange,self.onSubActivityStateChange)
notifySystem:listenNotify(notifyConfig.onReddotCatchTypeChange,self.onReddotCatchTypeChange)

notifySystem:listenNotify(notifyConfig.onDiscipleNewID,self.onDiscipleNewID)
notifySystem:listenNotify(notifyConfig.building_event,self.building_event)
notifySystem:listenNotify(notifyConfig.onTaskChange,self.onTaskChange)
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
notifySystem:listenNotify(notifyConfig.onBaoLingShuPickUpStateChange,self.onBaoLingShuPickUpStateChange)
activitiesController:onEnterState_sys()
activitiesController:handle_onEnterState()
activityEnterMergeController:onEnterState()
end

function activitiesController:onLeaveState(isReconnet)
if not isReconnet then
notifySystem:removelistener(notifyConfig.onActivityStateChange,self.onActivityStateChange)
notifySystem:removelistener(notifyConfig.onSubActivityStateChange,self.onSubActivityStateChange)
notifySystem:removelistener(notifyConfig.onReddotCatchTypeChange,self.onReddotCatchTypeChange)

notifySystem:removelistener(notifyConfig.onDiscipleNewID,self.onDiscipleNewID)
notifySystem:removelistener(notifyConfig.building_event,self.building_event)
notifySystem:removelistener(notifyConfig.onTaskChange,self.onTaskChange)
notifySystem:removelistener(notifyConfig.onNewDay,self.onNewDay)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
notifySystem:removelistener(notifyConfig.onBaoLingShuPickUpStateChange,self.onBaoLingShuPickUpStateChange)
activitiesModel:clearData()
_temp={}
release_all_activitiesHandle()
else
local curBgmId=AudioManager.getCurrentBgm()
if originalBgmId and originalBgmId~=curBgmId then
AudioManager.playBgMusic(originalBgmId)
end
end
activitiesController:handle_onLeaveState()
activitiesController:onLeaveState_sys()
originalBgmId=nil
activityBgmId={}
activityEnterMergeController:onLeaveState()
end

function activitiesController:onPlayerCreate(...)

end

function activitiesController:onProtocolReq()
activitiesModel:handle_actInitDatas()
activitiesController:checkInitSubActivities()
activitiesController:refreshAllActEnter()
actRoleController:initRoleActs()
timeEventController.addQuickTimerHandler(activitiesController.name,activitiesController)
end

function activitiesController:onLostConnection()

end

function activitiesController.onReddotCatchTypeChange(catchType,...)
activitiesModel:disposeSubActReddotChange(catchType,...)
end


function activitiesController.onDiscipleNewID(disguid,dzid)
activitiesModel:disposeSubActConditionChange(1,dzid)
end


function activitiesController.onBaoLingShuPickUpStateChange()
activitiesModel:disposeSubActConditionChange(2)
end


function activitiesController.building_event(eventType,param1,param2,param3)
if eventType==buildingEvent.zongmenLevelUp and param3~=param1 then

activitiesModel:disposeActConditionChange(1)
activitiesModel:disposeSubActConditionChange(5)
end
end


function activitiesController.onTaskChange(taskid,taskstate)
if taskstate==taskModel.taskFinishState then
activitiesModel:disposeActConditionChange(2)
end
end


function activitiesController.onNewDay()
activitiesModel:disposeActSpeChange()
activitiesController.checkAllNewDay()
end


function activitiesController.on_system_open(sysId)
activitiesModel:disposeActConditionChange(4,sysId)
end




function activitiesController:getOpenWinParam()
local p=UIManager:invokeUIMethod('UI_activity_main_Win_define','getOpenParams')
if p==nil then
p=UIManager:invokeUIMethod('UI_activity_main_Win','getOpenParams')
end
return p
end




function activitiesController:checkInitSubActivities()
local all=activitiesModel:getAllActivities()

local lookup={}
for act_id,actInfo in pairs(all)do

actInfo:onReady_init()

if actInfo:checkDoing()then
local res=actInfo.sublist
local serverType=actInfo:getServerType()
if lookup[serverType]==nil then
lookup[serverType]={}
end
for i,sub_actInfo in ipairs(res)do
if sub_actInfo:checkDoing()and not notNeedSendSubActType[sub_actInfo.sub_act_type]then
table.insert(lookup[serverType],{sub_actInfo.act_id,sub_actInfo.sub_act_type,sub_actInfo.sub_act_id})
end
end
end
end
for serverType,list in pairs(lookup)do
if#list>0 then
activitiesController:sendProtocol(actSendType.eReqInfoList,serverType,list)
end
end
end


function activitiesController:onQuickUpdate()
if#_temp>0 then
local len=_pushNum
while#_temp>0 and len>0 do
local actInfo=_remove(_temp,1)
if actInfo.act_id then
actInfo:update()
end
len=len-1
end
else
local all=activitiesModel:getAllActivities()

for _,actInfo in pairs(all)do
_temp[#_temp+1]=actInfo
end

local len=#_temp
if len>0 then
_pushNum=math.ceil(len/5)
end
end
end

function activitiesController.onActivityStateChange(actID,state)
if state==activitiesModel.activityDoingState then

activitiesController:refreshActEnter(actID,true)
elseif state==activitiesModel.activityFinishState then

activitiesController:refreshActEnter(actID,false)
end
end

function activitiesController.onSubActivityStateChange(actID,subType,subid,state)
if state==activitiesModel.activityDoingState then


elseif state==activitiesModel.activityFinishState then


end
end

function activitiesController.checkAllNewDay()
local all=activitiesModel:getAllActivities()
for act_id,actInfo in pairs(all)do
actInfo:checkNewDay()
end
end




function activitiesController:refreshAllActEnter()
local all=activitiesModel:getAllActivities()
for act_id,actInfo in pairs(all)do
actInfo:refreshEnter(true)
actInfo:refreshAllSubEnter(true)
end
end

function activitiesController:refreshActEnter(actID,flag)
local actInfo=activitiesModel:getActInfo(actID)
if actInfo then
actInfo:refreshEnter(flag)
end
end





function activitiesController:check_jump(actID,subType,subid)
local actInfo=activitiesModel:getActInfo(actID)
if actInfo==nil then return false end
if not actInfo:checkOpen(false)then
return false
end
return true
end

function activitiesController:jump(actID,subType,subid,extraParams)
local actInfo=activitiesModel:getActInfo(actID)
if actInfo==nil then return false end


if not actInfo:checkOpen(true)then
return false
end

if not actInfo:checkOneSubOpen()then
return false
end

if actInfo:checkIdle()then
UIManager.error('活动未开始')
return false
end
if actInfo:checkFinish()then
UIManager.error('活动已结束')
return false
end

local actID_=actID
local actInfo_=actInfo

if actInfo_:checkIsTabWin()then
actID_=activitiesModel:checkActInMerge(actID)
if actID_~=nil then
actInfo_=activitiesModel:getActInfo(actID_)
assert(actInfo_~=nil,'这里必不为空')


if not actInfo_:checkOpen(true)then
return false
end

if not actInfo_:checkOneSubOpen()then
return false
end
else

actID_=actID
end
end

local num=actInfo_:getSubList_notFinish_num()
if num<=0 then







return false
end


local sub_noDataList=actInfo_:getSubList_doing_noData()
if#sub_noDataList>0 then
for i,sub_base in ipairs(sub_noDataList)do








end
return false
end


if extraParams~=nil and extraParams.jumpInType==act_jump_in_type.eEnterIn then
local plotParams=actInfo:getActStartPlot()
if plotParams then
if not activitiesModel:isPlotPlayed(actID)then
local checkPlot=taskModel:activeTaskPlot(plotParams,actInfo:getActScreenParams())
if checkPlot then
activitiesModel:savePlotPlayed(actID)
return false
end
end
end
end

local panelname=actInfo_:getPanelName()
local panelparams=actInfo_:getPanelParams()
panelparams.act_id=actID_
if actID_~=actID then
panelparams.old_act_id=actID
end
panelparams.sub_act_type=subType
panelparams.sub_act_id=subid
panelparams.extraParams=extraParams
panelparams.moneyWinType=fullTopMoneyType.eSkin2

local showTopMask=activitiesModel:getActConfig(actID_,"hideTopMask")
if showTopMask==nil then
showTopMask=true
end

local showBlur=activitiesModel:getActConfig(actID_,"hideBlur")
if showBlur==nil then
showBlur=true
end

if actInfo_:checkConcatByCfg()then
local concatType,tabType=actInfo_:getConcatArgs()
local ret=contactTabController:checkTab(concatType,tabType,panelparams)
if ret then
contactTabController:jumpTab(concatType,tabType,panelparams,true)
return true
end
end

if extraParams~=nil and extraParams.isFull~=nil then
panelparams.isFull=extraParams.isFull
end
if activityEnterMergeController:checkMergeActivity(actID_)then
local winName,params,showBlur,id,showBg,skinType,showTopMask=activityEnterMergeController:getShowparams(actID,subType,subid,extraParams)
UIFullCommonControl:showCommonWindow(winName,params,showBlur,id,showBg,skinType,showTopMask)
else
UIFullCommonControl:showCommonWindow(panelname,panelparams,showBlur,actID_,false,fullScreenSkinType.eSkin5,showTopMask)
end


activitiesModel:extraCheck(actID_,subType,subid,extraParams)
return true
end



function activitiesController:hasActivityjumpSystem(subType,warning)
local sub_actInfo=activitiesModel:getAnyOpenActInfoBySubtype(subType)
return sub_actInfo~=nil
end


function activitiesController:jumpSystem_subType(subType,extraParams,warning)
local sub_actInfo=activitiesModel:getAnyOpenActInfoBySubtype(subType)
if sub_actInfo then
if sub_actInfo:checkOpen(warning)then
local base=sub_actInfo:getBaseData()
return activitiesController:jump(base.act_id,base.sub_act_type,base.sub_act_id,extraParams)
end
end
return false
end

function activitiesController:check_jump_subType(subType)
local sub_actList=activitiesModel:getActSubList_subType_doing(subType)
if#sub_actList>0 then
for i,sub_actInfo in ipairs(sub_actList)do
if sub_actInfo:checkOpen()and sub_actInfo:getUnlock()then
local actInfo=activitiesModel:getActInfo(sub_actInfo.act_id)
if actInfo and actInfo:checkSubUnlock_first(true)then
return sub_actInfo:getBaseData2()
end
end
end
end
return nil,nil,nil
end

function activitiesController:jump_subType(subType,extraParams)
local sub_actList=activitiesModel:getActSubList_subType_doing(subType)
if#sub_actList<=0 then
local name=cfgHelper.get2(cfg_subactivitytypeconfig_get,subType,'name')
UIManager.error(FMT.fmt('{0}活动尚未开始',name))
return false
end

for i,sub_actInfo in ipairs(sub_actList)do
if sub_actInfo:checkOpen()and sub_actInfo:getUnlock(#sub_actList==1)then
local actInfo=activitiesModel:getActInfo(sub_actInfo.act_id)
if actInfo and actInfo:checkSubUnlock_first(true)then
local base=sub_actInfo:getBaseData()
return activitiesController:jump(base.act_id,base.sub_act_type,base.sub_act_id,extraParams)
end
end
end

return false
end

function activitiesController:check_jump_subType_subid(subType,subid)
local sub_actList=activitiesModel:getActSubList_subType_subid_doing(subType,subid)
if#sub_actList>0 then
for i,sub_actInfo in ipairs(sub_actList)do
local base=sub_actInfo:getBaseData()
extraParams=extraParams or{}
local yl_sub_type=extraParams.ylSubType
local yl_sub_id=extraParams.ylSubId
if yl_sub_type~=nil and yl_sub_id~=nil then
if DerailcheckOpenSubActType[base.sub_act_type]then
local yl_sub_actList=activitiesModel:getActSubList_subType_subid_doing(yl_sub_type,yl_sub_id)
for i,yl_sub_actInfo in ipairs(yl_sub_actList)do
if yl_sub_actInfo:checkOtherSubActCond(base.sub_act_type,base.sub_act_id,true)then
return base.act_id,base.sub_act_type,base.sub_act_id
end
end
end
else
if sub_actInfo:checkOpen(true)and sub_actInfo:getUnlock(true)then
local actInfo=activitiesModel:getActInfo(sub_actInfo.act_id)
if actInfo and actInfo:checkSubUnlock_first(true)then
return base.act_id,base.sub_act_type,base.sub_act_id
end
end
end
end
end
return nil,nil,nil
end

function activitiesController:jump_subType_subid(subType,subid,extraParams)
local sub_actList=activitiesModel:getActSubList_subType_subid_doing(subType,subid)
if#sub_actList<=0 then
local name=activitiesModel:getSubActivityConfig(subType,subid,'sub_name')
UIManager.error(FMT.fmt('{0}活动尚未开始',name))
return false
end

for i,sub_actInfo in ipairs(sub_actList)do
local base=sub_actInfo:getBaseData()
extraParams=extraParams or{}
local yl_sub_type=extraParams.ylSubType
local yl_sub_id=extraParams.ylSubId
if yl_sub_type~=nil and yl_sub_id~=nil then
if DerailcheckOpenSubActType[base.sub_act_type]then
local yl_sub_actList=activitiesModel:getActSubList_subType_subid_doing(yl_sub_type,yl_sub_id)
for i,yl_sub_actInfo in ipairs(yl_sub_actList)do
if yl_sub_actInfo:checkOtherSubActCond(base.sub_act_type,base.sub_act_id,true)then
return activitiesController:jump(base.act_id,base.sub_act_type,base.sub_act_id,extraParams)
end
end
end
else
if sub_actInfo:checkOpen(true)then
local actInfo=activitiesModel:getActInfo(sub_actInfo.act_id)
if actInfo and actInfo:checkSubUnlock_first(true)then
return activitiesController:jump(base.act_id,base.sub_act_type,base.sub_act_id,extraParams)
end
end
end
end

return false
end

function activitiesController:check_jump_list(sublist)
if#sublist~=nil then
for i,v in ipairs(sublist)do
local subType=v[1]
local subid=v[2]
local sub_actList=activitiesModel:getActSubList_subType_subid_doing(subType,subid)
if#sub_actList>0 then
for i2,sub_actInfo in ipairs(sub_actList)do
if sub_actInfo:checkOpen()and sub_actInfo:checkUnlock_first()then
local actInfo=activitiesModel:getActInfo(sub_actInfo.act_id)
if actInfo and actInfo:checkSubUnlock_first()then
return sub_actInfo:getBaseData2()
end
end
end
end
end
end
return nil,nil,nil
end

function activitiesController:jump_list(sublist,extraParams)
if sublist==nil or#sublist<=0 then
return false
end
local sub_actInfo
for i,v in ipairs(sublist)do
local subType=v[1]
local subid=v[2]
local sub_actList=activitiesModel:getActSubList_subType_subid_doing(subType,subid)
if#sub_actList>0 then
for i2,sub_actInfo_ in ipairs(sub_actList)do
if sub_actInfo_:checkOpen()and sub_actInfo_:checkUnlock_first()then
local actInfo=activitiesModel:getActInfo(sub_actInfo_.act_id)
if actInfo and actInfo:checkSubUnlock_first()then
sub_actInfo=sub_actInfo_
break
end
end
end
end
end
if sub_actInfo==nil then
UIManager.error('活动尚未开始')
return false
end
local base=sub_actInfo:getBaseData()
return activitiesController:jump(base.act_id,base.sub_act_type,base.sub_act_id,extraParams)
end

function activitiesController:jump_DontHandle(actId,subType,subId,extraParams)
if activitiesModel:isDontHandleSubType(subType)then
local jumpHanlde=activitiesModel:getDontHandleSubTypeJump(subType)
if jumpHanlde then
return jumpHanlde(actId,subType,subId,extraParams)
else
return false
end
end
loggerUtil.logErrFMT("子活动类型不是放弃处理类型：{0}",subType)
return false
end


function activitiesController:checkBgmByOpenActivitiesMainWin(actId,bgmParam)

local actBgmParam=actId~=nil and activitiesModel:getActConfig(actId,"actBgmParam")or bgmParam
local actBgmId=actBgmParam and actBgmParam.bgmId or nil
local volWeight=actBgmParam and actBgmParam.volWeight or nil
local curBgmId=AudioManager.getCurrentBgm()
if actBgmId then

if not originalBgmId then
originalBgmId=curBgmId
end

if not activityBgmId or activityBgmId==-1 or activityBgmId~=actBgmId then
AudioManager.playBgMusic(actBgmId,nil,volWeight)
end
activityBgmId=actBgmId
else

if originalBgmId and originalBgmId~=curBgmId then
AudioManager.playBgMusic(originalBgmId)
end
activityBgmId=nil
originalBgmId=originalBgmId
end
end


function activitiesController:resetBgmByCloseActivitiesMainWin()
local curBgmId=AudioManager.getCurrentBgm()
if originalBgmId and originalBgmId~=curBgmId then
AudioManager.playBgMusic(originalBgmId)
end
originalBgmId=nil
activityBgmId=nil
end



function activitiesController:setUI_activity_main_Win_blackImg(flag)
UIManager:invokeUIMethod("UI_activity_main_Win","activeBlack",flag)
end





function activitiesController:test_clearActivitiesShowReddotData()
userActorArraySetting.clear(ACTOR_SETTING_TYPE.eActivityReddotShow)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eActivityReddotShow)
end

