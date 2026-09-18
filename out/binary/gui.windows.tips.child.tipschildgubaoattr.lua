







def_class("tipsChildGuBaoAttr",UICloneObject)





tipsChildGuBaoAttr.abName="ui/windows/tips/child/tipschildgubaoattr.ab"

tipsChildGuBaoAttr.assetName="tipsChildGuBaoAttr"


function tipsChildGuBaoAttr:bindComponents()

self.attrRoot1=UIObject.get(self,0)
self.attrRoot2=UIObject.get(self,1)
self.attrRoot3=UIObject.get(self,2)

end


function tipsChildGuBaoAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrRoot1);self.attrRoot1=nil;
_UIObject_release(self.attrRoot2);self.attrRoot2=nil;
_UIObject_release(self.attrRoot3);self.attrRoot3=nil;
end







function tipsChildGuBaoAttr:onLoaded(...)
self:bindComponents()
end


function tipsChildGuBaoAttr:__delete()
self:unbindComponents()
end


function tipsChildGuBaoAttr:onHide()

end

function tipsChildGuBaoAttr:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local gbid
if data.tipsType==TIPS_TYPE.eCommonGubao then
gbid=data.itemid
else
gbid=gubaoLookup:good2GuBao(data.itemid)
end
local attach=data.attach

local attrlist
if data.formType==TIPS_FORM_TYPE.eGubaoWin or data.formType==TIPS_FORM_TYPE.eGubaoCheck then
local isActive=gubaoModel:checkActive(gbid)
if isActive then

attrlist=gubaoModel:getBaseAttrList(gbid)
end
end
if attrlist==nil then
attrlist=cfgHelper.get2(cfg_gubaoconfig_get,gbid,'attr')
end
for i=1,3 do
local attr=attrlist[i]
local isshow=attr~=nil
local item=self[FMT.fmt('attrRoot{0}',i)]
local itemWidget=item:getChildWidgetBase()
item:setActive(isshow)
if isshow then
local name,valstr=equipsHelper.getAttr(attr[1],attr[2])
itemWidget:SetChildText(0,FMT.fmt('{0}：{1}',name,valstr))
end
end
end

