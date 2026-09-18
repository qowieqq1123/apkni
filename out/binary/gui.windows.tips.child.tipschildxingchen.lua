







def_class("tipsChildXingChen",UICloneObject)





tipsChildXingChen.abName="ui/windows/tips/child/tipschildxingchen.ab"

tipsChildXingChen.assetName="tipsChildXingChen"


function tipsChildXingChen:bindComponents()

self.equip=UIObject.get(self,0)
self.Icon=UIImage.get(self,1)
self.level=UIText.get(self,2)
self.lock=UIButton.get(self,3)
self.name=UIText.get(self,4)
self.type1=UIText.get(self,5)
self.unlock=UIButton.get(self,6)

self.lock:setButtonClick(function()self:onLock()end)

self.unlock:setButtonClick(function()self:onUnlock()end)

end


function tipsChildXingChen:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.equip);self.equip=nil;
_UIObject_release(self.Icon);self.Icon=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.lock);self.lock=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.type1);self.type1=nil;
_UIObject_release(self.unlock);self.unlock=nil;
end








local _descFun=function(title,desc)
return FMT.fmt('{0}{1}',FMT.cfmt(FONT_COLOR.eTitle2Color,title),
FMT.cfmt(FONT_COLOR.eGrayWhiteTxtColor,desc))
end

function tipsChildXingChen:onLoaded(...)
self:bindComponents()
end


function tipsChildXingChen:__delete()
self:unbindComponents()
end




function tipsChildXingChen:onShow(args,afterOnloaded)
local data=args.argtable
local childType=args.childType
local nodeidx=args.nodeidx
local itemid=data.itemid
self.itemid=itemid
local itemguid=data.itemguid
local attach=data.attach
self.attach=attach

local equip=itemsModel.getItem(itemguid)
local rare=false
if equip then
rare=equip.itemData and equip.itemData.fin_rare_id and equip.itemData.fin_rare_id~=0
end
local config=itemsConfig.getConfig(itemid)

self.name:setText(rare and FMT.fmt("稀·{0}",itemsConfig.getItemName(itemid))or itemsConfig.getItemName(itemid))

local iconname=data and itemsModel.getIconName(data)or
iconHelper.getIconName(itemid)
self.Icon:setImageIcon(iconname,false)

self.type1:setText(_descFun("类型：","星辰"))


self.level:setText(_descFun("战力：",self.getEquipFightX(config.type1,itemid,itemguid)))

self.equip:setActive(xingChenBagModel:getEquip(itemguid)~=nil)
end

function tipsChildXingChen.getEquipFightX(idx,itemid,itemguid)

local attrlist=xingChenHelper.getFixedAttr(itemid,1)

local fight=0
for k,v in ipairs(attrlist)do
local config=cfg_attributesconfig_get(v[1])
if config==nil then
loggerUtil.logErrFMT('装备属性类型{0}没有找到',v[1])
return 0
end
fight=fight+config.unitVal*v[2]
end
fight=math.floor(fight)

return fight
end


function tipsChildXingChen:onHide()

end




