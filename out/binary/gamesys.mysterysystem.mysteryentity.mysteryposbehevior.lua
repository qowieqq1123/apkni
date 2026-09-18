







mysteryPosBehevior=mysteryEntityBase.new(eMysteryEntityType.eBehaviorEnt,{})

mysteryPosBehevior.entityType=eMysteryEntityType.eBehaviorEnt


local guidIdx=-1001

function mysteryPosBehevior:init_data()

end


function mysteryPosBehevior:create_entity(entityType,posList,roomId,data)
self.entityList=self.entityList or{}

guidIdx=guidIdx-1
local guid=guidIdx

local ent={
entityType=entityType,
guid=guid,
pos=posList[1],
posList=posList,
roomId=roomId,
data=data or{},
notUseRemoveBehavior=false,
}
self.entityList[guid]=ent

local entitylua=entity()
entitylua.guid=guid
self.entityList[guid].entitylua=entitylua
if not self.useTree then
self.useTree=true
self:startUpdateTimer()
end
return guid
end

function mysteryPosBehevior:runBehaviorByPos(posList,btName,_onBahaviroEvent)
local roomId=mysteryRoomModel:get_cur_roomID()
local guid=self:create_entity(eMysteryEntityType.eBehaviorEnt,posList,roomId)

self:runBehavior(guid,btName,function()
if _onBahaviroEvent then _onBahaviroEvent()end
self.entityList[guid]=nil
end)
return guid
end

