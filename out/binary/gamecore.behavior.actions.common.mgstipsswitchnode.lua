
mgsTipsSwitchNode=simple_class(baseNode)

function mgsTipsSwitchNode:start()
mgsTipsSwitchNode._base.start(self)
local idx=self:getData('tipsIdx')or 0
local vis=self:getData('tipsVis')or 0
UIManager.enableTips(idx,vis)
end

function mgsTipsSwitchNode:update(interval)
return nodeState.success
end