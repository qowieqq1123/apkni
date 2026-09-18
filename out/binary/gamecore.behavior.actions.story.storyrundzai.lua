









storyRunDZAI=simple_class(baseNode)

function storyRunDZAI:update(interval)
local dzIndex=self:getData('dzIndex')
local AIType=self:getData('AIType')

local initData=self:dealAttachArgs()
local cmdData=
{
type=AIType,
initData=initData,
}
storyAIManager:startZMDiscipleAI(dzIndex,cmdData)
return nodeState.success
end

function storyRunDZAI:dealAttachArgs()
local list={}
local argsCount=self:getData('argsCount')
if argsCount then
for i=1,argsCount do
local shareKey=self:getData(FMT.fmt('shareKey{0}',i))
local shareVal=self:getData(FMT.fmt('shareVal{0}',i))
if shareKey then
list[shareKey]=shareVal
end
end
end
return list
end

function storyRunDZAI:skip()
local dzIndex=self:getData('dzIndex')
local AIType=self:getData('AIType')
storyAIManager:skipZMDiscipleAI(dzIndex,AIType)
return nodeState.success
end