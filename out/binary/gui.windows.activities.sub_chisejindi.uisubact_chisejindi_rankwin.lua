







def_class("UISubAct_ChiSeJinDi_RankWin",UIWindowBase)









function UISubAct_ChiSeJinDi_RankWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.myItem=UIObject.get(self,2)
self.resulting=UIText.get(self,3)
self.ScrollerScript=UIEnhancedScrollerLua.get(self,4)
self.tips=UIText.get(self,5)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISubAct_ChiSeJinDi_RankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.myItem);self.myItem=nil;
_UIObject_release(self.resulting);self.resulting=nil;
_UIObject_release(self.ScrollerScript);self.ScrollerScript=nil;
_UIObject_release(self.tips);self.tips=nil;
end















local _this=nil
local _itemCmp={
rank=0,
playerName=1,
score=2,
rewards=3,
rankImage=4,
serverName=5,
}
local _myItemCmp={
rank=0,
playerName=1,
score=2,
rankImage=3,
}
local UIPrepareEnScroller=simple_class(UIEnhancedScroller)



function UISubAct_ChiSeJinDi_RankWin:onLoaded(...)
self:bindComponents()
_this=self

self.enhancedscrollscript=UIPrepareEnScroller(self.ScrollerScript:getGameObject(),self.ScrollerScript:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self

socketManager:addNotify(249,232,self.on_249_232)
end


function UISubAct_ChiSeJinDi_RankWin:__delete()
self:stopCDTick()

self:unbindComponents()
_this=nil

socketManager:removeNotify(249,232,self.on_249_232)
end




function UISubAct_ChiSeJinDi_RankWin:onShow(argtable,afterOnloaded)
self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.parentWin=argtable.parentWin

self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

if self.info:hasRank()then
self:refreshView()
end

self:startCDTick()
end


function UISubAct_ChiSeJinDi_RankWin:onHide()

end




function UISubAct_ChiSeJinDi_RankWin:onCloseBtn()
self.info:setRank()

if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UISubAct_ChiSeJinDi_RankWin:onBackground()
self:onCloseBtn()
end

function UISubAct_ChiSeJinDi_RankWin:refreshView()
local data=self.info:getData()
local rankData=self.info:getRank()
self.rankList=rankData.rankList
local rankCnt=#self.rankList
self.enhancedscrollscript:initData(rankCnt,92,rankCnt)

local resulting=self.info:checkInResultRankTime()
self.resulting:setActive(resulting)
self.myItem:setActive(not resulting)
if not resulting then
local myRank=rankData.myRank
local widget=self.myItem:getChildWidgetBase()
local rankStr=myRank>0 and myRank or"未上榜"
widget:SetChildText(_myItemCmp.rank,rankStr)
widget:SetChildText(_myItemCmp.playerName,playerModel:getActorName())
local stageName=self.config.scoreClient[data.stage][1]
local scoreStr=FMT.fmt("{0} {1}",stageName,data.stageScore)
widget:SetChildText(_myItemCmp.score,scoreStr)
if myRank<=3 then
widget:SetChildCSImageSprite(_myItemCmp.rankImage,globalABLookup.global,FMT.fmt("icon_phbmingci_{0}",myRank))
else
widget:SetChildCSImageIcon(_myItemCmp.rankImage,"",false)
end
end
end

function UISubAct_ChiSeJinDi_RankWin:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UISubAct_ChiSeJinDi_RankWin:updateCDTick()
local nowStamp=timeHelper.getServerLongTime()
local deltaStamp=nowStamp-self.info.cycleBegin
local weekSecond=deltaStamp%self.info.cycleDuration
local leastTime=self.info.cycleDuration-weekSecond
leastTime=math.min(leastTime,self.info:getEndLeftTime())
local tipsStr=FMT.fmt("距离下次结算倒计时：<color=#00a504>{0}</color>",timeHelper.format_time_stamp3(leastTime))
self.tips:setText(tipsStr)
end

function UISubAct_ChiSeJinDi_RankWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UIPrepareEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:RefreshCell(dataIndex,cellIndex,cell)
local rankCfg=self.window.config.rank[3]

local rankData=self.window.rankList[dataIndex]
cell:SetChildText(_itemCmp.rank,dataIndex)
cell:SetChildText(_itemCmp.serverName,loginModel:getServerName(rankData.param_1))
cell:SetChildText(_itemCmp.playerName,rankData.param_2)
local stage=self.window.info:calculateStageEx(rankData.param_3)
local stageName=self.window.config.scoreClient[stage][1]
local scoreStr=FMT.fmt("{0} {1}",stageName,rankData.param_3)
cell:SetChildText(_itemCmp.score,scoreStr)
if dataIndex<=3 then
cell:SetChildCSImageSprite(_itemCmp.rankImage,globalABLookup.global,FMT.fmt("icon_phbmingci_{0}",dataIndex))
else
cell:SetChildCSImageIcon(_itemCmp.rankImage,"",false)
end
local rewards={}
for i,v in ipairs(rankCfg)do
if dataIndex<=v[1]then
rewards=v[2]
break
end
end
cell:SetChildLayoutGroupCreateItems(_itemCmp.rewards,#rewards,function(idx)
local _item=cell:GetChildLayoutGroupGridItem(_itemCmp.rewards,idx-1)
local rewardData=rewards[idx]
local rewardId=rewardData[1]
local rewardNum=rewardData[2]
local showCountBG=rewardNum>0
local countStr=showCountBG and mathHelper.formatNumber(rewardNum)or""
local conf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
_item:SetChildPropData(-1,prop)
_item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
end

function UISubAct_ChiSeJinDi_RankWin.on_249_232(actId,subId,len,list,myRank)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
if _this.info:compare(actId,subType,subId)then
_this:refreshView()
end
end