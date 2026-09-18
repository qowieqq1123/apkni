







def_class("UISubAct_roledoubleLottery_TargetWin",UIWindowBase)









function UISubAct_roledoubleLottery_TargetWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.targetScroller=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISubAct_roledoubleLottery_TargetWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.targetScroller);self.targetScroller=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
end
















local targetItemIndex={
targetDesc=0,
rewards=1,
getRewardBtn=2,
gotFlag=3,
unFinishFlag=4,
}



function UISubAct_roledoubleLottery_TargetWin:onLoaded(...)
self:bindComponents()
end


function UISubAct_roledoubleLottery_TargetWin:__delete()
self:unbindComponents()
end




function UISubAct_roledoubleLottery_TargetWin:onShow(argtable,afterOnloaded)
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
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.beginTime=self.activityData.start_time
self.endTime=self.activityData.end_time

self:refresh()
end


function UISubAct_roledoubleLottery_TargetWin:onHide()

end

function UISubAct_roledoubleLottery_TargetWin:refresh(isResetListPos)
local targetCfgList=self:getSortTargetCfgList()
local targetListCount=#targetCfgList
self.targetScroller:setChildScrollViewCreateGrids(targetListCount,0)
if isResetListPos then
self.targetScroller:setChildScrollRectEnable(false)
self.targetScroller:setChildScrollViewSelectItem(0,false,false,false)
self.targetScroller:setChildScrollRectEnable(true)
end
local grids=self.targetScroller:getChildScrollViewItemWidgets()
local data=self.activityData.data
local descStr=self.config.targetDescText
for i=1,grids.Count do
local widget=grids[i-1]
local cfg=targetCfgList[i]
local targetCount=cfg.targetCount
local maxFinishCount=data.maxFinishCount or 0
local maxGotRewardIndex=data.maxGotRewardIndex or 0
local isFinish=maxFinishCount>=targetCount
local isGot=maxGotRewardIndex>=cfg.idx
local countStr
if isFinish then
countStr=FMT.cfmt(FONT_COLOR.eGreenColor,"{0}/{1}",maxFinishCount,targetCount)
else
countStr=FMT.cfmt(FONT_COLOR.eRedColor,"{0}/{1}",maxFinishCount,targetCount)
end
widget:SetChildText(targetItemIndex.targetDesc,FMT.fmt(descStr,countStr))

widget:SetChildActive(targetItemIndex.gotFlag,isGot)
widget:SetChildActive(targetItemIndex.unFinishFlag,not isFinish)
widget:SetChildActive(targetItemIndex.getRewardBtn,isFinish and not isGot)
widget:SetChildButtonClick(targetItemIndex.getRewardBtn,function()
self:onClickGetRewardBtn(targetCount)
end)
local rewardCfgList=cfg.rewardCfgList
widget:SetChildLayoutGroupCreateItems(targetItemIndex.rewards,#rewardCfgList)
local rwGrids=widget:GetChildLayoutGroupGridList(targetItemIndex.rewards)
for i=1,rwGrids.Count do
local rwWidget=rwGrids[i-1]
local reward=rewardCfgList[i]
local itemid=reward[1]
local count=reward.showCount or reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rwWidget:SetChildActive(-1,true)
rwWidget:SetChildPropData(0,prop)
rwWidget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
end
end

function UISubAct_roledoubleLottery_TargetWin:getSortTargetCfgList()
local targetCfgList=self.config.target_reward
local sortTargetCfgList={}
local data=self.activityData.data
for i,v in ipairs(targetCfgList)do
local targetCount=v[1]
local maxFinishCount=data.maxFinishCount or 0
local maxGotRewardIndex=data.maxGotRewardIndex or 0
local isFinish=maxFinishCount>=targetCount
local isGot=maxGotRewardIndex>=i
local rewardCfgList=v[2]
local sortWeight=targetCount

if isFinish and not isGot then
sortWeight=sortWeight-1000
elseif isGot then
sortWeight=sortWeight+10000
end
local targetCfgItem={}
targetCfgItem.targetCount=targetCount
targetCfgItem.rewardCfgList=rewardCfgList
targetCfgItem.sortWeight=sortWeight
targetCfgItem.idx=i
table.insert(sortTargetCfgList,targetCfgItem)
end
table.sort(sortTargetCfgList,function(a,b)
return a.sortWeight<b.sortWeight
end)

return sortTargetCfgList
end




function UISubAct_roledoubleLottery_TargetWin:onClickMask()
self:onCloseBtn()
end



function UISubAct_roledoubleLottery_TargetWin:onCloseBtn()
self:closeSelf()
end


function UISubAct_roledoubleLottery_TargetWin:onClickGetRewardBtn(targetCount)
self.activityData:reqDoubleLotteryGetTargetReward()
end


function UISubAct_roledoubleLottery_TargetWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eRight,
showModel=true,})
end

