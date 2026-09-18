







def_class("tipsChildGuBaoFSAttr",UICloneObject)





tipsChildGuBaoFSAttr.abName="ui/windows/tips/child/tipschildgubaofsattr.ab"

tipsChildGuBaoFSAttr.assetName="tipsChildGuBaoFSAttr"


function tipsChildGuBaoFSAttr:bindComponents()

self.attrRoot1=UIObject.get(self,0)
self.attrRoot2=UIObject.get(self,1)
self.attrRoot3=UIObject.get(self,2)
self.attrRoot4=UIObject.get(self,3)

end


function tipsChildGuBaoFSAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrRoot1);self.attrRoot1=nil;
_UIObject_release(self.attrRoot2);self.attrRoot2=nil;
_UIObject_release(self.attrRoot3);self.attrRoot3=nil;
_UIObject_release(self.attrRoot4);self.attrRoot4=nil;
end







function tipsChildGuBaoFSAttr:onLoaded(...)
self:bindComponents()
end


function tipsChildGuBaoFSAttr:__delete()
self:unbindComponents()
end


function tipsChildGuBaoFSAttr:onHide()

end

function tipsChildGuBaoFSAttr:onShow(args)
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

end
attrlist=cfgHelper.get2(cfg_gubaoconfig_get,gbid,'fly_attr')
for i=1,4 do
local attr=attrlist[i]
local isshow=attr~=nil
local item=self[FMT.fmt('attrRoot{0}',i)]
local itemWidget=item:getChildWidgetBase()
item:setActive(isshow)
if isshow then
local name,valstr=equipsHelper.getAttr(attr[2],attr[3])
itemWidget:SetChildText(0,FMT.fmt('{0}：{1}',name,valstr))
end
end
end

