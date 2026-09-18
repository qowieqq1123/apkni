
local limitActInfo_wendingcangqiong={name='wendingcangqiong'}


function limitActInfo_wendingcangqiong:onInit()

end


function limitActInfo_wendingcangqiong:onStart()

end


function limitActInfo_wendingcangqiong:onUpdate()

end


function limitActInfo_wendingcangqiong:onDelete()

end


function limitActInfo_wendingcangqiong:checkReddot()
return false
end


function limitActInfo_wendingcangqiong:jump(extraParams)
local info={id=JUMP_TYPE.eWDCangQiong}
if extraParams then
info.args=extraParams
end

jumpManager:jump(info,nil,JUMP_BACK.eNoBack)

end

function limitActInfo_wendingcangqiong:checkOpen(isWarning)
if isWarning then
local dayCond,lerpDay=limitActivitiesModel:checkDayCondition(self.actID)
if dayCond then
self.isopen=self:checkCondition(true)
else
UIManager.error(FMT.fmt('{0}天后可参与',lerpDay))
self.isopen=false
end
end
return self.isopen
end

function limitActInfo_wendingcangqiong:checkJump_time(isWarning)
return true
end

function limitActInfo_wendingcangqiong:checkJump_data(isWarning)



return true
end


return limitActInfo_wendingcangqiong