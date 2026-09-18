









local subActivityInfo_xinashiqiandao={name='xinashiqiandao'}

function subActivityInfo_xinashiqiandao:onInit()

end

function subActivityInfo_xinashiqiandao:onStart()

end

function subActivityInfo_xinashiqiandao:onDelete()

end

function subActivityInfo_xinashiqiandao:checkReddot()
local reddot=false
local nowTime=gameUtilityModel.getServerShortTime()
local deltaTime=nowTime-self.start_time
local todayIndex=math.ceil((deltaTime+1)/86400)
if not self.data then

return reddot
end


local config=activitiesModel:getSubActivityConfig(self.sub_act_type,self.sub_act_id)
local allDayCount=#config.rewards
if todayIndex<=allDayCount then

local gotList=self.data.dayInfo
if gotList and next(gotList)then
if not gotList[todayIndex]then
reddot=true
end
else

reddot=true
end
else

reddot=false
end

return reddot
end

return subActivityInfo_xinashiqiandao