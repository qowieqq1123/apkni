




function zhengzhanshanhaiController:onAppStart_Rank()
socketManager:register_receiver(20,253,zhengzhanshanhaiController.do_protocol_20_253)


socketManager:register_receiver(44,253,zhengzhanshanhaiController.do_protocol_44_253)

end

function zhengzhanshanhaiController:onEnterState_Rank(isReconnect)


zhengzhanshanhaiModel:onEnterState_Rank(isReconnect)
end

function zhengzhanshanhaiController:onLeaveState_Rank(isReconnet)


zhengzhanshanhaiModel:onLeaveState_Rank(isReconnet)
end



function zhengzhanshanhaiController.do_protocol_20_253(len,rankList)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end
zhengzhanshanhaiModel:setRankList_ZZSH(len,rankList)
UIManager:invokeUIMethod("UIXM_ZZSH_settlementTipsWin","refresh")
end


function zhengzhanshanhaiController.do_protocol_44_253(len,rankList)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
zhengzhanshanhaiModel:setRankList_ZZSH(len,rankList)
UIManager:invokeUIMethod("UIXM_ZZSH_settlementTipsWin","refresh")
end


function zhengzhanshanhaiController.req_ZZSH_Rank()
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_253()
else
socketManager:send_20_253()
end
end





function zhengzhanshanhaiController.getRaceIndex_ZZSH_Rank()
return zhengzhanshanhaiModel:getSHSeasonId()
end


function zhengzhanshanhaiController.getEnterState_ZZSH_Rank()
local raceIndex=zhengzhanshanhaiController.getRaceIndex_ZZSH_Rank()
if raceIndex==-1 then
return 0
else

local rankSettlementPreviewEarlyTime=zhengzhanshanhaiController.getRaceCfg_ZZSH_Rank('rankSettlementPreviewEarlyTime')
if rankSettlementPreviewEarlyTime==nil then
return 0
end
local startTime,endTime,settleTime,settleEndTime=zhengzhanshanhaiModel:getSeasonTime()

local curtime=timeHelper.getServerLongTime()
local settlementLeftTime=settleTime-curtime

if curtime>settleTime and curtime<settleEndTime then
return 2
end

if rankSettlementPreviewEarlyTime>=settlementLeftTime then
return 1
end

return 0
end
end

function zhengzhanshanhaiController.getRankeCfg_ZZSH_Rank()
local raceIndex=zhengzhanshanhaiController.getRaceIndex_ZZSH_Rank()
if raceIndex==-1 then
return cfg_zhengzhanshanhaiguildscorerankconfig()
else

local shSeasonLv=zhengzhanshanhaiModel:getSeasonLv()or 1
return cfgHelper.get1(cfg_zhengzhanshanhaiguildscoreranknewconfig_get,shSeasonLv)
end
end

function zhengzhanshanhaiController.getRankeDefCfg_ZZSH_Rank()
local raceIndex=zhengzhanshanhaiController.getRaceIndex_ZZSH_Rank()
if raceIndex==-1 then
return cfgHelper.getdef(cfg_zhengzhanshanhaiguildscorerankconfig)
else

return cfgHelper.getdef(cfg_zhengzhanshanhaiguildscoreranknewconfig)
end

end

function zhengzhanshanhaiController.getRankeAttendrewards_ZZSH_Rank()
local raceIndex=zhengzhanshanhaiController.getRaceIndex_ZZSH_Rank()
if raceIndex==-1 then
return cfgHelper.getdef(cfg_zhengzhanshanhaiguildscorerankconfig,'attend_rewards')
else

local shSeasonLv=zhengzhanshanhaiModel:getSeasonLv()or 1
local attend_rewards=cfgHelper.get2(cfg_zhengzhanshanhaiguildscorebasicconfig_get,shSeasonLv,'attend_rewards')
return attend_rewards
end
end

function zhengzhanshanhaiController.getRankeRuleFmt_ZZSH_Rank()
local raceIndex=zhengzhanshanhaiController.getRaceIndex_ZZSH_Rank()
if raceIndex==-1 then
return cfgHelper.get2(cfg_zhengzhanshanhaiconfig_get,1,'rankRuleFmt')
else

local shSeasonLv=zhengzhanshanhaiModel:getSeasonLv()or 1
local rankRuleFmt=cfgHelper.get2(cfg_zhengzhanshanhaiguildscorebasicconfig_get,shSeasonLv,'rankRuleFmt')
return rankRuleFmt
end
end

function zhengzhanshanhaiController.getRankeGetWay_ZZSH_Rank()
local raceIndex=zhengzhanshanhaiController.getRaceIndex_ZZSH_Rank()
local list,tips
if raceIndex==-1 then
list=cfgHelper.get2(cfg_zhengzhanshanhaiconfig_get,1,'rank_souce_get_way')
tips=cfgHelper.get2(cfg_zhengzhanshanhaiconfig_get,1,'rank_souce_get_tips')
else

local shSeasonLv=zhengzhanshanhaiModel:getSeasonLv()or 1
list=cfgHelper.get2(cfg_zhengzhanshanhaiguildscorebasicconfig_get,shSeasonLv,'rank_souce_get_way')
tips=cfgHelper.get2(cfg_zhengzhanshanhaiguildscorebasicconfig_get,shSeasonLv,'rank_souce_get_tips')
end

return list,tips
end


function zhengzhanshanhaiController.getRaceCfg_ZZSH_Rank(...)
return zhengzhanshanhaiController:getZZSHCfg(...)
end

function zhengzhanshanhaiController.checkShowEnter_ZZSH_Rank()
local const_def=zhengzhanshanhaiController.getRankeDefCfg_ZZSH_Rank()

if const_def==nil then return false end

local open_fp_map=const_def.open_fp_map

if open_fp_map==nil then return true end

local tPfid=gameUtilityModel.getServerPlatform()

if open_fp_map[tPfid]~=nil and open_fp_map[tPfid]==1 then
return true
end

return false
end

function zhengzhanshanhaiController.getRankPreviewSettlementTime()
local rankSettlementPreviewEarlyTime=zhengzhanshanhaiController.getRaceCfg_ZZSH_Rank('rankSettlementPreviewEarlyTime')
if rankSettlementPreviewEarlyTime==nil then
return 0
end
local startTime,endTime,settleTime,settleEndTime=zhengzhanshanhaiModel:getSeasonTime()
if settleTime==nil then
return 0
end

local previewTime=settleTime-rankSettlementPreviewEarlyTime
return previewTime
end