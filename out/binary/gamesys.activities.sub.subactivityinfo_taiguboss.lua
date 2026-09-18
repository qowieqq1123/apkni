









local subActivityInfo_taiguBoss={name='taiguBoss'}

function subActivityInfo_taiguBoss:onInit()


end

function subActivityInfo_taiguBoss:onStart()

end

function subActivityInfo_taiguBoss:onUpdate()

if self.data then

end
end

function subActivityInfo_taiguBoss:onDelete()
if self.taiguBossTimer then
self.taiguBossTimer:cancel()
self.taiguBossTimer=nil
end
end

function subActivityInfo_taiguBoss:checkReddot()
return activitiesHandle_taiguBoss:checkreddotBossAll(self.act_id,SUB_ACTIVITY_TYPE.eTaiGuShiLian,self.sub_act_id)
or activitiesHandle_taiguBoss:checkIsNewBossYeQian(self.act_id,SUB_ACTIVITY_TYPE.eTaiGuShiLian,self.sub_act_id)
or activitiesHandle_taiguBoss:checkIsLastDayBoss(self.act_id,SUB_ACTIVITY_TYPE.eTaiGuShiLian,self.sub_act_id)
end


function subActivityInfo_taiguBoss:checkNewDay()
if self:checkDoing()then
local data=self.data
if data then

end
end
end



function subActivityInfo_taiguBoss:startActTime()
if self.data then
if self.taiguBossTimer then
self.taiguBossTimer:cancel()
self.taiguBossTimer=nil
end
local list=activitiesHandle_taiguBoss:checkbossOpen(self.act_id,SUB_ACTIVITY_TYPE.eTaiGuShiLian,self.sub_act_id)

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
local cfg_bossData=cfg_taigushilianconfig_get(self.sub_act_id).boss
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

if nowstamp>=bossend-timecah then
local flag=userActorSetting.get(FMT.fmt('actid{0}_subid{1}_time{2}_tgsldaojishi',self.act_id,self.sub_act_id,self.start_time),false)
if flag then
local todaybossID=1
local list=activitiesHandle_taiguBoss:checkbossOpen(self.act_id,SUB_ACTIVITY_TYPE.eTaiGuShiLian,self.sub_act_id)
for k,v in ipairs(list)do
if v==1 then
todaybossID=k
end
end
local old=math.abs(flag)
local today=math.abs(todaybossID)
if old==today then
else
old=today
userActorSetting.set(FMT.fmt('actid{0}_subid{1}_time{2}_tgsldaojishi',self.act_id,self.sub_act_id,self.start_time),today)
activitiesModel:callRefreshActEnter(self.act_id,SUB_ACTIVITY_TYPE.eTaiGuShiLian,self.sub_act_id,"onUIEnterBigActivityIconChange",self.act_id)
end
end
local flag2=userActorSetting.get(FMT.fmt('actid{0}_subid{1}_time{2}_tgsldjtwo',self.act_id,self.sub_act_id,self.start_time),false)
if flag2 then
flag2=self.nowbossID
userActorSetting.set(FMT.fmt('actid{0}_subid{1}_time{2}_tgsldjtwo',self.act_id,self.sub_act_id,self.start_time),flag2)
notifySystem:postNotify(notifyConfig.onSubActivityFlagChange,self.act_id,SUB_ACTIVITY_TYPE.eTaiGuShiLian,self.sub_act_id)
end
end


if nowstamp>=bossend then
local list=activitiesHandle_taiguBoss:checkbossOpen(self.act_id,SUB_ACTIVITY_TYPE.eTaiGuShiLian,self.sub_act_id)
for k,v in ipairs(list)do
if v==1 then
self.nowbossID=k
end
if v==2 then
self.endbossID=k
end
end

notifySystem:postNotify(notifyConfig.onSubActivityFlagChange,self.act_id,SUB_ACTIVITY_TYPE.eTaiGuShiLian,self.sub_act_id)
activitiesModel:callRefreshActEnter(self.act_id,SUB_ACTIVITY_TYPE.eTaiGuShiLian,self.sub_act_id,"onUIEnterBigActivityIconChange",self.act_id)
end

end
self.taiguBossTimer=timer.new()
self.taiguBossTimer:start(1,func)

func()
end
end

return subActivityInfo_taiguBoss