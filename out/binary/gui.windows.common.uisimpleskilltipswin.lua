







def_class("UISimpleSkillTipsWin",UIWindowBase)









function UISimpleSkillTipsWin:bindComponents()

self.skillname=UIText.get(self,0)
self.skillDescTxt=UIText.get(self,1)
self.clicker=UIButton.get(self,2)
self.root=UIObject.get(self,3)
self.skillIcon=UIObject.get(self,4)
self.skillSign=UIObject.get(self,5)

self.clicker:setButtonClick(function()self:onClicker()end)



end


function UISimpleSkillTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.skillname);self.skillname=nil;
_UIObject_release(self.skillDescTxt);self.skillDescTxt=nil;
_UIObject_release(self.clicker);self.clicker=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.skillIcon);self.skillIcon=nil;
_UIObject_release(self.skillSign);self.skillSign=nil;
end



















function UISimpleSkillTipsWin:onLoaded(...)
self:bindComponents()
end


function UISimpleSkillTipsWin:__delete()
self:unbindComponents()
end




function UISimpleSkillTipsWin:onShow(argtable,afterOnloaded)
self.skillId=argtable.skillId
self.skillLv=argtable.skillLv
self.rootPoint=argtable.rootPoint

local skillCfg=cfgHelper.get1(cfg_skillconfig_get,self.skillId)
local isbd=skillModel.isSkillBD(skillCfg.skillType)

self.skillname:setText(skillCfg.name)
self.skillIcon:setIcon(iconHelper.getSkillIcon(skillCfg.icon),false)
self.skillSign:setActive(isbd)
self.skillDescTxt:setText(skillModel:getSkillDesc(self.skillId,self.skillLv))
if self.rootPoint then
if self.rootPoint.anchorsMin and self.rootPoint.anchorsMax then
self.winlua:SetChildAnchors(self.root:getID(),self.rootPoint.anchorsMin,self.rootPoint.anchorsMax)
end
if self.rootPoint.pivot then
self.winlua:SetChildPivot(self.root:getID(),self.rootPoint.pivot)
end
if self.rootPoint.anchoredPosition then
self.winlua:SetChildAnchoredPosition(self.root:getID(),self.rootPoint.anchoredPosition)
end
end
end


function UISimpleSkillTipsWin:onHide()

end





function UISimpleSkillTipsWin:onClicker()
self:closeSelf()
end

