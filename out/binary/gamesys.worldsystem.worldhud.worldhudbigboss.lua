









worldHUDBigBoss=simple_class(worldHUDBase)
worldHUDBigBoss.name="worldHUDBigBoss"

function worldHUDBigBoss:onCreate()
local actId=LIMIT_ACT_TYPE.eShiJieShouLing
local check=limitActivitiesModel:checkActDoing(actId)
if check then
local actInfo=limitActivitiesModel:getActInfo(actId)
local curTime=gameUtilityModel.getServerShortTime()
local least=actInfo.end_time-curTime
local duration=actInfo.end_time-actInfo.start_time
self.cmp:SetProgressBarAniWithThreeParams(0,least,duration,0)
self.cmp:SetProgressBarAniUpdateAction(0,function(x,y)
local rate=math.ceil(x*100)
self.cmp:SetChildText(1,FMT.fmt('{0}%',rate))
end)
self.cmp:SetProgressBarAniWithThreeParams(0,0,duration,least)
end
worldHUDBase.onCreate(self)
end