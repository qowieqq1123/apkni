









local subActivityInfo_lianqidahui={name='lianqidahui'}

function subActivityInfo_lianqidahui:onInit()

end

function subActivityInfo_lianqidahui:onStart()

end

function subActivityInfo_lianqidahui:onDelete()

end

function subActivityInfo_lianqidahui:checkReddot()
if not self.data then
return false
end

if self:checkCanPlayReddot()then
return true
end

if self:checkChengJiuReddot()then
return true
end

return false
end

function subActivityInfo_lianqidahui:checkCanPlayReddot()
if not self.isInSettlementTime then
local cfg=cfgHelper.get1(cfg_artifactrefineconfig_get,self.sub_act_id)
local earlyEndTime=cfg.earlyEndTime or 0
local dt=self.end_time-gameUtilityModel.getServerShortTime()
if dt<=earlyEndTime then
self.isInSettlementTime=true
return false
end
else
return false
end

if not self.data.gridList then
local cfg=cfgHelper.get1(cfg_artifactrefineconfig_get,self.sub_act_id)
local have=itemsModel.getCount(cfg.moveCost[1])
return have>=cfg.moveCost[2]
end

return false
end

function subActivityInfo_lianqidahui:checkChengJiuReddot()
local taskData=self.data.taskData
if taskData then
for k,v in pairs(taskData)do
if v.flag==2 then
return true
end
end
end

return false
end

function subActivityInfo_lianqidahui:getExchangeList()
local cfg=cfgHelper.get1(cfg_artifactrefineconfig_get,self.sub_act_id)
local list={}
for i,v in ipairs(cfg.auto)do
local have=itemsModel.getCount(v[1])
if have>v[2]then
table.insert(list,v)
end
end
return list
end

return subActivityInfo_lianqidahui