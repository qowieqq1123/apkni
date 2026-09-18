







speakForCfgNode=simple_class(baseNode)

function speakForCfgNode:start()
local data=self.data
if data and data.cfgKey and data.index then
local config=self:getSharedVar(data.cfgKey)
if config then
local cfg=config[data.index]
if cfg and cfg.content1 then
local hudId=self:getSharedVar('hudIdSpeak')
if hudId==nil then

hudId=discipleStateManager:beginSpeak(self.args.dzId,self.args.guid,false)
self:setSharedVar('hudIdSpeak',hudId)
end
local widget=hudControl:getHUDWidget(hudId)
if widget then
local say=string.gsub(cfg.content1,'\\n','\n')
widget:SetChildText(0,say)
self.state=nodeState.success
return
end
end
end
end

self.state=nodeState.failure
end

function speakForCfgNode:reset()
self:shutUp()
self.state=nil
end

function speakForCfgNode:shutUp()
local hudId=self:getSharedVar('hudIdSpeak')
if hudId then

discipleStateManager:endSpeak(self.args.dzId,hudId)
self:setSharedVar('hudIdSpeak')
end
end