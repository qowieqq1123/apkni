









local xjEntityHud_xianmeng={}


function xjEntityHud_xianmeng:onInit()
self.needFollow=true


local hudSet=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'hudSet_xm')
local tagOffset=hudSet.tagOffset
self.tagOffset={}
for i=1,2 do
local offset=tagOffset~=nil and tagOffset[i]or nil
self.tagOffset[i]=offset and mathHelper.convertArrayToVector(offset)or Vector3.zero
end
local uiOffset=hudSet.uiOffset
self.uiOffset={}
for i=1,2 do
local offset=uiOffset~=nil and uiOffset[i]or nil
self.uiOffset[i]=offset and mathHelper.convertArrayToVector(offset)or Vector2(0,0)
end

local data=self.data
self.guildid=data[1]
self.guildid_str=mathHelper.int64_to_string(self.guildid)
end


function xjEntityHud_xianmeng:onCreateWidget(widget)
local xmData=xianjieModel:getXianMengDataEx(self.guildid_str)
local name=xmData.guildname
widget:SetChildText(0,name)
widget:SetChildButtonClick(1,function()
self:onClick()
end)
local isMyXM=xianmengModel:isMyXM2(self.guildid)
local hadZF=xianjieModel:haveSelfDefendXianMengTeamData(self.guildid)
widget:SetChildActive(2,isMyXM and hadZF)
widget:SetChildText(3,isMyXM and hadZF and"驻防中"or"")
end


function xjEntityHud_xianmeng:onRemoveWidget(widget)

end

function xjEntityHud_xianmeng:onClick()
if not self:checkWidget()then return end
xianjieController:openXianMengWin(self.guildid)
end

return xjEntityHud_xianmeng