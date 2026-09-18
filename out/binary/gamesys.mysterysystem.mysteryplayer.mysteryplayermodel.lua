







mysteryPlayerModel=mysteryEntityBase.new(eMysteryEntityType.ePlayer,{})

mysteryPlayerModel.entityType=eMysteryEntityType.ePlayer

local _HexMapManager=CS.HexagonMapManagerInterface


mysteryPlayerModel.lastPath={}

mysteryPlayerModel.lastSteps=0

mysteryPlayerModel.totalSteps=0

mysteryPlayerModel.simSteps=0



function mysteryPlayerModel.get_base_config()
local config=cfg_secretscenebaseconfig_get(1)
return config
end



function mysteryPlayerModel:init_data()
self.lastPath={}
self.totalSteps=0
self.tarpos=nil
self.isOpenGrassWindow=nil
self.isOpenGrassWindowName=nil
self.focus_flag=nil
end

function mysteryPlayerModel:get_player()
local entityList=self:get_entity_list()
for i,v in pairs(entityList)do
return v
end
end

function mysteryPlayerModel:get_player_guid()
local player=mysteryPlayerModel:get_player()
return player and player.guid
end


function mysteryPlayerModel:get_player_model_info()
local fbid=MysteryModel:get_cur_fbid()
local discipleOutsideInfo
local cfg=cfg_secretscenefubenconfig_get(fbid)
if cfg.playerImage then
discipleOutsideInfo={body=cfg.playerImage[1],componets=cfg.playerImage[2],scale=cfg.playerImage[3]}
else

local teamQueue={1,2,3,4,5}
local playerData=nil
local teamData=MysteryModel:get_fb_probeTeam()
local checkBlood=true

if cfg.useAllDizi then
checkBlood=false
end
local allDead=true
for i,v in ipairs(teamQueue)do
if teamData[v]and tonumber(tostring(teamData[v].unitId))~=0 then
playerData=teamData[v]
if tonumber(tostring(teamData[v].blood))>0 then
allDead=false
break
end
end
end

if checkBlood and allDead then
return
end
if allDead then
local sex=1
if playerData.unitType==fightPreSelectModel.teamEntityType.dizi then
sex=UIDiscipleModel:getDiscipleSex(playerData.unitId)
elseif playerData.unitType==fightPreSelectModel.teamEntityType.npc then
local NPCConfig=fightPreSelectModel.getNPCConfig(tonumber(tostring(playerData.unitId)))
sex=NPCConfig.sex
end
discipleOutsideInfo={body=sex==1 and 1114103 or 1114104}
else
if playerData.unitType==fightPreSelectModel.teamEntityType.dizi then
local discipleData=UIDiscipleModel:getDiscipleData(playerData.unitId)
discipleOutsideInfo=UIDiscipleModel:getDiscipleOutsideModelInfo(discipleData.discipleguid)
discipleOutsideInfo.scale=nil
elseif playerData.unitType==fightPreSelectModel.teamEntityType.npc then
local imageInfo=fightPreSelectModel.getNPCOutSideModel(tonumber(tostring(playerData.unitId)))
discipleOutsideInfo={body=imageInfo[1],componets=imageInfo[2]}
end
end
end
return discipleOutsideInfo
end

function mysteryPlayerModel:set_player_room(roomId)
self:set_entity_room(mysteryPlayerModel:get_player_guid(),roomId)
end

function mysteryPlayerModel:set_player_pos(pos)
self:set_entity_pos(mysteryPlayerModel:get_player_guid(),pos)
end

function mysteryPlayerModel:get_player_pos()
local player=mysteryPlayerModel:get_player()
return player and player.pos
end

function mysteryPlayerModel:set_focus_flag(flag)
self.focus_flag=flag
end

function mysteryPlayerModel:get_focus_flag()
return self.focus_flag
end

function mysteryPlayerModel:get_player_fight_value()
local player=mysteryPlayerModel:get_player()
return player.data.fight_value
end

function mysteryPlayerModel:flash(guid,pos)
local roomID=mysteryRoomModel:get_cur_roomID()
local layer=mysteryRoomModel:get_GroundLayer(roomID)

_HexMapManager.SetPosition(guid,pos,layer)
mysteryPlayerModel:set_player_pos(pos)

MysteryController.upload_player_pos()
UIManager:invokeUIMethod("UIMysteryMiniWin","focusPlayer",100)

MysteryController.set_camera_fcous_pos(roomID,pos,20,function()

mysteryFogController:updateFog(MysteryModel:get_cur_fbid(),mysteryPlayerModel:get_player_pos())
mysteryAIManager:set_mystery_state(false)
mysteryEntityController.handle_meet()
end,true,_Ease.InOutSine)

mysteryPlayerController:inGrassFade(pos)
if not mysteryPlayerModel:isPlayerInGrass()then
mysteryPlayerController:showGrassWindow(false)
end

end










function mysteryPlayerModel:is_move_complete()
local player=mysteryPlayerModel:get_player()
if player then
return player.data.move_complete
end
end



function mysteryPlayerModel:has_player()
local player=mysteryPlayerModel:get_player()
return player~=nil
end



function mysteryPlayerModel:set_ori_path(path)
self.oriPath=path
end


function mysteryPlayerModel:get_ori_path()
return self.oriPath
end



function mysteryPlayerModel:set_last_path(path)
self.lastPath=path
end


function mysteryPlayerModel:get_last_path()
return self.lastPath
end


function mysteryPlayerModel:set_last_pos(lastPos)
self.lastPos=lastPos
end


function mysteryPlayerModel:get_last_pos()
return self.lastPos
end


function mysteryPlayerModel:get_target_pos()
return self.tarpos
end

function mysteryPlayerModel:set_target_pos(tarpos)
self.tarpos=tarpos
end




function mysteryPlayerModel:set_last_steps(steps)
self.lastSteps=steps
end


function mysteryPlayerModel:add_last_steps(steps)
self.lastSteps=self.lastSteps+steps
end


function mysteryPlayerModel:get_last_steps()
return self.lastSteps
end


function mysteryPlayerModel:set_total_steps(steps)
self.totalSteps=self.totalSteps+steps
end


function mysteryPlayerModel:add_total_steps(steps)
self.totalSteps=self.totalSteps+steps
end


function mysteryPlayerModel:reset_sim_steps()
self.simSteps=self.totalSteps
end


function mysteryPlayerModel:add_sim_steps(steps)
self.simSteps=self.simSteps+steps
end


function mysteryPlayerModel:get_sim_steps()
return self.simSteps
end




function mysteryPlayerModel:isPlayerInGrass()
local pos=self:get_player_pos()
return mysteryTriggerPointModel:haveGrass(pos)
end
function mysteryPlayerModel:getGrassWindowState()
return self.isOpenGrassWindow
end