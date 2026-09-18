









local subActivityInfo_xinashichouka_Role={name='xinashichouka_Role'}

function subActivityInfo_xinashichouka_Role:onInit()

end

function subActivityInfo_xinashichouka_Role:onStart()

end

function subActivityInfo_xinashichouka_Role:onUpdate()

end

function subActivityInfo_xinashichouka_Role:onDelete()

end

function subActivityInfo_xinashichouka_Role:checkReddot()
local data=self.data
if data then
local sub_actcfg=self:getSubActConfig()

if activitiesHandle_xianshichouka_Role.checkHasFree(self.sub_act_type,self.sub_act_id,data.free)then
return true
end


local target=sub_actcfg.target
local max=#target
local flag=data.flag
local total=data.total
for i=1,max do
local d=target[i]
local num=d[1]
local reward=d[2][1]
local fix=total>=num
local rewardFlag=mathHelper.getBitValue(flag,i-1)
if fix and not rewardFlag then
return true
end
end


local itemid=sub_actcfg.itemid
local haveItem=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
if haveItem>=10 then
return true
end

local flag=self:reqXianShiChouKa_checkDailyRewardsIsGot()
return flag
end

return false
end




function subActivityInfo_xinashichouka_Role:reqXianShiChouKa_checkDailyRewardsIsGot()

local giftid=self:getSubActConfig('freeLibaoId')
local data={self.act_id,self.sub_act_type,self.sub_act_id}
return FreeGiftController.GetFreeGift(giftid,data)
end


function subActivityInfo_xinashichouka_Role:reqXianShiChouKa_getDailyRewards()

local giftid=self:getSubActConfig('freeLibaoId')
local data={self.act_id,self.sub_act_type,self.sub_act_id}
local subType=self.sub_act_type
return FreeGiftController.SendFreeGift(giftid,data,function(result)
if result then

local win=UIManager:findActiveWindow('UISubAct_xianshichouka_selectUpWin_Role')
if win then
win:refreshDailyReward()
end

local win2=UIManager:findActiveWindow('UISubAct_xianshichoukaWin_Role')
if win2 then
win2:refreshDailyReward()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
end)
end


return subActivityInfo_xinashichouka_Role