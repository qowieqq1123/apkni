









local subActivityInfo_shizhuangchoujian={name='shizhuangchoujian'}

function subActivityInfo_shizhuangchoujian:onInit()


end

function subActivityInfo_shizhuangchoujian:onStart()

end

function subActivityInfo_shizhuangchoujian:onUpdate()

end

function subActivityInfo_shizhuangchoujian:onDelete()





end

function subActivityInfo_shizhuangchoujian:checkReddot()
return activitiesHandle_shizhuangchoujian.checkreddot(self.act_id,self.sub_act_id)
end


function subActivityInfo_shizhuangchoujian:checkNewDay()
if self:checkDoing()then
local data=self.data
if data then



if self.data.free_sec and not timeHelper.isTodayStamp(timeHelper.convertLongStamp(self.data.free_sec))then
self.data.free_sec=0
self.data.use_free_times=0
end
UIManager:invokeUIMethod('UISubAct_shizhuanchoujianWin','rec_newday')
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
end
end
end


return subActivityInfo_shizhuangchoujian