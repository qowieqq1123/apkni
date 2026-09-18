







def_class("tipsChildEquipFixSuit",UICloneObject)





tipsChildEquipFixSuit.abName="ui/windows/tips/child/tipschildequipfixsuit.ab"

tipsChildEquipFixSuit.assetName="tipsChildEquipFixSuit"


function tipsChildEquipFixSuit:bindComponents()

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


function tipsChildEquipFixSuit:unbindComponents()
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








function tipsChildEquipFixSuit:onLoaded(...)
self:bindComponents()
end

function tipsChildEquipFixSuit:__delete()
self:unbindComponents()
end

function tipsChildEquipFixSuit:onShow(args)
local data=args.argtable
local itemid=data.itemid
local itemCfg=itemsConfig.getConfig(itemid)

local suitid=itemCfg.fix[0].suitid
local suitConfig=equipsConfig.getSuitConfig(suitid)
if suitConfig==nil then
self:recycleSelf()
return
end

local attr2desc=suitConfig.attr2desc
self.attrRoot1:setActive(attr2desc~=nil)
if attr2desc then
local attr4name=FMT.fmt('[{0}]',string.addSpace('2件套',true))
local fontColor=FONT_COLOR.eGrayColor
local desc=FMT.cfmt(fontColor,'{0}\194\160{1}',attr4name,attr2desc)
self.attr1:setText(desc)
end

local attr3desc=suitConfig.attr3desc
self.attrRoot2:setActive(attr3desc~=nil)
if attr3desc then
local attr4name=FMT.fmt('[{0}]',string.addSpace('3件套',true))
local fontColor=FONT_COLOR.eGrayColor
local desc=FMT.cfmt(fontColor,'{0}\194\160{1}',attr4name,attr3desc)
self.attr2:setText(desc)
end

local name=FMT.fmt('{0}（0/3）',suitConfig.name)
self.attrRoot3:setActive(false)
self.title:setText(name)
self.suitIcon:setIcon(equipsHelper.getEquipSuitIconById(suitid),false)
self.line:setActive(not self:isLastItem())
end

function tipsChildEquipFixSuit:onRecycle()
self.line:setActive(not self:isLastItem())
end