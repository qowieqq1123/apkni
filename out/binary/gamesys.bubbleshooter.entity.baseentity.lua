









local baseEntity={}

function baseEntity:__init(entityType,data,parent)
self.entityType=entityType
self.data=data or{}
self.parent=parent

self:onInit()
end


function baseEntity:onInit()

end

function baseEntity:containType(entityType)
return self.entityType==entityType
end


function baseEntity:getParent()
return self.parent
end

function baseEntity:checkWidget()
return self.m_ojbGuid~=nil
end

function baseEntity:getWidget()
if self.m_ojbGuid then
local parent=self:getParent()
if parent then
local widget=parent:GetChildExpandUIEx(self.m_ojbGuid)
return widget
end
end
end


function baseEntity:create(widget)
widget:SetChildActive(-1,true)
self:onCreateWidget(widget)









end


function baseEntity:onCreateWidget(widget)

end


function baseEntity:onRemoveWidget(widget)

end







function baseEntity:__delete()
self:onDelete()
end


function baseEntity:onDelete()

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

function check_bbBallObjLookup()
if next(objLookup)then



return false
end
return true
end

function clear_bbBallObjLookup()
objLookup={}
end

function clear_bbBallWidgetPool()
objWidgetPool={}
end

function new_bbEntity(entityType,data,parent)
local newT
if#pool>0 then
newT=table.remove(pool)
else
newT={}
local mT={




__index=baseEntity,
}
setmetatable(newT,mT)







end
local typecfg=bubbleShooterEnityCfgs[entityType]
local childname=typecfg[1]
if childname then
local child=fileLookup[entityType]
local filename=FMT.fmt('lua.gamesys.bubbleShooter.entity.{0}',childname)
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

function release_bbEntity(ent)
if ent==nil then return end
release_bbEntityObj(ent)
local m_ojbID=ent.m_ojbID
ent:__delete()
objLookup[m_ojbID]=nil
local temp={}

for k,v in pairs(ent)do
temp[k]=true
end
for k,v in pairs(temp)do
ent[k]=nil
end
if#pool>=num then
return
end
table.insert(pool,ent)
end

function new_bbEntityObj(ent)
local m_ojbID=ent.m_ojbID
local entityType=ent.entityType
local widget_pool=objWidgetPool[entityType]
if widget_pool==nil then
widget_pool={}
objWidgetPool[entityType]=widget_pool
end

local m_ojbGuid
if#widget_pool>0 then

local guid=table.remove(widget_pool)

assert(guid~=nil)

local parent=ent:getParent()
local widget=parent:GetChildExpandUIEx(guid)
if widget~=nil then
m_ojbGuid=guid
ent.m_ojbGuid=m_ojbGuid
ent:create(widget)
else


logErr(FMT.fmt('界面存在无意义的Widget,{0}',guid))

end
end
if m_ojbGuid==nil then

local parent=ent:getParent()
local typecfg=bubbleShooterEnityCfgs[entityType]
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
ent.m_ojbGuid=m_ojbGuid
end
end

function release_bbEntityObj(ent)
local guid=ent.m_ojbGuid
if guid~=nil then
ent.m_ojbGuid=nil
if UIManager:findActiveWindow('UIBubbleShooterWin')then
local parent=ent:getParent()
local widget=parent:GetChildExpandUIEx(guid)
if widget then
local entityType=ent.entityType
local widget_pool=objWidgetPool[entityType]
if widget_pool==nil then
widget_pool={}
objWidgetPool[entityType]=widget_pool
end
local typecfg=bubbleShooterEnityCfgs[entityType]
local poolnum=typecfg[3]
if#widget_pool>=poolnum then
parent:SetChildRemoveExpandUIEx(guid)
else
ent:onRemoveWidget(widget)
widget:SetChildActive(-1,false)
table.insert(widget_pool,guid)
end
else

end
else

end
end
end
