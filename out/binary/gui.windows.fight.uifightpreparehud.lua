







def_class("UIFightPrepareHUD",UIWindowBase)







local cshelper=CS.UIHelper

function UIFightPrepareHUD:auto_bind()
end
















local globalab='ui/sharedtextures/uiglobalspriteatlas_1.ab'
local guidLookUp={}
local fabaoLookUp={}

function UIFightPrepareHUD:onLoaded(...)
guidLookUp={}

self.onAddEntity=function(ent,josID)

if ent~=nil and josID~=nil and self.addHUD then
if ent.fabaoObjID then
fabaoLookUp[ent.guid]=ent.fabaoObjID
end
self:addHUD(INSTANCE_TYPE.eFightPrepareHUD,ent.guid,ent:getHudOffset(),true,false,josID)
end
end

self.onRemoveEntity=function(ent)

if ent~=nil and self.removeHUD then
local fabao=fabaoLookUp[ent.guid]
if fabao~=nil then
ent.hud:stopText(fabao)
ent.fabaoObjID=nil
fabaoLookUp[ent.guid]=nil
end
self:removeHUD(ent.guid)
end
end
notifySystem:listenNotify(notifyConfig.onPreSelectAddEntity,self.onAddEntity)
notifySystem:listenNotify(notifyConfig.onPreSelectRemoveEntity,self.onRemoveEntity)
end


function UIFightPrepareHUD:__delete()
if next(guidLookUp)then
for i,guid in pairs(guidLookUp)do
self.winlua:RemoveHUD(guid)
end
end
guidLookUp={}
notifySystem:removelistener(notifyConfig.onPreSelectAddEntity,self.onAddEntity)
notifySystem:removelistener(notifyConfig.onPreSelectRemoveEntity,self.onRemoveEntity)
end




function UIFightPrepareHUD:onShow(argtable,afterOnloaded)
if argtable and type(argtable)=='table'then
local preAddList=argtable.list
for i,v in ipairs(preAddList)do
self:addHUD(argtable.type,v.id,v.guid,argtable.offset,true,argtable.useUISpace,v.jobid)
end
end
end


function UIFightPrepareHUD:onHide()

end


function UIFightPrepareHUD:addHUD(index,entityId,offset,refreshPos,useUISpace,jobid)

local guid=nil
local createHUD=function(guid)
local widget=self.winlua:GetHUDWidget(guid)
if widget then
widget:SetChildText(0,UIDiscipleModel:getJobName(jobid))
end
end
if guidLookUp[entityId]then
guid=guidLookUp[entityId]
createHUD(guid)
else
guid=self.winlua:AddHUD(index,entityId,offset,refreshPos,not useUISpace,createHUD)
end

guidLookUp[entityId]=guid
end

function UIFightPrepareHUD:removeHUD(entityId)
local guid=guidLookUp[entityId]
if guid then
self.winlua:RemoveHUD(guid)
end
end


