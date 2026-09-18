







def_class("UIWDCQLiveBroadcastRoomHotRankListWin",UIWindowBase)









function UIWDCQLiveBroadcastRoomHotRankListWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.scrollerScript=UIEnhancedScrollerLua.get(self,2)
self.selfItem=UIObject.get(self,3)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIWDCQLiveBroadcastRoomHotRankListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.scrollerScript);self.scrollerScript=nil;
_UIObject_release(self.selfItem);self.selfItem=nil;
end















local _this=nil
local _itemCmp={
widget=-1,
rankImg=0,
rankNum=1,
hotNum=2,
noReward=3,
headBG=4,
head=5,
nameTx=6,
serverTx=7,
rewardList=8,
}
local _rankCmp={
widget=-1,
rankImg=0,
rankNum=1,
hotIcon=2,
hotNum=3,
noReward=4,
nameTx=5,
serverTx=6,
rewardList=7,
noPlayer=8,
headBG={9,10,11,12},
head={13,14,15,16},
}
local _rankImageCount=3
local UIPrepareEnScroller=simple_class(UIEnhancedScroller)



function UIWDCQLiveBroadcastRoomHotRankListWin:onLoaded(...)
self:bindComponents()
_this=self
self.enhancedscrollscript=UIPrepareEnScroller(self.scrollerScript:getGameObject(),self.scrollerScript:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self
self:addProNotify(38,25,self.on_38_25)
self:addNotify(notifyConfig.onRequestPhpServerNamesRecv,self.onRequestPhpServerNamesRecv)
end


function UIWDCQLiveBroadcastRoomHotRankListWin:__delete()
self:unbindComponents()
_this=nil
end




function UIWDCQLiveBroadcastRoomHotRankListWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.closeFunc=argtable.closeFunc

self:refreshView()
end


function UIWDCQLiveBroadcastRoomHotRankListWin:onHide()

end




function UIWDCQLiveBroadcastRoomHotRankListWin:onBackground()
end


function UIWDCQLiveBroadcastRoomHotRankListWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
elseif self.closeFunc then
self.closeFunc()
else
UIManager:closeWindow(self.__name)
end
end

function UIWDCQLiveBroadcastRoomHotRankListWin:onClickHead(index)
local rankData=self.rankList[index]
if rankData then


end
end

function UIWDCQLiveBroadcastRoomHotRankListWin.on_38_25(group,phase,order)
if _this.group==group and _this.phase==phase and _this.order==order then
_this:refreshView()
end
end

function UIWDCQLiveBroadcastRoomHotRankListWin:refreshView()
local group=wdcqLiveBroadcastRoomModel:getRoomGroup()
if group==nil then
self:onCloseBtn()
return
end

self:refreshData()
self:refreshList()
self:refreshOwner()
end

function UIWDCQLiveBroadcastRoomHotRankListWin:refreshData()
self.group=wdcqLiveBroadcastRoomModel:getRoomGroup()
self.rankList=wdcqLiveBroadcastRoomModel:getHotRank()or{}
self.ownHot=wdcqLiveBroadcastRoomModel:getOwnHot()or 0

self.ownRank=nil
for rank,rankData in ipairs(self.rankList)do
if playerModel:checkActorId(rankData.actorId)then
self.ownRank=rank
end
end

self.rewardCfg=cfgHelper.get3(cfg_wendingcangqiongzhibobasicconfig_get,1,"rdRankReward",self.group)
end

function UIWDCQLiveBroadcastRoomHotRankListWin:refreshList()
self.enhancedscrollscript:initData(self.rewardCfg,92,#self.rewardCfg)
end

function UIWDCQLiveBroadcastRoomHotRankListWin:refreshAllList()
self.enhancedscrollscript:doRefreshActiveCellViews()
end

function UIWDCQLiveBroadcastRoomHotRankListWin:refreshOwner()
local widget=self.selfItem:getChildWidgetBase()
playerController:setHeadIcon(widget,_itemCmp.head,{})
widget:SetChildText(_itemCmp.nameTx,playerModel:getActorName())
widget:SetChildText(_itemCmp.serverTx,FMT.fmt("[{0}]",loginModel:getMyServerName()))
widget:SetChildText(_itemCmp.hotNum,self.ownHot)
if self.ownRank then
widget:SetChildText(_itemCmp.rankNum,self.ownRank)
if self.ownRank<=_rankImageCount then
widget:SetChildCSImageSprite(_itemCmp.rankImg,globalABLookup.global,FMT.fmt("icon_phbmingci_{0}",self.ownRank))
else
widget:SetChildCSImageIcon(_itemCmp.rankImg,"",true)
end
widget:SetChildActive(_itemCmp.noReward,false)

local rewardList=nil
for i,v in ipairs(self.rewardCfg)do
local sRank=v[1]
local eRank=v[2]
if sRank<=self.ownRank and self.ownRank<=eRank then
rewardList=v[3]
break
end
end
local rewardNum=rewardList and#rewardList or 0
widget:SetChildActive(_itemCmp.noReward,rewardNum<=0)
widget:SetChildLayoutGroupCreateItems(_itemCmp.rewardList,rewardNum,function(index)
local rewardItem=widget:GetChildLayoutGroupGridItem(_itemCmp.rewardList,index-1)
local rewardData=rewardList[index]
local itemId=rewardData[1]
local itemNum=rewardData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(-1,prop)
rewardItem:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
else
widget:SetChildText(_itemCmp.rankNum,"未上榜")
widget:SetChildCSImageIcon(_itemCmp.rankImg,"",true)
widget:SetChildActive(_itemCmp.noReward,true)
widget:SetChildLayoutGroupCreateItems(_itemCmp.rewardList,0,nil)
end
end

function UIWDCQLiveBroadcastRoomHotRankListWin.onRequestPhpServerNamesRecv(secFlag)
if secFlag then
_this:refreshAllList()
end
end

function UIPrepareEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:RefreshCell(dataIndex,cellIndex,cell)
local rewardCfg=self.window.rewardCfg[dataIndex]
local sRank=rewardCfg[1]
local eRank=rewardCfg[2]
local rewardList=rewardCfg[3]
local rewardNum=rewardList and#rewardList or 0

cell:SetChildActive(_rankCmp.noReward,rewardNum<=0)
cell:SetChildLayoutGroupCreateItems(_rankCmp.rewardList,rewardNum,function(index)
local rewardItem=cell:GetChildLayoutGroupGridItem(_rankCmp.rewardList,index-1)
local rewardData=rewardList[index]
local itemId=rewardData[1]
local itemNum=rewardData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(-1,prop)
rewardItem:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)

if sRank~=eRank then
cell:SetChildText(_rankCmp.rankNum,FMT.fmt("{0}-{1}",sRank,eRank))
cell:SetChildCSImageIcon(_rankCmp.rankImg,"",true)
cell:SetChildActive(_rankCmp.hotIcon,false)
cell:SetChildActive(_rankCmp.hotNum,false)
cell:SetChildActive(_rankCmp.nameTx,false)
cell:SetChildActive(_rankCmp.serverTx,false)

local have=false
for i,v in ipairs(_rankCmp.headBG)do
local rank=sRank+i-1
if rank>eRank then
cell:SetChildActive(v,false)
else
local rankData=self.window.rankList[rank]
cell:SetChildActive(v,rankData~=nil)
if rankData then
playerController:setHeadIcon(cell,_rankCmp.head[i],{iconInfo=rankData.headIcon})
cell:SetChildButtonClick(v,function()
self.window:onClickHead(rank)
end)
have=true
end
end
end
cell:SetChildActive(_rankCmp.noPlayer,not have)
else
cell:SetChildText(_rankCmp.rankNum,sRank)
if sRank<=_rankImageCount then
cell:SetChildCSImageSprite(_rankCmp.rankImg,globalABLookup.global,FMT.fmt("icon_phbmingci_{0}",sRank))
else
cell:SetChildCSImageIcon(_rankCmp.rankImg,"",true)
end
for i=2,#_rankCmp.headBG do
cell:SetChildActive(_rankCmp.headBG[i],false)
end

local rankData=self.window.rankList[sRank]
local headBG=_rankCmp.headBG[1]
if rankData then
cell:SetChildActive(headBG,true)
cell:SetChildActive(_rankCmp.noPlayer,false)
cell:SetChildButtonClick(headBG,function()
self.window:onClickHead(sRank)
end)
playerController:setHeadIcon(cell,_rankCmp.head[1],{iconInfo=rankData.headIcon})
cell:SetChildActive(_rankCmp.hotIcon,true)
cell:SetChildActive(_rankCmp.hotNum,true)
cell:SetChildActive(_rankCmp.nameTx,true)
cell:SetChildActive(_rankCmp.serverTx,true)
cell:SetChildText(_rankCmp.hotNum,rankData.hot)
cell:SetChildText(_rankCmp.nameTx,rankData.actorName)
local serverName=loginModel:getServerNameEx(rankData.serverId,"")
cell:SetChildText(_rankCmp.serverTx,serverName)
else
cell:SetChildActive(headBG,false)
cell:SetChildActive(_rankCmp.noPlayer,true)
cell:SetChildActive(_rankCmp.hotIcon,false)
cell:SetChildActive(_rankCmp.hotNum,false)
cell:SetChildActive(_rankCmp.nameTx,false)
cell:SetChildActive(_rankCmp.serverTx,false)
end
end
end