









local xjEntityHud_RPMystery={}


function xjEntityHud_RPMystery:onInit()
self.dataGuid=self.data.guid
local data=xianjieModel:getResPointData(self.dataGuid)
local cfg=data:getCfg()
self.needFollow=true

local uiOffset=cfg.uiOffset
local tagOffset=cfg.tagOffset
if uiOffset then
self.uiOffset={}
table.insert(self.uiOffset,Vector2(uiOffset[1],uiOffset[2]))
end
if tagOffset then
self.tagOffset={}
table.insert(self.tagOffset,Vector3(tagOffset[1],tagOffset[2],tagOffset[3]))
end
end


function xjEntityHud_RPMystery:onCreateWidget(widget)
local data=xianjieModel:getResPointData(self.dataGuid)
local cfg=data:getCfg()
local mysteryCfg=cfgHelper.get1(cfg_secretscenefubenconfig_get,cfg.mystery)
if not mysteryCfg then
loggerUtil.logErrFMT("秘境配置不存在{0}",self.data[2])
return
end
local fb_color=mysteryCfg.color
local name=string.gsub(mysteryCfg.name,' ','\n')
local difficulty_text_color=cfg_secretscenebaseconfig_get(1).fb_quality
local color_cfg=difficulty_text_color[fb_color]
local colorStr=color_cfg[3]
widget:SetChildText(0,colorStr and FMT.fmt("<color=#{0}>{1}</color>",colorStr,name)or FMT.cfmt(fb_color,name))
widget:SetChildButtonClick(1,function()
xianjieController:onClickResPoint(self.dataGuid)
end)
self:refreshInfo()
end


function xjEntityHud_RPMystery:onRemoveWidget(widget)

end


function xjEntityHud_RPMystery:onDelete()

end

function xjEntityHud_RPMystery:refreshInfo()
local widget=self:getWidget()
if widget then
local march=xianjieModel:getResPointMarch(self.dataGuid)
local tansuo_ing=march~=nil
widget:SetChildActive(2,tansuo_ing)
end
end

return xjEntityHud_RPMystery