









local xjBuoy_zongmen={}


function xjBuoy_zongmen:onInit()


self.sceneOffset={490,-300,150,-120}
end


function xjBuoy_zongmen:setSceneOffset(offset)
self.sceneOffset=offset
end


function xjBuoy_zongmen:getScenePos()
local zmData=xianjieModel:getMyZongMenData()
if zmData~=nil and zmData:checkInCurScene()then
local worldPos=xianjieModel:getZongMenWorldPos_1(zmData)
if worldPos~=nil then
local pos=xianjieController:getScreenPoint(worldPos)
if pos then
return pos.x,pos.y
end
end
end
return nil,nil
end


function xjBuoy_zongmen:onCreateWidget(widget)

widget:SetChildButtonClick(0,function()
self:onClick()
end)

local abname=globalABLookup.xjhudicons
local iconname='image_xjbs_3'
widget:SetChildCSImageSprite(1,abname,iconname)

widget:SetChildActive(2,true)
end

function xjBuoy_zongmen:refreshDesc(widget)
local pos=xianjieController:getCameraLookAtPlanePos()
local gridX,gridZ=xianjieController:worldPos2WorldGridPos(pos.x,pos.z)
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(gridX,gridZ,1,1)
local gridX_c_,gridZ_c_=xianjieModel:getZongMenWorldGridCenterPos()
local dis=mathHelper.distance(gridX_c,gridZ_c,gridX_c_,gridZ_c_)
local unit=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'unit')
dis=math.ceil(dis*unit[1])
widget:SetChildText(3,FMT.fmt('{0}{1}',dis,unit[2]))
end


function xjBuoy_zongmen:onRemoveWidget(widget)
widget:SetChildIcon(1,'',false)
end

function xjBuoy_zongmen:onClick()
if not self:checkWidget()then return end
xianjieController:closeWin3()
xianjieModel:jumpMyZongMen(function()
self:lookBack()
end,false)
end

function xjBuoy_zongmen:lookBack()
if self.m_ID==nil then return end
self:refreshPos(false)
end


function xjBuoy_zongmen:onDelete()

end

return xjBuoy_zongmen