







xiaoZhuShouDetailFunc={}

function xiaoZhuShouDetailFunc.hs_autoCleanupZhenLingShowPrize(prizeType,rewards_,effectData)
local detailId=XIAOZHUSHUDETAIL_ENUM.xzs_sub_hs_2
local rewards=rewards_






local args={rewards=rewards}

xiaoZhuShouModel:changeDetailDataArgs(detailId,args)
timeEventController.delayDo(0.1,function()
xiaoZhuShouModel:callDetailFunc(detailId,"updateDetailProgress",10,10,0.2)
end)
end

function xiaoZhuShouDetailFunc.csz_autoReceiveShowPrize(prizeType,rewards_,effectData)

end

function xiaoZhuShouDetailFunc.autoReceiveCatShopShowPrize(prizeType,rewards_,effectData)
local detailId=XIAOZHUSHUDETAIL_ENUM.xzs_sub_mhl
local rewards=rewards_
local args={rewards=rewards}
xiaoZhuShouModel:addDetailData(detailId,args)
end

function xiaoZhuShouDetailFunc.autoReceiveAdRewardShowPrize(prizeType,rewards_,effectData)
local detailId=XIAOZHUSHUDETAIL_ENUM.xzs_sub_gyg
local rewards=rewards_
local args={rewards=rewards,count=effectData.count}
xiaoZhuShouModel:addDetailData(detailId,args)
end

function xiaoZhuShouDetailFunc.autoReceiveYueLongChiRewardShowPrize(prizeType,rewards_,effectData)
local detailId=XIAOZHUSHUDETAIL_ENUM.xzs_sub_ylc
local rewards=rewards_
local args={rewards=rewards}
xiaoZhuShouModel:addDetailData(detailId,args)
end

function xiaoZhuShouDetailFunc.autoReceiveXuanShangTaiRewardShowPrize(prizeType,rewards_,effectData)
local detailId=XIAOZHUSHUDETAIL_ENUM.xzs_sub_xst
local rewards=rewards_
local args={rewards=rewards}
xiaoZhuShouModel:addDetailData(detailId,args)
end

function xiaoZhuShouDetailFunc.autoReceiveShangShiRewardShowPrize(prizeType,rewards_,effectData)
local detailId=XIAOZHUSHUDETAIL_ENUM.xzs_sub_ss
local rewards=rewards_
local wait=xiaoZhuShouModel:getWaitReward(detailId)
local flag=not wait or not next(wait)
xiaoZhuShouModel:pushWaitReward(detailId,rewards)

if flag then
local args={rewards=rewards}
xiaoZhuShouModel:addDetailData(detailId,args)
end
end

function xiaoZhuShouDetailFunc.DayDiscount(prizeType,rewards_,effectData)
local detailId=XIAOZHUSHUDETAIL_ENUM.xzs_sub_sd
local rewards=rewards_
local args={rewards=rewards}
xiaoZhuShouModel:addDetailData(detailId,args)
end

function xiaoZhuShouDetailFunc.ly_autoReceiveShowPrize(prizeType,rewards_,effectData)
local detailId=XIAOZHUSHUDETAIL_ENUM.xzs_sub_ly

local rewards
if effectData.list then
rewards={}
for i,v in ipairs(effectData.list)do
table.insert(rewards,{itemid=v.param_1,num=v.param_2})
end
else
rewards=rewards_
end

xiaoZhuShouModel:resetWaitReward(detailId)
xiaoZhuShouModel:pushWaitReward(detailId,rewards)
local args={time=1.5,rewards=rewards}
xiaoZhuShouModel:addDetailData(detailId,args)
end

function xiaoZhuShouDetailFunc.autoReceiveFangShiShowPrize(arg)
local detailId=XIAOZHUSHUDETAIL_ENUM.xzs_sub_fs


local args=arg

xiaoZhuShouModel:changeDetailDataArgs(detailId,args)
timeEventController.delayDo(0.3,function()
xiaoZhuShouModel:callDetailFunc(detailId,"updateDetailProgress",10,10,0.1)
end)
end

function xiaoZhuShouDetailFunc.autoReceiveYYHYShowPrize(prizeType,rewards_,effectData)
local detailId=XIAOZHUSHUDETAIL_ENUM.xzs_sub_yyhy
local rewards=rewards_
local args={rewards=rewards,count=effectData.count}
xiaoZhuShouModel:addDetailData(detailId,args)
end

function xiaoZhuShouDetailFunc.hs_autoReceiveDailyChallengeShowPrize(prizeType,rewards_,effectData)
local detailId=XIAOZHUSHUDETAIL_ENUM.xzs_sub_hs_1
local rewards=rewards_
xiaoZhuShouModel:pushWaitReward(detailId,rewards)
end

function xiaoZhuShouDetailFunc.autoReceiveWDTShowPrize(prizeType,rewards_,effectData)
local detailId=XIAOZHUSHUDETAIL_ENUM.xzs_sub_wdt_1
local rewards=rewards_
local args={rewards=rewards,count=effectData.count}
xiaoZhuShouModel:addDetailData(detailId,args)
end

function xiaoZhuShouDetailFunc.autoReceiveXianWuLouShowPrize(prizeType,rewards_,effectData)
local detailId=XIAOZHUSHUDETAIL_ENUM.xzs_sub_xwl
local rewards=rewards_
xiaoZhuShouModel:pushWaitReward(detailId,rewards)
end

function xiaoZhuShouDetailFunc.autoReceiveTYSCShowPrize(prizeType,rewards_,effectData)
local detailId=XIAOZHUSHUDETAIL_ENUM.xzs_sub_tysc_challenge
local rewards=rewards_
xiaoZhuShouModel:pushWaitReward(detailId,rewards)
end

function xiaoZhuShouDetailFunc.autoReceiveTWXMShowPrize(prizeType,rewards_,effectData)
local detailId=XIAOZHUSHUDETAIL_ENUM.xzs_sub_twxm_challenge
local rewards=rewards_
xiaoZhuShouModel:pushWaitReward(detailId,rewards)
end

function xiaoZhuShouDetailFunc.autoReceiveTYCYShowPrize(prizeType,rewards_,effectData)
local detailId=XIAOZHUSHUDETAIL_ENUM.xzs_sub_tycy_challenge
local rewards=rewards_
xiaoZhuShouModel:pushWaitReward(detailId,rewards)
end