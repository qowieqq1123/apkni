









local subActivityInfo_totalRechargeRole={name='totalRechargRole'}

function subActivityInfo_totalRechargeRole:onInit()

end

function subActivityInfo_totalRechargeRole:onStart()
self.onRechargeFunc=function(...)self:onRecharge(...)end
self:listenNotify(notifyConfig.onRecharge,self.onRechargeFunc)
end

function subActivityInfo_totalRechargeRole:onDelete()





end

function subActivityInfo_totalRechargeRole:checkReddot()
local reddot=false
if not self.data then

return reddot
end


local isGotFree=self:reqTotalRecharge_checkFreeRewardsIsGot()
if not isGotFree then
return true
end


local allTaskCfgList=self:getSubActConfig('recharge')
local totalRechargeNum=self.data.totalRechargeNum or 0
for index,v in ipairs(allTaskCfgList)do
local targetRechargeNum=v[1]
local isFinish=totalRechargeNum>=targetRechargeNum
local isGot=self:checkTaskIsGot(index)
if isFinish and not isGot then
return true
end
end

return reddot
end

function subActivityInfo_totalRechargeRole:onRecharge(firstFlag,lastTotalRecharge,totalRecharge,lastDailyRecharge,dailyRecharge)
if not self.data then

return
end
local deltaRechargeNum=totalRecharge-lastTotalRecharge
self.data.totalRechargeNum=self.data.totalRechargeNum+deltaRechargeNum

local openPanel=self:getSubActConfig('openPanel')
for i,v in ipairs(openPanel)do
local sub_panelType=v[1]
local sub_panelcfg=cfgHelper.get1(cfg_subactivityspanelconfig_get,sub_panelType)
if sub_panelcfg then
local winName=sub_panelcfg.panelname
local win=UIManager:findActiveWindow(winName)
if win then
win:refresh()
end
end
end


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
end

function subActivityInfo_totalRechargeRole:getSelectData(taskIndex,rewardIndex)
if self.data.selectData and self.data.selectData[taskIndex]then
return self.data.selectData[taskIndex][rewardIndex]or 0
end
return 0
end

function subActivityInfo_totalRechargeRole:getSelectDataByTaskIndex(taskIndex)
if self.data.selectData then
return self.data.selectData[taskIndex]
end
end

function subActivityInfo_totalRechargeRole:setSelectData(taskIndex,rewardIndex,selectIndex)
self.data.selectData=self.data.selectData or{}
self.data.selectData[taskIndex]=self.data.selectData[taskIndex]or{}
self.data.selectData[taskIndex][rewardIndex]=selectIndex
end

function subActivityInfo_totalRechargeRole:checkTaskIsGot(taskIndex)
if not self.data then

return false
end

local rewardFlag=self.data.rewardFlag
return mathHelper.getBitValue(rewardFlag,taskIndex-1)
end


function subActivityInfo_totalRechargeRole:reqTotalRecharge_checkFreeRewardsIsGot()

local giftid=self:getSubActConfig('freeLibaoId')
local data={self.act_id,self.sub_act_type,self.sub_act_id}
return not FreeGiftController.GetFreeGift(giftid,data)
end


function subActivityInfo_totalRechargeRole:reqTotalRecharge_getFreeRewards()

local giftid=self:getSubActConfig('freeLibaoId')
local data={self.act_id,self.sub_act_type,self.sub_act_id}
local subType=self.sub_act_type
return FreeGiftController.SendFreeGift(giftid,data,function(result)
if result then

local openPanel=self:getSubActConfig('openPanel')
for i,v in ipairs(openPanel)do
local sub_panelType=v[1]
local sub_panelcfg=cfgHelper.get1(cfg_subactivityspanelconfig_get,sub_panelType)
if sub_panelcfg then
local winName=sub_panelcfg.panelname
local win=UIManager:findActiveWindow(winName)
if win then
win:refresh()
end
end
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
end)
end


function subActivityInfo_totalRechargeRole:reqTotalRecharge_getTaskReward(taskIndexlist)
local json_str=jsonHelper.encode({3,taskIndexlist})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end

function subActivityInfo_totalRechargeRole:reqTotalRecharge_selectTaskReward(taskIndex,selectList)
local json_str=jsonHelper.encode({2,taskIndex,selectList})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end

return subActivityInfo_totalRechargeRole