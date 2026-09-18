









local subActivityInfo_gongfagain={name='subActivityInfo_gongfagain'}

function subActivityInfo_gongfagain:onInit()
self:listenNotify(notifyConfig.onNewDay,function(...)
self:on_new_day(...)
end)
end

function subActivityInfo_gongfagain:onStart()

end

function subActivityInfo_gongfagain:onDelete()

end

function subActivityInfo_gongfagain:checkReddot()
if self:hasData()then
local data=self:getData()
if data.dailySec<=0 or not timeHelper.isTodayShort(data.dailySec)then
return true
end
local config=self:getSubActConfig()
if data.rewardFlag==0 and tonumber(tostring(data.taskProgress))>=config.aim then
return true
end
end
return false
end

function subActivityInfo_gongfagain:on_new_day(...)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
end

return subActivityInfo_gongfagain