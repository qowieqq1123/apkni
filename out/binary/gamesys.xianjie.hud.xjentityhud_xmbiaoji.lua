









local xjEntityHud_XMBiaoJi={}
local abname="ui/windows/xianjie/xianjiemain_explora_atlas_pak.ab"

function xjEntityHud_XMBiaoJi:onInit()
self.needFollow=true
self.BJkeyId=self.data.keyId
self.BJkeys={self.data.bj_x,self.data.bj_y,self.data.bj_sceneidx}
self.BJcbId=self.data.bj_cbid or-22
self.BJiconId=self.data.bj_iconid or 1
self.BJcontent=self.data.bj_content or"暂无数据显示"

local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,self.BJcbId)
local cfg_clientParam=cfg.clientParam or{}
local tagOffsetone=cfg_clientParam.tagOffsetone or{0,5.8,0}
local tagOffsetteo=cfg_clientParam.tagOffsettwo or{0,3.5,0}

self.tagTwoIconbg=cfg_clientParam.tagTwoIconbg or{52,55}
self.tagTwoIcon=cfg_clientParam.tagTwoIcon or{40,40}

self.tagOffset={mathHelper.convertArrayToVector(tagOffsetone),mathHelper.convertArrayToVector(tagOffsetteo)}
self.uiOffset={Vector2(0,0),Vector2(0,0)}


end


function xjEntityHud_XMBiaoJi:onCreateWidget(widget)
if widget then
local tbarry=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'biaojiicons')or{}
widget:SetChildCSImageSprite(4,abname,tbarry[self.BJiconId][1])
local str=self:checklengthover(self.BJcontent,8)
widget:SetChildText(1,str)
widget:SetChildSizeDelta(3,self.tagTwoIconbg[1],self.tagTwoIconbg[2])
widget:SetChildSizeDelta(4,self.tagTwoIcon[1],self.tagTwoIcon[2])

widget:SetChildButtonClick(2,function()
self:onClick()
end)
widget:SetChildButtonClick(3,function()
self:onClick()
end)
end
end


function xjEntityHud_XMBiaoJi:onRemoveWidget(widget)

end


function xjEntityHud_XMBiaoJi:refreshInfo()

















end

function xjEntityHud_XMBiaoJi:onClick()
if not self:checkWidget()then return end
xianjieController.openBJwin(self.BJkeys[1],self.BJkeys[2],self.BJkeys[3],self.BJcbId)
end

function xjEntityHud_XMBiaoJi:checklengthover(str,limitnum)
if not str then return''end
if limitnum==8 then
local c=string.toTable(str)
local newstr=''
if c and#c>=limitnum then
newstr=string.format("%s%s%s%s%s%s%s%s...",c[1],c[2],c[3],c[4],c[5],c[6],c[7],c[8])
return newstr or str
else
return str
end
end
return str
end


function xjEntityHud_XMBiaoJi:onDelete()

end

return xjEntityHud_XMBiaoJi