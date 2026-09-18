









local subActivityInfo_liangouhaoliRole={name='subActivityInfo_liangouhaoliRole'}

function subActivityInfo_liangouhaoliRole:onInit()

end

function subActivityInfo_liangouhaoliRole:onStart()

end

function subActivityInfo_liangouhaoliRole:onDelete()

end

function subActivityInfo_liangouhaoliRole:checkReddot()
if self:hasData()then
local flag=self.data.flag
if not mathHelper.getBitValue(flag,0)then
local rewards=self:getSubActConfig("rewards")
local cnt=mathHelper.cntbit(flag,1,#rewards)
if cnt>=#rewards then
return true
end
end
local now=timeHelper.getServerShortTime()
return now>self.data.dailySec and not timeHelper.checkInSameDay2(self.data.dailySec,now)
end
return false
end

function subActivityInfo_liangouhaoliRole:checkNewDay()
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
end

function subActivityInfo_liangouhaoliRole:getStartDay()
local now_time=timeHelper.getServerLongTime()
local start_time=timeHelper.getServerZeroStamp(self.start_time_l)
return math.ceil((now_time-start_time)/86400)
end

return subActivityInfo_liangouhaoliRole