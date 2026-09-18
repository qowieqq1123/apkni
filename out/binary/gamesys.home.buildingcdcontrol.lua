
buildingCDControl=gameState.addListener({})

local _cd_func_type={
[buildingCDFuncType.build]={buildingCDType.build},
[buildingCDFuncType.manufacture]={
buildingCDType.plan,
buildingCDType.natural,


},
}

















local _cd_define_data={
[buildingCDType.build]={
check=function(bdData)
return bdData.flag>0
end,
init=function(data)
local bdData=data.bdData
local ftype=zongmenModel:getBDFlagType(bdData.flag)
local lutime
if ftype==bdFlagType.sectionBuildStart then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
lutime=cfg.repair_time[bdData.flag-10]
else
local level=ftype==bdFlagType.build and bdData.level or(bdData.level+1)
local lcfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,level)
lutime=lcfg.uplevel_times
end
local curTime=gameUtilityModel.getServerShortTime()
data.beginTime=bdData.begintime
local dtime=curTime-data.beginTime

if dtime<0 then
data.beginTime=curTime
dtime=0
end
dtime=curTime-data.beginTime+bdData.reducetime
local ntime=lutime
data.cd=math.max(ntime-dtime,0)
data.complete=dtime>=ntime
data.dtime=dtime
data.ntime=ntime
data.percent=dtime/ntime
end,
update=function(data,time)
if not data.complete then
data.dtime=time-data.beginTime+data.bdData.reducetime
data.percent=data.dtime/data.ntime
data.cd=data.ntime-data.dtime
if data.cd<=0 then
data.complete=true
buildingCDControl:setReddotFlag(true)
end
end
end,
},
[buildingCDType.plan]={
check=function(bdData)
return bdData.plant_id>0
end,
init=function(data)
local bdData=data.bdData
local lcfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level)
local pdata=lcfg.produce_plans[bdData.plant_id]
data.stepNum=pdata.groups[1]
local planDatas=zongmenModel:countPlanRewardDatas(bdData)
local beginTime=bdData.pcreateopentime-bdData.pcreatetotaltimes
data.beginTime=beginTime
data.planDatas=planDatas
data.showStep=bdData.hasExNum
data.finishStep=bdData.hasExNum

local time=gameUtilityModel.getServerShortTime()
local isPause=bdData.pcreateopentime==0
local dtime
if isPause then
dtime=bdData.pcreatetotaltimes+bdData.pcreatereducetimes
else
dtime=time-data.beginTime+bdData.pcreatereducetimes
end
local currStep=bdData.hasExNum+1
local ntime=0
local passTime=0
for i,v in ipairs(planDatas)do
ntime=ntime+v.stepTime
if i<currStep then
passTime=passTime+v.stepTime
end
end
data.passTime=passTime
data.ntime=ntime
data.dtime=passTime+dtime
data.percent=data.dtime/data.ntime
data.cd=data.ntime-data.dtime

data.isPause=false

end,
update=function(data,time)
if not data.complete and not data.isPause then
local bdData=data.bdData
data.isPause=bdData.pcreateopentime==0
local dtime
if data.isPause then
dtime=bdData.pcreatetotaltimes+bdData.pcreatereducetimes
else
dtime=time-data.beginTime+bdData.pcreatereducetimes
end
local oldStep=data.currStep
local currStep=bdData.hasExNum+1
local len=#data.planDatas
local count=0
local complete=true
for i=currStep,len do
local pd=data.planDatas[i]
if dtime>=count+pd.stepTime then
count=count+pd.stepTime
data.finishStep=i
else
complete=false
data.currStep=i
data.stepDTime=dtime-count
data.stepNeedTime=pd.stepTime
data.stepCD=data.stepNeedTime-data.stepDTime
data.stepPercent=data.stepDTime/data.stepNeedTime
data.dtime=data.passTime+dtime
data.percent=data.dtime/data.ntime
data.cd=data.ntime-data.dtime
break
end
end
if complete then
data.complete=true
data.finishStep=data.stepNum
data.currStep=data.stepNum
local pd=data.planDatas[data.currStep]
data.stepDTime=pd.stepTime
data.stepNeedTime=pd.stepTime
data.stepCD=0
data.stepPercent=1
data.dtime=data.ntime
data.cd=0
buildingCDControl:setReddotFlag(true)
chatGGControl.onBuildEvent(bdData,bdData.dizi_id,bdData.plant_id)
end
if oldStep~=data.currStep then

notifySystem:postNotify(notifyConfig.onPlanStepChange,data.bdData.un_build_id,data.currStep,oldStep)
end
local canReceive=data.finishStep>data.bdData.hasExNum
local status=canReceive and planStatus.eComplete or planStatus.eStart
if status~=bdData.planStatus then
bdData.planStatus=status
isometricMapSystem:changeModel(bdData)
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end
end,
checkReceive=function(data)
return data.finishStep>data.bdData.hasExNum
end,
},
[buildingCDType.natural]={
check=function(bdData)
return bdData.ncreateopentime>0
end,
init=function(data)
local bdData=data.bdData
local cfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level)
data.utime=cfg.normal_produce[1]
data.uvalue=cfg.normal_produce.rewards[1][2]
data.mvalue=cfg.normal_produce.maxrewards[1][2]
end,
update=function(data,time)
local bdData=data.bdData
local dtime=time-bdData.ncreateopentime+bdData.ncreatetotaltimes
data.value=math.floor(dtime/data.utime)*data.uvalue
data.percent=data.value/data.mvalue
end,
checkReceive=function(data)
local percent=cfgHelper.get2(cfg_monijybuildconfig_get,data.bdData.build_id,'receive_percent')or 1
return data.percent>=percent
end,
},
[buildingCDType.liandan]={
check=function(bdData)
local dyData=UIDanYaoModel:get_danYaodata(bdData.un_build_id)
if dyData then
return dyData.cnt>0
end
return false
end,
init=function(data)
local bdData=data.bdData
local dyData=UIDanYaoModel:get_danYaodata(bdData.un_build_id)
local dfId=dyData.dfId
data.dfId=dfId
local curTime=gameUtilityModel.getServerShortTime()

data.dyCount=dyData.cnt
data.dfTime=UIDanYaoModel:getDanFangNeedTime(dfId,bdData.dizi_id)
local ntime=data.dfTime*data.dyCount
local dtime
if dyData.beginTime==0 then
dtime=dyData.passTime
data.beginTime=curTime
data.isPause=true
else
dtime=curTime-dyData.beginTime+dyData.passTime
data.beginTime=curTime-dtime
data.isPause=false
end
data.fCount=math.min(math.floor(dtime/data.dfTime),data.dyCount)
data.rCount=0

data.cd=math.max(ntime-dtime,0)
data.complete=dtime>ntime
data.dtime=dtime
data.ntime=ntime
data.percent=dtime/ntime

if data.complete then
data.fCount=data.dyCount
data.stepDTime=data.dfTime
data.stepCD=0
data.stepPercent=1
else
data.stepDTime=data.dtime%data.dfTime
data.stepCD=data.dfTime-data.stepDTime
data.stepPercent=data.stepDTime/data.dfTime
end
end,
update=function(data,time)
if not data.isPause and not data.complete then
data.dtime=time-data.beginTime
data.percent=data.dtime/data.ntime
data.fCount=math.min(math.floor(data.dtime/data.dfTime),data.dyCount)
data.cd=data.ntime-data.dtime

data.stepDTime=data.dtime%data.dfTime
data.stepCD=data.dfTime-data.stepDTime
data.stepPercent=data.stepDTime/data.dfTime

if data.cd<=0 then
data.stepDTime=data.dfTime
data.complete=true
buildingCDControl:setReddotFlag(true)

local ubdId=data.bdData.un_build_id
local rtype
if UIDanYaoController:isDingDanSystemOpen()then
local bdata=UIDanYaoModel:getBatchData(ubdId)
UIDanYaoModel:setDingDanIndex(bdata)
if not UIDanYaoModel:isDingDanNoProduction(ubdId)then
UIDanYaoModel:setCurrentDingDan(bdata)
buildingCDControl:resetCDData(buildingCDType.liandan,ubdId)
hudControl:refreshBuildingStatusHUD(ubdId)
rtype=3
end
end
UIManager:callWindowFunc('UIDanYaoWin','checkAndCallFunc',ubdId,'flushLianZhiComplete',rtype)
end
end
end,
checkReceive=function(data)
if UIDanYaoController:isDingDanSystemOpen()then
local bdata=UIDanYaoModel:getBatchData(data.bdData.un_build_id)
if#bdata.ddList>0 then
local dd=bdata.ddList[1]
if dd.complete then
return true
end
end
end
return data.fCount>data.rCount
end,
},
[buildingCDType.lianqi]={
check=function(bdData)
return fabaoModel.hasLianzhiInfo(bdData.un_build_id)
end,
init=function(data)
local currtime=gameUtilityModel.getServerShortTime()
local ubdId=data.bdData.un_build_id
local infoIndex=1

local info=fabaoModel.getLianzhiInfoByIdx(ubdId,infoIndex)
if not info then
return
end

local mainid=info.param_4
local itemcfg=itemsConfig.getConfig(mainid)
if itemcfg==nil then return end
local stage=itemcfg.stage
if stage==nil then return end
local needtime=fabaoConfig.getCreateTime(stage)
local endtime=info.param_5
data.beginTime=endtime-needtime
data.ntime=needtime
data.dtime=needtime-endtime+currtime
data.cd=math.max(data.ntime-data.dtime,0)
data.complete=data.dtime>=data.ntime
data.percent=data.dtime/data.ntime
end,
update=function(data,time)
if not data.complete then
data.dtime=time-data.beginTime
data.percent=data.dtime/data.ntime
data.cd=data.ntime-data.dtime
if data.cd<=0 then
data.complete=true
hudControl:refreshBuildingStatusHUD(data.bdData.un_build_id)
end
end
end,
},

[buildingCDType.tiandaohecheng]={
check=function(bdData)
return tianDaoRongDingModel:hasPeiFang()
end,
init=function(data)
local currtime=gameUtilityModel.getServerShortTime()
local beginTime,endtime=tianDaoRongDingModel:getTime()
local needtime=endtime-beginTime
data.beginTime=beginTime
data.ntime=needtime
data.dtime=needtime-endtime+currtime
data.cd=math.max(data.ntime-data.dtime,0)
data.complete=data.dtime>=data.ntime
data.percent=data.dtime/data.ntime
end,
update=function(data,time)
if not data.complete then
data.dtime=time-data.beginTime
data.percent=data.dtime/data.ntime
data.cd=data.ntime-data.dtime
if data.cd<=0 then
data.complete=true
hudControl:refreshBuildingStatusHUD(data.bdData.un_build_id)
end
end
end,
},
[buildingCDType.xiufu]={
check=function(bdData)
return emergenciesModel:isInRepairTime(bdData.un_build_id)
end,
init=function(data)
local currtime=gameUtilityModel.getServerShortTime()
local endtime=emergenciesModel:getRepairTime(data.bdData.un_build_id)
data.endTime=endtime
data.cd=endtime-currtime
data.complete=data.cd<=0
end,
update=function(data,time)
if not data.complete then
data.cd=data.endTime-time
if data.cd<=0 then
data.complete=true

emergenciesControl:endRepair(data.bdData)
end
end
end,
},
[buildingCDType.lianDanXiuFu]={
check=function(bdData)
return jctjDuJieXianDanModel:isInRepairTime(bdData.un_build_id)
end,
init=function(data)
local currtime=gameUtilityModel.getServerShortTime()
local endtime=jctjDuJieXianDanModel:getRepairTime(data.bdData.un_build_id)
data.endTime=endtime
data.cd=endtime-currtime
data.complete=data.cd<=0
end,
update=function(data,time)
if not data.complete then
data.cd=data.endTime-time
if data.cd<=0 then
data.complete=true

emergenciesControl:endRepair(data.bdData)
end
end
end,
},
[buildingCDType.dujiexiandan]={
check=function(bdData)
return jctjDuJieXianDanModel:isLianDanFinish()and bdData.un_build_id==jctjDuJieXianDanModel:getLianZhiBuild()
end,
init=function(data)
local currtime=gameUtilityModel.getServerShortTime()
local endtime=jctjDuJieXianDanModel:getLianZhiEndTime()
data.endTime=endtime
data.cd=endtime-currtime
data.complete=data.cd<=0
end,
update=function(data,time)
if not data.complete then
data.cd=data.endTime-time
if data.cd<=0 then
data.complete=true

reddotControl.on_change_catch_type(CATCH_TYPE.eDuJieXianDan)
end
end
end,
},
[buildingCDType.chanrao]={
check=function(bdData)
return emergenciesModel:isCreeper(bdData.un_build_id)
end,
init=function(data)
local currtime=gameUtilityModel.getServerShortTime()
local endtime=emergenciesModel:getCreeper(data.bdData.un_build_id)
data.endTime=endtime
data.cd=endtime-currtime
data.complete=data.cd<=0
end,
update=function(data,time)
if not data.complete then
data.cd=data.endTime-time
if data.cd<0 then
data.complete=true

emergenciesControl:endCreeper(data.bdData)
end
end
end,
},
[buildingCDType.xuanshang]={
check=function(bdData)
return true
end,
init=function(data)
local isXJsystem=XianjieXuanShangController:changeXJXSsystm()
if isXJsystem then
local taskList=XianjieXuanShangModel:getTaskAllData()
if taskList then
for k,v in pairs(taskList)do
if v then
XianjieXuanShangModel:addCDData(v)
end
end
end
else
local taskList=UIXuanShangControl:getTaskList()
if taskList then
for k,v in pairs(taskList)do
UIXuanShangControl:addCDData(v)
end
end
end
end,
update=function(data,time)
local isXJsystem=XianjieXuanShangController:changeXJXSsystm()
if isXJsystem then
local datas=XianjieXuanShangModel:getCDDatas()
for k,v in pairs(datas)do
if not v.complete then
v.dtime=time-v.beginTime
v.cd=v.ntime-v.dtime
if v.cd<=0 then
v.complete=true
UIManager:invokeUIMethod('UIXianjieXuanShangWin','initinfo')
XianjieXuanShangController:refreshXuanShangHUD()
end
end
end
else
local datas=UIXuanShangControl:getCDDatas()
for k,v in pairs(datas)do
if not v.complete then
v.dtime=time-v.beginTime
v.cd=v.ntime-v.dtime
if v.cd<=0 then
v.complete=true
UIManager:invokeUIMethod('UIXuanShangWin','refresh')
UIXuanShangControl:refreshXuanShangHUD()
end
end
end
end
end,
},
[buildingCDType.zhifu]={
check=function(bdData)
local pdata=UIFuLuFangModel:getProduceData(bdData.un_build_id)
return pdata~=nil
end,
init=function(data)
local pdata=UIFuLuFangModel:getProduceData(data.bdData.un_build_id)

local cfg=cfgHelper.get1(cfg_yufufangconfig_get,pdata.yufu_id)
data.stepTime=cfg.lz_time
data.makeNum=pdata.all_cnt
data.ntime=data.stepTime*data.makeNum

local currTime=gameUtilityModel.getServerShortTime()

local dtime
if pdata.is_stop==0 then
dtime=pdata.stop_time
data.beginTime=currTime
data.isPause=true
else
dtime=currTime-pdata.begin_time+pdata.stop_time
data.beginTime=currTime-dtime
data.isPause=false
end

data.dtime=math.max(dtime,0)
data.cd=data.ntime-data.dtime
data.complete=data.cd<=0
if data.complete then
data.currStep=data.makeNum
data.stepDTime=data.stepTime
data.stepCD=0
data.stepPercent=1
else
data.currStep=math.floor(data.dtime/data.stepTime)
data.stepDTime=data.dtime%data.stepTime
data.stepCD=data.stepTime-data.stepDTime
data.stepPercent=data.stepDTime/data.stepTime
end
end,
update=function(data,time)
if not data.isPause and not data.complete then
data.dtime=time-data.beginTime
data.dtime=math.max(data.dtime,0)
data.cd=data.ntime-data.dtime
data.currStep=math.floor(data.dtime/data.stepTime)
data.stepDTime=data.dtime%data.stepTime
data.stepCD=data.stepTime-data.stepDTime
data.stepPercent=data.stepDTime/data.stepTime
if data.cd<=0 then
data.stepDTime=data.stepTime
data.complete=true
hudControl:refreshBuildingStatusHUD(data.bdData.un_build_id)
end
end
end,
checkReceive=function(data)
local bdData=data.bdData
local pdata=UIFuLuFangModel:getProduceData(bdData.un_build_id)
local count=data.currStep-pdata.rec_cnt
return count>0
end,
},
[buildingCDType.binggongfang]={
check=function(bdData)
local state=bingGongChangModel:lianZhiState()
return state>=1
end,
init=function(data)
local currtime=gameUtilityModel.getServerShortTime()
local starttime=bingGongChangModel:getStartTime()
local needTimeOne=cfgHelper.get(cfg_binggongfangbaseconfig_get,1,"needTime")
local selectNum=bingGongChangModel:getSelectNum()
local needTime=needTimeOne*selectNum
local endtime=starttime+needTime
data.beginTime=starttime
data.endTime=endtime
data.cd=endtime-currtime
data.complete=data.cd<=0
data.ntime=endtime-starttime
data.dtime=currtime-starttime
data.selectNum=selectNum
data.needTimeOne=needTimeOne
data.createNum=math.floor(data.dtime/data.needTimeOne)
end,
update=function(data,time)
if not data.isPause and not data.complete then
data.cd=data.endTime-time
data.dtime=time-data.beginTime
if data.cd<=0 then
data.complete=true
bingGongChangController.refreshBuildingReddot()
end
local newNum=math.floor(data.dtime/data.needTimeOne)
if newNum>data.createNum then
bingGongChangController.refreshBuildingReddot()
end
data.createNum=newNum
end
end,
checkReceive=function(data)
return bingGongChangModel:getLianZhiRecviveOne()==0
end,
},
[buildingCDType.shangpu]={
check=function(bdData)
return true
end,

init=function(data)
local state,endTime,beginTime,curtime=UIShopControl:getShopCreateState(data.bdData)

if state==SHOP_CREATE_TYPE.eAutoFinish then
data.cd=0
data.complete=true
elseif state==SHOP_CREATE_TYPE.eNull or state==SHOP_CREATE_TYPE.eNone then
data.cd=nil
data.complete=false
elseif state==SHOP_CREATE_TYPE.eFinish then
data.cd=0
data.complete=true
elseif state==SHOP_CREATE_TYPE.eCreating then
data.cd=endTime-curtime
data.beginTime=beginTime
data.endTime=endTime
data.ntime=endTime-beginTime
data.dtime=curtime-beginTime
data.complete=false
end

end,
update=function(data,time)
local state,endTime,beginTime,curtime=UIShopControl:getShopCreateState(data.bdData)

if state==SHOP_CREATE_TYPE.eAutoFinish then
data.cd=0
data.complete=true
elseif state==SHOP_CREATE_TYPE.eNull or state==SHOP_CREATE_TYPE.eNone then
data.cd=nil
data.complete=false
elseif state==SHOP_CREATE_TYPE.eFinish then
data.cd=0
data.complete=true
elseif state==SHOP_CREATE_TYPE.eCreating then
data.cd=endTime-curtime
data.beginTime=beginTime
data.endTime=endTime
data.ntime=endTime-beginTime
data.dtime=curtime-beginTime
data.complete=false
end

end,
checkReceive=function(data)

return UIShopControl:checkRcvState(data.bdData)
end,
},
[buildingCDType.taixucang]={
check=function(bdData)
return TaiXuCangModel:getLeftTime()>0
end,
init=function(data)
data.leftTime=TaiXuCangModel:getLeftTime()
end,
update=function(data,time)
data.leftTime=TaiXuCangModel:getLeftTime()
if data.leftTime<=0 then
hudControl:refreshBuildingStatusHUD(data.bdData.un_build_id)
end
end,
},
[buildingCDType.zhalu]={
check=function(bdData)
local check=UIDanYaoModel:checkZhaLu(bdData.un_build_id,DANYAO_ZHALU_SEASON.eDiscipleSpecial)
return check
end,
init=function(data)
local check,least=UIDanYaoModel:checkZhaLu(data.bdData.un_build_id,DANYAO_ZHALU_SEASON.eDiscipleSpecial)

local now=gameUtilityModel.getServerShortTime()
least=check and least or 0
data.endTime=now+least
data.cd=least
data.complete=data.cd<=0
end,
update=function(data,time)
if not data.complete then
data.cd=data.endTime-time
if data.cd<=0 then
data.complete=true

UIDanYaoController:hideZhaLuPerformance(data.bdData)
end
end
end,
},
[buildingCDType.littleworld]={
check=function(bdData)
return not LittleWorldModel:canGetReward()
end,
init=function(data)
data.leftTime=LittleWorldModel:getFirstRewardLeftTime()
end,
update=function(data,time)
data.leftTime=LittleWorldModel:getFirstRewardLeftTime()
if data.leftTime<=0 then
hudControl:refreshBuildingStatusHUD(data.bdData.un_build_id)
UIManager:callWindowFunc("UIXJLittleWorldInfoWin","onRecvReward")
end
end,
},
[buildingCDType.xjtrain]={
check=function(bdData)
local beginTime=yunjiayingModel:getTrainBeginTime()
local trainList=yunjiayingModel:getTrainList()
if beginTime and beginTime>0 and trainList and next(trainList)~=nil then
return true
end
return false
end,
init=function(data)
data.leftTime=yunjiayingModel:getAllTrainLeftTime()
data.beginTime=yunjiayingModel:getTrainBeginTime()or 0
data.endTime=yunjiayingModel:getAllTrainFinalFinishTime()
data.ntime=data.endTime-data.beginTime
end,
update=function(data,time)
data.leftTime=yunjiayingModel:getAllTrainLeftTime()
data.dtime=data.ntime-data.leftTime
if data.leftTime<=0 then
data.complete=true
end
end,
},
[buildingCDType.zwgPlane]={
check=function(bdData)
return not zaoWuGeModel:checkFinishBuild()
end,
init=function(data)
local progressInfo=zaoWuGeModel:getBuildingProgressInfo()

local singleBuildDuration=cfgHelper.get2(cfg_zaowugebaseconfig_get,1,'needTime')

data.startTime=progressInfo.startTime
data.endTime=progressInfo.startTime+singleBuildDuration
end,
update=function(data,time)
if time>data.endTime then
data.complete=true
end
end,
},
[buildingCDType.yushoufang]={
check=function(bdData)
local isreddot,flag=yushoufangModel.hasReddotInfo(bdData.un_build_id)
return isreddot
end,
init=function(data)
local currtime=gameUtilityModel.getServerShortTime()
local un_build_id=data.bdData.un_build_id
local isreddot,flag=yushoufangModel.hasReddotInfo(un_build_id)
if not isreddot then
return
end
local _data=yushoufangModel:getLSDataByBuildID(un_build_id)
if not _data then
return
end
local endtime=_data.group_end_time
local group_begin_time=_data.group_begin_time
local needtime=endtime-group_begin_time
data.beginTime=group_begin_time
data.ntime=needtime
data.dtime=needtime-endtime+currtime
data.cd=math.max(data.ntime-data.dtime,0)
data.complete=data.dtime>=data.ntime
data.percent=data.dtime/data.ntime
end,
update=function(data,time)
if not data.complete then
data.dtime=time-data.beginTime
data.percent=data.dtime/data.ntime
data.cd=data.ntime-data.dtime
if data.cd<=0 then
data.complete=true


end
end
end,
},
}

function buildingCDControl:onAppStart()
self.updateDatas={
{
updateInterval=1,
lastUpdateTime=0,
updateFunc=self.updateBuildingCD
},
{
updateInterval=0.73,
lastUpdateTime=0,
updateFunc=self.updateReddot
},
}
end

function buildingCDControl:onEnterState(isReconnect)
if isReconnect then
return
end
self.initAllCD={}
self.cdDatas={}
self:reset()
loggerUtil.logFMT('clear all CDData')

end

function buildingCDControl:onLeaveState(isReconnect)
if isReconnect then
return
end

end

function buildingCDControl:reset()
for k,v in pairs(buildingCDType)do
self.cdDatas[v]={}
end
self.dzIdToGUID={}
self.idCount=0
self.cdUpdateFuncDict={}
self.initAllCD={}
loggerUtil.logFMT('clear all CDData')
end









function buildingCDControl:setReddotFlag(flag)
self.reddot_update_flag=flag
end

function buildingCDControl:onEnterHome()



self:startTick()
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)

end

function buildingCDControl:onLeaveHome()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
self:stopTick()


self:reset()
end
















local _handle_building_event_func={
[buildingEvent.planStart]=function(etype,sfId,bdId,arg1,arg2)
local bdData=zongmenModel:getBuildingData(bdId)
buildingCDControl:addCDData(buildingCDType.plan,bdData)
end,
[buildingEvent.planComplete]=function(etype,sfId,bdId,arg1,arg2)
buildingCDControl:removeCDData(buildingCDType.plan,bdId)
end,
[buildingEvent.planCancel]=function(etype,sfId,bdId,arg1,arg2)
buildingCDControl:removeCDData(buildingCDType.plan,bdId)
end,
[buildingEvent.buildStart]=function(etype,sfId,bdId,arg1,arg2)
local bdData=zongmenModel:getBuildingData(bdId)
buildingCDControl:addCDData(buildingCDType.build,bdData)
end,
[buildingEvent.buildComplete]=function(etype,sfId,bdId,arg1,arg2)
buildingCDControl:removeCDData(buildingCDType.build,bdId)
end,
[buildingEvent.levelUpStart]=function(etype,sfId,bdId,arg1,arg2)
local bdData=zongmenModel:getBuildingData(bdId)
buildingCDControl:addCDData(buildingCDType.build,bdData)
end,
[buildingEvent.levelUpComplete]=function(etype,sfId,bdId,arg1,arg2)
buildingCDControl:removeCDData(buildingCDType.build,bdId)
end,
[buildingEvent.buildDataChange]=function(etype,sfId,bdId,arg1,arg2)
buildingCDControl:setAllTytpeByBDID(bdId)
end,
[buildingEvent.liandanStart]=function(etype,sfId,bdId,arg1,arg2)
local bdData=zongmenModel:getBuildingData(bdId)
buildingCDControl:addCDData(buildingCDType.liandan,bdData)
end,
[buildingEvent.liandanComplete]=function(etype,sfId,bdId,arg1,arg2)
buildingCDControl:removeCDData(buildingCDType.liandan,bdId)
end,
[buildingEvent.liandanBreak]=function(etype,sfId,bdId,arg1,arg2)
buildingCDControl:removeCDData(buildingCDType.liandan,bdId)
end,
[buildingEvent.zhiFuStart]=function(etype,sfId,bdId,arg1,arg2)
local bdData=zongmenModel:getBuildingData(bdId)
buildingCDControl:addCDData(buildingCDType.zhifu,bdData)
end,
[buildingEvent.zhiFuComplete]=function(etype,sfId,bdId,arg1,arg2)
buildingCDControl:removeCDData(buildingCDType.zhifu,bdId)
end,
[buildingEvent.zhiFuBreak]=function(etype,sfId,bdId,arg1,arg2)
buildingCDControl:removeCDData(buildingCDType.zhifu,bdId)
end,
[buildingEvent.zwgPlaneStart]=function(etype,sfId,bdId,arg1,arg2)
buildingCDControl:addCDData(buildingCDType.zwgPlane,bdId)
end,
[buildingEvent.zwgPlaneComplete]=function(etype,sfId,bdId,arg1,arg2)
buildingCDControl:removeCDData(buildingCDType.zwgPlane,bdId)
end,
}

function buildingCDControl.on_building_event(etype,sfId,bdId,arg1,arg2)
local func=_handle_building_event_func[etype]
if func then
func(etype,sfId,bdId,arg1,arg2)
end
end

function buildingCDControl:resetCDData(etype,ubdId)
local bdData=zongmenModel:getBuildingData(ubdId)
self:addCDData(etype,bdData)
end

function buildingCDControl:setSpeedUp(bdId,utype)
local cdtype
if utype==speedUpType.eUpgradeBuilding then
cdtype=buildingCDType.build
elseif utype==speedUpType.eExecutePlant then
cdtype=buildingCDType.plan
else
return
end
local time=gameUtilityModel.getServerShortTime()
local data=self:getCDData(cdtype,bdId)
local def=_cd_define_data[cdtype]
if cdtype==buildingCDType.plan then
def.init(data)
end
def.update(data,time)
end

function buildingCDControl:addAllBuildingCD()
self:addAllBuildingCDByMapId(zongmenModel:getMountainId())
end

function buildingCDControl:addAllBuildingCDByMapId(mapId)
local datas=zongmenModel:getAllBuildingData(mapId)
for k,v in pairs(datas)do
self:checkAndSetData(v)
end
self.initAllCD[mapId]=true
end

function buildingCDControl:checkAndSetData(bdData)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local ptype=cfg.win_type

if ptype==sysWinType.eFangAn then
if bdData.plant_id>0 then
self:addCDData(buildingCDType.plan,bdData)
else
self:removeCDData(buildingCDType.plan,bdData.un_build_id)
end
elseif ptype==sysWinType.eZiRan then
self:addCDData(buildingCDType.natural,bdData)
elseif ptype==sysWinType.eShangPu then
self:addCDData(buildingCDType.shangpu,bdData)
end

local ftype=zongmenModel:getBDFlagType(bdData.flag)
if ftype==bdFlagType.build or ftype==bdFlagType.levelUp or ftype==bdFlagType.sectionBuildStart then
self:addCDData(buildingCDType.build,bdData)
end

if cfg.id==SLG_SYSTEM_TYPE.eLianDanFang then
self:addCDData(buildingCDType.liandan,bdData)
elseif cfg.id==SLG_SYSTEM_TYPE.eLianQiGe then
self:addCDData(buildingCDType.lianqi,bdData)
elseif cfg.id==SLG_SYSTEM_TYPE.eXuanShangTai then
self:addCDData(buildingCDType.xuanshang,bdData)
elseif cfg.id==SLG_SYSTEM_TYPE.eFuLuFang then
self:addCDData(buildingCDType.zhifu,bdData)
elseif cfg.id==SLG_SYSTEM_TYPE.tiandaohecheng then
self:addCDData(buildingCDType.zhifu,bdData)
elseif cfg.id==SLG_SYSTEM_TYPE.eYunJiaYing then
self:addCDData(buildingCDType.xjtrain,bdData)
elseif cfg.id==SLG_SYSTEM_TYPE.eYuShouFang then
self:addCDData(buildingCDType.yushoufang,bdData)
end
end

function buildingCDControl:startTick()
if self.timer==nil then
self.timer=FrameTimer.New(function()
if reconnectState:isDisConnectOrReconnect()then
return
end
local time=Time.time
for i,v in ipairs(self.updateDatas)do
local dtime=time-v.lastUpdateTime
if dtime>=v.updateInterval then
v.lastUpdateTime=time
v.updateFunc(self,dtime)
end
end
end,1,-1)
self.timer:Start()
end
end

function buildingCDControl:stopTick()
if self.timer then
self.timer:Stop()
self.timer=nil
end
end

function buildingCDControl:updateBuildingCD(delay)
local time=gameUtilityModel.getServerShortTime()
for k,v in pairs(self.cdDatas)do
local cdDefine=_cd_define_data[k]
for kk,vv in pairs(v)do
cdDefine.update(vv,time)
end
end
hudControl:onNormalUpdate()
for k,v in pairs(self.cdUpdateFuncDict)do
for kk,vv in pairs(v)do
vv(delay)
end
end
end

function buildingCDControl:addCDUpdateFunc(key1,key2,func)
local dict=self.cdUpdateFuncDict[key1]
if not dict then
dict={}
self.cdUpdateFuncDict[key1]=dict
end
dict[key2]=func
end

function buildingCDControl:removeCDUpdateFunc(key1,key2)
local dict=self.cdUpdateFuncDict[key1]
if dict then
dict[key2]=nil
end
end

function buildingCDControl:clearCDUpdateFunc(key1)
self.cdUpdateFuncDict[key1]=nil
end

function buildingCDControl:updateReddot(delay)
if self.reddot_update_flag then
self.reddot_update_flag=false
UIManager:invokeUIMethod('UIFuncStorageWin','refreshFastManagerBtn')
end
end

















function buildingCDControl:checkCD(bdCfg,bdData)
local cd
if bdCfg.id==SLG_SYSTEM_TYPE.eBingGongFang then
cd=bingGongChangModel:getLianZhiCD()
else
local cdtype
if bdCfg.win_type==sysWinType.eFangAn then
cdtype=buildingCDType.plan
elseif bdCfg.id==SLG_SYSTEM_TYPE.eLianDanFang then
cdtype=buildingCDType.liandan
end
if mainControl:isSceneType(eSceneType.eZongmen)then
cd=buildingCDControl:getCD(cdtype,bdData.un_build_id)
else
cd=buildingCDControl:checkCDEx(cdtype,bdData)
end
end
return cd
end

function buildingCDControl:checkCDEx(cdtype,bdData)
local cdDefine=_cd_define_data[cdtype]
if not cdDefine.check(bdData)then
return
end
local data={bdData=bdData}
cdDefine.init(data)
return data.cd
end

function buildingCDControl:addCDData(cdtype,bdData)
local datas=self.cdDatas[cdtype]



local cdDefine=_cd_define_data[cdtype]
if not cdDefine.check(bdData)then
return
end
local data={bdData=bdData}
cdDefine.init(data)
local time=gameUtilityModel.getServerShortTime()
cdDefine.update(data,time)
local un_build_id=bdData.un_build_id
datas[un_build_id]=data
self.dzIdToGUID[tostring(bdData.dizi_id)]=un_build_id
self:setReddotFlag(true)
loggerUtil.logFMT('add CDData cdtype:{0} un_build_id:{1}',cdtype,tostring(un_build_id))
end

function buildingCDControl:removeCDData(cdtype,bdId)
local datas=self.cdDatas[cdtype]
local data=datas[bdId]
if not data then
return
end
datas[bdId]=nil
self.dzIdToGUID[tostring(data.bdData.dizi_id)]=nil
self:setReddotFlag(true)
loggerUtil.logFMT('remove CDData cdtype:{0} un_build_id:{1}',cdtype,tostring(data.bdData.un_build_id))
end

function buildingCDControl:updateCDData(cdtype,bdId)
local cdDefine=_cd_define_data[cdtype]
local data=self:getCDData(cdtype,bdId)
local time=gameUtilityModel.getServerShortTime()
cdDefine.update(data,time)
end

function buildingCDControl:setAllTytpeByBDID(bdId)
local bdData=zongmenModel:getBuildingData(bdId)
if bdData then
self:checkAndSetData(bdData)
end
end

















function buildingCDControl:getFinishNum(cdtype)
local datas=self.cdDatas[cdtype]
local count=0
for i,v in pairs(datas)do
if v.complete then
count=count+1
end
end
return count
end

function buildingCDControl:getFinishNumReddot(cdtype)
local datas=self.cdDatas[cdtype]
local count=0
for i,v in pairs(datas)do
if v.complete then
return true
end
end
return false
end

function buildingCDControl:getCDTypeDatas(cdtype)
local datas=self.cdDatas[cdtype]
return datas
end

function buildingCDControl:getCDData(cdtype,ubdId,hideLog)
local datas=self.cdDatas[cdtype]
local data=datas[ubdId]
if not data and not hideLog then
local bdData=zongmenModel:getBuildingData(ubdId)
if bdData then
local bdId=bdData.build_id
local name=cfg_monijybuildconfig_get(bdId).name
loggerUtil.debugErrFMT('获取计时数据失败，计时类型：{0} 建筑名：{1}!',cdtype,name)
else
loggerUtil.debugErrFMT('获取计时数据失败，计时类型：{0} un_build_id：{1}!',cdtype,ubdId)
end
end
return data
end

function buildingCDControl:getCD(cdtype,bdId)
local data=self:getCDData(cdtype,bdId,true)
if data then
return data.cd
end
end

function buildingCDControl:getPercent(cdtype,bdId)
local data=self:getCDData(cdtype,bdId,true)
if data then
return data.percent
end
end

function buildingCDControl:isComplete(cdtype,bdId)
local data=self:getCDData(cdtype,bdId,true)
if data then
return data.complete
end
return false
end

function buildingCDControl:isCanReceive(cdtype,bdId)
local data=self:getCDData(cdtype,bdId,true)
if data then
local def=_cd_define_data[cdtype]
if def.checkReceive then
return def.checkReceive(data)
else
return data.complete
end
end
return false
end

function buildingCDControl:checkCompleteByFType(ftype,bdId)
local tdatas=_cd_func_type[ftype]
if tdatas then
for i,v in ipairs(tdatas)do
local check=self:isComplete(v,bdId)
if check then
return true
end
end
end
return false
end

function buildingCDControl:checkReceiveByFType(ftype,bdId)
local tdatas=_cd_func_type[ftype]
if tdatas then
for i,v in ipairs(tdatas)do
local check=self:isCanReceive(v,bdId)
if check then
return true
end
end
end
return false
end

function buildingCDControl:isTiming(cdtype,bdId)
local data=self:getCDData(cdtype,bdId,true)
if data then
return data.cd>0
end
return false
end

function buildingCDControl:countCDBytype(types)
local count=0
local maxCount=0
local baseCfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_times')
local feedTime=baseCfg[speedUpMode.eFree][1]
for i,v in ipairs(types)do
local datas=buildingCDControl:getCDTypeDatas(v)
for kk,vv in pairs(datas)do
local cd=vv.cd or 0
if cd>feedTime then
count=count+cd
end
maxCount=maxCount+cd
end
end
return count,maxCount
end