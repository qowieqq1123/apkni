







def_class("UIReportDisplayGongFaWin",UIWindowBase)









function UIReportDisplayGongFaWin:bindComponents()

self.skillItem_0=UIButton.get(self,0)
self.skillItem_1=UIButton.get(self,1)
self.skillItem_2=UIButton.get(self,2)

self.skillItem_0:setButtonClick(function()self:onSkillItem_0()end)

self.skillItem_1:setButtonClick(function()self:onSkillItem_1()end)

self.skillItem_2:setButtonClick(function()self:onSkillItem_2()end)
self.skillItem={
[0]=self.skillItem_0,
[1]=self.skillItem_1,
[2]=self.skillItem_2,
}



end


function UIReportDisplayGongFaWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.skillItem_0);self.skillItem_0=nil;
_UIObject_release(self.skillItem_1);self.skillItem_1=nil;
_UIObject_release(self.skillItem_2);self.skillItem_2=nil;
self.skillItem=nil;
end















local _this=nil
local _skillCmp={
button=-1,
icon=0,
name=1,
sign=2,
}



function UIReportDisplayGongFaWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIReportDisplayGongFaWin:__delete()
self:unbindComponents()
_this=nil
end




function UIReportDisplayGongFaWin:onShow(argtable,afterOnloaded)
self.gongfa=argtable.gongfaId

local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,self.gongfa)
local skillWidget0=self.skillItem_0:getWidgetBase()
skillWidget0:SetChildIcon(_skillCmp.icon,iconHelper.getSkillIcon(cfg.icon),true)
skillWidget0:SetChildText(_skillCmp.name,cfg.name)
skillWidget0:SetChildActive(_skillCmp.sign,false)

for index=1,2 do
local skillItem=self.skillItem[index]
local skillWidget=skillItem:getWidgetBase()
local skillID=cfg.skill[index]
local hasSkill=skillID~=nil
skillWidget:SetChildActive(_skillCmp.button,hasSkill)
if hasSkill then
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
skillWidget:SetChildIcon(_skillCmp.icon,iconHelper.getSkillIcon(skillCfg.icon),true)
local is_bd=skillModel.isSkillBD(skillCfg.skillType)
skillWidget:SetChildActive(_skillCmp.sign,is_bd)
skillWidget:SetChildText(_skillCmp.name,skillCfg.name)
end
end
end


function UIReportDisplayGongFaWin:onHide()

end





function UIReportDisplayGongFaWin:onSkillItem_0()
UIManager.PreloadCtor("UIGongFaTipsFiveWin")
UIManager:showWindow('UIGongFaTipsFiveTopWin',{gfID=self.gongfa})
end



function UIReportDisplayGongFaWin:onSkillItem_1()
self:showSkillTips(1)
end



function UIReportDisplayGongFaWin:onSkillItem_2()
self:showSkillTips(2)
end

function UIReportDisplayGongFaWin:showSkillTips(index)
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,self.gongfa)
local skillID=cfg.skill[index]
local args={skillID=skillID,skillLv=1,attend=nil,changLv=false,hideReport=true,fromCfg=true}
UIManager.PreloadCtor("UIDiscipleJobSkillTipsWin")
UIManager:showWindow('UIDiscipleJobSkillTipsTopWin',args)
end