











firstRechargeController=gameState.addListener({})






function firstRechargeController:onAppStart()

firstRechargeModel:onAppStart()


socketManager:register_receiver(14,5,firstRechargeController.recv_14_5)
socketManager:register_receiver(14,6,firstRechargeController.recv_14_6)
socketManager:register_receiver(14,7,firstRechargeController.recv_14_7)








end


function firstRechargeController:onEnterState()
firstRechargeModel:onEnterState()
notifySystem:listenNotify(notifyConfig.onTaskChange,self.onTaskChange)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
end


function firstRechargeController:onServerDataInitFinish()
firstRechargeModel:onServerDataInitFinish()
end


function firstRechargeController:onLeaveState()
firstRechargeModel:onLeaveState()
notifySystem:removelistener(notifyConfig.onTaskChange,self.onTaskChange)
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)

if self.enterGuid then
enterManager:removeEnter(self.enterGuid)
self.enterGuid=nil
end
self.data={}
end


function firstRechargeController:onLostConnection()

end



function firstRechargeController:reqGetFirstRechargeReward(rechargeId,day)
socketManager:send_14_6(rechargeId,day)
end


function firstRechargeController.recv_14_5(len,frList)

firstRechargeModel:setFirstRechargeData(len,frList)



if systemModel.isOpen(SYSTEM_DEFINE.eFirstRecharge)then

firstRechargeModel:initShowTabList()

firstRechargeController:checkFirstRechargeEnter()
end
end


function firstRechargeController.recv_14_6(rechargeId,day)
firstRechargeModel:setFirstRechargeGotReward(rechargeId,day)

local win=UIManager:findActiveWindow('UIFirstRechargeWin')
if win then
if day==1 then

win:onDayBtnClick(day,true)
else
win:refresh()
end
end


firstRechargeController:refreshEnterObjReddot()
end


function firstRechargeController.recv_14_7(rechargeId,rechargeSec)
firstRechargeModel:setFirstRechargeBuyTime(rechargeId,rechargeSec)


firstRechargeModel:initShowTabList(true)
local win=UIManager:findActiveWindow('UIFirstRechargeWin')
if win then
win:refreshTab()
end

firstRechargeController:refreshEnterObjReddot()
end














function firstRechargeController:checkFirstRechargeEnter(needRemove)

if verifyManager:isHideBusinessActivity()then
return false
end
local isHasEnterGuidOriginal=self.enterGuid~=nil

local data,dataLen=firstRechargeModel:getFirstRechargeAllData()
local isShowEnter=false
if dataLen then

local sortCfgList=firstRechargeModel:getSortCfgList()
for k,v in ipairs(sortCfgList)do
local rechargeId=v.rechargeId
local isShow=firstRechargeModel:checkTabCanShowByRechargeId(rechargeId)
if isShow then

self.enterGuid=enterManager:freshEnter({id=1,enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eFirstRecharge,getReddotFun=function()
return firstRechargeModel:checkMainEnterReddot()
end})
isShowEnter=true
if isHasEnterGuidOriginal then

firstRechargeController:refreshEnterObjReddot()
end
return
end
end
end

if needRemove and not isShowEnter then
firstRechargeController:removeFirstRechargeEnter()
end
end


function firstRechargeController:removeFirstRechargeEnter()
if self.enterGuid then

enterManager:freshFunc('onClose',ENTER_TYPE.eFirstRecharge)
local ret=enterManager:removeEnter(self.enterGuid)
self.enterGuid=nil
if ret then

UIManager:callWindowFunc('UIMainEntryWin','freshInfo')
end
end
end


function firstRechargeController:refreshEnterObjReddot()
enterManager:freshFunc('freshReddot',ENTER_TYPE.eFirstRecharge)
end



function firstRechargeController.onTaskChange(taskid,taskstate)
if not systemModel.isOpen(SYSTEM_DEFINE.eFirstRecharge)then

return
end
if verifyManager:isHideBusinessActivity()then
return
end

if taskstate==taskModel.taskFinishState then
local faceTipsCfg=cfgHelper.get1(cfg_firstrechargefaceconfig_get,taskid)
if faceTipsCfg then
local allShowPram=faceTipsCfg.showPram
local showPram=pfwindowsModel:getVersionAndPfCfg(allShowPram)
if showPram and next(showPram)then
local rechargeId=showPram.rechargeid
local dayIndex=showPram.day or 1

if rechargeId then
local isCanShow=firstRechargeModel:checkTabCanShowByRechargeId(rechargeId)
if isCanShow then
local tabIndex=firstRechargeModel:getShowTabIndexByRechargeId(rechargeId)
if tabIndex then
UIManager:showWindow("UIFirstRechargeWin",{id=tabIndex,dayIndex=dayIndex})
end
end
else
logErr(FMT.fmt("任务id：{0}配置了首充贴脸 但是没有找到相关展示参数",taskid))
end
end
end
end
end

function firstRechargeController.on_building_event(etype,level,exp,lastLv)
if not systemModel.isOpen(SYSTEM_DEFINE.eFirstRecharge)then
return
end

if etype==buildingEvent.zongmenLevelUp then

firstRechargeModel:initShowTabList()

firstRechargeController:checkFirstRechargeEnter(true)
end
end

