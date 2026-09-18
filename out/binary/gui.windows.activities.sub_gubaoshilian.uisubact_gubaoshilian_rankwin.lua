







def_class("UISubAct_GuBaoShiLian_RankWin",UIWindowBase)









function UISubAct_GuBaoShiLian_RankWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.myRank=UIObject.get(self,2)
self.rankView=UILoopListView.new(self,3)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.rankView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UISubAct_GuBaoShiLian_RankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.myRank);self.myRank=nil;
self.rankView:deleteSelf();self.rankView=nil;
end















local _this=nil
local _rankCmp={
rankIcon=0,
rankIconTx=1,
rankTx=2,
levelTx=3,
rewardList=4,
playerList=5,
}
local _myCmp={
rankIcon=0,
rankIconTx=1,
rankTx=2,
head=3,
playerName=4,
levelTx=5,
rewardList=6,
}
local _rankImage=3
local _rankPlayer=4



function UISubAct_GuBaoShiLian_RankWin:onLoaded(...)
self:bindComponents()
_this=self

self:addProNotify(247,54,self.on_247_54)
end


function UISubAct_GuBaoShiLian_RankWin:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_GuBaoShiLian_RankWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
if not self.info then
self:onCloseBtn()
end
self:refreshView()
end


function UISubAct_GuBaoShiLian_RankWin:onHide()

end




function UISubAct_GuBaoShiLian_RankWin:onBackground()
self:onCloseBtn()
end


function UISubAct_GuBaoShiLian_RankWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UISubAct_GuBaoShiLian_RankWin:onClickRankActor(index)
local rankData=self.info:getRankData(index)
if rankData then
otherPlayerController:openOtherPlayerInfoWin(rankData.actor_id,nil,nil,nil)
end
end

function UISubAct_GuBaoShiLian_RankWin:onStartAction()

end

function UISubAct_GuBaoShiLian_RankWin:onFreshAction(i,widget,data)
local config=self.config.rank_reward[i]
local min=config[1]
local max=config[2]
local items=config[3]
local onlyOne=min==max
local showRankIcon=onlyOne and min<=_rankImage
if showRankIcon then
widget:SetChildCSImageSprite(_rankCmp.rankIcon,globalABLookup.global,FMT.fmt("icon_phbmingci_{0}",min))
widget:SetChildText(_rankCmp.rankIconTx,min)
else
widget:SetChildText(_rankCmp.rankTx,onlyOne and min or FMT.fmt("{0}-{1}",min,max))
end
widget:SetChildLayoutGroupCreateItems(_rankCmp.rewardList,#items,function(index)
local item=widget:GetChildLayoutGroupGridItem(_rankCmp.rewardList,index-1)
local reward=items[index]
local itemId=reward[1]
local itemNum=reward[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local itemConf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local itemProp=itemsComponentHelper.getCommonFillDataSmall(itemConf)
item:SetChildPropData(-1,itemProp)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
if onlyOne then
local rankData=self.info:getRankData(min)
widget:SetChildLayoutGroupCreateItems(_rankCmp.playerList,1,function(index)
local item=widget:GetChildLayoutGroupGridItem(_rankCmp.playerList,index-1)
item:SetChildButtonClick(-1,function()
self:onClickRankActor(min)
end)
item:SetChildActive(0,rankData==nil)
playerController:setHeadIcon(item,1,rankData and{iconInfo=rankData.iconInfo}or nil)
item:SetChildText(2,rankData==nil and"虚位以待"or rankData.actor_name)
end)
widget:SetChildText(_rankCmp.levelTx,rankData==nil and""or FMT.fmt("{0}层",rankData.layer_id))
else
local dataList={}
for i=1,_rankPlayer do
local rankData=self.info:getRankData(min+i-1)
if rankData then
table.insert(dataList,rankData)
else
break
end
end
if#dataList>0 then
widget:SetChildLayoutGroupCreateItems(_rankCmp.playerList,_rankPlayer,function(index)
local item=widget:GetChildLayoutGroupGridItem(_rankCmp.playerList,index-1)
local data=dataList[index]
item:SetChildButtonClick(-1,function()
self:onClickRankActor(min+index-1)
end)
item:SetChildActive(0,data==nil)
playerController:setHeadIcon(item,1,data and{iconInfo=data.iconInfo}or nil)
item:SetChildText(2,"")
end)
else
widget:SetChildLayoutGroupCreateItems(_rankCmp.playerList,1,function(index)
local item=widget:GetChildLayoutGroupGridItem(_rankCmp.playerList,index-1)
item:SetChildButtonClick(-1,function()
self:onClickRankActor(min)
end)
item:SetChildActive(0,true)
playerController:setHeadIcon(item,1,nil)
item:SetChildText(2,"虚位以待")
end)
end
widget:SetChildText(_rankCmp.levelTx,"")
end
end

function UISubAct_GuBaoShiLian_RankWin:refreshView()
local rankCfgs=self.config.rank_reward
local myNo=self.info:getMyRank()
local createList={}
for i,v in ipairs(rankCfgs)do
createList[#createList+1]=i
end
self.rankView:initData('rankItem',createList)

local myWidget=self.myRank:getChildWidgetBase()
local showRankIcon=myNo>0 and myNo<=_rankImage
myWidget:SetChildActive(_myCmp.rankIcon,showRankIcon)
myWidget:SetChildActive(_myCmp.rankTx,not showRankIcon)
if showRankIcon then
myWidget:SetChildCSImageSprite(_myCmp.rankIcon,globalABLookup.global,FMT.fmt("icon_phbmingci_{0}",myNo))
myWidget:SetChildText(_myCmp.rankIconTx,myNo)
else
myWidget:SetChildText(_myCmp.rankTx,myNo>0 and myNo or"未上榜")
end
playerController:setHeadIcon(myWidget,_myCmp.head,{})
myWidget:SetChildText(_myCmp.playerName,playerModel:getActorName())

myWidget:SetChildText(_myCmp.levelTx,FMT.fmt("{0}层",self.info:getData()))

local rewards=nil
for i,v in ipairs(self.config.rank_reward)do
if v[1]<=myNo and myNo<=v[2]then
rewards=v[3]
break
end
end
local rewardCnt=rewards and#rewards or 0
myWidget:SetChildLayoutGroupCreateItems(_myCmp.rewardList,rewardCnt,function(index)
local item=myWidget:GetChildLayoutGroupGridItem(_myCmp.rewardList,index-1)
local reward=rewards[index]
local itemId=reward[1]
local itemNum=reward[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local itemConf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local itemProp=itemsComponentHelper.getCommonFillDataSmall(itemConf)
item:SetChildPropData(-1,itemProp)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
end

function UISubAct_GuBaoShiLian_RankWin.on_247_54(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eGuBaoShiLian
if _this.info and _this.info:compare(actId,subType,subId)then
_this:refreshView()
end
end