









local xjEntityHud_ceEnter={}


function xjEntityHud_ceEnter:onInit()
self.needFollow=true

self.uiOffset={Vector2(0,0),}
self.tagOffset={Vector3(4,5,0)}
local data=self.data
end


function xjEntityHud_ceEnter:onCreateWidget(widget)
return self:initShow(widget)
end


function xjEntityHud_ceEnter:onRemoveWidget(widget)

end

function xjEntityHud_ceEnter:initShow(widget)

self:refreshRewardFlag(widget)


widget:SetChildButtonClick(1,function()
return self:onClick()
end,true)
end

function xjEntityHud_ceEnter:refreshInfo()
local widget=self:getWidget()
if widget then

self:refreshRewardFlag(widget)
end
end

function xjEntityHud_ceEnter:refreshRewardFlag(widget)
local hasReward=xianJieCaravanEscortModel:checkSelfEscortShipPosHasReward()
widget:SetChildActive(0,hasReward)
end

function xjEntityHud_ceEnter:resetShow()
local widget=self:getWidget()
if widget then
return self:initShow(widget)
end
end

function xjEntityHud_ceEnter:onClick()
if not self:checkWidget()then return end

UIFullXJCaravanEscortController:showMainWindow()
end


function xjEntityHud_ceEnter:onDelete()

end











return xjEntityHud_ceEnter