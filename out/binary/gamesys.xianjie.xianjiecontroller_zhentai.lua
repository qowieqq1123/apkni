function xianjieController:onAppStart_zhentai()
socketManager:register_receiver(39,35,self.recv_39_35)
socketManager:register_receiver(39,36,self.recv_39_36)
socketManager:register_receiver(39,37,self.recv_39_37)
end

function xianjieController:onEnterState_zhentai(isReconnet)
xianjieModel:initData_zhentai()
end

function xianjieController:onLeaveState_zhentai(isReconnet)
xianjieModel:clearData_zhentai()
end

function xianjieController:onEnterMap_zhentai()
xianjieModel:onEnterMap_zhentai()
end

function xianjieController:onExitMap_zhentai()
xianjieModel:onExitMap_zhentai()
end

function xianjieController:reqFixZhenTai(seasonType,stageIndex,build_id,fixNum,isAuto)
if isAuto then
xianjieModel:setZhenTaiAutoFixNum(fixNum)
else
xianjieModel:setZhenTaiAutoFixNum(0)
end
fixNum=tostring(fixNum)
seasonController:send_39_2(seasonType,stageIndex,3,build_id,fixNum)
end

function xianjieController:reqWorshipZhenTai(seasonType,stageIndex,build_id)
seasonController:send_39_2(seasonType,stageIndex,4,build_id)
end

function xianjieController:reqZhenTaiRankDataList(seasonType,stageIndex,build_id,rankType)
rankType=tostring(rankType)
seasonController:send_39_2(seasonType,stageIndex,5,build_id,rankType)
end

function xianjieController.recv_39_35(args)
local seasonType=args[1]
local stageIndex=args[2]
local rank=args[3]
local score=args[4]
local len=args[5]
local list=args[6]
local build_id=args[7]

xianjieModel:setZhenTaiRank(seasonType,stageIndex,build_id,1,list,rank,score)
end

function xianjieController.recv_39_36(args)
local seasonType=args[1]
local stageIndex=args[2]
local rank=args[3]
local score=args[4]
local len=args[5]
local list=args[6]
local build_id=args[7]

xianjieModel:setZhenTaiRank(seasonType,stageIndex,build_id,2,list,rank,score)
end

function xianjieController.recv_39_37(seasonType,stageIndex,len,list)
if len>0 then
for i,v in ipairs(list)do
local build_id=v.param_1
local finish_cnt=v.param_2
local entityData=xianjieModel:getZhenTaiEntity(seasonType,stageIndex,build_id)
if entityData then
entityData.finish_cnt=finish_cnt
entityData:refreshEntity()
end
end
end
end


function xianjieController:refreshMoJieZhenTaiDefaultData()







end


function xianjieController:jumpMoJieZhenTai(seasonType,stageIndex,build_id,isOpenWin,height)
height=height or 50
local isOpenMoJie=xianjieModel:checkCurrentMoJieEnterTime()
if not isOpenMoJie then
UIManager.error("魔界未开启，无法跳转")
return false
end

local stage=seasonModel:getStage(seasonType,stageIndex)
if not(stage:checkOpen()and stage:isOverBegin())then
UIManager.error("赛季阶段未开启，无法跳转")
return false
end

local openFunc
if isOpenWin then
openFunc=function()
return xianjieController:openZhenTaiWin(seasonType,stageIndex,build_id)
end
end

local configs=seasonModel:getStageConfigEx(seasonType,stageIndex)
local client_build_list=configs.client_build_list
local client_build_id=client_build_list[build_id]
local buildCfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,client_build_id)
local sceneIdx=xianjieModel:getCurrentMoJieSceneIndex()or buildCfg.sceneidx
xianjieController:jumpGrid(sceneIdx,buildCfg.x,buildCfg.y,openFunc,true,nil,height)
return true
end