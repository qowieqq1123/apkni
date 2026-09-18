







def_class("tipsChildEquipSuit",UICloneObject)





tipsChildEquipSuit.abName="ui/windows/tips/child/tipschildequipsuit.ab"

tipsChildEquipSuit.assetName="tipsChildEquipSuit"


function tipsChildEquipSuit:bindComponents()

self.attrRoot1=UIObject.get(self,0)
self.attrRoot2=UIObject.get(self,1)
self.attrRoot3=UIObject.get(self,2)
self.line=UIObject.get(self,3)
self.title=UIText.get(self,4)
self.attr1=UIText.get(self,5)
self.attr2=UIText.get(self,6)
self.attr3=UIText.get(self,7)
self.suitIcon=UIObject.get(self,8)

end


function tipsChildEquipSuit:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrRoot1);self.attrRoot1=nil;
_UIObject_release(self.attrRoot2);self.attrRoot2=nil;
_UIObject_release(self.attrRoot3);self.attrRoot3=nil;
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.attr1);self.attr1=nil;
_UIObject_release(self.attr2);self.attr2=nil;
_UIObject_release(self.attr3);self.attr3=nil;
_UIObject_release(self.suitIcon);self.suitIcon=nil;
end






function tipsChildEquipSuit:onLoaded()
self:bindComponents()
end

function tipsChildEquipSuit:__delete()
self:unbindComponents()
end

function tipsChildEquipSuit:onShow(args)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local diziguid=attach.diziguid

local equip=equipsHelper.getEquip(itemguid)
local itemData=equip and equip.itemData or{}

if equip==nil then
self:recycleSelf()
return
end
local suitid=itemData.suitid
local suitConfig=equipsConfig.getSuitConfig(suitid)
if suitConfig==nil then
self:recycleSelf()
return
end
local suitList={}
if diziguid then
if UIDiscipleModel:isMyActorDZ(diziguid)then
suitList=equipsModel.getEquipSuit(diziguid,suitid)
else
suitList=otherPlayerModel.getEquipSuit(diziguid,suitid)
end
end

local hasNum=#suitList
if suitConfig==nil then return end

local attr2desc=suitConfig.attr2desc
self.attrRoot1:setActive(attr2desc~=nil)
if attr2desc then
local attr4name=FMT.fmt('[{0}]',string.addSpace('2件套',true))
local fontColor=hasNum>=2 and FONT_COLOR.ePurpleActiveColor or FONT_COLOR.eGrayColor
local desc=FMT.cfmt(fontColor,'{0}\194\160{1}',attr4name,attr2desc)
self.attr1:setText(desc)
end

local attr3desc=suitConfig.attr3desc
self.attrRoot2:setActive(attr3desc~=nil)
if attr3desc then
local attr4name=FMT.fmt('[{0}]',string.addSpace('3件套',true))
local fontColor=hasNum>=3 and FONT_COLOR.ePurpleActiveColor or FONT_COLOR.eGrayColor
local desc=FMT.cfmt(fontColor,'{0}\194\160{1}',attr4name,attr3desc)
self.attr2:setText(desc)
end

local name=FMT.fmt('（{0}/3）',hasNum)
name=FMT.fmt('{0}{1}',suitConfig.name,name)
self.attrRoot3:setActive(false)
self.title:setText(name)
self.suitIcon:setIcon(equipsHelper.getEquipSuitIcon(equip),false)
self.line:setActive(not self:isLastItem())
end

function tipsChildEquipSuit:onRecycle()
self.line:setActive(not self:isLastItem())
end