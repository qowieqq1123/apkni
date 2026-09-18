







def_class("UIChildTalkRightItem",UICloneObject)





UIChildTalkRightItem.abName="ui/windows/common/child/uichildtalkrightitem.ab"

UIChildTalkRightItem.assetName="UIChildTalkRightItem"


function UIChildTalkRightItem:bindComponents()

self.title=UIObject.get(self,0)
self.desc=UIText.get(self,1)

end


function UIChildTalkRightItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.desc);self.desc=nil;
end








function UIChildTalkRightItem:onLoaded(...)
self:bindComponents()
end

function UIChildTalkRightItem:__delete()
self:unbindComponents()
end

function UIChildTalkRightItem:onShow(argtable,afterOnloaded)
local desc=argtable.desc or''
local showTitle=argtable.showTitle or false
self.desc:setText(desc)
self.title:setActive(showTitle)
end

function UIChildTalkRightItem:onHide()

end


