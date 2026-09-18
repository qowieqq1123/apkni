













function worldController:point2Position(point)
local position=nil
local result,pos=CS.WorldUtilityHelper.RaycastPointToPosition(point,
bit.lshift(1,CS.SceneDefault.LAYER_NAV),position)
if result then
return pos
end

end




function worldController:calculateNavPath(startPoint,endPoint)
local corners=CS.WorldUtilityHelper.CalculateNav_MultiPoint({startPoint,endPoint},bit.lshift(1,CS.SceneDefault.LAYER_NAV))
if corners==nil then

end
local last=corners[corners.Length-1]
last=Vector2.New(last.x,last.z)
if last~=endPoint then

end
return corners
end




function worldController:calculateNavPathEx(startVector3,endVector3)
local corners=CS.WorldUtilityHelper.CalculateNav_MultiPosition({startVector3,endVector3})
if corners==nil then

end
local last=corners[corners.Length-1]
if last~=endVector3 then

end
return corners
end




function worldController:calculateNavPathXX(sPos,ePos)
local sVec3=worldPositionConfig:getPosition_CurrentWorld(sPos)
local eVec3=worldPositionConfig:getPosition_CurrentWorld(ePos)
if sVec3~=nil and eVec3~=nil then
return self:calculateNavPathEx(sVec3,eVec3)
else
local sVec2=mathHelper.convertArrayToVector(sPos)
local eVec2=mathHelper.convertArrayToVector(ePos)
return self:calculateNavPath(sVec2,eVec2)
end
end









function worldController:pushUnit(unitKey,pos,data,modelSettings,hudSetting,symbolSetting,click)
local unitData=CS.WorldObjectData.New(unitKey,pos,click==nil and true or click)
unitData:Setting(modelSettings,hudSetting,symbolSetting)
unitData:BindLuaData(data)
worldUnitModel:showUnit(unitKey,unitData)

end



function worldController:popUnit(unitKey)
self.manager:PopData(unitKey)
end




function worldController:getUnit(unitKey)
return self.manager:GetData(unitKey)
end




function worldController:haveUnit(unitKey)
return self.manager:ContainData(unitKey)
end




function worldController:changeUnitModel(unitKey,setting)
self.manager:ChangeModel(unitKey,setting)
end

function worldController:setModelShadow(unitKey,shadow)

if webGLHelper:isRunWebGL()then
return
end
self.manager:SetUnitShadow(unitKey,shadow)
end




function worldController:setUnitFlipX(unitKey,flipX)
self.manager:SetFlipX(unitKey,flipX)
end

function worldController:setRotation(unitKey,rotation)
self.manager:SetRotation(unitKey,rotation)
end




function worldController:setAnimation(unitKey,animation)
self.manager:SetAnimation(unitKey,animation)
end

function worldController:freezeAnimation(unitKey,animation,progress)
self.manager:FreezeAnimation(unitKey,animation,progress)
end




function worldController:lockCameraInRange(moveRange,zoomRange)
self.manager:LockCameraInRange(moveRange,zoomRange)
end

function worldController:lockTipsInRange(tipsRange)
self.manager:LockTipsInRange(tipsRange)
end

function worldController:lockDeflectionAngle(setting)
self.manager:LockDeflectionAngle(setting)
end

function worldController:resetDefaultPosition(position)
self.manager:ResetDefaultPosition(position)
end




function worldController:setCameraPosition(position,atOnce,callback,ease)
self.manager:SetCameraPosition(position,atOnce or false,callback,ease or DG.Tweening.Ease.InQuint)
end

function worldController:moveCameraPosition(position,duration,callback,ease)
self.manager:MoveCameraPosition(position,duration or 0,callback,ease or DG.Tweening.Ease.InQuint)
end



function worldController:lookAtUnit(unitKey,height,atOnce,callback,ease)
if height==nil then
height=self:getCameraPosition().y
local range=worldController:getCameraZoomRange()
if range then
height=Mathf.Clamp(height,range[1],range[2])
end
end
self.manager:CameraLookAtUnit(unitKey,height,atOnce or false,callback,ease or DG.Tweening.Ease.InQuint)
end

function worldController:lookAtUnit_Duration(unitKey,height,duration,callback,ease)
if height==nil then
height=self:getCameraPosition().y
local range=worldController:getCameraZoomRange()
if range then
height=Mathf.Clamp(height,range[1],range[2])
end
end
self.manager:CameraLookAtUnit_Duration(unitKey,height,duration or 0.2,callback,ease or DG.Tweening.Ease.InQuint)
end



function worldController:lookAtPoint(point,height,atOnce,callback)
if height==nil then
height=self:getCameraPosition().y
local range=worldController:getCameraZoomRange()
if range then
height=Mathf.Clamp(height,range[1],range[2])
end
end
local position=self:point2Position(point,height)
self:lookAtPosition(position,height,atOnce or false,callback)
end



function worldController:lookAtPosition(position,height,atOnce,callback,ease)
if self.manager==nil then return end
if height==nil then
height=self:getCameraPosition().y
local range=worldController:getCameraZoomRange()
if range then
height=Mathf.Clamp(height,range[1],range[2])
end
end
self.manager:CameraLookAtPosition(position,height,atOnce or false,callback,ease or DG.Tweening.Ease.InQuint)
end

function worldController:lookAtPosition_Duration(position,height,duration,callback,ease)
if height==nil then
height=self:getCameraPosition().y
local range=worldController:getCameraZoomRange()
if range then
height=Mathf.Clamp(height,range[1],range[2])
end
end
self.manager:CameraLookAtPosition_Duration(position,height,duration or 0.2,callback,ease or DG.Tweening.Ease.InQuint)
end



function worldController:getCameraPosition()
if not self.manager then
return
end
return self.manager:GetCameraPosition()
end

function worldController:getCameraRotation()
return self.manager:GetCameraRotation()
end

function worldController:moveCameraPath(points,duration,pathType,ease,callback)
return self.manager:CameraPathMove(points,duration,pathType,ease or DG.Tweening.Ease.Linear,callback)
end



function worldController:pushMove(move)

self.manager:PushMove(move)
end



function worldController:popMove(moveKey)

self.manager:PopMove(moveKey)
end




function worldController:getMove(moveKey)
return self.manager:GetMove(moveKey)
end




function worldController:containMove(moveKey)
return self.manager:ContainMove(moveKey)
end


function worldController:markCameraViewChange()
self.manager:OnCameraViewChange()
end



function worldController:setClouds(list)

self.manager:SetClouds(list)
end





function worldController:setSingleCloud(state,time,callback)

self.manager:SetCloud(state,time,callback)
end

function worldController:selectCloud(index)
local selected=worldBlockModel:getSelectFog()
local idx=index or-1
if idx~=selected then
if self:isInWorld()then
self.manager:SelectCloud(idx)
end

worldBlockModel:setSelectFog(idx)

local worldCfg=cfgHelper.get1(cfg_worldblockconfig_get,worldModel.world)
for block,blockCfg in pairs(worldCfg)do
if blockCfg.cloud==idx or blockCfg.cloud==selected then
local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.FOG,blockCfg.fog1})
worldHUDModel:UpdateHUDByKey(unitKey)
end


end
end
end






function worldController:changeModelColor(key,color,duration,callback)

self.manager:ChangeModelColor(key,color,duration,callback)

end




function worldController:playModelEffect(key,effect,offset,scale,handPoint,attach)

self.manager:PlayModelEffect(key,effect,offset or Vector3.zero,scale or Vector3.one,handPoint,attach==nil or attach==true)
end

function worldController:stopModelEffect(key,effect)
self.manager:StopModelEffect(key,effect)
end




function worldController:pushLine(key,positions)
self.manager:PushLine(key,positions)
end



function worldController:popLine(key)
self.manager:PopLine(key)
end

function worldController:lockCenterUnit(key)
self.manager:LockCameraLookAtUnit(key)
end

function worldController:unlockCenterUnit()
self.manager:UnlockCameraLookAtUnit()
end

function worldController:showObjectRoot(show)
if self.manager then
self.manager:ShowObjectRoot(show)
end
end

function worldController:showCamera(show)
if self.manager then
self.manager:SetCameraShow(show)
end
end

function worldController:showUnitModel(unitKey,show)

local unit=self:getUnit(unitKey)
if unit and unit.Model.HasObject then
unit.Model.Model.gameObject:SetActive(show)
end
end

function worldController:hideUnitEffect(unitKey,show)
local unit=self:getUnit(unitKey)
if unit and unit.Model.HasObject then
unit:HideModelAllEffect(show)
end
end

function worldController:getUnitModelEntity(unitKey)

local unit=self:getUnit(unitKey)
if unit then
return unit.Model:GetModelEntity()
end
end

function worldController:getUnitModelSetting(unitKey)
local unit=self:getUnit(unitKey)
if unit then
return unit.Model.Setting
end
end

function worldController:getUnitHUDSetting(unitKey)
local unit=self:getUnit(unitKey)
if unit then
return unit.HUD.Setting
end
end


function worldController:getUnitModelFlip(unitKey)
local unit=self:getUnit(unitKey)
if unit then
return unit.Model.FlipX
end
end


function worldController:getScreenPoint(pos)
return self.manager:GetScreenPoint(pos)
end

function worldController:SetLODThingVisible(lod,visible)

if lod>0 and lod<=self.manager.mapLODCount then
local things=self.manager.mapLODThings[lod]
things:SetActive(visible)
else

end
end

function worldController:GetCloudUIMask(index,locks)
return self.manager:GetCloudUIMask(index,locks)
end

function worldController:releaseCloudMask()
if api_Available_ReleaseCloudMaskRT()then
CS.GameInterface.ReleaseCloudMaskRT()
end
end

function worldController:getCameraCurveValue(height)
return self.manager:GetCameraCurveValue(height or self:getCameraPosition().y)
end

function worldController:getCameraCurveDelta(startHeight,endHeight)
return self.manager:GetCameraCurveDelta(startHeight,endHeight)
end

function worldController:getCameraCurveDelta2(delta,height)
local currentHeight=height or self:getCameraPosition().y
return self.manager:GetCameraCurveDelta(currentHeight,currentHeight+delta)
end

function worldController:getCameraPosition_WhenLookAtUnit(unitKey,height)
local pos=nil
local y=height or self:getCameraPosition().y
local check,position=self.manager:GetCameraPositionLookAtUnit(unitKey,y,pos)
return check and position or nil
end

function worldController:getCameraPosition_WhenLookAtPosition(position,height)
local y=height or self:getCameraPosition().y
return self.manager:GetCameraPoisitonLookAtPoisiton(position,y)
end

function worldController:setCurveWorld(work)
self.manager:SetCameraCurveWork(work)
end

function worldController:getCameraCurveAngle(height,force)
return self.manager:GetCameraCuvreAngle(height,force)
end

function worldController:setModelSlotIcon(unitKey,slotName,iconName)
return self.manager:SetModelSlotIcon(unitKey,slotName,iconName)
end

function worldController:setModelScale(unitKey,scale)
return self.manager:SetModelScale(unitKey,scale)
end

function worldController:findUnit(func)
return self.manager:FindData(func)
end

function worldController:clearUnitMount(unitKey)
return self.manager:ClearModelMount(unitKey)
end

function worldController:changeUnitMount(unitKey,id,slots,hp,scale,offset,callback)
return self.manager:ChangeModelMount(unitKey,id,slots,hp,scale,offset,callback)
end

function worldController:setUnitPosition(unitKey,position)
local unit=self:getUnit(unitKey)
if unit then
unit:SetPosition(position)
end
end

function worldController:navPathMoveUnit(unitKey,path,speed,animation,onStep,onComplete)

end

function worldController:singleNavMoveUnit(unitKey,dept,dest,speed,animation,onComplete)
local obj=worldController:getUnit(key)
local corners=worldController:calculateNavPathEx(dept or obj.Position,dest)
local animationInfo=Vector3Int(0,animation0,0)
local way=CS.WorldNavWay.New(corners,speed,animationInfo)
local ways={way}
local path=CS.WorldMovePath.New(ways,CS.WorldLoopType.Restart,1)
local move=CS.WorldSingelTeam.New(key,{path},obj)
move.onComplete=onComplete
worldController:pushMove(move)
end

function worldController:cameraDOShake(duration,strength,vibrato,callback)
local cameraTF=self:getCameraTransform()
if cameraTF then
local tweener=_DOTweenProxy.DOShakePosition(cameraTF,duration,strength,vibrato)
tweener:SetEase(_Ease.Linear)
tweener:OnComplete(callback)
end
end

function worldController:getAllUnit()
return self.manager:GetObjectDataList()
end

function worldController:setAllUnitActiveState(show,applyList)
applyList=applyList or{}

local allUnitList=self.manager:GetObjectDataList()

for index=1,allUnitList.Count do
local unit=allUnitList[index-1]
local unitType=unit.LuaData and unit.LuaData[1]
if unitType and type(unitType)=='number'and table.findValue(eWorldUnitTpye,unitType)and table.findValue(applyList,unitType)then
self:showUnitModel(unit.Key,show)
local hud=worldHUDModel:getHUD(unit.Key)
if hud then
hud:onVisible(show)
end
end
end
end


function worldController:setAllUnitAndEffectActiveState(show,applyList)
applyList=applyList or{}

local allUnitList=self.manager:GetObjectDataList()

for index=1,allUnitList.Count do
local unit=allUnitList[index-1]
local unitType=unit.LuaData and unit.LuaData[1]
if unitType and type(unitType)=='number'and table.findValue(eWorldUnitTpye,unitType)and table.findValue(applyList,unitType)then
self:showUnitModel(unit.Key,show)
self:hideUnitEffect(unit.Key,show)
local hud=worldHUDModel:getHUD(unit.Key)
if hud then
hud:onVisible(show)
end
end
end
end
