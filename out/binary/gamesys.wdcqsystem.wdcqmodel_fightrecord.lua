local _recordData=nil
local _saveKey="WDCQFightRecordData"

local corverKey=function(...)
return table.concat({...},"_")
end

function WDCQModel:resetFightRecord()
_recordData=nil
end

function WDCQModel:loadFightRecord()
if _recordData==nil then
_recordData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eWenDingCangQiong,_saveKey,{})
end
local startTime=WDCQController.getGameStartTime()
local endTime=WDCQController.getGameEndTime()
if next(_recordData)==nil or _recordData.startTime~=startTime or _recordData.endTime~=endTime then
_recordData.startTime=startTime
_recordData.endTime=endTime
_recordData.datas={}
self:saveFightRecord()
end
end

function WDCQModel:markFightRecord(group,phase,order)
local key=corverKey(group,phase,order)
_recordData.datas[key]=true
self:saveFightRecord()
end

function WDCQModel:saveFightRecord()
userActorArraySetting.set(ACTOR_SETTING_TYPE.eWenDingCangQiong,_saveKey,_recordData)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eWenDingCangQiong)
end

function WDCQModel:haveFightRecord(group,phase,order)
local key=corverKey(group,phase,order)
return _recordData.datas[key]or false
end