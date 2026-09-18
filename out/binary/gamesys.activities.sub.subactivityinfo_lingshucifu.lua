









local subActivityInfo_lingshucifu={name='lingshucifu'}



function subActivityInfo_lingshucifu:onInit()
local itemLookup={}
local rewardList=self:getSubActConfig('reward_preview')
for level,list in ipairs(rewardList)do
if itemLookup[level]==nil then
itemLookup[level]={}
itemLookup[level].bigReward=nil
itemLookup[level].list={}
end
for i,v in ipairs(list)do
if v[4]==0 then
table.insert(itemLookup[level].list,v)
elseif v[4]==1 and not itemLookup[level].bigReward then
itemLookup[level].bigReward=v
end
end
if not itemLookup[level].bigReward then
itemLookup[level].bigReward=list[1]
end
end
self.rewardPreviewLookup=itemLookup
end

function subActivityInfo_lingshucifu:onStart()

end

function subActivityInfo_lingshucifu:onUpdate()

end

function subActivityInfo_lingshucifu:onDelete()

end

function subActivityInfo_lingshucifu:getPreviewBigRewardByLevel(level)
if not self.rewardPreviewLookup[level]then
return nil
end
return self.rewardPreviewLookup[level].bigReward
end

function subActivityInfo_lingshucifu:getPreviewListByLevel(level)
if not self.rewardPreviewLookup[level]then
return nil
end
return self.rewardPreviewLookup[level].list
end


function subActivityInfo_lingshucifu:onNewDay()
local data=self:getData()
if data then
data.freeNum=0
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
UIManager:invokeUIMethod('UILingShuCiFuWin','rec_newday')
end
end

function subActivityInfo_lingshucifu:getJumpAnimation()
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

function subActivityInfo_lingshucifu:setJumpAnimation(jump)
if self.jumpAnimation==nil then
self.jumpAnimation={self.end_time,jump}
else
self.jumpAnimation[2]=jump
end

local keyStr=FMT.fmt("{0}_{1}",self.act_id,self.sub_act_id)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eActSkipAnimation,keyStr,self.jumpAnimation)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eActSkipAnimation)
end


function subActivityInfo_lingshucifu:checkProgressIsReceive()
local data=self:getData()
local sub_actcfg=self:getSubActConfig()
for i,v in ipairs(sub_actcfg.jdRewards)do
if data.cjNum>=v[1]and data.jdrwIndex<i then
return true
end
end
return false
end


function subActivityInfo_lingshucifu:checkFree()
local data=self:getData()
local sub_actcfg=self:getSubActConfig()
if data.freeNum<sub_actcfg.freeNum then
return true
end
return false
end


function subActivityInfo_lingshucifu:checkMany()
local sub_actcfg=self:getSubActConfig()
local useItems=sub_actcfg.useItems
local moneyType=useItems[1][1]
local many=useItems[1][2]*10
local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
if moneyVal>=many then
return true
end
return false
end

function subActivityInfo_lingshucifu:checkReddot()
local data=self.data
if data then
if self:checkProgressIsReceive()then
return true
end
if self:checkFree()then
return true
end
if self:checkMany()then
return true
end
end
return false
end

return subActivityInfo_lingshucifu