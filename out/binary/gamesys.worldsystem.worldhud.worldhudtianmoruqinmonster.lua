









worldHUDTianMoRuQinMonster=simple_class(worldHUDBase)
worldHUDTianMoRuQinMonster.name="worldHUDTianMoRuQinMonster"

local _cmp={
timeTx=0,
timeBg=1,
}

function worldHUDTianMoRuQinMonster:onCreate()
self.subType=SUB_ACTIVITY_TYPE.eTianMoRuQin
self.actId=self.data[2]
self.subId=self.data[3]
self.guid=self.data[4]
self.subActInfo=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.cmp:SetChildButtonClick(_cmp.timeBg,function()
worldController.onClickUnit(self.data)
end)
worldHUDBase.onCreate(self)
end

function worldHUDTianMoRuQinMonster:onUpdate()
self.deadLine=nil
local exMonster,monsterIdx,eventIdx=self.subActInfo:getExMonster(self.guid)
if exMonster and self.config.aim[eventIdx][4]then
self.deadLine=exMonster.sec+self.config.aim[eventIdx][4]
end
self:refreshCDTick()
end

function worldHUDTianMoRuQinMonster:onDestory()
self:stopCDTick()
end

function worldHUDTianMoRuQinMonster:refreshCDTick()
self:updateCDTick()
if self.deadLine and self.deadLine>=timeHelper.getServerShortTime()then
self:startCDTick()
else
self:stopCDTick()
end
end

function worldHUDTianMoRuQinMonster:startCDTick()
if not self.cdTick then
self.cdTick=timer.new()
self.cdTick:start(1,function()
self:updateCDTick()
if not self.deadLine or self.deadLine<timeHelper.getServerShortTime()then
self:stopCDTick()
end
end)
end
end

function worldHUDTianMoRuQinMonster:stopCDTick()
if self.cdTick then
self.cdTick:cancel()
self.cdTick=nil
end
end

function worldHUDTianMoRuQinMonster:updateCDTick()
local leastStr=""
self.cmp:SetChildActive(_cmp.timeBg,self.deadLine~=nil)
if self.deadLine then
local nowTime=timeHelper.getServerShortTime()
local leastTime=self.deadLine-nowTime
leastTime=math.min(leastTime,self.subActInfo.end_time-nowTime)
if leastTime>=0 then
leastStr=timeHelper.format_time_stamp3(leastTime)
else
leastStr="已离开"
end
end
self.cmp:SetChildText(_cmp.timeTx,leastStr)
end