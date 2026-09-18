







local _MODULENAME="mysteryDiscipleEffectController"
gameState.addListener(def_table(_MODULENAME))
mysteryDiscipleEffectController.name=_MODULENAME




function mysteryDiscipleEffectController:onAppStart()
mysteryDiscipleEffectModel:init_data()
end

function mysteryDiscipleEffectController:onEnterState()

end

function mysteryDiscipleEffectController:onLeaveState()

end






function mysteryDiscipleEffectController.bindClass(class)
mysteryDiscipleEffectModel.bindClass(class)
end


function mysteryDiscipleEffectController.invokeFunc(effectType,...)
local model=mysteryDiscipleEffectModel.getClass(effectType)
if model==nil then return end
if model["setDiscipleEffect"]then
local args={...}
return model.setDiscipleEffect(model,unpack(args))
else
loggerUtil.logErrFMT('实体类型{0}没有找到方法',effectType)
end
end

function mysteryDiscipleEffectController.useEffect()
mysteryDiscipleEffectModel:init_data()

local team=MysteryModel:get_fb_probeTeam()
local effectList={}
if team then
for _,v in ipairs(team)do
if v.unitType==fightPreSelectModel.teamEntityType.dizi then
local tezhiList=UIDiscipleModel:getDiscipleSpecialityConfig(v.unitId)
if next(tezhiList)then
for _,cfg in ipairs(tezhiList)do
if cfg.search_effects then
for k,u in ipairs(cfg.search_effects)do
if not effectList[u[1]]then
effectList[u[1]]={v.unitType,v.unitId,u}
else
local other=effectList[u[1]][3]
if type(u[2])=="number"and u[2]>other[2]then
effectList[u[1]]={v.unitType,v.unitId,u}
end
end
end
end
end
end
end
end
end
if next(effectList)then
for t,v in pairs(effectList)do
local guid=v[2]
local data=v[3]
mysteryDiscipleEffectController.invokeFunc(data[1],guid,data[2])
end
end

end
