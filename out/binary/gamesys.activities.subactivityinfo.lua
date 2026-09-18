







local subActivityObject={}

function subActivityObject:__init(actInfo,idx_cfg,idx)
local sub_act_type=idx_cfg[1]
local sub_act_id=idx_cfg[2]
self.act_idx=idx
self.unlockType=actInfo.unlockType
self.idx_cfg=idx_cfg

self.sub_act_type=sub_act_type
self.sub_act_id=sub_act_id
self.act_id=actInfo.act_id

local condition=self:getSubActConfig('condition')
if condition==nil then
condition=cfgHelper.get2(cfg_subactivitytypeconfig_get,self.sub_act_type,'condition')
end
self.condition_cfg=condition

self:resetData(actInfo,true)


local autoExtra=nil
local autoExtraConfig=self:getActConfig('autoExtraConfig')
if autoExtraConfig then
for i,v in ipairs(autoExtraConfig)do
if v[1]==self.sub_act_type and v[2]==self.sub_act_id then
autoExtra=mathHelper.deepCopy(v)
end
end
end
self.autoExtra=autoExtra


local subwinLookup={}
local openPanel=self:getSubActConfig('openPanel')
if openPanel then
for i,v in ipairs(openPanel)do
local sub_panelType=v[1]
local sub_panelcfg=cfgHelper.get1(cfg_subactivityspanelconfig_get,sub_panelType)
if sub_panelcfg then
subwinLookup[sub_panelcfg.panelname]=table.deepCopy(v[2])or{}
else



end
end
end
self.subwinLookup=subwinLookup

self:onInit()

self:refreshState()
end

function subActivityObject:resetData(actInfo,isInit)
local isChange=false
if not isInit then
if self.start_time~=actInfo.start_time or self.end_time~=actInfo.end_time then
isChange=true
end
end

if isInit or isChange then
local flag=self.idx_cfg[3]
if flag==0 then

self.start_time=actInfo.start_time
self.end_time=actInfo.end_time
self.start_time_l=actInfo.start_time_l
self.end_time_l=actInfo.end_time_l
self.start_day_idx=1
self.end_day_idx=actInfo.openDays
self.openDays=actInfo.openDays
else

local e_day_idx,s_day_idx=mathHelper.splitToInt16(flag)
local s_time,e_time=activitiesModel.get_open_time(actInfo.start_time_l,actInfo.end_time_l,s_day_idx,e_day_idx)
self.start_time=gameUtilityModel.serverLongTimeToShort(s_time)
self.end_time=gameUtilityModel.serverLongTimeToShort(e_time)
self.start_time_l=s_time
self.end_time_l=e_time
self.start_day_idx=s_day_idx
self.end_day_idx=e_day_idx
local openDays=e_day_idx+1-s_day_idx
self.openDays=math.min(actInfo.openDays,openDays)
end


self.data=nil
end

if not isInit then



self:refreshState()
if not self:checkDoing()then
self:refreshEnter(false)
end
end
end

function subActivityObject:onInit()

end

function subActivityObject:__delete()
self:onDelete()

self.act_idx=nil
self.act_id=nil
self.sub_act_type=nil
self.sub_act_id=nil
self.idx_cfg=nil
self.start_time=nil
self.end_time=nil
self.start_time_l=nil
self.end_time_l=nil
self.openDays=nil
self.autoExtra=nil

self.subwinLookup=nil

self.data=nil
self.state=nil
self.reddotFlag=nil
self.delayReady=nil
self.updateErr=nil

self:refreshEnter(false)
if self.listenner~=nil then
for notify_id,func in pairs(self.listenner)do
notifySystem:removelistener(notify_id,func)
end
self.listenner=nil
end
end

function subActivityObject:onDelete()

end

function subActivityObject:getActID()
return self.act_id
end

function subActivityObject:getSubType()
return self.sub_act_type
end

function subActivityObject:getSubID()
return self.sub_act_id
end

function subActivityObject:getConditionCfg()
return self.condition_cfg
end


function subActivityObject:printInfo()
logErr(FMT.fmt('活动id：{0}, 子活动类型：{1}, 子活动id：{2}',self.act_id,self.sub_act_type,self.sub_act_id))
logErr(FMT.fmt('开始时间：{0}',timeHelper.getFormatByStamp(self.start_time_l)))
logErr(FMT.fmt('结束时间：{0}',timeHelper.getFormatByStamp(self.end_time_l)))
end

function subActivityObject:getTimeDesc1()
return activitiesModel.getTimeDesc1(self.start_time_l,self.end_time_l)
end


function subActivityObject:getOpenDayIndex()
return activitiesModel.get_open_day_index(self.start_time_l)
end


function subActivityObject:getDayArea()
return activitiesModel.get_day_area(self.start_time_l,self.end_time_l)
end

function subActivityObject:listenNotify(notify_id,func)
if self.listenner==nil then
self.listenner={}
end
if self.listenner[notify_id]==nil then
self.listenner[notify_id]=func
notifySystem:listenNotify(notify_id,func)
end
end

function subActivityObject:getPanelLookup()
return table.deepCopy(self.subwinLookup)
end

function subActivityObject:invokePanelMethod(fName,...)
local subwinLookup=self.subwinLookup
if subwinLookup then
for panelname,panelParams in pairs(subwinLookup)do
UIManager:invokeUIMethod(panelname,fName,...)
end
end
end


function subActivityObject:getStartLeftTime()
local lerp=0
if self:checkIdle()then
local cur=gameUtilityModel.getServerShortTime()
lerp=self.start_time-cur
if lerp<=0 then
lerp=0
end
end
return lerp
end


function subActivityObject:getEndLeftTime()
local lerp=0
if not self:checkFinish()then
local cur=gameUtilityModel.getServerShortTime()
lerp=self.end_time-cur
if lerp<=0 then
lerp=0
end
end
return lerp
end


function subActivityObject:getEndLeftDayTime()
local day=0
if not self:checkFinish()then
local cur=gameUtilityModel.getServerShortTime()
local lerp=self.end_time-cur
if lerp<=0 then
lerp=0
end
day=math.ceil(lerp/86400)
end
return day
end

function subActivityObject:getStartTime()
return self.start_time
end


function subActivityObject:getBaseData()
return{act_id=self.act_id,sub_act_type=self.sub_act_type,sub_act_id=self.sub_act_id}
end

function subActivityObject:getBaseData2()
return self.act_id,self.sub_act_type,self.sub_act_id
end


function subActivityObject:setData(data_)
if self.data==nil and data_~=nil then


end
self.data=data_
end

function subActivityObject:getData()
return self.data
end

function subActivityObject:hasData()
return self.data~=nil
end

function subActivityObject:compareType(sub_act_type)
return self.sub_act_type==sub_act_type
end

function subActivityObject:compare(actID,subType,subid)
return self.act_id==actID and self.sub_act_type==subType and self.sub_act_id==subid
end


function subActivityObject:onReady_init()
xpcall(function()
self.isopen=self:checkCondition()
self:onStart()
end,function(err)
loggerUtil.logErrFMT('subActivityObject onReady_init err!{0}',err)
end)
end


function subActivityObject:onReady()
xpcall(function()
self.isopen=self:checkCondition()
if self:checkDoing()then
if not self:hasData()then
activitiesController:sendProtocol(actSendType.eComonReqInfo,self.act_id,self.sub_act_type,self.sub_act_id)
end
end
self:onStart()
end,function(err)
loggerUtil.logErrFMT('subActivityObject onReady err!{0}',err)
end)
end





function subActivityObject:onStart()

end


function subActivityObject:refreshEnter(flag)

if self.autoExtra==nil then return end

local needClear=true
if flag then
local act_id=self.act_id
if self:checkDoing()and self:checkOpen()and activitiesModel:checkActOpen(act_id)then
if self.enterguid==nil then
local params={}
params.act_id=act_id
params.sub_act_type=self.sub_act_type
params.sub_act_id=self.sub_act_id
params.iconType=self.autoExtra[3]
params.icon=self.autoExtra[4]
params.effectId=self.autoExtra[5]
params.modelParams=self.autoExtra[6]
local enterIconType
if params.iconType==1 then
enterIconType=ENTER_ICON_TYPE.eNomal
else
enterIconType=ENTER_ICON_TYPE.eBig
end
local guid=enterManager:freshEnter({id=act_id,enterIconType=enterIconType,enterType=ENTER_TYPE.eOperActivity,
params=params,getReddotFun=function()
return activitiesModel:checkSubActReddot(params.act_id,params.sub_act_type,params.sub_act_id)
end})
self.enterguid=guid





end
needClear=false
end
end
if needClear then
if self.enterguid~=nil then
enterManager:removeEnter(self.enterguid)
self.enterguid=nil
end
end
end

function subActivityObject:refreshEnterEx(funcName,args)
if self.enterguid~=nil then
enterManager:freshFuncByGUID(self.enterguid,funcName,args)
end
end


function subActivityObject:update()
if self.delayReady~=nil then
self:onReady()
self.delayReady=nil
end
local old_state=self.state
self:refreshState()
local state=self.state
if old_state~=nil and old_state~=state then
if old_state==activitiesModel.activityIdleState and state==activitiesModel.activityDoingState then

self:refreshEnter(true)
self:onChangeState(activitiesModel.activityDoingState)
notifySystem:postNotify(notifyConfig.onSubActivityStateChange,self.act_id,self.sub_act_type,self.sub_act_id,activitiesModel.activityDoingState)
self.delayReady=true
elseif old_state==activitiesModel.activityDoingState and state==activitiesModel.activityFinishState then

self:refreshEnter(false)
self:onChangeState(activitiesModel.activityFinishState)
notifySystem:postNotify(notifyConfig.onSubActivityStateChange,self.act_id,self.sub_act_type,self.sub_act_id,activitiesModel.activityFinishState)
end
end
if self.onNewDay then
local cur=gameUtilityModel.getServerLongTime()
local y,m,d=timeHelper.getDateNumber(cur)
local t=timeHelper.timeServer(y,m,d,0,0,1)
if cur==t then
self:onNewDay()
end
end

if self.end_time and state==activitiesModel.activityDoingState then
local bfEnd24Time=self.end_time-86400
local nowTime=timeHelper.getServerShortTime()
local isBeforeEnd24HourTime=nowTime<bfEnd24Time
if self.isBeforeEnd24HourTime~=nil then
local isBeforeEnd24HourTime_last=self.isBeforeEnd24HourTime
if isBeforeEnd24HourTime_last and not isBeforeEnd24HourTime then
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
notifySystem:postNotify(notifyConfig.onSubActivityOverBeforeEndTime24Hour,self.act_id,self.sub_act_type,self.sub_act_id)
end
end
self.isBeforeEnd24HourTime=isBeforeEnd24HourTime
end

if not self.updateErr then
if self.pcallUpdateFunc1==nil then
self.pcallUpdateFunc1=function()
self:onUpdate()
end
self.pcallUpdateFunc2=function(err)
self.updateErr=true
loggerUtil.logErrFMT('subActivityObject err!{0}',err)
end
end
xpcall(self.pcallUpdateFunc1,self.pcallUpdateFunc2)
end
end

function subActivityObject:onUpdate()

end


function subActivityObject:onChangeState(state)

end

function subActivityObject:refreshState()
self.state=self:getState()
end

function subActivityObject:getState()
local cur=gameUtilityModel.getServerShortTime()
if cur<self.start_time then
return activitiesModel.activityIdleState
elseif cur>self.end_time then
return activitiesModel.activityFinishState
else
return activitiesModel.activityDoingState
end
end

function subActivityObject:checkIdle()
return self.state==activitiesModel.activityIdleState
end

function subActivityObject:checkDoing()
return self.state==activitiesModel.activityDoingState
end

function subActivityObject:checkFinish()
return self.state==activitiesModel.activityFinishState
end

function subActivityObject:refreshReddot()
local old=self.reddotFlag
self.reddotFlag=self:handelReddot()
if old~=self.reddotFlag then
notifySystem:postNotify(notifyConfig.onSubActivityReddotChange,self.act_id,self.sub_act_type,self.sub_act_id)
end
end

function subActivityObject:getRoddot()
local reddotFlag=self.reddotFlag
if reddotFlag==nil and self.data~=nil then
reddotFlag=self:handelReddot()
self.reddotFlag=reddotFlag
end
return reddotFlag
end

function subActivityObject:handelReddot()


if self.data~=nil then
local isForbiddenShowReddot=self:checkIsForbiddenShowReddot()
local isShowReddot=self:checkIsShowReddot()
if isForbiddenShowReddot or isShowReddot then
return self:checkReddot()
end
end

return false
end


function subActivityObject:checkReddot()

return false
end


function subActivityObject:checkOpen(isWarning)
if isWarning then
self.isopen=self:checkCondition(true)
end
return self.isopen
end


function subActivityObject:checkUnlock(isWarning)
return true
end



function subActivityObject:checkUnlock_first(isWarning)
return true
end

function subActivityObject:getUnlock(isWarning)

if self.isunlock==nil or isWarning then
self.isunlock=self:checkUnlockCondition(isWarning)
end
return self.isunlock
end

function subActivityObject:checkUnlockCondition(isWarning)
local flag
if self.unlockType~=nil then
if self.unlockType==0 then
flag=self:checkUnlock(isWarning)
elseif self.unlockType==1 then
if self.act_idx==1 then
flag=true
else
local actInfo=activitiesModel:getActInfo(self.act_id)
flag=actInfo:checkSubUnlock_first(isWarning)
end
end
else
flag=true
end
return flag
end

function subActivityObject:refreshUnlock()
local old=self.isunlock
self.isunlock=self:checkUnlockCondition()
local ischange=false
if old~=nil and self.isunlock~=old then
ischange=true
notifySystem:postNotify(notifyConfig.onSubActUnlock,self.act_id,self.sub_act_type,self.sub_act_id,self.isunlock)
end
return ischange
end


function subActivityObject:refreshCondition(args)
local old_isopen=self.isopen
self.isopen=self:checkCondition()
if old_isopen~=nil and self.isopen~=old_isopen then

self:refreshEnter(true)

local actInfo=activitiesModel:getActInfo(self.act_id)
if actInfo then
actInfo:refreshEnter(true)
end
local flag=self.isopen==true and 1 or 2
notifySystem:postNotify(notifyConfig.onSubActivityOpen,self.act_id,self.sub_act_type,self.sub_act_id,flag,args)
end
end

function subActivityObject:checkCondition(isWarning)
if self.condition_cfg then
for i,v in ipairs(self.condition_cfg)do
local typo=v[1]
local num=v[2]
if typo==1 then

local count=UIDiscipleModel:getSameIdDiscipleCount(num)
if count==0 then
if isWarning then
local name=cfgHelper.get2(cfg_discipleconfig_get,num,'name')
local tips_str=FMT.fmt('需要拥有弟子{0}',name)
UIManager.error(tips_str)
end
return false
end
elseif typo==2 then
local ret=baoLingShuModel:checkIsInPickUpNow()
if not ret and isWarning then
UIManager.error('不在活动时间内')
end
return ret
elseif typo==3 then
local actType=v[2]
local subId=v[3]
local sub_act=activitiesModel:getSubActInfo(self.act_id,actType,subId)
if sub_act and sub_act:checkOpen()then
local ret=sub_act:checkOtherSubActCond(self.sub_act_type,self.sub_act_id)
if not ret and isWarning then
local name_str=self:getSubActConfig('sub_name')or''
UIManager.error(FMT.fmt('{0}活动尚未开始',name_str))
end
return ret
end
elseif typo==4 then
return false
elseif typo==5 then
local lv=zongmenModel:getLevel()
if lv<num then
if isWarning then
local tips_str=FMT.fmt('需要宗门等级达到{0}级',num)
UIManager.error(tips_str)
end
return false
end
elseif typo==6 then
local passporttype=txzType.act
local subType=v[2]
local subId=v[3]

local guid=UITYTongXingZhengModel:getGuidByActID(passporttype,self.act_id,subType,subId)
local txzId=UITYTongXingZhengModel:getTXZId(guid)

if UITYTongXingZhengModel:isReceiveFullIncludeCharge(guid,txzId)then
local config=cfgHelper.get2(cfg_passportconfig_get,txzId,'drop_id')
if not config then
return false
end
end
end
end
end
if not self:checkOtherCondition(isWarning)then
return false
end
return true
end


function subActivityObject:checkOtherCondition(isWarning)
return true
end


function subActivityObject:checkOtherSubActCond(act_type,act_id2)
return true
end


function subActivityObject:checkNewDay()
local newDayReq=cfgHelper.get2(cfg_subactivitytypeconfig_get,self.sub_act_type,'newDayReq')
if newDayReq==true and self:checkDoing()then
activitiesController:sendProtocol(actSendType.eComonReqInfo,self.act_id,self.sub_act_type,self.sub_act_id)
end
end

function subActivityObject:isKuafuType()
return self:getServerType()==activitiesServerType.eKuafu
end

function subActivityObject:isRoleType()
return self:getServerType()==activitiesServerType.eRole
end

function subActivityObject:getServerType()
return activitiesModel:getServerType(self.act_id)
end

function subActivityObject:getActConfig(...)
return activitiesModel:getActConfig(self.act_id,...)
end

function subActivityObject:getSubActConfig(...)
return activitiesModel:getSubActivityConfig(self.sub_act_type,self.sub_act_id,...)
end


function subActivityObject:getStart2NowDay()
local day=0
if not self:checkIdle()then
local y,m,d=timeHelper.getDateNumber(self.start_time_l)
local t=timeHelper.timeServer(y,m,d,0,0,0)
local cur=gameUtilityModel.getServerLongTime()

local lerp=cur-t
if lerp<=0 then
lerp=0
end
day=math.ceil(lerp/86400)
end
return day
end

function subActivityObject:checkIsForbiddenShowReddot()
return false
end

function subActivityObject:checkIsShowReddot(extraKey)

local key
if extraKey then
key=string.format("%s_%s_%s_%s",self.act_id,self.sub_act_type,self.sub_act_id,extraKey)
else
key=string.format("%s_%s_%s",self.act_id,self.sub_act_type,self.sub_act_id)
end
local showReddotData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eActivityReddotShow,key,nil)
if not showReddotData then

return true
end

local nowTime=timeHelper.getServerShortTime()
if nowTime>=showReddotData.expireTime then

return true
else

return showReddotData.isShow
end
end

function subActivityObject:setIsShowReddot(isShow,extraKey)
local nowTime=timeHelper.getServerShortTime()
local key
if extraKey then
key=string.format("%s_%s_%s_%s",self.act_id,self.sub_act_type,self.sub_act_id,extraKey)
else
key=string.format("%s_%s_%s",self.act_id,self.sub_act_type,self.sub_act_id)
end
local showReddotData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eActivityReddotShow,key,nil)
if not showReddotData or nowTime>=showReddotData.expireTime then
local actEndTime=self.end_time
local before24HourTime=actEndTime-86400

local expireTime
if nowTime>=before24HourTime then
expireTime=actEndTime
else
expireTime=before24HourTime
end

showReddotData={
expireTime=expireTime,
isShow=true,
}
end
showReddotData.isShow=isShow
userActorArraySetting.set(ACTOR_SETTING_TYPE.eActivityReddotShow,key,showReddotData)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eActivityReddotShow)
end


local num=20
local pool={}
local fileLookup={}

function new_subActivityInfo(actInfo,idx_cfg,idx)
local newT
if#pool>0 then
newT=table.remove(pool)
else
newT={}
local mT={




__index=subActivityObject,
}
setmetatable(newT,mT)







end
local subType=idx_cfg[1]
local childname=subActInfoChildConfig[subType]
if childname then
local child=fileLookup[subType]
local filename=FMT.fmt('lua.gamesys.activities.sub.{0}',childname)
if child==nil then
child=require(filename)
fileLookup[subType]=child
end
if child==nil then



return
end
for k,v in pairs(child)do
newT[k]=v
end
end
newT:__init(actInfo,idx_cfg,idx)
return newT
end

function release_subActivityInfo(sub_actInfo)
if sub_actInfo==nil then return end
sub_actInfo:__delete()
local temp={}

for k,v in pairs(sub_actInfo)do
temp[k]=true
end
for k,v in pairs(temp)do
sub_actInfo[k]=nil
end
if#pool>=num then
return
end
table.insert(pool,sub_actInfo)
end
