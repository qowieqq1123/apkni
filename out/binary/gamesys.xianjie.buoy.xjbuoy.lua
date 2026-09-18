









local xjBuoy={}

function xjBuoy:__init(buoyType,data)
self.buoyType=buoyType
self.data=data
self.scaleFactor=xianjieController:getUIScaleFactor()
self:onInit()
end


function xjBuoy:onInit()

end


function xjBuoy:getScenePos()

return nil,nil
end


function xjBuoy:getSceneOffset()

return self.sceneOffset
end

function xjBuoy:getParent()
return xianjieController:getBuoyParent()
end

function xjBuoy:checkWidget()
return self.m_widgetID~=nil
end

function xjBuoy:getWidget()
if self.m_widgetID then
local parent=self:getParent()
if parent then
local widget=parent:GetChildExpandUIEx(self.m_widgetID)
return widget
end
end
end

function xjBuoy:checkInView()
local posx,posy=self:getScenePos()
local pos,h_w,h_h
local scaleFactor=self.scaleFactor
if posx~=nil then
local offset=self.sceneOffset
h_w=UnityEngine.Screen.width/2
h_h=UnityEngine.Screen.height/2

local centerX=h_w
local centerY=h_h

local topLeftX=centerX-h_w
local topLeftY=centerY+h_h
local bottomRightX=centerX+h_w
local bottomRightY=centerY-h_h

if posx<topLeftX or posx>bottomRightX
or posy>topLeftY or posy<bottomRightY then

local topLeftX_,topLeftY_,bottomRightX_,bottomRightY_
if offset then
topLeftX_=topLeftX+offset[1]*scaleFactor.x
bottomRightX_=bottomRightX+offset[2]*scaleFactor.x
bottomRightY_=bottomRightY+offset[3]*scaleFactor.y
topLeftY_=topLeftY+offset[4]*scaleFactor.y
else
topLeftX_=topLeftX
bottomRightX_=bottomRightX
bottomRightY_=bottomRightY
topLeftY_=topLeftY
end
local x2=posx
local y2=posy
local lerpX=x2-centerX
local lerpY=y2-centerY
local plist={}
if lerpX==0 then


if x2>=topLeftX_ and x2<=bottomRightX_ then
table.insert(plist,{x2,topLeftY_})
table.insert(plist,{x2,bottomRightY_})
end
elseif lerpY==0 then


if y2>=topLeftY_ and y2<=bottomRightY_ then
table.insert(plist,{topLeftX_,y2})
table.insert(plist,{bottomRightX_,y2})
end
else

local k=lerpY/lerpX
local b=y2-k*x2

table.insert(plist,{(topLeftY_-b)/k,topLeftY_})
table.insert(plist,{(bottomRightY_-b)/k,bottomRightY_})

table.insert(plist,{topLeftX_,k*topLeftX_+b})
table.insert(plist,{bottomRightX_,k*bottomRightX_+b})
end

local d=nil
if#plist>0 then
for i,v in ipairs(plist)do
if v[1]>=topLeftX_ and v[1]<=bottomRightX_ and v[2]<=topLeftY_ and v[2]>=bottomRightY_ then
if pos==nil then
pos=v
d=mathHelper.distance(v[1],v[2],x2,y2)
else
local d2=mathHelper.distance(v[1],v[2],x2,y2)
if d2<d then
pos=v
d=d2
end
end
end
end
end
end
end
if pos then

local v={0,-1}
local v2={posx-pos[1],posy-pos[2]}


local dot_v=v[1]*v2[1]+v[2]*v2[2]
local l_A=1
local l_B=math.sqrt(v2[1]*v2[1]+v2[2]*v2[2])
local angle=math.acos(dot_v/(l_A*l_B))
local angle_deg=math.deg(angle)

if posx<pos[1]then
angle_deg=-angle_deg
end


pos[1]=(pos[1]-h_w)/scaleFactor.x
pos[2]=(pos[2]-h_h)/scaleFactor.y
return pos,angle_deg
end
return nil,nil
end

function xjBuoy:refreshPos(anim)
local pos,angle_deg=self:checkInView()
local check=pos~=nil
if check then
local parent=self:getParent()
if parent then
self.pos=pos
self.angle_deg=angle_deg
self.anim=anim
if self.m_widgetID==nil then
new_xjBuoyWidget(self)
else
self:refreshWidget()
end
else
release_xjBuoyWidget(self)
end
else
release_xjBuoyWidget(self)
end
end


function xjBuoy:createWidget(widget)
widget:SetChildActive(-1,true)
self:onCreateWidget(widget)
self:refreshWidget(widget)
end


function xjBuoy:onCreateWidget(widget)

end


function xjBuoy:refreshWidget(widget)
if widget==nil then
widget=self:getWidget()
end
if widget==nil then return end
local pos=self.pos
local anim=self.anim
if anim==nil or anim==true then
widget:SetChildDOAnchorPos(-1,Vector2.New(pos[1],pos[2]),0.2)
else
widget:SetChildLocalPos(-1,pos[1],pos[2],0)
end
widget:SetChildRotation(0,0,0,self.angle_deg)
self:refreshDesc(widget)
end

function xjBuoy:refreshDesc(widget)

end

function xjBuoy:removeWidget(widget)
self:onRemoveWidget(widget)
end


function xjBuoy:onRemoveWidget(widget)

end







function xjBuoy:__delete()
self:onDelete()
end


function xjBuoy:onDelete()

end



local objID=0
local get_objID=function()
objID=objID+1
return objID
end
local num=2
local pool={}
local fileLookup={}
local objLookup={}
local objWidgetPool={}

function check_xjBuoyLookup()
if next(objLookup)then



return false
end
return true
end

function clear_xjBuoyLookup()
objLookup={}
end

function clear_xjBuoyWidgetPool()
objWidgetPool={}
end

function new_xjBuoy(buoyType,data)
local newT
if#pool>0 then
newT=table.remove(pool)
else
newT={}
local mT={




__index=xjBuoy,
}
setmetatable(newT,mT)







end
local cfg=xjBuoyConfig[buoyType]
local childname=cfg[1]
if childname then
local child=fileLookup[buoyType]
local filename=FMT.fmt('lua.gamesys.xianjie.buoy.{0}',childname)
if child==nil then
child=require(filename)
fileLookup[buoyType]=child
end
if child==nil then



return
end
for k,v in pairs(child)do
newT[k]=v
end
end
local m_ID=get_objID()
newT.m_ID=m_ID
objLookup[m_ID]=newT
newT:__init(buoyType,data)
return newT
end

function release_xjBuoy(obj)
if obj==nil then return end
release_xjBuoyWidget(obj)
local m_ID=obj.m_ID
obj:__delete()
objLookup[m_ID]=nil
local temp={}

for k,v in pairs(obj)do
temp[k]=true
end
for k,v in pairs(temp)do
obj[k]=nil
end
if#pool>=num then
return
end
table.insert(pool,obj)
end

function new_xjBuoyWidget(obj)
local m_ID=obj.m_ID
local buoyType=obj.buoyType
local widget_pool=objWidgetPool[buoyType]
if widget_pool==nil then
widget_pool={}
objWidgetPool[buoyType]=widget_pool
end
local parent=xianjieController:getBuoyParent()
local m_widgetID
if#widget_pool>0 then

local guid=table.remove(widget_pool)

assert(guid~=nil)

local widget=parent:GetChildExpandUIEx(guid)
if widget~=nil then
m_widgetID=guid
obj.m_widgetID=m_widgetID
obj:createWidget(widget)
else


logErr(FMT.fmt('界面存在无意义的Widget,{0}',guid))

end
end
if m_widgetID==nil then

local cfg=xjBuoyConfig[buoyType]
local instanceID=cfg[2]
local func=function(id)
local obj_=objLookup[m_ID]
if obj_~=nil and obj_.m_widgetID==id then
local widget=parent:GetChildExpandUIEx(id)
if widget~=nil then
obj_:createWidget(widget)
end
else

parent:SetChildRemoveExpandUIEx(id)
end
end
m_widgetID=parent:SetChildGreateExpandUIEx(-1,instanceID,func)
obj.m_widgetID=m_widgetID
end
end

function release_xjBuoyWidget(obj)
local guid=obj.m_widgetID
if guid~=nil then
obj.m_widgetID=nil
local parent=xianjieController:getBuoyParent()
if parent then
local widget=parent:GetChildExpandUIEx(guid)
if widget then
local buoyType=obj.buoyType
local widget_pool=objWidgetPool[buoyType]
if widget_pool==nil then
widget_pool={}
objWidgetPool[buoyType]=widget_pool
end
local cfg=xjBuoyConfig[buoyType]
local poolnum=cfg[3]
if#widget_pool>=poolnum then
parent:SetChildRemoveExpandUIEx(guid)
else
obj:removeWidget(widget)
widget:SetChildActive(-1,false)
table.insert(widget_pool,guid)
end
else

end
else

end
end
end
