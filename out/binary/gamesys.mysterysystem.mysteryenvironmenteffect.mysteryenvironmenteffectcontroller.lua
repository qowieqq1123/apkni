







local _MODULENAME="mysteryEnvironmentEffectController"
gameState.addListener(def_table(_MODULENAME))
mysteryEnvironmentEffectController.name=_MODULENAME

local _HexMapManager=CS.HexagonMapManagerInterface





function mysteryEnvironmentEffectController:onAppStart()
socketManager:register_receiver(4,48,mysteryEnvironmentEffectController.recv_4_48)
end

function mysteryEnvironmentEffectController:onEnterState()

end

function mysteryEnvironmentEffectController:onLeaveState()

end








function mysteryEnvironmentEffectController.recv_4_48(envIdListLen,envIdList)
if envIdListLen>0 then
mysteryEnvironmentEffectController.setEnvironmentEffectByList(envIdList)
mysteryEnvironmentEffectModel:set_environment(envIdList)
end
end



function mysteryEnvironmentEffectController.bindClass(class)
mysteryEnvironmentEffectModel.bindClass(class)
end


function mysteryEnvironmentEffectController.invokeFunc(environmentEffectType,func_name,...)
local model=mysteryEnvironmentEffectModel.getClass(environmentEffectType)
if model==nil then return end
if model[func_name]then
local args={...}
return model[func_name](model,unpack(args))
else
loggerUtil.logErrFMT('实体类型{0}没有找到{1}方法',environmentEffectType,func_name)
end
end

function mysteryEnvironmentEffectController.setEnvironmentEffectByList(envIdList)
local config
if#envIdList>0 then
for i,envId in ipairs(envIdList)do
config=mysteryEnvironmentEffectModel.getConfigById(envId)
if config then
if config.envType then
mysteryEnvironmentEffectController.invokeFunc(config.envType,"setEnvironmentEffect",config.envParam)
end
end
end
end
end