









local xjEntity_mojieFog={}


function xjEntity_mojieFog:onInit()
local data=self.data
self.pos=Vector3(data.pos[1],data.pos[2],data.pos[3])
self.size=Vector2.New(10000,10000)

end


function xjEntity_mojieFog:onCreateWidget(widget)

self:refreshInfo()
end


function xjEntity_mojieFog:onRemoveWidget(widget)

end



function xjEntity_mojieFog:refreshInfo()
local widget=self:getWidget()
if widget then
local fogId=xianjieController:getSeaonCurFogId(self.data.seasonID)

for index=fogId,1,-1 do
local w1=index*2-2
local w2=index*2-1

widget:SetChildActive(w1,false)
widget:SetChildActive(w2,false)
end
end

end


function xjEntity_mojieFog:onMyClick(boxParams)

end

function xjEntity_mojieFog:playFogDissipate(stageFogId)
local widget=self:getWidget()
if widget then
widget:SetChildAnimatorInteger(6,'stateId',stageFogId,false)
widget:SetChildAnimatorParameter(6,'isPlayAni','trigger','')
else



end
end

return xjEntity_mojieFog
