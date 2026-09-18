







def_class("tipsChildMaterialDesc",UICloneObject)





tipsChildMaterialDesc.abName="ui/windows/tips/child/tipschildmaterialdesc.ab"

tipsChildMaterialDesc.assetName="tipsChildMaterialDesc"


function tipsChildMaterialDesc:bindComponents()

self.weiliTitle=UIText.get(self,0)
self.weiliDesc=UIText.get(self,1)
self.elementTitle=UIText.get(self,2)
self.elementDesc=UIText.get(self,3)
self.attrTitle=UIText.get(self,4)
self.attrDesc=UIText.get(self,5)
self.attrRoot=UIObject.get(self,6)
self.elementRoot=UIObject.get(self,7)
self.weiliRoot=UIObject.get(self,8)

end


function tipsChildMaterialDesc:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.weiliTitle);self.weiliTitle=nil;
_UIObject_release(self.weiliDesc);self.weiliDesc=nil;
_UIObject_release(self.elementTitle);self.elementTitle=nil;
_UIObject_release(self.elementDesc);self.elementDesc=nil;
_UIObject_release(self.attrTitle);self.attrTitle=nil;
_UIObject_release(self.attrDesc);self.attrDesc=nil;
_UIObject_release(self.attrRoot);self.attrRoot=nil;
_UIObject_release(self.elementRoot);self.elementRoot=nil;
_UIObject_release(self.weiliRoot);self.weiliRoot=nil;
end








function tipsChildMaterialDesc:onLoaded(...)
self:bindComponents()
end

function tipsChildMaterialDesc:__delete()
self:unbindComponents()
end

function tipsChildMaterialDesc:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx

local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach
self.diziguid=attach.diziguid

local itemConfig=itemsConfig.getConfig(itemid)

local power=itemConfig.power
local element=itemConfig.element

local lianhua=itemConfig.lianhua
local isEquip=itemsConfig.isEquip(itemid)
local fabaoRangeAttrs=fabaoHelper.getBaseAttrsRange(itemid)
if fabaoRangeAttrs then
local title=FMT.cfmt(FONT_COLOR.eTitle2Color,'作为法宝主材料时，法宝基础属性')
local attrStr=''
for i,v in ipairs(fabaoRangeAttrs)do
local attrId=v[1]
local min=v[2][1]
local max=v[2][2]
local attrname,minstr=equipsHelper.getAttr(attrId,min)
local attrname,maxstr=equipsHelper.getAttr(attrId,max)
local attrTxt=FMT.cfmt(FONT_COLOR.eTipWhiteColor,'{0}：{1}~{2}',attrname,minstr,maxstr)
attrStr=i~=1 and FMT.fmt('{0}\n{1}',attrStr,attrTxt)or attrTxt
end

self.attrTitle:setText(title)
self.attrDesc:setText(attrStr)
self.attrRoot:setActive(true)
else
self.attrRoot:setActive(false)
end

if power then
local title=FMT.cfmt(FONT_COLOR.eTitle2Color,'法宝炼制时，可提升五行威力')
local attrTxt
if not isEquip then
local min=mathHelper.decimal(power[1][1]/100)
local max=mathHelper.decimal(power[#power][2]/100)
attrTxt=element and FMT.cfmt(FONT_COLOR.eTipWhiteColor,'{0}系技能威力增加{1}%~{2}%',ELEMENT_TYPE.getName(element),min,max)
or FMT.cfmt(FONT_COLOR.eTipWhiteColor,'技能威力增加{0}%~{1}%',min,max)
else
local stagePower=power[#power]
local min=mathHelper.decimal(power[1][1][1]/100)
local max=mathHelper.decimal(stagePower[#stagePower][2]/100)
attrTxt=element and FMT.cfmt(FONT_COLOR.eTipWhiteColor,'{0}系技能威力增加{1}%~{2}%',ELEMENT_TYPE.getName(element),min,max)
or FMT.cfmt(FONT_COLOR.eTipWhiteColor,'技能威力增加{0}%~{1}%',min,max)
end
self.elementTitle:setText(title)
self.elementDesc:setText(attrTxt)
self.elementRoot:setActive(true)
else
self.elementRoot:setActive(false)
end

if lianhua then
local title=FMT.cfmt(FONT_COLOR.eTitle2Color,'法宝炼化时，可提升炼化属性')
local attrStr=''
for i,v in ipairs(lianhua)do
local attrId=v[1]
local range=v[2]
local step=v[3]
local eroFormat=type(range[1])=='number'
local attrname,minstr=equipsHelper.getAttr(attrId,eroFormat and range[1]*step or range[1][1]*step)
local attrname,maxstr=equipsHelper.getAttr(attrId,eroFormat and range[2]*step or range[#range][2]*step)
local attrTxt=FMT.cfmt(FONT_COLOR.eTipWhiteColor,'{0}：{1}~{2}',attrname,minstr,maxstr)
attrStr=i~=1 and FMT.fmt('{0}\n{1}',attrStr,attrTxt)or attrTxt
end
self.weiliTitle:setText(title)
self.weiliDesc:setText(attrStr)
self.weiliRoot:setActive(true)
else
self.weiliRoot:setActive(false)
end

end

function tipsChildMaterialDesc:onHide()

end


