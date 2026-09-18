function xianjieController:onAppStart_mojiang()
socketManager:register_receiver(39,10,self.recv_39_10)
socketManager:register_receiver(39,11,self.recv_39_11)
socketManager:register_receiver(39,12,self.recv_39_12)
socketManager:register_receiver(39,13,self.recv_39_13)
socketManager:register_receiver(39,14,self.recv_39_14)
socketManager:register_receiver(39,15,self.recv_39_15)
end

function xianjieController:onEnterState_mojiang(isReconnet)
xianjieModel:initData_mojiang()
end

function xianjieController:onLeaveState_mojiang(isReconnet)
xianjieModel:clearData_mojiang()
end

function xianjieController:onEnterMap_mojiang()
xianjieModel:onEnterMap_mojiang()
end

function xianjieController:onExitMap_mojiang()
xianjieModel:onExitMap_mojiang()
end

function xianjieController:reqMoJiangRankDataList(seasonType,stageIndex,build_id,rankType)
seasonController:send_39_2(seasonType,stageIndex,rankType==1 and 3 or 4,build_id)
end

function xianjieController:reqMoJiangFightRecordList(seasonType,stageIndex,build_id)
seasonController:send_39_2(seasonType,stageIndex,5,build_id)
end

function xianjieController:reqMoJiangDamageReward(seasonType,stageIndex,build_id,top)
seasonController:send_39_2(seasonType,stageIndex,6,build_id,tostring(top))
end

function xianjieController:reqMoJiangDailyReward(seasonType,stageIndex,build_id,target)
seasonController:send_39_2(seasonType,stageIndex,7,build_id,tostring(target))
end

function xianjieController.recv_39_10(seasonType,stageIndex,build_id,damage)
local entityData=xianjieModel:getMoJiangEntity(seasonType,stageIndex,build_id)
if entityData then
entityData.damage=mathHelper.int64_to_number(damage)
entityData:refreshEntity()
end
end

function xianjieController.recv_39_11(seasonType,stageIndex,build_id,hp)
local entityData=xianjieModel:getMoJiangEntity(seasonType,stageIndex,build_id)
if entityData then
entityData.hp=hp

if hp<=0 and entityData.killTime<=0 then
seasonController:send_39_4(seasonType,stageIndex)
end
end
end

function xianjieController.recv_39_12(args)
local seasonType=args[1]
local stageIndex=args[2]
local build_id=args[3]
local len=args[4]
local list=args[5]
local score=args[6]
local rank=args[7]
xianjieModel:setMoJiangRank(seasonType,stageIndex,build_id,1,list or defaultT,rank,score)
end

function xianjieController.recv_39_13(args)
local seasonType=args[1]
local stageIndex=args[2]
local build_id=args[3]
local len=args[4]
local list=args[5]
local score=args[6]
local rank=args[7]
xianjieModel:setMoJiangRank(seasonType,stageIndex,build_id,2,list or defaultT,rank,score)
end

function xianjieController.recv_39_14(seasonType,stageIndex,build_id,len,list)
xianjieModel:setMoJiangRecord(seasonType,stageIndex,build_id,list or defaultT)
end

function xianjieController.recv_39_15(seasonType,stageIndex,build_id,fighted)
local entityData=xianjieModel:getMoJiangEntity(seasonType,stageIndex,build_id)
if entityData then
entityData.fighted=fighted
end
end