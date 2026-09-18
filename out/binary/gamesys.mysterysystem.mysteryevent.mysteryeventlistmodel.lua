






local _MODULENAME="MysteryEventListModel"


def_table(_MODULENAME)
MysteryEventListModel.name=_MODULENAME

MysteryEventListModel.data={}

function MysteryEventListModel:on_app_start()

end


function MysteryEventListModel:on_enter_state()
self.data={}
self.data.eventGuidList={}
self.data.signDataList={}
end


function MysteryEventListModel:on_leave_state()

self.data={}
end






function MysteryEventListModel:init_event_list(sysId,qiyuList)
self.data.eventGuidList[sysId]={}
self.data.signDataList[sysId]={}
if qiyuList then
for i,v in ipairs(qiyuList)do
self.data.eventGuidList[sysId][tostring(v.guid)]=v
MysteryEventModel:set_dice_max_count(v.guid,v.diceNum)
self:signData(sysId,v)

if sysId==SYSTEM_DEFINE.eTuFaEvent then
emergenciesModel:setAdventureId(v.otherData.idx,v.guid,v.eventGroupId)
end
end

end
end

function MysteryEventListModel:signData(sysId,qiyuItem)
if qiyuItem.otherData and qiyuItem.otherData.dynamicType then
local func=MysteryEventRecv.getHandle(qiyuItem.otherData.dynamicType)
if func then
local data=func(qiyuItem.otherData)
local temp={}
for i,v in ipairs(data)do
table.insert(temp,tostring(v))
end
local str=table.concat(temp,"_")
self.data.signDataList[sysId][str]=qiyuItem.guid
end
end
end

function MysteryEventListModel:unsignData(sysId,qiyuItem)
if qiyuItem.otherData and qiyuItem.otherData.dynamicType then
local func=MysteryEventRecv.getHandle(qiyuItem.otherData.dynamicType)
if func then
local data=func(qiyuItem.otherData)
local temp={}
for i,v in ipairs(data)do
table.insert(temp,tostring(v))
end
local str=table.concat(temp,"_")
self.data.signDataList[sysId][str]=nil
end
end
end

function MysteryEventListModel:add_event(sysId,qiyuItem)
self.data.eventGuidList[sysId]=self.data.eventGuidList[sysId]or{}
self.data.signDataList[sysId]=self.data.signDataList[sysId]or{}
self.data.eventGuidList[sysId][tostring(qiyuItem.guid)]=qiyuItem
self:signData(sysId,qiyuItem)
MysteryEventModel:set_dice_max_count(qiyuItem.guid,qiyuItem.diceNum)
end

function MysteryEventListModel:remove_event(guid)
guid=tostring(guid)
if self.data.eventGuidList then
for sysId,v in pairs(self.data.eventGuidList)do
if v[guid]then
self:unsignData(sysId,v[guid])
v[guid]=nil
end
end
end
MysteryEventModel:set_dice_max_count(guid,nil)
end



function MysteryEventListModel:get_event_by_signData(sysId,signData)
if signData then
local temp={}
for i,v in ipairs(signData)do
table.insert(temp,tostring(v))
end
local str=table.concat(temp,"_")
self.data.signDataList[sysId]=self.data.signDataList[sysId]or{}
local guid=self.data.signDataList[sysId][str]
if guid then
return self:get_event_by_guid(sysId,guid)
end
end
end

function MysteryEventListModel:get_event_by_guid(sysId,guid)
guid=tostring(guid)
self.data.eventGuidList[sysId]=self.data.eventGuidList[sysId]or{}
return self.data.eventGuidList[sysId][guid]
end

function MysteryEventListModel:get_event(guid)
guid=tostring(guid)
for sysId,v in pairs(self.data.eventGuidList)do
if v[guid]then
return v[guid],sysId
end
end
end

function MysteryEventListModel:get_eventList_by_sys(sysId)
return self.data.eventGuidList[sysId]
end


function MysteryEventListModel:update_event(sysId,guid,nextGroupId)
local eventData=MysteryEventListModel:get_event_by_guid(sysId,guid)
if eventData then
eventData.eventGroupId=nextGroupId
eventData.choiceId=0
eventData.resultConf=0
eventData.resultIndex=0
end
end

