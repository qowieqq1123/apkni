









local subActivityInfo_tianshuxiuxing={name='tianshuxiuxing'}

function subActivityInfo_tianshuxiuxing:onInit()

end

function subActivityInfo_tianshuxiuxing:onStart()

end

function subActivityInfo_tianshuxiuxing:onUpdate()

end

function subActivityInfo_tianshuxiuxing:onDelete()

end

function subActivityInfo_tianshuxiuxing:checkReddot()
local data=self.data
if data then

local finishNum=0
for k,taskData in pairs(data.taskLookup)do
if activitiesHandle_tianshuxiuxing.checkTaskReward(taskData)then
return true
end
finishNum=finishNum+taskData.rewardIndex
end

local sub_actcfg=self:getSubActConfig()
local target=sub_actcfg.target
local max=#target
local targetidx=data.targetidx
local total=finishNum
for i=1,max do
local d=target[i]
local num=d[1]
local reward=d[2][1]
local fix=total>=num
local rewardFlag=i<=targetidx
if fix and not rewardFlag then
return true
end
end
end
return false
end

return subActivityInfo_tianshuxiuxing