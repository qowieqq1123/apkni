






UIAnimationFromTo=simple_class()

function UIAnimationFromTo:__init()
self._offIndex=0
self.tween_doMove={}
end

function UIAnimationFromTo:__delete()
self:Reset()
self._offIndex=nil
self.tween_doMove=nil
end

function UIAnimationFromTo:GetOffIndex()
self._offIndex=self._offIndex+1
return self._offIndex
end


function UIAnimationFromTo:AddDOMoveTween(handle_object,duration,from_handle_object,to_handle_object,callback,ease,offIndex)
local handle_transform=handle_object.transform

local startValue=from_handle_object.transform.position

local endValua=to_handle_object.transform.position
local offIndex=offIndex or self:GetOffIndex()
self.tween_doMove[offIndex]={handle_transform=handle_transform,duration=duration,startValue=startValue,endValua=endValua,callback=callback,ease=ease,isStart=false}
return offIndex
end


function UIAnimationFromTo:StartDoMoveTweenAll()
local handle_trans=nil
local duration=nil
local begin=nil
local endValua=nil
for offIndex,v in pairs(self.tween_doMove)do
self:StartDoMoveTween(offIndex)
end
end


function UIAnimationFromTo:StartDoMoveTween(offIndex)

if not self.tween_doMove[offIndex]or self.tween_doMove[offIndex].isStart then
return
end
local handle_trans=self.tween_doMove[offIndex].handle_transform
handle_trans.position=self.tween_doMove[offIndex].startValue
local dotweenerProxy=Lua.DOTweenProxyExtensions.DOMove(handle_trans,self.tween_doMove[offIndex].endValua,self.tween_doMove[offIndex].duration,false)
local ease=self.tween_doMove[offIndex].ease or DG.Tweening.Ease.Linear
dotweenerProxy:SetEase(ease)
if self.tween_doMove[offIndex].callback then
dotweenerProxy:OnComplete(function()self.tween_doMove[offIndex].callback(offIndex)end)
end
self.tween_doMove[offIndex].isStart=true
end


function UIAnimationFromTo:StopDoMoveTweenAll()
for offIndex,v in pairs(self.tween_doMove)do
self:StopDoMoveTween(offIndex)
end
end


function UIAnimationFromTo:StopDoMoveTween(offIndex)

if not self.tween_doMove[offIndex]or not self.tween_doMove[offIndex].isStart then
return
end
Lua.DOTweenProxyExtensions.DOKill(self.tween_doMove[offIndex].handle_transform,false)
self.tween_doMove[offIndex].isStart=false
end


function UIAnimationFromTo:Reset()
self:StopDoMoveTweenAll()
self:__init()
end