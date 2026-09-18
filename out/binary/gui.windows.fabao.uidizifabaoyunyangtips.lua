







def_class("UIDiZiFabaoYunYangTips",UIWindowBase)









function UIDiZiFabaoYunYangTips:bindComponents()

self.fbname=UIText.get(self,0)
self.lxlv=UIText.get(self,1)
self.desc=UIText.get(self,2)
self.yunyangBtn=UIButton.get(self,3)
self.btnWatch=UIButton.get(self,4)
self.iconBg=UIImage.get(self,5)
self.icon=UIObject.get(self,6)
self.closeTag=UIObject.get(self,7)
self.openTag=UIObject.get(self,8)

self.yunyangBtn:setButtonClick(function()self:onYunyangBtn()end)

self.btnWatch:setButtonClick(function()self:onBtnWatch()end)



end


function UIDiZiFabaoYunYangTips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.fbname);self.fbname=nil;
_UIObject_release(self.lxlv);self.lxlv=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.yunyangBtn);self.yunyangBtn=nil;
_UIObject_release(self.btnWatch);self.btnWatch=nil;
_UIObject_release(self.iconBg);self.iconBg=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.closeTag);self.closeTag=nil;
_UIObject_release(self.openTag);self.openTag=nil;
end


















function UIDiZiFabaoYunYangTips:onLoaded(...)
self:bindComponents()
end

function UIDiZiFabaoYunYangTips:__delete()
self:unbindComponents()
end

function UIDiZiFabaoYunYangTips:onShow(argtable,afterOnloaded)
local dzguid=argtable.dzguid
local equip=fabaoModel.getFabaoByDizi(dzguid)
local itemguid=equip.itemguid
self.itemguid=itemguid
self.equip=equip
local itemid=equip.itemid
local itemCfg=itemsConfig.getConfig(equip.itemid)
local lv=fabaoModel.getLingXingLv(itemguid)
local desc1='本命法宝蕴养中，将会自动吸收法宝主人获取修为的50%转化为灵性值'
local desc2='本命法宝已停止蕴养，将不会吸收法宝主人获取的修为值'
local isYunYang=fabaoModel.isYunYang(equip)

self.iconBg:setSprite(globalABLookup.global,fabaoConfig.bmQualityBg[itemCfg.color])
self.icon:setChildIcon(itemsModel.getIconName(equip),true)
self.fbname:setText(fabaoHelper.getFabaoName(equip))
self.lxlv:setText(FMT.fmt('灵性：{0}级',lv))
self.desc:setText(isYunYang and desc1 or desc2)
self.closeTag:setActive(not isYunYang)
self.openTag:setActive(isYunYang)
end

function UIDiZiFabaoYunYangTips:onHide()

end





function UIDiZiFabaoYunYangTips:onYunyangBtn()
local itemguid=self.itemguid
local has=benMingFaBaoHelper.hasOwner(itemguid)
if not has then
UIManager.error('暂无主人，无法蕴养')
return
end
local equip=self.equip
local flag=fabaoModel.isYunYang(equip)
fabaoProtocolControl.reqYunYang(itemguid,not flag)
end



function UIDiZiFabaoYunYangTips:onBtnWatch()
local itemguid=self.itemguid
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.fabaoBenMingInfo,{itemguid=itemguid})
self:closeSelf()
end


function UIDiZiFabaoYunYangTips:onYunYangRet(itemguid)
if tostring(itemguid)~=tostring(self.itemguid)then return end
local equip=self.equip
local isYunYang=fabaoModel.isYunYang(equip)
self.closeTag:setActive(not isYunYang)
self.openTag:setActive(isYunYang)
local desc1='本命法宝蕴养中，将会自动吸收法宝主人获取修为的50%转化为灵性值'
local desc2='本命法宝已停止蕴养，将不会吸收法宝主人获取的修为值'
self.desc:setText(isYunYang and desc1 or desc2)
end
