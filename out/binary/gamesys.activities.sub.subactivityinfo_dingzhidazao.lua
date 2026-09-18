









local subActivityInfo_dingzhidazao={name='dingzhidazao'}

function subActivityInfo_dingzhidazao:onInit()

end

function subActivityInfo_dingzhidazao:onStart()
self.data={}
end

function subActivityInfo_dingzhidazao:onUpdate()

end

function subActivityInfo_dingzhidazao:checkReddot()
local stage
local sub_actcfg=self:getSubActConfig()
local stageCfg=sub_actcfg.stage

local level=playerModel:getActorLevel()or 1
if level<sub_actcfg.level then
return false
end

if self.data and self.data.free and self.data.free<1 then
return true
end

for k,v in ipairs(stageCfg)do
if v then
if level>=v[1]and level<=v[2]then
stage=v[3]
break
end
end
end

local costCfg=sub_actcfg.useItem[stage][1]

if costCfg then

local costCount=costCfg[1]
local needCount=costCount[2]
local haveCount=itemsModel.getCount(costCfg[1])

if haveCount>=needCount then
return true
else
return false
end
end

return false
end

function subActivityInfo_dingzhidazao:onDelete()

end

return subActivityInfo_dingzhidazao