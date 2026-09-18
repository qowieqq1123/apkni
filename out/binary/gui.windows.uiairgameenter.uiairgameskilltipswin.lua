







def_class("UIAirGameSkillTipsWin",UIWindowBase)









function UIAirGameSkillTipsWin:bindComponents()

self.blackImg=UIObject.get(self,0)
self.changeroot=UIObject.get(self,1)
self.displayBtn=UIButton.get(self,2)
self.displayTx=UIText.get(self,3)
self.extra=UIObject.get(self,4)
self.root=UIObject.get(self,5)
self.skilDesc=UIObject.get(self,6)
self.skillItem=UIObject.get(self,7)
self.title1=UIObject.get(self,8)
self.title2=UIObject.get(self,9)
self.title3=UIObject.get(self,10)
self.upgradeCondition=UIObject.get(self,11)

self.displayBtn:setButtonClick(function()self:onDisplayBtn()end)



end


function UIAirGameSkillTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackImg);self.blackImg=nil;
_UIObject_release(self.changeroot);self.changeroot=nil;
_UIObject_release(self.displayBtn);self.displayBtn=nil;
_UIObject_release(self.displayTx);self.displayTx=nil;
_UIObject_release(self.extra);self.extra=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.skilDesc);self.skilDesc=nil;
_UIObject_release(self.skillItem);self.skillItem=nil;
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.title2);self.title2=nil;
_UIObject_release(self.title3);self.title3=nil;
_UIObject_release(self.upgradeCondition);self.upgradeCondition=nil;
end



















function UIAirGameSkillTipsWin:onLoaded(...)
self:bindComponents()
end


function UIAirGameSkillTipsWin:__delete()
self:unbindComponents()
end




function UIAirGameSkillTipsWin:onShow(argtable,afterOnloaded)
self.skillid=argtable.skillid
self.skilllv=argtable.skilllv
self.skillCfg=cfgHelper.get1(cfg_airskillconfig_get,self.skillid)

self:refreshAll()
end


function UIAirGameSkillTipsWin:onHide()

end

function UIAirGameSkillTipsWin:refreshAll()
self:refreshSkillItem()

local isShowSkillDesc=self.skillCfg.desc~=nil
self.title1:setActive(isShowSkillDesc)
self.skilDesc:setActive(isShowSkillDesc)
if isShowSkillDesc then
self:refreshSkillDesc()
end

local skillDescWidget=self.skilDesc:getChildWidgetBase()
local isCoolDown=self.skillCfg.cd~=nil
skillDescWidget:SetChildActive(2,isCoolDown)
if isCoolDown then
local cooldown_str=FMT.fmt('冷却：{0}秒',self.skillCfg.cd)
skillDescWidget:SetChildText(3,cooldown_str)
end
end

local CmpSkillItemIndex={
name=0,
icon=1,
sign=2,
faction=3,
level=4,
}
function UIAirGameSkillTipsWin:refreshSkillItem()
local wb=self.skillItem:getWidgetBase()

wb:SetChildText(CmpSkillItemIndex.name,self.skillCfg.name)
if self.skillCfg.icon==nil then
logErr(FMT.fmt("air game lose skill icon ，skill：{0}",self.skillid))
end
local skiillIconName=iconHelper.getSkillIcon(self.skillCfg.icon or 1)
wb:SetChildIcon(CmpSkillItemIndex.icon,skiillIconName,false)
wb:SetChildText(CmpSkillItemIndex.level,FMT.fmt("{0}级",self.skilllv))
end

local CmpSkillDescItemIndex={
desctxt=0,
}
function UIAirGameSkillTipsWin:refreshSkillDesc()
local wb=self.skilDesc:getWidgetBase()

local skilllv=self.skilllv

local skillDesc=self.skillCfg.desc
if self.skillCfg.descParams then
local descParams=self.skillCfg.descParams
skillDesc=FMT.fmt(skillDesc,unpack(descParams[skilllv]))
end
wb:SetChildText(CmpSkillDescItemIndex.desctxt,skillDesc)
end





function UIAirGameSkillTipsWin:onDisplayBtn()
end

