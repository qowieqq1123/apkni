









local subActivityInfo_tujiantezhi={name='tujiantezhi'}

function subActivityInfo_tujiantezhi:onInit()

end

function subActivityInfo_tujiantezhi:onStart()

end

function subActivityInfo_tujiantezhi:on_money_changed(moneyType,lastVal,val)

end

function subActivityInfo_tujiantezhi:on_item_changed(changeType,itemguid,itemid,oldcount,newcount)

end

function subActivityInfo_tujiantezhi:onUpdate()

end

function subActivityInfo_tujiantezhi:onDelete()

end

function subActivityInfo_tujiantezhi:checkReddot()
local data=self.data
if data then

local sub_actcfg=self:getSubActConfig()
if sub_actcfg then
local select_max=sub_actcfg.select_num
local selectSpeciality=data.selectSpeciality
local num=0
for k,v in pairs(selectSpeciality)do
num=num+1
end
if num>=select_max then
return false
else
return true
end
end
end
return false
end


function subActivityInfo_tujiantezhi:checkNewDay()
if self:checkDoing()then
local data=self.data
if data then

end
end
end

return subActivityInfo_tujiantezhi