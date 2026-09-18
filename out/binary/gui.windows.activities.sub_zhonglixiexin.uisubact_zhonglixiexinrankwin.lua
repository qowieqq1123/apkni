







def_class("UISubAct_ZhongLiXieXinRankWin",UIWindowBase)









function UISubAct_ZhongLiXieXinRankWin:bindComponents()

self.myInfo=UIObject.get(self,0)
self.noHaveRank=UIObject.get(self,1)
self.rewardPreviewBtn=UIButton.get(self,2)
self.scrollView=UILoopListView.new(self,3)

self.rewardPreviewBtn:setButtonClick(function()self:onRewardPreviewBtn()end)

self.scrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UISubAct_ZhongLiXieXinRankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.myInfo);self.myInfo=nil;
_UIObject_release(self.noHaveRank);self.noHaveRank=nil;
_UIObject_release(self.rewardPreviewBtn);self.rewardPreviewBtn=nil;
self.scrollView:deleteSelf();self.scrollView=nil;
end
















local _this




function UISubAct_ZhongLiXieXinRankWin:onLoaded(...)
self:bindComponents()
_this=self

self.rankGridPanelCmp=self.winlua:GetChildLoopListView2(self.scrollView:getID())
end


function UISubAct_ZhongLiXieXinRankWin:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_ZhongLiXieXinRankWin:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)

self.min_rank_score=self.sub_actcfg.min_rank_score
self.score_name=self.sub_actcfg.score_name
self:refresh()
end


function UISubAct_ZhongLiXieXinRankWin:onHide()

end

function UISubAct_ZhongLiXieXinRankWin:onStartAction()

end


function UISubAct_ZhongLiXieXinRankWin:onFreshAction(index,widget)
self:refreshItem(widget,index)
end

function UISubAct_ZhongLiXieXinRankWin:refresh()
local itemIdList={}
self.scrollView:initData("item",itemIdList)

local myRankData=self.sub_actInfo:getMyRankData()
self.myWidght=myRankData and myRankData.widght or 0
self.rankDatas=self.sub_actInfo:getRankList()or{}
local rankLen=#self.rankDatas

self.noHaveRank:setActive(rankLen==0)
self.scrollView:setActive(rankLen>0)

if rankLen>0 then
for i=1,rankLen do
itemIdList[i]=i
end
self.scrollView:initData("item",itemIdList)
local nowShowItemCount=self.rankGridPanelCmp.ShownItemCount
for i=0,nowShowItemCount-1 do
local item=self.rankGridPanelCmp:GetShownItemByIndex(i)
local index=item.ItemIndex+1
if item then
self:refreshItem(item.Widget,index)
end
end
end

self:setMyInfo()
end


function UISubAct_ZhongLiXieXinRankWin:refreshItem(widget,index)
if not _this then return end
local i=index
local data=_this.rankDatas[i]
local rank=data and data.rank or i
widget:SetChildText(0,rank)
if data~=nil and data.score>=_this.min_rank_score then
widget:SetChildActive(1,true)
playerController:setHeadIcon(widget,1,{scale=0.6,iconInfo=data.iconInfo})
widget:SetChildText(2,data.actor_name)
widget:SetChildText(3,FMT.fmt('{0}{1}',data.score,_this.score_name))

local actor_id=data.actor_id
local server_id=data.server_id
widget:SetChildButtonClick(4,function()
local attach={serverid=server_id}
otherPlayerController:openOtherPlayerInfoWin(actor_id,true,nil,attach)
end)
widget:SetChildActive(4,i~=_this.myWidght)
widget:SetChildActive(5,i==_this.myWidght)
widget:SetChildActive(9,i==_this.myWidght)
else
widget:SetChildActive(1,false)
widget:SetChildText(2,"")
widget:SetChildText(3,"")
widget:SetChildActive(4,false)
widget:SetChildActive(5,false)
widget:SetChildActive(9,false)
end
widget:SetChildActive(6,rank==1)
widget:SetChildActive(7,rank==2)
widget:SetChildActive(8,rank==3)
widget:SetChildActive(11,not data or data.score<_this.min_rank_score)


local rewards=_this.sub_actInfo:getRankReward(rank)
local bindItem=function(idx)
local item=widget:GetChildLayoutGroupGridItem(10,idx-1)
local reward=rewards[idx]
local rewardCount=reward[2]
local countStr=''
local showCountBG=false
if rewardCount>1 then
showCountBG=true
countStr=reward[2]
end
local prop=itemsComponentHelper.getCommonFillDataSmall({itemid=reward[1],itemcount=countStr,showCountBG=showCountBG,showname=false})
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end
widget:SetChildLayoutGroupCreateItems(10,#rewards,bindItem)
end

function UISubAct_ZhongLiXieXinRankWin:setMyInfo()
local myRankData=self.sub_actInfo:getMyRankData()
local score=self.sub_actInfo:getMyScore()or 0

local myRank=myRankData and myRankData.rank or 0
local myWidght=myRankData and myRankData.widght or 0
local isInList=myWidght>0 and myWidght<=#self.rankDatas and score>=self.min_rank_score
local widget=self.myInfo:getChildWidgetBase()
widget:SetChildText(0,isInList and FMT.fmt("排名：{0}",myRank)or'未上榜')
widget:SetChildText(1,FMT.fmt('我的{0}：{1}',self.score_name,score))
widget:SetChildText(2,FMT.fmt('{0}{1}以上即可参与排名',self.min_rank_score,self.score_name))
end




function UISubAct_ZhongLiXieXinRankWin:onCloseClick()
self:closeSelf()
end

function UISubAct_ZhongLiXieXinRankWin:onRewardPreviewBtn()
local args={}
args.act_id=self.actID
args.sub_act_type=self.subType
args.sub_act_id=self.subid
self:showWindow("UISubAct_ZhongLiXieXinRewardPreviewWin",args)
end
