









local subActivityInfo_chaoslingchi={name='subActivityInfo_chaoslingchi'}

local checkWin={
"UISubAct_ChaosLingChiExchangeTipsWin",
"UISubAct_ChaosLingChiExchangeWin",
"UI_activity_lotteryDetail",
"UI_activity_lotteryPercent",
"UI_activity_lotteryRule",
"UICommonShowPrizeThreeWin",
}

function subActivityInfo_chaoslingchi:onInit()
self:listenNotify(notifyConfig.onShowPrize,function(...)
self:onShowPrize(...)
end)
end

function subActivityInfo_chaoslingchi:onStart()

end

function subActivityInfo_chaoslingchi:onDelete()

end

function subActivityInfo_chaoslingchi:checkReddot()


if self.data then
if self:checkFree()then
return true
elseif self:exchangeReddot()then
return true
elseif self:lotteryReddot()then
return true
elseif self:targetRewardReddot()then
return true
end
end
return false
end

function subActivityInfo_chaoslingchi:exchangeReddot()
if self.data then
local moneyType=self:getSubActConfig("money")[1]
local money=moneyModel.getMoney(moneyType)
local exchangeNum=self:getSubActConfig("exchangeReddot")
local gift=self:getSubActConfig("gift")
local exchanges=self.data.exchanges
local cost=nil
for i,v in ipairs(gift)do
local max=v[4]
local buyed=exchanges[i]
if max<=0 or buyed<max then
cost=cost and math.min(cost,v[3])or v[3]
end
end
return(exchangeNum<=money)and cost and(money>=cost)
end
return false
end

function subActivityInfo_chaoslingchi:lotteryReddot()
local cfg=self:getSubActConfig("itemnum")
for i,v in ipairs(cfg)do
if v~=1 and self:lotteryEnough(v)then
return true
end
end
return false
end

function subActivityInfo_chaoslingchi:targetRewardReddot()
if self.data then
local data=self.data
local total=data.total or 0
local recvIdx=data.recvIdx or 0

local target=self:getSubActConfig("target_reward")
for i,d in ipairs(target)do
local num=d[1]
local fix=total>=num
local rewardFlag=recvIdx>=i
if fix and not rewardFlag then
return true
end
end
end

return false
end

function subActivityInfo_chaoslingchi:lotteryEnough(num)
local itemId=self:getSubActConfig("itemid")
local itemNum=num
local have=itemsModel.getCount(itemId)
return have>=itemNum
end

function subActivityInfo_chaoslingchi:getJumpAnimation()
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

function subActivityInfo_chaoslingchi:setJumpAnimation(jump)
if self.jumpAnimation==nil then
self.jumpAnimation={self.end_time,jump}
else
self.jumpAnimation[2]=jump
end

local keyStr=FMT.fmt("{0}_{1}",self.act_id,self.sub_act_id)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eActSkipAnimation,keyStr,self.jumpAnimation)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eActSkipAnimation)
end

function subActivityInfo_chaoslingchi:showPrize(rewards)
local timesCfg=self:getSubActConfig("itemnum")
local btnData={}
local itemId=self:getSubActConfig("itemid")


















local moneyType=self:getSubActConfig("money")[1]
local moneyGainNum=self:getSubActConfig("money")[2]
local moneyIconName=iconHelper.getIconName(moneyType)
local lotteryNum=#rewards
local tipsStr=moneyGainNum>0 and FMT.fmt("获得：quad-icon={0}-quad{1}",moneyIconName,lotteryNum*moneyGainNum)or nil
local args={
list=rewards,
tips=tipsStr,
btnData=btnData,
closeTips="点击空白区域关闭",
effect=self:getSubActConfig("reset_items"),
moneytypes={{itemId}},
callback=function()
UIManager:invokeUIMethod("UISubAct_ChaosLingChiWin","refresh_Animation",self.act_id,self.sub_act_type,self.sub_act_id)
end,
}
UIManager:showWindow('UICommonShowPrizeEightWin',args)

AudioManager.playAudio(407)
end

function subActivityInfo_chaoslingchi:checkFree()
return not timeHelper.isTodayShort(self.data.free)
end

function subActivityInfo_chaoslingchi:lottery(type)
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

function subActivityInfo_chaoslingchi:onShowPrize(prizeType,rewards_,effectData)
if prizeType~=ePrizeType.echaoslingchi then
return
end
self.data.selfRecordList=self.data.selfRecordList or{}
local rewards=rewards_
if effectData.list then
rewards={}
for i,v in ipairs(effectData.list)do
table.insert(rewards,{itemid=v.param_1,num=v.param_2})
end
end

local flag=false
local config=activitiesModel:getSubActivityConfig(self.sub_act_type,self.sub_act_id)
for i,v in ipairs(rewards)do
if config.self_record_items[v.itemid]then
flag=true
local get_time=self.data.now_sec or 0
table.insert(self.data.selfRecordList,{item_id=v.itemid,item_num=v.num,get_time=get_time})
end

end
if flag then
self:flushVal()
end

local show=true
for i,v in ipairs(checkWin)do
local win=UIManager:findActiveWindow(v)
if win then
show=false
break
end
end
if not show then
UIManager:invokeUIMethod("UISubAct_ChaosLingChiWin","refreshView",self.act_id,self.sub_act_type,self.sub_act_id)
UIManager:invokeUIMethod("UISubAct_ChaosLingChiExchangeWin","refreshView",self.act_id,self.sub_act_type,self.sub_act_id)
self:showPrize(rewards)
else
UIManager:invokeUIMethod("UISubAct_ChaosLingChiWin","refreshView",self.act_id,self.sub_act_type,self.sub_act_id)
UIManager:invokeUIMethod("UISubAct_ChaosLingChiWin","play_Animation",self.act_id,self.sub_act_type,self.sub_act_id,rewards)
end
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)


end

function subActivityInfo_chaoslingchi:initSelfRecordList()
local list={}
local args=userActorSetting.get("HDLC_SELF_RECORD_LIST",{})
if args.act_id~=self.act_id then
self.data.selfRecordList={}
self:flushVal()
return
end
for i,v in pairs(args.list or{})do
if v then
table.insert(list,{item_id=v.item_id,item_num=v.item_num,get_time=v.get_time})
end
end
self.data.selfRecordList=list
end

function subActivityInfo_chaoslingchi:flushVal()
local config=activitiesModel:getSubActivityConfig(self.sub_act_type,self.sub_act_id)
if config.self_record_cnt==0 then
userActorSetting.flushVal("HDLC_SELF_RECORD_LIST",{})
return
end
local selfLen=#self.data.selfRecordList
if selfLen>config.self_record_cnt then
self.data.selfRecordList=table.sub(self.data.selfRecordList,selfLen-config.self_record_cnt+1,selfLen)
end

local args={}
args.list={}
args.act_id=self.act_id
for i,v in pairs(self.data.selfRecordList)do
args.list[#args.list+1]={item_id=v.item_id,item_num=v.item_num,get_time=v.get_time}
end
userActorSetting.flushVal("HDLC_SELF_RECORD_LIST",args)
end

return subActivityInfo_chaoslingchi