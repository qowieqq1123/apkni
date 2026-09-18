









local xjEntityHud={}

function xjEntityHud:__init(hudType,entityType,key,data)
self.hudType=hudType
self.entityType=entityType
self.m_key=key
self.data=data
if self.data.husParams then

self.husParams=self.data.husParams
else
if self.data.lodLevel<=-1 then

local lodRange=xianjieController:getCameraLodRange()
self.husParams={-1,lodRange[1],1,1,1,1}
end
end
self.canSelect,self.isSelectMark=xianjieController:invokeEntityFunc(self.m_key,'checkCanSelect')
self:onInit()
if self.uiOffset==nil then
if self.tagOffset then
self.uiOffset={}
for i=1,#self.tagOffset do
table.insert(self.uiOffset,Vector2(0,0))
end
else
self.uiOffset={Vector2(0,0),}
end
end
if self.tagOffset==nil then
if self.uiOffset then
self.tagOffset={}
for i=1,#self.uiOffset do
table.insert(self.tagOffset,Vector3.zero)
end
else
self.tagOffset={Vector3.zero,}
end
end
end


function xjEntityHud:onInit()
self.needFollow=false



end

function xjEntityHud:getHudParams()
local husParams=self.husParams
if husParams==nil then
husParams=xianjieController:getHudParams(self.hudType)
end
return husParams
end

function xjEntityHud:getParent()
return xianjieController:getHUDParent(self.entityType)
end

function xjEntityHud:checkWidget()
return self.m_widgetID~=nil
end

function xjEntityHud:getWidget()
if self.m_widgetID then
local parent=self:getParent()
if parent then
local widget=parent:GetChildExpandUIEx(self.m_widgetID)
return widget
end
end
end


function xjEntityHud:createWidget(widget)
widget:SetChildActive(-1,true)
local ent=xianjieController:getEntity(self.m_key)
local tagOffset=self.tagOffset
local uiOffset=self.uiOffset
local husParams=self:getHudParams()
if not check_xjEntityHudNoWidget(self.hudType)then
local trans=ent:getHudBindingTransform()
if trans then
widget:SetChildUIFollowWorldTransformInitObj(-1,trans,tagOffset,uiOffset,self.needFollow,husParams)
else
local pos=ent:getPos()
widget:SetChildUIFollowWorldTransformInitPos(-1,pos,tagOffset,uiOffset,self.needFollow,husParams)
end
else
local pos=ent:getPos()
widget:SetChildUIFollowWorldTransformInitPos(-1,pos,tagOffset,uiOffset,self.needFollow,husParams)
end
if self.canSelect then
if self.isSelectMark then
self.isSelectMark=nil
self:onSelectHandle(widget,true)
else
self:onSelectHandle(widget,false)
end
end
self:onCreateWidget(widget)
end


function xjEntityHud:onCreateWidget(widget)

end

function xjEntityHud:removeWidget(widget)
widget:SetChildUIFollowWorldTransformStop(-1)
self:onRemoveWidget(widget)
end


function xjEntityHud:onRemoveWidget(widget)

end


function xjEntityHud:onSelect(widget,isSelect)
if not self.canSelect then return end

if widget==nil then
widget=self:getWidget()
end
if widget then
self:onSelectHandle(widget,isSelect)
else
if isSelect then
self.isSelectMark=isSelect
end
end
end


function xjEntityHud:onSelectHandle(widget,isSelect)

end







function xjEntityHud:__delete()
self:onDelete()
end


function xjEntityHud:onDelete()

end



local objID=0
local get_objID=function()
objID=objID+1
return objID
end
local num=50
local pool={}
local fileLookup={{},{},{}}
local objLookup={}
local objWidgetPool={{},{},{}}

local function get_xjEntityHudCfg(entityType,hudType)
local cfg=cfgHelper.get1(cfg_xianjieentityconfig_get,entityType)
local hud
if hudType==1 then
hud=cfg.hud1
elseif hudType==2 then
hud=cfg.hud2
elseif hudType==3 then
hud=cfg.hudEx
end
return hud
end

function check_xjEntityHudNoWidget(hudType)
return hudType==2
end

function check_xjEntityHudLookup()
if next(objLookup)then



return false
end
return true
end

function clear_xjEntityHudLookup()
objLookup={}
end

function clear_xjEntityHudWidgetPool()
objWidgetPool={{},{},{}}
end

function new_xjEntityHud(hudType,entityType,key,data)
local newT
if#pool>0 then
newT=table.remove(pool)
else
newT={}
local mT={




__index=xjEntityHud,
}
setmetatable(newT,mT)







end
local childname
local hudcfg=get_xjEntityHudCfg(entityType,hudType)
if hudcfg then
childname=hudcfg[2]
end
if childname then
local child=fileLookup[hudType][entityType]
local filename
if hudType==1 or hudType==3 then
filename=FMT.fmt('lua.gamesys.xianjie.hud.{0}',childname)
elseif hudType==2 then
filename=FMT.fmt('lua.gamesys.xianjie.hud2.{0}',childname)
end
if child==nil then
child=require(filename)
fileLookup[hudType][entityType]=child
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
newT:__init(hudType,entityType,key,data)

if not check_xjEntityHudNoWidget(hudType)then
if xianjieController:invokeEntityFunc(key,'checkWidget')then
new_xjEntityHudWidget(newT)
end
else
new_xjEntityHudWidget(newT)
end
return newT
end

function release_xjEntityHud(hud)
if hud==nil then return end
release_xjEntityHudWidget(hud)
local m_ID=hud.m_ID

assert(m_ID~=nil)
hud:__delete()
objLookup[m_ID]=nil
local temp={}

for k,v in pairs(hud)do
temp[k]=true
end
for k,v in pairs(temp)do
hud[k]=nil
end
if#pool>=num then
return
end
table.insert(pool,hud)
end

function new_xjEntityHudWidget(hud)
local guid_=hud.m_widgetID
if guid_==nil then
local m_ID=hud.m_ID
local hudType=hud.hudType
local entityType=hud.entityType
local widget_pool=objWidgetPool[hudType][entityType]
if widget_pool==nil then
widget_pool={}
objWidgetPool[hudType][entityType]=widget_pool
end
local parent=xianjieController:getHUDParent(entityType)
local m_widgetID
if#widget_pool>0 then

local guid=table.remove(widget_pool)

assert(guid~=nil)

local widget=parent:GetChildExpandUIEx(guid)
if widget~=nil then
m_widgetID=guid
hud.m_widgetID=m_widgetID
hud:createWidget(widget)
else


logErr(FMT.fmt('界面存在无意义的Widget,{0}',guid))

end
end
if m_widgetID==nil then

local hudcfg=get_xjEntityHudCfg(entityType,hudType)
local instanceID=hudcfg[1]
local func=function(id)
local hud_=objLookup[m_ID]
if hud_~=nil and hud_.m_widgetID==id then
local widget=parent:GetChildExpandUIEx(id)
if widget~=nil then
hud_:createWidget(widget)
end
else

parent:SetChildRemoveExpandUIEx(id)
end
end
m_widgetID=parent:SetChildGreateExpandUIEx(-1,instanceID,func)
hud.m_widgetID=m_widgetID
end
end
end

function release_xjEntityHudWidget(hud)
local guid=hud.m_widgetID
if guid~=nil then
hud.m_widgetID=nil
local entityType=hud.entityType
local parent=xianjieController:getHUDParent(entityType)
if parent then
local widget=parent:GetChildExpandUIEx(guid)
if widget then
local hudType=hud.hudType
local widget_pool=objWidgetPool[hudType][entityType]
if widget_pool==nil then
widget_pool={}
objWidgetPool[hudType][entityType]=widget_pool
end
local cfg=cfgHelper.get1(cfg_xianjieentityconfig_get,entityType)
local poolnum=cfg.poolNum
if#widget_pool>=poolnum then
parent:SetChildRemoveExpandUIEx(guid)
else
hud:removeWidget(widget)
widget:SetChildActive(-1,false)
table.insert(widget_pool,guid)
end
else

end
else

end
end
end
