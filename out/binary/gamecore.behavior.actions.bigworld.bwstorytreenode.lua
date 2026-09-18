








bwStoryTreeNode=simple_class(baseNode)

function bwStoryTreeNode:init()
self.isplaying=false
self.bComplete=false
end

function bwStoryTreeNode:update(interval)
if self.isPlaying then
return nodeState.running
end

if self.bComplete then
return nodeState.success
end

local treeId=self:getData('tree')
local cfg=cfgHelper.get1(cfg_storydialoguetreeconfig_get,treeId)
if cfg==nil then return nodeState.failure end

worldStoryController:showStoryTree(treeId,function()
self.isplaying=false
self.bComplete=true
self:quicklyTick()
end)
self.isplaying=true
self.bComplete=false
return nodeState.running
end