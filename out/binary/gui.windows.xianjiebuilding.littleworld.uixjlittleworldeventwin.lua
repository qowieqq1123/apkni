







def_class("UIXJLittleWorldEventWin",UIWindowBase)









function UIXJLittleWorldEventWin:bindComponents()

self.scrollview=UIObject.get(self,0)
self.tips=UIText.get(self,1)
self.title=UIText.get(self,2)



end


function UIXJLittleWorldEventWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.title);self.title=nil;
end



















function UIXJLittleWorldEventWin:onLoaded(...)
self:bindComponents()
end


function UIXJLittleWorldEventWin:__delete()
self:unbindComponents()
end




function UIXJLittleWorldEventWin:onShow(argtable,afterOnloaded)
self.title:setText("世界事件")

self.datas=LittleWorldModel:getEventData()
self.datas=table.reverse(self.datas)
if#self.datas>0 then
self:refreshEventList()
self.tips:setActive(false)

LittleWorldModel:setEventRead()
else
self.tips:setActive(true)
end
end


function UIXJLittleWorldEventWin:onHide()

end

function UIXJLittleWorldEventWin:refreshEventList()
local len=#self.datas
self.scrollview:setChildScrollViewCreateGrids(len,0)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.datas[i]
item:SetChildActive(0,data.isNew)
item:SetChildText(1,data.content)
local year=gameUtilityModel.getGameYearPassByLongStamp(data.time or 0)
item:SetChildText(2,FMT.cfmt(FONT_COLOR.eNomalGrayColor,'第{0}年',year))
end

end

function UIXJLittleWorldEventWin:onCloseClick()
self:closeSelf()
end


