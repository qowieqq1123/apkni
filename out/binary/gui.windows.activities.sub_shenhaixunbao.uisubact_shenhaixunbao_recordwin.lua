







def_class("UISubAct_shenhaixunbao_recordWin",UIWindowBase)









function UISubAct_shenhaixunbao_recordWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.listScroller=UILoopListView.new(self,1)
self.clickMask=UIButton.get(self,2)
self.bgModel=UIObject.get(self,3)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.listScroller:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.clickMask:setButtonClick(function()self:onClickMask()end)



end


function UISubAct_shenhaixunbao_recordWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
self.listScroller:deleteSelf();self.listScroller=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
end
















local _recordTypeDescStrList={
[1]="到达起点格",
[2]="经过起点格",
[3]="道具格奖励",
[4]="宝箱格奖励",
[5]="珍稀格奖励",
[6]="事件格奖励",
}




function UISubAct_shenhaixunbao_recordWin:onLoaded(...)
self:bindComponents()
end


function UISubAct_shenhaixunbao_recordWin:__delete()
self:unbindComponents()
end




function UISubAct_shenhaixunbao_recordWin:onShow(argtable,afterOnloaded)
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

local isIgnoreNewData=argtable and argtable.isIgnoreNewData

self.myData=activitiesModel:getSubActInfoData(self.activityId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.sub_actInfo=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

if afterOnloaded then
self.bgModel:setChildUIModelShowTarget(6369,1,{},eAnimationID.enter)
end

if not isIgnoreNewData then

self.sub_actInfo:reqGetRecordData()
end

self:refresh()
end


function UISubAct_shenhaixunbao_recordWin:onHide()

end

function UISubAct_shenhaixunbao_recordWin:refresh()

local recordList=self.myData.recordList
local count=#recordList
local createList={}
for i=1,count do createList[#createList+1]=i end
self.listScroller:initData('recordItem',createList)
end

function UISubAct_shenhaixunbao_recordWin:onFreshAction(i,widget)
local recordList=self.myData.recordList
local recordData=recordList[i]
if recordData then
widget:SetChildActive(-1,true)
local recordType=recordData.rwType
local descStr=_recordTypeDescStrList[recordType]or""
widget:SetChildText(0,descStr)
local rewardList=recordData.itemList
local rewardCount=rewardList and#rewardList or 0
widget:SetChildScrollViewCreateGrids(1,rewardCount,rewardCount)
local grids=widget:GetChildScrollViewItemWidgets(1)
for i=1,grids.Count do
local itemWidget=grids[i-1]
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
itemWidget:SetChildActive(-1,true)
itemWidget:SetChildPropData(0,prop)
itemWidget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
else
itemWidget:SetChildActive(-1,false)
end
end

widget:SetChildScrollRectEnable(1,rewardCount>3)
else
widget:SetChildActive(-1,false)
end
end

function UISubAct_shenhaixunbao_recordWin:onStartAction()

end




function UISubAct_shenhaixunbao_recordWin:onCloseBtn()
self:closeSelf()
end



function UISubAct_shenhaixunbao_recordWin:onClickMask()
return self:onCloseBtn()
end

function UISubAct_shenhaixunbao_recordWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end