









local subActivityInfo_jiucengyaolou={name='jiucengyaolou'}

function subActivityInfo_jiucengyaolou:onInit()

end

function subActivityInfo_jiucengyaolou:onStart()
self:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
end

function subActivityInfo_jiucengyaolou:onDelete()

end

function subActivityInfo_jiucengyaolou:checkReddot()
if not self.data then

return false
end
for i=1,#self.data.monidxList do
if self:canGotReward(i)==1 then
return true
end

if self:isJXGetReward(i,true)then
return true
end
end

return false
end

function subActivityInfo_jiucengyaolou:findNotJXClearLayer()
if not self.data then

return
end
for i=1,#self.data.monidxList do
if not self:isJXGetReward(i)then
return i
end
end
end

function subActivityInfo_jiucengyaolou:canGotReward(floor)
if not self.data then

return 0
end
self.data.passList=self.data.passList or{}
self.data.recvList=self.data.recvList or{}
local passData=self.data.passList[floor]
local recvData=self.data.recvList[floor]
if passData~=nil then
local times=recvData or 0
if times==0 then
return 1
else
return 0
end
end
return 0
end

function subActivityInfo_jiucengyaolou:getRewardGotTimes(floor)
if not self.data then

return 0
end
self.data.passList=self.data.passList or{}
self.data.recvList=self.data.recvList or{}
local passData=self.data.passList[floor]
local recvData=self.data.recvList[floor]
if passData~=nil then
local times=recvData or 0
return times
end
return 0
end

function subActivityInfo_jiucengyaolou.onShowPrize(prizeType,rewards,effectData)
if prizeType==ePrizeType.eJiuCengYaoLou then
local fightData=activitiesHandle_jiucengyaolou:popFightData()
if fightData then
local result=fightData[1]
local log=fightData[2]
local otherData=fightData[3]
otherData.rewards=rewards
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.jiucengyaolou,result,log,otherData)
else
logErr("九层妖楼没有存入战报数据")
end
end
end

function subActivityInfo_jiucengyaolou:getFloorLog(floor,isReq)
if not self.data then
return
end
self.data.logList=self.data.logList or{}
local list=self.data.logList
if list then

if list.logStamp and timeHelper.getServerShortTime()<=list.logStamp+2 then
return self.data.logList
end
end
if isReq then
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,jsonHelper.encode({3,floor}))
end
end

function subActivityInfo_jiucengyaolou:getJiXianJiangLi(isReq)
if not self.data then
return
end
self.data.jixianlogList=self.data.jixianlogList or{}
local list=self.data.jixianlogList
if list then

if list.logStamp and timeHelper.getServerShortTime()<=list.logStamp+2 then
return self.data.jixianlogList
end
end
if isReq then
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,jsonHelper.encode({5}))
end
end

function subActivityInfo_jiucengyaolou:checkJXReddot()
if not self.data then

return false
end
for i=1,#self.data.monidxList do
if self:isJXGetReward(i,true)then
return true
end
end

return false
end

function subActivityInfo_jiucengyaolou:isJXGetReward(floor,checkGot)
if not self.data then
return false
end
local num=activitiesHandle_jiucengyaolou:get_jixianCiTiaoNum(self.sub_act_id,floor)
if num then
local passData=self.data.passList[floor]or 0
if checkGot then
local isGot=self:isJXGot(floor)
return passData>=num and(not isGot)
else
return passData>=num
end

end
end

function subActivityInfo_jiucengyaolou:isJXGot(floor)
if not self.data then
return false
end

return bitHelper.check_pos(self.data.limitFlag,floor-1)
end

return subActivityInfo_jiucengyaolou