









local subActivityInfo_feijianduobao={name='feijianduobao'}

local checkWin={
"UISubAct_FeiJianDuoBaoExchangeTipsWin",
"UISubAct_FeiJianDuoBaoExchangeWin",
"UI_activity_lotteryDetail",
"UI_activity_lotteryPercent",
"UI_activity_lotteryRule",
}

function subActivityInfo_feijianduobao:onInit()
self:listenNotify(notifyConfig.onShowPrize,function(...)
self:onShowPrize(...)
end)
end

function subActivityInfo_feijianduobao:onStart()

end

function subActivityInfo_feijianduobao:onDelete()

end

function subActivityInfo_feijianduobao:checkReddot()


if self.data then
if self:checkFree()then
return true
elseif self:exchangeReddot()then
return true
elseif self:lotteryReddot()then
return true
end
end
return false
end

function subActivityInfo_feijianduobao:exchangeReddot()
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

function subActivityInfo_feijianduobao:lotteryReddot()
local cfg=self:getSubActConfig("itemnum")
for i,v in ipairs(cfg)do
if v~=1 and self:lotteryEnough(v)then
return true
end
end
return false
end

function subActivityInfo_feijianduobao:lotteryEnough(num)
local itemId=self:getSubActConfig("itemid")
local itemNum=num
local have=itemsModel.getCount(itemId)
return have>=itemNum
end

function subActivityInfo_feijianduobao:getJumpAnimation()
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

function subActivityInfo_feijianduobao:setJumpAnimation(jump)
if self.jumpAnimation==nil then
self.jumpAnimation={self.end_time,jump}
else
self.jumpAnimation[2]=jump
end

local keyStr=FMT.fmt("{0}_{1}",self.act_id,self.sub_act_id)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eActSkipAnimation,keyStr,self.jumpAnimation)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eActSkipAnimation)
end

function subActivityInfo_feijianduobao:showPrize(rewards)
local timesCfg=self:getSubActConfig("itemnum")
local btnData={}
local itemId=self:getSubActConfig("itemid")


















local moneyType=self:getSubActConfig("money")[1]
local moneyGainNum=self:getSubActConfig("money")[2]
local moneyIconName=iconHelper.getIconName(moneyType)
local lotteryNum=#rewards
local tipsStr=nil
local args={
list=rewards,
tips=tipsStr,
btnData=btnData,
closeTips="点击屏幕领取奖励",
effect=self:getSubActConfig("reset_items"),
moneytypes={{itemId}},
callback=function()
UIManager:invokeUIMethod("UISubAct_FeiJianDuoBaoWin","refresh_Animation",self.act_id,self.sub_act_type,self.sub_act_id)
end,
}
UIManager:showWindow('UICommonShowPrizeEightWin',args)

AudioManager.playAudio(407)
end

function subActivityInfo_feijianduobao:checkFree()
return not timeHelper.isTodayShort(self.data.free)
end

function subActivityInfo_feijianduobao:lottery(type)
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

function subActivityInfo_feijianduobao:onShowPrize(prizeType,rewards_,effectData)
if prizeType~=ePrizeType.eFeiJianDuoBao then
return
end
local rewards=rewards_
if effectData.list then
rewards={}
for i,v in ipairs(effectData.list)do
table.insert(rewards,{itemid=v.param_1,num=v.param_2})
end
end



local extera={}
extera.spitemid=0
extera.spnum=0
extera.rewards={}
for k,v in ipairs(rewards)do
if showPrizeControl:checkGuBaoBX(v.itemid)then
extera.spitemid=v.itemid
extera.spnum=extera.spnum+1

else
table.insert(extera.rewards,v)
end
end
if extera.spitemid~=0 and extera.spnum>0 then

extera.act_id=self.act_id
extera.sub_act_type=self.sub_act_type
extera.sub_act_id=self.sub_act_id
extera.funcType=funcGubaoBXType.eFeiJianDuoBao
showPrizeControl:setGuBaoBaoXiangData(extera)

bagProtocolControl.req_use_item(extera.spitemid,extera.spnum)
else
self:ShowPrize2(rewards)
end
end

function subActivityInfo_feijianduobao:ShowPrize2(rewards)

local show=true
for i,v in ipairs(checkWin)do
local win=UIManager:findActiveWindow(v)
if win then
show=false
break
end
end
if not show then
UIManager:invokeUIMethod("UISubAct_FeiJianDuoBaoWin","refreshView",self.act_id,self.sub_act_type,self.sub_act_id)
UIManager:invokeUIMethod("UISubAct_FeiJianDuoBaoExchangeWin","refreshView",self.act_id,self.sub_act_type,self.sub_act_id)
self:showPrize(rewards)
else

UIManager:invokeUIMethod("UISubAct_FeiJianDuoBaoWin","play_Animation",self.act_id,self.sub_act_type,self.sub_act_id,rewards)
end
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
end

return subActivityInfo_feijianduobao