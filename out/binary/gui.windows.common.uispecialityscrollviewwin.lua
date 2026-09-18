







def_class("UISpecialityScrollViewWin",UIWindowBase)









function UISpecialityScrollViewWin:bindComponents()

self.scrollview2=UIObject.get(self,0)



end


function UISpecialityScrollViewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview2);self.scrollview2=nil;
end



















function UISpecialityScrollViewWin:onLoaded(...)
self:bindComponents()
end


function UISpecialityScrollViewWin:__delete()
self:unbindComponents()
end




function UISpecialityScrollViewWin:onShow(argtable,afterOnloaded)
local guid=argtable.guid
local datas=argtable.datas
if datas then
local openType=argtable.openType
self.scrollview2:setChildScrollViewCreateGrids(#datas,1)
local grids=self.scrollview2:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=datas[i]
UIDiscipleModel.refreshSpecialityItemEx(item,data)
if openType==dzSelectWinOpenType.eManager then
local infoStr=zongmenControl:getSpecialityAddDesc(guid,data)
item:SetChildText(2,infoStr)
else
item:SetChildText(2,'')
end
end
end
end


function UISpecialityScrollViewWin:onHide()

end



