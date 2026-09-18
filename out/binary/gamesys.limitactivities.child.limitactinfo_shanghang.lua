
local limitActInfo_shanghang={name='lingzhenpengzhuang'}


function limitActInfo_shanghang:onInit()

end


function limitActInfo_shanghang:onStart()
if self:checkOpen()and not self:checkIdle()then
self:get_gupiao_info()
end
end


function limitActInfo_shanghang:onUpdate()


local longNow=timeHelper.getServerLongTime()
local eveTime=shangHangModel:getEveEndTime()

if eveTime~=0 then
if longNow==eveTime then
self:get_gupiao_info()
return
end
end




if shangHangModel:isWeekClose()then
return
end


local beginTime=shangHangModel:getMonBeginTime()

if beginTime==longNow then

end

if beginTime+5==longNow then
self:get_gupiao_info()
return
end
local beginEveTime=shangHangModel:getEveBeginTime()
if beginEveTime+5==longNow then
self:get_gupiao_info()
return
end

local zero=timeHelper.getTodayZeroStamp()
local change_time=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"stock_price_change_time")
local changeStamp
for i,v in ipairs(change_time)do
changeStamp=zero+v[1]*3600+v[2]*60+v[3]+5
if changeStamp==longNow then
self:get_gupiao_info()
return
end
end
end


function limitActInfo_shanghang:onDelete()

end


function limitActInfo_shanghang:checkReddot()
return false
end


function limitActInfo_shanghang:jump()
jumpManager:jump({id=JUMP_TYPE.eLingZhenPengZhuang},nil,JUMP_BACK.eNoBack)
end

function limitActInfo_shanghang:checkJump_time(isWarning)
return true
end

function limitActInfo_shanghang:checkJump_data(isWarning)
return true
end

function limitActInfo_shanghang:get_gupiao_info()
socketManager:send_248_91()
socketManager:send_248_92()
socketManager:send_248_93()
end

return limitActInfo_shanghang