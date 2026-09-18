







def_class("tipsChildCollectClothing",UICloneObject)





tipsChildCollectClothing.abName="ui/windows/tips/child/tipschildcollectclothing.ab"

tipsChildCollectClothing.assetName="tipsChildCollectClothing"


function tipsChildCollectClothing:bindComponents()

self.titleRoot=UIObject.get(self,0)
self.attrRoot5=UIObject.get(self,1)
self.attrRoot4=UIObject.get(self,2)
self.attrRoot3=UIObject.get(self,3)
self.attrRoot2=UIObject.get(self,4)
self.line=UIObject.get(self,5)
self.attrRoot1=UIObject.get(self,6)
self.attrRoot0=UIObject.get(self,7)
self.attr4=UIText.get(self,8)
self.star4=UIObject.get(self,9)
self.star1=UIObject.get(self,10)
self.attr1=UIText.get(self,11)
self.title=UIText.get(self,12)
self.attr3=UIText.get(self,13)
self.star3=UIObject.get(self,14)
self.attr2=UIText.get(self,15)
self.star2=UIObject.get(self,16)
self.attr0=UIText.get(self,17)
self.star5=UIObject.get(self,18)
self.attr5=UIText.get(self,19)

end


function tipsChildCollectClothing:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleRoot);self.titleRoot=nil;
_UIObject_release(self.attrRoot5);self.attrRoot5=nil;
_UIObject_release(self.attrRoot4);self.attrRoot4=nil;
_UIObject_release(self.attrRoot3);self.attrRoot3=nil;
_UIObject_release(self.attrRoot2);self.attrRoot2=nil;
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.attrRoot1);self.attrRoot1=nil;
_UIObject_release(self.attrRoot0);self.attrRoot0=nil;
_UIObject_release(self.attr4);self.attr4=nil;
_UIObject_release(self.star4);self.star4=nil;
_UIObject_release(self.star1);self.star1=nil;
_UIObject_release(self.attr1);self.attr1=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.attr3);self.attr3=nil;
_UIObject_release(self.star3);self.star3=nil;
_UIObject_release(self.attr2);self.attr2=nil;
_UIObject_release(self.star2);self.star2=nil;
_UIObject_release(self.attr0);self.attr0=nil;
_UIObject_release(self.star5);self.star5=nil;
_UIObject_release(self.attr5);self.attr5=nil;
end









function tipsChildCollectClothing:onLoaded(...)
self:bindComponents()
end


function tipsChildCollectClothing:__delete()
self:unbindComponents()
end




function tipsChildCollectClothing:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
self.attach_starlv=attach.starlv



local collectLv=ClothingModel:getClothingCollectStarLvById(itemid)or 0

local starlv=0
if itemguid then
starlv=collectLv
end




if itemguid and not ClothingHelper.getEquip(itemguid)then
self:recycleSelf()
return
end

local title
local cfg=itemsConfig.getConfig(itemid)

title=cfgHelper.get(cfg_disciplevocationconfig_get,cfg.type1,"name")


local maxStar=ClothingConfig.getStarMaxLv(itemid)

for i=0,maxStar do
local attr=ClothingHelper.getCollectAttrs(itemid,i)
if attr and attr[1]then
self:setAttr(i,attr[1][1],attr[1][2],starlv,title)
end
end
end

function tipsChildCollectClothing:setAttr(idx,attrType,attrValue,starlv,title)
if attrType==nil then
self[FMT.fmt('attrRoot{0}',idx)]:setActive(false)
return
end
self[FMT.fmt('attrRoot{0}',idx)]:setActive(true)
local name,str=equipsHelper.getAttr(attrType,attrValue,TO_INT_TYPE.eDown,1)
local attrStr=FMT.fmt('{0}{1}：{2}',title,name,str)


if idx>0 then
if starlv>idx-1 then
self.widget:SetChildStarNumber(self[FMT.fmt('star{0}',idx)]:getID(),idx)
self[FMT.fmt('attr{0}',idx)]:setText(attrStr)
else
self.widget:SetChildStarNumber(self[FMT.fmt('star{0}',idx)]:getID(),0)
self[FMT.fmt('attr{0}',idx)]:setText(FMT.fmt("<color=#827f78>{0}</color>",attrStr))
end
else
self[FMT.fmt('attr{0}',idx)]:setText(attrStr)
end
end



function tipsChildCollectClothing:onHide()

end


