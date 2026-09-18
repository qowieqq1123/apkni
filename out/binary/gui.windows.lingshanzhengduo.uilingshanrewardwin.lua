







def_class("UILingShanRewardWin",UIWindowBase)









function UILingShanRewardWin:bindComponents()

self.infoItem_1=UIObject.get(self,0)
self.infoItem_2=UIObject.get(self,1)
self.infoItem_3=UIObject.get(self,2)
self.infoItem={
self.infoItem_1,
self.infoItem_2,
self.infoItem_3,
}



end


function UILingShanRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.infoItem_1);self.infoItem_1=nil;
_UIObject_release(self.infoItem_2);self.infoItem_2=nil;
_UIObject_release(self.infoItem_3);self.infoItem_3=nil;
self.infoItem=nil;
end
















local _infoIndex={
name=0,
icon=1,
buff_name=2,
buff_desc=3,
items={4,5,6,7}
}




function UILingShanRewardWin:onLoaded(...)
self:bindComponents()

self.areaData={
{3,'山顶区域'},
{2,'山腰区域'},
{1,'山底区域'}
}
end


function UILingShanRewardWin:__delete()
self:unbindComponents()
end




function UILingShanRewardWin:onShow(argtable,afterOnloaded)
self.mountId=argtable
self.config=UILSZDControl:getLingShanConfig(self.mountId)
self:refresh()
end


function UILingShanRewardWin:onHide()

end

function UILingShanRewardWin:refresh()
local rewardData=self.config.set_up_income
local buffData=self.config.set_up_buff
for i=1,3 do
local sdata=self.areaData[i]
local areaId=sdata[1]
local name=sdata[2]
local rewards=rewardData[areaId]
local bfdata=buffData[areaId][1]
local iconName,buffName,buffDesc=UILSZDControl:getBuffInfo(bfdata)
local areaInfo=self.infoItem[i]
local widget=areaInfo:getChildWidgetBase()
widget:SetChildText(_infoIndex.name,name)
widget:SetChildIcon(_infoIndex.icon,iconName,true)
widget:SetChildText(_infoIndex.buff_name,buffName)
widget:SetChildText(_infoIndex.buff_desc,buffDesc)
for ii=1,4 do
local index=_infoIndex.items[ii]
local rw=rewards[ii]
if rw then
widget:SetChildActive(index,true)
widgetHelper.setNormalRewardItem(widget,index,rw)
else
widget:SetChildActive(index,false)
end
end
end
end




function UILingShanRewardWin:onCloseClick()
self:closeSelf()
end