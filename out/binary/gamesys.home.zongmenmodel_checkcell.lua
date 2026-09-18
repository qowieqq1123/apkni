local _checkRecord={}

function zongmenModel:markRecord(callback)
table.insert(_checkRecord,callback)
end

function zongmenModel:handleRecord(abandon)
local record=table.remove(_checkRecord,1)
if not abandon then
if record then
record()
else
loggerUtil.logErrFMT("没有对应格子检查完成处理")
end
end
end