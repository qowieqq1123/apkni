







def_class("UIReportDisplayFaBaoWin",UIWindowBase)









function UIReportDisplayFaBaoWin:bindComponents()

self.skillBtn=UIButton.get(self,0)
self.skillIcon=UIImage.get(self,1)

self.skillBtn:setButtonClick(function()self:onSkillBtn()end)



end


function UIReportDisplayFaBaoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.skillBtn);self.skillBtn=nil;
_UIObject_release(self.skillIcon);self.skillIcon=nil;
end















local _this=nil



function UIReportDisplayFaBaoWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIReportDisplayFaBaoWin:__delete()
self:unbindComponents()
_this=nil
end




function UIReportDisplayFaBaoWin:onShow(argtable,afterOnloaded)
self.skillId=argtable.skillId
self.tipsType=argtable.tipsType

local skillCfg=cfgHelper.get1(cfg_skillconfig_get,self.skillId)
self.skillIcon:setImageIcon(iconHelper.getSkillIcon(skillCfg.icon),true)
end


function UIReportDisplayFaBaoWin:onHide()

end





function UIReportDisplayFaBaoWin:onSkillBtn()
UIManager.PreloadCtor("UIDiscipleJobSkillTipsWin")
local args={skillID=self.skillId,skillLv=1,attend=nil,changLv=false,hideReport=true,fromCfg=true}
UIManager:showWindow('UIDiscipleJobSkillTipsTopWin',args)
end

