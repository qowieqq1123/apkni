






UIAnimation=simple_class()

local scaleFactor=CS.CSGUIManager.Instance.CanvasScaleValue
local screen=UnityEngine.Screen

local _DOAnchorPosX=Lua.DOTweenProxyExtensions.DOAnchorPosX
local _DOAnchorPosY=Lua.DOTweenProxyExtensions.DOAnchorPosY
local _DOScale=Lua.DOTweenProxyExtensions.DOScale


function UIAnimation:__init()

end

function UIAnimation:__delete()
self.tween_bottom=nil
self.tween_right=nil
self.tween_left=nil
self.tween_top=nil
end

function UIAnimation:DoScaleAction(handle_object,duration)
if self.tween_scale==nil then
self.tween_scale={}
end
local transform=ComponentHelper.GetComponent(handle_object,RectTransform)
self.tween_scale[#self.tween_scale+1]={transform=transform,duration=duration}
end

function UIAnimation:AddLeftTween(handle_object,duration)
if self.tween_left==nil then
self.tween_left={}
end
local transform=ComponentHelper.GetComponent(handle_object,RectTransform)
local endValua=transform.anchoredPosition.x
self.tween_left[#self.tween_left+1]={transform=transform,duration=duration,endValua=endValua}
end

function UIAnimation:AddRightTween(handle_object,duration)
if self.tween_right==nil then
self.tween_right={}
end
local transform=ComponentHelper.GetComponent(handle_object,RectTransform)
local endValua=transform.anchoredPosition.x
self.tween_right[#self.tween_right+1]={transform=transform,duration=duration,endValua=endValua}
end

function UIAnimation:AddTopTween(handle_object,duration)
if self.tween_top==nil then
self.tween_top={}
end
local transform=ComponentHelper.GetComponent(handle_object,RectTransform)
local endValua=transform.anchoredPosition.y
self.tween_top[#self.tween_top+1]={transform=transform,duration=duration,endValua=endValua}
end

function UIAnimation:AddBottomTween(handle_object,duration)
if self.tween_bottom==nil then
self.tween_bottom={}
end
local transform=ComponentHelper.GetComponent(handle_object,RectTransform)
local endValua=transform.anchoredPosition.y
self.tween_bottom[#self.tween_bottom+1]={transform=transform,duration=duration,endValua=endValua}
end

function UIAnimation:DoAnimation()
local handle_trans=nil
local duration=nil
local begin_x=nil
local begin_y=nil
local end_x=nil
local end_y=nil

if self.tween_right then
for i=1,#self.tween_right do
handle_trans=self.tween_right[i].transform
duration=self.tween_right[i].duration
begin_x=screen.width+handle_trans.pivot.x*handle_trans.rect.width*scaleFactor.x
end_x=self.tween_right[i].endValua
handle_trans.anchoredPosition=Vector2.New(begin_x,handle_trans.anchoredPosition.y)
_DOAnchorPosX(handle_trans,end_x,duration,false)
end
end
if self.tween_left then
for i=1,#self.tween_left do
handle_trans=self.tween_left[i].transform
duration=self.tween_left[i].duration
begin_x=handle_trans.pivot.x*handle_trans.rect.width*scaleFactor.x-screen.width
end_x=self.tween_left[i].endValua
handle_trans.anchoredPosition=Vector2.New(begin_x,handle_trans.anchoredPosition.y)
_DOAnchorPosX(handle_trans,end_x,duration,false)
end
end
if self.tween_bottom then
for i=1,#self.tween_bottom do
handle_trans=self.tween_bottom[i].transform
duration=self.tween_bottom[i].duration
begin_y=handle_trans.pivot.y*handle_trans.rect.height*scaleFactor.y-screen.height
end_y=self.tween_bottom[i].endValua
handle_trans.anchoredPosition=Vector2.New(handle_trans.anchoredPosition.x,begin_y)
_DOAnchorPosY(handle_trans,end_y,duration,false)
end
end
if self.tween_top then
for i=1,#self.tween_top do
handle_trans=self.tween_top[i].transform
duration=self.tween_top[i].duration
local begin_y=handle_trans.pivot.y*handle_trans.rect.height*scaleFactor.y+screen.height
local end_y=self.tween_top[i].endValua
handle_trans.anchoredPosition=Vector2.New(handle_trans.anchoredPosition.x,begin_y)
_DOAnchorPosY(handle_trans,end_y,duration,false)
end
end

if self.tween_scale then
for i=1,#self.tween_scale do
handle_trans=self.tween_scale[i].transform
duration=self.tween_scale[i].duration
handle_trans.localScale=Vector3(0,0,0)
_DOScale(handle_trans,1,duration)
end
end
end

