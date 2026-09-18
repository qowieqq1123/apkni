







def_class("tipsChildYunZhouEquipSuit",UICloneObject)





tipsChildYunZhouEquipSuit.abName="ui/windows/tips/child/tipschildyunzhouequipsuit.ab"

tipsChildYunZhouEquipSuit.assetName="tipsChildYunZhouEquipSuit"


function tipsChildYunZhouEquipSuit:bindComponents()

self.attr1=UIText.get(self,0)
self.attr2=UIText.get(self,1)
self.attr3=UIText.get(self,2)
self.attrRoot1=UIObject.get(self,3)
self.attrRoot2=UIObject.get(self,4)
self.attrRoot3=UIObject.get(self,5)
self.line=UIObject.get(self,6)
self.suitIcon=UIObject.get(self,7)
self.suitTips=UIText.get(self,8)
self.suitTipsPanel=UIObject.get(self,9)
self.title=UIText.get(self,10)

end


function tipsChildYunZhouEquipSuit:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attr1);self.attr1=nil;
_UIObject_release(self.attr2);self.attr2=nil;
_UIObject_release(self.attr3);self.attr3=nil;
_UIObject_release(self.attrRoot1);self.attrRoot1=nil;
_UIObject_release(self.attrRoot2);self.attrRoot2=nil;
_UIObject_release(self.attrRoot3);self.attrRoot3=nil;
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.suitIcon);self.suitIcon=nil;
_UIObject_release(self.suitTips);self.suitTips=nil;
_UIObject_release(self.suitTipsPanel);self.suitTipsPanel=nil;
_UIObject_release(self.title);self.title=nil;
end









function tipsChildYunZhouEquipSuit:onLoaded(...)
self:bindComponents()
end


function tipsChildYunZhouEquipSuit:__delete()
self:unbindComponents()
end




function tipsChildYunZhouEquipSuit:onShow(argtable,afterOnloaded)
local data=argtable.argtable
local childType=argtable.childType
local nodeidx=argtable.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
local yzId=attach.yzId
local suitData=attach.suitData

local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local suitid=itemConfig.type2
local suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,suitid,color)
if suitConfig==nil then
self:recycleSelf()
return
end
if not suitData then
suitData=XianYunGangModel:getYunZhouComponentsSuitData(yzId)
end
local hasNum=suitData[suitid]and suitData[suitid].num or 0
local suitLevel=suitData[suitid]and suitData[suitid].lv or 1
if suitData[suitid]then
suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,suitid,suitLevel)
end

local attr2desc=suitConfig.attr2desc
self.attrRoot1:setActive(attr2desc~=nil)
if attr2desc then
local attr4name=FMT.fmt('[{0}]',string.addSpace('2件套',true))
local fontColor=hasNum>=2 and FONT_COLOR.ePurpleActiveColor or FONT_COLOR.eGrayColor
local desc=FMT.cfmt(fontColor,'{0}\n{1}',attr4name,attr2desc)
self.attr1:setText(desc)
end

local attr3desc=suitConfig.attr3desc
self.attrRoot2:setActive(attr3desc~=nil)
if attr3desc then
local attr4name=FMT.fmt('[{0}]',string.addSpace('3件套',true))
local fontColor=hasNum>=3 and FONT_COLOR.ePurpleActiveColor or FONT_COLOR.eGrayColor
local desc=FMT.cfmt(fontColor,'{0}\n{1}',attr4name,attr3desc)
self.attr2:setText(desc)
end

self.attrRoot3:setActive(false)

local name=FMT.fmt('套装效果（{0}：{1}/3）<color=#a18cfd>[ {2}级效果 ]</color>',suitConfig.name,hasNum,suitLevel)
self.title:setText(name)
self.suitIcon:setIcon(string.format("icon_suit_%d",suitConfig.icon),false)

local showTips=hasNum>=3 and color<eQualityColor.eRed
self.suitTipsPanel:setActive(showTips)
if showTips then
local nextColor=color+1
local colroDesc=FMT.cfmt(nextColor,string.format("[%s品质]",itemsConfig.getColorDesc(nextColor)))
self.suitTips:setText(string.format("穿戴套装阵器均提升至%s\n套装效果等级提升至%d级",colroDesc,nextColor))
end

self.line:setActive(not self:isLastItem())
end

function tipsChildYunZhouEquipSuit:onRecycle()
self.line:setActive(not self:isLastItem())
end