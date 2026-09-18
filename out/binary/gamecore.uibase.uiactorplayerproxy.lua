def_class('UIActorPlayerProxy',UIActorPlayerLoader)



local M=CS.UIActorScene


local UIActorPlayer_RemoveAllEffect=M.UIActorPlayer_RemoveAllEffect
local UIActorPlayer_PlayEffect=M.UIActorPlayer_PlayEffect
local UIActorPlayer_Unload=M.UIActorPlayer_Unload
local UIActorPlayer_LoadAttachment=M.UIActorPlayer_LoadAttachment
local UIActorPlayer_LoadWeapon=M.UIActorPlayer_LoadWeapon
local UIActorPlayer_ChangeBody=M.UIActorPlayer_ChangeBody
local UIActorPlayer_LoadMount=M.UIActorPlayer_LoadMount
local UIActorPlayer_LoadFabao=M.UIActorPlayer_LoadFabao
local UIActorPlayer_LoadFromEntityModule=M.UIActorPlayer_LoadFromEntityModule
local UIActorPlayer_LoadCallback=M.UIActorPlayer_LoadCallback
local UIActorPlayer_UseSkill=M.UIActorPlayer_UseSkill
local UIActorPlayer_LoadTable=M.UIActorPlayer_LoadTable
local UIActorPlayer_LoadFBG=M.UIActorPlayer_LoadFBG
local UIActorPlayer_SetTableOffset=M.UIActorPlayer_SetTableOffset
local UIActorPlayer_SetFBGOffset=M.UIActorPlayer_SetFBGOffset
local UIActorPlayer_UnLoadTable=M.UIActorPlayer_UnLoadTable
local UIActorPlayer_UnLoadModel=M.UIActorPlayer_UnLoadModel
local UIActorPlayer_LoadParentNode=M.UIActorPlayer_LoadParentNode
local UIActorPlayer_RunAnimator=M.UIActorPlayer_RunAnimator
local UIActorPlayer_RunAnimatorWithName=M.UIActorPlayer_RunAnimatorWithName
local UIActorPlayer_SetAnimation=M.UIActorPlayer_SetAnimation
local UIActorPlayer_SetPose=M.UIActorPlayer_SetPose
local UIActorPlayer_SetIdleID=M.UIActorPlayer_SetIdleID


local SetTableRootActive=M.SetTableRootActive


local BodyParts=UIActorPlayerLoader.BodyParts

function UIActorPlayerProxy:__init(loaderID)
self:reset()

local onBodyLoad=function(...)self:onBodyLoad(...)end
local onAttachmentLoad=function(...)self:onAttachmentLoad(...)end
self.loaderID=loaderID

UIActorPlayer_LoadCallback(self.loaderID,onBodyLoad,onAttachmentLoad)
end

function UIActorPlayerProxy:onBodyLoadAction()
self:setActive(true)
local params=self.onBodyLoadActionParams
if not params then
return
end
self.onBodyLoadActionParams=nil

if params.useSkill then
UIActorPlayer_UseSkill(self.loaderID,params.useSkill[1],params.useSkill[2])
end
if params.runAnimator then
UIActorPlayer_RunAnimator(self.loaderID,params.runAnimator[1],params.runAnimator[2],params.runAnimator[3])
end
if params.runAnimatorWithName then
UIActorPlayer_RunAnimatorWithName(self.loaderID,param.runAnimatorWithName[1],param.runAnimatorWithName[2],param.runAnimatorWithName[3])
end
if params.mountID then
UIActorPlayer_LoadMount(self.loaderID,params.mountID)
end
end

function UIActorPlayerProxy:onBodyLoad(playerIndex,modelID)
self.model={id=modelID,state=true}
self:onBodyLoadAction()
end

function UIActorPlayerProxy:onAttachmentLoad(playerIndex,partID,attachmentID)
self.attachment[partID]={id=attachmentID,state=true}
end

function UIActorPlayerProxy:reset()
self:resetTable()
self:resetModel()
end

function UIActorPlayerProxy:resetTable()
self.tableNode={tablegroupID=0,tableID=0,fbgID=0}
end

function UIActorPlayerProxy:resetModel()
self.modelDirtyFlag=false
self.model={id=0}
self.attachment={}
self.parentNode={id=0}
for i=0,BodyParts.MAX,1 do
self.attachment[i]={id=0}
end
end

function UIActorPlayerProxy:removeAttachment(partID)
self:loadAttachment(partID,0)
end

function UIActorPlayerProxy:loadAttachment(partID,attachmentID)
attachmentID=attachmentID or 0
local l=self.attachment[partID]
if l and l.id==attachmentID then return end
self.attachment[partID]={id=attachmentID,state=nil}
self.modelDirtyFlag=true

UIActorPlayer_LoadAttachment(self.loaderID,partID,attachmentID)
end

function UIActorPlayerProxy:loadWing(attachmentID)
self:loadAttachment(BodyParts.HP_WING,attachmentID)
end

function UIActorPlayerProxy:loadWeapon(attachmentID)
attachmentID=attachmentID or 11001
local partID=BodyParts.HP_LH
local l=self.attachment[partID]
if l and l.id==attachmentID then return end
self.attachment[partID]={id=attachmentID,state=nil}
self.modelDirtyFlag=true


UIActorPlayer_LoadWeapon(self.loaderID,attachmentID)
end

function UIActorPlayerProxy:loadMount(mountID)
if self.model.state then
UIActorPlayer_LoadMount(self.loaderID,mountID)
return
end
if not self.onBodyLoadActionParams then
self.onBodyLoadActionParams={}
end
self.onBodyLoadActionParams.mountID=mountID
end

function UIActorPlayerProxy:loadFaBao(faBaoID)
UIActorPlayer_LoadFabao(self.loaderID,faBaoID)
end

function UIActorPlayerProxy:LoadLinZhu(linZhuID)
local moduleID=11
local args={linZhuID,0,2,-1}
self:loadFromEntityModule(moduleID,args)
end

function UIActorPlayerProxy:loadFromEntityModule(moduleID,args)
UIActorPlayer_LoadFromEntityModule(self.loaderID,moduleID,args)
end

function UIActorPlayerProxy:changeBody(modelID)
modelID=modelID or 0
if self.model.id==modelID then
return true
end
self.model={id=modelID,state=nil}
self:setActive(false)
self.modelDirtyFlag=true
UIActorPlayer_ChangeBody(self.loaderID,modelID)
return false
end

function UIActorPlayerProxy:playEffect(effects)
local loader=self.loaderID
UIActorPlayer_RemoveAllEffect(loader)
if effects then
for _,eff in ipairs(effects)do
UIActorPlayer_PlayEffect(loader,eff[1],eff[2],eff[3])
end
end
end

function UIActorPlayerProxy:useSkill(animationID,skillID)
if skillID==0 then return end
if self.model.state then
UIActorPlayer_UseSkill(self.loaderID,animationID,skillID)
return
end
if not self.onBodyLoadActionParams then
self.onBodyLoadActionParams={}
end
self.onBodyLoadActionParams.useSkill={animationID,skillID}
end

function UIActorPlayerProxy:loadTable(isshowstage,systemIndex)
isshowstage=isshowstage or false
SetTableRootActive(isshowstage)
local tableOffsetCfg={0,0,0,0,0,0,0}
local fbgOffsetCfg={0,0,0,0,0,0,0}
local v3_tb=Vector3(0,0,0)
local rx_tb=0
local ry_tb=0
local rz_tb=0
local v3_bg=Vector3(0,0,0)
local rx_bg=0
local ry_bg=0
local rz_bg=0

local InfoTableGroupID=RoleFashionData:GetOnFashion(GameConfigM9.ItemType.itFashion_Background)or 0
local JobVocation=playerControl.player~=nil and playerControl.player:get_vocation()or 1

if InfoTableGroupID<=0 or isshowstage==false then SetTableRootActive(false)return end

if self.tableNode.tablegroupID==InfoTableGroupID then
tableOffsetCfg=UISceneActor:GetActorConfigByUISystem(self.tableNode.tableID,systemIndex or 0)
v3_tb=Vector3(tableOffsetCfg[1]or 0,tableOffsetCfg[2]or 0,tableOffsetCfg[3]or 0)
rx_tb=tableOffsetCfg[5]or 0
ry_tb=tableOffsetCfg[6]or 0
rz_tb=tableOffsetCfg[7]or 0

fbgOffsetCfg=UISceneActor:GetActorConfigByUISystem(self.tableNode.fbgID,systemIndex or 0)
v3_bg=Vector3(fbgOffsetCfg[1]or 0,fbgOffsetCfg[2]or 0,fbgOffsetCfg[3]or 0)
rx_bg=fbgOffsetCfg[5]or 0
ry_bg=fbgOffsetCfg[6]or 0
rz_bg=fbgOffsetCfg[7]or 0

UIActorPlayer_SetTableOffset(self.loaderID,v3_tb,rx_tb,ry_tb,rz_tb)
UIActorPlayer_SetFBGOffset(self.loaderID,v3_bg,rx_bg,ry_bg,rz_bg)
return
end

local FashionID=0
local tableID=0
local fbgID=0
local tableBundleName="stage/m9stage/table/m9_map305_c_yuanpan_01.ab"
local fbgBundleName="stage/m9stage/table/m9_map305_c_yuanpan_01.ab"
FashionID=RoleAttributeData.GetAppearanceModelId(InfoTableGroupID,JobVocation)
local cfg=cfg_backgroundconfig_get(FashionID)
if cfg~=nil and next(cfg)then
tableID=cfg.tableID or 2000
fbgID=cfg.backgroundID or 2000
tableBundleName=cfg.tableAB or tableBundleName
fbgBundleName=cfg.backgroundAB or fbgBundleName
end

tableOffsetCfg=UISceneActor:GetActorConfigByUISystem(tableID,systemIndex or 0)
v3_tb=Vector3(tableOffsetCfg[1]or 0,tableOffsetCfg[2]or 0,tableOffsetCfg[3]or 0)
rx_tb=tableOffsetCfg[5]or 0
ry_tb=tableOffsetCfg[6]or 0
rz_tb=tableOffsetCfg[7]or 0

fbgOffsetCfg=UISceneActor:GetActorConfigByUISystem(fbgID,systemIndex or 0)
v3_bg=Vector3(fbgOffsetCfg[1]or 0,fbgOffsetCfg[2]or 0,fbgOffsetCfg[3]or 0)
rx_bg=fbgOffsetCfg[5]or 0
ry_bg=fbgOffsetCfg[6]or 0
rz_bg=fbgOffsetCfg[7]or 0

self.tableNode={tablegroupID=InfoTableGroupID,tableID=tableID,fbgID=fbgID}
UIActorPlayer_LoadTable(self.loaderID,tableBundleName)
UIActorPlayer_LoadFBG(self.loaderID,fbgBundleName)
UIActorPlayer_SetTableOffset(self.loaderID,v3_tb,rx_tb,ry_tb,rz_tb)
UIActorPlayer_SetFBGOffset(self.loaderID,v3_bg,rx_bg,ry_bg,rz_bg)
end

function UIActorPlayerProxy:setTableOffset(v3,rx,ry,rz)
UIActorPlayer_SetTableOffset(self.loaderID,v3,rx,ry,rz)
end

function UIActorPlayerProxy:setFBGOffset(v3,rx,ry,rz)
UIActorPlayer_SetFBGOffset(self.loaderID,v3,rx,ry,rz)
end


function UIActorPlayerProxy:loadParentNode(parentID,parentHP)
if self.parentNode.id==parentID then
return
end
self.modelDirtyFlag=true
self.parentNode={id=parentID}
UIActorPlayer_LoadParentNode(self.loaderID,parentID,parentHP)
end

function UIActorPlayerProxy:runAnimator(animationID,posID,updateDelta)
updateDelta=updateDelta or 0
if self.model.state then
UIActorPlayer_RunAnimator(self.loaderID,animationID,posID,updateDelta)
return
end
if not self.onBodyLoadActionParams then
self.onBodyLoadActionParams={}
end
self.onBodyLoadActionParams.runAnimator={animationID,posID,updateDelta}
end


function UIActorPlayerProxy:runAnimatorWithName(state,layer,reset)
if self.model.state then
UIActorPlayer_RunAnimatorWithName(self.loaderID,state,layer,reset)
return
end

if not self.onBodyLoadActionParams then
self.onBodyLoadActionParams={}
end
self.onBodyLoadActionParams.runAnimatorWithName={state,layer,reset}
end

function UIActorPlayerProxy:SetAnimation(animationID)
UIActorPlayer_SetAnimation(self.loaderID,animationID)
end

function UIActorPlayerProxy:SetPose(posID)
UIActorPlayer_SetPose(self.loaderID,posID)
end

function UIActorPlayerProxy:SetIdleID(idleID)
UIActorPlayer_SetIdleID(self.loaderID,idleID)
end

function UIActorPlayerProxy:build()
error('not supported')
end

function UIActorPlayerProxy:change()
error('not supported')
end

function UIActorPlayerProxy:unloadModel()
if not self.modelDirtyFlag then return end
self:resetModel()
UIActorPlayer_UnLoadModel(self.loaderID)
end

function UIActorPlayerProxy:unloadTable()
self:resetTable()
UIActorPlayer_UnLoadTable(self.loaderID)
end

function UIActorPlayerProxy:unload()
self:unloadModel()
self:unloadTable()
end
