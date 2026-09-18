







def_class("UIWDCQBottomWin",UIWindowBase)









function UIWDCQBottomWin:bindComponents()

self.bg_1=UIObject.get(self,0)
self.bg_2=UIObject.get(self,1)
self.bg_3=UIObject.get(self,2)
self.bg={
self.bg_1,
self.bg_2,
self.bg_3,
}



end


function UIWDCQBottomWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg_1);self.bg_1=nil;
_UIObject_release(self.bg_2);self.bg_2=nil;
_UIObject_release(self.bg_3);self.bg_3=nil;
self.bg=nil;
end



















function UIWDCQBottomWin:onLoaded(...)
self:bindComponents()
end


function UIWDCQBottomWin:__delete()
self:unbindComponents()
end




function UIWDCQBottomWin:onShow(argtable,afterOnloaded)

end


function UIWDCQBottomWin:onHide()

end

function UIWDCQBottomWin:setBgModel(modelList)
for i,v in ipairs(self.bg)do
local model=modelList[i]
if model then
v:setActive(true)
v:setChildUIModelShowTarget(model,1,nil,eAnimationID.stand)
else
v:setActive(false)
end
end
end



