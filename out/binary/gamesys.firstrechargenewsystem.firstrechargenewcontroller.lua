








firstRechargeNewController=gameState.addListener({})





function firstRechargeNewController:onAppStart()

firstRechargeNewModel:onAppStart()


socketManager:register_receiver(14,20,firstRechargeNewController.recv_14_20)
socketManager:register_receiver(14,21,firstRechargeNewController.recv_14_21)
socketManager:register_receiver(14,22,firstRechargeNewController.recv_14_22)












end


function firstRechargeNewController:onEnterState(isReconnect)
firstRechargeNewModel:onEnterState()
notifySystem:listenNotify(notifyConfig.onTaskChange,self.onTaskChange)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
end


function firstRechargeNewController:onProtocolReq()
firstRechargeNewModel:onProtocolReq()
end


function firstRechargeNewController:onLeaveState(isReconnect)
firstRechargeNewModel:onLeaveState(isReconnect)
notifySystem:removelistener(notifyConfig.onTaskChange,self.onTaskChange)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)

if self.enterGuid then
enterManager:removeEnter(self.enterGuid)
self.enterGuid=nil
end

self.data={}
end


function firstRechargeNewController:onLostConnection()

end


function firstRechargeNewController:onReConnection(isInitPro)
firstRechargeNewController:checkFirstRechargeEnter(true)
end




function firstRechargeNewController:reqGetFirstRechargeReward(rechargeId,day)
socketManager:send_14_21(rechargeId,day)
end




function firstRechargeNewController.recv_14_20(len,rechargeInfo)

firstRechargeNewModel:setFirstRechargeData(len,rechargeInfo)



if systemModel.isOpen(SYSTEM_DEFINE.eFirstRecharge2)then

firstRechargeNewModel:initShowTabList()

firstRechargeNewController:checkFirstRechargeEnter()
end
end




function firstRechargeNewController.recv_14_21(recharge_id,day)
firstRechargeNewModel:setFirstRechargeGotReward(recharge_id,day)

local win=UIManager:findActiveWindow('UIFirstRechargeWin2')
if win then
if day==1 then

win:onDayBtnClick(day,true)
else
win:refresh()
end
end


firstRechargeNewController:refreshEnterObjReddot()
end




function firstRechargeNewController.recv_14_22(recharge_id,recharge_sec)
firstRechargeNewModel:setFirstRechargeBuyTime(recharge_id,recharge_sec)


firstRechargeNewModel:initShowTabList(true)
local win=UIManager:findActiveWindow('UIFirstRechargeWin2')
if win then
win:refreshTab()
end

firstRechargeNewController:refreshEnterObjReddot()
end





function firstRechargeNewController:checkFirstRechargeEnter(needRemove)
if not systemModel.isOpen(SYSTEM_DEFINE.eFirstRecharge2)then
return false
end


if verifyManager:isHideBusinessActivity()then
return false
end
local isHasEnterGuidOriginal=self.enterGuid~=nil

local data,dataLen=firstRechargeNewModel:getFirstRechargeAllData()
local isShowEnter=false
if dataLen then

local sortCfgList=firstRechargeNewModel:getSortCfgList()
for k,v in ipairs(sortCfgList)do
local rechargeId=v.rechargeId
local isShow=firstRechargeNewModel:checkTabCanShowByRechargeId(rechargeId)
if isShow then

self.enterGuid=enterManager:freshEnter({id=2,enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eFirstRecharge2,getReddotFun=function()
return firstRechargeNewModel:checkMainEnterReddot()
end})
isShowEnter=true
if isHasEnterGuidOriginal then

firstRechargeNewController:refreshEnterObjReddot()
end
return
end
end
end

if needRemove and not isShowEnter then
firstRechargeNewController:removeFirstRechargeEnter()
end
end


function firstRechargeNewController:removeFirstRechargeEnter()
if self.enterGuid then

enterManager:freshFunc('onClose',ENTER_TYPE.eFirstRecharge2)
local ret=enterManager:removeEnter(self.enterGuid)
self.enterGuid=nil
if ret then

UIManager:callWindowFunc('UIMainEntryWin','freshInfo')
end
end
end


function firstRechargeNewController:refreshEnterObjReddot()
enterManager:freshFunc('freshReddot',ENTER_TYPE.eFirstRecharge2)
end



function firstRechargeNewController.onTaskChange(taskid,taskstate)
if not systemModel.isOpen(SYSTEM_DEFINE.eFirstRecharge2)then

return
end

if taskstate==taskModel.taskFinishState then
local faceTipsCfg=cfgHelper.get1(cfg_firstrecharge2faceconfig_get,taskid)
if faceTipsCfg then
local allShowPram=faceTipsCfg.showPram
local showPram=pfwindowsModel:getVersionAndPfCfg(allShowPram)
if showPram and next(showPram)then
local rechargeId=showPram.rechargeid
local dayIndex=showPram.day or 1

if rechargeId then
local isCanShow=firstRechargeNewModel:checkTabCanShowByRechargeId(rechargeId)
if isCanShow then
local tabIndex=firstRechargeNewModel:getShowTabIndexByRechargeId(rechargeId)
if tabIndex then
UIManager:showWindow("UIFirstRechargeWin2",{id=tabIndex,dayIndex=dayIndex})
end
end
else
logErr(FMT.fmt("任务id：{0}配置了首充贴脸 但是没有找到相关展示参数",taskid))
end
end
end
end
end

function firstRechargeNewController.on_building_event(etype,level,exp,lastLv)
if not systemModel.isOpen(SYSTEM_DEFINE.eFirstRecharge2)then
return
end

if etype==buildingEvent.zongmenLevelUp then

firstRechargeNewModel:initShowTabList()

firstRechargeNewController:checkFirstRechargeEnter(true)
end
end


function firstRechargeNewController.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eFirstRecharge2 then
firstRechargeNewController:checkFirstRechargeEnter()
end
end