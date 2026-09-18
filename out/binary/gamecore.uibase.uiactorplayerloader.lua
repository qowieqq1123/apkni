def_class('UIActorPlayerLoader')




local UI3D_OVERLAYER=29
local LAYER_3DGUI=22
local LoadType=
{
tableNode=0,
parentNode=1,
model=2,
effect=3,
max=4,
}

local BodyParts=
{
BODY=0,
HP_FACE=1,
HP_HAIR=2,
HP_HAT=3,
HP_LH=4,
HP_RH=5,
HP_WING=6,
COMMON=7,
MOUNT=8,
HP_CLOAK=9,
HP_Back=10,
HP_CAMERA_ROOT=11,
RESERV2=12,
RESERV3=13,
RESERV4=14,
RESERV5=15,
RESERV6=16,
RESERV7=17,
RESERV8=18,
RESERV9=19,
MAX=20
}

UIActorPlayerLoader.LoadType=LoadType
UIActorPlayerLoader.BodyParts=BodyParts

local M=CS.UIActorScene


local UIActorPlayer_SetActive=M.UIActorPlayer_SetActive
local UIActorPlayer_Unload=M.UIActorPlayer_Unload
local UIActorPlayer_RequestTableNode=M.UIActorPlayer_RequestTableNode
local UIActorPlayer_RequestParentNode=M.UIActorPlayer_RequestParentNode
local UIActorPlayer_RequestAttachment=M.UIActorPlayer_RequestAttachment
local UIActorPlayer_RequestEffect=M.UIActorPlayer_RequestEffect
local UIActorPlayer_SetLayer=M.UIActorPlayer_SetLayer
local UIActorPlayer_RequestBody=M.UIActorPlayer_RequestBody
local UIActorPlayer_LoadRequests=M.UIActorPlayer_LoadRequests
local UIActorPlayer_RemoveAllEffect=M.UIActorPlayer_RemoveAllEffect
local UIActorPlayer_SnapUIActorPlayerToScreenPos=M.UIActorPlayer_SnapUIActorPlayerToScreenPos
local UIActorPlayer_SetRotate=M.UIActorPlayer_SetRotate
local UIActorPlayer_SetRotateSpeed=M.UIActorPlayer_SetRotateSpeed
local UIActorPlayer_SetActorRootActive=M.UIActorPlayer_SetActorRootActive
local UIActorPlayer_LoadParentNode=M.UIActorPlayer_LoadParentNode
local UIActorPlayer_RunAnimator=M.UIActorPlayer_RunAnimator

function UIActorPlayerLoader:__init(loaderID)
self.loaderID=loaderID
end

function UIActorPlayerLoader:onLoadFinish()
self:setActive(true)





end

function UIActorPlayerLoader:onLoadCallback(what,id,subID)
if what==LoadType.max then
if self.waitAllLoaded then
self:onLoadFinish()
end
elseif what==LoadType.model and id==BodyParts.BODY then
if not self.waitAllLoaded then
self:onLoadFinish()
end
end
self.finishAction(what,id,subID)
end

function UIActorPlayerLoader:unload(...)

UIActorPlayer_Unload(self.loaderID)
end

























function UIActorPlayerLoader:build(input,finishAction)
self:unload()

finishAction=finishAction or function(what,id,subID)
logErr(what,id,subID)
end

local loader=self.loaderID;
local invokeLoad=nil

local bodyChanged=false
local tableNodeChange=false
local cameraChange=false

self.finishAction=finishAction
self.waitAllLoaded=input.waitAllLoaded
local layer=input.layer or LAYER_3DGUI
self.layer=layer
self.buff=input.buff

if not self.onLoadAction then
self.onLoadAction=function(...)self:onLoadCallback(...)end
end

if input.tableNode then
UIActorPlayer_RequestTableNode(loader,input.tableNode[1])
invokeLoad=true
tableNodeChange=true
end


if input.parentNode then
UIActorPlayer_RequestParentNode(loader,input.parentNode[1],input.parentNode[2])
invokeLoad=true
end


if input.modelID then
UIActorPlayer_RequestBody(loader,input.modelID)
invokeLoad=true
bodyChanged=true
end


if input.attachment then
for k,v in pairs(input.attachment)do
UIActorPlayer_RequestAttachment(loader,k,v)
end
end


if input.effect then
for _,eff in ipairs(input.effect)do
UIActorPlayer_RequestEffect(loader,eff[1],eff[2],eff[3])
end
end

if bodyChanged then
self:setActive(false)
end

self:setLayer(self.layer)
UIActorPlayer_LoadRequests(loader,self.onLoadAction)
end

function UIActorPlayerLoader:setActive(flag)

UIActorPlayer_SetActive(self.loaderID,flag)
end

function UIActorPlayerLoader:setLayer(layer)

UIActorPlayer_SetLayer(self.loaderID,layer)
end

function UIActorPlayerLoader:snapToScreenPos(anchorIndex,distance)
anchorIndex=anchorIndex or 1
distance=distance or 3.4
UIActorPlayer_SnapUIActorPlayerToScreenPos(self.loaderID,anchorIndex,distance)
end

function UIActorPlayerLoader:setRotate(rx,ry,rz)

UIActorPlayer_SetRotate(self.loaderID,rx,ry,rz)
end

function UIActorPlayerLoader:setRotateSpeed(speed)
UIActorPlayer_SetRotateSpeed(self.loaderID,speed)
end

function UIActorPlayerLoader:setActorRootActive(flag)
UIActorPlayer_SetActorRootActive(self.loaderID,flag)
end

function UIActorPlayerLoader.test(...)
local playerLoader=UISceneActor:getPlayer(1,true)

local reqTable={
modelID=29150,
attachment={
[UIActorPlayerLoader.BodyParts.HP_RH]=11000,
[UIActorPlayerLoader.BodyParts.HP_WING]=29504,
[UIActorPlayerLoader.BodyParts.HP_CAMERA_ROOT]=29801,
},
effect={
{"",28002,Vector3(0,0,0)},
},
layer=UI3D_OVERLAYER,
buff={9003}
}
playerLoader:build(reqTable)











end
