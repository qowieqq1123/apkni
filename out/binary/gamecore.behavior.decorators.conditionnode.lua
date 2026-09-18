





conditionNode=simple_class(checkSharedVarNode)

function conditionNode:checkPass()
local condition=self:getDataValue('condition')
condition=self:replaceData(condition)
condition=string.format('return %s',condition)
self.pass=loadstring(condition)()
end