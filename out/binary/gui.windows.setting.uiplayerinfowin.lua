







def_class("UIPlayerInfoWin",UIWindowBase)









function UIPlayerInfoWin:bindComponents()

self.accountText=UIText.get(self,0)
self.bgModel=UIObject.get(self,1)
self.bgModel2=UIObject.get(self,2)
self.btnChangeImage=UIButton.get(self,3)
self.btnChangeSex=UIButton.get(self,4)
self.btnsScrollView=UIObject.get(self,5)
self.changeHeadBtn=UIButton.get(self,6)
self.changeSexReddot=UIObject.get(self,7)
self.cleanBtn=UIButton.get(self,8)
self.copyBtn=UIButton.get(self,9)
self.discipleModel=UIObject.get(self,10)
self.emailBtn=UIButton.get(self,11)
self.emailReddot=UIObject.get(self,12)
self.fightText=UIText.get(self,13)
self.gongGaoBtn=UIButton.get(self,14)
self.head=UIObject.get(self,15)
self.headClick=UIButton.get(self,16)
self.headReddot=UIObject.get(self,17)
self.HM_AccountBind=UIButton.get(self,18)
self.HM_PhoneBind=UIButton.get(self,19)
self.HWshequBtn=UIButton.get(self,20)
self.imageReddot=UIObject.get(self,21)
self.instructionbookButton=UIButton.get(self,22)
self.ipBelongObj=UIObject.get(self,23)
self.ipBelongTxt=UIText.get(self,24)
self.jianSheText=UIText.get(self,25)
self.kefuBtn=UIButton.get(self,26)
self.level=UIText.get(self,27)
self.liandonBtn=UIButton.get(self,28)
self.pNameBtn=UIButton.get(self,29)
self.pNameText=UIText.get(self,30)
self.progressbar=UIProgress.get(self,31)
self.pSexImg=UIImage.get(self,32)
self.root=UIObject.get(self,33)
self.serverText=UIText.get(self,34)
self.settingBtn=UIButton.get(self,35)
self.settingReddot=UIObject.get(self,36)
self.shaqiPanel=UIButton.get(self,37)
self.shaQiTitle=UIButton.get(self,38)
self.shequBtn=UIButton.get(self,39)
self.switchAccountBtn=UIButton.get(self,40)
self.switchServerBtn=UIButton.get(self,41)
self.takePhotoButton=UIButton.get(self,42)
self.version=UIText.get(self,43)
self.wenDingDuText=UIText.get(self,44)
self.wxkfBtn=UIButton.get(self,45)
self.xianjie=UIObject.get(self,46)
self.xianMengText=UIText.get(self,47)
self.xjFortFightText=UIText.get(self,48)
self.xjFortLevelText=UIText.get(self,49)
self.xjJobInfoListPanel=UIObject.get(self,50)
self.xjShaQiNumText=UIText.get(self,51)
self.xjShiLiNameText=UIText.get(self,52)
self.xjTabBtn=UIButton.get(self,53)
self.xjTabText=UIText.get(self,54)
self.xjXiuShiNumText=UIText.get(self,55)
self.zhpanel=UIObject.get(self,56)
self.zmInfoReddot=UIObject.get(self,57)
self.zmNameClick=UIButton.get(self,58)
self.zNameBtn=UIButton.get(self,59)
self.zNameText=UIText.get(self,60)
self.zongmen=UIObject.get(self,61)
self.zongmenInfoBtn=UIButton.get(self,62)

self.btnChangeImage:setButtonClick(function()self:onBtnChangeImage()end)

self.btnChangeSex:setButtonClick(function()self:onBtnChangeSex()end)

self.changeHeadBtn:setButtonClick(function()self:onChangeHeadBtn()end)

self.cleanBtn:setButtonClick(function()self:onCleanBtn()end)

self.copyBtn:setButtonClick(function()self:onCopyBtn()end)

self.emailBtn:setButtonClick(function()self:onEmailBtn()end)

self.gongGaoBtn:setButtonClick(function()self:onGongGaoBtn()end)

self.headClick:setButtonClick(function()self:onHeadClick()end)

self.HM_AccountBind:setButtonClick(function()self:onHM_AccountBind()end)

self.HM_PhoneBind:setButtonClick(function()self:onHM_PhoneBind()end)

self.HWshequBtn:setButtonClick(function()self:onHWshequBtn()end)

self.instructionbookButton:setButtonClick(function()self:onInstructionbookButton()end)

self.kefuBtn:setButtonClick(function()self:onKefuBtn()end)

self.liandonBtn:setButtonClick(function()self:onLiandonBtn()end)

self.pNameBtn:setButtonClick(function()self:onPNameBtn()end)

self.settingBtn:setButtonClick(function()self:onSettingBtn()end)

self.shaqiPanel:setButtonClick(function()self:onShaqiPanel()end)

self.shaQiTitle:setButtonClick(function()self:onShaQiTitle()end)

self.shequBtn:setButtonClick(function()self:onShequBtn()end)

self.switchAccountBtn:setButtonClick(function()self:onSwitchAccountBtn()end)

self.switchServerBtn:setButtonClick(function()self:onSwitchServerBtn()end)

self.takePhotoButton:setButtonClick(function()self:onTakePhotoButton()end)

self.wxkfBtn:setButtonClick(function()self:onWxkfBtn()end)

self.xjTabBtn:setButtonClick(function()self:onXjTabBtn()end)

self.zmNameClick:setButtonClick(function()self:onZmNameClick()end)

self.zNameBtn:setButtonClick(function()self:onZNameBtn()end)

self.zongmenInfoBtn:setButtonClick(function()self:onZongmenInfoBtn()end)
self.HM={
["AccountBind"]=self.HM_AccountBind,
["PhoneBind"]=self.HM_PhoneBind,
}



end


function UIPlayerInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.accountText);self.accountText=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.bgModel2);self.bgModel2=nil;
_UIObject_release(self.btnChangeImage);self.btnChangeImage=nil;
_UIObject_release(self.btnChangeSex);self.btnChangeSex=nil;
_UIObject_release(self.btnsScrollView);self.btnsScrollView=nil;
_UIObject_release(self.changeHeadBtn);self.changeHeadBtn=nil;
_UIObject_release(self.changeSexReddot);self.changeSexReddot=nil;
_UIObject_release(self.cleanBtn);self.cleanBtn=nil;
_UIObject_release(self.copyBtn);self.copyBtn=nil;
_UIObject_release(self.discipleModel);self.discipleModel=nil;
_UIObject_release(self.emailBtn);self.emailBtn=nil;
_UIObject_release(self.emailReddot);self.emailReddot=nil;
_UIObject_release(self.fightText);self.fightText=nil;
_UIObject_release(self.gongGaoBtn);self.gongGaoBtn=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.headClick);self.headClick=nil;
_UIObject_release(self.headReddot);self.headReddot=nil;
_UIObject_release(self.HM_AccountBind);self.HM_AccountBind=nil;
_UIObject_release(self.HM_PhoneBind);self.HM_PhoneBind=nil;
_UIObject_release(self.HWshequBtn);self.HWshequBtn=nil;
_UIObject_release(self.imageReddot);self.imageReddot=nil;
_UIObject_release(self.instructionbookButton);self.instructionbookButton=nil;
_UIObject_release(self.ipBelongObj);self.ipBelongObj=nil;
_UIObject_release(self.ipBelongTxt);self.ipBelongTxt=nil;
_UIObject_release(self.jianSheText);self.jianSheText=nil;
_UIObject_release(self.kefuBtn);self.kefuBtn=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.liandonBtn);self.liandonBtn=nil;
_UIObject_release(self.pNameBtn);self.pNameBtn=nil;
_UIObject_release(self.pNameText);self.pNameText=nil;
_UIObject_release(self.progressbar);self.progressbar=nil;
_UIObject_release(self.pSexImg);self.pSexImg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.serverText);self.serverText=nil;
_UIObject_release(self.settingBtn);self.settingBtn=nil;
_UIObject_release(self.settingReddot);self.settingReddot=nil;
_UIObject_release(self.shaqiPanel);self.shaqiPanel=nil;
_UIObject_release(self.shaQiTitle);self.shaQiTitle=nil;
_UIObject_release(self.shequBtn);self.shequBtn=nil;
_UIObject_release(self.switchAccountBtn);self.switchAccountBtn=nil;
_UIObject_release(self.switchServerBtn);self.switchServerBtn=nil;
_UIObject_release(self.takePhotoButton);self.takePhotoButton=nil;
_UIObject_release(self.version);self.version=nil;
_UIObject_release(self.wenDingDuText);self.wenDingDuText=nil;
_UIObject_release(self.wxkfBtn);self.wxkfBtn=nil;
_UIObject_release(self.xianjie);self.xianjie=nil;
_UIObject_release(self.xianMengText);self.xianMengText=nil;
_UIObject_release(self.xjFortFightText);self.xjFortFightText=nil;
_UIObject_release(self.xjFortLevelText);self.xjFortLevelText=nil;
_UIObject_release(self.xjJobInfoListPanel);self.xjJobInfoListPanel=nil;
_UIObject_release(self.xjShaQiNumText);self.xjShaQiNumText=nil;
_UIObject_release(self.xjShiLiNameText);self.xjShiLiNameText=nil;
_UIObject_release(self.xjTabBtn);self.xjTabBtn=nil;
_UIObject_release(self.xjTabText);self.xjTabText=nil;
_UIObject_release(self.xjXiuShiNumText);self.xjXiuShiNumText=nil;
_UIObject_release(self.zhpanel);self.zhpanel=nil;
_UIObject_release(self.zmInfoReddot);self.zmInfoReddot=nil;
_UIObject_release(self.zmNameClick);self.zmNameClick=nil;
_UIObject_release(self.zNameBtn);self.zNameBtn=nil;
_UIObject_release(self.zNameText);self.zNameText=nil;
_UIObject_release(self.zongmen);self.zongmen=nil;
_UIObject_release(self.zongmenInfoBtn);self.zongmenInfoBtn=nil;
self.HM=nil;
end















local _GetResourceVersion=CS.AppDataModel.GetResourceVersion

local _this=nil


function UIPlayerInfoWin:onLoaded(...)
self:bindComponents()
notifySystem:listenNotify(notifyConfig.on_year_changed,UIPlayerInfoWin.on_year_changed)
notifySystem:listenNotify(notifyConfig.building_event,self.handleBuildingEvent)
self:addNotify(notifyConfig.onPlayerImageChanged,function(...)
self:refreshHead()
end)
self:addNotify(notifyConfig.on_money_changed,function(...)self:onMoneyChanged(...)end)
reddotClassManager.register_event(REDDIT_TYPE.eHeadKuang,self.refreshHeadSelectReddot)
reddotClassManager.register_event(REDDIT_TYPE.eMail,self.freshEmailReddot)
reddotClassManager.register_event(REDDIT_TYPE.ePlayerSetting,self.freshPlayerSettingReddot)
_this=self
self.winlua:SetChildCanvasGroupAlpha(self.root:getID(),0)
self.winlua:SetChildCanvasGroupDOFade(self.root:getID(),1,0.5)

self.winlua:SetChildSpineAnimation(self.bgModel:getID(),eAnimationID.juanzhoubi_dakai,1,nil)
if deviceHelper.isRunOpenHarmony()then
self:reqBingdingAccountState()
end
end


function UIPlayerInfoWin:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_year_changed,UIPlayerInfoWin.on_year_changed)
notifySystem:removelistener(notifyConfig.building_event,self.handleBuildingEvent)
reddotClassManager.unregister_event(REDDIT_TYPE.eHeadKuang,self.refreshHeadSelectReddot)
reddotClassManager.unregister_event(REDDIT_TYPE.eMail,self.freshEmailReddot)
reddotClassManager.unregister_event(REDDIT_TYPE.ePlayerSetting,self.freshPlayerSettingReddot)
_this=nil
systemIconFlyControl.setFlyDelay(0.3)
UIManager:callWindowFunc('UIMain','refreshActorHeadReddot')
end




function UIPlayerInfoWin:onShow(argtable,afterOnloaded)
self.selectZMTab=true
self:refreshHead()

local level=zongmenModel:getLevel()
self:refreshZMLevel(level)

local exp_cfg=cfg_guildexpconfig_get(level+1)
if exp_cfg then
self.progressbar:setProgressValue(tonumber(tostring(zongmenModel:getExp())),exp_cfg.exp)
else
self.progressbar:setProgressValue(1,1)
end

local sex=playerModel:getActorSex()
local sexIcon=sex==1 and 1 or 2
local iconName=iconHelper.getPlayerSexIcon(sexIcon)
self.pSexImg:setImageIcon(iconName,false)

self:refreshPlayerName()

self:refreshZMName()

self:refreshAge()

self.wenDingDuText:setText(homeBuffModel.getStableValue())

self.fightText:setText(playerModel:getActorFightValue())

local xmName=xianmengModel:hasXM()and xianmengModel:getXMName()or"暂无"
self.xianMengText:setText(xmName)

local local_cur_serveStr=userGlobalSetting.get('server_ip',loginModel.server_ip_string)
local name=string.match(local_cur_serveStr or'',loginModel.matchStr)
self.serverText:setText(name)

local accountStr=loginModel.userid
self.accountText:setText(accountStr)



local bdLevel=zongmenModel:getBuildingLevel(mapIdType.fort,SLG_SYSTEM_TYPE.eTianShuDian)
self.xjFortLevelText:setText(bdLevel)

local allMoneyCount=yunjiayingModel:getAllSoldierCountShow()
self.xjXiuShiNumText:setText(mathHelper.formatNumber3(allMoneyCount))

local fortFight=zongmenModel:getFortFightValue()
self.xjFortFightText:setText(mathHelper.formatNumber3(fortFight))

self.xjShiLiNameText:setText("尚未加入势力")

local have=moneyModel.getMoney(eMoneyType.mtLeak)
self.xjShaQiNumText:setText(mathHelper.formatNumber3(have))

local xjJobList={}
local xgkindInfoList=cfg_xianguangroupconfig()
for i,v in pairs(xgkindInfoList)do
local isInJob=xianguanController.checkSelfInJob(v.id)
if isInJob and v.id<=2 then
local JobInfo=xianguanModel:getSelfGroupJobInfo(v.id)
local jobCfg=xianguanConfig.getJobConfig(JobInfo.groupId,JobInfo.jobId)
table.insert(xjJobList,jobCfg)
end
end
local xjJobLen=#xjJobList
self.xjJobInfoListPanel:setActive(xjJobLen>0)
if xjJobLen>0 then
self.xjJobInfoListPanel:setChildScrollViewCreateGrids(xjJobLen,1)
local grids=self.xjJobInfoListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local jobCfg=xjJobList[i]
local item=grids[i-1]

local icon=chatModel:getSignIcon(jobCfg.chatFlagId)
if icon then
item:SetChildIcon(0,icon,false)
end

item:SetChildText(1,jobCfg.name)
end
end


local isOpenXianJie=xianjieController:checkXianJieSystemOpen()
self.xjTabBtn:setActive(isOpenXianJie)
self:freshXjTabBtn()

self:refreshZmLevelReddot()
self:refreshEmailReddot()

self.freshPlayerSettingReddot()

self:setModel()
self:showVersion()
self:refreshImageReddot()
self:refreshChangeSexReddot()
local actorid=playerModel:getActorID()
local args={actorid=actorid,markRecored=true}
args.callback=function(belong)
if _this==nil then return end
_this:refreshIPBelong(belong)
end
belongIPAddressController:reqBelong(args)


self:refreshBtnList()


if deviceHelper.isRunIOS()and not api_Available_SetSystemCopyBuffer()then
self.copyBtn:setActive(false)
end

local pfid=loginModel:getPfid()
self.HWshequBtn:setActive(pfid and pfid==8085)

self:showZongHuiPanel()


if verifyManager:isHideChangeSex()then
self.btnChangeSex:setActive(false)
end
end


function UIPlayerInfoWin:onHide()

end


function UIPlayerInfoWin:setModel()
local playerImage=playerImageModel:getPlayerImage()or
playerImageModel:getDefaultImage()
local sex=playerModel:getActorSex()
self.linkageId=liandonModel:getLianDonLinkageIdByPlayerImage(playerImage,sex)
self.liandonBtn:setActive(self.linkageId>0)
playerImageController.setPlayerModel(self.winlua,self.discipleModel:getID(),playerImage,1,eAnimationID.idle,0,0,playerController:supportDynamic())
end

function UIPlayerInfoWin:refreshHead()
playerController:setHeadIcon(self.winlua,self.head:getID(),{})
self:refreshHeadReddot()
end


function UIPlayerInfoWin:refreshHeadIcon()

end


function UIPlayerInfoWin:refreshChangeSex()
local sex=playerModel:getActorSex()
local sexIcon=sex==1 and 1 or 2
local iconName=iconHelper.getPlayerSexIcon(sexIcon)
self.pSexImg:setImageIcon(iconName,false)
end


function UIPlayerInfoWin:refreshHeadKuang()

end


function UIPlayerInfoWin:refreshZMLevel(level)
self.level:setText(level)
end


function UIPlayerInfoWin:refreshPlayerName()
self.pNameText:setText(playerModel:getActorName())
end


function UIPlayerInfoWin:refreshZMName()
local zmname=UISettingModel:getZMName()
local hasname=zmname~=nil and zmname~=''
if not hasname then
zmname='<color=#65615f>点击命名</color>'
end
self.zNameText:setText(zmname)
self.zNameBtn:setActive(hasname)
self.winlua:SetChildImageRaycast(self.zmNameClick:getID(),not hasname)
end


function UIPlayerInfoWin:refreshAge()
self.jianSheText:setText(FMT.fmt('第{0}年',gameUtilityModel.getGameYear()))
end

function UIPlayerInfoWin:refreshHeadReddot()
local reddot=UISettingModel:checkSelectHeadReddot()
self.headReddot:setActive(reddot)
end

function UIPlayerInfoWin:refreshZmLevelReddot()
local reddot=zongmenModel:checkZongMenLevelReddot()
self.zmInfoReddot:setActive(reddot)
end

function UIPlayerInfoWin:refreshEmailReddot()
local reddot=mailController:hasReddot()
self.emailReddot:setActive(reddot)
end

function UIPlayerInfoWin:refreshImageReddot()
self.imageReddot:setActive(playerImageModel:hasAnyNewImageTotal()or playerImageModel:checkSuitAttrActiveReddot())
end

function UIPlayerInfoWin:refreshChangeSexReddot()
local reddot=playerImageModel:checkChangeSexReddot()
self.changeSexReddot:setActive(reddot)
end

function UIPlayerInfoWin:refreshBtnList()
local defaultShowBtnCount=4
local maxShowBtnCount=5
local showBtnCount=defaultShowBtnCount

if webGLHelper:isShowCustomerServiceButton()then
self.wxkfBtn:setActive(true)
showBtnCount=showBtnCount+1
else
self.wxkfBtn:setActive(false)
end

if webGLHelper:isShowCleanButton()then
self.cleanBtn:setActive(true)
showBtnCount=showBtnCount+1
else
self.cleanBtn:setActive(false)
end

if autoLoginHelper:isAutoLogin()then
self.gongGaoBtn:setActive(true)
showBtnCount=showBtnCount+1
else
self.gongGaoBtn:setActive(false)
end


local isShieldKeFu=cfgHelper.getglobal('isShieldKeFu')

if pfwindowslController:checkPFWinState_ByCfg(pfwindowslController.winType.openKeFu)then
isShieldKeFu=false
end

if verifyManager:isHideKeFu()then
isShieldKeFu=true
end

local isShowKeFuBtn=not isShieldKeFu
self.kefuBtn:setActive(isShowKeFuBtn)
if isShowKeFuBtn then
showBtnCount=showBtnCount+1
end











local isShowTakePhotoBtn=systemModel.isOpen(SYSTEM_DEFINE.eTakeAPhotoInZM)and shareImageModel:isOpenShareImage()and api_Available_CroppingTexture()

self.takePhotoButton:setActive(isShowTakePhotoBtn)
if isShowTakePhotoBtn then
showBtnCount=showBtnCount+1
end


local isShowSheQuBtn=shequModel:isShowSheQuEnter()

self.shequBtn:setActive(isShowSheQuBtn)
if verifyManager:isHideSheQu()then
isShowSheQuBtn=false
end
if isShowSheQuBtn then
local gameVersion=pfwindowslController:getGameVersion()
local shequIcon=gameVersion==1 and"button_kefu"or"button_fbfensiye"
self.shequBtn:setSprite("ui/windows/setting/sharedtextures/setting.ab",shequIcon)
showBtnCount=showBtnCount+1
end


local isShowSwitchServerBtn=systemModel.isOpen(SYSTEM_DEFINE.eSwitchServer)and ServerTransferController:checkServerTransferConditionOpen()
self.switchServerBtn:setActive(isShowSwitchServerBtn)
if isShowSwitchServerBtn then
showBtnCount=showBtnCount+1
end

local isEnable=showBtnCount>maxShowBtnCount
self.btnsScrollView:setChildScrollRectEnable(isEnable)
end

function UIPlayerInfoWin.on_year_changed(newyear,isServer)
if _this==nil then
return
end
_this:refreshAge()
end




function UIPlayerInfoWin:onSwitchAccountBtn()
local showdata=
{
type='UIDialouge',
title='提示',
content='是否切换账号？',
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function(...)
if deviceHelper.isRunNoneOrEditor()then
loginState:logout()
elseif pfCommonHelper:isRunPC()or pfCommonHelper:isRunUWP()then
if pfwindowslController:checkIsGameVersion_guofu()then
loginControl:doLoginOutByDisconnect()
else
loginControl:loginout()
end
else
loginControl:loginout()
end
end,
showclosebtn=false,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end


function UIPlayerInfoWin:onEmailBtn()

mailController:showMailUI()
end


function UIPlayerInfoWin:onKefuBtn()
if pfwindowslController:checkIsGameVersion_oumei()then
platformSDK:reqCustomerService()
else
self:showWindow("UICustomerServiceFeedbackWin")
end
end


function UIPlayerInfoWin:onZongmenInfoBtn()
UIManager:showWindow('UIZongmenInfoWin',{showback=true})
end


function UIPlayerInfoWin:onSettingBtn()
UIManager:showWindow('UISettingWin')
end


function UIPlayerInfoWin:onPNameBtn()
UIManager:showWindow('UIChangePlayerNameWin')
end


function UIPlayerInfoWin:onZNameBtn()
UIManager:showWindow('UIChangeZMNameWin')
end


function UIPlayerInfoWin:onCopyBtn()

local accountStr=loginModel.userid
if accountStr==nil or accountStr==''or accountStr=='nil'then
accountStr='未知'
end


if deviceHelper.isRunIOS()then
if api_Available_SetSystemCopyBuffer()then
CS.GameInterface.SetSystemCopyBuffer(accountStr)
end
else
local result=platformHelper.copyTextToClipboard(accountStr)
if result then
UIManager.info("复制成功")
else
UIManager.error("复制失败")
end
end
end


function UIPlayerInfoWin:onChangeHeadBtn()

oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.head,{itemId=-1})
end






function UIPlayerInfoWin:onHeadClick()

oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.head,{itemId=-1})
end

function UIPlayerInfoWin.handleBuildingEvent(etype,arg1,arg2)
if etype==buildingEvent.zongmenLevelUp then
_this:refreshZMLevel(arg1)
end
end

function UIPlayerInfoWin.refreshHeadSelectReddot(class,sub_typo,last_flag,flag)
_this.headReddot:setActive(flag)
end

function UIPlayerInfoWin:onMoneyChanged(moneyType)
if moneyType==eMoneyType.mtExp then
self:refreshZmLevelReddot()
end
end

function UIPlayerInfoWin.freshEmailReddot()
local flag=mailController:hasReddot()
_this.emailReddot:setActive(flag)
end

function UIPlayerInfoWin.freshPlayerSettingReddot()
_this.settingReddot:setActive(UISettingModel:checkRedDotShowcase())
end

function UIPlayerInfoWin:onZmNameClick()
local name=UISettingModel:getZMName()
if name==nil or name==''then






local taskId=130
local taskData=taskModel:getTaskInfo(taskId)
if not taskData or taskModel:getTaskState(taskData).state<taskModel.taskRewardState then
UIManager.error('需完成主线“修复大殿”')
return
end

UIManager:showWindow('UICreateZMNameWin')
end
end

function UIPlayerInfoWin:onTakePhotoButton()
UIFullZongMenPhotoControl:showWindowPhoto()
end


function UIPlayerInfoWin:onBtnChangeImage()
UIManager:showWindow('UIPlayerChangeImageWin')
end


function UIPlayerInfoWin:onBtnChangeSex()





local changeSexReddot=userActorSetting.get('playerImageModel_changeSex',false)
if not changeSexReddot then
userActorSetting.set('playerImageModel_changeSex',true)
userActorSetting.flush()
self:refreshChangeSexReddot()
end
UIManager:showWindow('UIPlayerChangeSexWin')
end

function UIPlayerInfoWin:refreshIPBelong(belong)
local hideGuiShuDi=pfwindowslController:checkPFWinState_ByWinType(pfwindowslController.winType.hideGuiShuDi)
if verifyManager:isHideIpBelong()then
self.ipBelongObj:setActive(false)
return
end
self.ipBelongObj:setActive(hideGuiShuDi)
self.ipBelongTxt:setText(belong)
end

function UIPlayerInfoWin:showVersion()
if webGLHelper:isRunWebGL()or webGLHelper:isRunDouYinNative()then
local vstr=webGLHelper:getVersionString()
self.version:setText(vstr)
return
end
local vision_str=''
local version=_GetResourceVersion()
local apiLevel=deviceHelper.getAPILevel()
if deviceHelper.isRunNoneOrEditor()then
vision_str=FMT.fmt('游戏版本：{0}_{1}\n测试中项目不代表最终品质',version,apiLevel)
else
vision_str=FMT.fmt('游戏版本：{0}_{1}',version,apiLevel)
end
self.version:setText(vision_str)
end


function UIPlayerInfoWin:onShequBtn()
local data=houtaiModel:getSheQuEnterData()
local jumpURL=data.jumpURL
local openCommunity=data.openCommunity


local apiLevel=deviceHelper.getAPILevel()
if not openCommunity or apiLevel<400 then
if deviceHelper.isRunIOS()and apiLevel>=400 then
platformSDK:reqOpenURL(jumpURL)
else
LuaApplication.GetApplication().OpenURL(jumpURL)
end
else
platformSDK:reqOpenCommunity(10001)
end

end

function UIPlayerInfoWin:onInstructionbookButton()
if instructionbookModel:isMainTabOpen(5)then
instructionbookController:jumpTo(INSTRUCTIONBOOK_JUMP_TYPE.eUIJunZhenZhanDouWin)
else
UIManager:showWindow("UIGameInstructionBookWin",{mainId=1})
end
end

function UIPlayerInfoWin:onWxkfBtn()
if webGLHelper:isShowCustomerServiceButton()then
platformSDK:reqCustomerService()
end
end

function UIPlayerInfoWin:onCleanBtn()
if webGLHelper:isShowCleanButton()then
local dialogue=UIDialogManager.getConfirmDialogEx(nil,{
content='确定要清理缓存并重启游戏吗？',
okcb=function()
webGLHelper:clearAssetBundleAndRestartGame()
end
})
dialogue:show()
end
end

function UIPlayerInfoWin:onGongGaoBtn()
UIManager:showWindow('UIGongGaoWin')
end

function UIPlayerInfoWin:onLiandonBtn()
UIManager:showWindow('UITipLianDonWin',{linkageId=self.linkageId})
end


function UIPlayerInfoWin:reqBingdingAccountState()
platformSDK:reqBingdingAccountState()
platformSDK:reqPhoneBingdingState()
end


function UIPlayerInfoWin:onHM_PhoneBind()
platformSDK:reqBingdingAccount()
end


function UIPlayerInfoWin:onHM_AccountBind()
platformSDK:reqUnBingdingAccount()
end


function UIPlayerInfoWin:freshShowAccountBindBtn(state)
self.HM_AccountBind:setActive(state)

end


function UIPlayerInfoWin:freshShowPhoneBindBtn(state)
self.HM_PhoneBind:setActive(state)
end


function UIPlayerInfoWin:onHWshequBtn()
platformSDK:invoke('reqOpenForumPage')
end

function UIPlayerInfoWin:onXjTabBtn()
self.selectZMTab=not self.selectZMTab
self:freshXjTabBtn()
end

function UIPlayerInfoWin:freshXjTabBtn()
self.zongmen:setActive(self.selectZMTab)
self.xianjie:setActive(not self.selectZMTab)
self.xjTabText:setText(self.selectZMTab and"仙界信息"or"基本信息")
end

function UIPlayerInfoWin:onShaQiTitle()
self.shaqiPanel:setActive(true)
end

function UIPlayerInfoWin:onShaqiPanel()
self.shaqiPanel:setActive(false)
end


function UIPlayerInfoWin:showZongHuiPanel()
if ZongHuiController:checkZongHuiSystem()then
self.zhpanel:setActive(true)
self:freshList()
else
self.zhpanel:setActive(false)
end
end

function UIPlayerInfoWin:onfreshList()
_this:freshList()
end

function UIPlayerInfoWin:getSortList()
local list={}
local zhdata=ZongHuiModel:getBadgeList()
local config=cfg_sectbadgeconfig()
for k,v in ipairs(config)do
local id=v.id
local _weight=v.weight
local finishtime=0
local ishide=2
if zhdata[id]then
finishtime=zhdata[id].param_4
ishide=zhdata[id].param_3
end
local _unlock=finishtime>0
local _sort=_weight
if _unlock then
table.insert(list,{id=id,unlock=_unlock,sort=_sort,ishide=ishide})
end
end
if#list>1 then
table.sort(list,function(a,b)
return a.sort>b.sort
end)
end
return list
end

function UIPlayerInfoWin:freshList()
local abname=''
local zhwidget=self.zhpanel:getWidgetBase()
local list=self:getSortList()
local config=cfg_sectbadgeconfig()
local dataNum=#list
if dataNum>0 then
zhwidget:SetChildActive(-1,true)
zhwidget:SetChildScrollViewCreateGrids(2,dataNum,dataNum)
local grids=zhwidget:GetChildScrollViewItemWidgets(2)
local count=grids.Count
for i=1,count do
local widget=grids[i-1]
if widget then
local data=list[i]
local id=data.id
local unlock=data.unlock
local ishide=data.ishide
local cfg=config[id]



widget:SetChildGray(1,ishide==0 and unlock)

widget:SetChildActive(2,false)

widget:SetChildButtonClick(1,function()
if _this==nil then return end
self:onZHClick(widget)
end)
end
end
end
zhwidget:SetChildButtonClick(1,function()
if _this==nil then return end
self:onZHBtn()
end)
end

function UIPlayerInfoWin:onZHClick(_posWidget)
local _desc={"攻击+1000","防御+1000","生命+1000"}
UIManager:showWindow('UIMoJieRankTips',{posWidget=_posWidget,posWidgetIndex=1,pos={x=3,y=60},desc=_desc})
end

function UIPlayerInfoWin:onZHBtn()
ZongHuiController:OpenZongHuiWin()
end

function UIPlayerInfoWin:onSwitchServerBtn()
UIFullServerTransferControl:openServerTransferWindow()
end