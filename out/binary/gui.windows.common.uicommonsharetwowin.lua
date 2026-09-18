







def_class("UICommonShareTwoWin",UIWindowBase)









function UICommonShareTwoWin:bindComponents()

self.frameSp=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.mainroot=UIObject.get(self,2)
self.exportroot=UIObject.get(self,3)
self.titleTxt=UIText.get(self,4)
self.optionList=UIObject.get(self,5)
self.cancelBtn=UIButton.get(self,6)
self.shareBtn=UIButton.get(self,7)
self.countTip=UIText.get(self,8)
self.privateChannel=UIObject.get(self,9)
self.CSGUIScrollView=UIComboScrollView.get(self,10)
self.privateCount=UIText.get(self,11)
self.privateTitle=UIText.get(self,12)
self.sharename=UILinkImageText.get(self,13)
self.pos=UILinkImageText.get(self,14)
self.descTxt=UILinkImageText.get(self,15)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)



end


function UICommonShareTwoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.mainroot);self.mainroot=nil;
_UIObject_release(self.exportroot);self.exportroot=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.optionList);self.optionList=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.countTip);self.countTip=nil;
_UIObject_release(self.privateChannel);self.privateChannel=nil;
_UIObject_release(self.CSGUIScrollView);self.CSGUIScrollView=nil;
_UIObject_release(self.privateCount);self.privateCount=nil;
_UIObject_release(self.privateTitle);self.privateTitle=nil;
_UIObject_release(self.sharename);self.sharename=nil;
_UIObject_release(self.pos);self.pos=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
end















local _scrollSizeX=490
local _scrollSizeY={630,590,560}
local _scrollPosY={0,-20,-35}

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

local optionCfg={
[CHAT_CHANNNEL.eWorld]={

channel=CHAT_CHANNNEL.eWorld,
isShowExport=false,
checkOpen=function(channel)
return chatCommonHelper.isShowChannel(channel)
end,
getTipStr=function(channel,cfg)
if not chatCommonHelper.isShowChannel(channel)then
return FMT.fmt("{0}未开启",CHAT_CHANNNEL_NAME[channel])
end
end,
},
[CHAT_CHANNNEL.eKuafu]={

channel=CHAT_CHANNNEL.eKuafu,
isShowExport=false,
checkOpen=function(channel)
return chatCommonHelper.isShowChannel(channel)
end,
getTipStr=function(channel)
if not chatCommonHelper.isShowChannel(channel)then
return FMT.fmt("{0}未开启",CHAT_CHANNNEL_NAME[channel])
end
end,
},
[CHAT_CHANNNEL.eXianmeng]={

channel=CHAT_CHANNNEL.eXianmeng,
isShowExport=false,
checkOpen=function(channel)
return chatCommonHelper.isShowChannel(channel)and xianmengModel:hasXM()
end,
getTipStr=function(channel)
if not chatCommonHelper.isShowChannel(channel)then
return FMT.fmt("{0}未开启",CHAT_CHANNNEL_NAME[channel])
end
if not xianmengModel:hasXM()then
return"请先加入一个仙盟"
end
end,
},
[CHAT_CHANNNEL.ePrivate]={

channel=CHAT_CHANNNEL.ePrivate,
isShowExport=true,
checkOpen=function(channel)
return chatCommonHelper.isShowChannel(channel)
end,
getTipStr=function(channel)
if not chatCommonHelper.isShowChannel(channel)then
return FMT.fmt("{0}未开启",CHAT_CHANNNEL_NAME[channel])
end
end,
},
[CHAT_CHANNNEL.eBattleField]={

channel=CHAT_CHANNNEL.eBattleField,
isShowExport=true,
checkOpen=function(channel)
return chatCommonHelper.isShowChannel(channel)
end,
getTipStr=function(channel)
if not chatCommonHelper.isShowChannel(channel)then
return FMT.fmt("{0}未开启",CHAT_CHANNNEL_NAME[channel])
end
end,
},
[CHAT_CHANNNEL.eSeasonZZSH]={

channel=CHAT_CHANNNEL.eSeasonZZSH,
isShowExport=true,
checkOpen=function(channel)
return chatCommonHelper.isShowChannel(channel)
end,
getTipStr=function(channel)
if not chatCommonHelper.isShowChannel(channel)then
return FMT.fmt("{0}未开启",CHAT_CHANNNEL_NAME[channel])
end
end,
},
}

local _this=nil



function UICommonShareTwoWin:onLoaded(...)
self:bindComponents()
_this=self

local _mainClickAction=function(...)self:mainClickAction(...)end
local _subClickAction=function(...)self:subClickAction(...)end
local _mainCreateAction=function(...)self:mainCreateAction(...)end
local _subCreateAction=function(...)self:subCreateAction(...)end
local _onExpandAction=function(...)self:onExpandAction(...)end
self.CSGUIScrollView:setAction(_mainClickAction,_subClickAction,_mainCreateAction,_subCreateAction,_onExpandAction)
end


function UICommonShareTwoWin:__delete()
self:unbindComponents()
_this=nil
end




function UICommonShareTwoWin:onShow(argtable,afterOnloaded)
self.title=argtable.title
self.jsonStr=argtable.jsonStr
self.shareBack=argtable.shareBack
self.counterType=argtable.counterType

self.regexType=argtable.regexType

self.descStr=argtable.descStr
self.optionTypes=argtable.channels
local shareName=argtable.shareName
local sharePosStr=argtable.sharePosStr

if argtable.canvasIdx then
self:setCanvasIndex(-1,argtable.canvasIdx)
end


self.optionState={}
self.privateActorList={}
self.privateActorNum=0
self.optionNum=0

self.titleTxt:setText(self.title or'分享')

self.exportroot:setActive(false)

self.descTxt:setText(self.descStr)

self.optionList:setChildLayoutGroupCreateItems(#self.optionTypes,function(index)
if _this==nil then return end
_this:refreshOptionItem(nil,index)
end)

local usedNum=gameUtilityModel:getData_counter(self.counterType)
local limitTotalNum=cfgHelper.get2(cfg_chatstyleconfig_get,self.regexType,"daily")
self.residueNum=math.max(limitTotalNum-usedNum,0)
self.countTip:setText(FMT.fmt("今日剩余次数:{0}",self.residueNum))
local shareBtnState=(self.residueNum>0)and(next(self.optionState or{})~=nil or next(self.privateActorList or{})~=nil)
self.shareBtn:setButtonEnable(shareBtnState,not shareBtnState)
self.sharename:setText(shareName)
self.pos:setText(sharePosStr)
self:freshPrivateChannel()

self.mainroot:setChildCanvasGroupAlpha(0)
self.mainroot:setChildCanvasGroupDOFade(1,1,nil)

self.root:setChildCanvasGroupAlpha(0)
self.frameSp:setChildUIModelShowTarget(4851,1,{},2040,false,false,0,function()
if _this==nil then return end
_this:delayDo(0.25,function()
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end)
end


function UICommonShareTwoWin:onHide()

end





function UICommonShareTwoWin:onCancelBtn()
self:closeSelf()
end



function UICommonShareTwoWin:onShareBtn()
local channelIds={}
local actorIds={}
local jsonStr=self.jsonStr
if self.optionNum>0 then
for channel,v in pairs(self.optionState)do
local cfg=optionCfg[channel]
if v then
if cfg.channel~=CHAT_CHANNNEL.ePrivate then
channelIds[#channelIds+1]=channel
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
chatControl:reqShare(self.regexType,jsonStr,channelIds,actorIds)
end
if self.optionNum>0 or self.privateActorNum>0 then
if self.privateActorNum>0 then
local cfg=optionCfg[CHAT_CHANNNEL.ePrivate]
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
local cb=self.shareBack
self:closeSelf()
if cb~=nil then
cb()
end
else
UIManager.info("请选择一个频道")
end
end

function UICommonShareTwoWin:onCloseBtn()
if self.isShowFirentPart then
self.isShowFirentPart=not self.isShowFirentPart
self.exportroot:setActive(self.isShowFirentPart)
else
self:closeSelf()
end
end

function UICommonShareTwoWin:refreshOptionItem(item,index)
if item==nil then
item=self.optionList:getChildLayoutGroupGridItem(index-1)
end
local channel=self.optionTypes[index]
local cfg=optionCfg[channel]
local selectState=self.optionState[channel]~=nil
local isUnlock=cfg.checkOpen(channel)
local isPrivate=channel==CHAT_CHANNNEL.ePrivate

item:SetChildActive(CmpOptionItemIndex.optionusimg,not selectState or isPrivate)
item:SetChildActive(CmpOptionItemIndex.optionssimg,selectState and not isPrivate)
item:SetChildText(CmpOptionItemIndex.name,CHAT_CHANNNEL_NAME[channel])
item:SetChildActive(CmpOptionItemIndex.lockimg,not isUnlock)
item:SetChildActive(CmpOptionItemIndex.exportimg,cfg.isShowExport and isUnlock)
item:SetChildActive(CmpOptionItemIndex.exportroot,cfg.isShowExport and isUnlock and self.isShowFirentPart)
if cfg.isShowExport then
item:SetChildText(CmpOptionItemIndex.friendnum,self.privateActorNum)
end

item:SetBaseItemClickEvent(CmpOptionItemIndex.self,function()
if isUnlock then

self.optionState[channel]=not selectState and channel or nil
self.optionNum=not selectState and self.optionNum+1 or self.optionNum-1
selectState=not selectState
item:SetChildActive(CmpOptionItemIndex.optionusimg,not selectState or isPrivate)
item:SetChildActive(CmpOptionItemIndex.optionssimg,selectState and not isPrivate)
if isPrivate then
local exportRootState=isPrivate and self.optionState[channel]~=nil
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

local tipstr=cfg.getTipStr(channel)
UIManager.info(tipstr)
end
end)
end


function UICommonShareTwoWin:freshPrivateChannel()
local isShow=chatCommonHelper.isShowChannel(CHAT_CHANNNEL.ePrivate)
self.privateChannel:setGray(not isShow)
self.privateCount:setText(FMT.fmt("私聊（{0}）",self.privateActorNum))
end

function UICommonShareTwoWin:onClickPrivateChannel()
local channel=CHAT_CHANNNEL.ePrivate
local isShow=chatCommonHelper.isShowChannel(channel)
if isShow then
self.isShowFirentPart=self.optionState[channel]~=nil
self.exportroot:setActive(not self.isShowFirentPart)
if not self.isShowFirentPart and not self.isCreateFirentPart then
self.isCreateFirentPart=true
self:freshExportRoot()
end
self.optionState[channel]=not self.isShowFirentPart and CHAT_CHANNNEL.ePrivate or nil
self.optionNum=not self.isShowFirentPart and self.optionNum+1 or self.optionNum-1
end
end

function UICommonShareTwoWin:freshExportRoot()

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


function UICommonShareTwoWin:getFriendListIdx(actorid)
local list=self:getPrivateList(CHAT_PRIVATE_PLAYER_FROM_TYPE.eFriend)
for i,v in ipairs(list)do
if v.actorId==actorid then
return i
end
end
end

function UICommonShareTwoWin:fillRecentData(item)
local formType=CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent
local list=self:getPrivateList(formType)
if list==nil then return end
local index=item.Index+1
local mainIndex=item.Mainindex+1
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

function UICommonShareTwoWin:fillFriendData(item)
local formType=CHAT_PRIVATE_PLAYER_FROM_TYPE.eFriend
local list=self:getPrivateList(formType)
if list==nil then return end
local index=item.Index+1
local actorInfo=list[index]
local mainIndex=item.Mainindex+1
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

function UICommonShareTwoWin:mainClickAction(mainItem,isLast)
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

function UICommonShareTwoWin:subClickAction(subItem)
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

function UICommonShareTwoWin:mainCreateAction(mainItem)
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

function UICommonShareTwoWin:subCreateAction(subItem)
local index=subItem.Index+1

local mainIndex=subItem.Mainindex+1
local typo=mainIndex
local privateConfig=self.privateConfig[typo]
privateConfig.freshfunc(self,subItem)
end


function UICommonShareTwoWin:onExpandAction(index)
if index>=0 then
self.selectFormType=index+1
else
self.selectFormType=nil
end
if self.selectFormType~=CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent then
self.showDeatilActorId=nil
end

end


function UICommonShareTwoWin:getPrivateList(formType)
if self.privateCacheList==nil then self.privateCacheList={}end
if self.privateCacheList[formType]==nil then
local privateConfig=self.privateConfig[formType]
self.privateCacheList[formType]=privateConfig.list()or{}
end
return self.privateCacheList[formType]
end

function UICommonShareTwoWin:getPrivateCountByType(formType)
return#self:getPrivateList(formType)
end

function UICommonShareTwoWin:freshPrivateList(formType)
if self.privateCacheList==nil then self.privateCacheList={}end
self.privateCacheList[formType]=nil
self:getPrivateList(formType)
self:freshExpandColumCount(formType)
end

function UICommonShareTwoWin:freshAllPrivateList()
for i,v in pairs(self.privateConfig)do
self:freshPrivateList(i)
end
end

function UICommonShareTwoWin:freshOtherPrivateList(formType)
for i,v in pairs(self.privateConfig)do
if formType~=i then
self:freshPrivateList(i)
end
end
end

function UICommonShareTwoWin:getFriendListIdx(actorid)
local list=self:getPrivateList(CHAT_PRIVATE_PLAYER_FROM_TYPE.eFriend)
for i,v in ipairs(list)do
if v.actorId==actorid then
return i
end
end
end


function UICommonShareTwoWin:freshExpandColumCount(formType)
local mainItem=self.CSGUIScrollView:getMainItem(formType-1)
if mainItem then
mainItem:SetAddExpandColumCount(self:getPrivateCountByType(formType))
end
end

function UICommonShareTwoWin:selectActor(formType,index,actorInfo,subItem)
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

function UICommonShareTwoWin:freshPrivateTitle()

self:freshScrollViewRect()

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

function UICommonShareTwoWin:freshScrollViewRect()
local oldRectType=self.scrollRectType or 1
local topRootVis=self.topRootVis
local offLineTipsVis=self.offLineTipsVis
local rectType=not topRootVis and not offLineTipsVis and 1 or
topRootVis and not offLineTipsVis and 2 or
topRootVis and offLineTipsVis and 3
if oldRectType==rectType then return end
self.scrollRectType=rectType
local sizeX=_scrollSizeX
local sizeY=_scrollSizeY[rectType]
local posY=_scrollPosY[rectType]
self.winlua:SetChildSizeDelta(self.ScrollView:getID(),sizeX,sizeY)
self.winlua:SetChildLocalPosY(self.ScrollView:getID(),posY)
self.winlua:ForceLayoutRect(self.ScrollView:getID())
self.loopListViewCmp:ResetListView()
self.loopListView:JumpNewestIndex()
end

