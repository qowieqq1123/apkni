pushGiftThreeManager=gameState.addListener({})

local _tickCache={}
local _tickDequeueCache={}
local _lookupCfg={}
local _eventCache={}
local _stamp={}
local _sendCache={}
local _openList={}
local _circleCheckCurTime=0
local _circleCheckTime=30

local _limitQueue={}
local _limitLookup={}
local _advertTypeListCache={}
local _advertTypeLookupCache={}
local _advertTypeChangeCache={}
local _openedTable={}
local _openMaxCnt=10
local _updateLen=2
local _lastStamp=nil

local _checkType=
{
eZMlv=1,
eDZJingjie=2,
eDZLianTi=3,
eXuYuanCount=4,
eGongFaActive=5,
eShiLianTaLayer=6,
eSystemOpen=7,
eTaskFinish=8,
eServerOpenDay=9,
eUnFinishActiveGongFa=10,
eXianMengXingDong=11,
eFirstGetItem=12,
eDZTianMing=13,
eBuyGift=14,
eLeiJiRecharge=15,
eChuiWeiGift=16,
eTime=17,
eServerOpenOneDay=18,
eDZLingGenLv=19,
eFabaoOverLv=20,
eTuPoJingjieFail=21,
eDaoBingJllv=22,
eDelayOpen=23,
eNotOwnerDZ=24,
eWeekOpen=25,
eRoleActivity=26,
eSelfActivity=27,
eKuafuActivity=28,
eKaiFuRange=29,
eLockBuildSuitID=30,
eJiuChangTianJieJD=31,
ebadCheckItemNum=32,
eCheckbuildLevel=33,
eFirstGetXMEquip=34,
eFirstGetZQEquip=35,
eYunWuUnlock=36,
eYLZSeriousInjuryCount=37,
eCheckPlatform=38,
eDZDaoYan_lv=39,
eGuBaoStarUp=40,
eVocEquipCheck=41,
eLingShouJingJie=42,
eLingShouXueMai=43,
}
GIFT_THREE_CHECK_TYPE=_checkType


local _openOutFunc=
{
[_checkType.eTime]=
{
overfunc=function(params)
local endTime=params[3]
local endStamp=timeHelper.getDateStamp(endTime)
local stamp=timeHelper.getServerLongTime()
return endStamp<stamp
end
},
[_checkType.eNotOwnerDZ]=
{
overfunc=function(params)
local dzid=params[2]
return UIDiscipleModel:getDiscipleIdCount(dzid)>0
end
},
[_checkType.eKaiFuRange]=
{
overfunc=function(params)
local startOpen=params[1]
local endOpen=params[2]
local openDay=timeHelper.getServerOpenDay()
return openDay<startOpen or openDay>endOpen
end
}
}



local _otherArgsOutFunc=
{
['serverlimit']=
{
overfunc=function(params)
return not pushGiftThreeManager:checkServerLimitOpen(params)
end
},
}


local _checkFun=
{
[_checkType.eZMlv]=function(params)
local needlv=params[2]
local lv=zongmenModel:getLevel()
return lv>=needlv
end,
[_checkType.eDZJingjie]=function(params)
local needCount=params[2]
local needlv=params[3]
local count=UIDiscipleModel:getDiscipleJJCount(needlv)
return count>=needCount
end,
[_checkType.eDZLianTi]=function(params)
local needCount=params[2]
local needlv=params[3]
local count=UIDiscipleModel:getDiscipleLTCount(needlv)
return count>=needCount
end,
[_checkType.eXuYuanCount]=function(params)
local needCount=params[2]
return baoLingShuModel:getBugNum()>=needCount
end,
[_checkType.eGongFaActive]=function(params)
local needCount=params[2]
local needColor=params[3]
local count=UIGongFaModel:getActiveDataCountByColor(needColor)
return count>=needCount
end,
[_checkType.eShiLianTaLayer]=function(params)
local needLayer=params[2]
local layer=shiLianTaModel:getCurLayer()-1
return layer>=needLayer
end,
[_checkType.eSystemOpen]=function(params)
local sysid=params[2]
return systemModel.isOpen(sysid)
end,
[_checkType.eTaskFinish]=function(params)
local taskid=params[2]
return taskModel:checkTaskFinish(taskid)
end,
[_checkType.eServerOpenDay]=function(params)
local day=params[2]
local openDay=timeHelper.getServerOpenDay()
return openDay>=day
end,
[_checkType.eServerOpenOneDay]=function(params)
local day=params[2]
local openDay=timeHelper.getServerOpenDay()
return openDay==day
end,
[_checkType.eUnFinishActiveGongFa]=function(params)
local gfID=params[2]
return not UIGongFaModel:isGongFaActive(gfID)or
not UIGongFaModel:isPageAllActive(gfID)
end,
[_checkType.eXianMengXingDong]=function(params)
local val=params[2]
local maxcnt=xianmengdigongModel:getMaxXDLCount()
local buycnt=xianmengdigongModel:getXDLCount()or 0
local leftcnt=maxcnt-buycnt
if leftcnt>0 then return false end
local xfl=moneyModel.getMoney(eMoneyType.mtDiGongXingDongLi)
return xfl<val
end,
[_checkType.eFirstGetItem]=function(params,itemidlist)
if itemidlist==nil then return false end
itemidlist=itemidlist[1]
local itemtype=params[2]
local _itemid=params[3]
for i,itemid in ipairs(itemidlist)do
if _itemid and _itemid>0 then
if _itemid==itemid then return true end
else
if itemsConfig.getMainType(itemid)==itemtype then
return true
end
end
end
return false
end,
[_checkType.eDZTianMing]=function(params,dzguid)
if dzguid==nil then return false end
local id=params[2]
local needlv=params[3]
dzguid=dzguid[1]
local _id=UIDiscipleModel:getDiscipleID(dzguid)
if _id==id then
local lv=UIDiscipleModel:getTianMingLevel(dzguid)
return lv>=needlv
end
return false
end,
[_checkType.eLeiJiRecharge]=function(params)
local num=params[2]
return rechargeModel:getTotalRecharge()>=num
end,

[_checkType.eChuiWeiGift]=function(params,changeState)
local state=params[2]
if changeState and changeState[1]~=state then
return false
end
local num=params[3]
local cnt=UIDiscipleModel:getStateCnt(state)
return cnt>=num
end,
[_checkType.eBuyGift]=function(params,id)
local giftid=params[2]
id=id and id[1]or giftid
if id~=giftid then return false end
local times=params[3]
local cnt=pushGiftThreeModel:getAlreadyBuyTimesById(id)
if times and times>0 then
return cnt>=times
end
return pushGiftThreeModel:isBuyOver(id)
end,
[_checkType.eTime]=function(params)
local startTime=params[2]
local endTime=params[3]
local startStamp=timeHelper.getDateStamp(startTime)
local endStamp=timeHelper.getDateStamp(endTime)
local stamp=timeHelper.getServerLongTime()
return stamp>=startStamp and endStamp>=stamp
end,
[_checkType.eDZLingGenLv]=function(params,dzguid)
if dzguid==nil then return false end
local needlv=params[2]
local neednum=params[3]
dzguid=dzguid[1]
local lv=UIDiscipleModel:getDiscipleTotalLinggenLevel(dzguid)
if lv<needlv then return false end
local hasnum=0
local diguidlist=UIDiscipleModel:getAllDiscipleData()
for i,v in pairs(diguidlist)do
local dzguid=v.netData.net.discipleguid
local lv=UIDiscipleModel:getDiscipleTotalLinggenLevel(dzguid)
if lv>=needlv then
hasnum=hasnum+1
end
end
return hasnum>=neednum
end,
[_checkType.eFabaoOverLv]=function(params)
local needlv=params[2]
local neednum=params[3]
local hasnum=0
for _,v in ipairs(fabaoBagModel:getBagItems())do
if v.itemData and v.itemData.jilianlv>=needlv then
hasnum=hasnum+1
end
end

for _,v in pairs(fabaoModel.equips)do
if v.itemData and v.itemData.jilianlv>=needlv then
hasnum=hasnum+1
end
end
return hasnum>=neednum
end,
[_checkType.eTuPoJingjieFail]=function(params,args)
if args==nil then return false end
local needlv=params[2]
local jingjie=args[1]
return needlv==jingjie
end,
[_checkType.eDaoBingJllv]=function(params)
local needlv=params[2]
local neednum=params[3]
local hasnum=0
for _,v in ipairs(daobingBagModel:getBagItems())do
if v.itemData and v.itemData.jinglianlv and v.itemData.jinglianlv>=needlv then
hasnum=hasnum+1
end
end

for _,v in pairs(daobingModel.equips)do
if v.itemData and v.itemData.jinglianlv and v.itemData.jinglianlv>=needlv then
hasnum=hasnum+1
end
end
return hasnum>=neednum
end,
[_checkType.eDelayOpen]=function(params)
local giftid=params[2]
local delay=params[3]or 0
if not pushGiftThreeModel:isAlreadyDo(giftid)then return false end
local cost=pushGiftThreeModel:getStartedTime(giftid)
if cost==nil then return false end
return cost>=delay
end,
[_checkType.eNotOwnerDZ]=function(params)
local dzid=params[2]
return UIDiscipleModel:getDiscipleIdCount(dzid)<=0
end,
[_checkType.eWeekOpen]=function(params)
local minday=params[2]
local maxday=params[3]
local weekIdx=timeHelper.getWeakDateEx()
local ispass=minday<=weekIdx and weekIdx<=maxday
return ispass
end,
[_checkType.eRoleActivity]=function(params)
local subtypelist=params[2]
local allnum=params[3]
local getnum=pushGiftHandleModel:getActivityRoleNum(subtypelist)
return allnum<=getnum
end,
[_checkType.eSelfActivity]=function(params)
local subtypelist=params[2]
local allnum=params[3]
local getnum=pushGiftHandleModel:getActivityRoleNum(subtypelist)
return allnum<=getnum
end,
[_checkType.eKuafuActivity]=function(params)
local subtypelist=params[2]
local allnum=params[3]
local getnum=pushGiftHandleModel:getActivityRoleNum(subtypelist)
return allnum<=getnum
end,
[_checkType.eKaiFuRange]=function(params)
local startOpen=params[1]
local endOpen=params[2]
local openDay=timeHelper.getServerOpenDay()
return openDay>=startOpen and openDay<=endOpen
end,
[_checkType.eLockBuildSuitID]=function(params)
local suitId=params[2]
return not zongmenBuildingSuitModel:getActive(suitId)
end,
[_checkType.eJiuChangTianJieJD]=function(params)
local jctjid=params[2]
local jindu=params[3]
local openjd=pushGiftHandleModel:getJiuChongTianJiejd(jctjid)
return openjd>=jindu
end,
[_checkType.ebadCheckItemNum]=function(params)
local itemlist=params[2]
local isopen=pushGiftHandleModel:checkOpenByBadItem(itemlist)
return isopen
end,
[_checkType.eCheckbuildLevel]=function(params)
local bdId=params[2]
local needlevel=params[3]
local isopen=pushGiftHandleModel:checkOpenByBuildlevel(bdId,needlevel)
return isopen
end,
[_checkType.eFirstGetXMEquip]=function(params,firstHasXMLookup)
if firstHasXMLookup==nil then return false end
firstHasXMLookup=firstHasXMLookup[1]
local _type3=params[2]

if _type3==0 then return true end
local xflag=false
local mflag=false
for k,v in pairs(firstHasXMLookup)do
if k==EQUIP_XianMo_TYPES.eXian then
xflag=true
elseif k==EQUIP_XianMo_TYPES.eMo then
mflag=true
end
end
if xflag and _type3==EQUIP_XianMo_TYPES.eXian then
return true
end
if mflag and _type3==EQUIP_XianMo_TYPES.eMo then
return true
end
return false
end,
[_checkType.eFirstGetZQEquip]=function(params,firstHasZQLookup)
if firstHasZQLookup==nil then return false end
firstHasZQLookup=firstHasZQLookup[1]
if firstHasZQLookup and itemsConfig.isYunZhouComponents(firstHasZQLookup)then
return true
end
return false
end,
[_checkType.eYunWuUnlock]=function(params)
local cloudnum=params[2]
local libaoid=params[3]
local isopen=pushGiftHandleModel:checkXianJieCloudNum(cloudnum,libaoid)
return isopen
end,
[_checkType.eYLZSeriousInjuryCount]=function(params)
local needCount=params[2]
local num=xianjieModel:getSoldierAllHurtNum(xjSoldierHurtType.eSeriousInjury)
return num>=needCount
end,
[_checkType.eCheckPlatform]=function(params)
local flag=params[2]
local versionId=pfwindowslController:getGameVersion()
if type(flag)=='table'then
for k,v in ipairs(flag)do
if versionId==v then
return true
end
end
else
return versionId==flag
end
return false
end,
[_checkType.eDZDaoYan_lv]=function(params,dzguid)
if dzguid==nil then return false end
local ids=params[2]
local needlv=params[3]
dzguid=dzguid[1]
local _id=UIDiscipleModel:getDiscipleID(dzguid)
for k,id in ipairs(ids)do
if _id==id then
local lv=UIDiscipleModel:getDaoYanLevel(dzguid)
return lv>=needlv
end
end
return false
end,
[_checkType.eGuBaoStarUp]=function(params,_gbid)
local gbid=params[2]
local needlv=params[3]
local gbData=gubaoModel:getDataByID(gbid)
local starlv=gbData and gbData.gubaostar or 0
return starlv>=needlv
end,
[_checkType.eVocEquipCheck]=function(params,_gbid)
local neednum=params[2]
local data=params[3]
local color=data[1]
local level=data[2]
local flag=XianYunGangModel:checkYZEquipsNum(neednum,level,color)
return flag
end,

[_checkType.eLingShouJingJie]=function(params)
local needRace=params[2]
local needLv=params[3]
local lsDatas=lingshouModel:getLingShouDatas()
for _,lsData in pairs(lsDatas)do
if lsData.cfg then

if needRace==0 or lsData.cfg.race==needRace then
if lsData.jj_lvl>=needLv then
return true
end
end
end
end
return false
end,

[_checkType.eLingShouXueMai]=function(params)
local needRace=params[2]
local needLv=params[3]
local lsDatas=lingshouModel:getLingShouDatas()
for _,lsData in pairs(lsDatas)do
if lsData.cfg then

if needRace==0 or lsData.cfg.race==needRace then
if lsData.xuemai_val>=needLv then
return true
end
end
end
end
return false
end,
}


local _initFunc=
{
[_checkType.eDZTianMing]=function(params)
local id=params[2]
local needlv=params[3]
local diguidlist=UIDiscipleModel:getAllDiscipleData()
for i,v in pairs(diguidlist)do
local dzguid=v.netData.net.discipleguid
local _id=UIDiscipleModel:getDiscipleID(dzguid)
if _id==id then
local lv=UIDiscipleModel:getTianMingLevel(dzguid)
return lv>=needlv
end
end
return false
end,
[_checkType.eDZLingGenLv]=function(params)
local needlv=params[2]
local neednum=params[3]
local hasnum=0
local diguidlist=UIDiscipleModel:getAllDiscipleData()
for i,v in pairs(diguidlist)do
local dzguid=v.netData.net.discipleguid
local lv=UIDiscipleModel:getDiscipleTotalLinggenLevel(dzguid)
if lv>=needlv then
hasnum=hasnum+1
end
end
return hasnum>=neednum
end,
[_checkType.eLockBuildSuitID]=function(params)
local suitId=params[2]
return not zongmenBuildingSuitModel:getActive(suitId)
end,
[_checkType.eYunWuUnlock]=function(params)
local cloudnum=params[2]
local libaoid=params[3]
local isopen=pushGiftHandleModel:checkXianJieCloudNum(cloudnum,libaoid)
return isopen
end,
[_checkType.eYLZSeriousInjuryCount]=function(params)
local needCount=params[2]
local num=xianjieModel:getSoldierAllHurtNum(xjSoldierHurtType.eSeriousInjury)
return num>=needCount
end,
[_checkType.eDZDaoYan_lv]=function(params)
local ids=params[2]
local temp={}
for k,id in ipairs(ids)do
temp[id]=true
end
local needlv=params[3]
local diguidlist=UIDiscipleModel:getAllDiscipleData()
for i,v in pairs(diguidlist)do
local dzguid=v.netData.net.discipleguid
local _id=UIDiscipleModel:getDiscipleID(dzguid)
if temp[_id]then
local lv=UIDiscipleModel:getDaoYanLevel(dzguid)
return lv>=needlv
end
end
return false
end,
}


function pushGiftThreeManager:onAppStart()

notifySystem:listenNotify(notifyConfig.onDiscipleJJChange,function()
pushGiftThreeManager:onChanged(_checkType.eDZJingjie)
end)

notifySystem:listenNotify(notifyConfig.onDiscipleLTChange,function()
pushGiftThreeManager:onChanged(_checkType.eDZLianTi)
end)

notifySystem:listenNotify(notifyConfig.onGongFaActive,function()
pushGiftThreeManager:onChanged(_checkType.eGongFaActive)
pushGiftThreeManager:onChanged(_checkType.eUnFinishActiveGongFa)
end)

notifySystem:listenNotify(notifyConfig.building_event,function(eventType,...)
if eventType==buildingEvent.zongmenLevelUp then
pushGiftThreeManager:onChanged(_checkType.eZMlv)
end
if eventType==buildingEvent.levelUpComplete then
pushGiftThreeManager:onChanged(_checkType.eCheckbuildLevel)
end
end)
notifySystem:listenNotify(notifyConfig.on_system_open,function(sysid,isNew)
if sysid==SYSTEM_DEFINE.eLimitedTimeGift3 and initProControl.isDone()then
self:initalize()
end
pushGiftThreeManager:onChanged(_checkType.eSystemOpen)
end)
notifySystem:listenNotify(notifyConfig.onTaskChange,function(taskid,t_taskstate)
if t_taskstate==taskModel.taskFinishState then
pushGiftThreeManager:onChanged(_checkType.eTaskFinish)
end
end)
notifySystem:listenNotify(notifyConfig.onNewDay,function()
pushGiftThreeManager:onChanged(_checkType.eServerOpenDay)
pushGiftThreeManager:onChanged(_checkType.eServerOpenOneDay)
pushGiftThreeManager:onChanged(_checkType.eWeekOpen)
end)

notifySystem:listenNotify(notifyConfig.on_item_list_first_get,function(itemlist)
pushGiftThreeManager:onChanged(_checkType.eFirstGetItem,itemlist)
end)

notifySystem:listenNotify(notifyConfig.onDiscipleTianMingLvChange,function(dzguid,oldlv,lv)
pushGiftThreeManager:onChanged(_checkType.eDZTianMing,dzguid)
end)
notifySystem:listenNotify(notifyConfig.onDiscipleDaoYanLvChange,function(dis_guid,olddylv,dylv)
pushGiftThreeManager:onChanged(_checkType.eDZDaoYan_lv,dis_guid)
end)

socketManager:addNotify(14,1,function()
pushGiftThreeManager:onChanged(_checkType.eLeiJiRecharge)
end)

notifySystem:listenNotify(notifyConfig.onDiscipleStateChange,function(dzguid,state)
pushGiftThreeManager:onChanged(_checkType.eChuiWeiGift,state)
end)

notifySystem:listenNotify(notifyConfig.onDiscipleLingGenUpLevel,function(dzguid)
pushGiftThreeManager:onChanged(_checkType.eDZLingGenLv,dzguid)
end)

socketManager:addNotify(15,63,function(id,idx,buytimes)
local hasTimes=pushGiftThreeModel:hasLeftBuyTimes(id)
if hasTimes then return end
pushGiftThreeManager:onChanged(_checkType.eBuyGift,id)
end)

socketManager:addNotify(2,53,function()
pushGiftThreeManager:onChanged(_checkType.eFabaoOverLv)
end)

notifySystem:listenNotify(notifyConfig.onDiscipleJJBroke,function(guid,res,jjlv)
if res~=0 then
pushGiftThreeManager:onChanged(_checkType.eTuPoJingjieFail,jjlv)
end
end)

socketManager:addNotify(2,96,function()
pushGiftThreeManager:onChanged(_checkType.eDaoBingJllv)
end)

notifySystem:listenNotify(notifyConfig.onActivityStateChange,function(actID,state)
if state==activitiesModel.activityDoingState then
local serverType=activitiesModel:getServerType(actID)
if serverType==activitiesServerType.eKuafu or serverType==activitiesServerType.eBigCross then
pushGiftThreeManager:onChanged(_checkType.eKuafuActivity)
elseif serverType==activitiesServerType.eRole then
pushGiftThreeManager:onChanged(_checkType.eRoleActivity)
else
pushGiftThreeManager:onChanged(_checkType.eSelfActivity)
end
end
end)


notifySystem:listenNotify(notifyConfig.onJctjProgressChange,function(actID,state)
pushGiftThreeManager:onChanged(_checkType.eJiuChangTianJieJD)
end)


notifySystem:listenNotify(notifyConfig.on_XMequip_first_get,function(firstHasXMitem)
pushGiftThreeManager:onChanged(_checkType.eFirstGetXMEquip,firstHasXMitem)
end)

notifySystem:listenNotify(notifyConfig.on_YZequip_first_get,function(firstHasZQLookup)
pushGiftThreeManager:onChanged(_checkType.eFirstGetZQEquip,firstHasZQLookup)
end)

notifySystem:listenNotify(notifyConfig.home_event,function(etype)
if etype==homeEvent.eEnterHome then
pushGiftThreeManager:onChanged(_checkType.eYunWuUnlock)
end
end)
notifySystem:listenNotify(notifyConfig.on_money_changed,function(mtype,last,curr)
if YuLingZhaiModel:isMoneyHurtType(mtype)then
pushGiftThreeManager:onChanged(_checkType.eYLZSeriousInjuryCount)
end
end)

notifySystem:listenNotify(notifyConfig.onGuBaoShengXing,function(gbid)
pushGiftThreeManager:onChanged(_checkType.eGuBaoStarUp,gbid)
end)
notifySystem:listenNotify(notifyConfig.onVocEquipChange,function()
pushGiftTwoManager:onChanged(_checkType.eVocEquipCheck)
end)
notifySystem:listenNotify(notifyConfig.onVocEquipStrengthenLevelChange,function()
pushGiftTwoManager:onChanged(_checkType.eVocEquipCheck)
end)


notifySystem:listenNotify(notifyConfig.onLingShouJJChange,function()
pushGiftThreeManager:onChanged(_checkType.eLingShouJingJie)
end)

notifySystem:listenNotify(notifyConfig.onLingShouXMChange,function()
pushGiftThreeManager:onChanged(_checkType.eLingShouXueMai)
end)
end

function pushGiftThreeManager:onEnterState(isReconnect)
pushGiftThreeManager:stopTimer()
_lookupCfg={}
_eventCache={}
_openList={}
self.hasEnter=false
_stamp={}
self.isInit=false
_sendCache={}
_tickCache={}
_circleCheckCurTime=0
_openedTable={}
_lastStamp=nil
end

function pushGiftThreeManager:onLeaveState(isReconnect)
pushGiftThreeManager:stopTimer()
_lookupCfg={}
_eventCache={}
_openList={}
self.hasEnter=false
_stamp={}
self.isInit=false
_sendCache={}
_tickCache={}
_circleCheckCurTime=0
_openedTable={}
_lastStamp=nil
end

function pushGiftThreeManager:onProtocolReq()

end

function pushGiftThreeManager:initalize()
if not systemModel.isOpen(SYSTEM_DEFINE.eLimitedTimeGift3)or
not initProControl.isDoneKF()or
not initProControl.isDone()then return end
if self.isInit then return end
self.isInit=true
pushGiftThreeManager:initCfg()
pushGiftThreeModel:initAllhideGift()
pushGiftThreeManager:startTimer()
pushGiftThreeController.openAdvertWin()
end

function pushGiftThreeManager:isInitCfg()
return self.isInit
end


function pushGiftThreeManager:initCfg()
_tickCache={}
_limitQueue={}
_limitLookup={}

table.clear(_sendCache)

local add=function(cfg)
local openconf=cfg.openconf
local id=cfg.id
local adverttype=cfg.adverttype
if not pushGiftThreeModel:isHide(id)then
if adverttype then
if _limitQueue[adverttype]==nil then _limitQueue[adverttype]={}end
local limitQueueType=_limitQueue[adverttype]
limitQueueType[#limitQueueType+1]=cfg
_limitLookup[id]=adverttype
end
end

if pushGiftThreeManager:checkOtherOut(cfg)then return end

if not pushGiftThreeModel:isHide(id)and
pushGiftThreeModel:isCanActive(id)then
if pushGiftThreeManager:canOpen(openconf,nil,true)then
_sendCache[id]=true
_tickCache[id]=true
else
local checkCfg=openconf[1]
for i,v in ipairs(checkCfg)do
local checkType=v[1]
if _lookupCfg[checkType]==nil then _lookupCfg[checkType]={}end
local lookupCfg=_lookupCfg[checkType]
lookupCfg[#lookupCfg+1]=cfg
if _openOutFunc[checkType]then
_tickCache[id]=true
if adverttype then
loggerUtil.logErrFMT('第三套推送配置{0}自然时间配置了推送类型',id)
end
end
end
end
end
end

local cfgs=pushGiftThreeConfig.getAllConfig()
for _,v in pairs(cfgs)do
if v.id then
add(v)
end
end

local cfgs=pushGiftThreeConfig.getAllTimeConfig()
for _,v in pairs(cfgs)do
if v.id then
add(v)
end
end
end

function pushGiftThreeManager:isOutTick(id)
local cfg=pushGiftThreeConfig.getConfig(id)
local openconf=cfg.openconf
local checkCfg=openconf[1]
for i,v in ipairs(checkCfg)do
local checkType=v[1]
if _openOutFunc[checkType]then
local ret=_openOutFunc[checkType].overfunc(v)
if ret then
return true
end
end
end
return false
end


function pushGiftThreeManager:startTimer()
if self.tickTimer then return end
if webGLHelper:isRunWebGL()then
_updateLen=1
end
pushGiftThreeManager:stopTimer()
self.tickTimer=timer.new()
self.tickTimer:start(0.05,function()
if not initProControl.isDone()then return end


if _eventCache then
for checkType,args in pairs(_eventCache)do
if#args==0 then args=nil end
local cfgs=_lookupCfg[checkType]
if cfgs and#cfgs>0 then
local len=#cfgs
for i=len,1,-1 do
local cfg=cfgs[i]
local id=cfg.id
if not pushGiftThreeModel:isHide(id)and
pushGiftThreeModel:isCanActive(id)and
pushGiftThreeManager:canOpen(cfg.openconf,args)then
_sendCache[id]=true
_tickCache[id]=true
end
end
end
end
_eventCache=nil
end


local stamp=timeHelper.getServerShortTime()
local expiredDatas=pushGiftThreeModel:getAllExpiredAgainData()
for id,v in pairs(expiredDatas)do
if pushGiftThreeModel:isExpiredAgain(id)then
_sendCache[id]=true
_tickCache[id]=true
end
end


table.clear(_openList)
local len=_updateLen
while#_tickDequeueCache>0 and len>0 do
len=len-1
local id=_remove(_tickDequeueCache,1)
local cfg=pushGiftThreeConfig.getConfig(id)

if _openedTable[id]and _openedTable[id]>=_openMaxCnt or
pushGiftThreeModel:isDoing(id)or
pushGiftThreeModel:isBuyOver(id)or
pushGiftModel:isExpired(id)or
pushGiftThreeModel:isHide(id)or
pushGiftThreeManager:isOutTick(id)then
_tickCache[id]=nil
elseif _sendCache[id]or
(pushGiftThreeModel:isCanActive(id)and
not pushGiftThreeModel:isHide(id)and
pushGiftThreeManager:canOpen(cfg.openconf))then
_openList[#_openList+1]=id
end
end

local isCurTime=stamp==_lastStamp
if isCurTime then return end

if#_tickDequeueCache<=0 then
for v,_ in pairs(_tickCache)do
_insert(_tickDequeueCache,v)
end
end

table.clear(_advertTypeListCache)
table.clear(_advertTypeChangeCache)
table.clear(_advertTypeLookupCache)

for _,id in ipairs(_openList)do
local adverttype=_limitLookup[id]
if not adverttype or pushGiftThreeManager.isAdvertUnlimit()then
if pushGiftThreeController.openGift(id)then
_openedTable[id]=(_openedTable[id]or 0)+1
else
_openedTable[id]=_openMaxCnt
end
else

local len=pushGiftThreeModel:getAdverttypeLen(adverttype)
if len<=0 then
local str=string.format('three_%d',adverttype)
local oldstamp=userActorArraySetting.get(ACTOR_SETTING_TYPE.ePushThreeGift,str,nil)

if oldstamp==nil or oldstamp<stamp then
if _advertTypeLookupCache[id]==nil then
_advertTypeLookupCache[id]=true
if _advertTypeListCache[adverttype]==nil then _advertTypeListCache[adverttype]={}end
local list=_advertTypeListCache[adverttype]
local cfg=pushGiftThreeConfig.getConfig(id)
list[#list+1]=cfg
_advertTypeChangeCache[adverttype]=true
end
end
end
end
end

table.clear(_openList)
table.clear(_advertTypeLookupCache)

for adverttype,_ in pairs(_advertTypeChangeCache)do
local list=_advertTypeListCache[adverttype]
if list then
table.sort(list,function(a,b)
return a.advertsort<b.advertsort
end)
end
end
table.clear(_advertTypeChangeCache)

for adverttype,list in pairs(_advertTypeListCache)do
local len=pushGiftThreeModel:getAdverttypeLen(adverttype)
if len<=0 then
local str=string.format('three_%d',adverttype)
local oldstamp=userActorArraySetting.get(ACTOR_SETTING_TYPE.ePushThreeGift,str,nil)
if oldstamp==nil or oldstamp<stamp then
local list=_advertTypeListCache[adverttype]
if list and#list>0 then
userActorArraySetting.set(ACTOR_SETTING_TYPE.ePushThreeGift,str,stamp+5)
local id=list[1].id
if pushGiftThreeController.openGift(id)then
_openedTable[id]=(_openedTable[id]or 0)+1
else
_openedTable[id]=_openMaxCnt
end
end
end
end
end
table.clear(_advertTypeListCache)



local ids=pushGiftThreeModel:getGiftIds()
if ids and#ids>0 then
local len=#ids
for i=len,1,-1 do
local id=ids[i]
if not pushGiftThreeConfig.isForver(id)and
pushGiftThreeModel:getLeftBuyTime(id)<=0 then
pushGiftThreeModel:removeGiftData(id)
end
end
end


_circleCheckCurTime=_circleCheckCurTime+0.05
if _circleCheckCurTime>=_circleCheckTime then
_circleCheckCurTime=0
pushGiftThreeManager:onTickChange()
end

_lastStamp=stamp
end)
end

function pushGiftThreeManager:resetStamp(id)
_stamp[id]=nil
end

function pushGiftThreeManager:stopTimer()
if self.tickTimer then
self.tickTimer:cancel()
end
self.tickTimer=nil
end



function pushGiftThreeManager:canOpen(openconf,args,init)
if not systemModel.isOpen(SYSTEM_DEFINE.eLimitedTimeGift3)then return false end
local checkCfg=openconf[1]
local ret=true
for i,v in ipairs(checkCfg)do
local checkType=v[1]
if args==nil and init and _initFunc[checkType]then
ret=ret and _initFunc[checkType](v)
else
ret=ret and _checkFun[checkType](v,args)
end
if not ret then return false end
end
return ret
end

function pushGiftThreeManager:onChanged(checkType,...)
if not systemModel.isOpen(SYSTEM_DEFINE.eLimitedTimeGift3)then return end
if _eventCache==nil then _eventCache={}end
_eventCache[checkType]={...}
end

function pushGiftThreeManager:freshEnter()
local ids=pushGiftThreeModel:getLimitGiftIds()
local has=#ids>0
if self.hasEnter~=has then
self.hasEnter=has
if has then
local enterInfo=
{
enterType=ENTER_TYPE.ePushGiftThree,
enterIconType=ENTER_ICON_TYPE.eNomal,
id=1,
}
self.enterGUID=enterManager:freshEnter(enterInfo)
else
if self.enterGUID then
enterManager:removeEnter(self.enterGUID)
end
self.enterGUID=nil
end
elseif self.hasEnter then
enterManager:freshFunc('onfreshGifts',ENTER_TYPE.ePushGiftThree)
end
end

function pushGiftThreeManager:removeEnter()
if self.hasEnter==true then
self.hasEnter=false
if self.enterGUID then
enterManager:removeEnter(self.enterGUID)
end
self.enterGUID=nil
end
end

function pushGiftThreeManager:onFabaoChange(isInit)
if isInit then return end
pushGiftThreeManager:onChanged(_checkType.eFabaoOverLv)
end

function pushGiftThreeManager:onDaoBingChange(isInit)
if isInit then return end
pushGiftThreeManager:onChanged(_checkType.eDaoBingJllv)
end


function pushGiftThreeManager:onTickChange()
pushGiftThreeManager:onChanged(_checkType.eDelayOpen)
end


function pushGiftThreeManager.isAdvertUnlimit()
local limit=pushGiftThreeConfig.getAdvettypeUnlimit()
local recharge=rechargeModel:getTotalRecharge()
return recharge>=limit
end

function pushGiftThreeManager:checkOtherOut(cfg)
for k,v in pairs(_otherArgsOutFunc)do
local params=cfg[k]
if v.overfunc(params)then return true end
end
return false
end


function pushGiftThreeManager:checkServerLimitOpen(serverlimit)
if serverlimit==nil then return true end

local type=serverlimit.type
local pfCfg=serverlimit.pf
local pfid=loginModel:getPfid()
local bigServerId=loginModel.cross_sid
local serverid=playerModel:getActorServerID()

if type==1 then
if pfCfg==nil then return true end

for k,v in pairs(pfCfg)do
if pfid==k or k==-1 then
if v==-1 then return true end
local rangeServer=v[-1]
if rangeServer==nil and#v==0 then return false end
for _,vv in ipairs(v)do
if serverid==vv then

return true
end
end
if rangeServer then
for i,vv in ipairs(rangeServer)do
if serverid>=vv[1]and serverid<=vv[2]then

return true
end
end
end
end
end
return false
elseif type==2 then
if pfCfg==nil then return false end

for k,v in pairs(pfCfg)do
if pfid==k or k==-1 then
if v==-1 then return false end
local rangeServer=v[-1]
if rangeServer==nil and#v==0 then return true end
for _,vv in ipairs(v)do
if serverid==vv then

return false
end
end
if rangeServer then
for i,vv in ipairs(rangeServer)do
if serverid>=vv[1]and serverid<=vv[2]then

return false
end
end
end
end
end
return true
elseif type==3 then
if pfCfg==nil then return true end

for k,v in pairs(pfCfg)do
if pfid==k or k==-1 then
if v==-1 then return true end
local rangeServer=v[-1]
if rangeServer==nil and#v==0 then return false end
for _,vv in ipairs(v)do
if bigServerId==vv then

return true
end
end
if rangeServer then
for i,vv in ipairs(rangeServer)do
if bigServerId>=vv[1]and bigServerId<=vv[2]then

return true
end
end
end
end
end
return false
elseif type==4 then
if pfCfg==nil then return false end

for k,v in pairs(pfCfg)do
if pfid==k or k==-1 then
if v==-1 then return false end
local rangeServer=v[-1]
if rangeServer==nil and#v==0 then return true end
for _,vv in ipairs(v)do
if bigServerId==vv then

return false
end
end
if rangeServer then
for i,vv in ipairs(rangeServer)do
if bigServerId>=vv[1]and bigServerId<=vv[2]then

return false
end
end
end
end
end
return true
else
loggerUtil.debugErrFMT('礼包serverlimit尚未支持类型：{0}',type)
end
return false
end
