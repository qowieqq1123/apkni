





systemControl=gameState.addListener({})

local _mutil=100000


local _needInitProLookup={}
local _needInitNum=0
local _handleLookup={}
local _isInit=false
local _timer=nil

local checkTimeSysCond=
{
[SYSTEM_OPEN_TYPE.eSysOpenDay]=1,
}
local _needCheckTimeSys={}


function systemControl:onAppStart()
notifySystem:listenNotify(notifyConfig.building_event,self.onBuildLevelUp)
notifySystem:listenNotify(notifyConfig.onTaskChange,self.onTaskFinish)
notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
notifySystem:listenNotify(notifyConfig.on_item_list_changed,self.onItemListChanged)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.onMoneyChanged)
notifySystem:listenNotify(notifyConfig.onZongMenXianTuStage,self.onZongMenXianTuStage)

notifySystem:listenNotify(notifyConfig.onJctjProgressChange,self.onJctjProgressChange)
notifySystem:listenNotify(notifyConfig.onJctjDayChange,self.onJctjDayChange)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
notifySystem:listenNotify(notifyConfig.onDiscipleJJChange,self.onDiscipleJJChange)

notifySystem:listenNotify(notifyConfig.onSeasonChange,self.onReBuildXianYuInitChange)
notifySystem:listenNotify(notifyConfig.onSeasonStageChange,self.onReBuildXianYuChange)
notifySystem:listenNotify(notifyConfig.onSeasonStageDataChange,self.onReBuildXianYuChange)
notifySystem:listenNotify(notifyConfig.onJoinXianYuFlagChange,self.onJoinXianYuFlagChange)
notifySystem:listenNotify(notifyConfig.onXianJieEntityStageChange,self.onXianJieEntityStageChange)

notifySystem:listenNotify(notifyConfig.onWorldBlockDataChanged,self.onWorldBlockDataChanged)

end

function systemControl:onEnterState()
_handleLookup={}
_isInit=false
end

function systemControl:onLeaveState()
_handleLookup={}
_isInit=false
if _timer then
_timer:cancel()
end
_timer=nil
end

function systemControl:onProtocolReq()
_isInit=true
systemControl.initSystemData()
end





function systemControl.onInitSystem(len,list)
systemModel.onInit(len,list)
gameState:onSystemInit()
notifySystem:postNotify(notifyConfig.on_system_open,0,false)
end

function systemControl.onOpenSystem(sysid)
systemModel.onOpen(sysid)

if systemControl.isNeedOpenDaySys(sysid)then
local stamp=timeHelper.getServerShortTime()
systemModel.setSystemOpenStamp(sysid,stamp)
end

notifySystem:postNotify(notifyConfig.on_system_open,sysid,true)
reddotControl.on_change_catch_type(CATCH_TYPE.eSystemOpen,sysid)
end


function systemControl.on_system_open(sysId)
if _needCheckTimeSys[sysId]then
systemControl.onConditionChanged(SYSTEM_OPEN_TYPE.eSysOpenDay,0)
end
end

function systemControl.onBuildLevelUp(typo,level,exp,lastLv)
if typo==buildingEvent.zongmenLevelUp then
systemControl.onConditionChanged(SYSTEM_OPEN_TYPE.eZongmemLevelChanged,lastLv,level)
systemControl.onConditionChanged(SYSTEM_OPEN_TYPE.eZongMenFullLevel,0)
end
end

function systemControl.onBuildCreated(buildid)
systemControl.onConditionChanged(SYSTEM_OPEN_TYPE.eCreatedBuild,buildid)
end


function systemControl.onTaskFinish(taskid,status)
systemControl.onConditionChanged(SYSTEM_OPEN_TYPE.eTaskFinish,taskid,status)
end

function systemControl.onZheXianLingChanged(bookid,index)
index=index or 0
systemControl.onConditionChanged(SYSTEM_OPEN_TYPE.eZheXianLingBook,bookid,index)
end

function systemControl.onZongMenXianTuStage(id)
systemControl.onConditionChanged(SYSTEM_OPEN_TYPE.eXianTuLevel,id)
end

function systemControl.onWuXingShengDianChanged()
systemControl.onConditionChanged(SYSTEM_OPEN_TYPE.eWuXingShengDianOpen,0)
end

function systemControl.onNewDay()
if _timer then
_timer:cancel()
end
local func=function()
systemControl.onConditionChanged(SYSTEM_OPEN_TYPE.eOpenServerTime)
systemControl.onConditionChanged(SYSTEM_OPEN_TYPE.eSysOpenDay,0)
systemControl.onConditionChanged(SYSTEM_OPEN_TYPE.eJiuChongTianJieOpenDay,0)
end
_timer=timer.new()
_timer:start(10,func,1)
func()
end

function systemControl.onItemListChanged(argsTable)
for i,v in ipairs(argsTable)do
local changeType=v[1]
local itemguid=v[2]
local itemid=v[3]
local oldVal=v[4]
local newVal=v[5]
if changeType~=CHANGE_TYPE.eDelete then
if newVal>oldVal then
systemControl.onConditionChanged(SYSTEM_OPEN_TYPE.eItemOrMoney,itemid,newVal)
end
end
end
end
function systemControl.onMoneyChanged(moneyType,oldVal,newVal)
if newVal>oldVal then
systemControl.onConditionChanged(SYSTEM_OPEN_TYPE.eItemOrMoney,moneyType,newVal)
end
end

function systemControl.onJctjProgressChange()
systemControl.onConditionChanged(SYSTEM_OPEN_TYPE.eJiuChongTianJieJinDu,0)
end

function systemControl.onJctjDayChange()
systemControl.onConditionChanged(SYSTEM_OPEN_TYPE.eJiuChongTianJieOpenDay,0)
end

function systemControl.onDiscipleJJChange(disguid,old_jjlv,jingjielv,old_jjexp,jingjieexp)
if old_jjlv~=jingjielv then
systemControl.onConditionChanged(SYSTEM_OPEN_TYPE.eDiscipleReachJJ,jingjielv)
end
end

function systemControl.onReBuildXianYuChange(season_id,chapter_idx)
systemControl.onConditionChanged(SYSTEM_OPEN_TYPE.eReBuildXianYuTask,season_id,chapter_idx)
end

function systemControl.onReBuildXianYuInitChange()
local sHandle=seasonModel:getHandle(0)
if sHandle then
local stages=sHandle:getStages()
for i,v in ipairs(stages)do
systemControl.onConditionChanged(SYSTEM_OPEN_TYPE.eReBuildXianYuTask,0,i)
end
end
end

function systemControl.onJoinXianYuFlagChange()

local seasonType=seasonModel:getSeasonEnter()
local sHandle=seasonModel:getHandle(seasonType)
if sHandle then
local stages=sHandle:getStages()
for i,v in ipairs(stages)do
systemControl.onConditionChanged(SYSTEM_OPEN_TYPE.eReBuildXianYuTask,seasonType,i)
end
end
end

function systemControl.onXianJieEntityStageChange(changeList)
if changeList and next(changeList)then
for i,v in pairs(changeList)do
systemControl.onConditionChanged(SYSTEM_OPEN_TYPE.eXianJieEntityStage,v.param_1,v.param_2,v.param_3)
end
end
end

function systemControl.onWorldBlockDataChanged(world,block,state)
systemControl.onConditionChanged(SYSTEM_OPEN_TYPE.eQuKuaiUnLock,world,block,state)

end




function systemControl.initSystemData()
if not _isInit then return end
local array={}
for _,v in pairs(systemConfig.getAllSystemConfig())do
local sysid=v.id
if sysid and systemModel.isCanOpen(sysid)then
array[#array+1]=sysid
end

if v.openargs then
for _,vv in ipairs(v.openargs)do
for _,vv in ipairs(vv)do
if checkTimeSysCond[vv[1]]then
_needCheckTimeSys[vv[2]]=1
end
end
end
end
end
if#array>0 then
systemProtocolControl.reqSystemListOpen(array)
end
_handleLookup={}
end

function systemControl.onConditionChanged(openType,...)
if openType==SYSTEM_OPEN_TYPE.eZongmemLevelChanged then
systemControl.onConditionLevelChanged(openType,...)
elseif openType==SYSTEM_OPEN_TYPE.eTaskFinish then
systemControl.onConditionTaskChanged(openType,...)
elseif openType==SYSTEM_OPEN_TYPE.eOpenServerTime then
systemControl.onConditionServerChanged(openType)
elseif openType==SYSTEM_OPEN_TYPE.eZheXianLingBook then
systemControl.onConditionZheXianLingChanged(openType,...)
elseif openType==SYSTEM_OPEN_TYPE.eItemOrMoney then
systemControl.onConditionItemOrMoneyChanged(openType,...)
elseif openType==SYSTEM_OPEN_TYPE.eXianTuLevel then
systemControl.onXianTuChanged(openType,...)
elseif openType==SYSTEM_OPEN_TYPE.eWuXingShengDianOpen then
systemControl.onConditionWuXingShengDianChanged(openType,...)
elseif openType==SYSTEM_OPEN_TYPE.eServerPlatform or
openType==SYSTEM_OPEN_TYPE.eServerPlatformOpen then

elseif openType==SYSTEM_OPEN_TYPE.eCreatedBuild then
systemControl.onConditionBuildCreatedChanged(openType,...)
elseif openType==SYSTEM_OPEN_TYPE.eJiuChongTianJieJinDu then
systemControl.onConditionJCTJJinDuChanged(openType,...)
elseif openType==SYSTEM_OPEN_TYPE.eJiuChongTianJieOpenDay then
systemControl.onConditionJCTJTianShuChanged(openType)
elseif openType==SYSTEM_OPEN_TYPE.eSysOpenDay then
systemControl.onConditionSysOpenDayChanged(openType)
elseif openType==SYSTEM_OPEN_TYPE.eDiscipleReachJJ then
systemControl.onConditionDiscipleJJChanged(openType,...)
elseif openType==SYSTEM_OPEN_TYPE.eReBuildXianYuTask then
systemControl.onConditionReBuildXianYuChanged(openType,...)
elseif openType==SYSTEM_OPEN_TYPE.eXianJieEntityStage then
systemControl.onConditionXianJieEntityStageChanged(openType,...)
elseif openType==SYSTEM_OPEN_TYPE.eZongMenFullLevel then
systemControl.onConditionMaxLevelChanged(openType,...)
elseif openType==SYSTEM_OPEN_TYPE.eQuKuaiUnLock then
systemControl.onConditionQuKuaiUnlockChanged(openType,...)
end
end

function systemControl.onConditionWuXingShengDianChanged(openType,val)
local list=_handleLookup[openType]or{}
list[val]=true
_handleLookup[openType]=list
systemControl.handleTempData()
end

function systemControl.onXianTuChanged(openType,val)
local list=_handleLookup[openType]or{}
list[val]=true
_handleLookup[openType]=list
systemControl.handleTempData()
end

function systemControl.onConditionBuildCreatedChanged(openType,val)
local list=_handleLookup[openType]or{}
list[val]=true
_handleLookup[openType]=list
systemControl.handleTempData()
end

function systemControl.onConditionJCTJJinDuChanged(openType)
local list=_handleLookup[openType]or{}
local val=JiuChongTianJieEnterModel:getAllProgress()
list[val]=true
_handleLookup[openType]=list
systemControl.handleTempData()
end

function systemControl.onConditionJCTJTianShuChanged(openType)
local list=_handleLookup[openType]or{}
local zerotime=timeHelper.convertShortStamp(timeHelper.getTodayZeroStamp())
local sec=JiuChongTianJieEnterModel:getOpenTianJieSec()
local val=math.floor(zerotime/86400)-math.floor(sec/86400)+1
list[val]=val
_handleLookup[openType]=list
systemControl.handleTempData()
end

function systemControl.onConditionLevelChanged(openType,lastVal,val)
local list=_handleLookup[openType]
if list then
lastVal=math.min(lastVal,list[1])
val=math.max(val,list[2])
end
_handleLookup[openType]={lastVal,val}
systemControl.handleTempData()
end

function systemControl.onConditionTaskChanged(openType,taskid,status)
if status~=taskModel.taskFinishState then return end
if _handleLookup[openType]==nil then _handleLookup[openType]={}end
local list=_handleLookup[openType]
list[#list+1]=taskid
systemControl.handleTempData()
end

function systemControl.onConditionServerChanged(openType)
if _handleLookup[openType]==nil then _handleLookup[openType]={}end
local list=_handleLookup[openType]
local day=timeHelper.getServerOpenDay()
list[#list+1]=day
systemControl.handleTempData()
end

function systemControl.onConditionSysOpenDayChanged(openType)
if _handleLookup[openType]==nil then _handleLookup[openType]={}end
local list=_handleLookup[openType]
if _needCheckTimeSys then
local zerotime=timeHelper.getTodayZeroStamp()
if zerotime then
zerotime=timeHelper.convertShortStamp(zerotime)
for sys,v in pairs(_needCheckTimeSys)do
local openSec=systemModel.getSystemOpenTime(sys)
if openSec then
local val2=math.floor(zerotime/86400)-math.floor(openSec/86400)+1
list[#list+1]={sys,val2}
end

end
end
end
systemControl.handleTempData()
end


function systemControl.onConditionZheXianLingChanged(openType,bookid,index)
if _handleLookup[openType]==nil then _handleLookup[openType]={}end
local list=_handleLookup[openType]
list[#list+1]={bookid,index}
systemControl.handleTempData()
end

function systemControl.onConditionItemOrMoneyChanged(openType,itemid,num)
if _handleLookup[openType]==nil then _handleLookup[openType]={}end
local list=_handleLookup[openType]
list[#list+1]={itemid,num}
systemControl.handleTempData()
end

function systemControl.onConditionDiscipleJJChanged(openType,jjlevel)
if _handleLookup[openType]==nil then _handleLookup[openType]={}end
local list=_handleLookup[openType]
list[1]=jjlevel
systemControl.handleTempData()
end

function systemControl.onConditionReBuildXianYuChanged(openType,season_id,chapter_idx)
if _handleLookup[openType]==nil then _handleLookup[openType]={}end
local list=_handleLookup[openType]
if seasonController:checkSeasonStageBegined_NotCheckCondition(season_id,chapter_idx)then
list[#list+1]={chapter_idx,0}
end
if seasonController:checkSeasonStageEnded_NotCheckCondition(season_id,chapter_idx)then
list[#list+1]={chapter_idx,1}
end
systemControl.handleTempData()
end

function systemControl.onConditionXianJieEntityStageChanged(openType,entityType,newStage,oldStage)
if _handleLookup[openType]==nil then _handleLookup[openType]={}end
local list=_handleLookup[openType]

oldStage=oldStage or 0
for value=oldStage+1,newStage do
list[#list+1]={entityType,value}
end

systemControl.handleTempData()
end

function systemControl.onConditionMaxLevelChanged(openType,val)
local list=_handleLookup[openType]or{}
list[val]=true
_handleLookup[openType]=list
systemControl.handleTempData()
end

function systemControl.onConditionQuKuaiUnlockChanged(openType,worldid,qukuaiID,stage)
if _handleLookup[openType]==nil then _handleLookup[openType]={}end
local list=_handleLookup[openType]
if not stage then
stage=worldBlockModel:getBlockState(worldid,qukuaiID)
end

if stage==eWorldBlockState.OPEN then
list[#list+1]={worldid,qukuaiID}
end

systemControl.handleTempData()
end


function systemControl.handleTempData()
if not _isInit then return end

local enoughArray={}
for openType,list in pairs(_handleLookup)do
systemControl.addEnoughSystem(enoughArray,openType,list)
end
_handleLookup={}

local array={}
for sysid,_ in pairs(enoughArray)do
array[#array+1]=sysid
end
systemProtocolControl.reqSystemListOpen(array)
end


function systemControl.addEnoughSystem(enoughArray,openType,list)
if openType==SYSTEM_OPEN_TYPE.eZongmemLevelChanged then
for i=list[1],list[2]do
local sysidList=systemConfig.getCheckListByConfig(openType,i)
for _,sysid in ipairs(sysidList)do
if enoughArray[sysid]==nil and systemModel.isCanOpen(sysid)then
enoughArray[sysid]=true
end
end
end
elseif openType==SYSTEM_OPEN_TYPE.eTaskFinish then
for i,taskid in ipairs(list)do
local sysidList=systemConfig.getCheckListByConfig(openType,taskid)
for _,sysid in ipairs(sysidList)do
if enoughArray[sysid]==nil and systemModel.isCanOpen(sysid)then
enoughArray[sysid]=true
end
end
end
elseif openType==SYSTEM_OPEN_TYPE.eOpenServerTime then
local openDayArray={}
for _,openDay in ipairs(list)do
if openDayArray[openDay]==nil then
openDayArray[openDay]=true
local sysidList=systemConfig.getCheckListByConfig(openType,openDay)
for _,sysid in ipairs(sysidList)do
if enoughArray[sysid]==nil and systemModel.isCanOpen(sysid)then
enoughArray[sysid]=true
end
end
end
end
elseif openType==SYSTEM_OPEN_TYPE.eZheXianLingBook then
for i,args in ipairs(list)do
local bookid=args[1]
local index=args[2]
local sysidList=systemConfig.getCheckListByConfig(openType,bookid,index)
for _,sysid in ipairs(sysidList)do
if enoughArray[sysid]==nil and systemModel.isCanOpen(sysid)then
enoughArray[sysid]=true
end
end
end
elseif openType==SYSTEM_OPEN_TYPE.eItemOrMoney then
for i,args in ipairs(list)do
local itemid=args[1]
local num=args[2]
local sysidList=systemConfig.getCheckListByConfig(openType,itemid)
for n,arr in pairs(sysidList)do
if num>=n then
for _,sysid in ipairs(arr)do
if enoughArray[sysid]==nil and systemModel.isCanOpen(sysid)then
enoughArray[sysid]=true
end
end
end
end
end
elseif openType==SYSTEM_OPEN_TYPE.eXianTuLevel then
for k,v in pairs(list)do
local sysidList=systemConfig.getCheckListByConfig(openType,k)
for _,sysid in ipairs(sysidList)do
if enoughArray[sysid]==nil and systemModel.isCanOpen(sysid)then
enoughArray[sysid]=true
end
end
end
elseif openType==SYSTEM_OPEN_TYPE.eWuXingShengDianOpen then
for k,v in pairs(list)do
local sysidList=systemConfig.getCheckListByConfig(openType,k)
for _,sysid in ipairs(sysidList)do
if enoughArray[sysid]==nil and systemModel.isCanOpen(sysid)then
enoughArray[sysid]=true
end
end
end
elseif openType==SYSTEM_OPEN_TYPE.eServerPlatform or
openType==SYSTEM_OPEN_TYPE.eServerPlatformOpen then









elseif openType==SYSTEM_OPEN_TYPE.eCreatedBuild then
for buildid,_ in pairs(list)do
local sysidList=systemConfig.getCheckListByConfig(openType,buildid)
for _,sysid in ipairs(sysidList)do
if enoughArray[sysid]==nil and systemModel.isCanOpen(sysid)then
enoughArray[sysid]=true
end
end
end
elseif openType==SYSTEM_OPEN_TYPE.eJiuChongTianJieJinDu then
for k,v in pairs(list)do
local sysidList=systemConfig.getCheckListByConfig(openType,k)
for _,sysid in ipairs(sysidList)do
if enoughArray[sysid]==nil and systemModel.isCanOpen(sysid)then
enoughArray[sysid]=true
end
end
end
elseif openType==SYSTEM_OPEN_TYPE.eJiuChongTianJieOpenDay then
for k,v in pairs(list)do
local sysidList=systemConfig.getCheckListByConfig(openType,k)
for _,sysid in ipairs(sysidList)do
if enoughArray[sysid]==nil and systemModel.isCanOpen(sysid)then
enoughArray[sysid]=true
end
end
end
elseif openType==SYSTEM_OPEN_TYPE.eSysOpenDay then
for k,v in pairs(list)do
local sysidList=systemConfig.getCheckListByConfig(openType,v[1],v[2])
for _,sysid in ipairs(sysidList)do
if enoughArray[sysid]==nil and systemModel.isCanOpen(sysid)then
enoughArray[sysid]=true
end
end
end
elseif openType==SYSTEM_OPEN_TYPE.eDiscipleReachJJ then
local sysidList=systemConfig.getCheckListByConfig(openType,list[1])
for _,sysid in ipairs(sysidList)do
if enoughArray[sysid]==nil and systemModel.isCanOpen(sysid)then
enoughArray[sysid]=true
end
end
elseif openType==SYSTEM_OPEN_TYPE.eReBuildXianYuTask then
for k,v in pairs(list)do
local sysidList=systemConfig.getCheckListByConfig(openType,v[1],v[2])
for _,sysid in ipairs(sysidList)do
if enoughArray[sysid]==nil and systemModel.isCanOpen(sysid)then
enoughArray[sysid]=true
end
end
end
elseif openType==SYSTEM_OPEN_TYPE.eXianJieEntityStage then
for k,v in pairs(list)do
local sysidList=systemConfig.getCheckListByConfig(openType,v[1],v[2])
for _,sysid in ipairs(sysidList)do
if enoughArray[sysid]==nil and systemModel.isCanOpen(sysid)then
enoughArray[sysid]=true
end
end
end
elseif openType==SYSTEM_OPEN_TYPE.eZongMenFullLevel then
for k,v in pairs(list)do
local sysidList=systemConfig.getCheckListByConfig(openType,k)
for _,sysid in ipairs(sysidList)do
if enoughArray[sysid]==nil and systemModel.isCanOpen(sysid)then
enoughArray[sysid]=true
end
end
end
elseif openType==SYSTEM_OPEN_TYPE.eQuKuaiUnLock then
for k,v in pairs(list)do
local sysidList=systemConfig.getCheckListByConfig(openType,v[1],v[2])
for _,sysid in ipairs(sysidList)do
if enoughArray[sysid]==nil and systemModel.isCanOpen(sysid)then
enoughArray[sysid]=true
end
end
end
end
end

function systemControl.playOpenPlot(id)
local cfg=systemConfig.getSystemConfig(id)
if cfg==nil then return end
local behavier=cfg.behavier
if not behavier then return end
local screenParams=behavier.screenParams
local targetParams=behavier.targetParams
local plot=behavier.plot
if plot==nil then return end
local plot_type=plot[1]
local plot_name=plot[2]
local isBehavier=plot_type==1 or plot_type==3
local check=true
if isBehavier then
check=systemControl.checkPlot(plot_name)
end
if check then
local callBack=function(flag_)
if flag_ then
local flag=gameplotController.activePlot(plot)
if flag and isBehavier then
systemControl.setPlot(plot_name)
end
end
end
if screenParams~=nil then
cameraMoveController:Begin(screenParams,targetParams,callBack)
else
callBack(true)
end
return true
end
end

function systemControl.checkPlot(plot_name)
local marklist=userActorSetting.get('sysopenPlot',{})
if marklist[plot_name]~=nil then
return false
end
return true
end

function systemControl.setPlot(plot_name)
local marklist=userActorSetting.get('sysopenPlot',{})
marklist[plot_name]=true
userActorSetting.flushVal('sysopenPlot',marklist,{})
end

function systemControl.isNeedOpenDaySys(sysid)
return _needCheckTimeSys[sysid]
end