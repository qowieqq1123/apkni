
local _SortingLayerNameToID=CS.LuaHelper.SortingLayerNameToID


local _SortingLayerNameToIDCache={}


local LAYER_ACTOR=CS.SceneDefault.LAYER_ACTOR
local LAYER_TOUCH_GROUND=CS.SceneDefault.LAYER_TOUCH_GROUND


helper.LAYER_ACTOR=LAYER_ACTOR
helper.LAYER_TOUCH_GROUND=LAYER_TOUCH_GROUND




function helper.getSortingLayerID(name)

local id=_SortingLayerNameToIDCache[name]
if id==nil then

id=_SortingLayerNameToID(name)

_SortingLayerNameToIDCache[name]=id
end
return id
end

