







xiaoZhuShouModel={}

local unlockCondType={
zmLv=1,
build=2,
xianmeng=3,
kfDay=4,
zmOrder=5,
wxsd=6,
platform=7,
notPlatform=8,
systemOpen=9,
systemNotOpen=10,
}

function xiaoZhuShouModel:onEnterState(isReconnet)
xiaoZhuShouModel:initSetupConfig()
self.orderList={}
self.orderLookup={}
self.detailDatas={}
self.reportDatas={}
self.reportDatasLookup={}
end

function xiaoZhuShouModel:initXiaoZhuShouActiveData()
self.orderLookup={}
local cfgs=cfg_xiaozhushouconfig()
local orderList={}
for orderID,cfg in ipairs(cfgs)do
if xiaoZhuShouModel:checkShowUnlock(orderID)then
local sortVal=cfg.sortVal
table.insert(orderList,{id=orderID,cfg=cfg,sortVal=sortVal})
self.orderLookup[orderID]=true
end
end
if#orderList>1 then
table.sort(orderList,function(a,b)
return a.sortVal<b.sortVal
end)
end
self.orderList=orderList
end

function xiaoZhuShouModel:refreshXiaoZhuShouActiveData()
local cfgs=cfg_xiaozhushouconfig()
local orderList=self.orderList
local reOrder=false
for orderID,cfg in ipairs(cfgs)do
if not self.orderLookup[orderID]and xiaoZhuShouModel:checkShowUnlock(orderID)then
local sortVal=cfg.sortVal
table.insert(orderList,{id=orderID,cfg=cfg,sortVal=sortVal})
self.orderLookup[orderID]=true
reOrder=true
end
end
if#orderList>1 and reOrder then
table.sort(orderList,function(a,b)
return a.sortVal<b.sortVal
end)
end
self.orderList=orderList
end

function xiaoZhuShouModel:getXiaoZhuShouActiveData()
return self.orderList
end

function xiaoZhuShouModel:getXiaoZhuShouConfig(orderID)
local cfg=cfgHelper.get1(cfg_xiaozhushouconfig_get,orderID)
return cfg
end

function xiaoZhuShouModel:setOrderNewFlag()
local xzs_new_flag_list=userActorArraySetting.get(ACTOR_SETTING_TYPE.eOneTimeReddot,'xzs_new_flag',{})
for i,v in ipairs(self.orderList)do
local orderID=tostring(v.id)
local unlock=xiaoZhuShouModel:checkSetupUnlock(v.id)
if not xzs_new_flag_list[orderID]and unlock then
xzs_new_flag_list[orderID]=1
end
end
userActorArraySetting.set(ACTOR_SETTING_TYPE.eOneTimeReddot,'xzs_new_flag',xzs_new_flag_list)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eOneTimeReddot)
end

function xiaoZhuShouModel:checkOrderNewFlag(orderID)
local xzs_new_flag_list=userActorArraySetting.get(ACTOR_SETTING_TYPE.eOneTimeReddot,'xzs_new_flag',{})
if not xzs_new_flag_list[tostring(orderID)]then
return true
end
return false
end

function xiaoZhuShouModel:checkShowUnlock(orderID)
local cfg=cfgHelper.get1(cfg_xiaozhushouconfig_get,orderID)
if cfg.unlock_show then
if not self:checkConditions(cfg.unlock_show)then
return false
end
end
local setupCfg=xiaoZhuShouModel:getSetupConfig(orderID)
if setupCfg and setupCfg.checkOpen then
if setupCfg.checkOpen()==false then
return false
end
end
return true
end

function xiaoZhuShouModel:checkSetupUnlock(orderID)
local cfg=cfgHelper.get1(cfg_xiaozhushouconfig_get,orderID)
if cfg.unlock_setup then
return self:checkConditions(cfg.unlock_setup)
end
return true
end

function xiaoZhuShouModel:checkConditions(conditions)
if type(conditions[1][1])=='table'then
local gameVersion=pfwindowslController:getGameVersion()
conditions=conditions[gameVersion]
end
for idx,v in ipairs(conditions)do
local conditionType=v[1]
local condArgs=v[2]
local tips=v[3]
if conditionType==unlockCondType.zmLv then
local zmLevel=zongmenModel:getLevel()or 0
if zmLevel<condArgs then
return false,tips
end
elseif conditionType==unlockCondType.build then
local buildid
local num
if type(condArgs)=="number"then
buildid=condArgs
num=1
else
buildid,num=unpack(condArgs)
end
local buildNum=zongmenModel:getBuildNum3(buildid)
if buildNum<num then
return false,tips
end
elseif conditionType==unlockCondType.xianmeng then
local has=xianmengModel:hasXM()
if not has then
return false,tips
end
elseif conditionType==unlockCondType.kfDay then
local kfDays=timeHelper.getServerOpenDay()
if kfDays<condArgs then
return false,tips
end
elseif conditionType==unlockCondType.zmOrder then
local isActive=guildOrderModel:checkOrderActive(condArgs)
if not isActive then
return false,tips
end
elseif conditionType==unlockCondType.wxsd then
local isActive=UIFullTotalTouZiActivityontrol:checkWindowWXSDOpen()
if not isActive then
return false,tips
end
elseif conditionType==unlockCondType.platform then
local pfid=loginModel:getPfid()
if not condArgs[pfid]then
return false,tips
end
elseif conditionType==unlockCondType.notPlatform then
local pfid=loginModel:getPfid()
if condArgs[pfid]then
return false,tips
end
elseif conditionType==unlockCondType.systemOpen then
local sysid=condArgs
if not systemModel.isOpen(sysid)then
return false,tips
end
elseif conditionType==unlockCondType.systemNotOpen then
local sysid=condArgs
if systemModel.isOpen(sysid)then
return false,tips
end
end
end
return true
end

function xiaoZhuShouModel:addDetailData(detailId,args)
if not UIManager:isActive("UIXiaoZhuShouWin")then
loggerUtil.logErrFMT("xzs detail UIXiaoZhuShouWin not active detailId:{0}",detailId)
return
end
if not cfg_xiaozhushoudetailconfig_get(detailId)then
loggerUtil.logErrFMT("xzs detail not cfg detailId:{0}",detailId)
return
end
args=args or{}
args.detailId=detailId
self.detailDatas[detailId]={detailId=detailId,args=args}
UIManager:callWindowFunc("UIXiaoZhuShouWin","createDetail",detailId,args)
end

function xiaoZhuShouModel:bindDetailLuaId(detailId,luaid)
if not self.detailDatas[detailId]then
return
end
self.detailDatas[detailId].luaid=luaid
end

function xiaoZhuShouModel:callDetailFunc(detailId,func,...)
if not UIManager:isActive("UIXiaoZhuShouWin")then
loggerUtil.logErrFMT("xzs detail UIXiaoZhuShouWin not active detailId:{0}",detailId)
return
end
if not self.detailDatas[detailId]then
loggerUtil.logErrFMT("xzs detailDatas not data detailId:{0}",detailId)
return
end
local luaid=self.detailDatas[detailId].luaid
if not luaid then
loggerUtil.logErrFMT("xzs detailDatas not luaid detailId:{0}",detailId)
return
end
UIManager:callWindowFunc("UIXiaoZhuShouWin","callDetailFunc",luaid,func,...)
end

function xiaoZhuShouModel:getDetailData(detailId)
return self.detailDatas[detailId]
end

function xiaoZhuShouModel:changeDetailDataArgs(detailId,args)
if not self.detailDatas[detailId]then
loggerUtil.logErrFMT("xzs detailDatas not data detailId:{0}",detailId)
return
end
local data=self.detailDatas[detailId].args or{}
for key,val in pairs(args)do
data[key]=val
end
self.detailDatas[detailId].args=data
end

function xiaoZhuShouModel:getDetailDataArgs(detailId)
if not self.detailDatas[detailId]then
loggerUtil.logErrFMT("xzs detailDatas not data detailId:{0}",detailId)
return
end
return self.detailDatas[detailId].args or{}
end

function xiaoZhuShouModel:clearDetailData()
self.detailDatas={}
end

function xiaoZhuShouModel:addReportData(detailId,desc)
if self.reportDatasLookup[detailId]then
return
end
if not UIManager:isActive("UIXiaoZhuShouWin")then
loggerUtil.logErrFMT("xzs report UIXiaoZhuShouWin not active detailId:{0}",detailId)
return
end
if not cfg_xiaozhushoudetailconfig_get(detailId)then
loggerUtil.logErrFMT("xzs report not cfg detailId:{0}",detailId)
return
end
table.insert(self.reportDatas,{detailId=detailId,desc=desc})
self.reportDatasLookup[detailId]=#self.reportDatas
end

function xiaoZhuShouModel:getReportData()
return self.reportDatas
end

function xiaoZhuShouModel:checkReportReddot()
local reportData=xiaoZhuShouModel:getReportData()
if reportData and#reportData>0 then
return true
end
return false
end

function xiaoZhuShouModel:removeReportData(index)
if self.reportDatas and#self.reportDatas>=index then
local len=#self.reportDatas
table.remove(self.reportDatas,index)
if len<=1 then
UIManager:invokeUIMethod("UIXiaoZhuShouWin","refreshReportReddot")
end
end
end

function xiaoZhuShouModel:clearReportData()
self.reportDatas={}
self.reportDatasLookup={}
UIManager:invokeUIMethod("UIXiaoZhuShouWin","refreshReportReddot")
end

function xiaoZhuShouModel:getReddotNum()
if not xiaoZhuShouController:checkXiaoZhuShouOpen()then
return 0
end
local num=0
if not dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXZSTips)then
num=num+1
end
if xiaoZhuShouModel:checkReportReddot()then
num=num+1
end
return num
end
