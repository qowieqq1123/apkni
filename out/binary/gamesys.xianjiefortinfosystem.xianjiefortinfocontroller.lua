







local _MODULENAME="xianJieFortInfoController"
gameState.addListener(def_table(_MODULENAME))
xianJieFortInfoController.name=_MODULENAME

fortInfoType={
eBuild=1,
eRepair=2,
eYunZhou=3,
eYunJiaYing=4,
eYuLingZhai=5,
eLunHuiDian=6,
eTianShuDaZhen=7,
eXianBangTask=8,
eTaiXuCang=9,
eYanDaoTai=10,
eLittleWorld=11,
eZaoWuGe=12,
eJuTianYi=13,
eTianShuDian=14,
eYingXianGe=15,
}

local fortInfoCfg={
[fortInfoType.eBuild]={
refreshInfo=function()
xianJieFortInfoController:refreshInfo_Build()
end,
getInfo=function()
return xianJieFortInfoController:getInfo_Build()
end,
jumpFunc=function()
isometricMapSystem:enterLayoutModel({model=layoutMode.eBuild})
end,
infoIcon="icon_baoleizhuangtailan_11",
},
[fortInfoType.eYunZhou]={
getInfo=function()
return xianJieFortInfoController:getInfo_YunZhou()
end,
jumpFunc=function(args)
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eXianYunGang)
if bdData then
if args then
args.entityId=bdData.entityId
UIFullXianYunGangControl:showMainWindow(args)
else
UIFullXianYunGangControl:showMainWindow(bdData)
end
else
local repairData=isometricMapSystem:getUnlockRepairDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eXianYunGang)
if repairData then
UIManager:showWindow('UIXianYunGangRepairWin',{1,repairData})
end
end
end,
infoIcon="icon_baoleizhuangtailan_1",
},
[fortInfoType.eYunJiaYing]={
getInfo=function()
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eYunJiaYing)
if not bdData or bdData.flag==buildingStateType.eBuilding then
return defaultT
end
return xianJieFortInfoController:getInfo_YunJiaYing()
end,
jumpFunc=function(args)
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eYunJiaYing)
if bdData then
if args then
args.entityId=bdData.entityId
UIFullYunJiaYingControl:showYunJiaYingWindow(args)
if args.openUpLevelPanel then
UIManager:showWindow("UIXJBuildingInfoWin",bdData)
end
else
UIFullYunJiaYingControl:showYunJiaYingWindow(bdData)
end
end
end,
infoIcon="icon_baoleizhuangtailan_2",
},
[fortInfoType.eYuLingZhai]={
getInfo=function()
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eYuLingZhai)
if not bdData or bdData.flag==buildingStateType.eBuilding then
return defaultT
end
return xianJieFortInfoController:getInfo_YuLingZhai()
end,
jumpFunc=function(args)
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eYuLingZhai)
if bdData then
UIFullYuLingZhaiControl:showMainWindow(bdData)
if args and args.openUpLevelPanel then
UIManager:showWindow("UIXJBuildingInfoWin",bdData)
end
end
end,
infoIcon="icon_baoleizhuangtailan_3",
},
[fortInfoType.eLunHuiDian]={
getInfo=function()
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eLunHuiDian)
if not bdData or bdData.flag==buildingStateType.eBuilding then
return defaultT
end
return xianJieFortInfoController:getInfo_LunHuiDian()
end,
jumpFunc=function()
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eLunHuiDian)
if bdData then
UIFullLunHuiDianControl:showMainWindow(bdData)
end
end,
infoIcon="icon_baoleizhuangtailan_4",
},
[fortInfoType.eTianShuDaZhen]={
getInfo=function()
local bdData=zongmenModel:findBuildingDataByType(mapIdType.fort,SLG_SYSTEM_TYPE.eXianYunGang)
if not bdData or bdData.flag==buildingStateType.eBuilding then
return defaultT
end
local list=XianYunGangModel:getBoatList()
if list==nil or#list==0 then
return defaultT
end
return xianJieFortInfoController:getInfo_TianShuDaZhen()
end,
jumpFunc=function(args)
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eTianShuDaZhen)
if bdData then
if args and args.openUpLevelPanel then
UIFullTianShuDaZhenControl:showMainWindow({type=1})
else
UIFullTianShuDaZhenControl:showMainWindow()
end
end
end,
infoIcon="icon_baoleizhuangtailan_5",
},
[fortInfoType.eXianBangTask]={
getInfo=function()
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eXianBang)
if not bdData or bdData.flag==buildingStateType.eBuilding then
return defaultT
end
return xianJieFortInfoController:getInfo_XianBangTask()
end,
jumpFunc=function()
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eXianBang)
if bdData then
UIFullXianBangControl:showXianBangWindow(bdData)
end
end,
infoIcon="icon_baoleizhuangtailan_7",
},
[fortInfoType.eTaiXuCang]={
getInfo=function()
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eTaiXuCang)
if not bdData or bdData.flag==buildingStateType.eBuilding then
return defaultT
end
return xianJieFortInfoController:getInfo_TaiXuCang()
end,
jumpFunc=function(args)
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eTaiXuCang)
if bdData then
UIFullTaiXuCangControl:showMainWindow(bdData)
if args and args.openUpLevelPanel then
UIManager:showWindow("UIXJBuildingInfoWin",bdData)
end
end
end,
infoIcon="icon_baoleizhuangtailan_6",
},
[fortInfoType.eYanDaoTai]={
getInfo=function()
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eYanDaoTai)
if not bdData or bdData.flag==buildingStateType.eBuilding then
return defaultT
end
return xianJieFortInfoController:getInfo_YanDaoTai()
end,
jumpFunc=function(args)
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eYanDaoTai)
if bdData then
UIFullYanDaoTaiControl:showMainWindow(bdData)
if args and args.openUpLevelPanel then
UIManager:showWindow("UIXJBuildingInfoWin",bdData)
end
end
end,
infoIcon="icon_baoleizhuangtailan_8",
},
[fortInfoType.eLittleWorld]={
getInfo=function()
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eLittleWorld)
if not bdData or bdData.flag==buildingStateType.eBuilding then
return defaultT
end
return xianJieFortInfoController:getInfo_LittleWorld()
end,
jumpFunc=function(args)
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eLittleWorld)
if bdData then
UIFullLittleWorldControl:showMainWindow(args)
end
end,
infoIcon="icon_baoleizhuangtailan_9",
},
[fortInfoType.eZaoWuGe]={
getInfo=function()
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eZaoWuGe)
if not bdData or bdData.flag==buildingStateType.eBuilding then
return defaultT
end
return xianJieFortInfoController:getInfo_ZaoWuGe()
end,
jumpFunc=function()
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eZaoWuGe)
if bdData then
UIFullZaoWuGeControl:showMainWindow(bdData)
end
end,
infoIcon="icon_baoleizhuangtailan_10",
},
[fortInfoType.eJuTianYi]={
getInfo=function()
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eJuTianYi)
if not bdData or bdData.flag==buildingStateType.eBuilding then
return defaultT
end
return xianJieFortInfoController:getInfo_JuTianYi()
end,
jumpFunc=function(args)
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eJuTianYi)
if bdData then
UIFullJuTianYiControl:showJuTianYiProduceWindow(bdData)
if args and args.openUpLevelPanel then
UIManager:showWindow("UIXJBuildingInfoWin",bdData)
end
end
end,
infoIcon="icon_baoleizhuangtailan_11",
},
[fortInfoType.eTianShuDian]={
getInfo=function()
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eTianShuDian)
if not bdData or bdData.flag==buildingStateType.eBuilding then
return defaultT
end
return xianJieFortInfoController:getInfo_TianShuDian()
end,
jumpFunc=function(args)
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eTianShuDian)
if bdData then
UIFullTianShuDianControl:showMainWindow(bdData)
if args and args.openUpLevelPanel then
UIManager:showWindow("UIXJTianShuDianBuildingInfoWin",bdData)
end
end
end,
infoIcon="icon_baoleizhuangtailan_11",
},
[fortInfoType.eYingXianGe]={
getInfo=function()
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eYingXianGe)
if not bdData or bdData.flag==buildingStateType.eBuilding then
return defaultT
end
return xianJieFortInfoController:getInfo_YingXianGe()
end,
jumpFunc=function(args)
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eYingXianGe)
if bdData then
UIFullYingXianGeControl:showYingXianGeWindow(bdData)
if args and args.openUpLevelPanel then
UIManager:showWindow("UIXJBuildingInfoWin",bdData)
end
end
end,
infoIcon="icon_baoleizhuangtailan_11",
},
}


function xianJieFortInfoController:onEnterState(isReconnect)
notifySystem:listenNotify(notifyConfig.onMountainChange,self.onMountainChange)
notifySystem:listenNotify(notifyConfig.onTaskChange,self.onTaskChange)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
end

function xianJieFortInfoController:onLeaveState(isReconnect)
notifySystem:removelistener(notifyConfig.onMountainChange,self.onMountainChange)
notifySystem:removelistener(notifyConfig.onTaskChange,self.onTaskChange)
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
end


function xianJieFortInfoController.onMountainChange(old_sfId,sfId)
if sfId==mapIdType.fort then
for _,infoType in pairs(fortInfoType)do
local cfg=fortInfoCfg[infoType]
if cfg and cfg.refreshInfo then
cfg.refreshInfo()
end
end
end
end


function xianJieFortInfoController.onTaskChange(taskid,taskstate)
if taskstate==taskModel.taskFinishState or taskstate==taskModel.taskRewardState then
UIManager:invokeUIMethod("UIXianJieFortTaskbarWin","leftPanel_refrshTaskReddot")
end
end


function xianJieFortInfoController.on_building_event(etype,sfId,ubdId,build_id)
if sfId==mapIdType.fort then
if etype==buildingEvent.buildStart or etype==buildingEvent.buildComplete then
xianJieFortInfoController:refreshInfo_Build()
xianJieFortInfoController:refreshAllInfo()
elseif etype==buildingEvent.levelUpStart or etype==buildingEvent.levelUpComplete then
xianJieFortInfoController:refreshInfo_Build()
xianJieFortInfoController:refreshAllInfo()
end
end
end

function xianJieFortInfoController:refreshAllInfo()
UIManager:invokeUIMethod("UIXianJieFortInfoWin","onShowArgRecv")
end

function xianJieFortInfoController:getAllInfo()
self.fortInfoReddot=false
local temp={}
for _,infoType in pairs(fortInfoType)do
local cfg=fortInfoCfg[infoType]
if cfg and cfg.getInfo then
local infoArgs=cfg.getInfo()
if infoArgs then
for _,info in ipairs(infoArgs)do
if info.showReddot then
self.fortInfoReddot=true
end
table.insert(temp,info)
end
end
end
end
UIManager:invokeUIMethod("UIXianJieFortTaskbarWin","leftPanel_refrshFortReddot")
if#temp>1 then
table.sort(temp,function(a,b)
return a.sortVal<b.sortVal
end)
end
return temp
end

function xianJieFortInfoController:getInfoReddot()
return self.fortInfoReddot==true
end

function xianJieFortInfoController:jumpInfo(type,args)
local cfg=fortInfoCfg[type]
if cfg and cfg.jumpFunc then
cfg.jumpFunc(args)
end
end

function xianJieFortInfoController:getInfoIcon(type)
local cfg=fortInfoCfg[type]
if cfg then
return cfg.infoIcon
end
end

local function isBuildingUnlock(cfg)
local needSys=cfg.build_system
if needSys and not systemModel.isOpen(needSys)then
return false
end

local levelCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,cfg.id,1)
local check=zongmenControl:checkCondition(levelCfg,false)
return check
end

function xianJieFortInfoController:refreshInfo_Build()
self.catchBuild={}
local cfgs=cfg_monijybuildconfig()
local level=zongmenModel:getLevel()
local sfId=mapIdType.fort
for k,v in pairs(cfgs)do
if level>=v.show_level and v.buildTab==2 and(not v.mountain or v.mountain[sfId])then
local cur=zongmenModel:getBuildingCount(v.id,sfId)
local max=zongmenModel:getBuildingMaxNum(v.id,sfId)
local isfull=max>0 and cur>=max
if not isfull and isBuildingUnlock(v)then
table.insert(self.catchBuild,v.id)
end
end
end
end

function xianJieFortInfoController:getInfo_Build()
local temp={}
if self.catchBuild and#self.catchBuild>0 then
local len=#self.catchBuild
local args={type=fortInfoType.eBuild}
if len>1 then
args.name="<color=#aae252>可建造新建筑</color>"
elseif len>0 then
local build_id=self.catchBuild[1]
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,build_id)
args.name=string.format("<color=#aae252>可建造%s</color>",cfg.name)
end
args.sortVal=1000+fortInfoType.eBuild
table.insert(temp,args)
end
return temp
end

function xianJieFortInfoController:getInfo_YunZhou()
local temp={}
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eXianYunGang)
if not bdData then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,SLG_SYSTEM_TYPE.eXianYunGang)
local isOpen=XianYunGangModel:checkRepairBuildOpen(cfg)
if isOpen then
local canBuild=isometricMapSystem:checkRepairCost(cfg)
local args={type=fortInfoType.eYunZhou,name=canBuild and"<color=#aae252>可建造仙云港</color>"or"可建造仙云港"}
args.jumpAttach={repair=true}
args.sortVal=2000+fortInfoType.eYunZhou
table.insert(temp,args)
end
return temp
end
if bdData and bdData.flag==buildingStateType.eBuilding then
return temp
end
local cfgs=cfg_fairylandboatconfig()
local sfId=mapIdType.fort
for i,v in ipairs(cfgs)do
local build_id=v.build_id
local _data=isometricMapSystem:getRepairDataByID(sfId,build_id)
if _data then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,build_id)
local isOpen=XianYunGangModel:checkRepairBuildOpen(cfg)
if isOpen then
local canBuild=isometricMapSystem:checkRepairCost(cfg)
local args={type=fortInfoType.eYunZhou,name=canBuild and"<color=#aae252>可建造云舟</color>"or"可建造云舟"}
args.jumpAttach={build_id=build_id}
args.sortVal=2000+fortInfoType.eYunZhou
table.insert(temp,args)
break
end
else
local bdData=zongmenModel:findBuildingDataByID(sfId,build_id)
if bdData and bdData.flag==buildingStateType.eBuilding then
local cddata=buildingCDControl:getCDData(buildingCDType.build,bdData.un_build_id)
local args
if cddata.complete then
args={type=fortInfoType.eYunZhou,name="<color=#aae252>云舟建造完成</color>",completeBtn=true}
args.sortVal=1000+fortInfoType.eYunZhou
else
args={type=fortInfoType.eYunZhou,name="<color=#f1ce78>云舟建造中</color>",sTime=cddata.beginTime,eTime=cddata.beginTime+cddata.ntime}
args.sortVal=3000+fortInfoType.eYunZhou
end
args.jumpAttach={build_id=build_id}
table.insert(temp,args)
end
end
end
return temp
end

function xianJieFortInfoController:getInfo_YunJiaYing()
local temp={}
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eYunJiaYing)
if bdData.flag==buildingStateType.eUpgrading then
local cddata=buildingCDControl:getCDData(buildingCDType.build,bdData.un_build_id)
local build_name=cfgHelper.get2(cfg_monijybuildconfig_get,SLG_SYSTEM_TYPE.eYunJiaYing,"name")
if cddata.complete then
local args={type=fortInfoType.eYunJiaYing,name=string.format("<color=#aae252>%s升级完成</color>",build_name),completeBtn=true}
args.sortVal=1000+fortInfoType.eYunJiaYing
args.jumpAttach={openUpLevelPanel=true}
args.infoIcon='icon_baoleizhuangtailan_11'
table.insert(temp,args)
else
local starTime=cddata.beginTime
local endTime=starTime+cddata.ntime
local args={type=fortInfoType.eYunJiaYing,name=string.format("<color=#f1ce78>%s升级中</color>",build_name),sTime=starTime,eTime=endTime}
args.sortVal=3000+fortInfoType.eYunJiaYing
args.jumpAttach={openUpLevelPanel=true}
args.infoIcon='icon_baoleizhuangtailan_11'
table.insert(temp,args)
end
end
if yunjiayingModel:getAllTrainLeftTime()>0 then
local trainList=yunjiayingModel:getTrainList()
local startTime,finalFinishTime=yunjiayingModel:getTrainingDataTimeByIdx(#trainList)
local args={type=fortInfoType.eYunJiaYing,name="<color=#f1ce78>训练修士中</color>",sTime=startTime,eTime=finalFinishTime}
args.sortVal=3000+fortInfoType.eYunJiaYing
table.insert(temp,args)
return temp
end
if yunjiayingModel:checkYunJiaYingBdAllFinishReddot()then
local args={type=fortInfoType.eYunJiaYing,name="<color=#aae252>修士训练完成</color>",completeBtn=true}
args.sortVal=1000+fortInfoType.eYunJiaYing
args.showReddot=true
table.insert(temp,args)
return temp
end

local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eYunJiaYing)
local freeCount=yunjiayingModel:getFreeTrainCount()
local remainingCount=yunjiayingModel:getRemainingCanMakeSoldierCount()
if bdData.flag~=buildingStateType.eUpgrading and freeCount>0 and remainingCount>0 then
local levelCfgList=cfg_fairylandsoldierconfig()
local maxLevel=0
local buildLv=zongmenModel:getBuildingLevel(mapIdType.fort,SLG_SYSTEM_TYPE.eYunJiaYing)
local buildCfg=cfgHelper.get(cfg_yunjiayingconfig_get,buildLv)
local timeList=buildCfg.duration
for id,v in ipairs(levelCfgList)do
if not v.isHide and timeList[id]~=nil then
maxLevel=id
end
end
for lv=maxLevel,1,-1 do
local xsjNum=yunjiayingModel:getXiuShiNumById(lv)
if xsjNum>0 then
local args={type=fortInfoType.eYunJiaYing,name="<color=#aae252>可训练修士</color>"}
args.sortVal=2000+fortInfoType.eYunJiaYing
args.jumpAttach={selectLevelIdx=lv}
table.insert(temp,args)
return temp
end
end
end
return temp
end

function xianJieFortInfoController:getInfo_YuLingZhai()
local temp={}
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eYuLingZhai)
if bdData.flag==buildingStateType.eUpgrading then
local cddata=buildingCDControl:getCDData(buildingCDType.build,bdData.un_build_id)
local build_name=cfgHelper.get2(cfg_monijybuildconfig_get,SLG_SYSTEM_TYPE.eYuLingZhai,"name")
if cddata.complete then
local args={type=fortInfoType.eYuLingZhai,name=string.format("<color=#aae252>%s升级完成</color>",build_name),completeBtn=true}
args.sortVal=1000+fortInfoType.eYuLingZhai
args.jumpAttach={openUpLevelPanel=true}
args.infoIcon='icon_baoleizhuangtailan_11'
table.insert(temp,args)
else
local starTime=cddata.beginTime
local endTime=starTime+cddata.ntime
local args={type=fortInfoType.eYuLingZhai,name=string.format("<color=#f1ce78>%s升级中</color>",build_name),sTime=starTime,eTime=endTime}
args.sortVal=3000+fortInfoType.eYuLingZhai
args.jumpAttach={openUpLevelPanel=true}
args.infoIcon='icon_baoleizhuangtailan_11'
table.insert(temp,args)
end
end
local state=YuLingZhaiModel:getHealType()
if state==YLZ_HEAL_TYPE.eFast then
local startTime=YuLingZhaiModel:getHealStartTime()
local endStamp=YuLingZhaiModel:getEndStamp()
local now=timeHelper.getServerShortTime()
local left=endStamp-now
if left>0 then
local args={type=fortInfoType.eYuLingZhai,name="<color=#f1ce78>治疗修士中</color>",sTime=startTime,eTime=endStamp}
args.sortVal=3000+fortInfoType.eYuLingZhai
table.insert(temp,args)
return temp
end
end
local totalTreatCount=xianjieModel:getSoldierAllHurtNum(xjSoldierHurtType.eSeriousInjury)
if totalTreatCount>0 then
local args={type=fortInfoType.eYuLingZhai,name="<color=#f36666>修士受到重伤</color>"}
args.sortVal=2000+fortInfoType.eYuLingZhai
table.insert(temp,args)
return temp
end
return temp
end

function xianJieFortInfoController:getInfo_LunHuiDian()
local temp={}
local datas=zongmenModel:getBuildingDataByBdType(mapIdType.fort,SLG_SYSTEM_TYPE.eLunHuiDian)
if#datas<=0 then
return temp
end
local totalZhaoHunCount=LunHuiDianModel:getLeastCanRecruit()
if totalZhaoHunCount>0 then
local args={type=fortInfoType.eLunHuiDian,name="招回修士魂魄"}
args.sortVal=2000+fortInfoType.eLunHuiDian
table.insert(temp,args)
end
return temp
end

function xianJieFortInfoController:getInfo_TianShuDaZhen()
local temp={}
local level=tianshudazhenModel:getLevel()
if level==0 then return temp end
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eTianShuDaZhen)
if bdData.flag==buildingStateType.eUpgrading then
local cddata=buildingCDControl:getCDData(buildingCDType.build,bdData.un_build_id)
local build_name=cfgHelper.get2(cfg_monijybuildconfig_get,SLG_SYSTEM_TYPE.eTianShuDaZhen,"name")
if cddata.complete then
local args={type=fortInfoType.eTianShuDaZhen,name=string.format("<color=#aae252>%s升级完成</color>",build_name),completeBtn=true}
args.sortVal=1000+fortInfoType.eTianShuDaZhen
args.jumpAttach={openUpLevelPanel=true}
args.infoIcon='icon_baoleizhuangtailan_11'
table.insert(temp,args)
else
local starTime=cddata.beginTime
local endTime=starTime+cddata.ntime
local args={type=fortInfoType.eTianShuDaZhen,name=string.format("<color=#f1ce78>%s升级中</color>",build_name),sTime=starTime,eTime=endTime}
args.sortVal=3000+fortInfoType.eTianShuDaZhen
args.jumpAttach={openUpLevelPanel=true}
args.infoIcon='icon_baoleizhuangtailan_11'
table.insert(temp,args)
end
end
if not tianshudazhenModel:isMaxHDZ()then
local args={type=fortInfoType.eTianShuDaZhen,name="<color=#f36666>大阵遭到破坏</color>"}
args.sortVal=1000+fortInfoType.eTianShuDaZhen
table.insert(temp,args)
end
return temp
end

function xianJieFortInfoController:getInfo_XianBangTask()
local temp={}
local taskData=xianjiexianbangModel:getXBTaskData()
local len=#taskData
if taskData and len>0 then
local max=len
local cur=0
for k,v in ipairs(taskData)do
if v.finishFlag==1 then
cur=cur+1
end
end
local rewardBox=cur>0
local args={type=fortInfoType.eXianBangTask,name="仙榜任务",progress={cur,max},rewardBox=rewardBox}
args.sortVal=(rewardBox and 1000 or 2000)+fortInfoType.eXianBangTask
if rewardBox then
args.showReddot=true
end
table.insert(temp,args)
end
return temp
end

function xianJieFortInfoController:getInfo_TaiXuCang()
local temp={}
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eTaiXuCang)
if bdData.flag==buildingStateType.eUpgrading then
local cddata=buildingCDControl:getCDData(buildingCDType.build,bdData.un_build_id)
local build_name=cfgHelper.get2(cfg_monijybuildconfig_get,SLG_SYSTEM_TYPE.eTaiXuCang,"name")
if cddata.complete then
local args={type=fortInfoType.eTaiXuCang,name=string.format("<color=#aae252>%s升级完成</color>",build_name),completeBtn=true}
args.sortVal=1000+fortInfoType.eTaiXuCang
args.jumpAttach={openUpLevelPanel=true}
args.infoIcon='icon_baoleizhuangtailan_11'
table.insert(temp,args)
else
local starTime=cddata.beginTime
local endTime=starTime+cddata.ntime
local args={type=fortInfoType.eTaiXuCang,name=string.format("<color=#f1ce78>%s升级中</color>",build_name),sTime=starTime,eTime=endTime}
args.sortVal=3000+fortInfoType.eTaiXuCang
args.jumpAttach={openUpLevelPanel=true}
args.infoIcon='icon_baoleizhuangtailan_11'
table.insert(temp,args)
end
end
local max=TaiXuCangModel:getMax()
local cur=TaiXuCangModel:getNum()
local rewardBox=cur>0
local name=cur>=max and string.format("仙宫军备：<color=#f36666>%d/%d</color>",cur,max)or string.format("军备存储：%d/%d",cur,max)
local args={type=fortInfoType.eTaiXuCang,name=name,rewardBox=rewardBox}
args.sortVal=(rewardBox and 1000 or 3000)+fortInfoType.eTaiXuCang
if rewardBox then
args.showReddot=true
end
if cur<max then
local left=TaiXuCangModel:getLeftTime()
if left>0 then
local interval=TaiXuCangModel:getInterval()
local sTime=TaiXuCangModel:getLastStamp()+cur*interval
local eTime=sTime+interval
args.sTime=sTime
args.eTime=eTime
end
else
args.desc="<color=#aae252>太虚仓已满</color>"
end
table.insert(temp,args)
return temp
end

function xianJieFortInfoController:getInfo_YanDaoTai()
local temp={}
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eYanDaoTai)
if bdData.flag==buildingStateType.eUpgrading then
local cddata=buildingCDControl:getCDData(buildingCDType.build,bdData.un_build_id)
local build_name=cfgHelper.get2(cfg_monijybuildconfig_get,SLG_SYSTEM_TYPE.eYanDaoTai,"name")
if cddata.complete then
local args={type=fortInfoType.eYanDaoTai,name=string.format("<color=#aae252>%s升级完成</color>",build_name),completeBtn=true}
args.sortVal=1000+fortInfoType.eYanDaoTai
args.jumpAttach={openUpLevelPanel=true}
args.infoIcon='icon_baoleizhuangtailan_11'
table.insert(temp,args)
else
local starTime=cddata.beginTime
local endTime=starTime+cddata.ntime
local args={type=fortInfoType.eYanDaoTai,name=string.format("<color=#f1ce78>%s升级中</color>",build_name),sTime=starTime,eTime=endTime}
args.sortVal=3000+fortInfoType.eYanDaoTai
args.jumpAttach={openUpLevelPanel=true}
args.infoIcon='icon_baoleizhuangtailan_11'
table.insert(temp,args)
end
return temp
end
local studyList=yandaotaiModel:getStudyList()
if studyList and studyList.id and studyList.starTime then
local id=studyList.id
local level=yandaotaiModel:getTechnologyListLevel(id)or 1
local cfg=cfgHelper.get2(cfg_technologyconfig_get,id,level+1)
local value2=DianFengLevelModel:getDFXianBaoBuildPercent(3)
local study_time=yandaotaiController.getchangeSpeed(cfg.study_time,value2)
local flag=yandaotaiModel:checkStudyisFinishTime(id,study_time)
if flag then
local args={type=fortInfoType.eYanDaoTai,name="<color=#aae252>传承研究完成</color>",completeBtn=true}
args.sortVal=1000+fortInfoType.eYanDaoTai
table.insert(temp,args)
else
local endTime=study_time+studyList.starTime
local args={type=fortInfoType.eYanDaoTai,name="<color=#f1ce78>研究传承中</color>",sTime=studyList.starTime,eTime=endTime}
args.sortVal=3000+fortInfoType.eYanDaoTai
table.insert(temp,args)
end
return temp
end

local config=cfg_technologyconfig()
local len=#config
for i=1,len do
local time=yandaotaiModel:getStudyListTime(i)
if not time then
local level,limitLevel,maxLevel,isMaxLevel=yandaotaiModel:isMaxLevel(i)
if not isMaxLevel then
local cfg=config[i][level+1]
local flag=yandaotaiModel:checkIsEnoughUpLevel(cfg.unlock_condition)
local isFull=isMaxLevel or level>=limitLevel
if flag and not isFull then
local args={type=fortInfoType.eYanDaoTai,name="可研究传承"}
args.sortVal=2000+fortInfoType.eYanDaoTai
table.insert(temp,args)
return temp
end
end
end
end
return temp
end

function xianJieFortInfoController:getInfo_LittleWorld()
local temp={}
local datas=zongmenModel:getBuildingDataByBdType(mapIdType.fort,SLG_SYSTEM_TYPE.eLittleWorld)
if#datas<=0 then
return temp
end
if LittleWorldModel:canGetReward()then
local args={type=fortInfoType.eLittleWorld,name="<color=#aae252>小世界可领取物资</color>",rewardBox=true}
args.sortVal=1000+fortInfoType.eLittleWorld
args.showReddot=true
table.insert(temp,args)
end
local lv=LittleWorldModel:getLittleWorldLevel()
local max=LittleWorldModel.getXiaoHuoValMax(lv)
if LittleWorldModel:getLittleWorldXianghuo()>=max then
local args={type=fortInfoType.eLittleWorld,name="<color=#aae252>小世界香火值已满</color>",jumpAttach={openFaLing=true}}
local numStr=mathHelper.formatNumber4(max,2)
args.desc=string.format("<color=#f36666>%s/%s</color>",numStr,numStr)
args.sortVal=1000+fortInfoType.eLittleWorld
table.insert(temp,args)
end
return temp
end

function xianJieFortInfoController:getInfo_ZaoWuGe()
local temp={}
local datas=zongmenModel:getBuildingDataByBdType(mapIdType.fort,SLG_SYSTEM_TYPE.eZaoWuGe)
if#datas<=0 then
return temp
end
if zaoWuGeController:checkInBuild()then
return temp
end
if zaoWuGeController:checkCanBuildAnyOne()then
local args={type=fortInfoType.eZaoWuGe,name="可前往打造阵器"}
args.sortVal=2000+fortInfoType.eZaoWuGe
table.insert(temp,args)
end
return temp
end

function xianJieFortInfoController:getInfo_JuTianYi()
local temp={}
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eJuTianYi)
if bdData.flag==buildingStateType.eUpgrading then
local cddata=buildingCDControl:getCDData(buildingCDType.build,bdData.un_build_id)
local build_name=cfgHelper.get2(cfg_monijybuildconfig_get,SLG_SYSTEM_TYPE.eJuTianYi,"name")
if cddata.complete then
local args={type=fortInfoType.eJuTianYi,name=string.format("<color=#aae252>%s升级完成</color>",build_name),completeBtn=true}
args.sortVal=1000+fortInfoType.eJuTianYi
args.jumpAttach={openUpLevelPanel=true}
args.infoIcon='icon_baoleizhuangtailan_11'
table.insert(temp,args)
else
local starTime=cddata.beginTime
local endTime=starTime+cddata.ntime
local args={type=fortInfoType.eJuTianYi,name=string.format("<color=#f1ce78>%s升级中</color>",build_name),sTime=starTime,eTime=endTime}
args.sortVal=3000+fortInfoType.eJuTianYi
args.jumpAttach={openUpLevelPanel=true}
args.infoIcon='icon_baoleizhuangtailan_11'
table.insert(temp,args)
end
end
return temp
end

function xianJieFortInfoController:getInfo_TianShuDian()
local temp={}
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eTianShuDian)
if bdData.flag==buildingStateType.eUpgrading then
local cddata=buildingCDControl:getCDData(buildingCDType.build,bdData.un_build_id)
local build_name=cfgHelper.get2(cfg_monijybuildconfig_get,SLG_SYSTEM_TYPE.eTianShuDian,"name")
if cddata.complete then
local args={type=fortInfoType.eTianShuDian,name=string.format("<color=#aae252>%s升级完成</color>",build_name),completeBtn=true}
args.sortVal=1000+fortInfoType.eTianShuDian
args.jumpAttach={openUpLevelPanel=true}
args.infoIcon='icon_baoleizhuangtailan_11'
table.insert(temp,args)
else
local starTime=cddata.beginTime
local endTime=starTime+cddata.ntime
local args={type=fortInfoType.eTianShuDian,name=string.format("<color=#f1ce78>%s升级中</color>",build_name),sTime=starTime,eTime=endTime}
args.sortVal=3000+fortInfoType.eTianShuDian
args.jumpAttach={openUpLevelPanel=true}
args.infoIcon='icon_baoleizhuangtailan_11'
table.insert(temp,args)
end
end
return temp
end

function xianJieFortInfoController:getInfo_YingXianGe()
local temp={}
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,SLG_SYSTEM_TYPE.eYingXianGe)
if bdData.flag==buildingStateType.eUpgrading then
local cddata=buildingCDControl:getCDData(buildingCDType.build,bdData.un_build_id)
local build_name=cfgHelper.get2(cfg_monijybuildconfig_get,SLG_SYSTEM_TYPE.eYingXianGe,"name")
if cddata.complete then
local args={type=fortInfoType.eYingXianGe,name=string.format("<color=#aae252>%s升级完成</color>",build_name),completeBtn=true}
args.sortVal=1000+fortInfoType.eYingXianGe
args.jumpAttach={openUpLevelPanel=true}
args.infoIcon='icon_baoleizhuangtailan_11'
table.insert(temp,args)
else
local starTime=cddata.beginTime
local endTime=starTime+cddata.ntime
local args={type=fortInfoType.eYingXianGe,name=string.format("<color=#f1ce78>%s升级中</color>",build_name),sTime=starTime,eTime=endTime}
args.sortVal=3000+fortInfoType.eYingXianGe
args.jumpAttach={openUpLevelPanel=true}
args.infoIcon='icon_baoleizhuangtailan_11'
table.insert(temp,args)
end
end
return temp
end