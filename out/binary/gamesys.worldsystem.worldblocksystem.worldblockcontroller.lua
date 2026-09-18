






local _MODULENAME="worldBlockController"




gameState.addListener(def_table(_MODULENAME))
worldBlockController.name=_MODULENAME
worldBlockController.data={}
worldBlockController.fogEffect=1003
local _this=worldBlockController
local _openBlock_UnitEffect=3
local _openBlock_UnitFadeOutTime=0.5

function worldBlockController:onAppStart()
worldPositionConfig:onAppStart()
worldBlockModel:onAppStart()



socketManager:register_receiver(5,1,self.recv_5_1)
socketManager:register_receiver(5,2,self.recv_5_2)
socketManager:register_receiver(5,8,self.recv_5_8)


notifySystem:listenNotify(notifyConfig.onClickObjectInWorld,self.onClickFog)
notifySystem:listenNotify(notifyConfig.building_event,self.onZMLevelUp)
notifySystem:listenNotify(notifyConfig.onWorldBlockDataChanged,self.onWorldBlockDataChanged)
notifySystem:listenNotify(notifyConfig.onTaskChange,self.onTaskChange)
notifySystem:listenNotify(notifyConfig.enterWorld,self.onEnterWorld)
notifySystem:listenNotify(notifyConfig.onExperiencePointCompleted,self.onExperiencePointCompleted)


worldController:registerSceneState(1,0,function()
worldBlockModel:setSelectFog()
self:pushClouds(worldModel.world)
self:showWorldUnit(worldModel.world)

end)
worldController:registerSceneState(2,0,function()
worldBlockModel:setSelectFog()
end)
end


function worldBlockController:onEnterState()
worldPositionConfig:onEnterState()
worldBlockModel:onEnterState()
end


function worldBlockController:onServerDataInitFinish()
worldBlockModel:onServerDataInitFinish()
worldPositionConfig:onServerDataInitFinish()
end


function worldBlockController:onLeaveState()
worldBlockModel:onLeaveState()
worldPositionConfig:onLeaveState()

self.data={}
end


function worldBlockController:onLostConnection()

end

function worldBlockController:onProtocolReq()
worldBlockModel:checkInitStack()
if worldController:isInWorld()then
local worldId=worldModel.world
worldBlockController:pushClouds(worldId)
local sFog=worldBlockModel:getSelectFog()
worldBlockController:showWorldUnit(worldId)
local wCfg=cfgHelper.get1(cfg_worldblockconfig_get,worldId)
for blockId,bCfg in pairs(wCfg)do
if bCfg.cloud==sFog then
if worldBlockModel:checkBlockState(worldId,blockId,eWorldBlockState.OPEN)then
worldController:selectCloud()
break
end
end
end
end
end






function worldBlockController:send_5_2(world,block)
socketManager:send_5_2(world,block)
end








function worldBlockController:send_5_1()
socketManager:send_5_1()
end





function worldBlockController.recv_5_1(count,array,symbol,tourLen,tourList)
local worldId=worldModel.world
if worldController:isInWorld()then
worldBlockController:hideWorldUnit(worldId)
end

worldBlockModel:initBlockStateByServerData(array or{})
worldExperienceModel:initReward(symbol)

notifySystem:postNotify(notifyConfig.onWorldBlockDataInited,worldModel:checkInit(eWorldUnitTpye.FOG))
worldModel:finishInit(eWorldUnitTpye.FOG)

if initProControl.isDone()and worldController:isInWorld()then
worldBlockController:pushClouds(worldId)
worldBlockController:showWorldUnit(worldId)
local wCfg=cfgHelper.get1(cfg_worldblockconfig_get,worldId)
local sFog=worldBlockModel:getSelectFog()
for blockId,bCfg in pairs(wCfg)do
if bCfg.cloud==sFog then
if worldBlockModel:checkBlockState(worldId,blockId,eWorldBlockState.OPEN)then
worldController:selectCloud()
break
end
end
end
end
end





function worldBlockController.recv_5_2(world,block,errorCode)
if errorCode==0 then
_this:setBlockUnlock(world,block)
elseif errorCode==1 then
UIManager.error("迷雾已解封")
worldMonsterProtocolController.req_fresh()
elseif errorCode==2 then
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
for i,v in ipairs(blockCfg.unlock)do
if v[1]==1 and zongmenModel:getLevel()<v[2]then
return UIManager.error(FMT.fmt("解封迷雾需宗门达{0}级",v[2]or 0))
end
end
UIManager.error("解封迷雾未达到指定宗门等级")
elseif errorCode==3 then
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
for i,v in ipairs(blockCfg.consume or{})do
if not moneyModel.checkEnoughMoney(v[1],v[2])then
gainControl:showGainWin(v[1])
return UIManager.error(FMT.fmt("{0}不足",moneyModel.getMoneyName(v[1])))
end
end
UIManager.error("迷雾解封所需消耗材料不足")
elseif errorCode==4 then
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
for i,v in ipairs(blockCfg.unlock)do
if v[1]==2 and not taskModel:checkTaskFinish(v[2])then
local taskCfg=taskModel:getTaskConfig(v[2])
return UIManager.error("通过主线任务解锁")
end
end
UIManager.error("解封迷雾未达到指定任务")
end
end

function worldBlockController.recv_5_8(world,block)
worldController:stopCameraControl()
worldUnitModel.enable=false
worldBlockModel:setBlockState(world,block,eWorldBlockState.OPEN,false)
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
local experienceHeight=cfgHelper.get2(cfg_worldglobalconfig_get,"experienceCameraHeight","value")
local angle=blockCfg.eCameraRange[5]and worldController:getCameraCurveAngle(experienceHeight[2],true)or nil
local func=function()
UIManager:hideWindow("UIWorldExperienceWin")
local args={
world=world,
block=block,
cloudIndex=blockCfg.cloud,
position=Vector3.New(blockCfg.eExitPos[1],experienceHeight[2],blockCfg.eExitPos[2]),
angle=angle,
tree=blockCfg.openStory,
}
behaviorManager:addBehaviorTree("bw_blockopen",nil,true,args,true)
end
if blockCfg.eFinishPanel then
worldExperienceController:showCompleteWin(world,block,func)
else
func()
end
end





function worldBlockController:showWorldUnit(world)
local cfg=cfgHelper.get1(cfg_worldblockconfig_get,world)
for block,blockCfg in pairs(cfg)do
self:showBlockUnit(world,block)
end
end

function worldBlockController:hideWorldUnit(world)
local cfg=cfgHelper.get1(cfg_worldblockconfig_get,world)
for block,blockCfg in pairs(cfg)do
self:hideBlockUnit(world,block)
end
end

function worldBlockController:showBlockUnit(world,block,state)
local state=state or worldBlockModel:getBlockState(world,block)
if state~=eWorldBlockState.OPEN then
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
local fogId=state==eWorldBlockState.CLOSE and blockCfg.fog1 or blockCfg.fog2
local fogCfg=cfgHelper.get1(cfg_worldfogconfig_get,fogId)
local luaData={eWorldUnitTpye.FOG,fogId}
local unitKey=worldModel:convertUnitKey(luaData)
local position=mathHelper.convertArrayToVector(fogCfg.position)
local modelSettings=worldModel:getModelSettings(fogCfg.modelRes)
local hudSettings=worldModel:getHUDSetting(fogCfg.hudRes)
worldController:pushUnit(unitKey,position,luaData,modelSettings,hudSettings)
end
end

function worldBlockController:hideBlockUnit(world,block,state)
state=state or worldBlockModel:getBlockState(world,block)
if state~=eWorldBlockState.OPEN then
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
local fogId=state==eWorldBlockState.CLOSE and blockCfg.fog1 or blockCfg.fog2
local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.FOG,fogId})
worldController:popUnit(unitKey)
end
end

function worldBlockController.onWorldBlockDataChanged(world,block,cState,oState)

if worldController:isInWorld()and worldModel:isSameWorld(world)then
local cfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
if cfg then
worldBlockController:hideBlockUnit(world,block,oState)
worldBlockController:showBlockUnit(world,block,cState)
end
end

if cState==eWorldBlockState.OPEN then
for id,wCfg in pairs(cfg_worldconfig())do
local bCfg=cfgHelper.get2(cfg_worldblockconfig_get,id,1)
if bCfg.adjacentBlocks then
for index,adjacent in ipairs(bCfg.adjacentBlocks)do
if adjacent[1]==world and adjacent[2]==block then
if worldBlockModel:checkWorldReddotReset()then
worldBlockModel:setWorldReddotFlag(true)
return
end
end
end
end
end
end
end




function worldBlockController:setBlockUnlock(world,block)
local cState=worldBlockModel:getBlockState(world,block)
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
local func=function()
local show_data={
type='UIDialouge',
title='提示',
content=FMT.fmt("祖师是否立即派遣弟子探索{0}",blockCfg.name),
oktext='派遣',
canceltext='关闭',
okcallback=function()
worldExperienceController:readyTaskExperience(world,block,blockCfg.eTaskPlotDizi)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

notifySystem:postNotify(notifyConfig.onWorldBlockStateChanged,world,block,eWorldBlockState.UNLOCK,cState)
end

worldBlockModel:setBlockState(world,block,worldBlockModel.BLOCKSTATE.UNLOCK,true,func)
end

function worldBlockController:refreshWorldFogHUD(world,block)

local blocks={}
local cfg=cfg_worldblockconfig()
for i,v in pairs(cfg)do
for j,w in pairs(v)do
if w.adjacentBlocks then
for k,u in ipairs(w.adjacentBlocks)do

if u[1]==world and u[2]==block then
table.insert(blocks,{i,j})
end
end
end
end
end

for i,v in ipairs(blocks)do
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,v[1],v[2])
local fogID=blockCfg.fog1
local unitKey=worldModel:convertUnitKey({worldModel.UNITTYPE.FOG,fogID})
worldHUDModel:UpdateHUDByKey(unitKey)
end
end



function worldBlockController:pushClouds(world)
worldController:setClouds(worldBlockModel:getClouds(world))
end






function worldBlockController:pushSingleCloud(world,block,time,callBack)
local data=worldBlockModel:getCloud(world,block)
worldController:setSingleCloud(data,time,callBack)
end






function worldBlockController.onZMLevelUp(eventtype,level,exp,lastLv)
if eventtype==buildingEvent.zongmenLevelUp then
if worldController:isInWorld()then
local worldId=worldModel.world
local blocks={}
local worldCfg=cfgHelper.get1(cfg_worldblockconfig_get,worldId)
for blockId,blockCfg in pairs(worldCfg)do
for i,v in ipairs(blockCfg.unlock)do
if v[1]==1 and v[2]<=level and v[2]>lastLv then
blocks[blockId]=true
break
end
end
end
for blockId,check in pairs(blocks)do
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,worldId,blockId)
local unitKey=worldModel:convertUnitKey({worldModel.UNITTYPE.FOG,blockCfg.fog1})
worldHUDModel:UpdateHUDByKey(unitKey)
end
end

if worldBlockModel:checkWorldReddotReset()then
worldBlockModel:setWorldReddotFlag(true)
end
end
end



function worldBlockController.onClickFog(args)
if worldExperienceModel:checkScene()then
return
end
if(args and args[1]==worldModel.UNITTYPE.FOG)then
local fogCfg=cfgHelper.get1(cfg_worldfogconfig_get,args[2])
local block=fogCfg.block
local world=fogCfg.world
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)

if fogCfg.state==worldBlockModel.BLOCKSTATE.CLOSE then
if worldBlockModel:getSelectFog()~=blockCfg.cloud then
worldController:selectCloud(blockCfg.cloud)
end
local func=function()





UIManager:showWindow("UIWorldBlockUnlockWin",{world=world,block=block})
end
_this:lookAtFog(world,block,blockCfg,func)
elseif fogCfg.state==worldBlockModel.BLOCKSTATE.UNLOCK then

if not worldExperienceModel:checkScene()then
local task=worldExperienceModel:getTask()
if task then
if task.progress_state==eWorldTripProgress.Work then
worldExperienceController:enterExperience()
elseif task.progress_state==eWorldTripProgress.Go then
UIManager.info("弟子正在前往")
elseif task.progress_state==eWorldTripProgress.Back then

worldExperienceController:readyTaskExperience(world,block,blockCfg.eTaskPlotDizi)
end
else
worldExperienceController:readyTaskExperience(world,block,blockCfg.eTaskPlotDizi)
end
end
worldController:selectCloud()
end
else
worldController:selectCloud()
end
end

function worldBlockController:triggerUnlockFog(blockCfg,world,block)
if self:triggerUnlockFogNotEnough(blockCfg,world,block)then
self:triggerUnlockFogEnough(blockCfg,world,block)
end
end

function worldBlockController:triggerUnlockFogNotEnough(blockCfg,world,block)
local can,code=worldBlockModel:canUnlockBlock(world,block)
if not can then
local preInfo=worldBlockModel:findSourceBlock(world,block)
if not preInfo then return false end
local preCfg=cfgHelper.get2(cfg_worldblockconfig_get,preInfo[1],preInfo[2])
local contentStr=FMT.fmt("探索<color=#7d3b17>{0}</color>后方可解封",preCfg.name)
local show_data={
type='UIDialouge',
title='解封',
content=contentStr,
oktext='前往解封',
canceltext='关闭',
okcallback=function()
self:lookAtFog(preInfo[1],preInfo[2],preCfg)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return false
end
local enough,code1,code2=worldBlockModel:isUnLockEnoughCondition(world,block)
if not enough then
if code1==1 then
UIManager.info(FMT.fmt("宗门{0}级方可解封",code2))
elseif code1==2 then
local taskCfg=taskModel:getTaskConfig(code2)
UIManager.info(FMT.fmt("完成主线·{0}后解锁",taskCfg.name))
end
return false
end
return true
end

function worldBlockController:lookAtFog(world,block,cfg,callback)
local blockCfg=cfg or cfgHelper.get2(cfg_worldblockconfig_get,world,block)
if world==worldModel.world then
local cPos=worldController:getCameraPosition()
local position=Vector3.New(cfg.eExitPos[1],cPos.y,cfg.eExitPos[2])
worldController:setCameraPosition(position,false,callback)
else
local worldCfg=cfgHelper.get1(cfg_worldconfig_get,world)
local position=Vector3.New(cfg.eExitPos[1],worldCfg.cameraPos[2],cfg.eExitPos[2])
worldController:enterWorld(world,{position=position})
end
end

function worldBlockController:triggerUnlockFogEnough(blockCfg,world,block)
local costStr=""
for i,v in ipairs(blockCfg.consume)do
local moneyStr=FMT.fmt("{0}",v[2])
moneyStr=FMT.fmt("quad-icon={2}-quad<color=#{0}>{1}</color>",
moneyModel.checkEnoughMoney(v[1],v[2])and"549327FF"or"FF0000FF",moneyStr,
moneyModel.getIconNameEx(v[1]))
costStr=FMT.fmt("{0}{1}{2}",costStr,i==1 and""or"和",moneyStr)
end
local contentStr=FMT.fmt("解封<color=#7d3b17>{1}</color>需要消耗{0}\n\n祖师是否即刻解封\n",costStr,blockCfg.name)
local show_data={
type='UIDialougeWithIcon',
title='解封',
content=contentStr,
oktext='解封',
canceltext='取消',
okcallback=function()
for i,v in ipairs(blockCfg.consume)do
if not moneyModel.checkEnoughMoney(v[1],v[2])then
UIManager.error(FMT.fmt("{0}不足",moneyModel.getMoneyName(v[1])))
gainControl:showGainWin(v[1])
return
end
end
_this:send_5_2(world,block)
worldController:selectCloud()
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end

function worldBlockController:resumeUnit()
local handle=function(i,v)
local infos=worldModel:separateUnitKey(i)
local typo=tonumber(infos[1])
local func=function()
worldUnitModel:doAnimationSpe(typo,i)
end
worldController:changeModelColor(i,Color.clear,0)
worldController:changeModelColor(i,Color.white,_openBlock_UnitFadeOutTime,func)
end
worldUnitModel:resumeAll(handle)
worldUnitModel.enable=true
end

function worldBlockController:onOpenBlockComplete(world,block)

worldExperienceModel:outScene()
worldController:setCameraState(eWorldCameraState.Normal)
local cameraConfig=cfgHelper.get1(cfg_worldconfig_get,world)
local zoomRange=mathHelper.convertArrayToVector(worldController:getCameraZoomRange_Normal_Imp(cameraConfig))
local moveRange=mathHelper.convertArrayToVector(cameraConfig.cameraMove)
worldController:lockCameraInRange(moveRange,zoomRange)
worldUnitModel:clearData()
worldController:resumeCameraControl()


if not mainViewsControl.checkLastMainType(MAIN_VIEW_TYPE.eWorld)then
baseFullScreenUI:openMain(true)
else
worldController:showPanel()
end









notifySystem:postNotify(notifyConfig.onWorldBlockStateChanged,world,block,eWorldBlockState.OPEN,eWorldBlockState.UNLOCK)

newbieManager.startNewbie(NEW_BIE_CND_TYPE.eWorldBlock,world,block)
end

function worldBlockController.onTaskChange(taskid,taskstate)
if taskstate==taskModel.taskFinishState then
if worldController:isInWorld()then
local worldId=worldModel.world
local blocks={}
local worldCfg=cfgHelper.get1(cfg_worldblockconfig_get,worldId)
for blockId,blockCfg in pairs(worldCfg)do
for i,v in ipairs(blockCfg.unlock)do
if v[1]==2 and v[2]==taskid then
blocks[blockId]=true
break
end
end
end
for blockId,check in pairs(blocks)do
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,worldId,blockId)
local unitKey=worldModel:convertUnitKey({worldModel.UNITTYPE.FOG,blockCfg.fog1})
worldHUDModel:UpdateHUDByKey(unitKey)
end
end

if worldBlockModel:checkWorldReddotReset()then
worldBlockModel:setWorldReddotFlag(true)
end
end
end

function worldBlockController.onEnterWorld(progress,world)

if progress==eWorldEnterPhase.Completed then
if worldBlockModel:getWorldReddotFlag()and not worldBlockModel:checkBlockState(world,1,eWorldBlockState.OPEN)then
worldBlockModel:setWorldReddotFlag(false)
end
end
end

function worldBlockController.onExperiencePointCompleted(point)
local pointCfg=cfgHelper.get1(cfg_experienceconfig_get,point)
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,pointCfg.worldid,pointCfg.blockid)
local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.FOG,blockCfg.fog2})
worldHUDModel:onUpdateHUD(unitKey)
end








function worldBlockController.send_all_5_8_this_world()






end
