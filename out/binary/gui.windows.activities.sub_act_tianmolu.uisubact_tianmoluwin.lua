







def_class("UISubAct_tianmoluWin",UIWindowBase)









function UISubAct_tianmoluWin:bindComponents()

self.listScroller=UIObject.get(self,0)
self.times=UIText.get(self,1)
self.buyBtn=UIButton.get(self,2)
self.click=UIButton.get(self,3)
self.price=UILinkImageText.get(self,4)
self.time=UIText.get(self,5)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)

self.click:setButtonClick(function()self:onClick()end)



end


function UISubAct_tianmoluWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.listScroller);self.listScroller=nil;
_UIObject_release(self.times);self.times=nil;
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.click);self.click=nil;
_UIObject_release(self.price);self.price=nil;
_UIObject_release(self.time);self.time=nil;
end


















local taskItemIndex={
select=0,
taskDesc=1,
baseRewards=2,
upRewards=3,
}

function UISubAct_tianmoluWin:onLoaded(...)
self:bindComponents()
end


function UISubAct_tianmoluWin:__delete()
self:unbindComponents()
end




function UISubAct_tianmoluWin:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eInvestAct2
self.subid=argtable.sub_act_id
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)

self.taskaim=self.config.taskaim


self:refresh(true)
end


function UISubAct_tianmoluWin:onHide()

end

function UISubAct_tianmoluWin:refresh(isInit)

self:refreshListTop()

self.autoJumpIndex=nil

self.firstUnfinishTaskIndex=nil


self:refreshTaskList()


if not self.autoJumpIndex then

self.autoJumpIndex=self.firstUnfinishTaskIndex or 0
end



local jumpIndex=self.autoJumpIndex-1
if jumpIndex<0 then
jumpIndex=0
end
if isInit then
self.listScroller:setChildScrollViewSelectItem(jumpIndex,false,false,false)
end
end

function UISubAct_tianmoluWin:isOpenEx()
if not self.info then
return false
end
return self.info:isOpenEx()
end


function UISubAct_tianmoluWin:refreshListTop()

self.isBuyChaozhi=self:isOpenEx()




self.buyBtn:setActive(not self.isBuyChaozhi)
self.click:setActive(not self.isBuyChaozhi)

local rechargeId=self.config.recharge
local consume=self.config.consume
if rechargeId then
local rechargeCfg=cfgHelper.get(cfg_rechargeconfig_get,rechargeId)
local price=rechargeCfg.rmb
if price then
self.price:setText(price)
else
logErr(FMT.fmt("找不到充值id: {0}对应的rmb价格配置",rechargeId))
end
else
if consume then
local iconname=iconHelper.getIconName(consume[1][1])
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,40)
self.price:setText(FMT.fmt("{0}{1}解锁",iconStr,consume[1][2]))
end
end



end

function UISubAct_tianmoluWin:getTimes()
if not self.info then
return 0
end
return self.info:getTimes()
end

function UISubAct_tianmoluWin:isGotReward(rewardIdx)
if not self.info then
return false
end
return self.info:isGotReward(rewardIdx)
end

function UISubAct_tianmoluWin:isGotExReward(rewardIdx)
if not self.info then
return false
end
return self.info:isGotExReward(rewardIdx)
end


function UISubAct_tianmoluWin:refreshTaskList()
local count=#self.taskaim
self.listScroller:setChildScrollViewCreateGrids(count,1)
local times=self:getTimes()
self.times:setText(times)
local grids=self.listScroller:getChildScrollViewItemWidgets()
for i=1,count do
self:refreshTaskItem(grids[i-1],i,times)
end
end


function UISubAct_tianmoluWin:refreshTaskItem(item,index,times)
if item==nil then
item=self.listScroller:getChildScrollViewItemWidget(index-1)
end
times=times or 0
local Reward=self.taskaim[index][2]
local exReward=self.taskaim[index][3]
if item and Reward then

local needTimes=self.taskaim[index][1]
item:SetChildText(taskItemIndex.taskDesc,needTimes)


local isFinish=times>=needTimes



local taskGotState=self:isGotReward(index)
local taskGotExState=self:isGotExReward(index)







local gotFlag=false
if self.isBuyChaozhi then
gotFlag=taskGotExState
end


item:SetChildActive(0,isFinish and not gotFlag)








local baseRewards=Reward
item:SetChildLayoutGroupCreateItems(taskItemIndex.baseRewards,#baseRewards)
local grids=item:GetChildLayoutGroupGridList(taskItemIndex.baseRewards)
for i=1,#baseRewards do
local widget=grids[i-1]
local reward=baseRewards[i]
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


local isGot=taskGotState
local isGrayMask=isGot
prop[PropIndex(DataPropKey.eWidgetActive,7)]=isGrayMask

widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)



widget:SetChildGray(-1,not isFinish)
end


local upRewards=exReward
item:SetChildLayoutGroupCreateItems(taskItemIndex.upRewards,#upRewards)
local grids=item:GetChildLayoutGroupGridList(taskItemIndex.upRewards)
for i=1,#upRewards do
local widget=grids[i-1]
local reward=upRewards[i]
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


local isLock=not self.isBuyChaozhi
local isGot=taskGotExState
local isGrayMask=isGot
prop[PropIndex(DataPropKey.eWidgetActive,7)]=isGrayMask

widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)



widget:SetChildGray(-1,not isFinish)
end



if isFinish and not self.autoJumpIndex then

if not taskGotState then

self.autoJumpIndex=index-1
end
elseif not isFinish then

local nowIndex=index-1
if not self.firstUnfinishTaskIndex or nowIndex<self.firstUnfinishTaskIndex then

self.firstUnfinishTaskIndex=nowIndex
end
end
end

end

function UISubAct_tianmoluWin:getGotList()
local gotList={}
local count=#self.allReward
for i=1,count do
if not self:isGotReward(i)then
gotList[i]=true
end
end
return gotList
end




function UISubAct_tianmoluWin:onBuyBtn()
if not self.isBuyChaozhi then

local dayOut=self:getDayOut()
self:showWindow("ActSub_limitInvestorBuyWin",{dayOut=dayOut,act_id=self.actid,sub_act_id=self.subid})
end
end



function UISubAct_tianmoluWin:onClick()
if not self.isBuyChaozhi then

local dayOut=self:getTimes()
self:showWindow("ActSub_limitInvestorBuyWin",{dayOut=dayOut,act_id=self.actid,sub_act_id=self.subid})
end
end


function UISubAct_tianmoluWin:onClickGetRewardBtn(taskId,taskGotState)
if taskGotState and not self.isBuyChaozhi then


local dayOut=self:getTimes()
self:showWindow("ActSub_limitInvestorBuyWin",{dayOut=dayOut,act_id=self.actid,sub_act_id=self.subid})
return
end


activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actid,self.subType,self.subid,jsonHelper.encode({taskId}))
end

function UISubAct_tianmoluWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})

end



