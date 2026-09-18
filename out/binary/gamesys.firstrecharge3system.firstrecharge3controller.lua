






local _MODULENAME="firstRecharge3Controller"

gameState.addListener(def_table(_MODULENAME))
firstRecharge3Controller.name=_MODULENAME
firstRecharge3Controller.data={}

function firstRecharge3Controller:onAppStart()

firstRecharge3Model:onAppStart()



socketManager:register_receiver(14,23,firstRecharge3Controller.recv_14_23)
socketManager:register_receiver(14,24,firstRecharge3Controller.recv_14_24)
socketManager:register_receiver(14,25,firstRecharge3Controller.recv_14_25)






end


function firstRecharge3Controller:onEnterState(isReconnect)
firstRecharge3Model:onEnterState()
notifySystem:listenNotify(notifyConfig.onTaskChange,self.onTaskChange)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
end


function firstRecharge3Controller:onProtocolReq()
firstRecharge3Model:onProtocolReq()
end


function firstRecharge3Controller:onLeaveState(isReconnect)
firstRecharge3Model:onLeaveState(isReconnect)
notifySystem:removelistener(notifyConfig.onTaskChange,self.onTaskChange)
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)

if self.enterGuid then
enterManager:removeEnter(self.enterGuid)
self.enterGuid=nil
end
self.data={}
end


function firstRecharge3Controller:onLostConnection()

end


function firstRecharge3Controller:onReConnection(isInitPro)

end




function firstRecharge3Controller:reqGetFirstRechargeReward(rechargeId,day)
socketManager:send_14_24(rechargeId,day)
end


function firstRecharge3Controller.recv_14_23(len,frList)

firstRecharge3Model:setFirstRechargeData(len,frList)



if systemModel.isOpen(SYSTEM_DEFINE.eFirstRecharge3)then

firstRecharge3Model:initShowTabList()

firstRecharge3Controller:checkFirstRechargeEnter()
end
end


function firstRecharge3Controller.recv_14_24(rechargeId,day)
firstRecharge3Model:setFirstRechargeGotReward(rechargeId,day)

local win=UIManager:findActiveWindow('UIFirstRechargeWin3')
if win then
if day==1 then

win:onDayBtnClick(day,true)
else
win:refresh()
end
end


firstRecharge3Controller:refreshEnterObjReddot()
end


function firstRecharge3Controller.recv_14_25(rechargeId,rechargeSec)
firstRecharge3Model:setFirstRechargeBuyTime(rechargeId,rechargeSec)


firstRecharge3Model:initShowTabList(true)
local win=UIManager:findActiveWindow('UIFirstRechargeWin3')
if win then
win:refreshTab()
end

firstRecharge3Controller:refreshEnterObjReddot()
end





function firstRecharge3Controller:checkFirstRechargeEnter(needRemove)
if not systemModel.isOpen(SYSTEM_DEFINE.eFirstRecharge3)then
return false
end


if verifyManager:isHideBusinessActivity()then
return false
end
local isHasEnterGuidOriginal=self.enterGuid~=nil

local data,dataLen=firstRecharge3Model:getFirstRechargeAllData()
local isShowEnter=false
if dataLen then

local sortCfgList=firstRecharge3Model:getSortCfgList()
for k,v in ipairs(sortCfgList)do
local rechargeId=v.rechargeId
local isShow=firstRecharge3Model:checkTabCanShowByRechargeId(rechargeId)
if isShow then

self.enterGuid=enterManager:freshEnter({id=1,enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eFirstRecharge3,getReddotFun=function()
return firstRecharge3Model:checkMainEnterReddot()
end})
isShowEnter=true
if isHasEnterGuidOriginal then

firstRecharge3Controller:refreshEnterObjReddot()
end
return
end
end
end

if needRemove and not isShowEnter then
firstRecharge3Controller:removeFirstRechargeEnter()
end
end


function firstRecharge3Controller:removeFirstRechargeEnter()
if self.enterGuid then

enterManager:freshFunc('onClose',ENTER_TYPE.eFirstRecharge3)
local ret=enterManager:removeEnter(self.enterGuid)
self.enterGuid=nil
if ret then

UIManager:callWindowFunc('UIMainEntryWin','freshInfo')
end
end
end


function firstRecharge3Controller:refreshEnterObjReddot()
enterManager:freshFunc('freshReddot',ENTER_TYPE.eFirstRecharge3)
end


function firstRecharge3Controller.onTaskChange(taskid,taskstate)
if not systemModel.isOpen(SYSTEM_DEFINE.eFirstRecharge3)then

return
end

if taskstate==taskModel.taskFinishState then
local faceTipsCfg=cfgHelper.get1(cfg_firstrecharge3faceconfig_get,taskid)
if faceTipsCfg then
local allShowPram=faceTipsCfg.showPram
local showPram=pfwindowsModel:getVersionAndPfCfg(allShowPram)
if showPram and next(showPram)then
local rechargeId=showPram.rechargeid
local dayIndex=showPram.day or 1

if rechargeId then
local isCanShow=firstRecharge3Model:checkTabCanShowByRechargeId(rechargeId)
if isCanShow then
local tabIndex=firstRecharge3Model:getShowTabIndexByRechargeId(rechargeId)
if tabIndex then
UIManager:showWindow("UIFirstRechargeWin3",{id=tabIndex,dayIndex=dayIndex})
end
end
else
logErr(FMT.fmt("任务id：{0}配置了首充贴脸 但是没有找到相关展示参数",taskid))
end
end
end
end
end

function firstRecharge3Controller.on_building_event(etype,level,exp,lastLv)
if not systemModel.isOpen(SYSTEM_DEFINE.eFirstRecharge3)then
return
end
if etype==buildingEvent.zongmenLevelUp then

firstRecharge3Model:initShowTabList()

firstRecharge3Controller:checkFirstRechargeEnter(true)
end
end

function firstRecharge3Controller.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eFirstRecharge3 then
firstRecharge3Controller:checkFirstRechargeEnter()
end
end