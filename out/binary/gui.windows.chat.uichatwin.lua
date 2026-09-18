







def_class("UIChatWin",UIWindowBase)









function UIChatWin:bindComponents()

self.arrow=UIImage.get(self,0)
self.bagEmotBtn=UIButton.get(self,1)
self.btnBattleField=UIButton.get(self,2)
self.btnIcon=UIButton.get(self,3)
self.btnJianwen=UIButton.get(self,4)
self.btnKuafu=UIButton.get(self,5)
self.btnMoGongBattleField=UIButton.get(self,6)
self.btnNewest=UIButton.get(self,7)
self.btnPrivate=UIButton.get(self,8)
self.btnSeasonZZSH=UIButton.get(self,9)
self.btnSend=UIButton.get(self,10)
self.btnsRoot=UIObject.get(self,11)
self.btnSytem=UIButton.get(self,12)
self.btnWorld=UIButton.get(self,13)
self.btnXianJie=UIButton.get(self,14)
self.btnXianmeng=UIButton.get(self,15)
self.Content=UIObject.get(self,16)
self.CSGUIScrollView=UIComboScrollView.get(self,17)
self.downBtn=UIButton.get(self,18)
self.downRoot=UIObject.get(self,19)
self.emoreddot=UIImage.get(self,20)
self.InputField=UIInputField.get(self,21)
self.InputNode=UIObject.get(self,22)
self.inputText=UIText.get(self,23)
self.left=UIObject.get(self,24)
self.menu_1=UIObject.get(self,25)
self.menu_10=UIObject.get(self,26)
self.menu_2=UIObject.get(self,27)
self.menu_3=UIObject.get(self,28)
self.menu_4=UIObject.get(self,29)
self.menu_5=UIObject.get(self,30)
self.menu_6=UIObject.get(self,31)
self.menu_7=UIObject.get(self,32)
self.menu_8=UIObject.get(self,33)
self.menu_9=UIObject.get(self,34)
self.menuList=UIObject.get(self,35)
self.menuSerttingBtn=UIButton.get(self,36)
self.menuSetting=UIObject.get(self,37)
self.msgRoot=UIObject.get(self,38)
self.newMsg=UIText.get(self,39)
self.newRoot=UIObject.get(self,40)
self.noInputNode=UIObject.get(self,41)
self.noInputTxt=UIText.get(self,42)
self.offLineTips=UIObject.get(self,43)
self.offLineTipsText=UIText.get(self,44)
self.privateRoot=UIObject.get(self,45)
self.privateTitle=UIText.get(self,46)
self.privot=UIObject.get(self,47)
self.raycast=UIObject.get(self,48)
self.redpacket=UIButton.get(self,49)
self.roleName=UIText.get(self,50)
self.rotateImage=UIObject.get(self,51)
self.ScrollView=UILoopListView.new(self,52)
self.selectBagEmot=UIObject.get(self,53)
self.speakerRaycast=UIObject.get(self,54)
self.topMsg=UIText.get(self,55)
self.topMsgRoot=UIObject.get(self,56)
self.topRoot=UIObject.get(self,57)
self.tybg=UIImage.get(self,58)
self.unReadBtn=UIButton.get(self,59)
self.warningBg=UIObject.get(self,60)
self.warningtext=UIText.get(self,61)
self.xmRedpacket=UIObject.get(self,62)

self.bagEmotBtn:setButtonClick(function()self:onBagEmotBtn()end)

self.btnBattleField:setButtonClick(function()self:onBtnBattleField()end)

self.btnIcon:setButtonClick(function()self:onBtnIcon()end)

self.btnJianwen:setButtonClick(function()self:onBtnJianwen()end)

self.btnKuafu:setButtonClick(function()self:onBtnKuafu()end)

self.btnMoGongBattleField:setButtonClick(function()self:onBtnMoGongBattleField()end)

self.btnNewest:setButtonClick(function()self:onBtnNewest()end)

self.btnPrivate:setButtonClick(function()self:onBtnPrivate()end)

self.btnSeasonZZSH:setButtonClick(function()self:onBtnSeasonZZSH()end)

self.btnSend:setButtonClick(function()self:onBtnSend()end)

self.btnSytem:setButtonClick(function()self:onBtnSytem()end)

self.btnWorld:setButtonClick(function()self:onBtnWorld()end)

self.btnXianJie:setButtonClick(function()self:onBtnXianJie()end)

self.btnXianmeng:setButtonClick(function()self:onBtnXianmeng()end)

self.downBtn:setButtonClick(function()self:onDownBtn()end)

self.menuSerttingBtn:setButtonClick(function()self:onMenuSerttingBtn()end)

self.redpacket:setButtonClick(function()self:onRedpacket()end)

self.ScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.unReadBtn:setButtonClick(function()self:onUnReadBtn()end)
self.menu={
self.menu_1,
self.menu_2,
self.menu_3,
self.menu_4,
self.menu_5,
self.menu_6,
self.menu_7,
self.menu_8,
self.menu_9,
self.menu_10,
}



end


function UIChatWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.bagEmotBtn);self.bagEmotBtn=nil;
_UIObject_release(self.btnBattleField);self.btnBattleField=nil;
_UIObject_release(self.btnIcon);self.btnIcon=nil;
_UIObject_release(self.btnJianwen);self.btnJianwen=nil;
_UIObject_release(self.btnKuafu);self.btnKuafu=nil;
_UIObject_release(self.btnMoGongBattleField);self.btnMoGongBattleField=nil;
_UIObject_release(self.btnNewest);self.btnNewest=nil;
_UIObject_release(self.btnPrivate);self.btnPrivate=nil;
_UIObject_release(self.btnSeasonZZSH);self.btnSeasonZZSH=nil;
_UIObject_release(self.btnSend);self.btnSend=nil;
_UIObject_release(self.btnsRoot);self.btnsRoot=nil;
_UIObject_release(self.btnSytem);self.btnSytem=nil;
_UIObject_release(self.btnWorld);self.btnWorld=nil;
_UIObject_release(self.btnXianJie);self.btnXianJie=nil;
_UIObject_release(self.btnXianmeng);self.btnXianmeng=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.CSGUIScrollView);self.CSGUIScrollView=nil;
_UIObject_release(self.downBtn);self.downBtn=nil;
_UIObject_release(self.downRoot);self.downRoot=nil;
_UIObject_release(self.emoreddot);self.emoreddot=nil;
_UIObject_release(self.InputField);self.InputField=nil;
_UIObject_release(self.InputNode);self.InputNode=nil;
_UIObject_release(self.inputText);self.inputText=nil;
_UIObject_release(self.left);self.left=nil;
_UIObject_release(self.menu_1);self.menu_1=nil;
_UIObject_release(self.menu_10);self.menu_10=nil;
_UIObject_release(self.menu_2);self.menu_2=nil;
_UIObject_release(self.menu_3);self.menu_3=nil;
_UIObject_release(self.menu_4);self.menu_4=nil;
_UIObject_release(self.menu_5);self.menu_5=nil;
_UIObject_release(self.menu_6);self.menu_6=nil;
_UIObject_release(self.menu_7);self.menu_7=nil;
_UIObject_release(self.menu_8);self.menu_8=nil;
_UIObject_release(self.menu_9);self.menu_9=nil;
_UIObject_release(self.menuList);self.menuList=nil;
_UIObject_release(self.menuSerttingBtn);self.menuSerttingBtn=nil;
_UIObject_release(self.menuSetting);self.menuSetting=nil;
_UIObject_release(self.msgRoot);self.msgRoot=nil;
_UIObject_release(self.newMsg);self.newMsg=nil;
_UIObject_release(self.newRoot);self.newRoot=nil;
_UIObject_release(self.noInputNode);self.noInputNode=nil;
_UIObject_release(self.noInputTxt);self.noInputTxt=nil;
_UIObject_release(self.offLineTips);self.offLineTips=nil;
_UIObject_release(self.offLineTipsText);self.offLineTipsText=nil;
_UIObject_release(self.privateRoot);self.privateRoot=nil;
_UIObject_release(self.privateTitle);self.privateTitle=nil;
_UIObject_release(self.privot);self.privot=nil;
_UIObject_release(self.raycast);self.raycast=nil;
_UIObject_release(self.redpacket);self.redpacket=nil;
_UIObject_release(self.roleName);self.roleName=nil;
_UIObject_release(self.rotateImage);self.rotateImage=nil;
self.ScrollView:deleteSelf();self.ScrollView=nil;
_UIObject_release(self.selectBagEmot);self.selectBagEmot=nil;
_UIObject_release(self.speakerRaycast);self.speakerRaycast=nil;
_UIObject_release(self.topMsg);self.topMsg=nil;
_UIObject_release(self.topMsgRoot);self.topMsgRoot=nil;
_UIObject_release(self.topRoot);self.topRoot=nil;
_UIObject_release(self.tybg);self.tybg=nil;
_UIObject_release(self.unReadBtn);self.unReadBtn=nil;
_UIObject_release(self.warningBg);self.warningBg=nil;
_UIObject_release(self.warningtext);self.warningtext=nil;
_UIObject_release(self.xmRedpacket);self.xmRedpacket=nil;
self.menu=nil;
end

















local _subItemIndex=
{
cmpShowRoot=0,
cmpOpRoot=1,
cmpHead=2,
cmpNameText=3,
cmpOnline=4,
cmpReddot=5,
cmpOpenArrowBtn=6,
cmpCloseArrowBtn=7,
cmpTopBtn=8,
cmpDeleteBtn=9,
cmpSelect=10,
cmpMsgCount=11,
cmpBg=12,
}

local _btnsIdx=
{
[CHAT_CHANNNEL.eSystem]=1,
[CHAT_CHANNNEL.eJianwen]=2,
[CHAT_CHANNNEL.eWorld]=3,
[CHAT_CHANNNEL.eKuafu]=4,
[CHAT_CHANNNEL.eXianmeng]=5,
[CHAT_CHANNNEL.ePrivate]=6,
[CHAT_CHANNNEL.eBattleField]=7,
[CHAT_CHANNNEL.eMoGong]=8,
[CHAT_CHANNNEL.eSeasonZZSH]=9,
[CHAT_CHANNNEL.eXianJie]=10,
}
local _channels={CHAT_CHANNNEL.eXianJie,CHAT_CHANNNEL.eWorld,CHAT_CHANNNEL.eBattleField,CHAT_CHANNNEL.eSeasonZZSH,CHAT_CHANNNEL.eMoGong,CHAT_CHANNNEL.eXianmeng,CHAT_CHANNNEL.eKuafu,CHAT_CHANNNEL.ePrivate}
local _channelsLookup={}
for i,v in ipairs(_channels)do
_channelsLookup[v]=true
end
local _menuBody=2017
local _menu_slot_name='button_dytab'


local _sortChannelList=
{
CHAT_CHANNNEL.eBattleField,
CHAT_CHANNNEL.eSeasonZZSH,
CHAT_CHANNNEL.eXianJie,
CHAT_CHANNNEL.eKuafu,
CHAT_CHANNNEL.eWorld,
CHAT_CHANNNEL.eXianmeng,
CHAT_CHANNNEL.ePrivate,
}

local Desc=
{
"刷屏广告/礼包码广告/添加微信/私聊买卖账号均不可信，谨防上当受骗",
"刷屏廣告/禮包碼廣告/添加LINE/私聊買賣帳號均不可信,谨防上當受騙",
}

local _scrollSizeX=490


local _maxY=630
local _topY=38
local _offlineY=30
local _this=nil

function UIChatWin:onLoaded(...)
self:bindComponents()
_this=self
webGLHelper:uiWindowCloseCamera(self.tybg)

self.handlelist={}
self.sendguid=0
self.channelNewest={}
self.loopListView=self.winlua:GetChildUILoopListView(self.ScrollView:getID())
self.loopListViewCmp=self.winlua:GetChildLoopListView2(self.ScrollView:getID())
self:addNotify(notifyConfig.onRecvMessage,function(...)self:onRecvMessage(...)end)
self.showModel={}
self.showMenuSetting=false

self.btnWidgetList={}
local btnWidgetList=self.btnWidgetList
btnWidgetList[CHAT_CHANNNEL.eSystem]=self.btnSytem
btnWidgetList[CHAT_CHANNNEL.eJianwen]=self.btnJianwen
btnWidgetList[CHAT_CHANNNEL.eKuafu]=self.btnKuafu
btnWidgetList[CHAT_CHANNNEL.eWorld]=self.btnWorld
btnWidgetList[CHAT_CHANNNEL.eXianmeng]=self.btnXianmeng
btnWidgetList[CHAT_CHANNNEL.ePrivate]=self.btnPrivate
btnWidgetList[CHAT_CHANNNEL.eBattleField]=self.btnBattleField
btnWidgetList[CHAT_CHANNNEL.eMoGong]=self.btnMoGongBattleField
btnWidgetList[CHAT_CHANNNEL.eSeasonZZSH]=self.btnSeasonZZSH
btnWidgetList[CHAT_CHANNNEL.eXianJie]=self.btnXianJie

local _mainClickAction=function(...)self:mainClickAction(...)end
local _subClickAction=function(...)self:subClickAction(...)end
local _mainCreateAction=function(...)self:mainCreateAction(...)end
local _subCreateAction=function(...)self:subCreateAction(...)end
local _onExpandAction=function(...)self:onExpandAction(...)end
self.CSGUIScrollView:setAction(_mainClickAction,_subClickAction,_mainCreateAction,_subCreateAction,_onExpandAction)

self.selectActorInfo=nil
self.linkTable={}
self.linkNum=0
self.opActorId=nil
self.privateConfig={}
local privateConfig=self.privateConfig
privateConfig[CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent]={
name='最近联系人',
freshfunc=self.fillRecentData,
list=function()
return chatRecentModel.getRecentList(true)
end,
}
privateConfig[CHAT_PRIVATE_PLAYER_FROM_TYPE.eFriend]={
name='我的仙友',
freshfunc=self.fillFriendData,
list=chatFriendModel.getlist,
}
self.actorsData={}
self.actorsCacheData={}
self.isChangeActorCnt={}
self.isChangeActorIdx={}
self:initActorsData()
self.CSGUIScrollView:createMainGrids(#privateConfig,1,true)
self.chatIdx={}
local chatIdx=self.chatIdx
chatIdx[1]=CHAT_CHANNNEL.eSystem
chatIdx[2]=CHAT_CHANNNEL.eJianwen
chatIdx[3]=CHAT_CHANNNEL.eWorld
chatIdx[4]=CHAT_CHANNNEL.eKuafu
chatIdx[5]=CHAT_CHANNNEL.eXianmeng
chatIdx[6]=CHAT_CHANNNEL.ePrivate
chatIdx[7]=CHAT_CHANNNEL.eBattleField
chatIdx[8]=CHAT_CHANNNEL.eMoGong
chatIdx[9]=CHAT_CHANNNEL.eSeasonZZSH
chatIdx[10]=CHAT_CHANNNEL.eXianJie
self.loopListView:SetAction(function(...)
self:onFreshListView(...)
end,function(...)
self:onStartView(...)
end)
self.winlua:SetupMonoEvent(true,false,false,false)
self.mesgWin={}
self.msgIDLookup={}
self:closeReadPanel(false)
self:freshMsgPanelTopRootVis(false)
self:freshOffLineTipsVis(false)
self:freshTopMsgVis(false)
self.unReadVis=false
self.unReadBtn:setActive(false)
self.downBtn:setActive(true)

self:addNotify(notifyConfig.closeUI,function(...)self:onCloseUI(...)end)
self.arrow:setSprite(globalABLookup.layoutsprite,'button_tyduoxiangjiantou_2')

if webGLHelper:isNeedAdaption()then
local offset=50
local h=self.privateRoot:getChildSizeDeltaY()
h=h-offset*2
self.privateRoot:setChildSizeDeltaEx(3,0,h)
self.privot:setChildAnchoredPosition3D(Vector3.New(0,-offset,0))
end
local isGuoFu=pfwindowslController:checkIsGameVersion_guofu()
local curDesc=Desc[1]
if not isGuoFu then
curDesc=Desc[2]
end

self.warningtext:setText(curDesc)
self:addNotify(notifyConfig.onCSJDGuildDataChange,self.onCSJDGuildDataChange)
self:addNotify(notifyConfig.onXMHBGuildDataChange,self.onXMHBGuildDataChange)
self:addNotify(notifyConfig.onSubActivityStateChange,self.onSubActivityStateChange)
self:addProNotify(247,31,self.on_247_31)
self:initRedPacket()
end

function UIChatWin:__delete()
webGLHelper:uiWindowShowCamera()

self:recycleViewItem()
self:unregChatHandle(self.channelId)

self.loopListView:SetAction(nil,nil)
self.loopListView=nil

self:endAllReddotPunchRotation()

self:unbindComponents()
_this=nil

self.sendguid=0
self.selectActorInfo=nil
UIManager:closeWindow('UIFriendInfoWin')
self:stopRecord()
end

function UIChatWin:onShow(argtable,afterOnloaded)
self.argtable=argtable
if argtable and argtable.fixedHeight then
local rect=self.left:getGameObject():GetComponent(typeof(RectTransform))
rect.anchorMax=Vector2(1,0.5)
rect.anchorMin=Vector2(0,0.5)
rect.sizeDelta=Vector2(rect.sizeDelta.x,argtable.fixedHeight);
end
_maxY=self.winlua:GetChildRectHeight(self.msgRoot:getID())
self:onHandleArgs(afterOnloaded)
self:refreshRedPacketShow()
end

function UIChatWin:onStartView()
self.isStart=true
self:onHandleArgs(true)
end

function UIChatWin:onHandleArgs(afterOnloaded)
if not self.isStart then return end
local argtable=self.argtable
local defaultChannelId=chatModel:getLastChannel()
local channelId
local actorInfo
local formType
if argtable then
channelId=argtable.channelId or channelId
if self:isPrivateChannel(channelId)and argtable.actorInfo then
actorInfo=argtable.actorInfo
formType=argtable.formType
chatRecentModel.setRecentInfo(actorInfo)
end
end
channelId=channelId or defaultChannelId
if not channelId or not chatCommonHelper.isShowChannel(channelId)then

local isSetChannelId=false
for i,v in ipairs(_sortChannelList)do
if chatCommonHelper.isShowChannel(v)and
chatControl.hasNewMesgByChannel(v)then
channelId=v
isSetChannelId=true
break
end
end

if not isSetChannelId then

channelId=CHAT_CHANNNEL.eWorld
end
end
self.bestChannel=channelId

self:onSetChannel(channelId)
self:initPrivatePlayer(actorInfo,formType)
if afterOnloaded then
self:playBtnEnterAni()
end


chatModel.checkLiuYanActor()

self:freshEmoReddot()
end


function UIChatWin:selectBestChannel(argtable)
if self.bestChannel==nil then
self:onShow(argtable)
end
end

function UIChatWin:onHide()
end






function UIChatWin:isUnlockBtn(channelId)
return chatCommonHelper.isShowChannel(channelId)
end

function UIChatWin:freshBtns()
for channelId,v in pairs(self.btnWidgetList)do
local active=self:isUnlockBtn(channelId)
v:setActive(active)
if active then
self:freshBtnReddot(channelId)
end
end

self:freshSelectBtns()
end

function UIChatWin:onLoadedModel(i)
self.showModel[i]=true
self:freshSingleSelectBtn(i)
end


function UIChatWin:playBtnEnterAni()
self.menuList:setChildCanvasGroupAlpha(0)
self.btnsRoot:setChildCanvasGroupAlpha(0)


local func=function()
for i,v in pairs(self.menu)do
local channelId=self.chatIdx[i]
local active=self:isUnlockBtn(channelId)
local anim=v
anim:setActive(active)
if active then
anim:setActive(true)
anim:setChildUIModelShowTarget(_menuBody,1,{},eAnimationID.common_window_enter,false,false,0,function()
self.showModel[i]=true
self:freshSingleSelectBtn(i)
end)
end
end
end
func()

local func1=function()
self.menuList:setChildCanvasGroupDOFade(1,1)
self.btnsRoot:setChildCanvasGroupDOFade(1,1)
end
self:delayDo(0.4,func1)
end


function UIChatWin:freshSelectBtns()
for i,v in ipairs(self.menu)do
self:freshSingleSelectBtn(i)
end
end

function UIChatWin:freshSingleSelectBtn(i)
local channelId=self.chatIdx[i]
local active=self:isUnlockBtn(channelId)
if not active then return end
local idx=_btnsIdx[self.channelId]
local isSelect=i==idx
if not self.showModel[i]then return end
local v=self.menu[i]
self.winlua:SetChildUIModelShowSlotAttachment(v:getID(),_menu_slot_name,isSelect and'button_dytab_2'or'button_dytab_1')
end


function UIChatWin:freshBtnReddot(channelId)
self:freshChannelReddot(channelId)
if self:isPrivateChannel(channelId)then

self:freshMainItemReddot()

self:freshAllSubItemParticlInfo(self.formType)
end
end

function UIChatWin:freshChannelReddot(channelId)
local isUnlockBtn=self:isUnlockBtn(channelId)
local needShow=_channelsLookup[channelId]or false
local flag=needShow and isUnlockBtn and chatControl.hasNewMesgByChannel(channelId)or false
local luaCmp=self.btnWidgetList[channelId]
local widget=self.winlua:GetChildWidgetBase(luaCmp:getID())
local num=chatCommonHelper.isShowChannel(channelId)and
chatControl.getNewestMesgNumByChannel(channelId)or 0
local reddot=flag and num>0
if num>99 then
num='99+'
elseif num<=0 then
num=''
end
widget:SetChildActive(0,reddot)
widget:SetChildText(1,num)
if self.channelReddotList==nil then self.channelReddotList={}end
self.channelReddotList[channelId]=self:doPunchRotation(widget,0,self.channelReddotList[channelId],reddot)
end

function UIChatWin:playBtnClickAni(channelId)
local idx=_btnsIdx[channelId]
local anim=self.menu[idx]
if self.showModel[idx]then
anim:setChildUIModelShowTarget(_menuBody,1,{},eAnimationID.common_window_dianji)
end
end





function UIChatWin:setScrollViewSize()
end


function UIChatWin:freshMesgListData()
local channelId=self.channelId
local actorId=self.selectActorInfo and self.selectActorInfo.actorId or nil
local mesglist=chatControl.getTotalInfoList(channelId,actorId)or{}
self.mesglist=mesglist
end


function UIChatWin:freshMesgPanel()
self:recycleViewItem()

self:freshMesgListData()

local mesglist=self.mesglist
local len=#mesglist
local prefablist={}
local itemidlist={}
for i,v in ipairs(mesglist)do
local chatInfo=v
local msgID=chatInfo.msgID
local compName=chatConfig.getCompName(chatInfo)
if compName==nil then
loggerUtil.logErrFMT('compName不能为空值：{0}',tostring(chatInfo.mesg))
end
prefablist[#prefablist+1]=compName
itemidlist[#itemidlist+1]=msgID
end
self.loopListView:InitDataList(len,prefablist,itemidlist,nil,nil)
self.loopListView:JumpNewestIndex()
self.canKeepPos=false
self:onRectChanged()
if self.delayKeepTimer then
self:stopTimerByID(self.delayKeepTimer)
end
self.delayKeepTimer=self:delayDo(1,function()
self.canKeepPos=true
end)
end


function UIChatWin:isKeepPos()
if self.canKeepPos then
local y=self.oldY or self:getPosY()
local scroll_sizeY=_maxY-y
local content_sizeY=self.winlua:GetChildSizeDeltaY(self.Content:getID())
local pos=self.winlua:GetChildAnchoredPosition(self.Content:getID())
local y=pos.y
local top=content_sizeY-y-scroll_sizeY
return top>180
end
return false
end


function UIChatWin:jumpMsgIndex(index)
self.loopListView:JumpIndex(index)
end


function UIChatWin:jumpMsgNewestIndex()
self.loopListView:JumpNewestIndex()
end


function UIChatWin:onInsertMesgList(index,chatInfoList)
local compNameList={}
local msgIDList={}
self:freshMesgListData()
for i,chatInfo in ipairs(chatInfoList)do
local msgID=chatInfo.msgID
if not self.msgIDLookup[msgID]then
local compName=chatConfig.getCompName(chatInfo)
compNameList[#compNameList+1]=compName
msgIDList[#msgIDList+1]=msgID
end
end
self.loopListView:InsertItemList(index,#compNameList,compNameList,msgIDList,nil,nil)
self:onRectChanged()
end

function UIChatWin:onAddMesgList(chatInfoList)
local prefabNamelist={}
local msgIDlist={}
local len=0
for i,chatInfo in ipairs(chatInfoList)do
local msgID=chatInfo.msgID
if not self.msgIDLookup[msgID]then
self.msgIDLookup[msgID]=true
prefabNamelist[#prefabNamelist+1]=chatConfig.getCompName(chatInfo)
msgIDlist[#msgIDlist+1]=msgID
len=len+1
end
end
self.loopListView:AddItemList(len,prefabNamelist,msgIDlist,nil,nil)

end


function UIChatWin:onDeleteMesgListByIndex(channelId,indexlist)
if channelId~=self.channelId then return end
if self:isPrivateChannel(channelId)then

else
self.loopListView:DeleteItemListByDataIndex(indexlist)
end
self:onRectChanged()

end


function UIChatWin:onDeleteMesgListByMsgID(channelId,idlist)
if channelId~=self.channelId then return end
if self:isPrivateChannel(channelId)then

else
self.loopListView:DeleteItemListByItemId(idlist)
end
self:onRectChanged()

end


function UIChatWin:onRecvPublicMessageList(channelId,chatInfoList)
if chatInfoList.isTop then

end
self:freshBtnReddot(channelId)

self:freshChannelReddot(channelId)

if channelId~=self.channelId then return end
if chatInfoList.isTop then
self:freshMesgPanel()
return
end

self:freshMesgListData()

local prefabNamelist={}
local msgIDlist={}
local len=0
for i,chatInfo in ipairs(chatInfoList)do
local msgID=chatInfo.msgID
if not self.msgIDLookup[msgID]then
self.msgIDLookup[msgID]=true
prefabNamelist[#prefabNamelist+1]=chatConfig.getCompName(chatInfo)
msgIDlist[#msgIDlist+1]=msgID
len=len+1
end
end
self.loopListView:AddItemList(len,prefabNamelist,msgIDlist,nil,nil)
local toBottom=not self:isKeepPos()
if toBottom then
self:jumpMsgNewestIndex()
self.channelNewest[channelId]=false
else
self.channelNewest[channelId]=true
end

self:onRectChanged()
end


function UIChatWin:onRecvPublicMessage(channelId,chatInfo,actorId)

self:freshBtnReddot(channelId)

self:freshChannelReddot(channelId)

if channelId~=self.channelId then return end
if self:isPrivateChannel(channelId)and
(self.selectActorInfo==nil or not mathHelper.compareInt64(actorId,self.selectActorInfo.actorId))then
return
end

local msgID=chatInfo.msgID
if self.msgIDLookup[msgID]then return end
self.msgIDLookup[msgID]=true
self:freshMesgListData()
local compName=chatConfig.getCompName(chatInfo)
local toBottom=not self:isKeepPos()
self.loopListView:AddItem(compName,msgID,0,'',toBottom)
if toBottom then
self.channelNewest[channelId]=false
else
self.channelNewest[channelId]=true
end

self:onRectChanged()
end



function UIChatWin:createLuaObject(index,widget)
local chatInfo=self.mesglist[index]
local compName=chatConfig.getCompName(chatInfo)
local luaObject=UICloneObject.get(compName)
local msgID=chatInfo.msgID
self.msgIDLookup[msgID]=true
self.mesgWin[index]=luaObject
luaObject:setWidget(widget)
luaObject:onLoaded()
return luaObject
end

function UIChatWin:onFreshListView(index,widget)
index=index+1
local chatInfo=self.mesglist[index]
local luaObject=self.mesgWin[index]


if luaObject then
UICloneObject.release(luaObject)
end
luaObject=self:createLuaObject(index,widget)
local func=function()
luaObject:onShow({chatInfo=chatInfo,index=index})
end
xpcall(func,function(err)
local compName=chatConfig.getCompName(chatInfo)
logErr('UIChatWin onFreshList err:',err,chatInfo.mesg,compName)
end)
end

function UIChatWin:recycleViewItem()
for _,luaObject in pairs(self.mesgWin or{})do
UICloneObject.release(luaObject)
end
self.mesgWin={}
self.msgIDLookup={}
end


function UIChatWin:freshUnReadInfo()
local channelId=self.channelId
local vis=self.channelNewest[channelId]
if self.unReadVis~=vis then
self.unReadVis=vis
self.unReadBtn:setActive(vis)
self.downBtn:setActive(not vis)
end
end




function UIChatWin:onSetChannel(channelId)
chatModel:setLastChannel(channelId)
self:freshChannel(channelId)
end


function UIChatWin:freshChannel(channelId)
if self.channelId==channelId then return end
local oldChannel=self.channelId

self.channelId=channelId

self:playBtnClickAni(channelId)


self:showNoReadPanel()

self:regChatHandle(oldChannel,channelId)


local isPrivate=self:isPrivateChannel(channelId)
if isPrivate then
self:initActorsData()
end


self:showPrivate(isPrivate)


local isCanSend=true
local cantTips=''
if channelId==CHAT_CHANNNEL.eSystem or channelId==CHAT_CHANNNEL.eJianwen then
isCanSend=false
cantTips='当前频道不可聊天，请切换到其他频道'
elseif channelId==CHAT_CHANNNEL.eXianmeng then
if not xianmengModel:hasXM()then
isCanSend=false
cantTips='需要先加入一个仙盟'
end
end
self.noInputNode:setActive(not isCanSend)
self.noInputTxt:setText(cantTips)
self.InputNode:setActive(isCanSend)
self.warningBg:setActive(isCanSend)
self.warningBgVis=isCanSend
if verifyManager:isHideChatWarning()then
self.warningBg:setActive(false)
end


self:freshBtns()


if not isPrivate then
self:setPlayer(nil)
self:freshMesgPanelCommonInfo()
self:freshMesgPanel()
else
self:freshMesgPanel()

self:freshScrollViewRect()
end

self:refreshRedPacketBtn()
end




function UIChatWin:getSelectActorName()
return self.selectActorInfo and self.selectActorInfo.actorName or nil
end


function UIChatWin:showNoReadPanel()
local channelId=self.channelId
local selectPlayer=self.selectActorInfo
local isPrivate=self:isPrivateChannel(channelId)
local num=0
local actorId

if isPrivate and selectPlayer==nil then
self:openReadPanel(false)
return
end
if isPrivate and selectPlayer then
actorId=selectPlayer.actorId
end
local num=chatControl.getNewestMesgNumByChannel(channelId,actorId)
local readIndex=chatControl.getReadIdx(channelId,actorId)
self.readIndex=readIndex
self:openReadPanel(num>10)
self.newMsg:setText(FMT.fmt('{0}条新消息',num))
end


function UIChatWin:openReadPanel(flag)
if flag~=self.openReadFlag then
self.openReadFlag=flag
local endVal=flag and 0 or 160
self.winlua:SetChildDOLocalMoveX(self.newRoot:getID(),endVal,0.5)
end
end


function UIChatWin:closeReadPanel(flag)
self.openReadFlag=flag
local endVal=flag and 0 or 160
self.winlua:SetChildLocalPosX(self.newRoot:getID(),endVal)
end





function UIChatWin:getLink()
for name,link in pairs(self.linkTable)do
return name,link
end
end


function UIChatWin:doPunchRotation(widget,componentIndex,reddotIndex,isReddot)
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


function UIChatWin:endAllReddotPunchRotation()
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





function UIChatWin:onRecvMessage(channelId)
self:freshBtnReddot(channelId)
end

function UIChatWin:onBtnSytem()
self.bestChannel=nil
self:onSetChannel(CHAT_CHANNNEL.eSystem)
end

function UIChatWin:onBtnJianwen()
self.bestChannel=nil
self:onSetChannel(CHAT_CHANNNEL.eJianwen)
end

function UIChatWin:onBtnBattleField()
self.bestChannel=nil
self:onSetChannel(CHAT_CHANNNEL.eBattleField)
end

function UIChatWin:onBtnSeasonZZSH()
self.bestChannel=nil
self:onSetChannel(CHAT_CHANNNEL.eSeasonZZSH)
end

function UIChatWin:onBtnMoGongBattleField()
self.bestChannel=nil
self:onSetChannel(CHAT_CHANNNEL.eMoGong)
end

function UIChatWin:onBtnWorld()
self.bestChannel=nil
self:onSetChannel(CHAT_CHANNNEL.eWorld)
end

function UIChatWin:onBtnKuafu()
self.bestChannel=nil
self:onSetChannel(CHAT_CHANNNEL.eKuafu)
end

function UIChatWin:onBtnXianmeng()
self.bestChannel=nil
self:onSetChannel(CHAT_CHANNNEL.eXianmeng)
end

function UIChatWin:onBtnPrivate()
self.bestChannel=nil
self:onSetChannel(CHAT_CHANNNEL.ePrivate)
self:initPrivatePlayer()
end

function UIChatWin:onBtnXianmeng()
self.bestChannel=nil
self:onSetChannel(CHAT_CHANNNEL.eXianmeng)
end

function UIChatWin:onBtnXianJie()
self.bestChannel=nil
self:onSetChannel(CHAT_CHANNNEL.eXianJie)
end

function UIChatWin:onBtnSend()

local mesg=self:getInputMesg()


























if not mesg or mesg==''then return end
if pfCommonHelper:isRunPC()or pfCommonHelper:isRunUWP()then
local fromType,to_PrivatePlayerData
if chatModel.channelId==CHAT_CHANNNEL.ePrivate then
fromType,to_PrivatePlayerData=self.selectHandler:getNowActorInfo()
if to_PrivatePlayerData==nil then
UIManager.error('尚未选择聊天对象')
return
end
end
platformSDK:reqMsgSecCheck(2,mesg,function(reContent)
if reContent then
self:sendMesg(reContent)
else
UIManager.error('含有敏感字符')
end
end,to_PrivatePlayerData)
else
platformSDK:reqMsgSecCheck(2,mesg,function(reContent)
if reContent then
self:sendMesg(reContent)
else
UIManager.error('含有敏感字符')
end
end)
end
end


function UIChatWin:onBtnNewest()
self:openReadPanel(false)
self:jumpMsgIndex(self.readIndex)
end

function UIChatWin:onUnReadBtn()
local channelId=self.channelId
self:jumpMsgNewestIndex()
self.channelNewest[channelId]=nil
self:freshUnReadInfo()
end

function UIChatWin:onDownBtn()
local channelId=self.channelId
self:jumpMsgNewestIndex()
self.channelNewest[channelId]=nil
self:freshUnReadInfo()
end

function UIChatWin:onMenuSerttingBtn()
UIManager:showWindow('UIChatMesgFilterWin')
end

function UIChatWin:getInputMesg()
local mesg=self.InputField:getInputFieldValue()
mesg=string.removeHtmlTag(mesg)
return mesg
end


function UIChatWin:addMesg(typo,addInfo)
local mesg=self.InputField:getInputFieldValue()
local linkNum=self.linkNum
local isEmot=typo==CHAT_DECODE_TYPE.eEmot

if isEmot then
mesg=FMT.fmt('{0}{1}',mesg,addInfo)
else
local key=addInfo[1]
local val=addInfo[2]
key=FMT.fmt('[{0}]',key)
if linkNum>0 then
local key1,val1=self:getLink()
mesg=string.replace(mesg,key1,key)
self.linkTable={}
self.linkNum=0
linkNum=0
else
mesg=FMT.fmt('{0}{1}',mesg,key)
end
self.linkTable[key]=val
linkNum=self.linkNum+1
end

if not chatCommonHelper.checkMesgLen(mesg)then
UIManager.error('字数超过限制')
return
end

if not isEmot and linkNum>1 then
UIManager.error('超链接不能超过一个')
return
end

if not isEmot then
self.linkNum=self.linkNum+1
end
self.InputField:setInputFieldValue(mesg)
end


function UIChatWin:sendMesg(mesg)
if mesg==''then return end
local channelId=self.selectHandler:getNowChannel()
mesg=chatLinkHelper.replaceLink(mesg,self.linkTable)
if houtaiModel:isNoChatting()then
UIManager.error('功能维护中')
return
end
if channelId==CHAT_CHANNNEL.eSystem then
UIManager.error('系统频道不可发言')
elseif channelId==CHAT_CHANNNEL.eJianwen then
UIManager.error('见闻频道不可发言')
elseif self:isPrivateChannel(channelId)then
local fromType,actorInfo=self.selectHandler:getNowActorInfo()
if actorInfo==nil then
UIManager.error('尚未选择聊天对象')
return
end
local actorId=actorInfo.actorId

local black=friendModel:getFromList(eFriendDataType.eBlack,actorId)
if black then
UIManager.error("对方在黑名单中")
return
end
local sendguid=chatControl.reqPrivateMesg(fromType,actorId,mesg,actorInfo.serverId)
if chatCommonHelper.canNeedShowInput(mesg)then
if sendguid then
self.sendguid=sendguid
end
end
else
local sendguid=chatControl.reqPublicMesg(channelId,mesg)
if chatCommonHelper.canNeedShowInput(mesg)then
if sendguid then
self.sendguid=sendguid
end
end
end
end

function UIChatWin:onReadNewestMesg(channelId,actorId)
if channelId==CHAT_CHANNNEL.eNone then return end
self:freshBtnReddot(channelId)
end


function UIChatWin:clearInput(sendguid)
if self.sendguid==sendguid then
self.InputField:setInputFieldValue('')
self.linkNum=0
self.linkTable={}
end
end

function UIChatWin:onBtnIcon()
local lPos=self.btnIcon:getChildScreenPointToLocalPointRectangle()
local rootTrans=self.btnIcon:getTransform()
local itemSize=rootTrans.sizeDelta
local itemPivot=rootTrans.pivot
local offsetX=-(itemPivot.x-0.5)*itemSize.x
local offsetY=-(itemPivot.y-1)*itemSize.y
local rootPosX=lPos.x+offsetX
local rootPosY=lPos.y+offsetY
UIManager:showWindow('UIChatEmotWin',{rootPos=Vector3(rootPosX,rootPosY,0),pivot=Vector2(0.5,0)})
end

function UIChatWin:onInputChanged()
local mesg=self.InputField:getInputFieldValue()
local linkname=self:getLink()
if linkname and not string.findStr(mesg,linkname)then
self.linkTable[linkname]=nil
self.linkNum=0
end
end

function UIChatWin:onBtnRecentOpenArrow()

end

function UIChatWin:onBtnRecentCloseArrow()

end

function UIChatWin:onBtnFriendOpenArrow()

end

function UIChatWin:onBtnFriendCloseArrow()

end


function UIChatWin:onRectChanged()
local keepPos=self:isKeepPos()
if self.activeDownRoot~=keepPos then
self.activeDownRoot=keepPos
self.downRoot:setActive(keepPos)
end

self:freshUnReadInfo()
end


function UIChatWin:onClickDownVoice()
if not chatVoiceHelper:checkAPI()then return end
local channelId=self.channelId
local actorId=self.selectActorInfo and self.selectActorInfo.actorId or nil
local formType=self.formType
local args=chatVoiceHelper:getArgsJson(channelId,actorId,formType)
local ret,errCode=chatVoiceHelper:startRecord(args)
if ret then
self:startRecordTimer()
self.startRecord=true
self.clickDownRecord=true
self.winlua:SetChildScale(self.speakerRaycast:getID(),Vector3(3,3,3))
UIManager:showWindow('UISpeakVoiceWin')
end
end


function UIChatWin:onClickUpVoice(...)
self:stopRecordTimer()
if self.exitRecord then
self:cancelRecord()
else
self:stopRecord()
end
end

function UIChatWin:onClickExitVoice()
if self.clickDownRecord then
self.exitRecord=true
UIManager:callWindowFunc('UISpeakVoiceWin','setCancel')
end
end

function UIChatWin:onClickEnterVoice()
if self.exitRecord==true then
self.exitRecord=false
UIManager:callWindowFunc('UISpeakVoiceWin','setRecord')
end
end

function UIChatWin:startRecordTimer()
self:stopRecordTimer()
local max=30
local showTime=5
self.recordStamp=timeHelper.getServerShortTime()+max
self.recordTimer=self:setTimer(1,0,function()
local left=self.recordStamp-timeHelper.getServerShortTime()
if left>0 and left<=showTime then
UIManager:callWindowFunc('UISpeakVoiceWin','showCount',left)
elseif left<=0 then
self:stopRecord()
self:stopRecordTimer()
end
end)
end

function UIChatWin:stopRecordTimer()
if self.recordTimer then
self:stopTimerByID(self.recordTimer)
end
self.recordTimer=nil
self.recordStamp=nil
end

function UIChatWin:stopRecord()

if not chatVoiceHelper:checkAPI()then return false end
if not self.startRecord then return end
self.clickDownRecord=false
self.exitRecord=false
self.winlua:SetChildScale(self.speakerRaycast:getID(),Vector3(1,1,1))
self.startRecord=false
UIManager:closeWindow('UISpeakVoiceWin')
chatVoiceHelper:stopRecord()
end

function UIChatWin:cancelRecord()

if not chatVoiceHelper:checkAPI()then return false end
if not self.startRecord then return end
self.clickDownRecord=false
self.winlua:SetChildScale(self.speakerRaycast:getID(),Vector3(1,1,1))
self.startRecord=false
UIManager:closeWindow('UISpeakVoiceWin')
chatVoiceHelper:cancelRecord()
end















function UIChatWin:initActorsData()
table.clear(self.actorsCacheData)
self.actorsCacheData=table.deepCopy(self.actorsData,self.actorsCacheData)or{}
table.clear(self.actorsData)
self.isChangeActorCnt={}
local actorsData=self.actorsData

local temp={CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent,
CHAT_PRIVATE_PLAYER_FROM_TYPE.eFriend}
for _,formType in ipairs(temp)do
actorsData[formType]=self.privateConfig[formType].list()or{}
local old=self.actorsCacheData[formType]or{}
self.isChangeActorCnt[formType]=#actorsData[formType]~=#old
self.isChangeActorIdx[formType]=self:isDiffListIdx(actorsData[formType],self.actorsCacheData[formType])
end
self:freshFriendMainItemCnt()
self:freshRecentMainItemCnt()
end


function UIChatWin:isDiffListIdx(t1,t2)
if t1 and t2 and#t1==#t2 then
local ret=false
for i,v1 in ipairs(t1)do
local v2=t2[i]
ret=ret or not mathHelper.compareInt64(v1.actorId,v2.actorId)
if ret then return true end
end
end
return false
end

function UIChatWin:freshRecentActorsData()
local formType=CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent
local actorsData=self.actorsData
actorsData[formType]=self.privateConfig[formType].list()or{}
local old=self.actorsCacheData[formType]or{}
self.isChangeActorCnt[formType]=#actorsData[formType]~=#old
self:freshRecentMainItemCnt()
end


function UIChatWin:getActorsData(formType)
return self.actorsData[formType]or{}
end


function UIChatWin:getActorsCnt(formType)
return#self:getActorsData(formType)
end


function UIChatWin:getActorIdx(fromType,actorid)
local list=self:getActorsData(fromType)
for i,v in ipairs(list)do
if v.actorId==actorid then
return i
end
end
end

function UIChatWin:fillSubData(subItem,formType)
local privateConfig=self.privateConfig[formType]
privateConfig.freshfunc(self,subItem)
end


function UIChatWin:fillRecentData(item)
local formType=CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent
local list=self:getActorsData(formType)
if list==nil then return end
local index=item.Index+1
local mainIndex=item.Mainindex+1
local actorInfo=list[index]
if actorInfo==nil then return end
local actorId=actorInfo.actorId
local actorName=actorInfo.actorName
local iconInfo=actorInfo.iconInfo
local idStr=tostring(actorId)
local isWatch=self.opActorId==actorId
local isTop=chatRecentModel.isTop(actorId)
local reddot=chatControl.hasNewMesgByPlayer(tostring(actorId))
local isSelectPlayer=self.selectActorInfo and tostring(self.selectActorInfo.actorId)==idStr or false
local widget=item

widget:SetChildActive(_subItemIndex.cmpOpRoot,isWatch)
widget:SetChildActive(_subItemIndex.cmpShowRoot,not isWatch)

playerController:setHeadIcon(widget,_subItemIndex.cmpHead,{iconInfo=iconInfo,scale=HEAD_SCALE_TYPE.e60x60})

widget:SetChildText(_subItemIndex.cmpNameText,actorName)
widget:SetChildActive(_subItemIndex.cmpReddot,reddot)
widget:SetChildActive(_subItemIndex.cmpOnline,false)
widget:SetChildActive(_subItemIndex.cmpTopBtn,not isTop)
widget:SetChildActive(_subItemIndex.cmpDeleteBtn,true)
widget:SetChildActive(_subItemIndex.cmpOpenArrowBtn,not isWatch)
widget:SetChildActive(_subItemIndex.cmpCloseArrowBtn,isWatch)
widget:SetChildActive(_subItemIndex.cmpSelect,self.formType==mainIndex and isSelectPlayer)
widget:SetChildButtonClick(_subItemIndex.cmpDeleteBtn,function()self:deleteRecentInfo(actorId)end,true)
widget:SetChildButtonClick(_subItemIndex.cmpTopBtn,function()self:setRecentTopInfo(actorId)end,true)
widget:SetChildButtonClick(_subItemIndex.cmpCloseArrowBtn,function()self:opRecentInfo(actorId,item,false)end,true)
widget:SetChildButtonClick(_subItemIndex.cmpOpenArrowBtn,function()self:opRecentInfo(actorId,item,true)end,true)

if reddot then
local count=chatControl.getNewestMesgNumByPlayer(CHAT_CHANNNEL.ePrivate,actorId)or 0
local str=count>10 and'10+'or count
widget:SetChildText(_subItemIndex.cmpMsgCount,str)
end
end


function UIChatWin:fillFriendData(item)
local formType=CHAT_PRIVATE_PLAYER_FROM_TYPE.eFriend
local list=self:getActorsData(formType)
if list==nil then return end
local index=item.Index+1
local actorInfo=list[index]
local mainIndex=item.Mainindex+1
if actorInfo==nil then return end
local actorId=actorInfo.actorId
local actorName=actorInfo.actorName
local iconInfo=actorInfo.iconInfo
local idStr=tostring(actorId)
local isTop=chatRecentModel.isTop(actorId)
local reddot=chatControl.hasNewMesgByPlayer(actorId)
local isSelectPlayer=self.selectActorInfo and tostring(self.selectActorInfo.actorId)==idStr or false
local online=actorInfo.offline==0
local onlineStr=online and'在线'or FMT.cfmt(FONT_COLOR.eGrayColor,'离线')
local widget=item
widget:SetChildActive(_subItemIndex.cmpOpRoot,false)
widget:SetChildActive(_subItemIndex.cmpShowRoot,true)

playerController:setHeadIcon(widget,_subItemIndex.cmpHead,{iconInfo=iconInfo,scale=HEAD_SCALE_TYPE.e60x60,gray=not online})

widget:SetChildText(_subItemIndex.cmpNameText,actorName)
widget:SetChildActive(_subItemIndex.cmpReddot,reddot)
widget:SetChildText(_subItemIndex.cmpOnline,onlineStr)
widget:SetChildActive(_subItemIndex.cmpOnline,true)
widget:SetChildActive(_subItemIndex.cmpTopBtn,false)
widget:SetChildActive(_subItemIndex.cmpDeleteBtn,false)
widget:SetChildActive(_subItemIndex.cmpOpenArrowBtn,false)
widget:SetChildActive(_subItemIndex.cmpCloseArrowBtn,false)
widget:SetChildActive(_subItemIndex.cmpSelect,self.formType==mainIndex and isSelectPlayer)

if reddot then
local count=chatControl.getNewestMesgNumByPlayer(CHAT_CHANNNEL.ePrivate,actorId)or 0
local str=count>10 and'10+'or count
widget:SetChildText(_subItemIndex.cmpMsgCount,str)
end
end


function UIChatWin:opRecentInfo(actorId,widget,flag)
local formType=CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent
local oldActorId=self.opActorId

local isSame=mathHelper.compareInt64(self.opActorId==actorId)
if isSame and flag then return end

self.opActorId=flag and actorId or nil


self:fillSubData(widget,formType)


self:freshSubItemInfo(formType,oldActorId)
end


function UIChatWin:deleteRecentInfo(actorId)
local isRecenet=self:isRecentType()
if not isRecenet then return end

local ret=chatRecentModel.delete(actorId)
if not ret then return end


if mathHelper.compareInt64(self.opActorId,actorId)then
self.opActorId=nil
end

local formType=self.formType
local nextformType=nil

self:initActorsData()


local changeActor=false
if self:isSelectActor(actorId)then
self:setPlayer(nil)

nextformType=self:initPrivatePlayer()
changeActor=true
end



if nextformType==nil or nextformType==formType then
local func=function()
self:freshAllSubItemInfo()
end
self:rebuildSubItems(formType,func)
end

if changeActor then
local actorInfo=self.selectActorInfo
self:freshMesgPanel()
self:freshLiuYanReddot(actorInfo)
end


self:freshChannelReddot(CHAT_CHANNNEL.ePrivate)

self:freshMesgPanelCommonInfo()

self:freshMainItemReddot()

self:freshListPanelInfo()
end


function UIChatWin:setRecentTopInfo(actorId)
if not chatRecentModel.setTop(actorId)then return end
self.opActorId=nil
if not self:isRecentType()then return end
self:freshAllSubItemInfo(self.formType)
end

function UIChatWin:getOtherFormType(formType)
if formType==CHAT_PRIVATE_PLAYER_FROM_TYPE.eFriend then
return CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent
elseif formType==CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent then
return CHAT_PRIVATE_PLAYER_FROM_TYPE.eFriend
end
end


function UIChatWin:initPrivatePlayer(actorInfo,formType)
if not self:isPrivateChannel(self.channelId)then return end
formType=formType or self.formType
if formType==nil then formType=CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent end
if actorInfo==nil then

actorInfo=self:getDefaultPlayer(formType)


if actorInfo==nil then
formType=self:getOtherFormType(formType)
actorInfo=self:getDefaultPlayer(formType)

if actorInfo==nil then return end
end
end
self:selectActor(formType,actorInfo)
return formType
end


function UIChatWin:isRecentType()
return self.formType==CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent
end

function UIChatWin:isSelectActor(actorId)
return self.selectActorInfo and
mathHelper.compareInt64(self.selectActorInfo.actorId,actorId)or
false
end

function UIChatWin:isPrivateChannel(channelId)
return channelId==CHAT_CHANNNEL.ePrivate
end

function UIChatWin:setPlayer(actorInfo)
self.selectActorInfo=actorInfo
end

function UIChatWin:selectActor(formType,actorInfo)
if actorInfo==nil then
self:setPlayer(nil)
return
end
if not self:isPrivateChannel(self.channelId)then return end

if self:isSelectActor(actorInfo.actorId)then return end

self:setPlayer(actorInfo)


self.selectHandler:setNowActorInfo(formType,actorInfo)


if self.formType~=formType then
self:openMainItem(formType)
else

self:freshAllSubItemParticlInfo(formType)
end


local add=chatRecentModel.setRecentInfo(actorInfo)
if add then
self:freshRecentMainItemCnt()
end

self:freshChannelReddot(CHAT_CHANNNEL.ePrivate)

self:freshMesgPanel()

self:freshMesgPanelCommonInfo()

self:freshLiuYanReddot(actorInfo)

self:freshMainItemReddot()
end


function UIChatWin:freshLiuYanReddot(actorInfo)
if actorInfo==nil then return end
local actorId=actorInfo.actorId

if chatModel.checkLiuYanReddotByActorId(actorId)then
if friendModel:isFriend(actorId)then



chatProtocolControl.sendLiuYan(actorId)
end


chatProtocolControl.sendRemoveLiuYan(actorId)
end
end






function UIChatWin:showPrivate(flag)
if self.showPrivateFlag==nil then self.showPrivateFlag=false end
if self.showPrivateFlag==flag then return end
self.showPrivateFlag=flag
self.winlua:SetChildDOTweenAnimation_DOPlay(self.privateRoot:getID(),flag and'1'or'2',0,3)
end


function UIChatWin:isDiffDataAndItem(formType)
local datacnt=self:getActorsCnt(formType)
local itemcnt=self.CSGUIScrollView:getSubItemsList().Count
return itemcnt~=datacnt
end


function UIChatWin:getSubItem(formType,actorId)
local idx=self:getActorIdx(formType,actorId)
if idx==nil then return end
return self.CSGUIScrollView:getSubItem(formType-1,idx-1)
end


function UIChatWin:freshSubItemInfo(formType,actorId)
if actorId==nil then return end
local item=self:getSubItem(formType,actorId)
if item then
self:fillSubData(item,formType)
end
end


function UIChatWin:freshAllSubItemInfo(formType)
if formType==nil then return end
if self.formType~=formType then return end
local itemList=self.CSGUIScrollView:getSubItemsList()
local num=itemList.Count
if num==0 then return end
for i=1,num do
local item=itemList[i-1]
if item then
self:fillSubData(item,formType)
end
end
end



function UIChatWin:freshAllSubItemParticlInfo(formType)
if formType==nil then return end
if self.formType~=formType then return end
local itemList=self.CSGUIScrollView:getSubItemsList()
local num=itemList.Count
if num<=0 then return end
for i=1,num do
local item=itemList[i-1]
if item then
self:freshSubItemParticlInfoByItem(item,formType,i)
end
end
end


function UIChatWin:freshSubItemParticlInfoByItem(item,formType,index)
if item then
local list=self:getActorsData(formType)
local info=list[index]
if info==nil then return end
local actorId=info.actorId
local isSelectPlayer=self:isSelectActor(actorId)
local isSelect=self.formType==formType and isSelectPlayer
local reddot=chatControl.hasNewMesgByPlayer(actorId)

item:SetChildActive(_subItemIndex.cmpSelect,isSelect)
item:SetChildActive(_subItemIndex.cmpReddot,reddot)

if reddot then
local count=chatControl.getNewestMesgNumByPlayer(CHAT_CHANNNEL.ePrivate,actorId)or 0
local str=count>10 and'10+'or count
item:SetChildText(_subItemIndex.cmpMsgCount,str)
end
end
end


function UIChatWin:freshSubItemParticlInfoByActorId(formType,actorId)
local item=self:getSubItem(formType,actorId)
if item==nil then return end
local isSelectPlayer=self:isSelectActor(actorId)
local isSelect=self.formType==formType and isSelectPlayer
local reddot=chatControl.hasNewMesgByPlayer(actorId)

item:SetChildActive(_subItemIndex.cmpSelect,isSelect)
item:SetChildActive(_subItemIndex.cmpReddot,reddot)

if reddot then
local count=chatControl.getNewestMesgNumByPlayer(CHAT_CHANNNEL.ePrivate,actorId)or 0
local str=count>10 and'10+'or count
item:SetChildText(_subItemIndex.cmpMsgCount,str)
end
end




function UIChatWin:openMainItem(formType)
if self.formType==formType then return end
self:freshExpandColumCount(formType)
self.CSGUIScrollView:clickItem(formType-1)
end


function UIChatWin:freshMainItemReddot()

local firendMainItem=self.CSGUIScrollView:getMainItem(CHAT_PRIVATE_PLAYER_FROM_TYPE.eFriend-1)
local recentMainItem=self.CSGUIScrollView:getMainItem(CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent-1)
local reddot,friendReddot,recentReddot=chatControl.hasNewMesgByChannel(CHAT_CHANNNEL.ePrivate)
firendMainItem:SetChildActive(2,friendReddot)
recentMainItem:SetChildActive(2,recentReddot)
end


function UIChatWin:rebuildSubItems(formType,action)
if formType~=self.formType then return end
local len=self:getActorsCnt(formType)
self.CSGUIScrollView:rebuildSubItems(formType-1,len,action)
end


function UIChatWin:getDefaultPlayer(formType)
local list=self:getActorsData(formType)
local actorInfo
for i,v in ipairs(list)do
local idStr=tostring(v.actorId)
if chatControl.hasNewMesgByPlayer(idStr)then return v end
end
if actorInfo==nil then actorInfo=list[1]end
return actorInfo
end



function UIChatWin:freshExpandColumCount(formType)
local num=self:getActorsCnt(formType)
local mainItem=self.CSGUIScrollView:getMainItem(formType-1)
if mainItem then
mainItem:SetAddExpandColumCount(num)
end
end

function UIChatWin:freshPrivateList(formType)
self:initActorsData()

local isChangeNum=self:isDiffDataAndItem(formType)or
self.isChangeActorCnt[formType]or false
if not isChangeNum then return end
local mainItem=self.CSGUIScrollView:getMainItem(formType-1)
if mainItem==nil or not mainItem.isExpanded then return end
self:rebuildSubItems(formType)
end


function UIChatWin:freshListPanelInfo()
local formType=self.formType
local mesg=''
if formType then
local list=self:getActorsData(formType)
local len=#list
if len==0 then
if formType==CHAT_PRIVATE_PLAYER_FROM_TYPE.eFriend then
mesg='暂无仙友\n快去添加更多仙友吧！'
elseif formType==CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent then
mesg='暂无最近联系人'
end
end
end
self.privateTitle:setText(mesg)
end


function UIChatWin:freshMesgPanelCommonInfo()
local formType=self.formType
local channelId=self.channelId

local actorId=self.selectActorInfo and self.selectActorInfo.actorId

local isPrivateChannnel=self:isPrivateChannel(channelId)

local hasPlayer=isPrivateChannnel and actorId~=nil


self:freshMsgPanelTopRootVis(hasPlayer)

self:freshTopMsgVis()

if hasPlayer then


self.roleName:setText(self.selectActorInfo.actorName)


local isOnline=nil
if friendModel:isFriend(actorId)then
isOnline=friendModel:isOnline(eFriendDataType.eLocal,actorId)
if isOnline==nil then
isOnline=friendModel:isOnline(eFriendDataType.eCross,actorId)
end
end


if not isOnline then

self:freshOffLineTipsVis(true)


local count=cfgHelper.get1(cfg_friendbaseconfig_get,1).liuyanMsgMax
self.offLineTipsText:setText(FMT.fmt("离线仙友只会接收到最新{0}条消息",count))
else
self:freshOffLineTipsVis(false)
end
else
self:freshOffLineTipsVis(false)
end


self:freshScrollViewRect()
end


function UIChatWin:mainClickAction(mainItem)
local oldItem=self.mainItem
local index=mainItem.Index+1
local isExpanded=self.formType==index


if isExpanded then
self.mainItem=mainItem

self:freshMainItemInfo(oldItem)
else
self.mainItem=nil
end
self:freshMainItemInfo(mainItem)
self:checkResetSelectActor()
end


function UIChatWin:subClickAction(subItem)
local index=subItem.Index+1

local mainIndex=subItem.Mainindex+1
local typo=mainIndex
local list=self:getActorsData(typo)
local actorInfo=list[index]
self:selectActor(typo,actorInfo)
end


function UIChatWin:mainCreateAction(mainItem)
local index=mainItem.Index+1
local typo=index

local len=self:getActorsCnt(typo)
local privateConfig=self.privateConfig[typo]
local name=privateConfig.name
local widget=mainItem
widget:SetChildText(0,name)
mainItem:SetAddExpandColumCount(len)
self:freshMainItemInfo(mainItem)

self:freshListPanelInfo()
end


function UIChatWin:subCreateAction(subItem)
local index=subItem.Index+1

local mainIndex=subItem.Mainindex+1
local typo=mainIndex
self:fillSubData(subItem,typo)
end


function UIChatWin:onExpandAction(index)
local oldformType=self.formType
if index>=0 then
self.formType=index+1
else
self.formType=nil
end
self.isChangeFormType=oldformType~=self.formType
if self.formType~=CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent then
self.opActorId=nil
end

end


function UIChatWin:checkResetSelectActor()
local formType=self.formType
local actorInfo=self.selectActorInfo
local idx=actorInfo and self:getActorIdx(formType,actorInfo.actorId)or nil

local needResetPlayer=actorInfo==nil or idx==nil or false
if needResetPlayer then
local list=self:getActorsData(formType)
local actorInfo=list[1]
self:selectActor(formType,actorInfo)
end
end


function UIChatWin:freshMainItemInfo(mainItem)
if mainItem==nil then return end
local isExpanded=mainItem.isExpanded
mainItem:SetChildActive(1,isExpanded)
mainItem:SetChildRotation(3,0,0,isExpanded and 0 or 90)
end


function UIChatWin:onRecvPrivateMessage(channelId,actorInfo)


self:freshBtnReddot(CHAT_CHANNNEL.ePrivate)

local curChannelId=self.channelId
if curChannelId~=channelId then return end


local actorId=actorInfo.actorId
local selectPlayer=self.selectActorInfo


local formType=self.formType

if formType==nil then
self:initActorsData()
return
end

self:initActorsData()

local subIndex=self:getActorIdx(formType,actorId)

local isChangeNum=self:isDiffDataAndItem(formType)or
self.isChangeActorCnt[formType]or false

local isChangeIdx=self.isChangeActorIdx[formType]or false

if selectPlayer==nil then
local action=function()
self:selectActor(formType,actorInfo)
end
self:rebuildSubItems(formType,action)
else

local action=function()
self:freshSubItemParticlInfoByActorId(formType,actorId)
end
if isChangeNum==true then
self:rebuildSubItems(formType,action)
else
if isChangeIdx then
self:freshAllSubItemInfo(formType)
else
action()
end
end
end
end

function UIChatWin:freshRecentMainItemCnt()
self:freshExpandColumCount(CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent)
end

function UIChatWin:freshFriendMainItemCnt()
self:freshExpandColumCount(CHAT_PRIVATE_PLAYER_FROM_TYPE.eFriend)
end














function UIChatWin:regChatHandle(lastChannelId,channelId)

if lastChannelId==channelId then return end

self:unregChatHandle(lastChannelId)

local handler=self.handlelist[channelId]
if handler then return end

if self:isPrivateChannel(channelId)then
handler=chatPrivateMessageHandler.create(channelId,self)
else
handler=chatMessageHandler.create(channelId,self)
end

self.selectHandler=handler

self.handlelist[channelId]=handler
chatControl.addHandler(channelId,handler)
end

function UIChatWin:unregChatHandle(channelId)
if channelId==nil then return end
local handler=self.handlelist[channelId]
if not handler then return end
self.selectHandler=nil
self.handlelist[channelId]=nil
chatControl.deleteHandler(channelId,handler)
end

function UIChatWin:getPosY()
local topY=self.topRootVis and _topY or 0
local offlineY=self.offLineTipsVis and _offlineY or 0
local topMsgY=self.topMsgVis and self.topMsgVisHeight or 0
return topY+offlineY+topMsgY
end

function UIChatWin:freshScrollViewRect()
local Y=self:getPosY()
if self.oldY==Y and self.warningBgVis==self.oldWarningVis then return end
self.oldY=Y
self.oldWarningVis=self.warningBgVis
local lowerH=self.warningBgVis and 70 or 0
self.winlua:SetChildSizeDelta(self.ScrollView:getID(),_scrollSizeX,_maxY-Y-lowerH)
self.winlua:SetChildLocalPosY(self.ScrollView:getID(),-Y/2+lowerH/2)
self.winlua:SetChildLocalPosY(self.downRoot:getID(),-_maxY/2+70+lowerH)
self.winlua:ForceLayoutRect(self.ScrollView:getID())
self.loopListViewCmp:ResetListView()
self.loopListView:JumpNewestIndex()
end


function UIChatWin:freshMsgPanelTopRootVis(vis)
self.topRootVis=vis
self.topRoot:setActive(vis)
end

function UIChatWin:freshOffLineTipsVis(vis)
self.offLineTipsVis=vis
self.offLineTips:setActive(vis)
end

function UIChatWin:freshTopMsgVis()
local vis=false
if self.channelId==CHAT_CHANNNEL.eXianmeng and xianmengModel:hasXM()then
vis=true
end
self.topMsgVis=vis
self.topMsgRoot:setActive(vis)
if not vis then return end
self:freshTopMsg()
end

function UIChatWin:freshTopMsg()
if self.topMsgVis then
if self.channelId==CHAT_CHANNNEL.eXianmeng then
local notice=xianmengModel:getXMNotice()
self.topMsg:setText(FMT.fmt('<color=#ca631d>仙盟公告</color>：{0}',notice))
self.winlua:ForceLayoutVertical(self.topMsg:getID())
local sizeY=self.widget:GetChildSizeDeltaY(self.topMsg:getID())
self.winlua:SetChildSizeWithCurrentAnchors(self.topMsg:getID(),1,sizeY)
self.topMsgVisHeight=sizeY+10
end
end
end

function UIChatWin:freshEmoReddot()
local state=chatEmotModel.getChatWinEmotReddot()
self.emoreddot:setActive(state)
self:doPunchRotation(state)
end

function UIChatWin:doPunchRotation(reddot)
if reddot then
if self.reddotTweener==nil then
self:setChildRotation(self.emoreddot:getID(),0,0,0)
local tweener=self:setChildDOPunchRotation(self.emoreddot:getID(),Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener;
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self:setChildRotation(self.emoreddot:getID(),0,0,0)
end
end
end

function UIChatWin:onBagEmotBtn()
self.selectBagEmot:setActive(true)
UIManager:showWindow("UIBagEmotWin")
end

function UIChatWin:onCloseUI(name)
if name=="UIBagEmotWin"then
self.selectBagEmot:setActive(false)
end
end


function UIChatWin:initRedPacket()
self.redpacketWidget=self.redpacket:getChildWidgetBase()

end

function UIChatWin:refreshRedPacketInfo()
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
self.redpacketInfo=list[1]
end

function UIChatWin:refreshRedPacketInfoList()
local subActInfoList={}

local sub_actList_xmhb=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eXianMengHongBao)
if#sub_actList_xmhb>0 then
for i,sub_actInfo in ipairs(sub_actList_xmhb)do

local idx=#subActInfoList+1
subActInfoList[idx]=sub_actInfo
end
end


local sub_actList_csjd=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eCaiShenJiaDao)
if#sub_actList_csjd>0 then
for i,sub_actInfo in ipairs(sub_actList_csjd)do

local idx=#subActInfoList+1
subActInfoList[idx]=sub_actInfo
end
end

self.redPacketInfoList=subActInfoList
self.isShowRedPacket=#subActInfoList>0
end

function UIChatWin:refreshRedPacketBtn()

self.redpacketWidget:SetChildActive(0,self.channelId==CHAT_CHANNNEL.eXianmeng and self.isShowRedPacket)
if self.isShowRedPacket then
local subActInfo=self.redPacketInfoList[1]
local subActType=subActInfo.sub_act_type
local nameStr="财神红包"
if subActType==SUB_ACTIVITY_TYPE.eXianMengHongBao then
nameStr="仙盟红包"
end
self.redpacketWidget:SetChildText(3,nameStr)
end
end

function UIChatWin:refreshRedPacketShow()

self:refreshRedPacketInfoList()
self:refreshRedPacketBtn()
self:refreshRedPacketReddot()
end

function UIChatWin:refreshRedPacketReddot()

if self.isShowRedPacket then

local allShowCount=0
local allCheckCount=0
for i,info in ipairs(self.redPacketInfoList)do
local count
local showHbCount
if info.sub_act_type==SUB_ACTIVITY_TYPE.eCaiShenJiaDao then
count=info:countGuildDataStatus(eCSJDRedPacketStatus.eNormal)
showHbCount=count
elseif info.sub_act_type==SUB_ACTIVITY_TYPE.eXianMengHongBao then
count,showHbCount=info:getGuildDataCanGetRedPacketCount()
end
allShowCount=allShowCount+showHbCount
allCheckCount=allCheckCount+count
end

self.redpacketWidget:SetChildActive(1,allShowCount>0)
self.redpacketWidget:SetChildText(2,allShowCount)
self.xmRedpacket:setActive(allCheckCount>0)
else
self.redpacketWidget:SetChildActive(1,false)
self.xmRedpacket:setActive(false)
end
end

function UIChatWin:onRedpacket()

if self.isShowRedPacket then
local args={

parentWin=self,
callback=function()
if _this==nil and _this.isClose then
return
end
self.redpacket:setActive(true)
end
}
self:showWindow("UIChatRedPacketListWin",args)
self.redpacket:setActive(false)
end
end

function UIChatWin.onCSJDGuildDataChange(actId,subType,subId,guid,reSort)
if reSort then
_this:refreshRedPacketReddot()
end
end

function UIChatWin.onXMHBGuildDataChange(actId,subType,subId,guid,reSort)
if reSort then
_this:refreshRedPacketReddot()
end
end

function UIChatWin.onSubActivityStateChange(actId,subType,subId,state)
if subType==SUB_ACTIVITY_TYPE.eCaiShenJiaDao or subType==SUB_ACTIVITY_TYPE.eXianMengHongBao then

_this:refreshRedPacketInfoList()
_this:refreshRedPacketShow()
end
end

function UIChatWin.on_247_31(actId,subId,actorId,hbGuid,rewardIdx)
if playerModel:checkActorId(actorId)then
local subType=SUB_ACTIVITY_TYPE.eCaiShenJiaDao
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info then
local guildData=info:getGuildData(hbGuid)
local nowTime=timeHelper.getServerShortTime()
if nowTime<guildData.endTime then
local args={
info=info,
guid=guildData.guid,
}
UIManager:showWindow("UICaiShenJiaDaoRedPacketDetailWin",args)
end
end
end
end

function UIChatWin:onCloseBtn()
self:closeSelf()
end
