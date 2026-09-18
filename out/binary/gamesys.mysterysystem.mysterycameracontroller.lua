







local _MODULENAME="mysteryCameraController"
gameState.addListener(def_table(_MODULENAME))
mysteryCameraController.name=_MODULENAME

local _HexMapManager=CS.HexagonMapManagerInterface

mysteryCameraController.data={}

mysteryCameraController.View=5

local curCameraSize
local minCameraSize=6.5
local maxCameraSize=10


function mysteryCameraController:onEnterState()

self.data={}
self.data.cameraMoveBorder={x=0,y=0,z=0,w=0}
self.data.mapBorder={x=0,y=0,z=0,w=0}
self.mapSize={x=0,y=0,z=0}
notifySystem:listenNotify(notifyConfig.on_mystery_player_move_start,self.on_mystery_player_move_start)
notifySystem:listenNotify(notifyConfig.on_mystery_created,self.on_mystery_created)
self.screenEffectObj=cameraScreenEffect(_HexMapManager.GetMainCameratransform())


end


function mysteryCameraController:onLeaveState()


self.data={}
end

function mysteryCameraController:setCameraBorder(left,bottom,right,top)
self.data.cameraMoveBorder={x=left,y=bottom,z=right,w=top}
end
function mysteryCameraController:setMapBorder(left,bottom,right,top,cameraPosX,cameraPosY,angle)
self.data.mapBorder={x=left,y=bottom,z=right,w=top}
self.mapSize={x=cameraPosX,y=cameraPosY,z=angle}
end

function mysteryCameraController:checkCameraPosition(pos)
local mapBorder=self.data.mapBorder
local moveCameraBorder=self.data.cameraMoveBorder
local mapSize=self.mapSize
if(mapBorder.w-mapBorder.y==0 or mapBorder.z-mapBorder.x==0)then
return false,pos;
end
local isBorder=false;
local angle=Mathf.PI/180*mapSize.z;
local offset=(angle==0 or mapSize.z==0)and 0 or(pos.y-self.mapSize.y)/Mathf.Tan(angle);
local left=mapBorder.x-offset;
if(pos.x<left-moveCameraBorder.x+mapSize.x)then
pos.x=left-moveCameraBorder.x+mapSize.x
isBorder=true
end
local right=mapBorder.z-offset
if(pos.x>right+moveCameraBorder.z+mapSize.x)then
pos.x=right+moveCameraBorder.z+mapSize.x
isBorder=true
end
if(pos.y>mapBorder.w+moveCameraBorder.w+mapSize.y)then
pos.y=mapBorder.w+moveCameraBorder.w+mapSize.y
isBorder=true
end
if(pos.y<mapBorder.y-moveCameraBorder.y+mapSize.y)then
pos.y=mapBorder.y-moveCameraBorder.y+mapSize.y
isBorder=true
end

pos.z=3
return isBorder,pos
end

function mysteryCameraController.on_mystery_created()
mysteryCameraController:findViewEntity()
end

function mysteryCameraController.on_mystery_player_move_start(pos)
mysteryCameraController:findViewEntity(pos)
end

function mysteryCameraController:findViewEntity(pos)
local roomId=mysteryRoomModel:get_cur_roomID()


local playerPos=pos or mysteryPlayerModel:get_player_pos()

if not self.data.viewEntity then
self.data.viewEntity={}
end
local entityDict={}

for i=0,self.View do

local posList=mysteryPosHelper.get_round_pos_list(playerPos,i)
local entityList=mysteryEntityController.invokeAllModelsFunc("get_all_entity_list_by_posList",posList,roomId)

if next(entityList)then
for entityType,v in pairs(entityList)do
for i,v2 in ipairs(v)do
entityDict[v2.guid]={i,v2}
if not self.data.viewEntity[v2.guid]then

notifySystem:postNotify(notifyConfig.on_mystery_entity_enter_view,i,v2)
else

notifySystem:postNotify(notifyConfig.on_mystery_entity_view_change,i,v2)
end
end
end
end
end


if next(self.data.viewEntity)then
for guid,v in pairs(self.data.viewEntity)do
if not entityDict[guid]then

notifySystem:postNotify(notifyConfig.on_mystery_entity_leave_view,v[1],v[2])
end
end
end
self.data.viewEntity=entityDict
end



function mysteryCameraController.GetCamaraPosition()
local camera=_HexMapManager.GetMainCameratransform()
if camera then
return camera.position
end
end

function mysteryCameraController.GetCamara()
local camera=_HexMapManager.GetMainCameratransform()
return camera
end

function mysteryCameraController:getScreenEffect()
return self.screenEffectObj
end

function mysteryCameraController:initCameraEffect(mjCfg)
local effect=mjCfg.screenEffect
if effect then
local func=self.screenEffectObj.setEffectFunc[effect[1]]
if func then
func(self.screenEffectObj,effect[2])
end
else
mysteryCameraController:disableScreenEffect()
end
end

function mysteryCameraController:disableScreenEffect()
self.screenEffectObj:disableAllEffect()
end


function mysteryCameraController.setCameraSize(size)
local sizeRange=cfgHelper.get2(cfg_secretscenebaseconfig_get,1,"cameraSizeRange")
if size>=sizeRange[1]and size<sizeRange[2]then
curCameraSize=size
_HexMapManager.SetCameraSize(size)
end
end

function mysteryCameraController.getCameraSize()
return curCameraSize or 6.5
end

function mysteryCameraController:setCamaraPosition(pos)
local camera=_HexMapManager.GetMainCameratransform()
if camera then
local isBorder,checkPos=mysteryCameraController:checkCameraPosition(Vector3.New(pos.x,pos.y,0))
camera.position=checkPos
end
end

function mysteryCameraController:setCamaraPositionMove(pos,duration,ease,delay,action,mustExt)
duration=duration or 1
delay=delay or 0
pos.z=3
local camera=_HexMapManager.GetMainCameratransform()
if camera then
if self.cameraTween then
if not self.cameraTween:IsComplete()then
self.cameraTween:Complete()

end
end
local cb=function()

mysteryCameraController.isCameraMove=false
if action then action()end
self.cameraTween=nil
end
if pos==camera.position then
cb()
else
self.cameraTween=Lua.DOTweenProxyExtensions.DOMove(camera,pos,duration)
if mustExt then

mysteryCameraController.isCameraMove=true
end
ease=ease or _Ease.InOutSine
self.cameraTween:SetEase(ease)
if delay>0 then
self.cameraTween:SetDelay(delay)
end
timeEventController.delayDo(duration+delay,function()
mysteryCameraController.isCameraMove=false
cb()
end)

end

end
end

function mysteryCameraController:setCamaraPositionPath(path,duration,pathType,ease,delay,action)
local camera=_HexMapManager.GetMainCameratransform()
if camera then
if self.cameraTween then
if not self.cameraTween:IsComplete()then
self.cameraTween:Complete()

end
end
for i,v in ipairs(path)do
v.z=3
end
self.cameraTween=Lua.DOTweenProxyExtensions.DoPath(camera,path,duration,pathType or DG.Tweening.PathType.CubicBezier)
ease=ease or _Ease.Linear
self.cameraTween:SetEase(ease)
delay=delay or 0
if delay then
self.cameraTween:SetDelay(delay)
end
mysteryCameraController.isCameraMove=true
timeEventController.delayDo(duration+delay,function()
mysteryCameraController.isCameraMove=false
if action then action()end
self.cameraTween=nil
end)






end
end

function mysteryCameraController:setCamaraFocusEntity(entityType,guid,action,moveSpeed,ease,delay)
local camera=_HexMapManager.GetMainCameratransform()
if camera then
if self.cameraTween then
if not self.cameraTween:IsComplete()then
self.cameraTween:Complete()

end
end
local pos=mysteryEntityController.invokeFuncByMysteryEntityType(entityType,"get_world_position",guid)
if pos then
pos.z=3
local distance=Vector3.Distance(pos,camera.position)
local duration=distance/moveSpeed
self.cameraTween=Lua.DOTweenProxyExtensions.DOMove(camera,pos,distance/moveSpeed)
ease=ease or _Ease.InOutSine
delay=delay or 0
self.cameraTween:SetEase(ease)
if delay>0 then
self.cameraTween:SetDelay(delay)
end
mysteryCameraController.isCameraMove=true
timeEventController.delayDo(duration+delay,function()
mysteryCameraController.isCameraMove=false
if action then action()end
self.cameraTween=nil
end)





end
end
end

function mysteryCameraController:getCameraTween()
return self.cameraTween or mysteryTriggerManager.getCameraMoveFlag()
end

function mysteryCameraController:stopCameraTween()
mysteryCameraController.isCameraMove=false
local camera=_HexMapManager.GetMainCameratransform()
if camera then
Lua.DOTweenProxyExtensions.DOKill(camera)
end
end


function mysteryCameraController.getBgCamera()
return _HexMapManager.GetBgCameratransform()
end

function mysteryCameraController:setBgCameraShake(strength,duration,vibrato,randomness,snapping,fadeOut)
local bgCamera=self.getBgCamera()
if bgCamera then
Lua.DOTweenProxyExtensions.DOShakePosition(bgCamera,duration,strength,vibrato,randomness,snapping,fadeOut)
end
end

function mysteryCameraController:setBgCameraPunch(punch,duration,vibrato,elasticity,snapping)
local bgCamera=self.getBgCamera()
if bgCamera then
Lua.DOTweenProxyExtensions.DOPunchPosition(bgCamera,punch,duration,vibrato,elasticity,snapping)
end
end

function mysteryCameraController:setBgCameraRotate(x,y,z)
local bgCamera=self.getBgCamera()
if bgCamera then
if not self.data.bgCameraRotation then
self.data.bgCameraRotation={14.5,0,0}
end
self.data.bgCameraRotation={self.data.bgCameraRotation[1]+x,self.data.bgCameraRotation[2]+y,self.data.bgCameraRotation[3]+z}

local angleY=bgCamera.eulerAngles.y
if angleY>5 and angleY<180 then
self.data.bgCameraRotation[2]=5
elseif angleY>180 and angleY<355 then
self.data.bgCameraRotation[2]=-5
end
bgCamera:SetPositionAndRotation(bgCamera.position,Quaternion.Euler(self.data.bgCameraRotation[1],self.data.bgCameraRotation[2],self.data.bgCameraRotation[3]))
end
end

