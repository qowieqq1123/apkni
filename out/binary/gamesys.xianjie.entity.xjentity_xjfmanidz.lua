









local xjEntity_XJFMAniDz={}


function xjEntity_XJFMAniDz:onInit()

local data=XianJieFuMoController:getBossData()
self.pos=data:getWorldPos_1()
self.startpos=self.data.startpos
self.size=self.data.size
self.modelCfg=self.data.modelCfg
self.targetPos=self.data.targetPos
self.moveSpeed=self.data.moveSpeed
self.ent_name="xjEntity_XJFMAniDz"
self.canSelect=false
self.allowClickGrid=false
self.argEx=self.data.argEx
end


function xjEntity_XJFMAniDz:onSelectHandle(widget,isSelect)

end


function xjEntity_XJFMAniDz:onCreateWidget(widget)


self.widget=widget

self:clearTweener()
local delayFlag=false
if not self.showModel then
delayFlag=true
self.showModel=true
self:playEffect()
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
widget:SetChildSceneEntityCreateModel(0,self.modelCfg[1],self.modelCfg[2],'Entity',entCfg.sortOrder,self.modelCfg[3],nil,false)


widget:SetChildSceneEntityPlayAnimation(0,eAnimationID.jump2,1)
end
widget:SetChildSceneEntityFlipX(0,self.startpos.x<self.pos.x)
widget:SetChildPosition(1,self.startpos)

if self.endAttackTime then
widget:SetChildSceneEntityUnMount(0)
widget:SetChildSceneEntityPlayAnimation(0,1010,1)
else
widget:SetChildSceneEntityMount(0,1110013,{},"",1.5,Vector3.zero)
local moveFinishFunc=function()

widget:SetChildSceneEntityPlayAnimation(0,eAnimationID.jump2,1)
self:delayDo(0.5,function()
if not widget then
return
end
widget:SetChildSceneEntityUnMount(0)
self.moveTweener=nil
widget:SetChildSceneEntityPlayAnimation(0,1010,1)
if not self.endAttackTime then
self.endAttackTime=gameUtilityModel.getServerShortTime2()+math.random(5,10)
end
local data=XianJieFuMoController:getBossData()
if data then
data:chanegeBossAmiState(1010)
end
end)
end
local dis=mathHelper.distance(self.startpos.x,self.startpos.z,self.targetPos.x,self.targetPos.z)
local time=dis/self.moveSpeed

local moveFun=function()
if not widget then
return
end

widget:SetChildSceneEntityPlayAnimation(0,eAnimationID.fly,1)
if not self.targetPos then
return
end
self.moveTweener=widget:SetChildDOMove(1,self.targetPos,time,moveFinishFunc)
self.moveTweener:SetEase(DG.Tweening.Ease.Linear)
end

if delayFlag then
self:delayDo(0.8,moveFun)
else
moveFun()
end
end
end


function xjEntity_XJFMAniDz:onRemoveWidget(widget)
self.widget=nil

self.startpos=widget:GetChildPosition(1)
self:clearTweener()
end

function xjEntity_XJFMAniDz:onUpdate(boxParams)
if self.endAttackTime then
if gameUtilityModel.getServerShortTime2()>self.endAttackTime then
if self.widget then

self.widget:SetChildSceneEntityRemoveModel(0)
self:playEffect()
end
self.endAttackTime=nil
local teamIndex=self.argEx.teamIndex
local selfKey=self:getKey()
self:delayDo(0.2,function()
local data=XianJieFuMoController:getBossData()
if data then
data:removeTeamAniDz(teamIndex,selfKey)
data:checkBossAniState()
end
end)
end
end
end


function xjEntity_XJFMAniDz:onDelete()

end

function xjEntity_XJFMAniDz:clearTweener()
if self.moveTweener~=nil then


self.moveTweener:Kill()
self.moveTweener=nil
end
end

function xjEntity_XJFMAniDz:delayDo(time,func)
timeEventController.delayDo(time,function()
if self then
func()
end
end)
end

function xjEntity_XJFMAniDz:playEffect()

local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local sortingLayer=helper.getSortingLayerID("Entity")
self.widget:SetChildShowEffectEx(2,3,sortingLayer,entCfg.sortOrder-1,true)
end



return xjEntity_XJFMAniDz
