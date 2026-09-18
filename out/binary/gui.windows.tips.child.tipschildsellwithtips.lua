







def_class("tipsChildSellWithTips",UICloneObject)





tipsChildSellWithTips.abName="ui/windows/tips/child/tipschildsellwithtips.ab"

tipsChildSellWithTips.assetName="tipsChildSellWithTips"


function tipsChildSellWithTips:bindComponents()

self.sellprice=UIText.get(self,0)
self.moneyIcon=UIImage.get(self,1)
self.desc=UIText.get(self,2)
self.title=UIText.get(self,3)
self.tips=UIObject.get(self,4)

end


function tipsChildSellWithTips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.sellprice);self.sellprice=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.tips);self.tips=nil;
end








function tipsChildSellWithTips:onLoaded(...)
self:bindComponents()
end

function tipsChildSellWithTips:__delete()
self:unbindComponents()
end

function tipsChildSellWithTips:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local desc=attach.sellDesc

local itemConfig=itemsConfig.getConfig(itemid)
local dealPrice=itemConfig.dealPrice
if dealPrice==nil or
bagUseControl.hasExpireTime(itemguid)and not bagUseControl.isItemExpire(itemguid)then
self:recycleSelf()
return
end
self.sellprice:setText(dealPrice[2]or'')
self.moneyIcon:setImageIcon(iconHelper.getIconName(dealPrice[1]),false)

local vis=desc and desc~=''
self.desc:setActive(vis)
if vis then
self.desc:setText(desc)
end
end

function tipsChildSellWithTips:onHide()

end


