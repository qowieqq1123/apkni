









local xj2DEntity_biaoji={}

function xj2DEntity_biaoji:getIconName()
local sceneEnity=self:getSceneEnity()
local data=sceneEnity:getData()











self.BJkeys={data.bj_x,data.bj_y,data.bj_sceneidx}
self.BJcbId=data.bj_cbid or-22
self.BJiconId=data.bj_iconid or 1
local abname,iconname,desc,iconExtra
local tbarry=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'biaojiicons')or{}
iconname=tbarry[self.BJiconId][1]
abname="ui/windows/xianjie/xianjiemain_explora_atlas_pak.ab"
return abname,iconname,desc,iconExtra
end


function xj2DEntity_biaoji:onCreateWidget(widget)
local abname,iconname,desc,iconExtra=self:getIconName()
if self.xjIconGUID then
xianjieController:removeXjIcon(self.xjIconGUID)
end
self.xjIconGUID=xianjieController:createXjIcon(abname,iconname,iconExtra,widget,0)

widget:SetChildActive(-1,true)
if desc then
if desc[1]then
widget:SetChildText(1,desc[1][1])
widget:SetChildAnchoredPos(1,desc[1][2],desc[1][3])
else
widget:SetChildText(1,'')
end
if desc[2]then
widget:SetChildActive(2,true)
widget:SetChildText(3,desc[2])
else
widget:SetChildActive(2,false)
end
else
widget:SetChildText(1,'')
widget:SetChildActive(2,false)
end
widget:SetChildButtonClick(4,function()
self:onClick()
end)

if self.isHideModel then
widget:SetChildActive(-1,false)
end
end


function xj2DEntity_biaoji:onRemoveWidget(widget)
self.isHideModel=nil
widget:SetChildActive(-1,true)
widget:SetChildIcon(0,'',false)
if self.xjIconGUID then
xianjieController:removeXjIcon(self.xjIconGUID)
end
self.xjIconGUID=nil
end

function xj2DEntity_biaoji:onMyClick()
local sceneEnity=self:getSceneEnity()
local data=sceneEnity:getData()
self.BJkeyId=data.keyId
local BJkeys={data.bj_x,data.bj_y,data.bj_sceneidx}
local BJcbId=data.bj_cbid or-22
local cb=function()
xianjieController.openBJwin(BJkeys[1],BJkeys[2],BJkeys[3],BJcbId)
end
xianjieController:jumpGrid(self.BJkeys[3],self.BJkeys[1],self.BJkeys[2],cb,true)

UIManager:invokeUIMethod('UIXianJie_mapWin','onCloseBtn2')
end


function xj2DEntity_biaoji:onDelete()

end

return xj2DEntity_biaoji