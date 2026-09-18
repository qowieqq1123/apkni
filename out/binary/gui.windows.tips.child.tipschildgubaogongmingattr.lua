







def_class("tipsChildGuBaoGongMingAttr",UICloneObject)





tipsChildGuBaoGongMingAttr.abName="ui/windows/tips/child/tipschildgubaogongmingattr.ab"

tipsChildGuBaoGongMingAttr.assetName="tipsChildGuBaoGongMingAttr"


function tipsChildGuBaoGongMingAttr:bindComponents()

self.titleText=UIText.get(self,0)
self.creater=UIObject.get(self,1)

end


function tipsChildGuBaoGongMingAttr:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.creater);self.creater=nil;
end









function tipsChildGuBaoGongMingAttr:onLoaded(...)
self:bindComponents()
end


function tipsChildGuBaoGongMingAttr:__delete()
self:unbindComponents()
end




function tipsChildGuBaoGongMingAttr:onShow(args,afterOnloaded)
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
local equip=equipsHelper.getEquip(itemguid)
self.showEnhancelv=attach and attach.showEnhancelv

local gongMingLv=equip and vocEquipModel:getVocEquipGongMingLv(itemid)or 0
if self.showEnhancelv and self.showEnhancelv>0 then
gongMingLv=vocEquipModel:getVocEquipGongMingLv(itemid)
end
local showGongMingLv=gongMingLv>0 and gongMingLv or 1


self.titleText:setText(FMT.fmt("共鸣属性（{0}级）",showGongMingLv))

local maxLv=vocEquipHelper.getVocEquipGongMingMaxLv(itemid)
local nextLv=gongMingLv<maxLv and gongMingLv+1 or gongMingLv
local nowLvAttrs=gongMingLv>0 and vocEquipHelper.getVocEquipGongMingActiveAttrsByLevel(itemid,gongMingLv)or{}
local nextLvAttrs=vocEquipHelper.getVocEquipGongMingActiveAttrsByLevel(itemid,nextLv)or{}
local nextLvAttrs_lookup={}
if gongMingLv<=0 then
nowLvAttrs=nextLvAttrs
end
for _,attr in ipairs(nextLvAttrs)do
local attrId=attr[1]
local attrValue=attr[2]
nextLvAttrs_lookup[attrId]=attrValue
end

self.creater:setChildLayoutGroupCreateItems(#nowLvAttrs,function(index)
local widget=self.creater:getChildLayoutGroupGridItem(index-1)
local attr=nowLvAttrs[index]
if attr then
widget:SetChildActive(-1,true)
local attrId=attr[1]
local attrValue=attr[2]
local attrName,attrValueStr=equipsHelper.getAttr(attrId,attrValue)
if attrValue>0 then
attrValueStr=string.format("+%s",attrValueStr)
end
local str=string.format("%s：%s",attrName,attrValueStr)
widget:SetChildText(0,str)

local addStr=""
if gongMingLv<=0 then
addStr="<color=#8e8c87>（未激活）</color>"
else
local nextAttrValue=nextLvAttrs_lookup[attrId]
if nextAttrValue and nextAttrValue~=attrValue then
local addValue=nextAttrValue-attrValue
local _,addAttrValueStr=equipsHelper.getAttr(attrId,addValue)
if addValue>0 then
addAttrValueStr=string.format("+%s",addAttrValueStr)
end
addStr=FMT.fmt("{0}（{1}级）",addAttrValueStr,nextLv)
end
end
widget:SetChildText(1,addStr)
else
widget:SetChildActive(-1,false)
end
end)
end


function tipsChildGuBaoGongMingAttr:onHide()

end


