





storyShowHeiBianNode=simple_class(baseNode)

function storyShowHeiBianNode:broke()
UIManager:closeWindow('UIJuQingDongHuaHeiBianWin')
end

function storyShowHeiBianNode:update(interval)
local flag=self:getData('flag')
if flag then
UIManager:showWindow('UIJuQingDongHuaHeiBianWin')
else
UIManager:callWindowFunc('UIJuQingDongHuaHeiBianWin','closeWin')
end
return nodeState.success
end