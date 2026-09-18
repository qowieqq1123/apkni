









local subActivityInfo_tujiandizi={name='tujiandizi'}

function subActivityInfo_tujiandizi:onInit()

end

function subActivityInfo_tujiandizi:onStart()

end

function subActivityInfo_tujiandizi:on_money_changed(moneyType,lastVal,val)

end

function subActivityInfo_tujiandizi:on_item_changed(changeType,itemguid,itemid,oldcount,newcount)

end

function subActivityInfo_tujiandizi:onUpdate()

end

function subActivityInfo_tujiandizi:onDelete()

end

function subActivityInfo_tujiandizi:checkReddot()
local data=self.data
if data then

local sub_actcfg=self:getSubActConfig()
if sub_actcfg then
local select_max=sub_actcfg.select_num
local selectDisciple=data.selectDisciple
local num=0
for k,v in pairs(selectDisciple)do
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


function subActivityInfo_tujiandizi:checkNewDay()
if self:checkDoing()then
local data=self.data
if data then

end
end
end



return subActivityInfo_tujiandizi