







def_class("UIQJGMysterySkillWin",UIWindowBase)









function UIQJGMysterySkillWin:bindComponents()

self.btnClose=UIButton.get(self,0)
self.SkillGrid=UIObject.get(self,1)

self.btnClose:setButtonClick(function()self:onBtnClose()end)



end


function UIQJGMysterySkillWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.SkillGrid);self.SkillGrid=nil;
end



















function UIQJGMysterySkillWin:onLoaded(...)
self:bindComponents()
end


function UIQJGMysterySkillWin:__delete()
self:unbindComponents()
end




function UIQJGMysterySkillWin:onShow(argtable,afterOnloaded)
self.bdData=argtable
self:showSkillPanel()
end


function UIQJGMysterySkillWin:onHide()

end

function UIQJGMysterySkillWin:onBtnClose()
UIManager:closeWindow("UIQJGMysterySkillWin")
end

function UIQJGMysterySkillWin:onBtnCloseAll()
UIManager:closeWindow("UIQJGMysterySkillWin")
fullScreenUI.closeActiveUI()
end

function UIQJGMysterySkillWin:showSkillPanel()
self.skillData=QianJiGeModel:get_all_skill_unlock_config()
if self.skillData then
local length=#self.skillData
self.SkillGrid:setChildLayoutGroupCreateItems(length)
local gridlist=self.SkillGrid:getChildLayoutGroupGridList()
local gridNum=gridlist.Count
if gridNum>0 then
for i=1,gridNum do
local item=gridlist[i-1]
local skillId=self.skillData[i].skillid
local skillCfg=cfg_ssprobeskillconfig_get(skillId)
if item and skillCfg then
local checkUnlock=QianJiGeModel:is_skill_unlockId_unlock(i)
local image=skillCfg.icon
local name=skillCfg.name
item:SetChildText(2,name)
item:SetChildCSImageIcon(0,image,false)
item:SetChildImageExGray(0,not checkUnlock)
item:SetChildActive(1,checkUnlock)
item:SetChildButtonClick(3,function()
self:onClickItemCallback(1,skillId)
end)
end

end
end
end
end

function UIQJGMysterySkillWin:onClickItemCallback(clicknum,id)
UIManager:showWindow("UIQJGSkillTipsWin",{skillId=id,bdData=self.bdData,showUnLock=true})
end



