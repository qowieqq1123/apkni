






function xianjieController:onEnterState_mogongzhengduo(isReconnet)
end

function xianjieController:onLeaveState_mogongzhengduo(isReconnet)
end

function xianjieController:onEnterMap_mogongzhengduo(ischange,enterParam)

xianjieController:excuteAllPlotBehavior3()

xianjieModel:setAllDirty(SYSTEM_ATTRIBUTE_TYPE.aGuBao)
local simMixColor=cfgHelper.get(cfg_globalconfig_get,1,"simMixColor")
shaderHelper.setSimLight(true,simMixColor[1],simMixColor[2],simMixColor[3])
end

function xianjieController:onLeaveMap_mogongzhengduo(ischange)
xianjieModel:clearZongmenOutPos_mogongzhengduo()
xianjieModel:clearData_plotBehavior()
shaderHelper.setSimLight(false)

xianjieModel:setAllDirty(SYSTEM_ATTRIBUTE_TYPE.aGuBao)
end


function xianjieController:reqCreateZMPos_mogongzhengduo(enterCall,enterParam)
if not self.send_35_181_ing then
socketManager:send_35_181(mjZongMenPosRandType.eMoGongZhengDuo)
self.send_35_181_ing=true
self.send_35_181_enterCall=enterCall
self.send_35_181_enterParam=enterParam
end
end






function xianjieController:checkCanEnterMoGongZhengDuo()
if not xianmengModel:hasXM()then
UIManager.error("需要加入仙盟")
return
end

local remainSec=moGongZhengDuoActModel:getEnterIntervalRemainSec()
if remainSec and remainSec>0 then
UIManager.info(timeHelper.format_time_stamp4(remainSec).."后方可进入")
return false
end

local isJoinMoJie=xianjieModel:checkJoin_mojie()or xianjieModel:checkJoin_mogongzhengduo()
local isInMoGong=moGongZhengDuoActModel:getActInSceneFlag()==1
if not isJoinMoJie then
UIManager.info("需要进入过魔界方可参与")
return false,"需要进入过魔界方可参与"
end

local sceneType=mainControl:getSceneType()
if sceneType~=eSceneType.eXianJie and not isInMoGong then
local content="需要先前往魔界或仙界"
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return false,content
end

local isInMG=moGongZhengDuoActModel:getActInSceneFlag()==1
local isInMGScene=xianjieController:checkInMoGongZhengDuo()
local isJoin_MGZD=xianjieModel:checkJoin_mogongzhengduo()



if not isInMGScene and(not isInMG)then
local list=xianjieModel:getAllWaiPaiTeamHandle()or defaultT
local num_1=#list
local num_2=xianjieModel:getWaiPaiTeamNum()

if num_1>0 and num_2>0 then
UIManager.error("有队伍在外，无法进入活动")
return false
end
end

if isJoin_MGZD then return true end







local yzNum=YingXianGeModel:getWithMyYZTotal()
if yzNum>0 then
UIManager.error("存在援助自己的队伍，无法进入活动")
return false
end

return true
end
