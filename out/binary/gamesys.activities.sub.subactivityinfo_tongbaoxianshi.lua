









local subActivityInfo_tongbaoxianshi={name='tongbaoxianshi'}

function subActivityInfo_tongbaoxianshi:onInit()

end

function subActivityInfo_tongbaoxianshi:onStart()

end

function subActivityInfo_tongbaoxianshi:onDelete()

end

function subActivityInfo_tongbaoxianshi:onUpdate()
if self.data then
self.reqTime=self.reqTime or 60
self.reqTime=self.reqTime+1
if self.reqTime>=60 then

if not self.lockList then
self.lockList={}
local dhList=self:getSubActConfig('dhList')
for i,v in ipairs(dhList)do
local dhConfig=cfgHelper.get(cfg_tongbaoxianshiduihuanconfig_get,v)
local startTime=dhConfig.startTime
if startTime then
self.lockList[v]=startTime
end
end
end
local start_time=self.start_time
local time=timeHelper.getServerShortTime()
for id,startTime in pairs(self.lockList)do
local endTime=startTime+start_time
local leftTime=endTime-time
local unlock=leftTime<=0
if unlock then
self.data.unlockReddot=true
self.lockList[id]=nil
end
end

self.reqTime=0
end
end
end


function subActivityInfo_tongbaoxianshi:checkNewDay()
if not self.data then
return
end

local exchangeList=self.data.exchangeList or{}
for id,v in pairs(exchangeList)do
local cfg=cfgHelper.get(cfg_tongbaoxianshiduihuanconfig_get,id,"dayReset")
if cfg then
exchangeList[id]=0
end
end
self.data.exchangeList=exchangeList
UIManager:invokeUIMethod("UISubAct_tongbaoxianshi_Win","refresh")
end

function subActivityInfo_tongbaoxianshi:checkReddot()
if not self.data then
return false
end


if self.data.unlockReddot then
return true
end

local selectFangAnList=self.data.selectFangAn or{}
local exchangeList=self.data.exchangeList or{}

local time=timeHelper.getServerShortTime()
local start_time=self.start_time
for id,index in pairs(selectFangAnList)do
local dhConfig=cfgHelper.get(cfg_tongbaoxianshiduihuanconfig_get,id)
local enough=true
local startTime=dhConfig.startTime
local unlock=true
if startTime then
local endTime=startTime+start_time
local leftTime=endTime-time
unlock=leftTime<=0
end
local dhCount=dhConfig.dhCount or-1
local exchange=exchangeList[id]or 0
if unlock and((dhCount>0 and dhCount-exchange>0)or dhCount<0)then
local fangAnList=dhConfig.fangAn
local fangAn=fangAnList[index]
if fangAn then
for i,v in ipairs(fangAn)do
local have=itemsModel.getCount(v[1])
if have<v[2]then
enough=false
break
end
end
end
else
enough=false
end
if enough then
return true
end
end

return false
end

return subActivityInfo_tongbaoxianshi