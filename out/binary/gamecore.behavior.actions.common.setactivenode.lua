







setActiveNode=simple_class(baseNode)

function setActiveNode:update(interval)
local active=self:getData('active')or 1
local args=self:getArgs()
_MapManager.SetTilemapObjectActive(args.stId,active==1)

if active==0 then
self:shutUp()
end
return nodeState.success
end

function setActiveNode:broke()
local args=self:getArgs()
local default=self:getData('default')==0
_MapManager.SetTilemapObjectActive(args.stId,not default)
end

function setActiveNode:shutUp()
local hudId=self:getSharedVar('hudIdSpeak')
if hudId then
hudControl:removeHUD(hudId)
self:setSharedVar('hudIdSpeak')
end
end