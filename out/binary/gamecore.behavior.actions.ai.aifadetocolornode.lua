






aiFadeToColorNode=simple_class(baseNode)

function aiFadeToColorNode:init()
self.isPlaying=false
self.bComplete=false
end

function aiFadeToColorNode:update(interval)
if self.isPlaying then
return nodeState.running
end

if self.bComplete then
return self.checkState
end

local color=self:getData('color')
local duration=self:getData('duration')

self.isPlaying=true
self.checkState=nodeState.running
local args=self:getArgs()
_MapManager.SetFadeToColor(args.stId,Color.New(color[1],color[2],color[3],color[4]),duration,function()
self.checkState=nodeState.success
self.isPlaying=false
self.bComplete=true
self:quicklyTick()
end)

return self.checkState
end