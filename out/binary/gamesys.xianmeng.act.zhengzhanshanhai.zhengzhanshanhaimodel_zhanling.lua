
function zhengzhanshanhaiModel:onAppStart_zhanling()

end

function zhengzhanshanhaiModel:onEnterState_zhanling(isReconnet)
self.zhanlingData=nil
self.passData={}
end

function zhengzhanshanhaiModel:onLeaveState_zhanling(isReconnet)
self.zhanlingData=nil
self.passData=nil
end

function zhengzhanshanhaiModel:setZhanLingData(data)
self.zhanlingData=data
end

function zhengzhanshanhaiModel:getZhanLingData()
return self.zhanlingData
end


function zhengzhanshanhaiModel:getZhanLingData_completeCnt()
return self.zhanlingData and self.zhanlingData.complete_cnt or 0
end


function zhengzhanshanhaiModel:getZhanLingData_rewardFlag_Free()
return self.zhanlingData and self.zhanlingData.free_reward_flag or 0
end


function zhengzhanshanhaiModel:getZhanLingData_rewardFlag_Money()
return self.zhanlingData and self.zhanlingData.moeny_rewards_flag or 0
end


function zhengzhanshanhaiModel:getZhanLingData_rewardFlag_Recharge()
return self.zhanlingData and self.zhanlingData.recharge_reward_flag or 0
end


function zhengzhanshanhaiModel:getZhanLingData_buyFlag_Money()
return self.zhanlingData and self.zhanlingData.is_money or 0
end


function zhengzhanshanhaiModel:getZhanLingData_buyFlag_Recharge()
return self.zhanlingData and self.zhanlingData.is_recharge or 0
end

function zhengzhanshanhaiModel:getZhanLingConfig()
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then

return cfg_zhengzhanshanhaizhanlingconfig()
else

local shSeasonLv=zhengzhanshanhaiModel:getSeasonLv()
local allCfg=cfgHelper.get(cfg_zhengzhanshanhaizhanlingnewconfig_get,shSeasonLv)
if not allCfg then
logErr(FMT.fmt("找不到征战山海赛季等级为{0}对应的战令配置 请检查配置是否正确",shSeasonLv))
shSeasonLv=1
end

return cfgHelper.get(cfg_zhengzhanshanhaizhanlingnewconfig_get,shSeasonLv)
end

end

function zhengzhanshanhaiModel:getZhanLingConfig_const_def()
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then

return cfgHelper.getdef(cfg_zhengzhanshanhaizhanlingconfig)
else

return cfgHelper.getdef(cfg_zhengzhanshanhaizhanlingnewconfig)
end
end

function zhengzhanshanhaiModel:checkSHZhanLingNextRest()
if self.zhanlingData and self.zhanlingData.beginTimes then
return self.zhanlingData.beginTimes==0
end
return true
end


function zhengzhanshanhaiModel:checkSHZhanLingReddot()
if not zhengzhanshanhaiController.checkSHZhanLingOpen()then
return false
end
local cfg=self:getZhanLingConfig()
for i,v in ipairs(cfg)do
local id=v.conf_id or v.id
if self:getFreeRewardFlag(id)or
self:getMoneyRewardFlag(id)or
self:getRechargeRewardFlag(id)
then
return true
end
end
return false
end

function zhengzhanshanhaiModel:checkSJXianZangReddot()
if not zhengzhanshanhaiController.checkSJXianZangOpen()then
return false
end
local passport_id=self:getPassData_passport_id()
local curLevel=self:getPassData_level()

local passCfg=cfgHelper.get(cfg_zhengzhanshanhaipassportconfig_get,passport_id)

local max_level_box=passCfg.max_level_box
if max_level_box then
local up_level_conf=passCfg.up_level_conf
local maxLevel=#up_level_conf
local isMax=curLevel>=maxLevel
if isMax then
local curScore=self:getPassData_score()
return curScore>=max_level_box[1]
end
end

local fee_rewards=passCfg.fee_rewards

for targetLevel,v in pairs(fee_rewards)do
if curLevel>=targetLevel and
((not self:getPassData_targetLevelRecvFlag(targetLevel,PASS_Reward_Type.eFree)and self:getPassData_rewardBuyFlag(PASS_Reward_Type.eFree))or
(not self:getPassData_targetLevelRecvFlag(targetLevel,PASS_Reward_Type.eReward1)and self:getPassData_rewardBuyFlag(PASS_Reward_Type.eReward1))or
(not self:getPassData_targetLevelRecvFlag(targetLevel,PASS_Reward_Type.eReward2)and self:getPassData_rewardBuyFlag(PASS_Reward_Type.eReward2)))then
return true
end
end

return false
end


function zhengzhanshanhaiModel:getFreeRewardFlag(id)
local rewardFlag_Free=self:getZhanLingData_rewardFlag_Free()
if mathHelper.getBitValue(rewardFlag_Free,id-1)then
return false
end
local curConsume=self:getZhanLingData_completeCnt()
local config=self:getZhanLingConfig()
local cfg=config[id]
local completeCnt=cfg.complete_cnt
return curConsume>=completeCnt
end

function zhengzhanshanhaiModel:getMoneyRewardFlag(id)
local rewardFlag_Money=self:getZhanLingData_rewardFlag_Money()
if mathHelper.getBitValue(rewardFlag_Money,id-1)then
return false
end
local curConsume=self:getZhanLingData_completeCnt()
local config=self:getZhanLingConfig()
local cfg=config[id]
local completeCnt=cfg.complete_cnt
local buyFlag_Money=self:getZhanLingData_buyFlag_Money()
if curConsume>=completeCnt and buyFlag_Money==1 then
return true
end
return false
end

function zhengzhanshanhaiModel:getRechargeRewardFlag(id)
local rewardFlag_Recharge=self:getZhanLingData_rewardFlag_Recharge()
if mathHelper.getBitValue(rewardFlag_Recharge,id-1)then
return false
end
local curConsume=self:getZhanLingData_completeCnt()
local config=self:getZhanLingConfig()
local cfg=config[id]
local completeCnt=cfg.complete_cnt
local buyFlag_Recharge=self:getZhanLingData_buyFlag_Recharge()
if curConsume>=completeCnt and buyFlag_Recharge==1 then
return true
end
return false
end



function zhengzhanshanhaiModel:setPassData(data)























self.passData=data
end

function zhengzhanshanhaiModel:getPassData()
if not self.passData then
self.passData={}
end
return self.passData
end

function zhengzhanshanhaiModel:getPassData_passport_id()
return self.passData.passport_id or 0
end

function zhengzhanshanhaiModel:getPassData_level()
return self.passData.level or 0
end

function zhengzhanshanhaiModel:getPassData_score()
return self.passData.score or 0
end

function zhengzhanshanhaiModel:getPassData_BoxCnt()
return self.passData.max_level_box_cnt or 0
end

function zhengzhanshanhaiModel:getPassData_rewardBuyFlag(rw_type)
return self.passData.rewardBuyFlag and self.passData.rewardBuyFlag[rw_type]or false
end


function zhengzhanshanhaiModel:getPassData_targetLevelRecvFlag(level,rw_type)
if self.passData.len>0 and self.passData.list and self.passData.list[level]then
return self.passData.list[level][rw_type]
else

end
return false
end
