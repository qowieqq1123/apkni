pushGiftManager=gameState.addListener({})

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
eLingShouJingJie=42,
eLingShouXueMai=43,
}
GIFT_CHECK_TYPE=_checkType
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
itemidlist=table.unpackEx(itemidlist)
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
dzguid=table.unpackEx(dzguid)
local _id=UIDiscipleModel:getDiscipleID(dzguid)
if _id==id then
local lv=UIDiscipleModel:getTianMingLevel(dzguid)
return lv>=needlv
end
return false
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
}


local _lookupCfg={}
local _eventCache={}
local _tempTable=nil
local _stamp={}

function pushGiftManager:onAppStart()
notifySystem:listenNotify(notifyConfig.onDiscipleJJChange,function()
pushGiftManager:onChanged(_checkType.eDZJingjie)
end)

notifySystem:listenNotify(notifyConfig.onDiscipleLTChange,function()
pushGiftManager:onChanged(_checkType.eDZLianTi)
end)

notifySystem:listenNotify(notifyConfig.onGongFaActive,function()
pushGiftManager:onChanged(_checkType.eGongFaActive)
pushGiftManager:onChanged(_checkType.eUnFinishActiveGongFa)
end)

notifySystem:listenNotify(notifyConfig.building_event,function(eventType,...)
if eventType==buildingEvent.zongmenLevelUp then
pushGiftManager:onChanged(_checkType.eZMlv)
end
end)
notifySystem:listenNotify(notifyConfig.on_system_open,function(sysid,isNew)
if sysid==SYSTEM_DEFINE.eLimitedTimeGift and initProControl.isDone()then
self:initalize()
end
pushGiftManager:onChanged(_checkType.eSystemOpen)
end)
notifySystem:listenNotify(notifyConfig.onTaskChange,function(taskid,t_taskstate)
if t_taskstate==taskModel.taskFinishState then
pushGiftManager:onChanged(_checkType.eTaskFinish)
end
end)
notifySystem:listenNotify(notifyConfig.onNewDay,function(taskid,t_taskstate)
pushGiftManager:onChanged(_checkType.eServerOpenDay)
end)

notifySystem:listenNotify(notifyConfig.on_item_list_first_get,function(itemlist)
pushGiftManager:onChanged(_checkType.eFirstGetItem,itemlist)
end)

notifySystem:listenNotify(notifyConfig.onDiscipleTianMingLvChange,function(dzguid,oldlv,lv)
pushGiftManager:onChanged(_checkType.eDZTianMing,dzguid)
end)

notifySystem:listenNotify(notifyConfig.onLingShouJJChange,function()
pushGiftManager:onChanged(_checkType.eLingShouJingJie)
end)

notifySystem:listenNotify(notifyConfig.onLingShouXMChange,function()
pushGiftManager:onChanged(_checkType.eLingShouXueMai)
end)
end

function pushGiftManager:onEnterState(isReconnect)
pushGiftManager:stopTimer()
_lookupCfg={}
_eventCache={}
_tempTable=nil
self.hasEnter=false
_stamp={}
self.isInit=false
end

function pushGiftManager:onLeaveState(isReconnect)
pushGiftManager:stopTimer()
_lookupCfg={}
_eventCache={}
_tempTable=nil
self.hasEnter=false
_stamp={}
self.isInit=false
end

function pushGiftManager:onProtocolReq()
self:initalize()
end

function pushGiftManager:initalize()
if not systemModel.isOpen(SYSTEM_DEFINE.eLimitedTimeGift)then return end
pushGiftManager:initCfg()

end


function pushGiftManager:initCfg()
if self.isInit then return end
self.isInit=true
local cfgs=pushGiftConfig.getAllConfig()
for _,v in pairs(cfgs)do
local cfg=v
local openconf=cfg.openconf
local id=cfg.id
if pushGiftModel:isCanActive(id)then
if pushGiftManager:canOpen(openconf,nil,true)then
pushGiftController.openGift(id)
else
local checkCfg=openconf[1]
for i,v in ipairs(checkCfg)do
local checkType=v[1]
if _lookupCfg[checkType]==nil then _lookupCfg[checkType]={}end
local cfgs=_lookupCfg[checkType]
cfgs[#cfgs+1]=cfg
end
end
end
end
end



function pushGiftManager:startTimer()
if self.tickTimer then return end
pushGiftManager:stopTimer()
self.tickTimer=timer.new()
self.tickTimer:start(0.3,function()
if not initProControl.isDone()then return end

if _eventCache then
for checkType,args in pairs(_eventCache)do
if#args==0 then args=nil end
local cfgs=_lookupCfg[checkType]
if cfgs then
local len=#cfgs
if len>0 then
for i=len,1,-1 do
local cfg=cfgs[i]
local id=cfg.id
if pushGiftModel:isCanActive(id)and
pushGiftManager:canOpen(cfg.openconf,args)then
pushGiftController.openGift(id)
end
end
end
end
end
_eventCache=nil
end


local stamp=timeHelper.getServerShortTime()
local expiredDatas=pushGiftModel:getAllExpiredData()
for id,v in pairs(expiredDatas)do
if pushGiftModel:isExpiredAgain(id)then

if _stamp[id]==nil or(stamp-_stamp[id])>5 then
_stamp[id]=stamp
pushGiftController.openGift(id)
end
end
end


local ids=pushGiftModel:getGiftIds()
if ids and#ids>0 then
local len=#ids
for i=len,1,-1 do
local id=ids[i]
if pushGiftModel:getLeftBuyTime(id)<=0 then
pushGiftModel:removeGiftData(id)
end
end
end
end)
end

function pushGiftManager:resetStamp(id)
_stamp[id]=nil
end

function pushGiftManager:stopTimer()
if self.tickTimer then
self.tickTimer:cancel()
end
self.tickTimer=nil
end



function pushGiftManager:canOpen(openconf,args,init)
if not systemModel.isOpen(SYSTEM_DEFINE.eLimitedTimeGift)then return false end
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

function pushGiftManager:onChanged(checkType,...)
if not systemModel.isOpen(SYSTEM_DEFINE.eLimitedTimeGift)then return end
if _eventCache==nil then _eventCache={}end
_eventCache[checkType]={...}
end

function pushGiftManager:freshEnter()
local ids=pushGiftModel:getGiftIds()
local has=#ids>0
if self.hasEnter~=has then
self.hasEnter=has
if has then
local enterInfo=
{
enterType=ENTER_TYPE.ePushGift,
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
end
end

function pushGiftManager:removeEnter()
if self.hasEnter==true then
self.hasEnter=false
if self.enterGUID then
enterManager:removeEnter(self.enterGUID)
end
self.enterGUID=nil
end
end
