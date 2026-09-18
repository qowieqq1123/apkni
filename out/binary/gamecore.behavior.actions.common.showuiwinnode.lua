








showUIWinNode=simple_class(baseNode)

function showUIWinNode:init()
self.isWaiting=false
end

function showUIWinNode:update(interval)
if self.isWaiting then
if UIManager:isActive(self.winName)then
return nodeState.success
else
return nodeState.running
end
end

self.winName=self:getData('winName')
if UIManager:isActive(self.winName)then
return nodeState.success
end

local args=self:getData('winArgs')or{}
args.bt=self:getOwner()
UIManager:showWindow(self.winName,args)

local waitLoaded=self:getData('waitLoaded')
if waitLoaded==false then
return nodeState.success
else
self.isWaiting=true
return nodeState.running
end
end