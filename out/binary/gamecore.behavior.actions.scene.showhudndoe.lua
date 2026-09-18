










showHUDNdoe=simple_class(baseNode)

function showHUDNdoe:init()
self.showing=false
end

function showHUDNdoe:broke()
self:removeHUD()
end

function showHUDNdoe:removeHUD()
self.loadId=nil
if self.hudId then
hudControl:removeHUD(self.hudId)
local stId=self:getSharedVar('stId')
hudControl:setHUDActiveByTarget(stId,true)
self.hudId=nil
end
end

function showHUDNdoe:update(interval)
if self.showing then
if Time.time>=self.endTime then
self.showing=false
self:removeHUD()
return nodeState.success
end
return nodeState.running
end

local htype=self:getData('htype')
htype=INSTANCE_TYPE[htype]
local stId=self:getSharedVar('stId')
local offset=_MapManager.GetObjectHeadOffset(stId)

local initClass=self:getData('initClass')
local initFunc=self:getData('initFunc')

hudControl:setHUDActiveByTarget(stId,false)
self.loadId=hudControl:addHUD(htype,stId,offset,true,true,function(id)
if self.loadId==id then
self.hudId=id
local class=_G[initClass]
class[initFunc](class,self:getOwner(),id)
else
hudControl:removeHUD(id)
end
end)

self.showing=true

local duration=self:getData('duration')or math.random(self:getData('minDuration'),self:getData('maxDuration'))
self.endTime=Time.time+duration

return nodeState.running
end