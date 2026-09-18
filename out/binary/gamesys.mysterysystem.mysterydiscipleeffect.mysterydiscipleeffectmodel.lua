







mysteryDiscipleEffectModel={}


mysteryDiscipleEffectModel.data={}

local _register_list={}





function mysteryDiscipleEffectModel:init_data()
self.data={}
end

function mysteryDiscipleEffectModel.bindClass(class)
local discipleEffect=class.discipleEffect
if _register_list[discipleEffect]then return end
_register_list[discipleEffect]=class
end

function mysteryDiscipleEffectModel.getClass(effectType)
return _register_list[effectType]
end




function mysteryDiscipleEffectModel:add_hide_step(guid,num)
if not self.data.hideStep then
self.data.hideStep={}
end
self.data.hideStep[tostring(guid)]=num
end

function mysteryDiscipleEffectModel:get_hide_step()
local num=0
if self.data.hideStep then
for i,v in pairs(self.data.hideStep)do
num=num+v
end
end
return num
end


function mysteryDiscipleEffectModel:add_skill_explore_range(guid,num)
if not self.data.skillExploreRange then
self.data.skillExploreRange={}
end
self.data.skillExploreRange[tostring(guid)]=num
end

function mysteryDiscipleEffectModel:get_skill_explore_range()
local num=0
if self.data.skillExploreRange then
for i,v in pairs(self.data.skillExploreRange)do
num=num+v
end
end
return num
end

function mysteryDiscipleEffectModel:set_fog_add_view(guid,view)
if not self.data.fogView then
self.data.fogView={}
end
self.data.fogView[tostring(guid)]=view
end

function mysteryDiscipleEffectModel:get_fog_add_view()
local view=0
if self.data.fogView then
for i,v in pairs(self.data.fogView)do
view=view+v
end
end
return view
end

function mysteryDiscipleEffectModel:set_find_hidden_args(guid,args)
if not self.data.findHiddenArgs then
self.data.findHiddenArgs={}
end
local entityType=args[2]
if entityType then
self.data.findHiddenArgs[entityType]=self.data.findHiddenArgs[entityType]or{}
self.data.findHiddenArgs[entityType][tostring(guid)]=args
end

end

function mysteryDiscipleEffectModel:get_find_hidden_args()
return self.data.findHiddenArgs
end

function mysteryDiscipleEffectModel:check_find_hidden()
if self.data.findHiddenArgs then
local playerPos=mysteryPlayerModel:get_player_pos()
local roomId=mysteryRoomModel:get_cur_roomID()
for entityType,entityTypeList in pairs(self.data.findHiddenArgs)do
for guid,v in pairs(entityTypeList)do
local round=v[1]
local hidden=nil
local posList=mysteryPosHelper.get_all_round_pos_list(playerPos,round)
for _,pos in ipairs(posList)do
hidden=mysteryRoomModel:get_pos_have_entity_hidden(roomId,pos,entityType)
if hidden then
break
end
end
if hidden then
local guid=v.guid
local name=UIDiscipleModel:getDiscipleName(guid)
if not name then
local npcConfig=fightPreSelectModel.getNPCConfig(guid)
if npcConfig then
name=npcConfig.name
end
end
UIManager:invokeUIMethod("UIMysteryWin","talk",nil,name,v[3][math.random(1,#v[3])])
break
end
end
end
end
end