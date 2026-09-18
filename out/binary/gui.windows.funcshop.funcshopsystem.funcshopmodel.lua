






local _MODULENAME="funcShopModel"




def_table(_MODULENAME)
funcShopModel.name=_MODULENAME

funcShopModel.data={}

eFuncShopLimitType=
{
eSeason=1,
eForever=2,
eMonth=3,
eWeek=4,
eDay=5,
ePeriod=6,
}

eFuncShopType=
{
eDouFaTai=1,
eXianMeng=2,
eLunDao=3,
eXianFaLunDao=4,
eYiYuHuiYou=5,
eLingCui=6,
eZhanGong=7,
eXuYuan=8,
eshanhaishop=12,
eQiYuan=13,
eXianZhan_DaoJu=14,
eXianZhan_GuBao=15,
eXianZhan_SheJiTu=16,
eWenDingCangQiong=17,
eXianJieBaoKu=18,
eXianGongChaoGong=19,
eWanLingBaoKu=20,
eMojieSaiJi=21,
eLingShouShop=22,
}

funcShopUnlockType=
{
eZongMenLevel=1,
eSystem=2,
eXianMengLevel=3,
eXianFaLunDao=4,
eXianMengDuanWei=5,
eXianMengZhanSaiJi=6,
eXianZhiLevel=7,
eWanLingTaLevel=8,
eQiYanShuLib_id=9,
eTimeLimit=10,
ePlatformLimit=11,
eMoJieJieDuan=12,
eMojieSaiJiID=13,
}

local getUnlockProgress={
[funcShopUnlockType.eZongMenLevel]=function(args)
local zmLevel=zongmenModel:getLevel()
if args[3]then
return zmLevel,FMT.fmt("{0~{1}",args[2],args[3])
else
return zmLevel,args[2]
end
end,
[funcShopUnlockType.eSystem]=function(args)
local temp=systemModel.isOpen(args[2])and 1 or 0
return temp,1
end,
[funcShopUnlockType.eXianMengLevel]=function(args)
local xmLv=xianmengModel:getXMLevel()or 0
return xmLv,args[2]
end,
[funcShopUnlockType.eXianMengDuanWei]=function(args)
local level=lingxuwenjianModel:getScoreLevel()
return level,args[2]
end,
[funcShopUnlockType.eXianMengZhanSaiJi]=function(args,shopId)
if shopId==eFuncShopType.eMojieSaiJi then
local raceIndex=lingxuwenjianModel:getRaceIndex()
if args[3]then
return raceIndex,FMT.fmt("{0}~{1}",args[2],args[3])
else
return raceIndex,args[2]
end
else
local raceIndex=lingxuwenjianModel:getRaceIndex()
if args[3]then
return raceIndex,FMT.fmt("{0}~{1}",args[2],args[3])
else
return raceIndex,args[2]
end
end
end,
[funcShopUnlockType.eXianZhiLevel]=function(args)
local lv=xianzhiController.getXianZhiChongTian()or 0
return lv,args[2]
end,
}

local checkUnLockFunc=
{

[funcShopUnlockType.eZongMenLevel]=function(args)
local zmLevel=zongmenModel:getLevel()
if args[3]then
return args[2]<=zmLevel and args[3]>=zmLevel
else
return args[2]<=zmLevel
end

end,

[funcShopUnlockType.eSystem]=function(args)
return systemModel.isOpen(args[2])
end,

[funcShopUnlockType.eXianMengLevel]=function(args)
return args[2]<=(xianmengModel:getXMLevel()or 0)
end,

[funcShopUnlockType.eXianMengDuanWei]=function(args)

local level=lingxuwenjianModel:getScoreLevel()

return args[2]<=level
end,

[funcShopUnlockType.eXianMengZhanSaiJi]=function(args,shopId)
if shopId==eFuncShopType.eMojieSaiJi then
local raceIndex=xianjieController:getMoJieSaiJiID()
if args[3]then
return args[2]<=raceIndex and args[3]>=raceIndex
else
return args[2]==raceIndex
end
else
local raceIndex=lingxuwenjianModel:getRaceIndex()
if args[3]then
return args[2]<=raceIndex and args[3]>=raceIndex
else
return args[2]==raceIndex
end
end
end,

[funcShopUnlockType.eXianZhiLevel]=function(args)
local lv=xianzhiController.getXianZhiChongTian()or 0
return lv>=args[2]
end,

[funcShopUnlockType.eWanLingTaLevel]=function(args)
local lv=wanLingTaModel:getTaLingLevel()or 0
return lv>=args[2]
end,

[funcShopUnlockType.eQiYanShuLib_id]=function(args)
local lib_id=qiYuanShuModel:getQiYuanShuId()
return lib_id==args[2]
end,

[funcShopUnlockType.eMoJieJieDuan]=function(args,shopId)
if shopId==eFuncShopType.eMojieSaiJi then
local endtime=xianjieController:getMoJieSaiJieTime()
if endtime then
local curTime=timeHelper.getServerShortTime()
local const_def=cfgHelper.getdef(cfg_devildomshopconfig)
local duration=const_def.duration

if curTime<endtime then
local csid=xianjieModel:getMoJieEnterConfig("csid")
if csid and seasonController:checkSeasonStageBegined(csid,args[2])then
return true
end
else
if curTime<endtime+duration then
local csid=xianjieModel:getMoJieEnterConfig("csid")
if csid and seasonController:checkSeasonStageBegined(csid,args[2])then
return true
end

end
end
end
return false
end
end,

[funcShopUnlockType.eMojieSaiJiID]=function(args,shopId)
if shopId==eFuncShopType.eMojieSaiJi then
local seasonId=xianjieController:getMoJieSaiJiWanFaID()
if seasonId then
local temp=args[2]
if temp and temp[seasonId]then
return true
end
end
return false
end
end,
}

local getUnLockTips=
{

[funcShopUnlockType.eZongMenLevel]=function(args)
return FMT.fmt('宗门{0}级解锁',args[2])
end,

[funcShopUnlockType.eSystem]=function(args)
local name=systemConfig.getSystemName(args[2])
return FMT.fmt('{0}开放解锁',name)
end,

[funcShopUnlockType.eXianMengLevel]=function(args)
return FMT.fmt('仙盟{0}级解锁',args[2])
end,

[funcShopUnlockType.eXianMengDuanWei]=function(args)
local name=cfgHelper.get(cfg_lingxuwenjianlevelconfig_get,args[2],"name")
return FMT.fmt('{0}解锁',name)
end,

[funcShopUnlockType.eXianZhiLevel]=function(args)
return FMT.fmt('仙职·{0}重天后解锁',mathHelper.numberToChinese(args[2]))
end,

[funcShopUnlockType.eWanLingTaLevel]=function(args)
return FMT.fmt('须弥塔塔灵{0}级解锁',mathHelper.numberToChinese(args[2]))
end,

[funcShopUnlockType.eQiYanShuLib_id]=function(args)
return FMT.fmt('祈愿树第{0}抽奖库',mathHelper.numberToChinese(args[2]+1))
end,
[funcShopUnlockType.eXianMengZhanSaiJi]=function(args,shopId)
if shopId==eFuncShopType.eMojieSaiJi then
local raceIndex=xianjieController:getMoJieSaiJiID()
if args[3]and args[3]~=args[2]then
return FMT.fmt("魔界第{0}~{1}赛季开放",args[2],args[3])
else
return FMT.fmt("魔界第{0}赛季开放",args[2])
end
else
local raceIndex=lingxuwenjianModel:getRaceIndex()
if args[3]and args[3]~=args[2]then
return FMT.fmt("山海第{0}~{1}赛季开放",args[2],args[3])
else
return FMT.fmt("山海第{0}赛季开放",args[2])
end
end
end,
[funcShopUnlockType.eMoJieJieDuan]=function(args,shopId)
if shopId==eFuncShopType.eMojieSaiJi then
return FMT.fmt("魔界第{0}章开放",args[2])
end
end,
[funcShopUnlockType.eMojieSaiJiID]=function(args,shopId)
if shopId==eFuncShopType.eMojieSaiJi then

return FMT.fmt("魔界新赛季开放")
end
end,
}

funcShopModel.FuncShopTypeFunc=
{
[eFuncShopType.eDouFaTai]=
{
getEndTime=function()
local doufatai_data=douFaTaiModel:get_doufatai_data()
if doufatai_data then
return doufatai_data.settleTime
end
end,
needFreshFuncShopWin=true,
checkOpen=function()
return systemModel.isOpen(SYSTEM_DEFINE.eBuildOpenDouFaTai)
end
},
[eFuncShopType.eLunDao]=
{
getEndTime=function()
return
end,
checkOpen=function()
return systemModel.isOpen(SYSTEM_DEFINE.eBuildOpenDouFaTai)and(lundaodahuiModel:isOpened()or lundaodahuiModel:checkLunDaoDaHuiEntry())
end,
needFreshFuncShopWin=true,
},
[eFuncShopType.eXianFaLunDao]=
{
getEndTime=function()
return UIXianFaWenDaoControl:getSessionTruceEndTime()
end,
checkOpen=function()
return UIXianFaWenDaoControl:checkUnlock()
end,
needFreshFuncShopWin=true,
},
[eFuncShopType.eXianMeng]=
{
getEndTime=function()
return
end,
checkOpen=function()
if not xianmengModel:hasXM()then
return false
end
if not zongmenModel:haveBuildByBuildIdEx(SLG_SYSTEM_TYPE.eXianMengShanDian)then
return false
end



return true
end,
needFreshFuncShopWin=true,
},
[eFuncShopType.eZhanGong]=
{
getEndTime=function()
return
end,
checkOpen=function()

return true
end,
needFreshFuncShopWin=true,
},
[eFuncShopType.eXuYuan]=
{
getEndTime=function()
local sTime,eTime,nsTime=baoLingShuModel:getGBPickUpTime()
local isInPickUpNow=baoLingShuModel:checkIsInPickUpNow()
if isInPickUpNow then
return timeHelper.convertShortStamp(eTime)
else
return timeHelper.convertShortStamp(nsTime)
end
end,
checkOpen=function()

return true
end,
},
[eFuncShopType.eshanhaishop]=
{
getEndTime=function()
return
end,
checkOpen=function()

local actInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eZhengZhanShanHai)
if actInfo and actInfo:checkOpen()then
return true
else
return false
end

end,
},

[eFuncShopType.eLingCui]=
{
getEndTime=function()
return
end,
checkOpen=function()
return systemModel.isOpen(SYSTEM_DEFINE.eLingCuiShangDian)
end,
},

[eFuncShopType.eQiYuan]=
{
getEndTime=function()
local sTime,eTime=qiYuanShuModel:getQiYuanTime()
local cfg=cfgHelper.get1(cfg_wishtreeconfig_get,1)
local nowTime=timeHelper.getServerShortTime()
if nowTime>=sTime then
local timeParam=cfg.time_control[2]
local intervalWeek=timeParam[2]
local nextTime_s=sTime+(intervalWeek+1)*86400*7
return nextTime_s
else
return sTime
end
end,
checkOpen=function()

return true
end,
},
[eFuncShopType.eWenDingCangQiong]=
{
getEndTime=function()
return
end,
checkOpen=function()
return WDCQController.checkSysOpen()
end,
},
[eFuncShopType.eXianJieBaoKu]=
{
getEndTime=function()
return
end,
checkOpen=function()
return true
end,
},
[eFuncShopType.eXianGongChaoGong]=
{
getEndTime=function()
return
end,
checkOpen=function()
return true
end,
},
[eFuncShopType.eXianGongChaoGong]=
{
getEndTime=function()
return
end,
checkOpen=function()
return true
end,
},
[eFuncShopType.eMojieSaiJi]=
{
getEndTime=function()
return
end,
checkOpen=function()

local isMJtime=xianjieController:CheckMoJieSaiJieActityeTimeShop()
if isMJtime then
return true
else
return false
end
end,
},
[eFuncShopType.eXianZhan_DaoJu]=
{
getEndTime=function()
return
end,
checkOpen=function()
local list=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eXianZhan,true,true,false)
return list~=nil and#list>0
end,
},
[eFuncShopType.eXianZhan_GuBao]=
{
getEndTime=function()
return
end,
checkOpen=function()
local list=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eXianZhan,true,true,false)
return list~=nil and#list>0
end,
},
[eFuncShopType.eXianZhan_SheJiTu]=
{
getEndTime=function()
return
end,
checkOpen=function()
local list=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eXianZhan,true,true,false)
return list~=nil and#list>0
end,
},
[eFuncShopType.eLingShouShop]=
{
getEndTime=function()
return
end,
checkOpen=function()
return systemModel.isOpen(SYSTEM_DEFINE.eLingShou)
end,
},
}

ShopGroupType={
eDouFaShop=1,
eXianMengShop=2,
eXianYuanShop=3,
eXianZhanShop=4,
eLingZhenShop=5,
eLingShouShop=6,
}

funcShopModel.GroupShopCheckUnLockFunc={
[ShopGroupType.eDouFaShop]=function()
return zongmenControl:isRequireBuilding(SLG_SYSTEM_TYPE.eDouFaTai)
end,
[ShopGroupType.eXianMengShop]=function()
return xianmengModel:hasXM()and zongmenControl:isRequireBuilding(SLG_SYSTEM_TYPE.eXianMengShanDian)
end,
[ShopGroupType.eXianYuanShop]=function()
return zongmenControl:isRequireBuilding(SLG_SYSTEM_TYPE.eYinXianTai)
end,
[ShopGroupType.eXianZhanShop]=function()
local list=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eXianZhan,true,true,false)
return list~=nil and#list>0
end,
[ShopGroupType.eLingZhenShop]=function()
return zongmenControl:isRequireBuilding(SLG_SYSTEM_TYPE.eTianGongGe)and systemModel.isOpen(SYSTEM_DEFINE.eLingZhenDiaoKe)
end,
[ShopGroupType.eLingShouShop]=function()
return systemModel.isOpen(SYSTEM_DEFINE.eLingShou)
end,
}




function funcShopModel:onAppStart()

end


function funcShopModel:onEnterState()
funcShopModel:initData_shanhai()
funcShopModel:initData_qiyuanshu()
funcShopModel:initData_mojiesd()
self:init_group()
end


function funcShopModel:onLeaveState()

self.data={}
funcShopModel:clearData_shanhai()
funcShopModel:clearData_qiyuanshu()
funcShopModel:clearData_mojiesd()
end


function funcShopModel:onServerDataInitFinish()

funcShopController:checkXianYuanShopEnter()
end




function funcShopModel.get_shop_item_conf(shopId,buyId,...)
local shopCfg=cfgHelper.get(cfg_shoplistconfig_get,shopId)
if shopCfg then
local func
if buyId==nil then
func=cfgHelper.getCofingFunction(shopCfg.confFile)
if func then
return func()
end
else
func=cfgHelper.getCofingGetFunction(shopCfg.confFile)
if func then
return cfgHelper.get(func,buyId,...)
end
end
end
end

function funcShopModel:get_menu(shopId)
local cfg=cfg_shoplistconfig()
local menuList={}
local thisCfg=cfg[shopId]
if not thisCfg.shopGroup then
return menuList
end
local groupId=thisCfg.shopGroup
for i,v in ipairs(cfg)do
if v.shopIndex and v.shopGroup==groupId then
local funcCfg=funcShopModel.FuncShopTypeFunc[v.shopType]
if(not funcCfg)or(funcCfg and funcCfg.checkOpen())then
table.insert(menuList,v)
end
end
end
return menuList
end

function funcShopModel:check_item_unlock(shopId,buyId,isWarming,cond)
cond=cond or'unlock'
local unlock=self.get_shop_item_conf(shopId,buyId,cond)

if unlock then
for i,v in ipairs(unlock)do
if checkUnLockFunc[v[1]]then
if not checkUnLockFunc[v[1]](v,shopId)then
if getUnLockTips[v[1]]then
local warn_str=getUnLockTips[v[1]](v,shopId)
if isWarming then
UIManager.error(warn_str)
end
return false,warn_str
else
loggerUtil.logErrFMT("没有对应类型{0},{1},{2},{3}",shopId,buyId,cond,v[1])
end
end
end
end
end
return true,nil
end

function funcShopModel:get_lock_tips(shopId,buyId)
local unlock=self.get_shop_item_conf(shopId,buyId,'unlock')
if unlock then
for i,v in ipairs(unlock)do
if checkUnLockFunc[v[1]]then
if not checkUnLockFunc[v[1]](v,shopId)then
if getUnLockTips[v[1]]then
return getUnLockTips[v[1]](v,shopId)
end
end
end
end
end
return''
end


function funcShopModel:check_item_unlock_xianzhan(unlock)

if unlock then
for i,v in ipairs(unlock)do
if checkUnLockFunc[v[1]]then
if not checkUnLockFunc[v[1]](v)then
return false
end
end
end
end
return true
end

function funcShopModel:get_lock_status(shopId,buyId,index)
local unlock=self.get_shop_item_conf(shopId,buyId,'unlock')
if unlock then
local v=unlock[index]
local type=v[1]
local tips
if getUnLockTips[type]then
tips=getUnLockTips[type](v,shopId)
end
local cur,max
if getUnlockProgress[type]then
cur,max=getUnlockProgress[type](v,shopId)
end
return tips,cur,max
end
end

function funcShopModel:get_sort_list(shopId,locklimit)
local cfg=funcShopModel.get_shop_item_conf(shopId)
local list={}
local locknum=0
for i,v in pairs(cfg)do
if i~='const_def'then
local item={}
local sortId=0
local buyData=self:get_data(shopId,v.id)
local check=true
if self:check_item_unlock(shopId,v.id,nil,'hide')then
if self:check_item_unlock(shopId,v.id)then
if v.sort~=nil then
sortId=v.sort
end
item.unlock=true
else
locknum=locknum+1
if v.unlockSort~=nil then
sortId=v.unlockSort
elseif v.sort~=nil then
sortId=v.sort
else
sortId=1
end
sortId=sortId*1000
if locklimit~=nil then
if locknum>locklimit then
check=false
end
end
end

if buyData then
if v.buyLimit and buyData.buyNum>=v.buyLimit[1][2]then
item.sold=true
sortId=sortId+1000000000
end
end
item.sortId=sortId
item.cfg=v
if check then
table.insert(list,item)
end
end
end
end

table.sort(list,function(a,b)return a.sortId<b.sortId end)
return list
end

function funcShopModel:checkSoldout(shopId,buyId)
local cfg=funcShopModel.get_shop_item_conf(shopId,buyId)
local data=funcShopModel:get_data(shopId,buyId)
local buyNum=0
if data then
buyNum=data.buyNum
end
if cfg.buyLimit and buyNum>=cfg.buyLimit[1][2]then
return true
end
return false
end

function funcShopModel:init_data(shopId,buyList)
self.data[shopId]={}
if buyList then
for i,v in ipairs(buyList)do
self.data[shopId][v.buyId]=v
end
end
end

function funcShopModel:checkInit(shopId)
return funcShopModel:getShopData(shopId)~=nil
end

function funcShopModel:getShopData(shopId)
return self.data[shopId]
end

function funcShopModel:set_data(shopId,buyId,data)
self.data[shopId]=self.data[shopId]or{}
self.data[shopId][buyId]=self.data[shopId][buyId]or{}
for k,v in pairs(data)do
self.data[shopId][buyId][k]=v
end
end


function funcShopModel:get_data(shopId,buyId)
if self.data[shopId]then
return self.data[shopId][buyId]
end

return nil
end

function funcShopModel.getLimitName(limitType)
return cfgHelper.get2(cfg_shoplimitconfig_get,limitType,'limitStr')
end

function funcShopModel:checkFuncShopTypeFuncOpen(shopType)
local func=self.FuncShopTypeFunc[shopType]
if func and func.checkOpen then
return func.checkOpen()
end
return true
end

function funcShopModel:getFuncShopTypeFuncEndTime(shopType)
local func=self.FuncShopTypeFunc[shopType]
if func and func.getEndTime then
return func.getEndTime()
end
end

function funcShopModel.getLimitStr(limitType)
return cfgHelper.get2(cfg_shoplimitconfig_get,limitType,'limitStrEx')or""
end

function funcShopModel.getLimitStr2(limitType)
return cfgHelper.get2(cfg_shoplimitconfig_get,limitType,'limitStrXX')or""
end

function funcShopModel:checkCanBuy(shopId,buyId)
local shopType=cfgHelper.get(cfg_shoplistconfig_get,shopId,'shopType')

if not funcShopModel:checkFuncShopTypeFuncOpen(shopType)then return false end

if not self:check_item_unlock(shopId,buyId)then return false end

local conf=funcShopModel.get_shop_item_conf(shopId,buyId)

if conf.money then
return itemsModel:canUseItem(conf.money[1],conf.money[2])
end

if conf.consume and next(conf.consume)then
for index,cost in ipairs(conf.consume)do
if not itemsModel:canUseItem(cost[1],cost[2])then
return false
end
end
return true
end

if conf.useItem then
return itemsModel:canUseItem(conf.useItem[1],conf.useItem[2])
end


logErr("内网提示性报错：商店购买消耗检查缺少检查字段")

return false
end


function funcShopModel:init_group()
local shopAllCfg=cfg_shoplistconfig()

self.data.groupList={}
local groupList=self.data.groupList

for index,shopCfg in ipairs(shopAllCfg)do
local groupIndex=shopCfg.shopGroup
local shopIndex=shopCfg.shopIndex

if groupIndex then
if groupList[groupIndex]==nil then
groupList[groupIndex]={}
end
groupList[groupIndex][shopIndex]=shopCfg
end
end
end

function funcShopModel:get_menu_group()
local groupCfg=cfg_shopgroupconfig()

local groupList={}

for index,group in ipairs(groupCfg)do
local checkGroupOpen=funcShopModel.GroupShopCheckUnLockFunc[group.id]
if checkGroupOpen and checkGroupOpen()then
local menuList=self:get_group(group.id)
if menuList and#menuList>0 then
groupList[#groupList+1]=group
end
end
end

return groupList
end

function funcShopModel:get_group(groupIndex)
local menuList=self.data.groupList[groupIndex]
local tempList={}
for i,v in ipairs(menuList)do
local funcCfg=funcShopModel.FuncShopTypeFunc[v.shopType]
if(not funcCfg)or(funcCfg and funcCfg.checkOpen())then
table.insert(tempList,v)
end
end

return tempList
end



