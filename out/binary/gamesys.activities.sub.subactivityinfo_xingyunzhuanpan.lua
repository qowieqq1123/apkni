









local subActivityInfo_xingyunzhuanpan={name='xingyunzhuanpan'}

function subActivityInfo_xingyunzhuanpan:onInit()

end

function subActivityInfo_xingyunzhuanpan:onStart()

end

function subActivityInfo_xingyunzhuanpan:onDelete()

end


function subActivityInfo_xingyunzhuanpan:onNewDay()
if self.data then
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
UIManager:invokeUIMethod('UISubAct_XYZPWin','rec_newday')
end
end

function subActivityInfo_xingyunzhuanpan:initRewardLib()
if self.data then

end
end

function subActivityInfo_xingyunzhuanpan:checkReddot()


if self.data then
if self:checkFree()then
return true
elseif self:lotteryReddot()then
return true
elseif self:checkEXChouJiang()then
return true
end
end
return false
end

function subActivityInfo_xingyunzhuanpan:lotteryReddot()
local cfg=self:getSubActConfig("itemnum")
for i,v in ipairs(cfg)do
if v~=1 and self:lotteryEnough(v)then
return true
end
end
return false
end
function subActivityInfo_xingyunzhuanpan:lotteryEnough(num)
local itemId=self:getSubActConfig("itemid")
local itemNum=num
local have=itemsModel.getCount(itemId)
return have>=itemNum
end

function subActivityInfo_xingyunzhuanpan:getJumpAnimation()
local keyStr=FMT.fmt("{0}_{1}",self.act_id,self.sub_act_id)
if self.jumpLoad==nil then
self.jumpAnimation=userActorArraySetting.get(ACTOR_SETTING_TYPE.eActSkipAnimation,keyStr,nil)
if self.jumpAnimation and timeHelper.getServerShortTime()>self.jumpAnimation[1]then
self.jumpAnimation=nil
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eActSkipAnimation,keyStr,nil)
end
self.jumpLoad=true
end
return self.jumpAnimation and self.jumpAnimation[2]or false
end

function subActivityInfo_xingyunzhuanpan:setJumpAnimation(jump)
if self.jumpAnimation==nil then
self.jumpAnimation={self.end_time,jump}
else
self.jumpAnimation[2]=jump
end
local keyStr=FMT.fmt("{0}_{1}",self.act_id,self.sub_act_id)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eActSkipAnimation,keyStr,self.jumpAnimation)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eActSkipAnimation)
end

function subActivityInfo_xingyunzhuanpan:checkFree()
if self.data then
local free_sec=self.data.free_sec

return not timeHelper.isTodayStamp(timeHelper.convertLongStamp(free_sec))
end
return false
end

function subActivityInfo_xingyunzhuanpan:checkEXChouJiang()
if self.data then
local wish_consume=self:getSubActConfig("wish_consume")
local moneyType=wish_consume[1]
local jindu=wish_consume[2]
if moneyType and jindu then
local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
if moneyVal>=jindu then
return true
end
end
end
return false
end

function subActivityInfo_xingyunzhuanpan:reqChouJiang(type)

if type==3 then
local jstr=jsonHelper.encode({1,type})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,jstr)
else

if type==1 and self:checkFree()then
local jstr=jsonHelper.encode({1,type})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,jstr)
return
end
local itemId=self:getSubActConfig("itemid")
local timesCfg=self:getSubActConfig("itemnum")
local itemNum=timesCfg[type]
local have=itemsModel.getCount(itemId)
if have>=itemNum then
local jstr=jsonHelper.encode({1,type})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,jstr)
return
end
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(itemId)))
gainControl:showGainWin(itemId)
end
end

return subActivityInfo_xingyunzhuanpan