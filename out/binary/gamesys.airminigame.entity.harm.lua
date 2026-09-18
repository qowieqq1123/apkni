harm=simple_class(baseEntity)


function harm:initialize(args)
local action=args.action
self:lookAtCamera()

self.hudClearTimeList=nil
self.clearTimeIndex_start=1
self.clearTimeIndex_end=0
self.maxCount=20
self.hudCount=0
self:setSpriteActive(false)
if action then
return action(self)
end
end

function harm:onDelete()
if self==nil or self:isDeleteSelf()then return end
self:clearAllHud()
airHUDSystem:clearHarmEntity()
self._base.onDelete(self)
end

function harm:onUpdate()
self._base.onUpdate(self)
if self.hudClearTimeList and next(self.hudClearTimeList)then

for i=1,10 do
local clearData=self.hudClearTimeList[self.clearTimeIndex_start]
if clearData then
local guid=clearData.guid
local delayDeleteStamp=clearData.delayDeleteStamp
local stamp=Time.realtimeSinceStartup
if stamp>=delayDeleteStamp then
local hudType=eHudType.eHarm
airHUDSystem:deleteEntityHUDByGuid(self.handle,hudType,guid)
self.hudClearTimeList[self.clearTimeIndex_start]=nil
self.clearTimeIndex_start=self.clearTimeIndex_start+1
self.hudCount=self.hudCount-1
end
else
break
end
end
end
end

function harm:onPause()
self._base.onPause(self)

end

function harm:onContinue()
self._base.onContinue(self)

end

function harm:onFastUpdate()
self._base.onFastUpdate(self)

end

function harm:setHudClearTime(guid,delayTime)
if not self.hudClearTimeList then
self.hudClearTimeList={}
self.clearTimeIndex_start=1
self.clearTimeIndex_end=0
end

local stamp=Time.realtimeSinceStartup
local delayDeleteStamp=stamp+delayTime+0.2
self.clearTimeIndex_end=self.clearTimeIndex_end+1
self.hudClearTimeList[self.clearTimeIndex_end]={guid=guid,delayDeleteStamp=delayDeleteStamp}
if self.hudCount<self.maxCount then
self.hudCount=self.hudCount+1
else

local clearData=self.hudClearTimeList[self.clearTimeIndex_start]
if clearData then
local clearGuid=clearData.guid
local hudType=eHudType.eHarm
airHUDSystem:deleteEntityHUDByGuid(self.handle,hudType,clearGuid)
self.hudClearTimeList[self.clearTimeIndex_start]=nil
end
self.clearTimeIndex_start=self.clearTimeIndex_start+1
end
end

function harm:clearAllHud()
local hudType=eHudType.eHarm
if self.hudClearTimeList and next(self.hudClearTimeList)then
for i,clearData in pairs(self.hudClearTimeList)do
local guid=clearData.guid
airHUDSystem:deleteEntityHUDByGuid(self.handle,hudType,guid)
end
end

self.hudClearTimeList=nil
self.clearTimeIndex_start=1
self.clearTimeIndex_end=0
self.hudCount=0
end

function harm:getSortingLayer()
return airConfig.getEntitySortingLayer(eAirEntityType.TYPE_MONSTER)
end