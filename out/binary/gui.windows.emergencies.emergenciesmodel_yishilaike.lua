local max=nil
local npcId=nil
local adventureIdList={}

function emergenciesModel:setMaxCount(num)
max=num
end

function emergenciesModel:getMaxCount()
return max
end

function emergenciesModel:setClickNpcId(id)
npcId=id
end

function emergenciesModel:getClickNpcId()
return npcId
end

function emergenciesModel:setAdventureId(npcId,event_guid,event_group_id)
if not adventureIdList then adventureIdList={}end
local index=tostring(npcId)
adventureIdList[index]={event_guid=event_guid,event_group_id=event_group_id}

end

function emergenciesModel:getAdventureId(npcId)
local index=tostring(npcId)
if adventureIdList then
if adventureIdList[index]then
return adventureIdList[index]
end
end
return false
end

function emergenciesModel:closeAdventureEventWin()
if UIManager:isActive("UIMysteryEventWin")then
UIMysteryEventWin:onCloseClick()
end
end

function emergenciesModel:clearData()

max=nil
npcId=nil
adventureIdList=nil
end

function emergenciesModel:clearAdventureDataByGuild(guid)
if not adventureIdList then return end
for k,v in pairs(adventureIdList)do
if guid==v.event_guid then
adventureIdList[k]=nil
if adventureIdList then

end
end
end
end