









local xjBehaviorJob_searchCloud={}


function xjBehaviorJob_searchCloud:onInit()
self.cloudid=self.tree:getShareValue('cloudid')
local cloudData=xianjieModel:getCloudData(self.cloudid)
local events=cloudData.events
local num=#events
local hasEvent=false
local evenList={}
if num>0 then
local teamHandle=cloudData:getTeamHandle()
local wayTime=teamHandle:getMoveWayTime(false)

local arriveTime=cloudData.beginsec+wayTime
for i=1,num do
local cfg=events[i]
local idx=cfg.idx
local flag=cloudData.idx>=idx
if not flag then
hasEvent=true
local endTime=arriveTime+cfg.begin
table.insert(evenList,{idx,cfg,endTime})
end
end
end
if hasEvent then
self.evenList=evenList
end
self.hasEvent=hasEvent
end


function xjBehaviorJob_searchCloud:onStart()


if xianjieController:checkInPlotScene()then
self.entKey=xianjieController:addEntity(XJ_ENTITY_TYPE.eSearchCloud,{self.cloudid},true)
return true
end
return false
end

function xjBehaviorJob_searchCloud:tick(interval)
local isSearchOver=self.tree:getShareValue('isSearchOver')
if isSearchOver then
self.tree:setShareValue('isSearchOver',nil)
return true
end
local isReqData=self.tree:getShareValue('isReqData')
if not isReqData then
if self.hasEvent and#self.evenList>0 then
local reqIndex=self.tree:getShareValue('reqDataIndex')
if reqIndex~=nil then
self.tree:setShareValue('reqDataIndex',nil)
end
local found=nil
local time=gameUtilityModel.getServerShortTime2()
for i,d in ipairs(self.evenList)do
local idx=d[1]
if reqIndex~=nil and reqIndex==idx then
found=i
elseif time>=d[3]then
local cloudData=xianjieModel:getCloudData(self.cloudid)
xianjieController:reqSearchCloudIdx(cloudData.cloudid,cloudData.idx+1)

self.tree:setShareValue('isReqData',true)
self.tree:setShareValue('reqDataIndex',idx)
break
end
end
if found then
table.remove(self.evenList,found)
end
end
end
return false
end


function xjBehaviorJob_searchCloud:onDispose()
if self.entKey then
xianjieController:removeEntity(self.entKey)
self.entKey=nil
end
end

return xjBehaviorJob_searchCloud