






ResultAnimation=simple_class()

local scaleFactor=CS.CSGUIManager.Instance.CanvasScaleValue
local screen=UnityEngine.Screen
local helper=CS.UIHelper

ResultAnimation.Type={
Scale=1,
TopMove=2,
RightMove=3,
Fade=4,
Shake=5,
}

function ResultAnimation:__init()
end

function ResultAnimation:__delete()
if self.shakeScaleTrans then
Lua.DOTweenProxyExtensions.DOKill(self.shakeScaleTrans)
self.shakeScaleTrans=nil
end
if self.topTrans then
Lua.DOTweenProxyExtensions.DOKill(self.topTrans)
self.topTrans=nil
end
if self.rightTrans then
Lua.DOTweenProxyExtensions.DOKill(self.rightTrans)
self.rightTrans=nil
end
if self.fadeTrans then
Lua.DOTweenProxyExtensions.CanvasGroupDOKill(self.fadeTrans)
self.fadeTrans=nil
end
if self.scaleTrans then
Lua.DOTweenProxyExtensions.DOKill(self.scaleTrans)
self.scaleTrans=nil
end
end

function ResultAnimation:DoAnimation(list)
self.count=0
self.actionList=list
self:Complete()
end

function ResultAnimation:Complete()
self.count=self.count+1
local list=self.actionList[self.count]
if not list then return end

local function SetAction(data)
if data._type==ResultAnimation.Type.Scale then
self:DoScaleAction(data)

elseif data._type==ResultAnimation.Type.TopMove then
self:DoTopAction(data)

elseif data._type==ResultAnimation.Type.RightMove then
self:DoRightAction(data)

elseif data._type==ResultAnimation.Type.Fade then
self:DoFadeAction(data)

elseif data._type==ResultAnimation.Type.Shake then
self:DOShakeScaleAction(data)
end

if data.audioName then

end
end

for i,v in ipairs(list)do
SetAction(v)
end
end

function ResultAnimation:DOShakeScaleAction(actionData)
local trans=actionData.tarns
local duration=actionData.duration
local tween=Lua.DOTweenProxyExtensions.DOShakeRotation(trans,duration,1,10,180,false)


tween:OnComplete(objectHelper.packFunc(self,self.Complete))

self.shakeScaleTrans=trans
end

function ResultAnimation:DoTopAction(actionData)
local trans=actionData.tarns
local duration=actionData.duration
local begin_y=trans.pivot.y*trans.rect.height*scaleFactor.y+screen.height
local end_y=trans.anchoredPosition.y
trans.anchoredPosition=Vector2.New(trans.anchoredPosition.x,begin_y)
trans.gameObject:SetActive(true)

local tween=Lua.DOTweenProxyExtensions.DOAnchorPosY(trans,end_y,duration)
tween:SetEase(DG.Tweening.Ease.OutElastic)


tween:OnComplete(objectHelper.packFunc(self,self.Complete))

self.topTrans=trans
end

function ResultAnimation:DoRightAction(actionData)
local trans=actionData.tarns
local duration=actionData.duration
local begin_x=trans.anchoredPosition.x+100
local end_x=trans.anchoredPosition.x
trans.anchoredPosition=Vector2.New(begin_x,trans.anchoredPosition.y)
trans.gameObject:SetActive(true)
local tween=Lua.DOTweenProxyExtensions.DOAnchorPosX(trans,end_x,duration)


tween:OnComplete(objectHelper.packFunc(self,self.Complete))

self.rightTrans=trans
end

function ResultAnimation:DoFadeAction(actionData)
local trans=actionData.tarns
local CanvasGroup=helper.GetCanvasGroup(trans.gameObject)
local duration=actionData.duration
if CanvasGroup==nil then return end

trans.gameObject:SetActive(true)
local tween=Lua.DOTweenProxyExtensions.DOFade(CanvasGroup,1,duration)


tween:OnComplete(objectHelper.packFunc(self,self.Complete))

self.fadeTrans=CanvasGroup
end

function ResultAnimation:DoScaleAction(actionData)
local trans=actionData.tarns
local duration=actionData.duration
trans.gameObject:SetActive(true)
local tween=Lua.DOTweenProxyExtensions.DOScale(trans,1,duration)


tween:OnComplete(objectHelper.packFunc(self,self.Complete))

self.scaleTrans=trans
end
