







def_class("UIYFLZCombineFinishWin",UIWindowBase)









function UIYFLZCombineFinishWin:bindComponents()

self.tipsText=UIText.get(self,0)
self.level=UIText.get(self,1)
self.materials=UIObject.get(self,2)
self.tips=UILinkImageText.get(self,3)
self.effect=UIObject.get(self,4)
self.noteScrollView=UIObject.get(self,5)
self.noteGridPanel=UIObject.get(self,6)



end


function UIYFLZCombineFinishWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.materials);self.materials=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.noteScrollView);self.noteScrollView=nil;
_UIObject_release(self.noteGridPanel);self.noteGridPanel=nil;
end



















function UIYFLZCombineFinishWin:onLoaded(...)
self:bindComponents()
end


function UIYFLZCombineFinishWin:__delete()
self:unbindComponents()
end




function UIYFLZCombineFinishWin:onShow(argtable,afterOnloaded)
local itemId=argtable.itemId
local itemguid=argtable.guid

local widget=self.materials:getWidgetBase()
local color=UIYuFuLingZhenControl:getItemColorById(itemId,itemguid)
widget:SetChildActive(0,false)
widget:SetChildActive(1,false)
local cfg=itemsConfig.getConfig(itemId)

widget:SetChildActive(3,true)
local pz=UIYuFuLingZhenControl:getPZIconName(color)
widget:SetChildCSImageSprite(4,globalABLookup.yufulingzhen,pz)
local icon=UIYuFuLingZhenControl:getLZIconName(cfg)

widget:SetChildIcon(5,icon,true)
widget:SetChildText(2,cfg.name)

local new=UIYuFuLingZhenControl:getItemLevel(itemId)

self.level:setText(FMT.fmt("{0}级→{1}级",new-1,new))
end


function UIYFLZCombineFinishWin:onHide()

end

function UIYFLZCombineFinishWin:onClickClose()
self:closeSelf()
end


