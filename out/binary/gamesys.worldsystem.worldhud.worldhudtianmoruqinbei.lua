









worldHUDTianMoRuQinBei=simple_class(worldHUDBase)
worldHUDTianMoRuQinBei.name="worldHUDTianMoRuQinBei"

local _cmp={
this=-1,
root=0,
progressBar=1,
monsterType=2,
timeTx=3,
timeBg=4,
rewardBtn=5,
}

function worldHUDTianMoRuQinBei:onCreate()
self.subType=SUB_ACTIVITY_TYPE.eTianMoRuQin
self.actId=self.data[2]
self.subId=self.data[3]
self.index=self.data[4]
self.subActInfo=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.cmp:SetChildButtonClick(_cmp.rewardBtn,function()
self:onClickRewardBtn()
end)

local entity=worldController:getUnitModelEntity(self.key)
local camera=worldController:getCameraTransform()
if entity and camera then
self.cmp:SetChildFollowPointUI(_cmp.progressBar,camera.gameObject,_cmp.this,entity.transform,Vector3.zero,Vector3.New(0,0,0))
self.cmp:SetChildFollowPointUI(_cmp.monsterType,camera.gameObject,_cmp.this,entity.transform,Vector3.zero,Vector3.New(1.5,2.25,0))
self.cmp:SetChildFollowPointUI(_cmp.timeBg,camera.gameObject,_cmp.this,entity.transform,Vector3.zero,Vector3.New(0,3.5,0))
end

worldHUDBase.onCreate(self)
end

function worldHUDTianMoRuQinBei:onDestory()
self:stopCDTick()
end

function worldHUDTianMoRuQinBei:onUpdate()
local monsterData=self.subActInfo:getMonsterData(self.index)
if monsterData and monsterData.monster>0 then
local nowTime=timeHelper.getServerShortTime()
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterData.monster)
local monType=monsterCfg.monType
local leastTime=nil
self.deadLine=nil
if monsterData.since>0 then
self.deadLine=self.subActInfo:getMonsterDeadTimeEx(monsterData)
leastTime=self.deadLine-nowTime
end
if not leastTime or leastTime>=0 then
local maxBlood=tonumber(tostring(self.subActInfo:getMaxBloods(monType)))
local damageBlood=tonumber(tostring(monsterData.damage))
self.isLive=damageBlood<maxBlood
self.cmp:SetChildActive(_cmp.rewardBtn,not self.isLive and monsterData.fighted>0)
self:refreshCDTick()
if self.isLive then

local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterData.monster)
local monType=monsterCfg.monType



local abName=globalABLookup.global
local assetName=monTypeTag[monType]
if assetName then
self.cmp:SetChildCSImageSprite(_cmp.monsterType,abName,assetName)
else
self.cmp:SetChildIcon(_cmp.monsterType,"",false)
end

local curProgress=(maxBlood-damageBlood)/maxBlood
self.cmp:SetChildActive(_cmp.progressBar,true)
self.cmp:SetChildProgressValue(_cmp.progressBar,math.ceil(curProgress*10000),10000)
self.cmp:SetChildProgressText(_cmp.progressBar,FMT.fmt("{0}%",math.ceil(curProgress*100)))
return
end
else
self:stopCDTick()
end
else
self:stopCDTick()
end
self.cmp:SetChildCSImageIcon(_cmp.monsterType,"",false)
self.cmp:SetChildActive(_cmp.progressBar,false)

end

function worldHUDTianMoRuQinBei:refreshCDTick()
self:updateCDTick()
if self.deadLine and self.deadLine>=timeHelper.getServerShortTime()then
self:startCDTick()
else
self:stopCDTick()
end
end

function worldHUDTianMoRuQinBei:startCDTick()
self.cmp:SetChildActive(_cmp.timeBg,true)
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

function worldHUDTianMoRuQinBei:stopCDTick()
self.cmp:SetChildActive(_cmp.timeBg,false)
if self.cdTick then
self.cdTick:cancel()
self.cdTick=nil
end
end

function worldHUDTianMoRuQinBei:updateCDTick()
local leastStr=""
self.cmp:SetChildActive(_cmp.timeBg,self.deadLine~=nil)
if self.deadLine then
local nowTime=timeHelper.getServerShortTime()
local leastTime=self.deadLine-nowTime
leastTime=math.min(leastTime,self.subActInfo.end_time-nowTime)
if leastTime>=0 then
local content=self.isLive and"{0}后离开"or"{0}后天魔入侵"
leastStr=FMT.fmt(content,timeHelper.format_time_stamp3(leastTime))
else
leastStr="已离开"
end
end
self.cmp:SetChildText(_cmp.timeTx,leastStr)
end

function worldHUDTianMoRuQinBei:onClickRewardBtn()
local monsterData=self.subActInfo:getMonsterData(self.index)
if monsterData and monsterData.monster>0 then
local nowTime=timeHelper.getServerShortTime()
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterData.monster)
local monType=monsterCfg.monType
local leastTime=nil
self.deadLine=nil
if monsterData.since>0 then
self.deadLine=self.subActInfo:getMonsterDeadTimeEx(monsterData)
leastTime=self.deadLine-nowTime
end
if leastTime and leastTime>=0 then
local maxBlood=tonumber(tostring(self.subActInfo:getMaxBloods(monType)))
local damageBlood=tonumber(tostring(monsterData.damage))
local isLive=damageBlood<maxBlood
if not isLive and monsterData.fighted>0 then
call_activitiesHandle_func("activitiesHandle_tianmoruqin","reqMonsterReward",self.actId,self.subId,monsterData.guid)
end
end
end
end