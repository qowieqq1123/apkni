







def_class("tipsChildShopCost",UICloneObject)





tipsChildShopCost.abName="ui/windows/tips/child/tipschildshopcost.ab"

tipsChildShopCost.assetName="tipsChildShopCost"


function tipsChildShopCost:bindComponents()

self.titleText=UIText.get(self,0)
self.iconImg=UIImage.get(self,1)
self.numText=UIText.get(self,2)

end


function tipsChildShopCost:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.iconImg);self.iconImg=nil;
_UIObject_release(self.numText);self.numText=nil;
end







function tipsChildShopCost:onLoaded(...)
self:bindComponents()
end


function tipsChildShopCost:__delete()
self:unbindComponents()
end


function tipsChildShopCost:onHide()

end




function tipsChildShopCost:onShow(args,afterOnloaded)
local data=args.argtable
local attach=data.attach
local shopCostArgs=attach.shopCostArgs
local title=shopCostArgs.title
local costItemId=shopCostArgs.costItemId
local costNum=shopCostArgs.costNum

self.titleText:setText(title or'消耗：')
self.iconImg:setImageIcon(iconHelper.getIconName(costItemId),false)
self.numText:setText(tostring(costNum))
end

