









local xjEntityHud2_biaoji={}


function xjEntityHud2_biaoji:onInit()
self.needFollow=true
self.BJkeyId=self.data.keyId
self.BJkeys={self.data.bj_x,self.data.bj_y,self.data.bj_sceneidx}
self.BJcbId=self.data.bj_cbid or-22
self.BJiconId=self.data.bj_iconid or 1
self.BJcontent=self.data.bj_content or"暂无数据显示"
end

function xjEntityHud2_biaoji:getIconName()
local abname,iconname,desc,iconExtra

local tbarry=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'biaojiicons')or{}
iconname=tbarry[self.BJiconId][1]
abname="ui/windows/xianjie/xianjiemain_explora_atlas_pak.ab"
return abname,iconname,desc,iconExtra
end


function xjEntityHud2_biaoji:onCreateWidget(widget)

local abname,iconname,desc,iconExtra=self:getIconName()
if self.xjIconGUID then
xianjieController:removeXjIcon(self.xjIconGUID)
end
widget:SetChildActive(-1,true)
self.xjIconGUID=xianjieController:createXjIcon(abname,iconname,iconExtra,widget,0)
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
widget:SetChildButtonClick(0,function()
self:onClick()
end)

if self.isHideModel then
widget:SetChildActive(-1,false)
end
end


function xjEntityHud2_biaoji:onRemoveWidget(widget)
self.isHideModel=nil
widget:SetChildIcon(0,'',false)
if self.xjIconGUID then
xianjieController:removeXjIcon(self.xjIconGUID)
end
self.xjIconGUID=nil
end

function xjEntityHud2_biaoji:onClick()
if not self:checkWidget()then return end
local cb=function()
xianjieController.openBJwin(self.BJkeys[1],self.BJkeys[2],self.BJkeys[3],self.BJcbId)
end
xianjieController:jumpGrid(self.BJkeys[3],self.BJkeys[1],self.BJkeys[2],cb,true)
end


return xjEntityHud2_biaoji