







def_class("UIZongMenVisitorWin",UIWindowBase)









function UIZongMenVisitorWin:bindComponents()

self.background=UIButton.get(self,0)
self.midRoot=UIObject.get(self,1)
self.rightPanel=UIObject.get(self,2)
self.rightBg=UIButton.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.shareBtn=UIButton.get(self,5)
self.CSGUIScrollView=UIComboScrollView.get(self,6)
self.addfriend=UIButton.get(self,7)
self.privateTitle=UIText.get(self,8)
self.dialogTx=UIText.get(self,9)
self.rewardItem=UIObject.get(self,10)
self.leaveTx=UIText.get(self,11)
self.dialogBg=UIObject.get(self,12)
self.discipleModelRoot=UIObject.get(self,13)
self.nameTx=UIText.get(self,14)
self.rewardList=UIObject.get(self,15)
self.tipsTx=UIText.get(self,16)
self.helpBtn=UIButton.get(self,17)
self.rightRoot=UIObject.get(self,18)

self.background:setButtonClick(function()self:onBackground()end)

self.rightBg:setButtonClick(function()self:onRightBg()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)

self.addfriend:setButtonClick(function()self:onAddfriend()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)



end


function UIZongMenVisitorWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.midRoot);self.midRoot=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.rightBg);self.rightBg=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.CSGUIScrollView);self.CSGUIScrollView=nil;
_UIObject_release(self.addfriend);self.addfriend=nil;
_UIObject_release(self.privateTitle);self.privateTitle=nil;
_UIObject_release(self.dialogTx);self.dialogTx=nil;
_UIObject_release(self.rewardItem);self.rewardItem=nil;
_UIObject_release(self.leaveTx);self.leaveTx=nil;
_UIObject_release(self.dialogBg);self.dialogBg=nil;
_UIObject_release(self.discipleModelRoot);self.discipleModelRoot=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.rightRoot);self.rightRoot=nil;
end
















local _this=nil
local _subItemIndex=
{
cmpIcon=0,
cmpNameText=1,
cmpOnline=2,
cmpSelect=3,
cmpHeadBg=4,
cmpBg=5,
cmpShareBtn=6,
cmpSharedTx=7,
cmpHead=8,
}
local _titleStr={
[CHAT_PRIVATE_PLAYER_FROM_TYPE.eFriend]='暂无仙友\n快去添加更多仙友吧！',
[CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent]="暂无最近联系人",
[CHAT_PRIVATE_PLAYER_FROM_TYPE.eAlly]="请先加入仙盟",
}



function UIZongMenVisitorWin:onLoaded(...)
self:bindComponents()
_this=self

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

self.showShare=false

if webGLHelper:isNeedAdaption()then
local offset=50
local h=self.rightRoot:getChildSizeDeltaY()
h=h-offset*2
self.rightRoot:setChildSizeDeltaEx(3,0,h)
self.rightPanel:setChildAnchoredPosition3D(Vector3.New(0,-offset,0))
end
end


function UIZongMenVisitorWin:__delete()
self:unbindComponents()
_this=nil
self:stopLeaveTick()
if self.dialogTween then
self.dialogTween:Kill()
self.dialogTween=nil
end
end




function UIZongMenVisitorWin:onShow(argtable,afterOnloaded)
self.visitor=zongmenVisitorModel:getVisitor(argtable.actor)
self.visitorCfg=cfgHelper.get1(cfg_zongmenfangkeconfig_get,self.visitor.id)
local isSelf=self.visitor.playId==playerModel:getActorID()
local isGetted=zongmenVisitorModel:checkAwarded(argtable.actor,playerModel:getActorName())
self:initShare()
self:initPrivatePlayer()
self:initRole()

self:speakWord(not isSelf or not isGetted)
self:startLeaveTick()
end


function UIZongMenVisitorWin:onHide()

end




function UIZongMenVisitorWin:onCloseBtn()
UIFullZongMenVisitorControl:closeUI(true,false)
end

function UIZongMenVisitorWin:onBackground()
self:onCloseBtn()
end


function UIZongMenVisitorWin:onShareBtn()
self.showShare=not self.showShare
self.rightBg:setActive(self.showShare)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.rightRoot:getID(),self.showShare and'1'or'2',0,3)
end

function UIZongMenVisitorWin:onRightBg()
self:onShareBtn()
end


function UIZongMenVisitorWin:onHelpBtn()
local d={}
d.mode=3
d.title="规则介绍"
d.name='zongmenvisitor_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end

function UIZongMenVisitorWin:mainClickAction(mainItem)
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

function UIZongMenVisitorWin:subClickAction(subItem)
local index=subItem.Index+1
local mainIndex=subItem.Mainindex+1
local typo=mainIndex
local list=self:getPrivateList(typo)
local actorInfo=list[index]
if self.selectPlayer then
for i,v in ipairs(list)do
if tostring(self.selectPlayer.actorId)==tostring(v.actorId)then
local item=self.CSGUIScrollView:getSubItem(subItem.Mainindex,i-1)
item:SetChildActive(_subItemIndex.cmpSelect,false)
break
end
end
end
self:selectActor(typo,actorInfo)
subItem:SetChildActive(_subItemIndex.cmpSelect,true)
end

function UIZongMenVisitorWin:mainCreateAction(mainItem)
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

function UIZongMenVisitorWin:subCreateAction(subItem)
local index=subItem.Index+1
local mainIndex=subItem.Mainindex+1
local typo=mainIndex
self:fillData(typo,subItem)


end


function UIZongMenVisitorWin:onExpandAction(index)
if index>=0 then
self.selectFormType=index+1
else
self.selectFormType=nil
end
end

function UIZongMenVisitorWin:selectActor(formType,actorInfo)
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


function UIZongMenVisitorWin:getDefaultPlayer(formType)
local list=self:getPrivateList(formType)
return list[1]
end

function UIZongMenVisitorWin:freshPrivateTitle()
local mesg=self.selectFormType~=nil and self.selectPlayer==nil and _titleStr[self.selectFormType]or""
self.privateTitle:setText(mesg)











end

function UIZongMenVisitorWin:getFriendListIdx(form,actorid)
local list=self:getPrivateList(form)
for i,v in ipairs(list)do
if v.actorId==actorid then
return i
end
end
end

function UIZongMenVisitorWin:freshOtherPrivateList(formType)
for i,v in pairs(self.privateConfig)do
if formType~=i then
self:freshPrivateList(i)
end
end
end

function UIZongMenVisitorWin:freshPrivateList(formType)
if self.privateCacheList==nil then self.privateCacheList={}end
self.privateCacheList[formType]=nil
self:getPrivateList(formType)
self:freshExpandColumCount(formType)
end


function UIZongMenVisitorWin:freshExpandColumCount(formType)
local mainItem=self.CSGUIScrollView:getMainItem(formType-1)
if mainItem then
mainItem:SetAddExpandColumCount(self:getPrivateCountByType(formType))
end
end

function UIZongMenVisitorWin:getPrivateList(formType)
if self.privateCacheList==nil then self.privateCacheList={}end
if self.privateCacheList[formType]==nil then
local privateConfig=self.privateConfig[formType]
local list=privateConfig.list()or{}
table.sort(list,self.sortPrivateList)
self.privateCacheList[formType]=list
end
return self.privateCacheList[formType]
end

function UIZongMenVisitorWin.sortPrivateList(a,b)
local aLine=a.offline==0 and 1 or 0
local bLine=b.offline==0 and 1 or 0
if aLine~=bLine then
return aLine>bLine
else
return a.actorLevel>b.actorLevel
end
end


function UIZongMenVisitorWin:getPrivateCountByType(formType)
return#self:getPrivateList(formType)
end

function UIZongMenVisitorWin:fillData(formType,item)
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








local idStr=tostring(actorId)
local isSelectPlayer=self.selectPlayer and tostring(self.selectPlayer.actorId)==idStr or false
local widget=item

playerController:setHeadIcon(widget,_subItemIndex.cmpHead,{iconInfo=iconInfo,gray=offline~=0})



widget:SetChildText(_subItemIndex.cmpNameText,actorName)
widget:SetChildText(_subItemIndex.cmpOnline,"")
widget:SetChildActive(_subItemIndex.cmpSelect,self.selectFormType==mainIndex and isSelectPlayer)





local share=zongmenVisitorModel:existRecord(actorId)
widget:SetChildActive(_subItemIndex.cmpShareBtn,not share)
widget:SetChildActive(_subItemIndex.cmpSharedTx,share)
widget:SetChildButtonClick(_subItemIndex.cmpShareBtn,function()
self:onClickShareBtn(item,formType,actorId)
end)

if not share then
local ban=zongmenVisitorModel:existRecord(actorId,true)
widget:SetChildButtonEnable(_subItemIndex.cmpShareBtn,not ban,ban)
end
end















































































function UIZongMenVisitorWin:initPrivatePlayer(actorInfo,formType)
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


function UIZongMenVisitorWin:openMainItem(formType)
if self.selectFormType==formType then return end
self:freshExpandColumCount(formType)
self.CSGUIScrollView:clickItem(formType-1)
end

function UIZongMenVisitorWin:initShare()
local curMount=zongmenModel:getMountainId()
self.shareBtn:setActive(curMount==mapIdType.zhufeng)
end

function UIZongMenVisitorWin:initRole()
local modelParams={
body=self.visitorCfg.image[1],
componets=self.visitorCfg.image[2],
scale=self.visitorCfg.image[3],
anim=0,
}


comHelper.setChildInSideModelEx(self.discipleModelRoot,modelParams,nil,nil,30,-15,false,true,false)
self.discipleModelRoot:setChildUIModelShowFlipX(true)
self.endTime=zongmenVisitorModel:getNextMonday5oClock()
local delta_time=self.endTime-timeHelper.getServerShortTime()
self.leaveTx:setText(FMT.fmt("将在{0}后离开",timeHelper.format_time_stamp3(delta_time)))
self.nameTx:setText(self.visitorCfg.name)
local rewardDatas=self.visitorCfg.rewards
self.rewardList:setChildLayoutGroupCreateItems(#rewardDatas,function(index)
local item=self.rewardList:getChildLayoutGroupGridItem(index-1)
local rewardData=rewardDatas[index]
local rewardId=rewardData[1]
local rewardNum=rewardData[2]
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1
local conf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(1,function(...)itemsComponentHelper.onItemClick(...)end)
item:SetChildPropData(1,prop)

local actor=self.visitor.list[index]
item:SetChildActive(2,actor==nil)
item:SetChildActive(3,actor~=nil)
item:SetChildText(4,actor or"")
local enable=not table.containsValue(self.visitor.list,playerModel:getActorName())
item:SetChildButtonEnable(2,enable,not enable)
item:SetChildButtonClick(2,function()
self:onClickGetBtn(index)
end)
end)
self:refreshCount()
end

function UIZongMenVisitorWin:onClickGetBtn(index)



for i,v in pairs(self.visitor.list)do
if v==playerModel:getActorName()then
return UIManager.error("已领取过访客奖励")
end
end

if self.visitor.playId~=playerModel:getActorID()then
local current=zongmenVisitorModel:getNum()
local max=cfgHelper.get2(cfg_zongmenfangkebaseconfig_get,1,"rewardMax")
if current>=max then
return UIManager.error("本周领取次数已用完")
end
end

zongmenVisitorController:send_26_103(self.visitor.playId,index)
end

function UIZongMenVisitorWin:refreshGet(playerId,index)
if self.visitor.playId==playerId then
local actor=playerModel:getActorName()
self:speakWord(false)
self:refreshCount()

local items=self.rewardList:getChildLayoutGroupGridList()
for i=1,items.Count do
local item=items[i-1]
if i==index then
item:SetChildActive(2,false)
item:SetChildActive(3,true)
item:SetChildText(4,actor or"")
end
item:SetChildButtonEnable(2,false,true)
end
end
end

function UIZongMenVisitorWin:refreshCount()
local current=zongmenVisitorModel:getNum()
local max=cfgHelper.get2(cfg_zongmenfangkebaseconfig_get,1,"rewardMax")
self.tipsTx:setText(FMT.fmt("<color=#7D3B17>本周领取他人访客奖励：</color>{0}/{1}",current,max))
end

function UIZongMenVisitorWin:speakWord(flag)
local col=flag and"openWord"or"rewardWord"
local words=self.visitorCfg[col]
local word=words[math.random(1,#words)]
self.dialogTx:setText(word)




if self.dialogTween then
self.dialogTween:Kill()
self.dialogTween=nil
end

self.dialogBg:setChildCanvasGroupAlpha(1)
self.dialogBg:setScale(Vector3.zero)

self.dialogTween=self.dialogBg:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.dialogBg:setChildDOScale(1,0.1)
end)




end

function UIZongMenVisitorWin:onClickShareBtn(widget,formType,actorId)
local check=false
for i,v in ipairs(self.visitorCfg.rewards)do
local data=self.visitor.list[i]
if data==nil then
check=true
break
end
end
if not check then
return UIManager.error("访客已无道具可领取")
end

if not chatCommonHelper.isCanSpeakOnChannel(CHAT_CHANNNEL.ePrivate,"",true)then
return
end

zongmenVisitorController:shareLink(formType,actorId)
end

function UIZongMenVisitorWin:refreshSharedButton(actorId)
if self.selectMainItem then
local mainIdx=self.selectMainItem.Index
local formType=mainIdx+1
local list=self:getPrivateList(formType)
for i,v in ipairs(list)do
if v.actorId==actorId then
local widget=self.CSGUIScrollView:getSubItem(mainIdx,i-1)
local share=zongmenVisitorModel:existRecord(actorId)
widget:SetChildActive(_subItemIndex.cmpShareBtn,not share)
widget:SetChildActive(_subItemIndex.cmpSharedTx,share)
return
end
end
end
end

function UIZongMenVisitorWin:startLeaveTick()
if not self.leaveTick and self.endTime>timeHelper.getServerShortTime()then
self.leaveTick=self:setTimer(1,0,function()
local delta_time=self.endTime-timeHelper.getServerShortTime()
self.leaveTx:setText(FMT.fmt("将在{0}后离开",timeHelper.format_time_stamp3(delta_time)))
if delta_time<0 then
self:onCloseBtn()
end
end)
end
end

function UIZongMenVisitorWin:stopLeaveTick()
if self.leaveTick then
self:stopTimerByID(self.leaveTick)
self.leaveTick=nil
end
end


function UIZongMenVisitorWin:onAddfriend()
local jumpId=JUMP_TYPE.eFriend
if jumpId==JUMP_TYPE.eFriend then

local tabType=FULL_TAB_TYPE.eFriendList
local fulltabconfig=fullScreenModel.getFullTabConfig(tabType)
local ret,checkArgs=fullScreenModel.checkCND(fulltabconfig.cnd)
if ret==false then
local typo=checkArgs[1]
local sysid=checkArgs[2]
local limitType=fullScreenModel.LimitType
if typo==limitType.eSystem then
local isCan,errArgs=systemConfig.isEnoughConfigOpenCnd(sysid)
if not isCan then
local errtypo=errArgs[1]
local val=errArgs[2]
local name=systemConfig.getSystemName(sysid)
if errtypo==SYSTEM_OPEN_TYPE.eZongmemLevelChanged then
local level=val
UIManager.info(FMT.fmt('{0}级开启{1}系统',level,name))
end
end
end
return
else

jumpManager:jump({type=0,id=jumpId,args={tab=2}})
end
end
end