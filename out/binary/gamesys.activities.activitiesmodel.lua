







activitiesModel={}

activitiesModel.activityIdleState=0
activitiesModel.activityDoingState=1
activitiesModel.activityFinishState=2

local subActivityConfigGetterLookup={}
local subActivityConfigGetterLookup2={}

local dataLookup=nil
local actInitDatas=nil

function activitiesModel:recv_actInitDatas(serverType,len,actList)

if not initProControl.isDone()then
if actInitDatas==nil then
actInitDatas={}
end
actInitDatas[serverType]=actList or{}
else
activitiesModel:refreshActInfoList(serverType,actList)
activitiesController:refreshAllActEnter()
end
end

function activitiesModel:recv_openActDatas(serverType,len,actList)
if len<=0 then return end
for i,v in ipairs(actList)do
local act_id=v.act_id
local isNew=activitiesModel:setActInfo(v)

if isNew then
local actInfo=dataLookup[act_id]
actInfo:onReady()
if actInfo:checkDoing()then

notifySystem:postNotify(notifyConfig.onActivityStateChange,act_id,activitiesModel.activityDoingState)
end
local sublist=actInfo:get_sublist()
for i,sub_actInfo in ipairs(sublist)do

sub_actInfo:refreshCondition()

end
end
end
activitiesController:refreshAllActEnter()
end

function activitiesModel:handle_actInitDatas()
activitiesModel:clearData()

dataLookup={}
if actInitDatas then
for serverType,actList in pairs(actInitDatas)do
for i,v in ipairs(actList)do
activitiesModel:setActInfo(v)
end
end
end
activitiesModel:refreshAllActMerge()
actInitDatas=nil
end

function activitiesModel:refreshActInfoList(serverType,actList)






local lookup={}
if actList then
for i,v in ipairs(actList)do
local act_id=v.act_id
lookup[act_id]=true
local isNew=activitiesModel:setActInfo(v)
if isNew then
local actInfo=dataLookup[act_id]
actInfo:onReady()
if actInfo:checkDoing()then
notifySystem:postNotify(notifyConfig.onActivityStateChange,act_id,activitiesModel.activityDoingState)
end
end
end
end

local dels={}
for act_id,actInfo in pairs(dataLookup)do
if lookup[act_id]==nil and actInfo:getServerType()==serverType then
table.insert(dels,act_id)
end
end
if#dels>0 then
for i,act_id in ipairs(dels)do
local flag=activitiesModel:removeActInfo(act_id)
if flag then
notifySystem:postNotify(notifyConfig.onActivityStateChange,act_id,activitiesModel.activityFinishState)
end
end
end
activitiesModel:refreshAllActMerge()
end

function activitiesModel:removeActInfo(actID)
if dataLookup==nil then return false end
local actInfo=dataLookup[actID]
if actInfo~=nil then
release_activityInfo(actInfo)
dataLookup[actID]=nil
actInfo=nil
actRoleController.onActivityStateFinish(actID)
return true
end
return false
end

function activitiesModel:setActInfo(data)
local actInfo=dataLookup[data.act_id]
local isNew=actInfo==nil
if isNew then
actInfo=new_activityInfo(data)
dataLookup[data.act_id]=actInfo
else
actInfo:resetData(data)
end
return isNew
end

function activitiesModel:refreshAllActMerge()
if dataLookup==nil then return end
for act_id,actInfo in pairs(dataLookup)do
actInfo:refreshMerge()
end
end

function activitiesModel:getAllActivitiesEx()
return dataLookup
end

function activitiesModel:getAllActivities()
return dataLookup or{}
end

function activitiesModel:getAnyOpenActInfoBySubtype(subType)
if dataLookup==nil then return end
for actID,actInfo in pairs(dataLookup)do
local sub_actList=actInfo:getSubActInfoList(subType)
if sub_actList~=nil then
for subid,sub_actInfo in pairs(sub_actList)do
if sub_actInfo:checkOpen()then
return actInfo
end
end
end
end
end


function activitiesModel:getActInfo(actID)
if dataLookup==nil then return end
return dataLookup[actID]
end

function activitiesModel:setSubActInfoData(actID,subType,subid,data)
local subActInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if subActInfo then
subActInfo:setData(data)
end
end

function activitiesModel:getSubActInfoData(actID,subType,subid)
local subActInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if subActInfo then
return subActInfo:getData()or{}
end

return nil
end


function activitiesModel:getSubActInfo(actID,subType,subid)
local actInfo=activitiesModel:getActInfo(actID)
if actInfo then
return actInfo:getSubActInfo(subType,subid)
end
end


function activitiesModel:findSubActInAct(tag_actID,actID,subType,subid)
local actInfo=activitiesModel:getActInfo(tag_actID)
if actInfo then
return actInfo:checkSubIn(actID,subType,subid)
end
return false
end

function activitiesModel:getActSubList_open_doing(actID)
local actInfo=activitiesModel:getActInfo(actID)
if actInfo then
return actInfo:getSubList_open_doing()
end
end

function activitiesModel:getActSubList_subType_doing(subType)
if dataLookup==nil then return end
local list={}
for actID,actInfo in pairs(dataLookup)do
if actInfo:checkDoing()then
local sub_actList=actInfo:getSubActInfoList(subType)
if sub_actList~=nil then
for subid,sub_actInfo in pairs(sub_actList)do
if sub_actInfo:checkDoing()then
table.insert(list,sub_actInfo)
end
end
end
end
end
return list
end

function activitiesModel:getActSubList_subType_open_doing(subType)
if dataLookup==nil then return end
local list={}
for actID,actInfo in pairs(dataLookup)do
if actInfo:checkOpen()and actInfo:checkDoing()then
local sub_actList=actInfo:getSubActInfoList(subType)
if sub_actList~=nil then
for subid,sub_actInfo in pairs(sub_actList)do
if sub_actInfo:checkOpen()and sub_actInfo:checkDoing()then
table.insert(list,sub_actInfo)
end
end
end
end
end
return list
end

function activitiesModel:getActSubList_subType_subid_doing(subType,subid)
if dataLookup==nil then return end
local list={}
for actID,actInfo in pairs(dataLookup)do
if actInfo:checkDoing()and actInfo:checkOpen()then
local sub_actInfo=actInfo:getSubActInfo(subType,subid)
if sub_actInfo~=nil and sub_actInfo:checkDoing()then
table.insert(list,sub_actInfo)
end
end
end
if#list==0 then
for actID,actInfo in pairs(dataLookup)do
if actInfo:checkDoing()then
local sub_actInfo=actInfo:getSubActInfo(subType,subid)
if sub_actInfo~=nil and sub_actInfo:checkDoing()then
table.insert(list,sub_actInfo)
end
end
end
end

return list
end

function activitiesModel:clearData()
activitiesModel:clearData_CommonAct()
if dataLookup==nil then return end
for act_id,actInfo in pairs(dataLookup)do
release_activityInfo(actInfo)
end
dataLookup=nil
end


function activitiesModel:getAllActivities_show()
local list={}
if dataLookup then
local lookup={}
local merge_lp={}
for act_id,actInfo in pairs(dataLookup)do
if actInfo:checkDoing()then
lookup[act_id]=actInfo
actInfo:mark_merge(merge_lp)
end
end
for act_id,actInfo in pairs(lookup)do
if merge_lp[act_id]==true then

if actInfo:hasMerge()then
table.insert(list,actInfo:get_act_id())
end
else
table.insert(list,actInfo:get_act_id())
end
end
end
return list
end


function activitiesModel:checkActHasSelfEnter(actID)
local actInfo=activitiesModel:getActInfo(actID)
if actInfo then
if actInfo:checkDoing()then

if activitiesModel:checkActInMerge(actID)then

if actInfo:hasMerge()then
return true
end
else
return true
end
end
end
return false
end


function activitiesModel:checkActInMerge(actID)
if dataLookup then
for act_id,actInfo in pairs(dataLookup)do
if act_id~=actID and actInfo:checkDoing()and actInfo:is_in_merge(actID)then
return act_id
end
end
end
return nil
end

function activitiesModel:checkActReddot(actID)
local actInfo=activitiesModel:getActInfo(actID)
if actInfo then
return actInfo:getRoddot()
end
return false
end

function activitiesModel:checkSubActReddot(actID,subType,subid)
local actInfo=activitiesModel:getActInfo(actID)
if actInfo then
return actInfo:checkSubReddot(subType,subid)
end
return false
end

function activitiesModel:checkSubActUnlock(actID,subType,subid,isWarning)
local actInfo=activitiesModel:getActInfo(actID)
if actInfo then
return actInfo:checkSubUnlock(subType,subid,isWarning)
end
return false
end


function activitiesModel:refreshSubActUnlock(actID)
local actInfo=activitiesModel:getActInfo(actID)
if actInfo then
actInfo:refreshSubUnlock()
end
end

function activitiesModel:callRefreshActEnter(actID,subType,subid,funcName,args)
local actInfo=activitiesModel:getActInfo(actID)
if actInfo then
actInfo:refreshEnterEx(funcName,args)
local subActInfo=actInfo:getSubActInfo(subType,subid)
if subActInfo then
subActInfo:refreshEnterEx(funcName,args)
end
end
end

function activitiesModel:checkActOpen(actID)
local actInfo=activitiesModel:getActInfo(actID)
if actInfo then
return actInfo:checkOpen()
end
return false
end


function activitiesModel:getSubPanelLookup(actID,subType,subid)
local subActInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if subActInfo then
return subActInfo:getPanelLookup()
end
end


function activitiesModel:invokeActUIMethod(actID,fName,...)
local actInfo=activitiesModel:getActInfo(actID)
if actInfo then
return actInfo:invokePanelMethod(fName,...)
end
end


function activitiesModel:invokeSubActUIMethod(actID,subType,subid,fName,...)
local subActInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if subActInfo then
subActInfo:invokePanelMethod(fName,...)
end
end

function activitiesModel:getActEndLeftTime(actID)
local actInfo=activitiesModel:getActInfo(actID)
if actInfo then
return actInfo:getEndLeftTime()
end
return 0
end

function activitiesModel:getActStartLeftTime(actID)
local actInfo=activitiesModel:getActInfo(actID)
if actInfo then
return actInfo:getStartLeftTime()
end
return 0
end

function activitiesModel:getSubActEndLeftTime(actID,subType,subid)
local subActInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if subActInfo then
return subActInfo:getEndLeftTime()
end
return 0
end

function activitiesModel:getSubActStartLeftTime(actID,subType,subid)
local subActInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if subActInfo then
return subActInfo:getStartLeftTime()
end
return 0
end

function activitiesModel:getSubActStartTime(actID,subType,subid)
local subActInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if subActInfo then
return subActInfo:getStartTime()
end
return 0
end

function activitiesModel:printActInfo(actID)
local actInfo=activitiesModel:getActInfo(actID)
if actInfo then
actInfo:printInfo()
end
end

function activitiesModel:printSubActInfo(actID,subType,subid)
local subActInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if subActInfo then
subActInfo:printInfo()
end
end

function activitiesModel:checkSubActOpen(actID,subType,subid,isWarning)
local subActInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if subActInfo then
return subActInfo:checkOpen(isWarning)
end
end



function activitiesModel.getEnterIcon(iconID)
local abName=globalABLookup.mainEntrySprite
local icon=FMT.fmt('act_entericon_{0}',iconID)
return abName,icon
end

function activitiesModel.getActBgABName(bgname)
return FMT.fmt('ui/windows/activities/sharedtextures/{0}.ab',bgname)
end

function activitiesModel:getActConfig(actID,...)
local serverType=activitiesModel:getServerType(actID)
if serverType==activitiesServerType.eKuafu then
return cfgHelper.get(cfg_crossactconfig_get,actID,...)
elseif serverType==activitiesServerType.eRole then
return cfgHelper.get(cfg_actoractconfig_get,actID,...)
elseif serverType==activitiesServerType.eBigCross then
return cfgHelper.get(cfg_cbigcrossactconfig_get,actID,...)
else
return cfgHelper.get(cfg_activityconfig_get,actID,...)
end
end




function activitiesModel:getSubActivityConfig(subType,subid,...)
local getter=activitiesModel:getSubActivityConfigGetter2(subType)
return cfgHelper.get(getter,subid,...)
end

function activitiesModel:getSubActivity_def(subType,...)
local getter=activitiesModel:getSubActivityConfigGetter(subType)
return cfgHelper.getdef(getter,...)
end

function activitiesModel:getSubActivityConfigGetter(subType)
local getter=subActivityConfigGetterLookup[subType]
if getter==nil then
local cfg=cfgHelper.get1(cfg_subactivitytypeconfig_get,subType)
getter=cfgHelper.getCofingFunction(cfg.configname)
subActivityConfigGetterLookup[subType]=getter
end
return getter
end

function activitiesModel:getSubActivityConfigGetter2(subType)
local getter=subActivityConfigGetterLookup2[subType]
if getter==nil then
local cfg=cfgHelper.get1(cfg_subactivitytypeconfig_get,subType)
getter=cfgHelper.getCofingGetFunction(cfg.configname)
subActivityConfigGetterLookup2[subType]=getter
end
return getter
end



function activitiesModel:getActCondition(act_id)
local serverType=activitiesModel:getServerType(act_id)
if activitiesServerType.eRole==serverType and
activitiesModel:getActInfo(act_id)~=nil then
return nil
end
return activitiesModel:getActConfig(act_id,'condition')
end



function activitiesModel:isEnoughOpenCfgCnd(act_id,start_time,isWarning)
local serverType=activitiesModel:getServerType(act_id)
local cfg=activitiesModel:getActConfig(act_id)

local params=cfg.opentimelimit
local ret,out=activitiesModel:checkOpenTime(params,isWarning)
if not ret then return false,out end

local params=cfg.opendelaydays
local ret=activitiesModel:checkOpenDelayDay(params,isWarning,act_id)
if not ret then return false end

local params=cfg.opendaylimit
local ret,out=activitiesModel:checkOpenDay(start_time,params,isWarning,act_id)
if not ret then return false,out end

local params=cfg.serverCondition
local ret=activitiesModel:checkOpenServerCondition(params,isWarning,act_id)
if not ret then return false end

local params=cfg.openTimeLimit2
local ret=activitiesModel:checkOpenTimeLimitTwo(params,isWarning,act_id)
if not ret then return false end

local params=cfg.langVer
local ret=activitiesModel:checklangVerCondition(params,isWarning)
if not ret then return false,true end

local params=activitiesModel:getActCondition(act_id)
local ret,params=activitiesModel:checkOpenParams(params)
if isWarning and not ret and params then
local tips=activitiesModel:getSingleCndTips(params)
UIManager.error(tips)
end

return ret
end



function activitiesModel:checkOpenTime(params,isWarning)
if params==nil then return true end

local openTime=timeHelper.getServerOpenZeroLongStamp(timeHelper.getServerOpenLongTime())
local startFmt=params[1]
local endFmt=params[2]
local ret
if startFmt~=0 and endFmt~=0 then
local startStamp=timeHelper.getDateStamp(startFmt)
local endStamp=timeHelper.getDateStamp(endFmt)
ret=openTime>=startStamp and endStamp>=openTime
elseif startFmt==0 then
local endStamp=timeHelper.getDateStamp(endFmt)
ret=endStamp>=openTime
else
local startStamp=timeHelper.getDateStamp(startFmt)
ret=openTime>=startStamp
end
if isWarning and not ret then
UIManager.error('无法开启活动')
end
return ret,not ret
end



function activitiesModel:checkOpenDelayDay(params,isWarning,act_id)
if params==nil then return true end
local _ver=pfwindowslController:getGameVersion()
local _pfId=gameUtilityModel.getServerPlatform()







local _verCfg=params[_ver]or params[-1]
if not _verCfg then

return true
end







local _delayday=_verCfg[_pfId]or _verCfg[-1]
if not _delayday then
return true
end
local openDay=timeHelper.getServerOpenDay()
local delay=_delayday
local ret=openDay>delay
if isWarning and not ret then
UIManager.error(FMT.fmt('开服第{0}天开启',delay+1))
end
return ret
end



function activitiesModel:checkOpenDay(start_time,params,isWarning,act_id)
if params==nil then return true end
if start_time==nil then return false end

local longStamp=timeHelper.convertLongStamp(start_time)
local day=timeHelper.getServerOpenDayByStamp(longStamp)

local _ver=pfwindowslController:getGameVersion()
local _pfId=gameUtilityModel.getServerPlatform()
local _verCfg=params[_ver]or params[-1]

if not _verCfg then

return true
end







local _limit=_verCfg[_pfId]or _verCfg[-1]
if not _limit then
return true
end

local min=_limit[1]
local max=_limit[2]
local ret
local out=false
if min~=0 and max~=0 then
ret=day>=min and max>=day
elseif max==0 then
ret=day>=min
else
ret=max>=day
end
if isWarning and not ret then
UIManager.error('无法开启活动')
end
return ret,not ret
end


function activitiesModel:checkOpenParams(params)
if params==nil then return true end
local args=nil
local ret=true
for ii,vv in ipairs(params)do
ret=ret and activitiesModel:checkSingleCnd(vv)
if not ret then
args=vv
break
end
end
return ret,args
end

function activitiesModel:checkSingleCnd(params)
local typo=params[1]
local num=params[2]
if typo==1 then

local lv=zongmenModel:getLevel()
return lv>=num
elseif typo==2 then

return taskModel:checkTaskFinish(num)
elseif typo==3 then

local recharge=rechargeModel:getTotalRecharge()
return recharge>=num
elseif typo==4 then

return systemModel.isOpen(num)
elseif typo==5 then

local level=params[3]
if not level then
return false
end
return activitiesModel:checkOpenByBuildlevel(num,level)
elseif typo==6 then

local actid=params[2]
local isOpened=actRoleController:checkActIsOpened(actid)
return not isOpened
end
return false
end

function activitiesModel:getSingleCndTips(params)
local typo=params[1]
local num=params[2]
local tips_str=''
if typo==1 then

tips_str=FMT.fmt('宗门达到{0}级开启',num)
elseif typo==2 then

local cfg=taskModel:getTaskConfig(num)
tips_str=FMT.fmt('完成任务<{0}>开启',cfg.name)
elseif typo==3 then

tips_str=FMT.fmt('充值{0}后开启',num)
elseif typo==4 then

tips_str=systemModel.getOpenTips(num)
elseif typo==5 then

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,num)
local name=cfg.name or'建筑'
local level=params[3]or 0
tips_str=FMT.fmt('{0}达到{1}级开启',name,level)
elseif typo==6 then



end
return tips_str
end

function activitiesModel:containsAct(list,actInfo)
for i,v in ipairs(list)do
if v.act_id==actInfo.act_id then return true end
end
return false
end

function activitiesModel:invokeSubActInfoMethod(actID,subType,subid,funcName,...)
local subActInfo=activitiesModel:getSubActInfo(actID,subType,subid)
if subActInfo then
if subActInfo[funcName]then
pcall(subActInfo[funcName],subActInfo,...)
end
end
end


function activitiesModel:savePlotPlayed(actID)
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eActivitiesPlot,tostring(actID),true)
end

function activitiesModel:isPlotPlayed(actID)
return userActorArraySetting.get(ACTOR_SETTING_TYPE.eActivitiesPlot,tostring(actID),false)
end



function activitiesModel:checkOpenServerCondition(params,isWarning,actid)
if params==nil then return true end
local ret=true
for ii,vv in ipairs(params)do
ret=ret and activitiesModel:checkServerCondition(vv,actid)
if not ret then
break
end
end
return ret
end
function activitiesModel:checkServerCondition(params,actid)
local typo=params[1]
local num=params[2]
if actid and actRoleController:isOpen(actid)then
return true
end
if typo==1 then

return seasonController:checkSeasonStageBegined(0,num)
end
return false
end

function activitiesModel:checklangVerCondition(params,isWarning)
if params==nil then return true end
local ret=true
local typo=params[1]
local pfversions=params[2]
local curPfVersion=pfwindowslController:getGameVersion()
if typo==1 then
if pfversions==nil then return false end
for _,v in ipairs(pfversions)do
if v==curPfVersion then return true end
end
return false
elseif typo==2 then
if pfversions==nil then return true end
for _,v in ipairs(pfversions)do
if v==curPfVersion then return false end
end
return true
end
return false
end


function activitiesModel:checkOpenByBuildlevel(bdId,needlevel)
local mountainCfg=cfg_monijysfconfig()
for _,v in ipairs(mountainCfg)do
local bdDatas=zongmenModel:getBuildingDataByBdId(v.id,bdId)
for _,bd in ipairs(bdDatas)do
if bd.level>=needlevel then
return true
end
end
end
return false
end



function activitiesModel:checkOpenTimeLimitTwo(params,isWarning,actid)
if params==nil then return true end
if actid and actRoleController:isOpen(actid)then
return true
end
local startTime=params[1]
local endTime=params[2]
if startTime==nil or endTime==nil then return false end
if type(endTime)=="string"then
local startStamp=timeHelper.getDateStamp(startTime)
local endStamp=timeHelper.getDateStamp(endTime)
local stamp=timeHelper.getServerLongTime()
return stamp>=startStamp and endStamp>=stamp
else
local startStamp=timeHelper.getDateStamp(startTime)
local stamp=timeHelper.getServerLongTime()
return stamp>=startStamp
end
return false
end
