









local xjEntityHud_plotMonster={}


function xjEntityHud_plotMonster:onInit()
local data=self.data
self.cloudid=data[1]
self.plotIdx=data[2]


local cfg=cfgHelper.get2(cfg_fairylandclouddataconfig_get,self.cloudid,self.plotIdx)
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


function xjEntityHud_plotMonster:onCreateWidget(widget)
local cfg=cfgHelper.get2(cfg_fairylandclouddataconfig_get,self.cloudid,self.plotIdx)
local stage=cfg.stage or 1

local abname=globalABLookup.xjhudicons
local iconname=xjMonsterHUDBg[cfg.type or 1]
widget:SetChildCSImageSprite(0,abname,iconname)
widget:SetChildButtonClick(0,function()
self:onClick()
end)

local stage_str=FMT.fmt('{0}阶',stage)
widget:SetChildText(1,stage_str)




end


function xjEntityHud_plotMonster:onRemoveWidget(widget)

end

function xjEntityHud_plotMonster:onClick()
if not self:checkWidget()then return end
xianjieController:createCloudPlotBehavior(self.cloudid,self.plotIdx,true)
end


function xjEntityHud_plotMonster:onDelete()

end

return xjEntityHud_plotMonster