monsterMask=simple_class(baseEntity)


function monsterMask:initialize(args)
local bundle=args.bundle
local asset=args.asset
local scale=args.scale or 1
local sortinglayer=args.sortinglayer
local action=args.action
self:setBundleSpriteRender(bundle,asset)
self:setSpriteScale(scale)
self:setSpriteSortingGroup(sortinglayer)
self:setSpriteActive(true)
self.staticAuto.BaseEntity_SetChildLocalRotation(self.handle,Vector3.New(-90,0,0),false,true)
self:doFade(action)
end

function monsterMask:onDelete()
if self==nil or self:isDeleteSelf()then return end
if self.tweener then
Lua.DOTweenProxyExtensions.DOKill(self.transform,false)
end
self.creatorFunc=nil
Lua.DOTweenProxyExtensions.DOTransformSpriteRendererFade(self.transform,1,0)
self._base.onDelete(self)
end

function monsterMask:onUpdate()
self._base.onUpdate(self)
end

function monsterMask:onPause()
self._base.onPause(self)

end

function monsterMask:onContinue()
self._base.onContinue(self)

end

function monsterMask:onFastUpdate()
if self.pause then return end
self._base.onFastUpdate(self)
if self.delayTime and Time.realtimeSinceStartup>self.delayTime+self:getPauseTime()then
self.delayTime=nil
if self.creatorFunc then
self.creatorFunc()
end
self.creatorFunc=nil
end
end


function monsterMask:setPauseUpdate(flag)
if not monsterMask._base.setPauseUpdate(self,flag)then return end

if self.tweener then
self.tweener:TogglePause()
end
end

function monsterMask:doFade(action)
local transform=self.staticAuto.BaseEntity_GetSpriteTransform(self.handle)
self.transform=transform
Lua.DOTweenProxyExtensions.DOTransformSpriteRendererFade(self.transform,1,0)
local tweener=Lua.DOTweenProxyExtensions.DOTransformSpriteRendererFade(transform,0,0.5)
self.tweener=tweener
tweener:SetLoops(2,_LoopType.Yoyo)
self.delayTime=Time.realtimeSinceStartup+1.01-self:getPauseTime()
self.creatorFunc=function()
if self.tweener then
Lua.DOTweenProxyExtensions.DOKill(self.transform,false)
end
self.tweener=nil
if action then
action()
end
self:deleteEntity()
end
end

function monsterMask:getSortingLayer()
return airConfig.getEntitySortingLayer(eAirEntityType.TYPE_MONSTER)
end