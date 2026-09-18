






local _MODULENAME="tianJiangFuYuanController"

local _this

gameState.addListener(def_table(_MODULENAME))
tianJiangFuYuanController.name=_MODULENAME
tianJiangFuYuanController.data={}

function tianJiangFuYuanController:onAppStart()

tianJiangFuYuanModel:onAppStart()

socketManager:register_receiver(15,71,self.recv_15_71)
socketManager:register_receiver(15,72,self.recv_15_72)
socketManager:register_receiver(15,73,self.recv_15_73)

_this=self
end


function tianJiangFuYuanController:onEnterState(isReconnect)
tianJiangFuYuanModel:onEnterState()

notifySystem:listenNotify(notifyConfig.building_event,self.onZongMengLevelChange)
notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
notifySystem:listenNotify(notifyConfig.onDiscipleNewID,self.onDiscipleNewID)
end


function tianJiangFuYuanController:onProtocolReq()
tianJiangFuYuanModel:onProtocolReq()
tianJiangFuYuanController.doCommonCheckReqOpen()
end


function tianJiangFuYuanController:onProtocolReqKF()
tianJiangFuYuanController.doCommonCheckReqOpen()
end


function tianJiangFuYuanController:onLeaveState(isReconnect)
tianJiangFuYuanModel:onLeaveState(isReconnect)

self.data={}

notifySystem:removelistener(notifyConfig.building_event,self.onZongMengLevelChange)
notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
notifySystem:removelistener(notifyConfig.onShowPrize,self.onShowPrize)

if self.actEnterId then
enterManager:removeEnter(self.actEnterId)
self.actEnterId=nil
end
end


function tianJiangFuYuanController:onLostConnection()
timeEventController.removeNormalTimerHandler(1,_this.name)
end


function tianJiangFuYuanController:onReConnection(isInitPro)

end


function tianJiangFuYuanController:req_15_72(len,reqOpenList)
socketManager:send_15_72(len,reqOpenList)
end

function tianJiangFuYuanController:req_15_73(theme_id)
socketManager:send_15_73(theme_id)
end

function tianJiangFuYuanController.recv_15_71(len,theme_list)
tianJiangFuYuanModel:setServerInitData(len,theme_list or{})

tianJiangFuYuanController.doCommonCheckReqOpen()

tianJiangFuYuanController:freshActEnter()
end

function tianJiangFuYuanController.recv_15_72(len,theme_list)
tianJiangFuYuanModel:checkHasThemeDue()

tianJiangFuYuanModel:setServerAddData(len,theme_list or{})

tianJiangFuYuanController:freshActEnter()
end

function tianJiangFuYuanController.recv_15_73(theme_id,recv_gift_id)
tianJiangFuYuanModel:setThemeState(theme_id,recv_gift_id)

tianJiangFuYuanModel:checkHasThemeDue()

local themeList=tianJiangFuYuanModel:getThemeList()
if#themeList==0 then
if fullScreenUI.isActiveFullEx(FULL_TYPE.eTianJiangFuYuan,'UITianjiangfuyuanWin')then
UIFullTianJiangFuYuanControl:closeUI()
else
UIManager:closeWindow('UITianjiangfuyuanWin')
end
else
UIManager:invokeUIMethod('UITianjiangfuyuanWin','refreshAll')
end

tianJiangFuYuanController:freshActEnter()
end

function tianJiangFuYuanController:freshActEnter()

if verifyManager:isHideBusinessActivity()then
return false
end

if tianJiangFuYuanModel:checkActEnterOpen()and systemModel.isOpen(SYSTEM_DEFINE.eThemeGift)then
if self.actEnterId==nil then
self.actEnterId=enterManager:freshEnter({enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eTianJiangFuyuan,getReddotFun=function()
return tianJiangFuYuanModel:checkActEnterReddot()
end})
else
enterManager:freshFunc('freshReddot',ENTER_TYPE.eTianJiangFuyuan)
enterManager:freshFunc('startLeftTimer',ENTER_TYPE.eTianJiangFuyuan)
end
else
if self.actEnterId then
enterManager:removeEnter(self.actEnterId)
self.actEnterId=nil
end
end
end

function tianJiangFuYuanController:clickActEnter()
if tianJiangFuYuanModel:checkActEnterOpen()and systemModel.isOpen(SYSTEM_DEFINE.eThemeGift)then
UIFullTianJiangFuYuanControl:showMainWindow()
end
end

function tianJiangFuYuanController.onZongMengLevelChange(type,level,exp,lastlv)
if type==buildingEvent.zongmenLevelUp and level~=lastlv then

local reqOpenList=tianJiangFuYuanModel:getOpenList()

local len=#reqOpenList
if len>0 then
tianJiangFuYuanModel:setServerTempData(reqOpenList)
tianJiangFuYuanController:req_15_72(len,reqOpenList)
end
end
end

function tianJiangFuYuanController.on_home_event(etype)
if not systemModel.isOpen(SYSTEM_DEFINE.eThemeGift)then return end

if etype==homeEvent.eEnterHome then
timeEventController.addNormalTimerHandler(1,_this.name,_this)
elseif etype==homeEvent.eLeaveHome then
timeEventController.removeNormalTimerHandler(1,_this.name)
end
end

function tianJiangFuYuanController.on_system_open(sysid,isNoInit)
if sysid==SYSTEM_DEFINE.eThemeGift then
local lv=zongmenModel:getLevel()
tianJiangFuYuanController.onZongMengLevelChange(buildingEvent.zongmenLevelUp,lv)
timeEventController.addNormalTimerHandler(1,_this.name,_this)
end
if isNoInit then
tianJiangFuYuanController.doCommonCheckReqOpen()
end
end

function tianJiangFuYuanController.onShowPrize(prizeType,prizelist,effectData)
if prizeType==ePrizeType.eTianJiangFuYuan then
if UIManager:isActive('UITianjiangfuyuanWin')then
showPrizeControl.showWindow(prizelist,nil,nil)
end
end
end

function tianJiangFuYuanController.onDiscipleNewID(guid,id)
local reqOpenList=tianJiangFuYuanModel:getOpenList()

local len=#reqOpenList
if len>0 then
tianJiangFuYuanModel:setServerTempData(reqOpenList)
tianJiangFuYuanController:req_15_72(len,reqOpenList)
end
end


function tianJiangFuYuanController.doCommonCheckReqOpen()
local reqOpenList=tianJiangFuYuanModel:getOpenList()

local len=#reqOpenList
if len>0 then
tianJiangFuYuanModel:setServerTempData(reqOpenList)
tianJiangFuYuanController:req_15_72(len,reqOpenList)
end
end


function tianJiangFuYuanController:onNormalUpdate(delay)

if tianJiangFuYuanModel:checkActEnterOpen()then
if tianJiangFuYuanModel:checkHasThemeDue()then
tianJiangFuYuanController:freshActEnter()
local themeList=tianJiangFuYuanModel:getThemeList()
local themeNum=#themeList
local oldThemeNum=self.oldThemeNum or 0
if themeNum==0 then
if fullScreenUI.isActiveFullEx(FULL_TYPE.eTianJiangFuYuan,'UITianjiangfuyuanWin')then
UIFullTianJiangFuYuanControl:closeUI()
else
UIManager:closeWindow('UITianjiangfuyuanWin')
end
else
if themeNum~=oldThemeNum then
UIManager:invokeUIMethod('UITianjiangfuyuanWin','refreshAll')
self.oldThemeNum=themeNum
end
end
end
end
end


function tianJiangFuYuanController:checkServerLimitOpen(serverlimit)
if serverlimit==nil then return true end

local _type=serverlimit.type
local pfCfg=serverlimit.pf
local pfid=loginModel:getPfid()
local bigServerId=loginModel.cross_sid or 0
local serverid=playerModel:getActorServerID()
if _type==1 then
if pfCfg==nil then return true end

for k,v in pairs(pfCfg)do
if pfid==k or k==-1 then
if v==-1 then return true end
local rangeServer=v
local v_type=type(v)
if v_type=='number'then
if v==bigServerId then
return true
end
elseif v_type=='table'then
for i,vv in ipairs(rangeServer)do
if bigServerId>=vv[1]and bigServerId<=vv[2]then
return true
end
end
end
end
end
return false
elseif _type==2 then
if pfCfg==nil then return false end

for k,v in pairs(pfCfg)do
if pfid==k or k==-1 then
if v==-1 then return false end
local rangeServer=v
local v_type=type(v)
if v_type=='number'then
if v==bigServerId then
return false
end
elseif v_type=='table'then
for i,vv in ipairs(rangeServer)do
if bigServerId>=vv[1]and bigServerId<=vv[2]then
return false
end
end
end
end
end
return true
elseif _type==3 then
if pfCfg==nil then return true end

for k,v in pairs(pfCfg)do
if pfid==k or k==-1 then
if v==-1 then return true end
local rangeServer=v
local v_type=type(v)
if v_type=='number'then
if v==bigServerId then
return true
end
elseif v_type=='table'then
for i,vv in ipairs(rangeServer)do
if bigServerId>=vv[1]and bigServerId<=vv[2]then
return true
end
end
end
end
end
return false
elseif _type==4 then
if pfCfg==nil then return false end

for k,v in pairs(pfCfg)do
if pfid==k or k==-1 then
if v==-1 then return false end
local rangeServer=v
local v_type=type(v)
if v_type=='number'then
if v==bigServerId then
return false
end
elseif v_type=='table'then
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
loggerUtil.debugErrFMT('天降福缘serverlimit尚未支持类型：{0}',_type)
end
return false
end



