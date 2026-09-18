







def_class("tipsChildIMoneyItem",UICloneObject)





tipsChildIMoneyItem.abName="ui/windows/tips/child/tipschildimoneyitem.ab"

tipsChildIMoneyItem.assetName="tipsChildIMoneyItem"


function tipsChildIMoneyItem:bindComponents()

self.name=UIText.get(self,0)
self.Icon=UIImage.get(self,1)
self.title1=UIText.get(self,2)
self.title2=UIText.get(self,3)

end


function tipsChildIMoneyItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.Icon);self.Icon=nil;
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.title2);self.title2=nil;
end





local _descFun=function(title,desc)
return FMT.fmt('{0}{1}',FMT.cfmt(FONT_COLOR.eTitle2Color,title),
FMT.cfmt(FONT_COLOR.eGrayWhiteTxtColor,desc))
end

function tipsChildIMoneyItem:onLoaded()
self:bindComponents()
end

function tipsChildIMoneyItem:__delete()
self:unbindComponents()
end

function tipsChildIMoneyItem:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach

local itemConfig=itemsConfig.getConfig(itemid)
self:fillInfo(itemid,itemguid,itemConfig)
end

function tipsChildIMoneyItem:fillInfo(itemid,itemguid,itemConfig)
self.name:setText(itemConfig.name)

self.Icon:setImageIcon(iconHelper.getIconName(itemid),false)

self.title1:setText(_descFun('类型：','货币'))

self.title2:setText(_descFun('使用等级：','宗门1级'))
end
