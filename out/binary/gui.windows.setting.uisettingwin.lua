







def_class("UISettingWin",UIWindowBase)








function UISettingWin:bindComponents()

self.BindAccount=UIButton.get(self,0)
self.btn30fps=UIButton.get(self,1)
self.btn60fps=UIButton.get(self,2)
self.btnClose=UIButton.get(self,3)
self.btnQualityLevel1=UIButton.get(self,4)
self.btnQualityLevel2=UIButton.get(self,5)
self.changeTeamButton=UIButton.get(self,6)
self.chatSetBtn=UIButton.get(self,7)
self.chatSetting=UIObject.get(self,8)
self.check30fps=UIObject.get(self,9)
self.check60fps=UIObject.get(self,10)
self.checkQualityLevel1=UIObject.get(self,11)
self.checkQualityLevel2=UIObject.get(self,12)
self.fightSaveMode=UIToggleButton.get(self,13)
self.FT_GoogleAuth=UIButton.get(self,14)
self.FT_switchVoice=UIButton.get(self,15)
self.jianWenChannel=UIToggleButton.get(self,16)
self.jumpurlbtn=UIButton.get(self,17)
self.jumpurltxt=UIText.get(self,18)
self.kuafuChannel=UIToggleButton.get(self,19)
self.localVoiceAutoPlay=UIToggleButton.get(self,20)
self.logoutBtn=UIButton.get(self,21)
self.menu_anim_1=UIObject.get(self,22)
self.menu_anim_2=UIObject.get(self,23)
self.menu_anim_3=UIObject.get(self,24)
self.musiceSlider=UIObject.get(self,25)
self.powerSaveMode=UIToggleButton.get(self,26)
self.powerSaveMode1=UIObject.get(self,27)
self.powerSaveMode2=UIObject.get(self,28)
self.privateChatChannel=UIToggleButton.get(self,29)
self.privateChatVoiceAutoPlay=UIToggleButton.get(self,30)
self.profiler=UIObject.get(self,31)
self.qualityLevel1=UIObject.get(self,32)
self.qualityLevel2=UIObject.get(self,33)
self.qualitySet=UIObject.get(self,34)
self.rolespeakSlider=UIObject.get(self,35)
self.seeXianGuanBroadcast=UIToggleButton.get(self,36)
self.seeXianJieInfo=UIToggleButton.get(self,37)
self.seeXianJieSet=UIObject.get(self,38)
self.soundSlider=UIObject.get(self,39)
self.systemChannel=UIToggleButton.get(self,40)
self.systemSetBtn=UIButton.get(self,41)
self.systemSetting=UIObject.get(self,42)
self.teamBtn=UIButton.get(self,43)
self.teamGridRoot=UIObject.get(self,44)
self.teamRedDot=UIObject.get(self,45)
self.teamSetting=UIObject.get(self,46)
self.title=UIText.get(self,47)
self.UnBindAccount=UIButton.get(self,48)
self.wifiAutoPlayVoice=UIToggleButton.get(self,49)
self.worldChannel=UIToggleButton.get(self,50)
self.worldVoiceAutoPlay=UIToggleButton.get(self,51)
self.xianMengChannel=UIToggleButton.get(self,52)
self.xianMengVoiceAutoPlay=UIToggleButton.get(self,53)
self.xieyiRoot=UIObject.get(self,54)

self.BindAccount:setButtonClick(function()self:onBindAccount()end)

self.btn30fps:setButtonClick(function()self:onBtn30fps()end)

self.btn60fps:setButtonClick(function()self:onBtn60fps()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.btnQualityLevel1:setButtonClick(function()self:onBtnQualityLevel1()end)

self.btnQualityLevel2:setButtonClick(function()self:onBtnQualityLevel2()end)

self.changeTeamButton:setButtonClick(function()self:onChangeTeamButton()end)

self.chatSetBtn:setButtonClick(function()self:onChatSetBtn()end)

self.FT_GoogleAuth:setButtonClick(function()self:onFT_GoogleAuth()end)

self.FT_switchVoice:setButtonClick(function()self:onFT_switchVoice()end)

self.jumpurlbtn:setButtonClick(function()self:onJumpurlbtn()end)

self.logoutBtn:setButtonClick(function()self:onLogoutBtn()end)

self.systemSetBtn:setButtonClick(function()self:onSystemSetBtn()end)

self.teamBtn:setButtonClick(function()self:onTeamBtn()end)

self.UnBindAccount:setButtonClick(function()self:onUnBindAccount()end)
self.menu_anim={
self.menu_anim_1,
self.menu_anim_2,
self.menu_anim_3,
}
self.FT={
["GoogleAuth"]=self.FT_GoogleAuth,
["switchVoice"]=self.FT_switchVoice,
}



end


function UISettingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.BindAccount);self.BindAccount=nil;
_UIObject_release(self.btn30fps);self.btn30fps=nil;
_UIObject_release(self.btn60fps);self.btn60fps=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.btnQualityLevel1);self.btnQualityLevel1=nil;
_UIObject_release(self.btnQualityLevel2);self.btnQualityLevel2=nil;
_UIObject_release(self.changeTeamButton);self.changeTeamButton=nil;
_UIObject_release(self.chatSetBtn);self.chatSetBtn=nil;
_UIObject_release(self.chatSetting);self.chatSetting=nil;
_UIObject_release(self.check30fps);self.check30fps=nil;
_UIObject_release(self.check60fps);self.check60fps=nil;
_UIObject_release(self.checkQualityLevel1);self.checkQualityLevel1=nil;
_UIObject_release(self.checkQualityLevel2);self.checkQualityLevel2=nil;
_UIObject_release(self.fightSaveMode);self.fightSaveMode=nil;
_UIObject_release(self.FT_GoogleAuth);self.FT_GoogleAuth=nil;
_UIObject_release(self.FT_switchVoice);self.FT_switchVoice=nil;
_UIObject_release(self.jianWenChannel);self.jianWenChannel=nil;
_UIObject_release(self.jumpurlbtn);self.jumpurlbtn=nil;
_UIObject_release(self.jumpurltxt);self.jumpurltxt=nil;
_UIObject_release(self.kuafuChannel);self.kuafuChannel=nil;
_UIObject_release(self.localVoiceAutoPlay);self.localVoiceAutoPlay=nil;
_UIObject_release(self.logoutBtn);self.logoutBtn=nil;
_UIObject_release(self.menu_anim_1);self.menu_anim_1=nil;
_UIObject_release(self.menu_anim_2);self.menu_anim_2=nil;
_UIObject_release(self.menu_anim_3);self.menu_anim_3=nil;
_UIObject_release(self.musiceSlider);self.musiceSlider=nil;
_UIObject_release(self.powerSaveMode);self.powerSaveMode=nil;
_UIObject_release(self.powerSaveMode1);self.powerSaveMode1=nil;
_UIObject_release(self.powerSaveMode2);self.powerSaveMode2=nil;
_UIObject_release(self.privateChatChannel);self.privateChatChannel=nil;
_UIObject_release(self.privateChatVoiceAutoPlay);self.privateChatVoiceAutoPlay=nil;
_UIObject_release(self.profiler);self.profiler=nil;
_UIObject_release(self.qualityLevel1);self.qualityLevel1=nil;
_UIObject_release(self.qualityLevel2);self.qualityLevel2=nil;
_UIObject_release(self.qualitySet);self.qualitySet=nil;
_UIObject_release(self.rolespeakSlider);self.rolespeakSlider=nil;
_UIObject_release(self.seeXianGuanBroadcast);self.seeXianGuanBroadcast=nil;
_UIObject_release(self.seeXianJieInfo);self.seeXianJieInfo=nil;
_UIObject_release(self.seeXianJieSet);self.seeXianJieSet=nil;
_UIObject_release(self.soundSlider);self.soundSlider=nil;
_UIObject_release(self.systemChannel);self.systemChannel=nil;
_UIObject_release(self.systemSetBtn);self.systemSetBtn=nil;
_UIObject_release(self.systemSetting);self.systemSetting=nil;
_UIObject_release(self.teamBtn);self.teamBtn=nil;
_UIObject_release(self.teamGridRoot);self.teamGridRoot=nil;
_UIObject_release(self.teamRedDot);self.teamRedDot=nil;
_UIObject_release(self.teamSetting);self.teamSetting=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.UnBindAccount);self.UnBindAccount=nil;
_UIObject_release(self.wifiAutoPlayVoice);self.wifiAutoPlayVoice=nil;
_UIObject_release(self.worldChannel);self.worldChannel=nil;
_UIObject_release(self.worldVoiceAutoPlay);self.worldVoiceAutoPlay=nil;
_UIObject_release(self.xianMengChannel);self.xianMengChannel=nil;
_UIObject_release(self.xianMengVoiceAutoPlay);self.xianMengVoiceAutoPlay=nil;
_UIObject_release(self.xieyiRoot);self.xieyiRoot=nil;
self.menu_anim=nil;
self.FT=nil;
end

















local menuIndex={
system=1,
chat=2,
team=3,
}

local menuSystem={
[menuIndex.team]=SYSTEM_DEFINE.eTeamShowcase,
}

local menu_slot_name='button_dytab'

local Frame=0

local roleItemIndex={
color=0,
head=1,
name=2,
sortAttr=3,
job=4,
dark=5,
root=6,
bgRoot=7,
colorRoot=8,
level=9,
chuiweiback=10,
chuiweiImg=11,
levelBg=12,
hasTeamMark=13,
}
local _this


function UISettingWin:onLoaded(...)
_this=self
self:bindComponents()
self.curMenuIndex=menuIndex.system
self.fightSaveMode:setToggleChange(function(name,isOn)
self:onToggleChangeQieChuo(1,isOn)
AudioManager.playBtnClick()
end)
self.powerSaveMode:setToggleChange(function(name,isOn)
AudioManager.playBtnClick()
end)
self.systemChannel:setToggleChange(function(name,isOn)
AudioManager.playBtnClick()
end)
self.jianWenChannel:setToggleChange(function(name,isOn)
AudioManager.playBtnClick()
end)
self.kuafuChannel:setToggleChange(function(name,isOn)
AudioManager.playBtnClick()
end)
self.xianMengChannel:setToggleChange(function(name,isOn)
AudioManager.playBtnClick()
end)
self.privateChatChannel:setToggleChange(function(name,isOn)
AudioManager.playBtnClick()
end)
self.worldChannel:setToggleChange(function(name,isOn)
AudioManager.playBtnClick()
end)
self.wifiAutoPlayVoice:setToggleChange(function(name,isOn)
AudioManager.playBtnClick()
end)
self.localVoiceAutoPlay:setToggleChange(function(name,isOn)
AudioManager.playBtnClick()
end)
self.worldVoiceAutoPlay:setToggleChange(function(name,isOn)
AudioManager.playBtnClick()
end)
self.xianMengVoiceAutoPlay:setToggleChange(function(name,isOn)
AudioManager.playBtnClick()
end)
self.privateChatVoiceAutoPlay:setToggleChange(function(name,isOn)
AudioManager.playBtnClick()
end)
self.seeXianJieInfo:setToggleChange(function(name,isOn)
xianjieController:reqSetAllow(isOn and 1 or 0)
AudioManager.playBtnClick()
end)
self.seeXianGuanBroadcast:setToggleChange(function(name,isOn)
xianguanController.reqSetXianGuanBroadcast(isOn and 1 or 0)
AudioManager.playBtnClick()
end)
reddotClassManager.register_event(REDDIT_TYPE.ePlayerSetting,self.freshPlayerSettingReddot)

self:freshLogoutAccountBtn()

if webGLHelper:isRunMiniGame()then
self.powerSaveMode2:setActive(webGLHelper:isAllowHighFrameRate())
self.profiler:setActive(webGLHelper:isShowFPSSetting())
end

if deviceHelper.isRunOpenHarmony()then

end
self:checkPFWindowsShow()
local HWFT=pfwindowslController:checkIsGameVersion_HWFT()
self.FT_switchVoice:setActive(HWFT)

self.menu_Btn={
[1]=self.systemSetBtn,
[2]=self.chatSetBtn,
[3]=self.teamBtn,
}
end


function UISettingWin:__delete()
reddotClassManager.unregister_event(REDDIT_TYPE.ePlayerSetting,self.freshPlayerSettingReddot)
userActorSetting.set('setFrame',Frame)
userActorSetting.flush()
Frame=nil

AudioManager.stopMuteGroup()
self:record()
self:unbindComponents()
self.curMenuIndex=nil
self.musicVolume=nil
self.soundVolume=nil
self.rolespeakVolumee=nil
self.qualityLevel=nil
_this=nil
end





function UISettingWin:onShow(argtable,afterOnloaded)
self:refreshMenuState(true)
self:init()
local ret=systemModel.isOpen(SYSTEM_DEFINE.eRoleSpeak)
if ret then
self.rolespeakSlider:setActive(true)
else
self.rolespeakSlider:setActive(false)
end
self.testCount=0
self:showSetButtonInfo()



if argtable then
if argtable==menuIndex.chat then
self:onChatSetBtn()
elseif argtable==menuIndex.team then
self:onTeamBtn()
end
self:delayDo(0.01,function()
self:refreshMenuState()
end)
end

if verifyManager:isHideTeamSetting()then
self.menu_anim_3:setActive(false)
self.teamBtn:setActive(false)
end
end


function UISettingWin:onHide()

end

function UISettingWin.freshPlayerSettingReddot()
_this.teamRedDot:setActive(UISettingModel:checkRedDotShowcase())
end

function UISettingWin:init()
local data=UISettingModel:getActorSettingConfig()
local globalData=UISettingModel:getGlobalSettingConfig()

local _onMusicVolumeChange=function(...)
self:onMusicVolumeChange(...)
end
self.musicVolume=globalData.musicVolume
self.winlua:SetChildSliderInit(self.musiceSlider:getID(),globalData.musicVolume,0,1,_onMusicVolumeChange)

local _onSoundVolumeChange=function(...)
self:onSoundVolumeChange(...)
end
self.soundVolume=globalData.soundVolume
self.winlua:SetChildSliderInit(self.soundSlider:getID(),globalData.soundVolume,0,1,_onSoundVolumeChange)

local _onRoleSpeakChange=function(...)
self:onRoleSpeakVolumeChange(...)
end
self.rolespeakVolumee=globalData.rolespeakVolumee
self.winlua:SetChildSliderInit(self.rolespeakSlider:getID(),globalData.rolespeakVolumee,0,1,_onRoleSpeakChange)


self.qualityLevel=globalData.qualityLevel
self:freshQualityLevelCheck()


self.powerSaveMode:setToggle(data.powerSave)
self.systemChannel:setToggle(data.systemChannel)
self.jianWenChannel:setToggle(data.jianWenChannel)
self.kuafuChannel:setToggle(data.kuafuChannel)
self.xianMengChannel:setToggle(data.xianMengChannel)
self.privateChatChannel:setToggle(data.privateChatChannel)
self.worldChannel:setToggle(data.worldChannel)
self.wifiAutoPlayVoice:setToggle(data.wifiVoice)
self.localVoiceAutoPlay:setToggle(data.localServerVoice)
self.worldVoiceAutoPlay:setToggle(data.worldVoice)
self.xianMengVoiceAutoPlay:setToggle(data.xianMengVoice)
self.privateChatVoiceAutoPlay:setToggle(data.privateChatVoice)

local isallow=DiZiDuelModel:getallow()or 0
self.fightSaveMode:setToggle(isallow==1)

local isOpenXianJie=xianjieController:checkXianJieSystemOpen()
self.winlua:SetChildActive(self.seeXianJieSet:getID(),isOpenXianJie)
if isOpenXianJie then
local allow=xianjieModel:getAllow()
self.seeXianJieInfo:setToggle(allow==nil or allow==1)
local open=xianguanModel:getXianGuanBroadcastOpen()
self.seeXianGuanBroadcast:setToggle(open==nil or open==1)
end

Frame=userActorSetting.get('setFrame',nil)
if Frame==FRAME_LEVEL.eLow then
self.winlua:SetChildActive(self.check30fps:getID(),true)
self.winlua:SetChildActive(self.check60fps:getID(),false)
elseif Frame==FRAME_LEVEL.eMedium then
self.winlua:SetChildActive(self.check30fps:getID(),false)
self.winlua:SetChildActive(self.check60fps:getID(),true)
else
if webGLHelper:isRunMiniGame()then
Frame=webGLHelper:getAllowMaxFrameRate()
else
Frame=FRAME_LEVEL.eLow
end
gameHelper.setFrame(Frame)
local is30FPS=Frame==FRAME_LEVEL.eLow
self.winlua:SetChildActive(self.check30fps:getID(),is30FPS)
self.winlua:SetChildActive(self.check60fps:getID(),not is30FPS)
end
end

function UISettingWin:record()
local data=UISettingModel:getActorSettingConfig()
local globalData=UISettingModel:getGlobalSettingConfig()

globalData.musicVolume=self.musicVolume

globalData.soundVolume=self.soundVolume

globalData.rolespeakVolumee=self.rolespeakVolumee

globalData.qualityLevel=self.qualityLevel


data.powerSave=self.powerSaveMode:getToggle()
data.systemChannel=self.systemChannel:getToggle()
data.jianWenChannel=self.jianWenChannel:getToggle()
data.kuafuChannel=self.kuafuChannel:getToggle()
data.xianMengChannel=self.xianMengChannel:getToggle()
data.privateChatChannel=self.privateChatChannel:getToggle()
data.worldChannel=self.worldChannel:getToggle()
data.wifiVoice=self.wifiAutoPlayVoice:getToggle()
data.localServerVoice=self.localVoiceAutoPlay:getToggle()
data.worldVoice=self.worldVoiceAutoPlay:getToggle()
data.xianMengVoice=self.xianMengVoiceAutoPlay:getToggle()
data.privateChatVoice=self.privateChatVoiceAutoPlay:getToggle()
data.fightSaveMode=self.fightSaveMode:getToggle()

UISettingModel:flushActorSettingConfig(data)
UISettingModel:flushGlobalSettingConfig(globalData)

UISettingModel:init_chat_setting()
end

function UISettingWin:refreshMenuState(first)

for i=1,#self.menu_anim do
local anim=self.menu_anim[i]
if not menuSystem[i]or(menuSystem[i]and systemModel.isOpen(menuSystem[i]))then
self.menu_Btn[i]:setActive(true)
anim:setActive(true)
if first or self.curMenuIndex==i then
local func2=function()

self.winlua:SetChildUIModelShowSlotAttachment(anim:getID(),menu_slot_name,self.curMenuIndex==i and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end
local cb=nil
if first then
cb=func2
end
anim:setChildUIModelShowTarget(2017,1,{},eAnimationID.common_window_enter,false,false,0,cb)
end

self.winlua:SetChildUIModelShowSlotAttachment(anim:getID(),menu_slot_name,self.curMenuIndex==i and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
else
anim:setActive(false)
self.menu_Btn[i]:setActive(false)
end

end

self.systemSetting:setActive(self.curMenuIndex==menuIndex.system)
self.chatSetting:setActive(self.curMenuIndex==menuIndex.chat)
self.teamSetting:setActive(self.curMenuIndex==menuIndex.team)

self.freshPlayerSettingReddot()

if self.curMenuIndex==menuIndex.team then
self:showPFWindows(false)
self.title:setText("阵容展示")
else
self:showPFWindows(true)
self.title:setText("设置")
end

if verifyManager:isHideTeamSetting()then
self.menu_anim_3:setActive(false)
self.teamBtn:setActive(false)
end
end

function UISettingWin:freshLogoutAccountBtn()
local vis=pfHelper.showDelAccount()and not loginModel.isDelAccount or false
self.logoutBtn:setActive(vis)
end

function UISettingWin:freshQualityLevelCheck()

if self.qualityLevel==GraphicsQualityLevel.Low then
self.winlua:SetChildActive(self.checkQualityLevel1:getID(),true)
self.winlua:SetChildActive(self.checkQualityLevel2:getID(),false)
else
self.winlua:SetChildActive(self.checkQualityLevel1:getID(),false)
self.winlua:SetChildActive(self.checkQualityLevel2:getID(),true)
end
end

function UISettingWin:freshTeamList()
local teamList=UISettingModel:getShowcaseTeamList()or{}
local list={}
for i,v in pairs(teamList)do
if teamList[i]and not mathHelper.compareInt64(teamList[i],int64.zero)then
table.insert(list,v)
end
end
local grids=self.teamGridRoot:getChildCommonLayoutGroupWidgetList()
local l_red=userActorSetting.get('showcaseTeamRedDot',false)
if not l_red then
userActorSetting.flushVal('showcaseTeamRedDot',true)
UISettingModel:initRedDotShowcase()
self.freshPlayerSettingReddot()
reddotControl.on_change_catch_type(CATCH_TYPE.eShowcaseTeam)
end

for i=1,grids.Count do
local grid=grids[i-1]

if list[i]and not mathHelper.compareInt64(list[i],int64.zero)then
grid:SetChildActive(1,false)
grid:SetChildActive(0,true)
grid:SetChildActive(3,true)
local guid=list[i]
local cardGrid=grid:GetChildWidgetBase(0)
cardGrid:SetChildText(roleItemIndex.name,UIDiscipleModel:getDiscipleName(guid))
comHelper.setChildModelRawImage(cardGrid,guid,roleItemIndex.head,0,eHeadCenterType.eHead,nil,false)
local color=UIDiscipleModel:getDiscipleColor(guid)
cardGrid:SetChildCSImageSprite(roleItemIndex.color,globalABLookup.diciplecolorframe,discipleColorToFrame[color])
cardGrid:SetChildActive(roleItemIndex.chuiweiback,false)
cardGrid:SetChildActive(roleItemIndex.chuiweiImg,false)
local jobIcon=UIDiscipleModel:getJobIconNameX(guid)
cardGrid:SetChildCSImageSprite(roleItemIndex.job,globalABLookup.global,jobIcon)
cardGrid:SetChildText(roleItemIndex.sortAttr,FMT.fmt('<color=#7d3b17>战</color> {0}',mathHelper.formatNumber3(UIDiscipleModel:getDiscipleFightValue(guid))))
cardGrid:SetChildText(roleItemIndex.level,UIDiscipleModel:getDiscipleJJLevel(guid)or 0)
cardGrid:SetChildCSImageSprite(roleItemIndex.levelBg,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])
UIDiscipleController.refreshCommonItemTianMing(cardGrid,UIDiscipleModel:getDiscipleData(guid),14)

grid:SetChildButtonClick(3,function()

otherPlayerController:openSelfPlayerDZInfoWin(list,guid)
end)
else
grid:SetChildActive(1,true)
grid:SetChildActive(0,false)
grid:SetChildActive(3,false)
grid:SetChildButtonClick(1,function()
self:showFightWin()
end)
end
end
end

function UISettingWin:showFightWin()
local winArgs={
enterCallBack=function(guidList,zfId,map)
local discipleList={}
for _,v in ipairs(guidList)do
table.insert(discipleList,v[2])
end
UISettingController.req_set_team_254_128(discipleList)
UIFullFightPrepareControl:closeUI()
fightController:closeSelectStage()
UIManager:showWindow('UISettingWin',menuIndex.team)
end,
enterTxt="阵容展示",
cancelCallBack=self.cancelSelectDiscipleCallBack,
skipDiscipleStateCheck=true,
skipDiscipleInjuryCheck=true,
sureBodyid=2068,
sureBodyAnim=eAnimationID.dog_idle_1,
mapId=818001,
fightType=eFightPreSelectType.setTeam,
dontCloseStage=true,
enterBehaviorId=1,
statePriorityCheck=false,

}
local teamList=UISettingModel:getShowcaseTeamList()or{}
winArgs.teamList=teamList
UIFullFightPrepareControl:showPrepareWindow(winArgs)
end

function UISettingWin.cancelSelectDiscipleCallBack()
UIFullFightPrepareControl:closeUI()
fightController:closeSelectStage()
UIManager:showWindow('UISettingWin',menuIndex.team)
end



function UISettingWin:onSystemSetBtn()
if self.curMenuIndex==menuIndex.system then
return
end
self.curMenuIndex=menuIndex.system
self:refreshMenuState()
end


function UISettingWin:onChatSetBtn()
if self.curMenuIndex==menuIndex.chat then
return
end
self.curMenuIndex=menuIndex.chat
self:refreshMenuState()
end

function UISettingWin:onTeamBtn()
if not systemModel.isOpen(SYSTEM_DEFINE.eTeamShowcase)then
return
end
if self.curMenuIndex==menuIndex.team then
return
end
self.curMenuIndex=menuIndex.team
self:refreshMenuState()
self:freshTeamList()
end

function UISettingWin:onLogoutBtn()
local desc='账号注销后，角色信息还可保存15天,\n期间再次进入游戏则会自动取消注销\n祖师确定要注销账号吗？'
local func=function()
socketManager:send_254_84()
end
local showdata={
type='UIDialouge',
title='提示',
content=desc,
oktext='确定',
canceltext='取消',
allowclickBG='false',
useTimeCount=true,
timeCount=5,
okcallback=func,
}
local dialog=UIDialogManager.newDialog(showdata)
dialog:show()
end


function UISettingWin:onMusicVolumeChange(value)

self.musicVolume=value
AudioManager.setBgMusicVolume(value)

if AudioManager.getCurrentBgm()==nil and self.musicVolume>0 then
sceneAudioController.playZongMenBgMusic()
end
end


function UISettingWin:onSoundVolumeChange(value)

self.soundVolume=value
AudioManager.setSoundEffectVolume(value)
end


function UISettingWin:onRoleSpeakVolumeChange(value)

self.rolespeakVolumee=value
AudioManager.setRoleSpeakVolume(value)
end


function UISettingWin:onToggleChangeQieChuo(name,isOn)

local allow=isOn==true and 1 or 0
DiZiDuelController.send_254_74(allow)
end



function UISettingWin:onClickYeJingTest()











end

function UISettingWin:onBtnClose()
self:closeSelf()
end

function UISettingWin:onBtn30fps()
Frame=FRAME_LEVEL.eLow
gameHelper.setFrame(Frame)
self.winlua:SetChildActive(self.check30fps:getID(),true)
self.winlua:SetChildActive(self.check60fps:getID(),false)
end

function UISettingWin:onBtn60fps()
Frame=FRAME_LEVEL.eMedium
gameHelper.setFrame(Frame)
self.winlua:SetChildActive(self.check30fps:getID(),false)
self.winlua:SetChildActive(self.check60fps:getID(),true)
end

function UISettingWin:onBtnQualityLevel1()
self.qualityLevel=GraphicsQualityLevel.Low
self:freshQualityLevelCheck()
end

function UISettingWin:onBtnQualityLevel2()
self.qualityLevel=GraphicsQualityLevel.High
self:freshQualityLevelCheck()
end

function UISettingWin:onXieYiA()
UIManager:showWindow('UIAgreementWin',{userType=USER_TYPE.eUserProtocol})
end

function UISettingWin:onXieYiB()
UIManager:showWindow('UIAgreementWin',{userType=USER_TYPE.ePrivateProtected})
end

function UISettingWin:onXieYiC()
UIManager:showWindow('UIAgreementWin',{userId=24})
end

function UISettingWin:onXieYiD()
UIManager:showWindow('UIAgreementWin',{userId=23})
end


function UISettingWin:showSetButtonInfo()
local SetButtonInfo=houtaiModel:getSetButtonInfo()
self.jumpurlbtn:setActive(false)
if SetButtonInfo then

if SetButtonInfo.button_content then
self.jumpurlbtn:setActive(true)
self.jumpurltxt:setText(SetButtonInfo.button_content or"")
local vis=pfHelper.showDelAccount()and not loginModel.isDelAccount or false
if vis then
self.winlua:SetChildLocalPosX(self.xieyiRoot:getID(),-260)
self.winlua:SetChildLocalPosX(self.jumpurlbtn:getID(),100)
self.winlua:SetChildLocalPosX(self.logoutBtn:getID(),436)
end
end
end
end
function UISettingWin:onJumpurlbtn()
local SetButtonInfo=houtaiModel:getSetButtonInfo()
if SetButtonInfo then
if SetButtonInfo.jumpURL and SetButtonInfo.button_content then
local jumpURL=SetButtonInfo.jumpURL
pfwindowslController:OpenURL_By_UIWebViewWin(jumpURL)
end
end
end

function UISettingWin:onChangeTeamButton()
self:showFightWin()
end


function UISettingWin:onBindAccount()
platformSDK:reqBingdingAccount()
end


function UISettingWin:onUnBindAccount()
platformSDK:reqUnBingdingAccount()
end


function UISettingWin:reqBingdingAccountState()
platformSDK:reqBingdingAccountState()
end


function UISettingWin:freshShowBingBtn(state)
self.UnBindAccount:setActive(state)
self.BindAccount:setActive(not state)
end


function UISettingWin:checkPFWindowsShow()
local ruleObjState=pfwindowslController:checkPFWinState_ByWinType(pfwindowslController.winType.hidePrivacyAgreement)
self.xieyiRoot:setActive(ruleObjState)


end

function UISettingWin:showPFWindows(active)
if active then
self:checkPFWindowsShow()
else
self.xieyiRoot:setActive(false)

end

end


function UISettingWin:onFT_switchVoice()
local VoiceType=pfwindowslController:getVoiceVoiceVersion()
if VoiceType==pfwindowslController.VoiceType.taiwanyu then
pfwindowslController:setVoiceVoiceVersion(pfwindowslController.VoiceType.yueyu)
else
pfwindowslController:setVoiceVoiceVersion(pfwindowslController.VoiceType.taiwanyu)
end
end


function UISettingWin:onFT_GoogleAuth()
UIManager:showWindow('UIGoogleOneWin',{winState=2})
end
