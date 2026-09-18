







def_class("tipsChildTDLXAttr",UICloneObject)





tipsChildTDLXAttr.abName="ui/windows/tips/child/tipschildtdlxattr.ab"

tipsChildTDLXAttr.assetName="tipsChildTDLXAttr"


function tipsChildTDLXAttr:bindComponents()

self.attrRoot1=UIObject.get(self,0)
self.attrRoot2=UIObject.get(self,1)
self.attrRoot3=UIObject.get(self,2)
self.title=UIText.get(self,3)

end


function tipsChildTDLXAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrRoot1);self.attrRoot1=nil;
_UIObject_release(self.attrRoot2);self.attrRoot2=nil;
_UIObject_release(self.attrRoot3);self.attrRoot3=nil;
_UIObject_release(self.title);self.title=nil;
end









function tipsChildTDLXAttr:onLoaded(...)
self:bindComponents()
end


function tipsChildTDLXAttr:__delete()
self:unbindComponents()
end




function tipsChildTDLXAttr:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local tjId=wanLingTaModel:good2TDLX(data.itemid)
local tjCfg=wanLingTaModel:getTuJianConfig(tjId)
local attach=data.attach
local tjData=wanLingTaModel:getTuJianData(tjId)
local level=math.max(tjData.level,1)
local attrLookup=tjCfg.prop[level]
local attrlist={}
for attrType,attrValue in pairs(attrLookup)do
table.insert(attrlist,{attrType,attrValue})
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