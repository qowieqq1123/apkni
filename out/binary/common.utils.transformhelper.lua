


transformHelper={}

local _screen=UnityEngine.Screen
local defaultHeadPos={0.5,1}
local defaultUIScale=100




function transformHelper.bodyHeadPos(dbBodyID,scale)
local offset=Vector3.New(0,0,0)
local headPos=cfgHelper.get2(cfg_dbbodyconfig_get,dbBodyID,'headPos')or defaultHeadPos
offset.x=headPos[1]*scale
offset.y=headPos[2]*scale
return offset
end




function transformHelper.bodyUIHeadPos(dbBodyID,scale)
local offset=Vector3.New(0,0,0)
local headPos=cfgHelper.get2(cfg_dbbodyconfig_get,dbBodyID,'headPos')or defaultHeadPos
offset.x=headPos[1]*scale*defaultUIScale
offset.y=headPos[2]*scale*defaultUIScale
return offset
end




function transformHelper.bodyStatePos(dbBodyID,scale)
local offset=Vector3.New(0,0,0)
local state=cfgHelper.get2(cfg_dbbodyconfig_get,dbBodyID,'statePos')or defaultHeadPos
offset.x=state[1]*scale
offset.y=state[2]*scale
return offset
end




function transformHelper.bodySize(dbBodyID,scale)
local orgSize=cfgHelper.get2(cfg_dbbodyconfig_get,dbBodyID,'size')or{1.2,1.5}
local size={}
size[1]=orgSize[1]*scale
size[2]=orgSize[2]*scale
return size
end


function transformHelper.getUIRatioBy3dUI()
local screenWidth=_screen.width
local screenHeight=_screen.height
local scaleRatio=16*screenHeight/9/screenWidth
return scaleRatio
end