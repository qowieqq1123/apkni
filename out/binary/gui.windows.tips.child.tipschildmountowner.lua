







def_class("tipsChildMountOwner",UICloneObject)





tipsChildMountOwner.abName="ui/windows/tips/child/tipschildmountowner.ab"

tipsChildMountOwner.assetName="tipsChildMountOwner"


function tipsChildMountOwner:bindComponents()

self.root=UIObject.get(self,0)
self.dzbg=UIImage.get(self,1)
self.dzhead=UIObject.get(self,2)
self.dzname=UIText.get(self,3)

end


function tipsChildMountOwner:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.dzbg);self.dzbg=nil;
_UIObject_release(self.dzhead);self.dzhead=nil;
_UIObject_release(self.dzname);self.dzname=nil;
end








function tipsChildMountOwner:onLoaded(...)
self:bindComponents()
end

function tipsChildMountOwner:__delete()
self:unbindComponents()
end

function tipsChildMountOwner:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local dzguid=attach.diziguid
local equip_dzguid=mountModel:getDzguidByItemguid(itemguid)
comHelper.setChildModelHeadIconBG(self.widget,self.dzbg:getID(),equip_dzguid)
comHelper.setChildModelRawImage(self.widget,equip_dzguid,self.dzhead:getID(),0,eHeadCenterType.eHead)
self.dzname:setText(UIDiscipleModel:getDiscipleName(equip_dzguid))
end

function tipsChildMountOwner:onHide()

end


