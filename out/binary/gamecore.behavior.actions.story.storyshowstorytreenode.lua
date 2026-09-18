





storyShowStoryTreeNode=simple_class(baseNode)

function storyShowStoryTreeNode:reset()
storyShowStoryTreeNode._base.reset(self)
self.isShowing=false
self.isCompleteST=false
end

function storyShowStoryTreeNode:update(interval)
local treeId=self:getData('treeId')

if self.isShowing then
return nodeState.running
end
if self.isCompleteST then
return nodeState.success
end
self.isShowing=true
self.isCompleteST=false
local func=function(index)
self.isShowing=false
self.isCompleteST=true
return nodeState.success
end
worldStoryController:showStoryTree(treeId,func)
return nodeState.running
end