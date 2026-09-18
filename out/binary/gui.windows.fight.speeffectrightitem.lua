







def_class("speEffectRightItem",UICloneObject)





speEffectRightItem.abName="ui/windows/fight/speeffectrightitem.ab"

speEffectRightItem.assetName="speEffectRightItem"


function speEffectRightItem:bindComponents()

self.root=UIObject.get(self,0)
self.icon=UIImage.get(self,1)
self.title=UIImage.get(self,2)

end


function speEffectRightItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.title);self.title=nil;
end










function speEffectRightItem:onLoaded(...)
self:bindComponents()
end


function speEffectRightItem:__delete()
self:unbindComponents()
end




function speEffectRightItem:onShow(argtable,afterOnloaded)
local parent=argtable.parent
local spEffect=argtable.val
local hideCall=argtable.hideCall
local index=argtable.index

local cfg=skillShowTypeTag[spEffect]

if cfg.imageID then
local ab,name=entityHUD.getSkillImage(cfg.imageID)
self.title:setCSImageSprite(ab,name)
end

if cfg.speImageID then
local bgab,bg=entityHUD.getSpeStateImage(cfg.speImageID)
self.root:setCSImageSprite(bgab,bg[1])
self.icon:setCSImageSprite(bgab,bg[2])
end

local y=(index-1)*100

self.root:setChildAnchoredPos(-50,-y+50)

self.root:setChildDOAnchorPosX(0,0.5)
self.root:setChildCanvasGroupDOFade(1,0.2)
local delayFade=self.root:setChildCanvasGroupDOFade(0,0.3)
delayFade:SetDelay(2.2)

self:delayDo(3,function()
hideCall(parent,false)
self:recycleSelf()
end)
end


function speEffectRightItem:onHide()

end


