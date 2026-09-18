









local xjEntityHud_clickEmpty={}


function xjEntityHud_clickEmpty:onInit()
self.needFollow=true
end


function xjEntityHud_clickEmpty:onCreateWidget(widget)

widget:SetChildButtonClick(0,function()
self:onClick()
end)
end


function xjEntityHud_clickEmpty:onRemoveWidget(widget)

end

function xjEntityHud_clickEmpty:onClick()
if not self:checkWidget()then return end
local data=self.data
local gridX=data[1]
local gridZ=data[2]
local width=data[3]
local height=data[4]
if xianjieModel:checkGridState3(nil,gridX,gridZ)then
local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(gridX,gridZ,width,height)
local lookAtPos=xianjieController:worldGridPos2WorldPos4(gridX_c,gridZ_c)
xianjieController:lookAtPosition(lookAtPos,nil,0.2,nil,DG.Tweening.Ease.Linear)
else
xianjieController:openEmptyPosWin(gridX,gridZ)
end
xianjieModel:leaveSceneState(xjSceneStateType.eClickEmpty)
end

return xjEntityHud_clickEmpty