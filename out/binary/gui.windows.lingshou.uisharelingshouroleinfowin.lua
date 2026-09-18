







def_class("UIShareLingShouRoleInfoWin",UIWindowBase)









function UIShareLingShouRoleInfoWin:bindComponents()

self.bgmodel=UIObject.get(self,0)
self.cancelBtn=UIButton.get(self,1)
self.countTip=UIText.get(self,2)
self.CSGUIScrollView=UIComboScrollView.get(self,3)
self.exportroot=UIObject.get(self,4)
self.lingshourole=UIButton.get(self,5)
self.mainroot=UIObject.get(self,6)
self.optionList=UIObject.get(self,7)
self.order=UIImage.get(self,8)
self.privateChannel=UIObject.get(self,9)
self.privateCount=UIText.get(self,10)
self.privateTitle=UIText.get(self,11)
self.root=UIObject.get(self,12)
self.shareBtn=UIButton.get(self,13)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.lingshourole:setButtonClick(function()self:onLingshourole()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)



end


function UIShareLingShouRoleInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgmodel);self.bgmodel=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.countTip);self.countTip=nil;
_UIObject_release(self.CSGUIScrollView);self.CSGUIScrollView=nil;
_UIObject_release(self.exportroot);self.exportroot=nil;
_UIObject_release(self.lingshourole);self.lingshourole=nil;
_UIObject_release(self.mainroot);self.mainroot=nil;
_UIObject_release(self.optionList);self.optionList=nil;
_UIObject_release(self.order);self.order=nil;
_UIObject_release(self.privateChannel);self.privateChannel=nil;
_UIObject_release(self.privateCount);self.privateCount=nil;
_UIObject_release(self.privateTitle);self.privateTitle=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
end
















local _subItemIndex=
{
bg=0,
head=1,
name=2,
sdi=3,
simg=4
}

local CmpOptionItemIndex={
self=0,
optionusimg=1,
optionssimg=2,
name=3,
lockimg=4,
exportimg=5,
exportroot=6,
friendnum=7,
}

local optionIndex={
eWorld=1,
eKuafu=2,
eXianmeng=3,
ePrivate=4,
eBattleField=5,
eSeasonZZSH=6,
}

local optionCfg={
[optionIndex.eWorld]={
channel=CHAT_CHANNNEL.eWorld,
isShowExport=false,
checkOpen=function(channel)
return chatCommonHelper.isShowChannel(channel)
end,
getTipStr=function(channel,cfg)
if not chatCommonHelper.isShowChannel(channel)then
return FMT.fmt("{0}未开启",CHAT_CHANNNEL_NAME[cfg.channel])
end
end,
},
[optionIndex.eKuafu]={
channel=CHAT_CHANNNEL.eKuafu,
isShowExport=false,
checkOpen=function(channel)
return chatCommonHelper.isShowChannel(channel)
end,
getTipStr=function(channel,cfg)
if not chatCommonHelper.isShowChannel(channel)then
return FMT.fmt("{0}未开启",CHAT_CHANNNEL_NAME[cfg.channel])
end
end,
},
[optionIndex.eXianmeng]={
channel=CHAT_CHANNNEL.eXianmeng,
isShowExport=false,
checkOpen=function(channel)
return chatCommonHelper.isShowChannel(channel)and xianmengModel:hasXM()
end,
getTipStr=function(channel,cfg)
if not chatCommonHelper.isShowChannel(channel)then
return FMT.fmt("{0}未开启",CHAT_CHANNNEL_NAME[cfg.channel])
end
if not xianmengModel:hasXM()then
return"请先加入一个仙盟"
end
end,
},
[optionIndex.ePrivate]={
channel=CHAT_CHANNNEL.ePrivate,
isShowExport=true,
checkOpen=function(channel)
return chatCommonHelper.isShowChannel(channel)
end,
getTipStr=function(channel,cfg)
if not chatCommonHelper.isShowChannel(channel)then
return FMT.fmt("{0}未开启",CHAT_CHANNNEL_NAME[cfg.channel])
end
end,
},
[optionIndex.eBattleField]={
channel=CHAT_CHANNNEL.eBattleField,
isShowExport=true,
checkOpen=function(channel)
return chatCommonHelper.isShowChannel(channel)
end,
getTipStr=function(channel,cfg)
if not chatCommonHelper.isShowChannel(channel)then
return FMT.fmt("{0}未开启",CHAT_CHANNNEL_NAME[cfg.channel])
end
end,
},
[optionIndex.eSeasonZZSH]={
channel=CHAT_CHANNNEL.eSeasonZZSH,
isShowExport=true,
checkOpen=function(channel)
return chatCommonHelper.isShowChannel(channel)
end,
getTipStr=function(channel,cfg)
if not chatCommonHelper.isShowChannel(channel)then
return FMT.fmt("{0}未开启",CHAT_CHANNNEL_NAME[cfg.channel])
end
end,
},
}

local _this=nil




function UIShareLingShouRoleInfoWin:onLoaded(...)
self:bindComponents()
_this=self

local _mainClickAction=function(...)self:mainClickAction(...)end
local _subClickAction=function(...)self:subClickAction(...)end
local _mainCreateAction=function(...)self:mainCreateAction(...)end
local _subCreateAction=function(...)self:subCreateAction(...)end
local _onExpandAction=function(...)self:onExpandAction(...)end
self.CSGUIScrollView:setAction(_mainClickAction,_subClickAction,_mainCreateAction,_subCreateAction,_onExpandAction)
end


function UIShareLingShouRoleInfoWin:__delete()
_this=nil
self:unbindComponents()
end




function UIShareLingShouRoleInfoWin:onShow(argtable,afterOnloaded)
self.ls_guid=argtable.ls_guid


self.optionState={}
self.privateActorList={}
self.privateActorNum=0
self.optionNum=0


self.exportroot:setActive(false)


self.optionList:setChildLayoutGroupCreateItems(3,function(index)
local cfg=optionCfg[index]
local item=self.optionList:getChildLayoutGroupGridItem(index-1)
local selectState=self.optionState[index]~=nil
local isUnlock=cfg.checkOpen(cfg.channel)
local isPrivate=cfg.channel==CHAT_CHANNNEL.ePrivate

item:SetChildActive(CmpOptionItemIndex.optionusimg,not selectState or isPrivate)
item:SetChildActive(CmpOptionItemIndex.optionssimg,selectState and not isPrivate)
item:SetChildText(CmpOptionItemIndex.name,CHAT_CHANNNEL_NAME[cfg.channel])
item:SetChildActive(CmpOptionItemIndex.lockimg,not isUnlock)
item:SetChildActive(CmpOptionItemIndex.exportimg,cfg.isShowExport and isUnlock)
item:SetChildActive(CmpOptionItemIndex.exportroot,cfg.isShowExport and isUnlock and self.isShowFirentPart)
if cfg.isShowExport then
item:SetChildText(CmpOptionItemIndex.friendnum,self.privateActorNum)
end

item:SetBaseItemClickEvent(CmpOptionItemIndex.self,function()
if isUnlock then
self.optionState[index]=not selectState and cfg.channel or nil
self.optionNum=not selectState and self.optionNum+1 or self.optionNum-1
selectState=not selectState
item:SetChildActive(CmpOptionItemIndex.optionusimg,not selectState or isPrivate)
item:SetChildActive(CmpOptionItemIndex.optionssimg,selectState and not isPrivate)
if isPrivate then
local exportRootState=isPrivate and self.optionState[index]~=nil
self.exportroot:setActive(exportRootState)
self.isShowFirentPart=exportRootState
item:SetChildActive(CmpOptionItemIndex.exportroot,exportRootState)
if exportRootState and not self.isCreateFirentPart then
self.isCreateFirentPart=true
self:freshExportRoot()
end
item:SetChildText(CmpOptionItemIndex.friendnum,self.privateActorNum)
end
if not isPrivate then
local shareBtnState=(_this.residueNum>0)and(next(_this.optionState or{})~=nil or next(_this.privateActorList or{})~=nil)
_this.shareBtn:setButtonEnable(shareBtnState,not shareBtnState)
end
else
local tipstr=cfg.getTipStr(cfg.channel,cfg)
UIManager.info(tipstr)
end
end)
end)

self:freshLingShouRoleCard()

local usedNum=gameUtilityModel:getData_counter(gameCounterType.eShareLingShouRoleInfoNum)
local limitTotalNum=cfgHelper.get2(cfg_chatstyleconfig_get,16,"daily")or 2
self.residueNum=math.max(limitTotalNum-usedNum,0)
self.countTip:setText(FMT.fmt("每日剩余次数:{0}",self.residueNum))
local shareBtnState=(self.residueNum>0)and(next(self.optionState or{})~=nil or next(self.privateActorList or{})~=nil)
self.shareBtn:setButtonEnable(shareBtnState,not shareBtnState)

self:freshPrivateChannel()

self.mainroot:setChildCanvasGroupAlpha(0)
self.mainroot:setChildCanvasGroupDOFade(1,1,nil)
end


function UIShareLingShouRoleInfoWin:onHide()

end


function UIShareLingShouRoleInfoWin:freshLingShouRoleCard()
local ls_guid=self.ls_guid
local lingshouWidget=self.lingshourole:getWidgetBase()
local cardWidget=lingshouWidget:GetChildWidgetBase(0)
comHelper.setChildLingShouBaseCard(cardWidget,ls_guid,4,nil)
local hasOrder=lingshouModel:checkLSHasOrder(ls_guid)
if hasOrder then
self.order:setActive(true)
self.order:setCSImageSprite(globalABLookup.global,'button_guanzhu_2')
else
self.order:setActive(false)
end
end

function UIShareLingShouRoleInfoWin:freshPrivateChannel()
local isShow=chatCommonHelper.isShowChannel(CHAT_CHANNNEL.ePrivate)
self.privateChannel:setGray(not isShow)
self.privateCount:setText(FMT.fmt("私聊（{0}）",self.privateActorNum))
end


function UIShareLingShouRoleInfoWin:freshExportRoot()
self.privateConfig={}
local privateConfig=self.privateConfig
privateConfig[CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent]={
name='最近联系人',
freshfunc=self.fillRecentData,
list=chatRecentModel.getRecentList,
getIdx=chatRecentModel.getIdx,
}
privateConfig[CHAT_PRIVATE_PLAYER_FROM_TYPE.eFriend]={
name='我的仙友',
freshfunc=self.fillFriendData,
list=friendModel.getFriendList,
getIdx=function(...)return self:getFriendListIdx(...)end
}

self.CSGUIScrollView:createMainGrids(#privateConfig,1,true)
self.CSGUIScrollView:clickItem(1)
end

function UIShareLingShouRoleInfoWin:getFriendListIdx(actorid)
local list=self:getPrivateList(CHAT_PRIVATE_PLAYER_FROM_TYPE.eFriend)
for i,v in ipairs(list)do
if v.actorId==actorid then
return i
end
end
end

function UIShareLingShouRoleInfoWin:fillRecentData(item)
local formType=CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent
local list=self:getPrivateList(formType)
if list==nil then return end
local index=item.Index+1
local actorInfo=list[index]
if actorInfo==nil then return end
local actorId=actorInfo.actorId
local actorName=actorInfo.actorName
local iconInfo=actorInfo.iconInfo
local widget=item

playerController:setHeadIcon(widget,_subItemIndex.head,{iconInfo=iconInfo,scale=0.45})
widget:SetChildText(_subItemIndex.name,actorName)
widget:SetChildActive(_subItemIndex.simg,self.privateActorList[tostring(actorId)]~=nil)
end

function UIShareLingShouRoleInfoWin:fillFriendData(item)
local formType=CHAT_PRIVATE_PLAYER_FROM_TYPE.eFriend
local list=self:getPrivateList(formType)
if list==nil then return end
local index=item.Index+1
local actorInfo=list[index]
if actorInfo==nil then return end
local actorId=actorInfo.actorId
local actorName=actorInfo.actorName
local iconInfo=actorInfo.iconInfo
local online=actorInfo.offline==0
local widget=item

playerController:setHeadIcon(widget,_subItemIndex.head,{iconInfo=iconInfo,scale=0.45,gray=not online})
widget:SetChildText(_subItemIndex.name,actorName)
widget:SetChildActive(_subItemIndex.simg,self.privateActorList[tostring(actorId)]~=nil)
end

function UIShareLingShouRoleInfoWin:mainClickAction(mainItem,isLast)
local lastMainItem=self.selectMainItem
local index=mainItem.Index+1
local isExpanded=self.selectFormType==index

if isExpanded then
self.selectMainItem=mainItem
self:freshOtherPrivateList(index)
self:freshPrivateTitle()
end
local widget=mainItem
widget:SetChildActive(1,isExpanded)
widget:SetChildDORotation(3,isExpanded and Vector3(0,0,0)or Vector3(0,0,90),0.2)
if lastMainItem and lastMainItem.Index==mainItem.Index then
if not isExpanded then
self.selectSubItem=nil
self:freshPrivateList(index)
end
end
if not isLast and lastMainItem and lastMainItem.Index~=mainItem.Index then
self:mainClickAction(lastMainItem,true)
end
end

function UIShareLingShouRoleInfoWin:subClickAction(subItem)
local index=subItem.Index+1
local mainIndex=subItem.Mainindex+1
local typo=mainIndex
local list=self:getPrivateList(typo)
local actorInfo=list[index]
self:selectActor(typo,index,actorInfo,subItem)

local state=false
for k,v in pairs(_this.optionState)do
if v~=CHAT_CHANNNEL.ePrivate then
state=true
break
end
end
for k,v in pairs(_this.privateActorList)do
if v then
state=true
break
end
end
local shareBtnState=(_this.residueNum>0)and state
_this.shareBtn:setButtonEnable(shareBtnState,not shareBtnState)
self.privateCount:setText(FMT.fmt("私聊（{0}）",self.privateActorNum))
end

function UIShareLingShouRoleInfoWin:mainCreateAction(mainItem)
local index=mainItem.Index+1
local typo=index
local len=self:getPrivateCountByType(typo)
local privateConfig=self.privateConfig[typo]
local name=privateConfig.name
local isExpanded=mainItem.isExpanded
local widget=mainItem
widget:SetChildText(0,name)
mainItem:SetAddExpandColumCount(len)
widget:SetChildActive(1,isExpanded)
widget:SetChildRotation(3,0,0,isExpanded and 0 or 90)
end

function UIShareLingShouRoleInfoWin:subCreateAction(subItem)
local index=subItem.Index+1
local mainIndex=subItem.Mainindex+1
local typo=mainIndex
local privateConfig=self.privateConfig[typo]
privateConfig.freshfunc(self,subItem)
end

function UIShareLingShouRoleInfoWin:onExpandAction(index)
if index>=0 then
self.selectFormType=index+1
else
self.selectFormType=nil
end
if self.selectFormType~=CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent then
self.showDeatilActorId=nil
end
end

function UIShareLingShouRoleInfoWin:getPrivateList(formType)
if self.privateCacheList==nil then self.privateCacheList={}end
if self.privateCacheList[formType]==nil then
local privateConfig=self.privateConfig[formType]
self.privateCacheList[formType]=privateConfig.list()or{}
end
return self.privateCacheList[formType]
end

function UIShareLingShouRoleInfoWin:getPrivateCountByType(formType)
return#self:getPrivateList(formType)
end

function UIShareLingShouRoleInfoWin:freshPrivateList(formType)
if self.privateCacheList==nil then self.privateCacheList={}end
self.privateCacheList[formType]=nil
self:getPrivateList(formType)
self:freshExpandColumCount(formType)
end

function UIShareLingShouRoleInfoWin:freshOtherPrivateList(formType)
for i,v in pairs(self.privateConfig)do
if formType~=i then
self:freshPrivateList(i)
end
end
end

function UIShareLingShouRoleInfoWin:freshExpandColumCount(formType)
local mainItem=self.CSGUIScrollView:getMainItem(formType-1)
if mainItem then
mainItem:SetAddExpandColumCount(self:getPrivateCountByType(formType))
end
end

function UIShareLingShouRoleInfoWin:selectActor(formType,index,actorInfo,subItem)
if self.privateActorList[tostring(actorInfo.actorId)]then
self.privateActorList[tostring(actorInfo.actorId)]=nil
self.privateActorNum=self.privateActorNum-1
else
self.privateActorList[tostring(actorInfo.actorId)]={
actorid=actorInfo.actorId,
actorInfo=actorInfo,
formType=formType,
}
self.privateActorNum=self.privateActorNum+1
end
local selectState=self.privateActorList[tostring(actorInfo.actorId)]~=nil
subItem:SetChildActive(_subItemIndex.simg,selectState)
end

function UIShareLingShouRoleInfoWin:freshPrivateTitle()
local formType=self.selectFormType
if formType then
local mesg=''
if self.selectFormType==CHAT_PRIVATE_PLAYER_FROM_TYPE.eFriend then
mesg='暂无仙友\n快去添加更多仙友吧！'
else
mesg='暂无最近联系人'
end
local list=self:getPrivateList(self.selectFormType)
local len=#list
if len==0 then
self.privateTitle:setText(mesg)
else
self.privateTitle:setText('')
end
else
self.privateTitle:setText('')
end
end




function UIShareLingShouRoleInfoWin:onLingshourole()

end

function UIShareLingShouRoleInfoWin:onCancelBtn()
self:closeSelf()
end

function UIShareLingShouRoleInfoWin:onCloseBtn()
if self.isShowFirentPart then
self.isShowFirentPart=not self.isShowFirentPart
self.exportroot:setActive(self.isShowFirentPart)
else
self:closeSelf()
end
end

function UIShareLingShouRoleInfoWin:onClickPrivateChannel()
local isShow=chatCommonHelper.isShowChannel(CHAT_CHANNNEL.ePrivate)
if isShow then
self.isShowFirentPart=self.optionState[optionIndex.ePrivate]~=nil
self.exportroot:setActive(not self.isShowFirentPart)
if not self.isShowFirentPart and not self.isCreateFirentPart then
self.isCreateFirentPart=true
self:freshExportRoot()
end
self.optionState[optionIndex.ePrivate]=not self.isShowFirentPart and CHAT_CHANNNEL.ePrivate or nil
self.optionNum=not self.isShowFirentPart and self.optionNum+1 or self.optionNum-1
end
end

function UIShareLingShouRoleInfoWin:onShareBtn()
local channelIds={}
local actorIds={}
local jsonStr=chatEmotHelper.getLingShouShareChatJson(self.ls_guid)

if self.optionNum>0 then
for k,v in pairs(self.optionState)do
local cfg=optionCfg[k]
if v then
if cfg.channel~=CHAT_CHANNNEL.ePrivate then
channelIds[#channelIds+1]=cfg.channel
end
end
end
end

if self.privateActorNum>0 then
for k,v in pairs(self.privateActorList)do
actorIds[#actorIds+1]=v.actorid
end
end

if#channelIds>0 or#actorIds>0 then
chatControl:reqShare(CHAT_REGEX_TYPE.eShareLingShou,jsonStr,channelIds,actorIds)
end

if self.optionNum>0 or self.privateActorNum>0 then
if self.privateActorNum>0 then
local cfg=optionCfg[optionIndex.ePrivate]
local akey,avalue=next(self.privateActorList)
local args={
channelId=cfg.channel,
actorInfo=avalue.actorInfo,
formType=avalue.formType,
}
UIManager:showWindow('UIChatWin',args)
else
local key,value=next(self.optionState)
local cfg=optionCfg[key]
UIManager:showWindow('UIChatWin',{channelId=cfg.channel})
end
UIManager.info("分享成功")
UIFullLingShouMainControl:closeUI()
self:closeSelf()
else
UIManager.info("请选择一个频道")
end
end

