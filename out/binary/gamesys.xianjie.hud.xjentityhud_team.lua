









local xjEntityHud_team={}


function xjEntityHud_team:onInit()
self.needFollow=true



local teamHandle=self:getTeamHandle()
local marchtype=teamHandle:getMarchtype()
local hudSet=xianjieModel.getMarchTeamHudSet(marchtype)
if hudSet.tagOffset then
self.tagOffset={}
local offset=hudSet.tagOffset[1]
self.tagOffset[1]=offset and mathHelper.convertArrayToVector(offset)or Vector3.zero
else
self.tagOffset={Vector3.zero}
end
if hudSet.uiOffset then
self.uiOffset={}
local offset=hudSet.uiOffset[1]
self.uiOffset[1]=offset and mathHelper.convertArrayToVector(offset)or Vector2(0,0)
else
self.uiOffset={Vector2(0,0)}
end
end


function xjEntityHud_team:onCreateWidget(widget)

widget:SetChildButtonClick(0,function()
self:onBGClick()
end)

self:refreshTime(widget)
end

function xjEntityHud_team:refreshTime(widget)
local teamHandle=self:getTeamHandle()
local lerpTime=teamHandle:geLerpTime()
lerpTime=math.ceil(lerpTime)
local time_str=timeHelper.format_time_stamp(lerpTime,true)
widget:SetChildText(3,time_str)
end


function xjEntityHud_team:onSelectHandle(widget,isSelect)
if isSelect then
widget:SetChildActive(1,true)
local teamHandle=self:getTeamHandle()
local name=teamHandle:getOwnerName()
widget:SetChildText(2,name)
else
widget:SetChildActive(1,false)
end
end


function xjEntityHud_team:onRemoveWidget(widget)

end

function xjEntityHud_team:onBGClick()
if not self:checkWidget()then return end










local clickEntKey=self.m_key
xianjieModel:enterSceneState_clickTeam_before(clickEntKey)
end


function xjEntityHud_team:onUpdate()
local widget=self:getWidget()
if widget then
self:refreshTime(widget)
end
end

function xjEntityHud_team:getTeamHandle()
return xianjieController:invokeEntityFunc(self.m_key,'getTeamHandle')
end

return xjEntityHud_team
