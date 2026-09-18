UILocalPathMoveNode=simple_class(baseNode)

function UILocalPathMoveNode:reset()
self._base.reset(self)
self.isplaying=false
self.bComplete=false
if self.tweener then
self.tweener:Kill(false)
end
self.tweener=nil
end

function UILocalPathMoveNode:update(interval)
if self.isplaying then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

local widget=self:getData('widget')
local wIndex=self:getData('target')
local duration=self:getData('duration')
local pathMode=self:getData('pathMode')or 1
local pathType=self:getData('pathType')or 0
local resolution=self:getData('resolution')or 10
local pathData=self:getData('path')or{}
local ease=self:getData('ease')or 1

if#pathData<2 then
return
end
self.path={}
for i=2,#pathData do
local v=pathData[i]
local vec=Vector3.New(v[1],v[2],v[3])
table.insert(self.path,vec)
end

if duration>0 then
self.isplaying=true

local transform=widget:GetCommonComponent(wIndex,'Transform')
pathType=DG.Tweening.PathType.IntToEnum(pathType)
pathMode=DG.Tweening.PathMode.IntToEnum(pathMode)

local since=pathData[1]
widget:SetChildLocalPosition(wIndex,Vector3.New(since[1],since[2],since[3]))
local tweener=Lua.DOTweenProxyExtensions.DoLocalPath(transform,self.path,duration,pathType,pathMode,resolution)

ease=DG.Tweening.Ease.IntToEnum(ease)
tweener:SetEase(ease)

self.tweener=Lua.SequenceProxy.New()
self.tweener:Append(tweener)
self.tweener:AppendCallback(function()
self.isplaying=false
self.bComplete=true
self:quicklyTick()
end)
else
widget:SetChildLocalPosition(wIndex,self.path[#self.path])
self.bComplete=true
return nodeState.success
end

return nodeState.running
end

function UILocalPathMoveNode:skip()
if self.bComplete then
return nodeState.success
end

if self.tweener and self.tweener:IsActive()then
self.tweener:Kill(true)
else
local widget=self:getData('widget')
widget:SetChildLocalPosition(wIndex,self.path[#self.path])
end

return nodeState.success
end