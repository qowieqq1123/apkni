







def_class("UIXianGongJiaJiangWin",UIWindowBase)









function UIXianGongJiaJiangWin:bindComponents()

self.bgSpine=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.Root=UIObject.get(self,2)
self.taskScrollView=UIScrollView.get(self,3)
self.uiRoot=UIObject.get(self,4)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXianGongJiaJiangWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.taskScrollView);self.taskScrollView=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local CmpTaskSlotIndex={
title=0,
starList=1,
rewardList=2,
receiveBtn=3,
receivedImg=4,
}




function UIXianGongJiaJiangWin:onLoaded(...)
self:bindComponents()

local bindWidgetFunc=function(...)self:bingWidget(...)end
self.taskScrollView:bindScrollWidget(bindWidgetFunc)

self:addNotify(notifyConfig.onXianZhiTaskStateChange,function()self:refreshAll()end)
end


function UIXianGongJiaJiangWin:__delete()
self:unbindComponents()
end




function UIXianGongJiaJiangWin:onShow(argtable,afterOnloaded)

self:refreshAll()

self.bgSpine:setChildUIModelShowTarget(5550,1,nil,eAnimationID.enter)
end


function UIXianGongJiaJiangWin:onHide()

end



function UIXianGongJiaJiangWin:refreshAll()
self.taskList=xianzhiModel:getTaskList()

local len=#self.taskList

self.taskScrollView:freshGridsNum(len,1,len,self.taskZero)
self.taskZero=true
end







function UIXianGongJiaJiangWin:bingWidget(index,item)
local data=self.taskList[index]




local cfg=data.cfg
local jctianInfo=FMT.fmt("仙职：{0}重天",mathHelper.numberToChinese(cfg.jctian))
item:SetChildText(CmpTaskSlotIndex.title,jctianInfo)


local totalStarNum=xianzhiModel:getXzTotalStarNum(cfg.id)
local curStartIdx=cfg.star
local starCreateFunc=function(index)
local sitem=item:GetChildLayoutGroupGridItem(CmpTaskSlotIndex.starList,index-1)
local isLight=curStartIdx>=index
sitem:SetChildActive(0,isLight)
end
item:SetChildLayoutGroupCreateItems(CmpTaskSlotIndex.starList,totalStarNum,starCreateFunc)



local rewardList=cfg.goalItems
local rewardLen=#rewardList

local ritemGridFunc=function(index)
local ritem=item:GetChildLayoutGroupGridItem(CmpTaskSlotIndex.rewardList,index-1)

local data=rewardList[index]

local itemId=data[1]
local itemNum=data[2]
local itemNumStr=itemNum>1 and mathHelper.formatNumber4(itemNum)or""
local showCountBG=itemNum>1

local conf={itemid=itemId,itemcount=itemNumStr,showCountBG=showCountBG,showStage=true,showname=false}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
ritem:SetChildPropData(-1,propData)
ritem:SetBaseItemClickEvent(-1,function()
itemsComponentHelper.onItemClick(itemId)
end)
end
item:SetChildLayoutGroupCreateItems(CmpTaskSlotIndex.rewardList,rewardLen,ritemGridFunc)

local isCanReceive=xianzhiModel:checkCanReceiveXianGongJiaJiang(cfg.id)
local isReceived=xianzhiModel:checkReceivedXianGongJiaJiang(cfg.id)

local isGray=not isCanReceive and not isReceived


item:SetChildButtonClick(CmpTaskSlotIndex.receiveBtn,function()
if isCanReceive then

xianzhiController:reqReceiveXGReward()
else

UIManager.info("仙职等级不足，暂无法领取")
end
end)

item:SetChildButtonEnable(CmpTaskSlotIndex.receiveBtn,true,isGray)
item:SetChildActive(CmpTaskSlotIndex.receiveBtn,not isReceived)

item:SetChildActive(CmpTaskSlotIndex.receivedImg,isReceived)
end





function UIXianGongJiaJiangWin:onCloseBtn()
self:closeSelf()
end

