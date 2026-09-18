







def_class("UIMain",UIWindowBase)









function UIMain:bindComponents()

self.UIMain=UIWindowLua.new(self,0)
self.actorInfo=UIObject.get(self,1)
self.attentionList=UIObject.get(self,2)
self.btnChange_concise=UIButton.get(self,3)
self.btnChange_normal=UIButton.get(self,4)
self.btnChatArrow=UIButton.get(self,5)
self.btnFriend=UIButton.get(self,6)
self.btnJieYu=UIButton.get(self,7)
self.btnJieYu1=UIObject.get(self,8)
self.btnJieYu2=UIObject.get(self,9)
self.btnMap=UIButton.get(self,10)
self.btnReddot=UIImage.get(self,11)
self.btnRightArrow=UIButton.get(self,12)
self.btnWorld=UIButton.get(self,13)
self.chatContent=UIObject.get(self,14)
self.chatCreater=UIGameobjectClone.new(self,15)
self.chatEmoreddot=UIImage.get(self,16)
self.chatReddot=UIObject.get(self,17)
self.chatRedPacket=UIObject.get(self,18)
self.chatScrollView=UIObject.get(self,19)
self.eventIcon=UIButton.get(self,20)
self.eventInfoPanel=UIButton.get(self,21)
self.eventName=UIText.get(self,22)
self.eventTime=UIText.get(self,23)
self.eventTipsBg=UIObject.get(self,24)
self.eventTipsTx=UIText.get(self,25)
self.friendReddot=UIImage.get(self,26)
self.headIconCreater=UIObject.get(self,27)
self.lineRight=UIObject.get(self,28)
self.listBottom=UIObject.get(self,29)
self.listRight=UIObject.get(self,30)
self.numText=UIText.get(self,31)
self.right=UIObject.get(self,32)
self.rightLayerRoot=UIObject.get(self,33)
self.rightRoot=UIObject.get(self,34)
self.top=UIObject.get(self,35)
self.worldActFlagImg=UIImage.get(self,36)
self.add1=UIObject.get(self,37)
self.add2=UIObject.get(self,38)
self.add3=UIObject.get(self,39)
self.add4=UIObject.get(self,40)

self.btnChange_concise:setButtonClick(function()self:onBtnChange_concise()end)

self.btnChange_normal:setButtonClick(function()self:onBtnChange_normal()end)

self.btnChatArrow:setButtonClick(function()self:onBtnChatArrow()end)

self.btnFriend:setButtonClick(function()self:onBtnFriend()end)

self.btnJieYu:setButtonClick(function()self:onBtnJieYu()end)

self.btnMap:setButtonClick(function()self:onBtnMap()end)

self.btnRightArrow:setButtonClick(function()self:onBtnRightArrow()end)

self.btnWorld:setButtonClick(function()self:onBtnWorld()end)

self.eventIcon:setButtonClick(function()self:onEventIcon()end)

self.eventInfoPanel:setButtonClick(function()self:onEventInfoPanel()end)
self.btnChange={
["concise"]=self.btnChange_concise,
["normal"]=self.btnChange_normal,
}


self.createFrom_UIHeadItem=function(...)return self:createFromRectTransformPrefab(0,...);end
self.sprite_icon_money_1=0

end


function UIMain:unbindComponents()
local _UIObject_release=UIObject.release
self.UIMain:deleteSelf();self.UIMain=nil;
_UIObject_release(self.actorInfo);self.actorInfo=nil;
_UIObject_release(self.attentionList);self.attentionList=nil;
_UIObject_release(self.btnChange_concise);self.btnChange_concise=nil;
_UIObject_release(self.btnChange_normal);self.btnChange_normal=nil;
_UIObject_release(self.btnChatArrow);self.btnChatArrow=nil;
_UIObject_release(self.btnFriend);self.btnFriend=nil;
_UIObject_release(self.btnJieYu);self.btnJieYu=nil;
_UIObject_release(self.btnJieYu1);self.btnJieYu1=nil;
_UIObject_release(self.btnJieYu2);self.btnJieYu2=nil;
_UIObject_release(self.btnMap);self.btnMap=nil;
_UIObject_release(self.btnReddot);self.btnReddot=nil;
_UIObject_release(self.btnRightArrow);self.btnRightArrow=nil;
_UIObject_release(self.btnWorld);self.btnWorld=nil;
_UIObject_release(self.chatContent);self.chatContent=nil;
self.chatCreater:deleteSelf();self.chatCreater=nil;
_UIObject_release(self.chatEmoreddot);self.chatEmoreddot=nil;
_UIObject_release(self.chatReddot);self.chatReddot=nil;
_UIObject_release(self.chatRedPacket);self.chatRedPacket=nil;
_UIObject_release(self.chatScrollView);self.chatScrollView=nil;
_UIObject_release(self.eventIcon);self.eventIcon=nil;
_UIObject_release(self.eventInfoPanel);self.eventInfoPanel=nil;
_UIObject_release(self.eventName);self.eventName=nil;
_UIObject_release(self.eventTime);self.eventTime=nil;
_UIObject_release(self.eventTipsBg);self.eventTipsBg=nil;
_UIObject_release(self.eventTipsTx);self.eventTipsTx=nil;
_UIObject_release(self.friendReddot);self.friendReddot=nil;
_UIObject_release(self.headIconCreater);self.headIconCreater=nil;
_UIObject_release(self.lineRight);self.lineRight=nil;
_UIObject_release(self.listBottom);self.listBottom=nil;
_UIObject_release(self.listRight);self.listRight=nil;
_UIObject_release(self.numText);self.numText=nil;
_UIObject_release(self.right);self.right=nil;
_UIObject_release(self.rightLayerRoot);self.rightLayerRoot=nil;
_UIObject_release(self.rightRoot);self.rightRoot=nil;
_UIObject_release(self.top);self.top=nil;
_UIObject_release(self.worldActFlagImg);self.worldActFlagImg=nil;
_UIObject_release(self.add1);self.add1=nil;
_UIObject_release(self.add2);self.add2=nil;
_UIObject_release(self.add3);self.add3=nil;
_UIObject_release(self.add4);self.add4=nil;
self.btnChange=nil;
end


















local _abName
local _this=nil
local _shenziPosLookup=
{
[0]=260,
[1]=190,
[2]=100,
[3]=10,
}

local _chatShrinkHeight=110
local _chatWarpHeight=250


local _defaultRightOpen=true



local moneyList={eMoneyType.mtXianYu,eMoneyType.mtLingYu,eMoneyType.mtLingShi,eMoneyType.mtLingPai}
local mActorInfoType={
eActorHead=0,
eActorNameObj=1,
eZMNameObj=2,
eZMFight=3,
eMoney=4,
eZMLevel=5,
eZMAgeObj=6,
eZMState=7,
eZMBag=8,
eActorName=9,
eZMName=10,
eZMAge=11,
eZMTask=12,
eShanEMask=13,
eShanEValueImg=14,
eframe=15,
edfframe=16,
edfbtn=17
}
local closeUICallBackList={
['UIMoneyDetailWin']=function()
UIManager:callWindowFunc('UIMain','onRefreshZMBagSelect')
end,
['UIHomeBuffWin']=function()
UIManager:callWindowFunc('UIMain','onRefreshZMStateSelect')
end,
}


local leftPanelTypeFun={
[leftSimpleState.hide]={
showFun=function()
_this:leftPanel_closeTask()
_this:leftPanel_closeMoneyDetail()
_this:leftPanel_closeHomeBuff()
end,
closeFun=function()return end,
},

[leftSimpleState.task]={
showFun=function(isInit)
_this:leftPanel_showTask(isInit)
end,
closeFun=function()
_this:leftPanel_closeTask()
end,
},

[leftSimpleState.moneyDetail]={
showFun=function(isInit)
_this:leftPanel_showMoneyDetail(isInit)
end,
closeFun=function()
_this:leftPanel_closeMoneyDetail()
end,
},

[leftSimpleState.homeBuff]={
showFun=function(isInit)
_this:leftPanel_showHomeBuff(isInit)
end,
closeFun=function()
_this:leftPanel_closeHomeBuff()
end,
},
}

function UIMain:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onNewDay,self.onNewDay)
self:addNotify(notifyConfig.onZongMengLevelChange,self.onZongMengLevelChange)
self:addNotify(notifyConfig.on_year_changed,self.on_year_changed)
self:addNotify(notifyConfig.building_event,self.on_building_event)
self:addNotify(notifyConfig.on_item_changed,UIMain.on_item_changed)
self:addNotify(notifyConfig.on_system_open,self.on_system_open)
self:addNotify(notifyConfig.iconUnlock,self.onIconUnlock)
self:addNotify(notifyConfig.on_money_init,self.on_money_init)
self:addNotify(notifyConfig.onDiscipleJJChange,self.onDiscipleJJChange)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
self:addNotify(notifyConfig.closeUI,self.onCloseUI)
self:addNotify(notifyConfig.onZongMenFightChange,self.onZongMenFightChange)
self:addNotify(notifyConfig.onActorDataInit,self.onActorDataInit)
self:addNotify(notifyConfig.onSettingDataInit,self.onSettingDataInit)
self:addNotify(notifyConfig.onActorHeadChange,self.onActorHeadChange)
self:addNotify(notifyConfig.onActorNameChange,self.onActorNameChange)
self:addNotify(notifyConfig.onZongMenNameChange,self.onZongMenNameChange)
self:addNotify(notifyConfig.onSubActivityStateChange,self.onSubActivityStateChange)
self:addNotify(notifyConfig.onSubActivityOpen,self.onSubActivityOpen)
self:addNotify(notifyConfig.onCSJDGuildDataChange,self.onCSJDGuildDataChange)
self:addNotify(notifyConfig.onXMHBGuildDataChange,self.onXMHBGuildDataChange)
self:addNotify(notifyConfig.onTaskInit,self.refreshTaskState)
self:addNotify(notifyConfig.onTaskChange,self.refreshTaskState)
self:addNotify(notifyConfig.onTaskRecommand,self.refreshTaskState)
self:addNotify(notifyConfig.onTaskRemove,self.refreshTaskState)
self:addNotify(notifyConfig.onRecvMessage,function(...)self:onRecvMessage(...)end)
self:addNotify(notifyConfig.onPlayerImageChanged,function()self:onPlayerImageChanged()end)
self:addNotify(notifyConfig.onProsperityChange,function()self:onProsperityChange()end)
self:addNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
self:addNotify(notifyConfig.onMountainChange,self.onMountainChange)


reddotClassManager.register_event(REDDIT_TYPE.eFriend,self.refreshFriendReddot)
reddotClassManager.register_event(REDDIT_TYPE.eFriendPoint,self.refreshFriendReddot)
reddotClassManager.register_event(REDDIT_TYPE.eHeadKuang,self.refreshHeadSelectReddot)
reddotClassManager.register_event(REDDIT_TYPE.eMail,self.freshEmailReddot)
self._onRightMenuReddotChanged=function(...)
self:freshSimpleBtnReddot(...)
end
reddotClassManager.register_eventList({REDDIT_TYPE.eXianGouLiBao,REDDIT_TYPE.eWelfare,REDDIT_TYPE.eDailyTask},
self._onRightMenuReddotChanged)

self.onActivityReddotChange_=function(...)
self:freshSimpleBtnReddot(...)
end
self:addNotify(notifyConfig.onActivityReddotChange,self.onActivityReddotChange_)

self.abName=globalABLookup.mainwin
myxpcall(function()
self.handler=chatMessageMainHandler.create(self.chatCreater,self.chatContent:getID(),self)
self:registerChatHandle()
self.chatCreater:setRefreshAction(function(...)self:onFinishChatCreatAction(...)end)
chatControl.freshMainMesgPanel(MAIN_HOLD_TYPE.eMain,self.handler)
end)
self.viewHeight=self.winlua:GetChildSizeDeltaY(self.chatScrollView:getID())
self.viewWidth=self.winlua:GetChildSizeDeltaX(self.chatScrollView:getID())
self.iconLuaObjectLookup={}
_abName=mainConfig.getBundleName()

self:freshFriendReddot()
self.headCost={}
self.emotCost={}


self.leftSimple=simpleModeControl:getLeftSimple()

self.eventInfoPanel:setActive(false)
self:initHeadCostList()
self:initEmotCostList()
self:initActorInfo()
local isInit=mainControl:isFirstLoad()
mainControl:setFirstLoad(false)

self.groupBtnNodeID={
[MAIN_ICON_GROUP_TYPE.eBottom]=function()
return self.listBottom:getID()
end,
[MAIN_ICON_GROUP_TYPE.eRight]=function()
return self.listRight:getID()
end,
}
self.groupBtnCfgs=
{
[MAIN_ICON_GROUP_TYPE.eBottom]=function()
return mainConfig.getBottomGroupConfig()
end,
[MAIN_ICON_GROUP_TYPE.eRight]=function()
return mainConfig.getRightGroupConfig()
end,
}
self.chatWarp=false
self:initRightPanel(true)
self:checkVerify()
end


function UIMain:checkVerify()
if welfareController:checkVerify()then
self.add1:setActive(false)
self.add2:setActive(false)
self.add3:setActive(false)
self.add4:setActive(false)
end
end



function UIMain:__delete()
self:endAllReddotPunchRotation()
self:unregisterChatHandle()
self.chatCreater:setRefreshAction(nil)
self:unbindComponents()
for _,v in ipairs(self.list or{})do
if v.onClose then
v:onClose()
end
end
self:releaseAllButton()
self.list={}
self.headCost={}
self.emotCost={}


reddotClassManager.unregister_event(REDDIT_TYPE.eFriend,self.refreshFriendReddot)
reddotClassManager.unregister_event(REDDIT_TYPE.eFriendPoint,self.refreshFriendReddot)
reddotClassManager.unregister_eventList({REDDIT_TYPE.eXianGouLiBao,REDDIT_TYPE.eWelfare,REDDIT_TYPE.eDailyTask},
self._onRightMenuReddotChanged)
reddotClassManager.unregister_event(REDDIT_TYPE.eHeadKuang,self.refreshHeadSelectReddot)
reddotClassManager.unregister_event(REDDIT_TYPE.eMail,self.freshEmailReddot)
_this=nil
end

function UIMain.on_system_open(sysId)
if _this==nil then return end
if sysId==SYSTEM_DEFINE.eJianZhuTiShi then
buildingCDControl:setReddotFlag(true)
end

if sysId==SYSTEM_DEFINE.eFriend then
_this.btnFriend:setActive(true)
end

if sysId==SYSTEM_DEFINE.eWorld then
_this:refreshWorldEnable()
end

if sysId==SYSTEM_DEFINE.eJiuChongTianJieComplete then
_this:refreshJieYuBtn()
end

if sysId==SYSTEM_DEFINE.eZongMenCeFeng then
if webGLHelper:isRunMiniGame()and isometricMapSystem:isCanActiveNewArea()then
isometricMapSystem:activeNewArea()
end
end

_this:freshChatReddot()
end

function UIMain:showRoot(show)
self.top:setActive(show)
self.rightLayerRoot:setActive(show)
end

function UIMain:onShow(argtable,afterOnloaded)
if self.handler then
self.handler:resumeRecvMsg()
end

self:showRoot(true)
if not initProControl.isDone()then return end
local leftState=argtable and argtable.leftState or nil

self:initMoneyList()
self:refreshActorInfo()
self:freshMap()
self:freshChatReddot()

self:setContentBottom()
self:showEmergenciesPanel()




local btnGroupType=MAIN_ICON_GROUP_TYPE.eBottom
self:creatGroupBtns(btnGroupType)
if not afterOnloaded then
self:doCloneMove(btnGroupType,0)


end

local btnGroupType=MAIN_ICON_GROUP_TYPE.eRight
self:creatGroupBtns(btnGroupType)
if not afterOnloaded then
self:doCloneMove(btnGroupType,0)
self:initRightPanel(true)
end

if systemModel.isOpen(SYSTEM_DEFINE.eFriend)then
self.btnFriend:setActive(true)
self:freshFriendReddot()
else
self.btnFriend:setActive(false)
end

systemIconFlyControl.setFlyDelay()




self:initLeftSimpletate(leftState)

self:freshSimpleBtn()
self:refreshWorldEnable()
self:refreshWorldFlag()
self:refreshJieYuBtn()

XianYunGangModel:initBoatShow()

self:initRedPacket()
self:refreshRedPacket()
end


function UIMain:onHide()
self:endAllReddotPunchRotation()
for _,v in ipairs(self.list or{})do
if v.onHide then
v:onHide()
end
end
self:releaseAllButton()
emergenciesControl:showEventPageEffect(false)
self:showRoot(false)



if self.handler then
self.handler:pauseRecvMsg()
end
end






























































function UIMain:initRightPanelDisable()
simpleModeControl:setRightSimple(true)
self:initRightPanel()
end

function UIMain:initRightPanelEnable()
simpleModeControl:setRightSimple(false)
self:initRightPanel()
end







function UIMain:initActorInfo()
local infoWidget=self.actorInfo:getWidgetBase()
self.actorInfoWidget=infoWidget

infoWidget:SetChildButtonClick(mActorInfoType.eActorHead,function()
self:onActorInfo()
end,true)

infoWidget:SetChildButtonClick(mActorInfoType.eActorNameObj,function()
self:onActorInfo()
end,true)

infoWidget:SetChildButtonClick(mActorInfoType.eZMNameObj,function()
self:onZongMenNameClick()
end,true)

infoWidget:SetChildButtonClick(mActorInfoType.eZMFight,function()
self:onZongMenFightClick()
end,true)

self:initMoneyList()

infoWidget:SetChildButtonClick(mActorInfoType.eZMAgeObj,function()

end,true)

self.leftSimple=simpleModeControl:getLeftSimple()

local zmStateWidget=infoWidget:GetChildWidgetBase(mActorInfoType.eZMState)
zmStateWidget:SetChildActive(0,self.leftSimple==leftSimpleState.homeBuff)
infoWidget:SetChildButtonClick(mActorInfoType.eZMState,function()
zmStateWidget:SetChildActive(0,true)
self:onZongMenStateClick()
end,true)

local zmBagWidget=infoWidget:GetChildWidgetBase(mActorInfoType.eZMBag)
zmBagWidget:SetChildActive(0,self.leftSimple==leftSimpleState.moneyDetail)
infoWidget:SetChildButtonClick(mActorInfoType.eZMBag,function()
zmBagWidget:SetChildActive(0,true)
self:onZongMenBagClick()
end,true)

local zmTaskWidget=infoWidget:GetChildWidgetBase(mActorInfoType.eZMTask)
zmTaskWidget:SetChildActive(0,self.leftSimple==leftSimpleState.task)
infoWidget:SetChildButtonClick(mActorInfoType.eZMTask,function()
zmTaskWidget:SetChildActive(0,true)
self:onZongMenTaskClick()
end,true)


infoWidget:SetChildActive(mActorInfoType.eShanEValueImg,true)




infoWidget:SetChildButtonClick(mActorInfoType.edfbtn,function()
self:onDFTips()
end,true)
end

function UIMain:initMoneyList()
local infoWidget=self.actorInfoWidget
local isInFort=zongmenControl:isMountid(mapIdType.fort)
if isInFort then
moneyList[4]=eMoneyType.mtXianLing
else
moneyList[4]=eMoneyType.mtLingPai
end

local moneyWidget=infoWidget:GetChildWidgetBase(mActorInfoType.eMoney)
self.moneyChangeLookup={}
for i,v in ipairs(moneyList)do
local item=moneyWidget:GetChildWidgetBase(i-1)
local moneyType=v
self.moneyChangeLookup[moneyType]=i
item:SetChildButtonClick(0,function()
self:onMoneyClick(moneyType)
end,true)
item:SetChildButtonClick(2,function()
self:onMoneyExClick(i,moneyType)
end,true)
end
end

function UIMain:onRefreshZMBagSelect()
local zmBagWidget=self.actorInfoWidget:GetChildWidgetBase(mActorInfoType.eZMBag)
zmBagWidget:SetChildActive(0,false)
end
function UIMain:onRefreshZMStateSelect()
local zmStateWidget=self.actorInfoWidget:GetChildWidgetBase(mActorInfoType.eZMState)
zmStateWidget:SetChildActive(0,false)
end

function UIMain:refreshActorInfo()
if not playerModel:checkInit()then return end
self:refreshActorHeadObj()
self:refreshActorNameObj()
self:refreshZongMenNameObj()
self:refreshZongMenFightObj()
self:refreshMoneyObj()
self:refreshZongMenLevelObj()
self:refreshZongMenAgeObj()

buildingCDControl:setReddotFlag(true)
end

function UIMain:onPlayerImageChanged()
local stopHeadKuangAnim=webGLHelper:isHidePunchAni()
if stopHeadKuangAnim then
playerController:setRawImageHeadIcon(self.winlua,self.headIconCreater:getID(),{iconInfo=nil,scale=0.82,stopHeadKuangAnim=true,blueDiamondPos={100,47}})
else
playerController:setHeadIcon(self.winlua,self.headIconCreater:getID(),{iconInfo=nil,scale=0.82,blueDiamondPos={100,47}})
end
end


function UIMain:refreshActorHeadObj()
local actorHeadWidget=self.actorInfoWidget:GetChildWidgetBase(mActorInfoType.eActorHead)















local stopHeadKuangAnim=webGLHelper:isHidePunchAni()
if stopHeadKuangAnim then
playerController:setRawImageHeadIcon(self.winlua,self.headIconCreater:getID(),{iconInfo=nil,scale=0.82,stopHeadKuangAnim=true,blueDiamondPos={100,47}})
else
playerController:setHeadIcon(self.winlua,self.headIconCreater:getID(),{iconInfo=nil,scale=0.82,blueDiamondPos={100,47}})
end


self:refreshActorHeadReddot(actorHeadWidget)

self:refreshActorHeadUp(actorHeadWidget)
end

function UIMain:refreshActorHeadReddot(actorHeadWidget)
if actorHeadWidget==nil then
actorHeadWidget=self.actorInfoWidget:GetChildWidgetBase(mActorInfoType.eActorHead)
end
local reddot=UISettingModel:checkSelectHeadReddot()or
mailController:hasReddot()or
playerImageModel:hasAnyNewImageTotal()or
playerImageModel:checkSuitAttrActiveReddot()or
UISettingModel:checkRedDotShowcase()or
playerImageModel:checkChangeSexReddot()


actorHeadWidget:SetChildActive(3,reddot)

self.headReddotIndex=self:doPunchRotation(actorHeadWidget,3,self.headReddotIndex,reddot)
end

function UIMain:refreshActorHeadUp(actorHeadWidget)
if actorHeadWidget==nil then
actorHeadWidget=self.actorInfoWidget:GetChildWidgetBase(mActorInfoType.eActorHead)
end
local reddot=zongmenModel:checkZongMenLevelReddot()
actorHeadWidget:SetChildActive(4,reddot)
actorHeadWidget:SetChildActive(5,reddot)
end

function UIMain:refreshActorNameObj()
self.actorInfoWidget:SetChildText(mActorInfoType.eActorName,playerModel:getActorName())
end

function UIMain:refreshZongMenNameObj()
local name=UISettingModel:getZMName()
if name==nil or name==''then
name='<color=#c4b797>点击命名</color>'
end
self.actorInfoWidget:SetChildText(mActorInfoType.eZMName,name)
end

function UIMain:refreshZongMenFightObj()
local zmFightWidget=self.actorInfoWidget:GetChildWidgetBase(mActorInfoType.eZMFight)
local fight=playerModel:getActorFightValue()

zmFightWidget:SetChildText(0,mathHelper.formatNumber3(fight))
local isOpen=systemModel.isOpen(SYSTEM_DEFINE.eTopThreeTeams)
local reddot=userActorArraySetting.get(ACTOR_SETTING_TYPE.eOneTimeReddot,'zmFight',0)==0
local topThreeTeamsReddot=isOpen and reddot

local isOpenFort=mountainControl:isOpen(mapIdType.fort)
local reddot1=userActorArraySetting.get(ACTOR_SETTING_TYPE.eOneTimeReddot,'zmFortFight',0)==0
local fortReddot=isOpenFort and reddot1
zmFightWidget:SetChildActive(1,topThreeTeamsReddot or fortReddot)
end

function UIMain:refreshMoneyObj()
local moneyWidget=self.actorInfoWidget:GetChildWidgetBase(mActorInfoType.eMoney)
for i,v in ipairs(moneyList)do
local item=moneyWidget:GetChildWidgetBase(i-1)
local moneyType=v
self:refreshMoneyItem(item,moneyType)
end
end

function UIMain:refreshMoneyItem(item,moneyType)
if item==nil then
local idx=self.moneyChangeLookup[moneyType]
local moneyWidget=self.actorInfoWidget:GetChildWidgetBase(mActorInfoType.eMoney)
item=moneyWidget:GetChildWidgetBase(idx-1)
end

if moneyType==eMoneyType.mtXianYu and verifyManager:isOpen()and pfwindowslController:checkIsGameVersion_yuenan()and deviceHelper.isRunIOS()then
item:SetChildIcon(0,iconHelper.getIconName(moneyType),false)
else

item:SetChildCSImageSprite(0,globalABLookup.mainwin,iconHelper.getIconName(moneyType))
end


local showStr=moneyModel.getMoneyDesc1(moneyType)
item:SetChildText(1,showStr)
end

function UIMain:refreshZongMenLevelObj()
local levelWidget=self.actorInfoWidget:GetChildWidgetBase(mActorInfoType.eZMLevel)
if DianFengLevelController.isShowDF()then
self.actorInfoWidget:SetChildActive(mActorInfoType.eframe,false)
self.actorInfoWidget:SetChildActive(mActorInfoType.edfframe,true)
levelWidget:SetChildActive(2,false)
levelWidget:SetChildActive(3,true)
local dflevel=DianFengLevelModel:getLevel()
local levelStr=FMT.fmt("{0}级",dflevel)
levelWidget:SetChildText(0,levelStr)
local next_cfg=cfg_dianfenglevelconfig_get(dflevel+1)
local curExp=DianFengLevelModel:getExp()
if next_cfg then
local cfglvl=cfg_dianfenglevelconfig_get(dflevel)
local maxexp=cfglvl.exp
local maxValue=10000
local nowValue=math.floor((curExp/maxexp*(0.725-0.275)+0.275)*10000)
levelWidget:SetChildProgressValue(1,nowValue,maxValue)
end
else
self.actorInfoWidget:SetChildActive(mActorInfoType.eframe,true)
self.actorInfoWidget:SetChildActive(mActorInfoType.edfframe,false)
levelWidget:SetChildActive(2,true)
levelWidget:SetChildActive(3,false)
local zmLevel=zongmenModel:getLevel()
local levelStr=FMT.fmt("{0}级",zmLevel)
levelWidget:SetChildText(0,levelStr)
local next_cfg=cfg_guildexpconfig_get(zmLevel+1)
local curExp=tonumber(tostring(zongmenModel:getExp()))
if next_cfg then


local maxValue=10000
local nowValue=math.floor((curExp/next_cfg.exp*(0.725-0.275)+0.275)*10000)
levelWidget:SetChildProgressValue(1,nowValue,maxValue)
end
end
end

function UIMain:refreshZongMenAgeObj()
local y=gameUtilityModel.getGameYear()
local str=string.format('第%d年',y)
self.actorInfoWidget:SetChildText(mActorInfoType.eZMAge,str)
end







function UIMain:onActorInfo()
if zongmenModel:checkZongMenLevelReddot()then
UIManager:showWindow('UIZongmenInfoWin',{showback=true})
else
UIManager:showWindow('UIPlayerInfoWin')
end
end

function UIMain:onMoneyClick(moneyType)
if verifyManager:isOpen()and webGLHelper:isRunMiniGame()then
return
end
if moneyType==eMoneyType.mtXianYu then
UIFullRechargeController:showRechargeWindow()
else
gainControl:showGainWin(moneyType)
end
end

function UIMain:onMoneyExClick(idx,moneyType)
local moneyWidget=self.actorInfoWidget:GetChildWidgetBase(mActorInfoType.eMoney)
local item=moneyWidget:GetChildWidgetBase(idx-1)
local desc=FMT.fmt('{0}：{1}',moneyModel.getMoneyName(moneyType),moneyModel.getMoney(moneyType))
UIManager:showWindow('UIConditionTipsOne',{showType=3,str=desc,posWidget=item,pos={x=0,y=-20}})
end

function UIMain:onZongMenFightClick()
local isSetReddot=false
if systemModel.isOpen(SYSTEM_DEFINE.eTopThreeTeams)then
local reddot=userActorArraySetting.get(ACTOR_SETTING_TYPE.eOneTimeReddot,'zmFight',0)==0
if reddot then
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eOneTimeReddot,'zmFight',1,0)
isSetReddot=true
end
end
if mountainControl:isOpen(mapIdType.fort)then
local reddot=userActorArraySetting.get(ACTOR_SETTING_TYPE.eOneTimeReddot,'zmFortFight',0)==0
if reddot then
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eOneTimeReddot,'zmFortFight',1,0)
isSetReddot=true
end
end

if isSetReddot then
self:refreshZongMenFightObj()
end
UIManager:showWindow('UIMainStrengthTipsWin')
end

function UIMain:onZongMenNameClick()
local name=UISettingModel:getZMName()
if name==nil or name==''then






local taskId=130
local isFinish=taskModel:checkTaskFinish(taskId)
local taskData=taskModel:getTaskInfo(taskId)
local canCreate=isFinish or
taskData and taskModel:getTaskState(taskData).state>=taskModel.taskRewardState
if not canCreate then
UIManager.error('需完成主线“修复大殿”')
return
end

UIManager:showWindow('UICreateZMNameWin')
else
UIManager:showWindow('UIPlayerInfoWin')

end
end

function UIMain:onDFTips()
if DianFengLevelController.isShowDF()then
UIManager:showWindow('UIDianFengTips',{posWidget=self.actorInfoWidget,posWidgetIndex=mActorInfoType.edfbtn,pos={x=0,y=-50}})
end
end


function UIMain:freshMap()



end

function UIMain:initRightPanel(isInit)
local cfgs=mainConfig.getRightGroupConfig()
local isOpen=not simpleModeControl:getRightSimple()
local endVal=isOpen and 0 or 335
local rorate=isOpen and 90 or 0
self.winlua:SetChildDORotation(self.btnRightArrow:getID(),Vector3(0,0,rorate),0.5)
self.winlua:SetChildDOLocalMoveY(self.right:getID(),endVal,0.3)
if isOpen then
UIManager:invokeUIMethod("UIMainEntryWin","showEntryPanel",isInit)
else
UIManager:invokeUIMethod("UIMainEntryWin","hideEntryPanel")
end

self:freshSimpleBtnReddot()

self:freshSimpleBtn()
end

function UIMain:freshSimpleBtnReddot()
local isOpen=simpleModeControl:getRightSimple()
if isOpen==false then
if self.rightMenuReddot~=isOpen then
self.rightMenuReddot=isOpen
self.btnReddot:setActive(false)
self.btnReddotIndex=self:doPunchRotation(self.widget,self.btnReddot:getID(),self.btnReddotIndex,false)
end
return
end
local reddot=mainConfig.getGroupReddot(MAIN_ICON_GROUP_TYPE.eRight)
or enterManager:getAllEnterReddot()
if self.rightMenuReddot~=reddot then
self.rightMenuReddot=reddot
self.btnReddot:setActive(reddot)
end
self.btnReddotIndex=self:doPunchRotation(self.widget,self.btnReddot:getID(),self.btnReddotIndex,reddot)
end

function UIMain:getGroupBtnCfgs(btnGroupType)
return self.groupBtnCfgs[btnGroupType]()
end

function UIMain:getGroupBtnNodeID(btnGroupType)
return self.groupBtnNodeID[btnGroupType]()
end

function UIMain:creatGroupBtns(btnGroupType)
local index=self:getGroupBtnNodeID(btnGroupType)
local configs=self:getGroupBtnCfgs(btnGroupType)


if btnGroupType==MAIN_ICON_GROUP_TYPE.eRight and not next(configs)then
self.rightLayerRoot:setActive(false)
return
end

local indexArray={}
local parentIndexArray={}
local keys={}
for i,v in ipairs(configs)do
indexArray[i]=v.UIPrefabIndex
parentIndexArray[i]=i-1
keys[i]=v.key
end
self.winlua:SetCreatChildClonePrefabEx(index,indexArray,parentIndexArray,keys)
self.list={}
if not self.iconLuaObjectLookup[btnGroupType]then
self.iconLuaObjectLookup[btnGroupType]={}
end

local lookup=self.iconLuaObjectLookup[btnGroupType]
local temp={}
for k,v in pairs(lookup)do
temp[k]=v
end
for i=1,#configs do
local config=configs[i]
local key=config.key
local iconType=config.iconType
local luaObjet=lookup[key]
temp[key]=nil
local isFadeIn=iconType and not systemIconFlyControl.isFly(iconType)or false

local widget=self.winlua:GetChildCloneWidget(index,i-1)
local isInit=luaObjet==nil
if isInit then
mainBtnConfig.PreloadCtor(config)
local ctor=config.ctor
luaObjet=ctor(widget,i,config)
lookup[key]=luaObjet
luaObjet:onLoaded()
else
luaObjet:init(widget,i,config)
end
local list=self.list
list[#list+1]=luaObjet
luaObjet:onShow(isInit)
luaObjet:setChildCanvasGroupAlpha(-1,isFadeIn and 0 or 1)
local comName=FMT.fmt('{0}.click',keys[i])
luaObjet:setNewBieComponentId(1,comName)
luaObjet:setChildWeakGuideComponentId(1,comName)
end

for key,luaObjet in pairs(temp)do
lookup[key]=nil
if luaObjet and luaObjet.release then
luaObjet:release()
end
end
end

function UIMain:releaseAllButton()
for _,lookup in pairs(self.iconLuaObjectLookup)do
for _,luaObjet in pairs(lookup)do
if luaObjet and luaObjet.release then
luaObjet:release()
end
end
end
self.iconLuaObjectLookup={}
end

function UIMain:getLuaObjectByKey(key)

for _,lookup in pairs(self.iconLuaObjectLookup)do
if lookup[key]then
return lookup[key]
end
end

return nil
end

function UIMain:doFadeNomal(key)
local luaObjet=self:getLuaObjectByKey(key)
if luaObjet then
luaObjet:setChildCanvasGroupAlpha(-1,1)
end
end

function UIMain:doCloneMove(btnGroupType,duration)
if btnGroupType then
local index=self:getGroupBtnNodeID(btnGroupType)
self.winlua:StartChildClonePrefabTween(index,duration or 0.5,DG.Tweening.Ease.InOutBack)
end
end

function UIMain:getWidgetByKey(key)
local btnGroupType=mainConfig.getIconGroupType(key)
if btnGroupType then
local index=self:getGroupBtnNodeID(btnGroupType)
return self.winlua:GetChildCloneWidgetByKey(index,key)
end
end

function UIMain:getPositionByKey(key)
local btnGroupType=mainConfig.getIconGroupType(key)
if btnGroupType then
local index=self:getGroupBtnNodeID(btnGroupType)
return self.winlua:GetChildClonePositionByKey(index,key)
end
end

function UIMain:onLoadedJuanZhouBodyFinish()







end



function UIMain:setJuanZhouAni(flag)













end


function UIMain:openJuanZhou(flag)

















end

function UIMain:freshBottomArrow()




end

function UIMain:freshJuanzhouRaycast()










end

function UIMain:freshBottomBtns()





end



function UIMain:freshBtnChatArrow()
local ratate=self.chatWarp and 180 or 0
self.winlua:SetChildDOLocalRotate(self.btnChatArrow:getID(),Vector3(0,0,ratate),0.1)
end

function UIMain:freshChatShrinkHeight()
self.viewHeight=self.chatWarp and _chatWarpHeight or _chatShrinkHeight
self:doShrinkHeight()
self:freshBtnChatArrow()
end

function UIMain:doShrinkHeight()
local height=self.winlua:GetChildSizeDeltaY(self.chatContent:getID())
local viewHeight=self.viewHeight
if height>viewHeight then
self.winlua:SetChildDOSizeDelta(self.chatScrollView:getID(),Vector2(self.viewWidth,viewHeight),0.2)
else
self.winlua:SetChildDOSizeDelta(self.chatScrollView:getID(),Vector2(self.viewWidth,height),0.2)
end


self.winlua:SetChildDOAnchorPosY(self.chatContent:getID(),0,0)
end


function UIMain:onRecvMessage()
self:freshChatReddot()
end

function UIMain:onReadNewestMesg(channel,actorid)
self:freshChatReddot()
end

function UIMain:freshChatReddot()
local state=chatEmotModel.getChatWinEmotReddot()
self.chatEmoreddot:setActive(state)
self.chatEmoreddotIndex=self:doPunchRotation(self.widget,self.chatEmoreddot:getID(),self.chatEmoreddotIndex,state)
if state then
self.chatReddot:setActive(false)
self.chatReddotIndex=self:doPunchRotation(self.widget,self.chatReddot:getID(),self.chatReddotIndex,false)
return
end
local channels={CHAT_CHANNNEL.eWorld,CHAT_CHANNNEL.eXianmeng,CHAT_CHANNNEL.eKuafu,CHAT_CHANNNEL.ePrivate}

local num=0
for _,channelId in ipairs(channels)do
if chatCommonHelper.isShowChannel(channelId)and
chatControl.hasNewMesgByChannel(channelId)then
num=num+chatControl.getNewestMesgNumByChannel(channelId)
end
end
local reddot=num>0
if num>99 then
num='99+'
elseif num<=0 then
num=''
end
self.chatReddot:setActive(reddot)
self.numText:setText(num)
self.chatReddotIndex=self:doPunchRotation(self.widget,self.chatReddot:getID(),self.chatReddotIndex,reddot)
end

function UIMain:freshFriendReddot()
local reddot=friendController:hasReddot()
self.friendReddot:setActive(reddot)
self.friendReddotIndex=self:doPunchRotation(self.widget,self.friendReddot:getID(),self.friendReddotIndex,reddot)
end

function UIMain.refreshFriendReddot(class,sub_typo,last_flag,flag)
_this.friendReddot:setActive(flag)
_this.friendReddotIndex=_this:doPunchRotation(_this.widget,_this.friendReddot:getID(),_this.friendReddotIndex,flag)
end

function UIMain.refreshHeadSelectReddot(class,sub_typo,last_flag,flag)
local actorHeadWidget=_this.actorInfoWidget:GetChildWidgetBase(mActorInfoType.eActorHead)
if not flag then

flag=mailController:hasReddot()
end
actorHeadWidget:SetChildActive(3,flag)
_this.headReddotIndex=_this:doPunchRotation(actorHeadWidget,3,_this.headReddotIndex,flag)
end

function UIMain.freshEmailReddot()
local flag=UISettingModel:checkSelectHeadReddot()or mailController:hasReddot()
local actorHeadWidget=_this.actorInfoWidget:GetChildWidgetBase(mActorInfoType.eActorHead)
actorHeadWidget:SetChildActive(3,flag)
_this.headReddotIndex=_this:doPunchRotation(actorHeadWidget,3,_this.headReddotIndex,flag)


if UIManager:isActive('UIMain')and not UIManager:isActive('UIFuncStorageWin')and zongmenControl:checkShowFuncStorageWin()then
UIManager:refresh("UIFuncStorageWin")
end
end



function UIMain:initMesgEffect()








end


function UIMain:clearMesgEffect()



end


function UIMain:setContentBottom(ani)

local height=self.winlua:GetChildSizeDeltaY(self.chatContent:getID())
local viewHeight=self.viewHeight
self.winlua:SetStopChildScrollRect(self.chatScrollView:getID())
self.winlua:SetChildDOAnchorPosY(self.chatContent:getID(),0,ani and 0.2 or 0)
end


function UIMain:releaseObject(luaid)
self.chatCreater:recycleItemById(luaid)
end

function UIMain:onFinishChatCreatAction(assetName,guid,luaid,isInit)
if not isInit then
self:setContentBottom(true)
self.chatCreater:callChildFunc(luaid,'playAni')
end
end

function UIMain:releaseMainMesgPanel()
self.chatCreater:recycleAll()
chatControl.freshMainMesgPanel(MAIN_HOLD_TYPE.eMain,self.handler)
end


function UIMain:onReConnection()
self.chatCreater:recycleAll()
chatControl.freshMainMesgPanel(MAIN_HOLD_TYPE.eMain,self.handler)
end

function UIMain:onBottomArrow()



end

function UIMain:onBtnChatArrow()
self.chatWarp=not self.chatWarp
self:freshChatShrinkHeight()
end

function UIMain:onJuanzhouArrow()

end

function UIMain:onBtnMap()
if zongmenModel:getMountainId()==mapIdType.zhufeng then
mountainControl:loadAndswitchMapEx(mapIdType.lingshoudao,true)
else
mountainControl:loadAndswitchMapEx(mapIdType.zhufeng,true)
end

end

function UIMain:onBtnWorld()
if not systemModel.isOpen(SYSTEM_DEFINE.eWorld)then
UIManager.error("神州世界危险重重，请祖师先发展宗门")

return
end
if worldBlockModel:checkWorldEnterLimit(2)then
UIManager:showWindow("UIWorldMapWinEx",{showInfo=true,enter=function(index)
if not mainControl:isWaitSceneChange()then
worldController:enterWorld(index)
end
UIManager:closeWindow("UIWorldMapWinEx")
end})
else
if not mainControl:isWaitSceneChange()then
worldController:enterWorld(1)
end
end
end

function UIMain:checkStateAndSave()

self.showLimit=false
self.showFunc=false

if limitActivitiesController:getIsShowActList()then
self.showLimit=true
UIManager:invokeUIMethod('UILimitActStorageWin','onToggleIcon')
end

if simpleModeControl:getFuncStorageSimple()then
self.showFunc=true
UIManager:invokeUIMethod('UIFuncStorageWin','hindAndShowFuncList',false)
end
end

function UIMain:checkStateAndLeave()
if self.showLimit then
UIManager:invokeUIMethod('UILimitActStorageWin','onToggleIcon')
end
if self.showFunc then
UIManager:invokeUIMethod('UIFuncStorageWin','hindAndShowFuncList',true)
end

self.showLimit=false
self.showFunc=false
end

function UIMain:onBtnJieYu()
self:checkStateAndSave()

local btnList={
MAIN_BTNS_TYPE.eSubMoJie,
MAIN_BTNS_TYPE.eSubWorld,
MAIN_BTNS_TYPE.eSubXianJie,
MAIN_BTNS_TYPE.eSubXianYu,
MAIN_BTNS_TYPE.eSubZM,
}

local posVector2=self.btnJieYu:getChildScreenPointToLocalPointRectangle(-1)
local pos={posVector2.x-70,posVector2.y+123}

UIManager:showWindow("UIMainSubEnterPanelWin",{btnList=btnList,pos=pos,posType=2})
end

function UIMain:OnGMClick()
UIManager:showWindow('UIGMWin')
end

function UIMain:onBtnChat()
self:clearMesgEffect()
local channelId=chatControl.getAnyNewMesgChannel()or CHAT_CHANNNEL.eWorld
UIManager:showWindow('UIChatWin',{channelId=channelId})
end

function UIMain:onBtnFriend()
friendController:showMainUI()
end







function UIMain:onBtnRightArrow()
local isSimple=simpleModeControl:getRightSimple()
simpleModeControl:setRightSimple(not isSimple)
self:initRightPanel()
end

function UIMain.on_year_changed(newyear,isServer)
if _this==nil or _this.isClose then return end
_this:refreshZongMenAgeObj()
end

function UIMain.onZongMengLevelChange()
if _this==nil or _this.isClose then return end
_this:freshChatReddot()
end

function UIMain.onNewDay()
if _this==nil or _this.isClose then return end
_this:freshChatReddot()
_this:refreshWorldFlag()
end

function UIMain.on_building_event(etype,arg1,arg2)
if _this==nil or _this.isClose then return end
if etype==buildingEvent.zongmenLevelUp then
_this:refreshZongMenLevelObj()
_this:refreshActorHeadUp()
_this:refreshActorHeadReddot()

_this:refreshWorldFlag()

_this:leftPanel_checkTaskBtnSimple()
end
end

function UIMain:initHeadCostList()
self.headCost=UISettingModel:getHeadOrKuangCostList()
end

function UIMain:initEmotCostList()
self.emotCost=chatEmotModel:getEmotCostList()
end

function UIMain.on_item_changed(changeType,itemguid,itemid,lastcount,itemcount)
if _this==nil then
return
end
if _this.headCost[itemid]then
_this:refreshActorHeadReddot()
end
if _this.emotCost[itemid]~=nil then
_this:freshChatReddot()
end
end

function UIMain.onIconUnlock(iconTypes)
if _this==nil or _this.isClose then return end
_this:onIconRefresh(iconTypes)
end

function UIMain:onIconRefresh(openIconTypes)

local len=#openIconTypes
local btnGroupType=MAIN_ICON_GROUP_TYPE.eBottom
local iconTypes=mainConfig.getGroupIconTypeList(btnGroupType)
local flag=table.containsTableValue(iconTypes,openIconTypes)
if flag then
self:creatGroupBtns(btnGroupType)
self:doCloneMove(btnGroupType)


len=len-1
end

if len<=0 then return end

local btnGroupType=MAIN_ICON_GROUP_TYPE.eRight
local iconTypes=mainConfig.getGroupIconTypeList(btnGroupType)
local flag=table.containsTableValue(iconTypes,openIconTypes)
if flag then
self:creatGroupBtns(btnGroupType)
self:doCloneMove(btnGroupType)
self:initRightPanel(true)
end

local cacheTypes={ICON_TYPE.mainRecharge,ICON_TYPE.mainWelfare,ICON_TYPE.mainRiChang}
local flag=table.containsTableValue(openIconTypes,cacheTypes)
if flag then
self:freshSimpleBtnReddot()
end
end

function UIMain:onIconRefresh_btnGroup(btnGroupType)
self:creatGroupBtns(btnGroupType)
self:doCloneMove(btnGroupType)

if btnGroupType==MAIN_ICON_GROUP_TYPE.eRight then
self:initRightPanel(true)
self:freshSimpleBtnReddot()
end
end

function UIMain.on_money_init()
if _this==nil then return end
_this:refreshMoneyObj()
end

function UIMain.on_money_changed(moneyType,lastVal,val)
if _this==nil then return end

if moneyType==eMoneyType.mtExp then
_this:refreshZongMenLevelObj()
_this:refreshActorHeadUp()
_this:refreshActorHeadReddot()

end
if _this.moneyChangeLookup[moneyType]~=nil then
_this:refreshMoneyItem(nil,moneyType)
end
end

function UIMain.onDiscipleJJChange(discipleguid,old_jjlv,jingjielv,old_jjexp,jingjieexp,oldFight,newFight)
if zongmenModel:checkLevelUp()and zongmenModel:isBreakLevel()then
_this:refreshActorHeadUp()
end
end

function UIMain.onCloseUI(winName)







end

function UIMain.onZongMenFightChange(oldVal,fight)
if _this==nil then return end
_this:refreshZongMenFightObj()
end

function UIMain.onActorDataInit()
if _this==nil then return end
_this:refreshActorNameObj()
end

function UIMain.onSettingDataInit()
if _this==nil then return end
_this:refreshActorHeadObj()
_this:refreshZongMenNameObj()
end

function UIMain.onActorHeadChange()
if _this==nil then return end
_this:refreshActorHeadObj()
end

function UIMain.onActorNameChange()
if _this==nil then return end
_this:refreshActorNameObj()
end

function UIMain.onZongMenNameChange()
if _this==nil then return end
_this:refreshZongMenNameObj()
end


function UIMain.refreshTaskState()
if _this==nil then return end
_this:leftPanel_checkTaskBtnSimple()
end

function UIMain.onMountainChange(oldid,id)
_this:initMoneyList()
_this:refreshMoneyObj()

_this:onIconRefresh_btnGroup(MAIN_ICON_GROUP_TYPE.eBottom)
end


function UIMain:showEmergenciesPanel(tips)
local canShow=emergenciesModel:isInEventTime()
self.eventInfoPanel:setActive(canShow)
emergenciesControl:showEventPageEffect(canShow)
if not canShow then
self:setEventTips()
return
end
local eventId=emergenciesModel:getCurrentEventId()
local cfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,eventId)
self.eName=cfg.name

local endtime=emergenciesModel:getEndTime()
local currTime=timeHelper.getServerShortTime()
local dt=endtime-currTime
self.eventTime:setText(timeHelper.format_time_stamp11(dt))

self:setEventName()
end

function UIMain:setEventTime(dtime)
self.eventTime:setText(FMT.fmt('剩余：{0}',timeHelper.format_time_stamp11(dtime)))
end

function UIMain:setEventName()
local curr,max=emergenciesControl:getEventCount()
local str=self.eName
if curr and max then
str=FMT.fmt('{0}（{1}/{2}）',str,curr,max)
end
self.eventName:setText(str)
end

function UIMain:setEventTips(str)
self.eventTipsBg:setActive(str~=nil)
if str then
self.eventTipsTx:setText(str)
end
end

function UIMain:onEventInfoPanel()
emergenciesControl:moveCameraToEventPos()
end

function UIMain:showEventIcon()
local data=emergenciesControl:getSettlementData()
if data then
self.eventIcon:setActive(true)
local tweener=self.winlua:SetChildDOPunchRotation(self.eventIcon:getID(),Vector3(0,0,15),2,6,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
else
self.eventIcon:setActive(false)
end
end

function UIMain:onEventIcon()
local data=emergenciesControl:getSettlementData()
if data then
emergenciesControl:showSettlement(data)
self.eventIcon:setActive(false)
else
logErr('无突发事件结算数据')
end
end

function UIMain:refreshLevelIcon()


end

function UIMain:onLevelIcon()

end

function UIMain:showFastManagerIcon()

self.fastManagerBtn:setActive(false)
end

function UIMain:onFastManagerBtn()
UIManager:showWindow('UIXiaoDaoTongMainWin',{page=self.fastMarPage})
end

function UIMain:registerChatHandle()
if not self.isHandle then
self.isHandle=true
chatControl.registerMainHandler(MAIN_HOLD_TYPE.eMain,self.handler)
end
end

function UIMain:unregisterChatHandle()
if self.isHandle then
self.isHandle=false
chatControl.unregisterMainHandler(MAIN_HOLD_TYPE.eMain,self.handler)
end
end






function UIMain:doPunchRotation(widget,componentIndex,reddotIndex,isReddot)
if webGLHelper:isHidePunchAni()then return end
if isReddot then
if self.reddotTweenerList==nil then
self.reddotTweenerList={}
end
if not reddotIndex then
reddotIndex=#self.reddotTweenerList+1
end

if self.reddotTweenerList[reddotIndex]==nil then
widget:SetChildRotation(componentIndex,0,0,0)
local tweener=widget:SetChildDOPunchRotation(componentIndex,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweenerList[reddotIndex]={}
self.reddotTweenerList[reddotIndex].tweener=tweener
self.reddotTweenerList[reddotIndex].widget=widget
self.reddotTweenerList[reddotIndex].componentIndex=componentIndex
end

return reddotIndex
else
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return nil
end
if self.reddotTweenerList[reddotIndex]~=nil then
self.reddotTweenerList[reddotIndex].tweener:Complete()
self.reddotTweenerList[reddotIndex].tweener:Kill()
self.reddotTweenerList[reddotIndex]=nil
widget:SetChildRotation(componentIndex,0,0,0)
return nil
end
end
end


function UIMain:endAllReddotPunchRotation()
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return
end
for i,v in pairs(self.reddotTweenerList)do
if v~=nil then
v.tweener:Complete()
v.tweener:Kill()
local widget=v.widget
local componentIndex=v.componentIndex
widget:SetChildRotation(componentIndex,0,0,0)

self.reddotTweenerList[i]=nil
end
end
end

function UIMain:onZongMenTaskClick()
self:changeLeftSimple(leftSimpleState.task)
end

function UIMain:onZongMenBagClick()
self:changeLeftSimple(leftSimpleState.moneyDetail)
end

function UIMain:onZongMenStateClick()

self:changeLeftSimple(leftSimpleState.homeBuff)
end


function UIMain:changeLeftSimple(state,isInit)
self.leftSimple=simpleModeControl:getLeftSimple()
if self.leftSimple==state then

leftPanelTypeFun[state].closeFun()

self.leftSimple=leftSimpleState.hide
else

leftPanelTypeFun[self.leftSimple].closeFun()

self.leftSimple=state
leftPanelTypeFun[state].showFun(isInit)
end

simpleModeControl:setLeftSimple(self.leftSimple)
self:leftPanel_checkTaskBtnSimple()
self:leftPanel_checkMoneyDetailBtnSimple()
self:leftPanel_checkHomeBuffBtnSimple()

self:freshSimpleBtn()
end


function UIMain:initLeftSimpletate(state)
local lastState=self.leftSimple
self.leftSimple=state or simpleModeControl:getLeftSimple()

if lastState and lastState~=self.leftSimple then
leftPanelTypeFun[lastState].closeFun()
end
leftPanelTypeFun[self.leftSimple].showFun(true)

simpleModeControl:setLeftSimple(self.leftSimple)
self:leftPanel_checkTaskBtnSimple()
self:leftPanel_checkMoneyDetailBtnSimple()
self:leftPanel_checkHomeBuffBtnSimple()

self:freshSimpleBtn()
end


function UIMain:leftPanel_showTask(isInit)
local isInFort=zongmenControl:isMountid(mapIdType.fort)
if isInFort then
local state2=simpleModeControl:getFortLeftSimple()
if state2==leftFortSimpleState.task then
UIManager:invokeUIMethod("UITaskListWin","showTaskListPanel",isInit)
else
UIManager:invokeUIMethod("UIXianJieFortInfoWin","showInfoListPanel",isInit)
end
UIManager:invokeUIMethod("UIXianJieFortTaskbarWin","showBarPanel",isInit)
else
UIManager:invokeUIMethod("UITaskListWin","showTaskListPanel",isInit)
end
end


function UIMain:leftPanel_closeTask()
local isInFort=zongmenControl:isMountid(mapIdType.fort)
if isInFort then
local state2=simpleModeControl:getFortLeftSimple()
if state2==leftFortSimpleState.task then
UIManager:invokeUIMethod("UITaskListWin","hideTaskListPanel")
else
UIManager:invokeUIMethod("UIXianJieFortInfoWin","hideInfoListPanel")
end
UIManager:invokeUIMethod("UIXianJieFortTaskbarWin","hideBarPanel")
else
UIManager:invokeUIMethod("UITaskListWin","hideTaskListPanel")
end
end


function UIMain:leftPanel_checkTaskBtnSimple()
self.leftSimple=simpleModeControl:getLeftSimple()
local zmTaskWidget=self.actorInfoWidget:GetChildWidgetBase(mActorInfoType.eZMTask)
zmTaskWidget:SetChildActive(0,self.leftSimple==leftSimpleState.task)


local reddot
if self.leftSimple==leftSimpleState.task then

reddot=false
else

reddot=UIManager:invokeUIMethod('UITaskListWin','getAllTaskReddot')or false
end
zmTaskWidget:SetChildActive(1,reddot)

end


function UIMain:leftPanel_showMoneyDetail(isInit)
local win=UIManager:findActiveWindow('UIMoneyDetailWin')
if not win then
UIManager:showWindow('UIMoneyDetailWin',{isInit=isInit})
else
win:showMoneyDetailPanel()
end
end


function UIMain:leftPanel_closeMoneyDetail()
local win=UIManager:findActiveWindow('UIMoneyDetailWin')
if win then
win:hideMoneyDetailPanel(function()
UIManager:closeWindow('UIMoneyDetailWin')
end)
end
end


function UIMain:leftPanel_checkMoneyDetailBtnSimple()
self.leftSimple=simpleModeControl:getLeftSimple()
local zmBagWidget=self.actorInfoWidget:GetChildWidgetBase(mActorInfoType.eZMBag)
zmBagWidget:SetChildActive(0,self.leftSimple==leftSimpleState.moneyDetail)
end


function UIMain:leftPanel_showHomeBuff(isInit)
local win=UIManager:findActiveWindow('UIHomeBuffWin')
if not win then
homeBuffControl.showWindow(isInit)
homeBuffModel.readAllBuff()
else
win:showHomeBuffPanel()
end
end


function UIMain:leftPanel_closeHomeBuff()
local win=UIManager:findActiveWindow('UIHomeBuffWin')
if win then
win:hideHomeBuffPanel(function()
UIManager:closeWindow('UIHomeBuffWin')
end)
end
end


function UIMain:leftPanel_checkHomeBuffBtnSimple()
self.leftSimple=simpleModeControl:getLeftSimple()
local zmStateWidget=self.actorInfoWidget:GetChildWidgetBase(mActorInfoType.eZMState)
zmStateWidget:SetChildActive(0,self.leftSimple==leftSimpleState.homeBuff)
local reddot
if self.leftSimple==leftSimpleState.homeBuff then
reddot=false
else
reddot=prosperityModel:isCanUpLevel()
end

zmStateWidget:SetChildActive(1,reddot)
end

function UIMain:onProsperityChange()
self:leftPanel_checkHomeBuffBtnSimple()
end


function UIMain:onBtnChange_concise()

self:changeSimpleMode(false)
end

function UIMain:onBtnChange_normal()

self:changeSimpleMode(true)
end


function UIMain:changeSimpleMode(flag)
local oldflag=simpleModeControl:isSimple()
if oldflag==flag then return end
simpleModeControl:setSimple(flag)
if flag then


self:changeLeftSimple(leftSimpleState.hide)

self:initRightPanelDisable()

local win=UIManager:findActiveWindow('UILimitActStorageWin')
if win then
win:changeActListShow(false)
else
limitActivitiesController:setIsShowActList(false)
end

local win=UIManager:findActiveWindow('UIFuncStorageWin')
if win then
win:changeFuncListShow(false)
else
simpleModeControl:setFuncStorageSimple(false)
end
else


self:changeLeftSimple(leftSimpleState.task)

self:initRightPanelEnable()

local win=UIManager:findActiveWindow('UILimitActStorageWin')
if win then
win:changeActListShow(true)
else
limitActivitiesController:setIsShowActList(true)
end

local win=UIManager:findActiveWindow('UIFuncStorageWin')
if win then
win:changeFuncListShow(true)
else
simpleModeControl:setFuncStorageSimple(true)
end
end

self:freshSimpleBtn()
end


function UIMain:freshSimpleBtn()
local isConcise=simpleModeControl:isSimple()
self.btnChange["concise"]:setActive(isConcise)
self.btnChange["normal"]:setActive(not isConcise)
end


function UIMain:refreshWorldFlag()
local actList={}
local lp=limitActivitiesModel.getWorldMapLimitAct()
for lActID,Cfg in pairs(lp)do
local actInfo=limitActivitiesModel:getActInfo(lActID)
if actInfo and actInfo:checkOpen()and actInfo:checkDoing()and Cfg.flagImage then
self.worldActFlagImg:setSprite(globalABLookup.mainwin,Cfg.flagImage)
return
end
end
self.worldActFlagImg:setImageIcon("",false)
end

function UIMain.onLimitActStateChange(actID,actState)
local cfg=cfgHelper.get1(cfg_worldmaplimitactivityconfig_get,actID)
if cfg then
_this:refreshWorldFlag()
end
if actID==LIMIT_ACT_TYPE.eMojieSaiJi then
_this:refreshJieYuBtn()
end
end

function UIMain:refreshWorldEnable()


end

function UIMain:refreshJieYuBtn()
local isOpenXianJie=xianjieController:checkXianJieSystemOpen()
self.btnWorld:setActive(not isOpenXianJie)
self.btnJieYu:setActive(isOpenXianJie)
if isOpenXianJie then
local checkMoJie=xianjieModel:checkCurrentMoJieEnterTime()
self.btnJieYu1:setActive(not checkMoJie)
self.btnJieYu2:setActive(checkMoJie)
end
end

function UIMain:initRedPacket()
local subList=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eCaiShenJiaDao)
local list={}
for index,info in ipairs(subList)do

table.insert(list,info)

end
if#list>1 then
table.sort(list,function(a,b)
return a.start_time<b.start_time
end)
end
self.redpacketInfo_CSJD=list[1]

local sub_actList_xmhb=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eXianMengHongBao)
if#sub_actList_xmhb>0 then
self.redpacketInfo_XMHB=sub_actList_xmhb[1]
end
end

function UIMain:refreshRedPacket()
if self.redpacketInfo_CSJD or self.redpacketInfo_XMHB then
local count=0
if self.redpacketInfo_CSJD and self.redpacketInfo_CSJD.countGuildDataStatus then
local count_csjd=self.redpacketInfo_CSJD:countGuildDataStatus(eCSJDRedPacketStatus.eNormal)
count=count+count_csjd
end
if self.redpacketInfo_XMHB and self.redpacketInfo_XMHB.getGuildDataCanGetRedPacketCount then
local count_xmhb=self.redpacketInfo_XMHB:getGuildDataCanGetRedPacketCount()
count=count+count_xmhb
end

self.chatRedPacket:setActive(count>0)
else
self.chatRedPacket:setActive(false)
end
end

function UIMain.onSubActivityStateChange(actId,subType,subId,state)
if subType==SUB_ACTIVITY_TYPE.eCaiShenJiaDao then
_this:initRedPacket()
_this:refreshRedPacket()
end
end

function UIMain.onSubActivityOpen(actId,subType,subId,flag)
if subType==SUB_ACTIVITY_TYPE.eCaiShenJiaDao then
_this:initRedPacket()
_this:refreshRedPacket()
end
end

function UIMain.onCSJDGuildDataChange(actId,subType,subId,guid,reSort)
if reSort then
_this:refreshRedPacket()
end
end

function UIMain.onXMHBGuildDataChange(actId,subType,subId,guid,reSort)
if reSort then
_this:refreshRedPacket()
end
end