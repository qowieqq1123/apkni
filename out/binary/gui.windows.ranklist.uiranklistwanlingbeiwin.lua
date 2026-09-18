







def_class("UIRankListWanLingBeiWin",UIWindowBase)









function UIRankListWanLingBeiWin:bindComponents()

self.root=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.middleList=UIScrollView.get(self,2)
self.player=UIObject.get(self,3)
self.none=UIObject.get(self,4)
self.talk=UIObject.get(self,5)
self.ScrollerScript=UIEnhancedScrollerLua.get(self,6)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIRankListWanLingBeiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.middleList);self.middleList=nil;
_UIObject_release(self.player);self.player=nil;
_UIObject_release(self.none);self.none=nil;
_UIObject_release(self.talk);self.talk=nil;
_UIObject_release(self.ScrollerScript);self.ScrollerScript=nil;
end
















local _this=nil
local rankCmp={
leftframe=0,
rightframe=1,
rankframe=2,
rankNo=3,
headBg=4,
fightValue=5,
head=6,


levelTx=8,
playerName=9,
item=10,
}
local playerCmp={
rankFrame=0,
rankNo=1,
fightValue=2,
head=3,


levelTx=5,
playerName=6,
noneItem=7,
item=8,
}
local UIPrepareEnScroller=simple_class(UIEnhancedScroller)



function UIRankListWanLingBeiWin:onLoaded(...)
self:bindComponents()
_this=self
self.playerWidget=self.player:getChildWidgetBase()
self.playerWidget:SetBaseItemClickEvent(playerCmp.item,function(...)
self:onClickItem(...)
end)



self.enhancedscrollscript=UIPrepareEnScroller(self.ScrollerScript:getGameObject(),self.ScrollerScript:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self

notifySystem:listenNotify(notifyConfig.onRankListRefresh,self.onRankListRefresh)
end


function UIRankListWanLingBeiWin:__delete()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.onRankListRefresh,self.onRankListRefresh)
end




function UIRankListWanLingBeiWin:onShow(argtable,afterOnloaded)
self.root:setActive(true)
self:refreshList()
self:refreshPlayer()
self.enhancedscrollscript:jumpToDataIndex(0,0,0,true,0,0,nil)
end


function UIRankListWanLingBeiWin:onHide()
self.root:setActive(false)
end




function UIRankListWanLingBeiWin:onCloseBtn()
UIFullZaoHuaTianBeiControl:closeWanLingBei()
end

function UIRankListWanLingBeiWin:refreshList()
self.rankList=rankListModel:getRankList(eRankListType.eFaBaoFight)
local rankMax=#self.rankList

self.none:setActive(rankMax<=0)
self.enhancedscrollscript:initData(self.rankList,94,rankMax)













































end

function UIRankListWanLingBeiWin:refreshPlayer()
local playerInfo=rankListModel:getPlayerInfo(eRankListType.eFaBaoFight)

playerController:setHeadIcon(self.playerWidget,playerCmp.head,{iconInfo=playerInfo.head})







self.playerWidget:SetChildText(playerCmp.levelTx,playerInfo.zmLevel)
self.playerWidget:SetChildText(playerCmp.playerName,playerInfo.playerName)










local numStr=rankListModel.getNumberStr(playerInfo.number)
self.playerWidget:SetChildText(playerCmp.rankNo,numStr)







self.playerWidget:SetChildActive(playerCmp.noneItem,playerInfo.data==nil)



if playerInfo.data then
local fabao=fabaoHelper.getFabao(playerInfo.data)
local fightValue=fabaoHelper.getFabaoFight(playerInfo.data)
local propData=itemsComponentHelper.getCommonFillData(fabao,{showbg=true,showStageBg=true})
self.playerWidget:SetChildPropData(playerCmp.item,propData)
self.playerWidget:SetChildText(playerCmp.fightValue,fightValue)
end



















end

function UIRankListWanLingBeiWin:onClickHead(index)
local rankData=self.rankList[index]
if rankData and rankData.actorId then
local attach={
type=otherPlayerController.eAttachType.Rank,
rankType=eRankListType.eFaBaoFight,
}
otherPlayerController:openOtherPlayerInfoWin(rankData.actorId,true,nil,attach)
end
end

function UIRankListWanLingBeiWin:onClickItem(itemid,index,itemguid,attach)
itemsComponentHelper.onItemClick(itemid,index,itemguid,attach)
end

function UIRankListWanLingBeiWin.onRankListRefresh(rankType)
if rankType==eRankListType.eFaBaoFight then
_this:refreshList()
_this:refreshPlayer()
end
end
























































function UIPrepareEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:RefreshCell(dataIndex,cellIndex,cell)
local itemCmp=cell
local rankData=self.window.rankList[dataIndex]
local frame2=rankListModel.getFrameName2(rankData.rankNum)
local frame1=rankListModel.getFrameName(rankData.rankNum)
local numStr=rankListModel.getNumberStr(rankData.rankNum)
if frame2 then
itemCmp:SetChildCSImageSprite(rankCmp.leftframe,globalABLookup.rankList,frame2)
itemCmp:SetChildCSImageSprite(rankCmp.rightframe,globalABLookup.rankList,frame2)
else
itemCmp:SetChildIcon(rankCmp.leftframe,"",false)
itemCmp:SetChildIcon(rankCmp.rightframe,"",false)
end
if frame1 then
itemCmp:SetChildCSImageSprite(rankCmp.rankframe,globalABLookup.rankList,frame1)
else
itemCmp:SetChildIcon(rankCmp.rankframe,"",false)
end
itemCmp:SetChildText(rankCmp.rankNo,numStr)

playerController:setHeadIcon(itemCmp,rankCmp.head,{iconInfo=rankData.head})

itemCmp:SetChildText(rankCmp.levelTx,rankData.zmLevel)
itemCmp:SetChildText(rankCmp.playerName,rankData.playerName)

itemCmp:SetChildText(rankCmp.fightValue,tostring(rankData.data[1]))

fabaoHelper.handleItem(rankData.data[2])
local propData=itemsComponentHelper.getCommonFillData(rankData.data[2],{showStageBg=true})
itemCmp:SetChildPropData(rankCmp.item,propData)
itemCmp:SetBaseItemClickEvent(rankCmp.item,function(...)
self.window:onClickItem(...)
end)

itemCmp:SetChildButtonClick(rankCmp.headBg,function()
self.window:onClickHead(dataIndex)
end)
end