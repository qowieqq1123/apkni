
local _MODULENAME="actRoleController"
gameState.addListener(def_table(_MODULENAME))
actRoleController.name=_MODULENAME

local _cacheType=
{
eOpenTimeLimit2=-3,
eServerCondition=-2,
eOpenDay=-1,
eLevel=1,
eTask=2,
eRecharge=3,
eSystemOpen=4,
eBuildLevel=5,
}

local _openOneLookup={}
local _openTwoLookup={}
local _removeActs={}
local _openedActLookup={}


function actRoleController:onAppStart()
notifySystem:listenNotify(notifyConfig.building_event,self.onBuildEvent)
notifySystem:listenNotify(notifyConfig.on_system_open,self.onSystemOpen)
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
notifySystem:listenNotify(notifyConfig.onTaskChange,self.onTaskChange)
notifySystem:listenNotify(notifyConfig.onActivityStateChange,self.onActivityStateChange)
notifySystem:listenNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
notifySystem:listenNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
notifySystem:listenNotify(notifyConfig.onSeasonEnterConditionChange,self.onSeasonEnterConditionChange)
socketManager:addNotify(14,1,function()
actRoleController:handleCacheType(_cacheType.eRecharge)
end)
end

function actRoleController:onEnterState()
_removeActs={}
_openTwoLookup={}
_openOneLookup={}
_openedActLookup={}
end

function actRoleController:onLeaveState()
_removeActs={}
_openTwoLookup={}
_openOneLookup={}
_openedActLookup={}
end


function actRoleController.onBuildEvent(event,level,exp,lastLv)
if event==buildingEvent.zongmenLevelUp then
for i=lastLv,level do
actRoleController:handleCacheType(_cacheType.eLevel,i)
end
end
if event==buildingEvent.levelUpComplete or event==buildingEvent.buildComplete then
actRoleController:handleCacheType(_cacheType.eBuildLevel)
end
end

function actRoleController.onSystemOpen(sysid,flag)
if not flag then return end
actRoleController:handleCacheType(_cacheType.eSystemOpen,sysid)
end

function actRoleController.onNewDay()
actRoleController:handleCacheType(_cacheType.eOpenDay)
actRoleController:handleCacheType(_cacheType.eOpenTimeLimit2)
end

function actRoleController.onTaskChange(taskid,taskstate)
if taskstate==taskModel.taskFinishState then
actRoleController:handleCacheType(_cacheType.eTask,taskid)
end
end

function actRoleController.onSeasonChange()
actRoleController:handleCacheType(_cacheType.eServerCondition)
end

function actRoleController.onSeasonStageChange(season_id)
if season_id==0 then
actRoleController:handleCacheType(_cacheType.eServerCondition)
end
end

function actRoleController.onSeasonEnterConditionChange(season_id)
if season_id==0 then
actRoleController:handleCacheType(_cacheType.eServerCondition)
end
end

function actRoleController.onActivityStateFinish(actid)
actRoleController:markRemoveRoleAct(actid)
end

function actRoleController:initRoleActs()
local opentemp={}
local tickTemp={}
_openTwoLookup={}
_openOneLookup={}

local cfgs=cfg_actoractconfig()
for k,v in pairs(cfgs)do
local ret,out=self:canOpenRoleAct(v.id)
if ret then
opentemp[#opentemp+1]=v.id
tickTemp[#tickTemp+1]=v
else
if not out then
tickTemp[#tickTemp+1]=v
end
end
end

for i,v in ipairs(tickTemp)do
local opendaylimit=v.opendaylimit
if opendaylimit then
local cacheType=_cacheType.eOpenDay
self:addOpenRangeArgs(v.id,cacheType)
end

local serverCondition=v.serverCondition
if serverCondition then
local cacheType=_cacheType.eServerCondition
self:addOpenRangeArgs(v.id,cacheType)
end
local eOpenTimeLimit2=v.openTimeLimit2
if eOpenTimeLimit2 then
local cacheType=_cacheType.eOpenTimeLimit2
self:addOpenRangeArgs(v.id,cacheType)
end

local condition=v.condition
if condition then
for _,vv in ipairs(condition)do
local cacheType=vv[1]
local val=vv[2]
if cacheType==3 or cacheType==5 then
self:addOpenRangeArgs(v.id,cacheType)
else
self:addOpenRangeArgs(v.id,cacheType,val)
end
end
end
end

if#opentemp>0 then
activitiesController:sendProtocol(actSendType.eReqOpen,activitiesServerType.eRole,opentemp)
end
end


function actRoleController:handleCacheType(cacheType,val)
if not initProControl.isDone()then return end

local opentemp

local list=self:getOpenRangeTwoArgs(cacheType,val)
if list and#list>0 then
opentemp=opentemp or{}
local outTemp={}
local len=0
for i,v in ipairs(list)do
local ret,out=self:canOpenRoleAct(v)
if ret then
opentemp[#opentemp+1]=v
else
if out then
outTemp[v]=true
len=len+1
end
end
end
if len>0 then
self:removeOpenLookupTwoArgs(outTemp)
end
end
local list=self:getOpenRangeOneArgs(cacheType)
if list and#list>0 then
opentemp=opentemp or{}
local outTemp={}
local len=0
for i,v in ipairs(list)do
local ret,out=self:canOpenRoleAct(v)
if ret then
opentemp[#opentemp+1]=v
else
if out then
outTemp[v]=true
len=len+1
end
end
end
if len>0 then
self:removeOpenLookupOneArgs(outTemp)
end
end
if opentemp and#opentemp>0 then
activitiesController:sendProtocol(actSendType.eReqOpen,activitiesServerType.eRole,opentemp)
end
end

function actRoleController:addOpenRangeArgs(id,typo,val)
if val==nil then
self:addOpenRangeOneArgs(id,typo)
else
self:addOpenRangeTwoArgs(id,typo,val)
end
end

function actRoleController:addOpenRangeOneArgs(id,typo)
if _openOneLookup[typo]==nil then _openOneLookup[typo]={}end
local lookup=_openOneLookup[typo]
lookup[#lookup+1]=id
end

function actRoleController:addOpenRangeTwoArgs(id,typo,val)
val=val or 0
if _openTwoLookup[typo]==nil then _openTwoLookup[typo]={}end
if _openTwoLookup[typo][val]==nil then _openTwoLookup[typo][val]={}end
local lookup=_openTwoLookup[typo][val]
lookup[#lookup+1]=id
end

function actRoleController:getOpenRangeOneArgs(typo)
return _openOneLookup[typo]
end

function actRoleController:getOpenRangeTwoArgs(typo,val)
if val==nil then return end
if _openTwoLookup[typo]==nil then return end
return _openTwoLookup[typo][val]
end

function actRoleController:removeOpenList(actList)
local lookup=nil
for _,v in ipairs(actList or{})do
if lookup==nil then lookup={}end
lookup[v.act_id]=true
end
self:removeOpenLookupTwoArgs(lookup)
self:removeOpenLookupOneArgs(lookup)
end

function actRoleController:removeOpenLookupTwoArgs(lookup)
if lookup==nil then return end

local temp={}
for typo1,list in pairs(_openTwoLookup)do
temp[typo1]={}
for typo2,list2 in pairs(list)do
temp[typo1][typo2]={}
local t=temp[typo1][typo2]
for i,v in ipairs(list2)do
if not lookup[v]then
t[#t+1]=v
end
end
end
end
_openTwoLookup=temp
end

function actRoleController:removeOpenLookupOneArgs(lookup)
if lookup==nil then return end

local temp={}
for typo1,list in pairs(_openOneLookup)do
temp[typo1]={}
local t=temp[typo1]
for i,v in ipairs(list)do
if not lookup[v]then
t[#t+1]=v
end
end
end
_openOneLookup=temp
end


function actRoleController:isOpen(actid)
return activitiesModel:getActInfo(actid)~=nil
end


function actRoleController:canOpenRoleAct(actid)
if self:isOpen(actid)then return false,true end
if self:isRemoveAct(actid)then return false,true end
local speCond=cfgHelper.get2(cfg_actoractconfig_get,actid,'speCond')
if speCond then return false,true end
return activitiesModel:isEnoughOpenCfgCnd(actid)
end

function actRoleController:isRemoveAct(actid)
return _removeActs[actid]==true
end

function actRoleController:markRemoveRoleAct(actid)
_removeActs[actid]=true
end


function actRoleController:checkRemoveRoleActList(actList)
local temp
for i,v in ipairs(actList or{})do
if v.start_time==0 then
self:markRemoveRoleAct(v.act_id)
else
if temp==nil then temp={}end
temp[#temp+1]=v
end
end
return temp or actList
end

function actRoleController:setOpenedActLookup(actList)
if actList==nil or next(actList)==nil then return end
for index,actData in ipairs(actList)do
_openedActLookup[actData.act_id]=1
end
end

function actRoleController:getOpenedActLookup()
return _openedActLookup
end

function actRoleController:checkActIsOpened(actID)
return _openedActLookup[actID]~=nil
end
