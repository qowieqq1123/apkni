shaderHelper={}
local _DisableKeyword=UnityEngine.Shader.DisableKeyword
local _EnableKeyword=UnityEngine.Shader.EnableKeyword
local _SetGlobalVector=UnityEngine.Shader.SetGlobalVector
local _SetGloablFloat=UnityEngine.Shader.SetGlobalFloat
local _setGlobalColor=UnityEngine.Shader.SetGlobalColor

function shaderHelper.init()


shaderHelper.enableCurvedWorld(false)

_DisableKeyword("_VOLUMETRIC_FOG")
shaderHelper.enableWarFogMask(false)
UnityEngine.Shader.DisableKeyword("_ENABLE_CURVED_WORLD_LITTLEPLANET_Y")
shaderHelper.setSimLight(false)
end

function shaderHelper.enableCurvedWorld(enable)
if enable then
_EnableKeyword("_ENABLE_CURVED_WORLD")
else
_DisableKeyword("_ENABLE_CURVED_WORLD")
end
end

function shaderHelper.enableWarFogMask(enable)
if enable then
_EnableKeyword("_WAR_FOG_MASK")
else
_DisableKeyword("_WAR_FOG_MASK")
end
end

function shaderHelper.setCurvedWorldPivotPoint(point)
_SetGlobalVector("CurvedWorld_PivotPoint",point)
end




function shaderHelper.setCurveWorldBend(bend)
_SetGlobalVector("CurvedWorld_Bend",bend)
end


function shaderHelper.setCommomEffectFadeBaseHeight(baseHeight)
_SetGloablFloat('_CommonEffectBaseHeight',baseHeight)
end

function shaderHelper.setSimLight(enable,r,g,b)
if enable then
_EnableKeyword("_SIM_ENV_LIGHT")
_setGlobalColor("_SimLightColor",Color.New(r or 1,g or 1,b or 1,1))
else
_DisableKeyword("_SIM_ENV_LIGHT")
_setGlobalColor("_SimLightColor",Color.white)
end
end