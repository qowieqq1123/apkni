









local subActivityInfo_xianguyiji={name='xianguyiji'}

local checkWin={
"UISubAct_xianguyijiWin_RenPin",
"UISubAct_xianguyijiWin_TanSuoReward",
"UI_activity_lotteryDetail",
"UI_activity_lotteryPercent",
"UI_activity_lotteryRule",

}

function subActivityInfo_xianguyiji:onInit()
self:listenNotify(notifyConfig.onShowPrize,function(...)
self:onShowPrize(...)
end)
end

function subActivityInfo_xianguyiji:onStart()

end

function subActivityInfo_xianguyiji:onDelete()

end

function subActivityInfo_xianguyiji:checkReddot()



if self.data then
if self:checkFree()then
return true
elseif self.data.star>=self.data.fullReddot then
return true
elseif self:lotteryReddot()then
return true
else
local times=self:getSubActConfig("dz_all_times")
if not times then
return false
end
local checkGood=self.data.good<times
local checkBad=self.data.bad<times
if self.commentData==nil then
if checkGood or checkBad then
return true
end
else
if checkGood and self.commentData[1]~=nil then
return true
elseif checkBad and self.commentData[2]~=nil then
return true
end
end
end
end
return false
end

function subActivityInfo_xianguyiji:lotteryReddot()
local cfg=self:getSubActConfig("times")
for i,v in pairs(cfg)do
if i~=1 and self:lotteryEnough(i)then
return true
end
end
return false
end

function subActivityInfo_xianguyiji:lotteryEnough(num)
local cfg=self:getSubActConfig("times",num)
local itemId=cfg[2]
local itemNum=cfg[3]
local have=itemsModel.getCount(itemId)
return have>=itemNum
end













function subActivityInfo_xianguyiji:getJumpAnimation()
local keyStr=FMT.fmt("{0}_{1}",self.act_id,self.sub_act_id)
if self.jumpLoad==nil then
self.jumpAnimation=userActorArraySetting.get(ACTOR_SETTING_TYPE.eActXianGuYiJi,keyStr,nil)
if self.jumpAnimation and timeHelper.getServerShortTime()>self.jumpAnimation[1]then
self.jumpAnimation=nil
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eActXianGuYiJi,keyStr,nil)
end
self.jumpLoad=true
end
return self.jumpAnimation and self.jumpAnimation[2]or false
end

function subActivityInfo_xianguyiji:setJumpAnimation(jump)
if self.jumpAnimation==nil then
self.jumpAnimation={self.end_time,jump}
else
self.jumpAnimation[2]=jump
end

local keyStr=FMT.fmt("{0}_{1}",self.act_id,self.sub_act_id)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eActXianGuYiJi,keyStr,self.jumpAnimation)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eActXianGuYiJi)
end

function subActivityInfo_xianguyiji:setCommentData(commentData)
self.commentData=commentData
end

function subActivityInfo_xianguyiji:getCommentData()
return self.commentData
end

function subActivityInfo_xianguyiji:showPrize(rewards,showOuQi,textStr)
local ouqi=nil
if#rewards>1 and showOuQi~=false then
local ouqiCfg=self:getSubActConfig("ouqi")
if ouqiCfg then
ouqi=0
for i,v in ipairs(rewards)do
ouqi=ouqi+(ouqiCfg[v.itemid]or 0)*v.num
end
end
end

local timesCfg=self:getSubActConfig("times")
local temp={}
for i,v in pairs(timesCfg)do
table.insert(temp,i)
end
table.sort(temp)
local btnData={}
for i,v in ipairs(temp)do
local btnCfg=timesCfg[v]
local callback=function()
if not self.jumpAnimation then
UIManager:closeWindow("UICommonShowPrizeThreeWin")
end
self:lottery(v)
end
local free=v==1 and self:checkFree()
local text
if pfwindowslController:checkIsGameVersion_oumei()then
text=free and"Free this time"or FMT.fmt("{0} X{1}",textStr or"Exploration",v)
else
text=free and"本次免费"or FMT.fmt("{0}{1}次",textStr or"探寻",v)
end
local cost=not free and{btnCfg[2],btnCfg[3]}or nil
local bData={
text=text,
cost=cost,
callback=callback,
}
table.insert(btnData,bData)
end

local args={
list=rewards,
tips="",
btnData=btnData,
closeTips="点击屏幕领取奖励",
effect=self:getSubActConfig("reset_items"),
moneytypes={{timesCfg[temp[1]][2]}},
extraWin="UISubAct_xianguyijiWin_ShowPrizeTop",
extraParams={
num=self:getData().great,
name=self:getSubActConfig("awardImg"),
tips=ouqi~=nil and FMT.fmt("欧气值：{0}",ouqi)or"",
},
}
UIManager:showWindow('UICommonShowPrizeThreeWin',args)

AudioManager.playAudio(407)
end

function subActivityInfo_xianguyiji:checkFree()
return not timeHelper.isTodayShort(self.data.free)
end

function subActivityInfo_xianguyiji:lottery(num)
local data=self:getData()
if num==1 and self:checkFree()then
local is_assistant=0
local jstr=jsonHelper.encode({1,num,is_assistant})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,jstr)
return
end

local cfg=self:getSubActConfig("times",num)
local itemId=cfg[2]
local itemNum=cfg[3]
local have=itemsModel.getCount(itemId)

if have>=itemNum then
local is_assistant=0
local jstr=jsonHelper.encode({1,num,is_assistant})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,jstr)
return
end
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(itemId)))
gainControl:showCommonGainWin_item(itemId)
end

function subActivityInfo_xianguyiji:onShowPrize(prizeType,rewards_,effectData)
if prizeType~=ePrizeType.eXianGuYiJi or self.act_id~=effectData.actid or self.sub_act_id~=effectData.act2id then
return
end

if effectData.assistant==1 then
timeEventController.delayDo(0.1,function()
local xzsEffectData={
sub_effecttype=XIAOZHUSHU_ENUM.xzs_ActFreeLottery,
sub_effecttype2=SUB_ACTIVITY_TYPE.eXianGuYiJi,
}
notifySystem:postNotify(notifyConfig.onShowPrize,ePrizeType.eXZS_Common,rewards_,xzsEffectData)
end)
end

local config=activitiesModel:getSubActivityConfig(self.sub_act_type,self.sub_act_id)
local data=self:getData()
data.free=effectData.free_sec
data.great=effectData.times
data.star=effectData.star_value

if effectData.assistant~=1 then
local showOQ=effectData.is_spe==0

local rewards=rewards_
local show=true
for i,v in ipairs(checkWin)do
local win=UIManager:findActiveWindow(v)
if win then
show=false
break
end
end

local textStr=config.textStr or"探寻"

if not show then
UIManager:invokeUIMethod("UISubAct_xianguyijiWin","refreshView",self.act_id,self.sub_act_type,self.sub_act_id)
UIManager:invokeUIMethod("UISubAct_xianguyijiWin_TanSuoReward","refreshView",self.act_id,self.sub_act_type,self.sub_act_id,false)
self:showPrize(rewards,showOQ,textStr)
elseif UIManager:isActive("UICommonShowPrizeThreeWin")then
if not showOQ then
UIManager:closeWindow("UICommonShowPrizeThreeWin")
UIManager:invokeUIMethod("UISubAct_xianguyijiWin","refreshView",self.act_id,self.sub_act_type,self.sub_act_id,rewards,showOQ)
else
UIManager:invokeUIMethod("UISubAct_xianguyijiWin","refreshView",self.act_id,self.sub_act_type,self.sub_act_id)
self:showPrize(rewards,showOQ,textStr)
end
else
UIManager:invokeUIMethod("UISubAct_xianguyijiWin","refreshView",self.act_id,self.sub_act_type,self.sub_act_id,rewards,showOQ)
end
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
end

return subActivityInfo_xianguyiji