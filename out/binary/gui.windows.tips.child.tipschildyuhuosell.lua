







def_class("tipsChildYuHuoSell",UICloneObject)





tipsChildYuHuoSell.abName="ui/windows/tips/child/tipschildyuhuosell.ab"

tipsChildYuHuoSell.assetName="tipsChildYuHuoSell"


function tipsChildYuHuoSell:bindComponents()

self.title=UIText.get(self,0)
self.sellprice=UIText.get(self,1)
self.moneyIcon=UIImage.get(self,2)

end


function tipsChildYuHuoSell:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.sellprice);self.sellprice=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
end









function tipsChildYuHuoSell:onLoaded(...)
self:bindComponents()
end


function tipsChildYuHuoSell:__delete()
self:unbindComponents()
end




function tipsChildYuHuoSell:onShow(argtable,afterOnloaded)
local data=argtable.argtable


local itemid=data.itemid



local itemConfig=itemsConfig.getConfig(itemid)
local dealPrice=itemConfig.dealPrice



self.sellprice:setText(dealPrice[2])
local icon=iconHelper.getIconName(dealPrice[1])
self.moneyIcon:setImageIcon(icon,false)
end


function tipsChildYuHuoSell:onHide()

end


