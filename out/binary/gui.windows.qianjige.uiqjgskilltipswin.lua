







def_class("UIQJGSkillTipsWin",UIWindowBase)









function UIQJGSkillTipsWin:bindComponents()

self.skillItem=UIObject.get(self,0)
self.skillUpgrade=UIObject.get(self,1)
self.unlockCondition=UIObject.get(self,2)
self.unlockBtn=UIButton.get(self,3)
self.unlock=UIObject.get(self,4)
self.lock=UIObject.get(self,5)
self.titleText1=UIText.get(self,6)
self.moneyText1=UILinkImageText.get(self,7)
self.moneyText2=UILinkImageText.get(self,8)
self.lockText=UIText.get(self,9)

self.unlockBtn:setButtonClick(function()self:onUnlockBtn()end)



end


function UIQJGSkillTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.skillItem);self.skillItem=nil;
_UIObject_release(self.skillUpgrade);self.skillUpgrade=nil;
_UIObject_release(self.unlockCondition);self.unlockCondition=nil;
_UIObject_release(self.unlockBtn);self.unlockBtn=nil;
_UIObject_release(self.unlock);self.unlock=nil;
_UIObject_release(self.lock);self.lock=nil;
_UIObject_release(self.titleText1);self.titleText1=nil;
_UIObject_release(self.moneyText1);self.moneyText1=nil;
_UIObject_release(self.moneyText2);self.moneyText2=nil;
_UIObject_release(self.lockText);self.lockText=nil;
end


















local body_menu_id=2017



function UIQJGSkillTipsWin:onLoaded(...)
self:bindComponents()
self.unlockWidgetIndex=
{
txtWidget1=self.titleText1:getID(),
itemWidget1=self.moneyText1:getID(),
itemWidget2=self.moneyText2:getID(),
}
self.unlockBtn:setChildUIModelShowTarget(body_menu_id,1,{},eAnimationID.common_window_dianji)
end


function UIQJGSkillTipsWin:__delete()
self:unbindComponents()
end




function UIQJGSkillTipsWin:onShow(argtable,afterOnloaded)
if not argtable then
return
end
self.skillId=argtable.skillId
self.bdData=argtable.bdData
local showUnLock=argtable.showUnLock or false
self.unlockConfId=QianJiGeModel:get_unlockId(self.skillId)
local skillWidget=self.skillItem:getChildWidgetBase()
local skillCfg=mysterySkillModel.get_skill_config(self.skillId)
skillWidget:SetChildText(0,skillCfg.name)
skillWidget:SetChildIcon(1,skillCfg.icon,false)
skillWidget:SetChildText(3,skillCfg.desc)


if showUnLock then
local isUnlock=QianJiGeModel:is_skill_unlockId_unlock(self.unlockConfId)
self.unlock:setActive(isUnlock)
self.lock:setActive(not isUnlock)
self.unlockCondition:setActive(not isUnlock)
self.unlockBtn:setActive(not isUnlock)
if not isUnlock then
self:showUnlockPanel()
end
else
self.unlock:setActive(false)
self.lock:setActive(false)
self.unlockCondition:setActive(false)
self.unlockBtn:setActive(false)
end




end

function UIQJGSkillTipsWin:refreshAfterItemUse(...)
self:showUnlockPanel()
end

function UIQJGSkillTipsWin:showUnlockPanel()
local cfg=QianJiGeModel:get_skill_unlock_config(self.unlockConfId)

local unlockBuilding=true
if cfg.jzlevel then
if self.bdData then
unlockBuilding=self.bdData.level>=cfg.jzlevel
self.winlua:SetChildActive(self.unlockWidgetIndex.txtWidget1,not unlockBuilding)
if not unlockBuilding then
local fontColor=self.bdData.level<cfg.jzlevel and FONT_COLOR.eRedColor or FONT_COLOR.eGreenColor
local txtWidget=self.winlua:GetChildWidgetBase(self.unlockWidgetIndex.txtWidget1)
txtWidget:SetChildText(0,FMT.fmt("千机阁达到{0}级",cfg.jzlevel))
end
end
end
if unlockBuilding then
if cfg.items then
for i,item in ipairs(cfg.items)do
local iconName=iconHelper.getIconName(item[1])
local widgetIndex=self.unlockWidgetIndex[FMT.fmt("itemWidget{0}",i)]
if itemsConfig.isMoney(item[1])then
local fontColor=moneyModel.checkEnoughMoney(item[1],item[2])and FONT_COLOR.eGreenColor or FONT_COLOR.eRedColor
self.winlua:SetChildActive(widgetIndex,true)
local itemWidget=self.winlua:GetChildWidgetBase(widgetIndex)
if itemWidget then
local iconStr=chatEmotHelper.getIconEmotMesg(iconName,32)
itemWidget:SetChildText(0,FMT.cfmt(fontColor,"{2}{0}/{1}",mathHelper.formatNumber(moneyModel.getMoney(item[1])),mathHelper.formatNumber(item[2]),iconStr))

end
else
local itemCount=bagControl.invokeFuncByItemId(item[1],'getItemCountByItemID',item[1])
local fontColor=itemCount>=item[2]and FONT_COLOR.eGreenColor or FONT_COLOR.eRedColor
self.winlua:SetChildActive(widgetIndex,true)
local itemWidget=self.winlua:GetChildWidgetBase(widgetIndex)
if itemWidget then
local iconStr=chatEmotHelper.getIconEmotMesg(iconName,32)
itemWidget:SetChildText(0,FMT.cfmt(fontColor,"{2}{0}/{1}",mathHelper.formatNumber(itemCount),mathHelper.formatNumber(item[2]),iconStr))

end
end
end
end
self.lockText:setText("解锁消耗")
else
self.winlua:SetChildActive(self.unlockWidgetIndex.itemWidget1,unlockBuilding)
self.winlua:SetChildActive(self.unlockWidgetIndex.itemWidget2,unlockBuilding)
end
end


function UIQJGSkillTipsWin:onHide()

end





function UIQJGSkillTipsWin:onUnlockBtn()
local beforeskill,skillId=QianJiGeModel:is_beforeskill_unlock(self.unlockConfId)
if not beforeskill then
UIManager.error(FMT.fmt("需要解锁前置技能{0}",mysterySkillModel.get_skill_name(skillId)))
return
end
local check,flag,value=QianJiGeModel:check_unlock_condition(self.unlockConfId)
if check then
QianJiGeController.send_6_11(self.unlockConfId)
else
if flag==1 then
UIManager.error(FMT.fmt("千机阁等级不足{0}级",value))
elseif flag==2 then
UIManager.error(FMT.fmt("{0}不足{1}",itemsConfig.getItemName(value[1]),value[2]))
gainControl:showGainWin(value[1])
end
end
end

