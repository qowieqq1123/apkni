







def_class("tipsChildMount",UICloneObject)





tipsChildMount.abName="ui/windows/tips/child/tipschildmount.ab"

tipsChildMount.assetName="tipsChildMount"


function tipsChildMount:bindComponents()

self.name=UIText.get(self,0)
self.Icon=UIImage.get(self,1)
self.type=UIText.get(self,2)
self.jingjie=UIText.get(self,3)
self.fight=UIText.get(self,4)
self.equip=UIObject.get(self,5)
self.lock=UIButton.get(self,6)
self.unlock=UIButton.get(self,7)

self.lock:setButtonClick(function()self:onLock()end)

self.unlock:setButtonClick(function()self:onUnlock()end)

end


function tipsChildMount:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.Icon);self.Icon=nil;
_UIObject_release(self.type);self.type=nil;
_UIObject_release(self.jingjie);self.jingjie=nil;
_UIObject_release(self.fight);self.fight=nil;
_UIObject_release(self.equip);self.equip=nil;
_UIObject_release(self.lock);self.lock=nil;
_UIObject_release(self.unlock);self.unlock=nil;
end







local _descFun=function(title,desc)
return FMT.fmt('{0}{1}',FMT.cfmt(FONT_COLOR.eTitle2Color,title),
FMT.cfmt(FONT_COLOR.eGrayWhiteTxtColor,desc))
end

function tipsChildMount:onLoaded(...)
self:bindComponents()



end

function tipsChildMount:__delete()
self:unbindComponents()
end

function tipsChildMount:onShow(args,afterOnloaded)
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
self.isCompareTips=data.isCompareTips
local itemCfg=itemsConfig.getConfig(itemid)
self.itemguid=itemguid

self:fillInfo(itemid,itemguid,itemCfg,data)
end

function tipsChildMount:onHide()

end



function tipsChildMount:fillInfo(itemid,itemguid,itemCfg,data)
local type1=itemCfg.type1
local type2=itemCfg.type2
local equip=data


local name=itemCfg.name


local typetxt=_descFun('类型：','坐骑')


local fight=mountHelper.getFight(itemid)
local fightStr=_descFun('战力：',fight)


local jjLevel=cfgHelper.get2(cfg_disciplemountconfig_get,1,'jingjie')
local n,p,pN=UIDiscipleModel:getJJNameX(jjLevel)
local jingjieStr=_descFun('境界：',FMT.fmt('{0}期',n))

local itemCfg=itemsConfig.getConfig(itemid)
local iconName=iconHelper.getIconName(itemid)

local isEquip=mountModel:isEquipedOnAnyDZ(itemguid)
local isLock=bagHelper.isLock(equip)


if isEquip and self.formType==TIPS_FORM_TYPE.eEquipFilter then
local diziguid=mountModel:getDzguidByItemguid(itemguid)
if not self.isCompareTips and
not mathHelper.compareInt64(self.diziguid,diziguid)then
isEquip=false
end
end

self.name:setText(name)
self.Icon:setImageIcon(iconName,false)
self.type:setText(typetxt)
self.jingjie:setText(jingjieStr)
self.fight:setText(fightStr)
self.equip:setActive(isEquip)
self.lock:setActive(false)
self.unlock:setActive(false)
end

function tipsChildMount:onLock()

end

function tipsChildMount:onUnlock()

end

function tipsChildMount:changeLock(flag)






end






