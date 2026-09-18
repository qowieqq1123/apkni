







def_class("UIItemGaiLvWin",UIWindowBase)









function UIItemGaiLvWin:bindComponents()

self.list=UIObject.get(self,0)



end


function UIItemGaiLvWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.list);self.list=nil;
end



















function UIItemGaiLvWin:onLoaded(...)
self:bindComponents()
end


function UIItemGaiLvWin:__delete()
self:unbindComponents()
end




function UIItemGaiLvWin:onShow(argtable,afterOnloaded)
local dropid=argtable
local showItems=cfgHelper.get2(cfg_awardconfig_get,dropid,'detailItems')
local len=#showItems
self.list:setChildLayoutGroupCreateItems(len,function(index)
local item=self.list:getChildLayoutGroupGridItem(index-1)
local data=showItems[index]
local itemid=data[1]
local num=data[2]>0 and data[2]or''
local percent=data[4]or 1
local countStr=num>1 and mathHelper.formatNumber(num)or''
local showCountBG=num>1
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=true,showStage=true,range=data.range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetChildPropData(0,prop)
item:SetChildActive(1,true)
item:SetChildText(1,FMT.fmt("{0}%",percent/100))
end)
end


function UIItemGaiLvWin:onHide()

end



