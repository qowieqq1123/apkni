









local subActivityInfo_shenhaixunbao={name='shenhaixunbao'}

function subActivityInfo_shenhaixunbao:onInit()

end

function subActivityInfo_shenhaixunbao:onStart()

end

function subActivityInfo_shenhaixunbao:onDelete()

end

function subActivityInfo_shenhaixunbao:checkReddot()

local nowScore=self.data.jdrwScore or 0
local gotRewardVal=self.data.jdrwMaxVal or 0
local targetCfgList=self:getProgressTargetCfgList()
for i,cfg in ipairs(targetCfgList)do
local score=cfg.score
local isGot=gotRewardVal>=score
local isFinish=nowScore>=score
if isFinish and not isGot then
return true
end
end

return false
end


function subActivityInfo_shenhaixunbao:checkNewDay()
if self:checkDoing()then
local data=self.data
if data then
data.freeNum=0

UIManager:invokeUIMethod('UISubAct_shenhaixunbaoWin','refreshCostPanel')


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eShenHaiXunBao)
end
end
end


function subActivityInfo_shenhaixunbao:getProgressTargetCfgList()
if self.data.targetCfgList then
return self.data.targetCfgList
end

local targetCfgLookup=self:getSubActConfig('jdItems')
local targetCfgList={}
for score,rewardList in pairs(targetCfgLookup)do
targetCfgList[#targetCfgList+1]={
score=score,
rewardList=rewardList,
}
end
table.sort(targetCfgList,function(a,b)
return a.score<b.score
end)
self.data.targetCfgList=targetCfgList
return targetCfgList
end

function subActivityInfo_shenhaixunbao:checkIsUnlockFastUse()
local unlockNum=self:getSubActConfig('ksxbNum')
local totalNum=self.data and self.data.xbNum or 0
return totalNum>=unlockNum,unlockNum-totalNum
end

function subActivityInfo_shenhaixunbao:getFastUseLastSelectCount()
local fastUseSelectCount=userActorSetting.get("subAct_shxb_fastUseSelectCount",nil)

return fastUseSelectCount
end

function subActivityInfo_shenhaixunbao:setFastUseLastSelectCount(count)
userActorSetting.set('subAct_shxb_fastUseSelectCount',count)
userActorSetting.flush()
end

function subActivityInfo_shenhaixunbao:reqRollDice()
local json_str=jsonHelper.encode({2,1,0})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end

function subActivityInfo_shenhaixunbao:reqRollDiceByNum(num)
local json_str=jsonHelper.encode({2,2,num})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end

function subActivityInfo_shenhaixunbao:reqGetRecordData()
local json_str=jsonHelper.encode({3})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end

function subActivityInfo_shenhaixunbao:reqGetProgressReward()
local json_str=jsonHelper.encode({1})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end

function subActivityInfo_shenhaixunbao:reqGetFastUse(useFreeNum,useItemNum)
local json_str=jsonHelper.encode({4,useFreeNum,useItemNum})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,json_str)
end

return subActivityInfo_shenhaixunbao