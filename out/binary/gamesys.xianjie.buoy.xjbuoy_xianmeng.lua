









local xjBuoy_XianMeng={}


function xjBuoy_XianMeng:onInit()


self.sceneOffset={490,-300,150,-120}
end


function xjBuoy_XianMeng:setSceneOffset(offset)
self.sceneOffset=offset
end


function xjBuoy_XianMeng:getScenePos()
local xmData=xianjieModel:getXianMengData(self.data.guildid)
if xmData~=nil and xmData:checkInCurScene()then
local worldPos=xianjieController:worldGridPos2WorldPos11(xmData.gridX,xmData.gridZ,xmData.gridWidth,xmData.gridHeight,xmData.sceneidx)
if worldPos~=nil then
local pos=xianjieController:getScreenPoint(worldPos)
if pos then
return pos.x,pos.y
end
end
end
return nil,nil
end


function xjBuoy_XianMeng:onCreateWidget(widget)

widget:SetChildButtonClick(0,function()
self:onClick()
end)

local abname=globalABLookup.xjhudicons
local iconname='image_xjbs_3'
widget:SetChildCSImageSprite(1,abname,iconname)

widget:SetChildActive(2,true)
end

function xjBuoy_XianMeng:refreshDesc(widget)
local pos=xianjieController:getCameraLookAtPlanePos()
local gridX,gridZ=xianjieController:worldPos2WorldGridPos(pos.x,pos.z)
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(gridX,gridZ,1,1)

local xmData=xianjieModel:getXianMengData(self.data.guildid)
local dis=mathHelper.distance(gridX_c,gridZ_c,xmData.gridX_c,xmData.gridZ_c)
local unit=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'unit')
dis=math.ceil(dis*unit[1])
widget:SetChildText(3,FMT.fmt('{0}{1}\n{2}',dis,unit[2],xianmengModel:getXMName()or""))
end


function xjBuoy_XianMeng:onRemoveWidget(widget)
widget:SetChildIcon(1,'',false)
end

function xjBuoy_XianMeng:onClick()
if not self:checkWidget()then return end

local xmData=xianjieModel:getXianMengData(self.data.guildid)
if xmData==nil then return end

xianjieController:closeWin3()
xianjieController:jumpGrid(xmData.sceneidx,xmData.gridX_c,xmData.gridZ_c,function()
self:lookBack()
end,false)
end

function xjBuoy_XianMeng:lookBack()
if self.m_ID==nil then return end
self:refreshPos(false)
end


function xjBuoy_XianMeng:onDelete()

end

return xjBuoy_XianMeng