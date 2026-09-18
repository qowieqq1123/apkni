







def_class("UIManufactureEventWin",UIWindowBase)









function UIManufactureEventWin:bindComponents()

self.title=UIText.get(self,0)
self.scrollview=UIObject.get(self,1)
self.tips=UIText.get(self,2)



end


function UIManufactureEventWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.tips);self.tips=nil;
end



















function UIManufactureEventWin:onLoaded(...)
self:bindComponents()

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIManufactureEventWin:__delete()
self:unbindComponents()
end




function UIManufactureEventWin:onShow(argtable,afterOnloaded)
self.bdData=argtable
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.title:setText(FMT.fmt('{0}见闻',cfg.name))

self.datas=zongmenModel:getManufactureEventData(cfg.build_type)
self.datas=table.reverse(self.datas)
if#self.datas>0 then
self:refreshEventList()
self.tips:setActive(false)

zongmenModel:setManufactureEventRead(cfg.build_type)
else
self.tips:setActive(true)
end
end


function UIManufactureEventWin:onHide()

end

function UIManufactureEventWin:refreshEventList()
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




function UIManufactureEventWin:onCloseClick()
self:closeSelf()
end