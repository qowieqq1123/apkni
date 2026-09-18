







def_class("UILongHuDaoDanPreviewWin",UIWindowBase)









function UILongHuDaoDanPreviewWin:bindComponents()

self.liandanVal=UILinkImageText.get(self,0)
self.ScrollView1=UIObject.get(self,1)
self.Text=UILinkImageText.get(self,2)
self.ScrollView2=UIScrollView.get(self,3)



end


function UILongHuDaoDanPreviewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.liandanVal);self.liandanVal=nil;
_UIObject_release(self.ScrollView1);self.ScrollView1=nil;
_UIObject_release(self.Text);self.Text=nil;
_UIObject_release(self.ScrollView2);self.ScrollView2=nil;
end




















function UILongHuDaoDanPreviewWin:onLoaded(...)
self:bindComponents()
self.subType=SUB_ACTIVITY_TYPE.eLongHuMountain

end


function UILongHuDaoDanPreviewWin:__delete()
self:unbindComponents()
end




function UILongHuDaoDanPreviewWin:onShow(argtable,afterOnloaded)

local actid=argtable.actid
local act2id=argtable.act2id
local config=activitiesModel:getSubActivityConfig(self.subType,act2id)
local previewConfig=config.daodanPreview

local count=#previewConfig[1]
self.ScrollView1:setChildScrollViewCreateGrids(count,1)
local grids=self.ScrollView1:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local index=i+1
local item=grids[i]
local daodanId=previewConfig[1][index]
local itemConfig=itemsConfig.getConfig(daodanId)

local iconName=iconHelper.getItemIconName(itemConfig.icon)
local conf=
{
iconName=iconName,
color=itemConfig.color,
}
local prop=itemsComponentHelper.getCommonSpecialFillData(conf)
item:SetChildPropData(0,prop)
item:SetChildText(1,itemConfig.name)
item:SetChildText(2,itemConfig.desc)
item:SetBaseItemClickEvent(0,function()
tipsManager.showTips({itemid=daodanId})
end)
end

local count=#previewConfig[2]
self.ScrollView2:setChildScrollViewCreateGrids(count,1)
local grids=self.ScrollView2:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local index=i+1
local item=grids[i]
local daodanId=previewConfig[2][index]
local itemConfig=itemsConfig.getConfig(daodanId)

local iconName=iconHelper.getItemIconName(itemConfig.icon)
local conf=
{
iconName=iconName,
color=itemConfig.color,
}
local prop=itemsComponentHelper.getCommonSpecialFillData(conf)
item:SetChildPropData(0,prop)
item:SetChildText(1,itemConfig.name)
item:SetChildText(2,itemConfig.desc)
item:SetBaseItemClickEvent(0,function()
tipsManager.showTips({itemid=daodanId})
end)
end


end


function UILongHuDaoDanPreviewWin:onHide()

end



