









local subActivityInfo_fuyaoBoss={name='fuyaoBoss'}

function subActivityInfo_fuyaoBoss:onInit()


end

function subActivityInfo_fuyaoBoss:onStart()

end

function subActivityInfo_fuyaoBoss:onUpdate()

if self.data then

end
end

function subActivityInfo_fuyaoBoss:onDelete()
if self.taiguBossTimer then
self.taiguBossTimer:cancel()
self.taiguBossTimer=nil
end
end

function subActivityInfo_fuyaoBoss:checkReddot()
return activitiesHandle_fuyaoBoss:checkreddotBossAll(self.act_id,SUB_ACTIVITY_TYPE.eFuYaoShiLian,self.sub_act_id)
or activitiesHandle_fuyaoBoss:checkIsNewBossYeQian(self.act_id,SUB_ACTIVITY_TYPE.eFuYaoShiLian,self.sub_act_id)
or activitiesHandle_fuyaoBoss:checkIsLastDayBoss(self.act_id,SUB_ACTIVITY_TYPE.eFuYaoShiLian,self.sub_act_id)
end


function subActivityInfo_fuyaoBoss:checkNewDay()
if self:checkDoing()then
local data=self.data
if data then

end
end
end



function subActivityInfo_fuyaoBoss:startActTime()
if self.data then
if self.taiguBossTimer then
self.taiguBossTimer:cancel()
self.taiguBossTimer=nil
end
local list=activitiesHandle_fuyaoBoss:checkbossOpen(self.act_id,SUB_ACTIVITY_TYPE.eFuYaoShiLian,self.sub_act_id)

self.nowbossID=1
self.endbossID=0
for k,v in ipairs(list)do
if v==1 then
self.nowbossID=k
end
if v==2 then
self.endbossID=k
end
end

local func
func=function()
local cfg_bossData=cfg_fuyaoshilianconfig_get(self.sub_act_id).boss
local boss_config_single=cfg_bossData[self.nowbossID]
local nowstamp=timeHelper.getServerShortTime()
local bossstart=boss_config_single[2]+self.start_time
local bossend=boss_config_single[3]+self.start_time
local timecah=5*3600

if self.endbossID==#cfg_bossData then
if self.taiguBossTimer then
self.taiguBossTimer:cancel()
self.taiguBossTimer=nil
end
end


if nowstamp>=bossend then
local list=activitiesHandle_fuyaoBoss:checkbossOpen(self.act_id,SUB_ACTIVITY_TYPE.eFuYaoShiLian,self.sub_act_id)
for k,v in ipairs(list)do
if v==1 then
self.nowbossID=k
end
if v==2 then
self.endbossID=k
end
end


activitiesModel:callRefreshActEnter(self.act_id,SUB_ACTIVITY_TYPE.eFuYaoShiLian,self.sub_act_id,"onUIEnterBigActivityIconChange",self.act_id)
end

end
self.taiguBossTimer=timer.new()
self.taiguBossTimer:start(1,func)

func()
end
end

return subActivityInfo_fuyaoBoss