







def_class("tipsChildFabaoTuPoAttr",UICloneObject)





tipsChildFabaoTuPoAttr.abName="ui/windows/tips/child/tipschildfabaotupoattr.ab"

tipsChildFabaoTuPoAttr.assetName="tipsChildFabaoTuPoAttr"


function tipsChildFabaoTuPoAttr:bindComponents()

self.line=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.creater=UIObject.get(self,2)

end


function tipsChildFabaoTuPoAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.creater);self.creater=nil;
end








function tipsChildFabaoTuPoAttr:onLoaded(...)
self:bindComponents()
end

function tipsChildFabaoTuPoAttr:__delete()
self:unbindComponents()
end

function tipsChildFabaoTuPoAttr:onShow(args,afterOnloaded)
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
local isCfg=itemguid==nil
if isCfg then
self:recycleSelf()
return
end
local item=fabaoHelper.getFabao(itemguid)
local tpAttrLookup=fabaoHelper.getTuPoAttrLookup(item)or{}
local tpAttrList=attrListHelper.transformToList(tpAttrLookup)
local bonus=fabaoHelper.getTuPoBonus(item)[1]
local temp={}
if bonus>0 then
temp[#temp+1]={1,bonus}
end

local len=#tpAttrList
local len1=#temp
local tlen=len+len1
if tlen<=0 then
self:recycleSelf()
return
end
self.creater:setChildLayoutGroupCreateItems(tlen)
local grids=self.creater:getChildLayoutGroupGridList()
for i=1,tlen do
local widget=grids[i-1]
if i<=len then
self:fillAttr(widget,tpAttrList[i])
else
self:fillBonusAttr(widget,temp[i-len])
end
end
end

function tipsChildFabaoTuPoAttr:onHide()

end



function tipsChildFabaoTuPoAttr:fillAttr(widget,attr)
local attrType=attr[1]
local attrValue=attr[2]
local name,valstr=equipsHelper.getAttr(attrType,attrValue)
local attrStr=FMT.fmt('{0}：{1}',name,valstr)
widget:SetChildText(0,attrStr)
end

function tipsChildFabaoTuPoAttr:fillBonusAttr(widget,bonus)
local bonusType=bonus[1]
local bonusValue=bonus[2]
if bonusType==1 then
widget:SetChildText(0,FMT.fmt('法宝神通等级 +{0}',bonusValue))
elseif bonusType==2 then
widget:SetChildText(0,FMT.fmt('法宝祭炼属性 +{0}%',bonusValue))
end
end