







def_class("UISubAct_CangBaoTuFriendListWin",UIWindowBase)









function UISubAct_CangBaoTuFriendListWin:bindComponents()

self.CSGUIScrollView=UIComboScrollView.get(self,0)
self.privateTitle=UIText.get(self,1)
self.privot=UIObject.get(self,2)
self.rightBg=UIButton.get(self,3)
self.rightRoot=UIObject.get(self,4)

self.rightBg:setButtonClick(function()self:onRightBg()end)



end


function UISubAct_CangBaoTuFriendListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.CSGUIScrollView);self.CSGUIScrollView=nil;
_UIObject_release(self.privateTitle);self.privateTitle=nil;
_UIObject_release(self.privot);self.privot=nil;
_UIObject_release(self.rightBg);self.rightBg=nil;
_UIObject_release(self.rightRoot);self.rightRoot=nil;
end















local _this=nil
local _subItemIndex=
{
name=0,
online=1,
select=2,
bg=3,
button=4,
head=5,
btnTx={6,7},
}
local _titleStr={
[CHAT_PRIVATE_PLAYER_FROM_TYPE.eFriend]='暂无仙友\n快去添加更多仙友吧！',
[CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent]="暂无最近联系人",
[CHAT_PRIVATE_PLAYER_FROM_TYPE.eAlly]="暂无盟友",
}
local _funcType={
eShare=1,
eSOS=2,
}
local _funcHandle={
[_funcType.eShare]={
image={'ui/windows/zongmenphoto/zongmenphoto_atlas_pak.ab','button_zmfenxiang_1'},
callback=function(actId,subType,subId,actor,mone0y,sameServer)
if not sameServer then
UIManager.info("不能分享给跨服仙友")
return
end
local count=itemsModel.getCount(money)
if count>0 then
call_activitiesHandle_func('activitiesHandle_cangbaotu','reqShareItem',actId,subId,actor,money)
else
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(money)))
end
end,
},
[_funcType.eSOS]={
image={'ui/windows/zongmenphoto/zongmenphoto_atlas_pak.ab','button_zmpaizhao_1'},
callback=function(actId,subType,subId,actor,money,sameServer)
if not sameServer then
UIManager.info("不能求助跨服仙友")
return
end
local info=activitiesModel:getSubActInfo(actId,subType,subId)
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
local config=activitiesModel:getSubActivityConfig(subType,subId)
if data.task.helptimes<config.help then
local least=info:checkSOSTime(money)
if least>=0 then
call_activitiesHandle_func('activitiesHandle_cangbaotu','reqSOSItem',actId,subId,actor,money)
info:markSOSTime(money)
else
UIManager.error(FMT.fmt("{0}秒后才可继续求助",-least))
end
else
UIManager.error("今日求助次数已用完")
end
end,
},
}



function UISubAct_CangBaoTuFriendListWin:onLoaded(...)
self:bindComponents()
_this=self

if webGLHelper:isNeedAdaption()then
local offset=50
local h=self.privot:getChildSizeDeltaY()
h=h-offset*2
self.privot:setChildSizeDeltaEx(3,0,h)
self.privot:setChildAnchoredPosition3D(Vector3.New(0,-offset,0))
end

local _mainClickAction=function(...)self:mainClickAction(...)end
local _subClickAction=function(...)self:subClickAction(...)end
local _mainCreateAction=function(...)self:mainCreateAction(...)end
local _subCreateAction=function(...)self:subCreateAction(...)end
local _onExpandAction=function(...)self:onExpandAction(...)end
self.CSGUIScrollView:setAction(_mainClickAction,_subClickAction,_mainCreateAction,_subCreateAction,_onExpandAction)

self.privateConfig={}
local privateConfig=self.privateConfig
privateConfig[CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent]={
name='最近联系人',
list=chatRecentModel.getRecentList,
getIdx=chatRecentModel.getIdx,
}
privateConfig[CHAT_PRIVATE_PLAYER_FROM_TYPE.eFriend]={
name='我的仙友',
list=friendModel.getFriendList,
getIdx=function(...)return self:getFriendListIdx(CHAT_PRIVATE_PLAYER_FROM_TYPE.eFriend,...)end
}
if xianmengModel:hasXM()then
privateConfig[CHAT_PRIVATE_PLAYER_FROM_TYPE.eAlly]={
name='仙盟仙友',
list=xianmengModel.getAllyList,
getIdx=function(...)return self:getFriendListIdx(CHAT_PRIVATE_PLAYER_FROM_TYPE.eAlly,...)end
}
end
self.CSGUIScrollView:createMainGrids(#privateConfig,1,true)
end


function UISubAct_CangBaoTuFriendListWin:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_CangBaoTuFriendListWin:onShow(argtable,afterOnloaded)
self.closeCallback=argtable.closeCallback
self.activityId=argtable.activityId
self.subType=argtable.subType
self.subId=argtable.subId
self.piece=argtable.piece
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.money=self.config.money[self.piece]
self.funcType=argtable.funcType
if afterOnloaded then
self:initPrivatePlayer()
else
local subItems=self.CSGUIScrollView:getSubItemsList()
for i=1,subItems.Count do
self:subCreateAction(subItems[i-1])
end
end
end


function UISubAct_CangBaoTuFriendListWin:onHide()

end





function UISubAct_CangBaoTuFriendListWin:onRightBg()
local cb=self.closeCallback
self.rightBg:setActive(false)
self:closeSelf()
if cb then
cb()
end
end

function UISubAct_CangBaoTuFriendListWin:mainClickAction(mainItem)
local lastMainItem=self.selectMainItem
local index=mainItem.Index+1
local isExpanded=self.selectFormType==index
local expandedOther=lastMainItem and self.selectFormType==index or false
if isExpanded then
self.selectMainItem=mainItem
local typo=index
local list=self:getPrivateList(typo)
if expandedOther then
local actorInfo=self:getDefaultPlayer(self.selectFormType)
self:selectActor(typo,actorInfo)
end
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
if lastMainItem and lastMainItem.Index~=mainItem.Index then
self:mainClickAction(lastMainItem)
end
end

function UISubAct_CangBaoTuFriendListWin:subClickAction(subItem)
local index=subItem.Index+1
local mainIndex=subItem.Mainindex+1
local typo=mainIndex
local list=self:getPrivateList(typo)
local actorInfo=list[index]
if self.selectPlayer then
for i,v in ipairs(list)do
if tostring(self.selectPlayer.actorId)==tostring(v.actorId)then
local item=self.CSGUIScrollView:getSubItem(subItem.Mainindex,i-1)
item:SetChildActive(_subItemIndex.select,false)
break
end
end
end
self:selectActor(typo,actorInfo)
subItem:SetChildActive(_subItemIndex.select,true)
end

function UISubAct_CangBaoTuFriendListWin:mainCreateAction(mainItem)
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

function UISubAct_CangBaoTuFriendListWin:subCreateAction(subItem)
local index=subItem.Index+1
local mainIndex=subItem.Mainindex+1
local typo=mainIndex
self:fillData(typo,subItem)
end


function UISubAct_CangBaoTuFriendListWin:onExpandAction(index)
if index>=0 then
self.selectFormType=index+1
else
self.selectFormType=nil
end
end


function UISubAct_CangBaoTuFriendListWin:selectActor(formType,actorInfo)
if actorInfo==nil then
self.selectPlayer=nil
else
local selectPlayer=self.selectPlayer
if selectPlayer and tostring(selectPlayer.actorId)==tostring(actorInfo.actorId)then
return
end
self.selectPlayer=actorInfo
end
self:freshPrivateTitle()
end


function UISubAct_CangBaoTuFriendListWin:getDefaultPlayer(formType)
local list=self:getPrivateList(formType)
return list[1]
end

function UISubAct_CangBaoTuFriendListWin:freshPrivateTitle()
local mesg=self.selectFormType~=nil and self.selectPlayer==nil and _titleStr[self.selectFormType]or""
self.privateTitle:setText(mesg)
end

function UISubAct_CangBaoTuFriendListWin:getFriendListIdx(form,actorid)
local list=self:getPrivateList(form)
for i,v in ipairs(list)do
if v.actorId==actorid then
return i
end
end
end

function UISubAct_CangBaoTuFriendListWin:freshOtherPrivateList(formType)
for i,v in pairs(self.privateConfig)do
if formType~=i then
self:freshPrivateList(i)
end
end
end

function UISubAct_CangBaoTuFriendListWin:freshPrivateList(formType)
if self.privateCacheList==nil then self.privateCacheList={}end
self.privateCacheList[formType]=nil
self:getPrivateList(formType)
self:freshExpandColumCount(formType)
end


function UISubAct_CangBaoTuFriendListWin:freshExpandColumCount(formType)
local mainItem=self.CSGUIScrollView:getMainItem(formType-1)
if mainItem then
mainItem:SetAddExpandColumCount(self:getPrivateCountByType(formType))
end
end

function UISubAct_CangBaoTuFriendListWin:getPrivateList(formType)
if self.privateCacheList==nil then self.privateCacheList={}end
if self.privateCacheList[formType]==nil then
local privateConfig=self.privateConfig[formType]
local list=privateConfig.list()or{}
table.sort(list,self.sortPrivateList)
self.privateCacheList[formType]=list
end
return self.privateCacheList[formType]
end

function UISubAct_CangBaoTuFriendListWin.sortPrivateList(a,b)
local aLine=a.offline==0 and 1 or 0
local bLine=b.offline==0 and 1 or 0
if aLine~=bLine then
return aLine>bLine
else
return a.actorLevel>b.actorLevel
end
end


function UISubAct_CangBaoTuFriendListWin:getPrivateCountByType(formType)
return#self:getPrivateList(formType)
end

function UISubAct_CangBaoTuFriendListWin:fillData(formType,item)
local list=self:getPrivateList(formType)
if list==nil then return end
local index=item.Index+1
local mainIndex=item.Mainindex+1
local actorInfo=list[index]
if actorInfo==nil then return end
local actorId=actorInfo.actorId
local actorName=actorInfo.actorName
local iconInfo=actorInfo.iconInfo
local offline=actorInfo.offline
local serverId=actorInfo.serverId

local online=offline==0 or offline==nil
local onlineStr=online and'在线'or FMT.cfmt(FONT_COLOR.eGrayColor,'离线')

local idStr=tostring(actorId)
local isSelectPlayer=self.selectPlayer and tostring(self.selectPlayer.actorId)==idStr or false
local widget=item

playerController:setHeadIcon(widget,_subItemIndex.head,{iconInfo=iconInfo,gray=offline~=0})


widget:SetChildText(_subItemIndex.name,actorName)
widget:SetChildText(_subItemIndex.online,onlineStr)
widget:SetChildActive(_subItemIndex.online,formType~=CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent)
widget:SetChildActive(_subItemIndex.select,self.selectFormType==mainIndex and isSelectPlayer)

local handle=_funcHandle[self.funcType]

local sameServer=playerModel:checkServerId(serverId)
widget:SetChildGraphicGray(_subItemIndex.button,not sameServer)
widget:SetChildButtonClick(_subItemIndex.button,function()
local handle=_funcHandle[self.funcType]
if handle and handle.callback then
handle.callback(self.activityId,self.subType,self.subId,actorId,self.money,sameServer)
end
end)
for i,v in ipairs(_subItemIndex.btnTx)do
widget:SetChildActive(v,i==self.funcType)
end
end



function UISubAct_CangBaoTuFriendListWin:initPrivatePlayer(actorInfo,formType)
formType=formType or self.selectFormType
if formType==nil then
formType=CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent
end
if actorInfo==nil then

actorInfo=self:getDefaultPlayer(formType)
if actorInfo==nil then

formType=CHAT_PRIVATE_PLAYER_FROM_TYPE.eFriend
actorInfo=self:getDefaultPlayer(formType)
end
end
self:selectActor(formType,actorInfo)
self:openMainItem(formType)
end


function UISubAct_CangBaoTuFriendListWin:openMainItem(formType)
if self.selectFormType==formType then return end
self:freshExpandColumCount(formType)
self.CSGUIScrollView:clickItem(formType-1)
end