
setColorNdoe=simple_class(baseNode)

function setColorNdoe:init()
self.isPlaying=false
self.bComplete=false
end

function setColorNdoe:broke()
local color=self:getData("brokeColor")
if color then

end
end

function setColorNdoe:update(interval)
if self.isPlaying then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

local guid=self:getData("guid")
local color=self:getData("color")
local duration=self:getData("duration")

color=Color.New(color[1],color[2],color[3],color[4])
if duration>0 then
self.isPlaying=true
self.bComplete=false
local source=self:getData("source")
if source then
source=Color.New(source[1],source[2],source[3],source[4])
_MapManager.SetColor(guid,source)
end
local delay=self:getData("delay")or 0
_MapManager.SetFadeToColor(guid,color,duration,function()
self.isPlaying=false
self.bComplete=true
self:quicklyTick()
end,delay)
return nodeState.running
else
_MapManager.SetColor(guid,color)
return nodeState.success
end
end