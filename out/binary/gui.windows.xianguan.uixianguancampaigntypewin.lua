







def_class("UIXianGuanCampaignTypeWIn",UIWindowBase)









function UIXianGuanCampaignTypeWIn:bindComponents()

self.contentList=UIObject.get(self,0)
self.icon=UIImage.get(self,1)
self.name=UIText.get(self,2)
self.Root=UIObject.get(self,3)
self.uiRoot=UIObject.get(self,4)



end


function UIXianGuanCampaignTypeWIn:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.contentList);self.contentList=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local _this




function UIXianGuanCampaignTypeWIn:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXianGuanCampaignTypeWIn:__delete()
_this=nil

self:unbindComponents()
end




function UIXianGuanCampaignTypeWIn:onShow(argtable,afterOnloaded)
self.type=argtable.type

local config=cfgHelper.get1(cfg_xianguancampaigntypeconfig_get,self.type)

self.icon:setCSImageSprite(globalABLookup.xianguan,config.icon)
self.name:setText(config.name)

local contentList=config.contentList or{}
local contentLen=#contentList

if contentLen>0 then
self.contentList:setChildLayoutGroupCreateItems(contentLen,function(index)
if _this==nil then return end

local item=_this.contentList:getChildLayoutGroupGridItem(index-1)

local content=contentList[index]
item:SetChildText(0,content)
end)
end
end


function UIXianGuanCampaignTypeWIn:onHide()

end



