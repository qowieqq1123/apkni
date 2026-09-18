







def_class("UIXianJieJieYin_SupportWin",UIWindowBase)









function UIXianJieJieYin_SupportWin:bindComponents()

self.bgSpine=UIObject.get(self,0)
self.closeButton=UIButton.get(self,1)
self.jydesc=UIText.get(self,2)
self.leftRoot=UIObject.get(self,3)
self.picture=UIObject.get(self,4)
self.randomXianRenRoot=UIObject.get(self,5)
self.recvImg=UIObject.get(self,6)
self.recvReddot=UIObject.get(self,7)
self.root=UIObject.get(self,8)
self.ruleBtn=UIButton.get(self,9)
self.selectXMImg=UIObject.get(self,10)
self.selectXRImg=UIObject.get(self,11)
self.stateRppt=UIObject.get(self,12)
self.supportCountTxt=UIText.get(self,13)
self.supportInfo=UIObject.get(self,14)
self.supportRewardScrollView=UIScrollView.get(self,15)
self.XMEmpty=UIObject.get(self,16)
self.XMList=UIObject.get(self,17)
self.XMListButton=UIButton.get(self,18)
self.XMRoot=UIObject.get(self,19)
self.XMScrollView=UIObject.get(self,20)
self.XREmpty=UIObject.get(self,21)
self.XRList=UIObject.get(self,22)
self.XRListButton=UIButton.get(self,23)
self.XRScrollView=UIObject.get(self,24)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIXianJieJieYin_SupportWin")end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.XMListButton:setButtonClick(function()self:onXMListButton()end)

self.XRListButton:setButtonClick(function()self:onXRListButton()end)



end


function UIXianJieJieYin_SupportWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.jydesc);self.jydesc=nil;
_UIObject_release(self.leftRoot);self.leftRoot=nil;
_UIObject_release(self.picture);self.picture=nil;
_UIObject_release(self.randomXianRenRoot);self.randomXianRenRoot=nil;
_UIObject_release(self.recvImg);self.recvImg=nil;
_UIObject_release(self.recvReddot);self.recvReddot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.selectXMImg);self.selectXMImg=nil;
_UIObject_release(self.selectXRImg);self.selectXRImg=nil;
_UIObject_release(self.stateRppt);self.stateRppt=nil;
_UIObject_release(self.supportCountTxt);self.supportCountTxt=nil;
_UIObject_release(self.supportInfo);self.supportInfo=nil;
_UIObject_release(self.supportRewardScrollView);self.supportRewardScrollView=nil;
_UIObject_release(self.XMEmpty);self.XMEmpty=nil;
_UIObject_release(self.XMList);self.XMList=nil;
_UIObject_release(self.XMListButton);self.XMListButton=nil;
_UIObject_release(self.XMRoot);self.XMRoot=nil;
_UIObject_release(self.XMScrollView);self.XMScrollView=nil;
_UIObject_release(self.XREmpty);self.XREmpty=nil;
_UIObject_release(self.XRList);self.XRList=nil;
_UIObject_release(self.XRListButton);self.XRListButton=nil;
_UIObject_release(self.XRScrollView);self.XRScrollView=nil;
end
















local _this

local CmpItemIndex={
head=0,
name=1,
serverName=2,
askBtn=3,
btnTxt=4,
noneActorHead=5,
askFinishBtn=6,
headClick=7,
}

local _scrollType={
XRScrollView=1,
XMScrollView=2,
}




function UIXianJieJieYin_SupportWin:onLoaded(...)
_this=self

self.scrollViewType=_scrollType.XRScrollView

self:bindComponents()



















local bindFunc=function(...)
_this:bindRewardWidget(...)
end
self.supportRewardScrollView:bindScrollWidget(bindFunc)

jiuchongtianjieGuideController:req_xjGuideHelpList()
xianmengController:reqXMDataDetail()


self:addProNotify(34,155,function(...)
if _this==nil then return end
_this:recv_34_155(...)
end)

self:addProNotify(34,156,function(...)
if _this==nil then return end
_this:recv_34_156(...)
end)

self:addProNotify(34,157,function(...)
if _this==nil then return end
_this:recv_34_157(...)
end)

self:addNotify(notifyConfig.onNewDay,function()
if _this==nil then return end
_this:onNewDay()
end)
end


function UIXianJieJieYin_SupportWin:__delete()
self:unbindComponents()

_this=nil
end




function UIXianJieJieYin_SupportWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.bgSpine:setChildUIModelShowTarget(6066,1,{},eAnimationID.enter)

self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.4,function()
self.root:setChildCanvasGroupDOFade(1,0.4,nil)
end)
end

self:refreshAll()

jiuchongtianjieGuideModel:checkHelpNewFlag()
jiuchongtianjieGuideController:freshFuncStorageBtn()
end


function UIXianJieJieYin_SupportWin:onHide()

end


function UIXianJieJieYin_SupportWin:refreshAll()
self:refreshLeft()

self:refreshRight()
end



function UIXianJieJieYin_SupportWin:refreshLeft()
self:refreshIllustration()
self:refreshPlotDesc()
self:refreshSupportRewardInfo()
end

function UIXianJieJieYin_SupportWin:refreshIllustration()

end

function UIXianJieJieYin_SupportWin:refreshPlotDesc()

end

function UIXianJieJieYin_SupportWin:refreshSupportRewardInfo()
local rewardList=jiuchongtianjieGuideController:getSupportReward()
self.rewardList=rewardList
self.isCanReceive=jiuchongtianjieGuideController:checkIsCanReceiveSupportRewad()
self.isReceive=jiuchongtianjieGuideModel:getRecvState()

local len=#rewardList

self.supportRewardScrollView:freshGridsNum(len,1,len,true)
self.rewardScrollViewZero=true

self.recvReddot:setActive(self.isCanReceive)
self.recvImg:setActive(self.isReceive)

self.supportRewardScrollView:setChildScrollRectEnable(len>4)
end

function UIXianJieJieYin_SupportWin:bindRewardWidget(index,widget)
local data=self.rewardList[index]

local itemId=data[1]
local itemCount=data[2]

local isShowCount=itemCount>1
local itemCountStr=isShowCount and itemCount or""

local conf={
itemid=itemId,
itemcount=itemCountStr,
showCountBG=isShowCount,
showname=false,
showStage=true,
colorEffect=self.isCanReceive,
gray=self.isReceive and 1 or 0
}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)

widget:SetChildPropData(0,propData)
widget:SetBaseItemClickEvent(0,function()
if _this.isCanReceive then
jiuchongtianjieGuideController:req_xjGuideRecv()
else
itemsComponentHelper.onItemClick(itemId)
end
end)
end



function UIXianJieJieYin_SupportWin:refreshRight()
self:refreshScrollTitle()
self:refreshSupporActorList()
self:refreshXMSupporActorList()
self:refreshSupportState()
end

function UIXianJieJieYin_SupportWin:refreshScrollTitle()
self.selectXRImg:setActive(self.scrollViewType==_scrollType.XRScrollView)
self.selectXMImg:setActive(self.scrollViewType==_scrollType.XMScrollView)
end

function UIXianJieJieYin_SupportWin:refreshSupporActorList()
self.randomXianRenRoot:setActive(self.scrollViewType==_scrollType.XRScrollView)

local list=jiuchongtianjieGuideModel:getShowHelpActorList()
self.supportActorList_XR=list
local len=#list

local isEmpty=len==0
self.XREmpty:setActive(isEmpty)
self.XRScrollView:setActive(not isEmpty)
if not isEmpty then









self.XRList:setChildLayoutGroupCreateItems(len,function(index)
local widget=self.XRList:getChildLayoutGroupGridItem(index-1)
self:onFreshXRListView(index-1,widget)
end)
end
end

function UIXianJieJieYin_SupportWin:refreshXMSupporActorList()
self.XMRoot:setActive(self.scrollViewType==_scrollType.XMScrollView)

local list=jiuchongtianjieGuideModel:getXmHelpActorList()
self.supportActorList_XM=list
local len=#list

local isEmpty=len==0
self.XMEmpty:setActive(isEmpty)
self.XMScrollView:setActive(not isEmpty)
if not isEmpty then








self.XMList:setChildLayoutGroupCreateItems(len,function(index)
local widget=self.XMList:getChildLayoutGroupGridItem(index-1)
self:onFreshXMListView(index-1,widget)
end)
end
end

function UIXianJieJieYin_SupportWin:refreshSupportState()
local dayMaxCount=jiuchongtianjieGuideController:getDaySupportCount()
local helpCount=jiuchongtianjieGuideController:getSupportedCount()
self.supportCountTxt:setText(FMT.fmt("本周接引次数：{0}次",dayMaxCount-helpCount))
end


function UIXianJieJieYin_SupportWin:onStartView()
end

function UIXianJieJieYin_SupportWin:onFreshXRListView(index,widget)
index=index+1
local data=self.supportActorList_XR[index]

self:onFreshWidget(index,data,widget,_scrollType.XRScrollView)
end

function UIXianJieJieYin_SupportWin:onFreshXMListView(index,widget)
index=index+1
local data=self.supportActorList_XM[index]

self:onFreshWidget(index,data,widget,_scrollType.XMScrollView)
end

function UIXianJieJieYin_SupportWin:onFreshWidget(index,data,widget,scrollType)

local isNoneActor=mathHelper.compareInt64(data.actorid,Int64_0)
local isHasActor=not isNoneActor
widget:SetChildActive(CmpItemIndex.noneActorHead,isNoneActor)
local headWt=widget:GetChildWidgetBase(CmpItemIndex.head)
headWt:SetChildActive(0,isHasActor)
if isHasActor then
playerController:setHeadIcon(headWt,0,{scale=0.65,iconInfo=data.iconInfo})
end


local actorName=playerModel:getOtherActorName(data.actorname)
widget:SetChildText(CmpItemIndex.name,actorName)


local serverName=loginModel:getServerName(data.serverid)
widget:SetChildText(CmpItemIndex.serverName,serverName)

local isAskFinish=jiuchongtianjieGuideController:checkSupportActor(data.actorid)

local isShowAsk=(not isAskFinish)and isHasActor
widget:SetChildActive(CmpItemIndex.askBtn,isShowAsk)
local askBtnClickFunc=function()
if jiuchongtianjieGuideController:checkFinishSupportedActor()then
UIManager.info("本周援助次数已用完")
return
end

local actorId=data.actorid
local content=FMT.fmt("本周仅能接引1位祖师飞升，确定接引<color=#e74e02>[{0}]</color>吗？",data.actorname)
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function()
jiuchongtianjieGuideController:req_xjGuideSupport(actorId)
end,
showclosebtn=true,
}
local dialog=UIDialogManager.newDialog(showdata)
dialog:show()
end
widget:SetChildButtonClick(CmpItemIndex.askBtn,askBtnClickFunc,true)

local isShowAskFinish=isAskFinish and isHasActor
widget:SetChildActive(CmpItemIndex.askFinishBtn,isShowAskFinish)

local askFinishBtnClickFunc=function()
UIManager.info("该玩家已获得援助")
end
widget:SetChildButtonClick(CmpItemIndex.askFinishBtn,askFinishBtnClickFunc,true)

local headClickFunc=function()
local attach={serverid=data.serverid}
otherPlayerController:openOtherPlayerInfoWin(data.actorid,nil,nil,attach)
end
widget:SetChildButtonClick(CmpItemIndex.headClick,headClickFunc,true)
end


function UIXianJieJieYin_SupportWin:refreshActorList()
self:refreshSupporActorList()
self:refreshXMSupporActorList()
end





function UIXianJieJieYin_SupportWin:onChangeButton()
self.isChangeSupportActorList=true
self:refreshSupporActorList()
self.isChangeSupportActorList=false
end



function UIXianJieJieYin_SupportWin:onXRListButton()
self.scrollViewType=_scrollType.XRScrollView
self:refreshScrollTitle()
self:refreshActorList()
end



function UIXianJieJieYin_SupportWin:onXMListButton()
self.scrollViewType=_scrollType.XMScrollView
self:refreshScrollTitle()
self:refreshActorList()
end

function UIXianJieJieYin_SupportWin:onRuleBtn()
local d={}
d.mode=3
d.title="说明"
d.name='xjjy_ask_help_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end




function UIXianJieJieYin_SupportWin:recv_34_155(args)
self:refreshActorList()
end

function UIXianJieJieYin_SupportWin:recv_34_156(actorId)
self:refreshSupportState()

local actorWidgetIndex
local actorData
for index,data in ipairs(self.supportActorList_XR)do
if mathHelper.compareInt64(data.actorid,actorId)then
actorWidgetIndex=index
actorData=data
break
end
end

if actorWidgetIndex then
local wiget=self.XRList:getChildLayoutGroupGridItem(actorWidgetIndex-1)
self:onFreshXRListView(actorWidgetIndex-1,wiget)
return
end

for index,data in ipairs(self.supportActorList_XM)do
if mathHelper.compareInt64(data.actorid,actorId)then
actorWidgetIndex=index
actorData=data
break
end
end

if actorWidgetIndex then
local wiget=self.XRList:getChildLayoutGroupGridItem(actorWidgetIndex-1)
self:onFreshXMListView(actorWidgetIndex-1,wiget)
return
end
end

function UIXianJieJieYin_SupportWin:recv_34_157()
self:refreshSupportRewardInfo()
end

function UIXianJieJieYin_SupportWin:onNewDay()
self:closeSelf()
UIManager.info("飞升求援已失效")
end
