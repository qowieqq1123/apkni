









local subActivityInfo_yunhaidiaobao={name='yunhaidiaobao'}

local checkWin={
"UI_activity_lotteryDetail",
"UI_activity_lotteryPercent",
"UI_activity_lotteryRule",
}

function subActivityInfo_yunhaidiaobao:onInit()
self:listenNotify(notifyConfig.onShowPrize,function(...)
self:onShowPrize(...)
end)
end

function subActivityInfo_yunhaidiaobao:onStart()

end

function subActivityInfo_yunhaidiaobao:onDelete()

end

function subActivityInfo_yunhaidiaobao:checkReddot()


if self.data then
if self:checkFree()then
return true
elseif self:lotteryReddot()then
return true
end
end
return false
end

function subActivityInfo_yunhaidiaobao:exchangeReddot()
if self.data then
local moneyType=self:getSubActConfig("money")[1]
local money=moneyModel.getMoney(moneyType)
local exchangeNum=self:getSubActConfig("exchangeReddot")
local gift=self:getSubActConfig("gift")
local exchanges=self.data.exchanges or{}
local cost=nil
for i,v in ipairs(gift)do
local max=v[4]
local buyed=exchanges[i]or 0
if max<=0 or buyed<max then
cost=cost and math.min(cost,v[3])or v[3]
end
end
return(exchangeNum<=money)and cost and(money>=cost)
end
return false
end

function subActivityInfo_yunhaidiaobao:lotteryReddot()
local cfg=self:getSubActConfig("itemnum")
for i,v in ipairs(cfg)do
if v~=1 and self:lotteryEnough(v)then
return true
end
end
return false
end

function subActivityInfo_yunhaidiaobao:lotteryEnough(num)
local itemId=self:getSubActConfig("itemid")
local itemNum=num
local have=itemsModel.getCount(itemId)
return have>=itemNum
end

function subActivityInfo_yunhaidiaobao:getJumpAnimation()
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

function subActivityInfo_yunhaidiaobao:setJumpAnimation(jump)
if self.jumpAnimation==nil then
self.jumpAnimation={self.end_time,jump}
else
self.jumpAnimation[2]=jump
end

local keyStr=FMT.fmt("{0}_{1}",self.act_id,self.sub_act_id)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eActSkipAnimation,keyStr,self.jumpAnimation)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eActSkipAnimation)
end

function subActivityInfo_yunhaidiaobao:showPrize(rewards)
local timesCfg=self:getSubActConfig("itemnum")
local btnData={}
local itemId=self:getSubActConfig("itemid")
for i,v in ipairs(timesCfg)do
local itemNum=v
local callback=function()
if not self:getJumpAnimation()then
UIManager:closeWindow("UISubAct_YHDBShowPrizeWin")
end
self:lottery(i)
end
local free=v==1 and self:checkFree()
local text=free and"本次免费"or FMT.fmt("钓{0}次",v)
local cost=not free and{itemId,itemNum}or nil
local bData={
text=text,
cost=cost,
callback=callback,
}
table.insert(btnData,bData)
end
local moneyType=self:getSubActConfig("money")[1]
local moneyGainNum=self:getSubActConfig("money")[2]
local moneyIconName=iconHelper.getIconName(moneyType)
local lotteryNum=#rewards
local maxTimes=self:getSubActConfig("round")
local great=self.data.great
local leftNum=maxTimes-great
local tipsStr=FMT.fmt("获得：quad-icon={0}-quadx{1}",moneyIconName,lotteryNum*moneyGainNum)
local args={
list=rewards,
tips=tipsStr,
btnData=btnData,
greatNum=leftNum,
effect=self:getSubActConfig("reset_items"),
moneytypes={{itemId}},
callback=function()
UIManager:invokeUIMethod("UISubAct_YunHaiDiaoBaoWin","refresh_Animation",self.act_id,self.sub_act_type,self.sub_act_id)
end,
}
UIManager:showWindow('UISubAct_YHDBShowPrizeWin',args)

AudioManager.playAudio(407)
end

function subActivityInfo_yunhaidiaobao:checkFree()
return not timeHelper.isTodayShort(self.data.free)
end

function subActivityInfo_yunhaidiaobao:lottery(type)
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

function subActivityInfo_yunhaidiaobao:onShowPrize(prizeType,rewards_,effectData)
if prizeType~=ePrizeType.eYunHaiDiaoBao then
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
extera.funcType=funcGubaoBXType.eYunHaiDiaoBao
showPrizeControl:setGuBaoBaoXiangData(extera)

bagProtocolControl.req_use_item(extera.spitemid,extera.spnum)
else
self:ShowPrize2(rewards)
end
end

function subActivityInfo_yunhaidiaobao:ShowPrize2(rewards)
local show=true
for i,v in ipairs(checkWin)do
local win=UIManager:findActiveWindow(v)
if win then
show=false
break
end
end
if not show then
self:showPrize(rewards)
else
UIManager:invokeUIMethod("UISubAct_YunHaiDiaoBaoWin","play_Animation",self.act_id,self.sub_act_type,self.sub_act_id,rewards)
end
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
end

return subActivityInfo_yunhaidiaobao