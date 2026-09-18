







def_class("UIQianJiGeWin",UIWindowBase)









function UIQianJiGeWin:bindComponents()

self.animRoot=UIObject.get(self,0)
self.cloud=UIObject.get(self,1)
self.fgmask=UIObject.get(self,2)
self.mysterySkillPanel=UIObject.get(self,3)
self.firstPanel=UIObject.get(self,4)
self.title=UIText.get(self,5)
self.btnUpgrade=UIButton.get(self,6)
self.level=UIText.get(self,7)
self.effect=UIObject.get(self,8)
self.UIQJGSkillItem8=UIObject.get(self,9)
self.UIQJGSkillItem12=UIObject.get(self,10)
self.UIQJGSkillItem11=UIObject.get(self,11)
self.UIQJGSkillItem10=UIObject.get(self,12)
self.UIQJGSkillItem9=UIObject.get(self,13)
self.UIQJGSkillItem7=UIObject.get(self,14)
self.UIQJGSkillItem6=UIObject.get(self,15)
self.UIQJGSkillItem4=UIObject.get(self,16)
self.UIQJGSkillItem3=UIObject.get(self,17)
self.UIQJGSkillItem2=UIObject.get(self,18)
self.UIQJGSkillItem1=UIObject.get(self,19)
self.SkillGrid=UIObject.get(self,20)
self.UIQJGSkillItem5=UIObject.get(self,21)
self.txtTalk=UIText.get(self,22)
self.skillReddot=UIObject.get(self,23)
self.tipBg=UIObject.get(self,24)
self.txtUpgradeBtn=UIText.get(self,25)
self.backButton=UIButton.get(self,26)
self.AnimImage=UIImage.get(self,27)
self.icon=UIObject.get(self,28)
self.txtName=UIText.get(self,29)
self.btnWaiJiao=UIButton.get(self,30)
self.btnNull=UIButton.get(self,31)
self.btnSkill=UIButton.get(self,32)
self.txtEffect=UIText.get(self,33)

self.btnUpgrade:setButtonClick(function()self:onBtnUpgrade()end)

self.backButton:setButtonClick(function()self:onBackButton()end)

self.btnWaiJiao:setButtonClick(function()self:onBtnWaiJiao()end)

self.btnNull:setButtonClick(function()self:onBtnNull()end)

self.btnSkill:setButtonClick(function()self:onBtnSkill()end)


self.sprite_button_qjgjnxx_1=0
self.sprite_button_qjgjnxx_2=1
self.sprite_button_qjgjnxx_3=2

end


function UIQianJiGeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.animRoot);self.animRoot=nil;
_UIObject_release(self.cloud);self.cloud=nil;
_UIObject_release(self.fgmask);self.fgmask=nil;
_UIObject_release(self.mysterySkillPanel);self.mysterySkillPanel=nil;
_UIObject_release(self.firstPanel);self.firstPanel=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.btnUpgrade);self.btnUpgrade=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.UIQJGSkillItem8);self.UIQJGSkillItem8=nil;
_UIObject_release(self.UIQJGSkillItem12);self.UIQJGSkillItem12=nil;
_UIObject_release(self.UIQJGSkillItem11);self.UIQJGSkillItem11=nil;
_UIObject_release(self.UIQJGSkillItem10);self.UIQJGSkillItem10=nil;
_UIObject_release(self.UIQJGSkillItem9);self.UIQJGSkillItem9=nil;
_UIObject_release(self.UIQJGSkillItem7);self.UIQJGSkillItem7=nil;
_UIObject_release(self.UIQJGSkillItem6);self.UIQJGSkillItem6=nil;
_UIObject_release(self.UIQJGSkillItem4);self.UIQJGSkillItem4=nil;
_UIObject_release(self.UIQJGSkillItem3);self.UIQJGSkillItem3=nil;
_UIObject_release(self.UIQJGSkillItem2);self.UIQJGSkillItem2=nil;
_UIObject_release(self.UIQJGSkillItem1);self.UIQJGSkillItem1=nil;
_UIObject_release(self.SkillGrid);self.SkillGrid=nil;
_UIObject_release(self.UIQJGSkillItem5);self.UIQJGSkillItem5=nil;
_UIObject_release(self.txtTalk);self.txtTalk=nil;
_UIObject_release(self.skillReddot);self.skillReddot=nil;
_UIObject_release(self.tipBg);self.tipBg=nil;
_UIObject_release(self.txtUpgradeBtn);self.txtUpgradeBtn=nil;
_UIObject_release(self.backButton);self.backButton=nil;
_UIObject_release(self.AnimImage);self.AnimImage=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.txtName);self.txtName=nil;
_UIObject_release(self.btnWaiJiao);self.btnWaiJiao=nil;
_UIObject_release(self.btnNull);self.btnNull=nil;
_UIObject_release(self.btnSkill);self.btnSkill=nil;
_UIObject_release(self.txtEffect);self.txtEffect=nil;
end


















local _this=nil
local _format=string.format

function UIQianJiGeWin:onLoaded(...)
self:bindComponents()
self.fgmask:setActive(false)
self.skillGridList=
{
self.UIQJGSkillItem1,
self.UIQJGSkillItem2,
self.UIQJGSkillItem3,
self.UIQJGSkillItem4,
self.UIQJGSkillItem5,
self.UIQJGSkillItem6,
self.UIQJGSkillItem7,
self.UIQJGSkillItem8,
self.UIQJGSkillItem9,
self.UIQJGSkillItem10,
self.UIQJGSkillItem11,
self.UIQJGSkillItem12,
}
_this=self
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)


local func=function(id)
local widget=self:getChildExpandUI(-1,id)
if widget then
local pos=self:getChildCanvas(-1)
local sortLayer=pos[1]
local sortOrder=pos[2]
widget:SetChildCanvas(-1,sortLayer,sortOrder+3)
end
end

self.cloud_guid=self:setChildGreateExpandUI(-1,self.cloud:getID(),INSTANCE_TYPE.eCommonCloudUIExpand,func)
end


function UIQianJiGeWin:__delete()
if self.cloud_guid~=nil then
self:setChildRemoveExpandUI(-1,self.cloud_guid)
self.cloud_guid=nil
end

notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
_this=nil
if self.iconTimer then
self:stopTimerByID(self.iconTimer)
self.iconTimer=nil
end
if self.delay then
self:stopTimerByID(self.delay)
self.delay=nil
end
self.fgmask:setActive(true)
self:unbindComponents()
end




function UIQianJiGeWin:onShow(argtable,afterOnloaded)

if argtable then
local guid=argtable.entityId
self.sfId=zongmenModel:getMountainId()
self.bdData=zongmenModel:findBuildingByEntityId(guid)
end
self.sfId=zongmenModel:getMountainId()

self:showLeftPanel()

self.delay=self:setTimer(1.5,1,function()
self:showReddot()
end)
end


function UIQianJiGeWin:onHide()

end

function UIQianJiGeWin:showLeftPanel()
local baseConfig=cfg_qianjigebaseconfig_get(1)
self.txtName:setText(FMT.fmt("阁主：{0}",baseConfig.name))
self.txtEffect:setText(baseConfig.desc)
self.effect:setChildShowEffect(10086,true)
if baseConfig.tips then
self.winid:SetChildScale(self.tipBg:getID(),Vector3(1,1,1))
self.txtTalk:setText(baseConfig.tips)
end
if baseConfig.model then
self.icon:setChildUIModelShowTarget(baseConfig.model[1],baseConfig.model[3]or 1,baseConfig.model[2],eAnimationID.walk)
self.icon:setChildUIModelShowFlipX(baseConfig.model[4]==1)
self.iconTimer=self:setTimer(2,1,function()
self:setIconAnim(eAnimationID.stand)
self.iconTimer=nil
end)


end
end

function UIQianJiGeWin:showReddot()
self.skillReddot:setActive(QianJiGeModel:check_skill_unlock())
end

function UIQianJiGeWin:setIconAnim(iStataID)
self.icon:setChildModelAnimationState(iStataID)
end

function UIQianJiGeWin.on_building_event(etype,sfId,bdId,args)
if etype==buildingEvent.levelUpStart then
_this:refreshLevelUp()
elseif etype==buildingEvent.levelUpComplete then
_this:refreshLevelUp()
elseif etype==buildingEvent.speedUpComplete then
_this:refreshLevelUp()
end
end

function UIQianJiGeWin:refreshLevelUp()
local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level+1)
local bdCfg=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
if nextLvCfg then
self.txtUpgradeBtn:setText('升级')
if self.bdData.flag==buildingStateType.eUpgrading then
local beginTime=self.bdData.begintime-self.bdData.reducetime
if beginTime>0 then
local needTime=nextLvCfg.uplevel_times
local func=function()
local curTime=gameUtilityModel.getServerShortTime()
local dtime=curTime-beginTime
if dtime>needTime then
self:stopLevelUpTimer()
if self.bdData.flag==buildingStateType.eUpgrading then
self.txtUpgradeBtn:setText('完成升级')
end
end
end
func()
self:stopLevelUpTimer()
self.levelUpTimer=self:setTimer(1,0,func)
else

self.level:setText(FMT.fmt('{0}级{1}',self.bdData.level,bdCfg.name))
end
else

self.level:setText(FMT.fmt('{0}级{1}',self.bdData.level,bdCfg.name))
end
else
self.level:setText(FMT.fmt('{0}级{1}',self.bdData.level,bdCfg.name))
self.txtUpgradeBtn:setText('建筑信息')

end
end

function UIQianJiGeWin:stopLevelUpTimer()
if self.levelUpTimer then
self:stopTimerByID(self.levelUpTimer)
self.levelUpTimer=nil
end
end

function UIQianJiGeWin:showSkillPanel()
self:showReddot()
self.effect:setChildShowEffect(10086,false)
local skillData=QianJiGeModel:get_all_skill_unlock_config()
if skillData then
local gridlist=self.skillGridList
local gridNum=#self.skillGridList
if gridNum>0 then
for i=1,gridNum do
if gridlist[i]then
local item=gridlist[i]:getChildWidgetBase()
if skillData[i]then
gridlist[i]:setActive(true)
local skillId=skillData[i].skillid
local skillCfg=cfg_ssprobeskillconfig_get(skillId)
if item and skillCfg then
local checkUnlock=QianJiGeModel:is_skill_unlockId_unlock(i)
local image=skillCfg.icon
local name=skillCfg.name
item:SetChildText(2,name)
item:SetChildCSImageIcon(0,image,false)
item:SetChildImageExGray(0,not checkUnlock)
item:SetChildActive(5,checkUnlock)
item:SetChildActive(1,not checkUnlock)
item:SetChildButtonClick(3,function()
self:onClickItemCallback(1,skillId)
end)
local check,flag,value=QianJiGeModel:check_unlock_condition(i)
item:SetChildActive(4,(not checkUnlock)and check)

end
else
gridlist[i]:setActive(false)
end
end
end
end
end
end

function UIQianJiGeWin:onClickItemCallback(clicknum,id)
UIManager:showWindow("UIQJGSkillTipsWin",{skillId=id,bdData=self.bdData,showUnLock=true})
end






function UIQianJiGeWin:onBtnUpgrade()
UIManager:showWindow('UIBuildingInfoWin',self.bdData)
end



function UIQianJiGeWin:onBtnSkill()

AudioManager.playAudio(524)
self.animRoot:setAnimatorInteger('nState',1,true)
self:showSkillPanel()
self.AnimImage:setImageSprite(0,true)
end



function UIQianJiGeWin:onBtnWaiJiao()
end

function UIQianJiGeWin:onClickClose()

UIFullQianJiGeControl:closeUI(true,true)
end

function UIQianJiGeWin:onBtnFinishLv()
zongmenControl:reqBuildingLevelUpComplete(self.sfId,self.bdData.un_build_id)
end

function UIQianJiGeWin:onBtnNull()

end

function UIQianJiGeWin:onBackButton()

AudioManager.playAudio(524)
timeEventController.delayDo(1,function()
self.effect:setChildShowEffect(10086,true)
end)
self.animRoot:setAnimatorInteger('nState',2,true)
end