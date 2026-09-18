







def_class("UISubAct_CangBaoTuTaskWin",UIWindowBase)









function UISubAct_CangBaoTuTaskWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.content=UIObject.get(self,2)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISubAct_CangBaoTuTaskWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.content);self.content=nil;
end
















local _this=nil
local _itemCmp={
flag=0,
jumpBtn=1,
jumpTx=2,
rewardBtn=3,
unlockTx=4,
titleTx=5,
rewards=6,
reset=7,
jumpImage=8,
}



function UISubAct_CangBaoTuTaskWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_CangBaoTuTaskWin:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_CangBaoTuTaskWin:onShow(argtable,afterOnloaded)
self.activityId=argtable.activityId
self.subType=argtable.subType
self.subId=argtable.subId
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.info=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
self:updateListData()
self:refreshList()
end


function UISubAct_CangBaoTuTaskWin:onHide()

end





function UISubAct_CangBaoTuTaskWin:onCloseBtn()
self:closeSelf()
end

function UISubAct_CangBaoTuTaskWin:onBackground()
self:closeSelf()
end

function UISubAct_CangBaoTuTaskWin:refreshView(activityId,subType,subId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
self:updateListData()
self:refreshList()
end
end

function UISubAct_CangBaoTuTaskWin:updateListData()
local data=self.info:getData()
local flag=data.task.targetflag
local temp0={}
local temp1={}
local temp2={}
for i,v in ipairs(self.config.target)do
if self.info:getSingleTaskShow(i)then
local finish=mathHelper.getBitValue(flag,i-1)
if finish then
table.insert(temp2,i)
else
local progressValue=self.info:getTaskProgress(v[1])
local targetValue=v[2]
if progressValue<targetValue then
table.insert(temp1,i)
else
table.insert(temp0,i)
end
end
end
end
self.datas=table.concatTableX(temp0,temp1,temp2)
end

function UISubAct_CangBaoTuTaskWin:refreshList()
self.content:setChildLayoutGroupCreateItems(#self.datas,function(index)
self:refreshListItem(index)
end)
end

function UISubAct_CangBaoTuTaskWin:refreshListItem(index,item)
item=item or self.content:getChildLayoutGroupGridItem(index-1)
local dataIdx=self.datas[index]
local config=self.config.target[dataIdx]
local data=self.info:getData()
local finish=mathHelper.getBitValue(data.task.targetflag,dataIdx-1)
local prevTask=config[5]
local lock=prevTask~=0 and not self.info:getSingleTaskFinish(prevTask)
local progressValue=self.info:getTaskProgress(config[1])
local targetValue=config[2]
local str=FMT.fmt(config[7],math.min(progressValue,targetValue),targetValue)
item:SetChildText(_itemCmp.titleTx,str)
item:SetChildActive(_itemCmp.reset,config[1]==1)
item:SetChildButtonClick(_itemCmp.jumpBtn,function()
self:onClickJump(index)
end)
item:SetChildButtonClick(_itemCmp.rewardBtn,function()
self:onClickReward(index)
end)
local rewardList=config[3]
item:SetChildLayoutGroupCreateItems(_itemCmp.rewards,#rewardList,function(index)
local rewardItem=item:GetChildLayoutGroupGridItem(_itemCmp.rewards,index-1)
local rewardData=rewardList[index]
local rewardId=rewardData[1]
local rewardNum=rewardData[2]
local showCount=rewardNum>1
local countStr=showCount and rewardNum or""
local conf={itemid=rewardId,itemcount=countStr,showname=false,showCountBG=showCount,showStage=true,gray=lock and 1 or 0}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(-1,prop)
rewardItem:SetBaseItemClickEvent(-1,function(...)
itemsComponentHelper.onItemClickEx(...)
end)
end)
if not lock then

item:SetChildGraphicGray(-1,false,true,true)
item:SetChildActive(_itemCmp.unlockTx,false)
if finish then
item:SetChildActive(_itemCmp.jumpBtn,false)
item:SetChildActive(_itemCmp.rewardBtn,false)
item:SetChildActive(_itemCmp.flag,true)
else
if progressValue<targetValue then
local jumpStr=self.info:getTaskJumpStr(config[1])
item:SetChildText(_itemCmp.jumpTx,jumpStr)
item:SetChildActive(_itemCmp.jumpBtn,true)
item:SetChildActive(_itemCmp.jumpImage,true)
item:SetChildActive(_itemCmp.rewardBtn,false)
else
item:SetChildActive(_itemCmp.jumpBtn,false)
item:SetChildActive(_itemCmp.rewardBtn,true)
end
item:SetChildActive(_itemCmp.flag,false)
end
else

item:SetChildGraphicGray(-1,true,true,true)
item:SetChildActive(_itemCmp.unlockTx,true)
item:SetChildActive(_itemCmp.jumpBtn,false)
item:SetChildActive(_itemCmp.rewardBtn,false)
item:SetChildActive(_itemCmp.flag,false)
end
end

function UISubAct_CangBaoTuTaskWin:onClickJump(index)
local dataIdx=self.datas[index]
local config=self.config.target[dataIdx]
self.info:getTaskJumpHandle(config[1])
self:closeSelf()







end

function UISubAct_CangBaoTuTaskWin:onClickReward(index)
call_activitiesHandle_func('activitiesHandle_cangbaotu','reqRewardTask',self.activityId,self.subId,self.datas[index])
end

function UISubAct_CangBaoTuTaskWin:onNewDay()
self:updateListData()
self:refreshList()
end

function UISubAct_CangBaoTuTaskWin:afterReward(activityId,subType,subId,targetId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
local rewards=self.config.target[targetId][3]
local rewards_={}
for i,v in ipairs(rewards)do
table.insert(rewards_,{itemid=v[1],num=v[2]})
end
showPrizeControl.showWindow(rewards_)









self:updateListData()
self:refreshList()







end
end