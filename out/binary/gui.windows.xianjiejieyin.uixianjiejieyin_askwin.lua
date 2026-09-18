







def_class("UIXianJieJieYin_AskWin",UIWindowBase)









function UIXianJieJieYin_AskWin:bindComponents()

self.askCountTxt=UIText.get(self,0)
self.bgMask=UIObject.get(self,1)
self.bgSpine=UIObject.get(self,2)
self.changeButton=UIButton.get(self,3)
self.closeButton=UIButton.get(self,4)
self.finishJieYin=UIObject.get(self,5)
self.finishJieYintxt=UIText.get(self,6)
self.jydesc=UIText.get(self,7)
self.leftRoot=UIObject.get(self,8)
self.noneSupportHead=UIObject.get(self,9)
self.picture=UIObject.get(self,10)
self.randomXianRenRoot=UIObject.get(self,11)
self.root=UIObject.get(self,12)
self.ruleBtn=UIButton.get(self,13)
self.stateEmpty=UIText.get(self,14)
self.stateRppt=UIObject.get(self,15)
self.supporterHead=UIObject.get(self,16)
self.supportInfo=UIObject.get(self,17)
self.supportName=UIText.get(self,18)
self.supportServerName=UIText.get(self,19)
self.XMEmpty=UIObject.get(self,20)
self.XMList=UIObject.get(self,21)
self.XMListButton=UIButton.get(self,22)
self.XMRoot=UIObject.get(self,23)
self.XMScrollView=UIObject.get(self,24)
self.XMSelectImg=UIObject.get(self,25)
self.XREmpty=UIObject.get(self,26)
self.XRList=UIObject.get(self,27)
self.XRListButton=UIButton.get(self,28)
self.XRScrollView=UIObject.get(self,29)
self.XRSelectImg=UIObject.get(self,30)

self.changeButton:setButtonClick(function()self:onChangeButton()end)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIXianJieJieYin_AskWin")end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.XMListButton:setButtonClick(function()self:onXMListButton()end)

self.XRListButton:setButtonClick(function()self:onXRListButton()end)



end


function UIXianJieJieYin_AskWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.askCountTxt);self.askCountTxt=nil;
_UIObject_release(self.bgMask);self.bgMask=nil;
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.changeButton);self.changeButton=nil;
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.finishJieYin);self.finishJieYin=nil;
_UIObject_release(self.finishJieYintxt);self.finishJieYintxt=nil;
_UIObject_release(self.jydesc);self.jydesc=nil;
_UIObject_release(self.leftRoot);self.leftRoot=nil;
_UIObject_release(self.noneSupportHead);self.noneSupportHead=nil;
_UIObject_release(self.picture);self.picture=nil;
_UIObject_release(self.randomXianRenRoot);self.randomXianRenRoot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.stateEmpty);self.stateEmpty=nil;
_UIObject_release(self.stateRppt);self.stateRppt=nil;
_UIObject_release(self.supporterHead);self.supporterHead=nil;
_UIObject_release(self.supportInfo);self.supportInfo=nil;
_UIObject_release(self.supportName);self.supportName=nil;
_UIObject_release(self.supportServerName);self.supportServerName=nil;
_UIObject_release(self.XMEmpty);self.XMEmpty=nil;
_UIObject_release(self.XMList);self.XMList=nil;
_UIObject_release(self.XMListButton);self.XMListButton=nil;
_UIObject_release(self.XMRoot);self.XMRoot=nil;
_UIObject_release(self.XMScrollView);self.XMScrollView=nil;
_UIObject_release(self.XMSelectImg);self.XMSelectImg=nil;
_UIObject_release(self.XREmpty);self.XREmpty=nil;
_UIObject_release(self.XRList);self.XRList=nil;
_UIObject_release(self.XRListButton);self.XRListButton=nil;
_UIObject_release(self.XRScrollView);self.XRScrollView=nil;
_UIObject_release(self.XRSelectImg);self.XRSelectImg=nil;
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




function UIXianJieJieYin_AskWin:onLoaded(...)
_this=self

self.scrollViewType=_scrollType.XRScrollView
self.isChangeSupportActorList=true

self:bindComponents()



















jiuchongtianjieGuideController:checkReqXjGuideActorList()


self:addProNotify(34,152,function(...)
if _this==nil then return end
_this:recv_34_152(...)
end)

self:addProNotify(34,153,function(...)
if _this==nil then return end
_this:recv_34_153(...)
end)

self:addNotify(notifyConfig.onNewDay,function()
if _this==nil then return end
_this:onNewDay()
end)
end


function UIXianJieJieYin_AskWin:__delete()
self:unbindComponents()


_this=nil
end




function UIXianJieJieYin_AskWin:onShow(argtable,afterOnloaded)

if afterOnloaded then
self.bgSpine:setChildUIModelShowTarget(6066,1,{},eAnimationID.enter)

self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.4,function()
self.root:setChildCanvasGroupDOFade(1,0.4,nil)
end)
end

self:refreshAll()
end


function UIXianJieJieYin_AskWin:onHide()

end

function UIXianJieJieYin_AskWin:refreshAll()
self:refreshLeft()

self:refreshRight()
end



function UIXianJieJieYin_AskWin:refreshLeft()
self:refreshIllustration()
self:refreshPlotDesc()
self:refreshSupportInfo()
end

function UIXianJieJieYin_AskWin:refreshIllustration()

end

function UIXianJieJieYin_AskWin:refreshPlotDesc()

end

function UIXianJieJieYin_AskWin:refreshSupportInfo()
local isHasSupport=jiuchongtianjieGuideController:checkHasSupportActor()
self.stateEmpty:setActive(not isHasSupport)
self.supportInfo:setActive(isHasSupport)
if isHasSupport then
local supportActorData=jiuchongtianjieGuideModel:getGuideActorInfo()


local isNoneActor=mathHelper.compareInt64(supportActorData.actorid,Int64_0)
self.noneSupportHead:setActive(isNoneActor)
local wt=self.supportInfo:getChildWidgetBase()
wt:SetChildActive(0,not isNoneActor)
if not isNoneActor then
playerController:setHeadIcon(wt,0,{scale=0.65,iconInfo=supportActorData.iconInfo})
end


local actorName=playerModel:getOtherActorName(supportActorData.actorname)
self.supportName:setText(actorName)


local serverName=loginModel:getServerName(supportActorData.serverid)
self.supportServerName:setText(serverName)
end
end



function UIXianJieJieYin_AskWin:refreshRight()
self:refreshScrollTitle()
self:refreshSupporActorList()
self:refreshXMSupporActorList()
self:refreshAskState()
end

function UIXianJieJieYin_AskWin:refreshScrollTitle()
self.XRSelectImg:setActive(self.scrollViewType==_scrollType.XRScrollView)
self.XMSelectImg:setActive(self.scrollViewType==_scrollType.XMScrollView)
end


function UIXianJieJieYin_AskWin:refreshSupporActorList()
self.randomXianRenRoot:setActive(self.scrollViewType==_scrollType.XRScrollView)

local list=jiuchongtianjieGuideModel:getAskShowGuideActorList(self.isChangeSupportActorList)
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

self.isChangeSupportActorList=false
end

function UIXianJieJieYin_AskWin:refreshXMSupporActorList()
self.XMRoot:setActive(self.scrollViewType==_scrollType.XMScrollView)

local list=jiuchongtianjieGuideModel:getAskShowXMGuideActorList()
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

function UIXianJieJieYin_AskWin:refreshAskState()
local askMaxCount=jiuchongtianjieGuideController:getDayAskCount()
local askCount=jiuchongtianjieGuideModel:getAskCount()

local dval=askMaxCount-askCount
local color=dval>0 and FONT_COLOR.eGreenColor or FONT_COLOR.eRedColor
self.askCountTxt:setText(FMT.fmt("今日申请次数：{0}",toColorString(color,FMT.fmt("{0}次",dval))))
local isOk=jiuchongtianjieGuideController:checkHasSupportActor()
self.finishJieYin:setActive(isOk)
self.changeButton:setActive(not isOk)
self.askCountTxt:setActive(not isOk)
end


function UIXianJieJieYin_AskWin:onStartView()
end

function UIXianJieJieYin_AskWin:onFreshXRListView(index,widget)
local data=self.supportActorList_XR[index+1]

self:onFreshWidget(index,data,widget,_scrollType.XRScrollView)
end

function UIXianJieJieYin_AskWin:onFreshXMListView(index,widget)
local data=self.supportActorList_XM[index+1]

self:onFreshWidget(index,data,widget,_scrollType.XMScrollView)
end

function UIXianJieJieYin_AskWin:onFreshWidget(index,data,widget,scrollType)

local isFinish=jiuchongtianjieGuideModel:getViewState()
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

local isAskFinish=jiuchongtianjieGuideController:checkAskedActor(data.actorid)

local isShowAsk=(not isAskFinish)and isHasActor and(not isFinish)
widget:SetChildActive(CmpItemIndex.askBtn,isShowAsk)
local askBtnClickFunc=function()
if jiuchongtianjieGuideController:checkHasAskCount()then
jiuchongtianjieGuideController:req_xjGuideAsk(data.actorid)
else
UIManager.info("今日求助仙人次数为0，请明日再来")
end
end
widget:SetChildButtonClick(CmpItemIndex.askBtn,askBtnClickFunc,true)

local isShowAskFinish=isAskFinish and isHasActor and(not isFinish)

widget:SetChildActive(CmpItemIndex.askFinishBtn,isShowAskFinish)
local askFinishBtnClickFunc=function()
UIManager.info("已求助该仙人")
end
widget:SetChildButtonClick(CmpItemIndex.askFinishBtn,askFinishBtnClickFunc,true)

local headClickFunc=function()
local attach={serverid=data.serverid}
otherPlayerController:openOtherPlayerInfoWin(data.actorid,nil,nil,attach)
end
widget:SetChildButtonClick(CmpItemIndex.headClick,headClickFunc,true)
end


function UIXianJieJieYin_AskWin:refreshActorList()
self:refreshSupporActorList()
self:refreshXMSupporActorList()
end





function UIXianJieJieYin_AskWin:onChangeButton()
self.isChangeSupportActorList=true
self:refreshSupporActorList()
end



function UIXianJieJieYin_AskWin:onXRListButton()
self.scrollViewType=_scrollType.XRScrollView
self:refreshScrollTitle()
self:refreshActorList()
end



function UIXianJieJieYin_AskWin:onXMListButton()
self.scrollViewType=_scrollType.XMScrollView
self:refreshScrollTitle()
self:refreshActorList()
end

function UIXianJieJieYin_AskWin:onRuleBtn()
local d={}
d.mode=3
d.title="说明"
d.name='xjjy_ask_help_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end





function UIXianJieJieYin_AskWin:recv_34_152(args)
self.isChangeSupportActorList=true
self:refreshActorList()
end

function UIXianJieJieYin_AskWin:recv_34_153(actorId)
self:refreshAskState()

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
local widget=self.XRList:getChildLayoutGroupGridItem(actorWidgetIndex-1)
self:onFreshXRListView(actorWidgetIndex-1,widget)
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
local widget=self.XMList:getChildLayoutGroupGridItem(actorWidgetIndex-1)
self:onFreshXMListView(actorWidgetIndex-1,widget)
return
end
end

function UIXianJieJieYin_AskWin:onNewDay()
xianmengController:reqXMDataDetail()
jiuchongtianjieGuideController:req_xjGuideActorList()
end



