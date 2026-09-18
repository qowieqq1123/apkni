









local subActivityInfo_xianjutehui={name='xianjutehui'}

function subActivityInfo_xianjutehui:onInit()

end

function subActivityInfo_xianjutehui:onStart()

end

function subActivityInfo_xianjutehui:onUpdate()

end

function subActivityInfo_xianjutehui:onDelete()

end

function subActivityInfo_xianjutehui:checkReddot()
local data=self.data
if data then
local sub_actcfg=self:getSubActConfig()
return data.ex==0
end
return false
end

return subActivityInfo_xianjutehui