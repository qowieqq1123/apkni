









local xjBuoy_biaoji={}


function xjBuoy_biaoji:onInit()


self.sceneOffset={490,-300,150,-120}
self.showlodLevel=2

self.BJkeyId=self.data.keyId
self.BJkeys={self.data.bj_x,self.data.bj_y,self.data.bj_sceneidx}
self.BJcbId=self.data.bj_cbid or-22
self.BJiconId=self.data.bj_iconid or 1
end


function xjBuoy_biaoji:setSceneOffset(offset)
self.sceneOffset=offset
end


function xjBuoy_biaoji:getScenePos()
if xianjieController.curlodLevel<self.showlodLevel then
return nil,nil
end
local zbData=xianjieModel:getZBDataBykeyId(self.BJkeyId)
if zbData~=nil and zbData:checkInCurScene()then
local worldPos=zbData:getWorldPos_1()
if worldPos~=nil then
local pos=xianjieController:getScreenPoint(worldPos)
if pos then
return pos.x,pos.y
end
end
end
return nil,nil
end


function xjBuoy_biaoji:onCreateWidget(widget)

widget:SetChildButtonClick(0,function()
self:onClick()
end)

local abname="ui/windows/xianjie/xianjiemain_explora_atlas_pak.ab"
local tbarry=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'biaojiicons')or{}
local iconname=tbarry[self.BJiconId][1]
widget:SetChildCSImageSprite(1,abname,iconname)

widget:SetChildActive(2,true)
end

function xjBuoy_biaoji:refreshDesc(widget)

local pos=xianjieController:getCameraLookAtPlanePos()
local gridX,gridZ=xianjieController:worldPos2WorldGridPos(pos.x,pos.z)
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(gridX,gridZ,1,1)
local gridX_c_,gridZ_c_=xianjieModel:getZongMenWorldGridCenterPos()
local dis=mathHelper.distance(gridX_c,gridZ_c,gridX_c_,gridZ_c_)
local unit=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'unit')
dis=math.ceil(dis*unit[1])
widget:SetChildText(3,FMT.fmt('{0}{1}',dis,unit[2]))

end


function xjBuoy_biaoji:onRemoveWidget(widget)
widget:SetChildIcon(1,'',false)
end

function xjBuoy_biaoji:onClick()
if not self:checkWidget()then return end
xianjieController:closeWin3()

self:jumpBJPos(function()
self:lookBack()
end,false)
end

function xjBuoy_biaoji:lookBack()
if self.m_ID==nil then return end
self:refreshPos(false)
end


function xjBuoy_biaoji:onDelete()

end



function xjBuoy_biaoji:jumpBJPos(cb)

xianjieController:jumpGrid(self.BJkeys[3],self.BJkeys[1],self.BJkeys[2],cb,true)
end

return xjBuoy_biaoji