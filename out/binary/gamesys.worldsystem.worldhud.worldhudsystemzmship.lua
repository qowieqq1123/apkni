









worldHUDSystemZMShip=simple_class(worldHUDBase)
worldHUDSystemZMShip.name="worldHUDSystemZMShip"

local _cmp={
text=0,
textBg=1,
}

function worldHUDSystemZMShip:onCreate()
local task=worldTaskModel:getTask(self.data[2])
local serial=task.target_guid
self.infoData=systemZongMenModel:getInfoData(serial)

worldHUDBase.onCreate(self)
end

function worldHUDSystemZMShip:onUpdate()
local teamInfos=systemZongMenModel:findBattleWaitResultBySerial(self.infoData.serial)
if#teamInfos>0 then
self.deadLine=nil
for i,v in ipairs(teamInfos)do
self.deadLine=self.deadLine and math.min(self.deadLine,v.gameStamp)or v.gameStamp
end

self.cmp:SetChildActive(_cmp.textBg,true)
if self:updataCDTick()then
self:startCDTick()
end
else
self.cmp:SetChildActive(_cmp.textBg,false)
self:stopCDTick()
end
end

function worldHUDSystemZMShip:onDestory()
self:stopCDTick()
end

function worldHUDSystemZMShip:startCDTick()
if not self.cdTick then
self.cdTick=timer.new()
self.cdTick:start(1,function()
if not self:updataCDTick()then
self:stopCDTick()
end
end,-1)
end
end

function worldHUDSystemZMShip:stopCDTick()
if self.cdTick then
self.cdTick:cancel()
self.cdTick=nil
end
end

function worldHUDSystemZMShip:updataCDTick()
local nowTime=timeHelper.getServerShortTime()
local deltaTime=self.deadLine-nowTime
if deltaTime>=0 then
self.cmp:SetChildText(_cmp.text,FMT.fmt("<color=#35ba23>{0}</color>后到达",timeHelper.format_time_stamp3(deltaTime)))
return true
else
self.cmp:SetChildActive(_cmp.textBg,false)
return false
end
end