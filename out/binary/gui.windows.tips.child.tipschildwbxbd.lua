







def_class("tipsChildWBXBD",UICloneObject)





tipsChildWBXBD.abName="ui/windows/tips/child/tipschildwbxbd.ab"

tipsChildWBXBD.assetName="tipsChildWBXBD"


function tipsChildWBXBD:bindComponents()

self.name=UIText.get(self,0)
self.typename=UIText.get(self,1)
self.part=UIText.get(self,2)
self.icon=UIImage.get(self,3)

end


function tipsChildWBXBD:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.typename);self.typename=nil;
_UIObject_release(self.part);self.part=nil;
_UIObject_release(self.icon);self.icon=nil;
end






local typeName={
[1]='头饰'
}

local _descFun=function(title,desc)
return FMT.fmt('{0}{1}',FMT.cfmt(FONT_COLOR.eTitle2Color,title),
FMT.cfmt(FONT_COLOR.eGrayWhiteTxtColor,desc))
end




function tipsChildWBXBD:onLoaded(...)
self:bindComponents()
end


function tipsChildWBXBD:__delete()
self:unbindComponents()
end




function tipsChildWBXBD:onShow(argtable,afterOnloaded)
local data=argtable.argtable
local itemid=data.itemid
local itemguid=data.itemguid
local config=itemsConfig.getConfig(itemid)
local itemIconName=iconHelper.getIconName(itemid)

local jl_lv=0
if itemguid then
local itemdata=wanBaoXunBaoDuiModel:getEquipDataByGuid(itemguid)
if itemdata then
jl_lv=itemdata.itemData and itemdata.itemData.jl_lv or 0
end
end

local itemName=config.name

if jl_lv>0 then
itemName=FMT.fmt("{0} +{1}",itemName,jl_lv)
end
self.name:setText(itemName)
self.icon:setImageIcon(itemIconName,false)
self.typename:setText(_descFun('类型：','猫猫装备'))
self.typename:setActive(true)
self.part:setText(_descFun('部位：',typeName[config.type1]))
self.part:setActive(true)
end


function tipsChildWBXBD:onHide()

end


