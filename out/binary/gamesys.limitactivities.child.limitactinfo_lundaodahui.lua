









local limitActInfo_lundaodahui={name='lundaodahui'}


function limitActInfo_lundaodahui:onInit()

end


function limitActInfo_lundaodahui:onStart()

end


function limitActInfo_lundaodahui:onUpdate()

end


function limitActInfo_lundaodahui:onDelete()

end


function limitActInfo_lundaodahui:checkReddot()
return false
end


function limitActInfo_lundaodahui:jump(params)
local jumpParams={
id=4601,
args=params
}
jumpManager:jump(jumpParams,nil,JUMP_BACK.eNoBack)
end

function limitActInfo_lundaodahui:checkJump_data(isWarning)
if lundaodahuiModel:isOpened()then
return true
end
return true
end






































function limitActInfo_lundaodahui:checkOpen(isWarning)
if isWarning then
self.isopen=self:checkCondition(true)
local rCLimit=lundaodahuiModel:getRCLimit()
local startTime=lundaodahuiModel.data.startTime
if startTime and startTime>0 then
if not lundaodahuiModel:checkLocalOpenDay()then
if startTime>=rCLimit then
lundaodahuiModel:checkUnlockEx(isWarning)
return false
else
local now=timeHelper.getServerLongTime()
local lundaodahuiTime=cfgHelper.get(cfg_dftlundaodahuibasicconfig_get,1,"actTime")
if now>=startTime+lundaodahuiTime then
lundaodahuiModel:checkUnlockEx(isWarning)
return false
end
end
end
end


end
return self.isopen
end

return limitActInfo_lundaodahui