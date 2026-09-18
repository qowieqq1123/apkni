







def_class("tipsChildXingChenBaseAttr",UICloneObject)





tipsChildXingChenBaseAttr.abName="ui/windows/tips/child/tipschildxingchenbaseattr.ab"

tipsChildXingChenBaseAttr.assetName="tipsChildXingChenBaseAttr"


function tipsChildXingChenBaseAttr:bindComponents()

self.scrollview=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.titleUp=UIText.get(self,2)

end


function tipsChildXingChenBaseAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.titleUp);self.titleUp=nil;
end









function tipsChildXingChenBaseAttr:onLoaded(...)
self:bindComponents()
end


function tipsChildXingChenBaseAttr:__delete()
self:unbindComponents()
end




function tipsChildXingChenBaseAttr:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
self.itemid=itemid
local itemguid=data.itemguid
local attach=data.attach
self.attach=attach

local config=itemsConfig.getConfig(itemid)

local pos=config.type1

local curlv=xingChenBagModel:getOrbitLevel(pos)
self.titleUp:setActive(curlv>1)
local fixAttrs=xingChenHelper.getFixedAttr(itemid,1)
local upFixAttrs=xingChenHelper.getFixedAttr(itemid,curlv)
self.scrollview:setChildScrollViewCreateGrids(#fixAttrs,1)
local grids=self.scrollview:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local grid=grids[i-1]
local attr=fixAttrs[i]
local name,str=equipsHelper.getAttr(attr[1],attr[2])
grid:SetChildText(0,FMT.fmt("{0}：{1}",name,str))
grid:SetChildText(1,upFixAttrs[i][2]-attr[2]>0 and FMT.fmt("+{0}",upFixAttrs[i][2]-attr[2])or"")
end
end


function tipsChildXingChenBaseAttr:onHide()

end


