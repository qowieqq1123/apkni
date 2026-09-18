





storyShowPassNode=simple_class(baseNode)

function storyShowPassNode:broke()
UIManager:closeWindow('UIJuQingDongHuaPassWin')
end

function storyShowPassNode:update(interval)
local flag=self:getData('flag')
local owner=self:getOwner()
if flag then
UIManager:showWindow('UIJuQingDongHuaPassWin',owner)
else
UIManager:closeWindow('UIJuQingDongHuaPassWin')
end
return nodeState.success
end