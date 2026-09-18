







def_class("UISubAct_wxbtRankWin",UIWindowBase)









function UISubAct_wxbtRankWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.rankItem=UIObject.get(self,1)
self.rankPanel=UIObject.get(self,2)
self.rankScrollView=UIEnhancedScrollerLua.get(self,3)
self.root=UIObject.get(self,4)
self.tipsTxt=UIText.get(self,5)
self.titleTxt=UIText.get(self,6)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISubAct_wxbtRankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.rankItem);self.rankItem=nil;
_UIObject_release(self.rankPanel);self.rankPanel=nil;
_UIObject_release(self.rankScrollView);self.rankScrollView=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
end
















local UISubAct_wxbtRankScroller=simple_class(UIEnhancedScroller)
local _this=nil


function UISubAct_wxbtRankWin:onLoaded(...)
_this=self
self:bindComponents()
self.scrollscript=UISubAct_wzdjRankScroller(self.rankScrollView:getGameObject(),self.rankScrollView:getCSharpObject(),nil,nil)
end


function UISubAct_wxbtRankWin:__delete()
_this=nil
self:unbindComponents()
end


function UISubAct_wxbtRankWin:onHide()

end




function UISubAct_wxbtRankWin:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)

self:refreshView()








end

function UISubAct_wxbtRankWin:refreshView()
self:refreshInfo()

self:initRank()
self:refreshRankItem()
end

function UISubAct_wxbtRankWin:refreshInfo()

local limit=self.sub_actcfg.rank_min_score
local tips_str=FMT.fmt('排名前100且至少达到{0}积分的祖师，在活动结束后可获得排名奖励',limit)
self.tipsTxt:setText(tips_str)
end



function UISubAct_wxbtRankWin:initRank(reqBack)
local ranklist,lerp,isshow
ranklist,lerp=self.sub_actInfo:getRankList()
self.rankList=ranklist
isshow=ranklist~=nil
local showTips=false
self.rankPanel:setActive(isshow)
self.curRank=nil
self.curScore=nil
if isshow then
local num=#self.rankList
showTips=num<=0
local myActorid=playerModel:getActorID()
for i,data in ipairs(ranklist)do
if mathHelper.compareInt64(myActorid,data.actorid)then
self.curRank=data.rank
self.curScore=data.score
break
end
end
self.scrollscript:initData(ranklist,118,num)
else
showTips=false
if not reqBack then
if self.reqRankLookup==nil then
self.reqRankLookup={}
end
local func=function()

self.reqRankTimer=nil
local jstr=jsonHelper.encode({2})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actID,self.subType,self.subid,jstr)
end
if lerp~=nil then
if self.reqRankTimer==nil then
self.reqRankTimer=self:delayDo(lerp,func)
end
else
if self.reqRankTimer~=nil then
self:stopTimerByID(self.reqRankTimer)
self.reqRankTimer=nil
end
func()
end
end
end
self.noItemTips:setActive(showTips)
end

function UISubAct_wxbtRankScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UISubAct_wxbtRankScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UISubAct_wxbtRankScroller:RefreshCell(dataIndex,cellIndex,item)
if _this==nil then return end
self:RefreshCell(dataIndex,item)
end

function UISubAct_wxbtRankScroller:RefreshCell1(dataIndex,item)
if _this==nil then return end
local data=_this.rankList[dataIndex]

local rank=data.rank
local rank2=data.rank2

local rankIcon
local rank_str=tostring(rank)
if rank<=3 and rank2==nil then
rankIcon=FMT.fmt('icon_phbmingci_{0}',rank)
end
local showRankIcon=rankIcon~=nil
item:SetChildActive(0,showRankIcon)
item:SetChildActive(2,not showRankIcon)
if showRankIcon then
item:SetChildCSImageSprite(0,globalABLookup.global,rankIcon)
item:SetChildText(1,tostring(rank))
else
item:SetChildText(2,FMT.fmt('{0}-{1}',rank,rank2))
end

local hasMan=data.iconInfo~=nil
item:SetChildActive(3,hasMan)
item:SetChildActive(7,not hasMan)
if hasMan==true then

local args={iconInfo=data.iconInfo,scale=0.8}
playerController:setHeadIcon(item,4,args)

item:SetChildText(5,data.actorname)

item:SetChildText(6,FMT.fmt('{0}积分',data.score))
end

local rewardList=data.rewardList
local c=0
if rewardList~=nil then
c=#rewardList
end
local showReward=c>0
item:SetChildActive(8,showReward)
item:SetChildActive(9,not showReward)
if showReward then
item:SetChildLayoutGroupCreateItems(8,c)
local grids2=item:GetChildLayoutGroupGridList(8)
for i=1,c do
local rewardItem=grids2[i-1]
local itemid=rewardList[i][1]
local itemnum=rewardList[i][2]
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
end
end



function UISubAct_wxbtRankWin:getRewardList(rank,score)
return self.sub_actInfo:getRewardInRank(rank,score)
end

function UISubAct_wxbtRankWin:refreshRankItem()
local item=self.rankItem:getChildWidgetBase()

local rank=self.curRank
local score=self.curScore
if rank==nil then
score=self.sub_actInfo:getScore()
rank=self.sub_actInfo:getRank()
end
local rankIcon
local rank_str
local isNotRank=rank==nil or rank==0
if isNotRank then
rank_str='暂无名次'
else
rank_str=tostring(rank)
end
if not isNotRank and rank<=3 then
rankIcon=FMT.fmt('icon_phbmingci_{0}',rank)
end
local showRankIcon=rankIcon~=nil
item:SetChildActive(0,showRankIcon)
item:SetChildActive(2,not showRankIcon)
if showRankIcon then
item:SetChildCSImageSprite(0,globalABLookup.global,rankIcon)
item:SetChildText(1,rank_str)
else
item:SetChildText(2,rank_str)
end

local args={iconInfo=nil,scale=0.8}
playerController:setHeadIcon(item,3,args)

item:SetChildText(4,playerModel:getActorName())

item:SetChildText(5,FMT.fmt('{0}积分',score))

local rewardList=self:getRewardList(rank,score)
local c=0
if rewardList~=nil then
c=#rewardList
end
local showReward=c>0
item:SetChildActive(6,showReward)
item:SetChildActive(7,not showReward)
if showReward then
item:SetChildLayoutGroupCreateItems(6,c)
local grids2=item:GetChildLayoutGroupGridList(6)
for i=1,c do
local rewardItem=grids2[i-1]
local itemid=rewardList[i][1]
local itemnum=rewardList[i][2]
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
end
end

function UISubAct_wxbtRankWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UISubAct_wxbtRankWin:onCloseBtn()
self:closeSelf()
end