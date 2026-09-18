

def_class('entity',{})


function entity:__init(outEffectOpen)
self.autoRemove=true
self.visible=true
self.hudOffset=Vector3.zero
self.hudPosition=Vector3.zero
self.bodySize=Vector3.zero
self.scale=1
self.hitedPos={0.5,0.5}
self.m_flipX=false
self.fBTree=fBTBehaviorTree(self)
self.hud=entityHUDCtr:createEntityHud(self)
self.lookAtCamera=true
self.isEnableHud=true
self.isShowHUD=false
self.hasFace=false

if outEffectOpen==nil then outEffectOpen=false end
self.outEffectOpen=outEffectOpen
self:initOutEffect(nil)
end

function entity:_setEntObj(entObj)
self.entObj=entObj
self.entObj:SetLookAtCamera(self.lookAtCamera)
self.entObj:ShowShadow(true)
self.guid=self.entObj.GUID
end



function entity:initWithEntObj(entObj,autoRemove)
self:remove()
self.autoRemove=autoRemove
if entObj~=nil then
self:_setEntObj(entObj)
self:onShow()
end
end



function entity:changeBody(body,compoents,scale)
if self.entObj~=nil then
self.entObj:ChangeBody(body,compoents,false,scale)
self.bodySize=transformHelper.bodySize(body,scale)
self.bodyID=body
self.hasFace=spineHelper.enableChangeFace(body)
if self.hud~=nil then
self.hud:flushPosition()
end
end
end


function entity:initObj(body,componets,pos,scale,flip,callback)
self.m_flipX=flip
if self.m_flipX==nil then
self.m_flipX=false
end
local ent=fightManager.addEntity(body,componets,pos,self.m_flipX,eAnimationID.stand,scale,callback)
self.scale=scale
ent:SetShaderType(14)
ent:SetUpdateMode(SpineUpdateMode.FullUpdate)
self.bodyID=body
self.originBodyID=body
self.originComponets=componets
self.hasFace=spineHelper.enableChangeFace(body)
self:_setEntObj(ent)
self:onShow()
return self.guid
end

function entity:init3DObj(modelID,pos,rot,scale,callback)
self.lookAtCamera=false
self.scale=scale
self:_setEntObj(fightManager.add3DEntity(modelID,pos,rot,scale,callback))
self.hasFace=false
self.bodyID=-1
self:onShow()
return self.guid
end

function entity:show(isFade)
self:createHud()
if self.entObj==nil then
self.m_flipX=self.posInfo.left
if self.model.body~=nil then
self.bodySize=transformHelper.bodySize(self.model.body,self.model.scale)
self.scale=self.model.scale
self.hitedPos=cfgHelper.get2(cfg_dbbodyconfig_get,self.model.body,'hitedPos')or{0.5,0.5}

if isFade then

local ent=fightManager.addEntity(self.model.body,self.model.componets,self.posInfo.pos,self.m_flipX,eAnimationID.stand,self.model.scale)
ent:SetShaderType(14)
ent:SetUpdateMode(SpineUpdateMode.FullUpdate)
self:_setEntObj(ent)

ent:FadeToColor(Color.New(1,1,1,0),0,nil)
self:setPosition(self.posInfo.pos)

if self.assistantType~=fightAssistantType.eLingShou then
self.isFade=1
else
self:fadeToColor(Color.New(1,1,1,0),0,nil)
end
else
local ent=fightManager.addEntity(self.model.body,self.model.componets,self.posInfo.pos,self.m_flipX,eAnimationID.stand,self.model.scale)
ent:SetUpdateMode(SpineUpdateMode.FullUpdate)
ent:SetShaderType(14)
self:_setEntObj(ent)

if self.assistantType==fightAssistantType.eLingShou then
self:fadeToColor(Color.New(1,1,1,0),0,nil)
end
end

if self.assistantType==fightAssistantType.eLingShou then

self:setEnableRayHit(false)
end
end
end
self:onShow()
return self.guid
end


function entity:onShow()
self:rebuildAllOutEffect()
end

function entity:hide()
if self.entObj then
if self.bodyID~=-1 then
self.entObj:SetShaderType(0)
end
local callback=function()
self:shopExpressionTimer()
fightManager.removeEntity(self.entObj.GUID)
self.guid=-1
self.entObj=nil
end

if self.delayRemove and self.delayRemove>0 then
local hTimer=timer.new()
hTimer:start(self.delayRemove,callback,1)
else
callback()
end
end

if self.fabaoObjID then
if self.hud~=nil then
self.hud:stopText(self.fabaoObjID)
end
self.fabaoObjID=nil
end

self:stopBehavior()
self:onHide()
end

function entity:onHide()
self:removeAllOutEffect()

if self.hud~=nil then
self.hud:remove()
self.hud=nil
end
end


function entity:remove()

self:hide()


if self.hud~=nil then
self.hud:remove()
self.hud=nil
end

self:clearAllOutEffect()
end

function entity:isLeft()
return false
end

function entity:removeSelf()
if self.moveComplete then
self.moveComplete()
self.moveComplete=nil
end
fightManager.removeEntity(self.guid)
self.entObj=nil
end

function entity:flipX(flip)
self.m_flipX=flip
if self.m_flipX==nil then
self.m_flipX=false
end
if self.entObj~=nil then
self.entObj:SetFlipX(self.m_flipX)
end
end

function entity:getFlipX()
return self.m_flipX
end

function entity:getFlowDir()
if not self.m_flipX then
return Vector3.New(-1,0.5,0)
else
return Vector3.New(1,0.5,0)
end
end

function entity:getPosition()
if self.entObj~=nil then
return self.entObj:GetPosition()
else
return self.position or Vector3.zero
end
end

function entity:fixOffset(offset)
return offset
end

function entity:setVisible(visible)
if self.entObj then
self.entObj:SetVisible(visible)
end
end

function entity:runAnimator(stateID,speed,callback)
if self.entObj then
self.entObj:RunAnimator(stateID,speed or 1,callback or nil)
end
end

function entity:setAnimatorSpeed(speed)
if self.entObj then
self.entObj:SetAnimatorSpeed(speed)
end
end

function entity:stopAnimator(stateID,progress)
if self.entObj then
self.entObj:StopAnimator(stateID,progress)
end
end


function entity:moveTo(pos,faceTo,duration,ease,onComplete)
if self.moveComplete then
self.moveComplete()
self.moveComplete=nil
end
if self.entObj~=nil then
self.moveComplete=function()
if onComplete then
onComplete()
end
self.moveComplete=nil
end
self.entObj:MoveTo(pos,faceTo,duration,ease,self.moveComplete)
else
if onComplete then
onComplete()
end
end
end

function entity:localMove(pos,singleLoopTime)
if self.entObj~=nil then
self.entObj:DoLocalMove(pos,singleLoopTime)
end
end

function entity:stopLocalMove()

if self.entObj~=nil then
self.entObj:StopLocalMove()
end
end

function entity:rotationTo(angle,speed,ease,onComplete)
if self.entObj~=nil then
self.entObj:RotationTo(angle,speed,0,ease,onComplete)
end
end

function entity:setScale(scale)
if self.entObj~=nil then
self.entObj:SetScale(scale)
end
end

function entity:scaleTo(dstSize,speed,delay,ease,onComplete)
if self.entObj~=nil then
self.entObj:ScaleTo(dstSize,speed,delay,ease,onComplete)
end
end

function entity:stopScaleTo(complete)
if self.entObj then
self.entObj:StopScaleTo(complete)
end
end

function entity:scaleToRate(dstRate,speed,delay,ease,onComplete)
if self.entObj~=nil then
self.entObj:ScaleTo(self.scale*dstRate,speed,delay,ease,onComplete)
end
end

function entity:stopMoveTo()
if self.entObj~=nil then
self.entObj:StopMoveTo()
end
end

function entity:setSortingLayer(layer)
if self.entObj~=nil then
self.entObj:SetSortingLayer(layer)
end
end

function entity:setPosition(pos)
if self.entObj~=nil then
self.entObj.transform.position=pos
end
end

function entity:setRotation(angles)
if self.entObj~=nil then
self.entObj.transform.eulerAngles=angles
end
end

function entity:setScaleVec3(scaleVec3)
if self.entObj~=nil then
self.entObj.transform.localScale=scaleVec3
end

end

function entity:showShadow(show)
if self.entObj~=nil then
self.entObj:ShowShadow(show)
end
end

function entity:setColor(color)
if self.entObj then
self.entObj:SetColor(color)
end
end

function entity:fadeToColor(color,duration,finish)
if self.entObj then
self.entObj:FadeToColor(color,duration,finish or nil)
end
end



function entity:fadeToColorLoop(duration)
if self.entObj then
if self.loopFadeToColor then
self.setLoopColor=not self.setLoopColor
self.entObj:FadeToColor(self.setLoopColor and self.loopFadeToColor or Color.New(1,1,1,1),duration,function()
self:fadeToColorLoop(duration)
end)
else
local defaultColor=self.defaultColor or Color.New(1,1,1,1)
self.entObj:FadeToColor(defaultColor,duration,nil)
end
end
end

function entity:startFadeToColorLoop(color,duration)
self.loopFadeToColor=color
self:fadeToColorLoop(duration)
end

function entity:stopFadeToColorLoop(duration)
self.loopFadeToColor=nil
self.setLoopColor=nil
self:fadeToColorLoop(duration)
end

function entity:setSlotInheritColor(slotName,subslotName,inherit)
if self.entObj then
self.entObj:SetSlotInheritColor(slotName,subslotName,inherit)
end
end

function entity:getSlotTransform(slotName)
if self.entObj then
return self.entObj:GetSlotTransform(slotName)
end
end


function entity:setExpression(id)

if self.entObj then
if self.hasFace then
if id>0 then
local cfg=cfgHelper.get1(cfg_discipleexpressionimageconfig_get,id)
if cfg~=nil then
self.entObj:ChangeSlotDisplay("face","face",cfg.out_side)
end
else
self.entObj:ChangeSlotDisplay("face","face",0)
end
end
end
end

function entity:showExpression(id,duration,callback)
if not self.hasFace then
return
end
if self.showExpressionTimer~=nil then
self.showExpressionTimer:cancel()
end
local onEnd=function(...)
self.showExpressionTimer=nil
self:setExpression(0)
if callback then
callback()
end
end
self:setExpression(id)
self.showExpressionTimer=timer.new()
self.showExpressionTimer:start(duration,onEnd,1)
end

function entity:shopExpressionTimer()
if self.showExpressionTimer~=nil then
self.showExpressionTimer:cancel()
self:setExpression(0)
end
end

function entity:twinkle(duration,color)
if self.entObj then
self.entObj:Twinkle(duration,color)
end
end

function entity:playEffect(id,offset,attach,autoRemove,scale)
if self.entObj then
offset=offset or Vector3.zero
scale=scale or Vector3.one
return self.entObj:PlayEffect(id,offset,scale,attach,autoRemove)
end
end

function entity:playEffectOnActor(effectID,hangPoint,offset,scale)
if self.entObj then
offset=offset or Vector3.zero
scale=scale or Vector3.one
return self.entObj:PlayEffectOnActor(effectID,hangPoint,offset,scale)
end
end

function entity:removeEffectOnActor(id)
if self.entObj then
return self.entObj:RemoveEffectOnActor(id)
end
end

function entity:mount(id,cmps,hp,scale,offset,onMount)
if self.entObj then
self.entObj:Mount(id,cmps,hp,scale,offset,onMount)
end
end

function entity:unMount()
if self.entObj then
self.entObj:UnMount()
end
end

function entity:setEnableRayHit(enable)
if self.entObj then
self.entObj:EnableRayHit(enable)
end
end



function entity:runBehavior(btName,targets,_onBahaviroEvent)
self:stopBehavior()
self.isRunBehavior=true

local onEventListen=function(eventTypo,args)
if _onBahaviroEvent~=nil then
_onBahaviroEvent(eventTypo,args)
end
end

self.onBahaviroEvent=_onBahaviroEvent
self.fBTree:start(self,btName,onEventListen)
end


function entity:stopBehavior()
if self.isRunBehavior then
self.isRunBehavior=false
self.fBTree:stop()
end
end


function entity:update(deltaTime)
if self.isFade then

self.isFade=self.isFade-1
if self.isFade==0 then
self:fadeToColor(Color.New(1,1,1,0),0,nil)
end
self.isFade=nil
end
self.fBTree:update(deltaTime)
end






function entity:getHudPosition()
if self.entObj~=nil then
self.position=self.entObj.transform.position
local offset=self.entObj:GetHudOffset()
offset.x=0
self.hudPosition=self.position+offset
end
return self.hudPosition
end

function entity:getHudOffset()
if self.entObj~=nil then
return self.entObj:GetHudOffset()
end
return Vector3.zero
end

function entity:getSize()
return self.bodySize
end

function entity:getScale()
return self.scale
end

function entity:getPosOffset()
return Vector3.zero
end



function entity:createHud()
if self.hud==nil then
self.hud=entityHUDCtr:createEntityHud(self)
end
end

function entity:enableHUD(enable)
self.isEnableHud=enable
self:createHud()
if self.isEnableHud then
self.hud:show(self.isShowHUD)
else
self.hud:show(false)
end
end

function entity:showHuD(show)
self.isShowHUD=show
self:createHud()
if self.isEnableHud then
self.hud:show(show)
end
end












function entity:flowText(typo,args,inQueue)
if self.entObj then
self:createHud()
return self.hud:flowText(typo,args,inQueue)
end
end

function entity:stopText(id)
self:createHud()
return self.hud:stopText(id)
end

function entity:isShowHUD()
return true
end


function entity:haveAnimExculdeModel()
return false
end
