







def_class("UIRankListTop3Win_4",UIWindowBase)









function UIRankListTop3Win_4:bindComponents()

self.myItem=UIObject.get(self,0)
self.player_1=UIObject.get(self,1)
self.player_2=UIObject.get(self,2)
self.player_3=UIObject.get(self,3)
self.tabList=UIObject.get(self,4)
self.player={
self.player_1,
self.player_2,
self.player_3,
}



end


function UIRankListTop3Win_4:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.myItem);self.myItem=nil;
_UIObject_release(self.player_1);self.player_1=nil;
_UIObject_release(self.player_2);self.player_2=nil;
_UIObject_release(self.player_3);self.player_3=nil;
_UIObject_release(self.tabList);self.tabList=nil;
self.player=nil;
end















local _this=nil
local _tabCmp={
root=-1,
select=0,
name=1,
}
local _playerCmp={
have=0,
item=1,
empty=2,
infoBg=3,
nameTx=4,
serverTx=5,
headBG=6,
head=7,
infoTx=8,
}
local _ownerCmp={
rankImage=0,
rankImageTx=1,
rankTx=2,
item=3,
helpBtn=4,
detailBtn=5,
infoTx=6,
}



function UIRankListTop3Win_4:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onRankListRefresh,self.onRankListRefresh)

self.ownerWidget=self.myItem:getChildWidgetBase()
self.ownerWidget:SetChildButtonClick(_ownerCmp.helpBtn,function()
self:onClickHelpBtn()
end)
self.ownerWidget:SetChildButtonClick(_ownerCmp.detailBtn,function()
self:onClickDetailBtn()
end)
self.ownerWidget:SetBaseItemClickEvent(_ownerCmp.item,itemsComponentHelper.onItemClick)

self.playerWidget={}
for i,v in ipairs(self.player)do
local playerWidget=v:getChildWidgetBase()
playerWidget:SetChildButtonClick(_playerCmp.headBG,function()
self:onClickPlayer(i)
end)
playerWidget:SetChildButtonClick(_playerCmp.infoBg,function()
self:onClickPlayer(i)
end)
playerWidget:SetBaseItemClickEvent(_playerCmp.item,itemsComponentHelper.onItemClick)
self.playerWidget[i]=playerWidget
end
end


function UIRankListTop3Win_4:__delete()
self:unbindComponents()
end




function UIRankListTop3Win_4:onShow(argtable,afterOnloaded)
self.server=argtable.server
self.rank=argtable.rank
self.args=argtable.args
self.tabIndex=argtable.tab or 1

self:refreshTabList()
self:refreshPanel()

self.ownerWidget:SetChildActive(_ownerCmp.helpBtn,self.args.help~=nil)
self.ownerWidget:SetChildActive(_ownerCmp.detailBtn,self.args.detail~=0)
end


function UIRankListTop3Win_4:onHide()

end



function UIRankListTop3Win_4:onClickHelpBtn()
if self.args.help then
local d={}
d.title='规则'
d.mode=3
d.name=self.args.help
UIManager:showWindow('UIRuleWin',d)
end
end

function UIRankListTop3Win_4:onClickDetailBtn()
local args={
rank=self.rank[self.tabIndex],
type=4,
args=self.args,
server=self.server,
}
self:showWindow("UIRankListDetailWin",args)
end

function UIRankListTop3Win_4:onClickTab(index)
if self.tabIndex~=index then
if self.tabIndex then
local item=self.tabList:getChildLayoutGroupGridItem(self.tabIndex-1)
item:SetChildActive(_tabCmp.select,false)
end

self.tabIndex=index

local item=self.tabList:getChildLayoutGroupGridItem(self.tabIndex-1)
item:SetChildActive(_tabCmp.select,true)

self:refreshPanel()
end
end

function UIRankListTop3Win_4:onClickPlayer(index)
local rankData=self.rankList[index]
if rankData and rankData.actorId then
local attach={serverid=rankData.server}
attach.isXianJie=self.server==3
otherPlayerController:openOtherPlayerInfoWin(rankData.actorId,nil,nil,attach)
end
end

function UIRankListTop3Win_4:refreshTabList()
local rankNum=#self.rank
if rankNum>1 then
self.tabList:setChildLayoutGroupCreateItems(#self.rank,function(index)
local item=self.tabList:getChildLayoutGroupGridItem(index-1)
item:SetChildButtonClick(_tabCmp.root,function()
self:onClickTab(index)
end)
item:SetChildActive(_tabCmp.select,self.tabIndex==index)
item:SetChildText(_tabCmp.name,self.args.tabNames[index])
end)
else
self.tabList:setChildLayoutGroupCreateItems(0)
end
end

function UIRankListTop3Win_4:refreshPanel()
local rankType=self.rank[self.tabIndex]
self.rankList=rankListModel:getRankList(rankType)
for i,v in ipairs(self.player)do
self:refreshPlayer(i)
end
self.onwerData=rankListModel:getPlayerInfo(rankType)
self:refeshOwner(rankType)
end

function UIRankListTop3Win_4:refreshPlayer(index)
local widget=self.playerWidget[index]
local rankData=self.rankList[index]
widget:SetChildActive(_playerCmp.empty,rankData==nil or rankData.actorId==nil)
widget:SetChildActive(_playerCmp.have,rankData~=nil and rankData.actorId~=nil)
widget:SetChildActive(_playerCmp.infoBg,rankData~=nil and rankData.actorId~=nil)
if rankData and rankData.actorId then
local fabaoInfo=rankData.data[2]
fabaoHelper.handleItem(fabaoInfo)
local propData=itemsComponentHelper.getCommonFillData(fabaoInfo,{showStageBg=true,showCountBG=fabaoInfo.itemData.jilianlv>0})
widget:SetChildPropData(_playerCmp.item,propData)
playerController:setHeadIcon(widget,_playerCmp.head,{iconInfo=rankData.head})
widget:SetChildText(_playerCmp.nameTx,rankData.playerName)
if self.server==1 then
widget:SetChildActive(_playerCmp.serverTx,rankData.zmName~=nil)
if rankData.zmName then
widget:SetChildText(_playerCmp.serverTx,rankData.zmName)
end
else
widget:SetChildActive(_playerCmp.serverTx,rankData.server~=nil)
if rankData.server then
local serverName=FMT.fmt("[{0}]",loginModel:getServerName(rankData.server))
widget:SetChildText(_playerCmp.serverTx,serverName)
end
end
local value=type(rankData.data[1])=="number"and rankData.data[1]or mathHelper.int64_to_number(rankData.data[1])
local infoStr=FMT.fmt(self.args.infoStr,mathHelper.formatNumber(value))
widget:SetChildText(_playerCmp.infoTx,infoStr)
end
end

function UIRankListTop3Win_4:refeshOwner(rankType)
local number=self.onwerData.number
local showRankImage=1<=number and number<=3
self.ownerWidget:SetChildActive(_ownerCmp.rankImage,showRankImage)
self.ownerWidget:SetChildActive(_ownerCmp.rankTx,not showRankImage)
if showRankImage then
self.ownerWidget:SetChildCSImageSprite(_ownerCmp.rankImage,globalABLookup.global,'icon_phbmingci_'..number)
self.ownerWidget:SetChildText(_ownerCmp.rankImageTx,number)
else
self.ownerWidget:SetChildText(_ownerCmp.rankTx,number>0 and number or"未上榜")
end

if self.onwerData.data then
self.ownerWidget:SetChildActive(_ownerCmp.item,true)
local fabao=fabaoHelper.getFabao(self.onwerData.data)
local fightValue=fabaoHelper.getFabaoFight(self.onwerData.data)
local propData=itemsComponentHelper.getCommonFillData(fabao,{showStageBg=true,showCountBG=fabao.itemData.jilianlv>0})
self.ownerWidget:SetChildPropData(_ownerCmp.item,propData)
local infoStr=FMT.fmt(self.args.infoStr,mathHelper.formatNumber(fightValue))
self.ownerWidget:SetChildText(_ownerCmp.infoTx,infoStr)
else
self.ownerWidget:SetChildActive(_ownerCmp.item,false)
self.ownerWidget:SetChildText(_ownerCmp.infoTx,"暂无")
end
end

function UIRankListTop3Win_4.onRankListRefresh(rankType)
if rankType==_this.rank[_this.tabIndex]then
_this:refreshPanel()
end
end