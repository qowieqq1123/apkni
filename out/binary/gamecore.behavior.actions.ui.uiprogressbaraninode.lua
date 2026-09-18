UIProgressBarAniNode=simple_class(baseNode)

function UIProgressBarAniNode:reset()
self._base.reset(self)
self.isplaying=false
self.bComplete=false
end

function UIProgressBarAniNode:update(interval)
if self.isplaying then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

local widget=self:getData('widget')
local wIndex=self:getData('target')
local since=self:getData('since')
local val=self:getData('value')
local maxVal=self:getData('maxValue')
local duration=self:getData('duration')
local reverse=self:getData('reverse')or false
local wait=self:getData("wait")or true

if wait then
self.isplaying=true
self.bComplete=false
widget:SetProgressBarAniFinishAction(wIndex,function()
self.isplaying=false
self.bComplete=true
widget:SetProgressBarAniFinishAction(wIndex,nil)
self:quicklyTick()
end)
end

if duration==nil then
widget:SetProgressBarAniWithTwoParams(wIndex,val,maxVal)
elseif duration>0 then
if since~=nil then
widget:SetProgressBarAniWithFiveParams(wIndex,since,val,maxVal,duration,reverse)
else
widget:SetProgressBarAniWithFourParams(wIndex,val,maxVal,duration,reverse)
end
else
widget:SetProgressBarAniWithThreeParams(wIndex,val,maxVal,0)
end

return wait and nodeState.running or nodeState.success
end


function UIProgressBarAniNode:skip()
if self.bComplete then
return nodeState.success
end

local widget=self:getData('widget')
local wIndex=self:getData('target')
local val=self:getData('value')
local maxVal=self.getData('maxValue')
local reverse=self:getData('reverse')
widget:SetProgressBarAniFinishAction(wIndex,nil)
widget:SetProgressBarAniWithFourParams(wIndex,val,maxVal,0)

return nodeState.success
end