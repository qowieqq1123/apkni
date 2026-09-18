









local subActivityInfo_doubleLottery={name='doubleLottery'}

function subActivityInfo_doubleLottery:onInit()

self:listenNotify(notifyConfig.onShowPrize,function(...)
self:onShowPrize(...)
end)
end

function subActivityInfo_doubleLottery:onStart()

end

function subActivityInfo_doubleLottery:onDelete()

end

function subActivityInfo_doubleLottery:checkReddot()
if not self.data then

return false
end


if self:checkTargetReddot()then
return true
end


for i=1,2 do
if self:checkBoxReddotByIndex(i)then
return true
end
end

return false
end

function subActivityInfo_doubleLottery:checkBoxReddotByIndex(boxIndex)
local remainingDrawCount=self:getRemainingFreeDrawCount(boxIndex)
if remainingDrawCount>0 then

return true
end


local costCfg=self:getSubActConfig("box_cost_item")
local drawType=1
local drawCount=self:getSubActConfig("lottery_list")[drawType]
local itemId=costCfg[boxIndex][1]
local itemNum=costCfg[boxIndex][2]
local needCnt=itemNum*drawCount
local have=itemsModel.getCount(itemId)
return have>=needCnt
end

function subActivityInfo_doubleLottery:checkTargetReddot()
local targetCfgList=self:getSubActConfig("target_reward")
local maxFinishCount=self.data.maxFinishCount or 0
local maxGotRewardIndex=self.data.maxGotRewardIndex or 0

for i,v in ipairs(targetCfgList)do
local targetCount=v[1]
local isFinish=maxFinishCount>=targetCount
local isGot=maxGotRewardIndex>=i
if isFinish and not isGot then
return true
end
end
return false
end

function subActivityInfo_doubleLottery:onShowPrize(prizeType,rewards,effectData)
if prizeType~=ePrizeType.eDoubleLotteryBatch or self.act_id~=effectData.actid or self.sub_act_id~=effectData.act2id then
return
end

local remainCount=effectData.remain_times or 0
local freeResetTime=effectData.free_sec
local maxFinishCount=effectData.target_progress
local useFreeCount=effectData.use_free_times or 0
local boxId=effectData.box_id
if self.data then
self.data.freeResetTime=freeResetTime
self.data.maxFinishCount=maxFinishCount

if self.data.boxDrawCountList then
if not self.data.boxDrawCountList[boxId]then
self.data.boxDrawCountList[boxId]={}
end

self.data.boxDrawCountList[boxId].drawCount=remainCount
self.data.boxDrawCountList[boxId].useFreeCount=useFreeCount
end
end

local args={
list=rewards,
selectBoxIndex=boxId,
effect={},
act_id=self.act_id,
sub_act_type=self.sub_act_type,
sub_act_id=self.sub_act_id,
}

local callback=function()
UIManager:showWindow('UISubAct_doubleLottery_PrizeWin',args)

UIManager:invokeUIMethod("UISubAct_doubleLotteryWin","refresh")
UIManager:invokeUIMethod("UISubAct_doubleLottery_TargetWin","refresh",true)


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
end

local isSkipAnim=userActorSetting.get('skipDoubleLotteryAnim',false)
if not isSkipAnim and UIManager:isActive('UISubAct_doubleLotteryWin')then
local maxItemColor=eQualityColor.eWhite
for i,v in ipairs(rewards)do
local cfg=itemsConfig.getConfig(v.itemid)
maxItemColor=math.max(maxItemColor,cfg.color)
end
UIManager:invokeUIMethod("UISubAct_doubleLotteryWin","playLotteryAnim",maxItemColor,boxId,callback)
else
callback()
end
end

function subActivityInfo_doubleLottery:getRemainingFreeDrawCount(boxIndex)
local dailyFreeCount=self:getSubActConfig("free_times")or 0
local drawFreeCount=self.data.boxDrawCountList[boxIndex]and self.data.boxDrawCountList[boxIndex].useFreeCount or 0
local remainingDrawCount=dailyFreeCount-drawFreeCount
return remainingDrawCount
end


function subActivityInfo_doubleLottery:reqDoubleLotteryDraw(boxIndex,drawType)
local remainingDrawCount=self:getRemainingFreeDrawCount(boxIndex)
if drawType~=1 or remainingDrawCount<=0 then

local costCfg=self:getSubActConfig("box_cost_item")
local drawCount=self:getSubActConfig("lottery_list")[drawType]
local itemId=costCfg[boxIndex][1]
local itemNum=costCfg[boxIndex][2]
local needCnt=itemNum*drawCount
local have=itemsModel.getCount(itemId)
if have<needCnt then
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(itemId)))
gainControl:showCommonGainWin_item(itemId)
return
end
end

local json_str=jsonHelper.encode({1,boxIndex,drawType})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end


function subActivityInfo_doubleLottery:reqDoubleLotteryGetTargetReward()
local json_str=jsonHelper.encode({2})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end

return subActivityInfo_doubleLottery