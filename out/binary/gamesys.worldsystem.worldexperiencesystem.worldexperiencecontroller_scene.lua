

function worldExperienceController:enterExperience(soon)

if not worldExperienceModel:chekcValid()then
return logErr("没有当前历练数据")
end

worldController:displaySymbol(false)
worldController:displayUI(false)

UIManager:hideWindow("UITaskListWin")

worldController:hideView()

soon=soon or false
local cWorld=worldExperienceModel:getCurrentWorld()
local cBlock=worldExperienceModel:getCurrentBlock()
worldExperienceModel:intoScene(cWorld,cBlock)
worldController:setCameraState(eWorldCameraState.Experience)

local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,cWorld,cBlock)
local experienceHeight=cfgHelper.get2(cfg_worldglobalconfig_get,"experienceCameraHeight","value")
local eCameraHeight=blockCfg.eCameraHeight
local zoomMin=eCameraHeight and eCameraHeight[3]and eCameraHeight[3][1]or experienceHeight[1]
local zoomMax=eCameraHeight and eCameraHeight[3]and eCameraHeight[3][2]or experienceHeight[1]
local cameraHeight=eCameraHeight and eCameraHeight[1]or experienceHeight[1]

local cameraRange=blockCfg.eCameraRange
local moveRange=Vector4.New(cameraRange[1],cameraRange[2],cameraRange[3],cameraRange[4])
local zoomRange=Vector2.New(zoomMin,zoomMax)
worldController:lockCameraInRange(moveRange,zoomRange)

local cloudIdx=blockCfg.cloud
local angle=cameraRange[5]
local stand=worldExperienceModel:getStandPoint()
local standCfg=cfgHelper.get1(cfg_experienceconfig_get,stand)
local position=Vector3.New(standCfg.cameraPos[1],cameraHeight,standCfg.cameraPos[2])

if soon then
local cloudState=3
local cloudData=bit.lshift(cloudState,16)+cloudIdx
worldController:setSingleCloud(cloudData,0)
worldController:setCameraPosition(position,true)
if angle then
local cTF=worldController:getCameraTransform()
cTF.rotation=Quaternion.Euler(Vector3.right*angle)
worldController:setCurveWorld(false)
end
worldController:markCameraViewChange()
self:afterEnterExperience()
else
local args={
cloudIndex=cloudIdx,
position=position,
angle=angle
}
behaviorManager:addBehaviorTree("bw_enterexperience",nil,true,args,true)
self.animation=true
end
end


function worldExperienceController:afterEnterExperience()
self.animation=false
UIManager:showWindow("UIWorldExperienceWin",true)
local world,block=worldExperienceModel:getScene()
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)

if blockCfg.eAutoContinue then
self:doContinue()
end
end


function worldExperienceController:exitExperience()
if not worldExperienceModel:checkScene()then return end

local cWorld,cBlock=worldExperienceModel:getScene()
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,cWorld,cBlock)
local experienceHeight=cfgHelper.get2(cfg_worldglobalconfig_get,"experienceCameraHeight","value")
local eCameraHeight=blockCfg.eCameraHeight
local cameraHeight=eCameraHeight and eCameraHeight[2]or experienceHeight[2]
local cloudIdx=blockCfg.cloud
local angle=blockCfg.eCameraRange[5]and worldController:getCameraCurveAngle(cameraHeight,true)or nil
local position=Vector3.New(blockCfg.eExitPos[1],cameraHeight,blockCfg.eExitPos[2])
local blockState=worldBlockModel:getBlockState(cWorld,cBlock)
local cloudState=mathHelper.lShiftNum(blockState,2)or 0
local cloudData=bit.lshift(cloudState,16)+cloudIdx

UIManager:hideWindow("UIWorldExperienceWin")
UIManager:closeWindow("UIWorldBossWin")

local args={
cloudIndex=cloudIdx,
cloudState=cloudState,
position=position,
angle=angle
}
behaviorManager:addBehaviorTree("bw_exitexperience",nil,true,args,true)
self.animation=true
end


function worldExperienceController:afterExitExperience()
self.animation=false
worldExperienceModel:outScene()
worldController:setCameraState(eWorldCameraState.Normal)
local cameraConfig=cfgHelper.get1(cfg_worldconfig_get,worldModel.world)
local zoomRange=mathHelper.convertArrayToVector(worldController:getCameraZoomRange_Normal_Imp(cameraConfig))
local moveRange=mathHelper.convertArrayToVector(cameraConfig.cameraMove)
worldController:lockCameraInRange(moveRange,zoomRange)










if not mainViewsControl.checkLastMainType(MAIN_VIEW_TYPE.eWorld)then
baseFullScreenUI:openMain(true)
else
worldController:showPanel()
end


end



function worldExperienceController:isAnimationing()
return self.animation
end

function worldExperienceController:retreatExperience(jump)
if not jump then
if worldExperienceController:isAnimationing()or not worldController:getCameraControl()then
return
end
end

local world,block=worldExperienceModel:getScene()
local unitKey=worldExperienceModel:convertTaskTargetKey(world,block)
local taskKey=worldTaskModel:findTaskKey_ByTargetProgress(unitKey,eWorldTripProgress.Work)
if taskKey then
worldTaskController:returnMission(taskKey)
end
worldExperienceController:exitExperience()
end

function worldExperienceController:getFakeTaskAllDiscipleScr(world,block)
local list={}
if worldExperienceModel:checkCurrent(world,block)then
list=UIDiscipleModel:getAllPlotDisciple()or{}
end
return list
end
