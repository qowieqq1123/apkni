









local zzshEntityInfo={}

function zzshEntityInfo:__init(entityType,data,parent)
self.entityType=entityType
self.data=data or{}
self.parent=parent
self.sortLayer=self.data.sortLayer
self.sortOrder=self.data.sortOrder
self.sortOrder2=self.data.sortOrder2
self.sortOrder3=self.data.sortOrder3

self.m_radius=-1
self:onInit()
end


function zzshEntityInfo:onInit()

self:refreshLocalPos()
end

function zzshEntityInfo:containType(entityType)
return self.entityType==entityType
end

function zzshEntityInfo:containKey(key)
return false
end

function zzshEntityInfo:checkInCircle(g_x,g_y)
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


function zzshEntityInfo:getName()
return nil
end


function zzshEntityInfo:refreshLocalPos()
self.g_x=self.data[1]
self.g_y=self.data[2]
local l_x,l_y=zhengzhanshanhaiModel:gridPos2localPos(self.g_x,self.g_y)
self.l_x=l_x
self.l_y=l_y
end

function zzshEntityInfo:getParent()
return self.parent
end

function zzshEntityInfo:checkWidget()
return self.m_ojbGuid~=nil
end

function zzshEntityInfo:getWidget()
if self.m_ojbGuid then
local parent=self:getParent()
if parent then
local widget=parent:GetChildExpandUIEx(self.m_ojbGuid)
return widget
end
end
end


function zzshEntityInfo:create(widget)
widget:SetChildActive(-1,true)
self:onCreate(widget)
self:refreshUIScale(widget)
end


function zzshEntityInfo:onCreate(widget)

end


function zzshEntityInfo:onReleaseWidget(widget)

end

function zzshEntityInfo:onClick()
if self.clickLockTime~=nil and gameUtilityModel.getServerShortTime()-self.clickLockTime<zhengzhanshanhaiModel.clickEntityCoolTime then
return
end
if UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','checkLockClick')then
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','setClickEntity',self.m_ojbID)
return
end
self.clickLockTime=gameUtilityModel.getServerShortTime()
self:onMyClick()
end

function zzshEntityInfo:onMyClick()

end






function zzshEntityInfo:__delete()
self:onDelete()
end


function zzshEntityInfo:onDelete()

end


function zzshEntityInfo:checkInAOI(x1,y1,x2,y2)
return mathHelper.posInRect(self.l_x,self.l_y,x1,y1,x2,y2)
end

function zzshEntityInfo:refreshAOI(x1,y1,x2,y2,mapScale)
if self:checkInAOI(x1,y1,x2,y2)then
local changeScale=self:changeMapScale(mapScale)
if self.m_ojbGuid==nil then
new_zzshEntityObj(self)
else
if changeScale then
self:refreshUIScale()
end
end
self:enterAOI()
else
release_zzshEntityObj(self)
self:leaveAOI()
end
end

function zzshEntityInfo:changeMapScale(mapScale)
local changeScale=false
local oldScale=self.mapScale
if oldScale~=mapScale then
self.mapScale=mapScale
local min=zhengzhanshanhaiModel:get_entityAutoScaleMin()
self.objScale=math.max(min,mapScale)/mapScale
self.itemScale=1.0/mapScale
changeScale=true
end
return changeScale
end

function zzshEntityInfo:refreshMapScale(mapScale)
if self.m_ojbGuid then
local changeScale=self:changeMapScale(mapScale)
if changeScale then
self:refreshUIScale()
end
end
end


function zzshEntityInfo:enterAOI()
end


function zzshEntityInfo:leaveAOI()
end


function zzshEntityInfo:refreshUIScale(widget)
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

function check_zzshObjLookup()
if next(objLookup)then



return false
end
return true
end

function clear_zzshObjLookup()
objLookup={}
end






function clear_zzshWidgetPool()
objWidgetPool={}
end

function new_zzshEntityInfo(entityType,data,parent)
local newT
if#pool>0 then
newT=table.remove(pool)
else
newT={}
local mT={




__index=zzshEntityInfo,
}
setmetatable(newT,mT)







end
local typecfg=zzshEntityCfgs[entityType]
local childname=typecfg[1]
if childname then
local child=fileLookup[entityType]
local filename=FMT.fmt('lua.gamesys.xianmeng.act.zhengzhanshanhai.entity.{0}',childname)
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
newT:__init(entityType,data,parent)
return newT
end

function release_zzshEntityInfo(info)
if info==nil then return end
release_zzshEntityObj(info)
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

function new_zzshEntityObj(info)
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
info:create(widget)
else


logErr(FMT.fmt('界面存在无意义的Widget,{0}',guid))

end
end
if m_ojbGuid==nil then

local parent=info:getParent()
local typecfg=zzshEntityCfgs[entityType]
local instanceID=typecfg[2]
local func=function(id)
local info_=objLookup[m_ojbID]
if info_~=nil and info_.m_ojbGuid==id then
local parent_=info_:getParent()
local widget=parent_:GetChildExpandUIEx(id)
if widget~=nil then
info_:create(widget)
end
else

parent:SetChildRemoveExpandUIEx(id)
end
end
m_ojbGuid=parent:SetChildGreateExpandUIEx(-1,instanceID,func)
info.m_ojbGuid=m_ojbGuid
end
end

function release_zzshEntityObj(info)
local guid=info.m_ojbGuid
if guid~=nil then
info.m_ojbGuid=nil
if UIManager:findActiveWindow('UIXM_ZZSH_MapWin')then
local parent=info:getParent()
local widget=parent:GetChildExpandUIEx(guid)
if widget then
local entityType=info.entityType
local widget_pool=objWidgetPool[entityType]
if widget_pool==nil then
widget_pool={}
objWidgetPool[entityType]=widget_pool
end
local typecfg=zzshEntityCfgs[entityType]
local poolnum=typecfg[3]
if#widget_pool>=poolnum then
parent:SetChildRemoveExpandUIEx(guid)
else
info:onReleaseWidget(widget)
widget:SetChildActive(-1,false)
table.insert(widget_pool,guid)
end
else

end
else

end
end
end
