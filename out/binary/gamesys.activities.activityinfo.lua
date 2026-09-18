







local activityObject={}

function activityObject:__init(actData)
self:resetData(actData,true)
self:init(actData)

self:refreshState()
end

function activityObject:__delete()
self:removeSysTab()
self:refreshEnter(false)

self.act_id=nil
self.start_time=nil
self.end_time=nil
self.start_time_l=nil
self.end_time_l=nil
self.openDays=nil
if self.sublist then
for i,sub_actInfo in ipairs(self.sublist)do
release_subActivityInfo(sub_actInfo)
end
end
self.sublist=nil
self.sublist_lp=nil
self.sublist_merge=nil
self.mergeLookup=nil
self.unlockType=nil

self.isTabWin=nil
self.panelname=nil
self.panelparams=nil

self.state=nil
self.reddotFlag=nil
self.concatOther=nil
self.sub_sys_lp=nil
self.sys_tab=nil
end


function activityObject:getBaseData()
return{act_id=self.act_id}
end




function activityObject:resetData(actData,isInit)
local isChange=false
if not isInit then
if self.start_time~=actData.start_time or self.end_time~=actData.end_time then
isChange=true
end
end

if isInit or isChange then
self.act_id=actData.act_id
self.start_time=actData.start_time
self.end_time=actData.end_time
self.start_time_l=gameUtilityModel.serverShortTimeToLong(actData.start_time)
self.end_time_l=gameUtilityModel.serverShortTimeToLong(actData.end_time)
self.openDays=activitiesModel.get_total_days_by_time(self.start_time_l,self.end_time_l)
end

if isChange then



for i,sub_actInfo in ipairs(self.sublist)do
sub_actInfo:resetData(self)
end

self:refreshState()

if not self:checkDoing()then
self:refreshEnter(false)
end

self:onReady()

notifySystem:postNotify(notifyConfig.onActivityRefresh,self.act_id)
end
end

function activityObject:init(actData)

self.sublist={}
self.sublist_lp={}
self.sub_sys_lp={}
self.sublist_merge=nil
self.mergeLookup=nil
self.sys_tab={}
local actcfg=self:getActConfig()
self.unlockType=actcfg.unlockType
local sub_idxs=actcfg.idx
for i,idx_cfg in ipairs(sub_idxs)do
local sub_act_type=idx_cfg[1]
local dontHandle=cfgHelper.get2(cfg_subactivitytypeconfig_get,sub_act_type,'dontHandle')
if not dontHandle then
local sub_act_id=idx_cfg[2]
local sub_actInfo=new_subActivityInfo(self,idx_cfg,i)

table.insert(self.sublist,sub_actInfo)
if self.sublist_lp[sub_act_type]==nil then
self.sublist_lp[sub_act_type]={}
end
self.sublist_lp[sub_act_type][sub_act_id]=sub_actInfo
end
end


local custom_idx=actcfg.custom_idx

if custom_idx then
for i,idx_cfg in ipairs(custom_idx)do
local sub_act_type=idx_cfg[1]
local sub_act_id=idx_cfg[2]
local index=idx_cfg[4]
local sub_actInfo=new_subActivityInfo(self,idx_cfg,i)

local tlen=#self.sublist+1
local inserIdx=index>tlen and tlen or index
table.insert(self.sublist,inserIdx,sub_actInfo)

if self.sublist_lp[sub_act_type]==nil then
self.sublist_lp[sub_act_type]={}
end
self.sublist_lp[sub_act_type][sub_act_id]=sub_actInfo

if self.sub_sys_lp[sub_act_type]==nil then
self.sub_sys_lp[sub_act_type]={}
end
self.sub_sys_lp[sub_act_type][sub_act_id]=sub_actInfo

if sub_actInfo:checkOpen()then
activitiesController:contactTab(sub_act_type)
end
end

self:addSysTab()
end

local panelname
local panelparams
local isTabWin
if actcfg.openPanel then
local panelType=actcfg.openPanel[1]
local panelcfg=cfgHelper.get1(cfg_activityspanelconfig_get,panelType)
if panelcfg then
isTabWin=panelcfg.isTabWin
panelname=panelcfg.panelname
panelparams=table.deepCopy(actcfg.openPanel[2])or{}
panelparams.moneytypes=table.deepCopy(actcfg.moneytypes)
panelparams.isFull=panelcfg.isFull
panelparams.clickAnyClose=panelcfg.clickAnyClose
else



end
else




end
self.panelname=panelname
self.panelparams=panelparams
self.isTabWin=isTabWin
end

function activityObject:get_act_id()
return self.act_id
end


function activityObject:printInfo()
logErr(FMT.fmt('活动id：{0}',self.act_id))
logErr(FMT.fmt('开始时间：{0}',timeHelper.getFormatByStamp(self.start_time_l)))
logErr(FMT.fmt('结束时间：{0}',timeHelper.getFormatByStamp(self.end_time_l)))
end

function activityObject:getPanelName()
return self.panelname
end

function activityObject:getPanelParams()
return table.deepCopy(self.panelparams)
end

function activityObject:invokePanelMethod(fName,...)
local panelname=self.panelname
if panelname then
return UIManager:invokeUIMethod(panelname,fName,...)
end
end

function activityObject:checkIsTabWin()
return self.isTabWin==true
end

function activityObject:getStartTime()
return self.start_time
end


function activityObject:getStartLeftTime()
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


function activityObject:getEndLeftTime()
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


function activityObject:getEndLeftDayTime()
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


function activityObject:getStart2NowDay()
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


function activityObject:get_sublist()
return self.sublist
end

function activityObject:getAnySystemSubActInfo(subType)
if self.sub_sys_lp~=nil then
if self.sub_sys_lp[subType]then
return next(self.sub_sys_lp[subType])
end
end
return nil
end


function activityObject:getSubActInfo(subType,subid)
if self.sublist_lp~=nil then
if self.sublist_lp[subType]then
return self.sublist_lp[subType][subid]
end
end
return nil
end


function activityObject:getSubActInfoList(subType)
if self.sublist_lp~=nil then
return self.sublist_lp[subType]
end
return nil
end

function activityObject:getSubActInfoEx(actID,subType,subid)
local res=self.sublist_merge or self.sublist
for i,sub_actInfo in ipairs(res)do
if sub_actInfo:compare(actID,subType,subid)then
return sub_actInfo
end
end
return nil
end


function activityObject:checkSubIn(actID,subType,subid)
return self:getSubActInfoEx(actID,subType,subid)~=nil
end


function activityObject:getSubList_open_doing()
local list={}
if self:checkOpen()then
local res=self.sublist_merge or self.sublist
for i,sub_actInfo in ipairs(res)do
if sub_actInfo:checkDoing()and sub_actInfo:checkOpen()then
if sub_actInfo.act_id==self.act_id then
table.insert(list,sub_actInfo:getBaseData())
else

if activitiesModel:checkActOpen(sub_actInfo.act_id)then
table.insert(list,sub_actInfo:getBaseData())
end
end
end
end
end
return list
end


function activityObject:getSubList_notFinish_num()
local res=self.sublist_merge or self.sublist
local c=0
for i,sub_actInfo in ipairs(res)do
if sub_actInfo:checkDoing()or sub_actInfo:checkIdle()then
c=c+1
end
end
return c
end


function activityObject:onReady_init()
self.isopen=self:checkCondition()

local res=self.sublist
for i,sub_actInfo in ipairs(res)do
sub_actInfo:onReady_init()
end
end


function activityObject:onReady()

if self:checkDoing()then
local res=self.sublist
for i,sub_actInfo in ipairs(res)do
sub_actInfo:onReady()
end
end
self.isopen=self:checkCondition()
end


function activityObject:getSubList_doing_noData()
local list={}
local res=self.sublist_merge or self.sublist
for i,sub_actInfo in ipairs(res)do
if sub_actInfo:checkDoing()and not sub_actInfo:hasData()then
table.insert(list,sub_actInfo:getBaseData())
end
end
return list
end

function activityObject:getSubList_subType(subType)
local list={}
local res=self.sublist_merge or self.sublist
for i,sub_actInfo in ipairs(res)do
if sub_actInfo:compareType(subType)then
table.insert(list,sub_actInfo)
end
end
return list
end

function activityObject:getSubList_subType_doing(subType)
local list={}
local res=self.sublist_merge or self.sublist
for i,sub_actInfo in ipairs(res)do
if sub_actInfo:compareType(subType)and sub_actInfo:checkDoing()then
table.insert(list,sub_actInfo)
end
end
return list
end


function activityObject:refreshMerge()
local exToAct=nil
local isDoing=self:checkDoing()
if isDoing then
exToAct=self:getActConfig('exToAct')
end
local sublist_merge=nil
local mergeLookup=nil

if exToAct and self:checkIsTabWin()then
for i,v in ipairs(exToAct)do
local ex_act_id=v[1]
local insertIdx=v[2]or 1

if ex_act_id~=self.act_id then
local ex_list={}
local ex_actInfo=activitiesModel:getActInfo(ex_act_id)

if ex_actInfo~=nil and ex_actInfo:checkIsTabWin()and ex_actInfo:checkDoing()then
for i2,sub_actInfo in ipairs(ex_actInfo.sublist)do
if sub_actInfo:checkDoing()or sub_actInfo:checkIdle()then
table.insert(ex_list,sub_actInfo)
end
end
end
if#ex_list>0 then
if sublist_merge==nil then
sublist_merge=table.weakCopy(self.sublist)
end
if insertIdx>#sublist_merge then
insertIdx=#sublist_merge+1
end
table.insertRange(sublist_merge,ex_list,insertIdx)








if mergeLookup==nil then
mergeLookup={}
end
mergeLookup[ex_act_id]=ex_list
end
end
end
end
self.sublist_merge=sublist_merge
self.mergeLookup=mergeLookup
end

function activityObject:hasMerge()
return self.mergeLookup~=nil
end

function activityObject:mark_merge(merge_lp)
if self.mergeLookup then
for ex_act_id,v in pairs(self.mergeLookup)do
merge_lp[ex_act_id]=true
end
end
end

function activityObject:is_in_merge(act_id)
if self.mergeLookup then
return self.mergeLookup[act_id]~=nil
end
return false
end


function activityObject:checkHasEnter()

if activityEnterMergeController:checkMergeActivity(self.act_id)then
return false
end
local actcfg=self:getActConfig()
return actcfg.noEnter==nil or actcfg.noEnter==false
end


function activityObject:refreshEnter(flag)
local needClear=true
if flag then

if self:checkDoing()and self:checkOpen()and self:checkOneSubOpen()and activitiesModel:checkActInMerge(self.act_id)==nil and self:checkIsShow()then
needClear=false
if self:checkConcatByCfg()then
if not self.concatOther then
local sub_actInfo=self.sublist[1]
local actcfg=self:getActConfig()
local sub_act_type=sub_actInfo.sub_act_type
local sub_act_id=sub_actInfo.sub_act_id
local concatId=actcfg.concatToOther
local concatCfg=cfg_tabconcatconfig_get(concatId)
self.concatOther=contactTabController:addTab(concatCfg.concatType,
concatCfg.concatTabType,
{act_id=self.act_id,sub_act_type=sub_act_type,sub_act_id=sub_act_id})
end
else
if self:checkHasEnter()and self.enterguid==nil then
local act_id=self.act_id
local actcfg=self:getActConfig()
local enterIconType
if actcfg.iconType==1 then
enterIconType=ENTER_ICON_TYPE.eNomal
else
enterIconType=ENTER_ICON_TYPE.eBig
end
local guid=enterManager:freshEnter({id=act_id,enterIconType=enterIconType,enterType=ENTER_TYPE.eOperActivity,
params={act_id=act_id},getReddotFun=function()
return activitiesModel:checkActReddot(act_id)
end})
self.enterguid=guid





self:checkPop()

end
if activityEnterMergeController:checkMergeActivity(self.act_id)then
activityEnterMergeController:freshMergeActivityEnter(self.act_id)
end
end
self:addSysTab()
end
end
if needClear then

if self.concatOther then
local sub_actInfo=self.sublist[1]
local sub_act_type=sub_actInfo.sub_act_type
local sub_act_id=sub_actInfo.sub_act_id
local actcfg=self:getActConfig()
local concatId=actcfg.concatToOther
local concatCfg=cfg_tabconcatconfig_get(concatId)
contactTabController:removeTab(concatCfg.concatType,
concatCfg.concatTabType,
{act_id=self.act_id,sub_act_type=sub_act_type,sub_act_id=sub_act_id})
self.concatOther=nil
end

if self.enterguid~=nil then
enterManager:removeEnter(self.enterguid)
self.enterguid=nil
end

self:removeSysTab()
if activityEnterMergeController:checkMergeActivity(self.act_id)then
activityEnterMergeController:freshMergeActivityEnter(self.act_id)
end
end
end

function activityObject:refreshEnterEx(funcName,args)
if self.enterguid~=nil then
enterManager:freshFuncByGUID(self.enterguid,funcName,args)
end
end


function activityObject:refreshAllSubEnter(flag)
for i,sub_actInfo in ipairs(self.sublist)do
xpcall(function()
sub_actInfo:refreshEnter(flag)
end,function(err)
loggerUtil.logErrFMT('activityObject refreshAllSubEnter err!{0}',err)
end)
end
end


function activityObject:update()

for i,sub_actInfo in ipairs(self.sublist)do
sub_actInfo:update()
end

local old_state=self.state
self:refreshState()
local state=self.state
if old_state~=nil and old_state~=state then
if old_state==activitiesModel.activityIdleState and state==activitiesModel.activityDoingState then

notifySystem:postNotify(notifyConfig.onActivityStateChange,self.act_id,activitiesModel.activityDoingState)
self:onReady()
elseif old_state==activitiesModel.activityDoingState and state==activitiesModel.activityFinishState then

local act_id=self.act_id
activitiesModel:removeActInfo(act_id)
notifySystem:postNotify(notifyConfig.onActivityStateChange,act_id,activitiesModel.activityFinishState)
end
end
end

function activityObject:refreshState()
self.state=self:getState()
end

function activityObject:getState()
local cur=gameUtilityModel.getServerShortTime()
if cur<self.start_time then
return activitiesModel.activityIdleState
elseif cur>self.end_time then
return activitiesModel.activityFinishState
else
return activitiesModel.activityDoingState
end
end

function activityObject:checkIdle()
return self.state==activitiesModel.activityIdleState
end

function activityObject:checkDoing()
return self.state==activitiesModel.activityDoingState
end

function activityObject:checkFinish()
return self.state==activitiesModel.activityFinishState
end

function activityObject:refreshReddot()
local old=self.reddotFlag
self.reddotFlag=self:checkReddot()
if old~=self.reddotFlag then
notifySystem:postNotify(notifyConfig.onActivityReddotChange,self.act_id)
end
end

function activityObject:getRoddot()
local reddotFlag=self.reddotFlag
if reddotFlag==nil then
reddotFlag=self:checkReddot()
self.reddotFlag=reddotFlag
end
return reddotFlag
end

function activityObject:checkReddot()
local sublist=self:getSubList_open_doing()
for i,v in ipairs(sublist)do
local act_id=v.act_id
local flag
if act_id==self.act_id then
flag=self:checkSubReddot(v.sub_act_type,v.sub_act_id)
else

flag=activitiesModel:checkSubActReddot(v.act_id,v.sub_act_type,v.sub_act_id)
end
if flag then
return true
end
end
return false
end

function activityObject:checkSubReddot(subType,subid)
local sub_actInfo=self:getSubActInfo(subType,subid)
if sub_actInfo then
return sub_actInfo:getRoddot()and sub_actInfo:getUnlock()
end
return false
end


function activityObject:checkOpen(isWarning)
if isWarning then
self.isopen=self:checkCondition(true)
end
return self.isopen
end


function activityObject:checkIsShow()
local actcfg=self:getActConfig()
local onHide=actcfg.onHide
if onHide then
local sub_actInfo=self.sublist[1]
if sub_actInfo then
local sub_act_type=sub_actInfo.sub_act_type

local subtype=onHide[1]
local pfversions=onHide[2]
if subtype and pfversions then
if subtype==sub_act_type then
local curPfVersion=pfwindowslController:getGameVersion()
if pfversions[curPfVersion]then

local flag=sub_actInfo:checkAllTaskGet()
return flag
end
end
end
end
end
return true
end

function activityObject:refreshSubUnlock()
local isChange=false
for i,sub_actInfo in ipairs(self.sublist)do
if sub_actInfo:refreshUnlock()then
isChange=true
end
end
if isChange then


end
end






function activityObject:checkSubUnlock(subType,subid,isWarning)
local sub_actInfo=self:getSubActInfo(subType,subid)
return sub_actInfo:getUnlock(isWarning)
end

function activityObject:checkSubUnlock_first(isWarning)
local sub_actInfo=self.sublist[1]
return sub_actInfo:checkUnlock_first(isWarning)
end


function activityObject:checkOneSubOpen()
local res=self.sublist_merge or self.sublist
for i,sub_actInfo in ipairs(res)do
if sub_actInfo:checkOpen()then
return true
end
end
return false
end

function activityObject:refreshCondition()
local old_isopen=self.isopen
self.isopen=self:checkCondition()
if old_isopen~=nil and self.isopen~=old_isopen then

self:refreshEnter(true)

self:refreshAllSubEnter(true)
local flag=self.isopen==true and 1 or 2
notifySystem:postNotify(notifyConfig.onActivityOpen,self.act_id,flag)
end
end


function activityObject:checkCondition(isWarning)

if self:getServerType()==activitiesServerType.eRole then
return true
end
return activitiesModel:isEnoughOpenCfgCnd(self.act_id,self.start_time,isWarning)
end

function activityObject:checkNewDay()
if self:checkDoing()then
for i,sub_actInfo in ipairs(self.sublist)do
sub_actInfo:checkNewDay()
end
end
end


function activityObject:getConcatArgs()
local actcfg=self:getActConfig()
if actcfg.concatToOther==nil then return end
local concatId=actcfg.concatToOther
local concatCfg=cfg_tabconcatconfig_get(concatId)
return concatCfg.concatType,concatCfg.concatTabType
end


function activityObject:checkConcatByCfg()
local actcfg=self:getActConfig()
if actcfg.concatToOther==nil then return false end
local sub_actInfo=self.sublist[1]
local sub_act_type=sub_actInfo.sub_act_type
local concatId=actcfg.concatToOther
local args=cfg_tabconcatconfig_get(concatId).args
local _sub_act_type=args[1]
if sub_act_type==_sub_act_type then
return true
end
loggerUtil.debugErrFMT('页签合并参数必须与活动子类型配置{0}一致',sub_act_type)
return false
end

function activityObject:isKuafuType()
return self:getServerType()==activitiesServerType.eKuafu
end

function activityObject:isRoleType()
return self:getServerType()==activitiesServerType.eRole
end

function activityObject:getServerType()
return activitiesModel:getServerType(self.act_id)
end

function activityObject:getActConfig(...)
return activitiesModel:getActConfig(self.act_id,...)
end

function activityObject:getActCondition()
if self:isRoleType()then return nil end
return self:getActConfig('condition')
end

function activityObject:getActOpenDayLimit()
return self:getActConfig('opendaylimit')
end

function activityObject:getActOpenDelayDays()
return self:getActConfig('opendelaydays')
end

function activityObject:getActOpenTime()
return self:getActConfig('opentimelimit')
end

function activityObject:getActStartPlot()
return self:getActConfig('startPlot')
end
function activityObject:getActScreenParams()
return self:getActConfig('screenParams')
end


function activityObject:addSysTab()
for sub_act_type,v in pairs(self.sub_sys_lp)do
for sub_act_id,sub_actInfo in pairs(v)do
if sub_actInfo:checkOpen()then
if not self.sys_tab[sub_act_type]then
self.sys_tab[sub_act_type]=true
activitiesController:onActivity_system_tab_Change(sub_act_type,true)
sub_actInfo:removeEnter()
end
break
end
end
end
end

function activityObject:removeSysTab()
for sub_act_type,v in pairs(self.sub_sys_lp)do
for sub_act_id,sub_actInfo in pairs(v)do
if self.sys_tab[sub_act_type]then
self.sys_tab[sub_act_type]=nil
activitiesController:onActivity_system_tab_Change(sub_act_type,false)
sub_actInfo:resumeEnter()
end
break
end
end
end


function activityObject:checkPop()

if activityEnterMergeController:checkMergeActivity(self.act_id)then
return
end
local actcfg=self:getActConfig()
if not actcfg.popWin or not actcfg.popWin[1]then
return
end
local msgType=actcfg.popWin[1]
local panelparams=self:getPanelParams()
panelparams.act_id=self.act_id
local list=self:getSubList_open_doing()
local firstSubData=list[1]
panelparams.sub_act_type=firstSubData.sub_act_type
panelparams.sub_act_id=firstSubData.sub_act_id
panelparams.extraParams=nil
panelparams.moneyWinType=fullTopMoneyType.eSkin2
msgWinControl:addMsgWin(msgType,panelparams,nil,true)
end



local num=10
local pool={}

function new_activityInfo(actData)
local newT
if#pool>0 then
newT=table.remove(pool)
else
newT={}
local mT={
__index=activityObject,
}
setmetatable(newT,mT)
end
newT:__init(actData)
return newT
end

function release_activityInfo(actInfo)
if actInfo==nil then return end
actInfo:__delete()
if#pool>=num then
return
end
table.insert(pool,actInfo)
end
