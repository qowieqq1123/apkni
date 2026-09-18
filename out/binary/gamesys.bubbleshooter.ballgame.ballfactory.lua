








local ballFactory={}

local ballTableLuaFile,bassBallLuaFile
local isClient=true
if isClient then
ballFactory.physics=require("lua.gameSys.bubbleShooter.ballGame.ballPhysics")
ballTableLuaFile=require("lua.gameSys.bubbleShooter.ballGame.ballTable")
bassBallLuaFile=require("lua.gameSys.bubbleShooter.ballGame.bassBall")
else
ballFactory.physics=require("lua.gameSys.bubbleShooter.ballGame.ballPhysics")
ballTableLuaFile=require("lua.gameSys.bubbleShooter.ballGame.ballTable")
bassBallLuaFile=require("lua.gameSys.bubbleShooter.ballGame.bassBall")
end


function ballFactory.newTable(basecfg,cfg,data)







if ballFactory.ballTable==nil then
local newT={}
if ballTableLuaFile~=nil then
setmetatable(newT,{__index=ballTableLuaFile})
newT.physics=ballFactory.physics
newT.newBall=ballFactory.newBall
newT:__init(basecfg,cfg,data)
end
ballFactory.ballTable=newT
end
return ballFactory.ballTable
end

function ballFactory.releaseTable()
ballFactory.ballTable=nil
end


function ballFactory.newBall(index,row,col,color)

local newB={}
if bassBallLuaFile~=nil then
setmetatable(newB,{__index=bassBallLuaFile})
newB:__init(index,row,col,color)
end
return newB
end

return ballFactory