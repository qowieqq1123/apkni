luaBuildLightMap={}

local cur_api_level=deviceHelper.getAPILevel()

local Available_BuildLightMap=function()
return cur_api_level>=30
end


local instance

function luaBuildLightMap:init()
if Available_BuildLightMap()then
instance=CS.YMZBuildLight.CustomLightManager.GetInstance()
luaBuildLightMap:setLightScene(0,0)
luaBuildLightMap:enableLight(false)
end
end

function luaBuildLightMap:enableLight(enable)
if instance then
instance:EnableLight(enable)
end
end

function luaBuildLightMap:markDirty()
if instance then
instance.SimLightMapDirty=true
end
end

function luaBuildLightMap:continuGenMap(continue)
if instance then
instance.ContinuGenMap=continue
end
end

function luaBuildLightMap:setLightScene(type,state)
if instance then
instance:SetLightScene(type,state)
end
end

function luaBuildLightMap:setLigthSceneState(state)
if instance then
instance:StartTransition(state)
end
end

function luaBuildLightMap:setSceneLightIntensityFactor(factor)
if instance then
instance.SceneLightIntensityFactor=factor
end
end

function luaBuildLightMap:setCustomState(name,sceneLightIntensity,sceneEvnLightColor,transitionTime)
if instance then
instance:StartCustomTransition(name,sceneLightIntensity,sceneEvnLightColor,transitionTime)
end
end

function luaBuildLightMap:transitionStateImmediately()
if cur_api_level>=32 then
if instance~=nil then
instance:TransitionStateImmediately()
end
end
end

function luaBuildLightMap:addSceneStaticLight(id,x,y,scale)
if instance then
instance:AddSceneStaticLight(id,x,y,scale)
end
end


function luaBuildLightMap:removeSceneStaticLight(guid)
if instance then
instance:RemoveSceneStaticLight(guid)
end
end


function luaBuildLightMap:clearLight()
if instance then
instance:ClearLight()
end
end