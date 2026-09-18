








setColorNode=simple_class(baseNode)

function setColorNode:reset()
setColorNode._base.reset(self)
self.isFadeing=false
self.cComplete=false
end

function setColorNode:broke()
local active=self:getData('default')
local args=self:getArgs()
_MapManager.SetFadeToColor(args.stId,Color.New(1,1,1,active or 1),0,nil)
end

function setColorNode:update(interval)
if self.isFadeing then
return nodeState.running
end
if self.cComplete then
return nodeState.success
end
self.isFadeing=true

local color=self:getData('color')
local duration=self:getData('duration')
local args=self:getArgs()
local alpha=color[4]
local target=Color.New(color[1],color[2],color[3],alpha)
local func=function(...)
self.isFadeing=false
self.cComplete=true
end
_MapManager.SetFadeToColor(args.stId,target,duration,func)

return nodeState.running
end