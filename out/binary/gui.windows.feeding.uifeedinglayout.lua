







def_class("UIFeedingLayout",UIWindowBase)









function UIFeedingLayout:bindComponents()

self.head=UIObject.get(self,0)
self.name=UIText.get(self,1)
self.volumeGroup=UIObject.get(self,2)
self.emScrollView=UIObject.get(self,3)
self.infoPanel=UIObject.get(self,4)
self.frame=UIImage.get(self,5)
self.jingjieText=UIText.get(self,6)



end


function UIFeedingLayout:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.volumeGroup);self.volumeGroup=nil;
_UIObject_release(self.emScrollView);self.emScrollView=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.frame);self.frame=nil;
_UIObject_release(self.jingjieText);self.jingjieText=nil;
end



















function UIFeedingLayout:onLoaded(...)
self:bindComponents()

self.emScrollView:setChildScrollViewInit(0.5,true,self.on_element_click,nil)
end


function UIFeedingLayout:__delete()
self:unbindComponents()

isometricMapSystem:leaveLayoutModel()
end




function UIFeedingLayout:onShow(argtable,afterOnloaded)
local data=argtable.lsdata
local lsData=lingshouModel:getLingShouData(data.lsGuidStr)
comHelper.setChildModelHeadIconBGByColor(self.winlua,self.frame:getID(),lingshouModel.getColorEx(lsData))
comHelper.setChildModelRawImage_lingshou(self.winlua,lsData.id,self.head:getID(),0,eHeadCenterType.eHead,1)
self.name:setText(lsData.cfg.name)
self.jingjieText:setText(lingshouModel:getJJName(lsData.guid,3))


local volumeCount=lingshouModel.getLingShouPropertyValEx(lsData.guid,lingshouPropertyType.VOLUME)
self.volumeGroup:setChildLayoutGroupCreateItems(volumeCount)

local attr=feedingSystem:getElementDataM(lsData.cfg)
feedingSystem:setElementList(self.winlua,self.emScrollView:getID(),attr)
end


function UIFeedingLayout:onHide()

end




function UIFeedingLayout:onCloseClick()
UILayoutControl:closeUI(true,true)
end