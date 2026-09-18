






local _MODULENAME="tianJiangFuYuanModel"


def_table(_MODULENAME)
tianJiangFuYuanModel.name=_MODULENAME
tianJiangFuYuanModel.data={}

function tianJiangFuYuanModel:onAppStart()
self.data.themeList={}
self.data.themeLookup={}
self.data.themeLookup={}
end


function tianJiangFuYuanModel:onEnterState(isReconnect)
self.data.themeList={}
self.data.themeLookup={}
self.data.themeLookup={}
self:initAllThemeTaskList()
end


function tianJiangFuYuanModel:onProtocolReq()

end


function tianJiangFuYuanModel:onLeaveState(isReconnect)

self.data={}
end



function tianJiangFuYuanModel:setServerInitData(len,themes_list)
self.data.len=len
self.data.themeList={}
self.data.themeLookup={}

for k,themeData in pairs(themes_list)do
self:setServerData(themeData,false)
end

table.sort(self.data.themeList,function(a,b)
return a.themeId<b.themeId
end)


end

function tianJiangFuYuanModel:setServerAddData(len,themes_add_list)
for k,themeData in pairs(themes_add_list)do
self:setServerData(themeData,true)
end

table.sort(self.data.themeList,function(a,b)
return a.themeId<b.themeId
end)

local selectData=themes_add_list[1]
local selectThemeId=selectData.param_1
local selectIndex
local themeList=self:getThemeList()
for index,themeData in pairs(themeList)do
if themeData.themeId==selectThemeId then
selectIndex=index
break
end
end

if verifyManager:isHideBusinessActivity()then
return false
end
msgWinControl:addMsgWin(msgWinType.eTianJiangFuYuan,{selectIndex=selectIndex})


end

function tianJiangFuYuanModel:setServerData(theme_data,is_new)
local temp={}

temp.themeId=theme_data.param_1
temp.themeStamp=theme_data.param_2
temp.recvRewardMaxIndex=theme_data.param_3 or 0
temp.isNew=is_new


local themeCfg=cfgHelper.get1(cfg_themegiftconfig_get,temp.themeId)
if themeCfg then
local duration=themeCfg.duration
temp.needDuration=duration*3600

self.data.themeLookup[temp.themeId]=temp
table.insert(self.data.themeList,temp)

local serverStamp=timeHelper.getServerShortTime()
local themeTaskList=tianJiangFuYuanModel:getThemeTaskList(temp.themeId)
if temp.themeStamp+temp.needDuration>serverStamp and#themeTaskList>temp.recvRewardMaxIndex then
temp.isRemove=false
else
temp.isRemove=true
end
else
logErr(FMT.fmt("天降福缘 未找对id为{0}的配置",temp.themeId))
end
end

function tianJiangFuYuanModel:setServerTempData(theme_list)
for index,themeid in ipairs(theme_list or{})do
local temp={}

temp.themeId=themeid
temp.themeStamp=timeHelper.getServerShortTime()
temp.recvRewardMaxIndex=0
temp.isNew=false

local themeCfg=cfgHelper.get1(cfg_themegiftconfig_get,temp.themeId)
if themeCfg then
local duration=themeCfg.duration
temp.needDuration=duration*3600

self.data.themeLookup[temp.themeId]=temp
else
logErr(FMT.fmt("天降福缘 未找对id为{0}的配置",temp.themeId))
end
end
end

function tianJiangFuYuanModel:getThemeData(theme_id)
return self.data.themeLookup[theme_id]
end



function tianJiangFuYuanModel:getThemeList()
local temp={}

for k,v in ipairs(self.data.themeList)do
if not v.isRemove then
table.insert(temp,v)
end
end
return temp
end

function tianJiangFuYuanModel:getThemeIdByIndex(theme_index)
return self.data.themeList[theme_index].themeId
end

function tianJiangFuYuanModel:initAllThemeTaskList()
self.data.themeTaskListLoopup={}

local allThemeGiftCfg=cfg_themegiftconfig()

for themeId,themeGiftCfg in pairs(allThemeGiftCfg)do
if themeId~='const_def'then
local temp={}
for k,giftData in ipairs(themeGiftCfg.gift_info)do
local gtemp={}
gtemp.index=k
gtemp.isRecharge=giftData[1]>0
gtemp.items=giftData[2]
gtemp.rechargeId=giftData[1]
temp[k]=gtemp
end
self.data.themeTaskListLoopup[themeId]=temp
end
end
end

function tianJiangFuYuanModel:getThemeTaskList(theme_id)
return self.data.themeTaskListLoopup[theme_id]
end

function tianJiangFuYuanModel:getTaskStateByIndex(theme_id,recv_index)
local themeData=self.data.themeLookup[theme_id]
if themeData then
return themeData.recvRewardMaxIndex>=recv_index
end
end

function tianJiangFuYuanModel:getTaskFinishProgress(theme_id)
return self.data.themeLookup[theme_id].recvRewardMaxIndex
end

function tianJiangFuYuanModel:getThemeTaskData(theme_id,task_index)
local themeData=self.data.themeLookup[theme_id]
local themeId=themeData.themeId
local taskDataList=self.data.themeTaskListLoopup[themeId]or{}
return taskDataList[task_index]
end



function tianJiangFuYuanModel:setThemeState(theme_id,recv_gift_id)
local themeData=self.data.themeLookup[theme_id]
themeData.recvRewardMaxIndex=recv_gift_id
end



function tianJiangFuYuanModel:checkActEnterOpen()
local activeThemeList=self:getThemeList()

return#activeThemeList>0
end

function tianJiangFuYuanModel:checkHasThemeDue()
local serverStamp=timeHelper.getServerShortTime()
local removeLen=0
for index,themeData in pairs(self.data.themeList)do
if not themeData.isRemove then
if serverStamp>=themeData.themeStamp+themeData.needDuration or self:checkThemeFinish(themeData.themeId)then
removeLen=removeLen+1
self.data.themeLookup[themeData.themeId].isRemove=true

end
end
end

local isRemove=removeLen>0

return isRemove
end

function tianJiangFuYuanModel:getHasReddotTabIndex()
local themelist=self:getThemeList()
local index=1

if#themelist>0 then
for k,themeData in ipairs(themelist)do
if self:checkThemeReddot(themeData.themeId)then
index=k
break
end
end
end
return index
end



function tianJiangFuYuanModel:checkActEnterReddot()
local reddot=false

local themelist=self:getThemeList()
for k,themeData in pairs(themelist)do
local themeReddot=self:checkThemeReddot(themeData.themeId)
if themeReddot then
reddot=true
break
end
end

return reddot
end

function tianJiangFuYuanModel:checkThemeReddot(theme_id)
local reddot=false

local themeData=self:getThemeData(theme_id)
local themeTaskData=self:getThemeTaskData(theme_id,themeData.recvRewardMaxIndex+1)
if themeTaskData then
reddot=not themeTaskData.isRecharge
end

return reddot
end

function tianJiangFuYuanModel:checkThemeFinish(theme_id)
local themeData=self:getThemeData(theme_id)
local themeTaskList=tianJiangFuYuanModel:getThemeTaskList(theme_id)
return themeData.recvRewardMaxIndex>=#themeTaskList
end


function tianJiangFuYuanModel:getActEnterTime()
local minLeft
for k,themeData in pairs(self.data.themeList)do
if not themeData.isRemove then
local left=self:getThemeLeftTime(themeData.themeId)
if left>0 then
minLeft=minLeft and Mathf.Min(minLeft,left)or left
end
end
end
minLeft=minLeft and minLeft or 0
return minLeft
end

function tianJiangFuYuanModel:getThemeLeftTime(theme_id)
local themeData=self.data.themeLookup[theme_id]
return themeData.themeStamp+themeData.needDuration
end


local conditionTypeEnum={
ZmLevel=1,
ServerOpenDay=2,
FixedTime=3,
FixedDisciple=4,
SytemId=5,
}
local openConditionList={
[conditionTypeEnum.ZmLevel]=function(startLv,endLv)
local zmLevel=zongmenModel:getLevel()
local state=true
state=state and zmLevel>=startLv
if endLv then
state=state and endLv>=zmLevel
end
return state
end,
[conditionTypeEnum.ServerOpenDay]=function(startday,endDay)
local openDay=timeHelper.getServerOpenDay()
local state=true
state=state and openDay>=startday
if endDay then
state=state and endDay>=openDay
end
return state
end,
[conditionTypeEnum.FixedTime]=function(startTime,endTime)
local curTimeStamp=gameUtilityModel.getServerLongTime()
local startTimeStamp=timeHelper.dataToTimeStam(startTime)
local state=true
state=state and curTimeStamp>=startTimeStamp
if endTime then
local endTimeStamp=timeHelper.dataToTimeStam(endTime)
state=state and endTimeStamp>=curTimeStamp
end
return state
end,
[conditionTypeEnum.FixedDisciple]=function(id,checkType)
local list=UIDiscipleModel:findDisciplesByID(id)
local state
checkType=checkType or 0
if checkType==1 then
state=#list>0
elseif checkType==0 then
state=#list==0
end
return state
end,
[conditionTypeEnum.SytemId]=function(systemId)
return systemModel.isOpen(systemId)
end
}

function tianJiangFuYuanModel:checkThemeOpenCondition(conditionList)
local state=true
for k,condition in ipairs(conditionList)do
local conditionType=condition[1]
if openConditionList[conditionType]then
state=openConditionList[conditionType](condition[2],condition[3])
if not state then
state=false
break
end
else
logErr(FMT.fmt("出现错误的条件类型{0}",conditionType))
end
end
return state
end


function tianJiangFuYuanModel:getOpenList()
if not initProControl.isDone()then return{}end

local allThemeGiftCfg=cfg_themegiftconfig()
local reqOpenList={}
for themeId,themeCfg in pairs(allThemeGiftCfg)do
if themeId~='const_def'then
local themeData=tianJiangFuYuanModel:getThemeData(themeId)
if not themeData then
if tianJiangFuYuanController:checkServerLimitOpen(themeCfg.serverlimit)then
local condition=themeCfg.condition
if condition then

if tianJiangFuYuanModel:checkThemeOpenCondition(condition)then
table.insert(reqOpenList,themeId)
end
else
table.insert(reqOpenList,themeId)
end
end
end
end
end
return reqOpenList
end
