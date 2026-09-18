







storyStopEffectNode=simple_class(baseNode)

function storyStopEffectNode:start()
end

function storyStopEffectNode:reset()
storyStopEffectNode._base.reset(self)
end

function storyStopEffectNode:broke()
if self.effectId then
_stopEffect(self.effectId)
end
end

function storyStopEffectNode:update(interval)
local key=self:getData('effectName')
if key==nil then
logErr('storyStopEffectNode必须有effectName')
return nodeState.success
end
self.effectId=self:getSharedVar(key)
if self.effectId==nil then
loggerUtil.logErrFMT('effectName = {0}没有找到effectId',key)
return nodeState.success
end
local fadeout=self:getData('fadeout')or 0
if fadeout==1 then
_sleepEffect(self.effectId,false)
else
_stopEffect(self.effectId)
end
return nodeState.success
end