









local zzshEntityInfo_PvPLine={}


function zzshEntityInfo_PvPLine:onInit()
self.teamtype=self.data.teamtype
self:refreshLocalPos()
self.m_line={self.l_x,self.l_y,self.l_e_x,self.l_e_y}
end

function zzshEntityInfo_PvPLine:refreshLocalPos()
local orderData=zhengzhanshanhaiModel:getOrder(self.teamtype)
local g_x,g_y=zhengzhanshanhaiModel:getMyXMGridPos()
self.g_x=g_x
self.g_y=g_y
local l_x,l_y=zhengzhanshanhaiModel:gridPos2localPos(g_x,g_y)
self.l_x=l_x
self.l_y=l_y
local e_x,e_y=orderData:getTargetPos()
self.e_x=e_x
self.e_y=e_y
local l_e_x,l_e_y=zhengzhanshanhaiModel:gridPos2localPos(e_x,e_y)
self.l_e_x=l_e_x
self.l_e_y=l_e_y
end


function zzshEntityInfo_PvPLine:checkInAOI(x1,y1,x2,y2)
local orderData=zhengzhanshanhaiModel:getOrder(self.teamtype)
if orderData then

if mathHelper.posInRect(self.l_x,self.l_y,x1,y1,x2,y2)then
return true
elseif mathHelper.posInRect(self.l_e_x,self.l_e_y,x1,y1,x2,y2)then
return true
elseif mathHelper.lineCrashRect(self.l_x,self.l_y,self.l_e_x,self.l_e_y,x1,y1,x2,y2)then
return true
end
end
return false
end


function zzshEntityInfo_PvPLine:onCreate(widget)
self:refreshLine(widget)
end

function zzshEntityInfo_PvPLine:refreshLine(widget)
if self.teamtype==nil then return end
local check=false
if widget==nil then
widget=self:getWidget()
check=true
end
if widget==nil then return end
if check then
self:refreshLocalPos()
end
local l_x=self.l_x
local l_y=self.l_y
local l_e_x=self.l_e_x
local l_e_y=self.l_e_y

widget:SetChildLocalPos(-1,l_x,l_y,0)

local lineAB,lineIcon=xianmengdigongModel:getLineIcon(1)
widget:SetChildCSImageSprite(0,lineAB,lineIcon)
local dis=mathHelper.distanceEx(l_x,l_y,l_e_x,l_e_y)
widget:SetChildSizeDelta(0,dis,11)
if deviceHelper.getAPILevel()>=70 then
widget:SetChildUVImageScrollSprite(0,0,-0.5,false)
end

local v={1.0,0}
local v2={l_e_x-l_x,l_e_y-l_y}


local dot_v=v[1]*v2[1]+v[2]*v2[2]
local l_A=1.0
local l_B=math.sqrt(v2[1]*v2[1]+v2[2]*v2[2])
local angle=math.acos(dot_v/(l_A*l_B))
local angle_deg=math.deg(angle)

if l_y<=l_e_y then
widget:SetChildRotation(0,0,0,angle_deg)
else
widget:SetChildRotation(0,0,0,-angle_deg)
end
end


function zzshEntityInfo_PvPLine:onReleaseWidget(widget)

widget:SetChildIcon(0,'',false)
end


function zzshEntityInfo_PvPLine:onDelete()

end

return zzshEntityInfo_PvPLine