


registry_pool_class(fBTNodeTypo.SetFightMainUI,'fBTSetFightMainUINode',fBTBaseNode)

function fBTSetFightMainUINode:__init(guid)
self.typo=fBTNodeTypo.SetFightMainUI
end

function fBTSetFightMainUINode:parser(rawData)
self.stateType=rawData[1]
self.mustExe=rawData[2]
end


local hud_show=1
local hud_hide=2

function fBTSetFightMainUINode:awake(bt,rawData)
self.behaviorTree=bt
self.entity=bt.entity
self:parser(rawData)
self.hasExe=false
end



function fBTSetFightMainUINode:start()

self:doAction()
end

function fBTSetFightMainUINode:doAction()
self.hasExe=true
self.state=fBTNodeState.success
local battle=self.entity.battle

if battle~=nil then
if self.stateType==hud_show then
UIFullFightControl:reshowFightMain(battle)
else
UIFullFightControl:hideFightMain(battle)
end
end
end

function fBTSetFightMainUINode:update(delta)

return self.state
end

function fBTSetFightMainUINode:onComplete()
if self.mustExe and not self.hasExe then
self:doAction()
end
end


function fBTSetFightMainUINode:onDespawn()
self.entity=nil
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

