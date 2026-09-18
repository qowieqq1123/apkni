







def_class("tipsChildBenMingFabaoAttr",UICloneObject)





tipsChildBenMingFabaoAttr.abName="ui/windows/tips/child/tipschildbenmingfabaoattr.ab"

tipsChildBenMingFabaoAttr.assetName="tipsChildBenMingFabaoAttr"


function tipsChildBenMingFabaoAttr:bindComponents()

self.line=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.creater=UIObject.get(self,2)
self.warnRoot=UIObject.get(self,3)
self.warn=UIText.get(self,4)

end


function tipsChildBenMingFabaoAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.creater);self.creater=nil;
_UIObject_release(self.warnRoot);self.warnRoot=nil;
_UIObject_release(self.warn);self.warn=nil;
end








function tipsChildBenMingFabaoAttr:onLoaded(...)
self:bindComponents()
end

function tipsChildBenMingFabaoAttr:__delete()
self:unbindComponents()
end

function tipsChildBenMingFabaoAttr:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local diziguid=attach.diziguid
self.diziguid=diziguid
self.itemid=itemid
self.formType=data.formType
local itemConfig=itemsConfig.getConfig(itemid)
self.itemguid=itemguid
local fabao=fabaoHelper.getFabao(itemguid)

local lxlv=fabaoModel.getLingXingLv(itemguid)
local lxdesc=lxlv>0 and FMT.fmt('灵性蕴养（{0}级）',lxlv)or
'灵性蕴养（尚未蕴养）'

self.title:setText(lxdesc)
local ownerid=benMingFaBaoHelper.getOwner(itemguid)
local isPreview=fabaoPreviewModel:isPreview(itemguid)
local hasEquiped=fabaoModel.isEquipedOnAnyDizi(itemguid)
local vis=hasEquiped and not benMingFaBaoHelper.isDressSelf(fabao)or false
self.warnRoot:setActive(vis)

local mainid=fabaoHelper.getReallyMainId(fabao)
local attrs=benMingFaBaoHelper.getLxAttr(mainid,lxlv)or{}
local bonuslist=benMingFaBaoHelper.getLxEffectList(lxlv)
local addPrcent=benMingFaBaoHelper.getAddLxAttrPrecent(itemguid)
local attrLen=#attrs
local len=attrLen+#bonuslist
self.creater:setChildLayoutGroupCreateItems(len)
local grids=self.creater:getChildLayoutGroupGridList()
local bonusIdx=0
for i=1,len do
local item=grids[i-1]
if i<=attrLen then
local attr=attrs[i]
self:fillAttr(item,attr[1],attr[2],math.floor(attr[2]*addPrcent/100),vis)
else
bonusIdx=bonusIdx+1
self:fillLx(item,itemguid,bonuslist[bonusIdx],lxlv)
end
end
end

function tipsChildBenMingFabaoAttr:onHide()

end




function tipsChildBenMingFabaoAttr:fillAttr(item,attrType,attrValue,add,gray)
local name,valstr=equipsHelper.getAttr(attrType,attrValue)
local attrStr=FMT.fmt('{0}：{1}',name,valstr)
item:SetChildText(0,gray and FMT.cfmt(FONT_COLOR.eGrayColor,attrStr)or attrStr)
item:SetChildActive(1,add>0)
if add>0 then
item:SetChildText(3,gray and FMT.cfmt(FONT_COLOR.eGrayColor,add)or add)
end
item:SetChildImageExGray(2,gray)
end

function tipsChildBenMingFabaoAttr:fillLx(item,itemguid,bonus,lxlv)
local effectType=bonus[1]
local name,desc=benMingFaBaoHelper.getDescByType(itemguid,lxlv,effectType)
item:SetChildText(0,FMT.cfmt2('#5ac0e2','【{0}】{1}',name,desc))
end