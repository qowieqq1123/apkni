

sceneLightControl={}

local _setGlobalColor=UnityEngine.Shader.SetGlobalColor

function sceneLightControl:init()
self:reset()
end

function sceneLightControl:reset()
_setGlobalColor("_SceneLightColor",Color.New(1,1,1,0))
end
