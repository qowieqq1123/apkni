







def_class("tipsChildCSJDWeaponAttr",UICloneObject)





tipsChildCSJDWeaponAttr.abName="ui/windows/tips/child/tipschildcsjdweaponattr.ab"

tipsChildCSJDWeaponAttr.assetName="tipsChildCSJDWeaponAttr"


function tipsChildCSJDWeaponAttr:bindComponents()

self.attrList=UIObject.get(self,0)
self.line=UIObject.get(self,1)
self.title=UIText.get(self,2)

end


function tipsChildCSJDWeaponAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrList);self.attrList=nil;
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.title);self.title=nil;
end









function tipsChildCSJDWeaponAttr:onLoaded(...)
self:bindComponents()
end


function tipsChildCSJDWeaponAttr:__delete()
self:unbindComponents()
end




function tipsChildCSJDWeaponAttr:onShow(argtable,afterOnloaded)
local args=argtable.argtable
local id=args.itemid
local attach=args.attach
self.id=id
self.actId=attach.actId
self.subType=attach.subType
self.subId=attach.subId
self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self:refreshView()
end


function tipsChildCSJDWeaponAttr:onHide()

end



function tipsChildCSJDWeaponAttr:refreshView()
local weaponServer=self.config.treasure[self.id]
local attrs=weaponServer[1]
self.attrList:setChildLayoutGroupCreateItems(#attrs,function(index)
local item=self.attrList:getChildLayoutGroupGridItem(index-1)
local attrData=attrs[index]
local attrType=attrData[1]
local attrValue=attrData[2]
local attrStr=helper.getAttributeStr(attrType,attrValue,2,"{0}：{1}")
item:SetChildText(0,attrStr)
end)

self.line:setActive(not self:isLastItem())

self:forceLayoutRect(-1)
end