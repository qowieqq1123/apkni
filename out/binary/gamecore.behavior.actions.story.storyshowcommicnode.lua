




storyShowCommicNode=simple_class(baseNode)

function storyShowCommicNode:reset()
storyShowCommicNode._base.reset(self)
self.isShowing=false
self.bComplete=false
end

function storyShowCommicNode:update(interval)
local commic=self:getData('commic')
local isFullOpen=self:getData('fullScreen')or false

if self.isShowing then
return nodeState.running
end
if self.bComplete then
return nodeState.success
end
self.isShowing=true
self.bComplete=false
local func=function(index)
self.isShowing=false
self.bComplete=true
self:quicklyTick()
return nodeState.success
end
UIFullStoryBoardControl:showManHuaWindow({groupid=commic,callback=func},isFullOpen)
return nodeState.running
end