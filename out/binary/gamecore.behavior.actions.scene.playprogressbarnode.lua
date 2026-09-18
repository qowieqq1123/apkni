









playProgressBarNode=simple_class(baseNode)

function playProgressBarNode:reset()
playProgressBarNode._base.reset(self)
self.isplaying=false
self.bComplete=false
end

function playProgressBarNode:broke()
self:clearAll()
end

function playProgressBarNode:clearAll()
if self.tweener then
self.tweener:Kill()
self.tweener=nil
end
self.loadId=nil
if self.hudId then
hudControl:removeHUD(self.hudId)
hudControl:setHUDActiveByTarget(self.targetId,true)
self.hudId=nil
end
end

function playProgressBarNode:update(interval)
if self.isplaying then
return nodeState.running
end

if self.bComplete then
self:clearAll()
return nodeState.success
end

local ptype=self:getData('pbType')
ptype=INSTANCE_TYPE[ptype]
local targetId=self:getData('targetId')
local offset
if self:hasData('offset')then
offset=self:getData('offset')
offset=Vector3.New(offset[1],offset[2],0)
else
offset=_MapManager.GetObjectHeadOffset(targetId)
end
local refreshPos=self:getData('refreshPos')
local duration=self:getData('duration')
self.isplaying=true
hudControl:setHUDActiveByTarget(targetId,false)
self.loadId=hudControl:addHUD(ptype,targetId,offset,refreshPos,true,function(id)
if self.loadId==id then
self.hudId=id
local widget=hudControl:getHUDWidget(self.hudId)
widget:SetChildIconFillAmount(0,0)
self.tweener=widget:SetChildImageDOFillAmount(0,1,duration,function()
self.isplaying=false
self.bComplete=true
self:quicklyTick()
end)
self.tweener:SetEase(_Ease.Linear)
else
hudControl:removeHUD(id)
end
end)

self.targetId=targetId

return nodeState.running
end