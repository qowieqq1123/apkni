







def_class("UISubAct_manufactureRank_rankWin",UIWindowBase)









function UISubAct_manufactureRank_rankWin:bindComponents()

self.bg=UIObject.get(self,0)
self.rankPanel=UIObject.get(self,1)
self.rankListScroller=UILoopListView.new(self,2)
self.selfRankText=UIText.get(self,3)
self.tips=UIText.get(self,4)
self.menuList=UIObject.get(self,5)

self.rankListScroller:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UISubAct_manufactureRank_rankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.rankPanel);self.rankPanel=nil;
self.rankListScroller:deleteSelf();self.rankListScroller=nil;
_UIObject_release(self.selfRankText);self.selfRankText=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.menuList);self.menuList=nil;
end



















local MenuBtnCmpIndex=
{
bg=0,
select=1,
name=2,
click=3,
}

local rankItemIndex={
rankframe=0,
rankNo=1,
playerName=2,
zmName=3,
headBg=4,
rewards=5,
playerInfo=6,
notPlayerInfo=7,
rankDataPanel=8,
rankTarget=9,
rankData=10,
}


function UISubAct_manufactureRank_rankWin:onLoaded(...)
self:bindComponents()
end


function UISubAct_manufactureRank_rankWin:__delete()

UIManager:invokeUIMethod('UISubAct_manufactureRank_mainWin','changeRootShowState',true,true)
self:unbindComponents()
end




function UISubAct_manufactureRank_rankWin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.activityId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
if argtable.selectMenuIndex then
self.selectMenuIndex=argtable.selectMenuIndex
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.beginTime=self.activityData.start_time
self.endTime=self.activityData.end_time

if not self.selectMenuIndex then

self.selectMenuIndex=1
end

self.rankListInit={}
self.rankList={}
self.selfRankData={}

self:refresh()
end
end


function UISubAct_manufactureRank_rankWin:onHide()
UIManager:invokeUIMethod('UISubAct_manufactureRank_mainWin','changeRootShowState',true,true)
end

function UISubAct_manufactureRank_rankWin:refresh()

local menuList=self.config.rankList
local grids=self.menuList:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local menuBtnWidget=grids[i-1]
if menuList[i]then
menuBtnWidget:SetChildActive(-1,true)
menuBtnWidget:SetChildActive(MenuBtnCmpIndex.bg,i~=self.selectMenuIndex)
menuBtnWidget:SetChildActive(MenuBtnCmpIndex.select,i==self.selectMenuIndex)
local tabName=""
if self.config.rankShow and self.config.rankShow[i]and self.config.rankShow[i].tabName then
tabName=self.config.rankShow[i].tabName
else

local rankItemId=menuList[i][2]
local itemConfig=itemsConfig.getConfig(rankItemId)
tabName=FMT.fmt("{0}生产",itemConfig.name)
end
menuBtnWidget:SetChildText(MenuBtnCmpIndex.name,tabName)


menuBtnWidget:SetChildButtonClick(MenuBtnCmpIndex.click,function()
self:selectRank(i)
end)
else
menuBtnWidget:SetChildActive(-1,false)
end
end


self:refreshRankPanel()
end


function UISubAct_manufactureRank_rankWin:selectRank(selectIndex)
if selectIndex==self.selectMenuIndex then
return
end
local menuItem_old=self.menuList:getChildCommonLayoutGroupWidgetItem(self.selectMenuIndex-1)
local menuItem_new=self.menuList:getChildCommonLayoutGroupWidgetItem(selectIndex-1)


menuItem_old:SetChildActive(MenuBtnCmpIndex.bg,true)
menuItem_old:SetChildActive(MenuBtnCmpIndex.select,false)
menuItem_new:SetChildActive(MenuBtnCmpIndex.bg,false)
menuItem_new:SetChildActive(MenuBtnCmpIndex.select,true)
self.selectMenuIndex=selectIndex


self.rankListScroller:setChildScrollRectEnable(false)
self.rankListScroller:setChildScrollViewSelectItem(0,false,false,false)
self.rankListScroller:setChildScrollRectEnable(true)

self:refreshRankPanel()
end


function UISubAct_manufactureRank_rankWin:refreshRankPanel()
local rankItemId=self.config.rankList[self.selectMenuIndex][2]
local rankManufactureMiniNum=self.config.rankList[self.selectMenuIndex][3]
local maxShowRankNum=self.config.rankList[self.selectMenuIndex][4]


if not self.rankListInit[rankItemId]then


activitiesController:sendProtocol(actSendType.eComonReqHandle,self.activityId,self.subType,self.subId,jsonHelper.encode({1,rankItemId}))
self.rankListInit[rankItemId]=true
end


local model=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
self.rankList[rankItemId],self.selfRankData[rankItemId]=model:getManufactureRankListByItemId(rankItemId)


local createCount=maxShowRankNum
local createList={}
for i=1,createCount do createList[#createList+1]=i end
self.rankListScroller:initData('UISubAct_manufactureRankItem',createList)


local numStr="未上榜"
if self.selfRankData[rankItemId]then
numStr=FMT.fmt("第{0}名",self.selfRankData[rankItemId].rankNum)
elseif self.activityData.data.rankFirstList and self.activityData.data.rankFirstList[rankItemId]then
local rankData=self.activityData.data.rankFirstList[rankItemId]

if rankData.myRank~=0 then
numStr=FMT.fmt("第{0}名",rankData.myRank)
end
end
self.selfRankText:setText(FMT.fmt("我的排名：<color=#6a4d3e>{0}</color>",numStr))

local numStr=mathHelper.formatNumber(rankManufactureMiniNum)

self.tips:setText(FMT.fmt("生产累计超过{0}才会上榜",numStr))
end

function UISubAct_manufactureRank_rankWin:onFreshAction(i,item)
local rankItemId=self.config.rankList[self.selectMenuIndex][2]
self:refreshRankItem(item,i,rankItemId)
end

function UISubAct_manufactureRank_rankWin:onStartAction()

end


function UISubAct_manufactureRank_rankWin:refreshRankItem(item,index,rankItemId)
if item==nil then
item=self.rankListScroller:getChildScrollViewItemWidget(index-1)
end

local rankData=self.rankList[rankItemId][index]
if rankData then

item:SetChildActive(rankItemIndex.playerInfo,true)

item:SetChildActive(rankItemIndex.notPlayerInfo,false)


local headArgs={}
headArgs.iconInfo=rankData.iconInfo
headArgs.scale=0.75
playerController:setHeadIcon(item,-1,headArgs)

item:SetChildButtonClickWithID(rankItemIndex.headBg,function(index)
self:onClickHead(rankItemId,index)
end,index)

item:SetChildText(rankItemIndex.playerName,rankData.playerName)
local zmName=rankData.zmName~=""and rankData.zmName or"暂无"
item:SetChildText(rankItemIndex.zmName,zmName)


item:SetChildActive(rankItemIndex.rankDataPanel,true)
local rankItemId=self.config.rankList[self.selectMenuIndex][2]
local itemConfig=itemsConfig.getConfig(rankItemId)
local rankTargetStr=FMT.fmt("累计生产{0}",itemConfig.name)
item:SetChildText(rankItemIndex.rankTarget,rankTargetStr)
local manufactureNum=mathHelper.int64_to_number(rankData.data[1])
local manufactureCountStr=mathHelper.formatNumber(manufactureNum)
item:SetChildText(rankItemIndex.rankData,manufactureCountStr)

else


item:SetChildActive(rankItemIndex.playerInfo,false)
item:SetChildActive(rankItemIndex.rankDataPanel,false)

item:SetChildActive(rankItemIndex.notPlayerInfo,true)
end



local frameName=rankListModel.getFrameName(index)
if frameName then
item:SetChildCSImageSprite(rankItemIndex.rankframe,globalABLookup.rankList,frameName)
else
item:SetChildIcon(rankItemIndex.rankframe,"",false)
end


local rankNum=0

rankNum=index
item:SetChildText(rankItemIndex.rankNo,rankNum)



local rewards=self.activityData.data.rankRewardsCfg_lookup[self.selectMenuIndex]and self.activityData.data.rankRewardsCfg_lookup[self.selectMenuIndex][index]or{}
local grids=item:GetChildCommonLayoutGroupWidgetList(rankItemIndex.rewards)
for i=1,grids.Count do
local widget=grids[i-1]
if rewards[i]then
local reward=rewards[i]
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end

local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
else
widget:SetChildActive(-1,false)
end
end
end



function UISubAct_manufactureRank_rankWin:onClickHead(rankItemId,index)
local rankData=self.rankList[rankItemId][index]
if rankData and rankData.actorId then
local attach={
type=otherPlayerController.eAttachType.Rank,
rankType=eRankListType.eManufactureRank
}
otherPlayerController:openOtherPlayerInfoWin(rankData.actorId,true,nil,attach)
end
end


function UISubAct_manufactureRank_rankWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eRight,showModel=true})
end