







def_class("UIFightPrepareWorldBigBossSkillWin",UIWindowBase)









function UIFightPrepareWorldBigBossSkillWin:bindComponents()

self.skillList=UIObject.get(self,0)
self.tips=UIText.get(self,1)



end


function UIFightPrepareWorldBigBossSkillWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.skillList);self.skillList=nil;
_UIObject_release(self.tips);self.tips=nil;
end



















function UIFightPrepareWorldBigBossSkillWin:onLoaded(...)
self:bindComponents()
end


function UIFightPrepareWorldBigBossSkillWin:__delete()
self:unbindComponents()
end




function UIFightPrepareWorldBigBossSkillWin:onShow(argtable,afterOnloaded)
local tipsStr=argtable.tips
self.tips:setText(tipsStr or"")

local monsterId=argtable.id
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterId)
local skillList=monsterCfg.showSkills or{}
self.skillList:setChildLayoutGroupCreateItems(#skillList,function(index)
local skillItem=self.skillList:getChildLayoutGroupGridItem(index-1)
local skillData=skillList[index]
local skillID=skillData[1]
local skillLv=skillData[2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
skillItem:SetChildActive(-1,true)

skillItem:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),false)

local is_bd=skillModel.isSkillBD(skillCfg.skillType)
skillItem:SetChildActive(1,is_bd)




skillItem:SetChildButtonClick(3,function()



local x=-90
local y=-150-(index-1)*110
local args={
skillId=skillID,
skillLv=skillLv,
rootPoint={
anchorsMin=Vector2.one,
anchorsMax=Vector2.one,
pivot=Vector2.one,
anchoredPosition=Vector2.New(x,y)
}
}
UIManager:showWindow('UISimpleSkillTipsWin',args)
end)
end)
end


function UIFightPrepareWorldBigBossSkillWin:onHide()

end



