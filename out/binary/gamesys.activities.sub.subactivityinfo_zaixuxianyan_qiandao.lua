









local subActivityInfo_zaixuxianyan_qiandao={name='zaixuxianyan_qiandao'}

function subActivityInfo_zaixuxianyan_qiandao:onInit()

end

function subActivityInfo_zaixuxianyan_qiandao:onStart()

end

function subActivityInfo_zaixuxianyan_qiandao:onUpdate()

end

function subActivityInfo_zaixuxianyan_qiandao:onDelete()

end

function subActivityInfo_zaixuxianyan_qiandao:checkReddot()
local day=self:getDayOut()
local flag
if self.data and self.data[1]then
flag=bitHelper.check_pos(self.data[1],day-1)
end
if not flag then
return true
end


return false
end


function subActivityInfo_zaixuxianyan_qiandao:getDayOut()

local start_time=self.start_time-timeHelper.getServerStampPass(self.start_time)
local longTime=timeHelper.getServerShortTime()
local et=longTime-start_time

local day=1
if et<0 then
day=1
else
local cc=math.floor(et/86400)

local DD=cc
day=DD+1
end
return day
end



return subActivityInfo_zaixuxianyan_qiandao