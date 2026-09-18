







def_class("UIChatEmotUnLockWin",UIWindowBase)









function UIChatEmotUnLockWin:bindComponents()

self.tipsText=UIText.get(self,0)
self.goodScrollView=UIObject.get(self,1)
self.tips=UILinkImageText.get(self,2)
self.effect=UIObject.get(self,3)
self.noteScrollView=UIObject.get(self,4)
self.goodGridPanel=UIObject.get(self,5)
self.noteGridPanel=UIObject.get(self,6)
self.emotimg=UIObject.get(self,7)
self.name=UIText.get(self,8)



end


function UIChatEmotUnLockWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.goodScrollView);self.goodScrollView=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.noteScrollView);self.noteScrollView=nil;
_UIObject_release(self.goodGridPanel);self.goodGridPanel=nil;
_UIObject_release(self.noteGridPanel);self.noteGridPanel=nil;
_UIObject_release(self.emotimg);self.emotimg=nil;
_UIObject_release(self.name);self.name=nil;
end



















function UIChatEmotUnLockWin:onLoaded(...)
self:bindComponents()
end


function UIChatEmotUnLockWin:__delete()
self:unbindComponents()
end




function UIChatEmotUnLockWin:onShow(argtable,afterOnloaded)

local tabid=argtable.tabid
local tabidx=argtable.tabidx
local emotid=cfgHelper.get3(cfg_itemchatemotpackageconfig_get,tabid,tabidx,"emoid")
local consume=cfgHelper.get3(cfg_itemchatemotpackageconfig_get,tabid,tabidx,"consume")
local icon=cfgHelper.get2(cfg_chatebigmotconfig_get,emotid,'icon')
local itemid=consume[1][1]
local icon=iconHelper.getBigEmotIcon(icon)
self.emotimg:setChildIcon(icon,false)
self.name:setText(itemsConfig.getItemName(itemid))
end


function UIChatEmotUnLockWin:onHide()

end

function UIChatEmotUnLockWin:onClickClose()
self:closeSelf()
end



