

local weekSec=604800
PASS_Reward_Type={
eFree=0,
eReward1=1,
eReward2=2,
}
function zhengzhanshanhaiController:onAppStart_zhanling()
zhengzhanshanhaiModel:onAppStart_zhanling()
socketManager:register_receiver(20,213,self.recv_20_213)
socketManager:register_receiver(20,215,self.recv_20_215)


socketManager:register_receiver(44,213,self.recv_44_213)
socketManager:register_receiver(44,215,self.recv_44_215)

socketManager:register_receiver(44,11,self.recv_44_11)
socketManager:register_receiver(44,12,self.recv_44_12)
socketManager:register_receiver(44,13,self.recv_44_13)
socketManager:register_receiver(44,14,self.recv_44_14)
socketManager:register_receiver(44,15,self.recv_44_15)
socketManager:register_receiver(44,16,self.recv_44_16)


end

function zhengzhanshanhaiController:onEnterState_zhanling(isReconnet)
zhengzhanshanhaiModel:onEnterState_zhanling(isReconnet)

end

function zhengzhanshanhaiController:onLeaveState_zhanling(isReconnet)
zhengzhanshanhaiModel:onLeaveState_zhanling(isReconnet)
end

function zhengzhanshanhaiController:onProtocolReq_zhanling(isReconnet)











end
















function zhengzhanshanhaiController.req_getZZSHZhanLingData()
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_213()
else
socketManager:send_20_213()
end
end


function zhengzhanshanhaiController.req_getZZSHZhanLingReward()
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_214()
else
socketManager:send_20_214()
end
end


function zhengzhanshanhaiController.req_buyZZSHZhanLingWithMoney()
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_215()
else
socketManager:send_20_215()
end
end


function zhengzhanshanhaiController.req_44_11()
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then
socketManager:send_44_11()
end
end


function zhengzhanshanhaiController.req_44_13()
socketManager:send_44_13()
end



function zhengzhanshanhaiController.req_44_14(rw_type)
socketManager:send_44_14(rw_type)
end



function zhengzhanshanhaiController.req_44_15(cnt)
socketManager:send_44_15(cnt)
end



function zhengzhanshanhaiController.req_44_16(buy_level)
socketManager:send_44_16(buy_level)
end



function zhengzhanshanhaiController.recv_20_213(args)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end
return zhengzhanshanhaiController.recv_getZhanLingData(args)
end


function zhengzhanshanhaiController.recv_20_215()
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if isInSeason then

return
end
return zhengzhanshanhaiController.recv_buyZhanLingGoods()
end


function zhengzhanshanhaiController.recv_44_213(args)
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_getZhanLingData(args)
end


function zhengzhanshanhaiController.recv_44_215()
local isInSeason=zhengzhanshanhaiModel:checkIsInSeason()or false
if not isInSeason then

return
end
return zhengzhanshanhaiController.recv_buyZhanLingGoods()
end





function zhengzhanshanhaiController.recv_44_11(args)
local passport_id=args[1]
local level=args[2]
local score=args[3]
local max_level_box_cnt=args[4]
local reward_1_flag=args[5]
local reward_2_flag=args[6]
local len=args[7]
local list=args[8]

local data={}
data.passport_id=passport_id
data.level=level
data.score=score
data.max_level_box_cnt=max_level_box_cnt
data.rewardBuyFlag={}
data.rewardBuyFlag[PASS_Reward_Type.eFree]=true
data.rewardBuyFlag[PASS_Reward_Type.eReward1]=reward_1_flag==1
data.rewardBuyFlag[PASS_Reward_Type.eReward2]=reward_2_flag==1
data.len=len
if len>0 then
local lookupList={}
for i,v in ipairs(list)do
local recvFlagList={}
recvFlagList[PASS_Reward_Type.eFree]=mathHelper.getBitValue(v.param_2,PASS_Reward_Type.eFree)
recvFlagList[PASS_Reward_Type.eReward1]=mathHelper.getBitValue(v.param_2,PASS_Reward_Type.eReward1)
recvFlagList[PASS_Reward_Type.eReward2]=mathHelper.getBitValue(v.param_2,PASS_Reward_Type.eReward2)
lookupList[v.param_1]=recvFlagList

end
data.list=lookupList
end

zhengzhanshanhaiModel:setPassData(data)
UIManager:invokeUIMethod("UIXM_ZZSH_MapWin","refershZhanLing")
zhengzhanshanhaiController.passDataRefresh()
end




function zhengzhanshanhaiController.recv_44_12(level,score)
local passdata=zhengzhanshanhaiModel:getPassData()
passdata.level=level
passdata.score=score
zhengzhanshanhaiController.passDataRefresh()
end


function zhengzhanshanhaiController.recv_44_13()


end



function zhengzhanshanhaiController.recv_44_14(rw_type)
local passdata=zhengzhanshanhaiModel:getPassData()
passdata.rewardBuyFlag[rw_type]=true
zhengzhanshanhaiController.passDataRefresh()
end



function zhengzhanshanhaiController.recv_44_15(cnt)
local passdata=zhengzhanshanhaiModel:getPassData()
local passport_id=passdata.passport_id
local passCfg=cfgHelper.get(cfg_zhengzhanshanhaipassportconfig_get,passport_id)
local max_level_box=passCfg.max_level_box
passdata.max_level_box_cnt=passdata.max_level_box_cnt+cnt
passdata.score=passdata.score-cnt*max_level_box[1]
zhengzhanshanhaiController.passDataRefresh()
end



function zhengzhanshanhaiController.recv_44_16(buylevel)
local passdata=zhengzhanshanhaiModel:getPassData()
passdata.level=passdata.level+buylevel
zhengzhanshanhaiController.passDataRefresh()
end


function zhengzhanshanhaiController.recv_getZhanLingData(args)
local data={}
data.complete_cnt=args[1]
data.free_reward_flag=tonumber(tostring(args[2]))
data.moeny_rewards_flag=tonumber(tostring(args[3]))
data.recharge_reward_flag=tonumber(tostring(args[4]))
data.is_money=args[5]
data.is_recharge=args[6]
data.beginTimes=args[7]
zhengzhanshanhaiModel:setZhanLingData(data)
UIManager:invokeUIMethod("UIXM_ZZSH_ShanHaiZhanLingWin","refresh")
UIManager:invokeUIMethod("UIXM_ZZSH_TouziUnLockWin","freshInfo")
reddotControl.on_change_catch_type(CATCH_TYPE.eSHZhanLing)
end


function zhengzhanshanhaiController.recv_buyZhanLingGoods()
local data=zhengzhanshanhaiModel:getZhanLingData()
if not data then
return
end
data.is_money=1
UIManager:invokeUIMethod("UIXM_ZZSH_ShanHaiZhanLingWin","refresh")
UIManager:invokeUIMethod("UIXM_ZZSH_TouziUnLockWin","freshInfo")
reddotControl.on_change_catch_type(CATCH_TYPE.eSHZhanLing)
end



function zhengzhanshanhaiController.checkPVEState()
if limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eZhengZhanShanHai)then
if zhengzhanshanhaiModel:checkJoin()then
local raceState,left=zhengzhanshanhaiModel:getLunState()
if raceState==eZZSH_State.ePVEFight then
if not zhengzhanshanhaiModel:checkSHZhanLingNextRest()or zhengzhanshanhaiModel:checkIsSeasonDoNotResetTaskAndZhanLing()then

local newLeft=left+weekSec
local leftTime=limitActivitiesModel:getActEndLeftTime(LIMIT_ACT_TYPE.eZhengZhanShanHai)
return true,math.min(newLeft,leftTime)
else

return true,left
end










end
end
end
return false,0
end

function zhengzhanshanhaiController.checkSHZhanLingOpen()
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then

if not systemModel.isOpen(SYSTEM_DEFINE.eShanHaiZhanLing)then
return false
end
else

if not systemModel.isOpen(SYSTEM_DEFINE.eShanHaiZhanLingNew)then
return false
end
end


local shSeasonState=zhengzhanshanhaiModel:getSeasonState()
if shSeasonState~=1 then

return false
end

return zhengzhanshanhaiController.checkPVEState()
end

function zhengzhanshanhaiController.checkSJXianZangOpen()
local passport_id=zhengzhanshanhaiModel:getPassData_passport_id()
local seasonState=zhengzhanshanhaiModel:getSeasonState()
return passport_id and passport_id>0 and seasonState and seasonState<=2
end

function zhengzhanshanhaiController.finishSHZhanLing()

if zhengzhanshanhaiController.checkSHZhanLingOpen()then
return
end
UIFullSHZhanLingController:closeUI()
UIManager:closeWindow('UIXM_ZZSH_TouziUnLockWin')
UIManager:closeWindow('UIRuleWin')
end

function zhengzhanshanhaiController.passDataRefresh()
UIManager:invokeUIMethod("UIXM_ZZSH_SaiJiXianZangWin","refresh")
UIManager:invokeUIMethod("UIXM_SJXZ_TouziUnLockWin","freshInfo")
reddotControl.on_change_catch_type(CATCH_TYPE.eSJXianZang)
end

