









local xj2DEntity={}

function xj2DEntity:__init(entityType,iconType,sceneEntityKey,parent)
self.entityType=entityType
self.xjicontype=iconType
self.parent=parent
self.sceneEntityKey=sceneEntityKey

self.m_radius=-1
self:onInit()
end


function xj2DEntity:onInit()

self:refreshLocalPos()
end

function xj2DEntity:getSceneEnity()
return xianjieController:getEntity(self.sceneEntityKey)
end

function xj2DEntity:containType(entityType)
return self.entityType==entityType
end

function xj2DEntity:checkInCircle(g_x,g_y)
if self.m_radius>=0 then
if self.m_radius>0 then
return mathHelper.isInRadius(g_x,g_y,self.g_x,self.g_y,self.m_radius)
else
return g_x==self.g_x and g_y==self.g_y
end
else
return false
end
end


function xj2DEntity:refreshLocalPos()
local sceneEnity=self:getSceneEnity()

local gridX,gridZ=sceneEnity:getGridPos()
self.g_x=gridX
self.g_y=gridZ

local l_x,l_y=xianjieController:gridPos2localPos_2DEnity(self.g_x,self.g_y)
self.l_x=l_x
self.l_y=l_y

local gridwidth,gridheight=sceneEnity:getGridSize()
self.m_radius=gridwidth/2
local baseCfg=xianjieController:get2DMapCfg()
self.m_radius_l=baseCfg.gw*self.m_radius
self.m_rect={self.l_x-self.m_radius_l,self.l_y-self.m_radius_l,self.l_x+self.m_radius_l,self.l_y+self.m_radius_l}
end

function xj2DEntity:getParent()
return self.parent
end

function xj2DEntity:checkWidget()
return self.m_ojbGuid~=nil
end

function xj2DEntity:getWidget()
if self.m_ojbGuid then
local parent=self:getParent()
if parent then
local widget=parent:GetChildExpandUIEx(self.m_ojbGuid)
return widget
end
end
end


function xj2DEntity:createWidget(widget)
widget:SetChildActive(-1,true)
widget:SetChildLocalPos(-1,self.l_x,self.l_y,0)
self:onCreateWidget(widget)
self:refreshUIScale(widget)
end


function xj2DEntity:onCreateWidget(widget)

end


function xj2DEntity:removeWidget(widget)
self:onRemoveWidget(widget)
end


function xj2DEntity:onRemoveWidget(widget)

end

function xj2DEntity:onClick()
if self.clickLockTime~=nil and Time.realtimeSinceStartup-self.clickLockTime<xianjieController.click2DEntityCoolTime then
return
end
if UIManager:invokeUIMethod('UIXianJie_mapWin','checkLockClick')then
UIManager:invokeUIMethod('UIXianJie_mapWin','setClickEntity',self.m_ojbID)
return
end
self.clickLockTime=Time.realtimeSinceStartup
self:onMyClick()
end

function xj2DEntity:onMyClick()

end






function xj2DEntity:__delete()
self:onDelete()
end


function xj2DEntity:onDelete()

end


function xj2DEntity:checkInAOI(x1,y1,x2,y2)


if xianjieController:checkFilterEntity2DRecord(self.xjicontype)then
if self.m_radius_l>0 then

return mathHelper.circleCrashRect(self.l_x,self.l_y,self.m_radius_l,x1,y1,x2,y2)
else

return mathHelper.posInRect(self.l_x,self.l_y,x1,y1,x2,y2)
end
end
return false
end

function xj2DEntity:refreshAOI(x1,y1,x2,y2,mapScale)
if self:checkInAOI(x1,y1,x2,y2)then
local changeScale=self:changeMapScale(mapScale)
if self.m_ojbGuid==nil then
new_xj2DEntityObj(self)
else
if changeScale then
self:refreshUIScale()
end
end
self:enterAOI()
else
release_xj2DEntityObj(self)
self:leaveAOI()
end
end

function xj2DEntity:changeMapScale(mapScale)
local changeScale=false
local oldScale=self.mapScale
if oldScale~=mapScale then
self.mapScale=mapScale
local min=xianjieController.entity2DAutoScaleMin
self.objScale=math.max(min,mapScale)/mapScale
self.itemScale=1.0/mapScale
changeScale=true
end
return changeScale
end

function xj2DEntity:refreshMapScale(mapScale)
if self.m_ojbGuid then
local changeScale=self:changeMapScale(mapScale)
if changeScale then
self:refreshUIScale()
end
end
end


function xj2DEntity:enterAOI()
end


function xj2DEntity:leaveAOI()
end


function xj2DEntity:refreshUIScale(widget)
if widget==nil then
widget=self:getWidget()
end
if widget==nil then return end
local scale=self.objScale
local scale_=Vector3(scale,scale,1)
widget:SetChildScale(-1,scale_)
end



local objID=0
local get_objID=function()
objID=objID+1
return objID
end
local num=50
local pool={}
local fileLookup={}
local objLookup={}
local objWidgetPool={}
local widgetPoolNumMax=30

function check_xj2DEntityObjLookup()
if next(objLookup)then



return false
end
return true
end

function clear_xj2DEntityObjLookup()
objLookup={}
end

function clear_xj2DEntityWidgetPool()
objWidgetPool={}
end

function new_xj2DEntity(entityType,iconType,sceneEntityKey,parent)
local newT
if#pool>0 then
newT=table.remove(pool)
else
newT={}
local mT={




__index=xj2DEntity,
}
setmetatable(newT,mT)







end
local entity2dcfg=cfgHelper.get2(cfg_xianjieentityconfig_get,entityType,'entity2d')
local childname=entity2dcfg[2]
if childname then
local child=fileLookup[entityType]
local filename=FMT.fmt('lua.gamesys.xianjie.entity2D.{0}',childname)
if child==nil then
child=require(filename)
fileLookup[entityType]=child
end
if child==nil then



return
end
for k,v in pairs(child)do
newT[k]=v
end
end
local m_ojbID=get_objID()
newT.m_ojbID=m_ojbID
objLookup[m_ojbID]=newT
newT:__init(entityType,iconType,sceneEntityKey,parent)
return newT
end

function release_xj2DEntity(info)
if info==nil then return end
release_xj2DEntityObj(info)
local m_ojbID=info.m_ojbID
info:__delete()
objLookup[m_ojbID]=nil
local temp={}

for k,v in pairs(info)do
temp[k]=true
end
for k,v in pairs(temp)do
info[k]=nil
end
if#pool>=num then
return
end
table.insert(pool,info)
end

function new_xj2DEntityObj(info)
local m_ojbID=info.m_ojbID
local entityType=info.entityType
local widget_pool=objWidgetPool[entityType]
if widget_pool==nil then
widget_pool={}
objWidgetPool[entityType]=widget_pool
end

local m_ojbGuid
if#widget_pool>0 then

local guid=table.remove(widget_pool)

assert(guid~=nil)

local parent=info:getParent()
local widget=parent:GetChildExpandUIEx(guid)
if widget~=nil then
m_ojbGuid=guid
info.m_ojbGuid=m_ojbGuid
info:createWidget(widget)
else


logErr(FMT.fmt('界面存在无意义的Widget,{0}',guid))

end
end
if m_ojbGuid==nil then

local parent=info:getParent()
local entity2dcfg=cfgHelper.get2(cfg_xianjieentityconfig_get,entityType,'entity2d')
local instanceID=entity2dcfg[1]
local func=function(id)
local info_=objLookup[m_ojbID]
if info_~=nil and info_.m_ojbGuid==id then
local parent_=info_:getParent()
local widget=parent_:GetChildExpandUIEx(id)
if widget~=nil then
info_:createWidget(widget)
end
else

parent:SetChildRemoveExpandUIEx(id)
end
end
m_ojbGuid=parent:SetChildGreateExpandUIEx(-1,instanceID,func)
info.m_ojbGuid=m_ojbGuid
end
end

function release_xj2DEntityObj(info)
local guid=info.m_ojbGuid
if guid~=nil then
info.m_ojbGuid=nil
if UIManager:findActiveWindow('UIXianJie_mapWin')then
local parent=info:getParent()
local widget=parent:GetChildExpandUIEx(guid)
if widget then
local entityType=info.entityType
local widget_pool=objWidgetPool[entityType]
if widget_pool==nil then
widget_pool={}
objWidgetPool[entityType]=widget_pool
end
if#widget_pool>=widgetPoolNumMax then
parent:SetChildRemoveExpandUIEx(guid)
else
info:removeWidget(widget)
widget:SetChildActive(-1,false)
table.insert(widget_pool,guid)
end
else

end
else

end
end
end
