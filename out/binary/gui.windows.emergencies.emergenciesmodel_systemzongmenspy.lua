function emergenciesModel:setEventHandData_SystemZongMenSpy(eventId,time,cfg,eventData)

end

function emergenciesModel:refreshEvent_SystemZongMenSpy()

end

function emergenciesModel:ZongMenSpyEventDataChangeByIndex(index)
local EventData=emergenciesModel:getEventData()
if EventData and EventData[index]then
EventData[index].param_1=1
emergenciesControl:removeZongMenSpyByIndex(index)
end
end

function emergenciesModel:ZongMenSpyEventDataCurCount()
local EventData=emergenciesModel:getEventData()
local curCount=0
if EventData then
for i,v in ipairs(EventData)do
if v.param_1==0 then
curCount=curCount+1
end
end
end
return curCount
end