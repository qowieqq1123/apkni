







def_class("tipsChildRecycle",UICloneObject)





tipsChildRecycle.abName="ui/windows/tips/child/tipschildrecycle.ab"

tipsChildRecycle.assetName="tipsChildRecycle"


function tipsChildRecycle:bindComponents()

self.moneyIcon=UIImage.get(self,0)
self.sellprice=UIText.get(self,1)
self.title=UIText.get(self,2)

end


function tipsChildRecycle:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.sellprice);self.sellprice=nil;
_UIObject_release(self.title);self.title=nil;
end









function tipsChildRecycle:onLoaded(...)
self:bindComponents()
end


function tipsChildRecycle:__delete()
self:unbindComponents()
end




function tipsChildRecycle:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach

local gfID=gongfaLookup:checkGongfaPiece(itemid)
if gfID and UIGongFaModel:checkFullStudy(gfID)then
local gfCfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfID)
self.sellprice:setText(gfCfg.study_back or'')
self.moneyIcon:setImageIcon(iconHelper.getIconName(eMoneyType.mtChuanDao),false)
else
self:recycleSelf()
return
end
end