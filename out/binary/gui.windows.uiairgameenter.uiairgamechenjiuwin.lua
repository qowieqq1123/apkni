







def_class("UIAirGameChenJiuWin",UIWindowBase)









function UIAirGameChenJiuWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.quickBtn=UIButton.get(self,1)
self.quickReddot=UIObject.get(self,2)
self.Root=UIObject.get(self,3)
self.tabList=UIObject.get(self,4)
self.tabScrollView=UIObject.get(self,5)
self.taskScrollView=UIScrollView.get(self,6)
self.uiRoot=UIObject.get(self,7)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.quickBtn:setButtonClick(function()self:onQuickBtn()end)



end


function UIAirGameChenJiuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.quickBtn);self.quickBtn=nil;
_UIObject_release(self.quickReddot);self.quickReddot=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.tabList);self.tabList=nil;
_UIObject_release(self.tabScrollView);self.tabScrollView=nil;
_UIObject_release(self.taskScrollView);self.taskScrollView=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local _this

local CmpTabSlotIndex={
select=0,
name=1,
reddot=2,
gray=3,
}

local CmpTaskSlotIndex={
dcInfo=0,
head=1,
name=2,
defaultInfo=3,
taskDesc=4,
finish=5,
rewardList=6,
receive=7,
reddot=8,
receiveClickBtn=9,
select=10,
taskid=15,
}

local rewardIndexList={11,12,13,14}




function UIAirGameChenJiuWin:onLoaded(...)
self:bindComponents()

_this=self

self.tabIndex=1
self.taskIndex=1

self.taskScrollView:bindScrollWidget(function(...)self:onFreshAction(...)end)

self:addNotify(notifyConfig.onAirChenJiuUpdate,function(...)self:onAirChenJiuUpdate()end)
end


function UIAirGameChenJiuWin:__delete()
self:unbindComponents()

if UIManager:isActive('UIAirGameEnterWin')then
UIManager:invokeUIMethod("UIAirGameEnterWin","refreshMoneyBar")
end
if UIManager:isActive('UIAirGamePrepareWin')then
UIManager:invokeUIMethod("UIAirGameEnterWin","refreshMoneyBar")
end
end




function UIAirGameChenJiuWin:onShow(argtable,afterOnloaded)

self.tabIndex=argtable and(argtable.tabIndex or self.tabIndex)or 1
self.taskIndex=argtable and(argtable.taskIndex or self.taskIndex)or 1

self:refreshAll()


UIFullAirGameEnterController:showWindow("UITopMoneyWin2",{{eMoneyType.mtXianYu},{eMoneyType.mtLingYu},{eMoneyType.mtLingMu}})
end


function UIAirGameChenJiuWin:onHide()

end


function UIAirGameChenJiuWin:refreshAll()

self:refreshTab()

self:refreshTask()

self:refreshBtns()

end

function UIAirGameChenJiuWin:refreshTab()
local tabList=airGameEnterConfig.getChenJiuTabList()
local tabLen=#tabList

local createCallBack=function(index)
local tabItem=_this.tabList:getChildLayoutGroupGridItem(index-1)
local tabData=tabList[index]

tabItem:SetChildText(CmpTabSlotIndex.name,tabData.name)

local reddot=airGameEnterModel:checkChengJiuTabReddot(tabData.id)
tabItem:SetChildActive(CmpTabSlotIndex.reddot,reddot)

local isSelect=_this.tabIndex==index
tabItem:SetChildActive(CmpTabSlotIndex.select,isSelect)

tabItem:SetBaseItemClickEvent(-1,function()
local preTabItem=_this.tabList:getChildLayoutGroupGridItem(_this.tabIndex-1)
preTabItem:SetChildActive(CmpTabSlotIndex.select,false)

tabItem:SetChildActive(CmpTabSlotIndex.select,true)
_this.tabIndex=index
_this:refreshTask()
_this:refreshBtns()
end)
end

self.tabList:setChildLayoutGroupCreateItems(tabLen,createCallBack)
self.tabScrollView:setChildScrollRectEnable(tabLen>6)
end

function UIAirGameChenJiuWin:refreshTask()
self.taskDataList=airGameEnterModel:getGroupTaskDataList(self.tabIndex)

local taskLen=#self.taskDataList



self.taskScrollView:freshGridsNum(taskLen,taskLen,1,self.taskZeroFlag)
self.taskZeroFlag=true
end

function UIAirGameChenJiuWin:refreshBtns()

local quickReddot=airGameEnterModel:checkChengJiuTabReddot(self.tabIndex)
self.quickReddot:setActive(quickReddot)
end


function UIAirGameChenJiuWin:onFreshAction(id,item)
local data=self.taskDataList[id]

local isShowItem=data~=nil
item:SetChildActive(-1,isShowItem)

if isShowItem then
local reachRoleInfo=data.cjData.iconInfo
local isShowReachInfo=reachRoleInfo~=nil
item:SetChildActive(CmpTaskSlotIndex.dcInfo,isShowReachInfo)
item:SetChildActive(CmpTaskSlotIndex.defaultInfo,not isShowReachInfo)
item:SetChildActive(CmpTaskSlotIndex.name,isShowReachInfo)
if isShowReachInfo then
playerController:setHeadIcon(item,CmpTaskSlotIndex.head,{scale=0.75,iconInfo=reachRoleInfo,updateRendererSize=true})
item:SetChildText(CmpTaskSlotIndex.name,data.cjData.name)
end

item:SetChildButtonClick(CmpTaskSlotIndex.dcInfo,function()
local actorid=data.cjData.acotrid
if isShowReachInfo and actorid~=nil then
otherPlayerController:openOtherPlayerInfoWin(actorid,true,nil,nil)
end
end,true)


local desc=data.taskDesc
item:SetChildText(CmpTaskSlotIndex.taskDesc,desc)










local isShowFinish=data.isShowFinish

item:SetChildActive(CmpTaskSlotIndex.select,isShowFinish)
item:SetChildActive(CmpTaskSlotIndex.receiveClickBtn,isShowFinish)
item:SetChildButtonClick(CmpTaskSlotIndex.receiveClickBtn,function()
if isShowFinish then
airGameEnterController:reqReceiveChengJiuReward(1,{data.cjData.id})
end
end,true)


local isShowReceive=data.isShowReceive
item:SetChildActive(CmpTaskSlotIndex.receive,isShowReceive)

local isShowRewardList=data.isShowRewardList~=nil and(not data.isShowReceive)
item:SetChildActive(CmpTaskSlotIndex.rewardList,isShowRewardList)
if isShowRewardList then
local rewardList=data.rewardList or{}
local propDataList={}
for index,rewardData in ipairs(rewardList)do
local itemId=rewardData[1]
local itemCount=rewardData[2]
local isShowCount=itemCount>1
local itemCountStr=isShowCount and itemCount or""
local conf={itemid=itemId,itemcount=itemCountStr,showCountBG=isShowCount,showStage=true,showname=false}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
propDataList[#propDataList+1]=propData
end

for index,rindex in ipairs(rewardIndexList)do
local propData=propDataList[index]
local isShow=propData~=nil
item:SetChildActive(rindex,isShow)
if isShow then
item:SetChildPropData(rindex,propData)
item:SetBaseItemClickEvent(rindex,function(...)
itemsComponentHelper.onItemClick(...)
end)
end
end

item:SetChildScrollRectEnable(CmpTaskSlotIndex.rewardList,#rewardList>3)
end

local isShowReddot=data.isShowReddot
item:SetChildActive(CmpTaskSlotIndex.reddot,isShowReddot)
end

end

function UIAirGameChenJiuWin:onStartAction()

end


function UIAirGameChenJiuWin:onAirChenJiuUpdate()
self:refreshBtns()
end






function UIAirGameChenJiuWin:onCloseBtn()
self:closeSelf()
end



function UIAirGameChenJiuWin:onQuickBtn()
local idList=airGameEnterModel:getTabCanReceiveRewardTaskIdList(self.tabIndex)
local idLen=#idList
if idLen>0 then
airGameEnterController:reqReceiveChengJiuReward(idLen,idList)
else
UIManager.info("没有可领取的成就")
end
end

