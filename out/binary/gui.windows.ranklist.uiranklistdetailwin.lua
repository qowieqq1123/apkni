







def_class("UIRankListDetailWin",UIWindowBase)









function UIRankListDetailWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.scrollView=UILoopListView.new(self,2)
self.titleList=UIObject.get(self,3)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.scrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIRankListDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
self.scrollView:deleteSelf();self.scrollView=nil;
_UIObject_release(self.titleList);self.titleList=nil;
end















local _this=nil
local _ab="ui/windows/ranklist/ranklist_atlas_pak.ab"
local _titlePosY=-4
local _titlePosX={
{-368.5,-182.5,308},
{-368.5,-182.5,308},
{-368.5,-182.5,308},
{-368.5,-222.5,75,324},
{-368.5,-182.5,308},
}



function UIRankListDetailWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onRankListRefresh,self.onRankListRefresh)
end


function UIRankListDetailWin:__delete()
self:unbindComponents()
_this=nil
end




function UIRankListDetailWin:onShow(argtable,afterOnloaded)
self.rankType=argtable.rank
self.itemType=argtable.type
self.args=argtable.args
self.server=argtable.server
if self.rankType==nil then
self:onCloseBtn()
return
end

self:refreshView()
self:refreshTitle()
end


function UIRankListDetailWin:onHide()

end




function UIRankListDetailWin:onBackground()
self:onCloseBtn()
end


function UIRankListDetailWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UIRankListDetailWin:refreshView()
self.rankList=rankListModel:getRankList(self.rankType)
local showNum=cfgHelper.get2(cfg_rankbasicconfig_get,1,"showNum")
local count=showNum[self.rankType]or showNum[0]
local createList={}
for i=1,count do
table.insert(createList,i)
end
self.scrollView:initData("item"..self.itemType,createList)
end

function UIRankListDetailWin:onFreshAction(index,widget)
local rankData=self.rankList[index]
self["refreshItem"..self.itemType](self,index,widget,rankData)
end

function UIRankListDetailWin:onStartAction()

end

function UIRankListDetailWin:refreshTitle()
local _posList=_titlePosX[self.itemType]
self.titleList:setChildLayoutGroupCreateItems(#_posList,function(index)
local item=self.titleList:getChildLayoutGroupGridItem(index-1)
local pos=_posList[index]
local str=self.args.detailTitles[index]or""
item:SetChildText(-1,str)
item:SetChildAnchoredPos(-1,pos,_titlePosY)
end)
end

function UIRankListDetailWin:onClickPlayer(index)
local rankData=self.rankList[index]
if rankData and rankData.actorId then
otherPlayerController:openOtherPlayerInfoWin(rankData.actorId,nil,nil,{serverid=rankData.server})
end
end

function UIRankListDetailWin:refreshItem1(index,widget,rankData)
local showRankImage=1<=index and index<=3
widget:SetChildActive(0,showRankImage)
widget:SetChildActive(2,not showRankImage)
if showRankImage then
widget:SetChildCSImageSprite(0,globalABLookup.global,'icon_phbmingci_'..index)
widget:SetChildText(1,index)
else
widget:SetChildText(2,index>0 and index or"未上榜")
end
widget:SetChildActive(8,rankData~=nil and rankData.actorId~=nil)
widget:SetChildActive(9,rankData==nil or rankData.actorId==nil)

if rankData and rankData.actorId then
widget:SetChildButtonClick(3,function()
self:onClickPlayer(index)
end)
playerController:setHeadIcon(widget,4,{iconInfo=rankData.head})
widget:SetChildText(5,rankData.playerName)
if self.server==1 then
widget:SetChildText(6,rankData.zmName or"")
else
local serverName=rankData.server and FMT.fmt("[{0}]",loginModel:getServerName(rankData.server))or""
widget:SetChildText(6,serverName)
end
local value=type(rankData.data[1])=="number"and rankData.data[1]or mathHelper.int64_to_number(rankData.data[1])
widget:SetChildText(7,mathHelper.formatNumber(value))
end
end

function UIRankListDetailWin:refreshItem2(index,widget,rankData)
local showRankImage=1<=index and index<=3
widget:SetChildActive(0,showRankImage)
widget:SetChildActive(2,not showRankImage)
if showRankImage then
widget:SetChildCSImageSprite(0,globalABLookup.global,'icon_phbmingci_'..index)
widget:SetChildText(1,index)
else
widget:SetChildText(2,index>0 and index or"未上榜")
end
widget:SetChildActive(10,rankData~=nil and rankData.actorId~=nil)
widget:SetChildActive(11,rankData==nil or rankData.actorId==nil)

if rankData and rankData.actorId then
widget:SetChildButtonClick(3,function()
self:onClickPlayer(index)
end)
playerController:setHeadIcon(widget,4,{iconInfo=rankData.head})
widget:SetChildText(5,rankData.playerName)
if self.server==1 then
widget:SetChildText(6,rankData.zmName or"")
else
local serverName=rankData.server and FMT.fmt("[{0}]",loginModel:getServerName(rankData.server))or""
widget:SetChildText(6,serverName)
end
widget:SetChildCSImageIcon(8,self.args.icon,false)
local value=type(rankData.data[1])=="number"and rankData.data[1]or mathHelper.int64_to_number(rankData.data[1])
widget:SetChildText(9,mathHelper.formatNumber(value))
widget:ForceLayoutRect(7)
end
end

function UIRankListDetailWin:refreshItem3(index,widget,rankData)
local showRankImage=1<=index and index<=3
widget:SetChildActive(0,showRankImage)
widget:SetChildActive(2,not showRankImage)
if showRankImage then
widget:SetChildCSImageSprite(0,globalABLookup.global,'icon_phbmingci_'..index)
widget:SetChildText(1,index)
else
widget:SetChildText(2,index>0 and index or"未上榜")
end
widget:SetChildActive(8,rankData~=nil and rankData.actorId~=nil)
widget:SetChildActive(9,rankData==nil or rankData.actorId==nil)

if rankData and rankData.actorId then
widget:SetChildButtonClick(3,function()
self:onClickPlayer(index)
end)
playerController:setHeadIcon(widget,4,{iconInfo=rankData.head})
widget:SetChildText(5,rankData.playerName)
if self.server==1 then
widget:SetChildText(6,rankData.zmName or"")
else
local serverName=rankData.server and FMT.fmt("[{0}]",loginModel:getServerName(rankData.server))or""
widget:SetChildText(6,serverName)
end
local showProgress=self.args.fullDetailSp==nil or rankData.percent<100
widget:SetChildActive(7,showProgress)
widget:SetChildActive(10,not showProgress)
if showProgress then
widget:SetChildProgressValue(7,rankData.percent,100)
widget:SetChildProgressText(7,FMT.fmt("{0}%",math.floor(rankData.percent*10)/10))
else
widget:SetChildCSImageSprite(10,_ab,self.args.fullDetailSp)
end
end
end

function UIRankListDetailWin:refreshItem4(index,widget,rankData)
local showRankImage=1<=index and index<=3
widget:SetChildActive(0,showRankImage)
widget:SetChildActive(2,not showRankImage)
if showRankImage then
widget:SetChildCSImageSprite(0,globalABLookup.global,'icon_phbmingci_'..index)
widget:SetChildText(1,index)
else
widget:SetChildText(2,index>0 and index or"未上榜")
end
widget:SetChildActive(9,rankData~=nil and rankData.actorId~=nil)
widget:SetChildActive(10,rankData==nil or rankData.actorId==nil)

if rankData and rankData.actorId then
widget:SetChildButtonClick(3,function()
self:onClickPlayer(index)
end)
playerController:setHeadIcon(widget,4,{iconInfo=rankData.head})
widget:SetChildText(5,rankData.playerName)
if self.server==1 then
widget:SetChildText(6,rankData.zmName or"")
else
local serverName=rankData.server and FMT.fmt("[{0}]",loginModel:getServerName(rankData.server))or""
widget:SetChildText(6,serverName)
end

local fabaoInfo=rankData.data[2]
fabaoHelper.handleItem(fabaoInfo)
local propData=itemsComponentHelper.getCommonFillData(fabaoInfo,{showStageBg=true,showCountBG=fabaoInfo.itemData.jilianlv>0})
widget:SetChildPropData(7,propData)
widget:SetBaseItemClickEvent(7,itemsComponentHelper.onItemClick)
local value=type(rankData.data[1])=="number"and rankData.data[1]or mathHelper.int64_to_number(rankData.data[1])
widget:SetChildText(8,mathHelper.formatNumber(value))
end
end

function UIRankListDetailWin:refreshItem5(index,widget,rankData)
local showRankImage=1<=index and index<=3
widget:SetChildActive(0,showRankImage)
widget:SetChildActive(2,not showRankImage)
if showRankImage then
widget:SetChildCSImageSprite(0,globalABLookup.global,'icon_phbmingci_'..index)
widget:SetChildText(1,index)
else
widget:SetChildText(2,index>0 and index or"未上榜")
end
widget:SetChildActive(8,rankData~=nil and rankData.actorId~=nil)
widget:SetChildActive(9,rankData==nil or rankData.actorId==nil)

if rankData and rankData.actorId then
widget:SetChildButtonClick(3,function()
self:onClickPlayer(index)
end)
playerController:setHeadIcon(widget,4,{iconInfo=rankData.head})
widget:SetChildText(5,rankData.playerName)
if self.server==1 then
widget:SetChildText(6,rankData.zmName or"")
else
local serverName=rankData.server and FMT.fmt("[{0}]",loginModel:getServerName(rankData.server))or""
widget:SetChildText(6,serverName)
end
widget:SetChildText(7,rankData.data[1])
end
end

function UIRankListDetailWin.onRankListRefresh(rankType)
if _this.rankType==rankType then
_this:refreshView()
end
end