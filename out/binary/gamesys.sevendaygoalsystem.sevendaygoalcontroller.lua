











sevenDayGoalController=gameState.addListener({})




sevenDayGoalController.data={}

function sevenDayGoalController:onAppStart()

sevenDayGoalModel:onAppStart()


socketManager:register_receiver(28,1,sevenDayGoalController.recv_28_1)
socketManager:register_receiver(28,2,sevenDayGoalController.recv_28_2)
socketManager:register_receiver(28,3,sevenDayGoalController.recv_28_3)
socketManager:register_receiver(28,4,sevenDayGoalController.recv_28_4)

socketManager:register_receiver(28,6,sevenDayGoalController.recv_28_6)
socketManager:register_receiver(28,7,sevenDayGoalController.recv_28_7)





end


function sevenDayGoalController:onEnterState(isReconnect)
sevenDayGoalModel:onEnterState()
end


function sevenDayGoalController:onProtocolReq()

end


function sevenDayGoalController:onLeaveState(isReconnect)
sevenDayGoalModel:onLeaveState(isReconnect)

if self.enterGuid then
enterManager:removeEnter(self.enterGuid)
self.enterGuid=nil
end
self.data={}
end


function sevenDayGoalController:onLostConnection()

sevenDayGoalModel:setIsInitData(false)
end


function sevenDayGoalController:onReConnection(isInitPro)

sevenDayGoalController:reqSevenDayGoalData()
end



function sevenDayGoalController:reqSevenDayGoalData()
socketManager:send_28_1()
end


function sevenDayGoalController:reqGetGoalReward(day,taskId)
platformSDK.printSDK(FMT.fmt('请求领取七日试炼任务奖励 天数:{0}, 任务id:{1}',day,taskId))
socketManager:send_28_2(day,taskId)
end



function sevenDayGoalController:reqGetAllGoalReward()
platformSDK.printSDK(FMT.fmt('请求一键领取七日试炼任务奖励'))
socketManager:send_28_5()
end


function sevenDayGoalController:reqGetProgressReward(jinduPoint)
platformSDK.printSDK(FMT.fmt('请求领取七日试炼进度奖励'))
socketManager:send_28_3(jinduPoint)
end


function sevenDayGoalController:reqBuyLibao(libaoId,buyCount)
local buyNum=buyCount or 1
socketManager:send_28_4(libaoId,buyNum)
end









function sevenDayGoalController:reqEnd()
socketManager:send_28_8()
end


function sevenDayGoalController.recv_28_1(taskListLen,taskList,jiFen,jinduPoint,startTime)

sevenDayGoalModel:clearFinishDayList()
sevenDayGoalModel:setSevenDayGoalData(taskListLen,taskList,jiFen,jinduPoint,startTime)
sevenDayGoalController:checkSevenDayGoalEnter(true)


enterManager:freshFunc('freshReddot',ENTER_TYPE.eSevenDayGoal)
local win=UIManager:findActiveWindow('UISevenDayGoalWin')
if win then
win:refreshAllGoalPage()
end
end


function sevenDayGoalController.recv_28_2(len,updateTaskList)
local refreshDayList={}
if len and len>0 then
for i,updateTaskItem in pairs(updateTaskList)do
local day=updateTaskItem.day
local taskItem=updateTaskItem.taskItem
sevenDayGoalModel:setGoalDataByDayAndTaskId(day,taskItem.taskId,updateTaskItem.taskItem)

refreshDayList[day]=true
end
end

local win=UIManager:findActiveWindow('UISevenDayGoalWin')
if win then
for dayIdx,_ in pairs(refreshDayList)do
win:refreshNowGoalPage(dayIdx)
end
end


AudioManager.playAudio(503)


sevenDayGoalController:refreshSevenDayGoalEnterReddot()
end


function sevenDayGoalController.recv_28_3(jinduPoint)
sevenDayGoalModel:setProgressPoint(jinduPoint)

local win=UIManager:findActiveWindow('UISevenDayGoalWin')
if win then
win:refreshBottomPanel()
end


sevenDayGoalController:refreshSevenDayGoalEnterReddot()
end


function sevenDayGoalController.recv_28_4(libaoItem)
sevenDayGoalModel:setLibaoDataByLibaoId(libaoItem.libaoId,libaoItem)

local win=UIManager:findActiveWindow('UISevenDayGoalWin')
if win then
win:refreshNowGoalPage()
end


sevenDayGoalController:refreshSevenDayGoalEnterReddot()
end


function sevenDayGoalController.recv_28_6(len,updateTaskList)
local win=UIManager:findActiveWindow('UISevenDayGoalWin')
local refreshDayList={}
if len and len>0 then
for i,updateTaskItem in pairs(updateTaskList)do
local day=updateTaskItem.day
local taskItem=updateTaskItem.taskItem
sevenDayGoalModel:setGoalDataByDayAndTaskId(day,taskItem.taskId,updateTaskItem.taskItem)

refreshDayList[day]=true
end
end

if win then
for dayIdx,_ in pairs(refreshDayList)do
win:refreshNowGoalPage(dayIdx)
end
end


sevenDayGoalController:refreshSevenDayGoalEnterReddot()
end


function sevenDayGoalController.recv_28_7(jiFen)
sevenDayGoalModel:setJifen(jiFen)

local win=UIManager:findActiveWindow('UISevenDayGoalWin')
if win then
win:refreshBottomPanel()
end


sevenDayGoalController:refreshSevenDayGoalEnterReddot()
end















function sevenDayGoalController:checkSevenDayGoalEnter(isRecv)
if not systemModel.isOpen(SYSTEM_DEFINE.eSevenDayTarget)then
return
end

local isEnd=sevenDayGoalModel:checkIsEnd()
if isEnd==nil then

if not isRecv then

sevenDayGoalController:reqSevenDayGoalData()
else

logErr("未能正确获取到七日目标开启时间，请检查相关数据存储")
end
else
if not isEnd then

local isClose=sevenDayGoalModel:checkCloseEnterBeforeEndDay()

if not isClose then

self.enterGuid=enterManager:freshEnter({id=1,enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eSevenDayGoal,getReddotFun=function()
return sevenDayGoalModel:checkEnterReddot()
end})
end
end
end

end


function sevenDayGoalController:refreshSevenDayGoalEnterReddot()
if self.data.isRefreshEnterReddot then
self.data.needRefreshEnterReddot=true
return
end
self.data.isRefreshEnterReddot=true
enterManager:freshFunc('freshReddot_recv',ENTER_TYPE.eSevenDayGoal)
self.data.isRefreshEnterReddot=nil
if self.data.needRefreshEnterReddot then
self.data.needRefreshEnterReddot=nil
return self:refreshSevenDayGoalEnterReddot()
end
end


function sevenDayGoalController:removeSevenDayGoalEnter()

enterManager:freshFunc('onClose',ENTER_TYPE.eSevenDayGoal)
local ret=enterManager:removeEnter(self.enterGuid)
self.enterGuid=nil
if ret then

UIManager:callWindowFunc('UIMainEntryWin','freshInfo')
end
end



