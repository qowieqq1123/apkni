
jumpSceneNode=simple_class(baseNode)

function jumpSceneNode:init()
local sceneid=self:getData("sceneid")
local mapid=self:getData("mapid")
local args=self:getData("args")

local enterCallBack=function()
self.jumpSceneState=2
end

local jumpResult=jumpManager:jump({id=JUMP_TYPE.eBehaviorJump,args={scenetype=sceneid,mapid=mapid,args=args,enterCallBack=enterCallBack}})
self.jumpSceneState=jumpResult and 1 or 3
if not jumpResult then
logErr("跳转场景失败")
end
end

function jumpSceneNode:broke()

end

function jumpSceneNode:update(interval)




if self.jumpSceneState==2 then
return nodeState.success
end

if self.jumpSceneState==3 then
return nodeState.failure
end

return nodeState.running
end