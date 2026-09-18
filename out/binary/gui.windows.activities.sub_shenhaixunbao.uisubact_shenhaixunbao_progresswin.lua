







def_class("UISubAct_shenhaixunbao_progressWin",UIWindowBase)









function UISubAct_shenhaixunbao_progressWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.listScroller=UIObject.get(self,1)
self.clickMask=UIButton.get(self,2)
self.bgModel=UIObject.get(self,3)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.clickMask:setButtonClick(function()self:onClickMask()end)



end


function UISubAct_shenhaixunbao_progressWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.listScroller);self.listScroller=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
end
















local targetItemIndex={
select=0,
taskDesc=1,
rewardScrollView=2,
getRewardBtn=3,
gotFlag=4,
reddot=5,
getRewardBtnText=6,
}



function UISubAct_shenhaixunbao_progressWin:onLoaded(...)
self:bindComponents()
end


function UISubAct_shenhaixunbao_progressWin:__delete()
self:unbindComponents()
end




function UISubAct_shenhaixunbao_progressWin:onShow(argtable,afterOnloaded)
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


self.myData=activitiesModel:getSubActInfoData(self.activityId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.sub_actInfo=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

if afterOnloaded then
self.bgModel:setChildUIModelShowTarget(6368,1,{},eAnimationID.enter)
end

self:refresh()
end


function UISubAct_shenhaixunbao_progressWin:onHide()

end

function UISubAct_shenhaixunbao_progressWin:refresh()

self.sortTargetList=self:getSortTargetList()
local count=#self.sortTargetList
self.listScroller:setChildScrollViewCreateGrids(count,1)

local grids=self.listScroller:getChildScrollViewItemWidgets()
for i=1,count do
self:refreshTargetItem(grids[i-1],i)
end
end

function UISubAct_shenhaixunbao_progressWin:getSortTargetList()

local targetCfgList=self.sub_actInfo:getProgressTargetCfgList()
local sortTargetList={}
local gotRewardVal=self.myData.jdrwMaxVal or 0
for i,cfg in ipairs(targetCfgList)do
local score=cfg.score
local rewardList=cfg.rewardList
local isGot=gotRewardVal>=score
local sortWeight=score
if isGot then
sortWeight=sortWeight+10000
end

sortTargetList[#sortTargetList+1]={
score=score,
rewardList=rewardList,
isGot=isGot,
sortWeight=sortWeight,
}
end

table.sort(sortTargetList,function(a,b)
return a.sortWeight<b.sortWeight
end)
return sortTargetList
end

function UISubAct_shenhaixunbao_progressWin:refreshTargetItem(item,index)
if item==nil then
item=self.listScroller:getChildScrollViewItemWidget(index-1)
end


local targetData=self.sortTargetList[index]
if item and targetData then

local nowScore=self.myData.jdrwScore or 0
local needScore=targetData.score
local showNowScore=nowScore
local isFinish=nowScore>=needScore
if isFinish then
showNowScore=needScore
end
local isGot=targetData.isGot
local descStr
if isFinish then
descStr=FMT.fmt("骰子消耗达到{0}个（<color=#549327>{1}</color>/{0}）",needScore,showNowScore)
else
descStr=FMT.fmt("骰子消耗达到{0}个（<color=#c82c2c>{1}</color>/{0}）",needScore,showNowScore)
end
item:SetChildText(targetItemIndex.taskDesc,descStr)


local isShowGetRewardBtn=not isGot
item:SetChildActive(targetItemIndex.getRewardBtn,isShowGetRewardBtn)
item:SetChildActive(targetItemIndex.reddot,isFinish and not isGot)
if isShowGetRewardBtn then
item:SetChildButtonEnable(targetItemIndex.getRewardBtn,isFinish,not isFinish)
item:SetChildButtonClick(targetItemIndex.getRewardBtn,function()
self:onClickGetRewardBtn()
end)

local btnStr=isFinish and"领取"or"未完成"
item:SetChildText(targetItemIndex.getRewardBtnText,btnStr)
end


item:SetChildActive(targetItemIndex.gotFlag,isFinish and isGot)







local rewardList=targetData.rewardList

item:SetChildScrollViewCreateGrids(targetItemIndex.rewardScrollView,#rewardList,1)
local grids=item:GetChildScrollViewItemWidgets(targetItemIndex.rewardScrollView)
for i=1,grids.Count do
local widget=grids[i-1]
local reward=rewardList[i]
if reward then
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
end



function UISubAct_shenhaixunbao_progressWin:onCloseBtn()
self:closeSelf()
end

function UISubAct_shenhaixunbao_progressWin:onClickMask()
return self:onCloseBtn()
end

function UISubAct_shenhaixunbao_progressWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end


function UISubAct_shenhaixunbao_progressWin:onClickGetRewardBtn()

self.sub_actInfo:reqGetProgressReward()
end
