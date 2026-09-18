









local _children={
reward=0,
}
local xjEntityHud_MoJun={}


function xjEntityHud_MoJun:onInit()
self.needFollow=true

self.tagOffset={}
table.insert(self.tagOffset,mathHelper.convertArrayToVector({5,10,0}))
self.uiOffset={}
table.insert(self.uiOffset,Vector2(0,0))
end


function xjEntityHud_MoJun:onCreateWidget(widget)
self:refreshInfo(widget)
end


function xjEntityHud_MoJun:onRemoveWidget(widget)

end

function xjEntityHud_MoJun:onClick()
xianjieController:openMoJunWin()
end

function xjEntityHud_MoJun:refreshInfo(widget)
widget=widget or self:getWidget()
if widget==nil then return end

local rewardReddot=xianjieModel:checkHasMoJunJieShuReward()or xianjieModel:checkHasMoJunHurtReward()
widget:SetChildActive(_children.reward,rewardReddot)
widget:SetChildScale(-1,Vector3.New(1.5,1.5,1))
end

return xjEntityHud_MoJun