













invokeUIObjFuncNode=simple_class(invokeStaticObjFuncNode)

function invokeUIObjFuncNode:getClassObject()
local winName=self:getData('winName')
local win=UIManager:findActiveWindow(winName)
return win
end