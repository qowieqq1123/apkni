









local zzshEntityInfo_monsterPos={}


function zzshEntityInfo_monsterPos:onInit()
self:refreshLocalPos()
self.m_radius=self.data[3]
local baseCfg=zhengzhanshanhaiModel:get_mapBaseCfg()
self.m_radius_l=baseCfg.gw*self.m_radius
self.m_rect={self.l_x-self.m_radius_l,self.l_y-self.m_radius_l,self.l_x+self.m_radius_l,self.l_y+self.m_radius_l}
end


function zzshEntityInfo_monsterPos:checkInAOI(x1,y1,x2,y2)
if self.m_radius_l>0 then

return mathHelper.circleCrashRect(self.l_x,self.l_y,self.m_radius_l,x1,y1,x2,y2)
else

return mathHelper.posInRect(self.l_x,self.l_y,x1,y1,x2,y2)
end
end


function zzshEntityInfo_monsterPos:onCreate(widget)
widget:SetChildLocalPos(-1,self.l_x,self.l_y,0)



local size=self.m_radius*zhengzhanshanhaiModel.grid2CircleEffect
self.circleSize=size
self:refreshCircleSign(widget)
end

function zzshEntityInfo_monsterPos:refreshCircleSign(widget)
if self.m_ojbGuid==nil then return end
if widget==nil then
widget=self:getWidget()
end
if widget==nil then return end
local showCircle=UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','checkInMoveModel')
if showCircle then
self.showCircle=true

widget:SetChildShowEffectEx(0,10534,self.sortLayer,self.sortOrder2-1,true)
widget:SetChildScale(0,Vector3(self.circleSize,self.circleSize,self.circleSize))
else
self.showCircle=nil
widget:SetChildShowEffect(0,0,false)
end
end


function zzshEntityInfo_monsterPos:onReleaseWidget(widget)

if self.showCircle then
self.showCircle=nil
widget:SetChildShowEffect(0,0,false)
end
end


function zzshEntityInfo_monsterPos:onDelete()

end

return zzshEntityInfo_monsterPos