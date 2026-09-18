airMapSystem={}



function airMapSystem:onAppStart()

end

function airMapSystem:onEnterState(isReconnect)

end


function airMapSystem:onLeaveState(isReconnect)
airMapSystem:leaveAirGame()
end

function airMapSystem:onProtocolReq(isReconnect)

end

function airMapSystem:enterAirGame()
local defineStatic=airController.getDefineStatic()
self.manager=airController.getMapManager()
airMapSystem:setMapCameraBorder()
self.quaternion=Quaternion.Euler(20,0,0)
end

function airMapSystem:leaveAirGame()

end



function airMapSystem:getCamera()
return airController.getMapManager():GetCameraTransform()
end

function airMapSystem:setRoleRange(left,right,botttom,top)
local defineStatic=airController.getDefineStatic()

end


function airMapSystem:getBoundary()
return self.leftX,self.topY,self.rightX,self.bottomY
end

function airMapSystem:setMapCameraBorder()
local cfg=cfg_aircommonconfig_get(1)
self.border=cfg.border
local border=self.border
local leftX=border[1]
local topY=border[2]
local rightX=border[3]
local bottomY=border[4]
self.leftX=leftX
self.topY=topY
self.rightX=rightX
self.bottomY=bottomY
airController.getMapManager():SetMoveCameraBorder(leftX,topY,rightX,bottomY)
end

function airMapSystem:setCameraBorder(ent)
ent:setMoveCameraBorder(self.leftX,self.topY,self.rightX,self.bottomY)
end

function airMapSystem:resetCameraParent()
airController.getMapManager():SetCameraToParent()
end

function airMapSystem:isInMap(x,z)
return x<=self.rightX and x>=self.leftX and z<=self.topY and z>=self.bottomY
end

function airMapSystem:clamp(x,z)
x=math.min(x,self.rightX)
x=math.max(x,self.leftX)
z=math.min(z,self.topY)
z=math.max(z,self.bottomY)
return x,z
end

function airMapSystem.getQuaternion()
return self.quaternion
end

function airMapSystem.getScreenPoint(point)
return airController.getMapManager():GetScreenPoint(point)
end