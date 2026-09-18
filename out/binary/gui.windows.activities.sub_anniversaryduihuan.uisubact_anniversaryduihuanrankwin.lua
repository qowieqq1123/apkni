







def_class("UISubAct_AnniversaryDuiHuanRankWin",UIWindowBase)









function UISubAct_AnniversaryDuiHuanRankWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.item=UIObject.get(self,1)
self.notRank=UIText.get(self,2)
self.rankButton=UIButton.get(self,3)
self.rankScrollView=UIEnhancedScrollerLua.get(self,4)
self.rewardButton=UIButton.get(self,5)
self.ScrollView=UIObject.get(self,6)
self.timeText=UIText.get(self,7)
self.title=UIText.get(self,8)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.rankButton:setButtonClick(function()self:onRankButton()end)

self.rewardButton:setButtonClick(function()self:onRewardButton()end)



end


function UISubAct_AnniversaryDuiHuanRankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.item);self.item=nil;
_UIObject_release(self.notRank);self.notRank=nil;
_UIObject_release(self.rankButton);self.rankButton=nil;
_UIObject_release(self.rankScrollView);self.rankScrollView=nil;
_UIObject_release(self.rewardButton);self.rewardButton=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.title);self.title=nil;
end
















local _this
local UISubAct_AnniversaryDuiHuan_rankScroller=simple_class(UIEnhancedScroller)




function UISubAct_AnniversaryDuiHuanRankWin:onLoaded(...)
_this=self
self:bindComponents()

self.selectTabIndex=1

self.rankscrollscript=UISubAct_AnniversaryDuiHuan_rankScroller(self.rankScrollView:getGameObject(),self.rankScrollView:getCSharpObject(),nil,nil)
end


function UISubAct_AnniversaryDuiHuanRankWin:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_AnniversaryDuiHuanRankWin:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id

self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)

self.score_name=self.sub_actcfg.score_name or"喜庆值"
self.timeText:setText(FMT.fmt("{0}相同，宗门实力高者排名靠前（更新有延迟，最终以结算时数据为准）",self.score_name))

local widget1=self.rankButton:getWidgetBase()
widget1:SetChildActive(0,self.selectTabIndex==1)
local widget2=self.rewardButton:getWidgetBase()
widget2:SetChildActive(0,self.selectTabIndex~=1)

self:refreshAll()
end

function UISubAct_AnniversaryDuiHuanRankWin:refreshAll()
if self.selectTabIndex==1 then
self.title:setText(FMT.fmt("仙盟{0}排行",self.score_name))
local isHas,rankList=self.sub_actInfo:GetRankList()
if isHas then
self:refreshRankList(rankList)
end
else
self.title:setText("排行奖励")
self:refreshRankList(self.rankList or{})
end
end

function UISubAct_AnniversaryDuiHuanRankWin:refreshRankList(rankList)
self.rankList=rankList

local oldLen=self.rankLen or 0
self.rankLen=self.selectTabIndex==1 and#self.rankList or#self.sub_actcfg.rank_conf
self.ScrollView:setChildSizeDelta(1067,self.selectTabIndex==1 and 430 or 510)

if oldLen==self.rankLen then
if self.rankLen==0 then
self.rankscrollscript:initData(nil,87,0)
else
self.rankscrollscript:doRefreshActiveCellViews()
end
else
self.rankscrollscript:initData(nil,87,self.rankLen)
end
self.notRank:setActive(self.rankLen==0)

self.item:setActive(self.selectTabIndex==1)
if self.selectTabIndex==1 then
self:refreshMyRank()
end
end

function UISubAct_AnniversaryDuiHuan_rankScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UISubAct_AnniversaryDuiHuan_rankScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UISubAct_AnniversaryDuiHuan_rankScroller:RefreshCell(dataIndex,cellIndex,item)
if _this==nil then return end
local rank
local num_str=""
local name_str=""
local rank_str=""
local rewards
if _this.selectTabIndex==1 then
rank=dataIndex
local rankData=_this.rankList[rank]
rewards=_this.sub_actInfo:GetRankReward(rank)
name_str=rankData.param_1 or""
num_str=rankData.param_2 or""
rank_str=rank
else
local conf=_this.sub_actcfg.rank_conf[dataIndex]
rank=conf[1]
rewards=conf[3]
if conf[1]==conf[2]then
rank_str=rank
else
rank_str=FMT.fmt("{0}~{1}",conf[1],conf[2])
end
end
item:SetChildText(0,rank_str)
item:SetChildText(1,name_str or"")
item:SetChildActive(2,name_str==nil)
item:SetChildText(3,num_str or"")
item:SetChildActive(5,rank==1)
item:SetChildActive(6,rank==2)
item:SetChildActive(7,rank==3)

item:SetChildLocalPosX(4,_this.selectTabIndex==1 and 158 or 78)
item:SetChildLayoutGroupCreateItems(4,#rewards,function(i)
local rewardItem=item:GetChildLayoutGroupGridItem(4,i-1)
local rewardData=rewards[i]
local itemId=rewardData[1]
local itemNum=rewardData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local itemConf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local itemProp=itemsComponentHelper.getCommonFillDataSmall(itemConf)
rewardItem:SetChildPropData(0,itemProp)
rewardItem:SetChildButtonClick(0,function()
itemsComponentHelper.onItemClick(itemId)
end)
end)
end

function UISubAct_AnniversaryDuiHuanRankWin:refreshMyRank()
local m_rank=self.sub_actInfo:GetMyRank()
local item=self.item:getChildWidgetBase()
local name_str=xianmengModel:getXMName()
local num=0
if name_str~=nil and self.rankList~=nil and m_rank>0 and self.rankList[m_rank]~=nil then
num=self.rankList[m_rank].param_2 or 0
local rewards=self.sub_actInfo:GetRankReward(m_rank)or{}
item:SetChildActive(4,#rewards>0)
if#rewards>0 then
item:SetChildLayoutGroupCreateItems(4,#rewards,function(i)
local rewardItem=item:GetChildLayoutGroupGridItem(4,i-1)
local rewardData=rewards[i]
local itemId=rewardData[1]
local itemNum=rewardData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local itemConf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local itemProp=itemsComponentHelper.getCommonFillDataSmall(itemConf)
rewardItem:SetChildPropData(0,itemProp)
rewardItem:SetChildButtonClick(0,function()
itemsComponentHelper.onItemClick(itemId)
end)
end)
end
end
item:SetChildText(0,m_rank==0 and"未上榜"or m_rank)
item:SetChildText(1,name_str or"")
item:SetChildActive(2,name_str==nil)
item:SetChildText(3,num)
item:SetChildActive(5,m_rank==1)
item:SetChildActive(6,m_rank==2)
item:SetChildActive(7,m_rank==3)
end


function UISubAct_AnniversaryDuiHuanRankWin:onHide()

end





function UISubAct_AnniversaryDuiHuanRankWin:onCloseBtn()
self:closeSelf()
end

function UISubAct_AnniversaryDuiHuanRankWin:onRankButton()
if self.selectTabIndex~=1 then
self.selectTabIndex=1

local widget1=self.rankButton:getWidgetBase()
widget1:SetChildActive(0,true)
local widget2=self.rewardButton:getWidgetBase()
widget2:SetChildActive(0,false)

self:refreshAll()
end
end

function UISubAct_AnniversaryDuiHuanRankWin:onRewardButton()
if self.selectTabIndex==1 then
self.selectTabIndex=2

local widget1=self.rankButton:getWidgetBase()
widget1:SetChildActive(0,false)
local widget2=self.rewardButton:getWidgetBase()
widget2:SetChildActive(0,true)

self:refreshAll()
end
end