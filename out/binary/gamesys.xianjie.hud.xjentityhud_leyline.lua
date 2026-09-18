









local xjEntityHud_npc={}


function xjEntityHud_npc:onInit()
self.needFollow=true

self.uiOffset={}
table.insert(self.uiOffset,Vector2(0,0))
table.insert(self.uiOffset,Vector2(0,0))

local tagOffset=cfgHelper.get3(cfg_fairylandclientbuildconfig_get,xjClientBuildType.flcbXianYuLingMai,"clientParam","tagOffset")
self.tagOffset={}
table.insert(self.tagOffset,tagOffset[1]and mathHelper.convertArrayToVector(tagOffset[1])or Vector3.zero)
table.insert(self.tagOffset,tagOffset[2]and mathHelper.convertArrayToVector(tagOffset[2])or Vector3.zero)
end


function xjEntityHud_npc:onCreateWidget(widget)

local name=cfgHelper.get2(cfg_fairylandclientbuildconfig_get,xjClientBuildType.flcbXianYuLingMai,"name")
widget:SetChildText(0,name)

local data=xianjieModel:getLeyLineData()
local timeStr=timeHelper.format_time_stamp(math.ceil(data:getBaseWayTime()))
widget:SetChildText(3,timeStr)
end


function xjEntityHud_npc:onRemoveWidget(widget)

end

function xjEntityHud_npc:refreshInfo()
local widget=self:getWidget()
if widget then
local data=xianjieModel:getLeyLineData()
local timeStr=timeHelper.format_time_stamp(math.ceil(data:getBaseWayTime()))
widget:SetChildText(3,timeStr)
end
end

function xjEntityHud_npc:onClick()
if not self:checkWidget()then return end



end


function xjEntityHud_npc:onDelete()

end

return xjEntityHud_npc