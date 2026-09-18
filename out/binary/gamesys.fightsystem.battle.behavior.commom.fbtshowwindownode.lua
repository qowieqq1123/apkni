


registry_pool_class(fBTNodeTypo.ShowWindow,'fBTShowWindowNode',fBTBaseNode)

function fBTShowWindowNode:__init(guid)
self.typo=fBTNodeTypo.ShowWindow
end

function fBTShowWindowNode:parser(rawData)
self.windowName=rawData[1]
self.opType=rawData[2]
self.para=rawData[3]
self.mustExe=rawData[4]
end



local op_open=1
local op_hide=2
local op_close=3

function fBTShowWindowNode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)

self.isExe=false
end

function fBTShowWindowNode:start()
self:opWindow()

self.state=fBTNodeState.success
end

function fBTShowWindowNode:opWindow()
self.isExe=true
if self.opType==op_open then
UIManager:showWindow(self.windowName,{ent=self.entity,para=self.para})
elseif self.opType==op_hide then
UIManager:hideWindow(self.windowName)
else
UIManager:closeWindow(self.windowName)
end
end

function fBTShowWindowNode:update(delta)
return self.state
end



function fBTShowWindowNode:onComplete()
if self.mustExe and not self.isExe then
self:opWindow()
end
end

function fBTShowWindowNode:onDespawn()
self.behaviorTree=nil
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

