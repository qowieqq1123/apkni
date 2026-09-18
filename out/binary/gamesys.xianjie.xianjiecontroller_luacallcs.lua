









function xianjieController:getCameraPosition()
local manager=self.manager
if manager==nil then
return nil
end
return manager:GetCameraPosition()
end

function xianjieController:checkCameraMoving()
return self.isCameraMoving==true
end

function xianjieController:setCameraMoving(flag)
self.isCameraMoving=flag
end


function xianjieController:lookAtPosition(position,height,duration,callback,ease,lockRange)
local manager=self.manager
if manager==nil then
return nil
end



xianjieController:setCameraMoving(true)
xianjieModel:checkSceneState_moveScene()


height=xianjieController:getCameraPosition().y
local range=xianjieController:getCameraZoomRange()
if range then
height=Mathf.Clamp(height,range[1],range[2])
end

local cb=function()
xianjieController:setCameraMoving(nil)
if callback then
callback()
end
notifySystem:postNotify(notifyConfig.onXianJieCameraLookAt)
end
if lockRange==nil then lockRange=true end
manager:CameraLookAtPosition(position,height,duration or 0.2,cb,ease or DG.Tweening.Ease.InQuint,lockRange)
end

function xianjieController:lookAtPositionLow(position,sceneidx,duration,callback,ease,height)
sceneidx=sceneidx or xianjieModel:getSceneIndex()
local sceneType=xianjieModel:sceneIndex2SceneType(sceneidx)
local zoomRange=xianjieController:getCameraZoomRange2(sceneType)
xianjieController:lookAtPositionChangeHeight(position,height or zoomRange[1],duration,callback,ease)
end

function xianjieController:lookAtPositionHigh(position,sceneidx,duration,callback,ease,height)
sceneidx=sceneidx or xianjieModel:getSceneIndex()
local sceneType=xianjieModel:sceneIndex2SceneType(sceneidx)
local zoomRange=xianjieController:getCameraZoomRange2(sceneType)
xianjieController:lookAtPositionChangeHeight(position,height or zoomRange[2],duration,callback,ease)
end

function xianjieController:lookAtPositionChangeHeight(position,height,duration,callback,ease,lockRange)
local manager=self.manager
if manager==nil then
return nil
end
xianjieController:setCameraMoving(true)
xianjieModel:checkSceneState_moveScene()
if height==nil then

height=xianjieController:getCameraPosition().y
end
local range=xianjieController:getCameraZoomRange()
if range then
height=Mathf.Clamp(height,range[1],range[2])
end
local cb=function()
xianjieController:setCameraMoving(nil)
if callback then
callback()
end
notifySystem:postNotify(notifyConfig.onXianJieCameraLookAt)
end
if lockRange==nil then lockRange=true end
manager:CameraLookAtPosition(position,height,duration or 0.2,cb,ease or DG.Tweening.Ease.InQuint,lockRange)
end


function xianjieController:getCameraTransform()
local manager=self.manager
if manager==nil then
return nil
end
return manager:GetCameraTransform()
end

function xianjieController:openCinema(show)
local manager=self.manager
if manager==nil then
return nil
end
return manager:OpenCinema(show)
end

function xianjieController:getCameraLookAtPlanePos()
local manager=self.manager
if manager==nil then
return nil
end
local pos=manager:GetCameraLookAtPlanePos()
local mapResPos=xianjieController:get_mapResPos()
if pos.y==mapResPos[2]then
return pos
end
return nil
end


function xianjieController:getScreenPoint(worldPos)
local manager=self.manager
if manager==nil then
return nil
end
return manager:GetScreenPoint(worldPos)
end


function xianjieController:GetPosHeight(gridX,gridZ)
local manager=self.manager
if manager==nil then
return nil
end
return manager:GetPosHeight(gridX,gridZ)
end

function xianjieController:initFogLockList(list)
local manager=self.manager
if manager==nil then
return nil
end
manager:InitFogLockList(list)
end

function xianjieController:setFogState(indexs,state,time,onFinish)

local manager=self.manager
if manager==nil then
return nil
end
manager:SetFogState(indexs,state,time,onFinish)
end

function xianjieController:selectBlocks(indexs)
local manager=self.manager
if manager==nil then
return nil
end
local color,speed=xianjieModel:getSelectCloudCfg()
manager:SelectBlocks(indexs,speed,color)
end

function xianjieController:checkPosInAOI(pos)
local manager=self.manager
if manager==nil then
return nil
end
return manager:CheckPosInAOI(pos)
end

function xianjieController:checkLineInAOI(pos1,pos2)
local manager=self.manager
if manager==nil then
return nil
end
return manager:CheckLineInAOI(pos1,pos2)
end

function xianjieController:checkRectInAOI(pos,size)
local manager=self.manager
if manager==nil then
return nil
end
return manager:CheckRectInAOI(pos,size)
end

function xianjieController:setFollowTarget(trans,followOutSizeClose)
local manager=self.manager
if manager==nil then
return nil
end
if followOutSizeClose==nil then followOutSizeClose=true end
manager:SetFollowTarget(trans,followOutSizeClose)
xianjieModel:setCameraFollow(true)
end

function xianjieController:removeFollowTarget()
local manager=self.manager
if manager==nil then
return nil
end
manager:RemoveFollowTarget()
xianjieModel:setCameraFollow(nil)
end

function xianjieController:setLogicShow(logicShow)
local manager=self.manager
if manager==nil then
return nil
end
manager:SetLogicShow(logicShow)
end

function xianjieController:activeScene(flag)
local manager=self.manager
if manager==nil then
return nil
end
manager:ActiveScene(flag)
end

function xianjieController:setLineSortingGroup(sortingLayer,sortingOrder)
local lineManager=self.lineManager
if lineManager==nil then
return nil
end
lineManager:SetSortingGroup(sortingLayer,sortingOrder)
end

function xianjieController:removeLineSortingGroup()
local lineManager=self.lineManager
if lineManager==nil then
return nil
end
lineManager:RemoveSortingGroup()
end

function xianjieController:drawLines(prefabType,posList,color,speed,layer,boxParams)
local lineManager=self.lineManager
if lineManager==nil then
return nil
end
color=color or Color.white

local linekeys=lineManager:DrawLines(prefabType,posList,color,speed,layer,boxParams)
return linekeys
end

function xianjieController:drawLines2(prefabType,linePosList,color,speed,layer,boxParams)
local lineManager=self.lineManager
if lineManager==nil then
return nil
end
color=color or Color.white

local linekeys=lineManager:DrawLines2(prefabType,linePosList,color,speed,layer,boxParams)
return linekeys
end

function xianjieController:drawLine(prefabType,sPos,ePos,color,speed,layer,boxParams)
local lineManager=self.lineManager
if lineManager==nil then
return nil
end
color=color or Color.white
local linekey=lineManager:DrawLine(prefabType,sPos,ePos,color,speed,layer,boxParams)
return linekey
end

function xianjieController:removeLine(linekey)
local lineManager=self.lineManager
if lineManager==nil then
return nil
end
lineManager:RemoveLine(linekey)
end

function xianjieController:removeLines(linekeys)
local lineManager=self.lineManager
if lineManager==nil then
return nil
end
lineManager:RemoveLines(linekeys)
end

function xianjieController:setLinesSpeed(linekeys,speed)
local lineManager=self.lineManager
if lineManager==nil then
return nil
end
lineManager:SetLinesSpeed(linekeys,speed)
end

function xianjieController:setLineSpeed(speed)
local lineManager=self.lineManager
if lineManager==nil then
return nil
end
lineManager:SetLineSpeed(speed)
end

function xianjieController:activeLineRoot(isActive)
local lineManager=self.lineManager
if lineManager==nil then
return nil
end
lineManager:ActiveLineRoot(isActive)
end
