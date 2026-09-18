






local _MODULENAME="worldPositionConfig"




def_table(_MODULENAME)
worldPositionConfig.name=_MODULENAME
worldPositionConfig.data={}

function worldPositionConfig:onAppStart()
for world,temp in ipairs(worldPositionFileEnum)do
self.data[world]=require(FMT.fmt("lua.gamesys.worldSystem.worldPositionData.world_{0}_points",world))
end
end


function worldPositionConfig:onEnterState()

end


function worldPositionConfig:onLeaveState()


end


function worldPositionConfig:onServerDataInitFinish()

end





function worldPositionConfig:convertKey(x,z)
return x*100*100000+z*100
end






function worldPositionConfig:getPosition(world,info,mute)
local dimension=#info
if dimension==2 then
local key=self:convertKey(info[1],info[2])
local cfg=self.data[world]or{}

local data=cfg[tonumber(tostring(key))]
if data then
return mathHelper.convertArrayToVector(data[2]),data[1]
elseif not mute then



return Vector3.zero
end
elseif dimension==3 then
local key=self:convertKey(info[1],info[3])
local cfg=self.data[world]or{}
local data=cfg[tonumber(tostring(key))]
if data then
return mathHelper.convertArrayToVector(info),data[1]
elseif not mute then



return Vector3.zero
end
end
end




function worldPositionConfig:getPosition_CurrentWorld(info,mute)
return self:getPosition(worldModel.world,info,mute)
end

function worldPositionConfig:getPositionBlock(world,x,z,mute)
local key=self:convertKey(x,z)
local cfg=self.data[world]or{}
local data=cfg[tonumber(tostring(key))]
if data then
return data[1]
elseif not mute then
logErr(FMT.fmt("没有找到有效的坐标点[{0}]({1},{2})",world,x,z))
end
end
