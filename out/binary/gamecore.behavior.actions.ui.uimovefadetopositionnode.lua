







UIMoveFadeToPositionNode=simple_class(baseNode)

local _DOTween=Lua.DOTweenProxyExtensions
local _Ease=DG.Tweening.Ease
local _helper=CS.UIHelper

local function _getVector3(bt,pos)
if type(pos)=='string'then
return bt:getSharedVar(pos)
elseif type(pos)=='table'then
return Vector3(pos[1],pos[2],0)
end
end

function UIMoveFadeToPositionNode:update(interval)
if self.isMoving then
return nodeState.running
end

if self:isComplete()then
return self.state
end

local data=self.data
if data then
local args=self:getArgs()
self.active=data.active or 1
local targetPos=_getVector3(self.owner,data.outPos)
local childObj=args.winlua:GetChildGameObject(args.model)
local canvasGroup=_helper.GetCanvasGroup(childObj)
self.canvasGroup=canvasGroup
if targetPos and canvasGroup then
local transform=args.winlua:GetChildGameObject(args.model).transform
local fromPos=_getVector3(self.owner,data.fromPos)
if fromPos then
transform.localPosition=fromPos
else
fromPos=transform.localPosition
end
if fromPos==targetPos then
return nodeState.success
elseif data.speed or data.duration then
self.isMoving=true
if data.speed then
local duration=Vector3.Distance(fromPos,targetPos)/data.speed
self:moveToPos(transform,fromPos,targetPos,duration,data.changeScale)
elseif data.duration then
self:moveToPos(transform,fromPos,targetPos,data.duration,data.changeScale)
end
args.winlua:SetChildModelAnimationState(args.model,data.moveAnId or eAnimationID.run)
return nodeState.running
end
end
end
return nodeState.failure

end

function UIMoveFadeToPositionNode:moveToPos(transform,fromPos,targetPos,duration,changeScale)
local args=self:getArgs()
args.winlua:SetChildUIModelShowFlipX(args.model,fromPos.x<targetPos.x)
self.doTween=_DOTween.DOLocalMove(transform,targetPos,duration,false)
self.doTween:SetEase(_Ease.Linear)
if changeScale then
local dy=targetPos.y-fromPos.y
local change=dy/changeScale[1]*changeScale[2]
if dy~=0 then
local scale=transform.localScale.x-change
self.scaleTween=_DOTween.DOScale(transform,scale,duration)
end
end
self.fadeTween=_DOTween.DOFade(self.canvasGroup,self.active,duration)
self.doTween:OnComplete(function()
args.winlua:SetChildModelAnimationState(args.model,self.data.standAnId or eAnimationID.stand)
self.state=nodeState.success
self.isMoving=false
end)
end

function UIMoveFadeToPositionNode:broke()
if self.doTween then
self.doTween:Kill(false)
end
if self.scaleTween then
self.scaleTween:Kill(false)
end
local args=self:getArgs()
if args.winlua and args.model then
args.winlua:SetChildModelAnimationState(args.model,self.data.brokeAnId or eAnimationID.stand)
end





end

function UIMoveFadeToPositionNode:skip()
self:broke()
return nodeState.success
end