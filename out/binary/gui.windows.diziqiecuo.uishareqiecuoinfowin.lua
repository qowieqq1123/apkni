







def_class("UIShareQieCuoInfoWin",UIWindowBase)









function UIShareQieCuoInfoWin:bindComponents()

self.root=UIObject.get(self,0)
self.mainroot=UIObject.get(self,1)
self.exportroot=UIObject.get(self,2)
self.optionList=UIObject.get(self,3)
self.disciplerole=UIButton.get(self,4)
self.cancelBtn=UIButton.get(self,5)
self.shareBtn=UIButton.get(self,6)
self.countTip=UIText.get(self,7)
self.CSGUIScrollView=UIComboScrollView.get(self,8)
self.privateTitle=UIText.get(self,9)
self.bgteo=UIObject.get(self,10)
self.myplayer=UIObject.get(self,11)
self.otherplayer=UIObject.get(self,12)
self.myname=UIText.get(self,13)
self.myseverid=UIText.get(self,14)
self.othername=UIText.get(self,15)
self.otherseverid=UIText.get(self,16)
self.tempsiliaobtn=UIObject.get(self,17)
self.spinebg=UIObject.get(self,18)

self.disciplerole:setButtonClick(function()self:onDisciplerole()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)



end


function UIShareQieCuoInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.mainroot);self.mainroot=nil;
_UIObject_release(self.exportroot);self.exportroot=nil;
_UIObject_release(self.optionList);self.optionList=nil;
_UIObject_release(self.disciplerole);self.disciplerole=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.countTip);self.countTip=nil;
_UIObject_release(self.CSGUIScrollView);self.CSGUIScrollView=nil;
_UIObject_release(self.privateTitle);self.privateTitle=nil;
_UIObject_release(self.bgteo);self.bgteo=nil;
_UIObject_release(self.myplayer);self.myplayer=nil;
_UIObject_release(self.otherplayer);self.otherplayer=nil;
_UIObject_release(self.myname);self.myname=nil;
_UIObject_release(self.myseverid);self.myseverid=nil;
_UIObject_release(self.othername);self.othername=nil;
_UIObject_release(self.otherseverid);self.otherseverid=nil;
_UIObject_release(self.tempsiliaobtn);self.tempsiliaobtn=nil;
_UIObject_release(self.spinebg);self.spinebg=nil;
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
{
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
{
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
{
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





























}

local optionCfgPrivate={
{
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
}


local _this=nil




function UIShareQieCuoInfoWin:onLoaded(...)
self:bindComponents()
_this=self

local _mainClickAction=function(...)self:mainClickAction(...)end
local _subClickAction=function(...)self:subClickAction(...)end
local _mainCreateAction=function(...)self:mainCreateAction(...)end
local _subCreateAction=function(...)self:subCreateAction(...)end
local _onExpandAction=function(...)self:onExpandAction(...)end
self.CSGUIScrollView:setAction(_mainClickAction,_subClickAction,_mainCreateAction,_subCreateAction,_onExpandAction)
end


function UIShareQieCuoInfoWin:__delete()
self:unbindComponents()
end




function UIShareQieCuoInfoWin:onShow(argtable,afterOnloaded)
self.guid=argtable.guid
self.netdata=nil
self.headdata=argtable.headdata
self.result=argtable.result
self.zhanbao=argtable.zhanbao


self.optionState={}
self.privateActorList={}
self.privateActorNum=0
self.optionNum=0


self.exportroot:setActive(false)


_this.spinebg:setChildUIModelShowTarget(4851,1,nil,eAnimationID.stand)


self.optionList:setChildLayoutGroupCreateItems(#optionCfg,function(index)
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
item:SetChildText(CmpOptionItemIndex.friendnum,FMT.fmt('({0})',self.privateActorNum))
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
item:SetChildText(CmpOptionItemIndex.friendnum,FMT.fmt('({0})',self.privateActorNum))
end

local shareBtnState=(_this.residueNum>0)and(next(_this.optionState or{})~=nil or next(_this.privateActorList or{})~=nil)
_this.shareBtn:setButtonEnable(shareBtnState,not shareBtnState)

else

local tipstr=cfg.getTipStr(cfg.channel,cfg)
UIManager.info(tipstr)
end
end)
end)


local widget=self.tempsiliaobtn:getWidgetBase()
local cfg=optionCfgPrivate[1]
local isUnlock=cfg.checkOpen(cfg.channel)
local isPrivate=cfg.channel==CHAT_CHANNNEL.ePrivate
local selectState=self.optionState[4]~=nil
widget:SetChildText(CmpOptionItemIndex.friendnum,FMT.fmt('({0})',self.privateActorNum))
local func=function()
if isUnlock then

self.optionState[4]=not selectState and cfg.channel or nil
self.optionNum=not selectState and self.optionNum+1 or self.optionNum-1
selectState=not selectState


if isPrivate then
local exportRootState=isPrivate and self.optionState[4]~=nil
self.exportroot:setActive(exportRootState)
self.isShowFirentPart=exportRootState

if exportRootState and not self.isCreateFirentPart then
self.isCreateFirentPart=true
self:freshExportRoot()
end
widget:SetChildText(CmpOptionItemIndex.friendnum,FMT.fmt('({0})',self.privateActorNum))
end

local shareBtnState=(_this.residueNum>0)and(next(_this.optionState or{})~=nil or next(_this.privateActorList or{})~=nil)
_this.shareBtn:setButtonEnable(shareBtnState,not shareBtnState)

else

local tipstr=cfg.getTipStr(cfg.channel,cfg)
UIManager.info(tipstr)
end
end
widget:SetChildButtonClick(8,func,true)

local usedNum=gameUtilityModel:getData_counter(gameCounterType.eShareQieChuoInfoNum)
local limitTotalNum=cfgHelper.get2(cfg_chatstyleconfig_get,1,"daily")
self.residueNum=math.max(limitTotalNum-usedNum,0)

self.countTip:setText(FMT.fmt("每日剩余次数:{0}",self.residueNum))
local shareBtnState=(self.residueNum>0)and(next(self.optionState or{})~=nil or next(self.privateActorList or{})~=nil)
self.shareBtn:setButtonEnable(shareBtnState,not shareBtnState)

local iconInfo=self.headdata[3]
local playerImage=iconInfo.piList
if playerImage==nil or next(playerImage)==nil then
playerImage=playerImageModel:getPlayerImage()
end
playerImageController.setPlayerModel(self.winlua,11,playerImage,0.4,eAnimationID.idle,0,0)
self.myname:setText(playerModel:getActorName())
local serverName=loginModel:getServerName(self.headdata[2])
local str=FMT.fmt('[{0}]',serverName)
self.myseverid:setText(str)

local othericonInfo=self.headdata[6]
local otherplayerImage=othericonInfo.piList
if otherplayerImage==nil or next(otherplayerImage)==nil then
otherplayerImage=playerImageModel:getDefaultImage(1)
end
playerImageController.setPlayerModel(self.winlua,12,otherplayerImage,0.4,eAnimationID.idle,0,0)
self.othername:setText(self.headdata[7])
local otherserverName=loginModel:getServerName(self.headdata[5])
local otherstr=FMT.fmt('[{0}]',otherserverName)
self.otherseverid:setText(otherstr)


end


function UIShareQieCuoInfoWin:refreshfenxiangnum()
local qcdata=DiZiDuelModel:getAllData()
local usedNum=qcdata.dueltimes or 0
local limitTotalNum=cfgHelper.get2(cfg_chatstyleconfig_get,1,"daily")
local residueNum=math.max(limitTotalNum-usedNum,0)
_this.countTip:setText(FMT.fmt("每日剩余次数:{0}",residueNum))
end


function UIShareQieCuoInfoWin:onHide()

end

function UIShareQieCuoInfoWin:freshDiscipleRoleInfoCard()

local netdata=self.netdata.netData
local netData=netdata.net
local guid=netData.discipleguid
local state=UIDiscipleModel:getDiscipleState(guid)
local chuiwei=state==DISCIPLE_STATE_TYPE.eChuiWei
local beibu=state==DISCIPLE_STATE_TYPE.eBeiBu
local item=self.disciplerole:getWidgetBase()
local color=UIDiscipleModel:getDiscipleColor(guid)
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netData)
item:SetChildCSImageSprite(0,abname,iconname)

local jobicon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildCSImageSprite(1,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(29,isSpDz)

item:SetChildText(2,UIDiscipleModel:getDiscipleName(guid))

comHelper.setChildModelRawImage(item,guid,3,0,eHeadCenterType.eHead,nil,chuiwei)

item:SetChildCSImageSprite(17,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])

local lv_str=tostring(netData.jingjielv)
item:SetChildText(5,lv_str)
if self.sortType==eDiscipleSortType.eJingJieSort then

item:SetChildActive(6,false)

local jjlv=netData.jingjielv
local n,p,pN=UIDiscipleModel:getJJNameX(jjlv)
local jj_str=''
if p~=nil then
jj_str=FMT.fmt('{0}{1}阶',n,p)
else
jj_str=n
end
item:SetChildText(4,jj_str)
elseif self.sortType==eDiscipleSortType.eLianTiSort then

item:SetChildActive(6,false)

local ltlv=netData.liantilv
local n1,p1=UIDiscipleModel:getLTNameX(ltlv)
local lt_str=''
if p1~=nil then
lt_str=FMT.fmt('{0}{1}层',n1,p1)
else
lt_str=n1
end
item:SetChildText(4,lt_str)
elseif self.sortType==eDiscipleSortType.ePostSort then

item:SetChildActive(6,false)

local post_id=netData.pos
local post_name=eZongMenPostType.getName(post_id)
item:SetChildText(4,post_name)
else

item:SetChildActive(6,true)
item:SetChildText(6,UIDiscipleModel:getDiscipleFightValue(guid))

item:SetChildText(4,'')
end

item:SetChildActive(8,not chuiwei and self.inputstr~=nil)
item:SetChildText(9,UIDiscipleModel:getDiscipleStateDesc(guid,' '))



item:SetChildActive(12,chuiwei)
item:SetChildActive(13,chuiwei)
item:SetChildActive(18,beibu)












local showOrder=UIDiscipleModel:checkDZHasOrder(guid)
item:SetChildActive(15,showOrder)















UIDiscipleController.refreshCommonItemTianMing(item,netData)
end

function UIShareQieCuoInfoWin:freshExportRoot()

_this.privateConfig={}
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

_this.CSGUIScrollView:createMainGrids(#privateConfig,1,true)
_this.CSGUIScrollView:clickItem(1)
end

function UIShareQieCuoInfoWin:getFriendListIdx(actorid)
local list=self:getPrivateList(CHAT_PRIVATE_PLAYER_FROM_TYPE.eFriend)
for i,v in ipairs(list)do
if v.actorId==actorid then
return i
end
end
end

function UIShareQieCuoInfoWin:fillRecentData(item)
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

function UIShareQieCuoInfoWin:fillFriendData(item)
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

function UIShareQieCuoInfoWin:mainClickAction(mainItem,isLast)
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

function UIShareQieCuoInfoWin:subClickAction(subItem)
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

local item=self.tempsiliaobtn:getWidgetBase()
item:SetChildText(CmpOptionItemIndex.friendnum,FMT.fmt('({0})',self.privateActorNum))
end

function UIShareQieCuoInfoWin:mainCreateAction(mainItem)
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

function UIShareQieCuoInfoWin:subCreateAction(subItem)
local index=subItem.Index+1

local mainIndex=subItem.Mainindex+1
local typo=mainIndex
local privateConfig=self.privateConfig[typo]
privateConfig.freshfunc(self,subItem)
end


function UIShareQieCuoInfoWin:onExpandAction(index)
if index>=0 then
self.selectFormType=index+1
else
self.selectFormType=nil
end
if self.selectFormType~=CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent then
self.showDeatilActorId=nil
end

end

function UIShareQieCuoInfoWin:getPrivateList(formType)
if self.privateCacheList==nil then self.privateCacheList={}end
if self.privateCacheList[formType]==nil then
local privateConfig=self.privateConfig[formType]
self.privateCacheList[formType]=privateConfig.list()or{}
end
return self.privateCacheList[formType]
end

function UIShareQieCuoInfoWin:getPrivateCountByType(formType)
return#self:getPrivateList(formType)
end

function UIShareQieCuoInfoWin:freshPrivateList(formType)
if self.privateCacheList==nil then self.privateCacheList={}end
self.privateCacheList[formType]=nil
self:getPrivateList(formType)
self:freshExpandColumCount(formType)
end

function UIShareQieCuoInfoWin:freshAllPrivateList()
for i,v in pairs(self.privateConfig)do
self:freshPrivateList(i)
end
end

function UIShareQieCuoInfoWin:freshOtherPrivateList(formType)
for i,v in pairs(self.privateConfig)do
if formType~=i then
self:freshPrivateList(i)
end
end
end

function UIShareQieCuoInfoWin:getFriendListIdx(actorid)
local list=self:getPrivateList(CHAT_PRIVATE_PLAYER_FROM_TYPE.eFriend)
for i,v in ipairs(list)do
if v.actorId==actorid then
return i
end
end
end


function UIShareQieCuoInfoWin:freshExpandColumCount(formType)
local mainItem=self.CSGUIScrollView:getMainItem(formType-1)
if mainItem then
mainItem:SetAddExpandColumCount(self:getPrivateCountByType(formType))
end
end

function UIShareQieCuoInfoWin:selectActor(formType,index,actorInfo,subItem)
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

function UIShareQieCuoInfoWin:freshPrivateTitle()

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

function UIShareQieCuoInfoWin:freshScrollViewRect()
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




function UIShareQieCuoInfoWin:onCancelBtn()
self:closeSelf()
end



function UIShareQieCuoInfoWin:onShareBtn()



local channelIds={}
local actorIds={}








local jsonStr=''

if self.optionNum>0 then
for k,v in pairs(self.optionState)do
local cfg=optionCfg[k]
if cfg then
if v then
if cfg.channel~=CHAT_CHANNNEL.ePrivate then
channelIds[#channelIds+1]=cfg.channel




end
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
chatControl:reqShare(CHAT_REGEX_TYPE.eQieCuo,jsonStr,channelIds,actorIds)
end
if self.optionNum>0 or self.privateActorNum>0 then

















UIManager.info("分享成功")

UIFullDiscipleMainControl:closeUI()
UIFullDiscipleSelectControl:closeUI()
self:closeSelf()
else
UIManager.info("请选择一个频道")
end
end

function UIShareQieCuoInfoWin:onCloseBtn()
if self.isShowFirentPart then
self.isShowFirentPart=not self.isShowFirentPart


self.exportroot:setActive(self.isShowFirentPart)
else
self:closeSelf()
end
end
