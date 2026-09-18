









local xjBuoy_XJFMBoss={}


function xjBuoy_XJFMBoss:onInit()


self.sceneOffset={400,-300,150,-120}
end


function xjBuoy_XJFMBoss:setSceneOffset(offset)
self.sceneOffset=offset
end


function xjBuoy_XJFMBoss:getScenePos()
local bossData=XianJieFuMoController:getBossData()
if bossData~=nil and bossData:checkInCurScene()then
local worldPos=bossData:getWorldPos_1()
if worldPos~=nil then
local pos=xianjieController:getScreenPoint(worldPos)
if pos then
return pos.x,pos.y
end
end
end
return nil,nil
end


function xjBuoy_XJFMBoss:onCreateWidget(widget)

widget:SetChildButtonClick(0,function()
self:onClick()
end)

local abname=globalABLookup.xjhudicons
local bossData=XianJieFuMoController:getBossData()
local iconname=bossData:getFuBiaoIcon()
widget:SetChildCSImageSprite(1,abname,iconname)

widget:SetChildActive(2,false)
end


function xjBuoy_XJFMBoss:onRemoveWidget(widget)
widget:SetChildIcon(1,'',false)
end

function xjBuoy_XJFMBoss:onClick()
if not self:checkWidget()then return end
xianjieController:closeWin3()
XianJieFuMoController:jumpBossPos(function()
self:lookBack()
end)
end

function xjBuoy_XJFMBoss:lookBack()
if self.m_ID==nil then return end
self:refreshPos(false)
end


function xjBuoy_XJFMBoss:onDelete()

end

return xjBuoy_XJFMBoss