







def_class("UITravelEventWin",UIWindowBase)









function UITravelEventWin:bindComponents()

self.bgBtn=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.titleTx=UIText.get(self,2)
self.scrollview=UIObject.get(self,3)
self.tipsTx=UIText.get(self,4)

self.bgBtn:setButtonClick(function()self:onBgBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UITravelEventWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgBtn);self.bgBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.titleTx);self.titleTx=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
end



















function UITravelEventWin:onLoaded(...)
self:bindComponents()
end


function UITravelEventWin:__delete()
self:unbindComponents()
end




function UITravelEventWin:onShow(argtable,afterOnloaded)
self.title=argtable.title
self.tips=argtable.tips
self.datas=argtable.datas
self.openCB=argtable.open

self.titleTx:setText(self.title or"")
self.tipsTx:setText(self.tips or"")

self.datas=table.reverse(self.datas)
if#self.datas>0 then
self:refreshList()
self.tipsTx:setActive(false)
else
self.tipsTx:setActive(true)
end

if self.openCB then
self.openCB()
end
end


function UITravelEventWin:onHide()

end



function UITravelEventWin:onCloseBtn()
self:closeSelf()
end

function UITravelEventWin:onBgBtn()
self:closeSelf()
end

function UITravelEventWin:refreshList()
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