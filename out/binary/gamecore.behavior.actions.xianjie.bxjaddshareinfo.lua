






bXJAddShareInfo=simple_class(baseNode)

function bXJAddShareInfo:init()
self.waitTime=0
self.shareIdx=1
end

function bXJAddShareInfo:update(interval)
local typelist=self:getData('typelist')

if typelist==nil then
logErr("bXJAddShareInfo - 缺少类型列表")
end

if next(typelist)then
for index=self.shareIdx,#typelist do
local type=typelist[index]
self.shareIdx=index
if not xianjieStoryAIManager:setXianJieBehaviorShareArgs(type)then
break
end
end
end

if self.shareIdx==#typelist then
return nodeState.success
end

return nodeState.running
end