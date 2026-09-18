









local xjEntityHud_mojunBox={}


function xjEntityHud_mojunBox:onInit()
self.needFollow=true

self.uiOffset={Vector2(0,0),Vector2(0,0)}
self.tagOffset={Vector3(0,-3,0),Vector3(0,-6,0)}
self.lastAtkState=nil
end


function xjEntityHud_mojunBox:onCreateWidget(widget)
widget:SetChildActive(1,false)
widget:SetChildActive(2,false)
self:refreshInfo()
end


function xjEntityHud_mojunBox:onRemoveWidget(widget)
widget:SetChildActive(1,false)
widget:SetChildActive(2,false)
end


function xjEntityHud_mojunBox:onDelete()

end

function xjEntityHud_mojunBox:refreshInfo()
local widget=self:getWidget()
if widget then
local data=xianjieModel:getMoJunBoxEntityData(self.data.seasonType,self.data.stageIndex,self.data.boxId)
local state=data.state
if self.oldState~=nil and state==self.oldState then
return
end
widget:SetChildActive(1,false)
widget:SetChildActive(2,state~=0)
local _ab="ui/windows/mojiemojun/mojiemojun_atlas_pak.ab"
if state==1 then
widget:SetChildCSImageSprite(2,_ab,"image_mojun_7")
elseif state==2 then
widget:SetChildCSImageSprite(2,_ab,"image_mojun_8")
end
widget:SetChildScale(2,Vector3.New(2,2,1))
self.oldState=state
end
end

return xjEntityHud_mojunBox