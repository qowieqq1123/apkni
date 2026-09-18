







mysteryTriggerPointModel=mysteryEntityBase.new(eMysteryEntityType.eTriggerPoint,{})

mysteryTriggerPointModel.entityType=eMysteryEntityType.eTriggerPoint


mysteryTriggerPointModel.AllIdConditionType=
{
haveEntityIdActived=3,
}



function mysteryTriggerPointModel:get_config(id)
local config=cfgHelper.get(cfg_ssentitytutengconfig_get,id)
return config
end

function mysteryTriggerPointModel:have_collider(id)
local config=mysteryTriggerPointModel:get_config(id)
if config then
return config.collider
end
end

function mysteryTriggerPointModel:have_collider_ent(ent)
local status=ent.data.status
local id=ent.id
local config=mysteryTriggerPointModel:get_config(id)
if config then
if(config.hide and status>=config.hide)then
return false
end
local collider=config.collider

if collider then
if#collider==1 then
return collider[1]==1
else
return collider[status+1]==1
end
end
end
return false
end

function mysteryTriggerPointModel:isClick(id)
local config=mysteryTriggerPointModel:get_config(id)
if config then
return config.click
end
end

function mysteryTriggerPointModel:get_state_condition(id)
local config=mysteryTriggerPointModel:get_config(id)
if config then
return config.setStateCondition
end
end


function mysteryTriggerPointModel:get_care_config(id)
local config=mysteryTriggerPointModel:get_config(id)
if config then
return config.careId
end
end


function mysteryTriggerPointModel:get_statistics(id)
return MysteryModel:get_fake_item_count(id)
end


function mysteryTriggerPointModel:checkCondition(id,curStatus,originEntity)
local conditionList=mysteryTriggerPointModel:get_state_condition(id)
if not conditionList then
return true
end
curStatus=curStatus or 0
local index=curStatus+1
local condition=conditionList[index]
if not condition then
return false
end
local cType=condition[1]
local data=condition[2]
local check=false
if cType==1 then
check=true
for i,pos in ipairs(data)do
local entity=mysteryTriggerPointModel:get_entity_by_pos(Vector3(pos[1],pos[2],0),mysteryRoomModel:get_cur_roomID())
if entity then
local status=entity.data.status
if status<1 then
check=false
end
else
error(FMT.fmt("坐标({0},{1})找不到对应开关实体",pos[1],pos[2]))
check=false
end
end
return check
elseif cType==2 then
check=true
for i,sidata in ipairs(data)do
local statistics=mysteryTriggerPointModel:get_statistics(sidata[1])
if statistics<sidata[2]then
check=false
break
end
end
return check
elseif cType==3 then
local statistics=0
for guid,v in pairs(self.entityList)do
if v.id==id and(v.data.status>0 or v.data.isClicked)then
statistics=statistics+1
break
end
end
return statistics>0 or(originEntity and originEntity.data.isClicked)
end
end


function mysteryTriggerPointModel:isConditionApplyAll(id,curStatus)
local conditionList=mysteryTriggerPointModel:get_state_condition(id)
if not conditionList then
return false
end
local curStatus=curStatus or 0
local index=curStatus+1
local condition=conditionList[index]
if not condition then
return false
end
local cType=condition[1]
for i,v in pairs(mysteryTriggerPointModel.AllIdConditionType)do
if cType==v then
return true
end
end
end


function mysteryTriggerPointModel:isGrass(id)
local config=self:get_config(id)
if config then
return config.grass~=nil and config.grass~=0
end
return false
end


function mysteryTriggerPointModel:haveGrass(pos)
if not pos then
return
end
local roomID=mysteryRoomModel:get_cur_roomID()
local entity=mysteryRoomModel:get_pos_entityType(roomID,pos,eMysteryEntityType.eTriggerPoint)
if entity and self:isGrass(entity.id)then
return entity
end
end


function mysteryTriggerPointModel:getGrassType(id)
local config=self:get_config(id)
if config then
return config.grass
end
end

local getXYKey=function(x,y)
return table.concat({x,y},"-")
end


function mysteryTriggerPointModel:getNearGrassRound(pos)
local posList=mysteryPosHelper.get_passable_near_pos_list(pos,1)

local grassPosList={}
if next(posList)then
for i,v in ipairs(posList)do
local key=getXYKey(v.x,v.y)
if self:haveGrass(v)and not self.data.tempGrassList[key]then
grassPosList[key]=v
self.data.tempGrassList[key]=v
end
end
end
if next(grassPosList)then
local have,list

for i,v in pairs(grassPosList)do
list=self:getNearGrassRound(v)
if next(list)then
for k,v2 in pairs(list)do
if not grassPosList[k]and not self.data.tempGrassList[k]then
grassPosList[k]=v2
self.data.tempGrassList[k]=v2
end
end
end
end
return grassPosList
else
return grassPosList
end
end


function mysteryTriggerPointModel:getNearGrass(pos)
local key=getXYKey(pos.x,pos.y)
if not self.data.grassPosList[key]then
self.data.tempGrassList={}
if self:haveGrass(pos)then
self.data.tempGrassList[key]=pos
self:getNearGrassRound(pos)
end
local grassPosList=self.data.tempGrassList
self.data.tempGrassList=nil
self.data.grassPosList[key]=grassPosList
return grassPosList
else
return self.data.grassPosList[key]
end
end


function mysteryTriggerPointModel:isNearGrass(pos1,pos2)
local posList=mysteryTriggerPointModel:getNearGrass(pos1)
if next(posList)then
for i,v in pairs(posList)do
if v.x==pos2.x and v.y==pos2.y then
return true
end
end
end
return false
end





function mysteryTriggerPointModel:init_data()
self.data={}
self.data.grassPosList={}
self.data.grassList={}
self.data.grassEntList={}
end

function mysteryTriggerPointModel:clearGrassList()
self.data.grassList={}
end

function mysteryTriggerPointModel:getGrassList()
return self.data.grassList
end

function mysteryTriggerPointModel:playerCanSeeTheEntityInGrass(entity)
self.data.grassList[entity.guid]=entity
end

function mysteryTriggerPointModel:isInGrassList(guid)
return self.data.grassList[guid]~=nil
end

function mysteryTriggerPointModel:setEntGrass(grassguid,entguid,flag)
if not self.data.grassEntList[grassguid]then
self.data.grassEntList[grassguid]={}
end
self.data.grassEntList[grassguid][entguid]=flag
end

function mysteryTriggerPointModel:haveEntGrass(grassguid)
return self.data.grassEntList[grassguid]and next(self.data.grassEntList[grassguid])~=nil
end
