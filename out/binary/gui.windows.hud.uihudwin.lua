







def_class("UIHUDWin",UIWindowBase)









function UIHUDWin:bindComponents()

self.flow=UIHUDFlow.get(self,0)
self.container1=UIObject.get(self,1)
self.container2=UIObject.get(self,2)



end


function UIHUDWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.flow);self.flow=nil;
_UIObject_release(self.container1);self.container1=nil;
_UIObject_release(self.container2);self.container2=nil;
end



















function UIHUDWin:onLoaded(...)
self:bindComponents()

self.containers={
[hudContainerType.eDefault]=self.container1,
[hudContainerType.eStory]=self.container2,
}

local cfgs=cfg_monijysfconfig()
for k,v in pairs(cfgs)do
local cameraData=v.def_orthographic_size
if webGLHelper:isRunMiniGame()then
cameraData=v.def_orthographic_size_webgl
end
local scaleData=v.hud_scale_data
self.winlua:SetHUDScaleData(v.id,scaleData[1],scaleData[2],cameraData[1])
end

hudControl:refreshAllBuilding()
end


function UIHUDWin:__delete()
self:unbindComponents()
end




function UIHUDWin:onShow(argtable,afterOnloaded)
if argtable then

for i,v in ipairs(argtable)do
self.winlua:SetUsePoolType(v,true)
end

self.winlua:SetHUDScaleType(INSTANCE_TYPE.eDiscipleSpeak,0)

self.winlua:SetHUDScaleType(INSTANCE_TYPE.eXianZhanZhangGuiHud,0)
self.winlua:SetHUDScaleType(INSTANCE_TYPE.eXianZhanShopNpcHud,0)
self.winlua:SetHUDScaleType(INSTANCE_TYPE.eXianZhanRoomModelHud,0)
self.winlua:SetHUDScaleType(INSTANCE_TYPE.eXianZhanRoomNpcTalkHud,0)
self.winlua:SetHUDScaleType(INSTANCE_TYPE.eXianZhanZhiKeHud,0)
self.winlua:SetHUDScaleType(INSTANCE_TYPE.eXianZhanKeShangHud,0)
end
end


function UIHUDWin:OnEnable()

end


function UIHUDWin:OnDisable()

end



function UIHUDWin:SetActive(bActive)
self.winlua:SetActive(bActive)
end



function UIHUDWin:AddHUD(index,entityId,offset,refreshPos,worldSpace,callback)
return self.winlua:AddHUD(index,entityId,offset,refreshPos,worldSpace,callback)
end

function UIHUDWin:AddHUDWithPosition(index,mapId,pos,offset,refreshPos,worldSpace,callback)
return self.winlua:AddHUDWithPosition(index,mapId,pos,offset,refreshPos,worldSpace,callback)
end

function UIHUDWin:RemoveHUD(guid)
self.winlua:RemoveHUD(guid)
end

function UIHUDWin:GetHUDWidget(guid)
return self.winlua:GetHUDWidget(guid)
end

function UIHUDWin:SetHUDTarget(guid,entityId)
self.winlua:SetHUDTarget(guid,entityId)
end

function UIHUDWin:SetHUDTargetPosition(guid,mapId,pos)
self.winlua:SetHUDTargetPosition(guid,mapId,pos)
end

function UIHUDWin:GetHUDTargetPosition(guid)
return self.winlua:GetHUDTargetPosition(guid)
end

function UIHUDWin:RefreshHUDPosition(guid)
self.winlua:RefreshHUDPosition(guid)
end

function UIHUDWin:SetUsePoolType(hudType,usePool)
self.winlua:SetUsePoolType(hudType,usePool)
end

function UIHUDWin:SetHUDActive(guid,bActive)
self.winlua:SetHUDActive(guid,bActive)
end

function UIHUDWin:SetHUDActiveByTarget(entityId,bActive)
self.winlua:SetHUDActiveByTarget(entityId,bActive)
end

function UIHUDWin:GetHudComponent(guid,name)
self.winlua:GetHudComponent(guid,name)
end

function UIHUDWin:SetHUDParent(guid,parent)
self.winlua:SetHUDParent(guid,parent)
end

function UIHUDWin:ChangeContainer(guid,cId)
self.winlua:ChangeContainer(guid,cId)
end

function UIHUDWin:SetContainerActive(cId,flag)
self.winlua:SetContainerActive(cId,flag)
end

function UIHUDWin:SetContainerScale(cId,scale)
self.winlua:SetContainerScale(cId,scale)
end

function UIHUDWin:SetContainerAlpha(cId,alpha)
self.containers[cId]:setChildCanvasGroupAlpha(alpha)
end

function UIHUDWin:SetContainerRaycast(cId,enbable)
self.containers[cId]:setChildCanvasGroupRaycast(enbable)
end

function UIHUDWin:SetContainerGRActive(cId,bActive)
self.winlua:SetContainerGRActive(cId,bActive)
end

function UIHUDWin:ClearHUDByEntityID(entityId)
self.winlua:ClearHUDByEntityID(entityId)
end

function UIHUDWin:IsNeedLoad(guid)
return self.winlua:IsNeedLoad(guid)
end

local charMap2={['0']='A',['1']='B',['2']='C',['3']='D',['4']='E',['5']='F',['6']='H',['7']='I',['8']='J',['9']='K'}
local converNun=function(map,nunStr)
local str=''
local len=string.len(nunStr)
for i=1,len do
str=str..map[string.sub(nunStr,i,i)]
end
return str
end

function UIHUDWin:flowText(pos,offset,value)
local onSpwan=function(win)
local str=''
if value>0 then
str=FMT.fmt("-{0}",value)
else
value=tostring(math.abs(value))
value=converNun(charMap2,value)
str=FMT.fmt("+{0}",value)
end
win:SetChildText(1,str)
end
local normal=math.max(0.5,math.min(math.abs(value)/6000,1))
self.flow:genFlowObj(0,normal,pos,offset,onSpwan)
end