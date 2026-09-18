







def_class("tipsChildSell",UICloneObject)





tipsChildSell.abName="ui/windows/tips/child/tipschildsell.ab"

tipsChildSell.assetName="tipsChildSell"


function tipsChildSell:bindComponents()

self.title=UIText.get(self,0)
self.moneyIcon=UIImage.get(self,1)
self.sellprice=UIText.get(self,2)

end


function tipsChildSell:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.sellprice);self.sellprice=nil;
end





function tipsChildSell:onLoaded()
self:bindComponents()
end

function tipsChildSell:__delete()
self:unbindComponents()
end

function tipsChildSell:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach

local itemConfig=itemsConfig.getConfig(itemid)
local dealPrice=itemConfig.dealPrice
if dealPrice==nil or not bagUseControl.isItemExpire(itemguid)then
self:recycleSelf()
return
end
self.sellprice:setText(dealPrice[2]or'')
self.moneyIcon:setImageIcon(iconHelper.getIconName(dealPrice[1]),false)
end