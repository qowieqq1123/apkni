







def_class("UIYYTBBossWin",UIWindowBase)









function UIYYTBBossWin:bindComponents()

self.Root=UIObject.get(self,0)
self.costNum=UIText.get(self,1)
self.costIcon=UIImage.get(self,2)
self.TipsSkill=UIText.get(self,3)
self.SkillCmps_1=UIButton.get(self,4)
self.SkillCmps_2=UIButton.get(self,5)
self.SkillCmps_3=UIButton.get(self,6)
self.bossTips=UIImage.get(self,7)
self.costBg=UIObject.get(self,8)
self.ItemCmps_5=UIBaseItem.get(self,9)
self.ItemCmps_4=UIBaseItem.get(self,10)
self.ItemCmps_3=UIBaseItem.get(self,11)
self.ItemCmps_2=UIBaseItem.get(self,12)
self.ItemCmps_1=UIBaseItem.get(self,13)
self.ItemList=UIObject.get(self,14)
self.ItemScrollView=UIObject.get(self,15)
self.detailBtn=UIButton.get(self,16)
self.RewardTips=UIText.get(self,17)
self.previousButton=UIButton.get(self,18)
self.SkillRoot=UIObject.get(self,19)
self.nextButton=UIButton.get(self,20)
self.DescTx=UIText.get(self,21)
self.IconKuang=UIImage.get(self,22)
self.RequirementTx=UIText.get(self,23)
self.NameTx=UIText.get(self,24)
self.ButtonGiveUp=UIButton.get(self,25)
self.ButtonChallenge=UIButton.get(self,26)
self.TitleTx=UIText.get(self,27)
self.ButtonClose=UIButton.get(self,28)
self.IconImg=UIObject.get(self,29)
self.ItemList2=UIObject.get(self,30)
self.ItemCmpss_1=UIBaseItem.get(self,31)
self.ItemCmpss_2=UIBaseItem.get(self,32)
self.ItemCmpss_3=UIBaseItem.get(self,33)
self.ItemCmpss_4=UIBaseItem.get(self,34)
self.ItemCmpss_5=UIBaseItem.get(self,35)

self.ItemScrollView2=UIObject.get(self,36)
self.SkillCmps_1:setButtonClick(function()self:onSkillCmps_1()end)

self.SkillCmps_2:setButtonClick(function()self:onSkillCmps_2()end)

self.SkillCmps_3:setButtonClick(function()self:onSkillCmps_3()end)

self.detailBtn:setButtonClick(function()self:onDetailBtn()end)

self.previousButton:setButtonClick(function()self:onPreviousButton()end)

self.nextButton:setButtonClick(function()self:onNextButton()end)

self.ButtonGiveUp:setButtonClick(function()self:onButtonGiveUp()end)

self.ButtonChallenge:setButtonClick(function()self:onButtonChallenge()end)

self.ButtonClose:setButtonClick(function()self:onButtonClose()end)
self.SkillCmps={
self.SkillCmps_1,
self.SkillCmps_2,
self.SkillCmps_3,
}
self.ItemCmps={
self.ItemCmps_1,
self.ItemCmps_2,
self.ItemCmps_3,
self.ItemCmps_4,
self.ItemCmps_5,
}
self.ItemCmpss={
self.ItemCmpss_1,
self.ItemCmpss_2,
self.ItemCmpss_3,
self.ItemCmpss_4,
self.ItemCmpss_5,
}



end


function UIYYTBBossWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.costNum);self.costNum=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.TipsSkill);self.TipsSkill=nil;
_UIObject_release(self.SkillCmps_1);self.SkillCmps_1=nil;
_UIObject_release(self.SkillCmps_2);self.SkillCmps_2=nil;
_UIObject_release(self.SkillCmps_3);self.SkillCmps_3=nil;
_UIObject_release(self.bossTips);self.bossTips=nil;
_UIObject_release(self.costBg);self.costBg=nil;
_UIObject_release(self.ItemCmps_5);self.ItemCmps_5=nil;
_UIObject_release(self.ItemCmps_4);self.ItemCmps_4=nil;
_UIObject_release(self.ItemCmps_3);self.ItemCmps_3=nil;
_UIObject_release(self.ItemCmps_2);self.ItemCmps_2=nil;
_UIObject_release(self.ItemCmps_1);self.ItemCmps_1=nil;
_UIObject_release(self.ItemList);self.ItemList=nil;
_UIObject_release(self.ItemScrollView);self.ItemScrollView=nil;
_UIObject_release(self.detailBtn);self.detailBtn=nil;
_UIObject_release(self.RewardTips);self.RewardTips=nil;
_UIObject_release(self.previousButton);self.previousButton=nil;
_UIObject_release(self.SkillRoot);self.SkillRoot=nil;
_UIObject_release(self.nextButton);self.nextButton=nil;
_UIObject_release(self.DescTx);self.DescTx=nil;
_UIObject_release(self.IconKuang);self.IconKuang=nil;
_UIObject_release(self.RequirementTx);self.RequirementTx=nil;
_UIObject_release(self.NameTx);self.NameTx=nil;
_UIObject_release(self.ButtonGiveUp);self.ButtonGiveUp=nil;
_UIObject_release(self.ButtonChallenge);self.ButtonChallenge=nil;
_UIObject_release(self.TitleTx);self.TitleTx=nil;
_UIObject_release(self.ButtonClose);self.ButtonClose=nil;
_UIObject_release(self.IconImg);self.IconImg=nil;
_UIObject_release(self.ItemList2);self.ItemList2=nil;
_UIObject_release(self.ItemCmpss_1);self.ItemCmpss_1=nil;
_UIObject_release(self.ItemCmpss_2);self.ItemCmpss_2=nil;
_UIObject_release(self.ItemCmpss_3);self.ItemCmpss_3=nil;
_UIObject_release(self.ItemCmpss_4);self.ItemCmpss_4=nil;
_UIObject_release(self.ItemCmpss_5);self.ItemCmpss_5=nil;
_UIObject_release(self.ItemScrollView2);self.ItemScrollView2=nil;
self.SkillCmps=nil;
self.ItemCmps=nil;
self.ItemCmpss=nil;
end

















local _this=nil
local _abName="ui/sharedtextures/uiglobalspriteatlas_1.ab"
local _bossTips={
[monType.LittleMonster]=nil,
[monType.EliteMonster]="icon_guaiwubiaoqian_2",
[monType.Boss]="icon_guaiwubiaoqian_1",
[monType.BigBoss]="icon_guaiwubiaoqian_1",
[monType.GodAnimal]="icon_guaiwubiaoqian_1",
}
local _bossKuang={
[monType.LittleMonster]="frame_guaiwukuang_1",
[monType.EliteMonster]="frame_guaiwukuang_1",
[monType.Boss]="frame_guaiwukuang_2",
[monType.BigBoss]="frame_guaiwukuang_2",
[monType.GodAnimal]="frame_guaiwukuang_2",
}





function UIYYTBBossWin:onLoaded(...)
_this=self
self:bindComponents()

for i,v in ipairs(self.SkillCmps)do
self.winlua:SetChildButtonClick(v:getID(),function()self:onClickSkill(i,v)end)
end
for i,v in ipairs(self.ItemCmps)do
v:setBaseItemClickEvent(itemsComponentHelper.onItemClick)
end

for i,v in ipairs(self.ItemCmpss)do
v:setBaseItemClickEvent(itemsComponentHelper.onItemClick)
end
end


function UIYYTBBossWin:__delete()
_this=nil
self:unbindComponents()



end





function UIYYTBBossWin:onShow(argtable,afterOnloaded)









self.title=argtable.title;
self.name=argtable.name
self.icon=argtable.icon
self.level=argtable.level
self.skills=argtable.skills
self.desc=argtable.desc
self.items=argtable.items
self.itemss=argtable.itemss
self.actRewards=argtable.actRewards
self.cost=argtable.cost
self.highestType=argtable.highestType or 0
self.closeCallback=argtable.close
self.challengeCallback=argtable.challenge
self.detail=argtable.detail
self.giveUpCallback=argtable.giveUp
self.previousCallback=argtable.previousCallback
self.nextCallback=argtable.nextCallback
self.groupId=argtable.groupId
self.unitKey=argtable.unitKey
self.returnHeight=self.returnHeight or argtable.returnHeight
self.gotReward=argtable.gotReward
if self.groupId then








comHelper.setChildModelRawImage_monsterGroup(self.winlua,self.groupId,self.IconImg:getID(),0,eHeadCenterType.eHead)

end
self.TitleTx:setText(self.title or"")
self.NameTx:setText(self.name)
self.RequirementTx:setText(self.level and
FMT.fmt("境界：{0}",UIDiscipleModel.getJJNameCommon(self.level,3))or"")
self.costBg:setActive(false)

if self.detail then
if#self.detail<=5 then
self.detail=nil
end
end


if self.gotReward then
self.detail=nil
end

self.detailBtn:setActive(false)
local assetname=_bossTips[self.highestType]
self.bossTips:setActive(assetname~=nil)
if assetname then
self.bossTips:setSprite(_abName,_bossTips[self.highestType])
end

self.IconKuang:setSprite(_abName,_bossKuang[self.highestType])
if self.cost then
self.costIcon:setIcon(iconHelper.getIconName(self.cost[1]))
self.costNum:setText(FMT.fmt("-{0}",self.cost[2]))
end
self.ButtonGiveUp:setActive(self.giveUpCallback~=nil)
self.DescTx:setText(self.desc or"")
self.TipsSkill:setActive(self.desc==nil)
self.SkillRoot:setActive(false)
if self.desc==nil and self.skills then
for i,v in ipairs(self.SkillCmps)do
local skillData=self.skills[i]
local show=skillData~=nil
v:setActive(show)
if show then
local cfg_skill=cfgHelper.get(cfg_skillconfig_get,skillData[1])
if cfg_skill then
v:setImageIcon(iconHelper.getSkillIcon(cfg_skill.icon))
else
v:setImageIcon(iconHelper.getSkillIcon(skillData[1]))
end
end
end
end

local showItemCount=0
local showItemCounts=0


if not self.gotReward then

if self.items and next(self.items)then
local showNormalItemCount=#self.ItemCmps-#self.actRewards
if showNormalItemCount<0 then
showNormalItemCount=0
end

for i,v in ipairs(self.ItemCmps)do
local rewardData=self.items and self.items[i]





local show=rewardData~=nil
v:setActive(show)
if show then
showItemCount=showItemCount+1
local showCountBG=false
local gailv=(rewardData[3]~=nil and rewardData[3]==1)or rewardData[2]<0

local itemShowCount=rewardData.showCount
if rewardData[2]>1 or(itemShowCount and itemShowCount>1)or rewardData.range then
showCountBG=true
end
local conf={showname=false,showcount=(itemShowCount and itemShowCount>1)or rewardData[2]>1,showCountBG=showCountBG,showStageBg=true,range=rewardData.range}
local item_data={itemid=rewardData[1],itemcount=itemShowCount or rewardData[2]}
local propData=itemsComponentHelper.getCommonFillData(item_data,conf)
propData[PropIndex(DataPropKey.eWidgetActive,8)]=gailv
propData[PropIndex(DataPropKey.eWidgetActive,9)]=propData[PropIndex(DataPropKey.eWidgetText,6)]~=""
v:setChildPropData(propData)
end
end
else

end
end
if self.itemss and next(self.itemss)then
local showNormalItemCount=#self.ItemCmpss-#self.actRewards
if showNormalItemCount<0 then
showNormalItemCount=0
end

for i,v in ipairs(self.ItemCmpss)do
local rewardData=self.itemss and self.itemss[i]





local show=rewardData~=nil
v:setActive(show)
if show then
showItemCount=showItemCount+1
local showCountBG=false
local gailv=(rewardData[3]~=nil and rewardData[3]==1)or rewardData[2]<0

local itemShowCount=rewardData.showCount
if rewardData[2]>1 or(itemShowCount and itemShowCount>1)or rewardData.range then
showCountBG=true
end
local conf={showname=false,showcount=(itemShowCount and itemShowCount>1)or rewardData[2]>1,showCountBG=showCountBG,showStageBg=true,range=rewardData.range}
local item_data={itemid=rewardData[1],itemcount=itemShowCount or rewardData[2]}
local propData=itemsComponentHelper.getCommonFillData(item_data,conf)
propData[PropIndex(DataPropKey.eWidgetActive,8)]=gailv
propData[PropIndex(DataPropKey.eWidgetActive,9)]=propData[PropIndex(DataPropKey.eWidgetText,6)]~=""
v:setChildPropData(propData)
end
end
else

end


local enable=showItemCount>4
local enables=showItemCounts>4
self.winlua:SetChildScrollRectEnable(self.ItemScrollView:getID(),enable)
self.winlua:SetChildScrollRectEnable(self.ItemScrollView2:getID(),enables)



end


function UIYYTBBossWin:onHide()

self.unitKey=nil
self.returnHeight=nil


end

function UIYYTBBossWin.on_swipe()

if _this then







worldController.on_swipe_end(0)
_this:onButtonClose()
end

end

function UIYYTBBossWin.onClickEmptyInWorld()
if _this then
_this:onButtonClose()
end
end



function UIYYTBBossWin:onClickSkill(index,item)

if self.skills[index]then
local skillData=self.skills[index]
UIManager:showWindow("UIWorldMonsterSkillInfoWin",{skillData[1],skillData[2],item:getChildPosition()})
end
end

function UIYYTBBossWin:onButtonClose()

local unitKey=self.unitKey
local returnHeight=self.returnHeight
local cb=self.closeCallback


AudioManager.playCloseUI()























self:closeSelf()

end

function UIYYTBBossWin:onButtonChallenge()
if self.challengeCallback then self.challengeCallback()end
end

function UIYYTBBossWin:onButtonGiveUp()
if self.giveUpCallback then self.giveUpCallback()end
end

function UIYYTBBossWin:onDetailBtn()
UIManager:showWindow("UIDetailDropWin",{detail=self.detail,actRewards=self.actRewards})
end

function UIYYTBBossWin:onPreviousButton()
if self.previousCallback then
self.previousCallback()
end
end

function UIYYTBBossWin:onNextButton()
if self.nextCallback then
self.nextCallback()
end
end
