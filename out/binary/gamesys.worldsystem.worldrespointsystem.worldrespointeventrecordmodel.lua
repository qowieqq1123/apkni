






local _MODULENAME="worldResPointEventRecordModel"




def_table(_MODULENAME)
worldResPointEventRecordModel.name=_MODULENAME

worldResPointEventRecordModel.data={}











local selection={}

local tempEvent=nil


function worldResPointEventRecordModel:onAppStart()

end


function worldResPointEventRecordModel:onEnterState()

end


function worldResPointEventRecordModel:onLeaveState()

self:clearAllData()
end


function worldResPointEventRecordModel:onServerDataInitFinish()

end

function worldResPointEventRecordModel:clearAllData()
selection={}
tempEvent=nil
end



function worldResPointEventRecordModel:serializeData()
local serializeResult={}
for i,v in pairs(selection)do
table.insert(serializeResult,i)
table.insert(serializeResult,v.group)
table.insert(serializeResult,v.option)
table.insert(serializeResult,v.subIndex)
table.insert(serializeResult,v.result)
table.insert(serializeResult,v.after)
end
return serializeResult
end



function worldResPointEventRecordModel:deserializeData(array)
selection={}
local count=#array
for i=1,count,6 do
local guid=array[i]
local groupId=array[i+1]
local optionId=array[i+2]
local subIndex=array[i+3]
local result=array[i+4]
local after=array[i+5]
self:setEventSelection(guid,{group=groupId,option=optionId,subIndex=subIndex,result=result,after=after})
end
end



function worldResPointEventRecordModel:setEventGUID(guid)
tempEvent=guid
end



function worldResPointEventRecordModel:getEventGUID()
return tempEvent
end




function worldResPointEventRecordModel:setEventSelection(guid,selectionData)
selection[guid]=selectionData
end




function worldResPointEventRecordModel:getEventSelection(guid)
return selection[guid]
end




function worldResPointEventRecordModel:startEventSelection(guid,group)
local selection=self:getEventSelection(guid)
if selection then
selection.group=group
else
selection={}
selection.group=group
selection.option=0
selection.subIndex=0
selection.result=1
selection.after=0
self:setEventSelection(guid,selection)
end
end







function worldResPointEventRecordModel:markEventSelection(guid,group,optionId,subIndex,result)
local selection=self:getEventSelection(guid)
if selection then
selection.group=group
selection.option=optionId
selection.subIndex=subIndex
selection.result=result
else
selection={}
selection.group=group
selection.option=optionId
selection.subIndex=subIndex
selection.result=result
selection.after=0
self:setEventSelection(guid,selection)
end
end




function worldResPointEventRecordModel:setEventSelectionAfter(guid,after)
local selection=self:getEventSelection(guid)
if selection then
selection.after=after
else
selection={}
selection.group=0
selection.option=0
selection.subIndex=0
selection.result=1
selection.after=after
self:setEventSelection(guid,selection)
end
end




function worldResPointEventRecordModel:getEventSelectionAfter(guid)
local selection=self:getEventSelection(guid)
return selection and selection.after or 0
end