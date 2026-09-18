






function MysteryModel:set_map_type(mapType)
self.currentFBData.mapType=mapType
end

function MysteryModel:get_map_type()
return self.currentFBData.mapType or HexMapType.Main
end


function MysteryModel:set_fb_progress(progress)
self.currentFBData.progress=progress
end

function MysteryModel:set_team_dead(isDead)
self.currentFBData.is_all_dead=isDead
end

function MysteryModel:get_team_dead()
return self.currentFBData.is_all_dead
end


function MysteryModel:set_fb_target_progress(targetListLen,targetList)
self.currentFBData.targetListLen=targetListLen
self.currentFBData.targetList=targetList
end

function MysteryModel:get_fb_target_progress()
return self.currentFBData.targetListLen or 0,self.currentFBData.targetList
end


function MysteryModel:get_fb_progress()
return self.currentFBData.progress
end


function MysteryModel:set_fb_power(power)
self.currentFBData.power=power
end


function MysteryModel:get_fb_power()
return self.currentFBData.power
end


function MysteryModel:set_fb_max_power(power)
self.currentFBData.maxPower=power
end


function MysteryModel:get_fb_max_power()
return self.currentFBData.maxPower
end


function MysteryModel:set_fog_view(fogView)
self.currentFBData.fogView=fogView
end

function MysteryModel:get_fog_view()
if not self.currentFBData.fogView then
local fbID=self:get_cur_fbid()
local cfg_fb=cfg_secretscenefubenconfig_get(fbID)
self.currentFBData.fogView=cfg_fb.fog
end
if self.currentFBData.fogView then
local tezhi_addView=mysteryDiscipleEffectModel:get_fog_add_view()
return self.currentFBData.fogView+tezhi_addView
end
end


function MysteryModel:set_stop_surface(data)
self.currentFBData.stopSurfaceId={}
for i,v in ipairs(data)do
self.currentFBData.stopSurfaceId[v]=2
end
end


function MysteryModel:get_stop_surface()
return self.currentFBData.stopSurfaceId or{}
end


function MysteryModel:set_continue_flag(flag)
self.currentFBData.continue=flag
end

function MysteryModel:get_continue_flag()
return self.currentFBData.continue
end


function MysteryModel:set_moving_entity(guid,isMoving)
if not self.currentFBData.movingEntity then
self.currentFBData.movingEntity={}
end
if isMoving then
self.currentFBData.movingEntity[guid]=true
else
self.currentFBData.movingEntity[guid]=nil
end
end

function MysteryModel:clear_moving_entity()
self.currentFBData.movingEntity={}
end

function MysteryModel:set_move_complete_entity(guid,ent)
if not self.currentFBData.moveCompleteEntity then
self.currentFBData.moveCompleteEntity={}
end
self.currentFBData.moveCompleteEntity[guid]=ent
end

function MysteryModel:get_move_complete_entity()
return self.currentFBData.moveCompleteEntity
end

function MysteryModel:clear_move_complete_entity()
self.currentFBData.moveCompleteEntity={}
end


function MysteryModel:have_moving_entity()
return self.currentFBData.movingEntity~=nil and next(self.currentFBData.movingEntity)~=nil
end


function MysteryModel:set_wing_step(num,direction)
self.currentFBData.wingSteps=num
self.currentFBData.wingDirect=direction
end

function MysteryModel:get_wing_step()
return self.currentFBData.wingSteps or 0
end

function MysteryModel:have_wing_step()
return self:get_wing_max_step(self:get_cur_fbid())-self:get_wing_step()
end

function MysteryModel:get_wing_direct(change)
local fbid=self:get_cur_fbid()
if not self.currentFBData.wingDirect then
local d=MysteryModel:get_wing_default_direct(fbid)
self.currentFBData.wingDirect=d
end
if MysteryModel:is_wing_change_direct(fbid)then
if change then
if self.currentFBData.wingDirect==0 then
self.currentFBData.wingDirect=1
else
self.currentFBData.wingDirect=0
end
end
end
return self.currentFBData.wingDirect
end

function MysteryModel:get_wing_config(id)
return cfgHelper.get(cfg_secretscenefubenconfig_get,id,"wing")
end

function MysteryModel:have_wing(id)
local cfg=self:get_wing_config(id)
return cfg~=nil
end

function MysteryModel:get_wing_effect(id)
local cfg=self:get_wing_config(id)
return cfg and cfg[4]
end

function MysteryModel:get_wing_max_step(id)
if not self.currentFBData.wingMaxStep then
local cfg=self:get_wing_config(id)
self.currentFBData.wingMaxStep=cfg and cfg[1]
end
return self.currentFBData.wingMaxStep
end

function MysteryModel:get_wing_default_direct(id)
local cfg=self:get_wing_config(id)
return cfg and cfg[2]
end

function MysteryModel:is_wing_change_direct(id)
local cfg=self:get_wing_config(id)
return cfg and cfg[3]
end


function MysteryModel:set_rule_bag_data(bagCount,bagData)
self.data.bagData={}
if bagCount>0 then
for i,v in ipairs(bagData)do

table.insert(self.data.bagData,v)
end
end
end

function MysteryModel:check_group_rule()
local groupRuleList={}
if next(self.data.bagData)then
local config=cfg_sslawruleconfig()
local check=false
for _,c in pairs(config)do
if(not self.data.bagData[c.id])and c.jhCondition then
check=true
for _,groupRule in ipairs(c.jhCondition[2])do
if not self.data.bagData[groupRule]then
check=false
end
end
if check then
table.insert(groupRuleList,c.id)
end
end
end
end
return groupRuleList
end

function MysteryModel:add_rule_bag_data(ruleData)
if ruleData then
local ifCover=false
local config=cfgHelper.getSSlawRule(ruleData.id)
if config and config.ifCover then
if next(self.data.bagData)then
for i,v in pairs(self.data.bagData)do
if config.id==v.id then
if ruleData.level>v.level then
self.data.bagData[i]=ruleData
end
ifCover=true
break
end
end
end
end
if not ifCover then
table.insert(self.data.bagData,ruleData)
end
local groupRuleList=self:check_group_rule()
if next(groupRuleList)then
for i,v in ipairs(groupRuleList)do
MysteryController.send_4_54(v)
end
end
end
end


function MysteryModel:get_rule_bag_data()
return self.data.bagData
end

function MysteryModel:get_rule_bag_sort_data()
local sortList={}
if self.data.bagData and next(self.data.bagData)then
sortList=self.data.bagData

table.sort(sortList,function(a,b)
local aConfig=cfgHelper.getSSlawRule(a.id)
local bConfig=cfgHelper.getSSlawRule(b.id)
return a.level>b.level or(a.level==b.level and aConfig.id<bConfig.id)
end)
end
return sortList
end



function MysteryModel:set_temp_grid_data(gridList,first,birthData)
self.currentFBData.tempGridData=gridList
self.currentFBData.tempEnterFirst=first
self.currentFBData.tempBirthData=birthData
end

function MysteryModel:get_temp_grid_data()
return self.currentFBData.tempGridData
end
function MysteryModel:get_temp_enter_first()
return self.currentFBData.tempEnterFirst
end
function MysteryModel:get_temp_birthData()
return self.currentFBData.tempBirthData
end


function MysteryModel:set_main_grid_data(fbID,mapIndex,gridList)
self.currentFBData.mainGridData={}
self.currentFBData.fogData={}

mapIndex=mapIndex or 1




local mapData=MysteryController.loadMapData(fbID,mapIndex)
local mapAreaX=0
local mapAreaY=0

local view=MysteryModel:get_fog_view()


for i,v in ipairs(mapData[1])do
local x,y=v[3][1],v[3][2]
if not self.currentFBData.mainGridData[y]then
self.currentFBData.mainGridData[y]={}
end
if not self.currentFBData.fogData[x]then
self.currentFBData.fogData[x]={}
end
if x>mapAreaX then
mapAreaX=x
end
if y>mapAreaY then
mapAreaY=y
end
if not view then
mysteryFogModel:set_fog_data(0,x,y,true)
end
self.currentFBData.mainGridData[y][x]={height=v[4],surfaceId=v[2],etGuid=v[2],gridType=v[1]}
end


local cfg_fb=cfg_secretscenefubenconfig_get(fbID)
local maparea=cfg_fb.maparea
local maxRoundX=maparea[1]+10
local maxRoundY=maparea[2]+10
for i,v in ipairs(gridList or{})do
if v.x>maxRoundX+20 or v.y>maxRoundY+20 then
loggerUtil.logErrFMT("秘境{0} 坐标({1},{2})大于范围({3},{4}),无效",fbID,v.x,v.y,maxRoundX,maxRoundY)
else
if not self.currentFBData.mainGridData[v.y]then
self.currentFBData.mainGridData[v.y]={}
end
if not self.currentFBData.fogData[v.x]then
self.currentFBData.fogData[v.x]={}
end

local fogFlag=mathHelper.getBitValue(v.gridStatus,0)
if fogFlag then

mysteryFogModel:set_fog_data(0,v.x,v.y,false)
else
mysteryFogModel:set_fog_data(0,v.x,v.y,true)
end
end
end
mysteryRoomModel:set_room_map_area(0,mapAreaX,mapAreaY)

end

function MysteryModel:set_main_ent_birth_data(etList)

for _,entity in ipairs(etList)do
if entity.etType==eMysteryEntityType.eSurface then
self.currentFBData.mainGridData[entity.etComm.y][entity.etComm.x]={height=0,surfaceId=entity.etComm.etId,etGuid=entity.etComm.etGuid}
else
local model=mysteryEntityController.getModelByEntityType(entity.etType)
if model then
local newData=model:dealServerData(entity)
if newData.etType==eMysteryEntityType.ePortal then
mysteryPortalModel:add_portal_room_data(newData,0,newData.x,newData.y)
mysteryRoomModel:set_room_entity_birth_pos_list(0,newData.etType,newData)
else
mysteryRoomModel:set_room_entity_birth_pos_list(0,newData.etType,newData)
end
end
end

end

end

function MysteryModel:set_player_birth_pos(x,y)
self.currentFBData.playerBirthPos={x,y}
end


function MysteryModel:get_player_birth_pos()
return self.currentFBData.playerBirthPos or{0,0}
end

function MysteryModel:get_exist_pos(roomID)

local grid_data=mysteryRoomModel:get_grid_data(roomID)or{}
if next(grid_data)then
local y=next(grid_data)
local x=next(grid_data[y])
return Vector3(x,y,0)
end
end


function MysteryModel:get_all_main_grid_data()
return self.currentFBData.mainGridData
end

function MysteryModel:get_main_grid_data(x,y)
if not self.currentFBData.mainGridData[y]then
return
end
return self.currentFBData.mainGridData[y][x]
end

function MysteryModel:set_main_grid_pos_data(x,y,gridData)
if not self.currentFBData.mainGridData[y]then
self.currentFBData.mainGridData[y]={}
end
self.currentFBData.mainGridData[y][x]=gridData
end


function MysteryModel:get_grid_data(roomID,x,y)
if roomID==0 then
return MysteryModel:get_main_grid_data(x,y)
else
return mysteryRoomModel:get_room_grid_data(roomID,x,y)
end
end


function MysteryModel:set_map_create_flag(flag)
self.currentFBData.createFlag=flag
end

function MysteryModel:get_map_create_flag()
return self.currentFBData and self.currentFBData.createFlag
end


function MysteryModel:add_grid_color_entity(room,pos,guid)




local posKey=string.format('%s_%s_%s',room,pos.x,pos.y)
self.colorGridsEntity[posKey]=guid
end


function MysteryModel:remove_grid_color_entity(room,pos)




local posKey=string.format('%s_%s_%s',room,pos.x,pos.y)
self.colorGridsEntity[posKey]=nil
end


function MysteryModel:get_grid_have_entity(room,pos)



local posKey=string.format('%s_%s_%s',room,pos.x,pos.y)
return self.colorGridsEntity[posKey]
end


function MysteryModel:init_fake_item(itemList)
self.currentFBData.fakeItemList={}
if itemList then
for i,v in ipairs(itemList)do
self.currentFBData.fakeItemList[tostring(v.itemGuid)]=v
end
end
end

function MysteryModel:get_fake_item(id)
if self.currentFBData.fakeItemList then
for i,v in pairs(self.currentFBData.fakeItemList)do
if id==v.itemId then
return v
end
end
end
end

function MysteryModel:get_fake_item_count(id)
local count=0
if self.currentFBData.fakeItemList then
for i,v in pairs(self.currentFBData.fakeItemList)do
if id==v.itemId then
return v.itemNum
end
end
end
return count
end

function MysteryModel:update_fake_item(fakeItem)
self.currentFBData.fakeItemList[tostring(fakeItem.itemGuid)]=fakeItem
end



function MysteryModel:set_fb_task_team(probeTeam)
self.data.taskTeam={}
if probeTeam then
for i,v in ipairs(probeTeam)do
table.insert(self.data.taskTeam,v)
end
end
end
function MysteryModel:get_fb_task_team()
return self.data.taskTeam
end


function MysteryModel:set_fb_probeTeam(probeTeam)
self.data.probeTeam={}
if probeTeam then
for i,v in ipairs(probeTeam)do
if v.unitType~=0 and v.unitId~=0 then
table.insert(self.data.probeTeam,v)
end
end

MysteryController:checkTeamDead(probeTeam)
end
self.data.probeTeamX=probeTeam



mysteryDiscipleEffectController.useEffect()
end

function MysteryModel:change_fb_probeTeamX(teamData)
local fbid=MysteryModel:get_cur_fbid()
local cfg=cfg_secretscenefubenconfig_get(fbid)

local newTeamX={}
local newTeam={}
if cfg.useAllDizi then
for i,v in ipairs(teamData)do
local data=v
table.insert(newTeamX,i,data)
if data.unitType==1 then
MysteryModel:setHisDisciple(data)
table.insert(newTeam,data)
elseif v.unitType==2 then
MysteryModel:setLinShiDisciple(data)
table.insert(newTeam,data)
end
end
else
for i,v in ipairs(teamData)do
for _,old in ipairs(self.data.probeTeamX)do
if v.unitType==old.unitType and v.unitId==old.unitId then
local data=v
data.blood=old.blood
table.insert(newTeamX,i,data)
if v.unitType~=0 and v.unitId~=0 then
table.insert(newTeam,data)
end
end
end
end
end

self.data.probeTeamX=newTeamX
self.data.probeTeam=newTeam


mysteryDiscipleEffectController.useEffect()
end


function MysteryModel:get_fb_probeTeam()
return self.data.probeTeam
end

function MysteryModel:get_fb_sendTeam()
local team={}
for i,v in ipairs(self.data.probeTeamX)do
table.insert(team,{v.unitType,v.unitId})
end
return team
end

function MysteryModel:get_fb_probeTeamX()
return self.data.probeTeamX
end

function MysteryModel:get_random_dizi_data()
math.newrandomseed()
local randomIndex=math.random(1,#self.data.probeTeam)
local guid=self.data.probeTeam[randomIndex].unitId
return UIDiscipleModel:getDiscipleData(guid)
end


function MysteryModel:get_team_top_fight()
local topFight=0
local topGuid=nil
for i,v in ipairs(self.data.probeTeam)do
if v.unitType==fightPreSelectModel.teamEntityType.dizi then
local guid=tostring(v.unitId)
local fight=UIDiscipleModel:getDiscipleFightValue(guid)
if fight>topFight then
topFight=fight
topGuid=guid
end
end
end
return topGuid
end


function MysteryModel:get_team_first()
for i,v in ipairs(self.data.probeTeam)do
if v.unitType==fightPreSelectModel.teamEntityType.dizi then
return tostring(v.unitId)
end
end
end


function MysteryModel:get_fb_probeTeam_blood(unitType,guid)
for i,v in ipairs(self.data.probeTeam)do
if v.unitType==unitType and tostring(v.unitId)==tostring(guid)then
return tonumber(tostring(v.blood))
end
end
end


function MysteryModel:change_fb_probeTeam_blood(unitType,guid,blood)
for i,v in ipairs(self.data.probeTeam)do
if v.unitType==unitType and tostring(v.unitId)==tostring(guid)then
v.blood=blood
if v.unitType==eTeamEntityType.dizi then
MysteryModel:setHisDisciple(v)
elseif v.unitType==eTeamEntityType.npc then
MysteryModel:setLinShiDisciple(v)
end
return i
end
end
end

function MysteryModel:get_fb_probeTeam_disciple(unitType,guid)
for i,v in ipairs(self.data.probeTeam)do
if v.unitType==unitType and tostring(v.unitId)==tostring(guid)then
return v
end
end
end


function MysteryModel:check_dead()
for i,v in ipairs(self.data.probeTeam)do
if tonumber(tostring(v.blood))<=0 then
return true
end
end
return false
end





function MysteryModel:insert_last_path(guid,path,posIndex)
guid=tostring(guid)
self.lastPath[guid]=self.lastPath[guid]or{}
if next(path)then
for i,v in ipairs(path)do


if not next(self.lastPath[guid])then

if posIndex>2 then

for i=1,posIndex-2 do
table.insert(self.lastPath[guid],v)
end
end
table.insert(self.lastPath[guid],v)
end
if i>1 then
table.insert(self.lastPath[guid],v)

end
end
end
end


function MysteryModel:insert_last_path_pos(guid,pos)
guid=tostring(guid)
self.lastPath[guid]=self.lastPath[guid]or{}

table.insert(self.lastPath[guid],pos)

end


function MysteryModel:remove_last_path_pos(guid)
guid=tostring(guid)
self.lastPath[guid]=self.lastPath[guid]or{}
local len=#self.lastPath[guid]
table.remove(self.lastPath[guid],len)

end


function MysteryModel:clear_last_path(guid)
guid=tostring(guid)
self.lastPath[guid]={}
end

function MysteryModel:clear_all_last_path()
self.lastPath={}
end


function MysteryModel:get_last_path(guid)
guid=tostring(guid)
return self.lastPath[guid]or{}
end


function MysteryModel:get_last_path_pos(guid,index)
return self.lastPath[guid]and self.lastPath[guid][index]
end

function MysteryModel:get_all_last_path()
return self.lastPath
end

function MysteryModel:set_last_path(guid,path)
self.lastPath[guid]=path
end




function MysteryModel:is_moved(guid)
local path=MysteryModel:get_last_path(guid)or{}
for i,v in pairs(path)do
if not mysteryPosHelper.is_same_pos(path[#path],v)then
return true
end
end
return false
end



function MysteryModel:set_mystery_hide_cache(posKey,data)
if not self.data.hide_cache then
self.data.hide_cache={}
end
if not self.data.hide_cache[posKey]then
self.data.hide_cache[posKey]={}
end
table.insert(self.data.hide_cache[posKey],data)
end

function MysteryModel:get_mystery_hide_cache(posKey)
return self.data.hide_cache[posKey]
end

function MysteryModel:clear_mystery_hide_cache()
self.data.hide_cache={}
end


function MysteryModel:add_mini_entity_cache(guid,pos,entityType)
if not self.currentFBData.miniEntityList then
self.currentFBData.miniEntityList={}
end
self.currentFBData.miniEntityList[guid]={pos,entityType}
end

function MysteryModel:remove_mini_entity_cache(guid)
if not self.currentFBData.miniEntityList then
self.currentFBData.miniEntityList={}
end
self.currentFBData.miniEntityList[guid]=nil
end

function MysteryModel:get_mini_entity_cache()
return self.currentFBData.miniEntityList or{}
end


function MysteryModel:getShowAwards(fbid,level)
local mCfg=cfgHelper.get1(cfg_secretscenefubenconfig_get,fbid)
local detail={}
local items={}
local detailLookUp={}
local itemsLookUp={}
local showItems=nil
local outItems=nil
local awardConfig=nil
if mCfg.showReward then
local v=mCfg.showReward
if level then
awardConfig=itemsAwardConfig:getAwardInConfigByLevel(v,level)

else
awardConfig=cfgHelper.get(cfg_awardconfig_get,v)
end

if awardConfig then
showItems=awardConfig.detailItems
outItems=awardConfig.showItems
end

if showItems then
for i,vv in ipairs(showItems)do
if not detailLookUp[vv[1]]then
table.insert(detail,vv)
detailLookUp[vv[1]]=true
end
end
end
if outItems then
for i,vv in ipairs(outItems)do
if not itemsLookUp[vv[1]]then
table.insert(items,vv)
itemsLookUp[vv[1]]=true
end
end
end
end

return items,detail
end
