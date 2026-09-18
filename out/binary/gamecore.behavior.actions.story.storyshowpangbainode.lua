





storyShowPangBaiNode=simple_class(baseNode)

function storyShowPangBaiNode:broke()
UIManager:closeWindow('UIPangBaiWin')
end

function storyShowPangBaiNode:reset()
storyShowPangBaiNode._base.reset(self)
self.isPangBai=false
self.isCompletePb=false
end

function storyShowPangBaiNode:update(interval)
local speakList=self:getData('speakList')
local showType=self:getData('showType')or 0

if self.isPangBai then
return nodeState.running
end
if self.isCompletePb then
return nodeState.success
end
self.isPangBai=true
self.isCompletePb=false
local func=function()
self.isPangBai=false
self.isCompletePb=true
return nodeState.success
end
local args={
speakList=speakList,
showType=showType,
callback=func,
}
UIManager:showWindow('UIPangBaiWin',args)
return nodeState.running
end

function storyShowPangBaiNode:skip()
UIManager:closeWindow('UIPangBaiWin')
return nodeState.success
end