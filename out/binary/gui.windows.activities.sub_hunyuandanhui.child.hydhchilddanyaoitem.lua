







def_class("hydhChildDanYaoItem",UICloneObject)





hydhChildDanYaoItem.abName="ui/windows/activities/sub_hunyuandanhui/child/hydhchilddanyaoitem.ab"

hydhChildDanYaoItem.assetName="hydhChildDanYaoItem"


function hydhChildDanYaoItem:bindComponents()

self.effect=UIObject.get(self,0)
self.icon=UIButton.get(self,1)
self.select=UIObject.get(self,2)

self.icon:setButtonClick(function()self:onIcon()end)

end


function hydhChildDanYaoItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.select);self.select=nil;
end






local _this
local _abname="ui/windows/activities/sub_hunyuandanhui/hunyuandanhui_atlas_pak.ab"




function hydhChildDanYaoItem:onLoaded(...)
self:bindComponents()
_this=self
end


function hydhChildDanYaoItem:__delete()
self:unbindComponents()
_this=nil
end




function hydhChildDanYaoItem:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id

self.info=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)

self.type=argtable.type

self.x=argtable.x
self.y=argtable.y
self.r=argtable.r
self.m_cav=argtable.m_cav
self.widget:SetChildLocalPos(-1,self.x,self.y,0)

local radius=cfgHelper.get2(cfg_hunyuandanhuielementconfig_get,self.type,'radius')
self.radius=radius

self.icon:setCSImageSprite(_abname,self.info:getHYDHSrc(self.type))
self.icon:setChildSizeDelta(radius*2,radius*2)
self.widget:SetChildSizeDelta(-1,radius*2,radius*2)
self.select:setChildSizeDelta(radius*2,radius*2)
self.widget:SetChildRotation(-1,0,0,self.r)
self.select:setChildShowEffect(0,false)


self.isFusionAnim=nil
if self.type>=self:getMaxType()then
self.isMaxType=true

local scale=self.radius*2/212
self.effect:setChildShowEffectEx(60036,self.m_cav[1],self.m_cav[2]+2,true)
self.effect:setScale(Vector3.New(scale,scale,scale))
else
self.isMaxType=false
self.effect:setChildShowEffect(0,false)
end
end


function hydhChildDanYaoItem:onHide()

end

function hydhChildDanYaoItem:setSelect(flag)
if flag then
local scale=self.radius*2/212
self.select:setChildShowEffectEx(60035,self.m_cav[1],self.m_cav[2]+2,true)
self.select:setScale(Vector3.New(scale,scale,scale))
else
self.select:setChildShowEffect(0,false)
end
end

function hydhChildDanYaoItem:getMaxType()
if(not self.maxType)then
self.maxType=#cfg_hunyuandanhuielementconfig();
end
return self.maxType
end

function hydhChildDanYaoItem:setClickFunc(func)
self.clickFunc=func
end

function hydhChildDanYaoItem:setPos(x,y)
self.x=x
self.y=y
end

function hydhChildDanYaoItem:setType(type,isAnim)
local maxType=self:getMaxType()
if type>maxType then
type=maxType
end
self.type=type
local radius=cfgHelper.get2(cfg_hunyuandanhuielementconfig_get,type,'radius')
self.radius=radius

self.icon:setCSImageSprite(_abname,self.info:getHYDHSrc(type))
if isAnim then
self:setIsFusionAnim(true)
self.icon:setChildDOSizeDelta(Vector2(radius*2,radius*2),0.2)
self.widget:SetChildDOSizeDelta(-1,Vector2(radius*2,radius*2),0.2,function()
if not self then return end
self:setIsFusionAnim(nil)
end)
else
self.icon:setChildSizeDelta(radius*2,radius*2)
self.widget:SetChildSizeDelta(-1,radius*2,radius*2)
self:setIsFusionAnim(nil)
end
self.select:setChildSizeDelta(radius*2,radius*2)
self.select:setActive(false)
self.select:setChildShowEffect(0,false)

if self.type>=self:getMaxType()then
self.isMaxType=true

local scale=self.radius*2/212
self.effect:setChildShowEffectEx(60036,self.m_cav[1],self.m_cav[2]+2,true)
self.effect:setScale(Vector3.New(scale,scale,scale))
else
self.isMaxType=false
self.effect:setChildShowEffect(0,false)
end
end

function hydhChildDanYaoItem:setIsFusionAnim(flag)

self.isFusionAnim=flag
end




function hydhChildDanYaoItem:onIcon()
if self.clickFunc then
self.clickFunc()
end
end
