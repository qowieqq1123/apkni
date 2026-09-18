







def_class("UICSZDropItem",UICloneObject)





UICSZDropItem.abName="ui/windows/travel/uicszdropitem.ab"

UICSZDropItem.assetName="UICSZDropItem"


function UICSZDropItem:bindComponents()

self.effect1=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.item=UIBaseItem.get(self,2)
self.effect2=UIObject.get(self,3)

end


function UICSZDropItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.item);self.item=nil;
_UIObject_release(self.effect2);self.effect2=nil;
end









function UICSZDropItem:onLoaded(...)
self:bindComponents()
end


function UICSZDropItem:__delete()
if self.sequence then
self.sequence:Kill()
self.sequence=nil
end
self.root:setScale(Vector3.one*0.6)
self.item:setChildCanvasGroupAlpha(0)
self:unbindComponents()
end




function UICSZDropItem:onShow(argtable,afterOnloaded)

self.formPos=argtable.formPos
self.toPos=argtable.toPos
self.midPos=argtable.midPos
self.rIndex=argtable.index
self.itemId=argtable.itemId
self.itemConfig=itemsConfig.getConfig(self.itemId)
self.itemColor=self.itemConfig.color
local conf={itemid=self.itemId,showCountBG=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetQualityEx,0)]=nil

self.item:setChildPropData(prop)





self.root:setChildAnchoredPosition3D(self.formPos)
local itemTF=self.item:getTransform()
local rootTF=self.root:getTransform()
local sequence=Lua.SequenceProxy.New()
local tweenerJump0=Lua.DOTweenProxyExtensions.DOTransformCanvasGroupFade(itemTF,1,1)
sequence:Append(tweenerJump0)
local tweenerJump1=Lua.DOTweenProxyExtensions.DOLocalJump(rootTF,self.midPos,25,1,0.5,false)
sequence:Append(tweenerJump1)
sequence:AppendCallback(function()
self.effect1:setChildShowEffect(10034+self.itemColor,true)
self:delayDo(0.2,function()

AudioManager.playAudio(530)
end)
end)
sequence:AppendInterval(1.2)
sequence:AppendCallback(function()
self.effect2:setChildShowEffect(10039+self.itemColor,true)
self:delayDo(0.6,function()

AudioManager.playAudio(529)
end)
end)
local tweenerJump2=Lua.DOTweenProxyExtensions.DOLocalJump(rootTF,self.toPos,50,1,1.5,false)
sequence:Append(tweenerJump2)
local tweenerJump3=Lua.DOTweenProxyExtensions.DOScale(rootTF,0,1.5)
sequence:Join(tweenerJump3)
self.sequence=sequence




end


function UICSZDropItem:onHide()

end


