






local _MODULENAME="fightLaunchController"




gameState.addListener(def_table(_MODULENAME))
fightLaunchController.name=_MODULENAME


fightLaunchController.data={}

local sendDelayTime=3


function fightLaunchController:onAppStart()

fightLaunchModel:onAppStart()



socketManager:register_receiver(254,22,self.recv_254_22)
socketManager:register_receiver(254,28,self.recv_254_28)





end


function fightLaunchController:onEnterState()
fightLaunchModel:onEnterState()
self.prepareFightKey=nil
end


function fightLaunchController:onServerDataInitFinish()
fightLaunchModel:onServerDataInitFinish()
end


function fightLaunchController:onLeaveState()
fightLaunchModel:onLeaveState()

self.data={}
fightLaunchModel:endInteval()
self:stopUpdate()
self.prepareFightKey=nil
end


function fightLaunchController:onLostConnection()
self:stopUpdate()
end

function fightLaunchController:onProtocolReq()
local nextSendTime=timeHelper.getServerShortTime()
fightLaunchModel:setNextSendTime(nextSendTime)
end

local sendTeamData=nil
local overTimer={}

function fightLaunchController.recv_254_22(nextSendTime)

fightLaunchModel:setNextSendTime(nextSendTime)
local now=timeHelper.getServerShortTime()
if now>=nextSendTime then
local tempFightSend=fightLaunchModel:getFightSend()
if tempFightSend then
local list=tempFightSend[1]
local o=tempFightSend[2]
local fightKey=tempFightSend[3]
fightLaunchModel:removeFightSend()
socketManager:send_254_28(#list,list,o,fightKey)
end
else
fightLaunchController:checkUpdate()
end

end

function fightLaunchController.sendNextLaunch()
local tempFightSend=fightLaunchModel:getFightSend()
if tempFightSend then
local list=tempFightSend[1]
local o=tempFightSend[2]
local fightKey=tempFightSend[3]
fightLaunchModel:removeFightSend()
socketManager:send_254_28(#list,list,o,fightKey)
end
end

function fightLaunchController:onNormalUpdate(delay)

if fightLaunchModel:isFightListEmpty()then
self:stopUpdate()
else
if not self.sendUpdateTime then
self.sendUpdateTime=0
else
self.sendUpdateTime=self.sendUpdateTime+delay
end
if self.sendUpdateTime==sendDelayTime then
self.sendUpdateTime=0
self.sendNextLaunch()
end
end
end

function fightLaunchController:checkUpdate()
if not fightLaunchModel:isFightListEmpty()and not self.fightSendTUpdate then
timeEventController.addNormalTimerHandler(1,self.name,self)
self.fightSendTUpdate=true
end
end

function fightLaunchController:stopUpdate()
timeEventController.removeNormalTimerHandler(1,self.name)
self.fightSendTUpdate=nil
self.sendUpdateTime=0
end


function fightLaunchController:setPrepareFight(fightKey)
self.prepareFightKey=fightKey
end

function fightLaunchController:isPrepareFight(fightKey)
if fightKey==nil then return false end
return self.prepareFightKey==fightKey
end


function fightLaunchController:closePrepareWindow(fightKey)
if fightLaunchController:isPrepareFight(fightKey)then
local win=UIManager:findActiveWindow("UIFightPrepareWin")
if win and win.isVisible then
win.needClosePreSelectStage=true
win:onCancelButton()
end
end
end

function fightLaunchController:closeOverBattleWindow(fightType)
local battleContinueType=fightModel:getBattleContinueType()
if battleContinueType~=nil then
local handle=fightBattleHandle:getHandle(battleContinueType)
if handle and handle.launchType==fightType then
fightManager.clearStage()
fightManager.resetCamera(false)
UIFullFightControl:closeUI(true)

end
end
end


function fightLaunchController.send_254_28(fightType,fightList,other,isBack)
local fightKey=fightLaunchModel:getFightSendKey()

if not isBack then
if UIManager:isActive('UIFightPrepareWin')then
fightLaunchController:setPrepareFight(fightKey)
end
end
local nextSendTime=fightLaunchModel:getNextSendTime()
local now=timeHelper.getServerShortTime()
if nextSendTime and now<nextSendTime+1 then
loggerUtil.warn("战斗协议发送cd中",serializeHelper.serialize(other))
fightLaunchModel:insertFightSend(fightList,other,not isBack,fightKey)
fightLaunchController:checkUpdate()
else
socketManager:send_254_28(#fightList,fightList,other,fightKey)
fightLaunchModel:setNextSendTime(now+3)
end

if not isBack then
overTimer[fightKey]=timeEventController.delayDo(10,function()
fightLaunchController:closePrepareWindow(fightKey)
fightLaunchController:closeOverBattleWindow(fightType)
notifySystem:postNotify(notifyConfig.onBattleSendOverTime,fightType,fightKey)
end)
end
return fightKey
end

function fightLaunchController.recv_254_28(fightlistlen,fightList,other,guid)

if overTimer[guid]then
overTimer[guid]:cancel()
overTimer[guid]=nil
end

local teamData=fightLaunchController.sendTeamData

local teamNum=nil
if teamData~=nil then
teamNum=#teamData
end

fightLaunchController.sendTeamData=nil
if fightlistlen==1 then
local fightLog=""
if fightList[1].list then
for i,v in ipairs(fightList[1].list)do
fightLog=FMT.fmt("{0}{1}",fightLog,v)
end
end
fightList[1].fightLog=fightLog
fightLaunchController.recv_one_fight(fightList[1].result,fightList[1].fightLog,other,teamNum,guid)
elseif fightlistlen>1 then
fightLaunchController.recv_more_fight(fightList,other,teamNum,guid)
elseif fightlistlen==0 then
local fightType=other.fighttype
if eBattleLoseClosePrepare[fightType]then
if fullScreenUI.isActiveFullEx(FULL_TYPE.eFightPrepare)then
local win=UIManager:findActiveWindow("UIFightPrepareWin")
if win then
win.needClosePreSelectStage=true
win:onCancelButton()
end

end
fightLaunchController.recv_one_fight(nil,nil,other,teamNum,guid)
end
end
if other.fighttype==eBattleLaunch.doufatai then
webGLHelper:checkSubscribe(5)
elseif other.fighttype==eBattleLaunch.tianyuanshouchao then
webGLHelper:checkSubscribe(3)
end
end

function fightLaunchController.recv_one_fight(result,log,other,teamNum,guid)
local fightType=other.fighttype
local recvHandle=fightLaunchRecv:getHandle(fightType)

fightResultModel:printAllPackgeResult()

local prize=fightResultModel:getFightPrize(fightType)
local attribute=fightResultModel:getFightAttribute(fightType)

fightResultModel:printAllPackgeResult()

local resultIdx=nil
local reportId=nil
if log then
resultIdx=fightResultModel:setPackageResult(log,prize,attribute,teamNum)
reportId=worldFightRecordController:addRecord(fightType,result,log,prize,other)
end

if recvHandle then
recvHandle(result,resultIdx,other,guid,reportId)
else
loggerUtil.logErrFMT("没有类型{0}的通用战斗接收处理",fightType)
end
end

function fightLaunchController.recv_more_fight(fightList,other,teamNum,guid)
local fightType=other.fighttype
local recvHandle=fightLaunchRecv:getHandle(fightType)
local multiResultType=fightLaunchRecv:getRecvMulitResultType(fightType)

fightResultModel:printAllPackgeResult()

local prize=fightResultModel:getFightPrize(fightType)
local attribute=fightResultModel:getFightAttribute(fightType)

fightResultModel:printAllPackgeResult()

local logList={}
local result=fightResultType.Victory
local winCount=0
local loseCount=0
local tieCount=0
for i,v in ipairs(fightList)do
local fightLog=""
if v.list then
for i,v2 in ipairs(v.list)do
fightLog=FMT.fmt("{0}{1}",fightLog,v2)
end
end
table.insert(logList,fightLog)
if v.result==fightResultType.Victory then
winCount=winCount+1
elseif v.result==fightResultType.Lose then
loseCount=loseCount+1
elseif v.result==fightResultType.Tie then
tieCount=tieCount+1
end
end

if multiResultType==eFightMulitResultType.ResultTimes then
if winCount==loseCount then
result=fightResultType.Tie
elseif winCount>loseCount then
result=fightResultType.Victory
else
result=fightResultType.Lose
end
elseif multiResultType==eFightMulitResultType.ResultOneTimes then
if winCount>=1 then
result=fightResultType.Victory
else
result=fightResultType.Lose
end
else
if loseCount>=1 then
result=fightResultType.Lose
else
if winCount==0 and tieCount>0 then
result=fightResultType.Tie
end
end
end

local resultIdx=fightResultModel:setPackageResult(logList,prize,attribute,teamNum)

local reportId=worldFightRecordController:addRecord(fightType,result,logList,prize,other)

if recvHandle then
recvHandle(result,resultIdx,other,guid,reportId)
else
loggerUtil.logErrFMT("没有类型{0}的通用战斗接收处理",fightType)
end
end









function fightLaunchController:sendFight(fightType,teamList,map,zfId,sendFightClient,isBack)
local sendHandle=fightLaunchSend:getHandle(fightType)
if sendHandle then
local data
if sendFightClient then
data=sendHandle(fightType,unpack(sendFightClient))
else
data=sendHandle(fightType)
end
local sendCommonData={#teamList,teamList,{map or 0,zfId or 0}}
fightLaunchController.sendTeamData={sendCommonData}
return fightLaunchController.send_254_28(fightType,{sendCommonData},data,isBack)
else
loggerUtil.logErrFMT("没有类型{0}的通用战斗发送处理",fightType)
end
end




function fightLaunchController:sendFightEx(fightType,fightData,sendFightClient,isBack)
local sendHandle=fightLaunchSend:getHandle(fightType)
if sendHandle then
fightLaunchController.sendTeamData=fightData
local data
if sendFightClient then
data=sendHandle(fightType,unpack(sendFightClient))
else
data=sendHandle(fightType)
end
return fightLaunchController.send_254_28(fightType,fightData,data,isBack)
else
loggerUtil.logErrFMT("没有类型{0}的通用战斗接收处理",fightType)
end
end













