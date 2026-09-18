







def_class("UIWorldMonsterSkillInfoWin",UIWindowBase)









function UIWorldMonsterSkillInfoWin:bindComponents()

self.closeButton=UIButton.get(self,0)
self.Icon=UIImage.get(self,1)
self.nameTxt=UIText.get(self,2)
self.descTxt=UIText.get(self,3)
self.costTxt=UIText.get(self,4)
self.coldTxt=UIText.get(self,5)
self.select=UIObject.get(self,6)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIWorldMonsterSkillInfoWin")end)



end


function UIWorldMonsterSkillInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.Icon);self.Icon=nil;
_UIObject_release(self.nameTxt);self.nameTxt=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.costTxt);self.costTxt=nil;
_UIObject_release(self.coldTxt);self.coldTxt=nil;
_UIObject_release(self.select);self.select=nil;
end



















function UIWorldMonsterSkillInfoWin:onLoaded(...)
self:bindComponents()
end


function UIWorldMonsterSkillInfoWin:__delete()
self:unbindComponents()
end




function UIWorldMonsterSkillInfoWin:onShow(argtable,afterOnloaded)
if not argtable then
return
end
local skillId=argtable[1]
local skillLevel=argtable[2]
local selectPos=argtable[3]
local skillCfg=cfg_skillconfig_get(skillId)
if skillCfg then
self.Icon:setImageIcon(iconHelper.getSkillIcon(skillCfg.icon),false)
self.nameTxt:setText(skillCfg.name)
self.descTxt:setText(skillModel:getSkillDesc(skillId,skillLevel))
self.coldTxt:setText(FMT.fmt("冷却：{0}回合",skillCfg.cooldownTime[skillLevel]or skillCfg.cooldownTime[1]))
end
if selectPos then
self.select:setActive(true)
self.select:setChildPosition(selectPos)
end

end


function UIWorldMonsterSkillInfoWin:onHide()

end



