







def_class("tipsChildXianBaoAttr",UICloneObject)





tipsChildXianBaoAttr.abName="ui/windows/tips/child/tipschildxianbaoattr.ab"

tipsChildXianBaoAttr.assetName="tipsChildXianBaoAttr"


function tipsChildXianBaoAttr:bindComponents()

self.attrRoot1=UIObject.get(self,0)
self.attrRoot2=UIObject.get(self,1)
self.attrRoot3=UIObject.get(self,2)

end


function tipsChildXianBaoAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrRoot1);self.attrRoot1=nil;
_UIObject_release(self.attrRoot2);self.attrRoot2=nil;
_UIObject_release(self.attrRoot3);self.attrRoot3=nil;
end









function tipsChildXianBaoAttr:onLoaded(...)
self:bindComponents()
end


function tipsChildXianBaoAttr:__delete()
self:unbindComponents()
end




function tipsChildXianBaoAttr:onShow(argtable,afterOnloaded)
local data=argtable.argtable
local childType=argtable.childType
local nodeidx=argtable.nodeidx
local xbid=data.itemid
local attach=data.attach
local formType=data.formType
local xbtype=data.xbtype or XianBaoTypeEnum.eXianBao

local dfxb=xianbaoModel:CheckDianfengXianbao(xbid)
if dfxb then
local dflevel=DianFengLevelModel:getLevel()
local cfglvl=cfg_dianfenglevelconfig_get(dflevel)
local attrs=cfglvl.attrs
for i=1,3 do
local attr=attrs[i]
local isshow=attr~=nil
local item=self[FMT.fmt('attrRoot{0}',i)]
local itemWidget=item:getChildWidgetBase()
item:setActive(isshow)
if isshow then
local GBaddval=gubaoModel:getXianBaoAttr(xbid)
local attrval=attr[2]

if not attrListHelper.isMod(attr[1])then
attrval=math.floor(attrval*(1+GBaddval/100))
end
local name,valstr=equipsHelper.getAttr(attr[1],attrval)
itemWidget:SetChildText(0,FMT.fmt('{0}：{1}',name,valstr))
end
end
else
local starlv=xianbaoConfig.getTypeFuncResult(xbtype,'getLevel',{xbid,attach})
local attrlist=xianbaoConfig.getTypeFuncResult(xbtype,'getTipsAttrList',{xbid,starlv})
for i=1,3 do
local attr=attrlist[i]
local isshow=attr~=nil
local item=self[FMT.fmt('attrRoot{0}',i)]
local itemWidget=item:getChildWidgetBase()
item:setActive(isshow)
if isshow then
local GBaddval=gubaoModel:getXianBaoAttr(xbid)
local attrval=attr[2]

if not attrListHelper.isMod(attr[1])then
attrval=math.floor(attrval*(1+GBaddval/100))
end
local name,valstr=equipsHelper.getAttr(attr[1],attrval)
itemWidget:SetChildText(0,FMT.fmt('{0}：{1}',name,valstr))
end
end
end
end


function tipsChildXianBaoAttr:onHide()

end


