

function xianjieController:onAppStart_mojieGate()
socketManager:register_receiver(39,16,self.recv_39_16)
end

function xianjieController:onEnterState_mojieGate(isReconnet)
xianjieModel:initAllMoJieGateDatas()
end

function xianjieController:onLeaveState_mojieGate(isReconnet)
xianjieModel:clearData_allMoJieGate()
end

function xianjieController:onEnterMap_mojieGate()
xianjieModel:onEnterMap_mojieGate()
end

function xianjieController:onExitMap_mojieGate()
xianjieModel:onExitMap_mojieGate()
end

function xianjieController.onXianMengChange_mojieGate()

local originialGateId=xianjieModel:clearMoJieGateSelfXmOwnGateId()

UIManager:invokeUIMethod("UIMoJieGate_infoWin","refreshByGateId",originialGateId)
UIManager:invokeUIMethod("UIMoJieGate_attackWin","refreshByGateId",originialGateId)

UIManager:invokeUIMethod('UIXianJieFuncStorageWin','refreshGateApply')

end


function xianjieController:reqApplyForGatePass(seasonId,stageIndex,gateId)
local reqType=1
seasonController:send_39_2(seasonId,stageIndex,reqType,gateId)
UIManager.info("已成功向归属仙盟发起通过权限申请，请静候佳音")
end


function xianjieController:reqAllowGatePass(seasonId,stageIndex,gateId,xmId)
local reqType=2
local xmIdStr=tostring(xmId)
seasonController:send_39_2(seasonId,stageIndex,reqType,gateId,xmIdStr)
end


function xianjieController:reqRemoveGatePass(seasonId,stageIndex,gateId,xmId)
local reqType=4
local xmIdStr=tostring(xmId)
seasonController:send_39_2(seasonId,stageIndex,reqType,gateId,xmIdStr)
end






function xianjieController:reqSetGatePassType(seasonId,stageIndex,gateId,passType)
local reqType=3
local passTypeStr=tostring(passType)
seasonController:send_39_2(seasonId,stageIndex,reqType,gateId,passTypeStr)
end



function xianjieController.recv_39_16(season_id,chapter_idx,guankou_data)
local handle=seasonModel:getHandle(season_id)
if handle and handle:checkCondition()then
local stage=seasonModel:getStage(season_id,chapter_idx)
if stage then
local seasonId=stage.handle.id
local stageId=stage.id
local stageType=stage.type
local stageIndex=stage.index
local gateId=guankou_data.guankou_id
local data={
seasonId=seasonId,
stageId=stageId,
stageType=stageType,
stageIndex=stageIndex,
gateId=gateId,
hp=guankou_data.hp,
atkTime=guankou_data.attack_sec or 0,
fixTime=guankou_data.fix_sec or 0,
xmInfo=guankou_data.own_guild_info,
askSetting=guankou_data.ask_setting,
askListLen=guankou_data.ask_list_len,
askList=guankou_data.ask_list,
whiteListLen=guankou_data.whitelist_len,
whiteList=guankou_data.whitelist,
rankListLen=guankou_data.rank_len,
rankList=guankou_data.rank,
}
xianjieModel:setMoJieGateData(gateId,data)

notifySystem:postNotify(notifyConfig.onSeasonStageDataChange,season_id,chapter_idx)


UIManager:invokeUIMethod("UIMoJieGate_infoWin","refreshByGateId",gateId)
UIManager:invokeUIMethod("UIMoJieGate_attackWin","refreshByGateId",gateId)
UIManager:invokeUIMethod("UIMoJieGate_passListWin","refreshByGateId",gateId)

local selfXmOwnGateId=xianjieModel:getMoJieGateSelfXmOwnGateId()
if selfXmOwnGateId==gateId then

UIManager:invokeUIMethod('UIXianJieFuncStorageWin','refreshGateApply')
end
end
end
end


function xianjieController:jumpMoJieGateByGateId(gateId,isOpenWin,isShowPassList,height,isIgnoreXy)
height=height or 50
local isOpenMoJie=xianjieModel:checkCurrentMoJieEnterTime()
if not isOpenMoJie then
UIManager.error("魔界未开启，无法跳转")
return false
end

local gateCfg=cfgHelper.get1(cfg_devildomscenegateconfig_get,gateId)
local gateXYSceneIndex=gateCfg.area
local isSelfXianYu=gateXYSceneIndex==xianjieModel:getXianYuSceneIndex()
if not isSelfXianYu and not isIgnoreXy then
UIManager.error("非本仙域关口，无法跳转")
return false
end

local openFunc
if isOpenWin then
openFunc=function()
return xianjieController:openMoJieGateWin(gateId,isShowPassList)
end
end

local buildId=gateCfg.build_id
local buildCfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,buildId)
local sceneIdx=xianjieModel:getCurrentMoJieSceneIndex()or buildCfg.sceneidx
xianjieController:jumpGrid(sceneIdx,buildCfg.x,buildCfg.y,openFunc,true,nil,height)
return true
end



function xianjieController:test_printMoJieGateId()
local win=UIManager:findActiveWindow('UIMoJieGate_attackWin')
if not win then
win=UIManager:findActiveWindow('UIMoJieGate_infoWin')
end

if win then
local gateId=win.gateId

end
end
