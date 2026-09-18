







worldMapController=gameState.addListener({})

local _enter_scene=nil
local _last_scene=nil
local _current_scene=nil

function worldMapController:onAppStart()

end

function worldMapController:onEnterState()
worldMapModel:initData()
end

function worldMapController:onLeaveState()
worldMapModel:clearData()
end

function worldMapController:onPlayerCreate(...)

end

function worldMapController:onLostConnection()

end

function worldMapController:onProtocolReq()
if worldController:isInWorld()and worldController:isOverTop()then
local worldCfg=cfgHelper.get1(cfg_worldconfig_get,_enter_scene)
worldController:breakOverTopBackEnter(worldCfg.cameraPos[2])
worldMapController:exitMapModel()
worldController:setCameraState(eWorldCameraState.Normal)
end
end


function worldMapController:exitMapModel()
_enter_scene=nil
_last_scene=nil
_current_scene=nil
UIManager:closeWindow("UIWorldMapTabWin")
UIManager:closeWindow("UIWorldSceneWin")
UIManager:closeWindow("UIWorldMapWin")
UIManager:closeWindow("UITopMaskWin")
worldController:showCamera(true)
worldController:showPanel()
end


function worldMapController:enterMapModel(world)
_enter_scene=world
_current_scene=_enter_scene
_last_scene=_enter_scene
UIManager:showWindow("UIWorldSceneWin")
UIManager:showWindow("UIWorldMapTabWin")
UIManager:showWindow("UITopMaskWin")
worldController:hidePanel()
end


function worldMapController:setCurrentScene(world)
if world then
_current_scene=world
if world~=_enter_scene then
_last_scene=world
end
end
end


function worldMapController:getCurrentScene()
return _current_scene
end


function worldMapController:getLastScene()
return _last_scene
end


function worldMapController:getEnterScene()
return _enter_scene
end

function worldMapController:isMapModel()
return _current_scene~=nil
end