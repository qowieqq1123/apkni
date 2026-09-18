







def_class("UIPrisonLogWin",UIWindowBase)









function UIPrisonLogWin:bindComponents()

self.scrollview=UIObject.get(self,0)
self.nullBg=UIObject.get(self,1)



end


function UIPrisonLogWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.nullBg);self.nullBg=nil;
end



















function UIPrisonLogWin:onLoaded(...)
self:bindComponents()

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIPrisonLogWin:__delete()
self:unbindComponents()
end




function UIPrisonLogWin:onShow(argtable,afterOnloaded)
local logs=UIPrisonModel:getLogs()
self.scrollview:setChildScrollViewCreateGrids(#logs,1)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local msg=logs[count+1-i]
item:SetChildText(0,msg)
end

if#logs==0 then
self.winlua:SetChildActive(self.nullBg:getID(),true)
else
self.winlua:SetChildActive(self.nullBg:getID(),false)
end
end


function UIPrisonLogWin:onHide()

end




function UIPrisonLogWin:onCloseClick()
self:closeSelf()
end