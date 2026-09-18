







def_class("tipsChildWBXBDBaseAttr",UICloneObject)





tipsChildWBXBDBaseAttr.abName="ui/windows/tips/child/tipschildwbxbdbaseattr.ab"

tipsChildWBXBDBaseAttr.assetName="tipsChildWBXBDBaseAttr"


function tipsChildWBXBDBaseAttr:bindComponents()

self.attr1=UIText.get(self,0)
self.attr3=UIText.get(self,1)
self.attr2=UIText.get(self,2)
self.line=UIObject.get(self,3)
self.attrRoot10=UIObject.get(self,4)
self.attrRoot7=UIObject.get(self,5)
self.attrRoot11=UIObject.get(self,6)
self.attrRoot6=UIObject.get(self,7)
self.attrRoot5=UIObject.get(self,8)
self.attrRoot12=UIObject.get(self,9)
self.attrRoot4=UIObject.get(self,10)
self.attrRoot3=UIObject.get(self,11)
self.attrRoot2=UIObject.get(self,12)
self.attrRoot1=UIObject.get(self,13)
self.attrRoot8=UIObject.get(self,14)
self.attrRoot9=UIObject.get(self,15)
self.attr5=UIText.get(self,16)
self.title=UIText.get(self,17)
self.attr4=UIText.get(self,18)
self.attr6=UIText.get(self,19)
self.attr7=UIText.get(self,20)
self.attr8=UIText.get(self,21)
self.attr9=UIText.get(self,22)
self.attr10=UIText.get(self,23)
self.attr11=UIText.get(self,24)
self.attr12=UIText.get(self,25)

end


function tipsChildWBXBDBaseAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attr1);self.attr1=nil;
_UIObject_release(self.attr3);self.attr3=nil;
_UIObject_release(self.attr2);self.attr2=nil;
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.attrRoot10);self.attrRoot10=nil;
_UIObject_release(self.attrRoot7);self.attrRoot7=nil;
_UIObject_release(self.attrRoot11);self.attrRoot11=nil;
_UIObject_release(self.attrRoot6);self.attrRoot6=nil;
_UIObject_release(self.attrRoot5);self.attrRoot5=nil;
_UIObject_release(self.attrRoot12);self.attrRoot12=nil;
_UIObject_release(self.attrRoot4);self.attrRoot4=nil;
_UIObject_release(self.attrRoot3);self.attrRoot3=nil;
_UIObject_release(self.attrRoot2);self.attrRoot2=nil;
_UIObject_release(self.attrRoot1);self.attrRoot1=nil;
_UIObject_release(self.attrRoot8);self.attrRoot8=nil;
_UIObject_release(self.attrRoot9);self.attrRoot9=nil;
_UIObject_release(self.attr5);self.attr5=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.attr4);self.attr4=nil;
_UIObject_release(self.attr6);self.attr6=nil;
_UIObject_release(self.attr7);self.attr7=nil;
_UIObject_release(self.attr8);self.attr8=nil;
_UIObject_release(self.attr9);self.attr9=nil;
_UIObject_release(self.attr10);self.attr10=nil;
_UIObject_release(self.attr11);self.attr11=nil;
_UIObject_release(self.attr12);self.attr12=nil;
end









function tipsChildWBXBDBaseAttr:onLoaded(...)
self:bindComponents()
end


function tipsChildWBXBDBaseAttr:__delete()
self:unbindComponents()
end




function tipsChildWBXBDBaseAttr:onShow(argtable,afterOnloaded)
local data=argtable.argtable
local childType=argtable.childType
local nodeidx=argtable.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local itemConfig=itemsConfig.getConfig(itemid)

local static=itemConfig.static
local extra=itemConfig.extra or{}
local typelist=wanBaoXunBaoDuiModel:getPropNameList()
local name=typelist[static[1]]
local val=static[2]
if itemguid~=nil then
local itemdata=wanBaoXunBaoDuiModel:getEquipDataByGuid(itemguid)
if itemdata then
val=wanBaoXunBaoDuiModel:statisticsEquipAttr(itemdata)
end
end
self[FMT.fmt('attr{0}',1)]:setText(FMT.fmt('{0} +{1}',name,val))
self[FMT.fmt('attrRoot{0}',1)]:setActive(true)

self.line:setActive(not self:isLastItem())
end


function tipsChildWBXBDBaseAttr:onHide()

end

function tipsChildWBXBDBaseAttr:onRecycle()
self.line:setActive(not self:isLastItem())
end

