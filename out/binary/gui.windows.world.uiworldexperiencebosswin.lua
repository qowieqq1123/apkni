







def_class("UIWorldExperienceBossWin",UIWindowBase)









function UIWorldExperienceBossWin:bindComponents()

self.IconImg=UIImage.get(self,0)
self.NameTx=UIText.get(self,1)
self.RequirementTx=UIText.get(self,2)
self.SkillCmps={}
table.insert(self.SkillCmps,UIButton.get(self,3))
table.insert(self.SkillCmps,UIButton.get(self,4))
table.insert(self.SkillCmps,UIButton.get(self,5))
self.ItemCmps={}
table.insert(self.ItemCmps,UIBaseItem.get(self,6))
table.insert(self.ItemCmps,UIBaseItem.get(self,7))
table.insert(self.ItemCmps,UIBaseItem.get(self,8))
table.insert(self.ItemCmps,UIBaseItem.get(self,9))
self.TitleTx=UIText.get(self,10)

for i,v in ipairs(self.SkillCmps)do
v:setButtonClick(function()self:onClickSkill(i)end)
end



end


function UIWorldExperienceBossWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.IconImg);self.IconImg=nil;
_UIObject_release(self.NameTx);self.NameTx=nil;
_UIObject_release(self.RequirementTx);self.RequirementTx=nil;
for i,v in ipairs(self.SkillCmps)do
_UIObject_release(v)
end
self.SkillCmps=nil
for i,v in ipairs(self.ItemCmps)do
_UIObject_release(v)
end
self.ItemCmps=nil
_UIObject_release(self.TitleTx);self.TitleTx=nil;
end

















function UIWorldExperienceBossWin:onLoaded(...)
self:bindComponents()
end


function UIWorldExperienceBossWin:__delete()
self:unbindComponents()
end




function UIWorldExperienceBossWin:onShow(argtable,afterOnloaded)
if not argtable then return end
self.cfg=cfgHelper.get1(cfg_experiencebattleconfig_get,argtable[1])
self.group=argtable[2]
self.experience=argtable[3]
self.progress=argtable[4]
self.task=argtable[5]
if self.cfg.icon then
self.IconImg:setImageIcon(self.cfg.icon,false)
end
local experienceCfg=cfgHelper.get1(cfg_experienceconfig_get,self.experience)
self.TitleTx:setText(experienceCfg.name or"")
self.NameTx:setText(self.cfg.name)
self.RequirementTx:setText(self.cfg.lv and
FMT.fmt("境界：{0}",cfgHelper.getglobal2('jingjiename',self.cfg.lv))or"")
for i,v in ipairs(self.SkillCmps)do
local skillData=self.cfg.skills[i]
local show=skillData~=nil
v:setActive(show)
if show then
v:setImageIcon(iconHelper.getSkillIcon(skillData[1]))
end
end
for i,v in ipairs(self.ItemCmps)do
local rewardData=self.cfg.rewards[i]
local show=rewardData~=nil
v:setActive(show)
if show then
local conf={showname=false}
local item_data={itemid=rewardData[1],itemcount=rewardData[2]}
local propData=itemsComponentHelper.getCommonFillData(item_data,conf)
if rewardData[3]==1 then
propData[PropIndex(DataPropKey.eWidgetText,4)]=rewardData[2]==0 and
"低概率"or"高概率"
end
v:setChildPropData(propData)
end
end
end


function UIWorldExperienceBossWin:onHide()

end




function UIWorldExperienceBossWin:onClickSkill(index)

end

function UIWorldExperienceBossWin:onClickClose()
self:closeSelf()
UIManager:closeWindow("UIWorldExperienceEventWin")
end

function UIWorldExperienceBossWin:onClickChallenge()
local mcfg=cfgHelper.get(cfg_monstergroup_get,self.cfg.groupid)
UIManager:hideWindow("UIWorldExperienceBossWin")
UIManager:hideWindow("UIWorldExperienceWin")
UIManager:hideWindow("UIWorldWin")
fightController.showPrepareWin(fightPreSelectModel.fightType.worldExperienceBoss,{
enterTxt="历练",
isHomeBattle=false,
monsterList=mcfg.monList,
groupId=mcfg.id,
teamList=self.task.disciples,
cancelCallBack=function()
UIManager:showWindow("UIWorldExperienceBossWin")
UIManager:showWindow("UIWorldExperienceWin",self.group)
UIManager:showWindow("UIWorldWin")
end,
enterCallBack=function(selectList)
worldExperienceController:send_5_5(self.group,self.experience,self.cfg.id,self.task.disciples)
UIManager:closeWindow("UIWorldExperienceBossWin")
UIManager:showWindow("UIWorldExperienceWin",self.group)
UIManager:showWindow("UIWorldWin")
end})
end
